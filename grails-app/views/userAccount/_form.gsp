<%@ page import="virlib.UserAccount" %>



<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'realName', 'error')} required">
	<label for="realName">
		<g:message code="userAccount.realName.label" default="Real Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="realName" required="" value="${userAccountInstance?.realName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'userName', 'error')} required">
	<label for="userName">
		<g:message code="userAccount.userName.label" default="User Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="userName" required="" value="${userAccountInstance?.userName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="userAccount.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="password" name="password" required="" value="${userAccountInstance?.password}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'designation', 'error')} ">
	<label for="designation">
		<g:message code="userAccount.designation.label" default="Designation" />
		
	</label>
	<g:textField name="designation" value="${userAccountInstance?.designation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'organisation', 'error')} ">
	<label for="organisation">
		<g:message code="userAccount.organisation.label" default="Organisation" />
		
	</label>
	<g:textField name="organisation" value="${userAccountInstance?.organisation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'administrator', 'error')} ">
	<label for="administrator">
		<g:message code="userAccount.administrator.label" default="Administrator" />
		
	</label>
	<g:checkBox name="administrator" value="${userAccountInstance?.administrator}" />
</div>

