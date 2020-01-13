$(document).ready(function() {
    if ($('.search').hasClass('animation-on')) {
        $(".search").removeClass('animation-on');
    }

    $(".search-input").on('focus', function () {
        $(".search").addClass('active');
    });
    
    $(".search-input").on('blur', function () {
        if($(this).val().length == 0) {
            $(".search").removeClass('active');
        }
    });

    $('.submit-button').click(function() {
        setTimeout(function () { $('.submit-button').prop('disabled', true); }, 0);
        $('.search').addClass(' animation-on');  
    });
});