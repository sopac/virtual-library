<%@ page import="virlib.Document" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>


    <g:javascript library="jquery"/>
    <jqui:resources/>


    <style type="text/css" media="screen">
    #status {
        background-color: #eee;
        border: .2em solid #fff;
        margin: 2em 2em 1em;
        padding: 1em;
        width: 12em;
        float: left;
        -moz-box-shadow: 0px 0px 1.25em #ccc;
        -webkit-box-shadow: 0px 0px 1.25em #ccc;
        box-shadow: 0px 0px 1.25em #ccc;
        -moz-border-radius: 0.6em;
        -webkit-border-radius: 0.6em;
        border-radius: 0.6em;
    }

    .ie6 #status {
        display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
    }

    #status ul {
        font-size: 0.9em;
        list-style-type: none;
        margin-bottom: 0.6em;
        padding: 0;
    }

    #status li {
        line-height: 1.3;
    }

    #status h1 {
        text-transform: uppercase;
        font-size: 1.1em;
        margin: 0 0 0.3em;
    }

    #page-body {
        margin: 2em 1em 1.25em 18em;
    }

    h2 {
        margin-top: 1em;
        margin-bottom: 0.3em;
        font-size: 1em;
    }

    p {
        line-height: 1.5;
        margin: 0.25em 0;
    }

    #controller-list ul {
        list-style-position: inside;
    }

    #controller-list li {
        line-height: 1.3;
        list-style-position: inside;
        margin: 0.25em 0;
    }

    @media screen and (max-width: 480px) {
        #status {
            display: none;
        }

        #page-body {
            margin: 0 1em 1em;
        }

        #page-body h1 {
            margin-top: 0;
        }
    }

    #feedback {
        font-size: 1.4em;
    }

    #selectable .ui-selecting {
        background: #FECA40;
    }

    #selectable .ui-selected {
        background: #F39814;
        color: white;
    }

    #selectable {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }

    #selectable li {
        margin: 3px;
        padding: 4px;
        float: left;
        width: 190px;
        height: 220px;
        /*font-size: 4em;*/
        text-align: center;
    }

    </style>

    <script>
        $(function () {
            $("#selectable").selectable();
        });
    </script>
</head>

<body>
<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>

<div id="status" role="complementary">
    <h1>SOPAC Virtual Library</h1>
    <ul>
        <p align="justify">
            Welcome to the SOPAC Division's <b>Virtual Library</b>,
        maintained by Publication and Library Section with the goal of publishing and providing access to corporate, work programme and promotional reports and publications.
        %{--The service also holds a special geoscientific library for the Pacific Island Countries and Territories and staff containing current collection of reports, charts, maps, seismic sections, research cruise tracks, cores and other data records from geoscientific surveys. --}%
        As such it is the most frequently used entry point for enquiries regarding access to products and services, and is greatly facilitated through a user-friendly web portal.
        To access SOPAC Commission's legacy reports, please browse <a href="http://www.sopac.org/index.php/virtual-library">SOPAC Commission Closed Collection</a>. For additional queries and requests email <a href="mailto:datarequest.sopac.org">datarequest@sopac.org</a>
        </p>
        <br/>
        <g:img width="162px" dir="images" file="foam.png"/>
    </ul>

</div>

<div id="page-body" align="left" role="main">
    <h1>Browse Collections</h1>


    <div align="left">
        <ol id="selectable">
            <g:each in="${virlib.Category.list()}" var="c">
                <a style="text-decoration: none" href="${createLink(controller: 'document', action: 'list', params: [code: c.code])}">
                    <li class="ui-state-default">
                        <br/>
                        <img height="60px" src="${resource(dir: 'images', file: c.code + '.png')}"/>
                        <br/>
                        ${c.name}
                        <br/>

                        <div style="font: small;color: #a9a9a9; font-weight: 100;">
                            <br/>
                            ${c.description}
                        </div>
                    </li>
                </a>
            </g:each>
        </ol>
    </div>


    <div width="90%" align="left" style="margin-left: 50px; margin-top: 250px">
        <h1 style="margin-left: -50px; margin-bottom: 15px">Search Documents</h1>
        <g:form controller="searchable">
            <g:textField style="width: 480px" name="q" class="ui-state-default ui-corner-all"/>
            <g:submitButton name="Go" class="ui-state-default ui-corner-all"/>
        </g:form>
    </div>


    <table id="sdsds" align="left" style="width: 90%;border-top: 0px;align: left; margin-left: -15px">
        <tr>
            <td style="width: 80%"><h1>Recent Documents</h1></td>
            <td><h1>Manage</h1></td>

        </tr>
        <tr style="background-color: #ffffff;">
            <td>
                <g:each in="${Document.list(max: 9, sort: 'created', order: 'desc')}" var="d" status="i">
                    ${i + 1}.
                    <span align="right" style="text-align: right; margin-left: 20px">
                        <a style="color: blue;  text-decoration: none;" href="${createLink(controller: 'document', action: 'show', id: d.id)}">(${d.reportId}) ${d.title.substring(0, 58)}...</a>
                        <br/>
                    </span>

                </g:each>
            </td>
            <td>
                <br/>
                <a style="color: gray; text-decoration: none" href="${createLink(controller: 'document')}">Documents</a><br/><br/>
                <a style="color: gray; text-decoration: none" href="${createLink(controller: 'category')}">Categories</a><br/><br/>
                <a style="color: gray; text-decoration: none" href="${createLink(controller: 'userAccount')}">Users</a><br/><br/>
                <a style="color: gray; text-decoration: none" href="${createLink(controller: 'login')}">Usage Reports</a><br/><br/>
                %{--<i>Not Logged In</i>--}%
            </td>
        </tr>
    </table>





    <!--
    <div id="controller-list" role="navigation">
        <h2>Available Controllers:</h2>
        <ul>
            <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName }}">
        <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
    </g:each>
        </ul>
    </div>
    -->
</div>
</body>
</html>
