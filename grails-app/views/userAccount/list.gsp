<%@ page import="virlib.UserAccount" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'userAccount.label', default: 'UserAccount')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-userAccount" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="list-userAccount" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="realName" title="${message(code: 'userAccount.realName.label', default: 'Real Name')}"/>

            <g:sortableColumn property="userName" title="${message(code: 'userAccount.userName.label', default: 'User Name')}"/>

            <g:sortableColumn property="designation" title="${message(code: 'userAccount.designation.label', default: 'Designation')}"/>

            <g:sortableColumn property="organisation" title="${message(code: 'userAccount.organisation.label', default: 'Organisation')}"/>

            <g:sortableColumn property="administrator" title="${message(code: 'userAccount.administrator.label', default: 'Administrator')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${userAccountInstanceList}" status="i" var="userAccountInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show" id="${userAccountInstance.id}">${fieldValue(bean: userAccountInstance, field: "realName")}</g:link></td>

                <td>${fieldValue(bean: userAccountInstance, field: "userName")}</td>

                <td>${fieldValue(bean: userAccountInstance, field: "designation")}</td>

                <td>${fieldValue(bean: userAccountInstance, field: "organisation")}</td>

                <td><g:formatBoolean boolean="${userAccountInstance.administrator}"/></td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${userAccountInstanceTotal}"/>
    </div>
</div>
</body>
</html>
