/**
 * File       : faq.js
 * Author     : m-sync (kimkyungran)
 */


$(document).ready(function() {

    $('.faq_menu li').on ({
        click:function (e) {
            e.preventDefault();

            var idx = $(this).index();
            $(this).addClass('on').siblings().removeClass('on');
            $('.menu_content .content').hide().eq(idx).fadeIn(300);
        }
    }).eq(0).click();

    $('#listArea').on('click', '.question', function() {
        var faq = $(this).parents('.faq_list')
        faq.toggleClass('on');
        faq.find('.answer').slideToggle(200);
    });

    $('.paging li').on({
        click:function(){
            $(this).addClass('on').siblings().removeClass('on');
        }
    }).eq(0).click();

    //11-05 중요 정보 추가
    $('.important .title').on({
        click:function(){
            $(this).parents('.important').toggleClass('on');
            $(this).parents('.important').find('.info_wrap').slideToggle(200);
        }
    });
});
