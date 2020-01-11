$(document).ready(function() {
    $(".search-input").on('focus', function () {
        $(".search-input-wrapper").addClass('active');
    });
    
    $(".search-input").on('blur', function () {
        if($(this).val().length == 0) {
            $(".search-input-wrapper").removeClass('active');
        }
    });
});