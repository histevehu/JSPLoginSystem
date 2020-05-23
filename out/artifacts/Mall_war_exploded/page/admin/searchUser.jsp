<%@ page import="DB.Entity.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    User[] users = null;

    boolean isParamOk_page = false;

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
        isParamOk_page = true;
    }
    if (isParamOk_page && (session.getAttribute("SearchResult") != null))
    {
        users = (User[]) session.getAttribute("SearchResult");
        session.removeAttribute("SearchResult");
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
    <link name='css_global' type="text/css" href='<%=request.getContextPath()%>/css/steveDesign.css' rel="stylesheet"/>
    <link name='css_this' type="text/css" href='<%=request.getContextPath()%>/page/admin/css/console.css'
          rel="stylesheet"/>
    <link name='css_this' type="text/css" href='<%=request.getContextPath()%>/page/admin/css/userDetail.css'
          rel="stylesheet"/>
    <link name='css_this' type="text/css" href='<%=request.getContextPath()%>/page/admin/css/searchUser.css'
          rel="stylesheet"/>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/admin.svg"/>
    <title>Search User</title>
</head>
<body>
<div class="pageContainer">
    <div id="pageContainer" class="pageContainer" style="width: 100%;height: 100%">
        <div class="div-layout-top">
            <a href="console.jsp" target="_self">
                <button class="btn-back">Console
                </button>
            </a>
            <p class="title-head" style="display: inline-block;float: left">
                Search User</p>

            <div style="float: right;width: 50%">
                <a href="signOut.jsp" style=" text-decoration: none;float: right;display: inline-block">
                    <button class="button-no narrow" style="width: 5em;float: right;">Sign out</button>
                </a>
                <p class="text-style-inform"
                   style="float: right;margin-right: 0.3em;margin-top: 0.8em;font-weight: bold;display: inline-block">
                    Admin:<%=login_userName%>(ID:<%=login_id%>)
                </p>


            </div>


        </div>
        <div class="div-layout-searchBar">
            <form method="post" action="<%=request.getContextPath()%>/UserSearch.do" style="margin: 0">
                <input
                        type="text" class="searchInput" name="search_UserName" placeholder="User Name(optional)"
                        maxlength="30"
                        style="margin: 0.7em"
                        value="<%if(session.getAttribute("SearchParam_uName")!=null){%><%=session.getAttribute("SearchParam_uName")%><%}%>">
                <input type="text" class="searchInput" name="search_FirstName" placeholder="First Name(optional)"
                       maxlength="15"
                       style="margin: 0.7em"
                       value="<%if(session.getAttribute("SearchParam_fName")!=null){%><%=session.getAttribute("SearchParam_fName")%><%}%>">
                <input type="text" class="searchInput" name="search_LastName" placeholder="Last Name(optional)"
                       maxlength="15"
                       style="margin: 0.7em"
                       value="<%if(session.getAttribute("SearchParam_lName")!=null){%><%=session.getAttribute("SearchParam_lName")%><%}%>">
                <button type="submit" class="button-yes"
                        style="width: 5em;float: right;margin: 0.7em 1em;padding: 0.3em">Search
                </button>

            </form>
        </div>
        <div class="table-head">
            <table>
                <colgroup style="width: 5%;"></colgroup>
                <colgroup style="width: 15%;"></colgroup>
                <colgroup style="width: 20%;"></colgroup>
                <colgroup style="width: 15%;"></colgroup>
                <colgroup style="width: 10%;"></colgroup>
                <colgroup style="width: 10%;"></colgroup>
                <colgroup style="width: 25%;"></colgroup>
                <thead>
                <tr>
                    <th>id</th>
                    <th>userName</th>
                    <th>email</th>
                    <th>password</th>
                    <th>firstName</th>
                    <th>lastName</th>
                    <th>Operation</th>
                </tr>
                </thead>
            </table>
        </div>
        <div class="table-body layout-center">
            <table>
                <colgroup style="width: 5%;"></colgroup>
                <colgroup style="width: 15%;"></colgroup>
                <colgroup style="width: 20%;"></colgroup>
                <colgroup style="width: 15%;"></colgroup>
                <colgroup style="width: 10%;"></colgroup>
                <colgroup style="width: 10%;"></colgroup>
                <colgroup style="width: 25%;"></colgroup>
                <tbody>
                <%
                    if (users != null)
                    {
                        for (int i = 0; i < users.length; i++)
                        {
                %>
                <tr>
                    <td><%=String.valueOf(users[i].getId()) %>
                    </td>
                    <td><%=users[i].getUserName() %>
                    </td>
                    <td><%=users[i].getEmail() %>
                    </td>
                    <td><%=users[i].getPwd() %>
                    </td>
                    <td><%=users[i].getFirstName() %>
                    </td>
                    <td><%=users[i].getLastName() %>
                    </td>
                    <td>
                        <a href="<%=request.getContextPath()%>/UserDetail?id=<%=users[i].getId()%>"
                           target="_self">
                            <button class="table-btn">Detail</button>
                        </a>
                        <a href="userModify.jsp?id=<%=users[i].getId()%>" target="_self">
                            <button class="table-btn">Modify</button>
                        </a>
                        <a href="<%=request.getContextPath()%>/UserDelete.do?id=<%=users[i].getId()%>" target="_self">
                            <button class="button-no table-btn-no btn-user-delete" name="<%=users[i].getId()%>">Delete
                            </button>
                        </a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>


            </table>
        </div>

    </div>
</div>
</div>
</div>
</body>
<script src="<%=request.getContextPath()%>/page/admin/js/searchUser.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.12.4.min.js"></script>
<script>
    $(function () {
        $(".btn-user-delete").click(function () {
                var id = $(this).parent().parent().parent().find("td:eq(0)").text();
                var flag = confirm("Delete User? ID:" + id);
                return flag;
            }
        );
    });
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

