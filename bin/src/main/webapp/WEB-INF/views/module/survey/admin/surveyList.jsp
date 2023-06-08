<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<script type="text/javascript">
    $(function(){
        $(".search_result").html('검색 ${pageMaker.totalCount}개');
    });
</script>
<div class="grid_wrap">
    <form name="listForm" id="listForm" onsubmit="return false;" method="post">
    <table>
        <colgroup>
            <col style="width: 10%">
            <col style="width: 30%">
            <col style="width: 30%">
            <col style="width: 30%">
        </colgroup>
        <thead>
        <tr>
            <th class="arrange">NO</th>
            <th class="arrange <c:if test="${SurveyReqVO.order_column eq 'device_type' and SurveyReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${SurveyReqVO.order_column eq 'device_type' and SurveyReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'device_type');">기기타입<span>목록정렬</span></th>
            <th class="arrange <c:if test="${SurveyReqVO.order_column eq 'score' and SurveyReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${SurveyReqVO.order_column eq 'score' and SurveyReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'score');">점수<span>목록정렬</span></th>
            <th class="arrange <c:if test="${SurveyReqVO.order_column eq 'reg_date' and SurveyReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${SurveyReqVO.order_column eq 'reg_date' and SurveyReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'reg_date');">등록일<span>목록정렬</span></th>
        </tr>
        </thead>
            <tbody>
                <c:forEach var="list" items="${surveyList}" varStatus="status">
                    <tr>
                        <td class="medium">${((pageMaker.page-1)*pageMaker.perPageNum)+status.count}</td>
                        <td class="medium">${ufn:getCodeName("device_type", list.device_type)}</td>
                        <td class="medium">${list.score}</td>
                        <td class="date"><fmt:parseDate value="${list.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
    </table>
    </form>
</div>
<div class="page_wrap">
<tg:paging pageInfoHolder="${pageMaker}"/>
</div>
