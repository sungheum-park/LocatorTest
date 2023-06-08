<%@ page import="kr.co.msync.web.module.color.ColorController" %>
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

    function jsColorSnoExcg(){
        $('.color_excg_popup').show();

        $.ajax({
            url: "<%=ColorController.COLOR_SNO_EXCG_LIST%>",
            data: null,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $(".color_excg_popup").css("display", "block");
                $(".color_excg_popup").html(result);
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    }

</script>
<div class="result_btn_wrap multi_btn clearfix">
    <div class="left_btn button_90">
        <button class="delete_btn" onclick="jsDel();">선택삭제</button>
    </div>
    <div class="left_btn button_90">
        <button class="delete_btn" onclick="jsColorSnoExcg();">순서변경</button>
    </div>
    <div class="right_btn button_90">
        <button class="download_btn" onclick="jsExcelDown();">엑셀 다운로드</button>
    </div>
</div>
<div class="grid_wrap">
    <form name="listForm" id="listForm" onsubmit="return false;" method="post">
    <table>
        <colgroup>
            <col>
            <col>
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
            <th class="arrange <c:if test="${ColorReqVO.order_column eq 'color_name' and ColorReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${ColorReqVO.order_column eq 'color_name' and ColorReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'color_name');">색상명<span>목록정렬</span></th>
            <th class="arrange <c:if test="${ColorReqVO.order_column eq 'color_rgb' and ColorReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${ColorReqVO.order_column eq 'color_rgb' and ColorReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'color_rgb');">색상<span>목록정렬</span></th>
            <th class="arrange <c:if test="${ColorReqVO.order_column eq 'use_yn' and ColorReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${ColorReqVO.order_column eq 'use_yn' and ColorReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'use_yn');">사용여부<span>목록정렬</span></th>
            <th class="arrange <c:if test="${ColorReqVO.order_column eq 'del_yn' and ColorReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${ColorReqVO.order_column eq 'del_yn' and ColorReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'del_yn');">삭제여부<span>목록정렬</span></th>
            <th class="arrange <c:if test="${ColorReqVO.order_column eq 'reg_date' and ColorReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${ColorReqVO.order_column eq 'reg_date' and ColorReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'reg_date');">등록일<span>목록정렬</span></th>
            <th class="arrange <c:if test="${ColorReqVO.order_column eq 'mod_date' and ColorReqVO.order_type eq 'asc'}">btnOn btnOnTop</c:if><c:if test="${ColorReqVO.order_column eq 'mod_date' and ColorReqVO.order_type eq 'desc'}">btnOn</c:if>" onclick="jsSort(this,'mod_date');">수정일<span>목록정렬</span></th>
            <th class="arrange">수정</th>
        </tr>
        </thead>
            <tbody>
                <c:forEach var="list" items="${colorList}" varStatus="status">
                    <tr>
                        <td class="check_area">
                            <div class="check_wrap">
                                <input type="checkbox" class="blind" id="check_sno_${status.count}" name="del_no_color" value="${list.no_color}">
                                <label for="check_sno_${status.count}"></label>
                            </div>
                        </td>
                        <td class="medium">${list.color_name}</td>
                        <td class="medium">
                            <div class="td_inner_2">
                                <div class="color_name in-block">${list.color_rgb}</div>
                                <div class="color_chip ml5" style="background-color:${list.color_rgb}"></div>
                            </div>
                        </td>
                        <td class="medium">${ufn:getCodeName("use_yn", list.use_yn)}</td>
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
                                <button type="button" onclick="jsModForm('${list.no_color}')">수정</button>
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
