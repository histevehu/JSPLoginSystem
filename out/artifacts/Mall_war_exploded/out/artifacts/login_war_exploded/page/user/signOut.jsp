<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("id") != null)
        session.removeAttribute("id");
    if (session.getAttribute("unt") != null)
        session.removeAttribute("unt");
    if (session.getAttribute("login_userName") != null)
        session.removeAttribute("login_userName");
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies)
    {
        switch (cookie.getName())
        {
            case "login_id":
            case "login_UNT":
            case "login_userName":
            case "login_pwd":
                cookie.setMaxAge(0);
                cookie.setPath(request.getContextPath()+"/page");
                response.addCookie(cookie); // add new blank cookie
                break;
        }
    }
    session.invalidate();
    response.sendRedirect("../signIn/signIn.jsp");
%>
