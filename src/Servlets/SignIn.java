package Servlets;

import CONFIG._Config;
import DB.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import static PROCESSOR._Account.*;

@WebServlet("/SignIn")
public class SignIn extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String id;
        _Config.USER_NAME_TYPE UNT;
        String userName;
        String pwd;
        boolean autoLogin;

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        userName = request.getParameter("userName");
        pwd = request.getParameter("pwd");
        autoLogin = request.getParameter("autoLogin") != null ? true : false;

        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            if (conn == null)   // DB connect failed
            {
                out.print("DB:User connect failed!");
                response.setStatus(500);
            } else  // DB connect successfully
            {
                // judge the type(id/username/email) User input in the username input-text
                UNT = judgeUserNameType(userName);
                if (UNT == _Config.USER_NAME_TYPE.illegal)    // User input the illegal content in the username input-text
                {
                    out.print("UserName Illegal! Please input legal ID/UserName/Email!");
                } else  // User username input-text type is correct
                {
                    // check if the User account exists by userName
                    if (isUserExisted(userName, UNT)) // account exists
                    {
                        //verify password
                        if (verifyPwd(userName, UNT, pwd))   // password correct, login successfully
                        {
                            out.print("Login successfully! " + UNT + ":" + userName + " pwd:" + pwd);
                            // set id and pwd to attributes of session
                            id = (UNT == _Config.USER_NAME_TYPE.id ? userName : getLoginParameter(UNT, userName, _Config.USER_NAME_TYPE.id).toString());
                            HttpSession session = request.getSession();
                            session.setAttribute("id", id);
                            session.setAttribute("userName", userName);
                            session.setAttribute("UNT", UNT.toString());
                            // if checked "remember me" then need to save cookie to achieve auto login
                            if (autoLogin)
                            {
                                int saveTime = 24 * 60 * 60 * _Config.COOKIE_LIFE_TIME;
                                Cookie userName_cookie = new Cookie("login_userName", userName);
                                Cookie UNT_cookie = new Cookie("login_UNT", UNT.toString());
                                Cookie id_cookie = new Cookie("login_id", id);
                                Cookie pwd_cookie = new Cookie("login_pwd", pwd);
                                userName_cookie.setMaxAge(saveTime);
                                userName_cookie.setPath(request.getContextPath() + "/page");
                                UNT_cookie.setMaxAge(saveTime);
                                UNT_cookie.setPath(request.getContextPath() + "/page");
                                id_cookie.setMaxAge(saveTime);
                                id_cookie.setPath(request.getContextPath() + "/page");
                                pwd_cookie.setMaxAge(saveTime);
                                pwd_cookie.setPath(request.getContextPath() + "/page");
                                response.addCookie(userName_cookie);
                                response.addCookie(UNT_cookie);
                                response.addCookie(id_cookie);
                                response.addCookie(pwd_cookie);
                            }// if not checked, clear cookie to cancel auto login
                            else
                            {
                                Cookie[] cookies = request.getCookies();
                                for (Cookie cookie : cookies)
                                {
                                    switch (cookie.getName())
                                    {
                                        case "login_id":
                                        case "login_UNT":
                                        case "login_userName":
                                        case "login_pwd":
                                            cookie.setMaxAge(0);
                                            cookie.setPath(request.getContextPath() + "/page");
                                            response.addCookie(cookie); // add new blank cookie
                                            break;
                                    }
                                }
                            }
                            // redirect to User homepage, login process finished
                            if (isAdmin(id, _Config.USER_NAME_TYPE.id))
                            {
                                response.sendRedirect("page/admin/console.jsp");
                            } else
                            {
                                response.sendRedirect("page/user/home.jsp");
                            }
                        } else // password wrong
                        {
                            out.print("pwd incorrect!");
                        }
                    } else  // account doesn't exist
                    {
                        out.print("Account doesn't exist!");
                    }
                }
            }

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
