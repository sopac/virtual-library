package virlib



import org.junit.*
import grails.test.mixin.*

@TestFor(BlurbController)
@Mock(Blurb)
class BlurbControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/blurb/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.blurbInstanceList.size() == 0
        assert model.blurbInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.blurbInstance != null
    }

    void testSave() {
        controller.save()

        assert model.blurbInstance != null
        assert view == '/blurb/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/blurb/show/1'
        assert controller.flash.message != null
        assert Blurb.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/blurb/list'


        populateValidParams(params)
        def blurb = new Blurb(params)

        assert blurb.save() != null

        params.id = blurb.id

        def model = controller.show()

        assert model.blurbInstance == blurb
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/blurb/list'


        populateValidParams(params)
        def blurb = new Blurb(params)

        assert blurb.save() != null

        params.id = blurb.id

        def model = controller.edit()

        assert model.blurbInstance == blurb
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/blurb/list'

        response.reset()


        populateValidParams(params)
        def blurb = new Blurb(params)

        assert blurb.save() != null

        // test invalid parameters in update
        params.id = blurb.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/blurb/edit"
        assert model.blurbInstance != null

        blurb.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/blurb/show/$blurb.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        blurb.clearErrors()

        populateValidParams(params)
        params.id = blurb.id
        params.version = -1
        controller.update()

        assert view == "/blurb/edit"
        assert model.blurbInstance != null
        assert model.blurbInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/blurb/list'

        response.reset()

        populateValidParams(params)
        def blurb = new Blurb(params)

        assert blurb.save() != null
        assert Blurb.count() == 1

        params.id = blurb.id

        controller.delete()

        assert Blurb.count() == 0
        assert Blurb.get(blurb.id) == null
        assert response.redirectedUrl == '/blurb/list'
    }
}
