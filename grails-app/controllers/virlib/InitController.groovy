package virlib

import org.apache.tika.metadata.Metadata
import org.apache.tika.parser.pdf.PDFParser
import org.apache.tika.sax.BodyContentHandler
import org.xml.sax.ContentHandler

class InitController {

    def index() {

        //use apache tika to extract metadata and initialize database
        Document.executeUpdate("Delete from Document d");

        String path = "/opt/virlib/"
        new File(path).eachFile {file ->
            String filename = file.getName()
            if (filename.toLowerCase().endsWith(".pdf")) {
                render filename + "<br/>"
                //extract metadata
                def localFile = file
                InputStream input = new FileInputStream(localFile);
                ContentHandler textHandler = new BodyContentHandler(-1);
                Metadata metadata = new Metadata();
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
                    d.number = Integer.valueOf(d.reportId.substring(2, d.reportId.length()).trim())
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
