<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<div class="setting_wrap scrollY">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>교환기기 일괄 수정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal('excg_device_parent');"></div>
    </div>
    <form name="excgDeviceParentModalForm" id="excgDeviceParentModalForm" onsubmit="return false;" method="post">
    <div class="scroll_wrap">
        <table>

            <tr class="block">
                <td>
                    <div class="td_inner_2">

                        <div class="button_90 excgParentBtn">
                            <a href="javascript:;" class="delete_btn" onclick="jsAllModForm('excg_device')">+ 항목 설정</a>
                        </div>

                        <table>
                            <colgroup>
                                <col style="width:10%">
                                <col style="width:30%">
                                <col style="width:50%">
                                <col style="width:10%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>기기명</th>
                                <th>색상</th>
                                <th>재고</th>
                            </tr>
                            </thead>
                            <tbody id="excg_device_parent_setting_area" class="parent_target"></tbody>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="download_btn" onclick="jsSetAction('excg_device_parent');">설정</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal('excg_device_parent');">취소</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
    });
</script>

