<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script>
    /*function jsCloseModal() {
        $(".all_mod_store_status_popup").fadeOut(300);
    }*/
    $(function(){
        $("#storeStatusModalForm").find("[name=store_status]").bind("click",function(){
            const $statusPeriod = $(this).parents("#storeStatusModalForm").find(".period");
            if($(this).val()=="02") {
                $("[name=store_due_date]").val("");
                $statusPeriod.find(".rm_dt").eq("0").html("시작 예정일");
                $statusPeriod.show();
            } else if($(this).val()=="03") {
                $("[name=store_due_date]").val("");
                $statusPeriod.find(".rm_dt").eq("0").html("종료 예정일");
                $statusPeriod.show();
            } else {
                $statusPeriod.hide();
            }

        });

        $('.all_mod_store_status_popup .picker').datepicker({
            language: 'ko',
            todayButton: new Date(),
            position: 'top left',
            dateFormat: 'yyyy-M-dd',
            autoClose: true,
            timeFormat:  "hh:mm:ss"
        });
    });
</script>
<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>상태 일괄 수정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal('store_status');"></div>
    </div>

    <div class="scroll_wrap">
        <div class="all_list list allmode basic_table_wrap">
            <form name="storeStatusModalForm" id="storeStatusModalForm" onsubmit="return false;" method="post">
                <table id="all_change_device ">
                    <tr class="product_code">
                        <td class="infotd">상태 설정</td>
                        <td class="destd store_status_code">
                            <div class="td_inner_2">
                                ${ufn:getRadioButton('store_status', 'y', 'store_status', '01', '')}
                            </div>
                        </td>
                    </tr>
                    <tr class="product_code period" style="display:none">
                        <td class="infotd rm_dt">시작 예정일</td>
                        <td class="destd rm_dt">
                            <div class="td_inner_2">
                                <div class="input_wrap start" style="width:200px;">
                                    <input type="text" name="store_due_date" class="picker" readonly="readonly">
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="download_btn" onclick="jsSetAction('store_status');">저장</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal('store_status');">취소</button>
        </div>
    </div>
</div>

