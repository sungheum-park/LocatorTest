<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">
    function jsCloseModal() {
        $("#all_offer_service tr").remove();
        $("#display_offer_service tr").remove();
        $(".offer_service_popup").fadeOut(300);
    }

    function jsSetAction() {
        var selectedData = [];
        var modalData = [];

        // 부모창에서 선택된 것
        $("#service_setting_area").find("[name=selected_no_service]").each(function(i){
            selectedData[i] = $(this).val();
        });

        // 자식창에서 선택된 것
        $("#display_offer_service .item_list").find("[name=no_service]").each(function(i){
            modalData[i] = $(this).val();
        });

        // 자식창에서 부모창에서 선택된것 제외
        for(var j = 0 ; j < selectedData.length ; j++) {
            var index = modalData.indexOf(selectedData[j]);
            modalData.splice(index,1);
        }

        // 시퀀스 기준으로 다른 값 찾아서 만들어줌
        for(var i = 0; i < modalData.length ; i++) {
            $("#display_offer_service .item_list input[name=no_service]:input[value="+modalData[i]+"]").each(function(){
                var index = $("#display_offer_service .item_list input[name=no_service]").index(this);
                $("#setServiceTemplate").tmpl({idx: selectedData.length+(i+1),service_name: $("#display_offer_service .item_list").eq(index).find("[class=service_name]").text(),no_service:modalData[i]}).appendTo("#service_setting_area");
            });
        }

        $("#all_offer_service .item_list input[name=no_service]").each(function(){
            $("#service_setting_area input[name=selected_no_service]:input[value="+$(this).val()+"]").parent().remove();
        });


        $("#service_setting_area tr").each(function(i){
            $(this).find("td").eq(0).text(i+1);
        });

        jsCloseModal();
    }

    function jsPlusBtn() {
        if(!$("#all_offer_service .service_name").parent("tr").hasClass("on")) {
            alert("전체 항목에서 서비스를 선택해 주세요.");
            return;
        }

        $("#all_offer_service .service_name").parent("tr").each(function(){
            if($(this).hasClass("on")){
                $(this).removeClass("on").appendTo("#display_offer_service");
            }
        });
    }

    function jsMinusBtn() {
        if(!$("#display_offer_service .service_name").parent("tr").hasClass("on")) {
            alert("노출 항목에서 서비스를 선택해 주세요.");
            return;
        }
        $("#display_offer_service .service_name").parent("tr").each(function(){
            if($(this).hasClass("on")){
                $(this).removeClass("on").appendTo("#all_offer_service");
            }
        });
    }

</script>

<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>서비스 항목 설정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal();"></div>
    </div>
    <div class="scroll_wrap">
        <div class="all_list list">
            <div class="basic_table_wrap clearfix">
                <div class="title">
                    <h3>전체 항목</h3>
                </div>
            </div>
            <div class="list_wrap">
                <table id="all_offer_service">
                    <c:forEach var="list" items="${offerServiceList}">
                        <c:if test="${list.isMap eq 'N'}">
                            <tr class="item_list">
                                <td class="service_name">${list.service_name}</td>
                                <input type="hidden" name="no_service" value="${list.no_service}">
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
                <table id="display_offer_service">
                    <tbody>
                    <c:forEach var="list" items="${offerServiceList}">
                        <c:if test="${list.isMap eq 'Y'}">
                            <tr class="item_list">
                                <td class="service_name">${list.service_name}</td>
                                <input type="hidden" name="no_service" value="${list.no_service}">
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
        $(".service_name").bind("click",function(){
            $(this).parent("tr").toggleClass('on');
        });
    });
</script>

<script id="setServiceTemplate" type="text/x-jquery-tmpl">
    <tr>
        <input type="hidden" name="selected_no_service" value="{{html no_service}}">
        <td class="sno_holder">{{html idx}}</td>
        <td class="service_name">{{html service_name}}</td>
    </tr>
</script>