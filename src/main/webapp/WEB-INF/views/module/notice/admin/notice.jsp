<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.msync.web.module.notice.NoticeController" %>
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
            url: "<%=NoticeController.NOTICE_LIST%>",
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
        location.href="<%=NoticeController.NOTICE_REG_FORM%>";
    }

    function jsPreview(no_notice) {

        $.ajax({
            url: "<%=NoticeController.NOTICE_PREVIEW_FORM%>",
            data: {no_notice:no_notice},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $('.notice_preview_popup').show();
                $(".notice_preview_popup").css("display", "block");
                $(".notice_preview_popup").html(result);
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    }

    function jsModForm(no_notice) {

        var form = document.createElement("form");
        var parm = new Array();
        var input = new Array();

        form.action = "<%=NoticeController.NOTICE_MOD_FORM%>";
        form.method = "post";


        parm.push( ['no_notice', no_notice] );

        input[0] = document.createElement("input");
        input[0].setAttribute("type", "hidden");
        input[0].setAttribute('name', parm[0][0]);
        input[0].setAttribute("value", parm[0][1]);
        form.appendChild(input[0]);

        document.body.appendChild(form);
        form.submit();
    }

    function jsDel() {

        var del_length = $("#listForm").find("[name=del_no_notice]:checked").length;

        if(del_length<1) {
            alert("삭제할 공지사항을 선택해 주세요.");
            return;
        }

        if(!confirm("삭제하시겠습니까?")) {
            return;
        }

        var data = $("#listForm").serialize();

        $.ajax({
            url: "<%=NoticeController.NOTICE_DEL_ACTION%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (data) {
                if(data.resultCode == <%=ResultType.SUCCESS%>){
                    alert("삭제 되었습니다.");
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
        <span class="now_page">공지사항 리스트</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>공지사항 리스트</h2>
        </div>
        <div class="btn_wrap">
            <div class="btn"><a href="javascript:;" onclick="jsRegForm();">+ 공지사항 등록</a></div>
        </div>
    </div>

    <!-- 공통 검색폼 -->
    <div class="search_wrap basic_table_wrap">
        <div class="title">
            <h3>공지사항 검색</h3>
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
                        <td class="infotd">제목</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="notice_title">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">공지 구분</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("notice_div", "Y","notice_div", true, "")}
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">노출여부</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("display_yn", "Y","display_yn", true, "")}
                                </div>
                            </div>
                        </td>
                        <td class="infotd">삭제여부</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("del_yn", "Y","del_yn", true, "")}
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