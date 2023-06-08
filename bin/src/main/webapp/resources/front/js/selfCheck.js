/*
 * File       : selfCheck.js
 * Author     : m-sync (baeyoungseop)
 * Date       : 19-07-25
 */

$(document).ready(function() {
    (function() {
        var isOpen = false;
        $('#showWay').click(function(e) {
            e.preventDefault();
            
            if (isOpen === false) {
                TweenMax.set($('.way'), {height: 'auto', autoAlpha: 1,});
                TweenMax.from($('.way'), 2, {
                    height: 0,
                    autoAlpha: 0,
                    ease: Expo.easeOut,
                    force3D: true,
                    onUpdate: function() {
                        Waypoint.refreshAll();
                    }
                });
                $('.btn_register_toggle a').text('기기 등록방법 닫기').addClass('on');

                isOpen = !isOpen;
            } else {
                TweenMax.to($('.way'), 0.4, {
                    height: 0,
                    autoAlpha: 0,
                    ease: Expo.easeOut,
                    force3D: true,
                    onUpdate: function() {
                        Waypoint.refreshAll();
                    }
                });
                $('.btn_register_toggle a').text('기기 등록방법 보기').removeClass('on');

                isOpen = !isOpen;
            }
        });
        $('.btn_register_toggle a.btt').click(function(e) {
            e.preventDefault();
            $('#showWay').click();
        });
    })();

    var mainTl = new TimelineMax;
    mainTl
    .from('.online_self_check .section_title', 2, {ease: Power3.easeOut, force3D: true, autoAlpha: 0, y: 60},)
    .from('.online_self_check .self_check_text .sub_title', 2, {ease: Power3.easeOut, force3D: true, autoAlpha: 0, y: 60}, '-=1.6')
    .from('.online_self_check .self_check_text .default_des', 2, {ease: Power3.easeOut, force3D: true, autoAlpha: 0, y: 60}, '-=1.6')
});