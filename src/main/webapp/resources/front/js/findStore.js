var mainPanel;      // 매장 찾기
var resultPanel;    // 매장 검색 결과 리스트
var infoPanel;      // 매장 상세
var changeTab;      // 모바일 상단 메뉴
var step2;          // 지역검색2

var customScroll;   // PerfectScroll

var onlyParcel;     // 택배팝업
var loading;        // 로딩팝업
var noticePopup;    // 공지사항팝업
var survey;         // 설문조사 팝업
var moment;         // 체크팝업

// 모바일 풀스크린
var vh = window.innerHeight * 0.01;
document.documentElement.style.setProperty('--vh', vh+'px');

$(window).resize(function() {
    vh = window.innerHeight * 0.01;
    document.documentElement.style.setProperty('--vh', vh+'px');
});

$(document).ready(function() {
    /// PC 커스텀 스크롤바
    customScroll = (function() {
        var element = $('.scroll_area');
        var scrollObj;
        return {
            init: (function() {
                if ( !(isMobile.any) ) {
                    var elementObj = [];
                    element.each(function() {
                        var _this = $(this);
                        elementObj.push(
                            new PerfectScrollbar(_this[0], {
                                wheelSpeed: 0.3,
                                suppressScrollX: true,
                            })
                        );
                    });
                    scrollObj = elementObj;
                };
            })(),
            updateScroll: function() {
                if(!isMobile.any){
                    scrollObj.map(function(scroll) {
                        scroll.update();
                    });
                }
            }
        }
    })();


    /// 사이드바 레이아웃
    var panel = function(element) {
        this.element = document.querySelectorAll(element);
        this.state = {
            isOpen : false
        }
    }
    panel.prototype = {
        open: function() {
            if ( this.state.isOpen === false ) {
                var target = this.element;
                TweenMax.to(target, 0.4, {
                    ease: Expo.easeOut,
                    force3D: true,
                    xPercent: '+=100',
                    onStart: function() {
                        $(target).addClass('on');
                    }
                });
            }
            this.state.isOpen = true;
        },
        close: function() {
            if ( this.state.isOpen === true ) {
                TweenMax.to(this.element, 0.4, {
                    ease: Expo.easeOut,
                    force3D: true,
                    xPercent: (function() {
                        if ($(window).width() > 768) {
                            return 0;
                        } else {
                            return '-=100'
                        }
                    })(),
                    onStart: function() {
                        $(this.target).removeClass('on');
                    }
                });
            }
            this.state.isOpen = false;
        }
    }
    mainPanel = new panel('.side_nav');
    resultPanel = new panel('.search_result_panel');
    infoPanel = new panel('.info_panel');

	//추가 김은해
	changePanel = new panel('.new-style-popup');
	//추가 김은해

    changeTab = new panel('.mobile_change_tab');
    step2 = new panel('.step-2');

    /// 사이드바 토글기능
    (function() {
        $('#header .header_inner .search_store.search_store_pc a').click(function(e) {
            // 매장찾기 클릭시 -> 사이드바 열림
            e.preventDefault();
            var isToggle = $('.side_nav').hasClass('on');
            if (!isToggle) {
                mainPanel.open();
                changeTab.open();
                if (isMobile.any) {
                    if (storeListGType.length > 0) {
                        resultPanel.open();
                    }
                }
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
			 if ( $(changePanel.element).hasClass('on') ) {
                changePanel.close();
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


	    //작업하기 위하여 열어둠 김은해
        $('.main_panel .near_store a').click(function(e) {
            // 근처매장 바로보기 -> 결과 판 열림
            e.preventDefault();
            var isToggle = $('.search_result_panel').hasClass('on');
            if ( !isToggle ) {
                resultPanel.open();
            }
        });
        //작업하기 위하여 열어둠 김은해

		//수정 김은해
        $('.option .detail a').click(function(e) {
            // 매장검색결과 매장선택 -> 매장정보 판 열림
            e.preventDefault();
            var isToggle = $('.info_panel').hasClass('on');
            if ( !isToggle ) {
                infoPanel.open();
            }
        })
		//수정 김은해

		//추가 김은해 - 교환현황 리뉴얼
		$('.info_panel .others li a.new-popup').click(function(e) {
            e.preventDefault();
            var isToggle = $('.new-style-popup').hasClass('on');
            if ( !isToggle ) {
                changePanel.open();
            }
        })
		//추가 김은해 - 교환현황 리뉴얼
    })();


    /// 매장검색 탭
    ;(function() {
        $('.search_box .search_tab li a').on({
            click: function(e) {
                // e.preventDefault();
                // e.stopPropagation();
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
                e.stopPropagation();
                e.preventDefault();
                var flag = $(this).parent().hasClass('on');
                if(!flag){
                    filterInitializeExcg();
                }
                $(this).parent().addClass('on').siblings().removeClass('on');

				//수정 김은해
                var index = $(this).parent().index();
                $('.list-new').eq(index).show().siblings().hide();
				//수정 김은해
            }

        })
    })();

    /// 매장검색 - 지역검색
    ;(function() {
        // 스텝1 -> 스텝2
        $('.main_panel .local_list_wrap li a').on({
            click: function(e) {
                e.preventDefault();
                $('.main_panel .location_search .step-1').hide();
                step2.open();
            }
        });

        // 스텝2 -> 스텝1
        $('.main_panel .sub_local_list_wrap .title h2').on({
            click: function() {
                $('.main_panel .location_search .step-1').show();
                step2.close();
            }
        });
    })();


    /// 필터리스트 타이틀
    ;(function() {
        $('.main_panel .filter_list').on({
            click: function(e) {
                e.stopPropagation();
                e.preventDefault();
                var isShow = $(this).hasClass('on');
                if($(this).index() == 2){
                    if(!isShow){
                        if ($(this).find('[id*=fil-chg]').length > 0) {
                            if (!$(this).find('[id*=fil-chg]').hasClass('on')) {
                                $(this).find('[id*=fil-chg]').first().addClass('on')
                                $('.filter_depth2_list').eq(0).show().siblings().hide();
                            }
                            $(this).parent().find('.filter_list').eq(1).find('[id*=fil-sel]').attr('checked', false);
                        } else {
                            if (!$(this).find('ul li').hasClass('on')) {
                                $(this).find('ul li').first().addClass('on')
                                $('.filter_depth2_list').eq(0).show().siblings().hide();
                            }
                            $(this).parent().find('.filter_list').eq(1).find('.filter_depth2').removeClass('on')
                        }
                    }
                }
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
                }else{
                    var toggleTarget = $(this).find('.filter');
                    $(this).removeClass('on')
                    TweenMax.to(toggleTarget, 0.6, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });
                }
            }
        });
    })();

    /// 필터리스트 서비스
    ;(function() {
        $('.main_panel .filter_list .filter').on({
            click: function(e) {
                e.stopPropagation();
            }
        });
    })();



    /// 필터 뎁스2
    ;(function() {
        $('.main_panel .filter_depth2 h3').on({
            click: function(e) {
                e.stopPropagation();
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
                    var siblingsTarget2 = $(this).parents('.filter_depth2').siblings('.filter_depth2').find('.color_list_wrap .color_list');
                    siblingsTarget2.each(function(){
                        if($(this).hasClass('on')){
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
                            });
                            target.toggle();
                        }
                    })
                }
            }
        })
    })();


    // 판매기기 > 상품 선택시 교환기기 체크 항목 초기화
    ;(function() {
        $('.main_panel .sell_eq .filter_depth2 h3').on({
            click: function(e) {
                e.stopPropagation();
                $('.main_panel .change_eq').find('ul li, .filter_depth2').removeClass('on');
                $('.main_panel .change_eq .filter_depth2 h3').each(function(){
                    $(this).parents('.filter_depth2').removeClass('on')
                    var siblingsTarget = $(this).parents('.filter_depth2').siblings('.filter_depth2').find('.color_list_wrap');
                    TweenMax.to(siblingsTarget, 0.6, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });
                });
                $('.color_list').each(function(){
                    if($(this).hasClass('on')){
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
                        });
                        target.toggle();
                    }
                });
            }
        })
    })();


    // 판매기기 > 상품 선택시 교환기기 체크 항목 초기화 (필터링 페이지 전용)
    ;(function() {
        $('.main_panel .sell_eq [id*=fil-sel]').on({
            click: function(e) {
                e.stopPropagation();
                $('.main_panel .change_eq').find('[id*=fil-chg]').removeClass('on');
                $('.main_panel .change_eq').find('[id*=fil-dvc]').removeClass('on');
                $('.main_panel .change_eq').find('.filter_depth2').removeClass('current');
                $('.main_panel .change_eq').find('.color-circle').removeClass('on');
            }
        })
    })();



    /// 컬러 리스트
    ;(function() {
        $('.color_list').on({
            click: function(e) {
                e.stopPropagation();
                var color = $(this).attr('data-color');
                if(typeof color != 'undefined'){
                    $(this).toggleClass('on');
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
                var isToggle = $(this).parent().hasClass('on');
                var _this = $(this);
                if ( !isToggle ) {
                    $(this).parent().addClass('on');
                    var target = $(this).siblings('.store_list_wrap');

                    TweenMax.set(target, {height: 'auto'});
                    TweenMax.from(target, 0.4, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                        onComplete: function() {
                            if(!isMobile.any){
                                customScroll.updateScroll();
                            }
                        },
                        onStart: function() {
                            if(!isMobile.any){
                                _this.parents('.panel_inner.scroll_area').animate({scrollTop: 0}, 300);
                            }
                        }
                    });

                    $(this).parent().siblings('.store_type').removeClass('on');
                    var siblingsTarget = $(this).parent().siblings('.store_type').find('.store_list_wrap');
                    TweenMax.to(siblingsTarget, 0.4, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                    });
                } else {
                    $(this).parent().removeClass('on');
                    var target = $(this).siblings('.store_list_wrap');

                    TweenMax.to(target, 0.4, {
                        height: 0,
                        ease: Expo.easeOut,
                        force3D: true,
                        onComplete: function() {
                            if(!isMobile.any){
                                customScroll.updateScroll();
                            }
                        },
                        onStart: function() {
                            if(!isMobile.any){
                                _this.parents('.panel_inner.scroll_area').animate({scrollTop: 0}, 300);
                            }
                        }
                    });
                }
            }
        });
    })();


    //막아놓음 김은해
    /// 매장 정보 판 - 매장 사진 슬라이더
   /* var storeSl = new Swiper('.store_img', {
        observer: true,
        observeParents: true,
        watchOverflow: true,
        pagination: {
            el: '.store_pg',
            type: 'bullets',
            clickable: true,
        },
    });*/



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

			//추가 김은해
			$('.copy-comment').removeClass('on');
			$('.sms_share_form').css('display','none');
			//추가 김은해
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

        /**
        $('._colors').click(function() {
            // 교환기기 체크
            $(this).addClass('on').siblings().removeClass('on');
            var bColor = $(this).find('span').css('background-color');
            var cText = $(this).find('p').text();
            var obj = $(this).parents('.product_info').find('.stock');

            obj.find('.pal').css({'background-color': bColor});
            obj.find('.pal_text').text(cText);
        });
         */

        $('.btn_pop_close a').click(function(e) {
            // 레이어 닫기
            e.preventDefault();
            $(this).parents('.iqos_store_popup').fadeOut(300);
        });
        $('.iqos_store_popup .bg').click(function() {
            // 레이어 닫기
            $(this).parent().fadeOut(300);
        })


        // 현황 탭메뉴
        $('.iqos_store_popup .product_type_select a').click(function(e) {
            e.preventDefault();
            $(this).parent().addClass('on').siblings().removeClass('on');

            var index = $(this).parent().index();
            $(this).parents('.iqos_store_popup').find('.mobile_tab_menu .swiper-slide').eq(index).addClass('on').siblings().removeClass('on');
        })

        //  현황 모바일탭메뉴
        var mobileTab = new Swiper('.mobile_tab_menu', {
            observer: true,
            observeParents: true,
            watchOverflow: true,
            slidesPerView: 'auto',
            spaceBetween: 15,
        });
        $('.mobile_tab_menu .swiper-slide a').click(function(e) {
            // 모바일 탭메뉴 클릭이벤트
            e.preventDefault();
            $(this).parent().addClass('on').siblings().removeClass('on');

            var index= $(this).parent().index();
            $(this).parents('.iqos_store_popup').find('.product_type_select li').eq(index).addClass('on').siblings().removeClass('on')
        });
    })();


    /// 반응형 조정
    (function() {
        var isFire = false;
        function setPanelPosition(wWidth) {
            if ( wWidth <= 768 && isFire === false ) {
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

				//추가 김은해
				 if ( $(changePanel.element).hasClass('on') ) {
                    changePanel.close();
                }
				//추가 김은해

                if ( $(step2.element).hasClass('on') ) {
                    step2.close();
                }
                TweenMax.set(resultPanel.element, {xPercent: '-=100', force3D: true});
                TweenMax.set(infoPanel.element, {xPercent: '-=100', force3D: true});

				//추가 김은해 
                TweenMax.set(changePanel.element, {xPercent: '-=100', force3D: true});
				//추가 김은해 

                isFire = !isFire;
            } else if ( wWidth > 768 && isFire === true) {
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
				//추가 김은해
				 if ( $(changePanel.element).hasClass('on') ) {
                    changePanel.close();
                }
				//추가 김은해 

                if ( $(step2.element).hasClass('on') ) {
                    step2.close();
                }
                TweenMax.set(resultPanel.element, {xPercent: '+=100', force3D: true});
                TweenMax.set(infoPanel.element, {xPercent: '+=100', force3D: true});

				//추가 김은해
                TweenMax.set(changePanel.element, {xPercent: '+=100', force3D: true});
				//추가 김은해

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
		
		//추가 김은해
		$('.list-type-nav').removeClass('on');
		//추가 김은해

        var tabType = $(this).attr('data-tab');
        if (tabType === 'mapping') {
            TweenMax.to('.side_nav', 0.4, {autoAlpha: 0, ease: Expo.easeOut});
        } else {
            TweenMax.to('.side_nav', 0.4, {autoAlpha: 1, ease: Expo.easeOut});
        }
    });

    /// 택배교환 팝업
    onlyParcel = new iqosPopup('.only-parcel');
    onlyParcel.closeTrigger.click(function() {
        onlyParcel.closePopup();
    })

    /// 공유 - SMS 버튼 클릭시
    $('.share.sms').click(function() {
        $(this).parents('.share_popup').find('.sms_share_form').stop().slideToggle(400, 'easeOutExpo');
    });

    /// 모바일기기 접속시 클래스추가
    if ( isMobile.any === true ) {
        $('body').addClass('mobile-mode');
    }

    function momentPopup() {
        iqosPopup.apply(this, arguments);
    };
    momentPopup.prototype = Object.create(iqosPopup.prototype);
    momentPopup.prototype.constructor = momentPopup;
    momentPopup.prototype.onMoment = function(t, imgurl) {
        var _this = this;
        this.element.find('img').attr('src', imgurl);
        this.openPopup();
        setTimeout(function() {
            _this.closePopup();
            _this.element.find('img').attr('src', '');
        }, (t*1000));
    }

    /// 체크, 로딩 팝업
    moment = new momentPopup('#moment'); // moment.onMoment(1, checkimg); moment.onMoment(1.3, resettingimg);
    loading = new iqosPopup('#loading');

    survey = new iqosPopup('#survey');
    survey.closeTrigger.click(function() {
        survey.closePopup();
    });
    survey.bg.click(function() {
        survey.closePopup();
    });

    noticePopup = new iqosPopup('.notice_popup');
    $('.notice_popup .notice_close').click(function(e) {
        e.preventDefault();
        noticePopup.closePopup();
    });
    $('#closeNotice').click(function(e) {
        e.preventDefault();
        noticePopup.closePopup();
    })
    $('#doNotReopen').click(function(e){
        e.preventDefault();
        noticePopup.closePopup();
        setCookie('iqosStoreLocatorNotice', true, 1);
    })


/**********************************추가************************************/
	
	// 교환기기 선택
	$('.add-search-tab li a').click(function(){
        var tab_index = $(this).parent('li').index();
        $('.list-new').eq(tab_index).show().siblings().hide();
        $('.device-list > div').find('a').removeClass('on');
        $('.device-list > div:first-child').find('a').addClass('on');
    });

	//$('.color-box-wrap:first-child').find('.color-circle').addClass('on');
	
	$('.device-list > div').click(function(){
        $('.color-box-wrap').find('.color-circle').removeClass('on');
		var tab_id = $(this).index();		
		$(this).parents('.list-new').find('.filter_depth2_new').eq(tab_id).addClass('current').siblings().removeClass('current');
		$('.device-list > div').removeClass('on');
		$(this).addClass('on');
	});

	// 모바일 필터링 교환기기 선택
	$('.mobile_tab_menu .swiper-slide').click(function(){
        $('.color-box-wrap').find('.color-circle').removeClass('on');
        $('.filter_depth2_new.current').removeClass('current');
        var tab_index2 = $(this).index();
        $(this).parents('.change_eq').find('.list-new').eq(tab_index2).show().siblings().hide();
        $('.device-list > div').removeClass('on');
    });

	// url복사 클릭시
	$('.copy').click(function(){
		$('.copy-comment').addClass('on');
		$('.sms_share_form').css('display','none');
	});
	
	// 플로팅메뉴
	$('.floating-close').click(function(){
        $('.floating-wrap').hide();
		/*$('.floating-wrap').css('top','100%');*/
		$('.f-depth2-box').removeClass('on');
		$('.f-depth1-list li').removeClass('on');
		$('.f-depth1-list li:first-child').addClass('on');
	});

	$('.m-floating').click(function(){
        $('.floating-wrap').show();
		/*$('.floating-wrap').css('top','0');*/
		$('.f-depth2-box:first-child').addClass('on');
	});

	$('.f-depth1-list li a').click(function(){
		$('.f-depth1-list li').removeClass('on');
		$(this).parent('li').addClass('on');
		 var mfloating = $(this).parent().index();
		 // console.log(mfloating);
		 $('.f-depth2-box').removeClass('on');
		 $('.f-depth2-box').eq(mfloating).addClass('on');
	});

	// 모바일 플로팅메뉴 롤링
	var swiper3 = new Swiper('.f-depth2-box', {
		loop: true,
		speed:200,
		slidesPerView: "auto",
        centeredSlides: true,
		clickable: true,
	
	});

    // 플로팅 필터링 롤링
	var swiper4 = new Swiper('.m-filtering', {
		speed:200,
		slidesPerView: "auto",
		clickable: true,
        observer: true,
        observeParents: true
	});

	//var $tag =  $('<div class="swiper-slide"><a href="#" class="filter-link"><img src="../images/filter-link.png"></a></div>');
	//$('.add-btn').append($tag);

    // 컬러 선택시
    $('.color-circle').click(function(){
        if (typeof $(this).data('color') != "undefined") {
            $(this).toggleClass('on');
        }
    });

	// sms전송 클릭시 복사멘트 없애기
    $('.share.sms').click(function() {
        $('.copy-comment').removeClass('on');
    });

	$('.init-n, .init-y').click(function(){
        $('.init-popup').removeClass('on');
	});

	$('.m-filtering span a').click(function(){
		$(this).parents('.swiper-slide').css('display','none');
	});


	// 초기화 버튼 클릭시
	//  $('.fil-popup-btns .reset').click(function(){
    // 	$('.init-popup').addClass('on');
    //  });

	// 모바일 메뉴
    $('.mobile_menu a').click(function(){
        $('.m-menu-bg').addClass('on');
        $('.mobile_gnb').css('right','80%');
    });

    $('.m-menu-close').click(function(){
        $('.m-menu-bg').removeClass('on');
    });

    // 목록형
	$('.search-tag').click(function() {
		$('.search-tag2').removeClass('on');
		$(this).addClass('on');
		$('.list-type-nav').addClass('on');		
    });

	// 지도형
    $('.search-tag2').click(function() {
        $(this).addClass('on');
        $('.search-tag').removeClass('on');
        $('.list-type-nav').removeClass('on');
        $('.list-type-details').removeClass('on');
    });


	// 목록형 상세페이지
	$('.detail2').click(function(){
		$('.list-type-details').addClass('on')
	});

	$('.close_panel').click(function(){
		$('.list-type-nav').removeClass('on');
		$('.search-tag').removeClass('on');
	});

	$('.list-type-details .btn_back').click(function(){
		$('.list-type-details').removeClass('on');
		$('.list-type-change').removeClass('on');	
	});

	// 모바일 목록형 상세페이지에서 교환기기현황 클릭시 
	$('.list-type-details .others li a.new-popup').click(function() {
		$('.list-type-change').addClass('on');		
		$('.scroll-stop').animate({scrollTop : 0}, 200).css('overflow-y','hidden');
	});

	$('.change_popup_close').click(function(){
		$('.list-type-change').removeClass('on');		
		$('.scroll-stop').animate({scrollTop : 0}, 200).css('overflow-y','auto');
	});

	// 모바일 공유하기
	$('.m-share').click(function(){
		$('.share_popup_wrap').show();
	});

	$('.share_popup_close').click(function(){
		$('.share_popup_wrap').hide();
		$('.copy-comment').removeClass('on');
	});

    // 필터링 팝업
	$('.m-filtering .filter-link').click(function(){
		$('.fil-popup').addClass('on');
	});

	$('.fil-popup .btn_back').click(function(){
		$('.fil-popup').removeClass('on');
	});

	/*$('.fil-popup .filter_list').click(function(){
		$(this).find('h2').removeClass('off');
		$(this).siblings().find('h2').addClass('off');
	});*/

	$('.search-inner input').click(function(){
		//var btnC = $(this).parent('.search-inner').find('button').attr('class');
		//if (btnC == 'search-tag'){
			$('.m-search-new2').addClass('on');
			$(this).blur();
            $('.m-search-new2 input').focus();
		//} else{
		//	$('.m-search-new1').addClass('on');
		//}
	});	

	$('.search-inner button.search-btn').click(function(){
		//var btnC = $(this).parent('.search-inner').find('button').attr('class');
		//if (btnC == 'search-tag'){
			$('.m-search-new2').addClass('on');
		//} else{
		//	$('.m-search-new1').addClass('on');
		//}
	});
	

	$('.m-search-new1 .btn_back').click(function(){
		$('.m-search-new1').removeClass('on');
		$('.m-search-new1 .result-txt').css('display','none');
	});

	$('.m-search-new2 .btn_back').click(function(){
		$('.m-search-new2').removeClass('on');
		$('.m-search-new2 .result-txt').css('display','none');
	});

	//검색 결과 (내용없을때)
	$('.m-search-btn').click(function(){
		$('.result-txt').show();
	});

	//스와이퍼 블러 사라지게하기
	$('.mobile_tab_menu .swiper-slide').click(function(){
		if ($(this).hasClass('last-s')){
			$('.blur-box').css('right','-100%');
		} else{
			$('.blur-box').css('right','0');
		}
	});
	
	//모바일 지역검색
	$('.local-search').click(function(){
		$('.area-search-popup').addClass('on');
		$('.m-step1').addClass('on');
	});

	$('.area-name-list li a').click(function(){
		$('.m-step2').addClass('on');
	});

	$('.area-search-popup .btn_back').click(function(){
		if ($('.m-step2').hasClass('on')){
            $('.m-step2').removeClass('on');
            $('.m-step1').addClass('on');
        } else {
            $('.area-search-popup').removeClass('on');
            $('.m-step1').removeClass('on');
            $('.m-step2').removeClass('on');
        }
	});

	//모바일 지도에서  스토어 상세팝업 닫기
	$('.close_window').click(function(){
		$(this).parent('.m-new-window').css('display','none');
	});

	//pc지도 스토어 상세팝업 닫기
	$('.close_window').click(function(){
		$(this).parent('.new-window').css('display','none');
	});
});


