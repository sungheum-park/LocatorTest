<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp" %>
<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page import="kr.co.msync.web.module.user.UserController" %>
<%@ page import="kr.co.msync.web.module.common.type.ResultType" %>
<script type="text/javascript">
    $(document).ready(function () {

    });

    var minLength = 0;
    <c:choose>
        <c:when test="${sessionScope.userInfo.user_grt eq '01' or sessionScope.userInfo.user_grt eq '02'}">
            minLength = 12;
        </c:when>
        <c:otherwise>
            minLength = 9;
        </c:otherwise>
    </c:choose>

    function jsRegAction() {

        var data = $("#regForm").serialize();

        $.validator.addMethod("passwordValidate", function (value, element) {
            var isSuccess = true;
            var reg = new RegExp('^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{' + minLength + ',}$');

            if (false === reg.test(value)) {
                isSuccess = false;
            }
            return isSuccess;
        });

        $.validator.addMethod("emailValidate", function (value, element) {
            var isSuccess = true;
            var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

            if (false === reg.test(value)) {
                isSuccess = false;
            }
            return isSuccess;
        });

        $("#regForm").validate({
            rules: {
                user_name: "required",
                user_en_name: "required",
                login_id: "required",
                email_addr: {
                    required: true,
                    emailValidate: true
                },
                password: {
                    required: true,
                    passwordValidate: true
                },
                password_to: {
                    equalTo: "#password"
                },
                user_channel: {
                    required: true,
                    minlength: 1,
                    maxlength: 6
                }
            },
            messages: {
                user_name: "사용자명(한글)을 입력해 주세요.",
                user_en_name: "사용자명(영문)을 입력해 주세요.",
                login_id: "로그인 아이디를 입력해 주세요.",
                email_addr: {
                    required: "이메일을 입력해 주세요.",
                    emailValidate: "이메일 형식을 확인해 주세요."
                },
                password: {
                    required: "비밀번호를 입력해 주세요",
                    passwordValidate: "비밀번호는 " + minLength + "자 이상이어야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다."
                },
                password_to: "비밀번호가 일치하지 않습니다.",
                user_channel: {
                    required: "관리 채널을 선택해주세요.",
                    minlength: "하나 이상의 관리 채널을 선택해주세요.",
                }
            }, errorPlacement: function (error, element) {
                // do nothing

            }, invalidHandler: function (form, validator) {
                var errors = validator.numberOfInvalids();
                if (errors) {
                    alert(validator.errorList[0].message);
                    validator.errorList[0].element.focus();
                }
            }
        });

        $("#regForm").ajaxForm({
            url: "<%=UserController.USER_REG_ACTION%>",
            data: data,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            type: "POST",
            success: function (data) {
                if (data.resultCode == <%=ResultType.SUCCESS%>) {
                    alert("등록 되었습니다.");
                    location.href = "<%=UserController.USER%>";
                } else {
                    alert(data.resultMessage);
                    return;
                }
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });

        $("#regForm").submit();
    }

</script>

<!-- ///공통 사이드메뉴 -->
<div class="side_menu_wrap">
    <ul>
        <li class="menu_title">
            <h2><a href="#">운영자 관리</a></h2>
            <ul>
                <li class="on"><h4><a href="<%=UserController.USER%>">운영자 리스트</a></h4></li>
            </ul>
        </li>
    </ul>
</div>

<!-- ///컨텐츠-->
<div class="contents">
    <div class="contents_now">
        <span>운영자</span>
        <span>운영자 관리</span>
        <span class="now_page">운영자 등록</span>
    </div>

    <!-- 공통 타이틀 -->
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>운영자 등록</h2>
        </div>
        <div class="btn_wrap">
            <div class="btn list w90"><a href="<%=UserController.USER%>">목록</a></div>
            <div class="btn red w90"><a href="javascript:;" onclick="jsRegAction();">저장</a></div>
        </div>
    </div>

    <form name="regForm" id="regForm" onsubmit="return false;" method="post">
        <!-- 공통 검색폼 -->
        <div class="search_wrap basic_table_wrap">
            <div class="title">
                <h3>운영자 정보</h3>
            </div>
            <div class="form_wrap">
                <table>
                    <colgroup>
                        <col style="width: 180px">
                        <col style="width: calc(100% - 180px)">
                    </colgroup>
                    <tr class="product_code">
                        <td class="infotd">운영자(한글) 명</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w283 ml0">
                                    <input type="text" name="user_name" maxlength="30">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">운영자(영문) 명</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w283 ml0">
                                    <input type="text" name="user_en_name" maxlength="30">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="product_code">
                        <td class="infotd">메일주소</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w283 ml0">
                                    <input type="text" name="email_addr" maxlength="100">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">로그인 아이디</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w283 ml0">
                                    <input type="text" name="login_id" maxlength="10">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="product_code">
                        <td class="infotd">비밀번호</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w283 ml0">
                                    <input type="password" id="password" name="password" maxlength="100">
                                </div>
                            </div>
                        </td>
                        <td class="infotd">비밀번호 확인</td>
                        <td>
                            <div class="td_inner">
                                <div class="input_wrap w283 ml0">
                                    <input type="password" name="password_to" maxlength="100">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="product_code">
                        <td class="infotd">회사 명</td>
                        <td>
                            <div class="td_inner_2">
                                <div class="option_list w283">
                                    ${ufn:getSelectBox("user_company","Y","user_company", false, "01")}
                                </div>
                            </div>
                        </td>
                        <td class="infotd">운영자 권한</td>
                        <td>
                            <div class="td_inner">
                                ${ufn:getRadioButton('user_grt', 'y', 'user_grt', '03', '01,02')}
                            </div>
                        </td>
                    </tr>
                    <tr class="product_code">
                        <td class="infotd">관리채널</td>
                        <td class="inner_table" colspan="3">
                            <div class="td_inner">
                                ${ufn:getCheckBox('store_type', 'y', 'user_channel', '01')}
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</div>