<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<jsp:include page="./../head.jsp"></jsp:include>
<body>
<div class="admin-content">
    <div class="admin-content-body">
        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"><a href="main">首页</a></strong> /
                <small>产品列表</small>
            </div>
        </div>
        <hr class="am-hr">
        <form class="am-form am-form-inline searchForm" role="form" id="form1" action="product/list" method="get">
            <div class="am-g">
                <div class="am-u-sm-12 am-scrollable-horizontal">

                    <div class="am-form-group am-input-group-sm">
                        <input class="am-form-field" type="text" placeholder="航司" name="airLine"
                               value="${param.airLine}">
                    </div>
                    <div class="am-form-group am-input-group-sm">
                        <input class="am-form-field" type="text" placeholder="数据源" name="dataSrc"
                               value="${param.dataSrc}">
                    </div>
                    <div class="am-form-group am-input-group-sm">
                        <input class="am-form-field" type="text" placeholder="预定渠道" name="bookSrc"
                               value="${param.bookSrc}">
                    </div>
                    <div class="am-form-group">
                        <select name="status" style="width: 75px; height: 33px; font-size: 1.4rem;">
                            <option value="2" ${param.status == 2 ? "selected" : ""}> 全部</option>
                            <option value="1" ${param.status == 1 ? "selected" : ""}> 上架</option>
                            <option value="0" ${param.status == 0 ? "selected" : ""}> 下架</option>
                        </select>
                    </div>

                    <button type="button" class="am-btn am-btn-default am-btn-sm" id="queryBtn"><span
                            class="am-icon-search"></span> 查询
                    </button>
                    <button type="button" class="am-btn am-btn-default am-btn-sm" id="insertBtn"><span
                            class="am-icon-plus"></span> 新建
                    </button>

                </div>
                <input type="hidden" id="sort" name="sort" value="${param.sort}">
            </div>

            <div class="am-g">
                <div class="am-u-sm-12 am-scrollable-horizontal" style="margin-top: 20px;">

                    <table class="am-table am-table-bordered am-table-striped">
                        <thead>
                        <tr>
                            <th width="3%"><a href="javascript:void(0)" id="queryDesc">ID</a></th>
                            <th width="5%">产品名称</th>
                            <th width="5%">航司</th>
                            <th width="5%">价格标签</th>
                            <th width="4%">标签颜色</th>
                            <th width="5%">可见用户</th>
                            <th width="3%">加减价</th>
                            <th width="3%">返现</th>
                            <th width="4%">适用航程</th>
                            <th width="4%">APP平台</th>
                            <th width="3%">状态</th>
                            <th width="7%">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td>${item.id}</td>
                                <td title="${item.proName}">${item.proName}</td>
                                <td title="${item.airLine}">${item.airLine}</td>
                                <td title="${item.tagName}">${item.tagName}</td>
                                <td>${item.tagColor}</td>
                                <td title="${item.exUser}">${item.exUser}</td>
                                <td>${item.subCount == 0 ? "无" : i.subCount}</td>
                                <td>${item.fxCount == 0 ? "无" : i.fxCount}</td>
                                <td>${item.tripType}</td>
                                <td>${item.appType}</td>
                                <td><span
                                        style="color: ${item.status == 1 ? "#0e90d2" : "green"}">${item.status == 1 ? "已上架" : "已下架"}</span>
                                </td>
                                <td>
                                    <button class="am-btn am-btn-default am-btn-xs" onclick="toUpdate(${item.id})"><span
                                            class="am-icon-pencil-square-o"> 修改</span></button>
                                    <button class="am-btn am-btn-default am-btn-xs"
                                            onclick="updateStatus(${item.id}, ${item.status})"><span
                                            class="am-icon-sort">${item.status == 1 ? " 下架" : " 上架"}</span>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <!-- page begin -->
                    <input type="hidden" id="pageNum" name="pageNumber" value="${page.pageNum}">
                    <input type="hidden" id="pages" value="${page.pages}">
                    <!-- page end -->
                </div>
            </div>
        </form>
        <div class="am-page">
            <div id="page" class="am-page-paging"></div>
            <div class="am-page-pagenum"><strong>共 ${page.total} 条记录 </strong></div>
        </div>
    </div>

</div>
</body>
<jsp:include page="./../script.jsp"></jsp:include>
<script>
    function toUpdate(id) {
        window.location.href = "product/update/" + id;
        window.event.returnValue = false;
    }

    function updateStatus(id, status) {
        var action = '上架';
        if (status == 1) action = '下架';
        layer.confirm('确定' + action + '?', {icon: 3, title: '提示'}, function (index) {
            layer.close(index);
            index = layer.load(3, {shade: [0.1]});
            $.post("product/status/update/" + id, {}, function (data) {
                if (data.code == 1) {
                    notify.success('操作成功!');
                    setTimeout(function () {
                        window.location.reload();
                    }, 1500);
                } else {
                    notify.error('操作失败!');
                    layer.close(index);
                }
            });
        });
        window.event.returnValue = false;
    }

    $(document).ready(function () {
        // 初始化分页组件
        $.fn.paginator.init($('#form1'));

        // 绑定事件
        $('#queryBtn').click(function () {
            $('#form1').submit();
        });

        $('#insertBtn').click(function () {
            window.location.href = 'product/insert';
        });

        $('#queryDesc').click(function () {
            var sort = $('#sort').val();
            if (sort == '1') {
                $('#sort').val('0');
            } else {
                $('#sort').val('1');
            }
            $('#form1').submit();
        });
    });
</script>
</html>
