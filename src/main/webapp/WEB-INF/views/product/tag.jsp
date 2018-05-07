<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<jsp:include page="./../head.jsp"></jsp:include>

<div class="admin-content">
    <div class="admin-content-body">

        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"><a href="main">首页</a></strong> /
                <small>标签配置</small>
            </div>
        </div>
        <hr class="am-hr">

        <div class="am-tabs am-margin" data-am-tabs>
            <ul class="am-tabs-nav am-nav am-nav-tabs">
                <li><a href="product/update/${tag.id}" onclick="tabActive(this)">产品配置</a></li>
                <li class="am-active"><a href="product/tag/update/${tag.id}" onclick="tabActive(this)">标签配置</a></li>
                <li><a href="product/gift/update/${tag.id}" onclick="tabActive(this)">礼包配置</a></li>
            </ul>

            <div class="am-form-content">
                <form id="form1" class="am-form am-form-horizontal" action="product/tag/update" method="post"
                      style="margin-top: 20px;">
                    <input type="hidden" name="id" value="${tag.id}">

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">产品名称</label>
                        <div class="am-u-sm-9">
                            <input class="am-form-field" name="proName" value="${tag.proName}" disabled
                                   style="background-color: #fff;"/>
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">标签名称</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="tagName" value="${tag.tagName}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">标签颜色</label>
                        <div class="am-u-sm-9">
                            <select name="tagColor">
                                <option value="19,142,234,1" ${tag.tagColor.equals("19,142,234,1") ? "selected" : ""}>蓝色
                                </option>
                                <option value="62,158,21,1" ${tag.tagColor.equals("62,158,21,1") ? "selected" : ""}>绿色
                                </option>
                                <option value="226,58,19,1" ${tag.tagColor.equals("226,58,19,1") ? "selected" : ""}>红色
                                </option>
                                <option value="255,114,0,1" ${tag.tagColor.equals("255,114,0,1") ? "selected" : ""}>橙色
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">报销凭证</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="bx" value="${tag.bx}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">返现说明</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="fx" value="${tag.fx}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">预定限制</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="tj" value="${tag.tj}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">服务说明</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="fw" value="${tag.fw}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">活动说明</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="hd" value="${tag.hd}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">礼包说明</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="lb" value="${tag.lb}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">其他说明</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="qt" value="${tag.qt}">
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

