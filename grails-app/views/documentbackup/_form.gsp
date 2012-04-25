<%@ page import="virlib.Document" %>



<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'category', 'error')} required">
    <label for="category">
        <g:message code="document.category.label" default="Category"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="category" name="category.id" from="${virlib.Category.list()}" optionKey="id" required="" value="${documentInstance?.category?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'reportId', 'error')} ">
    <label for="reportId">
        <g:message code="document.reportId.label" default="Report Id"/>

    </label>
    <g:textField name="reportId" value="${documentInstance?.reportId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'title', 'error')} ">
    <label for="title">
        <g:message code="document.title.label" default="Title"/>

    </label>
    <g:textField style="width: 640px" name="title" value="${documentInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'author', 'error')} ">
    <label for="author">
        <g:message code="document.author.label" default="Author"/>

    </label>
    <g:textField name="author" value="${documentInstance?.author}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'file', 'error')} ">
    <label for="file">
        <g:message code="document.file.label" default="File"/>

    </label>
    <g:textField name="file" value="${documentInstance?.file}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'size', 'error')} ">
    <label for="size">
        <g:message code="document.size.label" default="Size"/>

    </label>
    <g:textField name="size" value="${documentInstance?.size}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'noOfPages', 'error')} ">
    <label for="noOfPages">
        <g:message code="document.noOfPages.label" default="No Of Pages"/>

    </label>
    <g:textField name="noOfPages" value="${documentInstance?.noOfPages}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'created', 'error')} ">
    <label for="created">
        <g:message code="document.created.label" default="Created"/>

    </label>
    <g:textField name="created" value="${documentInstance?.created}"/>  <i>yyyy-mm-dd, eg: 2012-03-28</i>
</div>
%{--

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="document.content.label" default="Content" />
		
	</label>
	<g:textArea name="content" cols="40" rows="5" maxlength="32670" value="${documentInstance?.content}"/>
</div>

--}%
