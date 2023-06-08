<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${cssPath}/selfCheck.css?v=${updateTimeCss}">
<script src="${jsPath}/selfCheck.js?v=${updateTimeCss}"></script>
<main id="main" class="self-check">
    <!-- 자가진단 설명 -->
    <section class="online_self_check">
        <div class="inner inner768">
            <div class="section_title">
                <h2><span>아이코스</span><br>
                    온라인 자가진단.</h2>
            </div>
            <div class="self_check_text">
                <div class="sub_title">
                    <h4>온라인 자가진단.</h4>
                </div>
                <div class="default_des">
                    <p>
                        고객님께서 겪고 계신 기기 증상을 온라인 자가진단을 통해<br>
                        보다 빠르고 편리하게 진단해보세요.문제에 대한 대응방법을<br>
                        편리하게 얻으실 수 있습니다.
                    </p>
                </div>
            </div>
        </div>
    </section>
    <!-- //자가진단 설명 -->
    <!-- 기기 등록 -->
    <section class="register_section">
        <div class="inner inner768">
            <div class="sub_title">
                <h4>자가진단을 하기 전,<br>기기를 먼저 등록해주세요!</h4>
            </div>
            <div class="btn_register_toggle">
                <a href="#" id="showWay">기기 등록방법 보기</a>
            </div>
            <div class="way">
                <div class="register_way">
                    <div class="care_title iqos-ani-fadeup">
                        <p>기기 등록 방법.</p>
                    </div>
                    <div class="register_steps step_inner">
                        <div class="regi_step">
                            <div class="regi_img iqos-ani-fadeltr">
                                <img src="${imagePath}/tutorial/register_02.png" alt="사이트 방문">
                            </div>
                            <div class="regi_txt">
                                <div class="regi_txt_title step_title iqos-ani-fadeup">
                                    <h4><span>01</span> 등록된 기기 메뉴 선택</h4>
                                    <p>아이코스 공식 웹사이트 (kr.iqos.com)에<br>방문하여 로그인 후, ‘ 내 계정 ’ 페이지 상단 <br>[등록된 기기 메뉴]를 선택하세요.</p>
                                </div>
                            </div>
                        </div>
                        <div class="regi_step">
                            <div class="regi_img iqos-ani-fadeltr">
                                <img src="${imagePath}/tutorial/register_03.png" alt="사이트 방문">
                            </div>
                            <div class="regi_txt">
                                <div class="regi_txt_title step_title iqos-ani-fadeup">
                                    <h4><span>02</span> 다른 기기 추가</h4>
                                    <p>[ 다른 기기 추가 ] 버튼을 클릭하여 12자리<br>제품 번호를 입력하면 기기등록이완료 됩니다. </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="check_code care_con">
                    <div class="care_title iqos-ani-fadeup">
                        <p>제품번호 확인 방법.</p>
                    </div>
                    <div class="care_des iqos-ani-fadeup">
                        <p>아이코스 2.4+ / 아이코스3 / 아이코스3 멀티 기기에<br>표시된 14자리 제품번호를 확인하실 수 있습니다.</p>
                    </div>
                    <div class="code_img_wrap iqos-ani-fadeup">
                        <div class="_img_wrap">
                            <img src="${imagePath}/tutorial/code_03.jpg" alt="제품번호 확인">
                        </div>
                        <div class="_img_wrap">
                            <img src="${imagePath}/tutorial/code_02.jpg" alt="제품번호 확인">
                        </div>
                    </div>
                </div>
                <div class="btn_register_toggle">
                    <a href="#" class="btt">기기 등록방법 보기</a>
                </div>
            </div>
        </div>
    </section>
    <!-- //기기 등록 -->
    <!-- 자가진단 방법 안내 -->
    <section class="self_check_method">
        <div class="inner inner768">
            <div class="check_steps">
                <div class="sub_title iqos-ani-fadeup">
                    <h4>온라인 자가진단 방법 안내.</h4>
                </div>
                <div class="step_list step_inner">
                    <div class="step iqos-ani-fadeup">
                        <div class="step_img _img_wrap">
                            <img src="${imagePath}/self_check/self_check_step_01.jpg" alt="기기 이상">
                        </div>
                        <div class="step_text">
                            <div class="step_title">
                                <h4><span>01</span>기기 이상</h4>
                                <p>리셋으로도 해결되지 않는 기기 문제<br>발생시, 온라인 자가진단을 통해 진단부터<br>제품교환까지 받아보세요.</p>
                            </div>
                        </div>
                    </div>
                    <div class="step iqos-ani-fadeup">
                        <div class="step_img _img_wrap">
                            <img src="${imagePath}/self_check/self_check_step_02.jpg" alt="My Page">
                        </div>
                        <div class="step_text">
                            <div class="step_title">
                                <h4><span>02</span><em>My Page</em></h4>
                                <p>아이코스 공식 웹사이트(kr.iqos.com)에<br>로그인 후 우측 상단의 '내 계정'을 클릭하고,<br>등록된 기기 페이지로 접속해주세요.</p>
                            </div>
                        </div>
                    </div>
                    <div class="step iqos-ani-fadeup">
                        <div class="step_img _img_wrap">
                            <img src="${imagePath}/self_check/self_check_step_03.jpg" alt="자가 진단 선택">
                        </div>
                        <div class="step_text">
                            <div class="step_title">
                                <h4><span>03</span>자가 진단 선택</h4>
                                <p>등록된 기기 목록 중 문제가 발생한 기기 하단의<br>‘제품 자가 진단’ 버튼을 클릭해주세요.</p>
                            </div>
                        </div>
                    </div>
                    <div class="step iqos-ani-fadeup">
                        <div class="step_img _img_wrap">
                            <img src="${imagePath}/self_check/self_check_step_04.jpg" alt="기기 진단">
                        </div>
                        <div class="step_text">
                            <div class="step_title">
                                <h4><span>04</span>기기 진단</h4>
                                <p>고객님께서 겪고 있는 문제를 선택해주세요.</p>
                            </div>
                        </div>
                    </div>
                    <div class="step iqos-ani-fadeup">
                        <div class="step_img _img_wrap">
                            <img src="${imagePath}/self_check/self_check_step_05.jpg" alt="기기 교환 가능 여부 확인">
                        </div>
                        <div class="step_text">
                            <div class="step_title">
                                <h4><span>05</span>기기 교환 가능 여부 확인</h4>
                                <p>기기 교환 가능 여부를 확인해주세요.</p>
                            </div>
                        </div>
                    </div>
                    <div class="step iqos-ani-fadeup">
                        <div class="step_img _img_wrap">
                            <img src="${imagePath}/self_check/self_check_step_06.jpg" alt="제품 수령 방법 확인">
                        </div>
                        <div class="step_text">
                            <div class="step_title">
                                <h4><span>06</span>제품 수령 방법 확인</h4>
                                <p>원하시는 교환 방법을 선택해주세요.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="btn_self_check_start iqos-ani-fadeup">
                    <%--<a href="https://kr.iqos.com/on/demandware.store/Sites-KR-Site/ko_KR/Account-IncludeAddDevice" target="_blank"><span>자가 진단 시작하기</span></a>--%>
                    <a href="https://kr.iqos.com/support/troubleshooting/iqos/3-duo" target="_blank"><span>자가 진단 시작하기</span></a>
                </div>
            </div>
        </div>
    </section>
    <!-- //자가진단 방법 안내 -->
    <!-- 아이코스 고객서비스센터 -->
    <section class="cs_center">
        <div class="inner inner768">
            <div class="section_title iqos-ani-fadeup">
                <h2><span>아이코스</span><br>
                    온라인 자가진단.</h2>
            </div>
            <div class="self_check_text">
                <div class="sub_title iqos-ani-fadeup">
                    <h4>더 궁금하신 점은 고객 서비스센터 <br>상담원에게 문의해주세요.</h4>
                </div>
                <div class="default_des iqos-ani-fadeup">
                    <p>
                        운영시간: 월-일, 24시간<br>
                        전화: 080-000-1905 <br>
                        이메일: contact.KR@iqos.com<br>
                        카카오톡&페이스북: ‘아이코스 고객서비스센터’ 검색
                    </p>
                </div>
            </div>
            <div class="btn_self_check_start iqos-ani-fadeup">
                <a href="#"><span>고객 서비스 센터</span></a>
            </div>
        </div>
    </section>
    <!-- //아이코스 고객서비스센터 -->

</main>

<script>
    $(document).ready(function(){
        $('.m_gnb nav ul #self_chk_gnb, .gnb_wrap nav ul #selfCheckGnb').addClass('on').siblings().removeClass('on');
    });
</script>