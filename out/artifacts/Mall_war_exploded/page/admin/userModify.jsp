<%@ page import="DB.Entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../processor/_account.jsp" %>
<%@ include file="../../processor/_web.jsp" %>
<jsp:useBean id="UserDAO" class="DB.DAO.UserDAO"></jsp:useBean>
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
        paramMap = getParamMap(param);
        if (paramMap.get("id") != null)
        {
            isParamOk = true;
            queryID = paramMap.get("id").toString();
        }
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
                    user = UserDAO.getUser(Integer.parseInt(queryID));
                    if (user != null)
                    {

%>
<html>
<head>
    <link name='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link name='css_this' type="text/css" href='css/userDetail.css' rel="stylesheet"/>
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
            Admin Console <span class="title-head-vice"> User Info Modify</span></p>

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
                <form method="post" action="<%=request.getContextPath()%>/UserModify.do">
                    <table>
                        <colgroup style="width: 30%;"></colgroup>
                        <colgroup style="width: 70%;"></colgroup>
                        <tbody>
                        <tr>
                            <td>id</td>
                            <td style="color: dimgrey"><input type="text" name="actionID" value="<%=user.getId()%>"
                                                              style="border: none;background-color: transparent;text-align: center"
                                                              readonly>
                            </td>
                        </tr>
                        <tr>
                            <td>userName</td>
                            <td style="color: dimgrey"><input type="text" name="actionUserName"
                                                              value="<%=user.getUserName()%>"
                                                              style="border: none;background-color: transparent;text-align: center"
                                                              readonly>
                            </td>
                        </tr>
                        <tr>
                            <td>email</td>
                            <td style="color: dimgrey"><input type="text" name="actionEmail"
                                                              value="<%=user.getEmail()%>"
                                                              style="border: none;background-color: transparent;text-align: center"
                                                              readonly></td>
                        </tr>
                        <tr>
                            <td>password</td>
                            <td><input type="text" style="width: 50%;text-align: center" name="modify_pwd"
                                       id="modify_pwd_input"
                                       value="<%=user.getPwd()%>"></td>
                        </tr>
                        <tr>
                            <td>firstName</td>
                            <td><input type="text" style="width: 50%;text-align: center" name="modify_fName"
                                       id="modify_fName_input"
                                       value="<%=user.getFirstName()%>"></td>
                        </tr>
                        <tr>
                            <td>lastName</td>
                            <td><input type="text" style="width: 50%;text-align: center" name="modify_lName"
                                       id="modify_lName_input"
                                       value="<%=user.getLastName()%>"></td>
                        </tr>
                        <tr>
                            <td>gender</td>
                            <td>
                                <input type="radio" name="modify_gender" id="radio-male" value="male" required
                                       <%if(user.getGender().equals("male")){%>checked<%}%>>
                                <label for="radio-male" class="radio-label" style=""></label>Male
                                <input type="radio" name="modify_gender" id="radio-female" value="female" required
                                       <%if(user.getGender().equals("female")){%>checked<%}%>>
                                <label for="radio-female" class="radio-label" style=""></label>Female
                            </td>
                        </tr>
                        <tr>
                            <td>birthday</td>
                            <td><input type="date" style="width: 50%" name="modify_birthday" id="modify_birthday_input"
                                       value="<%=user.getBirthday()%>"></td>
                        </tr>
                        </tbody>
                    </table>
                    <button class="button-yes" type="submit">
                        Modify
                    </button>
                </form>

            </div>
        </div>

    </div>
</div>
</body>
<script>
    <%if (session.getAttribute("result")!=null && session.getAttribute("result").toString()=="y"){
    session.removeAttribute("result");%>
    window.onload = function () {
        alert("Modify Successfully!");
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




