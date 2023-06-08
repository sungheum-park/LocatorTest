<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.msync.web.module.user.UserController" %>
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
            url: "<%=UserController.USER_LIST%>",
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
        location.href="<%=UserController.USER_REG_FORM%>";
    }

    function jsModForm(no_user) {

        var form = document.createElement("form");
        var parm = new Array();
        var input = new Array();

        form.action = "<%=UserController.USER_MOD_FORM%>";
        form.method = "post";


        parm.push( ['no_user', no_user] );

        input[0] = document.createElement("input");
        input[0].setAttribute("type", "hidden");
        input[0].setAttribute('name', parm[0][0]);
        input[0].setAttribute("value", parm[0][1]);
        form.appendChild(input[0]);

        document.body.appendChild(form);
        form.submit();
    }

    function jsDel() {

        var check_leng = $("#listForm").find("[name=check_no_user]:checked").length;

        if(check_leng<1) {
            alert("삭제할 운영자를 선택해 주세요.");
            return;
        }

        if(!confirm("삭제하시겠습니까?")) {
            return;
        }

        var data = $("#listForm").serialize();

        $.ajax({
            url: "<%=UserController.USER_DEL_ACTION%>",
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

    function jsApproved() {

        var check_leng = $("#listForm").find("[name=check_no_user]:checked").length;

        if(check_leng<1) {
            alert("승인할 운영자를 선택해 주세요.");
            return;
        }

        var isNotReadyCnt = 0;
        $("#listForm").find("[name=check_no_user]:checked").each(function(){
            if($(this).attr("value2")!="01") {
                isNotReadyCnt++;
            }
        });

        if(isNotReadyCnt>0) {
            alert("사용자 상태가 대기인 것만 선택해 주세요.");
            return;
        }

        if(!confirm("승인하시겠습니까?")) {
            return;
        } else {
            var data = $("#listForm").serialize();

            $.ajax({
                url: "<%=UserController.USER_APPROVED_ACTION%>",
                data: data,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                type: "POST",
                success: function (data) {
                    if(data.resultCode == <%=ResultType.SUCCESS%>){
                        alert("승인 되었습니다.");
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

    }

    function jsDenied() {

        var check_leng = $("#listForm").find("[name=check_no_user]:checked").length;

        if(check_leng<1) {
            alert("반려할 운영자를 선택해 주세요.");
            return;
        }

        var isNotReadyCnt = 0;
        $("#listForm").find("[name=check_no_user]:checked").each(function(){
            if($(this).attr("value2")!="01") {
               isNotReadyCnt++;
           }
        });

        if(isNotReadyCnt>0) {
            alert("사용자 상태가 대기인 것만 선택해 주세요.");
            return;
        }

        if(!confirm("반려하시겠습니까?")) {
            return;
        } else {
            var data = $("#listForm").serialize();

            $.ajax({
                url: "<%=UserController.USER_DENIED_ACTION%>",
                data: data,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                type: "POST",
                success: function (data) {
                    if(data.resultCode == <%=ResultType.SUCCESS%>){
                        alert("반려 되었습니다.");
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

    }

    function jsExcelDown(){
        var f = document.searchForm;
        f.action = '<%=UserController.USER_LIST_EXCEL_DOWNLOAD%>';
        f.submit();
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
            <h2><a href="#">운영자 관리</a></h2>
            <ul>
                <li class="on"><h4><a href="<%=UserController.USER%>">운영자 리스트</a></h4></li>
            </ul>
        </li>
    </ul>
</div>

<!-- ///컨텐츠-->
<div class="contents">
    <div class="contents_now">
        <span>운영자</span>
        <span>운영자 관리</span>
        <span class="now_page">운영자 리스트</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>운영자 리스트</h2>
        </div>
        <c:if test="${sessionScope.userInfo.user_grt eq '01'}">
        <div class="btn_wrap">
            <div class="btn"><a href="javascript:;" onclick="jsRegForm();">+ 운영자 등록</a></div>
        </div>
        </c:if>
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
                <table>
                    <colgroup>
                        <col style="width: 180px">
                        <col style="width: calc(100% - 180px)">
                    </colgroup>
                    <tr class="search_word">
                        <td class="infotd">운영자(한글) 명</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="user_name">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">운영자(영문) 명</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="user_en_name">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="infotd">이메일 주소</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="email_addr">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">로그인 아이디</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w230">
                                    <input type="text" name="login_id">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="infotd">회사명</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("user_company","Y", "user_company", true, "")}
                                </div>
                            </div>
                        </td>
                        <td class="infotd">운영자 권한</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("user_grt","Y", "user_grt", true, "")}
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">관리채널</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("store_type","Y","user_channel", true, "")}
                                </div>
                            </div>
                        </td>
                        <td class="infotd">등록유형</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("reg_way","Y","reg_way", true, "")}
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="search_word">
                        <td class="infotd">운영자 상태</td>
                        <td>
                            <div class="td_inner">
                                <div class="option_list w230">
                                    ${ufn:getSelectBox("user_status","Y","user_status", true, "")}
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