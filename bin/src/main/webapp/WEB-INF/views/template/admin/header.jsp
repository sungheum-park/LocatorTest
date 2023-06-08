<%@ page import="kr.co.msync.web.module.menu.controller.MenuController" %>
<%@ page import="kr.co.msync.web.module.user.UserController" %>
<%@ page import="kr.co.msync.web.module.common.type.ResultType" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<script type="text/javascript">
    $(document).ready(function(){
        jsMenuList(1);
        jsPwdConfirm();
    });

    function jsMenuList(menu_level) {
        $.ajax({
            url: "<%=MenuController.MENU_LIST%>",
            data: {menu_level:menu_level},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                var html = "";
                $.each(result.menuList, function(index, item){
                    html += '<li><a href="javascript:;" onclick="jsMenuChoice(\''+item.menu_url+'\');">'+item.menu_name+'</a></li>'
                });
                $("#menu_list").append(html);
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    }

    function jsPwdConfirm(){
        $.ajax({
            url: "<%=UserController.IS_PWD_MOD%>",
            data: null,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (data) {
                if(data.resultCode == <%=ResultType.SUCCESS%>){
                    var cookie = getCookie('iqosPasswordPopup');
                    if(cookie==null) {
                        $(".password_alarm_popup").show();
                        $(".password_alarm_popup").css("display", "block");
                    }
                }
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    }

    function jsMenuChoice(menu_url) {
        location.href = menu_url;
    }

    function jsUserModForm(no_user) {
        setTodayCookie('iqosPasswordPopup', true);
        var form = document.createElement("form");
        var parm = new Array();
        var input = new Array();

        form.action = "<%=UserController.USER_MOD_FORM%>";
        form.method = "post";


        parm.push( ['no_user', no_user] );

        input[0] = document.createElement("input");
        input[0].setAttribute("type", "hidden");
        input[0].setAttribute('name', parm[0][0]);
        input[0].setAttribute("value", parm[0][1]);
        form.appendChild(input[0]);

        document.body.appendChild(form);
        form.submit();
    }

    function jsClosePasswordModal() {
        setTodayCookie('iqosPasswordPopup', true);
        $('.password_alarm_popup').fadeOut(300);
    }

    function setTodayCookie(name, value) {
        var date = new Date();
        date.setHours(0,0,0,0);
        date.setDate(date.getDate() + 1);
        document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
    }

    function getCookie(name) {
         var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
         return value ? value[2] : null;
    }

</script>
<div class="top_header">
    <div class="top_header_inner">
        <div class="logo_wrap">
            <h1><a href="/"><img src="${imagePath}/layout/logo.png" alt="아이코스 관리자"></a></h1>
            <h1>아이코스 관리</h1>
        </div>
        <div class="util_menu_wrap">
            <div class="admin_menu_wrap">
                <h4>${sessionScope.userInfo.user_name}님 (${sessionScope.userInfo.login_id})</h4>
                <div class="admin_menu">
                    <ul>
                        <li><a href="javascript:;" onclick="jsUserModForm('${sessionScope.userInfo.no_user}')">운영자 정보</a></li><!-- TODO: 전체관리자만 운영자 정보 표시 -->
                        <li><a href="<%=UserController.LOGOUT%>">로그아웃</a></li>
                    </ul>
                </div>
            </div>
            <div class="util_menu">
                <nav>
                    <ul>
                        <li><a href="/main">아이코스 맵</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="bottom_header">
    <div class="bottom_header_inner">
        <div class="gnb">
            <nav>
                <ul id="menu_list">
                </ul>
            </nav>
        </div>
    </div>
</div>

<%-- 로그 --%>
<div class="password_alarm_popup modal" style="display: none;">
    <div class="setting_wrap">
        <div class="common_title_wrap">
            <div class="title_wrap">
                <h2>비밀번호 변경</h2>
            </div>
            <div class="close_btn" onclick="jsCloseModal('parking');"></div>
        </div>

        <div class="scroll_wrap">
            <div class="all_list list allmode">
                <p>비밀번호를 90일 동안 변경하지 않으셨습니다.<br/>
                개인정보를 보호하기 위해 비밀번호를 변경하세요.
                </p>
            </div>
        </div>
        <div class="btn_wrap">
            <div class="button_90">
                <button class="download_btn" onclick="jsUserModForm('${sessionScope.userInfo.no_user}')">변경하러 가기</button>
            </div>
            <div class="button_90">
                <button class="delete_btn" onclick="jsClosePasswordModal();">닫기</button>
            </div>
        </div>
    </div>
</div>