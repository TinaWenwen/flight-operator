<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
<jsp:include page="./../head.jsp"></jsp:include>

<div class="admin-content">
    <div class="admin-content-body">

        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"><a href="main">首页</a></strong> /
                <small>产品配置</small>
            </div>
        </div>
        <hr class="am-hr">

        <div class="am-form-content">
            <form id="form1" action="package/update" method="post"
                  class="am-form am-form-horizontal" style="margin-top: 20px;">
                <input type="hidden" name="id" value="${pkg.id}">
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">礼包名称</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="name" value="${pkg.name}" required/>
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">礼包标识</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="code" value="${pkg.code}" required/>
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">礼包组成部分</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="detail" value="<c:out value="${pkg.detail}"></c:out>"
                               required/>
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">生效日期</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="startDate" value="${pkg.startDate}"
                               placeholder="yyyy-MM-dd" data-am-datepicker readonly/>
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">失效日期</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="endDate" value="${pkg.endDate}" placeholder="yyyy-MM-dd"
                               data-am-datepicker readonly/>
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">提供发票</label>
                    <div class="am-u-sm-9">
                        <input type="radio" name="type" value="1" ${pkg.type == 1 ? "checked" : ""}>
                        是
                        <input type="radio" name="type" value="0" ${pkg.type == 0 ? "checked" : ""}>
                        否
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">状态</label>
                    <div class="am-u-sm-9">
                        <input type="radio" name="status" value="1" ${pkg.status == 1 ? "checked" : ""}>
                        生效
                        <input type="radio" name="status" value="0" ${pkg.status == 0 ? "checked" : ""}>
                        失效
                    </div>
                </div>

                <hr>
                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2">
                        <button type="submit" id="submitBtn" class="am-btn am-btn-primary am-btn-xs">保存</button>
                        <button type="button" class="am-btn am-btn-primary am-btn-xs"
                                onclick="javascript:history.go(-1)">返回
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<jsp:include page="./../script.jsp"></jsp:include>
<script>
    $().ready(function () {

        $("#form1").validate({
            submitHandler: function (form) {
                var index = layer.load(3, {shade: [0.1]});
                $.post($('#form1').attr("action"), $('#form1').serialize(), function (data) {
                    if (data.code == 1) {
                        notify.success('保存成功！');
                        setTimeout(function () {
                            layer.close(index);
                        }, 1500);
                    } else {
                        layer.close(index);
                        notify.error('保存失败！');
                    }
                });
            }
        });
    });
</script>
</html>


