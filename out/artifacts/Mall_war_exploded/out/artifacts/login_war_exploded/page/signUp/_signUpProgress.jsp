<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../processor/_account.jsp" %>
<%!
String email
        ,
        userName
        ,
        pwd
        ,
        pwdCon
        ,
        fName
        ,
        lName
        ,
        gender
        ,
        birthday;
%>
<%
    DBHelper dbHelper=new DBHelper();
    Connection conn = dbHelper.getConnection();request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    email = request.getParameter("userInfo_email");
    userName = request.getParameter("userInfo_userName");
    pwd = request.getParameter("userInfo_pwd");
    pwdCon = request.getParameter("userInfo_pwdCon");
    fName = request.getParameter("userInfo_fName");
    lName = request.getParameter("userInfo_lName");
    gender = request.getParameter("userInfo_gender");
    birthday = request.getParameter("userInfo_birthday");

    if (conn == null)
    {
        response.setStatus(500);
        return;
    }
    String dbCmd_login = "INSERT INTO login VALUES(?,?,?,?)";
    PreparedStatement preStmt_login = conn.prepareStatement(dbCmd_login);
    preStmt_login.setInt(1, 0);
    preStmt_login.setString(2, email);
    preStmt_login.setString(3, userName);
    preStmt_login.setString(4, pwd);
    preStmt_login.execute();
    String dbCmd_getId = "SELECT * FROM login WHERE email=?";
    PreparedStatement preStmt_getId = conn.prepareStatement(dbCmd_getId);
    preStmt_getId.setString(1, email);
    ResultSet rs_getId = preStmt_getId.executeQuery();
    rs_getId.next();
    int login_id = rs_getId.getInt("id");
    String dbCmd_info = "INSERT INTO info VALUES(?,?,?,?,?)";
    PreparedStatement preStmt_info = conn.prepareStatement(dbCmd_info);
    preStmt_info.setInt(1, login_id);
    preStmt_info.setString(2, fName);
    preStmt_info.setString(3, lName);
    preStmt_info.setString(4, gender);
    preStmt_info.setString(5, birthday);
    preStmt_info.execute();

    preStmt_login.close();
    preStmt_getId.close();
    preStmt_info.close();
    rs_getId.close();

    session.setAttribute("id", login_id);
    session.setAttribute("email", email);
    session.setAttribute("userName", userName);
    session.setAttribute("pwd", pwd);
    response.sendRedirect("signUpSuccessful.jsp");


%>


