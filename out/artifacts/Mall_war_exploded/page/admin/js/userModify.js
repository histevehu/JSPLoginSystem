function modifySubmit(id) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function () {

        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            if (xmlhttp.getResponseHeader("result") == 'n') {
                alert("Modify Error.Please try again.")
            } else {
                alert("Modify Successfully!");
                location.reload();
            }
        }
    }
    xmlhttp.open("post", "processor/_modifyUser.jsp", true);

    xmlhttp.setRequestHeader("alterUserInfo_pwd", document.getElementById("modify_pwd_input").value);
    xmlhttp.setRequestHeader("alterUserInfo_fName", document.getElementById("modify_fName_input").value);
    xmlhttp.setRequestHeader("alterUserInfo_lName", document.getElementById("modify_lName_input").value);
    xmlhttp.setRequestHeader("alterUserInfo_gender", gender);
    xmlhttp.setRequestHeader("alterUserInfo_birthday", document.getElementById("modify_birthday_input").value);

    xmlhttp.setRequestHeader("alterUserInfo_type", "modify");
    xmlhttp.setRequestHeader("alterUserInfo_id", id);

    xmlhttp.send();

}