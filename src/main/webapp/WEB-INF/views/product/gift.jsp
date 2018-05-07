<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<jsp:include page="./../head.jsp"></jsp:include>

<div class="admin-content">
    <div class="admin-content-body">

        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"><a href="main">首页</a></strong> /
                <small>礼包配置</small>
            </div>
        </div>
        <hr class="am-hr">

        <div class="am-tabs am-margin" data-am-tabs>
            <ul class="am-tabs-nav am-nav am-nav-tabs">
                <li><a href="product/update/${gift.id}" onclick="tabActive(this)">产品配置</a></li>
                <li><a href="product/tag/update/${gift.id}" onclick="tabActive(this)">标签配置</a></li>
                <li class="am-active"><a href="product/gift/update/${gift.id}" onclick="tabActive(this)">礼包配置</a>
                </li>
            </ul>

            <div class="am-form-content">
                <form id="form1" class="am-form am-form-horizontal" action="product/gift/update" method="post"
                      style="margin-top: 20px;">
                    <input type="hidden" name="id" value="${gift.id}">
                    <div class="am-form-group  am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">产品名称</label>
                        <div class="am-u-sm-9">
                            <input class="am-form-field" name="proName" value="${gift.proName}" disabled
                                   style="background-color: #fff;"/>
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">订单填写页礼包标签</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="ptag" value="${gift.ptag}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">礼包标识</label>
                        <div class="am-u-sm-9">
                            <input type="text" id="pcode" name="pcode" value="${gift.pcode}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">礼包类型</label>
                        <div class="am-u-sm-9">
                            <select id="ptype" name="ptype">
                                <option value=""  ${empty gift.ptype ? "selected" : ""}>请选择</option>
                                <option value="0" ${gift.ptype == '0' ? "selected" : ""}>优惠券礼包</option>
                                <option value="1" ${gift.ptype == '1' ? "selected" : ""}>高铁礼包</option>
                                <option value="2" ${gift.ptype == '2' ? "selected" : ""}>套餐礼包</option>
                            </select>
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">礼包份数</label>
                        <div class="am-u-sm-9">
                            <input type="number" min="1" id="pcount" name="pcount" value="${gift.pcount}">
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">返现类型</label>
                        <div class="am-u-sm-9">
                            <input type="radio" name="pfxtype" value="" ${empty gift.pfxtype ? "checked" : ""}>
                            无返现
                            <input type="radio" name="pfxtype" value="0" ${gift.pfxtype == '0' ? "checked" : ""}>
                            可提现余额
                            <input type="radio" name="pfxtype" value="1" ${gift.pfxtype == '1' ? "checked" : ""}>
                            不可提现余额
                            <input type="radio" name="pfxtype" value="2" ${gift.pfxtype == '2' ? "checked" : ""}>
                            返积分
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">返现金额</label>
                        <div class="am-u-sm-9">
                            <input type="number" placeholder="如果有返现，必填" id="pprice" name="pprice"
                                   value="${gift.pprice >= 0 ? '' : gift.pprice}">
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
    function checkPcode() {
        $('#ptype').removeAttr('required');
        $('#pcount').removeAttr('required');

        if ($('#pcode').val() != '') {
            $('#ptype').attr('required', true);
            $('#pcount').attr('required', true);
        }
    }

    function checkPfxtype() {
        $('#pprice').removeAttr('disabled');
        $('#pprice').removeAttr('required');
        var pfxtype = $('input[type="radio"][name="pfxtype"]:checked').val();
        if (pfxtype == '') {
            $('#pprice').attr('disabled', true);
            $('#pprice').val('');
        } else {
            if ($('#pcode').val() != '') {
                $('#pprice').attr('required', true);
            }
        }
    }

    function submit() {
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

    $().ready(function () {
        checkPcode();
        checkPfxtype();

        $('input[type="radio"][name="pfxtype"]').change(function () {
            checkPfxtype();
        });

        $('#pcode').bind('input propertychange', function () {
            checkPcode();
        });

        $("#form1").validate({
            submitHandler: function (form) {
                if ($('#pcode').val() == '') {
                    layer.confirm('礼包标识为空则为无效数据确定保存?', {icon: 3, title: '提示'}, function (index) {
                        layer.close(index);
                        submit();
                        setTimeout(function () {
                            window.location.reload();
                        }, 1500);

                    });
                } else {
                    submit();
                }
            }
        });
    });
</script>
</html>
