package virlib

import org.apache.tika.metadata.Metadata
import org.apache.tika.parser.pdf.PDFParser
import org.apache.tika.sax.BodyContentHandler
import org.xml.sax.ContentHandler

class InitController {

    def index() {
        render "<a href='${createLink(action: "reload")}'>Reload all documents and metadata<a/><br/>"
        render "<a href='${createLink(action: "regenerate")}'>Regenerate all thumbnails<a/><br/>"
        render "<a href='${createLink(action: "import_restricted")}'>Import restricted metadata from txt<a/><br/>"
    }

    def import_restricted() {
        Document.executeUpdate("Delete from Document d where d.file=''");
        String reportId = ""
        String number = ""
        String category = ""
        String title = ""
        String author = ""
        String publicationMonth = ""
        String publicationYear = ""
        new File("/opt/virlib/restricted.txt").eachLine { l ->

            if (l.startsWith("PR")) {
                reportId = l
                number = reportId.substring(2, reportId.length()).trim()
                for (char c : l.getChars()) if (c.isLetter()) number = number.replace(c, (char) ' ').trim()
                category = l.substring(0, 2)
            }

            if (l.startsWith("GR")) {
                reportId = l
                number = reportId.substring(2, reportId.length()).trim()
                for (char c : l.getChars()) if (c.isLetter()) number = number.replace(c, (char) ' ').trim()
                category = l.substring(0, 2)
            }

            if (l.startsWith("IR")) {
                reportId = l
                number = reportId.substring(2, reportId.length()).trim()
                for (char c : l.getChars()) if (c.isLetter()) number = number.replace(c, (char) ' ').trim()
                category = l.substring(0, 2)
            }
            //println reportId

            if (l.trim().endsWith("2011") || l.trim().endsWith("2012")) {
                String[] tmp = l.trim().split(",");
                publicationMonth = tmp[0].trim()
                publicationYear = tmp[1].trim()
            }

            if (l.startsWith("-")) {
                author = l.substring(1, l.length())
            }

            if (!l.trim().equals("")) {
                if (!l.substring(l.length() - 1, l.length()).isNumber() && !l.startsWith("-")) {
                    title = l
                }
            }

            if (l.trim().equals("")) {
                println "Importing " + reportId
                Document.executeUpdate("Delete Document d where d.reportId='" + reportId + "'")
                Document d = new Document()
                d.reportId = reportId
                d.number = Integer.valueOf(number.trim())
                d.title = title
                d.author = author
                d.publicationMonth = publicationMonth
                d.publicationYear = Integer.valueOf(publicationYear.trim())
                d.created = publicationYear + "-" + publicationMonth
                d.content = ""
                d.size = ""
                d.noOfPages = ""
                d.file = ""
                def list = virlib.Category.findAllByCode(category)
                if (list.size() != 0) d.category = list.get(0)
                d.save(flush: true, failOnError: false)
            }

            //if (l.startsWith("PR"))

            render "<h3>Imported.</h3>"
        }
    }

    def regenerate() {
        String path = "/opt/virlib/"
        String thumbnailPath = servletContext.getRealPath("/images/thumbnail/") + "/"
        render "Regenerating Thumbnails...."
        for (Document d : Document.list()) {
            org.sopac.virlib.ThumbnailGenerator.generateThumbnailPDF(path + d.file, thumbnailPath, d.reportId + ".jpg")
        }
        render "Finished."
    }

    def reload() {

        //use apache tika to extract metadata and initialize database
        Document.executeUpdate("Delete from Document d");

        String path = "/opt/virlib/"
        new File(path).eachFile {file ->
            String filename = file.getName()
            if (filename.toLowerCase().endsWith(".pdf") && !filename.toLowerCase().endsWith("r.pdf")) {
                render filename + "<br/>"
                //extract metadata
                def localFile = file
                InputStream input = new FileInputStream(localFile);
                ContentHandler textHandler = new BodyContentHandler(-1);

                PDFParser parser = new PDFParser();
                parser.parse(input, textHandler, metadata);
                input.close();

                //update metadata in pdf (it)
                println metadata.toString()
                String title = metadata.get(Metadata.TITLE) + " "
                if (title.length() >= 255) title = title.substring(0, 254)

                String author = metadata.get(Metadata.AUTHOR) + " "
                String created = metadata.get(Metadata.CREATION_DATE)
                if (created != null)
                    created = created.substring(0, created.indexOf("T"))
                String size = String.valueOf(localFile.length() / 1024)
                size = size.substring(0, size.indexOf(".")) + " kB"
                String pages = ""

                pages = metadata.get("xmpTPg:NPages")

                String content = textHandler.toString()
                if (content.length() > 32670) content = content.substring(0, 32670)

                String reportId = filename.toUpperCase().substring(0, filename.indexOf("."))
                if (!reportId.endsWith("0")) {
                    reportId = reportId.replaceAll("0", "").trim()
                } else {
                    reportId = reportId.replaceAll("00", "").trim()
                    reportId = reportId.replaceAll("000", "").trim()
                    reportId = reportId.replaceAll("0000", "").trim()
                }
                if (author != null && title != null) {
                    Document d = new Document()
                    d.reportId = reportId
                    String tmp = d.reportId.substring(2, d.reportId.length()).trim()
                    for (char c : tmp.getChars()) {
                        if (c.isLetter()) tmp = tmp.replace(c, (char) ' ').trim()
                    }
                    d.number = Integer.valueOf(tmp)
                    d.title = title
                    d.author = author
                    d.noOfPages = pages
                    d.size = size
                    d.created = created
                    d.content = content
                    d.file = filename

                    d.publicationYear = Integer.valueOf(d.created.substring(0, d.created.indexOf("-")).trim())
                    def months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
                    String m = d.created.substring(d.created.indexOf("-") + 1, d.created.lastIndexOf("-"))
                    //println m
                    d.publicationMonth = months[Integer.valueOf(m) - 1]

                    //get category
                    String code = filename.toUpperCase().substring(0, 2)
                    def list = virlib.Category.findAllByCode(code)
                    if (list.size() != 0) d.category = list.get(0)

                    d.save(failOnError: true, flush: true)
                }

                //generate thumbnail
                String thumbnailPath = servletContext.getRealPath("/images/thumbnail/") + "/"
                //render "<h1>" + thumbnailPath + "</h1>"

                org.sopac.virlib.ThumbnailGenerator.generateThumbnailPDF(path + filename, thumbnailPath, reportId + ".jpg")

                render filename + " processed.<br/>"

            }
        }

        render "Finished!"

    }
}
