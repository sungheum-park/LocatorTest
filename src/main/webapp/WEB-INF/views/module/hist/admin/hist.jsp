<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.msync.web.module.hist.HistController" %>
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
            url: "<%=HistController.HIST_LIST%>",
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

    function jsHistView() {

        var checkLeng = $("#listForm").find("[name=check_no_hist]:checked").length;

        if(checkLeng==0) {
            alert("조회할 로그를 선택해 주세요.");
            return;
        }

        if(checkLeng>2) {
            alert("최대 2개만 선택하여 조회할 수 있습니다.");
            return;
        }

        if(checkLeng==2) {
            var no_hist1 = $("#listForm").find("[name=check_no_hist]:checked").eq(0).val();
            var no_hist2 = $("#listForm").find("[name=check_no_hist]:checked").eq(1).val();
            if($("#listForm").find("[name=action_status_"+no_hist1+"]").val()!=$("#listForm").find("[name=action_status_"+no_hist2+"]").val()){
                alert("같은 속성만 비교하여 조회할 수 있습니다.");
                return;
            }
        }

        var data = $("#listForm").serialize();

        $.ajax({
            url: "<%=HistController.HIST_VIEW_MODAL%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $('.log_popup').show();
                $(".log_popup").css("display", "block");
                $(".log_popup").html(result);
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    }

    function jsReset() {
        $("#searchForm").find("input, select").not("input[type=hidden]").each(function(){
            $(this).val("");
        });

        jsList(1);
    }

</script>
<!-- ///공통 사이드메뉴 -->
<div class="side_menu_wrap">
    <ul>
        <li class="menu_title">
            <h2><a href="<%=HistController.HIST%>">로그 관리</a></h2>
            <ul>
                <li class="on"><h4><a href="<%=HistController.HIST%>">로그 리스트</a></h4></li>
            </ul>
        </li>
    </ul>
</div>

<!-- ///컨텐츠-->
<div class="contents">
    <div class="contents_now">
        <span>로그</span>
        <span>로그 관리</span>
        <span class="now_page">로그 조회</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>로그 조회</h2>
        </div>
    </div>

    <!-- 공통 검색폼 -->
    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>로그 검색</h3>
        </div>
        <div class="form_wrap">
            <form name="searchForm" id="searchForm" onsubmit="return false;" method="post">
                <input type="hidden" name="page">
                <input type="hidden" name="order_column" value="" />
                <input type="hidden" name="order_type" value="" />
                <input type="hidden" name="perPageNum" value="10">
                <table>
                    <colgroup>
                        <col style="width: 180px">
                        <col style="width: calc(100% - 180px)">
                    </colgroup>
                    <tr class="search_word">
                        <td class="infotd">로그인 아이디</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="login_id">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">사용자명</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="user_name">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">사용자 권한</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("user_grt","Y", "user_grt", true, "")}
                                </div>
                            </div>
                        </td>
                        <td class="infotd">속성</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("no_menu", "Y", "no_menu", true, "")}
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="period">
                        <td class="infotd">활동</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("action_status", "Y", "action_status", true, "")}
                                </div>
                            </div>
                        </td>
                        <td class="infotd">활동일</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w120 start">
                                    <input type="text" class="picker" name="action_time_start" readonly="readonly">
                                </div>
                                <div class="input_wrap w120 ml end">
                                    <input type="text" class="picker" name="action_time_end" readonly="readonly">
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