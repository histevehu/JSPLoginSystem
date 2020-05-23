<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = session.getAttribute("id").toString();
    String email = session.getAttribute("email").toString();
    String userName = session.getAttribute("userName").toString();
    String pwd = session.getAttribute("pwd").toString();
%>
<html>
<head>
    <meta charset="utf-8">
    <title>Sign Up Successfully</title>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/signUp_successful_pageIco.svg"/>
    <link id='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link id='css_signUp' type="text/css" href='css/signUp.css' rel="stylesheet"/>
    <script src="js/signUp_successful.js"></script>
</head>
<body>
<div class="pageContainer">
    <div class="containCard containCard-style-successful">
        <div class='div-head-ico'>
            <img src="res/img/signUp_successful.svg" alt="signUp_successful_img" class="ico-center-larger"
                 style="margin-top: 2%">
        </div>
        <div>
            <p class="title-head" style="font-weight: normal;text-align: center;margin-top: 2%">
                Sign Up Successfully!
            </p>
        </div>
        <div>
            <table style="margin: 1% auto">
                <tr>
                    <th>ID</th>
                </tr>
                <tr>
                    <td><%=id%>
                    </td>
                </tr>
                <tr style="height: 0.1em">
                </tr>
                <tr>
                    <th>Email</th>
                </tr>
                <tr>
                    <td><%=email%>
                    </td>
                </tr>
                <tr style="height: 0.1em">
                <tr>
                    <th>User Name</th>
                </tr>
                <tr>
                    <td><%=userName%>
                    </td>
                </tr>
                <tr style="height: 0.1em">
                <tr>
                    <th>Password</th>
                </tr>
                <tr>
                    <td onmouseover="pwdDisCover(this)" onmouseout="pwdCover(this)">**********</td>
                </tr>
                <tr style="height: 0.1em">
                <tr>
                    <td style="color: darkred;">You could sign in with ID/Email/User Name + Password</td>
                </tr>
            </table>
            <div style="text-align: center">
                <a href="../signIn/signIn.jsp" target="_blank">
                    <button class="button-yes" style="padding: 1.5vmin 3vmin">
                        Remembered, Sign In Now
                    </button>
                </a>
            </div>


        </div>
    </div>
</div>
<script>
    function pwdDisCover(obj) {
        obj.innerHTML = "<%=pwd%>";
    }
</script>
</body>
</html>
