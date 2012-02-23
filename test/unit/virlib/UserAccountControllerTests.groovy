package virlib



import org.junit.*
import grails.test.mixin.*

@TestFor(UserAccountController)
@Mock(UserAccount)
class UserAccountControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/userAccount/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.userAccountInstanceList.size() == 0
        assert model.userAccountInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.userAccountInstance != null
    }

    void testSave() {
        controller.save()

        assert model.userAccountInstance != null
        assert view == '/userAccount/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/userAccount/show/1'
        assert controller.flash.message != null
        assert UserAccount.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/userAccount/list'


        populateValidParams(params)
        def userAccount = new UserAccount(params)

        assert userAccount.save() != null

        params.id = userAccount.id

        def model = controller.show()

        assert model.userAccountInstance == userAccount
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/userAccount/list'


        populateValidParams(params)
        def userAccount = new UserAccount(params)

        assert userAccount.save() != null

        params.id = userAccount.id

        def model = controller.edit()

        assert model.userAccountInstance == userAccount
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/userAccount/list'

        response.reset()


        populateValidParams(params)
        def userAccount = new UserAccount(params)

        assert userAccount.save() != null

        // test invalid parameters in update
        params.id = userAccount.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/userAccount/edit"
        assert model.userAccountInstance != null

        userAccount.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/userAccount/show/$userAccount.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        userAccount.clearErrors()

        populateValidParams(params)
        params.id = userAccount.id
        params.version = -1
        controller.update()

        assert view == "/userAccount/edit"
        assert model.userAccountInstance != null
        assert model.userAccountInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/userAccount/list'

        response.reset()

        populateValidParams(params)
        def userAccount = new UserAccount(params)

        assert userAccount.save() != null
        assert UserAccount.count() == 1

        params.id = userAccount.id

        controller.delete()

        assert UserAccount.count() == 0
        assert UserAccount.get(userAccount.id) == null
        assert response.redirectedUrl == '/userAccount/list'
    }
}
