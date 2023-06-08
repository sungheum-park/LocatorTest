<%@ page import="kr.co.msync.web.module.main.controller.MainController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/front/include.jsp"%>
<%--<script src="${jsPath}/tutorial.js?v=${updateTimeCss}"></script>--%>
<main id="main" class="careplus">
    <!-- 아이코스 케어플러스 프로그램. /// -->
    <section class="care_plus common-padding wp" data-waypoint="nav4">
        <div class="inner inner768">
            <div class="section_title  iqos-ani-fadeup">
                <p class="color_sub">기기 등록과</p>
                <p>아이코스 케어 플러스.</p>
            </div>
            <div class="care_plus_info care_con">
                <div class="info_title care_title iqos-ani-fadeup main_wrap">
                    <div class="mainImg">
                        <img src="${imagePath}/care/caremain.png" alt="케어플러스 메인 이미지">
                    </div>
                    <div class="logo">
                        <img src="${imagePath}/care/logo.png" alt="케어플러스 로고">
                    </div>
                    <p>아이코스 <span>케어</span> 플러스 프로그램.</p>
                </div>
                <div class="info_des care_des iqos-ani-fadeup">
                    <p>케어 플러스는 구매 후 등록된 기기에 한해 보증 기간 동안 <br>다양한 서비스와 혜택을 제공해드리는 프로그램 입니다.</p>
                    <p class="caption">(구매일로부터 12개월 / 구매일자가 증빙되지 않는 경우 생산일자로부터 15개월)</p>
                </div>
            </div>
        </div>
    </section>
    <section class="care_plus_info wp">
        <div class="info_graph common-padding">
            <div class="inner inner768">
                <div class="iqos-ani-fadein" data-offset="50%">
                    <div class="care_con">
                        <div class="info_title care_title iqos-ani-fadeup">
                            <p><span>케어</span> 플러스 프로그램의 혜택.</p>
                        </div>
                    </div>
                    <div class="list_wrap">
                        <div class="list">
                            <div class="img_wrap">
                                <img src="${imagePath}/care/careplus_01.png" alt="">
                            </div>
                            <div class="text_wrap">
                                <div class="tit">
                                    <p>히터 블레이드 파손시<br>홀더 1회 무상 교환</p>
                                </div>
                                <div class="txt">
                                    <p>히터 블레이드 파손 시 1회에 한해<br>무상으로 홀더를 교환 받으실 수 있습니다.</p>
                                </div>
                            </div>
                            <!-- <div class="img_wrap" style="background-image: url(${imagePath}/tutorial/careplus_01.png)"></div> -->
                        </div>
                        <div class="list">
                            <div class="img_wrap">
                                <img src="${imagePath}/care/careplus_02.png" alt="">
                            </div>
                            <div class="text_wrap">
                                <div class="tit">
                                    <p>글로벌</p>
                                    <p>워런티</p>
                                </div>
                                <div class="txt">
                                    <p>해외 출장이나 휴가 중에도, 어느 곳에서나<br>보증 서비스를 받으실 수 있습니다.</p>
                                </div>
                            </div>
                            <!-- <div class="img_wrap" style="background-image: url(${imagePath}/tutorial/careplus_01.png)"></div> -->
                        </div>
                        <div class="list">
                            <div class="img_wrap">
                                <img src="${imagePath}/care/careplus_03.png" alt="">
                            </div>
                            <div class="text_wrap">
                                <div class="tit">
                                    <p>신속한 기기<br>교환 서비스</p>
                                </div>
                                <div class="txt">
                                    <p>전국 서비스센터 및 택배 서비스를<br>통해 빠르게 기기 교환이 가능합니다.</p>
                                </div>
                            </div>
                            <!-- <div class="img_wrap" style="background-image: url(${imagePath}/tutorial/careplus_01.png)"></div> -->
                        </div>
                        <div class="list">
                            <div class="img_wrap">
                                <img src="${imagePath}/care/careplus_04.png" alt="">
                            </div>
                            <div class="text_wrap">
                                <div class="tit">
                                    <p>아이코스 전문<br>코치 컨설팅</p>
                                </div>
                                <div class="txt">
                                    <p>아이코스 전문 코치에게 기기 사용 및<br>관리에 대한 도움을 받으실 수 있습니다.</p>
                                </div>
                            </div>
                            <!-- <div class="img_wrap" style="background-image: url(${imagePath}/tutorial/careplus_01.png)"></div> -->
                        </div>

                    </div>
                    <div class="caption">
                        <p>* 글로벌 워런티의 경우 교환 서비스는 각 국가의 <span>교환 절차 및 보증 정책에 따라 상이할 수 있습니다.</span></p>
                        <p>* 글로벌 위런티가 가능한 국가 등 자세한 사항에 관하여는 <span> 고객서비스센터(080-0000-1905)로 문의하시기 바랍니다.</span></p>
                        <p>* 교환 서비스의 범위 등 세부 사항은 자사 내부 규정에 따릅니다.<span> 자세한 내용은 고객서비스센터(080-0000-1905)로 문의하시기 바랍니다.</span></p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="common-padding wp" data-waypoint="nav4">
        <div class="inner inner768">
            <div class="register care_con">
                <div class="care_title iqos-ani-fadeup">
                    <p class="color_sub">기기 등록 방법.</p>
                    <p>기기 등록하고 파손 및<br>고장의 걱정을 덜어보세요.</p>
                </div>
                <div class="register_steps step_inner">
                    <div class="regi_step step_01">
                        <div class="regi_img iqos-ani-fadeltr">
                            <img src="${imagePath}/tutorial/register_01.png" alt="사이트 방문">
                        </div>
                        <div class="regi_txt">
                            <div class="regi_txt_title step_title iqos-ani-fadeup">
                                <h4><span>01</span> 사이트 방문</h4>
                                <p>아이코스 공식 웹사이트 (iqos.com)에<br>방문하여 로그인 후, 우측 상단의 ‘마이 페이지’<br>아이콘을 클릭하세요.</p>
                            </div>
                        </div>
                    </div>
                    <div class="regi_step">
                        <div class="regi_img iqos-ani-fadeltr">
                            <img src="${imagePath}/tutorial/register_02.png" alt="사이트 방문">
                        </div>
                        <div class="regi_txt">
                            <div class="regi_txt_title step_title iqos-ani-fadeup">
                                <h4><span>02</span> 등록된 기기 메뉴 선택</h4>
                                <p>마이 페이지에서 [등록된 기기 메뉴]를<br>선택하세요.</p>
                            </div>
                        </div>
                    </div>
                    <div class="regi_step">
                        <div class="regi_img iqos-ani-fadeltr">
                            <img src="${imagePath}/tutorial/register_03.png" alt="사이트 방문">
                        </div>
                        <div class="regi_txt">
                            <div class="regi_txt_title step_title iqos-ani-fadeup">
                                <h4><span>03</span> 다른 기기 추가</h4>
                                <p>[ 다른 기기 추가 ] 버튼을 클릭하여 <br>제품 번호를 입력하면 기기등록이 완료됩니다. </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="check_code care_con">
                <div class="care_title iqos-ani-fadeup code_list_wrap">
                    <p>제품번호 확인 방법.</p>
                </div>
                <div class="care_des iqos-ani-fadeup">
                    <p><span>01</span>박스 하단 스티커에 표시된 12자리 제품번호로 기기등록이 가능합니다.</p>
                    <p><span>02</span>기기 상에 표시된 제품번호로도 기기등록이 가능합니다.</p>
                </div>
                <div class="code_img_all">
                    <div class="code_img_wrap iqos-ani-fadeup">
                        <div class="_img_wrap">
                            <img src="${imagePath}/tutorial/code_01.jpg" alt="제품번호 확인">
                        </div>
                        <div class="_img_wrap">
                            <img src="${imagePath}/tutorial/code_02.jpg" alt="제품번호 확인">
                        </div>
                        <div class="_img_wrap">
                            <img src="${imagePath}/tutorial/code_03.jpg" alt="제품번호 확인">
                        </div>
                        <div class="_img_wrap">
                            <img src="${imagePath}/tutorial/code_04.jpg" alt="제품번호 확인">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<script>
    $(document).ready(function(){
        $('.m_gnb nav ul #care_plus, .gnb_wrap nav ul #carePlusGnb').addClass('on').siblings().removeClass('on');
    })
</script>