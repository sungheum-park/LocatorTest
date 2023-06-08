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
            url: "<%=StoreController.STORE_LIST%>",
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

    function jsRegForm() {
        location.href="<%=StoreController.STORE_REG_FORM%>";
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

    function jsCopyRegForm(store_code) {

        var form = document.createElement("form");
        var parm = new Array();
        var input = new Array();

        form.action = "<%=StoreController.STORE_COPY_REG_FORM%>";
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

    function jsDel() {

        var del_length = $("#listForm").find("[name=del_store_code]:checked").length;

        if(del_length<1) {
            alert("삭제할 매장을 선택해 주세요.");
            return;
        }

        if(!confirm("삭제하시겠습니까?")) {
            return;
        }

        var data = $("#listForm").serialize();

        $.ajax({
            url: "<%=StoreController.STORE_DEL_ACTION%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (data) {
                if(data.resultCode == <%=ResultType.SUCCESS%>){
                    alert("삭제 되었습니다.");
                    $("#searchForm").find("[name=final_mod_date]").val(data.StoreReqVO.mod_date);
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

    function jsSyncAction() {

        var final_sync_date = $("#searchForm").find("[name=final_sync_date]").val();
        var final_mod_date = $("#searchForm").find("[name=final_mod_date]").val();
        var final_reg_date = $("#searchForm").find("[name=final_reg_date]").val();

        if(final_mod_date < final_sync_date && final_reg_date < final_sync_date) {
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

</script>
<!-- ///공통 사이드메뉴 -->
<div class="side_menu_wrap">
    <ul>
        <li class="menu_title">
            <h2><a href="<%=StoreController.STORE%>">매장관리</a></h2>
            <ul>
                <li class="on"><h4><a href="<%=StoreController.STORE%>">매장 리스트</a></h4></li>
                <li><h4><a href="<%=StoreController.STORE_REG_FORM%>">매장 등록</a></h4></li>
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
        <span class="now_page">매장 리스트</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>매장 리스트</h2>
        </div>
        <div class="btn_wrap">
            <div class="btn"><a href="javascript:;" onclick="jsSyncAction();">O 동기화</a></div>
            <div class="btn"><a href="javascript:;" onclick="jsRegForm();">+ 매장 등록</a></div>
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
                <input type="hidden" name="perPageNum" value="10">
                <input type="hidden" name="final_sync_date" value="${final_sync_date}">
                <input type="hidden" name="final_mod_date" value="${final_mod_date}">
                <input type="hidden" name="final_reg_date" value="${final_reg_date}">
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
                                    ${ufn:getStoreSelectBox("store_type", "Y", "store_type",true, "", inclusive_code)}
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
                                <div class="input_wrap w120">
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
                        <option value="10">10개보기</option>
                        <option value="20">20개보기</option>
                        <option value="30">30개보기</option>
                        <option value="50">50개보기</option>
                        <option value="100">100개보기</option>
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