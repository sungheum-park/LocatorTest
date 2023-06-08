<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes">
<meta name="format-detection" content="telephone=no">

<script language='JavaScript1.1' async src='//pixel.mathtag.com/event/js?mt_id=1464190&mt_adid=235002&mt_exem=&mt_excl=&v1=&v2=&v3=&s1=&s2=&s3='></script>

<script type="text/javascript">
    function faqMove(){
        //검색할 단어
        var searchText = $("#searchText").val();

        var frm = document.searchForm;
        frm.action = '<%=MainController.FAQ%>';
        $('#wordSearch').val(searchText);
        frm.submit();
    }


    function jsEnterMain() {
        if (window.event.keyCode == 13) {
            faqMove();
        }
    }
</script>

<html>
<body>
    <main id="main" class="visual">
        <section class="iqos_main">
            <div class="inner inner768">
                <div class="section_title size-1">
                    <!-- <h2><span>아이코스</span><br>서비스 정책 안내.</h2> -->
                    <h1>아이코스 온라인 서비스 센터</h1>
                    <h2>가까운 서비스센터 찾기</h2>
                    <h3 class="blind">아이코스 A/S 및 서비스 관련 문의는 가까운 서비스 센터를 통해 문의해보세요.</h3>
                </div>
                <div class="search_wrap">
                    <input type="text" placeholder="궁금한 내용을 검색해 보세요." id="searchText" onkeydown="jsEnterMain();">
                    <span class="search_btn" onclick="javascript:faqMove();" ></span>
                </div>
                <div class="menu_wrap">
                    <ul>
                        <li>
                            <a href="<spring:eval expression="@config['site.url']"/><%=MainController.INDEX%>">
                                <div class="icon">
                                    <img src="${imagePath}/service/icon_01.png" alt="서비스 센터 찾기 페이지로 이동">
                                </div>
                                <div class="link_tit navy">
                                    <h2>서비스 센터 찾기</h2>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="<spring:eval expression="@config['site.url']"/><%=MainController.DEVICE_TUTORIAL%>">
                                <div class="icon">
                                    <img src="${imagePath}/service/icon_02.png" alt="기기 사용법 페이지로 이동">
                                </div>
                                <div class="link_tit">
                                    <h2>기기 사용법</h2>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="<spring:eval expression="@config['site.url']"/><%=MainController.CARE_PLUS%>" >
                                <div class="icon">
                                    <img src="${imagePath}/service/icon_03.png" alt="케어 플러스 페이지로 이동">
                                </div>
                                <div class="link_tit">
                                    <h2>케어 플러스</h2>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="<spring:eval expression="@config['site.url']"/><%=MainController.SELF_CHECK%>">
                                <div class="icon">
                                    <img src="${imagePath}/service/icon_04.png" alt="자가 진단 페이지로 이동">
                                </div>
                                <div class="link_tit">
                                    <h2>자가 진단</h2>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="<spring:eval expression="@config['site.url']"/><%=MainController.FAQ%>">
                                <div class="icon">
                                    <img src="${imagePath}/service/icon_05.png" alt="자주 묻는 질문 페이지로 이동">
                                </div>
                                <div class="link_tit">
                                    <h2>자주 묻는 질문</h2>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="<spring:eval expression="@config['site.url']"/><%=MainController.SERVICE_TERMS%>">
                                <div class="icon">
                                    <img src="${imagePath}/service/icon_06.png" alt="서비스 정책 페이지로 이동">
                                </div>
                                <div class="link_tit">
                                    <h2>서비스 정책</h2>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="https://pf.kakao.com/_VNLkj/chat">
                                <div class="icon">
                                    <img src="${imagePath}/service/icon_07.png" alt="카카오 채팅 상담 페이지로 이동">
                                </div>
                                <div class="link_tit">
                                    <h2>카카오 채팅 상담</h2>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="https://kr.iqos.com/">
                                <div class="icon">
                                    <img src="${imagePath}/service/icon_08.png" alt="아이코스 홈페이지로 이동">
                                </div>
                                <div class="link_tit">
                                    <h2>아이코스 홈페이지</h2>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>           
            </div>
        </section>
    </main>

    <!-- 검색을 위한 폼 -->
    <form name="searchForm" id="searchForm" method="post">
        <input type="hidden" name="wordSearch" id="wordSearch">
    </form>
</body>
</html>
