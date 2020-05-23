package Servlets.Admin;

import DB.DAO.UserDAO;
import DB.Entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AllUsers")
public class AllUsers extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        HttpSession session = request.getSession();

        int currentPage = Integer.parseInt(session.getAttribute("allUsers_currentPage").toString());
        int size = Integer.parseInt(session.getAttribute("allUsers_size").toString());
        int startAt = (currentPage - 1) * size;

        //System.out.println(currentPage+" "+size+" "+startAt);
        UserDAO userDAO = new UserDAO();
        User[] user = userDAO.getUsers(startAt, size);
        session.setAttribute("allUser_result", user);
        response.sendRedirect(request.getContextPath() + "/page/admin/allUsers.jsp" + "?page=" + currentPage);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doPost(request, response);
    }
}
