<%--
  Created by IntelliJ IDEA.
  User: sachin
  Date: Sep 15, 2010
  Time: 12:23:09 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>SOPAC Compendium</title>
    <meta name="layout" content="main"/>
</head>

<body>

<div class="nav">
    %{--<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>--}%
    <span class="menuButton" style="margin-left: 20px;"><b>Filter Documents By Month/Year</b>
    </span>

</div>

<div id="pageBody">
    <h1></h1>

    <p></p>

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>

    <div align="center" style="width: 100%; ">
        <g:form action="doFilter" controller="filter" method="post">
            <div class="dialog">
                <table style="width: 200px">
                    <tr class='prop'>
                        <td valign='top' style='text-align: left;'><label
                                for='username'>Select Month:</label></td>
                        <td valign='top' style='text-align: left;''>

                    <g:select name="month" from="${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']}"/>

                    </td>
                    </tr>
                    <tr class='prop'>
                        <td valign='top' style='text-align: left;'><label
                                for='password'>Select Year:</label></td>
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
</div>

</body>
</html>


