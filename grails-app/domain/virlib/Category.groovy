package virlib

class Category {

    static hasMany = [documents: Document]
    String code
    String name
    String description

    static constraints = {
        code()
        name()
        description(maxSize: 750)
    }

    String toString() {
        name + " (" + code + ")"
    }
}

