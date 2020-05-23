package Servlets.Admin;

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

@WebServlet("/UserModify")
public class UserModify extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try{
            DBHelper dbHelper = new DBHelper();
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            String actionID = request.getParameter("actionID");
            HttpSession session = request.getSession();
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
            response.sendRedirect(request.getContextPath()+"/page/admin/userModify.jsp?id="+actionID);
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doPost(request, response);
    }
}
