<%@ page import="DB.DBHelper" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../config/config.jsp" %>
<%
    DBHelper dbHelper = new DBHelper();
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String type = request.getHeader("check_type");
    String content = request.getHeader("check_content");
    Connection conn = dbHelper.getConnection();
    if (conn == null)
    {
        response.setStatus(500);
    }
    String dbCmd = "SELECT * FROM login WHERE " + type + " = ?";
    PreparedStatement preStmt = conn.prepareStatement(dbCmd);
    preStmt.setString(1, content);
    ResultSet rs = preStmt.executeQuery();
    if (rs.next())
    {
        preStmt.close();
        rs.close();
        response.setHeader("existed", "y");
    } else
    {
        preStmt.close();
        rs.close();
        response.setHeader("existed", "n");
    }

%>
