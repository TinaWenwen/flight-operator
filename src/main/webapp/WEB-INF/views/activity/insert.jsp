<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<jsp:include page="./../head.jsp"></jsp:include>

<div class="admin-content">
    <div class="admin-content-body">

        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"><a href="main">首页</a></strong> /
                <small>${action == "insert" ? "新建":"修改"}活动</small>
            </div>
        </div>
        <hr class="am-hr">

        <div class="am-form-content">
            <form id="form1" action="activity/${action}" method="post" class="am-form am-form-horizontal">
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
                    <label class="am-u-sm-3 am-form-label">背景颜色</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="backColor" value="${activity.backColor}" required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">头图</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="headerImg" value="${activity.header.img}" required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">航线标题栏背景颜色</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="titleBarBackColor" value="${activity.titleBar.backColor}"
                               required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">航线展示样式</label>
                    <div class="am-u-sm-9">
                        <input type="radio" name="listStyle" value="1" ${activity.listStyle == 1 ? "checked" : ""}>
                        样式1（缩略）
                        <input type="radio" name="listStyle" value="2" ${activity.listStyle == 2 ? "checked" : ""}>
                        样式2（详细）
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">预定按钮颜色</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="bookButtonColor" value="${activity.bookButton.color}"
                               required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">预定按钮文案</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="bookButtonText" value="${activity.bookButton.text}"
                               placeholder="立即预定" required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">查看更多航线按钮颜色</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="showMoreButtonColor" value="${activity.showMoreButton.color}"
                               required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">活动规则标题</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="ruleTitle" placeholder="活动规则" value="${activity.rule.title}"
                               required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">活动规则</label>
                    <div class="am-u-sm-9">
                        <textarea class="" rows="5" id="doc-ta-1" name="rule">${activity.ruleStr}</textarea>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">活动规则背景颜色</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="ruleBackColor" value="${activity.rule.backColor}" required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">活动规则字体颜色</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="ruleFontColor" value="${activity.rule.fontColor}" required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">尾图</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="footerImg" value="${activity.footer.img}" required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">微信分享标题</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="wechatShareTitle" value="${activity.wechatShare.title}"
                               required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">微信分享描述</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="wechatShareDesc" value="${activity.wechatShare.desc}"
                               required/>
                    </div>
                </div>

                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">微信分享图标</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="wechatShareIcon" value="${activity.wechatShare.icon}"
                               required/>
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
<jsp:include page="./../script.jsp"></jsp:include>
<script>
    function deleteEmptyLine(str) {
        var newArr = [];
        var arr = str.split("\n");
        $.each(arr, function (i, n) {
            var val = $.trim(n);
            if (val != '')
                newArr.push(val);
        });
        return newArr;
    }

    $().ready(function () {
        $("#form1").validate({
            submitHandler: function (form) {
                var form1 = $('#form1').serializeJSON();
                var param = {
                    "id": form1.id == undefined ? null : form1.id,
                    "title": form1.title,
                    "dataCode": form1.dataCode,
                    "beginDate": form1.beginDate,
                    "endDate": form1.endDate
                }
                var rules = deleteEmptyLine(form1.rule);
                var style = {
                    "backColor": form1.backColor,
                    "listStyle": form1.listStyle,
                    "header": {
                        "img": form1.headerImg
                    },
                    "titleBar": {
                        "backColor": form1.titleBarBackColor
                    },
                    "bookButton": {
                        "color": form1.bookButtonColor,
                        "text": form1.bookButtonText
                    },
                    "showMoreButton": {
                        "color": form1.showMoreButtonColor
                    },
                    "rule": {
                        "title": form1.ruleTitle,
                        "items": rules,
                        "backColor": form1.ruleBackColor,
                        "fontColor": form1.ruleFontColor
                    },
                    "footer": {
                        "img": form1.footerImg
                    },
                    "wechatShare": {
                        "desc": form1.wechatShareDesc,
                        "icon": form1.wechatShareIcon,
                        "title": form1.wechatShareTitle
                    }
                }
                param.styleStr = JSON.stringify(style);

                var index = layer.load(3, {shade: [0.1]});
                $.post($('#form1').attr("action"), param, function (data) {
                    if (data.code == 1) {
                        notify.success('保存成功！');
                        setTimeout(function () {
                            layer.close(index);
                            if ($('#action').val() == 'insert') {
                                window.location.href = "activity/list";
                            }
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

