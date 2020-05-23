// 获取弹窗
var modal = document.getElementById('modal');
var modal_cont = document.getElementById('modal-content');
var pageContainer = document.getElementById('pageContainer');
var dialog_title = document.getElementById('dialog-title')
var dialog_text = document.getElementById('dialog-text')
// 打开弹窗的按钮对象
var btn = document.getElementById("delConfirm");

// 获取 <span> 元素，用于关闭弹窗
var span = document.querySelector('.close');

// 点击按钮打开弹窗
function initialDialog(object) {
    dialogOpen('Confirm Action','Delete User(ID:'+object.name+') ?','err',object);
}

// 点击 <span> (x), 关闭弹窗
span.onclick = function () {
    dialogClose();
}

// 在用户点击其他地方时，关闭弹窗
window.onclick = function (e) {
    if (e.target == modal) {
        dialogClose();
    }
}

function dialogOpen(title, text, theme,object) {
    pageContainer.className = 'layer'
    modal.className = "modal-appear";
    if (theme.trim() != '') {
        modal_cont.className += ' dialog-theme-' + theme;
        dialog_title.className = dialog_title.className+ ' dialog-title-' + theme;
    }
    dialog_title.innerHTML = title;
    dialog_text.innerHTML = text;
    modal_cont.style.display = "block";
    document.getElementById("doDelBtn").name=object.name;

}
function dialogClose() {
    modal.className = "modal-disappear";
    setTimeout(function () { modal.className = ""; }, 500)
    modal_cont.style.display = "";
    pageContainer.className = '';

}
function deleteUser(object)
{
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            if (xmlhttp.getResponseHeader("result") == 'n') {
                alert("Delete Error.Please try again.")
            } else {
                location.reload();
            }
        }
    }
    xmlhttp.open("post", "../../UserDelete", true);
    xmlhttp.setRequestHeader("alterUserInfo_id", object.name);
    xmlhttp.send();
}
function inputPageRecover(object,val){
    object.value=val;
}
function handleEnter(object, total,event) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which
        : event.charCode;
    if (keyCode == 13) {
        if (object.value<1||object.value>total){
            alert("Input page out of range! (Pages Range:1~"+total+")");
        } else{
            window.location="allUsers.jsp?page="+object.value;
        }

    }
}

