<%@ page import="virlib.Document" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}"/>
    <title>Change Thumbnail</title>
</head>

<body>
<a href="#create-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-document" class="content scaffold-create" role="main">
    <h1>Change Thumbnails for ${reportId}</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <br/>

    <div align="center">
        <g:uploadForm action="uploadThumbnail">
            <input type="file" accept="image/*" name="thumbfile"/>
            <g:hiddenField name="reportId" value="${reportId}"/>
            <input type="submit"/>
        </g:uploadForm>
        <i>only jpg files are accepted</i>

    </div>
</div>
</body>
</html>
