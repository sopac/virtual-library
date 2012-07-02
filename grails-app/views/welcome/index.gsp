<%@ page import="virlib.Document" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>

    <resource:tabView/>



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
        float: none;
        width: 190px;
        height: 220px;
        /*font-size: 4em;*/
        text-align: center;
    }
    </style>



    <script type="text/javascript">

    </script>

</head>


<body>

<div style="visibility: hidden;">
    ${virlib.Document.executeUpdate("Delete from Document d where d.title=' '")}
</div>
<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>




<div id="status" role="complementary">
    <h1>SOPAC Virtual Library</h1>
    <ul>
        <p align="justify">
            Welcome to the SOPAC Division's <b>Virtual Library</b>.
        It is maintained by the Publications and Library Section so that Division staff may see the status of their submitted reports; and to provide interested parties with a view of the latest reports as they are published. As such it is the most frequently used entry point for enquiries regarding access to products and services, and is greatly facilitated through a user-friendly web portal.
        To access SOPAC Commission's legacy reports, please browse <a href="http://www.sopac.org/index.php/virtual-library">SOPAC Commission Closed Collection</a>. For additional queries and requests email <a href="mailto:datarequest.sopac.org">datarequest@sopac.org</a>
        </p>
        <br/>
        <g:img width="162px" dir="images" file="foam.png"/>
        <g:if test="${cookie(name: 'skip')}">
            <a href="${createLink(controller: 'welcome', action: 'destroy')}">Enable Welcome Page</a>
        </g:if>

    </ul>

</div>

<div id="page-body" align="left" role="main">

    <richui:tabView id="tabView">
        <richui:tabLabels>
            <richui:tabLabel selected="true" title="Browse by Collection"/>
            <richui:tabLabel title="Browse by Authors"/>
            <richui:tabLabel title="Browse by Publication Date"/>
            <richui:tabLabel title="Recent Documents"/>
            <richui:tabLabel title="Search"/>
        </richui:tabLabels>

        <richui:tabContents>
            <richui:tabContent>
                <h1>Browse By Collection</h1>

                <ol align="center">
                    <g:each in="${virlib.Category.list()}" var="c">
                        <a style="text-decoration: none" href="${createLink(controller: 'document', action: 'list', params: [code: c.code])}">
                            <li align="center">
                                <p align="center" style="text-align: center;">
                                    <br/>
                                    <img height="60px" align="center" src="${resource(dir: 'images', file: c.code + '.png')}"/>
                                    <br/>
                                    <b>${c.name}</b>
                                </p>

                                <div align="center" style="font: small;color: #808080; font-weight: 100;">
                                    <p align="center" style="width: 75%; text-align: center;">${c.description}</p>
                                </div>
                            </li>
                        </a>
                    </g:each>
                </ol>
            </richui:tabContent>

            <richui:tabContent>
                <h1>Browse By Authors</h1>
                <br/>

                <div style="margin-left: 20px">
                    <g:each in="${virlib.Document.executeQuery('select distinct d.author from Document d order by d.author')}" var="d">
                        <a href="${createLink(controller: 'document', action: 'listAuthor', params: ['author': d])}">${d}</a> (${virlib.Document.findAllByAuthor(d).size()})
                        <br/>
                    </g:each>
                </div>

            </richui:tabContent>

            <richui:tabContent>
                <h1>Browse By Publication Date</h1>
                <br/>

                <div align="center" style="width: 100%; ">
                    <g:form action="doFilter" controller="filter" method="post">
                        <div class="dialog">
                            <table style="width: 200px">
                                <tr class='prop'>
                                    <td valign='top' style='text-align: left;'><label
                                            for='month'>Select Month:</label></td>
                                    <td valign='top' style='text-align: left;''>

                                <g:select name="month" from="${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']}"/>

                                </td>
                                </tr>
                                <tr class='prop'>
                                    <td valign='top' style='text-align: left;'><label
                                            for='year'>Select Year:</label></td>
                                    <td valign='top' style='text-align: left;'>
                                        <input id="year" style="width: 40px" name='year' value="2012"/>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="buttons" style="width: 60px">
                            <span align="right" class="button">
                                <input type="submit" value="Filter"/>
                            </span></div>
                    </g:form>
                </div>

            </richui:tabContent>

            <richui:tabContent>
                <h1>Recent Documents</h1>
                <br/>
                <g:each in="${Document.list(max: 15, sort: 'number', order: 'desc')}" var="d" status="i">
                    <span align="right" style="text-align: right; margin-left: 10px">
                        <g:set var="color" value="blue"/>
                        <g:if test="${d.file.trim().equals("")}">
                            <g:set var="color" value="red"/>
                        </g:if>
                        <a style="color: ${color};  text-decoration: none;" href="${createLink(controller: 'document', action: 'show', id: d.id)}">(${d.reportId})
                        <g:if test="${d.title.length() >= 100}">
                            ${d.title.substring(0, 100)}
                        </g:if>
                        <g:else>
                            ${d.title}
                        </g:else>
                        ...</a>
                        <br/><br/>
                    </span>
                </g:each>
            </richui:tabContent>

            <richui:tabContent>
                <h1>Search</h1>
                <br/>

                <div align="center">
                    <g:form controller="searchable">
                        <g:textField style="width: 480px" name="q" class="ui-state-default ui-corner-all"/>
                        <g:submitButton name="Go" class="ui-state-default ui-corner-all"/>
                        <input type="button" value="?" class="ui-state-default ui-corner-all" onclick="window.location = '${createLink(controller: 'userAccount', action: 'help')}'"/>
                    </g:form>
                </div>
            </richui:tabContent>

        </richui:tabContents>
    </richui:tabView>

</div>




<!-- logged in -->
<div align="right" style="width: 95%">
    <g:if test="${session.user != null}">
        <h1>For Administrators</h1>
        <br/>
        <a style="color: gray; text-decoration: none" href="${createLink(controller: 'document')}">Documents</a><br/><br/>
        <a style="color: gray; text-decoration: none" href="${createLink(controller: 'category')}">Categories</a><br/><br/>
        <a style="color: gray; text-decoration: none" href="${createLink(controller: 'userAccount')}">Users</a><br/><br/>
        <a style="color: gray; text-decoration: none" href="${createLink(controller: 'filter')}">Filter</a><br/><br/>
        <a style="color: gray; text-decoration: none" target="_blank" href="${createLink(controller: 'export')}">Export</a><br/><br/>
        <a style="color: gray; text-decoration: none" href="${createLink(controller: 'init', action: 'regenerate')}">Regenerate Thumbnails</a><br/><br/>
        <a style="color: gray; text-decoration: none" href="${createLink(controller: 'reindex')}">Rebuild Search Index</a><br/><br/>
        <a style="color: gray; text-decoration: none" href="${createLink(controller: 'blurb')}">Blurbs/Text</a>
    </g:if>
</div>









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
