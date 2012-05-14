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
        reportId(unique: true)
        title()
        author()
        file(blank: true)
        size(blank: true)
        noOfPages(blank: true)
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
