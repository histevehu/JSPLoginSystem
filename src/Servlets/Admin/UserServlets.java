package Servlets.Admin;

import CONFIG._Config;
import DB.DAO.UserDAO;
import DB.Entity.DimUser;
import DB.Entity.User;
import PROCESSOR._Account;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.Method;

import static PROCESSOR._Account.isUserExisted;

@WebServlet("*.do")
public class UserServlets extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String servletPath = request.getServletPath();
        String methodName = servletPath.substring(1).substring(0, servletPath.length() - 4);
        try
        {
            Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, request, response);
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doPost(request, response);
    }

    private void UserSearch(HttpServletRequest request, HttpServletResponse response)
    {
        UserDAO userDAO = new UserDAO();
        User[] users = null;
        HttpSession session = request.getSession();
        String uName = request.getParameter("search_UserName");
        String fName = request.getParameter("search_FirstName");
        String lName = request.getParameter("search_LastName");
        if (uName.trim().equals("") && fName.trim().equals("") && lName.trim().equals(""))
        {
            users = userDAO.getAllUsers();
        } else
        {
            DimUser dimUser = new DimUser(uName, fName, lName);
            users = userDAO.getDimUsers(dimUser);
        }
        session.setAttribute("SearchResult", users);
        session.setAttribute("SearchParam_uName", uName);
        session.setAttribute("SearchParam_fName", fName);
        session.setAttribute("SearchParam_lName", lName);
        try
        {
            response.sendRedirect("page/admin/searchUser.jsp");
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    private void UserDelete(HttpServletRequest request, HttpServletResponse response)
    {
        String id = request.getParameter("id");
        try
        {
            int idNum = Integer.parseInt(id);
            UserDAO userDAO = new UserDAO();
            userDAO.delUser(idNum);
            response.sendRedirect(request.getContextPath() + "/page/admin/searchUser.jsp");
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    private void UserModify(HttpServletRequest request, HttpServletResponse response)
    {
        String actionID = request.getParameter("actionID");
        String actionUserName = request.getParameter("actionUserName");
        String actionEmail = request.getParameter("actionEmail");
        String alterUserInfo_pwd = request.getParameter("modify_pwd");
        String alterUserInfo_fName = request.getParameter("modify_fName");
        String alterUserInfo_lName = request.getParameter("modify_lName");
        String alterUserInfo_gender = request.getParameter("modify_gender");
        String alterUserInfo_birthday = request.getParameter("modify_birthday");
        User newUser = new User(Integer.parseInt(actionID), actionEmail, actionUserName, alterUserInfo_pwd, false, alterUserInfo_fName, alterUserInfo_lName, alterUserInfo_gender, alterUserInfo_birthday);
        try
        {
            UserDAO userDAO = new UserDAO();
            userDAO.modifyUser(newUser);
            HttpSession session = request.getSession();
            session.setAttribute("result", "y");
            response.sendRedirect(request.getContextPath() + "/page/admin/userModify.jsp?id=" + actionID);
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    private void UserAdd(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        HttpSession session = request.getSession();
        String email = request.getParameter("userInfo_email");
        String uName = request.getParameter("userInfo_userName");
        String pwd = request.getParameter("userInfo_pwd");
        String fName = request.getParameter("userInfo_fName");
        String lName = request.getParameter("userInfo_lName");
        String gender = request.getParameter("userInfo_gender");
        String birthday = request.getParameter("userInfo_birthday");

        UserDAO userDAO = new UserDAO();
        if (userDAO.isUserExisted(_Config.USER_NAME_TYPE.email.toString(), email))
        {
            session.setAttribute("UserAdd_result", "n_emailExisted");
        } else if (userDAO.isUserExisted(_Config.USER_NAME_TYPE.userName.toString(), uName))
        {
            session.setAttribute("UserAdd_result", "n_uNameExisted");
        } else
        {
            String sql = "INSERT INTO login(id,email,userName,pwd,isAdmin) VALUES(?,?,?,?,?)";
            userDAO.update(sql, 0, email, uName, pwd, false);
            String id = _Account.getLoginParameter(_Config.USER_NAME_TYPE.email, email, _Config.USER_NAME_TYPE.id).toString();
            sql = "INSERT INTO info(id,firstName,lastName,gender,birthday) VALUES(?,?,?,?,?)";
            userDAO.update(sql, Integer.parseInt(id), fName, lName, gender, birthday);
            session.setAttribute("UserAdd_result", "y");
        }
        response.sendRedirect(request.getContextPath() + "/page/admin/addUser.jsp");


    }

    private void UserRstPwd(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        HttpSession session = request.getSession();
        String pwd = request.getParameter("reset_pwd");
        String userName = session.getAttribute("reset_userName").toString();
        _Config.USER_NAME_TYPE UNT = _Config.USER_NAME_TYPE.valueOf(session.getAttribute("reset_UNT").toString());
        if (!kaptcha(request))
        {
            response.setHeader("resetResult", "wrongVerifyCode");
            String url="resetPwd.jsp?"+"from="+session.getAttribute("from").toString()+"&userName="+userName;
            request.getRequestDispatcher(url).forward(request, response);
            return;
        } else
        {
            if (isUserExisted(userName, UNT))
            {
                UserDAO userDAO=new UserDAO();
                String dbCmd = "UPDATE login SET pwd=? WHERE " + UNT.toString() + "=?";
                userDAO.update(dbCmd, pwd,userName);
                response.setHeader("resetResult", "y");
                session.setAttribute("resetedPwd", pwd);
                response.sendRedirect(request.getContextPath()+"/page/resetPwd/resetPwdSuccessful.jsp");
            } else
            {
                response.setHeader("resetResult", "noAccount");
                request.getRequestDispatcher("resetPwd.jsp?"+"from="+session.getAttribute("from").toString()+"&userName="+userName).forward(request, response);
            }
        }
    }
    private boolean kaptcha(HttpServletRequest request)
    {
        String kaptchaExpected = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        String kaptchaReceived = request.getParameter("reset_kaptcha"); //获取填写的验证码内容
        return !(kaptchaReceived == null || !kaptchaReceived.equalsIgnoreCase(kaptchaExpected));
    }


}
