<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Sign In</title>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/pageIco_signIn.svg" />
    <link id='css_signIn' type="text/css" href='css/signIn.css' rel="stylesheet" />
</head>

<body>
<div class='pageContainer'>
    <div class="containCard">
        <div class='div-head-ico'>
            <img src="res/img/signIn_user.svg" alt="signIn_user_img" class="ico-center">
        </div>
        <div>
            <p class="title-head">
                Sign In
            </p>
            <div class="containerDiv">
                <form name="form_email" method="post" action="_signInProcess.jsp"
                      autocomplete="on">
                    <p class="text-inform slim">ID / Email Address / Username</p>
                    <input class='textbox' type="text" placeholder="" name="userName" required>
                    <span class="text-inform slim left">
                            Password
                        </span>
                    <span class="text-inform slim">
                            <a href="../forgetPwd/forgetPwd.jsp" class="right">
                                Forget Password?
                            </a>
                        </span>

                    <input class='textbox' type="password" placeholder="" name="pwd" required>
                    <div class="div-checkbox">
                        <input class='checkbox' type="checkbox" name="autoLogin"> <span class="text-inform">Remember Me</span>
                    </div>
                    <div>
                        <button class="button-ok" type="submit">Sign In</button>
                    </div>
                </form>
                <hr>
                <p class="text-inform center">New to Here? </p>

                <a href="../signUp/signUp.jsp" target="_self" style="text-decoration:none">
                    <button style="margin-top: 1vmin">Sign Up</button>
                </a>
            </div>


        </div>
    </div>

</div>

</body>

</html>
