<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<body>
<jsp:include page="./../head.jsp"></jsp:include>
<div class="admin-content">
    <div class="admin-content-body">
        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"><a href="main">首页</a></strong> /
                <small>活动列表</small>
            </div>
        </div>
        <hr class="am-hr">
        <form class="am-form am-form-inline searchForm" role="form" id="form1" action="activity/list" method="get">
            <div class="am-g">
                <div class="am-u-sm-12 am-scrollable-horizontal">
                    <div class="am-form-group am-input-group-sm">
                        <input class="am-form-field" type="text" placeholder="活动名称" name="title"
                               value="${param.title}">
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
            </div>

            <div class="am-g">
                <div class="am-u-sm-12 am-scrollable-horizontal" style="margin-top: 20px;">
                    <table class="am-table am-table-bordered am-table-striped">
                        <thead>
                        <tr>
                            <th width="3%">ID</th>
                            <th>活动名称</th>
                            <th width="10%">数据标识</th>
                            <th width="14%">创建时间</th>
                            <th width="14%">生效日期</th>
                            <th width="14%">失效日期</th>
                            <th width="8%">状态</th>
                            <th width="19%">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.title}</td>
                                <td>${item.dataCode}</td>
                                <td><fmt:formatDate type="both" dateStyle="medium" timeStyle="medium"
                                                    value="${item.createTime}"/></td>
                                <td><fmt:formatDate type="date" value="${item.beginTime}"/></td>
                                <td><fmt:formatDate type="date" value="${item.endTime}"/></td>
                                <td><span
                                        style="color: ${item.status == 1 ? "#0e90d2" : "green"}">${item.status == 1 ? "已上架" : "已下架"}</span>
                                </td>
                                <td>
                                    <button class="am-btn am-btn-default am-btn-xs"
                                            onclick="preview('${item.previewUrl}')"><span
                                            class="am-icon-envira"> 预览</span>
                                    </button>
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
        window.location.href = "activity/update/" + id;
        window.event.returnValue = false;
    }

    function preview(url) {
        window.open(url, '', 'width=375,height=812,top=220,left=1000');
        window.event.returnValue = false;
    }

    function updateStatus(id, status) {
        var action = '上架';
        if (status == 1) action = '下架';
        layer.confirm('确定' + action + '?', {icon: 3, title: '提示'}, function (index) {
            layer.close(index);
            index = layer.load(3, {shade: [0.1]});
            $.post("activity/status/update/" + id, {}, function (data) {
                if (data.code == 1) {
                    notify.success('操作成功!');
                    setTimeout(function () {
                        window.location.reload();
                    }, 1500);
                } else {
                    notify.error('操作失败，' + data.msg + '!');
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
            window.location.href = 'activity/insert';
        });
    });
</script>
</html>
