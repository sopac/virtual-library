package virlib

class FilterController {

    def index() { }

    def getMonthNo(String m) {
        String res = "01"
        if (m.equals("Jan")) res = "01";
        if (m.equals("Feb")) res = "02";
        if (m.equals("Mar")) res = "03";
        if (m.equals("Apr")) res = "04";
        if (m.equals("May")) res = "05";
        if (m.equals("Jun")) res = "06";
        if (m.equals("Jul")) res = "07";
        if (m.equals("Aug")) res = "08";
        if (m.equals("Sep")) res = "09";
        if (m.equals("Oct")) res = "10";
        if (m.equals("Nov")) res = "11";
        if (m.equals("Dec")) res = "12";
        //println m + " - " + res
        return res
    }

    def doFilter() {
        String year = params.year
        String month = getMonthNo(params.month)
        def list = []

        Document.listOrderByReportId().each {d ->
            println d.created + "   " + year + "-" + month
            if (d.created.startsWith(year + "-" + month)) {
                list << d
            }
        }
        [documentInstanceList: list, documentInstanceTotal: list.size(), count: list.size(), year: year, month: params.month]

    }
}
