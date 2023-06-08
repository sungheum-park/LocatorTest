<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/front/include.jsp"%>
<%--<link rel="stylesheet" href="${cssPath}/theme.css?v=${updateTimeCss}" type="text/css">--%>
<script>
    function pageMove(page){
        location.href = page;
    }

   /* $(document).ready(function(){
        var overLayFlag = getCookie('iqosStoreLocator');
        if(overLayFlag == null){
            $('#overlay').css('display', 'flex');
        }else{
            initFunc();
        }
    })*/
    $(document).ready(function(){
        var overLayFlag = getCookie('iqosStoreLocator');
        if(overLayFlag == null){
            $('#ageModal').css('display', 'block');
        }else{
            initFunc();
        }
    });
</script>
<header id="header">
    <div class="header_inner">
        <div class="search_store search_store_pc">
            <a href="<spring:eval expression="@config['site.url']"/><%=MainController.INDEX%>">서비스센터 찾기</a>
        </div>
        <div class="search_store search_store_m">
            <a href="javascript:;" onclick="location.pathname != '/' ? pageMove('/') : '';">서비스센터 찾기</a>
        </div>
        <div class="logo" onclick="pageMove('/')"><img src="${imagePath}/logo.png" alt="로고"></div>
        <div class="gnb_wrap search_box">
            <div class="mobile_menu">
                <a href="#">
                    <span></span>
                    <span></span>
                </a>
            </div>
            <nav class="search_tab">
                <ul class="clearfix">
                    <%--<li id="tutorialGnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.DEVICE_TUTORIAL%>">기기 사용법</a></li>
                    <li id="carePlusGnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.CARE_PLUS%>">케어플러스</a></li>--%>
                    <%-- <li id="selfCheckGnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.SELF_CHECK%>">자가진단</a></li>--%>
                    <%--<li id="termGnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.SERVICE_TERMS%>">서비스 정책</a></li>--%>
                    <%--<li id="faqGnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.FAQ%>">자주 묻는 질문</a></li>--%>
                    <li id="tutorialGnb"><a href="https://kr.iqos.com/support/guide/iqos/iluma-prime" target="_blank">기기 사용법</a></li>
                    <li id="carePlusGnb"><a href="https://kr.iqos.com/support/careplus" target="_blank">고객지원 서비스</a></li>
                    <li id="termGnb"><a href="https://kr.iqos.com/support/faq/iluma-warrenty-and-service" target="_blank">서비스 정책</a></li>
                    <li id="faqGnb"><a href="https://kr.iqos.com/support/faq/iluma" target="_blank">자주 묻는 질문</a></li>
                    <li><a href="https://kr.iqos.com" target="_blank">아이코스 홈페이지</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>

<div class="mobile_gnb">
    <div class="mobile_gnb_inner">
        <div class="m_gnb add_m_gnb">
            <a href="#" class="m-menu-close"><img src="${imagePath}/m-menu-close.png"></a>
            <nav>
                <ul>
                    <%--<li id="find_store_gnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.INDEX%>">서비스센터 찾기</a></li>
                    <li id="tutorial_gnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.DEVICE_TUTORIAL%>">기기 사용법</a></li>
                    <li id="care_plus"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.CARE_PLUS%>">케어플러스</a></li>--%>
<%--                    <li id="self_chk_gnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.SELF_CHECK%>">자가진단</a></li>--%>
<%--                    <li id="faq_gnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.FAQ%>">자주 묻는 질문</a></li>--%>
                    <li id="tutorialGnb"><a href="https://kr.iqos.com/support/guide/iqos/iluma-prime" target="_blank">기기 사용법</a></li>
                    <li id="carePlusGnb"><a href="https://kr.iqos.com/support/careplus" target="_blank">고객지원 서비스</a></li>
                    <li id="termGnb"><a href="https://kr.iqos.com/support/faq/iluma-warrenty-and-service" target="_blank">서비스 정책</a></li>
                    <li id="faqGnb"><a href="https://kr.iqos.com/support/faq/iluma" target="_blank">자주 묻는 질문</a></li>
                    <%--<li id="term_gnb"><a href="<spring:eval expression="@config['site.url']"/><%=MainController.SERVICE_TERMS%>">서비스 정책</a></li>--%>
                </ul>
            </nav>
        </div>
        <div class="m_gnb_util add_m_util">
            <div class="m_link">
                <p>바로가기</p>
                <ul>
                    <li><a href="https://kr.iqos.com" target="_blank">아이코스 홈페이지</a></li>
                    <li><a href="https://www.pmi.com" target="_blank">PMI.com</a></li>
                </ul>
            </div>
            <div class="m_sns clearfix">
                <ul>
                    <li><a href="https://www.youtube.com/channel/UC5XUM6ocFvcqpTghNO1FH4Q" target="_blank"><img src="${imagePath}/m_gnb_youtube.png"></a></li>
                    <%--<li><a href="https://www.facebook.com/iqos.kr" target="_blank"><img src="${imagePath}/m_gnb_fb.png"></a></li>--%>
                    <li><a href="https://pf.kakao.com/_VNLkj/chat" target="_blank"><img src="${imagePath}/m_gnb_kakao.png"></a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="m-menu-bg"></div>

<%--<div id="overlay">
    <div class="text"><p>대한민국에 거주하는 만 19세 이상 흡연자입니까?</p></div>
    <div class="btn">
        <div class="no"><a href="javascript:;">아니오</a></div>
        <div class="yes"><a href="javascript:;" onclick="initFunc()">네</a></div>
    </div>
</div>--%>
<div id="ageModal" style="">
    <div class="content_sav">
        <div class="step_icon"><img src="${imagePath}/signature_iqos.png" alt=""></div>
        <div class="text_info">
            <p>귀하께서는 대한민국에 거주하는 만 19세 이상의<br>
                성인 흡연자 또는 니코틴 제품 사용자이십니까?<br>
                출생년도를 선택해주세요</p>
        </div>
        <div class="box_con">
            <div class="date_con  date_select">
                <div class="date_box"><span class="selected_years">출생년도 선택*</span>
                    <ul class="date_list date_list_display" style="">
                        <li class="date_data default">출생년도 선택*${sysYear}</li>
                        <c:set var="now" value="<%=new java.util.Date()%>" />
                        <c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
                        <c:forEach var="i" begin="0" end="${sysYear-1900}">
                            <c:set var="yearOption" value="${2020-i}"></c:set>
                            <li class="date_data">${yearOption}</li>
                        </c:forEach>
                    </ul>
                </div>
                <script src="${jsPath}/age_chk.js?v=${updateTimeCss}"></script>
            </div>
            <div class="date_con btn_wrap1">
                <a href="#" class="btnHomeYearsOk">확인</a>
            </div>
        </div>
    </div>
    <div class="age_low_modal">
        <div>
            <p>
                본 사이트는 대한민국에 거주하는<br>
                만 19세 이상의 성인 흡연자만<br>
                이용할 수 있습니다.
            </p>
        </div>
    </div>
</div>
<!-- 연령 체크 스크립트입니다. -->

