<%@ page import="virlib.Blurb" %>



<div class="fieldcontain ${hasErrors(bean: blurbInstance, field: 'welcomeText', 'error')} ">
	<label for="welcomeText">
		<g:message code="blurb.welcomeText.label" default="Welcome Text" />
		
	</label>
	<g:textArea name="welcomeText" cols="40" rows="5" maxlength="1250" value="${blurbInstance?.welcomeText}"/>
</div>

