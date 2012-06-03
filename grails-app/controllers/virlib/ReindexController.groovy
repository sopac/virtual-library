package virlib

import org.apache.tika.metadata.Metadata
import org.apache.tika.parser.pdf.PDFParser
import org.apache.tika.sax.BodyContentHandler
import org.xml.sax.ContentHandler

class ReindexController {

    def searchableService

    def index() {

        Document.list().each { d ->
            if (!d.file.toString().trim().equals("")) {
                println "Rebuilding Content Index - " + d.file.toString()
                InputStream input = new FileInputStream(new File(("/opt/virlib/" + d.file.trim())))
                ContentHandler textHandler = new BodyContentHandler(-1)
                PDFParser parser = new PDFParser();
                Metadata metadata = new Metadata();
                parser.parse(input, textHandler, metadata);
                String content = textHandler.toString()
                if (content.length() > 32670) content = content.substring(0, 32670)
                input.close()
                d.content = content
                d.save(flush: true, failOnError: true)
            }
        }

        // Reindex everything
        searchableService.reindex()
        render "Content Search Index Rebuilt..."

    }
}
