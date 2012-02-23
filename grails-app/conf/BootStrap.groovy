import virlib.UserAccount

class BootStrap {

    def init = { servletContext ->
        if (virlib.Category.list().size == 0) {
            virlib.Category c = new virlib.Category()
            c.code = "PR"
            c.name = "Published Reports"
            c.description = "Documents created for the widest possible dissemination promoting SPC and its Members; and publishing work programme results"
            c.save(failOnError: true, flush: true)
            c = new virlib.Category()
            c.code = "GR"
            c.name = "Graphic Reports"
            c.description = "Documents prepared primarily with graphic elements. This category to include maps and charts; image backdrops; posters; billboards, banners, signage etc."
            c.save(failOnError: true, flush: true)
            c = new virlib.Category()
            c.code = "IR"
            c.name = "Internal Reports"
            c.description = "Documents created predominantly for internal purposes, which include many that will remain confidential to SPC and its Members"
            c.save(failOnError: true, flush: true)
        }
        if (UserAccount.list().size() == 0) {
            UserAccount u = new UserAccount()
            u.realName = "Sachindra Singh"
            u.userName = "sachindra@sopac.org"
            u.password = "123"
            u.designation = "Systems Developer"
            u.organisation = "Applied GeoScience and Technology Division, SOPAC"
            u.administrator = true
            u.save(failOnError: true, flush: true)
        }
    }
    def destroy = {
    }
}
