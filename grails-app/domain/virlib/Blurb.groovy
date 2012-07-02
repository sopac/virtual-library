package virlib

class Blurb {

    String welcomeText

    static constraints = {
        welcomeText(maxSize: 1250)
    }
}
