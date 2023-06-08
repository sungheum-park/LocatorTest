<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">


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
            <h2>서비스 항목 일괄수정</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal('service');"></div>
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
                                <input type="hidden" name="selected_no_service" value="${list.no_service}">
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
                <form name="serviceModalForm" id="serviceModalForm" onsubmit="return false;" method="post">
                <table id="display_offer_service">
                    <tbody>
                    </tbody>
                </table>
                </form>
            </div>
        </div>
    </div>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="download_btn" onclick="jsSetAction('service');">설정</button>
        </div>
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseModal('service');">취소</button>
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