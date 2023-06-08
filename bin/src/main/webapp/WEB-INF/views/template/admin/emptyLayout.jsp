<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<tiles:insertAttribute name="page"/>
<%--<link rel="stylesheet" type="text/css" href="${cssPath}/lib/datepicker.min.css">
<script src="${jsPath}/lib/datepicker.min.js"></script>
<script src="${jsPath}/csDatepicker.js"></script>--%>
<script type="text/javascript">
jsCheckAll("#listForm");
</script>
