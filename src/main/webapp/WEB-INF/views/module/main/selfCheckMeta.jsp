<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes">
<meta name="format-detection" content="telephone=no">
<meta name="author" content="아이코스 온라인 서비스센터, IQOS">
<meta name="Title" content="아이코스 온라인 자가진단 | IQOS">
<meta name="description" content="아이코스 온라인 서비스 페이지에서 고객님께서 겪고 계신 기기 이상 문제를 온라인 자가진단으로 빠르고 편리하게 진단 받아 보세요. ">
<meta name="Keywords" content="아이코스, IQOS, 자가진단, 고객센터, 고객서비스, 고객 서비스 센터, 아이코스3, 아이코스 멀티, 아이코스2.4, 아이코스2 아이코스 2.4 플러스, 아이코스 교환, AS, AS기간, 보증기간, 아이코스 수리, 아이코스 불량, 아이코스 파손">
<title>아이코스 온라인 서비스센터 - 자가진단 ㅣ IQOS</title>
<meta property="og:url" content="<spring:eval expression="@config['site.url']"/><%=MainController.SELF_CHECK%>">
<meta property="og:image" content="<spring:eval expression="@config['site.url']"/><spring:eval expression="@config['front.image.path']"/>/self_check/self_check_step_01.jpg">
<meta property="og:type" content="website">
<meta property="og:title" content="아이코스 온라인 자가진단 | IQOS">
<meta property="og:description" content="아이코스 온라인 서비스 페이지에서 고객님께서 겪고 계신 기기 이상 문제를 온라인 자가진단으로 빠르고 편리하게 진단 받아 보세요.">
<meta property="og:locale" content="ko_KR">
<meta property="og:site_name" content="아이코스 온라인 서비스센터 - 자가진단 ㅣ IQOS ">
<meta property="og:site_name" content="아이코스 온라인 서비스센터 - 서비스센터 찾기 ㅣ IQOS">
<link rel="canonical" href="<spring:eval expression="@config['site.url']"/><%=MainController.SELF_CHECK%>">
<%--SNS 채널 노출 추가--%>
<script type="application/ld+json">
{
 "@context": "http://schema.org",
 "@type": "아이코스",
 "name": "아이코스 온라인 서비스센터",
 "url": "https://iqossvc.kr",
 "sameAs": [
   "https://www.facebook.com/iqos.kr",
   "https://pf.kakao.com/_VNLkj"
 ]
}
</script>
<!-- PRD 만 검색가능하도록 수정 -->
<spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
<c:if test="${profileId ne 'prd'}">
    <meta name="robots" content="noindex,nofollow">
</c:if>