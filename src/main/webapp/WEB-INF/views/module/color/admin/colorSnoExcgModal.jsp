<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page import="kr.co.msync.web.module.color.ColorController" %>
<%@ page import="kr.co.msync.web.module.common.type.ResultType" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">

    function jsCloseModal() {
        $("#all_device_color tr").remove();
        $(".color_excg_popup").fadeOut(300);
    }

    function jsSetAction() {

        var data = $("#colorModalForm").serialize();

        $.ajax({
            url: "<%=ColorController.COLOR_SNO_EXCG_ACTION%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (data) {
                if(data.resultCode == <%=ResultType.SUCCESS%>){
                    alert("변경 되었습니다.");
                    jsCloseModal();
                } else {
                    alert("다시 시도해 주세요.");
                }
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });

    }

</script>

<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>색상 항목 설정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal();"></div>
    </div>

    <form name="colorModalForm" id="colorModalForm" onsubmit="return false;" method="post">
    <div class="scroll_wrap">
        <div class="all_list wide_list">
            <div class="basic_table_wrap clearfix">
                <div class="title">
                    <h3>전체 항목</h3>
                </div>
            </div>
            <div class="list_wrap">
                <table id="all_device_color">
                    <colgroup>
                        <col style="width: 10%">
                        <col style="width: 40%">
                        <col style="width: 30%">
                        <col style="width: 20%">
                    </colgroup>
                    <tbody class="sortable">
                    <c:forEach var="list" items="${colorSnoExcgList}" varStatus="status">
                        <tr class="color_list">
                            <input type="hidden" name="color_sno" value="${status.count}">
                            <td class="check_area sno_handle">
                            </td>
                            <td>${list.color_name}</td>
                            <td>
                                <div class="td_inner_2">
                                    <div class="color_name in-block">${list.color_rgb}</div>
                                    <div class="color_chip ml5" style="background-color:${list.color_rgb}"></div>
                                </div>
                            </td>
                            <td class="date"><fmt:parseDate value="${list.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                                <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/>
                            </td>
                            <input type="hidden" name="no_color" value="${list.no_color}">
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </form>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="download_btn" onclick="jsSetAction();">설정</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal();">취소</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $(".sortable").sortable({
            handle : ".sno_handle",
            scroll : false,
            update : function() {
                $(".color_list").each(function(i){
                    $("[name=color_sno]").eq(i).val(i+1);
                });
            }
        });
        $(".sortable").disableSelection();
    });
</script>
