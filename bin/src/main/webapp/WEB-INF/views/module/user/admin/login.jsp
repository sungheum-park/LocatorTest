<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.co.msync.web.module.user.UserController" %>
<%@ page import="kr.co.msync.web.module.util.SessionUtil" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<body>
<main id="main">
    <div class="login">
        <div class="title">
            <span>아이코스 매장찾기 관리자</span>
        </div>
        <div class="login_wrap">
            <div class="title">
                <h1>로그인이<br> 필요한 서비스입니다.</h1>
            </div>
            <form id="form" class="m-t" role="form" action="${pageContext.request.contextPath}<%=UserController.LOGIN_ACTION%>" method="post">
            <div class="input_wrap">
                <input type="text" id="login_id" name="login_id" class="form-control" autocomplete=off placeholder="아이디" onkeypress="jsEnter(event.keyCode)">
                <input type="password" id="password" name="password" class="form-control" autocomplete=off placeholder="비밀번호" onkeypress="jsEnter(event.keyCode)">
            </div>
            <div class="login_btn">
                <a href="javascript:;" onclick="jsValidate();">로그인</a>
            </div>
            </form>
        </div>
        <div class="logo">
            <h2>
                <img src="${imagePath}/layout/iqos_logo_g.png" alt="아이코스 로고">
            </h2>
            <div class="copyright">
                <p>© 2018 Philip Morris Products SA All Rights Reserved.</p>
            </div>
        </div>
    </div>
</main>
</body>

<script type="text/javascript">
    $(document).ready(function() {
        <c:if test="${not empty sessionScope.alertMsg}">
        alert("${sessionScope.alertMsg}");
        <%SessionUtil.removeSession("alertMsg");%>
        </c:if>
        $("#login_id").focus();
    });

    function jsEnter(keyCode) {
        if (keyCode == 13) {
            jsValidate();
        }
    }

    function jsValidate() {
        document.getElementById('form').submit();
    }
</script>