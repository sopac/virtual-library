package virlib

class LoginController {

    def index() { }

    def doLogin = {
        String username = params.username
        String password = params.password

        def user = UserAccount.findWhere(userName: username)
        if (user != null) {
            if (user.password.equals(password)) {
                session['user'] = user.realName
                session['admin'] = user.administrator
                flash.message = user.realName + ", " + user.designation + ", " + user.organisation + " - logged in ..."
                //log
                /*
                def l = new Log()
                l.name = session['user']
                l.type = "Logged In"
                l.project = "*"
                l.timeStamp = new Date()
                l.save()
                */
                redirect(controller: "welcome")
            } else {
                flash.message = "Invalid username and/or password, please try again"
                redirect(controller: 'login', action: 'index')
            }
        } else {
            flash.message = "Invalid username and/or password, please try again"
            redirect(controller: 'login', action: 'index')
        }

    }


    def logout = {
        String tmp = session['user']
        session['user'] = null
        session['organisation'] = null
        session['admin'] = false
        flash.message = tmp + " Logged Out..."
        redirect(controller: "welcome")
    }
}

