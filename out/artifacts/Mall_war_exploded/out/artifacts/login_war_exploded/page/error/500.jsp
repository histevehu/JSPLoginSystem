<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isErrorPage="true" %>
<%
    response.setStatus(HttpServletResponse.SC_OK); //这句也一定要写,不然IE不会跳转到该页面
    String path = request.getContextPath();
%>

<html>
<head>
    <meta charset="utf-8">
    <title>Error - 500</title>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/pageIco.svg"/>
    <link id='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link id='css_error' type="text/css" href='../error/css/errorPage.css' rel="stylesheet"/>
</head>
<body>
<div class="pageContainer">
    <div class='div-head-ico'>
        <img src="../error/res/500.svg" alt="500_img" class="ico-center-largest" style="margin-top: 5%">
    </div>
    <div class="text-center">
        <p class="title-head">
            ERROR-500:Server Internal Error
        </p>
        <div>
            <table align="center">
                <tr>
                    <th>
                        <p class="text-style-inform">Error Code:</p>
                    </th>
                    <td>
                        <p class="text-style-inform">${pageContext.errorData.statusCode}</p>
                    </td>
                </tr>
                <tr>
                    <th>
                        <p class="text-style-inform">Error Location:</p>
                    </th>
                    <td>
                        <p class="text-style-inform">${pageContext.errorData.requestURI}</p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <a onclick="alterInfoDisplay(this)" class="text-style-inform" id="info-hidden" style="color: darkred;text-decoration-line: underline;cursor: pointer">Show Detail Error Info</a>
                    </td>
                </tr>
            </table>
            <table align="center">
                <tr style="height: 30%;" id="detailInfo" class="hidden">
                    <th style="text-align: center">
                        <p class="text-style-inform">Error Stack Information:</p>
                        <div style="height: 30%;text-align: left;font-weight: normal" >
                            <c:forEach var="trace" items="${pageContext.exception.stackTrace}">
                                <p class="text-style-inform">${trace}</p>
                            </c:forEach>
                        </div>
                    </th>
                </tr>
                <tr>
                    <td>

                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div>

    </div>

</div>
</body>
<script>
    function alterInfoDisplay(object) {
        if (object.id=="info-hidden") {
            document.getElementById("detailInfo").setAttribute("class","");
            object.setAttribute("id","info-show");
            object.innerHTML="Hide Detail Error Info"
        }
        else{
            document.getElementById("detailInfo").setAttribute("class","hidden");
            object.setAttribute("id","info-hidden");
            object.innerHTML="Show Detail Error Info"
        }
    }
</script>
</html>
