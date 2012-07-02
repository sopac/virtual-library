<%@ page import="virlib.Document" %>
<!doctype html>
<html>

<g:if test="${cookie(name: 'skip')}">
    ${response.sendRedirect("welcome/")}
</g:if>

<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>

    <style type="text/css">
    a:link {
        text-decoration: none;

    }

    a {
        color: blue;
    }
    </style>

</head>

<body>

<div align="center" style="border: 1px; padding:20px">
    <p style="font-family: Arial; color: #00B3ED; font-size: 16px">
        ${virlib.Blurb.list().get(0).getWelcomeText()}
    </p>
    <br/>
    <g:form controller="dualSearch" action="index">
        <g:textField style="width: 300px" name="q"/>
        <br/><br/>
        <g:submitButton name="Search Both Libraries"/>
        <br/>
        <br/>
    </g:form>





    <table align="center" width="600px">
        <tr align="center">
            <td align="center" width="50%">
                <div align="center">
                    <a href="${createLink(controller: 'welcome')}">
                        <h1>SOPAC Division Library</h1>

                        <p style="color: #000000;">2010 onwards</p>
                        Current Reports
                        <br/>
                        <img width="200px" src="images/current.png"/>
                    </a>
                </div>
            </td>
            <td align="center">
                <div align="center">
                    <a href="http://dev.sopac.org.fj:8080/closed-commission-collection">
                        <h1>SOPAC Commission Closed Collection</h1>

                        <p style="color: #000000;">1972 - 2010</p>
                        Legacy Reports
                        <br/>
                        <img width="200px" src="images/legacy.png"/>
                    </a>
                </div>

            </td>
        </tr>

    </table>

    <g:form controller="welcome" action="skip">
        <g:submitButton name="skip" value="Continue to Division Library & Do Not Show Welcome Page Again"/>
    </g:form>
</div>
</body>
</html>
