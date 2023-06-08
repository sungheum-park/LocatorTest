<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/WEB-INF/views/common/front/include.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <!-- PRD 만 검색가능하도록 수정 -->
    <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
    <c:if test="${profileId ne 'prd'}">
        <meta name="robots" content="noindex,nofollow">
    </c:if>

    <tiles:insertAttribute name ="meta" flush="true"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,400,500,700&display=swap&subset=korean" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${cssPath}/lib/swiper-4.5.0.min.css">
    <link rel="stylesheet" type="text/css" href="${cssPath}/lib/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="${cssPath}/reset.css">
    <link rel="stylesheet" type="text/css" href="${cssPath}/main.css?v=${updateTimeCss}">
    <link rel="stylesheet" type="text/css" href="${cssPath}/common.css?v=${updateTimeCss}">
    <link rel="stylesheet" type="text/css" href="${cssPath}/common2.css?v=${updateTimeCss}">
    <link rel="stylesheet" type="text/css" href="${cssPath}/tutorial.css?v=${updateTimeCss}">
    <link rel="stylesheet" type="text/css" href="${cssPath}/faq.css?v=${updateTimeCss}">
    <link rel="shortcut icon" type="image/x-icon" href="${imagePath}/favicon.ico" />

    <script src="${jsPath}/lib/jquery-3.5.1.min.js"></script>
    <script src="${jsPath}/lib/jquery-easing-1.4.1.min.js"></script>
    <script src="${jsPath}/lib/isMobile.min.js"></script>
    <script src="${jsPath}/lib/TweenMax.min.js"></script>
    <script src="${jsPath}/lib/swiper-4.5.0.min.js"></script>
    <script src="${jsPath}/lib/Waypoint-4.0.1.min.js"></script>
    <script src="${jsPath}/common.js?v=${updateTimeCss}"></script>
    <script src="${jsPath}/iqosAnime.js?v=${updateTimeCss}"></script>

    <!-- PRD 만 노출 -->
    <c:if test="${profileId eq 'prd'}">
        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-145074034-1"></script>
        <script>
            window.dataLayer = [{
                environment: 'production',
                environmentVersion: '',
                page: {
                    attributes: {
                        country: 'KR',
                        currency: 'KRW',
                        language :'ko_KR'
                    }

                }
            }];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());

            gtag('config', 'UA-145074034-1', {'cookie_expires': 365 * 24 * 60 * 60});
        </script>

        <!-- Google Tag Manager -->
        <script>
            (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
            })(window,document,'script','dataLayer');
            (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
            })(window,document,'script','dataLayer','GTM-5M6VMJK');
            (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                    new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
            })(window,document,'script','dataLayer','GTM-KXSXVFZ');
        </script>
        <!-- End Google Tag Manager -->
    </c:if>

    <!-- Pixel Code 추가 (20.02.18) -->
    <c:if test='${mt_id ne null}'>
        <script language='JavaScript1.1' async src='//pixel.mathtag.com/event/js?mt_id=${mt_id}&mt_adid=235002&mt_exem=&mt_excl=&v1=&v2=&v3=&s1=&s2=&s3='></script>
    </c:if>
    <!-- Pixel Code 추가 -->

</head>
<body>
    <!-- PRD 만 노출 -->
    <c:if test="${profileId eq 'prd'}">
        <!-- Google Tag Manager (noscript) -->
        <noscript>
            <iframe src="https://www.googletagmanager.com/ns.html" height="0" width="0" style="display:none;visibility:hidden"></iframe>
            <iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5M6VMJK" height="0" width="0" style="display:none;visibility:hidden"></iframe>
            <iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KXSXVFZ" height="0" width="0" style="display:none;visibility:hidden"></iframe>
        </noscript>
        <!-- End Google Tag Manager (noscript) -->
    </c:if>

    <tiles:insertAttribute name ="header"/>

    <tiles:insertAttribute name ="content"/>

    <div class="ad_wrap">
        <div class="kakaotalk_popup">
            <div class="pop_pc">
                <div class="popup_top">
                    <div class="pop_title">
                        <p>카카오톡<br>상담</p>
                    </div>
                    <div class="pop_text">
                        <p>카카오톡 검색창에<br><strong>@아이코스<br>고객서비스센터</strong>를<br>검색해보세요!</p>
                    </div>
                </div>
                <div class="popup_bottom">
                    <div class="pop_des">
                        <p>24시간 1:1상담을<br>통해 친절히 상담해<br>드리겠습니다.</p>
                    </div>
                    <div class="link">
                        <a href="javascript:;" onclick="pageMove('https://pf.kakao.com/_VNLkj/chat')">상담하기</a>
                    </div>
                </div>
            </div>
            <div class="pop_mo">
                <div class="pop_circle" onclick="pageMove('https://pf.kakao.com/_VNLkj/chat')">
                    <div class="_img_wrap">
                        <img src="${imagePath}/kakaotalk_c.png" alt="카카오톡 상담">
                    </div>
                    <p>카톡상담</p>
                </div>
            </div>
        </div>
    </div>
    <div class="btn_top_wrap">
        <div class="btn_top">
            <a href="javascript:;">Top</a>
        </div>
    </div>

    <footer id="footer">
        <tiles:insertAttribute name ="footer"/>
    </footer>
</body>
</html>
