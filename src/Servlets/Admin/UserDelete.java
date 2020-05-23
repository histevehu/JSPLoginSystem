package Servlets.Admin;

import DB.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/UserDelete")
public class UserDelete extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
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
        } catch (SQLException e)
        {
            e.printStackTrace();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doPost(request, response);
    }
}
