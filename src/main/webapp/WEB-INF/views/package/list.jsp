<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<jsp:include page="./../head.jsp"></jsp:include>
<div class="admin-content">
    <div class="admin-content-body">
        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"><a href="main">首页</a></strong> /
                <small>套餐列表</small>
            </div>
        </div>
        <hr class="am-hr">
        <form class="am-form am-form-inline searchForm" role="form" id="form1" action="package/list" method="get">
            <div class="am-g">
                <div class="am-u-sm-12 am-scrollable-horizontal" style="margin-top: 20px;">
                    <table class="am-table am-table-bordered am-table-striped">
                        <thead>
                        <tr>
                            <th width="3%">ID</th>
                            <th>礼包名称</th>
                            <th>礼包标识</th>
                            <th>价格详情</th>
                            <th>生效日期</th>
                            <th>失效日期</th>
                            <th>是否提供发票</th>
                            <th width="6%">状态</th>
                            <th width="7%">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.name}</td>
                                <td>${item.code}</td>
                                <td>${item.detail}</td>
                                <td>${item.startDate}</td>
                                <td>${item.endDate}</td>
                                <td>${item.type == 1 ? "是" : "否"}</td>
                                <td>${item.status == 1 ? "生效" : "失效"}</td>
                                <td>
                                    <button class="am-btn am-btn-default am-btn-xs" onclick="toUpdate(${item.id})"><span
                                            class="am-icon-pencil-square-o"> 修改</span></button>
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
        window.location.href = "package/update/" + id;
        window.event.returnValue = false;
    }

    $(function () {
        // 初始化分页组件
        $.fn.paginator.init($('#form1'));
    });
</script>
</html>
