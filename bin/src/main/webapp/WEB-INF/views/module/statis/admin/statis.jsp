<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.msync.web.module.statis.StatisController" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<script type="text/javascript">
    $(function () {
        /*goGoogleAnalytics();*/
    });

    function goGoogleAnalytics() {
		window.open('http://analytics.google.com', '_blank');
    }

</script>
<!-- ///공통 사이드메뉴 -->
<div class="side_menu_wrap">
    <ul>
        <li class="menu_title">
            <h2><a href="<%=StatisController.STATIS%>">통계 관리</a></h2>
            <ul>
                <li class="on"><h4><a href="<%=StatisController.STATIS%>">통계 리스트</a></h4></li>
            </ul>
        </li>
    </ul>
</div>

<!-- ///컨텐츠-->
<div class="contents">
    <div class="contents_now">
        <span>통계</span>
        <span>통계 관리</span>
        <span class="now_page">통계 조회</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>통계 조회</h2>
        </div>
    </div>

    <!-- 공통 검색폼 -->
    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3 style="display: inline-block; cursor: pointer;" onclick="goGoogleAnalytics();">통계 페이지로 이동</h3>
        </div>
    </div>

</div>