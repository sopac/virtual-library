package virlib

class Document {

    String reportId
    Integer number
    String title
    String author
    String file
    String size
    String noOfPages
    String created = ""
    String content = "" // hidden
    String publicationMonth = ""
    Integer publicationYear = 2012

    static belongsTo = [category: virlib.Category]

    static constraints = {
        category()
        reportId()
        title()
        author()
        file()
        size()
        noOfPages()
        created(nullable: true, blank: true)
        content(nullable: true, maxSize: 32670)
        number(nullable: true)
        publicationMonth(inList: ['', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'])
        publicationYear(nullable: true, blank: true)

    }

    static searchable = {
        mapping {
            spellCheck "include"
        }
    }

    String toString() {
        "(" + reportId + ") " + title
    }
}
