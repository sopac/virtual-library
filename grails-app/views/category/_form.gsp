<%@ page import="virlib.Category" %>



<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'code', 'error')} ">
	<label for="code">
		<g:message code="category.code.label" default="Code" />
		
	</label>
	<g:textField name="code" value="${categoryInstance?.code}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="category.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${categoryInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="category.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="750" value="${categoryInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'documents', 'error')} ">
	<label for="documents">
		<g:message code="category.documents.label" default="Documents" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${categoryInstance?.documents?}" var="d">
    <li><g:link controller="document" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="document" action="create" params="['category.id': categoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'document.label', default: 'Document')])}</g:link>
</li>
</ul>

</div>

