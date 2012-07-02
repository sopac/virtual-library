package virlib

import javax.servlet.http.Cookie

class WelcomeController {

    def index() { }

    def skip() {
        Cookie cookie = new Cookie("skip", "skip")
        cookie.setMaxAge(100000000)
        cookie.setValue("skip_skip")
        cookie.setPath("/")
        response.addCookie(cookie)
        println("cookie set")



        redirect(controller: "welcome", action: "index")
    }

    def destroy() {
        Cookie cookie = new Cookie("skip", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie)
        redirect(uri: "/")
    }


    def list() {
        request.cookies.find { render it.name + " - " + it.value + "<br/>" }
        render "<hr/>"
        render request.cookies.length
    }


}
