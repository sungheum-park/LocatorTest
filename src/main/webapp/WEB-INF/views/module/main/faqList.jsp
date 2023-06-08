<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>

<div class="content_wrap">

    <!-- FAQ 질문 리스트 영역-->
    <c:choose>
        <c:when test="${faqItem eq '검색 결과'}">
            <div class="search_content inner inner768">
        </c:when>
        <c:otherwise>
            <div class="menu_content inner inner768">
        </c:otherwise>
    </c:choose>
        <div class="content all_faq">
            <div class="faq_title">
                <h3>${faqItem}</h3>
                <c:if test="${faqItem eq '검색 결과'}">
                    <h3 class="result">${faqListCnt}건</h3>
                </c:if>
            </div>
            <c:forEach var="list" items="${faqList}" varStatus="status">
                <div class="faq_list">
                    <div class="question">
                        <h3>${list.faq_q}</h3>
                    </div>
                    <div class="answer">
                        <p>
                                ${list.faq_a}
                        </p>
                        <!-- FAQ 질문내용 중 안에 서브 내용 있는 경우 -->
                        <c:if test="${fn:length(list.faqItemSubList) > 0}">
                            <div class="important">
                                <div class="title">
                                    <h4>${list.faqItemSubList[0].faq_q}</h4>
                                </div>
                                <div class="info_wrap">
                                    <c:forEach var="subList" items="${list.faqItemSubList}">
                                        <span>${subList.faq_a}</span>
                                    </c:forEach>
                                </div>
                            </div>
                            <!-- FAQ 질문내용 중 안에 서브 내용 있는 경우 -->
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <!-- FAQ 질문 리스트 영역-->

    <!-- 페이징 영역 -->
    <div class="paging">
        <tg:paging pageInfoHolder="${pageMaker}"/>
    </div>
    <!-- 페이징 영역 -->

    <!-- 원하는 결과 없는 경우(faqList가 있던 없던 무조건 노출되야 함)-->
    <div class="no_result">
        <div class="inner inner768">
            <div class="contents">
                <div class="icon">
                    <img src="${imagePath}/faq/cs_icon.png" alt="아이코스 고객센터 아이콘">
                </div>
                <div class="noticeTxt">
                    <h5>
                        원하시는 정보가 없거나 불충분한 경우<br>
                        아이코스 고객센터로 접수 부탁드립니다.
                    </h5>
                    <span><a href="tel:080-000-1905">고객센터: 080-000-1905</a></span>
                </div>
            </div>
        </div>
    </div>
    <!-- 원하는 결과 없는 경우-->
</div>

<script>
    $(document).ready(function(){
        $('.important .title').on({
            click:function(){
                $(this).parents('.important').toggleClass('on');
                $(this).parents('.important').find('.info_wrap').slideToggle(200);
            }
        });
    })
</script>