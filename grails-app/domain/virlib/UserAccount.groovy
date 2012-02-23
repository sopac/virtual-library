package virlib

class UserAccount {

    String realName
    String userName
    String password
    String designation
    String organisation
    boolean administrator




    static constraints = {
        realName(blank: false)
        userName(email: true, unique: true, blank: false)
        password(password: true, blank: false)
        designation(nullable: true)
        organisation(nullable: true)
        administrator()

    }
}
