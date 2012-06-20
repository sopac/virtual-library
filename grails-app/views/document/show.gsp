<%@ page import="virlib.Document" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-document" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list document">

        <li class="fieldcontain">
            <span class="property-value" aria-labelledby="category-label">
                <g:if test="${documentInstance.file.trim().equals("")}">
                    <p style="color: red">Restricted Document</p><br/>
                    <g:if test="${new java.io.File("/var/lib/tomcat6/webapps/ROOT/VirLibThumb/" + documentInstance.reportId + ".jpg").exists()}">
                        <img border="3px" style="height: 100px; border: 1px; border-color: #000000" src="http://ict.sopac.org/VirLibThumb/${documentInstance.reportId}.jpg"/>
                    </g:if>
                </g:if>
                <g:else>
                    <a href="${createLink(controller: 'download', params: [file: documentInstance.file, id: documentInstance.id])}">
                        <img border="3px" style="height: 100px; border: 1px; border-color: #000000" src="http://ict.sopac.org/VirLibThumb/${documentInstance.reportId}.jpg"/>
                    </a>
                </g:else>
            </span>
        </li>


        <g:if test="${documentInstance?.category}">
            <li class="fieldcontain">
                <span id="category-label" class="property-label"><g:message code="document.category.label" default="Category"/></span>

                <span class="property-value" aria-labelledby="category-label"><g:link controller="category" action="show" id="${documentInstance?.category?.id}">${documentInstance?.category?.encodeAsHTML()}</g:link></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.reportId}">
            <li class="fieldcontain">
                <span id="reportId-label" class="property-label"><g:message code="document.reportId.label" default="Report Id"/></span>

                <span class="property-value" aria-labelledby="reportId-label"><g:fieldValue bean="${documentInstance}" field="reportId"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.title}">
            <li class="fieldcontain">
                <span id="title-label" class="property-label"><g:message code="document.title.label" default="Title"/></span>

                <span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${documentInstance}" field="title"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.author}">
            <li class="fieldcontain">
                <span id="author-label" class="property-label"><g:message code="document.author.label" default="Author"/></span>

                <span class="property-value" aria-labelledby="author-label"><g:fieldValue bean="${documentInstance}" field="author"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.file}">
            <li class="fieldcontain">
                <span id="file-label" class="property-label"><g:message code="document.file.label" default="File"/></span>

                <span class="property-value" aria-labelledby="file-label"><g:fieldValue bean="${documentInstance}" field="file"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.size}">
            <li class="fieldcontain">
                <span id="size-label" class="property-label"><g:message code="document.size.label" default="Size"/></span>

                <span class="property-value" aria-labelledby="size-label"><g:fieldValue bean="${documentInstance}" field="size"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.noOfPages}">
            <li class="fieldcontain">
                <span id="noOfPages-label" class="property-label"><g:message code="document.noOfPages.label" default="No Of Pages"/></span>

                <span class="property-value" aria-labelledby="noOfPages-label"><g:fieldValue bean="${documentInstance}" field="noOfPages"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.created}">
            <li class="fieldcontain">
                <span id="created-label" class="property-label"><g:message code="document.created.label" default="Created"/></span>

                <span class="property-value" aria-labelledby="created-label"><g:fieldValue bean="${documentInstance}" field="created"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.publicationMonth}">
            <li class="fieldcontain">
                <span id="created-label" class="property-label"><g:message code="document.created.label" default="Published"/></span>

                <span class="property-value" aria-labelledby="created-label"><g:fieldValue bean="${documentInstance}" field="publicationMonth"/>, ${documentInstance.publicationYear.encodeAsHTML()}</span>

            </li>
        </g:if>

        <li class="fieldcontain">
            <span id="created-label" class="property-label">Download</span>
            <span class="property-value" aria-labelledby="created-label">
                <a href="${createLink(controller: 'download', params: [file: documentInstance.file, id: documentInstance.id])}">
                    <g:img dir="images" file="download.png"></g:img>
                </a>

            </span>
        </li>

        %{--
            <g:if test="${documentInstance?.content}">
                <li class="fieldcontain">
                              <span id="content-label" class="property-label"><g:message code="document.content.label" default="Content"/></span>

                                <span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${documentInstance}" field="content"/></span>

                        </li>
            </g:if>

        --}%
    </ol>



    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${documentInstance?.id}"/>
            <g:link class="edit" action="edit" id="${documentInstance?.id}"><g:message code="default.button.edit.label" default="Edit"/></g:link>

            <g:if test="${session.user != null}">
                <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                <g:hiddenField name="reportId" value="${documentInstance.reportId}"/>
                <g:actionSubmit class="edit" action="changeThumbnail" value="Change Thumbnail"/>
            </g:if>
        </fieldset>
    </g:form>
</div>
</body>
</html>
