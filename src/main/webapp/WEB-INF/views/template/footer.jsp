<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/front/include.jsp"%>
<div class="inner inner1560">
    <div class="top_footer">
        <div class="notice">
            <p>아이코스와 타바코 스틱은 무해한 제품이 아니며 중독성이 있습니다.</p>
        </div>
        <div class="footer_cs clearfix">
            <div class="cs">
                <p>아이코스 고객서비스센터</p>
                <div class="txt">
                    <img src="${imagePath}/ico_tel.png" alt="tel">
                    <span>080-000-1905 <br/> (매일 오전9시 - 오후10시)</span>
                </div>
            </div>
            <div class="chat">
                <p>24시간 채팅 & 이메일 상담</p>
                <ul>
                    <li><img src="${imagePath}/ico_kakao_01.png" alt="kakao"><a href="https://pf.kakao.com/_VNLkj/chat" target="_blank">카카오톡 : ‘아이코스 고객서비스센터’ 검색</a></li>
                    <li><img src="${imagePath}/ico_livec.png" alt=""><a href="https://kr.iqos.com/" target="_blank">라이브챗 : kr.iqos.com 접속</a></li>
                    <li><img src="${imagePath}/ico_email.png" alt="">이메일 : contact.kr@iqos.com</li>
                    <%--<li><img src="${imagePath}/ico_fb.png" alt="facebook"><a href="https://www.facebook.com/iqos.kr" target="_blank">페이스북 : ‘아이코스 고객서비스센터’ 검색</a></li>--%>
                </ul>
            </div>
            <%--<div class="live">--%>
                <%--<ul>--%>
                    <%--<li><img src="${imagePath}/ico_livec.png" alt=""><a href="https://kr.iqos.com" target="_blank">라이브챗 : kr.iqos.com 접속</a></li>--%>
                    <%--<li><img src="${imagePath}/ico_email.png" alt="">이메일 : contact.kr@iqos.com</li>--%>
                <%--</ul>--%>
            <%--</div>--%>
            <div class="link">
                <p>바로가기</p>
                <ul>
                    <li><img src="${imagePath}/ico_iqos.png" alt="iqos"><a href="https://kr.iqos.com" target="_blank">아이코스 홈페이지</a></li>
                    <li><img src="${imagePath}/ico_pmi.png" alt="pmi"><a href="https://www.pmi.com" target="_blank">PMI.com</a></li>
                </ul>
            </div>
            <div class="noti">
                <p>법적 고지</p>
                <ul>
                    <li><a href="javascript:void(0);" id="edit-cookieconsent-settings">쿠키 기본 설정</a></li>
                    <li><a href="https://kr.iqos.com/privacy-policy" target="_blank">개인정보처리방침</a></li>
                </ul>
            </div>
        </div>
        <div class="footer_info">
            <h1 class="footer_logo"><a href="#"><img src="${imagePath}/iqos_footer_logo_121x32.png" alt="iqos"></a></h1>
            <p>법인명(상호) 한국필립모리스(주)</p>
            <button type="button" class="ft_info_more">사업정보 자세히보기</button>
            <div class="info">
                <p>
                    <span>(주)사업자등록번호 110-81-20980 <a href="http://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=1108120980" target="_blank">(사업자정보확인)</a> </span>
                    <span>주소: 서울특별시 영등포구 국제금융로 10, 25층 (여의도동, 원 아이에프씨)</span>
                </p>
                <p>
                    <span>통신판매업 신고: 제2017-서울영등포-0516호</span>
                    <span>대표자(성명) 백영재</span>
                    <span>E-MAIL : Contact.KR@IQOS.com</span>
                    <span>대표번호: 080-000-1905</span>
                </p>
            </div>
        </div>
    </div>
    <div class="bottom_footer">
        <div class="sns">
            <ul>
                <li><a href="https://www.youtube.com/channel/UC5XUM6ocFvcqpTghNO1FH4Q" target="_blank"><img src="${imagePath}/footer_youtube.png"></a></li>
                <%--<li><a href="https://www.facebook.com/iqos.kr" target="_blank"><img src="${imagePath}/footer_fb.png"></a></li>--%>
                <li><a href="https://pf.kakao.com/_VNLkj/chat" target="_blank"><img src="${imagePath}/footer_kakao.png"></a></li>
            </ul>
        </div>
        <div class="iqos">
            <%--<ul>--%>
                <%--<li><a href="#link">개인정보 처리방침</a></li>--%>
                <%--<li><a href="#link">이용약관</a></li>--%>
                <%--<li><a href="#link">회사정보</a></li>--%>
            <%--</ul>--%>
            <copyright>© 2020 Philip Morris Products SA<br class="b_hide"> All Rights Reserved.</copyright>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/template/cookieSection.jsp"%>
<script>
    $(document).ready(function(){
       $('header .header_inner .search_store.search_store_pc a').click(function(){
           pageMove('/main');
       })

        //footer more
        $('.ft_info_more').click(function(){
            $('.footer_info .info').slideToggle();
        });

    });

    //footer 사업정보 768px - show
    $(window).resize(function(){
        if($(window).width() > 768) {
            $('.footer_info .info').show();
        }
    });
    initFunc()
    function initFunc(){
        setCookie('iqosStoreLocator', true, 90);
    }
</script>