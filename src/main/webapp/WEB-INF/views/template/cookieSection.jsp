<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<link rel="stylesheet" type="text/css" href="/resources/front/css/cookie.css">

<%--쿠키 동의 팝업--%>
<div class="new_popup">
    <div class="bg"></div>
    <div class="js-cookie-consent-container cookie-consent__container" data-cookie-expiration="90" data-technical-cookie="opt-in" data-advertisement-cookie="opt-out">
        <div class="js-cookie-banner cookie-consent__banner">
            <div class="cookie-consent__msg js-cookie-msg">
                <div class="content-asset"><!-- dwMarker="content" dwContentID="c9d7ff76c0af8e55e0ed6ccc38" -->
                    <p>당사는 본 사이트 및 타 사이트에서의 당사의 광고, 콘텐트 및 커뮤니케이션에 대한 최적화된 경험 제공, 귀하의 선호사항을 기억, 사이트 운영 및 개선을 위하여 쿠키를 사용합니다. 계속해서 사이트를 이용하시고자 할 경우, 본 사이트의 쿠키 수신에 동의해 주세요. 당사에서 사용되는 쿠키에 대하여 더 알아보시거나 특정 쿠키를 비활성화 하고자 하실 경우  ‘더 알아보기＇ 버튼을 클릭하세요. 당사가 수집하는
                        개인정보는 당사의 <a href="https://kr.iqos.com/privacy-policy" target="_blank">개인정보 처리방침</a>에 의거하여 사용됩니다.</p>
                </div> <!-- End content-asset -->
            </div>
            <div class="cookie-consent__atc">
                <button class="cookie-consent__btn cookie-consent__btn--dark cookie-consent__btn--silent js-button-accept js-button-more-info" id="cookie-info">더 알아보기</button>
                <button class="cookie-consent__btn cookie-consent__btn--dark js-button-accept" id="accept-all-cookies" onClick="setCookieAgree('todayCookieAgree', 'done', 365);">동의하고 계속하기</button>
            </div>
        </div>
        <div class="js-cookie-settings cookie-consent__settings cookie-consent__settings--hidden">
            <div class="cookie-consent__tabs tabs">
                <nav role="navigation" class="js-cookie-tabs cookie-consent__tabs-nav">
                    <ul class="cookie-consent__tabs-links">
                        <li class="cookie-consent__tabs-link"><a href="#tab-1" class="active">필수 및 성능 쿠키</a></li>
                        <li class="cookie-consent__tabs-link"><a href="#tab-2" class="">성능 쿠키</a></li>
                        <li class="cookie-consent__tabs-link"><a href="#tab-3">분석및 맞춤 설정 쿠키</a></li>
                    </ul>
                </nav>

                <div class="cookie-consent__tab-container">
                    <div class="cookie-consent__tab active" id="tab-1">
                        <div class="cookie-consent__msg cookie-consent__msg--fixed">



                            <div class="content-asset"><!-- dwMarker="content" dwContentID="ef8bfcb5abb755c242bc7b7e42" -->

                                <h2>기능 쿠키</h2>

                                <p style="word-break: keep-all;">웹사이트가 제대로 기능하는데 반드시 필요한 쿠키 또는 고객이 선택한 기능을 편리한 방식으로 제공하기 위하여 필요한 쿠키</p>

                                <p>&nbsp;</p>

                                <table border="1" cellspacing="1" class="cookies_tbl">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center;" width="20%">cookie_id</th>
                                        <th style="text-align: center;" width="58%">목적</th>
                                        <th style="text-align: center;" width="20%">보유 기간</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td style="text-align: center;">iqosStoreLocator</td>
                                        <td style="word-break: keep-all;">19세 이상 여부를 판단하여 사이트 이용가능여부를 식별합니다.</td>
                                        <td style="text-align: center;">90일</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">JSESSIONID</td>
                                        <td style="word-break: keep-all;">현재 브라우징 중인 세션을 식별합니다.</td>
                                        <td style="text-align: center;">현재 세션</td>
                                    </tr>
                                    </tbody>
                                </table>

                                <p style="margin-top: 10px;">언제든지 기본 설정을 변경하려면 사이트 하단의 '쿠키 기본 설정'을 클릭하세요. 당사가 수집하는 개인정보는 당사의 <a href="https://kr.iqos.com/privacy-policy" target="_blank">'개인정보처리방침'</a>에 의거하여 사용됩니다.</p>


                            </div> <!-- End content-asset -->

                        </div>
                        <hr>
                        <button class="cookie-consent__btn cookie-consent__btn--dark js-save-cookie" onClick="setCookieAgree('todayCookieAgree', 'done', 365);">동의하고 계속하기</button>
                    </div>
                    <div class="cookie-consent__tab" id="tab-2">
                        <div class="cookie-consent__msg cookie-consent__msg--fixed">

                            <div class="content-asset"><!-- dwMarker="content" dwContentID="e15fa27278227783fb4f4e1cec" -->

                                <h2>성능 쿠키</h2>

                                <p style="word-break: keep-all;">방문자의 웹사이트 사용 방식에 대한 정보를 수집하여 사이트의 성능을 개선하는 데에 사용</p>

                                <p>&nbsp;</p>

                                <table border="1" cellspacing="1" class="cookies_tbl">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center;" width="20%">cookie_id</th>
                                        <th style="text-align: center;" width="60%">목적</th>
                                        <th style="text-align: center;" width="20%">보유 기간</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td style="text-align: center;">iqosStoreLocatorNotice</td>
                                        <td style="word-break: keep-all;">팝업의 다시 보지 않기에 대한 쿠키입니다.</td>
                                        <td style="text-align: center;">1일</td>
                                    </tr>
                                    </tbody>
                                </table>

                                <p>&nbsp;</p>

                                <p>&nbsp;</p>

                                <p style="word-break: keep-all;">언제든지 기본 설정을 변경하려면 사이트 하단의 ‘쿠키 기본 설정’을 클릭하세요. </p>
                                <p>당사가 수집하는 개인정보는 당사의 <a href="https://kr.iqos.com/privacy-policy" target="_blank">'개인정보 처리방침'</a>에 의거하여 사용됩니다.</p>

                                <p>&nbsp;</p>

                            </div> <!-- End content-asset -->

                        </div>
                        <label class="cookie-consent__cb-label">
                            <input type="checkbox" class="js-cookie-checkbox" name="dw_Technical_cookie" data-name="performance">
                            <span class="cookie-consent__cb-input"></span>
                            성능 쿠키
                        </label>
                        <hr>
                        <button class="cookie-consent__btn cookie-consent__btn--dark js-save-cookie" onClick="setCookieAgree('todayCookieAgree', 'done', 365);">동의하고 계속하기</button>
                    </div>
                    <div class="cookie-consent__tab" id="tab-3">
                        <div class="cookie-consent__msg cookie-consent__msg--fixed">

                            <div class="content-asset"><!-- dwMarker="content" dwContentID="d0b404d24e8728a1df981486fa" -->

                                <h2>분석및 맞춤 설정 쿠키</h2>

                                <p style="word-break: keep-all;">사용자 경험을 향상시키기 위해 사용자별 맞춤 서비스를 설정하는 데 도움이 되는 정보를 수집. 귀하의 사용자 경험을 바탕으로 본/타사이트의 방문시 귀하의 선호도 및 기기에 따른 맞춤 정보를 제공합니다. 이는 광고, 본 사이트에서의 맞춤 콘텐트 및 커뮤니케이션을 포함 합니다.</p>

                                <p>&nbsp;</p>

                                <table border="1" cellspacing="1" class="cookies_tbl">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center;" width="20%">cookie_id</th>
                                        <th style="text-align: center;" width="60%">목적</th>
                                        <th style="text-align: center;" width="20%">보유 기간</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td style="text-align: center;">_gid</td>
                                        <td style="word-break: keep-all;">방문자가 웹 사이트를 사용하는 방식에 대한 통계 데이터를 생성하는 데 사용되는 고유 ID를 등록합니다.</td>
                                        <td style="text-align: center;">1일</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">_ga</td>
                                        <td style="word-break: keep-all;">방문자가 웹 사이트를 사용하는 방식에 대한 통계 데이터를 생성하는 데 사용되는 고유 ID를 등록합니다.</td>
                                        <td style="text-align: center;">1년</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">_gat_UA-<br class="show_mo"/>69424936-18</td>
                                        <td style="word-break: keep-all;">요청 속도를 제한하기 위해 Google 애널리틱스에서 사용됩니다.</td>
                                        <td style="text-align: center;">1일</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">_gat_gtag_UA_<br class="show_mo"/>145074034_1</td>
                                        <td style="word-break: keep-all;">Google 애드센스에서 서비스를 사용하여 웹 사이트 전체에서 광고 효율성을 실험하는 데 사용됩니다.</td>
                                        <td style="text-align: center;">3개월</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">_gat_UA-*</td>
                                        <td style="word-break: keep-all;">요청 속도를 제한하는 데 사용됩니다.</td>
                                        <td style="text-align: center;">1분</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">_dc_gtm_UA-165852391-3</td>
                                        <td style="word-break: keep-all;">Google 태그 관리자가 Google 애널리틱스 스크립트 태그의 로딩을 제어하는 데 사용됩니다.</td>
                                        <td style="text-align: center;">1일</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">kppid_managed</td>
                                        <td style="word-break: keep-all;">이 쿠키는 방문자의 행동에 대한 정보를 수집하는 데 사용됩니다. 이 정보는 웹 사이트에서 내부 용으로 저장됩니다. 내부 분석은 웹 사이트를 최적화하거나 방문자가 뉴스 레터를 구독 한 경우 등록하는 데 사용됩니다.</td>
                                        <td style="text-align: center;">-</td>
                                    </tr>

                                    </tbody>
                                </table>

                                <p>&nbsp;</p>

                                <p>&nbsp;</p>

                                <p style="word-break: keep-all;">언제든지 기본 설정을 변경하려면 사이트 하단의 ‘쿠키 기본 설정’을 클릭하세요.</p>
                                <p>당사가 수집하는 개인정보는 당사의 <a href="https://kr.iqos.com/privacy-policy" target="_blank">'개인정보 처리방침'</a>에 의거하여 사용됩니다.</p>

                                <p>&nbsp;</p>

                            </div> <!-- End content-asset -->

                        </div>
                        <label class="cookie-consent__cb-label">
                            <input type="checkbox" class="js-cookie-checkbox" name="dw_Advertisement_cookie" data-name="advertising">
                            <span class="cookie-consent__cb-input"></span>
                            분석 및 맞춤 설정 쿠키
                        </label>
                        <hr>
                        <button class="cookie-consent__btn cookie-consent__btn--dark js-save-cookie" onClick="setCookieAgree('todayCookieAgree', 'done', 365);">동의하고 계속하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${jsPath}/lib/jquery.cookie.js"></script>
<script>
    $(document).ready(function(){
        //쿠키 동의 팝업 추가
        if($.cookie("todayCookieAgree")){
            $('.new_popup').hide();
        }

        $('.cookie-consent__tabs-links').on('click',function(){
            $(this).toggleClass('open');
        });

        $('.cookie-consent__tabs-links a').on('click',function(){
            var tab_id = $(this).attr('href');
            $('.cookie-consent__tabs-links li a').removeClass('active');
            $('.cookie-consent__tab').removeClass('active');
            $(this).addClass('active');
            $(tab_id).addClass('active');
        });

        $('#edit-cookieconsent-settings').on('click',function(){
            $('.new_popup').show();
        });

        $('#cookie-info, #edit-cookieconsent-settings').on('click',function(){
            $('.new_popup .bg').addClass('on');
            $('html,body').addClass('not_scroll');
            $('.cookie-consent__container').addClass('centerOn');
            $('.cookie-consent__banner').addClass('cookie-consent__banner--hidden');
            $('.cookie-consent__settings').removeClass('cookie-consent__settings--hidden');
        });

    });


    function closePopupSetCookie(cookieName){
        $.cookie(cookieName, true, {path: "/", expires: 1});

        var ModalNoDisLeng = 0;

        $("#noticePopup .popup_content").each(function(i){
            if($(this).css("display")!="none") {
                ModalNoDisLeng++;
            }
        });

        if(ModalNoDisLeng<=1) {
            $("#noticePopup").fadeOut(300);
        }
    }

    function setCookieAgree(name, value, expiredays) {
        var todayCookieAgree = new Date();
        todayCookieAgree.setDate(todayCookieAgree.getDate() + expiredays);
        document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayCookieAgree.toGMTString() + ";";

        $('html, body').removeClass('not_scroll');
        $('.new_popup').hide();
    }
</script>