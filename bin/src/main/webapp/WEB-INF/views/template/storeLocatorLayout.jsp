<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
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

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="author" content="아이코스 온라인 서비스센터, IQOS">
    <meta name="Title" content="아이코스 온라인 서비스센터, IQOS">
    <meta name="description" content="아이코스 온라인 서비스센터, IQOS">
    <meta name="Keywords" content="아이코스, IQOS, 아이코스 지도, 매장, 매장찾기, 서비스센터, 서비스센터 찾기, AS센터, 공식 아이코스 매장, 일렉트로마트 아이코스, 이마트 아이코스, 아이코스 편의점 교환, 아이코스3, 아이코스 멀티, 아이코스2.4, 아이코스2 아이코스 2.4 플러스">
    <title>아이코스 고객서비스센터 및 매장 찾기ㅣ IQOS</title>
    <meta property="og:url" content="<spring:eval expression="@config['site.url']"/>">
    <meta property="og:image" content="<spring:eval expression="@config['share.kakao.image']"/>">
    <meta property="og:type" content="website">
    <meta property="og:title" content="아이코스 고객서비스센터 및 매장 찾기ㅣ IQOS">
    <meta property="og:description" content="가까운 아이코스 서비스센터 찾아 보세요">
    <meta property="og:locale" content="ko_KR">
    <meta property="og:site_name" content="아이코스 온라인 서비스센터 - 서비스센터 찾기 ㅣ IQOS">
    <meta name="naver-site-verification" content="1c1bb5ed813089131182587bab868c94896a0ee1" />
    <link rel="canonical" href="<spring:eval expression="@config['site.url']"/><%=MainController.INDEX%>">
    <script type="application/ld+json">
        {
         "@context": "http://schema.org",
         "@type": "아이코스",
         "name": "아이코스 온라인 서비스센터",
         "url": "https://iqossvc.kr",
         "sameAs": [
           "https://www.facebook.com/iqos.kr",
           "https://pf.kakao.com/_VNLkj"
         ]
        }
    </script>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,400,500,700&display=swap&subset=korean" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="${cssPath}/lib/swiper-4.5.0.min.css">
    <link rel="stylesheet" type="text/css" href="${cssPath}/lib/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="${cssPath}/reset.css">
    <link rel="stylesheet" type="text/css" href="${cssPath}/main.css?v=${updateTimeCss}">
    <link rel="stylesheet" type="text/css" href="${cssPath}/findStore.css?v=${updateTimeCss}">
    <link rel="stylesheet" type="text/css" href="${cssPath}/iqos_popup.css?v=${updateTimeCss}">
    <link rel="stylesheet" type="text/css" href="${cssPath}/common.css?v=${updateTimeCss}">
    <link rel="shortcut icon" type="image/x-icon" href="${imagePath}/favicon.ico" />

    <script src="${jsPath}/lib/jquery-3.5.1.min.js"></script>
    <script src="${jsPath}/lib/jquery-easing-1.4.1.min.js"></script>
    <script src="${jsPath}/lib/jquery.tmpl.js"></script>
    <script src="${jsPath}/lib/isMobile.min.js"></script>
    <script src="${jsPath}/lib/TweenMax.min.js"></script>
    <script src="${jsPath}/lib/swiper-4.5.0.min.js"></script>
    <script src="${jsPath}/lib/perfect-scrollbar.js"></script>
    <script src="${jsPath}/lib/Waypoint-4.0.1.min.js"></script>
    <script src="${jsPath}/iqosAnime.js?v=${updateTimeCss}"></script>
    <script src="${jsPath}/findStore.js?v=${updateTimeCss}"></script>
    <script src="${jsPath}/iqosPopup.js?v=${updateTimeCss}"></script>
    <script src="${jsPath}/common.js?v=${updateTimeCss}"></script>
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
    <%@ include file="/WEB-INF/views/template/cookieSection.jsp"%>
</body>
<tiles:insertAttribute name="module" />
</html>
