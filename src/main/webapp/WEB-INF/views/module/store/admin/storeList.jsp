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
<div class="result_btn_wrap clearfix">
    <div class="left_btn button_90">
        <button class="delete_btn" onclick="jsDel();">선택삭제</button>
    </div>
    <div class="right_btn button_90">
        <button class="download_btn" onclick="jsExcelDown();">엑셀 다운로드</button>
    </div>
</div>
<div class="grid_wrap">
    <form name="listForm" id="listForm" onsubmit="return false;" method="post">
    <table>
        <colgroup>
            <col style="width: 30px">
            <col style="width: 100px">
            <col style="width: 100px">
            <col>
            <col>
            <col style="width: 100px">
            <col style="width: 100px">
            <col style="width: 100px">
            <col style="width: 100px">
            <col style="width: 100px">
        </colgroup>
        <thead>
        <tr>
            <th class="check_area">
                <div class="check_wrap">
                    <input type="checkbox" class="blind" id="checkAll">
                    <label for="checkAll"></label>
                </div>
            </th>
            <th class="arrange <c:if test="${StoreReqVO.order_column eq 'store_code' and StoreReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${StoreReqVO.order_column eq 'store_code' and StoreReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'store_code');">매장코드<span>목록정렬</span></th>
            <th class="arrange <c:if test="${StoreReqVO.order_column eq 'store_type' and StoreReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${StoreReqVO.order_column eq 'store_type' and StoreReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'store_type');">매장타입<span>목록정렬</span></th>
            <th class="arrange <c:if test="${StoreReqVO.order_column eq 'store_name' and StoreReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${StoreReqVO.order_column eq 'store_name' and StoreReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'store_name');">매장명<span>목록정렬</span></th>
            <th class="arrange <c:if test="${StoreReqVO.order_column eq 'store_total_addr' and StoreReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${StoreReqVO.order_column eq 'store_total_addr' and StoreReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'store_total_addr');">주소<span>목록정렬</span></th>
            <th class="arrange <c:if test="${StoreReqVO.order_column eq 'store_status' and StoreReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${StoreReqVO.order_column eq 'store_status' and StoreReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'store_status');">상태<span>목록정렬</span></th>
            <th class="arrange <c:if test="${StoreReqVO.order_column eq 'reg_date' and StoreReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${StoreReqVO.order_column eq 'reg_date' and StoreReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'reg_date');">등록일<span>목록정렬</span></th>
            <th class="arrange <c:if test="${StoreReqVO.order_column eq 'mod_date' and StoreReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${StoreReqVO.order_column eq 'mod_date' and StoreReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'mod_date');">수정일<span>목록정렬</span></th>
            <th class="arrange">복사</th>
            <th class="arrange">수정</th>
        </tr>
        </thead>
            <tbody>
                <c:forEach var="list" items="${storeList}" varStatus="status">
                    <tr>
                        <td class="check_area">
                            <div class="check_wrap">
                                <input type="checkbox" class="blind" id="check_${status.count}" name="del_store_code" value="${list.store_code}">
                                <label for="check_${status.count}"></label>
                            </div>
                        </td>
                        <td>${list.store_code}</td>
                        <td class="medium">${ufn:getCodeName('store_type', list.store_type)}</td>
                        <td class="medium">${list.store_name}</td>
                        <td style="text-align:left; padding-left:10px">${list.store_total_addr}</td>
                        <td class="medium">${ufn:getCodeName('store_status', list.store_status)}</td>
                        <td class="date"><fmt:parseDate value="${list.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td class="date"><fmt:parseDate value="${list.mod_date}" var="fmt_mod_date" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${fmt_mod_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td>
                            <c:if test="${list.del_yn eq 'N'}">
                                <div class="modify_btn">
                                    <button type="button" onclick="jsCopyRegForm('${list.store_code}')">복사</button>
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${list.del_yn eq 'N'}">
                            <div class="modify_btn">
                                <button type="button" onclick="jsModForm('${list.store_code}')">수정</button>
                            </div>
                            </c:if>
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
