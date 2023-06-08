<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    $(function () {
        jsList(1);
    });

    function jsEnter() {
        if (window.event.keyCode == 13) {
            faqSearch();
        }
    }

    function jsList(page) {

        if (typeof (page) == "undefined") {
            $("#searchForm").find("input[name=page]").val("1");
        } else {
            $("#searchForm").find("input[name=page]").val(page);
        }

        var data = $("#searchForm").serialize();

        $.ajax({
            url: "<%=MainController.FAQ_LIST%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $("#listArea").css("display", "block");
                $("#listArea").html(result);
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    }

    function faqItem(no_item) {

        if (typeof (page) == "undefined") {
            $("#searchForm").find("input[name=page]").val("1");
        } else {
            $("#searchForm").find("input[name=page]").val(page);
        }

        //전체보기를 위한 값 셋팅
        if(no_item == 1){
            no_item = '';
        }
        //검색어가 있는 상태에서 항목선택시 값 초기화
        $("#searchForm").find("input[name=wordSearch]").val('');
        //선택된 faq항목 값 셋팅
        $("#searchForm").find("input[name=no_item]").val(no_item);

        var data = $("#searchForm").serialize();

        $.ajax({
            url: "<%=MainController.FAQ_LIST%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $("#listArea").css("display", "block");
                $("#listArea").html(result);
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });

    }

    function faqSearch() {
        if (typeof (page) == "undefined") {
            $("#searchForm").find("input[name=page]").val("1");
        } else {
            $("#searchForm").find("input[name=page]").val(page);
        }

        //검색시에 faq항목 선택 안되게 처리
        $('.faq_menu li').removeClass('on');
        //선택된 faq항목이 있는 상태에서 검색시 값 초기화
        $("#searchForm").find("input[name=no_item]").val('');

        var data = $("#searchForm").serialize();

        $.ajax({
            url: "<%=MainController.FAQ_LIST%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (result) {
                $("#listArea").css("display", "block");
                $("#listArea").html(result);
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });

    }
/*
    function showAnswer(no_item){
        $("#faqAnswer").css("display", "block");
    }
*/
    function jsPerPageNum() {
        var optionVal = $("[name=change_page_num] option").filter(":selected").val();
        $("#searchForm").find("[name=perPageNum]").val(optionVal);
        jsList(1);
    }

</script>
