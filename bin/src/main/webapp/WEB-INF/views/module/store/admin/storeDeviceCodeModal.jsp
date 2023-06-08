<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">
    var sellCodeArray=[], excgCodeArray=[], serviceArray=[], colorArray=[];
    <c:forEach var="list" items="${sellDeviceList}">
    sellCodeArray.push({name:"${list.cate_name}", code:"${list.no_cate}"});
    </c:forEach>

    <c:forEach var="list" items="${changeDeviceList}">
    excgCodeArray.push({name:"${list.cate_name}"+" "+"${list.device_name}", code:"${list.no_cate}${list.no_device}"});
    </c:forEach>

    <c:forEach var="list" items="${offerServiceList}">
    serviceArray.push({name:"${list.service_name}", code:"${list.no_service}"});
    </c:forEach>

    <c:forEach var="list" items="${colorAllList}">
    colorArray.push({name:"${list.color_name}", code:"${list.no_color}"});
    </c:forEach>

    const arrayList = [{name:"sellCodeArray", array : sellCodeArray},
                       {name:"excgCodeArray", array : excgCodeArray},
                       {name:"serviceArray", array : serviceArray},
                       {name:"colorArray", array : colorArray}
                      ];

    var codeBoolean = false;
    function codeTypeClick(type, target){
        if(!codeBoolean && $(target).hasClass("active")) return false;
        codeBoolean=false;
        $(".code_search input").val('');
        $(".code_category button").removeClass("active");
        $(target).addClass("active");
        codeData(type);
    }

    function codeData(type){
        var html="";
        $(".code_table tbody").empty();
        if(type == "none"){
            html+="<tr><td colspan='4'>검색 결과가 없습니다.</td></tr>";
        }else{
            for(var i=0; i<type.length; i++){
                if(i%2==0) html+="<tr>";
                html += "<td>"+type[i].name+"</td>";
                html += "<td>"+type[i].code+"</td>";
                if(i%2==1) html+="</tr>";
            }
        }
        $(".code_table tbody").append(html);
    }

    function jsCloseModal() {
        $(".code_popup").fadeOut(300, function(){
            $(".code_category button").eq(0).click();
        });
    }

    function enterkey() {
        if (window.event.keyCode == 13) {
            $(".code_search button").click();
        }
    }

    $(function(){
        $(".code_search button").on("click", function(){ //상품 코드표 검색
            codeBoolean = true;
            let searchText = $(this).prev("input").val().trim();
            let $category = $(".code_category button.active").attr("name");

            if(searchText.length == 0){
                $(".code_category button.active").click();
                return false;
            }

            let codeArray = arrayList.filter((elem) => {
                return (elem.name.indexOf($category) > -1);
            });

            let searchResult = codeArray[0].array.filter((elem) => {
                return (elem.name.indexOf(searchText) > -1 || elem.code.indexOf(searchText) > -1);
            });

            if(searchResult.length == 0){
                codeData("none");
            }else{
                codeData(searchResult);
            }
        });
    });
</script>

<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>상품 코드표</h2>
        </div>
        <div class="close_btn" onclick="jsCloseModal();"></div>
    </div>
    <div class="scroll_wrap">
        <div class="code_search">
            <input type="text" onkeyup="enterkey();" >
            <button >검색</button>
        </div>
        <div class="code_category">
            <button onclick="codeTypeClick(sellCodeArray, this);" class="sell active" name="sellCodeArray">판매기기</button>
            <button onclick="codeTypeClick(excgCodeArray, this);" class="excg" name="excgCodeArray">교환기기</button>
            <button onclick="codeTypeClick(serviceArray, this);" class="service" name="serviceArray">제공 서비스</button>
            <button onclick="codeTypeClick(colorArray, this);" class="color" name="colorArray">컬러</button>
        </div>
        <div class="code_table" style="display: block">
            <table>
                <colgroup>
                    <col width="190px">
                    <col width="190px">
                    <col width="190px">
                    <col width="190px">
                </colgroup>
                <thead>
                <tr>
                    <td>항목명</td>
                    <td>코드값</td>
                    <td>항목명</td>
                    <td>코드값</td>
                </tr>
                </thead>
                <tbody>
                <c:set var="sell" value="0" />
                <c:forEach var="list" items="${sellDeviceList}" varStatus="status">
                    <c:if test="${sell%2 == 0}">
                        <tr>
                    </c:if>
                        <td>${list.cate_name}</td>
                        <td>${list.no_cate}</td>
                    <c:if test="${sell%2 == 1}">
                        </tr>
                    </c:if>
                    <c:set var="sell" value="${sell+1}" />
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
