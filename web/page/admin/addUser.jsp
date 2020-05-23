<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../processor/_account.jsp" %>
<%@ include file="../../processor/_web.jsp" %>

<%
    String login_id = null;
    USER_NAME_TYPE login_UNT = null;
    String login_userName = null;
    String login_pwd = null;
    LOGIN_FROM login_from = null;
    Cookie[] cookies = request.getCookies();
    boolean success_login, success_privilege;
    String param = request.getQueryString();
    String queryID = null;
    Map paramMap = new HashMap();
    Boolean isParamOk = false;

    if (session.getAttribute("id") != null && session.getAttribute("userName") != null && session.getAttribute("UNT") != null)
    {
        login_from = LOGIN_FROM._session;
        login_id = session.getAttribute("id").toString();
        login_UNT = USER_NAME_TYPE.userName.valueOf(session.getAttribute("UNT").toString());
        login_userName = session.getAttribute("userName").toString();
        success_login = (isUserExisted(login_id, USER_NAME_TYPE.id)) ? true : false;
        success_privilege = isAdmin(login_id, USER_NAME_TYPE.id) ? true : false;
    } else if (cookies != null && isInCookie(cookies, "login_id") && isInCookie(cookies, "login_UNT") && isInCookie(cookies, "login_userName") && isInCookie(cookies, "login_pwd"))
    {
        login_from = LOGIN_FROM._cookie;
        login_userName = getCookieValue(cookies, "login_userName");
        login_UNT = USER_NAME_TYPE.valueOf(getCookieValue(cookies, "login_UNT"));
        login_id = getCookieValue(cookies, "login_id");
        login_pwd = getCookieValue(cookies, "login_pwd");
        success_login = (isUserExisted(login_id, USER_NAME_TYPE.id) && verifyPwd(login_id, USER_NAME_TYPE.id, login_pwd)) ? true : false;
        success_privilege = isAdmin(login_id, USER_NAME_TYPE.id) ? true : false;
    } else
    {
        login_from = LOGIN_FROM.illegal;
        success_login = false;
        success_privilege = false;
    }

    if ((login_from == LOGIN_FROM._session || login_from == LOGIN_FROM._cookie) && success_login && success_privilege)
    {
        isParamOk = true;
    }
%>
<%!
    public boolean isInCookie(Cookie[] cookies, String key)
    {
        for (Cookie cookie : cookies)
        {
            if (cookie.getName().equals(key))
            {
                return true;
            }
        }
        return false;
    }

    public String getCookieValue(Cookie[] cookies, String key)
    {
        for (Cookie cookie : cookies)
        {
            if (cookie.getName().equals(key))
            {
                return cookie.getValue();
            }
        }
        return null;
    }
%>

<%
    if (login_from == LOGIN_FROM._session || login_from == LOGIN_FROM._cookie)
    {
        if (success_login)
        {
            if (success_privilege)
            {
                if (isParamOk)
                {

%>
<html>
<head>
    <link name='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link name='css_this' type="text/css" href='css/userDetail.css' rel="stylesheet"/>
    <link name='css_this' type="text/css" href='css/addUser.css' rel="stylesheet"/>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/admin.svg"/>
    <title>Admin Console - Modify User Info</title>
</head>
<body>
<div class="pageContainer">
    <div class="div-layout-top">
        <a href="console.jsp" target="_self">
            <button class="btn-back">Console
            </button>
        </a>
        <p class="title-head" style="display: inline-block;float: left">
            Admin Console <span class="title-head-vice"> Add User</span></p>

        <div style="float: right;width:30%;overflow: hidden">

            <a href="signOut.jsp" style=" text-decoration: none;float: right;display: inline-block">
                <button class="button-no narrow" style="width: 5em;float: right;">Sign out</button>
            </a>
            <p class="text-style-inform"
               style="float: right;margin-right: 0.3em;margin-top: 0.8em;font-weight: bold;display: inline-block">
                Admin:<%=login_userName%>(ID:<%=login_id%>)
            </p>
        </div>
    </div>
    <div class="div-layout-center">
        <form id="userSignUpInfoForm" method="post" action="<%=request.getContextPath()%>/UserAdd.do"
              style="width: 70%;margin-left: 15%;">
            <div>
                <p class="text-title-split">
                </p>
            </div>

            <div class="div-input" id="signUp-email">
                <div class="div-input-item">
                    <div>
                            <span style="color: darkred">*<p class="text-style-inform"
                                                             style="display: inline">Email Address</p></span>
                    </div>

                    <input type="text" id="user-email-input" name="userInfo_email" maxlength="50"
                           style="width: 300px"
                           required>

                    <p class="text-style-inform" id="ac_email_inform"></p>
                </div>
            </div>
            <div class="div-input" id="signUp-userName">
                <div class="div-input-item">
                    <div>
                            <span style="color: darkred">*<p class="text-style-inform"
                                                             style="display: inline">User Name</p></span>
                    </div>
                    <input type="text" id="user-userName-input" name="userInfo_userName" maxlength="30"
                           style="width: 300px" required>
                    <p class="text-style-inform" id="ac_userName_inform"></p>
                </div>
            </div>
            <div class="div-input" id="signUp-password">
                <div>
                    <div class="div-input-item">
                        <div>
                                <span style="color: darkred">*<p class="text-style-inform"
                                                                 style="display: inline">Password</p></span>
                        </div>

                        <input
                                type="password" id="user-pwd-input" name="userInfo_pwd" maxlength="20"
                                 style="width: 300px" required>
                    </div>
                    <p class="text-style-inform" id="ac_pwdConfirm_inform"></p>
                </div>
            </div>
            <div>
                <p class="text-title-split">

                </p>
            </div>

            <div class="div-input" id="signUp-name">
                <div class="div-input-item">
                    <div>
                        <span style="color: darkred">*<p class="text-style-inform"
                                                         style="display: inline">First Name</p></span>
                    </div>
                    <input type="text" id="userInfo_fName" name="userInfo_fName" maxlength="15" required>
                </div>
                <div class="div-input-item">
                    <div>
                            <span style="color: darkred">*<p class="text-style-inform"
                                                             style="display: inline">Last Name</p></span>
                    </div>
                    <input type="text" id="userInfo_lName" name="userInfo_lName" maxlength="15" required>
                </div>
            </div>
            <div class="div-input" id="signUp-gender">
                <div class="div-input-item">
                        <span style="color: darkred">*<p class="text-style-inform"
                                                         style="display: inline">Gender</p></span>
                </div>
                <div style="margin-left: 1vmin">
                    <input type="radio" name="userInfo_gender" id="radio-male" value="male" required>
                    <label for="radio-male" class="radio-label" style=""></label>Male
                    <input type="radio" name="userInfo_gender" id="radio-female" value="female" required>
                    <label for="radio-female" class="radio-label" style=""></label>Female
                </div>
            </div>
            <div class="div-input" id="signUp-birthday">
                <div class="div-input-item">
                    <span style="color: darkred">*<p class="text-style-inform"
                                                     style="display: inline">Birthday</p></span>
                    <input type="date" style="margin-left: 1vmin" id="userInfo_birthday" name="userInfo_birthday"
                           required>
                </div>
            </div>
            <button type="submit" class="button-yes">
                Add User
            </button>
        </form>

    </div>
</div>
</body>
<script>
    <%
    String msg="";
    if (session.getAttribute("UserAdd_result")!=null){
    switch (session.getAttribute("UserAdd_result").toString()){
        case "n_emailExisted":
            msg="Email Existed!";
            break;
            case "n_uNameExisted":
                 msg="User Name Existed!";
                break;
                case "y":
                    msg="User Added!";
                    break;
    }
    session.removeAttribute("UserAdd_result");

        %>
    window.onload = function () {
        alert("<%=msg%>");
    }
    <%}%>

</script>

</html>
<%
} else
{%>
<html>
<head>
    <link name='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link name='css_this' type="text/css" href='css/console.css' rel="stylesheet"/>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/error.svg"/>
    <title>Error</title>
</head>
<body>
<div class="pageContainer">
    <div style="width: 100%;height: 60%;top: 20%">
        <div style="margin-top: 1%">
            <img class="ico-center-larger" src="res/ico/error.svg">
        </div>
        <div>
            <p class="text-align-center">
                User does not existed
            </p>
        </div>
    </div>

</div>

</body>
</html>
<%}%>
<%
} else
{%>
<html>
<head>
    <link name='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link name='css_this' type="text/css" href='css/console.css' rel="stylesheet"/>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/error.svg"/>
    <title>Parameter Error</title>
</head>
<body>
<div class="pageContainer">
    <div style="width: 100%;height: 60%;top: 20%">
        <div style="margin-top: 1%">
            <img class="ico-center-larger" src="res/ico/error.svg">
        </div>
        <div>
            <p class="text-align-center">
                Invalid Parameter
            </p>
        </div>
    </div>

</div>

</body>
</html>
<%}%>
<%
} else
{%>
<html>
<head>
    <link name='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link name='css_this' type="text/css" href='css/console.css' rel="stylesheet"/>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/error.svg"/>
    <title>Sign In Error</title>
</head>
<body>
<div class="pageContainer">
    <div style="width: 100%;height: 60%;top: 20%">
        <div style="margin-top: 1%">
            <img class="ico-center-larger" src="res/ico/forbid.svg">
        </div>
        <div>
            <p class="text-align-center">
                Administrator Only
            </p>
        </div>
        <div class="text-align-center">
            <a href="../signIn/signIn.jsp" style="text-decoration-line: none;">
                <button class="button-yes">Sign in</button>
            </a>
        </div>
    </div>

</div>

</body>
</html>
<%
    }
} else
{
%>
<html>
<head>
    <link name='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link name='css_this' type="text/css" href='css/console.css' rel="stylesheet"/>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/error.svg"/>
    <title>Sign In Error</title>
</head>
<body>
<div class="pageContainer">
    <div style="width: 100%;height: 60%;top: 20%">
        <div style="margin-top: 1%">
            <img class="ico-center-larger" src="res/ico/forbid.svg">
        </div>
        <div>
            <p class="text-align-center">
                You are not logged in or your login information is invalid.<br>
                Please sign in first.
            </p>
        </div>
        <div class="text-align-center">
            <a href="../signIn/signIn.jsp" style="text-decoration-line: none;">
                <button class="button-yes">Sign in</button>
            </a>
        </div>
    </div>

</div>

</body>
</html>
<%}%>




