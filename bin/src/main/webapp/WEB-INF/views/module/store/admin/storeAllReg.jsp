<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.msync.web.module.store.StoreController" %>
<%@ page import="kr.co.msync.web.module.common.type.ResultType" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<script type="text/javascript">
    $(document).ready(function(){
        $('#file_upload').on('change', function(){
            var file_name = $(this).val().split("\\").pop();
            var type = file_name.substring(file_name.lastIndexOf("."), file_name.length);
            type = type.toLowerCase();
            if(type != '.xls'){
                $('#file_upload').val('');
                $('#file_upload_text').val('');
                alert('엑셀(.xls)만 업로드 가능합니다.');
                return false;
            }
            $('#file_upload_text').val($(this).val().split("\\").pop());
        });
    });

    /**
     * 매장 엑셀 일괄 업로드
     */
    function file_store_upload(){
        if($('#file_upload_text').val().trim() == ''){
            alert('엑셀 파일을 선택 후 업로드를 눌러주세요.');
            return false;
        }

        if(!confirm('일괄 업로드 하시겠습니까?')){
            return false;
        }

        var ajax_data = new FormData($("#excelStoreUpload")[0]);
        $.ajax({
            url:"<%=StoreController.STORE_All_REG_ACTION%>", //request 보낼 서버의 경로
            type:'post', // 메소드(get, post, put 등)
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            data: ajax_data, //보낼 데이터
            success: function(data) {
                if(data.result == 'S'){
                    alert('대량 매장 업로드 완료되었습니다.');
                } else if(data.result == 'FILE_NULL'){
                    alert('엑셀 파일을 등록해 주세요.');
                } else if(data.result == 'FILE_TYPE_ERROR'){
                    alert('엑셀(.xls) 파일만 업로드 가능합니다.');
                } else if(data.result == 'MAX_ERROR'){
                    alert('최대 1000개의 매장 대량 등록 가능합니다.');
                } else if(data.result.indexOf("REQUIRE_NULL") > -1){
                    var cell = data.result.split("&")[1];
                    var row = data.result.split("&")[2];
                    alert(row+'번째 매장에 필수 입력 "'+ cell +'" 값이 누락되었습니다.');
                } else if(data.result.indexOf("VALIDATION_ERROR") > -1){
                    var cell = data.result.split("&")[1];
                    var row = data.result.split("&")[2];
                    alert(row+'번째 매장 "'+ cell +'" 에서 오류가 발생하였습니다.');
                } else if(data.result.indexOf("RETAIL_CODE_DUE") > -1){
                    var row = data.result.split("&")[1];
                    alert(row+'번째 매장 소매점 코드가 이미 존재합니다.');
                }
                else {
                    alert('에러가 발생하였습니다. 관리자에게 문의 바랍니다.');
                }

                $("#file_upload").val('');
                $("#file_upload_text").val('');
            }
            ,beforeSend:function(){
                $("#loader").show();
            }
            ,complete:function(){
                $("#loader").hide();
            }
            ,error: function (e) {
                console.log(e.responseText);
                alert('에러가 발생하였습니다. 관리자에게 문의 바랍니다.');
            }
        });
    }

    function code_popup(){
        $('.code_popup').show();
        $.ajax({
            url: "<%=StoreController.STORE_DEVICE_CODE_LIST%>",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $(".code_popup").css("display", "block");
                $(".code_popup").html(result);
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
                <li><h4><a href="<%=StoreController.STORE_REG_FORM%>">매장 등록</a></h4></li>
            </ul>
        </li>
        <li class="menu_title">
            <h2><a href="<%=StoreController.STORE_ALL%>">매장 일괄 관리</a></h2>
            <ul>
                <li class="on"><h4><a href="<%=StoreController.STORE_ALL_REG%>">대량 매장 업로드</a></h4></li>
                <li><h4><a href="<%=StoreController.STORE_ALL%>">대량 일괄 수정</a></h4></li>
            </ul>
        </li>
    </ul>
</div>

<!-- ///컨텐츠-->
<div class="contents">
    <div class="contents_now">
        <span>매장</span>
        <span>매장 일괄 관리</span>
        <span class="now_page">대량 매장 업로드</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>대량 매장 업로드</h2>
        </div>
    </div>

    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>대량 매장 업로드</h3>
        </div>
        <div class="form_wrap store_img_form">
            <form name="excelStoreUpload" id="excelStoreUpload" onsubmit="return false;" method="post" enctype="multipart/form-data">
                <table>
                    <tbody>
                        <tr class="block">
                            <td class="infotd">업로드</td>
                            <td>
                                <div class="image">
                                    <div class="image_wrap">
                                        <div class="button_90">
                                            <input type="file" id="file_upload" name="file_upload" class="download_btn blind upload-hidden">
                                            <label for="file_upload" class="download_btn">찾아보기</label>
                                            <input class="upload-name upload_img" id="file_upload_text" readonly="readonly" value="">
                                            <button class="in-block" style="border: 1px solid #000" onclick="file_store_upload()">엑셀 업로드</button>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
    <div class="excel-ex border">
        <div class="title">
            <h3>매장 엑셀 샘플 다운로드</h3>
        </div>
        <ol>
            <li>
                1. 아래 [1.매장 엑셀 샘플 다운로드]<%--, [2.상품엑셀 다운로드]--%> 버튼을 눌러 샘플을 참고하시기 바랍니다.
            </li>
            <li>
                2. 엑셀 파일 저장은 반드시 "Excel 97-2003 통합문서"로 저장을 하셔야 합니다. 그 외 csv나 xlsx 파일 등은 지원 되지 않습니다.
            </li>
        </ol>
        <div class="excel-sample">
            <a href="${samplePath}/iqos_store_excel_sample.xls" download>1. 매장 엑셀 샘플 다운로드</a>
            <%--<a href="#" download>2. 상품 엑셀 샘플 다운로드</a>--%>
            <button type="button" onclick="code_popup();">상품 코드표 확인</button>
        </div>
    </div>
    <div class="excel-ex">
        <div class="title">
            <h3>매장 업로드 방법</h3>
        </div>
        <ol>
            <li>
                1. 아래 항목에 설명되어 있는 내용을 기준으로 엑셀 파일을 작성합니다.
            </li>
            <li>
                2. 매장 다운로드에서 받은 엑셀이나 [1.매장 엑셀 샘플 다운로드] 버튼을 눌러 다운받은 엑셀 파일을 기준으로 작성합니다.
            </li>
            <li>
                3. 엑셀 파일 저장은 반드시 "Excel 97-2003 통합문서"로 저장을 하셔야 합니다. (csv 파일이나 xlsx 파일이 아닌 xls 파일입니다.)
            </li>
            <li>
                4. 작성된 엑셀 파일을 업로드 합니다.
            </li>
        </ol>
    </div>
</div>
<div id="loader" class="type2">
    <p><img src="${imagePath}/layout/loading.gif"></p>
</div>

<style>
    #loader.type2{display:none; position:absolute; top:0; left:0; width:100%; height:100%; margin:0; z-index: 100; background:rgba(0,0,0,0.7);}
    #loader.type2 p{position:absolute; top:40%; left:50%; transform:translateX(-50%); width:64px; height:64px; border-radius: 50%; background:#fff;}
    #loader.type2 img{display:block; width:100%; height:100%;}
</style>