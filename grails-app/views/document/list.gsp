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
    <g:if test="${code} == null">
        <h1>Listing Reports (${count})</h1>
    </g:if>
    <g:else>
        <h1>Listing ${Category.findAllByCode(code)[0].name}  (${count})</h1>
    </g:else>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

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
                    <g:elseif test="${!new java.io.File(application.getRealPath("images/thumbnail") + "/" + documentInstance.reportId + ".jpg").exists()}">
                        <p>Thumbnail Not Available</p>
                    </g:elseif>
                    <g:else>
                        <g:img border="3px" style="height: 100px; border: 1px; border-color: #000000" dir="images/thumbnail" file="${documentInstance.reportId}.jpg"/>
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
