package virlib

class DownloadController {

    def index() {

        def file = new File("/opt/virlib/" + params.file)
        if (!file.exists()) {
            flash.message = "This document is restricted and can not be downloaded. Please contact SOPAC Publications and Library Section."
            redirect(controller: 'document', action: 'show', id: params.id)
        } else {
            try {
                byte[] content = file.readBytes()
                OutputStream out = response.getOutputStream();
                // Set headers
                //response.setContentType(bulletin.contentType)
                response.setContentLength(content.size())
                response.setHeader("Content-disposition", "attachment; filename=${params.file}")
                /* By default, Tomcat will set headers on any SSL content to deny
         * caching. This will cause downloads to Internet Explorer to fail. So
         * we override Tomcat's default behavior here. */
                response.setHeader("Pragma", "")
                response.setHeader("Cache-Control", "private")
                Calendar cal = Calendar.getInstance()
                cal.add(Calendar.MINUTE, 5)
                response.setDateHeader("Expires", cal.getTimeInMillis())
                // Write the file content
                out.write(content)
                response.outputStream.flush()
                out.close()
            } catch (Exception ex) {
                flash.message = "This document is restricted and can not be downloaded. Please contact SOPAC Publications and Library Section."
                redirect(controller: 'document', action: 'show', id: params.id)
            }
        }

    }
}
