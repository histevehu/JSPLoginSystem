<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    enum USER_NAME_TYPE
    {
        id, userName, email, illegal
    }

    int COOKIE_LIFE_TIME=30;

    String DB_CLASS= "com.mysql.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost:3306/User?useUnicode=true&characterEncoding=utf8";
    String DB_USERNAME="root";
    String DB_PWD="hzw13579";


    String EMAIL_ACCOUNT="histevehu@qq.com";
    String EMAIL_AUTHOCODE="hhtbyigajucwfdhj";

    enum RESETPWD_FROM
    {
        forgetPwdEmail,logined,blank
    }
    enum LOGIN_FROM
    {
        _cookie,_session,illegal
    }
%>
