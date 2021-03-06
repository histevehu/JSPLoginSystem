<%@ page import="DB.Entity.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../processor/_account.jsp" %>
<jsp:useBean id="UserDAO" class="DB.DAO.UserDAO"></jsp:useBean>
<%
    String login_id = null;
    USER_NAME_TYPE login_UNT = null;
    String login_userName = null;
    String login_pwd = null;
    LOGIN_FROM login_from = null;
    Cookie[] cookies = request.getCookies();
    boolean success_login, success_privilege;
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
    if ((login_from == LOGIN_FROM._session || login_from == LOGIN_FROM._cookie)&&success_login&&success_privilege)
    {
        User Users[]=UserDAO.getAllUsers();
        System.out.println(Users.toString());
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
            {%>
<html>
<head>
    <link name='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <title>User Homepage</title>
</head>
<body>
<div>
    <p style="font-weight: bold">
        Login successfully! <br></p>
    <p>From: <%=login_from.toString()%><br>
        ID: <%=login_id%><br>
        UNT: <%=login_UNT%> <br>
        LOGIN_USERNAME: <%=login_userName%><br>
        PWD:<%=login_pwd%><br>
        success_login:<%=success_login%><br>
        success_privilege:<%=success_privilege%><br>
    </p>
</div>
<div>
    <a href="signOut.jsp">
        <button class="button-no">Sign out</button>
    </a>
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
        <%}
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
    <%}
%>

<%
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

