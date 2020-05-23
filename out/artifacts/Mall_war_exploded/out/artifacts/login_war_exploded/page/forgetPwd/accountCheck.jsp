<%@ page import="javax.mail.Session" %>
<%@page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Properties" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../processor/_account.jsp" %>
<%
    String userName = request.getParameter("userName");
    USER_NAME_TYPE UNT;
    try
    {
        DBHelper dbHelper = new DBHelper();
        Connection conn = dbHelper.getConnection();
        if (conn == null)   // DB connect failed
        {
            response.setStatus(500);
        } else  // DB connect successfully
        {
            // judge the type(id/username/email) User input in the username input-text
            UNT = judgeUserNameType(userName);
            if (UNT == USER_NAME_TYPE.illegal)    // User input the illegal content in the username input-text
            {
                response.setHeader("result", "UNT_ILLEGAL");
                request.getRequestDispatcher("forgetPwd.jsp").forward(request, response);
            } else  // User username input-text type is correct
            {
                // check if the User account exists by userName
                if (isUserExisted(userName, UNT)) // account exists
                {
                    response.setHeader("result", "SUCCESS");
                    String targetEmailAddress = (UNT == USER_NAME_TYPE.email ? userName : getLoginParameter(UNT, userName, USER_NAME_TYPE.email).toString());
                    veriEmailSend(targetEmailAddress, request);

                    session.setAttribute("targetEmailAddress", targetEmailAddress);
                    response.sendRedirect("remindEmailCheck.jsp");

                } else  // account doesn't exist
                {
                    response.setHeader("result", "UNT_NO_ACCOUNT");

                    request.getRequestDispatcher("forgetPwd.jsp").forward(request, response);
                }
            }


        }

    } catch (Exception e)
    {
        e.printStackTrace();
    }

%>
<%!
    public void veriEmailSend(String targetEmailAddress, HttpServletRequest request)
    {
        try
        {
            String myEmailAccount = EMAIL_ACCOUNT;
            String myEmailSMTPHost = "smtp.qq.com";
            Properties props = new Properties();
            props.setProperty("mail.transport.protocol", "smtp");
            props.setProperty("mail.smtp.host", myEmailSMTPHost);
            props.setProperty("mail.smtp.auth", "true");

            String smtpPort = "465";
            props.setProperty("mail.smtp.port", smtpPort);
            props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.setProperty("mail.smtp.socketFactory.fallback", "false");
            props.setProperty("mail.smtp.socketFactory.port", smtpPort);

            Session sess = Session.getDefaultInstance(props);
            sess.setDebug(false);

            MimeMessage message = createMimeMessage(sess, myEmailAccount, targetEmailAddress, request);
            Transport transport = sess.getTransport();
            transport.connect(myEmailAccount, EMAIL_AUTHOCODE);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    public MimeMessage createMimeMessage(Session session, String sendMail, String receiveMail, HttpServletRequest request) throws Exception
    {
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(sendMail, "Project Index", "UTF-8"));
        message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "User", "UTF-8"));
        message.setSubject("Find forgotten password", "UTF-8");
        String emailContent = "<!DOCTYPE html>\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "    <title>Title</title>\n" +
                "</head>\n" +
                "<body style=\"background-color: rgb(240,240,240)\">\n" +
                "<table align=\"center\"\n" +
                "       style=\"text-align:center;font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif\">\n" +
                "    <tr>\n" +
                "        <td>\n" +
                "            <h1> Find Forgotten Password</h1>\n" +
                "        </td>\n" +
                "    </tr>\n" +
                "    <tr>\n" +
                "        <td>\n" +
                "            <h3>\n" +
                "                We have received your request to retrieve the lost password.<br>\n" +
                "                Click the button to reset your password\n" +
                "            </h3>\n" +
                "<a id=\"url_resetPwdBtn\"  href=\"" +
                request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/" + "page/resetPwd/resetPwd.jsp?from=" + RESETPWD_FROM.forgetPwdEmail.toString() + "&userName=" + receiveMail +
                "\"><button style=\"display: inline-block;margin: 1vmin auto;padding: 1vmin 3vmin;border-radius: 7px;border-width: 1px;border-style: solid;outline: 0;font-size: 1em;border-color: rgb(40, 150, 80);color: white;background-color: rgb(46, 188, 79);\">" +
                " Reset Password</button></a>" +
                "        </td>\n" +
                "    </tr>\n" +
                "    <tr>\n" +
                "        <td>\n" +
                "            <br><br>If the button cannot be displayed, click the hyperlink below to reset the password<br>\n" +
                "            <a id=\"url_resetPwdLink\"  href=\"" +
                request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/" + "page/resetPwd/resetPwd.jsp?from=" + RESETPWD_FROM.forgetPwdEmail.toString() + "&userName=" + receiveMail +
                "\">Reset Password</a>\n" +
                "        </td>\n" +
                "\n" +
                "    </tr>\n" +
                "    <tr>\n" +
                "        <td style=\"text-align: right\">\n" +
                "            <br>\n" +
                "            <br>\n" +
                "            <hr>\n" +
                "            <p style=\"color: dimgrey\">Project Index Team</p>\n" +
                "        </td>\n" +
                "    </tr>\n" +
                "</table>\n" +
                "</body>\n" +
                "</html>";
        message.setContent(emailContent, "text/html;charset=UTF-8");
        message.setSentDate(new Date());
        message.saveChanges();
        return message;
    }
%>
