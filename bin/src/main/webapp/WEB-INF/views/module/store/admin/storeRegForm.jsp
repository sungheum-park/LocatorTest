<%@ page import="kr.co.msync.web.module.store.StoreController" %>
<%@ page import="kr.co.msync.web.module.common.type.ResultType" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@config['api.kakao.authKey']" />"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('.sale_item .button_90').bind("click",function(){

            $('.sell_device_popup').show();

            var selected_sell_no_cate;

            $("#regForm").find("[name=selected_sell_no_cate]").each(function(i){
                if(i==0) {
                    selected_sell_no_cate = $(this).val();
                } else {
                    selected_sell_no_cate += "," + $(this).val();
                }
            });

            $.ajax({
                url: "<%=StoreController.STORE_SELL_DEVICE_LIST%>",
                data: {selected_sell_no_cate:selected_sell_no_cate},
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                type: "POST",
                success: function (result) {
                    $(".sell_device_popup").css("display", "block");
                    $(".sell_device_popup").html(result);
                },
                error: function (e) {
                    console.log(e.responseText);
                }
            });

        });

        $('.change_item .button_90').bind("click",function(){

            $('.excg_device_popup').show();

            var selected_excg_no_device;

            $("#regForm").find("[name=selected_excg_no_device]").each(function(i){
                if(i==0) {
                    selected_excg_no_device = $(this).val();
                } else {
                    selected_excg_no_device += "," + $(this).val();
                }
            });

            console.log(selected_excg_no_device);

            $("#regForm").serialize();

            $.ajax({
                url: "<%=StoreController.STORE_EXCG_DEVICE_LIST%>",
                data: {selected_excg_no_device:selected_excg_no_device},
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                type: "POST",
                success: function (result) {
                    $(".excg_device_popup").css("display", "block");
                    $(".excg_device_popup").html(result);
                },
                error: function (e) {
                    console.log(e.responseText);
                }
            });

        });

        $('.offer_service .button_90').bind("click",function(){

            $('.offer_service_popup').show();

            var selected_no_service;

            $("#regForm").find("[name=selected_no_service]").each(function(i){
                if(i==0) {
                    selected_no_service = $(this).val();
                } else {
                    selected_no_service += "," + $(this).val();
                }
            });

            $.ajax({
                url: "<%=StoreController.STORE_OFFER_SERVICE_LIST%>",
                data: {selected_no_service:selected_no_service},
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                type: "POST",
                success: function (result) {
                    $(".offer_service_popup").css("display", "block");
                    $(".offer_service_popup").html(result);
                },
                error: function (e) {
                    console.log(e.responseText);
                }
            });

        });

        $("#regForm").find("[name=store_status]").bind("click",function(){
           if($(this).val()=="02") {
               $("[name=store_due_date]").val("");
               $(".store_status_code").attr("colspan", "1");
               $(".rm_dt").attr("colspan", "1");
               $(".rm_dt").eq("0").html("시작 예정일");
               $(".rm_dt").css("display","");
           } else if($(this).val()=="03") {
               $("[name=store_due_date]").val("");
               $(".store_status_code").attr("colspan", "1");
               $(".rm_dt").attr("colspan", "1");
               $(".rm_dt").eq("0").html("종료 예정일");
               $(".rm_dt").css("display","");
           } else {
               $(".store_status_code").attr("colspan", "3");
               $(".rm_dt").css("display","none");
           }

        });


    });

    function jsRegAction(){

        var data = $("#regForm").serialize();

        $("#regForm").validate({
            rules: {
                store_name: "required",
                store_addr: "required",
                lat_long_spot: "required",
                oper_time: "required",
                retail_store_code : "number"
            },
            messages: {
                store_name: "매장명을 입력해 주세요.",
                store_addr: "매장 주소를 입력해 주세요.",
                lat_long_spot: "위도 경도를 선택해 주세요.",
                oper_time: "영업시간을 입력해 주세요.",
                retail_store_code : "소매점 코드는 숫자만 입력해 주세요."
            }, errorPlacement: function(error, element) {
                // do nothing

            }, invalidHandler: function(form, validator) {
                var errors = validator.numberOfInvalids();
                if (errors) {
                    alert(validator.errorList[0].message);
                    validator.errorList[0].element.focus();
                }
            }
        });

        $("#regForm").ajaxForm({
            url: "<%=StoreController.STORE_REG_ACTION%>",
            type: "POST",
            data: data,
            enctype: "multipart/form-data",
            success: function(data){
                if(data.resultCode == <%=ResultType.SUCCESS%>){
                    alert("등록 되었습니다.");
                    location.href= "<%=StoreController.STORE%>";
                } else if(data.resultCode == "RETAIL_CODE_DUE"){
                    alert("소매점 코드가 이미 존재합니다.");
                    return;
                } else {
                    alert("저장 중 에러가 발생했습니다.");
                    return;
                }
            },
            error: function(request, status, e) {
                alert(e.responseText);
            }
        });

        $("#regForm").submit();
    }

    function addPhotoBtn() {
        var count = $(".store_img_form .button_90").length + 1 ;

        if(count>4) {
            alert("최대 4장까지 업로드 가능합니다.");
            return;
        }

        var datas = [{"f_count" : count}];

        $("#photoFileTemplate").tmpl(datas).appendTo(".image_wrap");
    }

    function removePhotoBtn(o) {
        var count = $(".store_img_form .button_90").length;

        if(count<=1) return;
        $(o).parent().remove();
    }

    function addClosedDateBtn() {
        var count = $(".close_date_wrap").length + 1 ;

        if(count>5) {
            alert("최대 5번 입력 가능합니다.");
            return;
        }

        $("#closedDateFileTemplate").tmpl().appendTo(".add_wrap");
    }

    function removeClosedDateBtn(o) {
        var count = $(".close_date_wrap").length;

        if(count<=1) return;
        $(o).parent().remove();
    }

    function fileValidate(o) {
        // 확장자 체크
        if($(o).val() != ""){
            var ext = $(o).val().split(".").pop().toLowerCase();
            if($.inArray(ext,["gif","jpg","jpeg","png"]) == -1){
                alert("확장자가 gif, jpg, jpeg, png인 파일만 업로드 할수 있습니다.");
                $(o).val("");
                $(o).next().next().val("");
                $(o).parents(".button_90").find(".file_thumb img").attr('src', '');
                return;
            }
            //
            var fileSize = o.files[0].size;
            var fileName = o.files[0].name;

            $(o).next().next().val(fileName);
            var maxSize = 10485760;
            if(fileSize > maxSize){
                alert("파일 크기는 10MB 이하만 업로드 할수 있습니다.");
                $(o).val("");
                $(o).next().next().val("");
                $(o).parents(".button_90").find(".file_thumb img").attr('src', '');
                return;
            }

            //가로,세로 길이
            var file = o.files[0];
            var _URL = window.URL || window.webkitURL;
            var img = new Image();

            img.src = _URL.createObjectURL(file);
            img.onload = function(){
                // 너비 높이 제한
                /*if(!(img.width >= 780 && img.width <= 820)){
                    alert("W 780~820px x H 780~820px are allowed.");
                    $(o).val("");
                    $(o).next().next().val("");
                    $(o).parents(".button_90").find(".file_thumb img").attr('src', '');
                    return;
                }

                if(!(img.height >= 400 && img.height <= 420)){
                    alert("W 400~420px x H 400~420px are allowed.");
                    $(o).val("");
                    $(o).next().next().val("");
                    $(o).parents(".button_90").find(".file_thumb img").attr('src', '');
                    return;
                }*/
                readURL(o);
            }

        }
    }

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
            reader.onload = function (e) {
                //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                $(input).parents(".button_90").find(".file_thumb img").attr('src', e.target.result);
                //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                //(아래 코드에서 읽어들인 dataURL형식)
            }
            reader.readAsDataURL(input.files[0]);
            //File내용을 읽어 dataURL형식의 문자열로 저장
        }
    }

    function jsMapForm(){

        $('.position_popup').show();

        var data = $("#regForm").serialize();

        $.ajax({
            url: "<%=StoreController.STORE_POSITION_MAP_MODAL%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $(".position_popup").css("display", "block");
                $(".position_popup").html(result);
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    }

</script>
<!-- ///공통 사이드메뉴 -->
<div class="side_menu_wrap">
    <ul>
        <li class="menu_title">
            <h2><a href="<%=StoreController.STORE%>">매장관리</a></h2>
            <ul>
                <li><h4><a href="<%=StoreController.STORE%>">매장 리스트</a></h4></li>
                <li class="on"><h4><a href="<%=StoreController.STORE_REG_FORM%>">매장 등록</a></h4></li>
            </ul>
        </li>
        <li class="menu_title">
            <h2><a href="<%=StoreController.STORE_ALL%>">매장 일괄 관리</a></h2>
            <ul>
                <li><h4><a href="<%=StoreController.STORE_ALL_REG%>">대량 매장 업로드</a></h4></li>
                <li><h4><a href="<%=StoreController.STORE_ALL%>">대량 일괄 수정</a></h4></li>
            </ul>
        </li>
    </ul>
</div>

<!-- ///컨텐츠-->
<div class="contents">
    <div class="contents_now">
        <span>매장</span>
        <span>매장 관리</span>
        <span class="now_page">매장 등록</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>매장 등록</h2>
        </div>
        <div class="btn_wrap">
            <div class="btn list w90"><a href="<%=StoreController.STORE%>">목록</a></div>
            <div class="btn red w90"><a href="javascript:;" onclick="jsRegAction();">저장</a></div>
        </div>
    </div>

    <!-- 공통 검색폼 -->
    <form name="regForm" id="regForm" onsubmit="return false;" method="post" enctype="multipart/form-data">
    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>매장 타입</h3>
        </div>
        <div class="form_wrap">
                <table>
                    <tr>
                        <td class="infotd">타입 선택</td>
                        <td>
                            <div class="td_inner_2">
                                <div class="option_list w283">
                                    ${ufn:getStoreSelectBox("store_type","Y","store_type", false, "01", inclusive_code)}
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
        </div>
    </div>

    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>매장 기본 정보</h3>
        </div>
        <div class="form_wrap">
                <table>
                    <tr class="search_word colum-2">
                        <td class="infotd" colspan="1">매장 코드</td>
                        <td class="destd" colspan="1">등록 시 자동 생성됩니다.</td>
                        <td class="infotd" colspan="1">국가</td>
                        <td class="destd" colspan="1">대한민국</td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">소매점 코드</td>
                        <td colspan="3">
                            <div class="td_inner_2">
                                <div class="input_wrap ml0 w332">
                                    <input class="number_type" type="number" name="retail_store_code" maxlength="20">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="period">
                        <td class="infotd">매장 상태</td>
                        <td class="destd store_status_code" colspan="3">
                            <div class="td_inner">
                                ${ufn:getRadioButton('store_status', 'y', 'store_status', '01', '')}
                            </div>
                        </td>
                        <td class="infotd rm_dt" style="display:none">시작 예정일</td>
                        <td class="destd rm_dt" style="display:none">
                            <div class="td_inner_2">
                                <div class="input_wrap start">
                                    <input type="text" name="store_due_date" class="picker" readonly="readonly">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="product_code">
                        <td class="infotd">* 매장명</td>
                        <td colspan="3">
                            <div class="td_inner_2">
                                <div class="input_wrap ml0">
                                    <input type="text" name="store_name" maxlength="60">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">* 매장 주소</td>
                        <td colspan="3">
                            <div class="td_inner_2">
                                <div class="input_wrap ml0">
                                    <input type="text" name="store_addr" maxlength="100">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">매장 상세 주소</td>
                        <td colspan="3">
                            <div class="td_inner_2">
                                <div class="input_wrap ml0">
                                    <input type="text" name="store_addr_dtl" maxlength="150">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word position">
                        <td class="infotd">* 매장 위도/경도</td>
                        <td colspan="3">
                            <div class="td_inner_2">
                                <div class="button_90">
                                    <a href="javascript:;" class="download_btn" onclick="jsMapForm()">+ 위도/경도 설정</a>
                                </div>
                                <div class="input_wrap w332">
                                    <input type="text" name="lat_long_spot" readonly="readonly">
                                    <input type="hidden" name="latitude" value="0">
                                    <input type="hidden" name="longitude" value="0">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">찾아오는 길</td>
                        <td colspan="3">
                            <div class="td_inner_2">
                                <div class="input_wrap ml0">
                                    <input type="text" name="come_way" maxlength="300">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">매장 전화번호</td>
                        <td class="destd">
                            <div class="td_inner_2">
                                <div class="input_wrap ml0">
                                    <input type="text" name="tel_num" maxlength="30">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">주차 여부</td>
                        <td class="destd">
                            <div class="td_inner">
                                ${ufn:getRadioButton('parking_yn', 'y', 'parking_yn', 'Y', '')}
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">* 영업시간</td>
                        <td class="destd">
                            <div class="td_inner_2">
                                <div class="input_wrap ml0">
                                    <input type="text" name="oper_time" maxlength="50">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">A/S시간</td>
                        <td class="destd">
                            <div class="td_inner_2">
                                <div class="input_wrap ml0">
                                    <input type="text" name="as_time" maxlength="50">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd text_area">매장 메시지</td></td>
                        <td colspan="3" class="text_area">
                            <div class="input_wrap ml0">
                                <textarea name="notice" maxlength="1000"></textarea>
                            </div>

                        </td>
                    </tr>
                </table>

        </div>

    </div>
    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>매장 휴무</h3>
        </div>
        <div class="form_wrap">
                <table>

                    <tr class="block">
                        <td class="infotd">휴무 설정</td>
                        <td>
                            <span class="notice block ml0">월 / 주 / 요일 (예 : # / 2 / 월 - 매월 / 둘째주 / 월요일 휴무) or 20190703로 입력할 수 있습니다.<br>매장별 한가지 규칙으로 입력이 가능하며, (예 : [#/2/수],[#/#/수],[20190703]) 여러 형식을 혼합하여 사용할 수 없습니다.</span>
                            <div class="td_inner_2 pt0 add_wrap">
                                <div class="input_wrap close_date_wrap w283 ">
                                    <input type="text" maxlength="20" name="closed_date">
                                    <span class="add_btn" onclick="addClosedDateBtn();">+ 추가</span>
                                    <span class="delete_btn" onclick="removeClosedDateBtn(this);">- 삭제</span>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>

        </div>

    </div>

    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>영업 시간</h3>
        </div>
        <div class="form_wrap">
            <table>
                <tbody>
                    <tr class="time_set block">
                        <td class="infotd">영업시간 설정</td>
                        <td>
                            <c:forEach begin="0" end="6" varStatus="status">
                            <div class="setting_input">
                                <div class="option_list w45">
                                    <span class="option_txt">${ufn:getCodeName("oper_week",status.index)}</span>
                                </div>
                                <div class="input_wrap w185 ml0">
                                    <input type="text" maxlength="23" name="oper_week_time" onkeyup="spaceDel(this);">
                                </div>
                            </div>
                            </c:forEach>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>매장 이미지</h3>
        </div>
        <div class="form_wrap store_img_form">
            <table>
                <tr class="block">
                    <td class="infotd">이미지 등록</td>
                    <td>
                        <span class="notice block ml0">최대 4장까지 업로드 가능합니다.</span>
                        <span class="notice block ml0" style="margin-top:0">이미지 권장 사이즈: 800px X 416px <br>
*권장드리는 사이즈로 업로드 하지 않으실 경우, 해당 이미지가 잘려보일 수 있는점 참고부탁드립니다.</span>
                        <div class=image>
                            <div class="image_wrap">
                                <div class="button_90">
                                    <span class="sno_handle img_handle"></span>
                                    <input type="file" id="file_1" name="store_img_file_1" class="download_btn blind upload-hidden" onchange="fileValidate(this);">
                                    <label for="file_1" class="download_btn">찾아보기</label>
                                    <input class="upload-name upload_img" readonly="readonly">
                                    <input type="hidden" name="file_sno" value="1">
                                    <span class="add_btn" onclick="addPhotoBtn();">+ 추가</span>
                                    <span class="delete_btn" onclick="removePhotoBtn(this);">- 삭제</span>
                                    <div class="file_name">
                                        <span class="file_thumb" onclick="jsImagePreview(this)">
                                            <img src="" alt="">
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>악세사리 취급 여부</h3>
        </div>
        <div class="form_wrap">
            <table>
                <tr class="block">
                    <td class="infotd">악세사리</td>
                    <td>
                        <div class="td_inner">
                            ${ufn:getRadioButton('treat_yn', 'y', 'treat_yn', 'Y', '')}
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="search_wrap basic_table_wrap sale_item">
        <div class="title">
            <h3>판매 기기</h3>
        </div>
        <div class="form_wrap">
            <table>
                <tr class="block">
                    <td class="infotd">판매 기기</td>
                    <td>
                        <div class="td_inner_2">
                            <div class="button_90">
                                <a href="javascript:;" class="delete_btn">+ 항목 설정</a>
                            </div>
                            <table>
                                <colgroup>
                                    <col style="width:10%">
                                    <col style="width:90%">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>순번</th>
                                    <th>기기명</th>
                                </tr>
                                </thead>
                                <tbody id="sell_device_setting_area" class="sortable"></tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="search_wrap basic_table_wrap change_item">
        <div class="title">
            <h3>교환 기기</h3>
        </div>
        <div class="form_wrap">
            <table>
                <tr class="block">
                    <td class="infotd">교환 기기</td>
                    <td>
                        <div class="td_inner_2">

                            <div class="button_90">
                                <a href="javascript:;" class="delete_btn">+ 항목 설정</a>
                            </div>

                            <table>
                                <colgroup>
                                    <col style="width:10%">
                                    <col style="width:30%">
                                    <col style="width:50%">
                                    <col style="width:10%">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>기기명</th>
                                    <th>색상</th>
                                    <th>재고</th>
                                </tr>
                                </thead>
                                <tbody id="excg_device_setting_area" class="parent_target"></tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

    </div>


    <div class="search_wrap basic_table_wrap offer_service">
        <div class="title">
            <h3>제공 서비스</h3>
        </div>
        <div class="form_wrap">
            <table>
                <tr class="block">
                    <td class="infotd">서비스</td>
                    <td>
                        <div class="td_inner_2">
                            <div class="button_90">
                                <a href="javascript:;" class="delete_btn">+ 항목 설정</a>
                            </div>

                            <table>
                                <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>서비스</th>
                                </tr>
                                </thead>
                                <tbody id="service_setting_area"></tbody>
                            </table>

                        </div>
                    </td>
                </tr>
            </table>
        </div>

    </div>

    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>관리자 메모</h3>
        </div>
        <div class="form_wrap">
            <table>
                <tr class="block">
                    <td class="infotd">관리자 메모</td>
                    <td class="text_area">
                        <div class="td_inner_2">
                            <textarea name="cust_desc" maxlength="1000"></textarea>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $(".sortable").sortable({
            handle : ".sno_holder",
            scroll : false,
            update : function() {
                $(".sno_holder").each(function(i){
                    $("[name=selected_cate_sno]").eq(i).val(i+1);
                });
            }
        });
        $(".sortable").disableSelection();
        $(".image_wrap").sortable({
            handle : ".sno_handle",
            scroll : false,
            update : function() {
                $(".sno_handle").each(function(i){
                    $("[name=file_sno]").eq(i).val(i+1);
                });
            }
        });
        $(".image_wrap").disableSelection();
    });
</script>

<script id="photoFileTemplate" type="text/x-jquery-tmpl">
<div class="button_90">
    <span class="sno_handle img_handle"></span>
    <input type="file" id="file_{{html f_count}}" name="store_img_file_{{html f_count}}" class="download_btn blind upload-hidden" onchange="fileValidate(this);">
    <label for="file_{{html f_count}}" class="download_btn">찾아보기</label>
    <input class="upload-name upload_img" readonly="readonly">
    <input type="hidden" name="file_sno" value="{{html f_count}}">
    <span class="add_btn" onclick="addPhotoBtn();">+ 추가</span>
    <span class="delete_btn" onclick="removePhotoBtn(this);">- 삭제</span>
    <div class="file_name">
        <span class="file_thumb" onclick="jsImagePreview(this)">
            <img src="" alt="">
        </span>
    </div>
</div>
</script>

<script id="closedDateFileTemplate" type="text/x-jquery-tmpl">
<div class="input_wrap close_date_wrap w283">
    <input type="text" maxlength="20" name="closed_date">
    <span class="add_btn" onclick="addClosedDateBtn();">+ 추가</span>
    <span class="delete_btn" onclick="removeClosedDateBtn(this);">- 삭제</span>
</div>
</script>
