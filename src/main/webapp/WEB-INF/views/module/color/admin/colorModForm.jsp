<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page import="kr.co.msync.web.module.color.ColorController" %>
<%@ page import="kr.co.msync.web.module.common.type.ResultType" %>
<%@ page import="kr.co.msync.web.module.device.DeviceController" %>
<%@ page import="kr.co.msync.web.module.cate.CateController" %>
<%@ page import="kr.co.msync.web.module.service.ServiceController" %>
<script type="text/javascript">
    $(document).ready(function(){

    });

    function jsModAction(){

        $("#modForm").validate({
            rules: {
                service_name: "required",
            },
            messages: {
                service_name: "매장명을 입력해 주세요.",
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

        var data = $("#modForm").serialize();

        $("#modForm").ajaxForm({
            url: "<%=ColorController.COLOR_MOD_ACTION%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (data) {
                if(data.resultCode == <%=ResultType.SUCCESS%>){
                    alert("수정 되었습니다.");
                    location.href= "<%=ColorController.COLOR%>";
                } else {
                    alert("저장 중 에러가 발생했습니다.");
                    return;
                }
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });

        $("#modForm").submit();
    }

    function jsSetColor(){
        var val = $("#modForm").find("[name=color_rgb]").val();
        if(val.length==7)
            $("#modForm .color_chip").css("background-color",val);
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
                <li class="on"><h4><a href="<%=ColorController.COLOR%>">상품 색상 리스트</a></h4></li>
                <li><h4><a href="<%=ColorController.COLOR_REG_FORM%>">상품 색상 등록</a></h4></li>
                <li><h4><a href="<%=CateController.CATE%>">상품 카테고리 리스트</a></h4></li>
                <li><h4><a href="<%=CateController.CATE_REG_FORM%>">상품 카테고리 등록</a></h4></li>
            </ul>
        </li>
        <li class="menu_title">
            <h2><a href="<%=ServiceController.SERVICE%>">서비스 관리</a></h2>
            <ul>
                <li><h4><a href="<%=ServiceController.SERVICE%>">서비스 리스트</a></h4></li>
                <li><h4><a href="<%=ServiceController.SERVICE_REG_FORM%>">서비스 등록</a></h4></li>
            </ul>
        </li>
    </ul>
</div>
<!-- ///컨텐츠-->
<div class="contents">
    <div class="contents_now">
        <span>항목</span>
        <span>상품관리 관리</span>
        <span class="now_page">상품 색상 수정</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>상품 색상 수정</h2>
        </div>
        <div class="btn_wrap">
            <div class="btn list w90"><a href="<%=ColorController.COLOR%>">목록</a></div>
            <div class="btn red w90"><a href="javascript:;" onclick="jsModAction();">저장</a></div>
        </div>
    </div>

    <form name="modForm" id="modForm" onsubmit="return false;" method="post">
        <input type="hidden" name="no_color" value="${vo.no_color}">
        <!-- 공통 검색폼 -->
        <div class="search_wrap basic_table_wrap">
            <div class="title">
                <h3>색상 정보</h3>
            </div>
            <div class="form_wrap">
                <table>
                    <colgroup>
                        <col style="width: 180px">
                        <col style="width: calc(100% - 180px)">
                    </colgroup>

                    <tr class="product_code">
                        <td class="infotd">색상명</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w283 ml0">
                                    <input type="text" name="color_name" value="${vo.color_name}" maxlength="300">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">색상</td>
                        <td>
                            <div class="td_inner_2 ">
                                <div class="input_wrap w120 ml0 in-block">
                                    <input type="text" name="color_rgb" value="${vo.color_rgb}" onkeyup="jsSetColor();" maxlength="7">
                                </div>
                                <div class="color_chip big" style="background-color:${vo.color_rgb}"></div>
                                <span class="notice block">색상은 RGB코드로 입력해주세요. 예) #FFFFFF</span>
                            </div>
                        </td>
                    </tr>
                    <tr class="period">
                        <td class="infotd">사용 여부</td>
                        <td class="inner_table">
                            <div class="td_inner">
                                ${ufn:getRadioButton('use_yn', 'y', 'use_yn', vo.use_yn, '')}
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</div>