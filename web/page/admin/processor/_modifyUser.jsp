<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DB.DBHelper" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ include file="../../../config/config.jsp" %>
<%
    DBHelper dbHelper = new DBHelper();
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String actionID = request.getParameter("actionID");
    Connection conn = dbHelper.getConnection();
    if (conn == null)
    {
        response.setHeader("result", "n");
        response.setStatus(500);
        return;
    }
    String alterUserInfo_pwd = request.getParameter("modify_pwd");
    String alterUserInfo_fName = request.getParameter("modify_fName");
    String alterUserInfo_lName = request.getParameter("modify_lName");
    String alterUserInfo_gender = request.getParameter("modify_gender");
    String alterUserInfo_birthday = request.getParameter("modify_birthday");
    String dbCmd_modify_login = "UPDATE login SET pwd=? WHERE id=?";
    PreparedStatement preStmt_modify_login = conn.prepareStatement(dbCmd_modify_login);
    preStmt_modify_login.setString(1, alterUserInfo_pwd);
    preStmt_modify_login.setString(2, actionID);
    preStmt_modify_login.execute();
    preStmt_modify_login.close();

    String dbCmd_modify_info = "UPDATE info SET firstName=?,lastName=?,gender=?,birthday=? WHERE id=?";
    PreparedStatement preStmt_modify_info = conn.prepareStatement(dbCmd_modify_info);
    preStmt_modify_info.setString(1, alterUserInfo_fName);
    preStmt_modify_info.setString(2, alterUserInfo_lName);
    preStmt_modify_info.setString(3, alterUserInfo_gender);
    preStmt_modify_info.setString(4, alterUserInfo_birthday);
    preStmt_modify_info.setString(5, actionID);
    preStmt_modify_info.execute();
    preStmt_modify_info.close();
    session.setAttribute("result", "y");
    response.sendRedirect("../userModify.jsp?id="+actionID);
%>

