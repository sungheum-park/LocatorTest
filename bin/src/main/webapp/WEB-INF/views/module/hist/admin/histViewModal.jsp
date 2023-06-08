<%@ taglib prefix="ufn" uri="http://java.sun.com/jsp/jstl/function" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>

<script type="text/javascript">
    function jsCloseLogModal() {
        $(".log_popup").fadeOut(300);
    }
</script>

<div class="setting_wrap">
    <div class="common_title_wrap">
        <div class="title_wrap">
            <h2>로그 내용 조회</h2>
        </div>
        <div class="close_btn" onclick="jsCloseLogModal();"></div>
    </div>

    <div class="search_wrap basic_table_wrap standard_data">
        <div class="form_wrap access">
            <c:forEach var="list" items="${list}" varStatus="status">
            <table>
                <colgroup>
                    <col style="width: 180px">
                    <col style="width: calc(100% - 180px)">
                </colgroup>
                <tr class="search_word">
                    <td class="infotd">로그인아이디/사용자명</td>
                    <td class="medium" colspan="3">
                        <span class="userId">${list.login_id}</span>
                        <span>/</span>
                        <span class="userName">${list.user_name}</span>
                    </td>
                </tr>
                <tr>
                    <td class="infotd">활동일시</td>
                    <td><fmt:parseDate value="${list.action_time}" var="fmt_action_time" pattern="yyyyMMddHHmmss"/>
                        <span class="date"><fmt:formatDate value="${fmt_action_time}" pattern="yyyy-MM-dd"/></span>
                        <span class="date"><fmt:formatDate value="${fmt_action_time}" pattern="HH:mm:ss"/></span>
                    </td>
                    <td class="infotd">속성/활동</td>
                    <td>
                        <span class="property">${ufn:getCodeName("no_menu", list.no_menu)}/${ufn:getCodeName("action_status", list.action_status)}</span>
                    </td>
                </tr>
            </table>
            </c:forEach>
        </div>

        <c:forEach begin="0" end="${fn:length(list)}" varStatus="i">
            <c:forEach var="vo" items="${list[i.index].masterVO}" varStatus="status">
                <c:if test="${list[i.index].no_menu eq '01'}">
                    <div class="grid_wrap overscroll fillIn_store">
                        <table>
                            <colgroup>
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 200px">
                                <col style="width: 100px">
                                <col style="width: 200px">
                                <col style="width: 200px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 200px">
                                <col style="width: 100px">
                                <col style="width: 300px">
                                <col style="width: 100px">
                                <col style="width: 500px">
                                <col style="width: 150px">
                                <col style="width: 300px">
                                <col style="width: 300px">
                                <col style="width: 300px">
                                <col style="width: 1000px">
                                <col style="width: 500px">
                            </colgroup>
                            <thead>
                            <tr>
                                <th>매장 코드</th>
                                <th>매장 상태</th>
                                <th>매장명</th>
                                <th>주소</th>
                                <th>상세 주소</th>
                                <th>위도/경도</th>
                                <th>찾아오는 길</th>
                                <th>매장 전화번호</th>
                                <th>주차 여부</th>
                                <th>영업시간</th>
                                <th>A/S시간</th>
                                <th>매장 메시지</th>
                                <th>매장 휴무</th>
                                <th>영업 시간</th>
                                <th>악세사리 취급 여부</th>
                                <th>관리자 메모</th>
                                <th>매장 사진</th>
                                <th>판매기기</th>
                                <th>교환기기</th>
                                <th>제공서비스</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${vo.store_code}</td>
                                <td>${ufn:getCodeName("store_status", vo.store_status)}</td>
                                <td>${vo.store_name}</td>
                                <td>${vo.store_addr}</td>
                                <td>${vo.store_addr_dtl}</td>
                                <td>${vo.latitude}, ${vo.longitude}</td>
                                <td>${vo.come_way}</td>
                                <td>${vo.tel_num}</td>
                                <td>${vo.parking_yn}</td>
                                <td>${vo.oper_time}</td>
                                <td>${vo.as_time}</td>
                                <td>${vo.notice}</td>
                                <td>${vo.closed_date}</td>
                                <td>${vo.oper_week_time}</td>
                                <td>${ufn:getCodeName("treat_yn", vo.treat_yn)}</td>
                                <td>${vo.cust_desc}</td>
                                <td>${vo.file_map_array}</td>
                                <td>${vo.sell_array}</td>
                                <td>${vo.excg_array}</td>
                                <td>${vo.service_map_array}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <c:if test="${list[i.index].no_menu eq '02'}">
                    <div class="grid_wrap fillIn_category">
                        <table>
                            <thead>
                            <tr>
                                <th>서비스명</th>
                                <th>서비스 구분</th>
                                <th>사용여부</th>
                                <th>삭제여부</th>
                                <th>등록일</th>
                                <th>수정일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${vo.service_name}</td>
                                <td>${ufn:getCodeName("service_div", vo.service_div)}</td>
                                <td>${ufn:getCodeName("use_yn", vo.use_yn)}</td>
                                <td>${ufn:getCodeName("del_yn", vo.del_yn)}</td>
                                <td><fmt:parseDate value="${vo.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td><fmt:parseDate value="${vo.mod_date}" var="fmt_mod_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_mod_date}" pattern="yyyy-MM-dd"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <c:if test="${list[i.index].no_menu eq '03'}">
                    <div class="grid_wrap fillIn_device">
                        <table>
                            <thead>
                            <tr>
                                <th>상품타입</th>
                                <th>상품명</th>
                                <th>컬러</th>
                                <th>사용여부</th>
                                <th>삭제여부</th>
                                <th>등록일</th>
                                <th>수정일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${vo.cate_name}</td>
                                <td>${vo.device_name}</td>
                                <td>${vo.color_name_array}</td>
                                <td>${ufn:getCodeName('use_yn', vo.use_yn)}</td>
                                <td>${ufn:getCodeName('del_yn', vo.del_yn)}</td>
                                <td><fmt:parseDate value="${vo.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/></td>
                                <td><fmt:parseDate value="${vo.mod_date}" var="fmt_mod_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_mod_date}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <c:if test="${list[i.index].no_menu eq '04'}">
                    <div class="grid_wrap fillIn_color">
                        <table>
                            <thead>
                            <tr>
                                <th>색상명</th>
                                <th>색상</th>
                                <th>사용여부</th>
                                <th>삭제여부</th>
                                <th>등록일</th>
                                <th>수정일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${vo.color_name}</td>
                                <td>${vo.color_rgb}</td>
                                <td>${ufn:getCodeName('use_yn', vo.use_yn)}</td>
                                <td>${ufn:getCodeName('del_yn', vo.del_yn)}</td>
                                <td>
                                    <fmt:parseDate value="${vo.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td>
                                    <fmt:parseDate value="${vo.mod_date}" var="fmt_mod_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_mod_date}" pattern="yyyy-MM-dd"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <c:if test="${list[i.index].no_menu eq '05' and list[i.index].action_status ne '05'}">
                    <div class="grid_wrap overscroll fillIn_user">
                        <table>
                            <colgroup>
                                <col style="width: 100px">
                                <col style="width: 200px">
                                <col style="width: 200px">
                                <col style="width: 300px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                                <col style="width: 100px">
                            </colgroup>
                            <thead>
                            <tr>
                                <th>운영자 번호</th>
                                <th>운영자(한글) 명</th>
                                <th>운영자(영문) 명</th>
                                <th>메일 주소</th>
                                <th>로그인 아이디</th>
                                <th>회사 명</th>
                                <th>운영자 권한</th>
                                <th>관리채널</th>
                                <th>등록유형</th>
                                <th>사용자 상태</th>
                                <th>삭제여부</th>
                                <th>등록일</th>
                                <th>수정일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${vo.no_user}</td>
                                <td>${vo.user_name}</td>
                                <td>${vo.user_en_name}</td>
                                <td>${vo.email_addr}</td>
                                <td>${vo.login_id}</td>
                                <td>${ufn:getCodeName("user_company", vo.user_company)}</td>
                                <td>${ufn:getCodeName('user_grt', vo.user_grt)}</td>
                                <td>${ufn:getCodeName('store_type', vo.user_channel)}</td>
                                <td>${ufn:getCodeName('reg_way', vo.reg_way)}</td>
                                <td>${ufn:getCodeName('user_status', vo.user_status)}</td>
                                <td>${ufn:getCodeName('del_yn', vo.del_yn)}</td>
                                <td><fmt:parseDate value="${vo.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/></td>
                                <td><fmt:parseDate value="${vo.mod_date}" var="fmt_mod_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_mod_date}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <c:if test="${list[i.index].no_menu eq '06'}">
                    <div class="grid_wrap fillIn_category">
                        <table>
                            <thead>
                            <tr>
                                <th>상품 카테고리명</th>
                                <th>판매여부</th>
                                <th>교환여부</th>
                                <th>삭제여부</th>
                                <th>등록일</th>
                                <th>수정일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${vo.cate_name}</td>
                                <td>${ufn:getCodeName("sell_yn", vo.sell_yn)}</td>
                                <td>${ufn:getCodeName("excg_yn", vo.excg_yn)}</td>
                                <td>${ufn:getCodeName("del_yn", vo.del_yn)}</td>
                                <td><fmt:parseDate value="${vo.reg_date}" var="fmt_reg_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_reg_date}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td><fmt:parseDate value="${vo.mod_date}" var="fmt_mod_date" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${fmt_mod_date}" pattern="yyyy-MM-dd"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </c:forEach>
        </c:forEach>

    </div>
    <div class="btn_wrap">
        <div class="button_90">
            <button class="delete_btn" onclick="jsCloseLogModal();">닫기</button>
        </div>
    </div>
</div>

