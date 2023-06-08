/*
 * File       : tutorial.js
 * Author     : m-sync (baeyoungseop)
 * Date       : 19-07-24
 */

$(document).ready(function() {
    // 아이코스 튜토리얼 탭메뉴
    function iqosTutorialTab (element, options) {
        // 엘리먼트 제이쿼리 객체로 선택
        if (typeof element === 'string') {
            this.element = $(document.querySelector(element));
        } else if (typeof element === 'object') {
            this.element = element;
        };

        // 옵션
        if (typeof options === 'object') {
            this.options = options;
        }

        // 상태
        var _this = this.element;
        this.state = {
            selectedIndex: 0,
            tabIndex: parseInt(_this.attr('data-tab-index'))
        }
    }
    iqosTutorialTab.prototype = {
        selectMenu: function(e, _index) { // 탭 메뉴선택 메서드
            var _this = $(e.target);

            // 인덱스를 파라미터로 받았을 때는 파라미터 인덱스 사용
            // 아니면 클릭한 것의 인덱스 사용
            var index;
            if (typeof index === 'number') {
                index = _index;
            } else {
                index = _this.parent().index();
            }
            if (this.state.selectedIndex !== index ) {
                // 탭 강조효과
                this.element.find('.swiper-slide')
                .eq(index).addClass('on')
                .siblings().removeClass('on');

                // 해당 컨텐츠 필터
                this.element.parents('.content_wrap').find('.step_list')
                .eq(index).fadeIn(300)
                .siblings().hide();
                // var target = this.element.parents('.content_wrap').find('.step_list').eq(index);
                // var siblings = target.siblings();
                // TweenMax.set(target, {height: 'auto'});
                // TweenMax.to(target, 0.3, {autoAlpha: 1, ease: Power2.easeOut});
                // TweenMax.set(siblings, {autoAlpha: 0, height: 0,});
                
                // 선택된 인덱스 변경 (중복선택방지)
                this.state.selectedIndex = index;

                // OPTION: 사용하기 탭일 때 '중요한 사용팁' 이미지 변경해주기
                if (this.options && this.options.type === 'using') {
                    var imgListArr = [];
                    $('.using_tip .col_right ._img_wrap img').each(function(i) {
                        var dataImageStr = $(this).attr('data-imageurl');
                        var images = JSON.parse(dataImageStr);
                        imgListArr.push(images);
                        $(this).attr('src', imgListArr[i][index]);
                        if(imgListArr[i][index] == '/resources/front/images/tutorial/cus-3-2.png') {
                            $(this).closest('.imp_tip').addClass('on');
                        }else{
                            $('.imp_tip').removeClass('on');
                        }

                    });
                };
                Waypoint.refreshAll();
                // console.log(this.state.selectedIndex);
                console.log('[tabmenu] method called -> selectMenu');
            }
        },
        init: function() { // 초기화(시작) 메서드
            var self = this.element;
            var tabSlider = new Swiper(this.element, {
                observer: true,
                observeParents: true,
                watchOverflow: true,
                slidesPerView: 'auto',
                freeMode: true,
                spaceBetween: 20,
                breakpoints: {
                    768: {
                        spaceBetween: 20,
                    }
                },
                init: (function() { // data- inin = false 면 슬라이드 작동 
                    if (self[0].dataset.init === 'false') {
                        return false
                    } else return true
                })(),
            });
            console.log('[tabmenu] method called -> init');
        }
    }
    var tabmenuArr = [];
    $('.tabslider').each(function() {
        var optionStr = $(this).attr('data-iqostab-option');
        var options;
        if (typeof optionStr !== 'undefined') {
            options = JSON.parse(optionStr);
        } else {
            options = null;
        }

        var tabmenu = new iqosTutorialTab($(this), options);
        tabmenu.init();

        $(this).find('a').click(function(e) {
            e.preventDefault();
            tabmenu.selectMenu(e);
        });
        tabmenuArr.push(tabmenu);
    });

    // 19-07-25 첫번째 탭에서 변경시 전체 탭 변경을 위한 스크립트 추가
    $('.tabslider.tab1 .swiper-slide a').click(function(e) {
        var index = $(this).parent();
        tabmenuArr.map(function(tab) {
            tab.selectMenu(e, index);
        })
    });

    $('.wp').each(function() {
        var _this = $(this);
        var triggerPoints = $(this).attr('data-waypoint');
        _this.waypoint({
            offset: '80%',
            handler: function(direction) {
                if ( direction === 'down' ) {
                    $('.section_navigation li').each(function() {
                        if ($(this).attr('data-waypoint') === triggerPoints) {
                            $(this).addClass('on');
                        } else {
                            $(this).removeClass('on')
                        }
                        return;
                    });
                }
                else {
                    $('.section_navigation li').each(function(i) {
                        if ($(this).attr('data-waypoint') === triggerPoints && i > 0) {
                            $(this).removeClass('on');
                            $(this).parents('.section_navigation').find('li').eq(i-1).addClass('on');
                        }
                        return;
                    });
                }
            }
        });
    });

    $('.section_navigation li a').click(function(e) {
        e.preventDefault();

        var tab = $(this).parent().attr('data-waypoint');
        $('.wp').each(function(i) {
            if ($(this).attr('data-waypoint') === tab) {
                var posY = $('.wp').eq(i).offset().top;
        
                if ($(window).width() < 768) {
                    posY -= $('#header').height() + $('.section_navigation').height();
                }

                $('html, body').animate({
                    scrollTop: posY
                }, 1000, 'easeOutExpo');
            }
        });
    });

    var mainTl = new TimelineMax;
    mainTl
    .from('.visual_txt', 2, {ease: Expo.easeOut,force3D: true,y: 60,autoAlpha: 0,})
    .from('.visual_img', 2, {ease: Expo.easeOut,force3D: true,y: 60,autoAlpha: 0,}, '-=1.6')
    .from('.visual_des', 2, {ease: Expo.easeOut,force3D: true,y: 60,autoAlpha: 0,}, '-=1.6');
});

/// 스크롤시 네비게이션 포지션 제한 --------------???????????????????????어디서 추가 된 코드인지??????????????????????????
$(window).scroll(function() {

    if ( $(this).width() > 768 ) {
        // var point = $('.reset').offset().top + $('.reset').outerHeight()
        var point = $('.self-wrap').offset().top + $('.self-wrap').outerHeight()
        var relPoint = $('.section_navigation').offset().top + $('.section_navigation ul').outerHeight();
        if( relPoint > point ) {
            // 페이지 끝나는 부분 보다 네비게이션이 내려갈때 고정
            $('.section_navigation').css({
                position: 'absolute',
                top: parseInt(point - $('.section_navigation ul').outerHeight() - 100),
                bottom: 'auto'
            });
        } else if ($(this).scrollTop() + $(this).height() - $('.section_navigation ul').outerHeight() < point ) {
            $('.section_navigation').css({
                position: 'fixed',
                top: 'auto',
                bottom: '33%'
            });
        }
    }

 /*   if ( $(this).width() > 768 ) {
        var point = $('.check_code').offset().top + $('.check_code').outerHeight()
        var relPoint = $('.section_navigation').offset().top + $('.section_navigation ul').outerHeight();
        if( relPoint > point ) {
            console.log(relPoint, point)
            $('.section_navigation').css({
                position: 'absolute',
                top: parseInt(point - $('.section_navigation ul').outerHeight()),
                bottom: 'auto'
            });
        } else if ($(this).scrollTop() + $(this).height() - $('.section_navigation ul').outerHeight() < point ) {
            $('.section_navigation').css({
                position: 'fixed',
                top: 'auto',
                bottom: '33%'
            });
        }
    }*/
});

$(window).on('load', function() { //이미지 로딩 후 실행
    var device = getQuerystring('device');
    var section = getQuerystring('move');
    if (device && section) { //device와 section 이 정상적으로 적용되었을때만 실행
        faqLink(device, section);
    }
})

function faqLink(device, section) {
    // 섹션이동
    switch(section) {
        case 'using':
            {
                $('li[data-waypoint="nav1"] a').click();
                break;
            }
        case 'cleaning':
            {
                $('li[data-waypoint="nav2"] a').click();
                break;
            }
        case 'reset':
            {
                $('li[data-waypoint="nav3"] a').click();
                break;
            }
        default: 
        console.error('Unhandled section type ' + section)
        break;
    }

    // 클릭이벤트
    switch(device) {
        case 'cus-1':
            {
                $('[data-device="cus-1"]').click();
                break;
            }
        case 'cus-2':
            {
                $('[data-device="cus-2"]').click();
                break;
            }
        case 'cus-3':
            {
                $('[data-device="cus-3"]').click();
                break;
            }
        case 'duo':
            {
                $('[data-device="duo"]').click();
                break;
            }
        case 'iqos3':
            {
                $('[data-device="iqos3"]').click();
                break;
            }
        case 'multi':
            {
                $('[data-device="multi"]').click();
                break;
            }
        case 'iqos2':
            {
                $('[data-device="iqos2"]').click();
                break;
            }
        default: 
        console.error('Unhandled device type ' + device)
        break;
    }
}