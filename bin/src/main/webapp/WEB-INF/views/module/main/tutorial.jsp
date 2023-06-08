<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>
<script src="${jsPath}/tutorial.js?v=${updateTimeCss}"></script>
<script src="${jsPath}/selfCheck.js?v=${updateTimeCss}"></script>

<main id="main" class="tutorial">
    <div class="section_navigation">
        <nav>
            <ul>
                <li data-waypoint="nav1"><a href="#">사용시작</a></li>
                <li data-waypoint="nav2"><a href="#">청소하기</a></li>
                <li data-waypoint="nav3"><a href="#">리셋하기</a></li>
                <li data-waypoint="nav4"><a href="#">자가진단</a></li>
                <!-- <li data-waypoint="nav4"><a href="#">기기등록</a></li> -->
            </ul>
        </nav>
    </div>
    <!-- 비주얼 ///-->
    <section class="tutorial_visual">
        <div class="inner inner1560">
            <div class="visual_wrap">
                <div class="visual_txt">
                    <p>Tutorial</p>
                    <h2 class="iqos-font">쉽고 간단한 아이코스 사용법</h2>
                </div>
                <div class="visual_img _img_wrap">
                    <img src="${imagePath}/tutorial/visualred-2.png" alt="아이코스 사용법">
                </div>
                <div class="visual_des">
                    <h4>사용 시작부터 기기 등록까지<br>
                        아이코스 사용에 관한 모든 것을 알아보세요.</h4>
                </div>
                <div class="mobile_scroll">Scroll</div>
            </div>
        </div>
    </section>

    <!-- 사용 시작하기. ///-->
    <section class="start_using common-padding wp" data-waypoint="nav1">
        <div class="inner inner768">
            <div class="section_title  iqos-ani-fadeup">
                <p class="color_sub iqos-font">아이코스를 처음 만나는 순간</p>
                <p class="iqos-font">사용 시작하기</p>
            </div>

            <div class="content_wrap">
                <div class="tab_slider mo_tab">
                    <div class="swiper-container tab1 tabslider top_tab iqos-ani-fadeup" data-iqostab-option='{"type": "using"}'>
                        <div class="swiper-wrapper">
                            <div class="swiper-slide on"><a href="#" data-device="cus-1">아이코스 일루마 프라임</a></div>
                            <div class="swiper-slide"><a href="#" data-device="cus-2">아이코스 일루마</a></div>
                            <div class="swiper-slide"><a href="#" data-device="cus-3">아이코스 일루마 원</a></div>
                            <div class="swiper-slide"><a href="#" data-device="duo">아이코스3 듀오</a></div>
                            <div class="swiper-slide "><a href="#" data-device="iqos3">아이코스3</a></div>
                            <div class="swiper-slide"><a href="#" data-device="multi">아이코스3 멀티</a></div>
                            <div class="swiper-slide"><a href="#" data-device="iqos2">아이코스2.4+</a></div>
                        </div>
                    </div>
                </div>
                <div class="tab_slider pc_tab">
                    <div class="tab1 tabslider swiper-container top_tab iqos-ani-fadeup" data-init="false" data-iqostab-option='{"type": "using"}'>
                        <div>
                            <div class="swiper-slide tablist on"><a href="#" data-device="cus-1">아이코스 일루마 프라임</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="cus-2">아이코스 일루마</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="cus-3">아이코스 일루마 원</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="duo">아이코스3 듀오</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="iqos3">아이코스3</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="multi">아이코스3 멀티</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="iqos2">아이코스2.4+</a></div>
                        </div>
                    </div>
                </div>
                <div class="step_wrap">
                    <div class="step_list_01 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 시작하기</h4>
                                    <p>홀더를 포켓 충전기에서 꺼내고 일루마 전용 타바코 스틱을 필터가 위쪽으로 향하도록 하여 필터라인까지 부드럽게 넣어주세요.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
<%--                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">--%>
                                        <img src="https://via.placeholder.com/768x420" alt="임시이미지">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1">
                                <div class="step_title">
                                    <h4><span>02</span> 사용하기</h4>
                                    <p>진동이 울리고 표시등이 깜빡이면 자동으로 히팅이 시작됩니다. 자동으로 시작되지 않을 경우 버튼을 1초 동안 둘러주세요.<br>홀더가 진동하고 상태 표시등이 켜진 상태로 유지되면 사용을 시작하세요.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <%--                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">--%>
                                        <img src="https://via.placeholder.com/768x420" alt="임시이미지">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-1">
                                <div class="step_title">
                                    <h4><span>03</span> 종료하기</h4>
                                    <p>사용 종료 30초 전 혹은 마지막 두 모금이 남으면, 홀더가 진동하고 상태 표시등이 하얀색으로 깜빡입니다.<br>사용을 완료한 스틱은 홀더에서 제거한 후 폐기해 주세요. 이 후, 홀더를 포켓 충전기에 넣어 다시 충전합니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <%--                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">--%>
                                        <img src="https://via.placeholder.com/768x420" alt="임시이미지">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_02 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 시작하기</h4>
                                    <p>홀더를 포켓 충전기에서 꺼내고 일루마 전용 타바코 스틱을 필터가 위쪽으로 향하도록 하여 필터라인까지 부드럽게 넣어주세요.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <%--                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">--%>
                                        <img src="https://via.placeholder.com/768x420" alt="임시이미지">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1">
                                <div class="step_title">
                                    <h4><span>02</span> 사용하기</h4>
                                    <p>진동이 울리고 표시등이 깜빡이면 자동으로 히팅이 시작됩니다. 자동으로 시작되지 않을 경우 버튼을 1초 동안 둘러주세요.<br>홀더가 진동하고 상태 표시등이 켜진 상태로 유지되면 사용을 시작하세요.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <%--                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">--%>
                                        <img src="https://via.placeholder.com/768x420" alt="임시이미지">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-1">
                                <div class="step_title">
                                    <h4><span>03</span> 종료하기</h4>
                                    <p>사용 종료 30초 전 혹은 마지막 두 모금이 남으면, 홀더가 진동하고 상태 표시등이 하얀색으로 깜빡입니다.<br>사용을 완료한 스틱은 홀더에서 제거한 후 폐기해 주세요. 이 후,홀더를 포켓 충전기에 넣어 다시 충전합니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <%--                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">--%>
                                        <img src="https://via.placeholder.com/768x420" alt="임시이미지">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_03 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 시작하기</h4>
                                    <p>도어캡을 슬라이드해 열어준 후 일루마 전용 타바코 스틱을 필터가 바깥쪽으로 향하도록 하여 필터라인까지 부드럽게 삽입합니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <%--                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">--%>
                                        <img src="https://via.placeholder.com/768x420" alt="임시이미지">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1">
                                <div class="step_title">
                                    <h4><span>02</span> 사용하기</h4>
<%--                                    <p>진동이 울리고 표시등이 깜빡이면 자동으로 히팅이 시작됩니다. 자동으로 시작되지 않을 경우 버튼을 1초 동안 둘러주세요.<br>홀더가 진동하고 상태 표시등이 켜진 상태로 유지되면 사용을 시작하세요.</p>--%>
                                    <p>진동이 울리고 상태 표시등이 켜질 때 까지 최소 1초 동안 버튼을 누르세요. 히팅 시 스틱이 삽입된 상태를 유지하세요.<br>20초의 히팅 후 진동이 울리고 상태 표시등이 켜진 상태로 유지되면 사용을 시작하세요.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <%--                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">--%>
                                        <img src="https://via.placeholder.com/768x420" alt="임시이미지">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-1">
                                <div class="step_title">
                                    <h4><span>03</span> 종료하기</h4>
<%--                                    <p>사용 종료 30초 전 혹은 마지막 두 모금이 남으면, 홀더가 진동하고 상태 표시등이 하얀색으로 깜빡입니다.<br>사용을 완료한 스틱은 홀더에서 제거한 후 폐기해 주세요. 이 후, 홀더를 포켓 충전기에 넣어 다시 충전합니다.</p>--%>
                                    <p>사용 중 상태 표시등이 남은 사용 시간을 알려줍니다. 마지막 30초 또는 마지막 두 모금이 남은 경우 상태 표시등의 점등과 동시에 홀더가 진동합니다. 사용을 완료한 스틱은 홀더에서 제거한 후 폐기해 주세요. 이 후, 도어캡을 슬라이드해 닫아줍니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <%--                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">--%>
                                        <img src="https://via.placeholder.com/768x420" alt="임시이미지">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="step_list_04 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 기기 전원 켜기</h4>
                                    <p>포켓 충전기 버튼을 4초 이상 누르면 전원이 켜집니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/s1_duo_01.jpg" alt="기기 전원켜기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-2">
                                <div class="col_left iqos-ani-fadeup">
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img m_full">
                                            <img src="${imagePath}/tutorial/step_01.gif" alt="">
                                        </div>
                                    </div>
                                    <div class="tips">
                                        <p class="sub_color">첫번째 진동알림,</p>
                                        <p>히팅 시작.</p>
                                    </div>
                                </div>
                                <div class="col_right iqos-ani-fadertl">
                                    <div class="step_title">
                                        <h4><span>02</span> 시작하기</h4>
                                        <p>도어 하단을 눌러 홀더를 꺼낸 후, 홀더 전원 버튼을 <strong>진동(1)</strong>이 울릴 때까지 눌러 아이코스를 시작해주세요.</p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_duo_02.jpg" alt="">
                                        </div>
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_duo_03.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-2">
                                <div class="col_left iqos-ani-fadeup">
                                    <div class="_img_wrap">
                                        <img src="${imagePath}/tutorial/step_02.gif" alt="">
                                    </div>
                                    <div class="tips">
                                        <p class="sub_color">두번째 진동알림,</p>
                                        <p>히팅 완료.</p>
                                    </div>
                                </div>
                                <div class="col_right iqos-ani-fadertl">
                                    <div class="step_title">
                                        <h4><span>03</span> 사용하기</h4>
                                        <p><strong>진동(2)</strong>이 울리고 예열이 시작되면, 타바코 스틱을 넣어 사용해주세요. <br><strong>*주의: 한 번 넣은 스틱은 절대로 비틀지 마세요. 히터 블레이드가 손상될 수도 있습니다.</strong></p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_duo_04.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_04">
                            <div class="step_inner col-2">
                                <div class="col_left iqos-ani-fadeup">
                                    <div class="_img_wrap">
                                        <img src="${imagePath}/tutorial/step_03.gif" alt="">
                                    </div>
                                    <div class="tips">
                                        <p class="sub_color">세번째 진동알림,</p>
                                        <p>사용종료 30초 전.</p>
                                    </div>
                                </div>
                                <div class="col_right iqos-ani-fadertl">
                                    <div class="step_title">
                                        <h4><span>04</span> 종료하기</h4>
                                        <p style="letter-spacing: -0.06em;"><strong>진동(3)</strong>은 사용 종료 30초 전 또는 2모금이 남았다는 신호입니다. 사용이 끝나면 홀더 캡을 위로 밀어 타바코 스틱을 제거합니다. 홀더를 방향 구분 없이 포켓 충전기에 삽입 후 도어를 닫아주세요.</p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_duo_05.jpg" alt="">
                                        </div>
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_duo_06.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="duo_intro">
                            <div class="intro_1 intro">
                                <div class="step_inner">
                                    <div class="iqos-ani-fadeup">
                                        <div class="_img_wrap">
                                            <img src="${imagePath}/tutorial/duo_01.png" alt="아이코스3 듀오 소개">
                                        </div>
                                        <div class="tips">
                                            <p class="sub_color">아이코스3 듀오는</p>
                                            <p>2회 연속 사용이 가능합니다.</p>
                                        </div>
                                    </div>
                                    <div class="iqos-ani-fadertl">
                                        <div class="step_title">
                                            <p>
                                                아이코스3 듀오의 2회 연속 사용 여부는 홀더 또는<br>포켓 충전기의 LED 불빛을 통해 사용 횟수 확인이 가능합니다.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="intro_2 intro">
                                <div class="step_inner">
                                    <div class="iqos-ani-fadeup">
                                        <div class="_img_wrap">
                                            <img src="${imagePath}/tutorial/duo_02.png" alt="아이코스3 듀오 소개">
                                        </div>
                                        <div class="tips">
                                            <p class="sub_color">아이코스3 듀오는</p>
                                            <p>아이코스3와 호환이 가능합니다.</p>
                                        </div>
                                    </div>
                                    <div class="iqos-ani-fadertl">
                                        <div class="step_title">
                                            <p>
                                                아이코스3 듀오의 홀더와 포켓 충전기는 아이코스3의<br>
                                                홀더 및 포켓 충전기와 호환이 가능합니다.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_05 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 기기 전원 켜기</h4>
                                    <p>포켓 충전기 버튼을 4초 이상 누르면 전원이 켜집니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/s1_01.jpg" alt="기기 전원켜기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-2">
                                <div class="col_left iqos-ani-fadeup">
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img m_full">
                                            <img src="${imagePath}/tutorial/step_01.gif" alt="">
                                        </div>
                                    </div>
                                    <div class="tips">
                                        <p class="sub_color">첫번째 진동알림,</p>
                                        <p>히팅 시작.</p>
                                    </div>
                                </div>
                                <div class="col_right iqos-ani-fadertl">
                                    <div class="step_title">
                                        <h4><span>02</span> 시작하기</h4>
                                        <p>도어 하단을 눌러 홀더를 꺼낸 후, 홀더 전원 버튼을 <strong>진동(1)</strong>이 울릴 때까지 눌러 아이코스를 시작해주세요.</p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_02.jpg" alt="">
                                        </div>
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_03.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-2">
                                <div class="col_left iqos-ani-fadeup">
                                    <div class="_img_wrap">
                                        <img src="${imagePath}/tutorial/step_02.gif" alt="">
                                    </div>
                                    <div class="tips">
                                        <p class="sub_color">두번째 진동알림,</p>
                                        <p>히팅 완료.</p>
                                    </div>
                                </div>
                                <div class="col_right iqos-ani-fadertl">
                                    <div class="step_title">
                                        <h4><span>03</span> 사용하기</h4>
                                        <p><strong>진동(2)</strong>이 울리고 예열이 시작되면, 타바코 스틱을 넣어 사용해주세요. <br><strong>*주의: 한 번 넣은 스틱은 절대로 비틀지 마세요. 히터 블레이드가 손상될 수도 있습니다.</strong></p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_04.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_04">
                            <div class="step_inner col-2">
                                <div class="col_left iqos-ani-fadeup">
                                    <div class="_img_wrap">
                                        <img src="${imagePath}/tutorial/step_03.gif" alt="">
                                    </div>
                                    <div class="tips">
                                        <p class="sub_color">세번째 진동알림,</p>
                                        <p>사용종료 30초 전.</p>
                                    </div>
                                </div>
                                <div class="col_right iqos-ani-fadertl">
                                    <div class="step_title">
                                        <h4><span>04</span> 종료하기</h4>
                                        <p style="letter-spacing: -0.06em;"><strong>진동(3)</strong>은 사용 종료 30초 전 또는 2모금이 남았다는 신호입니다. 사용이 끝나면 홀더 캡을 위로 밀어 타바코 스틱을 제거합니다. 홀더를 방향 구분 없이 포켓 충전기에 삽입 후 도어를 닫아주세요.</p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_05.jpg" alt="">
                                        </div>
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_06.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_06 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl iqos-ani-fadeup">
                                <div class="step_title">
                                    <h4><span>01</span> 기기 전원 켜기</h4>
                                    <p>버튼을 4초 이상 누르면 전원이 켜집니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/s1_multi_01.jpg" alt="기기 전원켜기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-2">
                                <div class="col_left">
                                    <div class="_img_wrap">
                                        <img src="${imagePath}/tutorial/step_01.gif" alt="">
                                    </div>
                                    <div class="tips">
                                        <p class="sub_color">첫번째 진동알림,</p>
                                        <p>히팅 시작.</p>
                                    </div>
                                </div>
                                <div class="col_right">
                                    <div class="step_title">
                                        <h4><span>02</span> 시작하기</h4>
                                        <p>뚜껑을 돌려 연 후, 전원버튼을 <strong>진동(1)</strong>이 울릴 때까지 눌러 아이코스를 시작해주세요.</p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_multi_02.jpg" alt="">
                                        </div>
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_multi_03.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-2">
                                <div class="col_left iqos-ani-fadeup">
                                    <div class="_img_wrap">
                                        <img src="${imagePath}/tutorial/step_02.gif" alt="">
                                    </div>
                                    <div class="tips">
                                        <p class="sub_color">두번째 진동알림,</p>
                                        <p>히팅 완료.</p>
                                    </div>
                                </div>
                                <div class="col_right iqos-ani-fadertl">
                                    <div class="step_title">
                                        <h4><span>03</span> 사용하기</h4>
                                        <p><strong>진동(2)</strong>이 울리고 예열이 시작되면, 타바코 스틱을 넣어 사용해주세요. <br><strong>*주의: 한 번 넣은 스틱은 절대로 비틀지 마세요. 히터 블레이드가 손상될 수도 있습니다.</strong></p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_multi_04.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_04">
                            <div class="step_inner col-2">
                                <div class="col_left iqos-ani-fadeup">
                                    <div class="_img_wrap">
                                        <img src="${imagePath}/tutorial/step_03.gif" alt="">
                                    </div>
                                    <div class="tips">
                                        <p class="sub_color">세번째 진동알림,</p>
                                        <p>사용종료 30초 전.</p>
                                    </div>
                                </div>
                                <div class="col_right iqos-ani-fadertl">
                                    <div class="step_title">
                                        <h4><span>04</span> 종료하기</h4>
                                        <p style="letter-spacing: -0.06em;"><strong>진동(3)</strong>은 사용 종료 30초 전 또는 2모금이 남았다는 신호입니다. 사용이 끝나면 홀더 캡을 위로 밀어 타바코 스틱을 제거합니다. 홀더를 방향 구분 없이 포켓 충전기에 삽입 후 도어를 닫아주세요.</p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_multi_05.jpg" alt="">
                                        </div>
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_multi_06.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step">
                            <div class="step_inner align_center">
                                <div class="tips addtips">
                                    <p class="sub_color">아이코스3 멀티는 완전 충전 시<br><span class="main_color">최대 10회 연속 사용</span>이 가능합니다.</p>
                                    <div class="_img_wrap">
                                        <img src="${imagePath}/tutorial/s1_multi_07.gif" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_07 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 기기 전원 켜기</h4>
                                    <p>전원 버튼을 누른 채로 <strong>진동(1)</strong>과 함께 하얀색 표시등이 깜빡거리며 예열이 시작되면 2~3초 후 타바코 스틱을 넣어주세요.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/s1_24_01.jpg" alt="기기 전원켜기">
                                    </div>
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/s1_24_02.jpg" alt="기기 전원켜기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1">
                                <div class="col_right">
                                    <div class="step_title">
                                        <h4><span>02</span> 사용하기</h4>
                                        <p>하얀색 표시등이 완전히 켜지면 타바코 스틱을 14모금 혹은 6분간 즐기실 수 있습니다. <br><strong>*주의: 한번 넣은 스틱은 절대로 비틀지 마세요. 히터블레이드가 손상될 수도 있습니다.</strong></p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_24_03.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-1">
                                <div class="col_right iqos-ani-fadertl">
                                    <div class="step_title">
                                        <h4><span>03</span> 종료하기</h4>
                                        <p style="letter-spacing: -0.06em;"><strong>진동(2)</strong>은 사용 종료 30초 전 또는 2모금이 남았다는 신호입니다. 사용이 끝나면 홀더 캡을 꼭 먼저 밀어 타바코 스틱을 제거해주세요.</p>
                                    </div>
                                    <div class="step_img_wrap">
                                        <div class="_img_wrap step_img">
                                            <img src="${imagePath}/tutorial/s1_24_04.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 중요한 사용 팁. ///-->
    <section class="using_tip common-padding">
        <div class="anibox iqos-ani-bgltr"></div>
        <div class="inner inner768 iqos-ani-fadein" data-offset="50%">
            <div class="section_title">
                <p class="iqos-font">중요한 사용 팁</p>
            </div>

            <div class="contents_wrap">
                <div class="tips_wrap">
                    <div class="imp_tip">
                        <div class="col_left">
                            <div class="tip_title">
                                <p class="sub_color">사용팁 01.</p>
<%--                                <p>2~3초간 기기 예열 후<br>스틱을 넣어주세요.</p>--%>
                                <p class="pc-text">사용오토스탑* (Autostop) 기능하기</p>
                                <p class="mobile-text">오토스탑* (Autostop) 기능</p>
                            </div>
                            <div class="tip_des">
<%--                                <p>2~3초간의 예열 단계를 거친 후 타바코 스틱을<br>넣어주시면 스틱이 부드러워져 블레이드 파손 확률이<br>감소되며 더욱 만족스러운 경험을 하실 수 있습니다.</p>--%>
                                <p>사용 중에 스틱을 홀더에서 옮기거나 제거하는 경우 사용이 자동 중지됩니다. 스틱을 제거한 후 폐기해 주세요.</p>
                            </div>
                        </div>
                        <div class="col_right">
                            <div class="_img_wrap">
                                <img
                                        src="${imagePath}/tutorial/cus-1-1.png"
                                        alt="사용팁1"
                                        data-imageurl='{
                                            "0": "${imagePath}/tutorial/cus-1-1.png",
                                            "1": "${imagePath}/tutorial/cus-2-1.png",
                                            "2": "${imagePath}/tutorial/cus-3-1.png",
                                            "3": "${imagePath}/tutorial/important_tip_01_duo.gif",
                                            "4": "${imagePath}/tutorial/important_tip_1.gif",
                                            "5": "${imagePath}/tutorial/important_tip_multi_1.gif",
                                            "6": "${imagePath}/tutorial/important_tip_24_1.gif"
                                        }'
                                >
                            </div>
                        </div>
                    </div>
                    <div class="imp_tip">
                        <div class="col_left">
                            <div class="tip_title">
                                <p class="sub_color">사용팁 02.</p>
<%--                                <p>한 번 홀더에 넣은 스틱은<br>절대로 비틀지 마세요.</p>--%>
                                <p>스마트 제스처 (Smart Gesture)</p>
                            </div>
                            <div class="tip_des none">
                                버튼을 짧게 누르면 상태 표시등을 통해<br>
                                배터리 잔량을 확인할 수 있습니다.<br><br>
                                상태 표시등 4개 : 배터리가 완전히 충전됨<br>
                                상태 표시등 3개 : 최대 75% 배터리 잔량<br>
                                상태 표시등 2개 : 최대 50% 배터리 잔량<br>
                                상태 표시등 1개 : 최대 25% 배터리 잔량<br>
                            </div>
                            <div class="tip_des block">
<%--                                <p>타바코 스틱 제거시, 절대 비틀지 마세요.<br>고장의 원인이 될 수 있습니다. (사용 후,<br>캡을 위로 밀어 타바코 스틱을 제거하세요.)</p>--%>
    1) 홀더로 남은 사용량 확인: 홀더를 사용자 쪽으로 기울이거 나 버튼을 짧게 누르면 상태 표시등이 남은 배터리 양을 알려줍니다. 2개 표시등은 2회 사용 가능, 1개 표시등은 1회 사용 가능을 의미합니다.<br><br>
    2) 포켓 충전기로 남은 사용량 확인 : 포켓 충전기 버튼을 짧게 누르면, 포켓 충전기의 상태 표시등이 켜집니다. 2개 표시등은 | 2회 사용 가능, 1개 표시등은 1회 사용 가능을 의미합니다.
                            </div>
                        </div>
                        <div class="col_right">
                            <div class="_img_wrap">
                                <img
                                        src="${imagePath}/tutorial/cus-1-2.png"
                                        alt="사용팁2"
                                        data-imageurl='{
                                            "0": "${imagePath}/tutorial/cus-1-2.png",
                                            "1": "${imagePath}/tutorial/cus-2-2.png",
                                            "2": "${imagePath}/tutorial/cus-3-2.png",
                                            "3": "${imagePath}/tutorial/important_tip_02_duo.gif",
                                            "4": "${imagePath}/tutorial/important_tip_2.gif",
                                            "5": "${imagePath}/tutorial/important_tip_multi_2.gif",
                                            "6": "${imagePath}/tutorial/important_tip_24_2.gif"
                                        }'
                                >
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 아이코스 클리닝. ///-->
    <section class="cleaning common-padding wp" data-waypoint="nav2">
        <div class="inner inner768">
            <div class="section_title  iqos-ani-fadeup">
                <p class="color_sub iqos-font">최적의 사용을 위한 방법</p>
                <p class="iqos-font">아이코스 클리닝</p>
            </div>

            <div class="content_wrap">
                <div class="sub_contents cleaning_top iqos-ani-fadeup">
                    <div class="sub_inner">
                        <div class="_img_wrap">
                            <img src="${imagePath}/tutorial/cleaning_add01.png" alt="클리닝">
                        </div>
                        <div class="text">
                            <p class="sub_color">클리닝은 간편하고 쉽게.<br>더 나아진 아이코스의<br>클리닝 도구를 경험해보세요.</p>
                            <span>*아이코스 정품 클리닝 도구 사용을 권장합니다.</span>
                        </div>
                    </div>
                </div>
                <div class="tab_slider mo_tab">
                    <div class="swiper-container tab2 tabslider iqos-ani-fadeup">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide on"><a href="#" data-device="duo">아이코스3 듀오</a></div>
                            <div class="swiper-slide"><a href="#" data-device="iqos3">아이코스3</a></div>
                            <div class="swiper-slide"><a href="#" data-device="multi">아이코스3 멀티</a></div>
                            <div class="swiper-slide"><a href="#" data-device="iqos2">아이코스2.4+</a></div>
                        </div>
                    </div>
                </div>
                <div class="tab_slider pc_tab">
                    <div class="swiper-container tab2 tabslider iqos-ani-fadeup" data-init="false">
                        <div>
                            <div class="swiper-slide tablist on"><a href="#" data-device="duo">아이코스3 듀오</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="iqos3">아이코스3</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="multi">아이코스3 멀티</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="iqos2">아이코스2.4+</a></div>
                        </div>
                    </div>
                </div>
                <div class="step_wrap">
                    <div class="step_list_01 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 준비하기</h4>
                                    <p>전원이 완전히 꺼지고 30초 이상 열을 식힌 다음, 홀더 캡을 분리해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaningduo_01.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>02</span> 클리닝하기</h4>
                                    <p>아이코스 정품 이지 클리너를 밀어 넣어 좌우로 돌리며 블레이드가 파손되지 않도록 부드럽게 클리닝해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaningduo_02.jpg" alt="클리닝하기">
                                    </div>
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaningduo_03.jpg" alt="클리닝하기2">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>03</span> 정기 클리닝</h4>
                                    <p>1~2주 간격에 한 번씩 아이코스 정품 클리닝 스틱으로 블레이드에 직접 닿지 않도록 주의하면서 관리해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaningduo_04.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="sub_contents cleaning_bottom iqos-ani-fadeup">
                            <div class="sub_inner">
                                <div class="_img_wrap">
                                    <img src="${imagePath}/tutorial/cleaning_add02_duo.gif" alt="클리닝">
                                </div>
                                <div class="text">
                                    <p class="sub_color">당신도 모르는 사이<br>깨끗해지는 아이코스.</p>
                                    <p>스마트 오토클리닝</p>
                                    <span>아이코스3 듀오는 20번 사용 후, 기기가 케이블에<br>연결된 채로 충전 중인 상태에서 자동으로<br>히터블레이드가 발열되며 잔여물이 클리닝됩니다.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_02 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 준비하기</h4>
                                    <p>전원이 완전히 꺼지고 30초 이상 열을 식힌 다음, 홀더 캡을 분리해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaning_01.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>02</span> 클리닝하기</h4>
                                    <p>아이코스 정품 이지 클리너를 밀어 넣어 좌우로 돌리며 블레이드가 파손되지 않도록 부드럽게 클리닝해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaning_02.jpg" alt="클리닝하기">
                                    </div>
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaning_03.jpg" alt="클리닝하기2">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>03</span> 정기 클리닝</h4>
                                    <p>1~2주 간격에 한 번씩 아이코스 정품 클리닝 스틱으로 블레이드에 직접 닿지 않도록 주의하면서 관리해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaning_04.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="sub_contents cleaning_bottom iqos-ani-fadeup">
                            <div class="sub_inner">
                                <div class="_img_wrap">
                                    <img src="${imagePath}/tutorial/cleaning_add02.gif" alt="클리닝">
                                </div>
                                <div class="text">
                                    <p class="sub_color">당신도 모르는 사이<br>깨끗해지는 아이코스.</p>
                                    <p>스마트 오토클리닝</p>
<%--                                    <span>아이코스3는 20번 사용 후,<br>기기가 케이블에 연결된 채로 충전 중인<br>상태에서 자동으로 히터 블레이드가<br>발열되며 잔여물이 클리닝됩니다.</span>--%>
                                    <span>아이코스3는 20번 사용 후, 기기가 케이블에<br>연결된 채로 충전 중인 상태에서 자동으로<br>히터블레이드가 발열되며 잔여물이 클리닝됩니다.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_03 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 준비하기</h4>
                                    <p>전원이 완전히 꺼지고 30초 이상 열을 식힌 다음, 멀티 캡을 분리해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaning_multi_01.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>02</span> 클리닝하기</h4>
                                    <p>아이코스 정품 이지 클리너를 밀어 넣어 좌우로 돌리며 블레이드가 파손되지 않도록 부드럽게 클리닝해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaning_multi_02.jpg" alt="클리닝하기">
                                    </div>
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaning_multi_03.jpg" alt="클리닝하기2">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>03</span> 정기 클리닝</h4>
                                    <p>1~2주 간격에 한 번씩 아이코스 정품 클리닝 스틱으로 블레이드에 직접 닿지 않도록 주의하면서 관리해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img m_full">
                                        <img src="${imagePath}/tutorial/cleaning_multi_04.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="sub_contents cleaning_bottom iqos-ani-fadeup">
                            <div class="sub_inner">
                                <div class="_img_wrap">
                                    <img src="${imagePath}/tutorial/cleaning_multi_add02.gif" alt="클리닝">
                                </div>
                                <div class="text">
                                    <p class="sub_color">당신도 모르는 사이<br>깨끗해지는 아이코스.</p>
                                    <p>스마트 오토클리닝</p>
<%--                                    <span>아이코스3 멀티는 10번 사용 후,<br>기기가 케이블에 연결된 채로 충전 중인 <br> 상태에서 자동으로 히터블레이드가 발열되며 잔여물이 클리닝됩니다.</span>--%>
                                    <span>아이코스3 멀티는 10번 사용 후, 기기가 케이블에<br>연결된 채로 충전 중인 상태에서 자동으로<br>히터블레이드가 발열되며 잔여물이 클리닝됩니다.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_04 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 준비하기</h4>
                                    <p>전원이 완전히 꺼지고 30초 이상 열을 식힌 다음, 홀더 캡을 분리해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/cleaning_24_01.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>02</span> 클리닝하기</h4>
                                    <p>아이코스 정품 이지 클리너를 밀어 넣어 좌우로 돌리며 블레이드가 파손되지 않도록 부드럽게 클리닝해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/cleaning_24_02.jpg" alt="클리닝하기">
                                    </div>
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/cleaning_24_03.jpg" alt="클리닝하기2">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_03">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>03</span> 정기 클리닝</h4>
                                    <p>1~2주 간격에 한 번씩 아이코스 정품 클리닝 스틱으로 블레이드에 직접 닿지 않도록 주의하면서 관리해주세요.</p>
                                </div>
                                <div class="step_img_wrap">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/cleaning_24_04.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="sub_contents cleaning_bottom iqos-ani-fadeup">
                            <div class="sub_inner">
                                <div class="_img_wrap">
                                    <img src="${imagePath}/tutorial/cleaning_24_add02.gif" alt="클리닝">
                                </div>
                                <div class="text">
                                    <p class="sub_color">당신도 모르는 사이<br>깨끗해지는 아이코스.</p>
                                    <p>스마트 오토클리닝</p>
<%--                                    <span>아이코스2.4+가 20번 사용 후,<br> 기기가 케이블에 연결된 채로 충전 중인<br>상태에서 자동으로 히터 블레이드가<br>발열되며 잔여물이 클리닝됩니다. </span>--%>
                                    <span>아이코스2.4+가 20번 사용 후, 기기가 케이블에<br>연결된 채로 충전 중인 상태에서 자동으로<br>히터블레이드가 발열되며 잔여물이 클리닝됩니다.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="free_clean">
            <div class="icon_wrap">
                <img src="${imagePath}/tutorial/free_clean-2.png" alt="무료 클리닝">
            </div>
            <div class="text_wrap">
                <p class="sub_color">매장에 오시면 꼭 요청해보세요!<br>https://iqossvc.kr에서 공식 매장 검색 후 방문하시면</p>
                <p>전문 코치가 기기를 무료로 클리닝해드립니다.</p>
            </div>
        </div>
    </section>

    <!-- 리셋하기. /// -->
    <section class="reset common-padding wp" data-waypoint="nav3">
        <div class="resetinner">
            <div class="inner inner768">
                <div class="section_title  iqos-ani-fadeup">
                    <p class="color_sub iqos-font">간단한 오작동의 빠른해결</p>
                    <p class="iqos-font">리셋하기</p>
                </div>

                <div class="content_wrap">
                    <div class="sub_contents reset_top">
                        <div class="sub_con_des">
                            <p class="iqos-ani-fadeup">아래와 같은 간단한 오작동은 리셋을 통해<br>쉽게 해결할 수 있습니다.</p>
                            <div class="des_img_wrap">
                                <div class="list">
                                    <div class="anibox iqos-ani-bgltr"></div>
                                    <div class="img_wrap iqos-ani-fadein" data-delay="0.5" style="background-image: url(${imagePath}/tutorial/reset_top2_01.jpg)">
                                        <p>"기기가 안켜져요."</p>
                                    </div>
                                </div>
                                <div class="list">
                                    <div class="anibox iqos-ani-bgltr" data-delay="0.3"></div>
                                    <div class="img_wrap iqos-ani-fadein" data-delay="0.5" style="background-image: url(${imagePath}/tutorial/reset_top2_02.jpg)">
                                        <p>"불빛이 안들어와요."</p>
                                    </div>
                                </div>
                                <div class="list">
                                    <div class="anibox iqos-ani-bgltr"></div>
                                    <div class="img_wrap iqos-ani-fadein" data-delay="0.5" style="background-image: url(${imagePath}/tutorial/reset_top2_03.jpg)">
                                        <p>"빨간 불빛이 깜빡이거나<br>고정되어 있어요."</p>
                                    </div>
                                </div>
                                <div class="list">
                                    <div class="anibox iqos-ani-bgltr" data-delay="0.3"></div>
                                    <div class="img_wrap iqos-ani-fadein" data-delay="0.5" style="background-image: url(${imagePath}/tutorial/reset_top2_04.jpg)">
                                        <p>"홀더에 빨간불이<br>깜빡이거나 불빛이 없어요."</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="inner inner768">
            <!-- <div class="section_title  iqos-ani-fadeup">
                <p class="color_sub">간단한 오작동의 빠른해결.</p>
                <p>리셋하기.</p>
            </div> -->

            <div class="content_wrap">
                <!-- <div class="sub_contents reset_top">
                    <div class="sub_con_des">
                        <p class="iqos-ani-fadeup">아래와 같은 간단한 오작동은 리셋을 통해<br>쉽게 해결할 수 있습니다.</p>
                        <div class="des_img_wrap">
                            <div class="list">
                                <div class="anibox iqos-ani-bgltr"></div>
                                <div class="img_wrap iqos-ani-fadein" data-delay="0.5" style="background-image: url(${imagePath}/tutorial/reset_top2_01.jpg)">
                                    <p>"기기가 안켜져요."</p>
                                </div>
                            </div>
                            <div class="list">
                                <div class="anibox iqos-ani-bgltr" data-delay="0.3"></div>
                                <div class="img_wrap iqos-ani-fadein" data-delay="0.5" style="background-image: url(${imagePath}/tutorial/reset_top2_02.jpg)">
                                    <p>"불빛이 안들어와요."</p>
                                </div>
                            </div>
                            <div class="list">
                                <div class="anibox iqos-ani-bgltr"></div>
                                <div class="img_wrap iqos-ani-fadein" data-delay="0.5" style="background-image: url(${imagePath}/tutorial/reset_top2_03.jpg)">
                                    <p>"빨간 불빛이 깜빡이거나<br>고정되어 있어요."</p>
                                </div>
                            </div>
                            <div class="list">
                                <div class="anibox iqos-ani-bgltr" data-delay="0.3"></div>
                                <div class="img_wrap iqos-ani-fadein" data-delay="0.5" style="background-image: url(${imagePath}/tutorial/reset_top2_04.jpg)">
                                    <p>"홀더에 빨간불이<br>깜빡이거나 불빛이 없어요."</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> -->
                <div class="tab_slider mo_tab">
                    <div class="tab_title iqos-ani-fadeup">기기 별 리셋 방법</div>
                    <div class="swiper-container tab3 tabslider iqos-ani-fadeup">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide on"><a href="#" data-device="cus-1">아이코스 일루마 프라임</a></div>
                            <div class="swiper-slide"><a href="#" data-device="cus-2">아이코스 일루마</a></div>
                            <div class="swiper-slide"><a href="#" data-device="cus-3">아이코스 일루마 원</a></div>
                            <div class="swiper-slide"><a href="#" data-device="duo">아이코스3 듀오</a></div>
                            <div class="swiper-slide"><a href="#" data-device="iqos3">아이코스3</a></div>
                            <div class="swiper-slide"><a href="#" data-device="multi">아이코스3 멀티</a></div>
                            <div class="swiper-slide"><a href="#" data-device="iqos2">아이코스2.4+</a></div>
                        </div>
                    </div>
                </div>
                <div class="tab_slider pc_tab">
                    <div class="tab_title iqos-ani-fadeup">기기 별 리셋 방법</div>
                    <div class="swiper-container tab3 tabslider iqos-ani-fadeup" data-init="false">
                        <div>
                            <div class="swiper-slide tablist on"><a href="#" data-device="cus-1">아이코스 일루마 프라임</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="cus-2">아이코스 일루마</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="cus-3">아이코스 일루마 원</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="duo">아이코스3 듀오</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="iqos3">아이코스3</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="multi">아이코스3 멀티</a></div>
                            <div class="swiper-slide tablist"><a href="#" data-device="iqos2">아이코스2.4+</a></div>
                        </div>
                    </div>
                </div>
                <div class="step_wrap">
                    <div class="step_list_01 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 리셋하기</h4>
                                    <p>포켓 충전기 버튼을 10초 동안 누릅니다. 상태 표시등이 모두 꺼지고, 두 번 깜빡인 다음 다시 켜지면 초기화가 완료됩니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset-cus-1.png" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_02 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 리셋하기</h4>
                                    <p>포켓 충전기 버튼을 10초 동안 누릅니다. 상태 표시등이 모두 꺼지고, 두 번 깜빡인 다음 다시 켜지면 초기화가 완료됩니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset-cus-2.png" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_03 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 리셋하기</h4>
<%--                                    <p>포켓 충전기 버튼을 10초 동안 누릅니다. 상태 표시등이 모두 꺼지고, 두 번 깜빡인 다음 다시 켜지면 초기화가 완료됩니다.</p>--%>
                                    <p>버튼을 7초 동안 눌러주세요. 상태 표시등이 모두 꺼지고 불빛이 다시 켜지면 초기화가 완료된 것입니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset-cus-3.png" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_04 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 준비하기</h4>
                                    <p>홀더를 포켓 충전기에 삽입하시고 리셋을 준비해주세요.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset_01_duo.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>02</span> 리셋하기</h4>
                                    <p>전원 버튼을 10초간 눌렀다가 손을 떼면, 배터리 상태등이 2번 깜빡인 후 다시 켜지며 리셋이 완료됩니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset_02_duo.gif" alt="리셋하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_05 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 준비하기</h4>
                                    <p>홀더를 포켓 충전기에 삽입하시고 리셋을 준비해주세요.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset_01.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>02</span> 리셋하기</h4>
                                    <p>전원 버튼을 10초간 눌렀다가 손을 떼면, 배터리 상태등이 2번 깜빡인 후 다시 켜지며 리셋이 완료됩니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset_02.gif" alt="리셋하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_06 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 준비하기</h4>
                                    <p>뚜껑을 닫고  리셋을 준비해주세요.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset_multi_01.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>02</span> 리셋하기</h4>
                                    <p>전원 버튼을 10초간 눌렀다가 손을 떼면, 배터리 상태등이 2번 깜빡인 후 다시 켜지며 리셋이 완료됩니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset_multi_02.gif" alt="리셋하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step_list_07 step_list">
                        <div class="step step_01">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>01</span> 준비하기</h4>
                                    <p>블루투스 버튼과 전원버튼을 동시에 누르고 손을 떼시면 모든 표시등이 깜빡이며 리셋됩니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset_24_01.jpg" alt="준비하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step step_02">
                            <div class="step_inner col-1 iqos-ani-fadertl">
                                <div class="step_title">
                                    <h4><span>02</span> 리셋하기</h4>
                                    <p>리셋 후 포켓 충전기의 전원버튼을 눌렀을 때 표시등에 하얀 불이 켜졌다 꺼지면 리셋이 정상적으로 완료된 경우입니다.</p>
                                </div>
                                <div class="step_img_wrap m_full">
                                    <div class="_img_wrap step_img">
                                        <img src="${imagePath}/tutorial/reset_24_02.gif" alt="리셋하기">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="self-wrap">
        <!-- 자가진단 설명 -->
        <section class="online_self_check wp" data-waypoint="nav4">
            <div class="inner inner768">
                <div class="section_title">
                    <h2 class="iqos-font"><span class="iqos-font">아이코스</span><br>
                        온라인 자가진단</h2>
                </div>
                <div class="self_check_text">
                    <div class="sub_title">
                        <h4>온라인 자가진단</h4>
                    </div>
                    <div class="default_des">
                        <p>
                            고객님께서 겪고 계신 기기 증상을 온라인 자가진단을 통해 보다 빠르고 편리하게 진단해보세요.<br>
                            문제에 대한 대응방법을 편리하게 얻으실 수 있습니다.
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
                    <a href="javascript:;" id="showWay">기기 등록방법 보기</a>
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
                                        <p>아이코스 공식 웹사이트 (kr.iqos.com)에 방문하여 로그인 후, ‘ 내 계정 ’ 페이지 상단 [등록된 기기 메뉴]를 선택하세요.</p>
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
                                        <p>[ 다른 기기 추가 ] 버튼을 클릭하여 12자리 제품 번호를 입력하면 기기등록이완료 됩니다. </p>
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
                            <p>아이코스 2.4+ / 아이코스3 / 아이코스3 멀티 기기에 표시된 14자리 제품번호를 확인하실 수 있습니다.</p>
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
                        <h4>온라인 자가진단 방법 안내</h4>
                    </div>
                    <div class="step_list step_inner">
                        <div class="step iqos-ani-fadeup">
                            <div class="step_img _img_wrap">
                                <img src="${imagePath}/self_check/self_check_step_01.jpg" alt="기기 이상">
                            </div>
                            <div class="step_text">
                                <div class="step_title">
                                    <h4><span>01</span>기기 이상</h4>
                                    <p>리셋으로도 해결되지 않는 기기 문제 발생시, 온라인 자가진단을 통해 진단부터 제품교환까지 받아보세요.</p>
                                </div>
                            </div>
                        </div>
                        <div class="step iqos-ani-fadeup">
                            <div class="step_img _img_wrap">
                                <img src="${imagePath}/self_check/self_check_step_02-2.png" alt="My Page">
                            </div>
                            <div class="step_text">
                                <div class="step_title">
                                    <h4><span>02</span><em>My Page</em></h4>
                                    <p>아이코스 공식 웹사이트(kr.iqos.com)에 로그인 후 우측 상단의 '내 계정'을 클릭하고, 등록된 기기 페이지로 접속해주세요.</p>
                                </div>
                            </div>
                        </div>
                        <div class="step iqos-ani-fadeup">
                            <div class="step_img _img_wrap">
                                <img src="${imagePath}/self_check/self_check_step_03-2.png" alt="자가 진단 선택">
                            </div>
                            <div class="step_text">
                                <div class="step_title">
                                    <h4><span>03</span>자가 진단 선택</h4>
                                    <p>등록된 기기 목록 중 문제가 발생한 기기 하단의 ‘제품 자가 진단’ 버튼을 클릭해주세요.</p>
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
                                <img src="${imagePath}/self_check/self_check_step_06.png" alt="기기 교환 가능 여부 확인">
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
                                <img src="${imagePath}/self_check/self_check_step_06.png" alt="제품 수령 방법 확인">
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
    </div>


</main>

<script>
    $(document).ready(function(){
        $('.m_gnb nav ul #tutorial_gnb, .gnb_wrap nav ul #tutorialGnb').addClass('on').siblings().removeClass('on');
    })
</script>