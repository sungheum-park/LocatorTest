$(document).ready(function() {
    
    //gnb 탭
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

    
    // 메인 제품 슬라이드 
    $('.visual_wrap .iqos_slider').each(function(i) {
        var _this = $(this);
        var changeSl = new Swiper (_this ,{
            observer: true,
            observeParents: true,
            slidesPerView: 3,
            spaceBetween: 42,
            freeMode: true,
            scrollbar: {
                el: '.visual_wrap .swiper-scrollbar',
            },
            navigation: {
                nextEl: '.arr_right',
                prevEl: '.arr_left',
            },
            // mousewheel: true,
            breakpoints: {
                1200: {
                    spaceBetween: 12,
                    slidesPerView: 2
                },
                1024: {
                    spaceBetween: 18,
                    slidesPerView: 2
                },
            },
        });
    });

    // 메인 제품 슬라이드 선택 탭(리스트 = 아이템 네임)
    
    var pdtlistSl = new Swiper ('.change_pdt_list', {
        observer: true,
        observeParents: true,
        watchOverflow: true,
        slidesPerView: 'auto',
        spaceBetween: 24,
        breakpoints: {
            1024: {
                spaceBetween: 12
                
            },
        },
    });


    
    // 메인 아이템 제품 이름 탭 클릭 시 해당 컨텐츠 block

    $('.change_pdt_list li').on({
        click:function(e) {
            var idx = $(this).index();

            $(this).addClass('on').siblings().removeClass('on');

            $('.visual_left .main_image').hide().eq(idx).show();
            $('.visual_slide_wrap .swiper_wrap').hide().eq(idx).show();
        }
    }).eq(0).click();




});