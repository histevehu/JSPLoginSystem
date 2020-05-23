<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../processor/_account.jsp" %>
<%
    String param_from = request.getQueryString();
    Map paramSet = new HashMap();
    boolean isParamOK;
    RESETPWD_FROM param_from_type = RESETPWD_FROM.blank;

    DBHelper dbHelper=new DBHelper();
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    Connection conn = dbHelper.getConnection();

    if (conn == null)
    {
        response.setStatus(500);
        return;
    }

    if (param_from == null)
    {
        isParamOK = false;
        System.out.println("empty Param error.");
        response.setStatus(500);
        return;
    } else if (!getParamMap(param_from, paramSet))
    {
        isParamOK = false;
        System.out.println("get Param error.");
        response.setStatus(500);
    } else if (paramSet.size() != 2 || paramSet.get("from") == null || paramSet.get(USER_NAME_TYPE.userName.toString()) == null)
    {
        isParamOK = false;
        System.out.println("items lack");
        response.setStatus(500);
    } else if (!isInResetPwdFromEnum(paramSet.get("from").toString()))
    {
        isParamOK = false;
        System.out.println("from type error.");
        response.setStatus(500);
    } else
    {
        isParamOK = true;
        param_from_type = RESETPWD_FROM.valueOf(paramSet.get("from").toString());
        switch (param_from_type){
            case forgetPwdEmail:
                session.setAttribute("reset_userName", paramSet.get(USER_NAME_TYPE.userName.toString()).toString());
                session.setAttribute("reset_UNT", USER_NAME_TYPE.email.toString());
                break;
        }


    }

%>
<%!
    public boolean getParamMap(String param, Map m)
    {
        String[] items = param.split("&");
        for (int i = 0; i < items.length; i++)
        {
            String[] item = items[i].split("=");
            if (item.length == 2)
            {
                m.put(item[0], item[1]);
            } else
            {
                return false;
            }
        }
        return true;
    }

    public String emailMask(String mailAddress)
    {
        String maskMailAddress = "";
        int atPos = mailAddress.indexOf("@");
        if (atPos <= 3)
            maskMailAddress = mailAddress.substring(0, atPos);
        else
            maskMailAddress = mailAddress.substring(0, 3);
        maskMailAddress += "*****@";
        maskMailAddress += mailAddress.substring(atPos + 1);
        return maskMailAddress;
    }

    public boolean isInResetPwdFromEnum(String value)
    {
        for (int i = 0; i < RESETPWD_FROM.values().length; i++)
        {
            if (value.equals(RESETPWD_FROM.values()[i].toString()))
            {
                return true;
            }
        }
        return false;
    }
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Reset Password</title>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/pageIco.svg"/>
    <link id='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link id='css_this' type="text/css" href='css/resetPwd.css' rel="stylesheet"/>
    <script src="js/resetPwd.js"></script>
</head>

<body>
<div class='pageContainer'>
        <%
            if (isParamOK)
            {
                switch (param_from_type)
                {
                    case forgetPwdEmail:
                        if (isUserExisted(paramSet.get(USER_NAME_TYPE.userName.toString()).toString(), USER_NAME_TYPE.email))
                        {%>
    <div class="containCard">
        <img src="res/img/reset_password.svg" class="ico-center-larger" style="margin-top: 3%">
        <div class="center">
            <p style="margin-top: 2%">Since you enter from the confirm email
                <b>(<%=emailMask(paramSet.get(USER_NAME_TYPE.userName.toString()).toString())%>)</b>
            </p>
            <p>
                Password reset process will be easy
            </p>
            <div style="padding: 0.5em">
                <form name="resetPwd-form" method="post" action="resetPwdProcess.jsp">
                    <table align="center">
                        <tr>
                            <td style="text-align: right">
                                <p class="text-inform" style="display: inline-block">New Password</p>
                            </td>
                            <td>
                                <input type="password" id="user-pwd-input" name="reset_pwd" maxlength="20"
                                    oninput="ac_pwdConfirm()"  required>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <p class="text-inform" style="display: inline-block">Confirm New Password</p>
                            </td>
                            <td>
                                <input type="password" id="user-pwdConfirm-input" name="reset_pwdCon" maxlength="20"
                                       oninput="ac_pwdConfirm()" required>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <p class="text-inform" style="display: inline-block">Verification Code</p>
                            </td>
                            <td style="text-align: left">
                                <input type="password" id="kaptcha-input" name="reset_kaptcha" style="width: 100px"
                                       oninput="ac_pwdConfirm()"  required>
                            </td>
                        </tr>
                    </table>
                    <p class="text-style-inform" id="ac_pwdConfirm_inform" style="font-weight: bold">
                        <%if (response.getHeader("resetResult")=="noAccount"){%>
                        Unexpected error: the account does not exist
                        <%}%>
                    </p>
                    <p class="text-inform" style="color: darkred">Please remember new password</p>
                    <button class="button-no" type="submit">Reset Password</button>
                </form>
            </div>

        </div>

        <%
        } else
        {
        %>
        <div class="containCard" style="box-shadow: none;border: none;background-color: transparent">
            <img src="res/img/reset_password.svg" class="ico-center-larger" style="margin-top: 13%">
            <div class="center">
                <p class="title-head " style="margin-top: 3%">Reset Password Failed
                </p>
                <p>Bad Parameter - Account doesn't existed</p>
            </div>
            <%
                            }
                            break;
                        case logined:
                            ;
                            break;

                        default:
                            break;
                    }

                }
            %>

        </div>


    </div>

</body>

</html>
