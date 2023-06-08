/*
 * File       : iqosPopup.js
 * Author     : m-sync (baeyoungseop)
 * Date       : 19-07-24
 */
// Layer popup JS - iqos
var iqosPopup = function(element) {
    // 엘리먼트 제이쿼리 객체로 선택
    var typeofEl = typeof element;
    if (typeofEl === 'string') {
        // 셀렉터로만 입력시 -> 제이쿼리 객체로
        this.element = $(document.querySelector(element));
    } else if (typeofEl === 'object') {
        // 제이쿼리 객체로 선택시 -> 그대로 가져감
        this.element = element;
    };

    // 클로즈 트리거
    this.closeTrigger = this.element.find('.pop_close');
    this.bg = this.element.find('.bg');

    // 옵션
    this.options = { // 기본 옵션 세팅
        x: 0,   // translateX 값
        y: 0,   // translateY 값
        duration: 0.4, // 시간
        scale: 1, // 스케일
    }

    // 상태
    this.state = {
        isOpen: false,
    }
}

iqosPopup.prototype = {
    test: function() {
        var data = {
            element: this.element,
            options: this.options,
            states: this.state,
            message: '아이코스 팝업 오브젝트.'
        }
        console.log('[iqosPopup.js] called method "test".', data);
    },
    openPopup: function(options) {
        // 팝업열기
        if ( this.state.isOpen === false ) {
            var fixedOption = this.options;
            if (typeof options === 'object') {
                // 옵션을 파라미터로 전달받았을 때 기본 옵션과 
                // 다르다면 파라미터로 전달받은 옵션으로 교체
                for (var key in fixedOption) {
                    if (options[key] === undefined) {
                        fixedOption[key] = this.options[key];
                    } else {
                        fixedOption[key] = options[key];
                    };
                };
            };

            var _this = this.element;
            TweenMax.to(this.element, fixedOption.duration, {
                ease: Expo.easeOut,
                x: fixedOption.x,
                y: fixedOption.y,
                autoAlpha: 1,
                force3D: true,
                onComplete: function() {
                    // 팝업 뿌옇게 보이는것 픽스
                    var height = _this.height();
                    if (height%2) {
                        _this.find('.pop_inner').css({height: _this.find('.pop_inner').outerHeight()+1});
                    };
                }
            });
            this.state.isOpen = true;

            //console.log('[iqosPopup.js] called method "openPopup".');
        }
    },
    closePopup: function(options) {
        // 팝업 닫기
        if ( this.state.isOpen === true ) {
            var fixedOption = this.options;
            if (typeof options === 'object') {
                // 옵션을 파라미터로 전달받았을 때 기본 옵션과 
                // 다르다면 파라미터로 전달받은 옵션으로 교체
                for (var key in fixedOption) {
                    if (options[key] === undefined) {
                        fixedOption[key] = this.options[key];
                    } else {
                        fixedOption[key] = options[key];
                    };
                };
            };

            TweenMax.to(this.element, fixedOption.duration, {
                ease: Expo.easeOut,
                x: fixedOption.x,
                y: fixedOption.y,
                autoAlpha: 0,
                force3D: true,
            });
            this.state.isOpen = false;

            //console.log('[iqosPopup.js] called method "closePopup".');
        }
    },
}
