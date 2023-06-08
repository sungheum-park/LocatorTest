<%--
  Created by IntelliJ IDEA.
  User: MSYNC-CMH
  Date: 2019-10-14
  Time: 오후 4:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>
<%@include file="/WEB-INF/views/module/main/faqJs.jsp"%>
<script src="${jsPath}/faq.js?v=${updateTimeCss}"></script>

<html>
<body>
<main id="main">
    <section class="faq_wrap">
        <div class="inner inner768">
            <div class="section_title size-1">
                <h2>아이코스</h2>
                <h2>자주 묻는 질문.</h2>
            </div>
            <form name="searchForm" id="searchForm" onsubmit="return false;" method="post">
                <input type="hidden" name="page">
                <input type="hidden" name="perPageNum" value="10">
                <input type="hidden" name="no_item" id="no_item">


                <!-- FAQ 검색 영역 -->
                <div class="search_wrap">
                    <input type="text" placeholder="궁금한 내용을 검색해 보세요." name="wordSearch" onkeydown="jsEnter();" value="${FaqVO.getWordSearch()}">
                    <span class="search_btn" onclick="faqSearch();"></span>
                </div>
                <!-- FAQ 검색 영역 -->

                <!-- FAQ 질문 카테고리 영역 -->
                <div class="content_wrap">
                    <div class="faq_menu">
                        <ul>
                            <c:forEach var="item" items="${faqItemList}" varStatus="status">
                                <li><a onclick="faqItem('${item.no_item}')">${item.item_name}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <!-- FAQ 질문 카테고리 영역 -->
            </form>
        </div>

        <!-- FAQ 리스트 영역 -->
        <div id="listArea" style="display:none"></div>
        <!-- FAQ 리스트 영역 -->
    </section>
</main>
</body>
</html>

<script>
    $(document).ready(function(){
        $('.m_gnb nav ul #faq_gnb, .gnb_wrap nav ul #faqGnb').addClass('on').siblings().removeClass('on');
    })
</script>