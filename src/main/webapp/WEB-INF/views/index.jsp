<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js fixed-layout">
<jsp:include page="head.jsp"></jsp:include>
<body>
<!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，Amaze UI 暂不支持。 请 <a href="http://browsehappy.com/" target="_blank">升级浏览器</a>以获得更好的体验！
</p>
<![endif]-->

<jsp:include page="header.jsp"></jsp:include>

<div class="am-cf admin-main">
    <!-- sidebar start -->
    <jsp:include page="sidebar.jsp"></jsp:include>
    <!-- sidebar end -->

    <!-- content start -->
    <div class="admin-content">
        <iframe id="main" src="main" scrolling="y" style="height: 100%;" frameborder="0" border="0" marginwidth="0"
                marginheight="0"></iframe>

        <jsp:include page="footer.jsp"></jsp:include>
    </div>
    <!-- content end -->
</div>

<a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu"
   data-am-offcanvas="{target: '#admin-offcanvas'}"></a>

<jsp:include page="script.jsp"></jsp:include>
<script>
    $(document).ready(function () {
        resetWidth();
    });

    $(window).resize(function () {
        resetWidth();
    });

    function resetWidth() {
        var width = $(".admin-content").width();
        if (width < 1210) width = 1210;
        $("#main").width(width);
    }
</script>
</body>
</html>

