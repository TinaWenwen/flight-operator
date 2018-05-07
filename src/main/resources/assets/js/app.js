(function ($) {
    'use strict';

    $(function () {
        $('.am-icon-btn').on('click', function() {
            $('#admin-offcanvas').removeClass('am-active');
        });
    });
})(jQuery);

// tab页面切换跳转
function tabActive(o) {
    window.location.href = $(o).attr("href");
}
