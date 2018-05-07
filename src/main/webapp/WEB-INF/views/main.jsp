<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="head.jsp"></jsp:include>
<body>
<div>
    <div style="padding-left: 30px; padding-top: 20px;">
        <label>亲爱的管理员，欢迎使用国内机票产品货架管理系统！</label>
    </div>
    <div id="bgDiv">
        <img style="float: right" src="assets/i/banner-bg.png">
    </div>
</div>
<jsp:include page="script.jsp"></jsp:include>
<script>
    $(document).ready(function () {
        resetBg();
    });

    $(window).resize(function () {
        resetBg();
    });

    function resetBg() {
        var height = $("body").height();
        $("#bgDiv").css("padding-top", height - 400);
    }
</script>
</body>
</html>
