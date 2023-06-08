/*
 * File       : common.js
 * Author     : m-sync (baeyoungseop)
 *  
 * SUMMARY:
 *  1) 헤더, 푸터 컴포넌트화
 *  2) 관리자 메뉴 (관리자정보, 로그아웃) 토글
 */

$(document).ready(function() {

    // 1) LNB 메뉴 배경 및 선택 토글 
    $('.side_menu_wrap .menu_title li').on({
        click:function(){
            
            $(this).parents('.side_menu_wrap').find('.menu_title li').removeClass('on');
            $(this).addClass('on').siblings().removeClass('on');
        }
    })
    
    $('.option_list .hidden_option li').eq(0).addClass('blue');



    // 2) 페이징 현재 페이지 표시 
    $('.page_num .page').on({
        click:function(){
            $(this).addClass('on').siblings().removeClass('on');
        }
    }).eq(0).click();
    

    // 3) LIST 페이지 체크박스 전체 체크 
    jsCheckAll("#searchForm");

    // 4) 사진첨부 파일선택 텍스트 입력

    /*var fileTarget = $ ('.upload-hidden');

    fileTarget.on({
        change:function(){
            if(window.FileReader){
                var filename = $(this)[0].files[0].name;
            }else {
                var filename = $(this).val().split('/').pop().split('\\').pop();
            }

            $(this).siblings('.upload-name').val(filename);
        }
    })*/

    // 5) LIST 메뉴 오름차순, 내림차순 클래스 부여
    $('.grid_wrap th.arrange').on({
        click:function(){
            $(this).addClass('btnOn').siblings().removeClass('btnOn');
            $(this).on({
                click:function(){
                    $(this).toggleClass('btnOnTop');
                    e.stopPropagation();
                    }
                })
            }
    }).eq(1).click();


    // 6) 공통 - 팝업 창 closing
    $('.close_btn, .close').on({
        click:function(){
            $(this).parents('.modal').hide();
        }
    });

    $('.common_image_close_btn').on({
        click:function(){
            $(this).parents('.modal').hide();
            $(".pdt_big_image img").attr('src','');
        }
    });

    // 7) 색상 추가 페이지 팝업
    $('.addColor').on({
        click:function(e){
            e.preventDefault();
            $('.color_setting').show();
        }
    })
    // 7-1) 팝업 페이지 팝업 내 리스트 선택 > 클래스 추가 
    $('.color_list, .item_list').on({
        click:function(){
            $(this).toggleClass('on');
        }
    })
        
    
    // 8) 색상 추가 페이지 이미지 클릭 팝업 
    $('.file_thumb').on({
        click:function(e){
            e.preventDefault();
            $('.product_image').show();
        }
    })

    //10) 로그 페이지 조회 버튼 조회 내용 팝업
    $('.inquiry_btn').on({
        click:function(e){
            e.preventDefault(e);
            $('.log_popup').show();
        }
    })

    
});

var jsCheckAll = function (formId) {
    $(formId).find('#checkAll').on({
        click:function(){
            if ($(formId).find('#checkAll').is(":checked")){
                $(formId).find("input[type=checkbox]").prop("checked",true);
            }else{
                $(formId).find("input[type=checkbox]").prop("checked",false);
            }
        }
    })
}

// 공백 제거
function spaceDel(obj){
    var oper_week_time = obj.value.replace(/ /gi, '');
    obj.value = oper_week_time;
}


