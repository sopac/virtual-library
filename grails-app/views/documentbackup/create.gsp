<%@ page import="virlib.Document" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
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
    <h1>Upload Document</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <br/>

    <div align="center">
        <g:uploadForm action="upload">
            <input type="file" name="docfile"/>
            <input type="submit"/>
        </g:uploadForm>

        <i>or</i>
        <br/>
        <g:uploadForm action="restricted">
            <input value="Create Restricted Document" type="submit"/>
        </g:uploadForm>
        <br/>
        <i>ensure that the pdf or word file has metadata pre-filled in</i>
        <br/>
    </div>
</div>
</body>
</html>
