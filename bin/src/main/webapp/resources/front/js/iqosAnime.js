/*
 * File       : iqosAnime.js
 * Author     : m-sync (baeyoungseop)
 * Date       : 19-07-24
 */

    /// 아이코스 공통 애니메이션 JS



var iqosAnime = function(element) {
    // 엘리먼트 제이쿼리 객체로 선택
    var typeofEl = typeof element;
    if (typeofEl === 'string') {
        // 셀렉터로만 입력시 -> 제이쿼리 객체로
        this.element = $(document.querySelector(element));
    } else if (typeofEl === 'object') {
        // 제이쿼리 객체로 선택시 -> 그대로 가져감
        this.element = element;
    };


    // 상태
    var _this = this.element;
    this.state = {
        isDone: false,
        delay: (function() {
            var tempDelay = _this.attr('data-delay');
            if ( typeof tempDelay === 'string' ) {
                return tempDelay
            } else {
                return 0;
            }
        })()
    };


    // 기본 세팅
    TweenMax.set(this.element, {
        autoAlpha: 0,
    });
}

iqosAnime.prototype = {
    /// 액션함수
    fadeIn: function() {
        // 페이드인
        var delay = this.state.delay;
        if (this.state.isDone === false) {
            TweenMax.to(this.element, 2, {
                ease: Power3.easeOut,
                force3D: true,
                autoAlpha: 1,
                delay: (function() {
                    if ( !(delay === 0) ) {
                        return delay;
                    } else {
                        return 0;
                    }
                })(),
            });
            this.state.isDone = true;
    
            console.log('[iqosAnime.js] called method "fadeIn".');
        }
    },
    fadeUp: function() {
        // 페이드인 + 위로 떠오르는 효과
        var delay = this.state.delay;
        if (this.state.isDone === false) {
            TweenMax.set(this.element, {
                y: 60,
            });
            TweenMax.to(this.element, 2, {
                ease: Power3.easeOut,
                force3D: true,
                y: 0,
                autoAlpha: 1,
                delay: (function() {
                    if ( !(delay === 0) ) {
                        return delay;
                    } else {
                        return 0;
                    }
                })(),
            });
            this.state.isDone = true;
    
            console.log('[iqosAnime.js] called method "fadeUp".');
        }
    },
    fadeLeftToRight: function() {
        // 페이드인 + ---> 방향
        var delay = this.state.delay;
        if (this.state.isDone === false) {
            TweenMax.set(this.element, {
                x: 60,
            });
            TweenMax.to(this.element, 2, {
                ease: Power3.easeOut,
                force3D: true,
                x: 0,
                autoAlpha: 1,
                delay: (function() {
                    if ( !(delay === 0) ) {
                        return delay;
                    } else {
                        return 0;
                    }
                })(),
            });
            this.state.isDone = true;
    
            console.log('[iqosAnime.js] called method "fadeLeftToRight".');
        }
    },
    fadeRightToLeft: function() {
        // 페이드인 + <--- 방향
        var delay = this.state.delay;
        if (this.state.isDone === false) {
            TweenMax.set(this.element, {
                x: 60,
            });
            TweenMax.to(this.element, 2, {
                ease: Power3.easeOut,
                force3D: true,
                x: 0,
                autoAlpha: 1,
                delay: (function() {
                    if ( !(delay === 0) ) {
                        return delay;
                    } else {
                        return 0;
                    }
                })(),
            });
            this.state.isDone = true;
    
            console.log('[iqosAnime.js] called method "fadeRightToLeft".');
        }
    },
    bgLeftToRight: function() {
        // 백그라운드 효과
        var delay = this.state.delay;
        if (this.state.isDone === false) {
            var _this = this.element;
            TweenMax.set(_this, {
                autoAlpha: 1,
            });
            TweenMax.to(_this, 0.5, {
                ease: Expo.easeOut,
                force3D: true,
                width: '100%',
                delay: (function() {
                    if ( !(delay === 0) ) {
                        return delay;
                    } else {
                        return 0;
                    }
                })(),
                onComplete: function() {
                    _this.css({left: 'auto', right: '0'});
                    TweenMax.to(_this, 0.5, {
                        ease: Expo.easeInOut,
                        force3D: true,
                        width: 0,
                    });
                }
            });
            this.state.isDone = true;
    
            console.log('[iqosAnime.js] called method "bgLeftToRight".');
        }
    }
}

$(document).ready(function() {
    /// 액션트리거
    $('.iqos-ani-fadein').each(function() {
        var anime = new iqosAnime($(this));
        var customOffset = $(this).attr('data-offset');
        $(this).waypoint({
            offset: (function() {
                if ( typeof customOffset === 'string' ) {
                    return customOffset;
                } else {
                    return '70%';
                }
            })(),
            handler: function(direction) {
                if ( direction === 'down' ) {
                    anime.fadeIn();
                };
                this.destroy();
            }
        });
    });
    $('.iqos-ani-fadeup').each(function() {
        var anime = new iqosAnime($(this));
        var customOffset = $(this).attr('data-offset');
        $(this).waypoint({
            offset: (function() {
                if ( typeof customOffset === 'string' ) {
                    return customOffset;
                } else {
                    return '70%';
                }
            })(),
            handler: function(direction) {
                if ( direction === 'down' ) {
                    anime.fadeUp();
                };
                this.destroy();
            }
        });
    });
    $('.iqos-ani-fadeltr').each(function() {
        var anime = new iqosAnime($(this));
        var customOffset = $(this).attr('data-offset');
        $(this).waypoint({
            offset: (function() {
                if ( typeof customOffset === 'string' ) {
                    return customOffset;
                } else {
                    return '70%';
                }
            })(),
            handler: function(direction) {
                if ( direction === 'down' ) {
                    anime.fadeLeftToRight();
                };
                this.destroy();
            }
        });
    });
    $('.iqos-ani-fadertl').each(function() {
        var anime = new iqosAnime($(this));
        var customOffset = $(this).attr('data-offset');
        $(this).waypoint({
            offset: (function() {
                if ( typeof customOffset === 'string' ) {
                    return customOffset;
                } else {
                    return '70%';
                }
            })(),
            handler: function(direction) {
                if ( direction === 'down' ) {
                    anime.fadeRightToLeft();
                };
                this.destroy();
            }
        });
    });
    $('.iqos-ani-bgltr').each(function() {
        var anime = new iqosAnime($(this));
        var customOffset = $(this).attr('data-offset');
        $(this).waypoint({
            offset: (function() {
                if ( typeof customOffset === 'string' ) {
                    return customOffset;
                } else {
                    return '70%';
                }
            })(),
            handler: function(direction) {
                if ( direction === 'down' ) {
                    anime.bgLeftToRight();
                };
                this.destroy();
            }
        });
    });
});