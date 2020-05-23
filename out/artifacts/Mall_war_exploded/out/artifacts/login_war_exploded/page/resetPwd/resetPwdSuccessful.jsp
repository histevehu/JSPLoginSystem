<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String resetedPwd = session.getAttribute("resetedPwd").toString();
%>
<html>
<head>
    <meta charset="utf-8">
    <title>Sign Up Successfully</title>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/signUp_successful_pageIco.svg"/>
    <link id='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link id='css_signUp' type="text/css" href='css/resetPwdSuccessful.css' rel="stylesheet"/>
    <script src="js/resetPwdSuccessful.js"></script>
</head>
<body>
<div class="pageContainer">
    <div class="containCard containCard-style-successful" style="height: 60%;top: 20%">
        <div class='div-head-ico'>
            <img src="res/ico/reset_password.svg" alt="reset_password_img" class="ico-center-larger"
                 style="margin-top: 5%">
        </div>
        <div>
            <p class="title-head" style="font-weight: normal;text-align: center;margin-top: 2%">
                Password Reset Successfully!
            </p>
        </div>
        <div>
            <table style="margin: 1% auto">
                <tr>
                    <th>New Password</th>
                </tr>
                <tr>
                    <td onmouseover="pwdDisCover(this)" onmouseout="pwdCover(this)">**********</td>
                </tr>
                <tr style="height: 0.1em">
                <tr>
                    <td style="color: darkgreen;">Please remember new password</td>
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
    function pwdDisCover(obj){
        obj.innerHTML="<%=resetedPwd%>";
    }
    function pwdCover(obj) {
        obj.innerHTML = "**********";
    }
</script>
</body>
</html>
