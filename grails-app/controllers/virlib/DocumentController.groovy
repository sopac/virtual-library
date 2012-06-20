package virlib

import org.apache.tika.metadata.Metadata
import org.apache.tika.parser.pdf.PDFParser
import org.apache.tika.sax.BodyContentHandler
import org.sopac.virlib.ThumbnailGenerator
import org.springframework.dao.DataIntegrityViolationException
import org.xml.sax.ContentHandler

import java.text.SimpleDateFormat

class DocumentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def changeThumbnail() {
        [reportId: params.reportId]
    }

    def uploadThumbnail() {
        def f = request.getFile('thumbfile')
        if (f.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'create')
            return
        }
        //String path = servletContext.getRealPath("images/thumbnail/") + "/"
        String path = "/var/lib/tomcat6/webapps/ROOT/VirLibThumb/";
        File file = new File(path + params.reportId.trim() + ".jpg");
        if (file.exists()) file.delete();
        f.transferTo(file)

        //resize
        ThumbnailGenerator.resize(file.getAbsolutePath().toString());

        flash.message = "Thumbnail changed..."
        Document d = Document.findByReportId(params.reportId.trim())
        redirect(action: 'show', id: d.id)

    }

    def upload() {
        def f = request.getFile('docfile')
        if (f.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'create')
            return
        }
        String path = "/opt/virlib/"
        File file = new File(path + f.getOriginalFilename())
        f.transferTo(file)

        //process

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
                Document.executeUpdate("Delete Document d where d.reportId='" + reportId + "'")
                Document d = new Document()
                d.reportId = reportId
                d.title = title
                d.author = author
                d.noOfPages = pages
                d.size = size
                d.created = created
                d.content = content
                d.file = filename
                //get category
                String code = filename.toUpperCase().substring(0, 2)
                def list = virlib.Category.findAllByCode(code)
                if (list.size() != 0) d.category = list.get(0)
                d.save(failOnError: true, flush: true)
            }
            //generate thumbnail
            String thumbnailPath = "/var/lib/tomcat6/webapps/ROOT/VirLibThumb/"; //servletContext.getRealPath("/images/thumbnail/") + "/"
            //render "<h1>" + thumbnailPath + "</h1>"
            org.sopac.virlib.ThumbnailGenerator.generateThumbnailPDF(path + filename, thumbnailPath, reportId + ".jpg")

            //
            //response.sendError(200, 'Done')
            flash.message = "Document Uploaded..."

            redirect(action: "edit", id: Document.findAllByReportId(reportId)[0].id)
        }
    }

    def restricted() {
        Document d = new Document()
        d.reportId = " "
        d.title = " "
        d.author = " "
        d.file = " "
        d.size = " "
        d.noOfPages = " "
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd")
        d.created = df.format(new Date())
        d.content = " " // hidden
        d.category = Category.list()[0]
        d.save(flush: true, failOnError: true)
        redirect(action: "edit", id: d.id)
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def listAuthor() {
        params.sort = "number"
        def docs = Document.findAllByAuthor(params.author, params)
        int count = docs.size()
        [documentInstanceList: docs, documentInstanceTotal: count, count: count, author: params.author]
    }

    def list() {
        if (params.code == null || params.code.trim().equals("")) {
            //params.max = Math.min(params.max ? params.int('max') : 10, 100)
            params.sort = "number"
            String count = Document.list().size()
            [documentInstanceList: Document.list(params), documentInstanceTotal: Document.count(), count: count]
        } else {
            String code = params.code
            //params.max = Math.min(params.max ? params.int('max') : 10, 100)
            params.sort = "number"
            String count = Document.findAllByCategory(Category.findAllByCode(code)[0], params).size()
            def documentInstanceList = Document.findAllByCategory(Category.findAllByCode(code)[0], params)

            [documentInstanceList: documentInstanceList, documentInstanceTotal: documentInstanceList.size(), code: code, count: count]
        }
    }

    def create() {
        [documentInstance: new Document(params)]
    }

    def save() {
        def documentInstance = new Document(params)
        String tmp = params.reportId.substring(2, params.reportId.length()).trim()
        for (char c : tmp.getChars()) {
            if (c.isLetter()) tmp = tmp.replace(c, (char) ' ').trim()
        }
        documentInstance.number = Integer.valueOf(tmp)
        if (!documentInstance.save(flush: true)) {
            render(view: "create", model: [documentInstance: documentInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'document.label', default: 'Document'), documentInstance.id])
        redirect(action: "show", id: documentInstance.id)
    }

    def show() {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }

        [documentInstance: documentInstance]
    }

    def edit() {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }

        [documentInstance: documentInstance]
    }

    def update() {
        def documentInstance = Document.get(params.id)
        String tmp = params.reportId.substring(2, params.reportId.length()).trim()
        for (char c : tmp.getChars()) {
            if (c.isLetter()) tmp = tmp.replace(c, (char) ' ').trim()
        }
        documentInstance.number = Integer.valueOf(tmp)
        if (!documentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (documentInstance.version > version) {
                documentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'document.label', default: 'Document')] as Object[],
                        "Another user has updated this Document while you were editing")
                render(view: "edit", model: [documentInstance: documentInstance])
                return
            }
        }

        documentInstance.properties = params

        if (!documentInstance.save(flush: true)) {
            render(view: "edit", model: [documentInstance: documentInstance])
            return
        }

        //update thumbnail
        /*
        String path = "/opt/virlib/"
        String filename = documentInstance.file
        String reportId = documentInstance.id.toString()
        String thumbnailPath = "/var/lib/tomcat6/webapps/ROOT/VirLibThumb/"; //servletContext.getRealPath("/images/thumbnail/") + "/"
        org.sopac.virlib.ThumbnailGenerator.generateThumbnailPDF(path + filename, thumbnailPath, reportId + ".jpg")
        */

        flash.message = message(code: 'default.updated.message', args: [message(code: 'document.label', default: 'Document'), documentInstance.id])
        redirect(action: "show", id: documentInstance.id)
    }

    def delete() {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }

        try {
            documentInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
