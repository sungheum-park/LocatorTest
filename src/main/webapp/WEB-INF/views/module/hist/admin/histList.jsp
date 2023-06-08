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
<div class="result_btn_wrap clearfix hist_btn_wrap">
    <div class="left_btn button_90">
        <button class="delete_btn" onclick="jsHistView();">조회</button>
        <span class="notice ml0">비교 시, 최대 2개만 선택하여 조회할 수 있습니다.</span>
    </div>
</div>
<div class="grid_wrap">
    <form name="listForm" id="listForm" onsubmit="return false;" method="post">
    <table>
        <colgroup>
            <col style="width: 10%">
            <col style="width: 20%">
            <col style="width: 15%">
            <col style="width: 15%">
            <col style="width: 10%">
            <col style="width: 10%">
            <col style="width: 20%">
        </colgroup>
        <thead>
        <tr>
            <th class="check_area">
                <div class="check_wrap">
                    <input type="checkbox" class="blind" id="checkAll">
                    <label for="checkAll"></label>
                </div>
            </th>
            <th class="arrange <c:if test="${HistReqVO.order_column eq 'login_id' and HistReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${HistReqVO.order_column eq 'login_id' and HistReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'login_id');">로그인 아이디<span>목록정렬</span></th>
            <th class="arrange <c:if test="${HistReqVO.order_column eq 'user_name' and HistReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${HistReqVO.order_column eq 'user_name' and HistReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'user_name');">사용자명<span>목록정렬</span></th>
            <th class="arrange <c:if test="${HistReqVO.order_column eq 'user_grt' and HistReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${HistReqVO.order_column eq 'user_grt' and HistReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'user_grt');">사용자 권한<span>목록정렬</span></th>
            <th class="arrange <c:if test="${HistReqVO.order_column eq 'no_menu' and HistReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${HistReqVO.order_column eq 'no_menu' and HistReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'no_menu');">속성<span>목록정렬</span></th>
            <th class="arrange <c:if test="${HistReqVO.order_column eq 'action_status' and HistReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${HistReqVO.order_column eq 'action_status' and HistReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'action_status');">활동<span>목록정렬</span></th>
            <th class="arrange <c:if test="${HistReqVO.order_column eq 'action_time' and HistReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${HistReqVO.order_column eq 'action_time' and HistReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'action_time');">활동일시<span>목록정렬</span></th>
        </tr>
        </thead>
            <tbody>
                <c:forEach var="list" items="${histList}" varStatus="status">
                    <tr>
                        <td class="check_area">
                            <div class="check_wrap">
                                <input type="checkbox" class="blind" id="check_${status.count}" name="check_no_hist" value="${list.no_hist}">
                                <label for="check_${status.count}"></label>
                            </div>
                        </td>
                        <td class="medium">${list.login_id}</td>
                        <td class="medium">${list.user_name}</td>
                        <td class="medium">${ufn:getCodeName("user_grt", list.user_grt)}</td>
                        <td class="medium">${ufn:getCodeName("no_menu", list.no_menu)}<input type="hidden" name="action_status_${list.no_hist}" value="${list.no_menu}"></td>
                        <td class="medium">${ufn:getCodeName("action_status", list.action_status)}</td>
                        <td class="date"><fmt:parseDate value="${list.action_time}" var="fmt_action_time" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${fmt_action_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
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
