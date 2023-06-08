<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@config['api.kakao.authKey']" />"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<div class="mobile_change_tab clearfix">
    <div class="change_tab on"><a href="#" data-tab="searching" id="mobileSearch">서비스센터 검색</a></div>
    <div class="change_tab"><a href="#" data-tab="mapping" id="mobileMap" >지도</a></div>
</div>


<main id="main">
    <div class="search-area clearfix">
        <div class="search-inner">
            <button type="button" class="search-tag">목록형 </button>
            <button type="button" class="search-tag2">지도형 </button>
            <input type="text" id="moveSearchInput">
            <button type="submit" class="search-btn"></button>
        </div>
        <button type="button" class="local-search">지역 검색</button>
    </div>
    <div class="map_area add-map-area" id="map">
        <div class="m-filtering swiper-container">
            <div class="swiper-wrapper add-btn">
                <div class="swiper-slide"><a href="#" class="filter-link"><img src="${imagePath}/filter-link-2.svg">필터</a></div>
                <div class="swiper-slide" data-set="svc" data-val="018"><span>체험프로그램 가능처</span></div>
                <div class="swiper-slide" data-set="svc" data-val="017"><span>특별혜택 쿠폰 사용처</span></div>
                <div class="swiper-slide" data-set="svc" data-val="011"><span>친구추천 코드 사용</span></div>
                <div class="swiper-slide" data-set="svc" data-val="012"><span>보상판매 가능처</span></div>
                <div class="swiper-slide" data-set="svc" data-val="006"><span>직영매장</span></div>
                <div class="swiper-slide" data-set="sel" data-val="0000004"><span>아이코스 3 듀오</span></div>
            </div>
        </div>
        <a href="#" class="m-map-icon"><img src="${imagePath}/map-icon-2.svg"></a>
    </div>
    <div class="side_nav">
        <div class="panel main_panel">
            <div class="close_panel"></div>
            <div class="panel_inner scroll_area">
                <div class="near_store">
                    <h1>
                        <a href="#"><span>근처 서비스센터 바로보기</span></a>
                    </h1>
                </div>
                <div class="search_box">
                    <div class="search_tab" id="mainSearchTab">
                        <ul class="clearfix">
                            <li class="on"><a href="#">직접검색</a></li>
                            <li><a href="#">지역검색</a></li>
                            <%--<li><a href="#" data-type="road">길찾기</a></li>--%>
                        </ul>
                    </div>
                    <div class="search_wrap">
                        <div class="direct_search _search">
                            <input type="text" placeholder="주소/지하철/서비스센터명으로 검색" id="directSearchInput">
                            <button type="button" id="directSearchBtn" onclick="javascript:directSearch();"></button>
                            <div class="purpose">
                                <h4>목적별 검색</h4>
                                <ul class="purpose-list clearfix">
                                    <li data-set="svc" data-val="018"><a href="#">체험프로그램 가능처</a></li>
                                    <li data-set="svc" data-val="017"><a href="#">특별혜택 쿠폰 사용처</a></li>
                                    <li data-set="svc" data-val="011"><a href="#">친구추천 코드 사용</a></li>
                                    <li data-set="svc" data-val="012"><a href="#">보상판매 가능처</a></li>
                                    <li data-set="svc" data-val="006"><a href="#">직영매장</a></li>
                                    <li data-set="sel" data-val="0000004"><a href="#">아이코스 3 듀오</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="location_search _search">
                            <div class="step-1">
                                <div class="step">
                                    <h3>STEP 01 아래에서 시/도를 선택해주세요.</h3>
                                </div>
                                <div class="local_list_wrap">
                                    <ul>
                                        <c:forEach items="${regionList}" var="region">
                                            <li><a href ="#" onclick="javascript:getRegionList('${region.no_region}','${region.region_name}')">${region.region_name}</a></li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <div class="step-2">
                                <div class="step">
                                    <h3>STEP 02 아래에서 시/군/구를 선택해주세요.</h3>
                                </div>
                                <div class="sub_local_list_wrap scroll_area">
                                    <div class="title"><h2></h2></div>
                                    <ul></ul>
                                </div>
                            </div>
                        </div>
                        <div class="road_search _search">
                            <div class="start_point">
                                <h2>출발</h2>
                                <div class="direct_search load_input_wrap" >
                                    <input class="starting_input" type="text" placeholder="출발 위치를 검색해주세요" id="startPoint">
                                    <button class="starting_button" type="button" onclick="javascript:startPointSet();"></button>
                                    <button class="starting_mobile_button" type="button"><span>현재위치로 설정</span></button>
                                </div>
                                <h3>
                                    <a href="#" class="starting_button_a">현재위치로 설정</a>
                                    <p class="starting_mobile_notice">현재 위치를 설정해주세요</p>
                                </h3>
                            </div>
                            <div class="desti_point">
                                <h2>도착 서비스 센터</h2>
                                <div class="direct_search load_input_wrap" >
                                    <input type="text" id="endPoint" placeholder="도착 서비스 센터를 검색해주세요">
                                    <button type="button" onclick="javascript:endPointSet();"></button>
                                </div>
                            </div>
                            <div class="find_course">
                                <button><span>길찾기</span></button>
                            </div>
                            <div class="road_search_result">
                                <h3></h3>
                                <div class="result_wrap">
                                    <ul class="scroll_area">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="select_filter">
                    <div class="title clearfix">
                        <h4>필터 선택</h4>
                        <div class="btn_wrap clearfix">
                            <div class="btn">
                                <a href="#" class="apply">적용</a>
<%--                                <a href="#" class="application">적용</a>--%>
                            </div>
                            <div class="btn">
                                <a href="#" class="clear">초기화</a>
<%--                                <a href="#" class="reset">초기화</a>--%>
                            </div>
                        </div>
                    </div>
                    <div class="filter_list_wrap">
                        <div class="filter_list">
                            <h2>제공 서비스<div class="ico"><span></span><span></span></div></h2>
                            <div class="filter">
                                <p>*원하는 서비스 항목을 선택해주세요(중복 선택 가능)</p>
                                <div class="filter_inner service">
                                    <c:forEach var="item" items="${serviceList}" >
                                        <div class="filter_ckbox_wrap">
                                            <input type="checkbox" class="blind" name="serviceChk" id="service${item.no_service}" value="${item.no_service}">
                                            <label for="service${item.no_service}">${item.service_name}</label>
                                        </div>
                                    </c:forEach>
                                    <div class="filter_ckbox_wrap">
                                        <input type="checkbox" class="blind" name="serviceChk" id="service000" value="000">
                                        <label for="service000">주차여부</label>
                                    </div>
                                </div>
                            </div>
                        </div>
<%--                        <div class="filter_list">--%>
<%--                            <h2>판매기기 <div class="ico"><span></span><span></span></div></h2>--%>
<%--                            <div class="filter">--%>
<%--                                <div class="sell_eq filter_inner">--%>
<%--                                    <c:forEach var="item" items="${categoryList}" >--%>
<%--                                        <c:if test="${item.sell_yn eq 'Y'}">--%>
<%--                                            <div class="filter_ckbox_wrap">--%>

<%--                                                <input type="radio" class="blind add-radio" name="selChk" id="fill-sel${item.no_cate}" value="${item.no_cate}">--%>
<%--                                                <label for="fill-sel${item.no_cate}">--%>
<%--                                                    <img src="${item.file_path}${item.save_name}" alt="">--%>
<%--                                                    <span>${item.cate_name}</span>--%>
<%--                                                </label>--%>
<%--                                            </div>--%>
<%--                                        </c:if>--%>
<%--                                    </c:forEach>--%>
<%--                                    <div class="filter_ckbox_wrap">--%>
<%--                                        &lt;%&ndash;                                    <input type="radio" class="blind add-radio" name="selChk" id="fil-sel0000000" value="0000000">&ndash;%&gt;--%>
<%--                                        &lt;%&ndash;                                    <label for="fil-sel0000000">액세서리</label>&ndash;%&gt;--%>
<%--                                        <input type="radio" class="blind add-radio" name="selChk" id="fil-sel0000000" value="0000000">--%>
<%--                                        <label for="fil-sel0000000">--%>
<%--                                            <img src="${imagePath}/acc_img.png" alt="">--%>
<%--                                            <span>액세서리</span>--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div class="filter_list pro">
                            <h2>판매기기 <div class="ico"><span></span><span></span></div></h2>
                            <div class="filter">
                                <div class="sell_eq filter_inner">
                                    <div class="filter_depth2_wrap">
                                        <div class="filter_depth2_list" style="display: block;">
                                            <c:forEach var="item" items="${categoryList}">
                                                <c:if test="${item.sell_yn eq 'Y'}">
                                                    <div class="filter_depth2">
                                                        <img src="${item.file_path}${item.save_name}" alt="">
                                                        <div class="title_depth2 clearfix">
                                                            <h3 id="${item.no_cate}"><span class="check_label"></span>${item.cate_name}</h3>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                            <div class="filter_depth2">
                                                <div class="title_depth2 clearfix">
                                                    <img src="${imagePath}/acc_img.png" alt="">
                                                    <h3 id="0000000"><span class="check_label"></span>액세서리</h3>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="filter_list">
                            <h2>교환기기 <div class="ico"><span></span><span></span></div></h2>
                            <div class="filter">
                                <div class="change_eq filter_inner">
                                    <div class="search_tab swiper-container mobile_tab_menu">
                                        <ul class="clearfix swiper-wrapper" id="excgDevice">
                                            <c:forEach var="item" items="${categoryList}" varStatus="status">
                                                <c:if test="${item.excg_yn eq 'Y'}">
                                                    <li id="${item.no_cate}" class="${status.index} swiper-slide"><a href="#">${item.cate_name}</a></li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
<%--                                        <p>*아래에서 기기 별 색상을 선택하세요(중복 선택 가능)</p>--%>
                                    </div>
                                    <div class="filter_depth2_wrap">
                                        <c:forEach var="category" items="${categoryList}">
                                            <c:if test="${fn:length(category.deviceList) ne 0}"><div class="filter_depth2_list list-new ${category.no_cate}"></c:if>
                                            <c:forEach var ="device" items="${category.deviceList}">
                                                <div class="filter_depth2" id="${device.no_device}">
                                                    <div class="title_depth2 clearfix">
                                                        <h3><span class="check_label"></span>${device.device_name}</h3>
                                                        <div class="selected_color clearfix">
                                                            <p>선택 색상</p>
                                                            <div class="colors">
                                                                <c:forEach  var="color" items="${device.deviceColorList}">
                                                                    <span data-color="${color.no_color}" style="background-color: ${color.color_rgb}"></span>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="color_list_wrap">
                                                        <c:forEach var="color" items="${device.deviceColorList}">
                                                            <c:choose>
                                                                <c:when test="${color.limit_yn eq '01'}">
                                                                    <div class="color_list" data-color="${color.no_color}" id="${color.no_color}">
                                                                        <div class="pal" style="background-color: ${color.color_rgb}"></div>
                                                                        <p>${color.color_name}</p>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="color_list" id="${color.no_color}" onclick="javascript:onlyParcel.openPopup({x: '-50%', y: '-50%'});">
                                                                        <div class="pal" style="background-color: ${color.color_rgb}"></div>
                                                                        <p>${color.color_name}</p>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <c:if test="${fn:length(category.deviceList) ne 0}"></div></c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--매장 검색 결과--%>
        <div class="panel sub_panel search_result_panel">
            <div class="close_panel"></div>
            <div class="panel_inner scroll_area">
                <div class="sub_panel_title clearfix">
                    <h3>서비스센터 검색 결과 (0)</h3>
                    <div class="result_type">
                        <ul class="clearfix">
                            <li class="on" id="distance"><a href="#">거리순</a></li>
                            <%--<li id="type"><a href="#">서비스센터 유형순</a></li>--%>
                        </ul>
                    </div>
                </div>
                <div class="search_store_result">
                </div>
            </div>
        </div>

        <%-- 매장 상세 정보--%>
        <div class="panel sub_panel info_panel" id="storeDetailPanel">
            <p class="store-name"></p>
            <div class="btn_back">
                <a href="#"></a>
            </div>
            <div class="panel_inner scroll_area">
            </div>
        </div>
    </div>
</main>

<!-- 목록형 -->
<div class="list-type-nav">
    <div class="m-filtering swiper-container">
        <div class="swiper-wrapper add-btn">
            <div class="swiper-slide"><a href="#" class="filter-link"><img src="${imagePath}/filter-link-2.svg">필터</a></div>
            <div class="swiper-slide" data-set="svc" data-val="018"><span>체험프로그램 가능처</span></div>
            <div class="swiper-slide" data-set="svc" data-val="017"><span>특별혜택 쿠폰 사용처</span></div>
            <div class="swiper-slide" data-set="svc" data-val="011"><span>친구추천 코드 사용</span></div>
            <div class="swiper-slide" data-set="svc" data-val="012"><span>보상판매 가능처</span></div>
            <div class="swiper-slide" data-set="svc" data-val="006"><span>직영매장</span></div>
            <div class="swiper-slide" data-set="sel" data-val="0000004"><span>아이코스 3 듀오</span></div>
        </div>
    </div>
    <!-- <div class="close_panel"></div> -->
    <div class="panel_inner scroll_area">
        <div class="sub_panel_title">
            <h3>서비스센터 검색 결과 (0)</h3>
        </div>
        <div class="search_store_result">
        </div>
    </div>
</div>
<!-- 목록형 -->

<!-- 상세페이지 -->
<div class="list-type-details">
    <p class="store-name"></p>
    <div class="btn_back">
        <a href="#"></a>
    </div>
    <div class="panel_inner scroll_area scroll-stop">
    </div>
</div>
<!-- 상세페이지 -->

<!-- 필터링 -->
<div class="fil-popup">
    <div class="fil-tit">
        필터링
    </div>
    <div class="btn_back">
        <a href="#"></a>
    </div>
    <div class="panel main_panel ">
        <div class="panel_inner scroll_area ps ps--active-y">
            <div class="select_filter">
                <div class="filter_list_wrap">

                    <!-- 제공서비스 -->
                    <div class="filter_list">
                        <h2>제공 서비스<div class="ico"><span></span><span></span></div></h2>
                        <div class="filter">
                            <div class="filter_inner service">
                                <c:forEach var="item" items="${serviceList}" >
                                    <div class="filter_ckbox_wrap">
                                        <input type="checkbox" class="blind" name="serviceChk" id="fil-service${item.no_service}" value="${item.no_service}">
                                        <label for="fil-service${item.no_service}">${item.service_name}</label>
                                    </div>
                                </c:forEach>
                                <div class="filter_ckbox_wrap">
                                    <input type="checkbox" class="blind" name="serviceChk" id="fil-service000" value="000">
                                    <label for="fil-service000">주차여부</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 제공서비스 -->

                    <!-- 판매기기 -->
                    <div class="filter_list">
                        <h2>판매기기 <div class="ico"><span></span><span></span></div></h2>
                        <div class="filter">
                            <div class="sell_eq filter_inner">
                                <c:forEach var="item" items="${categoryList}" >
                                    <c:if test="${item.sell_yn eq 'Y'}">
                                        <div class="filter_ckbox_wrap">

                                            <input type="radio" class="blind add-radio" name="selChk" id="fil-sel${item.no_cate}" value="${item.no_cate}">
                                            <label for="fil-sel${item.no_cate}">
                                                <img src="${item.file_path}${item.save_name}" alt="">
                                                <span>${item.cate_name}</span>
                                            </label>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <div class="filter_ckbox_wrap">
<%--                                    <input type="radio" class="blind add-radio" name="selChk" id="fil-sel0000000" value="0000000">--%>
<%--                                    <label for="fil-sel0000000">액세서리</label>--%>
                                        <input type="radio" class="blind add-radio" name="selChk" id="fil-sel0000000" value="0000000">
                                        <label for="fil-sel0000000">
                                            <img src="${imagePath}/acc_img.png" alt="">
                                            <span>액세서리</span>
                                        </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 판매기기 -->

                    <!-- 교환기기 -->
                    <div class="filter_list">
                        <h2>교환기기 <div class="ico"><span></span><span></span></div></h2>
                        <div class="filter">
                            <div class="change_eq filter_inner">
                                <div class="mobile_tab_menu swiper-container">
                                    <div class="swiper-wrapper">
                                        <c:forEach var="item" items="${categoryList}" varStatus="status">
                                            <c:if test="${item.excg_yn eq 'Y'}">
                                                <div id="fil-chg${item.no_cate}" class="swiper-slide"><a href="#">${item.cate_name}</a></div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <span class="blur-box" style="pointer-events:none;"></span>
                                </div>
                                <div class="filter_depth2_wrap">
                                    <c:forEach var="category" items="${categoryList}">
                                        <c:if test="${fn:length(category.deviceList) ne 0}"><div class="filter_depth2_list list-new ${category.no_cate}"></c:if>
                                            <c:if test="${fn:length(category.deviceList) ne 0}"><div class="device-list clearfix"></c:if>
                                                <c:forEach var ="device" items="${category.deviceList}">
                                                    <div id="fil-dvc${device.no_device}"><a href="#">${device.device_name}</a></div>
                                                </c:forEach>
                                            <c:if test="${fn:length(category.deviceList) ne 0}"></div></c:if>
                                            <c:forEach var ="device" items="${category.deviceList}">
                                                <div class="filter_depth2 filter_depth2_new ${device.no_device}">
                                                    <div class="color-list clearfix" style="display:flex; flex-wrap:wrap;">
                                                        <c:forEach var="color" items="${device.deviceColorList}">
                                                            <c:choose>
                                                                <c:when test="${color.limit_yn eq '01'}">
                                                                    <div class="color-box-wrap">
                                                                        <div class="color-box">
                                                                            <div class="color-circle" data-color="${color.no_color}" style="background-color: ${color.color_rgb}"></div>
                                                                        </div>
                                                                        <span class="color-name">${color.color_name}</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="color-box-wrap" onclick="javascript:onlyParcel.openPopup({x: '-50%', y: '-50%'});">
                                                                        <div class="color-box">
                                                                            <div class="color-circle" data-color="${color.no_color}" style="background-color: ${color.color_rgb}"></div>
                                                                        </div>
                                                                        <span class="color-name">${color.color_name}</span>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        <c:if test="${fn:length(category.deviceList) ne 0}"></div></c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 교환기기 -->

                </div>
            </div>
            <!-- <div class="ps__rail-x" style="left: 0px; bottom: -22px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div>
            <div class="ps__rail-y" style="top: 22px; right: 0px; height: 589px;"><div class="ps__thumb-y" tabindex="0" style="top: 22px; height: 567px;"></div></div> -->
        </div>
    </div>
    <div class="fil-popup-btns clearfix">
        <a href="#" class="reset">초기화</a>
        <a href="#" class="application">적용</a>
    </div>
</div>
<!-- 필터링 -->

<!-- 지역검색 -->
<div class="area-search-popup">
    <div class="area-tit">
        지역검색
    </div>
    <div class="btn_back">
        <a href="#"></a>
    </div>
    <div class="area-name-wrap">
        <div class="m-step m-step1">
            <p class="area-guide"><strong>STEP 01</strong> 아래에서 시/도를 선택해주세요.</p>
            <ul class="area-name-list clearfix">
                <c:forEach items="${regionList}" var="region">
                    <li><a href ="#" onclick="javascript:getRegionList('${region.no_region}','${region.region_name}')">${region.region_name}</a></li>
                </c:forEach>
            </ul>
        </div>
        <div class="m-step m-step2">
            <p class="area-guide"><strong>STEP 02</strong> 아래에서 시/군/구를 선택해주세요.</p>
            <ul class="area-name-list clearfix">
            </ul>
        </div>
    </div>
</div>
<!-- 지역검색 -->

<!-- 목록형 검색 -->
<div class="m-search-new m-search-new1">
    <div class="m-search">
        <div class="m-search-inner">
            <div class="btn_back"><a href="#"></a></div>
            <input type="text" class="search-txt" placeholder="아이코스">
            <button type="submit" class="m-search-btn"></button>
        </div>
    </div>
    <div class="m-search-result">
        <div class="result-txt">
            <div class="result-icon"></div>
            <p>검색하신 <span>아이코스</span>에 대한<br>
                검색 결과가 없습니다</p>
        </div>
    </div>
</div>
<!-- 검색 -->

<!-- 지도형 검색 -->
<div class="m-search-new m-search-new2">
    <div class="m-search">
        <div class="m-search-inner">
            <div class="btn_back"><a href="#"></a></div>
            <input type="text" id="directSearchInput2" class="search-txt" placeholder="주소 / 지하철 / 서비스 센터명">
            <button type="button" onclick="javascript:directSearch();" class="m-search-btn"></button>
        </div>
    </div>
    <div class="m-search-result">
<%--        <div class="result-txt">--%>
<%--            <div class="result-icon"></div>--%>
<%--            <p>검색하신 <span>아이코스</span>에 대한<br>--%>
<%--                검색 결과가 없습니다</p>--%>
<%--        </div>--%>
    </div>
</div>
<!-- 검색 -->

<!-- 초기화 팝업 -->
<div class="init-popup">
    <div class="init-box">
        <p>선택하신 키워드를 제외하시면<br>
            설정하신 필터링이 초기화됩니다.<br>
            초기화 하시겠습니까?</p>
        <div class="init-btns clearfix">
            <a href="#" class="init-n">취소</a>
            <a href="#" class="init-y">초기화</a>
        </div>
    </div>
</div>
<!-- 초기화 팝업 -->

<%--설문조사 팝업--%>
<div class="survey" id="survey">
    <div class="bg"></div>
    <div class="survey_wrap">
        <div class="btn_pop_close pop_close"></div>
        <div class="survey_inner pop_inner scroll_area">
            <div class="survey_title">
                <p>저희 홈페이지에서의 경험에<br>만족하셨나요?</p>
            </div>
            <div class="survey_des">
                <p>아래에서 만족도를 선택해주세요.</p>
                <div class="survey_chk_wrap">
                        <c:forEach var="i" begin="0" end="10" step="1" varStatus="status">
                            <div class="chk_input_wrap">
                                <input type="radio" class="blind" name="serveyPoint" id="p${10-i}" value="${10-i}">
                                <label for="p${10-i}">${10-i}
                                    <c:choose>
                                        <c:when test="${status.first}">
                                            &nbsp;매우 만족
                                        </c:when>
                                        <c:when test="${status.last}">
                                            &nbsp;매우 불만족
                                        </c:when>
                                    </c:choose>
                                </label>
                            </div>
                        </c:forEach>
                        </div>
                        <div class="btn_submit">
                            <button onclick="javascript:sendSurvey();">제출하기</button>
                        </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- 공지사항 팝업 --%>
<div class="notice_popup">
    <div class="bg"></div>
    <div class="notice_wrap">
        <div class="notice_close"></div>
        <div class="notice_img_wrap scroll_area">
        </div>
        <div class="btn_wrap">
            <div class="btn"><a id="doNotReopen" href="javascript:;">다시 열지 않음</a></div>
            <div class="btn"><a id="closeNotice" href="javascript:;">닫기</a></div>
        </div>
    </div>
</div>

<%--교환기기 현황 레이어 팝업--%>
<div class="iqos_store_popup change_layer">
    <div class="bg"></div>
    <div class="popup_inner">
        <div class="btn_pop_close">
            <a href="#"></a>
        </div>
        <div class="pop_left">
        </div>
        <div class="pop_right">
            <div class="scroll_area">
            </div>
        </div>
    </div>
</div>

<%--판매기기 현황 레이어 팝업--%>
<div class="iqos_store_popup sale_layer">
    <div class="bg"></div>
    <div class="popup_inner">
        <div class="btn_pop_close">
            <a href="#"></a>
        </div>
        <div class="pop_left">
        </div>
        <div class="pop_right">
            <div class="scroll_area">

            </div>
        </div>
    </div>
</div>

<div class="iqos_popup only-parcel">
    <div class="pop_close"></div>
    <div class="pop_inner">
        <div class="pop_des">
            <p>선택하신 색상은<br>택배교환만 가능한<br>상품입니다.</p>
            <span>자세한 내용은 문의 부탁드립니다.</span>
        </div>
        <div class="pop_footer">
            <h5>고객센터</h5>
            <p>홈페이지: <a href="https://kr.iqos.com/support/">아이코스 고객지원 &gt;</a></p>
            <p class="bb1">전화문의: <a href="tel:080-000-1905">080-000-1905</a></p>
        </div>
    </div>
</div>

<button class="m-floating"><img src="${imagePath}/floating-icon-2.svg"></button>
<div class="floating-wrap">
    <div class="f-depth1">
        <ul class="f-depth1-list">
            <li class="on">
                <a href="#">
                    <span class="f-icon f-icon1"></span>
                    <span class="f-name">대여프로그램</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="f-icon f-icon2"></span>
                    <span class="f-name">서비스센터</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="f-icon f-icon3"></span>
                    <span class="f-name">공식홈페이지</span>
                </a>
            </li>
        </ul>
<%--        <button class="floating-close"><img src="${imagePath}/floating-close.png"></button>--%>
        <button class="floating-close"><img src="${imagePath}/icon_close_mint.svg"></button>
    </div>
    <div class="f-depth2">
        <div class="f-depth2-box one-swiper swiper-container on">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <a href="https://kr.iqos.com/myiqos/tryiqos-all" target="_blank">
                        <span class="depth2-icon"><img src="${imagePath}/rental-icon.png"></span>
                        <span class="f-name2">아이코스 대여</span>
                    </a>
                </div>
            </div>
        </div>
        <div class="f-depth2-box swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
<%--                    <a href="/faq">--%>
                    <a href="https://kr.iqos.com/support/faq/iluma" target="_blank">
                        <span class="depth2-icon"><img src="${imagePath}/service-icon1.png"></span>
                        <span class="f-name2">자주 묻는 질문</span>
                    </a>
                </div>
<%--                <div class="swiper-slide">--%>
<%--                    <a href="/carePlus">--%>
<%--                        <span class="depth2-icon"><img src="${imagePath}/service-icon2.png"></span>--%>
<%--                        <span class="f-name2">케어플러스</span>--%>
<%--                    </a>--%>
<%--                </div>--%>
                <div class="swiper-slide">
                    <a href="https://pf.kakao.com/_VNLkj/chat" target="_blank">
                        <span class="depth2-icon"><img src="${imagePath}/service-icon3.png"></span>
                        <span class="f-name2">카카오 채팅 상담</span>
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="https://kr.iqos.com/support/guide/iqos/iluma-prime" target="_blank">
                        <span class="depth2-icon"><img src="${imagePath}/service-icon4.png"></span>
                        <span class="f-name2">기기 사용법</span>
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="https://kr.iqos.com/support/troubleshooting/iqos/iluma-prime" target="_blank">
                        <span class="depth2-icon"><img src="${imagePath}/service-icon5.png"></span>
                        <span class="f-name2">자가진단</span>
                    </a>
                </div>
            </div>
        </div>
        <div class="f-depth2-box swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <a href="https://kr.iqos.com/program/refer" target="_blank">
                        <span class="depth2-icon"><img src="${imagePath}/iqoss-icon1.png"></span>
                        <span class="f-name2">친구추천</span>
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="https://kr.iqos.com/brandstory/what-is-iqos" target="_blank">
                        <span class="depth2-icon"><img src="${imagePath}/iqoss-icon2.png"></span>
                        <span class="f-name2">아이코스란?</span>
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="https://kr.iqos.com/" target="_blank">
                        <span class="depth2-icon"><img src="${imagePath}/iqoss-icon3.png"></span>
                        <span class="f-name2">아이코스 메인</span>
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="https://kr.iqos.com/products/iqos-device" target="_blank">
                        <span class="depth2-icon"><img src="${imagePath}/iqoss-icon4.png"></span>
                        <span class="f-name2">온라인 스토어</span>
                    </a>
                </div>
                <%--<div class="swiper-slide">
                    <a href="#">
                        <span class="depth2-icon"><img src="${imagePath}/iqoss-icon5.png"></span>
                        <span class="f-name2">월정액 서비스</span>
                    </a>
                </div>--%>
            </div>
        </div>
    </div>
</div>

<div class="share_popup_wrap" data-code="" data-name="" data-addr="">
    <div class="share_popup">
        <div class="share_popup_close"></div>
        <div class="share_list">
            <div class="share kakaotalk">
                <div class="img_wrap" onclick="javascript:sendKakaoLink($('.share_popup_wrap').data('code'), $('.share_popup_wrap').data('name'), $('.share_popup_wrap').data('addr'));">
<%--                    <img src="${imagePath}/kakao.png">--%>
                    <img src="${imagePath}/kakao.svg">
                </div>
                <p>카카오톡</p>
            </div>
            <%--<div class="share sms">
                <div class="img_wrap">
                    <img src="${imagePath}/sms.png">
                </div>
                <p>SMS전송</p>
            </div>--%>
            <div class="share copy">
                <input type="hidden" id="copyUrl" value="">
                <div class="img_wrap" onclick="javascript:copyUrl();">
<%--                    <img src="${imagePath}/copy.png">--%>
                    <img src="${imagePath}/url_copy.svg">
                </div>
                <p>URL복사</p>
            </div>
        </div>
        <div class="sms_share_form">
            <form>
                <div class="sms_input_wrap">
                    <input type="tel" placeholder="전화번호를 입력해주세요">
                </div>
                <div class="sms_submit_wrap">
                    <button type="button" onclick="javascript:sendSms($('.share_popup_wrap').data('code'), $('.share_popup_wrap').data('name'), $('.share_popup_wrap').data('addr'), this, 'list');">SMS 공유하기</button>
                </div>
            </form>
        </div>
        <p class="copy-comment"><span>URL이 복사되었습니다.</span></p>
    </div>
</div>

<div class="moment" id="moment">
    <img src="">
</div>
<div class="loading" id="loading">
    <img src="${imagePath}/loading.gif">
</div>

<form name = "filterForm" id="filterForm" method = "post">
    <input type="hidden" name="service" id="service_form">
    <input type="hidden" name="sell_device" id="sell_device_form">
    <input type="hidden" name="excg_device_cate" id="excg_device_cate">
    <input type="hidden" name="excg_device_device" id="excg_device_device">
    <input type="hidden" name="excg_device_color" id="excg_device_color">
</form>
<input type="hidden" id="eLat">
<input type="hidden" id="eLng">
<input type="hidden" id="endPointSub">

