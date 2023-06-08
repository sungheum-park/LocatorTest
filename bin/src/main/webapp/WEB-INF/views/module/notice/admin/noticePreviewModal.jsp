<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">

    function jsCloseModal() {
        $(".notice_preview_popup").fadeOut(300);
    }

</script>
<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>공지사항 미리보기</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal();"></div>
    </div>

    <c:if test="${vo.notice_div eq '01'}">
        <div class="pdt_big_image">
            <img src="${vo.file_path}${vo.save_name}" alt="">
        </div>
    </c:if>
    <c:if test="${vo.notice_div eq '02'}">
        <textarea class="notice_content" readonly="readonly">${vo.notice_contents}</textarea>
    </c:if>

</div>