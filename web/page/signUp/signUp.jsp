<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Sign Up</title>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/pageIco.svg"/>
    <link id='css_global' type="text/css" href='../../css/steveDesign.css' rel="stylesheet"/>
    <link id='css_signUp' type="text/css" href='css/signUp.css' rel="stylesheet"/>
    <script src="js/signUp.js"></script>
</head>

<body>
<div class='pageContainer' style="overflow: hidden">
    <div class='div-head div-layout-top'>
        <div style="float: left">
            <img src="res/img/signUp_user.svg" class="ico-left" alt="signUp_user_img">
        </div>

        <div style="float: left">
            <p class="title-head">Welcome</p>
            <p class="text-style-inform">Sign up a new account</p>
        </div>
        <div style="float: right">
            <p class="text-style-inform" style="margin-top: 2vmin;margin-right: 2vmin;">
                Already have an account?
            </p>
            <a href="../signIn/signIn.jsp" target="_self">
                <button style="float: right;margin-top: 0vmin;margin-right: 2vmin">Sign In</button>
            </a>
        </div>
    </div>
    <div class="containerDiv div-layout-center">
        <div class="formContainer">
            <form id="userSignUpInfoForm" method="post" action="<%=request.getContextPath()%>/SignUp"
                  style="width: 70%;margin-left: 15%;">
                <div>
                    <p class="text-title-split">
                        --- Sign In Info ---
                    </p>
                </div>

                <div class="div-input" id="signUp-email">
                    <div class="div-input-item">
                        <div>
                            <span style="color: darkred">*<p class="text-style-inform"
                                                             style="display: inline">Email Address</p></span>
                        </div>

                        <input type="text" id="user-email-input" name="userInfo_email" maxlength="50"
                               oninput="ac_email()" style="width: 300px"
                               required>

                        <p class="text-style-inform" id="ac_email_inform"></p>
                    </div>
                </div>
                <div class="div-input" id="signUp-userName">
                    <div class="div-input-item">
                        <div>
                            <span style="color: darkred">*<p class="text-style-inform"
                                                             style="display: inline">User Name</p></span>
                        </div>
                        <input type="text" id="user-userName-input" name="userInfo_userName" maxlength="30"
                               oninput="ac_userName()" style="width: 300px" required>
                        <p class="text-style-inform" id="ac_userName_inform"></p>
                    </div>
                </div>
                <div class="div-input" id="signUp-password">
                    <div>
                        <div class="div-input-item">
                            <div>
                                <span style="color: darkred">*<p class="text-style-inform"
                                                                 style="display: inline">Password</p></span>
                            </div>

                            <input
                                    type="password" id="user-pwd-input" name="userInfo_pwd" maxlength="20"
                                    oninput="ac_pwdConfirm()" style="width: 300px" required>
                        </div>
                        <div class="div-input-item">
                            <div>
                                <span style="color: darkred">*<p class="text-style-inform"
                                                                 style="display: inline">Password Confirm</p></span>
                            </div>
                            <input type="password" id="user-pwdConfirm-input" name="userInfo_pwdCon" maxlength="20"
                                   oninput="ac_pwdConfirm()" style="width: 300px" required>
                        </div>
                        <p class="text-style-inform" id="ac_pwdConfirm_inform"></p>
                    </div>
                </div>
                <div>
                    <p class="text-title-split">
                        --- User Info ---
                    </p>
                </div>

                <div class="div-input" id="signUp-name">
                    <div class="div-input-item">
                        <div>
                        <span style="color: darkred">*<p class="text-style-inform"
                                                         style="display: inline">First Name</p></span>
                        </div>
                        <input type="text" id="userInfo_fName" name="userInfo_fName" maxlength="15" required>
                    </div>
                    <div class="div-input-item">
                        <div>
                            <span style="color: darkred">*<p class="text-style-inform"
                                                             style="display: inline">Last Name</p></span>
                        </div>
                        <input type="text" id="userInfo_lName" name="userInfo_lName" maxlength="15" required>
                    </div>
                </div>
                <div class="div-input" id="signUp-gender">
                    <div class="div-input-item">
                        <span style="color: darkred">*<p class="text-style-inform"
                                                         style="display: inline">Gender</p></span>
                    </div>
                    <div style="margin-left: 1vmin">
                        <input type="radio" name="userInfo_gender" id="radio-male" value="male" required>
                        <label for="radio-male" class="radio-label" style=""></label>Male
                        <input type="radio" name="userInfo_gender" id="radio-female" value="female" required>
                        <label for="radio-female" class="radio-label" style=""></label>Female
                    </div>
                </div>
                <div class="div-input" id="signUp-birthday">
                    <div class="div-input-item">
                        <span style="color: darkred">*<p class="text-style-inform" style="display: inline">Birthday</p></span>
                        <input type="date" style="margin-left: 1vmin" id="userInfo_birthday" name="userInfo_birthday"
                               required>
                    </div>
                </div>
            </form>
        </div>

    </div>
    <div class="div-layout-foot">
        <div style="float: right;">
            <button class="button-yes" type="submit" onclick="formSubmit()"
                    style="font-size:1.3em;padding:5px 20px;height: 80%;margin: 10px 5vmin">Sign
                Up
            </button>


        </div>
        <div style="float: left;margin: 13px 3vmin">
            <p style=" color: darkred">
                All items with * marks are required
            </p>
        </div>

    </div>
</div>
<script>
    <%if (session.getAttribute("signUpResult")!=null){
        String msg="";
        switch (session.getAttribute("signUpResult").toString()){
            case "n_emailTaken":
                msg="Email address has been registered!";
                break;
                case "n_uNameTaken":
                    msg="User Name has been registered!";
                    break;
        }
        session.removeAttribute("signUpResult");%>
    window.onload = function () {
        alert("<%=msg%>");
    }
    <%}%>

</script>
</body>

</html>

