<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes">
<meta name="format-detection" content="telephone=no">
<meta name="author" content="아이코스 온라인 서비스센터, IQOS">
<meta name="Title" content="아이코스 온라인 서비스센터, IQOS">
<meta name="description" content="아이코스 온라인 서비스센터, IQOS">
<meta name="Keywords" content="아이코스, IQOS, 사용법, 아이코스3, 아이코스3 사용법, 아이코스3 충전, 아이코스3 청소, 아이코스 멀티, 아이코스3 멀티, 아이코스 멀티 사용법, 아이코스 멀티 충전, 아이코스 멀티 청소, 아이코스2.4, 아이코스2, 아이코스 2.4 플러스">
<title>아이코스 온라인 서비스센터 - 자주 묻는 질문 ㅣ IQOS</title>
<meta property="og:url" content="<spring:eval expression="@config['site.url']"/><%=MainController.FAQ%>">
<meta property="og:image" content="<spring:eval expression="@config['share.kakao.image']"/>">
<meta property="og:type" content="website">
<meta property="og:title" content="아이코스 자주 묻는 질문 ㅣ IQOS ">
<meta property="og:description" content="아이코스 자주 묻는 질문을 알아보세요.">
<meta property="og:locale" content="ko_KR">
<meta property="og:site_name" content="아이코스 온라인 서비스센터 - 자주 묻는 질문 ㅣ IQOS ">
<meta property="og:site_name" content="아이코스 온라인 서비스센터 - 서비스센터 찾기 ㅣ IQOS">
<link rel="canonical" href="<spring:eval expression="@config['site.url']"/><%=MainController.FAQ%>">
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