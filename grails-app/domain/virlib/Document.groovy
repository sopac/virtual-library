package virlib

class Document {

    String reportId
    String title
    String author
    String file
    String size
    String noOfPages
    String created = ""
    String content = "" // hidden

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
