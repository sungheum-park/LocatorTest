<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- Jstl Tag --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- Spring Tag --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- Jstl Tag 전역 변수 --%>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/admin/css"/>
<c:set var="imagePath" value="${pageContext.request.contextPath}/resources/admin/images"/>
<c:set var="jsPath" value="${pageContext.request.contextPath}/resources/admin/js"/>
<c:set var="samplePath" value="${pageContext.request.contextPath}/resources/admin/sample"/>