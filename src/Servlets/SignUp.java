package Servlets;

import DB.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/SignUp")
public class SignUp extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String email, userName, pwd, pwdCon, fName, lName, gender, birthday;
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            HttpSession session = request.getSession();

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
            String dbCmd_email = "SELECT * FROM login WHERE email= ?";
            PreparedStatement preStmt_email = conn.prepareStatement(dbCmd_email);
            preStmt_email.setString(1, email);
            ResultSet rs_email = preStmt_email.executeQuery();
            if (rs_email.next())
            {
                session.setAttribute("signUpResult", "n_emailTaken");
                response.sendRedirect("page/signUp/signUp.jsp");
                return;
            }
            String dbCmd_uName = "SELECT * FROM login WHERE userName= ?";
            PreparedStatement preStmt_uName = conn.prepareStatement(dbCmd_uName);
            preStmt_uName.setString(1, userName);
            ResultSet rs_uName = preStmt_uName.executeQuery();
            if (rs_uName.next())
            {
                session.setAttribute("signUpResult", "n_uNameTaken");
                response.sendRedirect("page/signUp/signUp.jsp");
                return;
            }
            String dbCmd_login = "INSERT INTO login VALUES(?,?,?,?,?)";
            PreparedStatement preStmt_login = conn.prepareStatement(dbCmd_login);
            preStmt_login.setInt(1, 0);
            preStmt_login.setString(2, email);
            preStmt_login.setString(3, userName);
            preStmt_login.setString(4, pwd);
            preStmt_login.setBoolean(5, false);
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
            response.sendRedirect("page/signUp/signUpSuccessful.jsp");
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doPost(request, response);
    }

}
