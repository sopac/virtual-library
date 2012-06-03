package virlib

import org.springframework.dao.DataIntegrityViolationException

class UserAccountController {

    def help() {

    }

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userAccountInstanceList: UserAccount.list(params), userAccountInstanceTotal: UserAccount.count()]
    }

    def create() {
        [userAccountInstance: new UserAccount(params)]
    }

    def save() {
        def userAccountInstance = new UserAccount(params)
        if (!userAccountInstance.save(flush: true)) {
            render(view: "create", model: [userAccountInstance: userAccountInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccountInstance.id])
        redirect(action: "show", id: userAccountInstance.id)
    }

    def show() {
        def userAccountInstance = UserAccount.get(params.id)
        if (!userAccountInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), params.id])
            redirect(action: "list")
            return
        }

        [userAccountInstance: userAccountInstance]
    }

    def edit() {
        def userAccountInstance = UserAccount.get(params.id)
        if (!userAccountInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), params.id])
            redirect(action: "list")
            return
        }

        [userAccountInstance: userAccountInstance]
    }

    def update() {
        def userAccountInstance = UserAccount.get(params.id)
        if (!userAccountInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (userAccountInstance.version > version) {
                userAccountInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'userAccount.label', default: 'UserAccount')] as Object[],
                        "Another user has updated this UserAccount while you were editing")
                render(view: "edit", model: [userAccountInstance: userAccountInstance])
                return
            }
        }

        userAccountInstance.properties = params

        if (!userAccountInstance.save(flush: true)) {
            render(view: "edit", model: [userAccountInstance: userAccountInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccountInstance.id])
        redirect(action: "show", id: userAccountInstance.id)
    }

    def delete() {
        def userAccountInstance = UserAccount.get(params.id)
        if (!userAccountInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), params.id])
            redirect(action: "list")
            return
        }

        try {
            userAccountInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
