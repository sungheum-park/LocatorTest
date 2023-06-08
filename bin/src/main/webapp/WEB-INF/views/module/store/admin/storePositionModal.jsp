<%@ page import="kr.co.msync.web.module.store.StoreController" %>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<script type="text/javascript">
    var myLat = ${mapVO.latitude};							// 현재 위치 위도(아이코스 본사 위도) - 현재 위치 정보 갖고 올때마다 업데이트 됨
    var myLng = ${mapVO.longitude};							// 현재 위치 경도(아이코스 본사 경도) - 현재 위치 정보 갖고 올때마다 업데이트 됨
    var map;										    // map 객체
    var marker = null;
    var enterFlagStartPoint = true;
    var latlng = null;

    if(myLat==0) {
        myLat = '37.525045';
    }

    if(myLng==0) {
        myLng = '126.925319';
    }

    $(document).ready(function(){
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(myLat, myLng), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

        initMarker();

        // 지도에 클릭 이벤트를 등록합니다
        // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

            if(marker != null){
                marker.setMap(null);
            }

            latlng = mouseEvent.latLng;

            // 마커를 생성합니다
            marker = new kakao.maps.Marker({
                position: latlng
            });
            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(map);

            myLat = latlng.getLat();
            myLng = latlng.getLng();

        });
    });

    function initMarker(){
        var markerPosition  = new kakao.maps.LatLng(myLat, myLng);
        // 마커를 생성합니다
        marker = new kakao.maps.Marker({
            position: markerPosition
        });
        // 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);
    }

    function jsSetPosition() {
        if(marker == null) {
            alert("위치를 선택해 주세요.");
            return;
        }
        $("[name=lat_long_spot]").val(myLat + ", " + myLng);
        $("[name=latitude]").val(myLat);
        $("[name=longitude]").val(myLng);

        jsClosePosition();
    }

    function jsClosePosition(){
        $(".position_popup").fadeOut(300);
    }

    function jsModalEnter(keyCode){
        if (keyCode == 13) {
            jsModalSearch();
        }
    }

    function jsModalSearch(){
        var keyword = $('[name=keyword]').val();
        if(typeof keyword == 'undefined' || keyword == ''){
            alert('주소를 입력해주세요');
            return;
        }

        $.ajax({
            url : '<%=StoreController.ADDRESS_BY_KEYWORD%>',
            method : 'post',
            data : {
                query : keyword
            },
            success : function(result){
                if(result.x==undefined || result.y==undefined){
                    alert("결과가 존재하지 않습니다.");
                    return;
                }
                panTo(result.y, result.x);
                // 연속 방지
                enterFlagStartPoint = false;
                setTimeout(function(){
                    enterFlagStartPoint = true;
                },2000);
            }
        })
    }

    function panTo(lat, lon) {
        // 이동할 위도 경도 위치를 생성합니다
        var moveLatLon = new kakao.maps.LatLng(lat, lon);

        // 지도 중심을 부드럽게 이동시킵니다
        // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
        map.panTo(moveLatLon);
    }

</script>

<div class="setting_wrap">
    <div id="map" class="map_area"></div>

    <div class="input_wrap">
        <input type="text" name="keyword" onkeypress="jsModalEnter(event.keyCode);">
        <a href="javascript:;" class="search_button" onclick="jsModalSearch();">
            <img src="${imagePath}/layout/glass_btn.png" alt="위치 검색하기">
        </a>
    </div>

    <div class="btn_wrap">
        <div class="button_90">
            <button type="button" class="download_btn" onclick="jsSetPosition();">설정</button>
        </div>
        <div class="button_90">
            <button type="button" class="delete_btn close" onclick="jsClosePosition()">취소</button>
        </div>
    </div>

</div>