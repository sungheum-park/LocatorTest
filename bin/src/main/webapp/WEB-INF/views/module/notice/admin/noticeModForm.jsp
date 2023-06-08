<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page import="kr.co.msync.web.module.notice.NoticeController" %>
<%@ page import="kr.co.msync.web.module.common.type.ResultType" %>
<script type="text/javascript">
    $(document).ready(function(){

        $('.picker').datepicker({
            language: 'ko',
            todayButton: new Date(),
            position: 'top left',
            dateFormat: 'yyyy-M-dd',
            autoClose: true,
            timeFormat:  "hh:mm:ss"
        });

        $("[name=notice_div]").bind("click",function(){
            $("#notice_div_area").empty();
            if($(this).val()=="01"){
                $("#noticeImageTemplate").tmpl().appendTo("#notice_div_area");
            } else if($(this).val()=="02"){
                $("#noticeContentsTemplate").tmpl().appendTo("#notice_div_area");
            }
        });

        <fmt:parseDate value="${vo.display_time_start}" var="fmt_display_time_start" pattern="yyyyMMddHHmm"/>
        <fmt:formatDate value="${fmt_display_time_start}" var="display_time_start" pattern="yyyy-MM-dd HH:mm"/>
        <fmt:parseDate value="${vo.display_time_end}" var="fmt_display_time_end" pattern="yyyyMMddHHmm"/>
        <fmt:formatDate value="${fmt_display_time_end}" var="display_time_end" pattern="yyyy-MM-dd HH:mm"/>

        setTimeout(function(){
            $("#modForm").find("[name=display_time_start]").val('${display_time_start}');
            $("#modForm").find("[name=display_time_end]").val('${display_time_end}');
        }, 100)

    });

    function jsModAction(){

        var data = $("#modForm").serialize();

        $("#modForm").validate({
            rules: {
                notice_title: "required",
                notice_file_name: "required",
                notice_contents: "required",
                display_time_start: "required",
                display_time_end: "required"
            },
            messages: {
                notice_title: "제목을 입력해 주세요.",
                notice_file_name: "파일을 선택해 주세요.",
                notice_contents: "매장 메시지를 입력해 주세요.",
                display_time_start: "노출 시작일을 입력해 주세요.",
                display_time_end: "노출 종료일을 입력해 주세요."
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

        $("#modForm").ajaxForm({
            url: "<%=NoticeController.NOTICE_MOD_ACTION%>",
            type: "POST",
            data: data,
            enctype: "multipart/form-data",
            success: function(data){
                if(data.resultCode == <%=ResultType.SUCCESS%>){
                    alert("수정 되었습니다.");
                    location.href= "<%=NoticeController.NOTICE%>";
                } else {
                    alert("저장 중 에러가 발생했습니다.");
                    return;
                }
            },
            error: function(request, status, e) {
                alert(e.responseText);
            }
        });

        $("#modForm").submit();
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
                /*if(img.width < 290){
                    alert("W 290px x H 230px are allowed.");
                    $(o).val("");
                    $(o).next().next().val("");
                    return;
                }

                if(img.height < 230){
                    alert("W 290px x H 230px are allowed.");
                    $(o).val("");
                    $(o).next().next().val("");
                    return;
                }*/
            }

            readURL(o);

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
            <h2><a href="<%=NoticeController.NOTICE%>">공지사항 관리</a></h2>
            <ul>
                <li class="on"><h4><a href="<%=NoticeController.NOTICE%>">공지사항 리스트</a></h4></li>
                <li><h4><a href="<%=NoticeController.NOTICE_REG_FORM%>">공지사항 등록</a></h4></li>
            </ul>
        </li>
    </ul>
</div>
<!-- ///컨텐츠-->
<div class="contents">
    <div class="contents_now">
        <span>공지사항</span>
        <span>공지사항 관리</span>
        <span class="now_page">공지사항 수정</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>공지사항 수정</h2>
        </div>
        <div class="btn_wrap">
            <div class="btn list w90"><a href="<%=NoticeController.NOTICE%>">목록</a></div>
            <div class="btn red w90"><a href="javascript:;" onclick="jsModAction();">저장</a></div>
        </div>
    </div>

    <form name="modForm" id="modForm" onsubmit="return false;" method="post" enctype="multipart/form-data">
        <input type="hidden" name="no_notice" value="${vo.no_notice}">
        <!-- 공통 검색폼 -->
        <div class="search_wrap basic_table_wrap">
            <div class="title">
                <h3>공지사항 정보</h3>
            </div>
            <div class="form_wrap">
                <table>
                    <colgroup>
                        <col style="width: 180px">
                        <col style="width: calc(100% - 180px)">
                    </colgroup>
                    <tr class="product_code">
                        <td class="infotd">제목</td>
                        <td>
                            <div class="td_inner_2">
                                <div class="input_wrap w283 ml0">
                                    <input type="text" name="notice_title" value="${vo.notice_title}">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="period">
                        <td class="infotd">공지구분</td>
                        <td class="inner_table">
                            <div class="td_inner">
                                ${ufn:getRadioButton('notice_div', 'y', 'notice_div', vo.notice_div, '')}
                            </div>
                        </td>
                    </tr>
                    <c:if test="${vo.notice_div eq '01'}">
                    <tr class="search_word" id="notice_div_area">
                        <td class="infotd">이미지</td>
                        <td>
                            <div class=image>
                                <div class="image_wrap">
                                    <div class="button_90">
                                        <input type="file" id="file" name="notice_file" class="download_btn blind upload-hidden" onchange="fileValidate(this);">
                                        <label for="file" class="download_btn">찾아보기</label>
                                        <input class="upload-name upload_img" name="notice_file_name" readonly="readonly" value="${vo.origin_name}">
                                        <div class="file_name">
                                            <span class="file_thumb" onclick="jsImagePreview(this)">
                                                <img src="${vo.file_path}${vo.save_name}" alt="">
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </c:if>
                    <c:if test="${vo.notice_div eq '02'}">
                    <tr class="search_word" id="notice_div_area">
                        <td class="infotd text_area">매장 메시지</td></td>
                        <td colspan="3" class="text_area">
                            <div class="input_wrap ml0">
                                <textarea name="notice_contents" maxlength="1000">${vo.notice_contents}</textarea>
                            </div>
                        </td>
                    </tr>
                    </c:if>
                    <tr class="search_word">
                        <td class="infotd">노출여부</td>
                        <td class="inner_table">
                            <div class="td_inner">
                                ${ufn:getRadioButton('display_yn', 'y', 'display_yn', vo.display_yn, '')}
                            </div>
                        </td>
                    </tr>
                    <tr class="period">
                        <td class="infotd">노출기간</td>
                        <td class="td_inner">
                            <div class="input_wrap w150 start">
                                <input type="text" data-timepicker="true" data-time-format="hh:ii" class="picker" name="display_time_start" readonly="readonly">
                            </div>
                            <div class="input_wrap w150 ml end">
                                <input type="text" data-timepicker="true" data-time-format="hh:ii" class="picker" name="display_time_end" readonly="readonly">
                            </div>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
    </form>
</div>

<script id="noticeImageTemplate" type="text/x-jquery-tmpl">
<td class="infotd">이미지</td>
<td>
    <div class=image>
        <div class="image_wrap">
            <div class="button_90">
                <input type="file" id="file" name="notice_file" class="download_btn blind upload-hidden" onchange="fileValidate(this);">
                <label for="file" class="download_btn">찾아보기</label>
                <input class="upload-name upload_img" readonly="readonly">
                <div class="file_name">
                    <span class="file_thumb" onclick="jsImagePreview(this)">
                        <img src="" alt="">
                    </span>
                </div>
            </div>
        </div>
    </div>
</td>
</script>

<script id="noticeContentsTemplate" type="text/x-jquery-tmpl">
<td class="infotd text_area">매장 메시지</td></td>
<td colspan="3" class="text_area">
    <div class="input_wrap ml0">
        <textarea name="notice_contents" maxlength="1000"></textarea>
    </div>
</td>
</script>