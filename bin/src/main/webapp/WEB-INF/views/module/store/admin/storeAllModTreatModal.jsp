<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">


</script>

<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>악세사리 취급여부 일괄 수정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal('treat');"></div>
    </div>

    <div class="scroll_wrap">
        <div class="all_list list allmode">
            <form name="treatModalForm" id="treatModalForm" onsubmit="return false;" method="post">
                <table id="all_change_device">
                    <tr class="product_code">
                        <td class="infotd">악세사리 취급여부</td>
                        <td colspan="3">
                            <div class="td_inner_2">
                                ${ufn:getRadioButton('treat_yn', 'y', 'treat_yn', 'Y', '')}
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="download_btn" onclick="jsSetAction('treat');">저장</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal('treat');">취소</button>
        </div>
    </div>
</div>
