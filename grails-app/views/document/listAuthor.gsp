<%@ page import="virlib.Document" %>
<%@ page import="virlib.Category" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="list-document" class="content scaffold-list" role="main">

    <h1>Listing ${author} Documents (${count})</h1>


    <table>
        <thead>
        <tr>

            <g:sortableColumn params="[code: code]" property="reportId" title="${message(code: 'document.reportId.label', default: 'Report Id')}"/>

            <g:sortableColumn params="[code: code]" property="reportId" title="${message(code: 'document.reportId.label', default: 'Published')}"/>

            <g:sortableColumn params="[code: code]" property="title" title="${message(code: 'document.title.label', default: 'Title')}"/>

            <g:sortableColumn params="[code: code]" property="author" title="${message(code: 'document.author.label', default: 'Author')}"/>

            <th></th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${documentInstanceList}" status="i" var="documentInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>${fieldValue(bean: documentInstance, field: "reportId")}</td>

                <td>${fieldValue(bean: documentInstance, field: "publicationMonth")},<br/>${documentInstance.publicationYear}
                </td>

                <td><g:link action="show" id="${documentInstance.id}">${fieldValue(bean: documentInstance, field: "title")}</g:link></td>

                <td>${fieldValue(bean: documentInstance, field: "author")}</td>

                <td>
                    <g:if test="${documentInstance.file.trim().equals("")}">
                        <p style="color: red">Restricted Document</p>
                    </g:if>
                    <g:elseif test="${!new java.io.File("/var/lib/tomcat6/webapps/ROOT/VirLibThumb/" + documentInstance.reportId + ".jpg").exists()}">
                        <p>Thumbnail Not Available</p>
                    </g:elseif>
                    <g:else>
                        <img border="3px" style="height: 100px; border: 1px; border-color: #000000" src="http://ict.sopac.org/VirLibThumb/${documentInstance.reportId}.jpg"/>
                    </g:else>
                </td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        ${count} reports
        %{--<g:paginate params="[code: code]" total="${documentInstanceTotal}"/>--}%
    </div>
</div>
</body>
</html>
