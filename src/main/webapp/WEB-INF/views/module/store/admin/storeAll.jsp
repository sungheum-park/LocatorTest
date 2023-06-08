<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.msync.web.module.store.StoreController" %>
<%@ page import="kr.co.msync.web.module.common.type.ResultType" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<script type="text/javascript">
    $(function () {
        jsList(1);
    });

    function jsList(page) {

        $("#loader img").show();

        if (typeof (page) == "undefined") {
            $("#searchForm").find("input[name=page]").val("1");
        } else {
            $("#searchForm").find("input[name=page]").val(page);
        }

        var data = $("#searchForm").serialize();

        $.ajax({
            url: "<%=StoreController.STORE_ALL_LIST%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $("#listArea").css("display", "block");
                $("#listArea").html(result);
                $("#loader img").hide();
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });

    }

    function jsSort(o, orderColumn){
        $("#searchForm").find("[name=order_column]").val(orderColumn);

        if($(o).hasClass("btnOn") && $(o).hasClass("btnOnTop")){
            $("#searchForm").find("[name=order_type]").val("desc");
            $(o).addClass("arrange");
            $(o).addClass("btnOn");
        } else if($(o).hasClass("btnOn")) {
            $("#searchForm").find("[name=order_type]").val("asc");
            $(o).removeClass();
            $(o).addClass("arrange");
            $(o).addClass("btnOn");
            $(o).addClass("btnOnTop");
        }

        jsList(1);
    }

    function jsPerPageNum() {
        var optionVal = $("[name=change_page_num] option").filter(":selected").val();
        $("#searchForm").find("[name=perPageNum]").val(optionVal);
        jsList(1);
    }

    // 일괄 수정
    function jsAllModForm(type) {

        var del_length = $("#listForm").find("[name=store_code_array]:checked").length;

        if(del_length<1) {
            alert("일괄 수정할 매장을 선택해 주세요.");
            return;
        }

        var url = "";
        var data = null;

        switch(type){
            case "parking":
                url = "<%=StoreController.STORE_ALL_MOD_PARKING_FORM%>";
                break;
            case "treat":
                url = "<%=StoreController.STORE_ALL_MOD_TREAT_FORM%>";
                break;
            case "oper_time":
                url = "<%=StoreController.STORE_ALL_MOD_OPER_TIME_FORM%>";
                break;
            case "oper_week_time":
                url = "<%=StoreController.STORE_ALL_MOD_OPER_WEEK_TIME_FORM%>";
                break;
            case "closed_date":
                url = "<%=StoreController.STORE_ALL_MOD_CLOSED_DATE_FORM%>";
                break;
            case "sell_device":
                url = "<%=StoreController.STORE_ALL_MOD_SELL_DEVICE_FORM%>";
                break;
            case "excg_device":
                url = "<%=StoreController.STORE_ALL_MOD_EXCG_DEVICE_FORM%>";
                data = $("#excgDeviceParentModalForm").serialize();
                break;
            case "excg_device_parent":
                url = "<%=StoreController.STORE_ALL_MOD_EXCG_DEVICE_PARENT_FORM%>";
                break;
            case "service":
                url = "<%=StoreController.STORE_ALL_MOD_SERVICE_FORM%>";
                break;
            case "store_status":
                url = "<%=StoreController.STORE_ALL_MOD_STATUS_FORM%>";
                break;
            default:
                url = "";
        }

        if(url=="") {
            alert("에러가 발생했습니다.");
            return;
        }

        $.ajax({
            url: url,
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $(".all_mod_"+type+"_popup").css("display", "block");
                $(".all_mod_"+type+"_popup").html(result);
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });

    }

    // 모달 취소
    function jsCloseModal(type) {

        switch(type){
            case "parking":
                $(".all_mod_parking_popup").fadeOut(300);
                break;
            case "treat":
                $(".all_mod_treat_popup").fadeOut(300);
                break;
            case "oper_week_time":
                $(".all_mod_oper_week_time_popup").fadeOut(300);
                break;
            case "oper_time":
                $(".all_mod_oper_time_popup").fadeOut(300);
                break;
            case "closed_date":
                $(".all_mod_closed_date_popup").fadeOut(300);
                break;
            case "sell_device":
                $("#all_sell_device tr").remove();
                $("#display_sell_device tr").remove();
                $(".all_mod_sell_device_popup").fadeOut(300);
                break;
            case "excg_device":
                $("#all_excg_device tr").remove();
                $("#display_excg_device tr").remove();
                $(".all_mod_excg_device_popup").fadeOut(300);
                break;
            case "excg_device_parent":
                $(".all_mod_excg_device_parent_popup").fadeOut(300);
                break;
            case "service":
                $("#all_offer_service tr").remove();
                $("#display_offer_service tr").remove();
                $(".all_mod_service_popup").fadeOut(300);
                break;
            case "store_status":
                $(".all_mod_store_status_popup").fadeOut(300);
                break;
            default:
                $("[class$=_popup]").fadeOut(300);
        }

    }

    // 등록
    function jsSetAction(type) {

        var del_length = $("#listForm").find("[name=store_code_array]:checked").length;

        if(del_length<1) {
            alert("일괄 수정할 매장을 선택해 주세요.");
            return;
        }

        console.log(del_length);
        switch(type){
            case "parking":
                if(confirm("기존의 저장된 정보는 모두 지워집니다.\n수정하시겠습니까?")) {

                    var data = $("#listForm").serialize() + "&parking_yn=" + $("#parkingModalForm").find("[name=parking_yn]:checked").val();

                    $.ajax({
                        url: "<%=StoreController.STORE_ALL_MOD_PARKING_ACTION%>",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        type: "POST",
                        success: function (data) {
                            if(data.resultCode == <%=ResultType.SUCCESS%>){
                                $("#searchForm").find("[name=final_mod_date]").val(data.resultDate);
                                alert("수정 되었습니다.");
                                jsCloseModal('parking');
                                jsList(1);
                            } else {
                                alert("다시 시도해 주세요.");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                }
                break;
            case "treat":
                if(confirm("기존의 저장된 정보는 모두 지워집니다.\n수정하시겠습니까?")) {

                    var data = $("#listForm").serialize() + "&treat_yn=" + $("#treatModalForm").find("[name=treat_yn]:checked").val();

                    $.ajax({
                        url: "<%=StoreController.STORE_ALL_MOD_TREAT_ACTION%>",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        type: "POST",
                        success: function (data) {
                            if(data.resultCode == <%=ResultType.SUCCESS%>){
                                $("#searchForm").find("[name=final_mod_date]").val(data.resultDate);
                                alert("수정 되었습니다.");
                                jsCloseModal('treat');
                                jsList(1);
                            } else {
                                alert("다시 시도해 주세요.");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                }
                break;
            case "oper_week_time":

                var oper_week_time = "";

                $("#operTimeModalForm").find("[name=oper_week_time]").each(function(i){
                    if(i==0) {
                        oper_week_time = $(this).val();
                    } else {
                        oper_week_time += "," + $(this).val();
                    }
                });

                if(confirm("기존의 저장된 정보는 모두 지워집니다.\n수정하시겠습니까?")) {

                    var data = $("#listForm").serialize() + "&oper_week_time=" + oper_week_time;

                    $.ajax({
                        url: "<%=StoreController.STORE_ALL_MOD_OPER_WEEK_TIME_ACTION%>",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        type: "POST",
                        success: function (data) {
                            if(data.resultCode == <%=ResultType.SUCCESS%>){
                                $("#searchForm").find("[name=final_mod_date]").val(data.resultDate);
                                alert("수정 되었습니다.");
                                jsCloseModal('oper_week_time');
                                jsList(1);
                            } else {
                                alert("다시 시도해 주세요.");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                }
                break;
            case "oper_time":

                var oper_time = $("#storeOperTimeModalForm").find("[name=oper_time]").val();

                if(oper_time=="") {
                    alert("영업시간을 입력해 주세요.");
                    return;
                }

                if(confirm("기존의 저장된 정보는 모두 지워집니다.\n수정하시겠습니까?")) {

                    var data = $("#listForm").serialize() + "&oper_time=" + oper_time;

                    $.ajax({
                        url: "<%=StoreController.STORE_ALL_MOD_OPER_TIME_ACTION%>",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        type: "POST",
                        success: function (data) {
                            if(data.resultCode == <%=ResultType.SUCCESS%>){
                                $("#searchForm").find("[name=final_mod_date]").val(data.resultDate);
                                alert("수정 되었습니다.");
                                jsCloseModal('oper_time');
                                jsList(1);
                            } else {
                                alert("다시 시도해 주세요.");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                }
                break;
            case "closed_date":

                var closed_date = "";
                var isSuccess = true;

                $("#ClosedDateModalForm input[name=closed_date]").each(function(){
                    if($(this).val().indexOf(",")>-1) {
                        isSuccess = false;
                        return;
                    }
                    if($(this).val()!="") {
                        closed_date += "," + $(this).val();
                    }
                });

                if(!isSuccess) {
                    alert(",를 제거해 주십시오.");
                    return;
                }

                closed_date = closed_date.replace(",","");

                if(confirm("기존의 저장된 정보는 모두 지워집니다.\n수정하시겠습니까?")) {

                    var data = $("#listForm").serialize() + "&closed_date=" + closed_date;

                    $.ajax({
                        url: "<%=StoreController.STORE_ALL_MOD_CLOSED_DATE_ACTION%>",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        type: "POST",
                        success: function (data) {
                            if(data.resultCode == <%=ResultType.SUCCESS%>){
                                $("#searchForm").find("[name=final_mod_date]").val(data.resultDate);
                                alert("수정 되었습니다.");
                                jsCloseModal('closed_date');
                                jsList(1);
                            } else {
                                alert("다시 시도해 주세요.");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                }
                break;
            case "sell_device":

                if(confirm("기존의 저장된 정보는 모두 지워집니다.\n수정하시겠습니까?")) {

                    var data = $("#listForm").serialize() + "&" +$("#sellDeviceModalForm").serialize();

                    $.ajax({
                        url: "<%=StoreController.STORE_ALL_MOD_SELL_DEVICE_ACTION%>",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        type: "POST",
                        success: function (data) {
                            if(data.resultCode == <%=ResultType.SUCCESS%>){
                                $("#searchForm").find("[name=final_mod_date]").val(data.resultDate);
                                alert("수정 되었습니다.");
                                jsCloseModal('sell_device');
                                jsList(1);
                            } else {
                                alert("다시 시도해 주세요.");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                }
                break;
            case "excg_device":

                var selectedData = [];
                var modalData = [];

                // 부모창에서 선택된 것
                $("#excg_device_parent_setting_area").find("[name=selected_excg_no_device]").each(function(i){
                    selectedData[i] = $(this).val();
                })

                // 자식창에서 선택된 것
                $("#display_excg_device .item_list").find("[name=no_device]").each(function(i){
                    modalData[i] = $(this).val();
                })

                // 자식창에서 부모창에서 선택된것 제외
                for(var j = 0 ; j < selectedData.length ; j++) {
                    var index = modalData.indexOf(selectedData[j]);
                    modalData.splice(index,1);
                }

                // 시퀀스 기준으로 다른 값 찾아서 만들어줌
                var data = [];
                for(var i = 0; i < modalData.length ; i++) {
                    $("#display_excg_device .item_list input[name=no_device]:input[value="+modalData[i]+"]").each(function(){
                        var index = $("#display_excg_device .item_list input[name=no_device]").index(this);
                        var subData = []
                        var colorLeng = $("#display_excg_device .item_list").eq(index).find("[name=no_color]").length;
                        $("#display_excg_device .item_list").eq(index).find("[name=no_color]").each(function(j){
                            subData[j] = {idx: j+1, no_color: $(this).val(), color_rgb: $(this).next().val(), color_name: $(this).next().next().val()}
                        });
                        data[i] = {idx: i+1, color_length: colorLeng, no_device: $("#display_excg_device .item_list").eq(index).find("[name=no_device]").val(), no_cate: $("#display_excg_device .item_list").eq(index).find("[name=no_device]").next().val(), excg_device_name: $("#display_excg_device .item_list").eq(index).find("[name=no_device]").next().next().text(),color_array: subData}
                    });
                }

                $.each(data, function(k, v){
                    $("#setExcgDeviceParentTemplate").tmpl(v).appendTo("#excg_device_parent_setting_area");
                });

                $("#all_excg_device .item_list input[name=no_device]").each(function(){
                    $("#excg_device_parent_setting_area input[name=selected_excg_no_device]:input[value="+$(this).val()+"]").parent().remove();
                });

                $("#excg_device_parent_setting_area tr").each(function(i){
                    $(this).find("td").eq(0).text(i+1);
                });

                jsCloseModal('excg_device');

                break;
            case "excg_device_parent":

                if(confirm("기존의 저장된 정보는 모두 지워집니다.\n수정하시겠습니까?")) {

                    var data = $("#listForm").serialize() + "&" +$("#excgDeviceParentModalForm").serialize();

                    $.ajax({
                        url: "<%=StoreController.STORE_ALL_MOD_EXCG_DEVICE_ACTION%>",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        type: "POST",
                        success: function (data) {
                            if(data.resultCode == <%=ResultType.SUCCESS%>){
                                $("#searchForm").find("[name=final_mod_date]").val(data.resultDate);
                                alert("수정 되었습니다.");
                                jsCloseModal('excg_device_parent');
                                jsList(1);
                            } else {
                                alert("다시 시도해 주세요.");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                }
                break;

            case "service":

                if(confirm("기존의 저장된 정보는 모두 지워집니다.\n수정하시겠습니까?")) {

                    var data = $("#listForm").serialize() + "&" +$("#serviceModalForm").serialize();

                    $.ajax({
                        url: "<%=StoreController.STORE_ALL_MOD_SERVICE_ACTION%>",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        type: "POST",
                        success: function (data) {
                            if(data.resultCode == <%=ResultType.SUCCESS%>){
                                $("#searchForm").find("[name=final_mod_date]").val(data.resultDate);
                                alert("수정 되었습니다.");
                                jsCloseModal('service');
                                jsList(1);
                            } else {
                                alert("다시 시도해 주세요.");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                }
                break;

            case "store_status":
                if(confirm("기존의 저장된 정보는 모두 지워집니다.\n수정하시겠습니까?")) {
                    var data = $("#listForm").serialize() + "&" +$("#storeStatusModalForm").serialize();

                    $.ajax({
                        url: "<%=StoreController.STORE_ALL_MOD_STATUS_ACTION%>",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        type: "POST",
                        success: function (data) {
                            if(data.resultCode == <%=ResultType.SUCCESS%>){
                                $("#searchForm").find("[name=final_mod_date]").val(data.resultDate);
                                alert("수정 되었습니다.");
                                jsCloseModal('store_status');
                                jsList(1);
                            } else {
                                alert("다시 시도해 주세요.");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                }
                break;
            default:

        }

    }

    function jsModForm(store_code) {

        var form = document.createElement("form");
        var parm = new Array();
        var input = new Array();

        form.action = "<%=StoreController.STORE_MOD_FORM%>";
        form.method = "post";


        parm.push( ['store_code', store_code] );

        input[0] = document.createElement("input");
        input[0].setAttribute("type", "hidden");
        input[0].setAttribute('name', parm[0][0]);
        input[0].setAttribute("value", parm[0][1]);
        form.appendChild(input[0]);

        document.body.appendChild(form);
        form.submit();
    }

    function jsReset() {
        $("#searchForm").find("input, select").not("input[type=hidden]").each(function(){
            $(this).val("");
        });

        jsList(1);
    }

    function jsExcelDown(){
        var f = document.searchForm;
        f.action = '<%=StoreController.STORE_LIST_EXCEL_DOWNLOAD%>';
        f.submit();
    }

    function jsSyncAction() {
        var final_sync_date = $("#searchForm").find("[name=final_sync_date]").val();
        var final_mod_date = $("#searchForm").find("[name=final_mod_date]").val();

        if(final_mod_date < final_sync_date) {
            alert("동기화 할 매장이 존재하지 않습니다.\n최종 동기화 시간은 "+getSyncFormatDate(final_sync_date)+"입니다");
            return;
        }

        $.ajax({
            url: "<%=StoreController.STORE_SYNC_ACTION%>",
            data: null,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (data) {
                console.log(data);
                if(data.code == <%=ResultType.SUCCESS%>){
                    alert(data.message);
                    $("#searchForm").find("[name=final_sync_date]").val(data.final_sync_date);
                } else {
                    alert("다시 시도해 주세요.");
                }
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });

    }

    function getSyncFormatDate(final_sync_date) {

        var resultDate = final_sync_date;

        return resultDate.substring(0,4)+'-'+resultDate.substring(4,6)+'-'+resultDate.substring(6,8)+' '+resultDate.substring(8,10)+':'+resultDate.substring(10,12)+':'+resultDate.substring(12,14);
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
                <li><h4><a href="<%=StoreController.STORE_ALL_REG%>">대량 매장 업로드</a></h4></li>
                <li class="on"><h4><a href="<%=StoreController.STORE_ALL%>">대량 일괄 수정</a></h4></li>
            </ul>
        </li>
    </ul>
</div>

<!-- ///컨텐츠-->
<div class="contents">
    <div class="contents_now">
        <span>매장</span>
        <span>매장 일괄 수정 관리</span>
        <span class="now_page">매장 일괄 수정</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>매장 일괄 수정</h2>
        </div>
        <div class="btn_wrap">
            <div class="btn"><a href="javascript:;" onclick="jsSyncAction();">O 동기화</a></div>
        </div>
    </div>

    <!-- 공통 검색폼 -->
    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>매장 검색</h3>
        </div>
        <div class="form_wrap">
            <form name="searchForm" id="searchForm" onsubmit="return false;" method="post">
                <input type="hidden" name="page">
                <input type="hidden" name="order_column" value="" />
                <input type="hidden" name="order_type" value="" />
                <input type="hidden" name="perPageNum" value="20">
                <input type="hidden" name="final_sync_date" value="${final_sync_date}">
                <input type="hidden" name="final_mod_date" value="${final_mod_date}">
                <table>
                    <colgroup>
                        <col style="width: 180px">
                        <col style="width: calc(100% - 180px)">
                    </colgroup>
                    <tr class="search_word">
                        <td class="infotd">매장타입</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getStoreSelectBox("store_type","Y", "store_type",true, "",inclusive_code)}
                                </div>
                            </div>
                        </td>
                        <td class="infotd">매장명</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="store_name">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="infotd">매장 주소</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="store_total_addr">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">전화번호</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="tel_num">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">주차여부</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("parking_yn","Y", "parking_yn",true, "")}
                                </div>
                            </div>
                        </td>
                        <td class="infotd">악세사리 취급여부</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("treat_yn","Y", "treat_yn",true, "")}
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">매장상태</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("store_status","Y", "store_status",true, "")}
                                </div>
                            </div>
                        </td>
                        <td class="infotd">삭제여부</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("del_yn","Y", "del_yn",true, "")}
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="period">
                        <td class="infotd">등록일</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w120 start">
                                    <input type="text" class="picker" name="reg_date_start" readonly="readonly">
                                </div>
                                <div class="input_wrap w120 ml end">
                                    <input type="text" class="picker" name="reg_date_end" readonly="readonly">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">수정일</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w120 start">
                                    <input type="text" class="picker" name="mod_date_start" readonly="readonly">
                                </div>
                                <div class="input_wrap w120 ml end">
                                    <input type="text" class="picker" name="mod_date_end" readonly="readonly">
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
            <div class="btn_submit">
                <button onclick="jsReset();">초기화</button>
                <button onclick="jsList(1);">검색</button>
            </div>
        </div>
    </div>

    <div class="result_wrap">
        <div class="result_amount clearfix">
            <div class="left_amount">
                <ul>
                    <li>
                        <span class="search_result">검색 0개</span>
                    </li>
                    <li>
                        <span class="search_all">전체 ${total_cnt}개</span>
                    </li>
                </ul>
            </div>
            <div class="right_amount">
                <div class="option_list">
                    <select class="hidden_option" name="change_page_num" onchange="jsPerPageNum();">
                        <option value="20">20개보기</option>
                        <option value="50">50개보기</option>
                        <option value="100">100개보기</option>
                        <option value="200">200개보기</option>
                        <option value="500">500개보기</option>
                        <option value="1000">1000개보기</option>
                    </select>
                </div>
            </div>
        </div>
        <div id="loader" style="position:absolute; left:50%; width:35px; height:35px; margin:30px auto 0; z-index: 100;-webkit-transform: translateX(-50%);-moz-transform: translateX(-50%);-ms-transform: translateX(-50%);-o-transform: translateX(-50%);transform: translateX(-50%);">
            <img src="${imagePath}/layout/loading.gif">
        </div>
        <div id="listArea"></div>
    </div>
</div>