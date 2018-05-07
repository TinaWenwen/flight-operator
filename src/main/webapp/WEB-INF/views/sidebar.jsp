<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    function change(path) {
        $('#main').attr('src', path);
        $('#am-offcanvas').removeClass('am-active');
        $('.am-offcanvas-bar').removeClass('am-offcanvas-bar-active');
        $('.am-offcanvas-bar').removeClass('am-offcanvas-bar-overlay');
    }
</script>
<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar">
        <ul class="am-list admin-sidebar-list">
            <li><a href="javascript:void(0)" onclick="change('product/list')"><span class="am-icon-table"></span> 产品管理</a></li>
            <li><a href="javascript:void(0)" onclick="change('package/list')"><span class="am-icon-gift"></span> 套餐管理</a></li>
            <li class="admin-parent">
                <a class="am-cf" data-am-collapse="{target: '#collapse-nav'}"><span class="am-icon-edit"></span> 活动管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                <ul class="am-list admin-sidebar-sub am-collapse" id="collapse-nav" style="">
                    <li><a href="javascript:void(0)" onclick="change('activity/list')" class="am-cf">活动列表</a></li>
                    <li><a href="javascript:void(0)" onclick="change('activity/data/list')" class="am-cf">活动数据</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>
