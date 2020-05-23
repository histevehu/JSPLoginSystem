<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../processor/_account.jsp"%>
<%
    DBHelper dbHelper=new DBHelper();
    Connection conn = dbHelper.getConnection();
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String pwd=request.getParameter("reset_pwd");
    String userName=session.getAttribute("reset_userName").toString();
    USER_NAME_TYPE UNT=USER_NAME_TYPE.valueOf(session.getAttribute("reset_UNT").toString());

    if (conn == null)
    {
        response.setStatus(500);
        return;
    }
    if(isUserExisted(userName,UNT))
    {
        String dbCmd = "UPDATE login SET pwd=? WHERE "+UNT.toString()+"=?";
        PreparedStatement preStmt = conn.prepareStatement(dbCmd);
        preStmt.setString(1, pwd);
        preStmt.setString(2, userName);
        preStmt.execute();
        preStmt.close();
        response.setHeader("resetResult","y");
        session.setAttribute("resetedPwd", pwd);
        response.sendRedirect("resetPwdSuccessful.jsp");
    }
    else{
        response.setHeader("resetResult","noAccount");
        request.getRequestDispatcher("restPwd.jsp").forward(request, response);
    }
%>