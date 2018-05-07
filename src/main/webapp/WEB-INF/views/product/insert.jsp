<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<jsp:include page="./../head.jsp"></jsp:include>

<div class="admin-content">
    <div class="admin-content-body">

        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"><a href="main">首页</a></strong> /
                <small>新建产品</small>
            </div>
        </div>
        <hr class="am-hr">

        <div class="am-form-content">
            <form id="form1" action="product/insert" method="post" class="am-form am-form-horizontal">
                <%--基本信息begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">产品名称</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="proName" required/>
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">数据源</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="dataSrc" required/>
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">预定渠道</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="bookSrc" required/>
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">航司代码</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="airLine" placeholder="航司代码必填，二字码，多个以/分隔，如CZ，MU/FM" required/>
                    </div>
                </div>
                <%--基本信息end--%>

                <%--舱位运价匹配方式begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">舱位运价匹配方式</label>
                    <div class="am-u-sm-9">
                        <input type="radio" name="priceFlag" value="1" checked> 按政策id匹配
                        <input type="radio" name="priceFlag" value="0"> 按舱位匹配
                        <input type="radio" name="priceFlag" value="2"> 按产品代码
                        <input type="radio" name="priceFlag" value="3"> 按渠道匹配
                        <input type="radio" name="priceFlag" value="4"> 全渠道匹配
                        <input class="am-form-field" style="margin-top: 8px;" id="proCode" name="proCode"
                               placeholder="必填，政策id，多个以逗号分隔，支持通配符，如*和131*，132*，133*，13400,1340">
                    </div>
                </div>
                <%--舱位运价匹配方式end--%>

                <%--是否返现begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">返现</label>
                    <div class="am-u-sm-9">
                        <input type="radio" id="doReturn" name="fxFlag" value="1" checked> 是
                        <input type="radio" id="notReturn" name="fxFlag" value="0"> 否
                        <select name="fxisFixed" style="margin-top: 8px;">
                            <option value="1" selected>固定金额</option>
                            <option value="0">比例</option>
                        </select>
                        <input class="am-form-field fxCount" style="margin-top: 8px;" name="fxCount" placeholder="返现金额"
                               required/>
                    </div>
                </div>
                <%--是否返现end--%>

                <%--加减价begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">加减价</label>
                    <div class="am-u-sm-9">
                        <input type="radio" id="doChange" name="isPriceChange" value="1" checked> 是
                        <input type="radio" id="notChange" name="isPriceChange" value="0"> 否
                        <br>
                        <input type="radio" id="addPrice" name="changePrice" value="1" checked> 加价
                        <input type="radio" id="subPrice" name="changePrice" value="0"> 直减

                        <select name="subisFixed" style="margin-top: 8px;">
                            <option value="1" selected>固定金额</option>
                            <option value="0">比例</option>
                        </select>
                        <input class="am-form-field subCount" style="margin-top: 8px;" name="subCount" placeholder="金额"
                               required/>
                    </div>
                </div>
                <%--加减价end--%>

                <%--是否添加直减标识begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">直减标识</label>
                    <div class="am-u-sm-9">
                        <input type="radio" name="subFlag" value="1"> 是
                        <input type="radio" name="subFlag" value="0" checked> 否
                    </div>
                </div>
                <%--是否添加直减标识end--%>

                <%--可见限制begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">可见标识</label>
                    <div class="am-u-sm-9">
                        <input type="radio" id="partSee" name="allSee" value="0" checked> 部分用户可见
                        <input type="radio" id="allSee" name="allSee" value="1"> 全部用户可见
                        <input class="am-form-field userInfo" style="margin-top: 8px;" name="userInfo"
                               placeholder="可见用户tag"/>
                    </div>
                </div>
                <%--可见限制end--%>

                <%--校验 begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">校验标识</label>
                    <div class="am-u-sm-9">
                        <input type="radio" name="ckBuyer" value="1"> 校验购买人
                        <input type="radio" name="ckBuyer" value="0" checked> 校验乘机人
                    </div>
                </div>
                <%--校验 end--%>

                <%--排除用户的属性 begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">排除用户</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="exUser"/>
                    </div>
                </div>
                <%--排除用户的属性 end--%>

                <%--产品优先级 begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">优先级</label>
                    <div class="am-u-sm-9">
                        <select name="priority">
                            <option value="0" selected>0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                        </select>
                    </div>
                </div>
                <%--产品优先级 end--%>

                <%--类型 begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">航程类型</label>
                    <div class="am-u-sm-9">
                        <input type="radio" name="tripType" value="" checked> 无限制
                        <input type="radio" class="tripType" name="tripType" value="OW"> 单程
                        <input type="radio" class="tripType" name="tripType" value="RT"> 往返
                        <input type="radio" class="tripType" name="tripType" value="MP"> 多程
                    </div>
                </div>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">APP类型</label>
                    <div class="am-u-sm-9">
                        <input type="radio" name="appType" value="" checked> 无限制
                        <input type="radio" name="appType" value="gtgj">高铁app
                        <input type="radio" name="appType" value="hbgj"> 航班app
                        <input type="radio" name="appType" value="web"> h5平台
                    </div>
                </div>
                <%--类型 end--%>

                <%--购买限制 begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">购买限制</label>
                    <div class="am-u-sm-9">
                        <input type="radio" id="partBuy" name="allBuy" value="0" checked> 部分乘机人
                        <input type="radio" id="allBuy" name="allBuy" value="1"> 无限制

                        <select name="psnum" class="selectGroup" style="margin-top: 8px;">
                            <option value="0" selected>人数无限制</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                        </select>
                        <select name="gender" class="selectGroup" style="margin-top: 8px;">
                            <option value="0" selected>性别无限制</option>
                            <option value="1">男</option>
                            <option value="2">女</option>
                        </select>
                        <select name="pstype" class="selectGroup" style="margin-top: 8px;">
                            <option value="0" selected>乘机人类型无限制</option>
                            <option value="ADT">成人</option>
                            <option value="CHD">儿童</option>
                            <option value="INF">婴儿</option>
                        </select>
                        <select name="adidtypes" class="selectGroup" style="margin-top: 8px;">
                            <option value="0" selected>辅助证件类别无限制</option>
                            <option value="disabled">残疾类证件限制</option>
                        </select>
                        <select name="ageLimit" id="ageLimit" style="margin-top: 8px;">
                            <option value="1" id="limit_option">年龄段限制</option>
                            <option value="0" id="nolimit_option" selected>年龄段无限制</option>
                        </select>
                        <div style="display: inline-flex; margin-top: 8px;">
                            <input type="text" name="minAge" class="ageInput" style="width: 318px" placeholder="岁以上"/>
                            <input type="text" name="maxAge" class="ageInput" style="width: 317px; margin-left: 3px;"
                                   placeholder="岁以下"/>
                        </div>
                        <select name="cardLimit" class="cardLimit" selectGroup style="margin-top: 8px;">
                            <option value="1">证件类型限制</option>
                            <option value="0" selected>证件类型无限制</option>
                        </select>
                        <label class="am-checkbox-inline cardCheckbox">
                            <input class="cardCheckbox" name="idtype" type="checkbox" value="0"> 身份证
                        </label>
                        <label class="am-checkbox-inline cardCheckbox">
                            <input class="cardCheckbox" name="idtype" type="checkbox" value="1"> 护照
                        </label>
                        <label class="am-checkbox-inline cardCheckbox">
                            <input class="cardCheckbox" name="idtype" type="checkbox" value="2"> 户口本
                        </label>
                        <label class="am-checkbox-inline cardCheckbox">
                            <input class="cardCheckbox" name="idtype" type="checkbox" value="3"> 其他
                        </label>
                    </div>
                </div>
                <%--购买限制 end--%>

                <%--特殊预定参数begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">特殊预定参数</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="bookParam" placeholder="若出票组有要求，则找他们提供"/>
                    </div>
                </div>
                <%--特殊预定参数end--%>

                <%-- 客规ID begin--%>
                <div class="am-form-group am-form-group-sm">
                    <label class="am-u-sm-3 am-form-label">客规ID</label>
                    <div class="am-u-sm-9">
                        <input class="am-form-field" name="ruleId"/>
                    </div>
                </div>
                <%-- 客规ID end--%>

                <hr>
                <div class="am-form-group">
                    <div class="am-u-sm-10 am-u-sm-offset-2">
                        <button type="submit" id="submitBtn" class="am-btn am-btn-primary am-btn-xs">保存</button>
                        <button type="button" class="am-btn am-btn-primary am-btn-xs"
                                onclick="javascript:history.go(-1)">上一步
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
        //控制运价方式单选框输入限制
        $('input[type="radio"][name="priceFlag"]').change(function () {
            $('#proCode').removeAttr('disabled');
            var priceFlag = $('input[type="radio"][name="priceFlag"]:checked').val();
            if (priceFlag == 0) {
                $('#proCode').attr('placeholder', '必填，舱位代码，多个以逗号分隔，数据保存格式cabin:S,T,W,H,Q,U,V,Y');
            } else if (priceFlag == 1) {
                $('#proCode').attr('placeholder', '必填，政策id，多个以逗号分隔，支持通配符，如*和131*，132*，133*，13400,1340');
            } else if (priceFlag == 2) {
                $('#proCode').attr('placeholder', '必填，产品代码，大写字母或数字，数据保存格式CHILD61/WADI/Y_E');
            } else if (priceFlag == 3) {
                $('#proCode').attr('placeholder', '必填，渠道，多个以逗号分隔，小写字母开头，数据保存格式jiecheng*,yingxing*');
            } else if (priceFlag == 4) {
                $('#proCode').val("");
                $('#proCode').attr('placeholder', '');
                $('#proCode').attr('disabled', true);
            }
        });

        //控制是否返现单选框输入限制
        $('#doReturn').click(function () {
            if (this.checked) {
                $('.fxCount').removeAttr('disabled');
            }
        });
        $('#notReturn').click(function () {
            if (this.checked) {
                $('.fxCount').attr('disabled', true);
            }
        });

        //控制加减价单选框输入限制
        $('#doChange').click(function () {
            if (this.checked) {
                $('.subCount').removeAttr('disabled');
                $('#addPrice').removeAttr('disabled');
                $('#subPrice').removeAttr('disabled');
            }
        });
        $('#notChange').click(function () {
            if (this.checked) {
                $('.subCount').attr('disabled', true);
                $('#addPrice').attr('disabled', true);
                $('#subPrice').attr('disabled', true);
            }
        });

        //控制用户可见单选框输入限制
        $('#partSee').click(function () {
            if (this.checked) {
                $('.userInfo').removeAttr('disabled');
            }
        });
        $('#allSee').click(function () {
            if (this.checked) {
                $('.userInfo').attr('disabled', true);
            }
        });

        //控制购买限制输入限制
        $('#allBuy').click(function () {
            if (this.checked) {
                $('.selectGroup').attr('disabled', true);
                $('.ageInput').attr('disabled', true);
                $('.cardCheckbox').attr('disabled', true);
            }
        });
        $('#partBuy').click(function () {
            if (this.checked) {
                $('.selectGroup').removeAttr('disabled');
                $('.ageInput').removeAttr('disabled');
                $('.cardCheckbox').removeAttr('disabled');
            }
        });

        $("#form1").validate({
            submitHandler: function (form) {
                var index = layer.load(3, {shade: [0.1]});
                $.post($('#form1').attr("action"), $('#form1').serialize(), function (data) {
                    if (data.code == 1) {
                        notify.success('保存成功！');
                        setTimeout(function () {
                            window.location.href = "product/list";
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

