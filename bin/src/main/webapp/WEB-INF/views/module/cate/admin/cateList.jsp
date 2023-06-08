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
            <col style="width: 100px">
            <col>
            <col style="width: 100px">
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
            <th class="arrange <c:if test="${CateReqVO.order_column eq 'cate_name' and CateReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${CateReqVO.order_column eq 'cate_name' and CateReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'cate_name');">상품 카테고리명<span>목록정렬</span></th>
            <th class="arrange <c:if test="${CateReqVO.order_column eq 'sell_yn' and CateReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${CateReqVO.order_column eq 'sell_yn' and CateReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'sell_yn');">판매여부<span>목록정렬</span></th>
            <th class="arrange <c:if test="${CateReqVO.order_column eq 'excg_yn' and CateReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${CateReqVO.order_column eq 'excg_yn' and CateReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'excg_yn');">교환여부<span>목록정렬</span></th>
            <th class="arrange <c:if test="${CateReqVO.order_column eq 'del_yn' and CateReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${CateReqVO.order_column eq 'del_yn' and CateReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'del_yn');">삭제여부<span>목록정렬</span></th>
            <th class="arrange <c:if test="${CateReqVO.order_column eq 'reg_date' and CateReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${CateReqVO.order_column eq 'reg_date' and CateReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'reg_date');">등록일<span>목록정렬</span></th>
            <th class="arrange <c:if test="${CateReqVO.order_column eq 'mod_date' and CateReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${CateReqVO.order_column eq 'mod_date' and CateReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'mod_date');">수정일<span>목록정렬</span></th>
            <th class="arrange">수정</th>
        </tr>
        </thead>
            <tbody>
                <c:forEach var="list" items="${cateList}" varStatus="status">
                    <tr>
                        <td class="check_area">
                            <div class="check_wrap">
                                <input type="checkbox" class="blind" id="check_${status.count}" name="del_no_cate" value="${list.no_cate}">
                                <label for="check_${status.count}"></label>
                            </div>
                        </td>
                        <td class="medium">${list.cate_name}</td>
                        <td class="medium">${ufn:getCodeName("sell_yn", list.sell_yn)}</td>
                        <td class="medium">${ufn:getCodeName("excg_yn", list.excg_yn)}</td>
                        <td class="medium">${ufn:getCodeName("del_yn", list.del_yn)}</td>
                        <td class="date"><fmt:parseDate value="${list.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td class="date"><fmt:parseDate value="${list.mod_date}" var="fmt_mod_date" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${fmt_mod_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td>
                            <c:if test="${list.del_yn eq 'N'}">
                            <div class="modify_btn">
                                <button type="button" onclick="jsModForm('${list.no_cate}')">수정</button>
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
