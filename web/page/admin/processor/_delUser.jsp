<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DB.DBHelper" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ include file="../../../config/config.jsp" %>
<%
    DBHelper dbHelper = new DBHelper();
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String actionID = request.getHeader("alterUserInfo_id");
    Connection conn = dbHelper.getConnection();
    if (conn == null)
    {
        response.setHeader("result", "n");
        response.setStatus(500);
        return;
    }

    String dbCmd = "DELETE login,info FROM login LEFT JOIN info ON login.id = info.id WHERE login.id=?";
    PreparedStatement preStmt = conn.prepareStatement(dbCmd);
    preStmt.setString(1, actionID);
    preStmt.execute();
    response.setHeader("result", "y");

%>

