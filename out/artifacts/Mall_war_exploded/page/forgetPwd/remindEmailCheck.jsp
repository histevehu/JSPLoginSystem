<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String mailAddress=session.getAttribute("targetEmailAddress").toString();
    String maskMailAddress="";
    int atPos=mailAddress.indexOf("@");
    if(atPos<=3)
        maskMailAddress=mailAddress.substring(0, atPos);
    else
        maskMailAddress=mailAddress.substring(0,3);
    maskMailAddress+="*****@";
    maskMailAddress+=mailAddress.substring(atPos+1);
%>
<html>
<head>
    <title>Title</title>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/mail.svg"/>
    <link id='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link id='css_forgetPwd' type="text/css" href='css/forgetPwd.css' rel="stylesheet"/>
    <script src="js/forgetPwd.js"></script>
</head>
<body>
<div class='pageContainer'>
    <div class="containCard mailInform">
        <div class="containerDiv">
            <img src="res/ico/mail_dark.svg" class="ico-center-larger" style="margin-top: 5%">
            <div style="text-align: center;margin-top: 3%">
                    <p>
                        The Verification Mail has been sent to your Email Address <br><b><%=maskMailAddress%></b>
                    </p>
                <p class="text-inform" style="margin-top: 2em">
                    Please sign in the mailbox as soon as possible and click the link in the mail to complete the password reset
                </p>
            </div>
            <div>

            </div>
        </div>


    </div>

</div>
</body>
</html>
