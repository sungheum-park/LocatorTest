<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">


    function jsCloseModal() {
        $("#all_device_color tr").remove();
        $("#display_device_color tr").remove();
        $(".color_setting_popup").fadeOut(300);
    }

    function jsSetAction() {

        var selectedData = [];
        var modalData = [];

        // 부모창에서 선택된 것
        $("#color_setting_area").find("[name=selected_no_color]").each(function(i){
            selectedData[i] = $(this).val();
        });

        // 자식창에서 선택된 것
        $("#display_device_color .color_list").find("[name=no_color]").each(function(i){
            modalData[i] = $(this).val();
        });

        // 자식창에서 부모창에서 선택된것 제외
        for(var j = 0 ; j < selectedData.length ; j++) {
            var index = modalData.indexOf(selectedData[j]);
            modalData.splice(index,1);
        }

        // 시퀀스 기준으로 다른 값 찾아서 만들어줌
        for(var i = 0; i < modalData.length ; i++) {
            $("#display_device_color .color_list input[name=no_color]:input[value="+modalData[i]+"]").each(function(){
                var index = $("#display_device_color .color_list input[name=no_color]").index(this);
                $("#setColorTemplate").tmpl({idx: selectedData.length+(i+1),color_name: $("#display_device_color .color_list").eq(index).find("[class=color_name]").text(),color_rgb: $("#display_device_color .color_list").eq(index).find("[class=color_code] span").text(),no_color:modalData[i], no_file: $("#display_device_color .color_list").eq(index).find("[name=no_color]").val()}).appendTo("#color_setting_area");
            });
        }

        $("#all_device_color .color_list input[name=no_color]").each(function(){
            $("#color_setting_area input[name=selected_no_color]:input[value="+$(this).val()+"]").parent().remove();
        });


        /*$("#color_setting_area tr").each(function(i){
            $(this).find("td").eq(0).text(i+1);
        });*/

        jsCloseModal();
    }

    function jsPlusBtn() {
        if(!$("#all_device_color .color_list").hasClass("on")) {
            alert("전체 항목에서 컬러를 선택해 주세요.");
            return;
        }

        $("#all_device_color .color_list").each(function(){
            if($(this).hasClass("on")){
                $(this).removeClass("on").appendTo("#display_device_color");
            }
        });
    }

    function jsMinusBtn() {
        if(!$("#display_device_color .color_list").hasClass("on")) {
            alert("노출 항목에서 컬러를 선택해 주세요.");
            return;
        }
        $("#display_device_color .color_list").each(function(){
            if($(this).hasClass("on")){
                $(this).removeClass("on").appendTo("#all_device_color");
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
    <div class="scroll_wrap">
        <div class="all_list list">
            <form name="itemModalForm" id="itemModalForm" onsubmit="return false;" method="post">
                <div class="basic_table_wrap clearfix">
                    <div class="title">
                        <h3>전체 항목</h3>
                    </div>
                </div>
            </form>
            <div class="list_wrap">
                <table id="all_device_color">
                    <c:forEach var="list" items="${deviceColorList}">
                        <c:if test="${list.isMap eq 'N'}">
                            <tr class="color_list">
                                <td class="color_name">${list.color_name}</td>
                                <td class="color_code">
                                    <span>${list.color_rgb}</span>
                                </td>
                                <td>
                                    <div class="color_box" style="background-color: ${list.color_rgb}; border: 1px solid #bfbfbf;"></div>
                                </td>
                                <input type="hidden" name="no_color" value="${list.no_color}">
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
            <div class="list_wrap">
                <table id="display_device_color">
                    <tbody>
                    <c:forEach var="list" items="${deviceColorList}">
                        <c:if test="${list.isMap eq 'Y'}">
                            <tr class="color_list">
                                <td class="color_name">${list.color_name}</td>
                                <td class="color_code">
                                    <span>${list.color_rgb}</span>
                                </td>
                                <td>
                                    <div class="color_box" style="background-color: ${list.color_rgb}; border: 1px solid #bfbfbf;"></div>
                                </td>
                                <input type="hidden" name="no_color" value="${list.no_color}">
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="download_btn" onclick="jsSetAction();">설정</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal();">취소</button>
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
        $(".color_list").bind("click",function(){
            $(this).toggleClass('on');
        });
    });
</script>

<script id="setColorTemplate" type="text/x-jquery-tmpl">
    <tr>
        <input type="hidden" name="selected_no_color" value="{{html no_color}}">
        <input type="hidden" name="selected_color_sno" value="{{html idx}}">
        <td class="sno_holder"></td>
        <td class="color_name">{{html color_name}}</td>
        <td>
            <div class="color">
                <span>{{html color_rgb}}</span>
                <span class="color_chip" style="background-color:{{html color_rgb}};  border: 1px solid #bfbfbf;"></span>
            </div>
        </td>
        <td class=image>
            <div class="image_wrap">
                <div class="button_90">
                    <input type="file" id="file_{{html no_file}}" name="device_file_{{html no_file}}" class="download_btn blind upload-hidden" onchange="fileValidate(this);">
                    <label for="file_{{html no_file}}" class="download_btn">찾아보기</label>
                    <input class="upload-name upload_img" name="device_file_name" readonly="readonly">
                    <div class="file_name">
                        <span class="file_thumb" onclick="jsImagePreview(this)">
                            <img src="" alt="">
                        </span>
                    </div>
                </div>
            </div>
        </td>
        <td class="inner_table">
            <div class="option_list">
                <select class="hidden_option" name="selected_limit_yn">
                    <option value="01">일반</option>
                    <option value="02">한정</option>
                </select>
            </div>
        </td>
    </tr>
</script>
