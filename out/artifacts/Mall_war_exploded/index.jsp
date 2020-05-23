<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Project Index</title>
    <link rel="icon" type="image/svg" sizes="256x256" href="res/ico/projectIco.svg"/>
    <link id='css_signIn' type="text/css" href='css/steveDesign.css' rel="stylesheet"/>
    <link id='css_signUp' type="text/css" href='css/index.css' rel="stylesheet"/>
</head>
<body>
<div class="pageContainer">
    <div class="div-mainIco" align="center" style="margin-top: 5%">
        <img src="res/ico/projectIco.svg" alt="pageIco" class="anim-react-mouse"
             style="background-color: rgb(30,30,30);height: 20%;margin: 4vmin">
    </div>
    <div style="text-align: center;margin-top: 1vmin">
        <p class="title-head">
            PROJECT "MALL"
        </p>
        <p class="text-style-inform slim">
            Based on the JSP + MySQL
        </p>
    </div>

    <div>
        <div style="text-align: center">
            <a href="page/signIn/signIn.jsp" target="_blank" class="" style="display: inline-block">
                <button class="button-yes">Sign In</button>
            </a>
            <a href="page/signUp/signUp.jsp" target="_blank" class="" style="display: inline-block">
                <button class="button-yes">Sign Up</button>
            </a>
        </div>
        <div style="text-align: center">
            <a href="page/signUp/signUp.jsp" target="_blank" class="" style="display: inline-block">
                <button>Visitor Pattern</button>
            </a>
        </div>
    </div>
</div>
<div class="div-copyright">
    <p class="copyright">Copyright © 2020 Steve Hu. All rights reserved.</p>
</div>
</body>
</html>
