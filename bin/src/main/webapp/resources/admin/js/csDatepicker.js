/*
 * File       : csDatepicker.js
 * Author     : m-sync (baeyoungseop)
 */

$(document).ready(function(){
    
    // 1) date picker
    var pickerOption = {
        language: 'ko',
        todayButton: new Date(),
        position: 'top left',
        dateFormat: 'yyyy-M-dd',
        autoClose: true,
    }

    $('.picker').each(function() {
        var _this = $(this);
        _this.datepicker(pickerOption);
    });

    $('.end .picker').each(function(i){
        $(this).data('datepicker').update({
            position: 'top right',
            onSelect: function(fd, date) {
                var startDate = $('.start .picker').eq(i).val();
                var endDate = $('.end .picker').eq(i).val();

                if (parseInt(startDate.replace("-","").replace("-","").replace(":","").replace(" ","")) - parseInt(endDate.replace("-","").replace("-","").replace(":","").replace(" ","")) > 0) {
                    // 종료일 적용시 시작일보다 과거일 때 시작일 = 종료일 수정
                    $('.start .picker').eq(i).val(endDate);
                }
            }
        })
    })

});

// date picker language set
;(function ($) { $.fn.datepicker.language['ko'] = {
    days: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
    daysShort: [ '일', '월', '화', '수', '목', '금', '토'],
    daysMin: ['일', '월', '화', '수', '목', '금', '토'],
    months: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
    monthsShort: ['01','02','03','04','05','06', '07','08','09','10','11','12'],
    today: '오늘',
    clear: '초기화',
    dateFormat: 'mm/dd/yyyy',
    timeFormat: 'hh:mm',
    firstDay: 0
}; })(jQuery);
