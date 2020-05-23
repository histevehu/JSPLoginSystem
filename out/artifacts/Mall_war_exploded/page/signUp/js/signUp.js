function formSubmit() {
    if (submitFinalCheck()) {
        document.getElementById("userSignUpInfoForm").submit();
        /*
         var xmlhttp = new XMLHttpRequest();
         xmlhttp.onreadystatechange = function () {
             if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                 if (xmlhttp.getResponseHeader("result") == 'y') {

                 }
             }
         }
         xmlhttp.open("post", "_signUpProgress.jsp", true);
         var fd = new FormData;
         fd.append("userInfo_email", document.getElementById("user-email-input").value);
         fd.append("userInfo_userName", document.getElementById("user-userName-input").value);
         fd.append("userInfo_pwd", document.getElementById("user-pwd-input").value);
         fd.append("userInfo_pwdCon", document.getElementById("user-pwdConfirm-input").value);
         fd.append("userInfo_fName", document.getElementById("userInfo_fName").value);
         fd.append("userInfo_lName", document.getElementById("userInfo_lName").value);
         fd.append("userInfo_gender", getRbtnValue(document.getElementsByName("userInfo_gender")));
         fd.append("userInfo_birthday", document.getElementById("userInfo_birthday").value);
         xmlhttp.send(fd);
     }
 */
    }
}

function ac_email() {
    var input = document.getElementById("user-email-input").value;
    var atpos = input.indexOf("@");
    var dotpos = input.lastIndexOf(".");
    // input-text is empty, clear inform text
    if (input == '') {
        document.getElementById("ac_email_inform").innerHTML = "";

        return false;
    }
    // input-text is not empty
    //email address includes illegal character
    else if (!emailLegalCharCheck(input)) {
        document.getElementById("ac_email_inform").innerHTML = " × Email Address input contains illegal characters<br>&nbsp&nbsp&nbsp<b>Correct email address format:<br>&nbsp&nbsp&nbsp (1)X@X.XX<br>&nbsp&nbsp&nbsp (2)Legal characters only include: 0~9,\'a\'~\'z\',\'A\'~\'Z\',\'-\',\'_\',\'.\',\'@\'</b>";
        document.getElementById("ac_email_inform").style.color = "darkred";

        return false;
    }
    //email address format isn't correct
    else if ((atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= input.length)) {
        document.getElementById("ac_email_inform").innerHTML = " × Please enter a properly formatted email address";
        document.getElementById("ac_email_inform").style.color = "darkred";

        return false;
    } else //email address format correct
    {
        document.getElementById("ac_email_inform").innerHTML = " ~ Email address format correct, checking availability...";
        document.getElementById("ac_email_inform").style.color = "grey";
        //connect to DB to check if email has been registered
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                if (xmlhttp.getResponseHeader("existed") == 'n') {
                    document.getElementById("ac_email_inform").innerHTML = " √ Email address valid";
                    document.getElementById("ac_email_inform").style.color = "darkgreen";

                    return true;
                } else {
                    document.getElementById("ac_email_inform").innerHTML = " × Email address has been registered";
                    document.getElementById("ac_email_inform").style.color = "darkred";

                    return false;
                }
            }
        }
        xmlhttp.open("post", "existedCheck.jsp", true);
        xmlhttp.setRequestHeader("check_type", "email");
        xmlhttp.setRequestHeader("check_content", input);
        xmlhttp.send();

    }
}

function ac_userName() {
    var input = document.getElementById("user-userName-input").value;
    // input-text is empty, clear inform text
    if (input == '') {
        document.getElementById("ac_userName_inform").innerHTML = "";
        return false;
    }
    // input-text is not empty
    // userName format isn't correct or includes illegal characters
    else if (!ac_userName_format(input)) {
        document.getElementById("ac_userName_inform").innerHTML = " × User name input contains illegal characters<br>&nbsp&nbsp&nbsp<b>Correct user name format:<br>&nbsp&nbsp&nbsp (1)Must include character<br>&nbsp&nbsp&nbsp (2)Legal characters only include: 0~9,\'a\'~\'z\',\'A\'~\'Z\',\'-\',\'_\'</b>";
        document.getElementById("ac_userName_inform").style.color = "darkred";
        return false;
    } else //userName format correct
    {
        document.getElementById("ac_userName_inform").innerHTML = " ~ User name format correct, checking availability...";
        document.getElementById("ac_userName_inform").style.color = "grey";
        //connect to DB to check if user name has been registered
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                if (xmlhttp.getResponseHeader("existed") == 'n') {
                    document.getElementById("ac_userName_inform").innerHTML = " √ User name valid";
                    document.getElementById("ac_userName_inform").style.color = "darkgreen";
                    return true;
                } else {
                    document.getElementById("ac_userName_inform").innerHTML = " × User name has been registered";
                    document.getElementById("ac_userName_inform").style.color = "darkred";
                    return false;
                }
            }
        }
        xmlhttp.open("post", "existedCheck.jsp", true);
        xmlhttp.setRequestHeader("check_type", "userName");
        xmlhttp.setRequestHeader("check_content", input);
        xmlhttp.send();
    }
}

function ac_userName_format(str) {
    if ((!isNaN(str)) || str.trim() == '') return false;
    if (!legalCharCheck(str)) return false;
    return true;
}

function ac_pwdConfirm() {
    var pwd = document.getElementById("user-pwd-input").value;
    var pwdConfirm = document.getElementById("user-pwdConfirm-input").value;
    if (pwd == "" && pwdConfirm == "") {
        document.getElementById("ac_pwdConfirm_inform").innerHTML = "";
        return false;
    } else if (!pwdLegalCharCheck(pwd) || !pwdLegalCharCheck(pwdConfirm)) {
        document.getElementById("ac_pwdConfirm_inform").innerHTML = " × Password input contains illegal characters<br>&nbsp&nbsp&nbsp<b>Correct password format:<br>&nbsp&nbsp&nbsp (1)Legal characters only include: 0~9,\'a\'~\'z\',\'A\'~\'Z\',\'-\',\'_\',\'.\',\'@\',\'$\',\'!\',\'&\'</b>";
        document.getElementById("ac_pwdConfirm_inform").style.color = "darkred";
        return false;
    } else if (pwd != "" && pwdConfirm == "") {
        document.getElementById("ac_pwdConfirm_inform").innerHTML = " ~ Please enter password again to confirmed";
        document.getElementById("ac_pwdConfirm_inform").style.color = "grey";
        return false;
    } else if (pwd == pwdConfirm) {
        document.getElementById("ac_pwdConfirm_inform").innerHTML = " √ Password confirmed";
        document.getElementById("ac_pwdConfirm_inform").style.color = "darkgreen";
        return true;
    } else {
        document.getElementById("ac_pwdConfirm_inform").innerHTML = " × Password incorrect";
        document.getElementById("ac_pwdConfirm_inform").style.color = "darkred";
        return false;
    }
}

function submitFinalCheck() {
    switch (false) {
        case ac_email():
            location.href = "#signUp-email";
            return false;
            break;
        case ac_userName():
            location.href = "#signUp-userName";
            return false;
            break;
        case ac_pwdConfirm():
            location.href = "#signUp-password";
            return false;
            break;

        case document.getElementById("userInfo_fName").value != "" && document.getElementById("userInfo_lName").value != "":
            location.href = "#signUp-name";
            return false;
            break;
        case getRbtnValue(document.getElementsByName("userInfo_gender")) != null:
            location.href = "#signUp-gender";
            return false;
            break;
        case document.getElementById("userInfo_birthday").value != null:
            location.href = "#signUp-birthday";
            return false;
            break;
    }
    return true;
}

function getRbtnValue(group) {
    for (var i = 0; i < group.length; i++) {
        if (group[i].checked) {
            return group[i].value;
        }
    }
    return null;
}

function legalCharCheck(str) {
    for (var i = str.length; --i >= 0;) {
        if (!((str.charAt(i) >= 'a' && str.charAt(i) <= 'z') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '_') || (str.charAt(i) == '-'))) {
            return false;
        }
    }
    return true;
}

function emailLegalCharCheck(str) {
    for (var i = str.length; --i >= 0;) {
        if (!((str.charAt(i) >= 'a' && str.charAt(i) <= 'z') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '_') || (str.charAt(i) == '-') || (str.charAt(i) == '@') || (str.charAt(i) == '.'))) {
            return false;
        }
    }
    return true;
}

function pwdLegalCharCheck(str) {
    for (var i = str.length; --i >= 0;) {
        if (!((str.charAt(i) >= 'a' && str.charAt(i) <= 'z') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '_') || (str.charAt(i) == '-') || (str.charAt(i) == '@') || (str.charAt(i) == '.') || (str.charAt(i) == '$') || (str.charAt(i) == '!') || (str.charAt(i) == '&'))) {
            return false;
        }
    }
    return true;
}