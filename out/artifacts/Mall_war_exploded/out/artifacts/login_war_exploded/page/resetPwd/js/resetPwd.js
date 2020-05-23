function ac_pwdConfirm() {
    var pwd = document.getElementById("user-pwd-input").value;
    var pwdConfirm = document.getElementById("user-pwdConfirm-input").value;
    if (pwd == "" && pwdConfirm == "") {
        document.getElementById("ac_pwdConfirm_inform").innerHTML = "";
        return false;
    }  else if(!pwdLegalCharCheck(pwd)||!pwdLegalCharCheck(pwdConfirm)){
        document.getElementById("ac_pwdConfirm_inform").innerHTML = " × Password input contains illegal characters<br>&nbsp&nbsp&nbsp<b>Correct password format:<br>&nbsp&nbsp&nbsp (1)Legal characters only include: 0~9,\'a\'~\'z\',\'A\'~\'Z\',\'-\',\'_\',\'.\',\'@\',\'$\',\'!\',\'&\'</b>";
        document.getElementById("ac_pwdConfirm_inform").style.color = "darkred";
        return false;
    }
    else if (pwd != "" && pwdConfirm == "") {
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

function pwdLegalCharCheck(str) {
    for (var i = str.length; --i >= 0;) {
        if (!((str.charAt(i) >= 'a' && str.charAt(i) <= 'z') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '_') || (str.charAt(i) == '-') || (str.charAt(i) == '@')|| (str.charAt(i) == '.')|| (str.charAt(i) == '$')|| (str.charAt(i) == '!')|| (str.charAt(i) == '&'))) {
            return false;
        }
    }
    return true;
}
function formSubmit() {
    if (submitFinalCheck()) {
        document.getElementById("newPwd-form").submit();
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
