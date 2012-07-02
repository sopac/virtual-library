package virlib

import org.apache.lucene.analysis.standard.StandardAnalyzer
import org.apache.lucene.queryParser.QueryParser
import org.apache.lucene.search.*

class DualSearchController {


    def index() {


        String q = params.q
        q = "title:" + q + " OR author:" + q
        render "<h1>Search results for <u><b>" + params.q + "</b></u> in Division and Commission Collections</h1><div style='margin: 20px' align='left'>"

        //render "<!doctype html><html><head><meta name='layout' content='main'><title>Dual Search Result</title></head><body><div class='nav' role='navigation'><ul><li><a class='home' href='${createLink(uri: '/')}'><g:message code='default.home.label'/></a></li></ul></div>"


        String indexPathCommission = "/Users/SPC/.grails/projects/WebConsole/searchable-index/development/index/library"
        String indexPathDivision = "/Users/SPC/.grails/projects/VirLib/searchable-index/development/index/document"

        if (System.getProperty("os.name").toLowerCase().startsWith("linux")) {
            indexPathCommission = "/roo/.grails/projects/WebConsole/searchable-index/development/index/library"
            indexPathDivision = "/root/.grails/projects/VirLib/searchable-index/development/index/document"
        }

        IndexSearcher[] is = new IndexSearcher[2]
        is[0] = new IndexSearcher(indexPathCommission)
        is[1] = new IndexSearcher(indexPathDivision)

        MultiSearcher searcher = new MultiSearcher(is)
        QueryParser parser = new QueryParser("title", new StandardAnalyzer())
        Query query = parser.parse(q)
        TopDocs hits = searcher.search(query, 1000)

        for (ScoreDoc scoreDoc : hits.scoreDocs) {
            org.apache.lucene.document.Document doc = searcher.doc(scoreDoc.doc);
            String type = "c"
            String id = doc.get('$/Library/id')
            if (id == null) {
                type = "d"
                id = doc.get('$/Document/id')
            }

            String link = "http://ict.sopac.org/WebConsole/library/show/" + id
            if (type.equals("d")) link = "http://ict.sopac.org/library/document/show/" + id
            String reportId = doc.get("reportID")
            if (type.equals("d")) reportId = doc.get("reportId")

            render "<a target='_blank' href='${link}'> (" + reportId + ") " + doc.get("title") + "</a><br/>"
            render doc.get("author") + "<br/>"
            if (type.equals("c")) render "<i>Commission Library" + " - " + id + "</i><br/><br/>"
            if (type.equals("d")) render "<i>Division Library" + " - " + id + "</i><br/><br/>"


        }

        searcher.close();
        render "<hr/><h3>Total Results : <b>" + hits.totalHits + "</b></h3></div>"

        render layout: 'main'

    }
}
