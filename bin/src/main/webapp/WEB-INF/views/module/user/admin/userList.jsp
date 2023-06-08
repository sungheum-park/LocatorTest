<%@ page import="kr.co.msync.web.module.common.type.YesNoType" %>
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
<div class="result_btn_wrap clearfix all_list_mod">
    <c:if test="${sessionScope.userInfo.user_grt eq '01' or sessionScope.userInfo.user_grt eq '02'}">
    <div class="left_btn button_90">
        <button class="delete_btn" onclick="jsApproved();">승인</button>
    </div>
    <div class="left_btn button_90">
        <button class="delete_btn" onclick="jsDenied();">반려</button>
    </div>
    </c:if>
    <c:if test="${sessionScope.userInfo.user_grt eq '01'}">
    <div class="left_btn button_90">
        <button class="delete_btn" onclick="jsDel();">선택삭제</button>
    </div>
    </c:if>
    <%--<div class="right_btn button_90">--%>
        <%--<button class="download_btn" onclick="jsExcelDown();">엑셀 다운로드</button>--%>
    <%--</div>--%>
</div>
<div class="grid_wrap">
    <form name="listForm" id="listForm" onsubmit="return false;" method="post">
    <table>
        <colgroup>
            <col>
            <col style="width: 100px">
            <col>
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
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'no_user' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'no_user' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'no_user');">운영자 번호<span>목록정렬</span></th>
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'user_name' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'user_name' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'user_name');">운영자명<span>목록정렬</span></th>
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'login_id' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'login_id' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'login_id');">로그인 아이디<span>목록정렬</span></th>
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'user_company' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'user_company' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'user_company');">회사명<span>목록정렬</span></th>
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'user_grt' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'user_grt' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'user_grt');">운영자 권한<span>목록정렬</span></th>
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'user_channel' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'user_channel' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'user_channel');">관리채널<span>목록정렬</span></th>
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'user_status' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'user_status' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'user_status');">사용자 상태<span>목록정렬</span></th>
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'del_yn' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'del_yn' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'del_yn');">삭제여부<span>목록정렬</span></th>
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'reg_date' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'reg_date' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'reg_date');">등록일<span>목록정렬</span></th>
            <th class="arrange <c:if test="${UserReqVO.order_column eq 'mod_date' and UserReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${UserReqVO.order_column eq 'mod_date' and UserReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'mod_date');">수정일<span>목록정렬</span></th>
            <th class="arrange">수정</th>
        </tr>
        </thead>
            <tbody>
                <c:forEach var="list" items="${userList}" varStatus="status">
                    <tr>
                        <td class="check_area">
                            <div class="check_wrap">
                                <input type="checkbox" class="blind" id="check_${status.count}" name="check_no_user" value="${list.no_user}" value2="${list.user_status}">
                                <label for="check_${status.count}"></label>
                            </div>
                        </td>
                        <td class="medium">${list.no_user}</td>
                        <td class="medium">${list.user_name}</td>
                        <td class="medium">${list.login_id}</td>
                        <td class="medium">${ufn:getCodeName('user_company', list.user_company)}</td>
                        <td class="medium">${ufn:getCodeName('user_grt', list.user_grt)}</td>
                        <td class="medium">${ufn:getCodeNameArr('store_type', list.user_channel)}</td>
                        <td class="medium">${ufn:getCodeName('user_status', list.user_status)}</td>
                        <td class="medium">${ufn:getCodeName('del_yn', list.del_yn)}</td>
                        <td class="date"><fmt:parseDate value="${list.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td class="date"><fmt:parseDate value="${list.mod_date}" var="fmt_mod_date" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${fmt_mod_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td>
                            <c:if test="${(list.no_user eq sessionScope.userInfo.no_user or (sessionScope.userInfo.user_grt eq '01' and list.user_grt eq '03')) and list.del_yn eq 'N'}">
                            <div class="modify_btn">
                                <button type="button" onclick="jsModForm('${list.no_user}')">수정</button>
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
