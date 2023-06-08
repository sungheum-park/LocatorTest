$(document).ready(function() {

    if ( !(isMobile.any) ) {
        /// PC 커스텀 스크롤바
        $('.scroll_area').each(function() {
            var _this = $(this);
            var scroll = new PerfectScrollbar(_this[0], {
                wheelSpeed: 0.15,
                
            });
        });
    }


    /// 사이드바 레이아웃
    var panel = function(element) {
        this.element = document.querySelectorAll(element);
    }
    panel.prototype = {
        open: function() {
            var target = this.element;
            TweenMax.to(target, 0.4, {
                ease: Expo.easeOut,
                force3D: true,
                x: '+=100%',
                onStart: function() {
                    $(target).addClass('on');
                }
            });
        },
        close: function() {
            TweenMax.to(this.element, 0.4, {
                ease: Expo.easeOut,
                force3D: true,
                x: '-=100%',
                onStart: function() {
                    $(this.target).removeClass('on');
                }
            });
        }
    }
    var mainPanel = new panel('.side_nav');
    var resultPanel = new panel('.search_result_panel');
    var infoPanel = new panel('.info_panel');
    var changeTab = new panel('.mobile_change_tab');

    /// 사이드바 토글기능
    (function() {
        $('#header .header_inner .search_store a').click(function(e) {
            // 매장찾기 클릭시 -> 사이드바 열림
            e.preventDefault();
            var isToggle = $('.side_nav').hasClass('on');
            if ( !isToggle ) {
                mainPanel.open();
                changeTab.open();
            }
        })
        $('.main_panel .close_panel').click(function() {
            // 메인판 닫기
            if ( $(mainPanel.element).hasClass('on') ) {
                mainPanel.close();
                changeTab.close();
            }
            if ( $(resultPanel.element).hasClass('on') ) {
                resultPanel.close();
            }
            if ( $(infoPanel.element).hasClass('on') ) {
                infoPanel.close();
            }
        });
        $('.search_result_panel .close_panel').click(function() {
            // 매장찾기 결과 판 닫기
            resultPanel.close();
        });
        $('.info_panel .btn_back a').click(function() {
            // 정보 판 닫기
            infoPanel.close();
        });

        $('.main_panel .near_store a').click(function(e) {
            // 근처매장 바로보기 -> 결과 판 열림
            e.preventDefault();
            var isToggle = $('.search_result_panel').hasClass('on');
            if ( !isToggle ) {
                resultPanel.open();
            }
        });

        $('.search_store_result .store .more_info a').click(function(e) {
            // 매장검색결과 매장선택 -> 매장정보 판 열림
            e.preventDefault();
            var isToggle = $('.info_panel').hasClass('on');
            if ( !isToggle ) {
                infoPanel.open();
            }
        })
    })();




    /// 매장검색 탭 
    ;(function() {
        $('.search_box .search_tab li a').on({
            click: function(e) {
                e.preventDefault();
                e.stopPropagation();
                $(this).parent().addClass('on').siblings().removeClass('on');

                var _index = $(this).parent().index();
                $(this).parents('.search_box').find('._search').eq(_index).show().siblings().hide();

                if ( $(this).attr('data-type') === 'road' ) {
                    $('.select_filter').hide();
                } else {
                    $('.select_filter').show();
                }
            }
        });
    })();


    /// 매장검색 - 직접검색
    ;(function() {
        $('.change_eq .search_tab li a').on({
            click: function(e) {
                e.preventDefault();
                $(this).parent().addClass('on').siblings().removeClass('on');

                var index = $(this).parent().index();
                $('.filter_depth2_list').eq(index).show().siblings().hide();
            }
        })
    })();


    /// 매장검색 - 지역검색
    ;(function() {
        // 스텝1 -> 스텝2
        $('.main_panel .loca_list_wrap li a').on({
            click: function(e) {
                e.preventDefault();

                var step2 = $(this).parents('.location_search').find('.step-2');
                TweenMax.to(step2, 0.6, {
                    ease: Expo.easeOut,
                    force3D: true,
                    xPercent: 100,
                });
                TweenMax.to('.step-1', 0.6, {
                    ease: Expo.easeOut,
                    force3D: true,
                    autoAlpha: 0,
                });
            }
        });

        // 스텝2 -> 스텝1
        $('.main_panel .sub_loca_list_wrap .title h2').on({
            click: function() {
                var step2 = $(this).parents('.step-2');
                TweenMax.to(step2, 0.6, {
                    ease: Expo.easeInOut,
                    force3D: true,
                    xPercent: -100,
                });
                TweenMax.to('.step-1', 0.6, {
                    ease: Expo.easeInOut,
                    force3D: true,
                    autoAlpha: 1,
                });
            }
        });
    })();


    /// 매장검색 - 길찾기
    ;(function() {

        // 길찾기 현재위치로 설정
        $('.main_panel .road_search a').click(function(e) {
            e.preventDefault();
            $(this).parents('.start_point').find('input').val('가로수 길');
        });

        // 길찾기 출발매장 검색
        $('.start_point button').click(function() {
            $('.result_wrap').removeClass('destip');
        });
        // 길찾기 도착매장 검색
        $('.desti_point button').click(function() {
            $('.result_wrap').addClass('destip');
        });
    })();


    /// 필터리스트 타이틀
    ;(function() {
        $('.main_panel .filter_list').on({
            click: function(e) {
                var isShow = $(this).hasClass('on');
                if (!isShow) {
                    $(this).addClass('on').siblings().removeClass('on');
                    var toggleTarget = $(this).find('.filter');
                    TweenMax.set(toggleTarget, {height: 'auto'});
                    TweenMax.from(toggleTarget, 0.6, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });

                    var siblingsTarget = $(this).siblings().find('.filter');
                    TweenMax.to(siblingsTarget, 0.6, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });
                }
            }
        });
    })();


    /// 필터 뎁스2
    ;(function() {
        $('.main_panel .filter_depth2 h3').on({
            click: function() {
                var isShow = $(this).parents('.filter_depth2').hasClass('on');
                if (!isShow) {
                    $(this).parents('.filter_depth2').addClass('on').siblings('.filter_depth2').removeClass('on');
    
                    var toggleTarget = $(this).parents('.filter_depth2').find('.color_list_wrap');
                    TweenMax.set(toggleTarget, {height: 'auto'});
                    TweenMax.from(toggleTarget, 0.6, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });

                    var siblingsTarget = $(this).parents('.filter_depth2').siblings('.filter_depth2').find('.color_list_wrap');
                    TweenMax.to(siblingsTarget, 0.6, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });
                }
            }
        })
    })();

    /// 컬러 리스트
    ;(function() {
        $('.color_list').on({
            click: function() {
                $(this).toggleClass('on');
                var color = $(this).attr('data-color');
                var targetArr = $(this).parents('.filter_depth2').find('.selected_color .colors span');
                var target;
                targetArr.each(function() {
                    var _this = $(this);
                    if (_this.attr('data-color') === color) {
                        return target = _this;
                    }
                    return;
                })
                
                target.toggle();
            }
        });
    })();


    /// 매장검색 결과 타입별 리스트
    ;(function() {
        $('.sub_panel_title .result_type a').click(function(e) {
            // 상단 유형, 거리순
            e.preventDefault();
            $(this).parent().addClass('on').siblings().removeClass('on');
        });

        $('.store_type h2').on({
            click: function() {
                // 매장검색 결과 매장 타입별
                var isToggle = $(this).hasClass('on');
                if ( !isToggle ) {
                    $(this).addClass('on');
                    var target = $(this).siblings('.store_list_wrap');

                    TweenMax.set(target, {height: 'auto'});
                    TweenMax.from(target, 0.4, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });

                    $(this).parent().siblings('.store_type').find('h2').removeClass('on');
                    var siblingsTarget = $(this).parent().siblings('.store_type').find('.store_list_wrap');
                    TweenMax.to(siblingsTarget, 0.4, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });
                }
            }
        });
    })();


    /// 매장 정보 판 - 매장 사진 슬라이더
    var storeSl = new Swiper('.store_img', {
        observer: true,
        observeParents: true,
        watchOverflow: true,
        pagination: {
            el: '.store_pg',
            type: 'bullets',
            clickable: true,
        },
    });


    /// 매장 정보 공유
    ;(function() {
        $('.option .share a').click(function(e) {
            // 팝업 열기
            e.preventDefault();
            $(this).parents('.option').find('.share_popup').show();
        })

        $('.option .share_popup .share_popup_close').click(function() {
            // 팝업 닫기
            $(this).parents('.share_popup').hide();
        });
    })();

    /// **** 현황 레이어팝업
    ;(function() {

        $('.changepop').click(function(e) {
            // 교환기기 현황 레이어 열기
            e.preventDefault();
            $('.change_layer').fadeIn(300);
        });
        $('.salepop').click(function(e) {
            // 교환기기 현황 레이어 열기
            e.preventDefault();
            $('.sale_layer').fadeIn(300);
        });

        $('._colors').click(function() {
            // 교환기기 체크
            $(this).addClass('on').siblings().removeClass('on');
            var bColor = $(this).find('span').css('background-color');
            var cText = $(this).find('p').text();
            var obj = $(this).parents('.product_info').find('.stock');

            obj.find('.pal').css({'background-color': bColor});
            obj.find('.pal_text').text(cText);
        });

        $('.btn_pop_close a').click(function(e) {
            // 레이어 닫기
            e.preventDefault();
            $(this).parents('.iqos_store_popup').fadeOut(300);
        });
        $('.iqos_store_popup .bg').click(function() {
            // 레이어 닫기
            $(this).parent().fadeOut(300);
        })
    })();


    /// 반응형 조정
    (function() {
        var isFire = false;
        function setPanelPosition(wWidth) {
            if ( wWidth <= 768 && isFire === false ) {
                if ( $(mainPanel.element).hasClass('on') ) {
                    mainPanel.close();
                }
                if ( $(resultPanel.element).hasClass('on') ) {
                    resultPanel.close();
                }
                if ( $(infoPanel.element).hasClass('on') ) {
                    infoPanel.close();
                }
                TweenMax.set(resultPanel.element, {x: '-=100%', force3D: true});
                TweenMax.set(infoPanel.element, {x: '-=100%', force3D: true});

                isFire = !isFire;
            } else if ( wWidth > 768 && isFire === true) {
                if ( $(mainPanel.element).hasClass('on') ) {
                    mainPanel.close();
                }
                if ( $(resultPanel.element).hasClass('on') ) {
                    resultPanel.close();
                }
                if ( $(infoPanel.element).hasClass('on') ) {
                    infoPanel.close();
                }
                TweenMax.set(resultPanel.element, {x: '+=100%', force3D: true});
                TweenMax.set(infoPanel.element, {x: '+=100%', force3D: true});
                
                isFire = !isFire;
            }
        }
        setPanelPosition($(this).width());
        $(window).resize(function() {
            var windowWidth = $(this).width();
            setPanelPosition(windowWidth);
        });
    })();


    /// 모바일 검색 - 지도 전환탭
    $('.mobile_change_tab a').click(function(e) {
        e.preventDefault();
        $(this).parent().addClass('on').siblings().removeClass('on');

        var tabType = $(this).attr('data-tab');
        if (tabType === 'mapping') {
            TweenMax.to('.side_nav', 0.4, {autoAlpha: 0, ease: Expo.easeOut});
        } else {
            TweenMax.to('.side_nav', 0.4, {autoAlpha: 1, ease: Expo.easeOut});
        }
    });
});