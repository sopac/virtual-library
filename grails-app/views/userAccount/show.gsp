<%@ page import="virlib.UserAccount" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'userAccount.label', default: 'UserAccount')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-userAccount" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-userAccount" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list userAccount">

        <g:if test="${userAccountInstance?.realName}">
            <li class="fieldcontain">
                <span id="realName-label" class="property-label"><g:message code="userAccount.realName.label" default="Real Name"/></span>

                <span class="property-value" aria-labelledby="realName-label"><g:fieldValue bean="${userAccountInstance}" field="realName"/></span>

            </li>
        </g:if>

        <g:if test="${userAccountInstance?.userName}">
            <li class="fieldcontain">
                <span id="userName-label" class="property-label"><g:message code="userAccount.userName.label" default="User Name"/></span>

                <span class="property-value" aria-labelledby="userName-label"><g:fieldValue bean="${userAccountInstance}" field="userName"/></span>

            </li>
        </g:if>
    <!--
    <g:if test="${userAccountInstance?.password}">
        <li class="fieldcontain">
      <span id="password-label" class="property-label"><g:message code="userAccount.password.label" default="Password"/></span>

                <span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${userAccountInstance}" field="password"/></span>

            </li>
    </g:if>
    -->

        <g:if test="${userAccountInstance?.designation}">
            <li class="fieldcontain">
                <span id="designation-label" class="property-label"><g:message code="userAccount.designation.label" default="Designation"/></span>

                <span class="property-value" aria-labelledby="designation-label"><g:fieldValue bean="${userAccountInstance}" field="designation"/></span>

            </li>
        </g:if>

        <g:if test="${userAccountInstance?.organisation}">
            <li class="fieldcontain">
                <span id="organisation-label" class="property-label"><g:message code="userAccount.organisation.label" default="Organisation"/></span>

                <span class="property-value" aria-labelledby="organisation-label"><g:fieldValue bean="${userAccountInstance}" field="organisation"/></span>

            </li>
        </g:if>

        <g:if test="${userAccountInstance?.administrator}">
            <li class="fieldcontain">
                <span id="administrator-label" class="property-label"><g:message code="userAccount.administrator.label" default="Administrator"/></span>

                <span class="property-value" aria-labelledby="administrator-label"><g:formatBoolean boolean="${userAccountInstance?.administrator}"/></span>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${userAccountInstance?.id}"/>
            <g:link class="edit" action="edit" id="${userAccountInstance?.id}"><g:message code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
