/*window.onload=function () {
        $(".date_box").click(function () {
            $(".date_list").toggleClass("date_list_display");
        });
        $(".date_list > li").click(function () {
            var data = $(this).text();
            $(".selected_years").text(data);
        });
        $(".btnHomeYearsOk").click(function () {
            $select = $(".selected_years").text();
            $num = Number($select);
            if ($select == "출생년도 선택*") {
                alert("연도를 선택하세요.")
            }
            if ($num <= 2002) {
                initFunc();
                $("#ageModal").css("display", "none");
            }
            if ($num >= 2002) {
                $(".age_low_modal").css("display", "block");

            }
        });
}*/
$(document).ready(function(){
    $(document).on("click", ".date_box", function(){
        $(".date_list").toggleClass("date_list_display");
    });

    $(document).on("click", ".date_list > li", function(){
        var data = $(this).text();
        $(".selected_years").text(data);
    });

    $(document).on("click", ".btnHomeYearsOk", function(){
        $select = $(".selected_years").text();
        $num = Number($select);
        if ($select == "출생년도 선택*") {
            alert("연도를 선택하세요.")
        }
        if ($num <= 2002) {
            initFunc();
            $("#ageModal").css("display", "none");
        }
        if ($num >= 2002) {
            $(".age_low_modal").css("display", "block");

        }
    });
});
    /*require(['jquery','mage/url','jquery/jquery.cookie'],function($,urlBuider){
        var currentDate = new Date();
        var currentYear = currentDate.getFullYear();
        var html = '<option value="">출생년도 선택*</option>';
        var i = currentYear;

        for (i = currentYear; i > currentYear - 100;i--) {
            html += '<option value="' + i + '">' + i + '</option>';
        }
        $('#sav-validation-form #age').html(html);
        $('#sav-validation-form #age').trigger('contentUpdated');

        $('#sav-validation-form').on('submit',function(e){
            e.preventDefault();
            var age_value = $('#sav-validation-form #age').val();
            var age = parseInt(currentYear) - parseInt(age_value);
            if (age < 19) {
                $('#age-fail').show();
            } else {
                $.cookie('sav',1);
                $('#ageModal').hide();
            }
        });
    });*/
