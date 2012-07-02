package virlib

import org.springframework.dao.DataIntegrityViolationException

class BlurbController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [blurbInstanceList: Blurb.list(params), blurbInstanceTotal: Blurb.count()]
    }

    def create() {
        [blurbInstance: new Blurb(params)]
    }

    def save() {
        def blurbInstance = new Blurb(params)
        if (!blurbInstance.save(flush: true)) {
            render(view: "create", model: [blurbInstance: blurbInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'blurb.label', default: 'Blurb'), blurbInstance.id])
        redirect(action: "show", id: blurbInstance.id)
    }

    def show() {
        def blurbInstance = Blurb.get(params.id)
        if (!blurbInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'blurb.label', default: 'Blurb'), params.id])
            redirect(action: "list")
            return
        }

        [blurbInstance: blurbInstance]
    }

    def edit() {
        def blurbInstance = Blurb.get(params.id)
        if (!blurbInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'blurb.label', default: 'Blurb'), params.id])
            redirect(action: "list")
            return
        }

        [blurbInstance: blurbInstance]
    }

    def update() {
        def blurbInstance = Blurb.get(params.id)
        if (!blurbInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'blurb.label', default: 'Blurb'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (blurbInstance.version > version) {
                blurbInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'blurb.label', default: 'Blurb')] as Object[],
                        "Another user has updated this Blurb while you were editing")
                render(view: "edit", model: [blurbInstance: blurbInstance])
                return
            }
        }

        blurbInstance.properties = params

        if (!blurbInstance.save(flush: true)) {
            render(view: "edit", model: [blurbInstance: blurbInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'blurb.label', default: 'Blurb'), blurbInstance.id])
        redirect(action: "show", id: blurbInstance.id)
    }

    def delete() {
        def blurbInstance = Blurb.get(params.id)
        if (!blurbInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'blurb.label', default: 'Blurb'), params.id])
            redirect(action: "list")
            return
        }

        try {
            blurbInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'blurb.label', default: 'Blurb'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'blurb.label', default: 'Blurb'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
