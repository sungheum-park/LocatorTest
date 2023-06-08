<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">
    function addClosedDateBtn() {
        var count = $(".close_date_wrap").length + 1 ;

        if(count>5) {
            alert("최대 5번 입력 가능합니다.");
            return;
        }

        $("#closedDateFileTemplate").tmpl().appendTo(".add_wrap");
    }

    function removeClosedDateBtn(o) {
        var count = $(".close_date_wrap").length;

        if(count<=1) return;
        $(o).parent().remove();
    }

</script>

<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>휴무 일괄 수정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal('closed_date');"></div>
    </div>

    <div class="scroll_wrap">
        <div class="all_list list allmode">
            <form name="ClosedDateModalForm" id="ClosedDateModalForm" onsubmit="return false;" method="post">
                <table id="all_change_device">
                    <tr class="product_code">
                        <td class="infotd">휴무 설정</td>
                        <td>
                            <span class="notice block ml0">월 / 주 / 요일 (예 : # / 2 / 월 - 매월 / 둘째주 / 월요일 휴무) or 20190703로 입력할 수 있습니다.<br>매장별 한가지 규칙으로 입력이 가능하며, (예 : [#/2/수],[#/#/수],[20190703]) 여러 형식을 혼합하여 사용할 수 없습니다.</span>
                            <div class="td_inner_2 add_wrap">
                                <div class="input_wrap close_date_wrap">
                                    <input type="text" maxlength="50" name="closed_date" class="w283">
                                    <span class="add_btn" onclick="addClosedDateBtn();">+ 추가</span>
                                    <span class="delete_btn" onclick="removeClosedDateBtn(this);">- 삭제</span>
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
            <button class="download_btn" onclick="jsSetAction('closed_date');">저장</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal('closed_date');">취소</button>
        </div>
    </div>
</div>

<script id="closedDateFileTemplate" type="text/x-jquery-tmpl">
<div class="input_wrap close_date_wrap">
    <input type="text" maxlength="50" name="closed_date" class="w283">
    <span class="add_btn" onclick="addClosedDateBtn();">+ 추가</span>
    <span class="delete_btn" onclick="removeClosedDateBtn(this);">- 삭제</span>
</div>
</script>
