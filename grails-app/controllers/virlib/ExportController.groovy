package virlib

import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Workbook

class ExportController {

    def index() {
        //export documents as excel to /opt/virlib
        File excel = new File("/opt/virlib/metadata.xls")
        if (excel.exists()) excel.delete()

        Workbook wb = new HSSFWorkbook();
        FileOutputStream fileOut = new FileOutputStream(excel.getAbsolutePath())
        HSSFSheet s = wb.createSheet("SOPAC VirLib Metadata")
        Cell cell = null;
        int rowcount = 0
        Document.listOrderByReportId().each { d ->
            Row row = s.createRow((short) rowcount);
            rowcount++
            cell = row.createCell(0)
            cell.setCellValue(d.reportId)
            cell = row.createCell(1)
            cell.setCellValue(d.category.toString())
            cell = row.createCell(2)
            cell.setCellValue(d.title)
            cell = row.createCell(3)
            cell.setCellValue(d.author)
            cell = row.createCell(4)
            cell.setCellValue(d.file)
            cell = row.createCell(5)
            cell.setCellValue(d.noOfPages.toString())
            cell = row.createCell(6)
            cell.setCellValue(d.size)
            cell = row.createCell(7)
            cell.setCellValue(d.title)
            cell = row.createCell(8)
            cell.setCellValue(d.created.toString())
            cell = row.createCell(9)
            cell.setCellValue(d.publicationMonth.toString())
            cell = row.createCell(10)
            cell.setCellValue(d.publicationYear.toString())
        }

        wb.write(fileOut)
        fileOut.close()
        println "Excel generated..."

        //zip everything under /opt/virlib in zip
        File backup = new File("/opt/virlib/backup.zip")
        if (backup.exists()) backup.delete()

        def ant = new AntBuilder()
        ant.zip(
                destfile: backup.getAbsolutePath(),
                basedir: "/opt/virlib/"
        )
        println "Zip created..."

        //output zip for download
        try {
            byte[] content = backup.readBytes()
            OutputStream out = response.getOutputStream();
            // Set headers
            //response.setContentType(bulletin.contentType)
            response.setContentLength(content.size())
            response.setHeader("Content-disposition", "attachment; filename=${backup.getName()}")
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
            ex.printStackTrace()
        }

    }
}
