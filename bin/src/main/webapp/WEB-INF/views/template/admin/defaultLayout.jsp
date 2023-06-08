<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<!doctype html>
<div lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes">
        <meta name="format-detection" content="telephone=no">
        <title>IQOS - ADMIN</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,400,500,700&display=swap&subset=korean" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="${cssPath}/reset.css">
        <link rel="stylesheet" type="text/css" href="${cssPath}/common.css">
        <link rel="stylesheet" type="text/css" href="${cssPath}/lib/swiper-4.5.0.min.css">
        <link rel="stylesheet" type="text/css" href="${cssPath}/layout.css">
        <script src="${jsPath}/lib/jquery-3.5.1.min.js"></script>
        <script src="${jsPath}/lib/jquery-easing-1.4.1.min.js"></script>
        <script src="https://www.w3schools.com/lib/w3.js"></script>
        <script src="${jsPath}/layout.js"></script>
        <script src="${jsPath}/lib/swiper-4.5.0.min.js"></script>
        <script src="${jsPath}/lib/TweenMax.min.js"></script>
        <script src="${jsPath}/lib/EasePack.min.js"></script>
        <script src="${jsPath}/common.js"></script>
        <script src="${jsPath}/jquery.form.js"></script>
        <script src="${jsPath}/jquery.validate.js"></script>
        <script src="${jsPath}/jquery.tmpl.js"></script>
        <script src="${jsPath}/jquery-ui.js"></script>
    </head>

    <body>
        <!-- ///헤더  -->
        <header id="header">
            <tiles:insertAttribute name ="header"/>
        </header>

        <main id="main">
            <div class="main_inner">
                <!-- ///컨텐츠 -->
                <tiles:insertAttribute name ="section"/>
            </div>
        </main>

        <!-- ///푸터 -->
        <footer id="footer">
            <tiles:insertAttribute name ="footer"/>
        </footer>
    </body>

    <link rel="stylesheet" type="text/css" href="${cssPath}/lib/datepicker.min.css">
    <script src="${jsPath}/lib/datepicker.min.js"></script>
    <script src="${jsPath}/csDatepicker.js"></script>
    <script type="text/javascript">
        function jsImagePreview(o) {
            var src = $(o).find("img").attr("src");
            if(src=="") return;
            $('.common_image').show();
            $(".pdt_big_image img").attr('src','');
            $(".pdt_big_image img").attr("src",src);
        }
    </script>