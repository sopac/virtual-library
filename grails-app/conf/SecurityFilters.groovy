class SecurityFilters {

    def filters = {
        edit(controller: '*', action: 'edit') {
            before = {
                if (!session.user || session.user == null) {
                    redirect(controller: 'login')
                    return false
                }
            }
        }
        save(controller: '*', action: 'save') {
            before = {
                if (!session.user || session.user == null) {
                    redirect(controller: 'login')
                    return false
                }
            }
        }
        delete(controller: '*', action: 'delete') {
            before = {
                if (!session.user || session.user == null) {
                    redirect(controller: 'login')
                    return false
                }
            }
        }
        init(controller: 'init', action: '*') {
            before = {
                if (!session.user || session.user == null) {
                    redirect(controller: 'login')
                    return false
                }
            }
        }
        create(controller: '*', action: 'create') {
            before = {
                if (!session.user || session.user == null) {
                    redirect(controller: 'login')
                    return false
                }
            }
        }
        useraccount(controller: 'userAccount', action: '*') {
            before = {
                if (!session.user || session.user == null) {
                    redirect(controller: 'login')
                    return false
                }
            }
        }

    }


}
