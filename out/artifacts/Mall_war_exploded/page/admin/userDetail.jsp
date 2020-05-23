<%@ page import="DB.Entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../processor/_account.jsp" %>
<%@ include file="../../processor/_web.jsp" %>
<jsp:useBean id="userDetailInfo" class="DB.Entity.User" scope="request"/>
<%
    String login_id = null;
    USER_NAME_TYPE login_UNT = null;
    String login_userName = null;
    String login_pwd = null;
    LOGIN_FROM login_from = null;
    Cookie[] cookies = request.getCookies();
    boolean success_login, success_privilege;

    User user = null;
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
        userDetailInfo=(User)session.getAttribute("userDetailInfo");
        user=userDetailInfo;
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
                if (user != null)
                {

%>
<html>
<head>
    <link name='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link name='css_this' type="text/css" href='css/userDetail.css'
          rel="stylesheet"/>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/admin.svg"/>
    <title>Admin Console - User Detail</title>
</head>
<body>
<div class="pageContainer">
    <div class="div-layout-top">
        <a href="console.jsp" target="_self">
            <button class="btn-back">Console
            </button>
        </a>
        <p class="title-head" style="display: inline-block;float: left">
            Admin Console <span class="title-head-vice"> User Info Detail</span></p>

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
        <div class="">
            <div class="table-head">
                <table>
                    <colgroup style="width: 30%;"></colgroup>
                    <colgroup style="width: 70%;"></colgroup>
                    <thead>
                    <tr>
                        <th>Item</th>
                        <th>Value</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="table-body">
                <table>
                    <colgroup style="width: 30%;"></colgroup>
                    <colgroup style="width: 70%;"></colgroup>
                    <tbody>
                    <tr>
                        <td>id</td>
                        <td><%=user.getId()%>
                        </td>
                    </tr>
                    <tr>
                        <td>userName</td>
                        <td><%=user.getUserName()%>
                        </td>
                    </tr>
                    <tr>
                        <td>email</td>
                        <td><%=user.getEmail()%>
                        </td>
                    </tr>
                    <tr>
                        <td>password</td>
                        <td><%=user.getPwd()%>
                        </td>
                    </tr>
                    <tr>
                        <td>isAdmin</td>
                        <td><%=user.isAdmin()%>
                        </td>
                    </tr>
                    <tr>
                        <td>firstName</td>
                        <td><%=user.getFirstName()%>
                        </td>
                    </tr>
                    <tr>
                        <td>lastName</td>
                        <td><%=user.getLastName()%>
                        </td>
                    </tr>
                    <tr>
                        <td>gender</td>
                        <td><%=user.getGender()%>
                        </td>
                    </tr>
                    <tr>
                        <td>birthday</td>
                        <td><%=user.getBirthday()%>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
</body>
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
                Your login information is incorrect.Please login again.
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
%>
<%
    }
    else
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




