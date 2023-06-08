<%@ page import="kr.co.msync.web.module.kakao.controller.KaKaoActionController" %>
<%@ page import="kr.co.msync.web.module.main.controller.MainActionController" %>
<%@ page import="kr.co.msync.web.module.sms.controller.SmsActionController" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    Kakao.init("<spring:eval expression="@config['api.kakao.authKey']"/>");
    var myLat = '37.525045';							// 현재 위치 위도(아이코스 본사 위도) - 현재 위치 정보 갖고 올때마다 업데이트 됨
    var myLng = '126.925319';							// 현재 위치 경도(아이코스 본사 경도) - 현재 위치 정보 갖고 올때마다 업데이트 됨
    var myAddr;                                         // 현재 위치(주소)
    var kakaoMap;										// map 객체
    var myLocationMarker;								// 내 위치 marker
    var myCircle;										// 내 위치 반경 표시
    var branchMarkers = [];								// 매장 marker
    var branchInfoWindows = [];						    // 매장 marker InfoWindow
    var clusterer;										// 클러스터 객체
    var selectedBranchInfoWindows = null;			    // 현재 선택된 branch
    var watchId = null;								// watchId
    var storeListGType = [];                            // 검색 결과(타입별 매장리스트)
    var storeListGDistance = [];                        // 검색 결과(거리순 정렬등에 사용)
    var distanceSearchFlag = true;                     // 지도 이동시 반경내 매장 표시 플래그
    var distance = 1;

    function  initFunc(){
        loading.openPopup();

        // 공지사항 팝업
        var notice = '${noticeData}';
        if(notice != '' && getCookie('iqosStoreLocatorNotice') == null){
            var noticeData = JSON.parse(notice);
            var noticeHtml = '';
            if(noticeData.notice_div == '01'){
                var imagePath = noticeData.file_path + noticeData.save_name;
                noticeHtml = '<img src = "' + imagePath + '"';
                if(noticeData.width != null && noticeData.width != ''){
                    noticeHtml += 'width="' + noticeData.width + '"';
                }
                if(noticeData.height != null && noticeData.height != ''){
                    noticeHtml += 'height="' + noticeData.height + '"';
                }
                noticeHtml += '>'
            }else{
                noticeHtml += '<div class="notice_text">';
                noticeHtml += '<h4>';
                noticeHtml += noticeData.notice_title;
                noticeHtml += '</h4>';
                noticeHtml += '<p>' + noticeData.notice_contents + '</p>';
                noticeHtml += '</div>';
            }
            $('.notice_img_wrap').append(noticeHtml);
            noticePopup.openPopup();
        }

        // 19세 미만 팝업 쿠키 저장(90일)
        setCookie('iqosStoreLocator', true, 90);

        $('.m_gnb nav ul #find_store_gnb').addClass('on').siblings().removeClass('on');

        getMyCurrentPostion(function(lat, lng){
            initializeMap(lat, lng);
//            circleDraw(lat, lng);
            // 공유하기로 입장했을경우
            var storeDetailStr = '${storeDetailResVO}';
            if(storeDetailStr != ''){
                var storeDetail = JSON.parse(storeDetailStr.replace(/\r/gi, '\\r').replace(/\n/gi, '\\n'));
                storeDetailData = storeDetail;
                if(typeof storeDetail != 'undefined' && storeDetail != ''){
                    markerCreate(new Array(storeDetail));
                    storeListGDistance.push(storeDetailData);
                    if(storeDetail.store_type != '04'){
                        makeHtmlStoreDetail(storeDetail);
                        makeHtmlSaleDeviceLeft(storeDetail.store_name, storeDetail.tel_num);
                        makeHtmlSaleDeviceRight(storeDetail.storeSellDeviceList, storeDetail.treat_yn);
                    }else{
                        makeHtmlStoreDetailGS(storeDetail);
                    }
                    makeHtmlExcgDeviceLeft(storeDetail);
                    makeHtmlExcgDeviceRight("");
                    moveMap(storeDetail.latitude, storeDetail.longitude, storeDetail.store_code);
                }
                if($(window).width() > 1024) {
                    panelToggle(true, false, true, true);
                }
                loading.closePopup();
            }else{
                if('${serviceName}'==='friend') {
                    $("#service_form").val("011,");
                    $('#service011').attr("checked","checked");
                    $(".filter_list_wrap .filter_list:eq(2) .ico").click();
                }
                $.ajax({
                    url : '<%=MainActionController.GET_STORE_LIST_BY_XY%>',
                    method : 'post',
                    data : $('#filterForm').serialize() + '&myLat='+ lat + '&myLng=' + lng + '&latitude=' + lat + '&longitude=' + lng+ '&distance=1',
                    success : function(result){
                        moveMap(lat, lng);
                        successAction(result);
                        if('${serviceName}'==='friend') {
                            $('.btn_wrap .btn .apply').click();
                        } else {
                            if(!isMobile.any) {
                                if($(window).width() > 1024) {
                                    panelToggle(true, true, false, true);
                                }
                            }
                        }
                        loading.closePopup();
                    }
                });
            }
        }, function(error){
            initializeMap(myLat, myLng);
            geoLocationErrorCallback(error);

            var storeDetailStr = '${storeDetailResVO}';
            if(storeDetailStr != ''){
                var storeDetail = JSON.parse(storeDetailStr.replace(/\r/gi, '\\r').replace(/\n/gi, '\\n'));
                if(typeof storeDetail != 'undefined' && storeDetail != ''){
                    markerCreate(new Array(storeDetail));
                    if(storeDetail.store_type != '04'){
                        makeHtmlStoreDetail(storeDetail);
                    }else{
                        makeHtmlStoreDetailGS(storeDetail);
                    }
                    moveMap(storeDetail.latitude, storeDetail.longitude, storeDetail.store_code);
                }
                if($(window).width() > 1024) {
                    panelToggle(true, false, true, true);
                }
                loading.closePopup();
            }else{
                $.ajax({
                    url : '<%=MainActionController.GET_STORE_LIST_BY_XY%>',
                    method : 'post',
                    data : $('#filterForm').serialize() + '&myLat='+ myLat + '&myLng=' + myLng + '&latitude=' + myLat + '&longitude=' + myLng+ '&distance=1',
                    success : function(result){
                        if(!isMobile.any) {
                            if($(window).width() > 1024) {
                                panelToggle(true, true, false, true);
                            }
                        }
                        distanceSearchFlag = true;
                        successAction(result);
                        moveMap(myLat, myLng);
                        loading.closePopup();
                    }
                })
            }
        });
    }

    function geoLocationErrorCallback(error){
        switch(error.code) {
            case error.PERMISSION_DENIED:
                // 사용자가 위치정보 사용을 허용하지 않았을 때
                alert('위치 정보 제공을 동의하지 않았습니다.');
                break;
            case error.POSITION_UNAVAILABLE:
                // 위치 정보 사용이 불가능할 때
                alert('위지 정보 사용이 불가능 합니다.');
                break;
            case error.TIMEOUT:
                // 위치 정보를 가져오려 시도했지만, 시간이 초과되었을 때
                alert('다시 시도해주세요.');
                break;
            case error.UNKNOWN_ERROR:
                // 기타 알 수 없는 오류가 발생하였을 때
                alert('다시 시도해주세요.');
                break;
            default :
                alert('오류가 발생했습니다.');
                break;
        }
    }

    /**
     현재 위치 - PC에서 사용
     */
    function getMyCurrentPostion(callback, errorCallback){
        if (!navigator.geolocation) {
            alert('Geolocation API를 지원하지 않습니다.');
            return;
        }
        navigator.geolocation.getCurrentPosition(function(pos){
            myLat = pos.coords.latitude;
            myLng = pos.coords.longitude;
            if(callback){
                callback(myLat, myLng);
            }
        }, errorCallback)
    }

    /**
     현재 위치 갖고오기(위치 이동시마다) - 휴대폰에서 사용
     */
    function getWatchCurrentPosition(callback, errorCallback){
        if (!navigator.geolocation) {
            alert('Geolocation API를 지원하지 않습니다.');
            return;
        }
        watchId = navigator.geolocation.watchPosition(function(pos){
            myLat = pos.coords.latitude;
            myLng = pos.coords.longitude;
            if(callback){
                callback(myLat, myLng);
            }
        }, errorCallback);
    }
    // navigator.geolocation.clearWatch(watchId);		// 실시간 위치 갖고오기 중단 - 탭이동시



    /**
     카카오맵 지도 초기화
     */
    function initializeMap(lat, lng){
        // 기본 맵 생성
        var map = document.getElementById('map');
        var mapOption = {
            center : new kakao.maps.LatLng(lat, lng),	// 중심 좌표
            level : 3,													// 확대 수준
            draggable : true										// 마우스 드래그, 휠, 모바일 터치를 이용한 시점 변경(이동, 확대, 축소) 가능 여부
            //	mapTypeId MapTypeId : 지도 종류 (기본값: 일반 지도)
            //	scrollwheel Boolean : 마우스 휠, 모바일 터치를 이용한 확대 및 축소 가능 여부
            //	disableDoubleClick Boolean : 더블클릭 이벤트 및 더블클릭 확대 가능 여부
            //	disableDoubleClickZoom Boolean : 더블클릭 확대 가능 여부
            //	projectionId String : 투영법 지정 (기본값: kakao.maps.ProjectionId.WCONG)
            //	tileAnimation Boolean : 지도 타일 애니메이션 설정 여부 (기본값: true)
            //	keyboardShortcuts Boolean | Object : 키보드의 방향키와 +, – 키로 지도 이동,확대,축소 가능 여부 (기본값: false)
            //	speed Number : 지도 이동 속도
        };
        kakaoMap = new kakao.maps.Map(map, mapOption);
        // 맵 생성 끝


        /**
        // clusterer 객체 생성
        clusterer = new kakao.maps.MarkerClusterer({
            map : kakaoMap,			//	클러스터링 마커를 표시할 지도 객체
            averageCenter : true,		// 마커들의 좌표 평균을 클러스터 좌표 설정 여부)
            minLevel : 8					// 클러스터링 할 지도의 최소 레벨 값
            //	markers Array.< Marker > : 클러스터링 할 마커 배열
            //	gridSize Number : 클러스터의 격자 크기. 화면 픽셀 단위이며 해당 격자 영역 안에 마커가 포함되면 클러스터에 포함시킨다 (default : 60)
            //	minClusterSize Number : 클러스터링 할 최소 마커 수 (default: 2)
            //	styles Array.< Object > : 클러스터의 스타일. 여러개를 선언하면 calculator 로 구분된 사이즈 구간마다 서로 다른 스타일을 적용시킬 수 있다
            //	texts Array.< String > | Function : 클러스터에 표시할 문자열 또는 문자열 생성 함수. (default : 클러스터에 포함된 숫자)
            //	calculator Array.< Number > | Function : 클러스터 크기를 구분하는 값을 가진 배열 또는 구분값 생성함수 (default : [10, 100, 1000, 10000])
            //	disableClickZoom Boolean : 클러스터 클릭 시 지도 확대 여부. true로 설정하면 클러스터 클릭 시 확대 되지 않는다 (default: false)
            //	clickable Boolean : 클러스터 클릭 가능 여부 지정 옵션. false일 경우 클러스터의 clusterclick, clusterdblclick, clusterrightclick 이벤트가 발생하지 않으며, 커서가 변경되지 않는다. (default: true)
            //	hoverable Boolean : 클러스터에 마우스 over/out 가능 여부 지정 옵션. false일 경우 클러스터의 clusterover, clusterout 이벤트가 발생하지 않는다. (default: true)
        });
         */

        // 지도/스카이뷰 Control 생성
        //kakaoMap.addControl(new kakao.maps.MapTypeControl(), kakao.maps.ControlPosition.TOPRIGHT);
        // ZoomControl 생성
        //kakaoMap.addControl(new kakao.maps.ZoomControl(), kakao.maps.ControlPosition.RIGHT);
        // kakaoMap CopyrightPosition
        kakaoMap.setCopyrightPosition(kakao.maps.CopyrightPosition.BOTTOMRIGHT, false);

        // 이동 이벤트 등록
        kakao.maps.event.addListener(kakaoMap, 'dragend', mapEventHandler());
//         kakao.maps.event.removeListener(kakaoMap, 'dragend', mapEventHandler());			// 이벤트 제거시 사용

        // zoom 변경 이벤트 등록
// 		kakao.maps.event.addListener(kakaoMap, 'zoom_changed', mapEventHandler());
        // kakao.maps.event.removeListener(kakaoMap, 'zoom_changed', mapEventHandler());	// 이벤트 제거시 사용
    }

    /**
     map이벤트 핸들러
     */
    function mapEventHandler(){
        return function(){
            if(!distanceSearchFlag){
                return;
            }
            var center = kakaoMap.getCenter();
            var latitude = center.getLat();
            var longitude = center.getLng();

            loading.openPopup();
            distance = 5;
            searchStoreByXY(myLat, myLng, latitude, longitude, distance, function(result){
                successAction(result);
                if(!isMobile.any){
                    if($(window).width() > 1024) {
                        panelToggle(true, true, false, false);
                    }
                }else{
                    var mobileChangePanelToggle = $('.mobile_change_tab').hasClass('on');
                    var mainPanelToggle = $('.side_nav').hasClass('on');
                    panelToggle(mainPanelToggle, true, false, mobileChangePanelToggle);
                }
                loading.closePopup();
            });
        }
    }

    /**
     카카오맵 매장 marker생성
     */
    function markerCreate(item){
        // marker생성 시작
        for(var i=0; i<item.length; i++){
            // 이미지 크기
            var imgSize;
            if($(window).width() > 768) {
                if (item[i].store_type == "01"){
                    imgSize = new kakao.maps.Size(32,48);
                } else if (item[i].store_type == "05" || item[i].store_type == "06"){
                    imgSize = new kakao.maps.Size(33,43);
                } else {
                    imgSize = new kakao.maps.Size(25,25);
                }
            } else {
                if (item[i].store_type == "01") {
                    imgSize = new kakao.maps.Size(32,48);
                }else if (item[i].store_type == "05" || item[i].store_type == "06"){
                    imgSize = new kakao.maps.Size(33,43);
                } else {
                    imgSize = new kakao.maps.Size(20,20);
                }
            }

            // 이미지 파일 경로(매장 타입별 다른 이미지로)
//            var imgSrc = 'https://kr.iqos.com/on/demandware.static/Sites-KR-Site/-/default/dwbd763a49/images/pin-brown.png';
//            var imgSrc = '${imagePath}/store_marker_'+item[i].store_type + '.svg';
            if(item[i].store_type == '01') {
                var imgSrc = '${imagePath}/mark_'+item[i].store_type + '.svg';
            }else{
                var imgSrc = '${imagePath}/mark_'+item[i].store_type + '.png';
            }


            // image option
            // 		alt String : 마커 이미지의 alt 속성값을 정의한다.
            // 		coords String : 마커의 클릭 또는 마우스오버 가능한 영역을 표현하는 좌표값
            // 		offset Point : 마커의 좌표에 일치시킬 이미지 안의 좌표 (기본값: 이미지의 가운데 아래)
            // 		shape String : 마커의 클릭 또는 마우스오버 가능한 영역의 모양
            // 		spriteOrigin Point : 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            // 		spriteSize Size : 스프라이트 이미지의 전체 크기

            // marker를 생성합니다
            var marker = new kakao.maps.Marker({
                map : kakaoMap,																			// 마커가 올라갈 지도 또는 로드뷰
                position : new kakao.maps.LatLng(item[i].latitude, item[i].longitude),					// 마커의 좌표 또는 로드뷰에서의 시점
                image : new kakao.maps.MarkerImage(imgSrc, imgSize)						// 마커의 이미지
                //	title String : 마커 엘리먼트의 타이틀 속성 값 (툴팁)
                //	draggable Boolean : 드래그 가능한 마커, 로드뷰에 올릴 경우에는 유효하지 않다
                //	clickable Boolean : 클릭 가능한 마커
                //	zIndex Number : 마커 엘리먼트의 z-index 속성 값
                //	opacity Number : 마커 투명도 (0-1)
                // 	altitude Number : 로드뷰에 올라있는 마커의 높이 값(m 단위)
                // 	range Number : 로드뷰 상에서 마커의 가시반경(m 단위), 두 지점 사이의 거리가 지정한 값보다 멀어지면 마커는 로드뷰에서 보이지 않게 된다
            });
            // marker 생성 끝


            // infowWindow 생성
            // infoWindow 내용
            var infoWindowContent = makeHtmlInfoWindow(item[i]);
            var infoWindow = new kakao.maps.InfoWindow({
                content : infoWindowContent,				    // 엘리먼트 또는 HTML 문자열 형태의 내용
                disableAutoPan : true							// infoWindow를 열 때 지도가 자동으로 패닝하지 않을지의 여부(default : false)
            });
            // infoWindow 생성 끝

            // marker에 클릭 이벤트 등록
            kakao.maps.event.addListener(marker, 'click', makeClickEvent(kakaoMap, marker, infoWindow, item[i].store_code, item[i].store_name,  item[i].store_type));
//            branchMarkers.push(marker);
//            branchInfoWindows.push(infoWindow);
            branchMarkers[item[i].store_code] = marker;
            branchInfoWindows[item[i].store_code] = infoWindow;
//            clusterer.addMarker(marker);
        }
        // cluster객체에 marker(Array)추가
//        clusterer.addMarkers(branchMarkers);
    }

    function infoWindowToggle(storeCode){
        var info = branchInfoWindows[storeCode];
        if(selectedBranchInfoWindows != null && selectedBranchInfoWindows != info){
            selectedBranchInfoWindows.close();
        }
        if(info.getMap()){
            info.close();
        }else{
            selectedBranchInfoWindows = info;
            info.open(kakaoMap, branchMarkers[storeCode]);
        }
    }

    /**
     marker 클릭 이벤트
     */
    function makeClickEvent(map, marker, infoWindow, store_code, store_name, store_type){
        return function(){
            // infoWindow 하나만 띄우기
            if(selectedBranchInfoWindows != null && selectedBranchInfoWindows != infoWindow){
                selectedBranchInfoWindows.close();
            }
            if(infoWindow.getMap()){
                infoWindow.close();
            }else{
                selectedBranchInfoWindows = infoWindow;
                infoWindow.open(map, marker);

                // 말풍선 꼬리 삭제
                $('.iqos_info_window').parent().prev().hide();

                <!-- PRD 만 노출 -->
                <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
                <c:if test="${profileId eq 'prd'}">
                    var storeType = "";
                    if(store_type == '01'){
                        storeType = "IQOS Service Point"; // 공식 판매처
                    } else if(store_type == '03'){
                        storeType = "Stockist"; // 소매점
                    } else {
                        storeType = "IQOS Store"; // 직영매장
                    }
                    dataLayer.push({
                        'event': 'storeLocatorStoreClick',
                        'storeLocatorStoreID': store_code,
                        'storeLocatorStoreName': store_name,
                        'storeLocatorStoreType': storeType,
                        'storeLocatorStoreClickSource': 'map' // or 'list'
                    });
                </c:if>
            }
        };

    }

    /**
     marker 보여주기/삭제
     */
    function setMarkers(map){
        if(selectedBranchInfoWindows != null){
            if(selectedBranchInfoWindows.getMap()){
                selectedBranchInfoWindows.close();
            }
        }
        for(var i=0; i< storeListGDistance.length ; i++){
            branchMarkers[storeListGDistance[i].store_code].setMap(map);
        }
    }
    /**
     marker 보여주기
     */
    function showMarkers(){
        setMarkers(kakaoMap);
    }
    /**
     모든 marker 숨기기
     */
    function hideMarkers(){
 		setMarkers(null);
// 		clusterer.removeMarkers(branchMarkers);
//      clusterer.clear();
        storeListGDistance = [];
        branchMarkers = [];	// 매장 marker 변수 초기화
        branchInfoWindows = [];
        selectedBranchInfoWindows = null;
    }

    /**
     내 위치 원그리기
     */
    function circleDraw(lat, lng){
        if(lat == null || typeof lat == 'undefined' || lng == null || typeof lng== 'undefined'){
            if(myCircle != null){
                myCircle.setMap(null);
                return ;
            }
        }
        if(myCircle != null){
            myCircle.setPosition(new kakao.maps.LatLng(lat, lng));
        }else{
            myCircle = new kakao.maps.Circle({
                center : new kakao.maps.LatLng(lat, lng),
                radius : 400,
                strokeWeight: 5, // 선의 두께입니다
                strokeColor: '#75B8FA', // 선의 색깔입니다
                strokeOpacity: 0, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                strokeStyle: 'dashed', // 선의 스타일 입니다
                fillColor: '#CFE7FF', // 채우기 색깔입니다
                fillOpacity: 0.4  // 채우기 불투명도 입니다
            });
        }
        myCircle.setMap(kakaoMap);
    }
    /**
     * 맵 이동
     * @param lat
     * @param lng
     */
    function moveMap(lat, lng, store_code, dataPushYn){
        var moveLatLng = new kakao.maps.LatLng(lat, lng);
        kakaoMap.setLevel(3);
        kakaoMap.setCenter(moveLatLng)
        if(!isMobile.any){
            var width = -window.innerWidth;
            kakaoMap.panBy(width*(1/3),0);
        }else{
            var height = -window.innerHeight;
            kakaoMap.panBy(0, height/5);
            /**
            if(typeof store_code != 'undefined' ){
                $('#mobileMap').parent().addClass('on').siblings().removeClass('on');
                TweenMax.to('.side_nav', 0.4, {autoAlpha: 0, ease: Expo.easeOut});
            }
             */
        }
        if(store_code){
            if(selectedBranchInfoWindows != null){
                if(selectedBranchInfoWindows.getMap()){
                    selectedBranchInfoWindows.close();
                }
            }
            branchInfoWindows[store_code].open(kakaoMap, branchMarkers[store_code]);
            selectedBranchInfoWindows = branchInfoWindows[store_code];
            loading.openPopup();
            $.ajax({
                url : '<%=MainActionController.GET_STORE_DETAIL%>',
                method : 'post',
                data : {
                    store_code : store_code
                },
                success : function(result){
                    if(typeof result == 'undefined' || result ==''){
                        alert('해당 상점 정보가 없습니다.')
                        return ;
                    }
                    <!-- PRD 만 노출 -->
                    <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
                    <c:if test="${profileId eq 'prd'}">
                        if (dataPushYn == 'Y') {
                            var storeType = "";
                            if (result.store_type == '01') {
                                storeType = "IQOS Service Point"; // 공식 판매처
                            } else if (result.store_type == '03') {
                                storeType = "Stockist"; // 소매점
                            } else {
                                storeType = "IQOS Store"; // 직영매장
                            }
                            dataLayer.push({
                                'event': 'storeLocatorStoreClick',
                                'storeLocatorStoreID': result.store_code,
                                'storeLocatorStoreName': result.store_name,
                                'storeLocatorStoreType': storeType,
                                'storeLocatorStoreClickSource': 'list' // or 'map'
                            });
                        }
                    </c:if>
                    loading.closePopup();
                }
            })
        }
    }
</script>
<script>
    var checkimg = '${imagePath}/check_layer.gif';
    var resettingimg = '${imagePath}/resetting.gif'

    function directSearch(isFil){
        if(!enterFlag){
            return;
        }
        var keyword;
        if ($(".m-search-new").css("display") == "none"){
            keyword = $('#directSearchInput').val();
            $('#directSearchInput2').val(keyword);
        } else {
            keyword = $('#directSearchInput2').val();
            $('#directSearchInput').val(keyword);
        }
        if(keyword == ''){
            alert('검색어를 입력해주세요.');
            return;
        }
        enterFlag = false;
        if(isMobile.any){
            $('.mobile-mode').animate({scrollTop : 0}, 300);
        }
        loading.openPopup();
        getMyCurrentPostion(function(lat, lng){
            $.ajax({
                url : '<%=MainActionController.GET_STORE_LIST_BY_SEARCH_KEYWORD%>',
                method : 'post',
                data : $('#filterForm').serialize() + '&myLat=' + lat + '&myLng=' + lng + '&keyword='+ keyword +'&distance=1',
                success : function(result){
                    successAction(result);
                    distanceSearchFlag = false;
                    // 지역검색 키워드 초기화
                    regionDepth1Keyword='';
                    regionDepth2Keyword='';
                    // 직접검색 or 필터링
                    if ($('.m-search-new2').hasClass('on') || isFil){
                        $('.fil-popup .btn_back').click();
                        $('#moveSearchInput').attr('placeholder', keyword);
                        $('.m-search-new2 .btn_back').click();
                        $('.search-tag').click();
                    } else {
                        panelToggle(true, true, false, true)
                    }
                    if(storeListGDistance.length > 0){
                        moveMap(storeListGDistance[0].latitude, storeListGDistance[0].longitude, storeListGDistance[0].store_code);
                    }else{
                        moveMap(lat, lng);
                    }
                    //setTimeout(function(){
                        enterFlag = true;
                    //},2000);
                    // 말풍선 꼬리 삭제
                    $('.iqos_info_window').parent().prev().hide();
                    loading.closePopup();

                    <!-- PRD 만 노출 -->
                    <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
                    <c:if test="${profileId eq 'prd'}">
                        dataLayer.push({
                            'event': 'search',
                            'searchQuery': keyword, // search terms in lowercase
                            'searchResults': result.distanceList.length // Total Results found for query
                        });
                    </c:if>
                }
            });
        },function(error){
            geoLocationErrorCallback(error);
            $.ajax({
                url : '<%=MainActionController.GET_STORE_LIST_BY_SEARCH_KEYWORD%>',
                method : 'post',
                data : $('#filterForm').serialize() + '&keyword='+keyword + '&myLat=' + myLat + '&myLng=' + myLng +'&distance=1',
                success : function(result){
                    successAction(result);
                    distanceSearchFlag = false;
                    // 지역검색 키워드 초기화
                    regionDepth1Keyword='';
                    regionDepth2Keyword='';
                    // 직접검색 or 필터링
                    if ($('.m-search-new2').hasClass('on') || isFil){
                        $('.fil-popup .btn_back').click();
                        $('#moveSearchInput').attr('placeholder', keyword);
                        $('.m-search-new2 .btn_back').click();
                        $('.search-tag').click();
                    } else {
                        panelToggle(true, true, false, true);
                    }
                    if(storeListGDistance.length > 0){
                        moveMap(storeListGDistance[0].latitude, storeListGDistance[0].longitude, storeListGDistance[0].store_code);
                    }else{
                        moveMap(myLat, myLng);
                    }
                    loading.closePopup();
                    setTimeout(function(){
                        enterFlag = true;
                    },2000);

                    <!-- PRD 만 노출 -->
                    <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
                    <c:if test="${profileId eq 'prd'}">
                        dataLayer.push({
                            'event': 'search',
                            'searchQuery': keyword, // search terms in lowercase
                            'searchResults': result.distanceList.length // Total Results found for query
                        });
                    </c:if>
                }
            })
        });
    }

    var enterFlag = true;
    // 직접검색 스크립트
    $(document).ready(function(){
        $('#directSearchInput, #directSearchInput2').keypress(function(e){
            if(e.which == 13 && enterFlag){
                directSearch();
            }
        });
    });
</script>
<script>
    /**
     * 지역검색 지역리스트 갖고 오기
     * @param no_region
     * @param region_name
     */
    function getRegionList(no_region, region_name){
        $.ajax({
            url : '<%=MainActionController.GET_REGION_LIST%>',
            method : 'post',
            data : {
                region_p_no : no_region
            },
            success : function(result){
                $('.sub_local_list_wrap .title h2').text(region_name);
                var regionList = result;
                var html = '<li onclick="javascript:getStoreListByRegion(\''+region_name+'\',\'\');"><a href="javascript:;">전체</a></li>';
                for(var i = 0 ; i < regionList.length; i++){
                    html += '<li onclick="javascript:getStoreListByRegion(\''+region_name+'\',\''+regionList[i].region_name+'\');">';
                    html += '<a href="javascript:;">';
                    html += regionList[i].region_name;
                    html += '</a>';
                    html += '</li>';
                }

                if ($('.m-step2').hasClass('on')){
                    $('.m-step.m-step2 ul').empty();
                    $('.m-step.m-step2 ul').append(html);
                } else {
                    $('.sub_local_list_wrap ul').empty();
                    $('.sub_local_list_wrap ul').append(html);
                }

//                TweenMax.to(step2, 0.6, {
//                    ease: Expo.easeInOut,
//                    force3D: true,
//                    xPercent: -100,
//                });
//                TweenMax.to('.step-1', 0.6, {
//                    ease: Expo.easeInOut,
//                    force3D: true,
//                    autoAlpha: 1,
//                });
//
//                TweenMax.to(step2, 0.6, {
//                    ease: Expo.easeOut,
//                    force3D: true,
//                    xPercent: 100,
//                });
//                TweenMax.to('.step-1', 0.6, {
//                    ease: Expo.easeOut,
//                    force3D: true,
//                    autoAlpha: 0,
//                });

            }
        });
    }

    var regionDepth1Keyword='';
    var regionDepth2Keyword='';
    function getStoreListByRegion(regionDepth1, regionDepth2, isFil){
        // 하드 코딩 필요....
        if(regionDepth1 == '경남'){
            regionDepth1 = "경남,경상남도"
        }else if(regionDepth1 == '경북'){
            regionDepth1 = "경북,경상북도"
        }else if(regionDepth1 == '전남'){
            regionDepth1 = "전남,전라남도"
        }else if(regionDepth1 == '전북'){
            regionDepth1 = "전북,전라북도"
        }else if(regionDepth1 == '충남'){
            regionDepth1 = "충남,충청남도"
        }else if(regionDepth1 == '충북'){
            regionDepth1 = "충북,충청북도"
        }

        // 필터 적용 버튼 클릭시 필요
        regionDepth1Keyword = regionDepth1;
        regionDepth2Keyword = regionDepth2;
        loading.openPopup();
        $.ajax({
            url : '<%=MainActionController.GET_STORE_LIST_BY_REGION%>',
            method : 'post',
            data : $('#filterForm').serialize() + '&latitude=' + myLat + '&longitude=' + myLng + '&regionDepth1=' + regionDepth1 + '&regionDepth2=' + regionDepth2,
            success : function(result){
                successAction(result,1);
                distanceSearchFlag = false;
                // 직접검색 키워드 초기화
                $('#directSearchInput').val('');
                $('#directSearchInput2').val('');
                $('#moveSearchInput').attr('placeholder', '');
                // 지역검색 or 필터링
                if ($('.m-step2').hasClass('on') || isFil) {
                    $('.fil-popup .btn_back').click();
                    $('.area-search-popup').removeClass('on');
                    $('.m-step1').removeClass('on');
                    $('.m-step2').removeClass('on');
                    $('.search-tag').click();
                } else {
                    panelToggle(true, true, false, true);
                }
                if(storeListGDistance.length > 0){
                    successAction(result);
                    moveMap(storeListGDistance[0].latitude, storeListGDistance[0].longitude, storeListGDistance[0].store_code);
                }else{
                    successAction(result,1);
                    moveMap(myLat, myLng);
                }
                // 말풍선 꼬리 삭제
                $('.iqos_info_window').parent().prev().hide();
                loading.closePopup();

                <!-- PRD 만 노출 -->
                <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
                <c:if test="${profileId eq 'prd'}">
                    dataLayer.push({
                        'event': 'storeLocatorTypeFilter',
                        'storeLocatorTypeFilter': 'region'
                    });
                </c:if>
            }
        });
    }
</script>

<script>
    var enterFlagStartPoint = true;
    var enterFlagEndPoint = true;
    // 길찾기 스크립트
   /// 매장검색 - 길찾기
    ;(function() {
        // 길찾기 현재위치로 설정(PC)
        $('.main_panel .road_search .starting_button_a, .main_panel .road_search .starting_mobile_button').click(function(e) {
            e.preventDefault();

            loading.openPopup();
            getMyCurrentPostion(function(lat, lng){
                $.ajax({
                    url : '<%=KaKaoActionController.ADDRESS_BY_XY%>',
                    method : 'post',
                    data : {
                        latitude: lat,
                        longitude : lng
                    },
                    success : function(result){
                        if(!isMobile.any){
                            moveMap(lat, lng);
                            myAddr = result;
                        }else{
                            $('.main_panel .road_search p').addClass('selected').text('현재위치 : ' + result);
                        }
                        $('#startPoint').val(result);
                        loading.closePopup();
                    }
                })
            }, function(error){
                geoLocationErrorCallback(error);
            });
        });


        // 길찾기 출발위치 검색
        $('#startPoint, #endPoint').keypress(function(e) {
            var id = $(this).prop('id');
            if(e.which == 13 && enterFlagStartPoint){
                loading.openPopup();
                if(id == 'startPoint'){
                    startPointSet();
                }else if(id == 'endPoint' && enterFlagEndPoint){
                    endPointSet();
                }
                loading.closePopup();
            }
        });
    })();

    function startPointSet(){
        if(!enterFlagStartPoint){
            return;
        }
        $('.result_wrap').removeClass('destip');

        var keyword = $('#startPoint').val();
        if(typeof keyword == 'undefined' || keyword == ''){
            alert('출발지를 입력해주세요');
            return;
        }

        $.ajax({
            url : '<%=KaKaoActionController.ADDRESS_BY_KEYWORD%>',
            method : 'post',
            data : {
                query : keyword
            },
            success : function(result){
                if(result == null || result == 'null'){
                    $('.road_search_result').find('h3').text('위치 검색 결과(0)');
                    makeHtmlRoadSearchResultEmpty();
                    return;
                }
                $('.road_search_result').find('h3').text('위치 검색 결과('+ result.length + ')');
                makeHtmlRoadSearchResult(result, 'startPoint');

                // 연속 방지
                enterFlagStartPoint = false;
                setTimeout(function(){
                    enterFlagStartPoint = true;
                },2000);
            }
        })
    }

    function endPointSet(){
        if(!enterFlagEndPoint){
            return;
        }
        $('.result_wrap').addClass('destip');
        var keyword = $('#endPoint').val();
        if(keyword == ''){
            alert('도착 서비스 센터를 입력해주세요');
            return ;
        }
        $.ajax({
            url : '<%=MainActionController.GET_STORE_LIST_BY_KEYWORD%>',
            method : 'post',
            data : {
                keyword : keyword
            },
            success : function(result){
                if(result == null || result == 'null'){
                    $('.road_search_result').find('h3').text('서비스 센터 검색 결과(0)');
                    makeHtmlRoadSearchResultEmpty();
                    return;
                }
                makeHtmlRoadSearchResult(result, 'endPoint');
                $('.road_search_result').find('h3').text('서비스 센터 검색 결과('+ result.length + ')');
                // 연속 enter 방지
                enterFlagEndPoint = false;
                setTimeout(function(){
                    enterFlagEndPoint = true;
                },2000);
            },
            error : function(err){

            }
        })
    }


    function setDestination(id, title, subTitle, lat, lng){
        $('#'+id).val(title);
        if(id =='endPoint'){
            $('#endPointSub').val(subTitle);
            $('#eLat').val(lat);
            $('#eLng').val(lng);
        }
        var startPoint = $('#startPoint').val();
        var endPoint = $('#endPoint').val();
        var endPointSub = $('#endPointSub').val();

        if(startPoint != '' && endPoint != '' && endPointSub != ''){
            $('.find_course').show();
        }else{
            $('.find_course').hide();
        }
    }

    $(document).ready(function(){
        var startPoint = $('#startPoint').val();
        if(startPoint != ''){
            $('.main_panel .road_search p').addClass('selected').text('현재위치 : ' + startPoint);
        }
        var endPoint = $('#endPoint').val('');

        // 출발지 검색지 필드 값 변경시 작동
        $(document).on('change, focusin, focusout', '#startPoint, #endPoint', function(){
            var startPoint = $('#startPoint').val();
            var endPoint = $('#endPoint').val();
            var endPointSub = $('#endPointSub').val();

            if(startPoint != '' && endPoint != '' && endPointSub != ''){
                $('.find_course').show();
            }else{
                $('.find_course').hide();
            }
        });

        $('.find_course').find('button').click(function(){
            var startPoint = $('#startPoint').val();
            var endPointSub = $('#endPointSub').val();
            var eLat = $('#eLat').val();
            var eLng = $('#eLng').val();

            if(startPoint == ''){
                alert('출발 위치를 선택해주세요');
                return;
            }
            if(endPointSub ==''){
                alert('도착 서비스 센터를 선택해주세요')
                return;
            }
            findRoadMoveKaKaoMap(startPoint, endPointSub, eLat, eLng);
        });
    });

    /**
     * 길찾기
     * @param sPoint
     * @param ePoint
     * @param eName
     * @param eLat
     * @param eLng
     */
    function findRoadMoveKaKaoMap(sPoint, ePoint, eLat, eLng){
        if(!isMobile.any){
            // PC일 경우
            window.open("https://map.kakao.com/?target=car&sName=" + encodeURI(sPoint) + "&eName=" + encodeURI(ePoint))
        }else{
            // MOBILE일경우
            location.href = "https://map.kakao.com/link/to/" + ePoint.replace(/,/gi, '') + ',' + eLat + ',' + eLng;
        }
    }

    /**
     * 매장 검색결과/상세정보 > 길찾기
     * @param startPoint
     * @param endPoint
     */
    function moveKaKaoMap(ePoint, eLat, eLng, store_type){
        <!-- PRD 만 노출 -->
        <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
        <c:if test="${profileId eq 'prd'}">
            var storeType = "";
            if(store_type == '01'){
                storeType = "IQOS Service Point"; // 공식 판매처
            } else if(store_type == '03'){
                storeType = "Stockist"; // 소매점
            } else {
                storeType = "IQOS Store"; // 직영매장
            }
            dataLayer.push({
                'event': 'storeLocatorDirections',
                'storeLocatorStoreType': storeType
            });
        </c:if>
        getMyCurrentPostion(function(lat, lng){
            $.ajax({
                url : '<%=KaKaoActionController.ADDRESS_BY_XY%>',
                method : 'post',
                data : {
                    latitude : lat,
                    longitude : lng
                },
                success : function(result){
                    if(!isMobile.any){
                        // PC일 경우
                        window.open("https://map.kakao.com/?target=car&sName=" + encodeURI(result) + "&eName=" + encodeURI(ePoint))
                    }else{
                        // MOBILE일경우
                        location.href = "https://map.kakao.com/link/to/" + ePoint.replace(/,/gi, '') + ',' + eLat + ',' + eLng;
                    }
                }
            })

        }, function(error){
            geoLocationErrorCallback(error);
            if(!isMobile.any){
                // PC일 경우
                window.open("https://map.kakao.com/link/to/" + encodeURI(ePoint.replace(/,/gi, '')) + ',' + eLat + ',' + eLng);
            }else{
                // MOBILE일경우
                location.href = "https://map.kakao.com/link/to/" + ePoint.replace(/,/gi, '') + ',' + eLat + ',' + eLng;
            }
        });
    }
</script>

<script>
    // 필터 스크립트
    $(document).ready(function(){

        // 필터 적용 버튼
        $('.btn_wrap .btn .apply, .fil-popup-btns .application, .purpose-list li a, .m-filtering span').click(function(){

            // 필터링 페이지 여부
            var isFilPage = $(this).hasClass('application');

            // 추천 필터링 여부 (PC)
            var isPurpose = $(this).parent().parent().hasClass('purpose-list');

            // 추천 필터링 여부 (모바일)
            var isFiltering = $(this).parent().parent().parent().hasClass('m-filtering');

            // 추천 필터링 체크
            if (isPurpose || isFiltering){
                var set = $(this).parent().data('set');
                var val = $(this).parent().data('val');

                if (set == "svc"){
                    if ($('input[name=serviceChk][value=' + val + ']').prop("checked")){
                        $('input[name=serviceChk][value=' + val + ']').prop('checked', false);
                    } else {
                        $('input[name=serviceChk][value=' + val + ']').prop('checked', true);
                    }
                } else if (set == "sel"){
                    if ($('input[name=selChk][value=' + val + ']').prop("checked")){
                        $('input[name=selChk][value=' + val + ']').prop('checked', false);
                    } else {
                        $('input[name=selChk][value=' + val + ']').click();
                    }
                    $('.sell_eq .filter_depth2_wrap .filter_depth2_list .filter_depth2').each(function(index, tag){
                        if ($(this).find('.title_depth2 h3').prop('id') == val){
                            if ($(this).hasClass('on')){
                                $(this).removeClass('on');
                            } else {
                                $(this).find('.title_depth2 h3').click();
                            }
                        }
                    });
                }
            }

            // 서비스 항목값 갖고오기 (필터링 레이어, 필터링 팝업 > 사용 element 동일)
            var serviceChkVal = '';
            if (isFilPage){
                $('.filter_list_wrap').eq(1).find('input[name=serviceChk]').each(function(index, tag){
                    if ($(this).prop('checked')) {
                        serviceChkVal += tag.value + ",";
                        // 추천 필터링 제어
                        $('.purpose-list li a').parent().parent().find('[data-set=svc][data-val=' + tag.value + '] a').addClass('on');
                        $('.m-filtering span').parent().parent().find('[data-set=svc][data-val=' + tag.value + '] span').addClass('on');
                        // 필터링 레이어 제어
                        $('.filter_list_wrap').eq(0).find('input[name=serviceChk][value=' + tag.value + ']').prop('checked', true);
                        if (!$('.filter_list_wrap .filter_list').eq(0).hasClass('on')) {
                            $('.filter_list_wrap .filter_list').eq(0).click();
                        }
                    } else {
                        // 추천 필터링 제어
                        $('.purpose-list li a').parent().parent().find('[data-set=svc][data-val=' + tag.value + '] a').removeClass('on');
                        $('.m-filtering span').parent().parent().find('[data-set=svc][data-val=' + tag.value + '] span').removeClass('on');
                        // 필터링 레이어 제어
                        $('.filter_list_wrap').eq(0).find('input[name=serviceChk][value=' + tag.value + ']').prop('checked', false);
                    }
                });
            } else {
                $('.filter_list_wrap').eq(0).find('input[name=serviceChk]').each(function(index, tag){
                    if ($(this).prop('checked')) {
                        serviceChkVal += tag.value + ",";
                        // 추천 필터링 제어
                        $('.purpose-list li a').parent().parent().find('[data-set=svc][data-val=' + tag.value + '] a').addClass('on');
                        $('.m-filtering span').parent().parent().find('[data-set=svc][data-val=' + tag.value + '] span').addClass('on');
                        // 필터링 팝업 제어
                        $('.filter_list_wrap').eq(1).find('input[name=serviceChk][value=' + tag.value + ']').prop('checked', true);
                        if (!$('.filter_list_wrap .filter_list').eq(3).hasClass('on')) {
                            $('.filter_list_wrap .filter_list').eq(3).click();
                        }
                        // 추천 필터링 진입시
                        if (isFiltering){
                            // 필터링 레이어 제어
                            $('.filter_list_wrap').eq(0).find('input[name=serviceChk][value=' + tag.value + ']').prop('checked', true);
                            if (!$('.filter_list_wrap .filter_list').eq(0).hasClass('on')) {
                                $('.filter_list_wrap .filter_list').eq(0).click();
                            }
                        }
                    } else {
                        // 추천 필터링 제어
                        $('.purpose-list li a').parent().parent().find('[data-set=svc][data-val=' + tag.value + '] a').removeClass('on');
                        $('.m-filtering span').parent().parent().find('[data-set=svc][data-val=' + tag.value + '] span').removeClass('on');
                        // 필터링 팝업 제어
                        $('.filter_list_wrap').eq(1).find('input[name=serviceChk][value=' + tag.value + ']').prop('checked', false);
                        // 추천 필터링 진입시
                        if (isFiltering){
                            // 필터링 레이어 제어
                            $('.filter_list_wrap').eq(0).find('input[name=serviceChk][value=' + tag.value + ']').prop('checked', false);
                        }
                    }
                });
            }

            // 판매 상품 선택
            var sellVal;
            if (isFilPage){
                sellVal = typeof $('input[name=selChk]:checked') == 'undefined' ? '' : $('input[name=selChk]:checked').val();
                $('input[name=selChk]').each(function(index, tag){
                    if ($(this).prop('checked')) {
                        // 추천 필터링 제어
                        $('.purpose-list li a').parent().parent().find('[data-set=sel][data-val=' + tag.value + '] a').addClass('on');
                        $('.m-filtering span').parent().parent().find('[data-set=sel][data-val=' + tag.value + '] span').addClass('on');
                        // 필터링 레이어 제어
                        $('.sell_eq .filter_depth2_wrap .filter_depth2_list .title_depth2 h3[id=' + tag.value + ']').click();
                        if (!$('.filter_list_wrap .filter_list').eq(1).hasClass('on')) {
                            $('.filter_list_wrap .filter_list').eq(1).click();
                        }
                    } else {
                        // 추천 필터링 제어
                        $('.purpose-list li a').parent().parent().find('[data-set=sel][data-val=' + tag.value + '] a').removeClass('on');
                        $('.m-filtering span').parent().parent().find('[data-set=sel][data-val=' + tag.value + '] span').removeClass('on');
                        // 필터링 레이어 제어
                        $('.sell_eq .filter_depth2_wrap .filter_depth2_list .title_depth2 h3[id=' + tag.value + ']').parent().parent().removeClass('on');
                    }
                });
            } else {
                sellVal = $('.sell_eq .filter_depth2_wrap .filter_depth2_list .on .title_depth2 h3').prop('id');
                $('.sell_eq .filter_depth2_wrap .filter_depth2_list .title_depth2 h3').each(function(index, tag){
                    if ($(this).parent().parent().hasClass('on')) {
                        // 추천 필터링 제어
                        $('.purpose-list li a').parent().parent().find('[data-set=sel][data-val=' + tag.id + '] a').addClass('on');
                        $('.m-filtering span').parent().parent().find('[data-set=sel][data-val=' + tag.id + '] span').addClass('on');
                        // 필터링 팝업 제어
                        $('input[name=selChk][value=' + tag.id + ']').click();
                        if (!$('.filter_list_wrap .filter_list').eq(4).hasClass('on')) {
                            $('.filter_list_wrap .filter_list').eq(4).click();
                        }
                        // 추천 필터링 진입시
                        if (isFiltering){
                            // 필터링 레이어 제어
                            $('.sell_eq .filter_depth2_wrap .filter_depth2_list .title_depth2 h3[id=' + tag.value + ']').click();
                            if (!$('.filter_list_wrap .filter_list').eq(1).hasClass('on')) {
                                $('.filter_list_wrap .filter_list').eq(1).click();
                            }
                        }
                    } else {
                        // 추천 필터링 제어
                        $('.purpose-list li a').parent().parent().find('[data-set=sel][data-val=' + tag.id + '] a').removeClass('on');
                        $('.m-filtering span').parent().parent().find('[data-set=sel][data-val=' + tag.id + '] span').removeClass('on');
                        // 필터링 팝업 제어
                        $('input[name=selChk][value=' + tag.id + ']').prop('checked', false);
                        // 추천 필터링 진입시
                        if (isFiltering){
                            // 필터링 레이어 제어
                            $('.sell_eq .filter_depth2_wrap .filter_depth2_list .title_depth2 h3[id=' + tag.value + ']').parent().parent().removeClass('on');
                        }
                    }
                });
            }

            // 교환 상품 선택 값
            // 기기, 종류, 색상
            var no_cate;
            if (isFilPage){
                no_cate = $('[id*=fil-chg].on').prop('id');
                if (typeof no_cate != 'undefined'){
                    // 필터링 레이어 제어
                    $('.search_tab #excgDevice li[id=' + no_cate.replace('fil-chg', '') + '] a').click();
                    if (!$('.filter_list_wrap .filter_list').eq(2).hasClass('on')) {
                        $('.filter_list_wrap .filter_list').eq(2).click();
                    }
                }
            } else {
                no_cate = $('.search_tab #excgDevice .on').prop('id');
                if (typeof no_cate != 'undefined'){
                    // 필터링 팝업 제어
                    $('[id=fil-chg' + no_cate + '] a').click();
                    if (!$('.filter_list_wrap .filter_list').eq(5).hasClass('on')) {
                        $('.filter_list_wrap .filter_list').eq(5).click();
                    }
                }
            }
            no_cate = typeof no_cate == 'undefined' ? '' : no_cate.replace('fil-chg', '');

            var no_device;
            if (isFilPage){
                no_device = $('[id*=fil-dvc].on').prop('id');
                if (typeof no_device != 'undefined'){
                    // 필터링 레이어 제어
                    $('.filter_depth2[id=' + no_device.replace('fil-dvc', '') + '] h3').click();
                    $('.filter_depth2[id=' + no_device.replace('fil-dvc', '') + '] .color_list_wrap').css('height', 'auto');
                }
            } else {
                no_device = $('.filter_depth2.on').prop('id');
                if (typeof no_device != 'undefined'){
                    // 필터링 레이어 제어
                    $('[id=fil-dvc' + no_device + '] a').click();
                }
            }
            no_device = typeof no_device == 'undefined' ? '' : no_device.replace('fil-dvc', '');

            var no_color = '';
            $('.color_list.on, .color-circle.on').each(function(index, tag){
                if (isFilPage){
                    // 필터링 레이어 제어
                    $('.filter_depth2[id=' +no_device+ '] .color_list[data-color=' + $(this).data('color') + ']').click();
                } else {
                    // 필터링 팝업 제어
                    $('.filter_depth2_new[class*=' + no_device + '] .color-circle[data-color=' + $(this).data('color') + ']').click();
                }
                no_color += $(this).data('color') + ',';
            });

            if(no_cate != '' || no_device != '' || no_color != '' || typeof sellVal != 'undefined' || serviceChkVal != ''){
                $('#excg_device_cate').val(no_cate);
                $('#excg_device_device').val(no_device);
                $('#excg_device_color').val(no_color);
                $('#sell_device_form').val(sellVal);
                $('#service_form').val(serviceChkVal);
                moment.onMoment(1, checkimg);
            }else{
                /*if (!isPurpose && !isFiltering) {
                    alert('적용 시킬 필터 항목을 선택해주세요');
                    return;
                }*/

                // 필터 타이틀 접기
                $('.main_panel .filter_list').each(function(){
                    var isShow = $(this).hasClass('on');
                    var toggleTarget = $(this).find('.filter');
                    $(this).removeClass('on')
                    TweenMax.to(toggleTarget, 0.6, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });
                })

                // 폼데이터 초기화
                $('#service_form').val('');
                $('#sell_device_form').val('');
                $('#excg_device_cate').val('');
                $('#excg_device_device').val('');
                $('#excg_device_color').val('');
            }

            // 필터 버튼 클릭시 값있을 경우만 검색
            var isDirectSearch = true;
            if(regionDepth1Keyword != '' && !distanceSearchFlag){
                isDirectSearch = false;
            }
            if(isDirectSearch){
                // 직접검색 탭에서 필터 적용 버튼 클릭
                var directSearchInput = $('#directSearchInput').val();
                var directSearchInput2 = $('#directSearchInput2').val();
                if((directSearchInput != '' || directSearchInput2 != '') && !distanceSearchFlag){
                    if (isFilPage || isFiltering) {
                        directSearch(true);
                    } else {
                        directSearch();
                    }
                }
                if(distanceSearchFlag){
                    if(distance == 1){
                        // 근처 서비스센터 바로보기
                        searchStoreByXY(myLat, myLng, myLat, myLng, distance, function(result){
                            successAction(result);
                            if (isFilPage || isFiltering) {
                                $('.fil-popup .btn_back').click();
                                $('.search-tag').click();
                            } else {
                                panelToggle(true, true, false, true);
                            }
                            if(storeListGDistance.length > 0){
                                moveMap(storeListGDistance[0].latitude, storeListGDistance[0].longitude, storeListGDistance[0].store_code);
                            }else{
                                moveMap(myLat, myLng);
                            }
                            loading.closePopup();
                        });
                    }else{
                        // 맵 이동
                        var center = kakaoMap.getCenter();
                        var latitude = center.getLat();
                        var longitude = center.getLng();
                        searchStoreByXY(myLat, myLng, latitude, longitude, distance, function(result){
                            successAction(result);
                            if(!isMobile.any){
                                if($(window).width() > 1024) {
                                    panelToggle(true, true, false, false);
                                }
                            }else{
                                // panelToggle(true, false, false, true);
                                $('.fil-popup .btn_back').click();
                                $('.search-tag').click();
                            }
                        });
                    }
                }
            } else {
                // 지역검색 탭에서 필터 적용 버튼 클릭
                getStoreListByRegion(regionDepth1Keyword, regionDepth2Keyword, true);
            }
            $('.search_store_result').parents('.panel_inner.scroll_area').animate({scrollTop: 0}, 300);

            <!-- PRD 만 노출 -->
            <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
            <c:if test="${profileId eq 'prd'}">
                if (serviceChkVal != ''){
                    dataLayer.push({
                        'event': 'storeLocatorTypeFilter',
                        'storeLocatorTypeFilter': 'Services'
                    });
                }
                if (typeof sellVal != 'undefined') {
                    dataLayer.push({
                        'event': 'storeLocatorTypeFilter',
                        'storeLocatorTypeFilter': 'Sale Devices'
                    });
                }
                if (no_cate != '' || no_device != '' || no_color != '') {
                    dataLayer.push({
                        'event': 'storeLocatorTypeFilter',
                        'storeLocatorTypeFilter': 'Exchange Devices'
                    });
                }
            </c:if>
        });

        // 필터 초기화 버튼
        $('.btn_wrap .btn .clear, .fil-popup-btns .reset').click(function(){
            filterInitialize();
            moment.onMoment(1, resettingimg);
        });
    });

    // 필터 초기화 스크립트
    function filterInitialize(){
        // 필터 타이틀 접기
        $('.main_panel .filter_list').each(function(){
            var isShow = $(this).hasClass('on');
            var toggleTarget = $(this).find('.filter');
            $(this).removeClass('on')
            TweenMax.to(toggleTarget, 0.6, {
                height: 0,
                ease: Expo.easeOut,
                force3D: true,
            });
        })

        // 교환기기 cate 선택해제
        $('.change_eq ul li').removeClass('on');

        // 기기별선택 해제
        $('.main_panel .filter_depth2 h3').each(function(){
            $(this).parents('.filter_depth2').removeClass('on')
            $(this).parents('.search_tab').removeClass('on')
            var siblingsTarget = $(this).parents('.filter_depth2').siblings('.filter_depth2').find('.color_list_wrap');
            TweenMax.to(siblingsTarget, 0.6, {
                height: 0,
                ease: Expo.easeOut,
                force3D: true,
            });
        });

        // 컬러 체크 해제
        $('.color_list').each(function(){
            if($(this).hasClass('on')){
                $(this).toggleClass('on');
                var color = $(this).attr('data-color');
                var targetArr = $(this).parents('.filter_depth2').find('.selected_color .colors span');
                var target;
                targetArr.each(function() {
                    var _this = $(this);
                    if (_this.attr('data-color') === color) {
                        return target = _this;
                    }
                    return;
                });
                target.toggle();
            }
        });

        // 필터 타이틀 on/off 초기화 (필터링 페이지 전용)
        $('.fil-popup .filter_list').removeClass('on');

        // 교환기기 초기화 (필터링 페이지 전용)
        $('.main_panel .change_eq').find('[id*=fil-chg]').removeClass('on');
        $('.main_panel .change_eq').find('[id*=fil-dvc]').removeClass('on');
        $('.main_panel .change_eq').find('.filter_depth2').removeClass('current');
        $('.main_panel .change_eq').find('.color-circle').removeClass('on');

        // 판매기기 초기화 (필터링 페이지 전용)
        $('.main_panel .sell_eq').find('[id*=fil-sel]').prop('checked', false);

        // 서비스 항목 체크 해제
        $('input[name=serviceChk]:checkbox').prop('checked', false);
        // 폼데이터 초기화
        $('#service_form').val('');
        $('#sell_device_form').val('');
        $('#excg_device_cate').val('');
        $('#excg_device_device').val('');
        $('#excg_device_color').val('');
    }



    // 필터 교환기기 초기화 스크립트
    function filterInitializeExcg(){
        // 교환기기 cate 선택해제
        $('.change_eq ul li').removeClass('on');

        // 기기별선택 해제
        $('.main_panel .filter_depth2 h3').each(function(){
            $(this).parents('.filter_depth2').removeClass('on')
            $(this).parents('.search_tab').removeClass('on')
            var siblingsTarget = $(this).parents('.filter_depth2').siblings('.filter_depth2').find('.color_list_wrap');
            TweenMax.to(siblingsTarget, 0.6, {
                height: 0,
                ease: Expo.easeOut,
                force3D: true,
            });
        });

        // 컬러 체크 해제
        $('.color_list').each(function(){
            if($(this).hasClass('on')){
                $(this).toggleClass('on');
                var color = $(this).attr('data-color');
                var targetArr = $(this).parents('.filter_depth2').find('.selected_color .colors span');
                var target;
                targetArr.each(function() {
                    var _this = $(this);
                    if (_this.attr('data-color') === color) {
                        return target = _this;
                    }
                    return;
                });
                target.toggle();
            }
        });
        // 폼데이터 초기화
        $('#service_form').val('');
        $('#sell_device_form').val('');
        $('#excg_device_cate').val('');
        $('#excg_device_device').val('');
        $('#excg_device_color').val('');
    }
</script>

<script>

    var storeDetailData;
    function getStoreDetail(store_code, clickSource){
        loading.openPopup();
        $.ajax({
            url : '<%=MainActionController.GET_STORE_DETAIL%>',
            method : 'post',
            data : {
                store_code : store_code
            },
            success : function(result){
                if(typeof result == 'undefined' || result ==''){
                    alert('해당 상점 정보가 없습니다.')
                    return ;
                }
                <!-- PRD 만 노출 -->
                <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
                <c:if test="${profileId eq 'prd'}">
                    var storeType = "";
                    if(result.store_type == '01'){
                        storeType = "IQOS Service Point"; // 공식 판매처
                    } else if(result.store_type == '03'){
                        storeType = "Stockist"; // 소매점
                    } else {
                        storeType = "IQOS Store"; // 직영매장
                    }
                    dataLayer.push({
                        'event': 'storeLocatorDetailsClick',
                        'storeLocatorStoreID': result.store_code,
                        'storeLocatorStoreName': result.store_name,
                        'storeLocatorStoreType': storeType,
                        'storeLocatorStoreClickSource': clickSource
                    });
                </c:if>
                storeDetailData = result;
                if(result.store_type != '04'){
                    makeHtmlStoreDetail(result);
                    makeHtmlSaleDeviceLeft(result.store_name, result.tel_num);
                    makeHtmlSaleDeviceRight(result.storeSellDeviceList, result.treat_yn);

                }else{
                    makeHtmlStoreDetailGS(result);
                }
                makeHtmlExcgDeviceLeft(result);
                makeHtmlExcgDeviceRight("");
                if($(window).width() > 1024) {
                    panelToggle(true,true,true,true);
                } else {
                    // 모바일
                    $('#mobileSearch').parent().addClass('on').siblings().removeClass('on');
                    TweenMax.to('.side_nav', 0.4, {autoAlpha: 1, ease: Expo.easeOut});
                    //panelToggle(true, resultPanelToggle, true, true);
                    $('.list-type-details').addClass('on');
                }
                loading.closePopup();
            }
        })
    }
    function getStoreDetail2(store_code, clickSource){
        loading.openPopup();
        $.ajax({
            url : '<%=MainActionController.GET_STORE_DETAIL%>',
            method : 'post',
            data : {
                store_code : store_code
            },
            success : function(result){
                <!-- PRD 만 노출 -->
                <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
                <c:if test="${profileId eq 'prd'}">
                var storeType = "";
                if(result.store_type == '01'){
                    storeType = "IQOS Service Point"; // 공식 판매처
                } else if(result.store_type == '03'){
                    storeType = "Stockist"; // 소매점
                } else {
                    storeType = "IQOS Store"; // 직영매장
                }
                dataLayer.push({
                    'event': 'storeLocatorDetailsClick',
                    'storeLocatorStoreID': result.store_code,
                    'storeLocatorStoreName': result.store_name,
                    'storeLocatorStoreType': storeType,
                    'storeLocatorStoreClickSource': clickSource
                });
                </c:if>
                storeDetailData = result;
                if(result.store_type != '04'){
                    makeHtmlStoreDetail(result);
                    makeHtmlSaleDeviceLeft(result.store_name, result.tel_num);
                    makeHtmlSaleDeviceRight(result.storeSellDeviceList, result.treat_yn);

                }else{
                    makeHtmlStoreDetailGS(result);
                }
                makeHtmlExcgDeviceLeft(result);
                makeHtmlExcgDeviceRight("");

                var mainPanelToggle = $('.side_nav').hasClass('on');
                var resultPanelToggle = $('.search_result_panel').hasClass('on');

                if($(window).width() > 1024) {
                    panelToggle(true, resultPanelToggle, true, true);
                } else {
                    // 모바일
                    $('#mobileSearch').parent().addClass('on').siblings().removeClass('on');
                    TweenMax.to('.side_nav', 0.4, {autoAlpha: 1, ease: Expo.easeOut});
                    //panelToggle(true, resultPanelToggle, true, true);
                    $('.list-type-details').addClass('on');
                }

                loading.closePopup();
            }
        })
    }

    /**
     * 매장 상세화면 교환기기현황/판매기기현황 레이어 팝업 열기
     * @param flag
     */
    function layerPopup(flag){
        // layer팝업 뜨기전 스크롤 상단으로 이동
        $('.change_layer .scroll_area').animate({scrollTop: 0}, 300);
        $('.sale_layer .scroll_area').animate({scrollTop: 0}, 300);

        var isToggle = $('.new-style-popup').hasClass('on');
        if(flag){
            $('.change_layer').fadeIn(300);
            if ( !isToggle ) {
                changePanel.open();
            }
        }else{
            $('.sale_layer').fadeIn(300);
        }
    }
</script>

<script>
    /// 매장 정보 공유
    function sharePopup(flag, id, store_type){
        // 모든 팝업 닫기
        $('.copy-comment').removeClass('on');
        $('.search_store_result').find('.store .share_popup').hide();
        $('.search_store_result').find('.store .share_popup .sms_share_form').slideUp(400, 'easeOutExpo');
        if(flag){
            // 팝업 열기
            $(id).parents('.option').find('.share_popup').show();

            <!-- PRD 만 노출 -->
            <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
            <c:if test="${profileId eq 'prd'}">
                var storeType = "";
                if(store_type == '01'){
                    storeType = "IQOS Service Point"; // 공식 판매처
                } else if(store_type == '03'){
                    storeType = "Stockist"; // 소매점
                } else {
                    storeType = "IQOS Store"; // 직영매장
                }
                dataLayer.push({
                    'event': 'storeShare',
                    'storeLocatorStoreType': storeType
                });
            </c:if>
        }else{
            // 팝업 닫기
            $(id).parents('.share_popup').hide();
        }
    }

    /// 매장 정보 공유 (지도 Ver)
    function sharePopupWrap(flag, code, name, addr, store_type){
        // code, name ,addr 입력
        $(".share_popup_wrap").data("code", code);
        $(".share_popup_wrap").data("name", name);
        $(".share_popup_wrap").data("addr", addr);
        if(flag){
            // 팝업 열기
            $('.share_popup_wrap').show();

            <!-- PRD 만 노출 -->
            <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
            <c:if test="${profileId eq 'prd'}">
                var storeType = "";
                if(store_type == '01'){
                    storeType = "IQOS Service Point"; // 공식 판매처
                } else if(store_type == '03'){
                    storeType = "Stockist"; // 소매점
                } else {
                    storeType = "IQOS Store"; // 직영매장
                }
                dataLayer.push({
                    'event': 'storeShare',
                    'storeLocatorStoreType': storeType
                });
            </c:if>
        }else{
            // 팝업 닫기
            $('.share_popup_wrap').hide();
        }
    }

    function sendKakaoLink(store_code, store_name, store_addr){
        var imageUrl = "<spring:eval expression="@config['share.kakao.link.main.image']"/>";
        var linkUrl = "<spring:eval expression="@config['share.link.url']"/>" + store_code;
        Kakao.Link.sendDefault({
            objectType: 'location',
            address: store_addr,
            addressTitle: store_name,
            content: {
                title: store_name,
                description : store_addr,
                imageUrl: imageUrl,
                link: {
                    mobileWebUrl: linkUrl,
                    webUrl: linkUrl
                }
            },
            buttons: [
                {
                    title: '상세보기',
                    link: {
                        mobileWebUrl: linkUrl,
                        webUrl: linkUrl
                    }
                }
            ]
        });
    }


    function sendSms(store_code, store_name, store_addr, isThis, actWhere){
        var phone = $(isThis).parent().parent().find('.sms_input_wrap input').val();

        if(typeof phone == 'undefined' || phone == ''){
            alert('전화번호를 입력해주세요.');
            return false;
        }

        $.ajax({
            url : '<%=SmsActionController.SEND_SMS%>',
            method : 'post',
            data : {
                store_code : store_code,
                store_name : store_name,
                store_addr : store_addr,
                phone : phone,
            },
            success : function(result){
                alert(result.message);
                if(result.result_code == 'OK'){
                    $('.search_store_result').find('.store .share_popup .sms_share_form').slideUp(400, 'easeOutExpo');
                    $(isThis).parent().parent().find('.sms_input_wrap input').val('');

                    <!-- PRD 만 노출 -->
                    <spring:eval expression="@config['profiles.profile.id']" var="profileId"/>
                    <c:if test="${profileId eq 'prd'}">
                        gtag('event', 'click', {
                            'event_category': actWhere,
                            'event_label': store_name + '_공유_SMS',
                            'value': 1
                        });
                    </c:if>
                }
            }
        })
    }
    function printPage(isThis){
        if(!isMobile.any){
            $(isThis).parents('.option').find('.share_popup').hide();
            var resultPanelisToggle = $('.search_result_panel').hasClass('on');
            var infoPanelisToggle = $('.info_panel').hasClass('on');
            panelToggle(false,resultPanelisToggle,infoPanelisToggle,false);
            setTimeout(function(){
                window.print();
                panelToggle(true, resultPanelisToggle, infoPanelisToggle, true);
            }, 300)
        }else{
            alert('모바일에서는 해당 기능을 지원하지 않습니다.');
        }
    }

    /**
     * 설문조사 팝업 오픈
     */
    function surveyPopup(){
        survey.openPopup();
    }
    /**
     * 설문조사 제출
     */
    function sendSurvey(){
        var point = $('input[name=serveyPoint]:checked').val();
        // deviceType - 01 : PC, 02 : Mobile
        var deviceType = isMobile.any ? '02' : '01';

        if(typeof point == 'undefined' || point == null || point == ''){
            alert('만족도를 선택해주세요')
            return ;
        }
        loading.openPopup();
        $.ajax({
            url : '<%=MainActionController.SEND_SURVEY%>',
            method : 'post',
            data : {
                score : point,
                device_type : deviceType
            },
            success : function(result){
                loading.closePopup();
                alert(result.message);
                // 초기화
                survey.closePopup()
                $('input[name=serveyPoint]:checked').prop('checked', false);
            }
        })
    }


</script>
<script>
    /**
     * 해당 판넬 컨트롤 여부
     * @param mainPanel, resultPanel, infoPanel, changeTabFlag
     */
    function panelToggle(mainPanelFlag, resultPanelFlag, infoPanelFlag, changeTabFlag){
        var mainPanelisToggle = $('.side_nav').hasClass('on');
        if(mainPanelFlag){
            if( !mainPanelisToggle ){
                mainPanel.open();
            }
        }else{
            if( mainPanelisToggle ){
                mainPanel.close();
            }
        }

        var resultPanelisToggle = $('.search_result_panel').hasClass('on');
        if(resultPanelFlag){
            if( !resultPanelisToggle ){
                resultPanel.open();
            }
        }else{
            if( resultPanelisToggle ){
                resultPanel.close();
            }
        }

        var infoPanelisToggle = $('.info_panel').hasClass('on');
        if(infoPanelFlag){
            if( !infoPanelisToggle ){
                infoPanel.open();
            }
        }else{
            if( infoPanelisToggle ){
                infoPanel.close();
            }
        }

        var changeTabisToggle = $('.mobile_change_tab').hasClass('on');
        if(changeTabFlag){
            if( !changeTabisToggle ){
                changeTab.open();
            }
        }else{
            if( changeTabisToggle ){
                changeTab.close();
            }
        }
    }


    function successAction(result,idx){
        storeListGType = [];
        // console.log(result," : ",idx)
        if(Object.keys(result.typeList).length === 0){
            //  비었을때
            if(idx == 1) {
                makeHtmlStoreListEmpty(1);
            }else{
                makeHtmlStoreListEmpty();
            }
        }else{
            storeListGType = result.typeList;
            makeHtmlStoreList(result.typeList);
            //makeHtmlStoreListByDistance(result.distanceList);
        }
    }

    // 근처매장 바로보기
    $(document).ready(function(){
        $('.near_store a, .m-map-icon').click(function(){
            loading.openPopup();

            $('#directSearchInput').val('');
            $('#directSearchInput2').val('');
            getMyCurrentPostion(function(lat, lng){
                // 내위치 정보 갖고 와서 모든 매장 위경도 좌표와 비교 후 내위치지 기준 1km이내 20개 뿌려주기
                searchStoreByXY(lat, lng, lat, lng, 1, function(result){
                    successAction(result);
                    if(storeListGDistance.length > 0){
                        moveMap(storeListGDistance[0].latitude, storeListGDistance[0].longitude, storeListGDistance[0].store_code);
                    }else{
                        moveMap(lat, lng);
                    }
                    if (!isMobile.any) {
                        if($(window).width() > 1024) {
                            panelToggle(true, true, false, true);
                        }
                    }
                    distanceSearchFlag = true;
                    distance = 1;
                    loading.closePopup();
                });
            }, function(error){
                geoLocationErrorCallback(error);
                searchStoreByXY(myLat, myLng, myLat, myLng, 1, function(result){
                    successAction(result);
                    if(storeListGDistance.length > 0){
                        moveMap(storeListGDistance[0].latitude, storeListGDistance[0].longitude, storeListGDistance[0].store_code);
                    }else{
                        moveMap(myLat, myLng);
                    }
                    distanceSearchFlag = true;
                    distance = 1;
                    if (!isMobile.any) {
                        if($(window).width() > 1024) {
                            panelToggle(true, true, false, true);
                        }
                    }
                    loading.closePopup();
                });
            });
        });
    });

    function searchStoreByXY(myLat, myLng, lat, lng, distance, successCallback){
        distanceSearchFlag = true;
        $.ajax({
            url : '<%=MainActionController.GET_STORE_LIST_BY_XY%>',
            method : 'post',
            data : $('#filterForm').serialize() + '&myLat='+ myLat + '&myLng=' + myLng + '&latitude=' + lat + '&longitude=' + lng+ '&distance='+distance,
            success : function(result){
                successCallback(result);
                // 말풍선 꼬리 삭제
                $('.iqos_info_window').parent().prev().hide();
            }
        })
    }

    // 매장 검색 결과 > 유형순/거리순 버튼 이벤트 처리
    $(document).ready(function(){
        $('.sub_panel_title .result_type ul #type').click(function(){
            // 매장 유형별 선택
            if(storeListGType.length == 0){
                makeHtmlStoreListEmpty();
            }else{
                makeHtmlStoreList(storeListGType);
            }
        })
        $('.sub_panel_title .result_type ul #distance').click(function(){
            if(storeListGDistance.length == 0){
                makeHtmlStoreListEmpty();
            }else{
                // 거리순
//                storeListGDistance.sort(function(a, b){
//                    return a.distance < b.distance ? -1 : a.distance > b.distance ? 1 : 0;
//                });
                makeHtmlStoreListByDistance(storeListGDistance);
            }
        })
    })

    /**
     * 매장 검색 결과 > 유형순 > 아코디언 이벤트 바인딩
     */
    function storeClick() {
        $('.store_type h2').on({
            click: function() {
                // 서비스센터 검색 결과 매장 타입별
                var isToggle = $(this).parent().hasClass('on');
                var _this = $(this);
                if ( !isToggle ) {
                    $(this).parent().addClass('on');
                    var target = $(this).siblings('.store_list_wrap');

                    TweenMax.set(target, {
                        height: 'auto'
                    });
                    TweenMax.from(target, 0.4, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                        onComplete: function() {
                            if(!isMobile.any){
                                customScroll.updateScroll();
                            }
                            if (parseInt(_this.find('span').text()) <= 1) {
                                target.addClass('one');
                            }else{
                                TweenMax.set(target, {
                                    height : target.height() + 28
                                })
                            }
                        },
                        onStart: function() {
//                            if(!isMobile.any){
                                _this.parents('.panel_inner.scroll_area').animate({scrollTop: 0}, 300);
//                            }
                        }
                    });

                    $(this).parent().siblings('.store_type').removeClass('on');
                    var siblingsTarget = $(this).parent().siblings('.store_type').find('.store_list_wrap');
                    TweenMax.to(siblingsTarget, 0.4, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                        onStart: function() {
                            siblingsTarget.removeClass('one');
                        }
                    });
                } else {
                    $(this).parent().removeClass('on');
                    var target = $(this).siblings('.store_list_wrap');

                    TweenMax.to(target, 0.4, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                        onComplete: function() {
                            if(!isMobile.any){
                                customScroll.updateScroll();
                            }
                        },
                        onStart: function() {
//                            if(!isMobile.any){
                                _this.parents('.panel_inner.scroll_area').animate({scrollTop: 0}, 300);
                                target.removeClass('one');
//                            }
                        }
                    });
                }
            }
        });
    }
</script>
<script>
    //HTML 그리는 함수 모음
    /**
     * 매장 검색 결과 유형순
     * @param storeList
     */
    function makeHtmlStoreList(result){
        hideMarkers();
        var cnt = 0;
        var html= ''
        for(var key in result){
            /*html += '<div class="store_type">';
            html += '<h2>';
            html += result[key].storeTypeName;
            html += '<span>';
            html += result[key].storeList.length;
            html += '</span></h2>';*/
            html += '<div class="store_list_wrap">';
            for(var j = 0; j < result[key].storeList.length ; j++){
                var store = result[key].storeList[j];
                html += '<div class="store';
                if(j == (result[key].storeList.length-1)){
                    html += ' one';
                }
                html += '">';
                html += '<div class="store_name">';
                html += '<h3 style = "cursor:pointer;"onclick="javascript:moveMap(\'' + store.latitude + '\',\'' + store.longitude + '\',\'' + store.store_code + '\',\'Y\')">';
                html += store.store_name;
                html += '<span class="distance">';
                html += store.distance.toFixed(2) + 'km';
                html += '</span>';
                html += '</h3>';
                html += '</div>';
                html += '<div class="is_store_on">';
                html += '<span class="tag type_' + store.store_type + '">';
                html += store.store_type_name;
                html += '</span>'
                html += '<span ';
                html += store.oper_flag ? 'class="live"' : store.closed_flag ? 'class="closed"' : 'class="oper_end"';
                html += '>'
                html += store.oper_flag ? '영업중' :  store.closed_flag ? '휴무일' : '영업시간종료';
                html += '</span>'
                html += '</div>';
                html += '<div class="option">';
                html += '<div class="nav" onclick="javascript:moveKaKaoMap(\'' + store.store_addr + '\',\'' + store.latitude+ '\',\'' + store.longitude + '\',\'' + store.store_type + '\')">';
                html += '<a href="javascript:;">길찾기</a></div>';
                if (isMobile.any) {
                    html += '<div class="detail"><a href="javascript:;" onclick="javascript:getStoreDetail2(\''+store.store_code+'\',\'list\')">매장 상세정보</a></div>';
                } else {
                    html += '<div class="detail"><a href="javascript:;" onclick="javascript:getStoreDetail(\''+store.store_code+'\',\'list\')">매장 상세정보</a></div>';
                }
                html += '<div class="share"><a href="javascript:;" onclick="javascript:sharePopup(true, this, \''+store.store_type+'\');">공유하기</a></div>';

                html += '<div class="share_popup">';
                html += '<div class="share_popup_wraps">';
                html += '<div class="share_popup_close" onclick="javascript:sharePopup(false, this, \''+store.store_type+'\');"></div>';
                html += '<div class="share_list">';
                html += '<div class="share kakaotalk">';
                html += '<div class="img_wrap" onclick="javascript:sendKakaoLink(\'' + store.store_code + '\',\'' + store.store_name + '\',\'' + store.store_addr + '\')">';
                html += '<img src="${imagePath}/kakao.svg">';
                html += '</div><p>카카오톡</p></div>';
                /*html += '<div class="share sms">';
                html += '<div class="img_wrap">';
                html += '<img src="${imagePath}/store/icon/sms.jpg">';
                html += '</div><p>SMS</p></div>';*/
                html += '<div class="share copy">';
                html += '<div class="img_wrap" onclick="javascript:copyStoreUrl(\'' + store.store_code + '\');">';
                html += '<img src="${imagePath}/url_copy.svg">';
                html += '</div><p>URL복사</p></div>';
                html += '<div class="share print">';
                html += '<div class="img_wrap" onclick="javascript:printPage(this);">';
                html += '<img src="${imagePath}/store/icon/print.svg">';
                html += '</div><p>인쇄</p></div>';
                html += '</div>';
                html += '<p class="copy-comment"><span>URL이 복사되었습니다.</span></p>';
                html += '<div class="sms_share_form">';
                html += '<div class="sms_input_wrap">';
                html += '<input type="tel" placeholder="전화번호를 입력해주세요">'
                html += '</div>';
                html += '<div class="sms_submit_wrap">';
                html += '<button onclick="javascript:sendSms(\'' + store.store_code + '\',\''+ store.store_name + '\',\'' + store.store_addr + '\',' + 'this,\'list\');">';
                html += 'SMS 공유하기'
                html += '</button>';
                html += '</div>';
                html += '</div>';
                html += '</div>';
                html += '</div>';
                html += '</div>';
                html += '<div class="store_info">';
                if(store.oper_time != null && store.oper_time != ''){
                    html += '<p>'
                    html += '영업시간 : ' + store.oper_time;
                    html += '</p>'
                }
                if(store.as_time != null && store.as_time != ''){
                    html += '<p>'
                    html += 'A/S서비스 시간 : ' + store.as_time;
                    html += '</p>'
                }
                if(store.tel_num != null && store.tel_num != ''){
                    html += '<p>'
                    html += '전화번호 : ' + store.tel_num;
                    html += '</p>'
                }
                if(store.store_addr != null && store.store_addr != ''){
                    html += '<p>'
                    html += '주소 : ' + store.store_addr;
                    if(store.store_addr_dtl != null && store.store_addr_dtl != ''){
                        html += ' ' + store.store_addr_dtl;
                    }
                    html += '</p>';
                }
                /*if(store.service_name != null && store.service_name != ''){
                    html += '<p>';
                    html += '제공서비스 : ' + store.service_name;
                    html += '</p>';
                }*/
                html += '</div>';
                html += '<ul class="info-list clearfix">';
                for(var i = 0 ; i < store.storeServiceList.length ; i++){
                    html += '<li>';
                    html += '<span class="icon-area">';
                    if((store.storeServiceList[i].file_path != null && store.storeServiceList[i].file_path != '') &&
                        (store.storeServiceList[i].save_name != null && store.storeServiceList[i].save_name != '')) {
                        var serviceImgUrl = store.storeServiceList[i].file_path + store.storeServiceList[i].save_name
                        html += '<img src="'+serviceImgUrl+'">';
                    }
                    html += "</span>";
                    html += '<span class="icon-name">';
                    // var serviceNameArr = store.storeServiceList[i].service_name.split(' ');
                    var serviceNameArr = store.storeServiceList[i].service_name;
                    // if(serviceNameArr.length >= 2){
                    //     for(var k = 0; k < serviceNameArr.length ; k++){
                    //         if(k == 1){
                    //             html += '<br>';
                    //         }else{
                    //             html += ' ';
                    //         }
                    //         html += serviceNameArr[k];
                    //     }
                    // }else{
                    //     html += serviceNameArr[0];
                    // }
                    html += serviceNameArr;
                    html += "</span>";
                    html += '</li>';
                }
                html += '</ul>';
                /*html += '<div class="more_info" onclick="javascript:getStoreDetail(\''+store.store_code+'\')">';
                html += '<a href="javascript:;">More Info</a>';
                html += '</div>';*/

                html += '</div>';
                storeListGDistance.push(store);
                cnt++;
            }
            html += '</div>'
            //html += '</div>';

        }

        $('.sub_panel_title h3').text('서비스센터 검색 결과 (' + cnt + ')');
        $('.sub_panel_title').show();

        markerCreate(storeListGDistance);
        // $('.m-filtering').show();
        $('.search_store_result').empty();
        $('.search_store_result').append(html);
        //storeClick();
        $('.share.sms').off().click(function() {
            $(this).parents('.share_popup').find('.sms_share_form').stop().slideToggle(400, 'easeOutExpo');
        });
        $('.search_store_result').parents('.panel_inner.scroll_area').animate({scrollTop: 0}, 300);
    }

    /**
     * 매장 검색 결과 거리순
     * @param storeList
     */
    function makeHtmlStoreListByDistance(result){
        $('.sub_panel_title .result_type ul li').removeClass('on');
        $('.sub_panel_title .result_type ul #distance').addClass('on');
        $('.sub_panel_title h3').text('서비스센터 검색 결과 (' + result.length + ')');
        $('.sub_panel_title').show();
        hideMarkers();
        markerCreate(result);
        var html ='';
        for(var j = 0; j < result.length ; j++){
            var store = result[j];
            html += '<div class="store">';
            html += '<div class="store_name">';
            html += '<h3 style = "cursor:pointer;"onclick="javascript:moveMap(\'' + store.latitude + '\',\'' + store.longitude + '\',\'' + store.store_code + '\',\'Y\')">';
            html += store.store_name;
            html += '<span class="distance">';
            html += store.distance.toFixed(2) + 'km';
            html += '</span>';
            html += '</h3>';
            html += '</div>';
            html += '<div class="is_store_on">';
            html += '<span ';
            html += store.oper_flag ? 'class="live"' : store.closed_flag ? 'class="closed"' : 'class="oper_end"';
            html += '>'
            html += store.oper_flag ? '영업중' :  store.closed_flag ? '휴무일' : '영업시간종료';
            html += '</span>'
            html += '</div>';
            html += '<div class="store_info">';
            if(store.oper_time != null && store.oper_time != ''){
                html += '<p>'
                html += '영업시간 : ' + store.oper_time;
                html += '</p>'
            }
            if(store.as_time != null && store.as_time != ''){
                html += '<p>'
                html += 'A/S 서비스 시간 : ' + store.as_time;
                html += '</p>'
            }
            if(store.tel_numm != null && store.tel_num != ''){
                html += '<p>'
                html += '전화번호 : ' + store.tel_num;
                html += '</p>'
            }
            if(store.store_addr != null && store.store_addr != ''){
                html += '<p>'
                html += '주소 : ' + store.store_addr;
                if(store.store_addr_dtl != null && store.store_addr_dtl != ''){
                    html += ' ' + store.store_addr_dtl;
                }
                html += '</p>';
            }
            if(store.service_name != null && store.service_name != ''){
                html += '<p>';
                html += '제공서비스 : ' + store.service_name;
                html += '</p>';
            }
            html += '</div>';
            // html += '<div class="more_info" onclick="javascript:getStoreDetail(\''+store.store_code+'\',\'map\')">';
            // html += '<a href="javascript:;">More Info</a>';
            // html += '</div>';
            html += '<div class="option">';
            html += '<div class="nav" onclick="javascript:moveKaKaoMap(\'' + store.store_addr + '\',\'' + store.latitude+ '\',\'' + store.longitude + '\',\'' + store.store_type + '\')">';
            html += '<a href="javascript:;">길찾기</a></div>';
            html += '<div class="more_info detail" onclick="javascript:getStoreDetail(\''+store.store_code+'\',\'map\')">';
            html += '<a href="javascript:;">매장 상세정보</a>';
            html += '</div>';
            html += '<div class="share"><a href="javascript:;" onclick="javascript:sharePopup(true, this, \''+store.store_type+'\');">공유하기</a></div>';
            html += '<div class="share_popup">';
            html += '<div class="share_popup_wraps">';
            html += '<div class="share_popup_close" onclick="javascript:sharePopup(false, this, \''+store.store_type+'\');"></div>';
            html += '<div class="share_list">';
            html += '<div class="share kakaotalk">';
            html += '<div class="img_wrap" onclick="javascript:sendKakaoLink(\'' + store.store_code + '\',\'' + store.store_name + '\',\'' + store.store_addr + '\')">';
            html += '<img src="${imagePath}/kakao.svg">';
            html += '</div><p>카카오톡</p></div>';
            /*html += '<div class="share sms">';
            html += '<div class="img_wrap">';
            html += '<img src="${imagePath}/store/icon/sms.jpg">';
            html += '</div><p>SMS</p></div>';*/
            html += '<div class="share copy">';
            html += '<div class="img_wrap" onclick="javascript:copyStoreUrl(\'' + store.store_code + '\');">';
            html += '<img src="${imagePath}/url_copy.svg">';
            html += '</div><p>URL복사</p></div>';
            html += '<div class="share print">';
            html += '<div class="img_wrap" onclick="javascript:printPage(this);">';
            html += '<img src="${imagePath}/store/icon/print.svg">';
            html += '</div><p>인쇄</p></div>';
            html += '</div>';
            html += '<p class="copy-comment"><span>URL이 복사되었습니다.</span></p>';
            html += '<div class="sms_share_form">';
            html += '<div class="sms_input_wrap">';
            html += '<input type="tel" placeholder="전화번호를 입력해주세요">'
            html += '</div>';
            html += '<div class="sms_submit_wrap">';
            html += '<button onclick="javascript:sendSms(\'' + store.store_code + '\',\''+ store.store_name + '\',\'' + store.store_addr + '\',' + 'this,\'list\');">';
            html += 'SMS 공유하기'
            html += '</button>';
            html += '</div>';
            html += '</div>';
            html += '</div>';
            html += '</div>';
            html += '</div>';
            html += '</div>';
        }
        // $('.m-filtering').show();
        $('.search_store_result').empty();

        $('.search_store_result').append(html);
        $('.share.sms').off().click(function() {
            $(this).parents('.share_popup').find('.sms_share_form').stop().slideToggle(400, 'easeOutExpo');
        });
        storeListGDistance = result;
        $('.search_store_result').parents('.panel_inner.scroll_area').animate({scrollTop: 0}, 300);
    }


    function makeHtmlStoreListEmpty(idx){
        if(idx == 1){
            var html= '<div class="result-txt" style="display: block;"><p>해당 지역에 검색결과가 없습니다.<br>인근 지역으로 검색해주세요.</p><div>';
        }else{
            var html= '<div class="result-txt" style="display: block;"><p>해당 검색어로 검색결과가 없습니다.<br>다른검색어를 입력해주세요.</p><div>';
        }

        // $('.sub_panel_title h3').text('서비스센터 검색 결과 (0)');
        $('.sub_panel_title').hide();
        // $('.m-filtering').hide();
        $('.search_store_result').empty();
        $('.search_store_result').append(html);
        hideMarkers();
    }

    /**
     * 매장 상세화면(GS제외)
     * @param store
     */
    function makeHtmlStoreDetail(store){
        var html = '';
        html += '<div class="store_img swiper-container">';
        html += '<div class="swiper-wrapper">';
        for(var i = 0; i < store.storePhotoList.length ; i++){
            var imgUrl = store.storePhotoList[i].file_path + store.storePhotoList[i].save_name;
            // var imgUrl = '//via.placeholder.com/350x150';
            html += '<div class="swiper-slide">';
            html += '<div class="img_rwd_wrap" style="background-image:url(' +imgUrl+ ')"></div>';
            html += '</div>';
        }
        html += '</div>';
        html += '<div class="swiper-pagination store_pg"></div>';
        html += '</div>';
        html += '<div class="option">';
        html += '<div class="nav" onclick="javascript:moveKaKaoMap(\'' + store.store_addr + '\',\'' + store.latitude+ '\',\'' + store.longitude + '\',\'' + store.store_type + '\')">'
        html += '<a href="javascript:;">길찾기</a>'
        html += '</div>';
        html += '<div class="share">';
        html += '<div class="share"><a href="javascript:;" onclick="javascript:sharePopup(true, this, \''+store.store_type+'\');">공유하기</a></div>';
        html += '</div>';
        html += '<div class="share_popup">';
        html += '<div class="share_popup_wraps">';
        html += '<div class="share_popup_close" onclick="javascript:sharePopup(false, this, \''+store.store_type+'\');"></div>';
        html += '<div class="share_list">';
        html += '<div class="share kakaotalk">';
        html += '<div class="img_wrap" onclick="javascript:sendKakaoLink(\'' + store.store_code + '\',\'' + store.store_name + '\',\'' + store.store_addr + '\')">';
        html += '<img src="${imagePath}/kakao.svg">';
        html += '</div><p>카카오톡</p></div>';
        /*html += '<div class="share sms">';
        html += '<div class="img_wrap">';
        html += '<img src="${imagePath}/store/icon/sms.jpg">';
        html += '</div><p>SMS</p></div>';*/
        html += '<div class="share copy">';
        html += '<div class="img_wrap" onclick="javascript:copyStoreUrl(\'' + store.store_code + '\');">';
        html += '<img src="${imagePath}/url_copy.svg">';
        html += '</div><p>URL복사</p></div>';
        html += '<div class="share print">';
        html += '<div class="img_wrap" onclick="javascript:printPage(this);">';
        html += '<img src="${imagePath}/store/icon/print.svg">';
        html += '</div><p>인쇄</p></div>';
        html += '</div>';
        html += '<p class="copy-comment"><span>URL이 복사되었습니다.</span></p>';
        html += '<div class="sms_share_form">';
        html += '<div class="sms_input_wrap">';
        html += '<input type="tel" placeholder="전화번호를 입력해주세요">'
        html += '</div>';
        html += '<div class="sms_submit_wrap">';
        html += '<button onclick="javascript:sendSms(\'' + store.store_code + '\',\''+ store.store_name + '\',\'' + store.store_addr + '\',' + 'this,\'Store_info\');">';
        html += 'SMS 공유하기'
        html += '</button>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        html += '<div class="store_info_wrap">';
        /*html += '<div class="store_name" style = "cursor:pointer;" onclick="javascript:moveMap(\'' + store.latitude + '\',\'' + store.longitude + '\',\'' + store.store_code + '\')">';
        html += '<h3>' + store.store_name + '</h3>';
        html += '</div>';*/

        html += '<div class="info_wrapper">';
        html += '<h4>';
        html += '영업현황';
        html += '<div class="is_store_on tag-live">';
        html += '<span ';
        html += store.oper_flag ? 'class="live"' : store.closed_flag ? 'class="closed"' : 'class="oper_end"';
        html += '>';
        html += store.oper_flag ? '영업중' :  store.closed_flag ? '휴무일' : '영업시간종료';
        html += '</span>';
        html += '</div>';
        html += '</h4>';
        html += '<div class="store_info">';
        if(store.oper_time != null && store.oper_time != ''){
            html += '<p>영업 시간 : ' + store.oper_time + '</p>';
        }
        if(store.as_time != null && store.as_time != ''){
            html += '<p>A/S서비스 시간 : ' + store.as_time + '</p>';
        }
        html += '</div></div>';
        html += '<div class="info_wrapper">';
        html += '<h4>서비스 센터 정보</h4>';
        html += '<div class="store_info">';
        if(store.tel_num != null && store.tel_num != ''){
            html += '<p>전화번호 : '+ store.tel_num + '</p>';
        }
        if(store.store_addr != null && store.store_addr != ''){
            html += '<p>주소 : ' + store.store_addr;
            if(store.store_addr_dtl != null && store.store_addr_dtl != ''){
                html += ' ' + store.store_addr_dtl;
            }
            html += '</p>';
        }
        if(store.come_way != null && store.come_way != ''){
            html += '<p>찾아오는길 : ' + store.come_way + '</p>';
        }
        html += '<p>주차가능여부 : ' + (store.parking_yn == 'Y' ? '가능' : '불가능') + '</p>';
        html += '</div>';
        if(store.notice != null && store.notice != ''){
            html += '<div class="message">';
            // html += '<h5>MESSAGE</h5>';
            html += '<p>' + store.notice.replace(/\n/gi, '<br/>') + '</p>';
            html += '</div>';
        }
        html += '</div>';
        html += '<div class="info_wrapper">';
        html += '<h4>제공 서비스</h4>';
        html += '<ul class="info-list clearfix">';
        for(var i = 0 ; i < store.storeServiceList.length ; i++){
            html += '<li>';
            html += '<span class="icon-area">';
            if((store.storeServiceList[i].file_path != null && store.storeServiceList[i].file_path != '') &&
                (store.storeServiceList[i].save_name != null && store.storeServiceList[i].save_name != '')) {
                var serviceImgUrl = store.storeServiceList[i].file_path + store.storeServiceList[i].save_name
                html += '<img src="'+serviceImgUrl+'">';
            }
            html += "</span>";
            html += '<span class="icon-name">';
            // var serviceNameArr = store.storeServiceList[i].service_name.split(' ');
            var serviceNameArr = store.storeServiceList[i].service_name;
            // if(serviceNameArr.length >= 2){
            //     for(var k = 0; k < serviceNameArr.length ; k++){
            //         if(k == 1){
            //             html += '<br>';
            //         }else{
            //             html += ' ';
            //         }
            //         html += serviceNameArr[k];
            //     }
            // }else{
            //     html += serviceNameArr[0];
            // }
            html += serviceNameArr;
            html += "</span>";
            html += '</li>';
        }
        html += '</ul>';
        html += '</div>';
        html += '<div class="others">';
        html += '<ul>';
        html += '<li><a href="#" class="popup changepop" onclick="layerPopup(true)">교환기기 현황</a></li>'
        html += '<li><a href="#" class="popup salepop" onclick="layerPopup(false)">판매기기 현황</a></li>'
        html += '<li><a href="#" onclick="surveyPopup()">설문조사</a></li>'
        html += '</ul>';
        html += '</div>';
        <%--html += '<div class="option">';--%>
        <%--html += '<div class="nav" onclick="javascript:moveKaKaoMap(\'' + store.store_addr + '\',\'' + store.latitude+ '\',\'' + store.longitude + '\',\'' + store.store_type + '\')">'--%>
        <%--html += '<a href="javascript:;">길찾기</a>'--%>
        <%--html += '</div>';--%>
        <%--html += '<div class="share">';--%>
        <%--html += '<div class="share"><a href="javascript:;" onclick="javascript:sharePopup(true, this, \''+store.store_type+'\');">공유</a></div>';--%>
        <%--html += '</div>';--%>
        <%--html += '<div class="share_popup">';--%>
        <%--html += '<div class="share_popup_close" onclick="javascript:sharePopup(false, this, \''+store.store_type+'\');"></div>';--%>
        <%--html += '<div class="share_list">';--%>
        <%--html += '<div class="share kakaotalk">';--%>
        <%--html += '<div class="img_wrap" onclick="javascript:sendKakaoLink(\'' + store.store_code + '\',\'' + store.store_name + '\',\'' + store.store_addr + '\')">';--%>
        <%--html += '<img src="${imagePath}/store/icon/kakao.jpg">';--%>
        <%--html += '</div><p>카카오톡</p></div>';--%>
        <%--/*html += '<div class="share sms">';--%>
        <%--html += '<div class="img_wrap">';--%>
        <%--html += '<img src="${imagePath}/store/icon/sms.jpg">';--%>
        <%--html += '</div><p>SMS</p></div>';*/--%>
        <%--html += '<div class="share copy">';--%>
        <%--html += '<div class="img_wrap" onclick="javascript:copyStoreUrl(\'' + store.store_code + '\');">';--%>
        <%--html += '<img src="${imagePath}/copy.png">';--%>
        <%--html += '</div><p>URL복사</p></div>';--%>
        <%--html += '<div class="share print">';--%>
        <%--html += '<div class="img_wrap" onclick="javascript:printPage(this);">';--%>
        <%--html += '<img src="${imagePath}/store/icon/print.jpg">';--%>
        <%--html += '</div><p>인쇄</p></div>';--%>
        <%--html += '</div>';--%>
        <%--html += '<p class="copy-comment"><span>URL이 복사되었습니다.</span></p>';--%>
        <%--html += '<div class="sms_share_form">';--%>
        <%--html += '<div class="sms_input_wrap">';--%>
        <%--html += '<input type="tel" placeholder="전화번호를 입력해주세요">'--%>
        <%--html += '</div>';--%>
        <%--html += '<div class="sms_submit_wrap">';--%>
        <%--html += '<button onclick="javascript:sendSms(\'' + store.store_code + '\',\''+ store.store_name + '\',\'' + store.store_addr + '\',' + 'this,\'Store_info\');">';--%>
        <%--html += 'SMS 공유하기'--%>
        <%--html += '</button>';--%>
        <%--html += '</div>';--%>
        <%--html += '</div>';--%>
        html += '</div></div></div>';

        $('.list-type-details .panel_inner').empty();
        $('#storeDetailPanel .panel_inner').empty();

        $('.list-type-details .store-name').html(store.store_name);
        $('#storeDetailPanel .store-name').html(store.store_name);

        $('.list-type-details .panel_inner').append(html);
        $('#storeDetailPanel .panel_inner').append(html);

        $('.share.sms').off().click(function() {
            $(this).parents('.share_popup').find('.sms_share_form').stop().slideToggle(400, 'easeOutExpo');
        });

        /// 매장 정보 판 - 매장 사진 슬라이더
        var storeSl = new Swiper('.list-type-details .store_img, #storeDetailPanel .store_img', {
            observer: true,
            observeParents: true,
            watchOverflow: true,
            pagination: {
                el: '.store_pg',
                type: 'bullets',
                clickable: true,
            },
        });

        $('.list-type-details .panel_inner.scroll_area').animate({scrollTop: 0}, 0);
        $('#storeDetailPanel .panel_inner.scroll_area').animate({scrollTop: 0}, 0);
    }

    /**
     * 매장 상세 화면(GS)
     * @param store
     */
    function makeHtmlStoreDetailGS(store){
        var pickupServiceChk = store.storeServiceList.filter((elem) => { // 교환픔 픽업서비스 제공 여부 체크
            return (elem.no_service.indexOf("009") > -1);
        });

        var html = '';
        html += '<div class="option">';
        html += '<div class="nav" onclick="javascript:moveKaKaoMap(\'' + store.store_addr + '\',\'' + store.latitude+ '\',\'' + store.longitude + '\',\'' + store.store_type + '\')">';
        html += '<a href="javascript:;">길찾기</a>'
        html += '</div>';
        html += '<div class="share">';
        html += '<div class="share"><a href="javascript:;" onclick="javascript:sharePopup(true, this, \''+store.store_type+'\');">공유하기</a></div>';
        html += '</div>';
        html += '<div class="share_popup">';
        html += '<div class="share_popup_close" onclick="javascript:sharePopup(false, this, \''+store.store_type+'\');"></div>';
        html += '<div class="share_list">';
        html += '<div class="share kakaotalk">';
        html += '<div class="img_wrap" onclick="javascript:sendKakaoLink(\'' + store.store_code + '\',\'' + store.store_name + '\',\'' + store.store_addr + '\')">';
        html += '<img src="${imagePath}/kakao.svg">';
        html += '</div><p>카카오톡</p></div>';
        /*html += '<div class="share sms">';
        html += '<div class="img_wrap">';
        html += '<img src="${imagePath}/store/icon/sms.jpg">';
        html += '</div><p>SMS</p></div>';*/
        html += '<div class="share copy">';
        html += '<div class="img_wrap" onclick="javascript:copyStoreUrl(\'' + store.store_code + '\');">';
        html += '<img src="${imagePath}/url_copy.svg">';
        html += '</div><p>URL복사</p></div>';
        html += '<div class="share print">';
        html += '<div class="img_wrap" onclick="javascript:printPage(this);">';
        html += '<img src="${imagePath}/store/icon/print.svg">';
        html += '</div><p>인쇄</p></div>';
        html += '</div>';
        html += '<p class="copy-comment"><span>URL이 복사되었습니다.</span></p>';
        html += '<div class="sms_share_form">';
        html += '<div class="sms_input_wrap">';
        html += '<input type="tel" placeholder="전화번호를 입력해주세요">'
        html += '</div>';
        html += '<div class="sms_submit_wrap">';
        html += '<button onclick="javascript:sendSms(\'' + store.store_code + '\',\''+ store.store_name + '\',\'' + store.store_addr + '\',' + 'this,\'Store_info\');">';
        html += 'SMS 공유하기'
        html += '</button>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        html += '<div class="message top_message">';
        html += '<h5>꼭 확인해주세요</h5>';
        html += '<p>';
        if(pickupServiceChk.length > 0){
            html +=  '“편의점에서 픽업 서비스를 받기 위해서는 아이코스 공식 홈페이지 (https://kr.iqos.com)에서';
            html += '‘제품 자가 진단’ 또는 콜센터 직원의 진단 후 교환쿠폰을 발급받으셔야 합니다.”';
        }else{
            html+=  '편의점 픽업 서비스를 제공하지 않는 매장입니다.';
        }
        html += '</p>';
        html += '</div>';
        html += '<div class="store_info_wrap">';
        /*html += '<div class="store_name" style = "cursor:pointer;" onclick="javascript:moveMap(\'' + store.latitude + '\',\'' + store.longitude + '\',\'' + store.store_code + '\')">';
        html += '<h3>' + store.store_name + '</h3>';
        html += '</div>';*/
        html += '<div class="info_wrapper">';
        html += '<h4>';
        html += '영업현황';
        html += '<div class="is_store_on tag-live">';
        html += '<span ';
        html += store.oper_flag ? 'class="live"' : store.closed_flag ? 'class="closed"' : 'class="oper_end"';
        html += '>';
        html += store.oper_flag ? '영업중' :  store.closed_flag ? '휴무일' : '영업시간종료';
        html += '</span>';
        html += '</div>';
        html += '</h4>';
        html += '<div class="store_info">';
        if(store.oper_time != null && store.oper_time != ''){
            html += '<p>영업 시간 : ' + store.oper_time + '</p>';
        }
        html += '</div></div>';
        html += '<div class="info_wrapper">';
        html += '<h4>서비스 센터 정보</h4>';
        html += '<div class="store_info">';
        if(store.store_addr != null && store.store_addr != ''){
            html += '<p>주소 : ' + store.store_addr;
            if(store.store_addr_dtl != null && store.store_addr_dtl != ''){
                html += ' ' + store.store_addr_dtl;
            }
            html += '</p>';
        }
        html += '</div></div>';
        html += '<div class="info_wrapper">';
        html += '<h4>제공 서비스</h4>';
        html += '<ul class="info-list clearfix">';
        for(var i = 0 ; i < store.storeServiceList.length ; i++){
            html += '<li>';
            html += '<span class="icon-area">';
            if((store.storeServiceList[i].file_path != null && store.storeServiceList[i].file_path != '') &&
                (store.storeServiceList[i].save_name != null && store.storeServiceList[i].save_name != '')) {
                var serviceImgUrl = store.storeServiceList[i].file_path + store.storeServiceList[i].save_name
                html += '<img src="'+serviceImgUrl+'">';
            }
            html += "</span>";
            html += '<span class="icon-name">';
            var serviceNameArr = store.storeServiceList[i].service_name.split(' ');
            if(serviceNameArr.length >= 2){
                for(var k = 0; k < serviceNameArr.length ; k++){
                    if(k == 1){
                        html += '<br>';
                    }else{
                        html += ' ';
                    }
                    html += serviceNameArr[k];
                }
            }else{
                html += serviceNameArr[0];
            }
            html += "</span>";
            html += '</li>';
        }
        html += '</ul>';
        html += '</div>';
        html += '<div class="others">';
        html += '<ul>';
        html += '<li><a href="#" class="popup changepop" onclick="layerPopup(true)">교환기기 현황</a></li>';
        html += '<li><a href="#" onclick="surveyPopup()">설문조사</a></li>';
        html += '</ul>';
        html += '</div>';

        html += '</div></div></div>';

        $('.list-type-details .panel_inner').empty();
        $('#storeDetailPanel .panel_inner').empty();

        $('.list-type-details .store-name').html(store.store_name);
        $('#storeDetailPanel .store-name').html(store.store_name);

        $('.list-type-details .panel_inner').append(html);
        $('#storeDetailPanel .panel_inner').append(html);

        $('.share.sms').off().click(function() {
            $(this).parents('.share_popup').find('.sms_share_form').stop().slideToggle(400, 'easeOutExpo');
        });

        $('.list-type-details .panel_inner.scroll_area').animate({scrollTop: 0}, 0);
        $('#storeDetailPanel .panel_inner.scroll_area').animate({scrollTop: 0}, 0);
    }

    /**
     * 매장 상세화면 > 교환기기 리스트(left)
     */
    function makeHtmlExcgDeviceLeft(store){
        var html = '<div class="popup_title">';
        html += '<h2>';
        html += store.store_name + '<br>';
        html += '교환기기 현황';
        html += '</h2>';
        html += '</div>';
        html += '<div class="popup_notice">';
        html += ' <h4>알려드립니다.</h4><p>서비스센터별 재고 현황은 보여지는 내용과 다를 수 있습니다.</p><p>자세한 사항은 서비스센터에 직접 문의 부탁드립니다.</p>';
        if(store.tel_num != null && store.tel_num != ''){
            html += '<p>' + store.tel_num + '</p>';
        }
        html += '</div>';
        html += '<div class="product_type_select">';
        html += '<ul>';
        html += '<li class="on" onclick="javascript:makeHtmlExcgDeviceRight(\'\')"><a href="javascript:;">전체 (' + store.excg_total_count + ')</a></li>';
        for(var i = 0 ; i < store.storeExcgDeviceList.length ; i++){
            html += '<li onclick="javascript:makeHtmlExcgDeviceRight(\'' + i + '\')">';
            html += '<a href="javascript:;">' + store.storeExcgDeviceList[i].cate_name + ' (' + store.storeExcgDeviceList[i].deviceList.length + ')</a></li>';
        }
        html += '</ul>';
        html += '<div class="mobile_tab_menu swiper-container">';
        html += '<div class="swiper-wrapper">';
        html += '<div class="swiper-slide on"onclick="javascript:makeHtmlExcgDeviceRight(\'\')"><a href="javascript:;"> 전체 (' + store.excg_total_count + ')</a></div>';
        for(var i = 0; i < store.storeExcgDeviceList.length ; i++){
            html += '<div class="swiper-slide" onclick="javascript:makeHtmlExcgDeviceRight(\'' + i + '\')">';
            html += '<a href="javascript:;">' + store.storeExcgDeviceList[i].cate_name + ' (' + store.storeExcgDeviceList[i].deviceList.length + ')</a></li>';
            html += '</div>';
        }
        html += '</div></div></div></div>';

        $('.change_layer .popup_inner .pop_left').empty();
        $('.change_layer .popup_inner .pop_left').append(html);

        // 현황 탭메뉴
        $('.iqos_store_popup .product_type_select a').click(function(e) {
            e.preventDefault();
            $(this).parent().addClass('on').siblings().removeClass('on');

            var index = $(this).parent().index();
            $(this).parents('.iqos_store_popup').find('.mobile_tab_menu .swiper-slide').eq(index).addClass('on').siblings().removeClass('on');
        })

        //  현황 모바일탭메뉴
        var mobileTab = new Swiper('.mobile_tab_menu', {
            observer: true,
            observeParents: true,
            watchOverflow: true,
            slidesPerView: 'auto',
            spaceBetween: 15,
        });
        $('.mobile_tab_menu .swiper-slide a').click(function(e) {
            // 모바일 탭메뉴 클릭이벤트
            e.preventDefault();
            $(this).parent().addClass('on').siblings().removeClass('on');

            var index= $(this).parent().index();
            $(this).parents('.iqos_store_popup').find('.product_type_select li').eq(index).addClass('on').siblings().removeClass('on')
        });
    }


    /**
     * 매장 상세화면 > 교환기기 리스트(right)
     */
    function makeHtmlExcgDeviceRight(deviceIndex){

        var forStartIndex = deviceIndex;
        var forEndIndex = 0;
        var title = '';
        var totalCount='';

        if(forStartIndex == ''){
            forStartIndex = 0;
            forEndIndex = storeDetailData.storeExcgDeviceList.length;
            title = '전체';
            totalCount = storeDetailData.excg_total_count;
        }else{
            title = storeDetailData.storeExcgDeviceList[deviceIndex].cate_name;
            totalCount = storeDetailData.storeExcgDeviceList[deviceIndex].deviceList.length;
            forEndIndex = parseInt(forStartIndex) + 1;
        }

        var html = ''
        html += '<h3>'+ title +' (' + totalCount + ')</h3>';
        html += '<div class="product_wrap">';
        for(var i = forStartIndex ; i< forEndIndex ; i++){
            for(var k = 0; k < storeDetailData.storeExcgDeviceList[i].deviceList.length; k++){
                var device = storeDetailData.storeExcgDeviceList[i].deviceList[k];
                var imgPath = device.file_path + device.save_name;
                html += '<div class="product">';
                html += '<div class="product_img">';
                html += '<div class="product_img_rsp" style="background-image:url(' + imgPath + ')"></div>';
                html += '<div class="product_info">';
                html += '<div class="eq"><h4>' + storeDetailData.storeExcgDeviceList[i].cate_name + '</h4></div>';
                html += '<div class="type"><h4>' + device.device_name + '</h4></div>';
                html += '<div class="stock">';
                html += '<p><span class="pal"></span>';
                html += '<span class="pal_text"></span>';
                html += '<span class="stock_yn"></span></p>';
                html += '</div>';
                html += '<div class="_colors_wrap">';
                for(var j = 0 ; j < device.deviceColorList.length; j ++){
                    var deviceColor = device.deviceColorList[j];
                    var imgPath = deviceColor.file_path + deviceColor.save_name;
                    html += '<div class="_colors" data-limit="' + deviceColor.limit_yn + '"data-qty="'+ deviceColor.qty +'" data-img="'+ imgPath +'">';
                    html += '<span class="_colors_pal" style="background-color:' + deviceColor.color_rgb + ';"></span>';
                    html += '<p>' + deviceColor.color_name  + '</p>';
                    html += '</div>';
                }
                html += '</div>';
                html += '</div></div></div>';
            }
        }
        html += '</div>';
        $('.change_layer .popup_inner .pop_right .scroll_area').empty();
        $('.change_layer .popup_inner .pop_right .scroll_area').append(html);

        $('._colors').click(function() {
            var limit_yn = $(this).data('limit');
            if(limit_yn == '02'){
                onlyParcel.openPopup({x: '-50%', y: '-50%'});
                return;
            }

            // 교환기기 체크
            $(this).addClass('on').siblings().removeClass('on');
            var bColor = $(this).find('span').css('background-color');
            var cText = $(this).find('p').text();
            var obj = $(this).parents('.product_info').find('.stock');

            obj.find('.pal').css({'background-color': bColor});
            obj.find('.pal_text').text(cText);
            var qty = $(this).data('qty');
            var stockStr = qty > 0 ? '재고 : Y(있음)' : '재고 : N(없음)';
            obj.find('.stock_yn').text(stockStr);

            // 품절된 상품 표시 여부
            if(qty == 0){
                $(this).parent().parent().parent().find('.product_img_rsp').addClass('on').addClass('soldout');
            }else{
                if($(this).parent().parent().parent().find('.product_img_rsp').hasClass('on soldout')){
                    $(this).parent().parent().parent().find('.product_img_rsp').removeClass('on').removeClass('soldout');
                }
            }
            // 백그라운드 이미지 변경하기
            var imgPath = $(this).data('img');
            $(this).parent().parent().parent().find('.product_img_rsp').css('background-image', 'url(' + imgPath + ')');
        });
        $('.change_layer .popup_inner .pop_right .scroll_area').animate({scrollTop:0}, 300);
    }
    /**
     * 매장 상세화면 > 판매기기 리스트(left)
     * @param store_name
     */
    function makeHtmlSaleDeviceLeft(store_name, tel_num){
        var html = '<div class="popup_title">';
        html += '<h2>';
        html += store_name;
        html += '<br>';
        html += '판매기기 현황';
        html += '</h2>';
        html += '</div>';
        html += '<div class="popup_notice">';
        html += '<div>';
        html += '<h4>알려드립니다.</h4><p>서비스센터별 재고 현황은 보여지는 내용과 다를 수 있습니다.</p><p>자세한 사항은 서비스센터에 직접 문의 부탁드립니다.</p>';
        if(tel_num != null && tel_num != ''){
            html += '<p>' + tel_num + '</p>';
        }
        html += '</div>';
        html += '</div>';
        $('.sale_layer .popup_inner .pop_left').empty();
        $('.sale_layer .popup_inner .pop_left').append(html);
    }

    /**
     * 매장 상세화면 > 판매기기 리스트(right)
     * @param storeSellDeviceList, treat_yn(악세사리 취급여부)
     */
    function makeHtmlSaleDeviceRight(storeSellDeviceList, treat_yn){
        var totalCount = storeSellDeviceList.length;
        totalCount = treat_yn == 'Y' ? totalCount+1 : totalCount;
        var html = '';
        html += '<h3>전체 (' + totalCount + ')</h3>';
        html += '<div class="product_wrap">';
        for(var i=0; i< storeSellDeviceList.length; i++){
            var imgUrl = storeSellDeviceList[i].file_path + storeSellDeviceList[i].save_name;
            html += '<div class="product">';
            html += '<div class="product_img">';
            html += '<div class="product_img_rsp" style="background-image:url(' + imgUrl + ')"></div>'
            html += '<div class="product_info">';
            html += '<div class="eq"><h4>' + storeSellDeviceList[i].cate_name + '</h4></div>';
            html += '</div></div></div>';
        }
        if(treat_yn == 'Y'){
            var imgUrlAccessory = '/upload/cate/판매기기_04_액새서리.jpg';
            html += '<div class="product">';
            html += '<div class="product_img">';
            html += '<div class="product_img_rsp" style="background-image:url(' + imgUrlAccessory + ')"></div>'
            html += '<div class="product_info">';
            html += '<div class="eq"><h4>액세서리</h4></div>';
            html += '</div></div></div>';
        }

        html += '</div>';
        $('.sale_layer .popup_inner .pop_right .scroll_area').empty();
        $('.sale_layer .popup_inner .pop_right .scroll_area').append(html);
    }

    /**
     * 길찾기 > 검색결과
     * @param list
     * @param id
     */
    function makeHtmlRoadSearchResult(list, id){
        $('.road_search_result .result_wrap ul').empty();
        var html = '';
        for(var i = 0 ; i < list.length ; i++){
            html += '<li onclick="setDestination(\''+id+ '\',\'' + list[i].title + '\',\'' + list[i].subTitle+'\',\'' + list[i].latitude + '\',\'' + list[i].longitude + '\')">';
            html += '<p>';
            html += list[i].title;
            html += '</p>';
            html += '<span>';
            html += list[i].subTitle;
            html += '</span>';
            html += '</li>';
        }
        $('.road_search_result .result_wrap ul').append(html);
    }

    function makeHtmlRoadSearchResultEmpty(){
        $('.road_search_result .result_wrap ul').empty();
        var html = '<li><p>검색 결과가 없습니다.</p></li>';
        $('.road_search_result .result_wrap ul').append(html);
    }


    /**
     * infoWindow html생성
     * @param store
     * @returns {string}
     */
    function makeHtmlInfoWindow(store){
        var html = '<div class="iqos_info_window new-window">';
        html += '<div class="close_window" onclick="javascript:infoWindowToggle(\''+store.store_code+'\');"></div>';
        html += '<div class="info_window_inner">';
        html += '<div class="_store_info">';
        html += '<div class="_store_type">';
        html += '<p>' + store.store_type_name + '</p>';
        html += '</div>';
        html += '<div class="_store_name">';
        html += '<p>';
        html += store.store_name + ' ';
        html += '</p>';
        html += '</div>';
        html += '<div class="is_store_on">';
        html += '<span ';
        html += store.oper_flag ? 'class="live"' : store.closed_flag ? 'class="closed"' : 'class="oper_end"';
        html += '>';
        html += store.oper_flag ? '영업중' :  store.closed_flag ? '휴무일' : '영업시간종료';
        html += '</span>';
        if(store.oper_time != null && store.oper_time != ''){
            html += '<span class="live-time">';
            html += '영업시간 : ' + store.oper_time;
            html += '</span>';
        }
        html += '</div>';
        html += '<div class="store_info2">';
        if(store.tel_num != null && store.tel_num != ''){
            html += '<p>';
            html += '전화번호 : ' + store.tel_num;
            html += '</p>';
        }
        if(store.come_way != null && store.come_way != ''){
            html += '<p>';
            html += '찾아오는길 : ' + store.come_way;
            html += '</p>';
        }
        if(store.service_name != null && store.service_name != ''){
            html += '<p>';
            html += '제공서비스 : ' + store.service_name;
            html += '</p>';
        }
        html += '</div>';
        html += '<div class="new-btns clearfix">';

        html += '<div class="sh-btns">';

        html += '<span class="icon-area1">';
        html += '<a href="javascript:" onclick="javascript:moveKaKaoMap(\'' + store.store_addr + '\',\'' + store.latitude+ '\',\'' + store.longitude + '\',\'' + store.store_type + '\');">';
        html += '길찾기';
        html += '</a>';
        html += '</span>';
        html += '<span class="icon-area2">';
        html += '<a href="javascript:" onclick="javascript:sharePopupWrap(true, \'' + store.store_code + '\',\'' + store.store_name + '\',\'' + store.store_addr + '\',\''+store.store_type+'\');">';
        html += '공유';
        html += '</a>';
        html += '</span>';
        html += '<span class="icon-area3"><a href="javascript:" class="new-more-btn" onclick="javascript:getStoreDetail2(\'' + store.store_code+ '\',\'map\')">상세정보</a></span>';
        html += '</div>';
        html += '</div>';
        html += '</div></div></div>';

        html += '<div class="iqos_info_window m-new-window">';
        html += '<div class="close_window" onclick="javascript:infoWindowToggle(\''+store.store_code+'\');"></div>';
        html += '<div class="info_window_inner">';
        html += '<div class="_store_info">';
        html += '<div class="_store_type">';
        html += '<p>' + store.store_type_name + '</p>';
        html += '</div>';
        html += '<div class="_store_name">';
        html += '<p>';
        html += store.store_name + ' ';
        if(store.distance != null && store.distance != '') {
            html += '<span class="distance-m">';
            html += store.distance.toFixed(2) + 'km';
        }
        html += '</span>';
        html += '</p>';
        html += '</div>';
        html += '<ul class="window-btns clearfix">';
        html += '<li>';
        html += '<a href="javascript:" onclick="javascript:moveKaKaoMap(\'' + store.store_addr + '\',\'' + store.latitude+ '\',\'' + store.longitude + '\',\'' + store.store_type + '\');">';
        html += '<span class="icon-area1"></span>';
        html += '<span>길찾기</span>';
        html += '</a>';
        html += '</li>';
        html += '<li>';
        html += '<a href="javascript:" onclick="javascript:sharePopupWrap(true, \'' + store.store_code + '\',\'' + store.store_name + '\',\'' + store.store_addr + '\',\''+store.store_type+'\');">';
        html += '<span class="icon-area2"></span>';
        html += '<span>공유</span>';
        html += '</a>';
        html += '</li>';
        html += '<li>';
        html += '<a href="javascript:" onclick="javascript:getStoreDetail2(\'' + store.store_code+ '\',\'map\');">';
        html += '<span class="icon-area3"></span>';
        html += '<span>상세정보</span>';
        html += '</a>';
        html += '</li>';
        html += '</ul>';
        html += '</div></div></div>';        

        return html;
    }

    /**
     * 현재 URL 복사
     */
    function copyUrl(){
        var currUrl = $(location).attr('href');
        navigator.clipboard.writeText(currUrl);
    }

    /**
     * 스토어 URL 복사
     */
    function copyStoreUrl(store_code){
        var storeUrl = "<spring:eval expression="@config['share.link.url']"/>" + store_code;
        navigator.clipboard.writeText(storeUrl);
        $('.copy-comment').addClass('on');
        $('.sms_share_form').css('display','none');
    }

    /**
     * 화면 resize 스크립트
     */
    $(window).resize(function(){
        // 지도 마커 이미지 크기 변경
        if($(window).width() > 768) {
            $("[src*=mark_01]").css({clip:"rect("+0+"px,66px,85px,"+0+")", width:66+"px", height:85+"px"});
            $("[src*=mark_05]").css({clip:"rect("+0+"px,66px,85px,"+0+")", width:66+"px", height:85+"px"});
            $("[src*=mark_06]").css({clip:"rect("+0+"px,66px,85px,"+0+")", width:66+"px", height:85+"px"});
            $("[src*=mark_02]").css({clip:"rect("+0+"px,66px,85px,"+0+")", width:25+"px", height:25+"px"});
            $("[src*=mark_03]").css({clip:"rect("+0+"px,66px,85px,"+0+")", width:25+"px", height:25+"px"});
            $("[src*=mark_04]").css({clip:"rect("+0+"px,66px,85px,"+0+")", width:25+"px", height:25+"px"});
        } else {
            $("[src*=mark_01]").css({clip:"rect("+0+"px,33px,43px,"+0+")", width:32+"px", height:48+"px"});
            $("[src*=mark_05]").css({clip:"rect("+0+"px,33px,43px,"+0+")", width:33+"px", height:43+"px"});
            $("[src*=mark_06]").css({clip:"rect("+0+"px,33px,43px,"+0+")", width:33+"px", height:43+"px"});
            $("[src*=mark_02]").css({clip:"rect("+0+"px,33px,43px,"+0+")", width:12.5+"px", height:12.5+"px"});
            $("[src*=mark_03]").css({clip:"rect("+0+"px,33px,43px,"+0+")", width:12.5+"px", height:12.5+"px"});
            $("[src*=mark_04]").css({clip:"rect("+0+"px,33px,43px,"+0+")", width:12.5+"px", height:12.5+"px"});
        }

        // 인포윈도우 모두 닫기
        $(".iqos_info_window .close_window").each(function(){
            $(this).click();
        });
    });


</script>