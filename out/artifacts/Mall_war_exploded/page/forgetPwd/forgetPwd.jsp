<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    System.out.println(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/");
    String submit_errMessage = "";
    if (response.getHeader("result") == "UNT_ILLEGAL")
    {
        submit_errMessage = "Illegal input.please enter the correct format ID/Email/UserName";
    } else if (response.getHeader("result") == "UNT_NO_ACCOUNT")
    {
        submit_errMessage = "Account does not existed";
    }

%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Forget Password?</title>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/password.svg"/>
    <link id='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link id='css_forgetPwd' type="text/css" href='css/forgetPwd.css' rel="stylesheet"/>
    <script src="js/forgetPwd.js"></script>
</head>

<body>
<div class='pageContainer'>
    <div class="containCard">
        <div class="containerDiv">
            <img src="res/img/password.svg" class="ico-center-larger" style="margin-top: 2%">
            <div style="text-align: center;margin-top: 2%">
                <form method="post" action="accountCheck.jsp">
                    <p class="title-head">
                        Find Forgotten Password
                    </p>
                    <p class="text-inform" style="margin-top: 1em">
                        Enter the ID/Email Address/User Name of your account
                    </p>
                    <input name="userName" id="userName-input" type="text" maxlength="50"
                           style="width: 70%;text-align: center" oninput="reinform_hide()">
                    <p id="reinform" style="color: darkred;font-weight: bold"><%=submit_errMessage%>
                    </p>
                    <button class="button-ok" type="submit">Submit</button>
                </form>
            </div>
        </div>


    </div>

</div>

</body>

</html>
