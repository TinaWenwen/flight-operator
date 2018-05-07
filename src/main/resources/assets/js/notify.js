(function (e) {
    "use strict";
    var option = {
        title: true,
        size: 'mini',
        showClass: 'zoomIn',
        hideClass: 'zoomOut',
        icon: false,
        msg: 'hello world',
        img: null,
        closable: true,
        delay: 1500,
        delayIndicator: true,
        closeOnClick: true,
        width: 300,
        sound: false,
        position: 'top right',
        rounded: false,
        messageHeight: 60,
        pauseDelayOnHover: true,
        onClickUrl: null,
        showAfterPrevious: false,
        continueDelayOnInactiveTab: true
    };

    function run(type, msg, opt) {
        var settings = $.extend({}, option, opt);
        settings.msg = msg;
        Lobibox.notify(type, settings);
    };

    var notify = {
        info(msg, opt) {
            run("info", msg, opt);
        },
        warning(msg, opt) {
            run("warning", msg, opt);
        },
        error(msg, opt) {
            if (opt == undefined) opt = {delay: 3000};
            run("error", msg, opt);
        },
        success(msg, opt) {
            run("success", msg, opt);
        }
    };

    e.notify = notify;
})(window);