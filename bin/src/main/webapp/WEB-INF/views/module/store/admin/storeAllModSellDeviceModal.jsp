<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">


    function jsPlusBtn() {
        if(!$("#all_sell_device .cate_name").parent("tr").hasClass("on")) {
            alert("전체 항목에서 판매기기를 선택해 주세요.");
            return;
        }

        $("#all_sell_device .cate_name").parent("tr").each(function(){
            if($(this).hasClass("on")){
                $(this).removeClass("on").appendTo("#display_sell_device");
            }
        });

        $("#display_sell_device .item_list").parent("tr").each(function(i){
            $("#display_sell_device [name=selected_cate_sno]").eq(i).val(i+1);
        });
    }

    function jsMinusBtn() {
        if(!$("#display_sell_device .cate_name").parent("tr").hasClass("on")) {
            alert("노출 항목에서 판매기기를 선택해 주세요.");
            return;
        }
        $("#display_sell_device .cate_name").parent("tr").each(function(){
            if($(this).hasClass("on")){
                $(this).removeClass("on").appendTo("#all_sell_device");
            }
        });
    }

</script>

<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>판매기기 항목 설정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal('sell_device');"></div>
    </div>
    <div class="scroll_wrap">
        <div class="all_list list">
            <div class="basic_table_wrap clearfix">
                <div class="title">
                    <h3>전체 항목</h3>
                </div>
            </div>
            <div class="list_wrap">
                <table id="all_sell_device">
                    <c:forEach var="list" items="${sellDeviceList}" varStatus="status">
                        <c:if test="${list.isMap eq 'N'}">
                            <tr class="item_list">
                                <td class="sno_handle"></td>
                                <td class="cate_name">${list.cate_name}</td>
                                <input type="hidden" name="selected_no_cate" value="${list.no_cate}">
                                <input type="hidden" name="selected_cate_sno" value="${status.count}">
                                <input type="hidden" name="selected_device_qty" value="1">
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>
        </div>
        <div class="show_list list">
            <div class="basic_table_wrap clearfix">
                <div class="title">
                    <h3>노출 항목</h3>
                </div>
            </div>
            <form name="sellDeviceModalForm" id="sellDeviceModalForm" onsubmit="return false;" method="post">
            <div class="list_wrap">
                <table id="display_sell_device">
                    <tbody id="sortable">
                    </tbody>
                </table>
            </div>
            </form>
        </div>
    </div>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="download_btn" onclick="jsSetAction('sell_device');">설정</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal('sell_device');">취소</button>
        </div>
    </div>
    <div class="color_addbtn">
        <div class="add">
            <a href="javascript:;" onclick="jsPlusBtn();"><img src="${imagePath}/layout/add.png" alt=""></a>
        </div>
        <div class="delete">
            <a href="javascript:;" onclick="jsMinusBtn();"><img src="${imagePath}/layout/delete.png" alt=""></a>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $(".cate_name").bind("click",function(){
            $(this).parent("tr").toggleClass('on');
        });
        $("#sortable").sortable({
            handle : ".sno_handle",
            scroll : false,
            update : function() {
                $("#display_sell_device .item_list").each(function(i){
                    $("#display_sell_device [name=selected_cate_sno]").eq(i).val(i+1);
                });
            }
        });
        $("#sortable").disableSelection();
    });
</script>
