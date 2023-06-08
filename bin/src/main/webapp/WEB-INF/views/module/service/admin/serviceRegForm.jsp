<%@ page import="kr.co.msync.web.module.service.ServiceController" %>
<%@ page import="kr.co.msync.web.module.cate.CateController" %>
<%@ page import="kr.co.msync.web.module.device.DeviceController" %>
<%@ page import="kr.co.msync.web.module.color.ColorController" %>
<%@ page import="kr.co.msync.web.module.common.type.ResultType" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<script type="text/javascript">
    $(document).ready(function(){

    });

    function jsRegAction(){

        var data = $("#regForm").serialize();

        $("#regForm").validate({
            rules: {
                service_name: "required",
                service_file: "required",
            },
            messages: {
                service_name: "매장명을 입력해 주세요.",
                service_file: "파일을 선택해 주세요."
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
            url: "<%=ServiceController.SERVICE_REG_ACTION%>",
            type: "POST",
            data: data,
            enctype: "multipart/form-data",
            success: function(data){
                if(data.resultCode == <%=ResultType.SUCCESS%>){
                    alert("등록 되었습니다.");
                    location.href= "<%=ServiceController.SERVICE%>";
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

    function fileValidate(o) {
        // 확장자 체크
        if($(o).val() != ""){
            var ext = $(o).val().split(".").pop().toLowerCase();
            if($.inArray(ext,["gif","jpg","jpeg","png"]) == -1){
                alert("확장자가 gif, jpg, jpeg, png인 파일만 업로드 할수 있습니다.");
                $(o).val("");
                $(o).next().next().val("");
                $('.file_thumb img').attr('src', '');
                return;
            }
            var fileSize = o.files[0].size;
            var fileName = o.files[0].name;

            $(o).next().next().val(fileName);
            var maxSize = 10485760;
            if(fileSize > maxSize){
                alert("파일 크기는 10MB 이하만 업로드 할수 있습니다.");
                $(o).val("");
                $(o).next().next().val("");
                $('.file_thumb img').attr('src', '');
                return;
            }

            //가로,세로 길이
            var file = o.files[0];
            var _URL = window.URL || window.webkitURL;
            var img = new Image();

            img.src = _URL.createObjectURL(file);
            img.onload = function(){
                // 너비 높이 제한
                if(img.width != 90){
                 $('.file_thumb img').attr('src', '');
                 alert("W 90px x H 90px are allowed.");
                 $(o).val("");
                 $(o).next().next().val("");
                 $('.file_thumb img').attr('src', '');
                 return;
                 }

                 if(img.height != 90){
                 $('.file_thumb img').attr('src', '');
                 alert("W 90px x H 90px are allowed.");
                 $(o).val("");
                 $(o).next().next().val("");
                 $('.file_thumb img').attr('src', '');
                 return;
                 }

                readURL(o);

            }

        }
    }

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
            reader.onload = function (e) {
                //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                $('.file_thumb img').attr('src', e.target.result);
                //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                //(아래 코드에서 읽어들인 dataURL형식)
            }
            reader.readAsDataURL(input.files[0]);
            //File내용을 읽어 dataURL형식의 문자열로 저장
        }
    }

</script>
<!-- ///공통 사이드메뉴 -->
<div class="side_menu_wrap">
    <ul>
        <li class="menu_title">
            <h2><a href="<%=DeviceController.DEVICE%>">상품 관리</a></h2>
            <ul>
                <li><h4><a href="<%=DeviceController.DEVICE%>">상품 리스트</a></h4></li>
                <li><h4><a href="<%=DeviceController.DEVICE_REG_FORM%>">상품 등록</a></h4></li>
                <li><h4><a href="<%=ColorController.COLOR%>">상품 색상 리스트</a></h4></li>
                <li><h4><a href="<%=ColorController.COLOR_REG_FORM%>">상품 색상 등록</a></h4></li>
                <li><h4><a href="<%=CateController.CATE%>">상품 카테고리 리스트</a></h4></li>
                <li><h4><a href="<%=CateController.CATE_REG_FORM%>">상품 카테고리 등록</a></h4></li>
            </ul>
        </li>
        <li class="menu_title">
            <h2><a href="<%=ServiceController.SERVICE%>">서비스 관리</a></h2>
            <ul>
                <li><h4><a href="<%=ServiceController.SERVICE%>">서비스 리스트</a></h4></li>
                <li class="on"><h4><a href="<%=ServiceController.SERVICE_REG_FORM%>">서비스 등록</a></h4></li>
            </ul>
        </li>
    </ul>
</div>
<!-- ///컨텐츠-->
<div class="contents productRegister">
    <div class="contents_now">
        <span>항목</span>
        <span>서비스 관리</span>
        <span class="now_page">서비스 등록</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>서비스 등록</h2>
        </div>
        <div class="btn_wrap">
            <div class="btn list w90"><a href="<%=ServiceController.SERVICE%>">목록</a></div>
            <div class="btn red w90"><a href="javascript:;" onclick="jsRegAction();">저장</a></div>
        </div>
    </div>

    <form name="regForm" id="regForm" onsubmit="return false;" method="post" enctype="multipart/form-data">
    <!-- 공통 검색폼 -->
    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>서비스 정보</h3>
        </div>
        <div class="form_wrap">
            <table>
                <colgroup>
                    <col style="width: 180px">
                    <col style="width: calc(100% - 180px)">
                </colgroup>
                <tr class="search_word ">
                    <td class="infotd">서비스 구분</td>
                    <td>
                        <div class="td_inner_2">
                            <div class="option_list w283">
                                ${ufn:getSelectBox("service_div","Y","service_div", false, "")}
                            </div>
                        </div>
                    </td>
                </tr>
                <tr class="search_word ">
                    <td class="infotd">서비스명</td>
                    <td>
                        <div class="td_inner_2">
                            <div class="input_wrap w332 ml0">
                                <input type="text" maxlength="25" name="service_name">
                            </div>
                        </div>
                    </td>
                </tr>
                <tr class="search_word">
                    <td class="infotd text_area">설명</td>
                    <td colspan="3" class="text_area">
                        <div class="input_wrap ml0">
                            <textarea name="comment" maxlength="1000"></textarea>
                        </div>
                    </td>
                </tr>
                <tr class="period">
                    <td class="infotd">사용여부</td>
                    <td class="inner_table">
                        <div class="td_inner">
                            ${ufn:getRadioButton('use_yn', 'y', 'use_yn', 'Y', '')}
                        </div>
                    </td>
                </tr>
                <tr class="search_word">
                    <td class="infotd">이미지</td>
                    <td>
                        <div class=image>
                            <div class="image_wrap">
                                <div class="button_90">
                                    <input type="file" id="file" name="service_file" class="download_btn blind upload-hidden" onchange="fileValidate(this);">
                                    <label for="file" class="download_btn">찾아보기</label>
                                    <input class="upload-name  upload_img" readonly="readonly">
                                    <div class="file_name">
                                        <span class="file_thumb" onclick="jsImagePreview(this)">
                                            <img src="" alt="">
                                        </span>
                                    </div>
                                    <span class="notice block ml0">매장 상세 제공 서비스에 들어가는 이미지입니다.<br/>*이미지 사이즈 및 형식(필수): 90px X 90px / PNG</span>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</div>