(function($){
	$.fn.paginator = {
		init : function(form) {
			var action = form.attr('action');
			var pageNum = $('#pageNum').val();
			var pages = $('#pages').val();

			if (Number(pages) <= 0 || Number(pageNum) <= 0 || Number(pageNum) > Number(pages)) return;

            var $page = $("#page").page({
                pages: pages, //页数
                curr: pageNum, //当前页
                theme: 'default', //主题
                groups: 5, //连续显示分页数
                prev: '< 上一页', //若不显示，设置false即可
                next: '下一页 >', //若不显示，设置false即可
                first: "首页",
                last: "尾页", //false则不显示
                render: function(context, $element, index) {
					if ($($element).text() == '首页' && context.option.curr == 1) {
                        $element.addClass('am-disabled');
                        return $element;
					}
                    if ($($element).text() == '尾页' && context.option.curr == context.option.pages) {
                        $element.addClass('am-disabled');
                        return $element;
                    }
                    return false;
                },
                jump: function(context, first) {
                    if (!first) {
                        $('#pageNum').val(context.option.curr);
                        form.submit();
                    }
                }
            });
		}
	}
})(jQuery);