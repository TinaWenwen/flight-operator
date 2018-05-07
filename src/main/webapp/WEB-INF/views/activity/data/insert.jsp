<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<jsp:include page="../../head.jsp"></jsp:include>

<div class="admin-content">
    <div class="admin-content-body">

        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"><a href="main">首页</a></strong> /
                <small>${action == "insert" ? "新建":"修改"}数据</small>
            </div>
        </div>
        <hr class="am-hr">

        <div class="am-form-content">
            <form id="form1" action="activity/data/${action}" method="post" class="am-form am-form-horizontal">
                <input type="hidden" name="id" value="${activity.id}">
                <input type="hidden" id="action" value="${action}">

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">活动名称</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="title" value="${activity.title}" required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">数据标识</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="dataCode" value="${activity.dataCode}" required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">数据Json</label>
                    <div class="am-u-sm-9">
                        <textarea class="" rows="15" id="doc-ta-1" name="dataStr"
                                  placeholder='{"org": "TSN","dst": "WUH","orgcn": "天津","dstcn": "武汉","date": "2018-04-23","rdate": "","period": "","fn": "CZ3167","saleprice": 0,"notaxprice": 515},'
                                  required>${activity.dataStr}</textarea>
                        <div id="alertDiv" class="am-alert am-alert-secondary" data-am-alert style="display: none">
                            <pre id="alertContent"></pre>
                        </div>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">生效日期</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="beginDate" value="${activity.beginDate}"
                               placeholder="yyyy-MM-dd" data-am-datepicker readonly required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">失效日期</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="endDate" value="${activity.endDate}" placeholder="yyyy-MM-dd"
                               data-am-datepicker readonly required/>
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
<jsp:include page="../../script.jsp"></jsp:include>
<script>
    $().ready(function () {
        $("#form1").validate({
            submitHandler: function (form) {
                var form1 = $('#form1').serializeJSON();
                var param = {
                    "id": form1.id == undefined ? null : form1.id,
                    "title": form1.title,
                    "dataCode": form1.dataCode,
                    "beginDate": form1.beginDate,
                    "endDate": form1.endDate,
                }
                var flightStr = form1.dataStr;// 后续加上数据验证
                flightStr = flightStr.substring(0, flightStr.length - 1);
                flightStr = "[" + flightStr + "]";
                try {
                    $('#alertDiv').css('display', 'none');
                    jsonlint.parse(flightStr);
                }
                catch (err) {
                    $('#alertDiv').css('display', 'block');
                    $('#alertContent').html(err.message);
                    notify.error('数据Json格式有误！');
                    return;
                }
                param.flightStr = flightStr;
                var index = layer.load(3, {shade: [0.1]});
                $.post($('#form1').attr("action"), param, function (data) {
                    if (data.code == 1) {
                        notify.success('保存成功！');
                        setTimeout(function () {
                            layer.close(index);
                            if ($('#action').val() == 'insert') {
                                window.location.href = "activity/data/list";
                            }
                        }, 1500);
                    } else {
                        layer.close(index);
                        notify.error('保存失败，' + data.msg + '!');
                    }
                });
            }
        });
    });
</script>
</html>

