<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">


</script>

<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>영업시간 일괄 수정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal('oper_week_time');"></div>
    </div>

    <div class="scroll_wrap">
        <div class="all_list list allmode">
            <form name="operTimeModalForm" id="operTimeModalForm" onsubmit="return false;" method="post">
                <table id="all_change_device">
                    <tbody>
                        <tr class="time_set block product_code">
                            <td class="infotd">영업시간 설정</td>
                            <td>
                                <c:forEach begin="0" end="6" varStatus="status">
                                <div class="setting_input">
                                    <div class="option_list w45">
                                        <span class="option_txt">${ufn:getCodeName("oper_week",status.index)}</span>
                                    </div>
                                    <div class="input_wrap w185 ml0">
                                        <input type="text" maxlength="50" name="oper_week_time" onkeyup="spaceDel(this);">
                                    </div>
                                </div>
                                </c:forEach>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="download_btn" onclick="jsSetAction('oper_week_time');">저장</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal('oper_week_time');">취소</button>
        </div>
    </div>
</div>
