<%@ page import="javax.sound.midi.Soundbank" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../processor/_account.jsp" %>
<%
    DBHelper dbHelper = new DBHelper();
    Connection conn = dbHelper.getConnection();
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String pwd = request.getParameter("reset_pwd");
    String userName = session.getAttribute("reset_userName").toString();
    USER_NAME_TYPE UNT = USER_NAME_TYPE.valueOf(session.getAttribute("reset_UNT").toString());
    if (conn == null)
    {
        response.setStatus(500);
        return;
    }
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
            String dbCmd = "UPDATE login SET pwd=? WHERE " + UNT.toString() + "=?";
            PreparedStatement preStmt = conn.prepareStatement(dbCmd);
            preStmt.setString(1, pwd);
            preStmt.setString(2, userName);
            preStmt.execute();
            preStmt.close();
            response.setHeader("resetResult", "y");
            session.setAttribute("resetedPwd", pwd);
            response.sendRedirect("resetPwdSuccessful.jsp");
        } else
        {
            response.setHeader("resetResult", "noAccount");
            request.getRequestDispatcher("resetPwd.jsp?"+"from="+session.getAttribute("from").toString()+"&userName="+userName).forward(request, response);
        }
    }
%>
<%!
    public boolean kaptcha(HttpServletRequest request)
    {
        String kaptchaExpected = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        String kaptchaReceived = request.getParameter("reset_kaptcha"); //获取填写的验证码内容
        return !(kaptchaReceived == null || !kaptchaReceived.equalsIgnoreCase(kaptchaExpected));
    }%>
