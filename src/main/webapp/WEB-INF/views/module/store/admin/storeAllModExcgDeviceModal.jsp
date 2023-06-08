<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">

    function jsPlusBtn() {
        if(!$("#all_excg_device .excg_device_name").parent("tr").hasClass("on")) {
            alert("전체 항목에서 교환기기를 선택해 주세요.");
            return;
        }

        $("#all_excg_device .excg_device_name").parent("tr").each(function(){
            if($(this).hasClass("on")){
                $(this).removeClass("on").appendTo("#display_excg_device");
            }
        });
    }

    function jsMinusBtn() {
        if(!$("#display_excg_device .excg_device_name").parent("tr").hasClass("on")) {
            alert("노출 항목에서 교환기기를 선택해 주세요.");
            return;
        }
        $("#display_excg_device .excg_device_name").parent("tr").each(function(){
            if($(this).hasClass("on")){
                $(this).removeClass("on").appendTo("#all_excg_device");
            }
        });
    }

</script>

<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>교환기기 일괄 수정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal('excg_device');"></div>
    </div>
    <div class="scroll_wrap">
        <div class="all_list list">
            <div class="basic_table_wrap clearfix">
                <div class="title">
                    <h3>전체 항목</h3>
                </div>
            </div>
            <div class="list_wrap">
                <table id="all_excg_device">
                    <tbody>
                    <c:forEach var="list" items="${changeDeviceList}">
                        <c:if test="${list.isMap eq 'N'}">
                            <tr class="item_list">
                                <input type="hidden" name="no_device" value="${list.no_device}">
                                <input type="hidden" name="no_cate" value="${list.no_cate}">
                                <td class="excg_device_name">${list.excg_device_name}</td>
                                <c:forEach var="color" items="${list.color_array}">
                                    <input type="hidden" name="no_color" value="${color.no_color}">
                                    <input type="hidden" name="color_rgb" value="${color.color_rgb}">
                                    <input type="hidden" name="color_name" value="${color.color_name}">
                                </c:forEach>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="show_list list">
            <div class="basic_table_wrap clearfix">
                <div class="title">
                    <h3>노출 항목</h3>
                </div>
            </div>
            <form name="excgDeviceModalForm" id="excgDeviceModalForm" onsubmit="return false;" method="post">
            <div class="list_wrap">
                <table id="display_excg_device">
                    <tbody>
                    <c:forEach var="list" items="${changeDeviceList}">
                        <c:if test="${list.isMap eq 'Y'}">
                            <tr class="item_list">
                                <input type="hidden" name="no_device" value="${list.no_device}">
                                <input type="hidden" name="no_cate" value="${list.no_cate}">
                                <td class="excg_device_name">${list.excg_device_name}</td>
                                <c:forEach var="color" items="${list.color_array}">
                                    <input type="hidden" name="no_color" value="${color.no_color}">
                                    <input type="hidden" name="color_rgb" value="${color.color_rgb}">
                                    <input type="hidden" name="color_name" value="${color.color_name}">
                                </c:forEach>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            </form>
        </div>
    </div>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="download_btn" onclick="jsSetAction('excg_device');">설정</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal('excg_device');">취소</button>
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
        $(".excg_device_name").bind("click",function(){
            $(this).parent("tr").toggleClass('on');
        });
    });
</script>

<script id="setExcgDeviceParentTemplate" type="text/x-jquery-tmpl">
<tr class="item_list">
    <input type="hidden" name="selected_excg_no_device" value="{{html no_device}}">
    <input type="hidden" name="selected_no_cate" value="{{html no_cate}}">
    <input type="hidden" name="device_color_length" value="{{html color_length}}">
    <td>{{html idx}}</td>
    <td>{{html excg_device_name}}</td>
    <td>
        {{each(key,item) color_array}}
        <div class="color_wrap check_wrap">
            <input type="checkbox" class="blind" id="check_{{html no_device}}_{{html item.idx}}" name="selected_no_color" value="{{html no_device}}-{{html item.no_color}}-{{html item.idx}}">
            <label for="check_{{html no_device}}_{{html item.idx}}"></label>
            <div class="color_name">{{html item.color_name}}</div>
            <div class="color_chip" style="background-color:{{html item.color_rgb}}"></div>
        </div>
        {{/each}}
    </td>
    <td>
        {{each(key,item) color_array}}
            <div class="option_list">
                <select class="hidden_option" name="selected_device_qty">
                   <option value="1">있음</optionv>
                   <option value="0">없음</optionv>
                </select>
            </div>
        {{/each}}
    </td>
</tr>
</script>