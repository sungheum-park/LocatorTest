<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${cssPath}/terms.css?v=${updateTimeCss}">
<main id="main" class="terms">
    <section class="iqos_terms">
        <div class="inner inner768">
            <div class="section_title size-1">
                <h2 class="iqos-font"><span class="iqos-font">아이코스</span><br>서비스 정책 안내.</h2>
            </div>
            <div class="terms_list_wrap">
                <div class="terms_list">
                    <div class="terms_title">
                        <h4>제품 보증 기간</h4>
                    </div>
                    <div class="terms_des">
                        <p>제품 보증 기간은 구매일로부터 12개월입니다. 단, 구매일을<br>증빙할 수 없는 경우 제품 제조일로부터 15개월로 간주합니다.</p>
                    </div>
                </div>
                <div class="terms_list">
                    <div class="terms_title">
                        <h4>교환 서비스</h4>
                    </div>
                    <div class="terms_des listing">
                        <ul>
                            <li data-index="01">
                                보증 기간 동안 제품 하자 발생 시에는 동일 제품으로 무상 교환해 드리며, 공식 웹사이트에서 자가 진단
                                서비스를 이용하시거나, 고객서비스센터 (080-000-1905) 혹은 지정된 서비스 센터를 방문하여 교환
                                서비스를 신청하실 수 있습니다. 단, 고객의 과실로 인한 히터 블레이드 파손은 1회에 한하여 교환
                                서비스가 가능합니다.
                            </li>
                            <li data-index="02">
                                제품 교환은 지정된 택배사를 통하거나 선택한 교환처를 방문하여 새 제품을 전달받고 하자가 발생한
                                제품을 반납하는 맞교환 방식으로 처리됩니다. 맞교환 시에 하자가 발생한 제품을 반납하지 않을 경우는
                                다음 교환 서비스 진행 시에 제한이 있을 수 있습니다.
                            </li>
                            <li data-index="03">
                                교환된 제품의 보증기간은 교환일 당일 기준, 하자가 발생한 기존 제품의 남은 보증기간과 3개월을
                                비교하여, 둘 중 더 긴 기간으로 산정됩니다.
                            </li>
                            <li data-index="04">
                                서비스 센터 방문 시에 재고 부족으로 인하여 동일 색상으로 교환되지 못할 경우 다른 색상의 동일
                                제품으로 교환이 가능합니다.
                            </li>
                            <li data-index="05">
                                보증 기간 내 맞교환 신청이 가능한 제품들은 아래 종류로 규정되어 있습니다.
                                <div class="terms_depth2">
                                    <ul>
                                        <li>아이코스 키트 내 구성품 (키트가 아닌 개별 제품으로 구입한 경우에도 적용)</li>
                                        <li>아이코스 홀더</li>
                                        <li>아이코스 포켓 충전기</li>
                                        <li>정품 USB 케이블</li>
                                        <li>정품 AC 파워 어댑터</li>
                                    </ul>
                                </div>
                            </li>
                            <li data-index="06">
                                제품 교환은 지정된 택배사를 통하거나 선택한 교환처를 방문하여 새 제품을 전달받고 하자가 발생한
                                제품을 반납하는 맞교환 방식으로 처리됩니다. 맞교환 시에 하자가 발생한 제품을 반납하지 않을 경우는
                                다음 교환 서비스 진행 시에 제한이 있을 수 있습니다.
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="terms_list">
                    <div class="terms_title">
                        <h4>교환 반품 및 환불</h4>
                    </div>
                    <div class="terms_des listing">
                        <ul>
                            <li data-index="01">
                                고객 변심으로 인한 교환/반품은 제품 수령일로부터 7일 이내, 제품 및 포장 손상으로 인하여 제품 가치의
                                훼손이 없는 상태여야만 가능합니다. 영수증이 없는 경우 일반적 소비자 분쟁 해결 기준에 의거하여 판매
                                통상 가격으로 환불이 진행됩니다.
                            </li>
                            <li data-index="02">
                                고객 변심으로 인한 교환은 최초 구매 제품에 대한 반품 신청 후, 재 구매를 통해 이용 부탁 드립니다.
                                (동일 제품 색상교환 등). 다른 제품으로 교환은 최초 구매 제품에 대한 반품신청 후 재구매를 통해 이용
                                부탁 드립니다.
                            </li>
                            <li data-index="03">
                                오배송으로 인한 교환/반품 및 제품 하자로 인한 반품(환불)은 고객이 당해 제품을 배송받은 때로부터
                                3개월 이내, 오배송 또는 제품 하자를 안 날 또는 알 수 있었던 때로부터 30일 이내 신청하셔야
                                가능합니다. (단, 고객 과실에 의한 경우에는 제외)
                            </li>
                            <li data-index="04">
                                아이코스 공식 웹사이트에서 구매한 제품은 오프라인 매장에서 교환/반품이 불가합니다.
                                (단, 공식 웹사이트에서 구매한 제품이라도 보증 기간 내 제품 하자로 인한 교환은 지정된 오프라인
                                교환처에서도 가능합니다.)
                            </li>
                            <li data-index="05">
                                제품 교환/반품 신청은 고객서비스센터 (080-000-1905)로 연락 주시기 바랍니다.
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<script>
    $(document).ready(function(){
        $('.m_gnb nav ul #term_gnb, .gnb_wrap nav ul #termGnb').addClass('on').siblings().removeClass('on');
    })
</script>