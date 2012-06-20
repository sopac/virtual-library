import virlib.Document

import java.text.SimpleDateFormat

/**
 * Created by IntelliJ IDEA.
 * User: sachin
 * Date: 2/22/12
 * Time: 1:29 PM
 * To change this template use File | Settings | File Templates.
 */
class Global {

    static def getDocumentsSortedByDate() {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd")
        def list = []
        Document.list().each {
            list.add(it.created)
        }
        ArrayList<Date> datelist = new ArrayList<Date>()
        list.each { str ->
            try {
                Date d1 = df.parse(str)
                datelist.add(d1)
            } catch (Exception ex) {
                ex.printStackTrace()
            }
        }
        datelist = datelist.reverse()
        def res = []
        datelist.each {
            res.addAll(Document.findByCreated(df.format(it)))
            println it
        }

        return res.subList(0, 9)
    }




}
