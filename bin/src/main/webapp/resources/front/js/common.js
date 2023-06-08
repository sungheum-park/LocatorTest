/*
 * File       : common.js
 * Author     : m-sync (baeyoungseop)
 * Date       : 19-07-29
 */


$(document).ready(function() {
    (function() {
        /// 모바일 접속 확인
        if (isMobile.any === true) {
            $('body').addClass('mobile-mode');
        }
    })()

    /// 탑 버튼
    $('.btn_top_wrap .btn_top a').click(function(e) {
        e.preventDefault();
        $('html, body').animate({scrollTop: 0}, 600, 'easeOutExpo');
    });

    $(window).scroll(function() {
        if ($(this).scrollTop() > 500) {
            $('.btn_top_wrap').addClass('on');
        } else {
            $('.btn_top_wrap').removeClass('on');
        }
    });
    $('.start_using').waypoint({
        // 모바일 스크롤
        offset: '60%',
        handler: function(direction) {
            if (direction === 'down') {
                $('.mobile_scroll').addClass('on');
            } else {
                $('.mobile_scroll').removeClass('on');
            }
        }
    });

    /// 모바일 gnb
    (function() {
        var isOpen = false; 
        function open () {
            $('#header .gnb_wrap .mobile_menu').toggleClass('on');
            $('body').toggleClass('fix');    
            TweenMax.to('.mobile_gnb', 0.4, {
                ease: Expo.easeOut,
                force3D: true,
                x: '-=100%',
            });
            isOpen = true;
        }
        function close() {
            $('#header .gnb_wrap .mobile_menu').toggleClass('on');
            $('body').toggleClass('fix');    
            TweenMax.to('.mobile_gnb', 0.4, {
                ease: Expo.easeOut,
                force3D: true,
                x: '+=100%',
            });
            isOpen = false;
        }
        $('.mobile_menu a').click(function(e) {
            e.preventDefault();
            
            if ( isOpen === false ) {
                open();
            } else {
                close();
            }
        });
        $(window).resize(function() {
            if ($(this).width() > 768) {
                if (isOpen === true) {
                    close();
                }
            }
        });

		//추가 김은해 
		$('.m-menu-close').click(function(){
			close();
		});
		//추가 김은해 
    })();


    /// 19 오버레이
    $('#overlay .yes').click(function(e) {
        e.preventDefault();
        $('#overlay').hide();
    });
    $('#overlay .no').click(function(e) {
        e.preventDefault();
        $(this).parents('.btn').hide();
        $('#overlay .text p').html('본 사이트는 대한민국에 거주하는 만 19세 이상의<br> 성인흡연자에게만 열람 및 이용이 허용됩니다.');
    });
});
function setCookie(name, value, exp){
    var date = new Date();
    date.setTime(date.getTime() + exp*24*60*60*1000);
    document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
}

function getCookie(name){
    var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return value ? value[2] : null;
}

function deleteCookie(name){
    document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
}
function getQuerystring(paramName) {
    var $tempUrl = window.location.search.substring(1);
    var $tempArray = $tempUrl.split('&');

    for (var i = 0; i < $tempArray.length; i ++) {
        var $keyValuePair = $tempArray[i].split('=');
        if ($keyValuePair[0] == paramName) {
            return $keyValuePair[1];
        }
    }
}