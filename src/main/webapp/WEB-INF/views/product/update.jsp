<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        <div class="am-tabs am-margin" data-am-tabs>
            <ul class="am-tabs-nav am-nav am-nav-tabs">
                <li class="am-active"><a href="product/update/${product.id}" onclick="tabActive(this)">产品配置</a></li>
                <li><a href="product/tag/update/${product.id}" onclick="tabActive(this)">标签配置</a></li>
                <li><a href="product/gift/update/${product.id}" onclick="tabActive(this)">礼包配置</a></li>
            </ul>

            <div class="am-form-content">
                <form id="form1" action="product/update" method="post"
                      class="am-form am-form-horizontal" style="margin-top: 20px;">
                    <input type="hidden" name="id" value="${product.id}">
                    <%--基本信息begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">产品名称</label>
                        <div class="am-u-sm-9">
                            <input class="am-form-field" name="proName" value="${product.proName}" required/>
                        </div>
                    </div>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">数据源</label>
                        <div class="am-u-sm-9">
                            <input class="am-form-field" name="dataSrc" value="${product.dataSrc}" required/>
                        </div>
                    </div>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">预定渠道</label>
                        <div class="am-u-sm-9">
                            <input class="am-form-field" name="bookSrc" value="${product.bookSrc}" required/>
                        </div>
                    </div>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">航司代码</label>
                        <div class="am-u-sm-9">
                            <input class="am-form-field" name="airLine" value="${product.airLine}" placeholder="航司代码必填，二字码，多个以/分隔，如CZ，MU/FM" required/>
                        </div>
                    </div>
                    <%--基本信息end--%>

                    <%--舱位运价匹配方式begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">舱位运价匹配方式</label>
                        <div class="am-u-sm-9">
                            <input type="radio" name="priceFlag" value="1" ${product.priceFlag == 1 ? "checked" : ""}>
                            按政策id匹配
                            <input type="radio" name="priceFlag" value="0" ${product.priceFlag == 0 ? "checked" : ""}>
                            按舱位匹配
                            <input type="radio" name="priceFlag" value="2" ${product.priceFlag == 2 ? "checked" : ""}>
                            按产品代码
                            <input type="radio" name="priceFlag" value="3" ${product.priceFlag == 3 ? "checked" : ""}>
                            按渠道匹配
                            <input type="radio" name="priceFlag" value="4" ${product.priceFlag == 4 ? "checked" : ""}>
                            全渠道匹配
                            <input class="am-form-field" id="proCode" name="proCode" value="${product.proCode}" style="margin-top: 3px;"
                                   placeholder="必填，政策id，多个以逗号分隔，支持通配符，如*和131*，132*，133*，13400,1340">
                        </div>
                    </div>
                    <%--舱位运价匹配方式end--%>

                    <%--是否返现begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">返现</label>
                        <div class="am-u-sm-9">
                            <input type="radio" id="doReturn" name="fxFlag" value="1" ${product.fxFlag == 1 ? "checked" : ""}> 是
                            <input type="radio" id="notReturn" name="fxFlag" value="0" ${product.fxFlag == 0 ? "checked" : ""}> 否
                            <select name="fxisFixed" style="margin-top: 8px;">
                                <option value="1" ${product.fxisFixed == 1 ? "selected" : ""}>固定金额</option>
                                <option value="0" ${product.fxisFixed == 0 ? "selected" : ""}>比例</option>
                            </select>
                            <input class="am-form-field fxCount" style="margin-top: 8px;" name="fxCount" value="${product.fxCount}" placeholder="返现金额" required/>
                        </div>
                    </div>
                    <%--是否返现end--%>

                    <%--加减价begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">加减价</label>
                        <div class="am-u-sm-9">
                            <input type="radio" id="doChange" name="isPriceChange" value="1" ${product.isPriceChange == 1 ? "checked" : ""}> 是
                            <input type="radio" id="notChange" name="isPriceChange" value="0" ${product.isPriceChange == 0 ? "checked" : ""}> 否
                            <br>
                            <input type="radio" id="addPrice" name="changePrice" value="1" ${product.changePrice == 1 ? "checked" : ""}> 加价
                            <input type="radio" id="subPrice" name="changePrice" value="0" ${product.changePrice == 0 ? "checked" : ""}> 直减
                            <select name="subisFixed" style="margin-top: 8px;">
                                <option value="1" ${product.subisFixed == 1 ? "selected" : ""}>固定金额</option>
                                <option value="0" ${product.subisFixed == 0 ? "selected" : ""}>比例</option>
                            </select>
                            <input class="am-form-field subCount" style="margin-top: 8px;" name="subCount" value="${product.subCount}" placeholder="金额" required/>
                        </div>
                    </div>
                    <%--加减价end--%>

                    <%--是否添加直减标识begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">直减标识</label>
                        <div class="am-u-sm-9">
                            <input type="radio" name="subFlag" value="1" ${product.subFlag == 1 ? "checked" : ""}> 是
                            <input type="radio" name="subFlag" value="0" ${product.subFlag == 0 ? "checked" : ""}> 否
                        </div>
                    </div>
                    <%--是否添加直减标识end--%>

                    <%--可见限制begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">可见标识</label>
                        <div class="am-u-sm-9">
                            <input type="radio" id="partSee" name="allSee" value="0" ${product.allSee == 0 ? "checked" : ""}> 部分用户可见
                            <input type="radio" id="allSee" name="allSee" value="1" ${product.allSee == 1 ? "checked" : ""}> 全部用户可见
                            <input class="am-form-field userInfo" style="margin-top: 8px;" name="userInfo" value="${product.userInfo}" placeholder="可见用户tag"/>
                        </div>
                    </div>
                    <%--可见限制end--%>

                    <%--校验 begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">校验标识</label>
                        <div class="am-u-sm-9">
                            <input type="radio" name="ckBuyer" value="1" ${product.ckBuyer == 1 ? "checked" : ""}> 校验购买人
                            <input type="radio" name="ckBuyer" value="0" ${product.ckBuyer == 0 ? "checked" : ""}> 校验乘机人
                        </div>
                    </div>
                    <%--校验 end--%>

                    <%--排除用户的属性 begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">排除用户</label>
                        <div class="am-u-sm-9">
                            <input class="am-form-field" name="exUser" value="${product.exUser}"/>
                        </div>
                    </div>
                    <%--排除用户的属性 end--%>

                    <%--产品优先级 begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">优先级</label>
                        <div class="am-u-sm-9">
                            <select name="priority">
                                <option value="0" ${product.priority == 0 ? "selected" : ""}>0</option>
                                <option value="1" ${product.priority == 1 ? "selected" : ""}>1</option>
                                <option value="2" ${product.priority == 2 ? "selected" : ""}>2</option>
                                <option value="3" ${product.priority == 3 ? "selected" : ""}>3</option>
                                <option value="4" ${product.priority == 4 ? "selected" : ""}>4</option>
                            </select>
                        </div>
                    </div>
                    <%--产品优先级 end--%>

                    <%--类型 begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">航程类型</label>
                        <div class="am-u-sm-9">
                            <input type="radio" name="tripType" value="" value="" ${product.tripType.equals("") ? "checked" : ""}> 无限制
                            <input type="radio" class="tripType" name="tripType" value="OW" value="" ${product.tripType.equals("OW") ? "checked" : ""}> 单程
                            <input type="radio" class="tripType" name="tripType" value="RT" value="" ${product.tripType.equals("RT") ? "checked" : ""}> 往返
                            <input type="radio" class="tripType" name="tripType" value="MP" value="" ${product.tripType.equals("MP") ? "checked" : ""}> 多程
                        </div>
                    </div>

                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">APP类型</label>
                        <div class="am-u-sm-9">
                            <input type="radio" name="appType" value="" value="" ${product.appType.equals("") ? "checked" : ""}> 无限制
                            <input type="radio" name="appType" value="gtgj" value="" ${product.appType.equals("gtgj") ? "checked" : ""}>高铁app
                            <input type="radio" name="appType" value="hbgj" value="" ${product.appType.equals("hbgj") ? "checked" : ""}> 航班app
                            <input type="radio" name="appType" value="web" value="" ${product.appType.equals("web") ? "checked" : ""}> h5平台
                        </div>
                    </div>
                    <%--类型 end--%>

                    <%--购买限制 begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">购买限制</label>
                        <div class="am-u-sm-9">
                            <input type="radio" id="partBuy" name="allBuy" value="0" ${product.allBuy == 0 ? "checked" : ""}> 部分乘机人
                            <input type="radio" id="allBuy" name="allBuy" value="1" ${product.allBuy == 1 ? "checked" : ""}> 无限制
                            <select name="psnum" class="selectGroup" style="margin-top: 8px;">
                                <option value="0" ${product.psnum.equals("0") ? "selected" : ""}>人数无限制</option>
                                <option value="1" ${product.psnum.equals("1") ? "selected" : ""}>1</option>
                                <option value="2" ${product.psnum.equals("2") ? "selected" : ""}>2</option>
                                <option value="3" ${product.psnum.equals("3") ? "selected" : ""}>3</option>
                                <option value="4" ${product.psnum.equals("4") ? "selected" : ""}>4</option>
                                <option value="5" ${product.psnum.equals("5") ? "selected" : ""}>5</option>
                            </select>
                            <select name="gender" class="selectGroup" style="margin-top: 8px;">
                                <option value="0" ${product.gender.equals("0") ? "selected" : ""}>性别无限制</option>
                                <option value="1" ${product.gender.equals("1") ? "selected" : ""}>男</option>
                                <option value="2" ${product.gender.equals("2") ? "selected" : ""}>女</option>
                            </select>
                            <select name="pstype" class="selectGroup" style="margin-top: 8px;">
                                <option value="0" ${product.pstype.equals("0") ? "selected" : ""}>乘机人类型无限制</option>
                                <option value="ADT" ${product.pstype.equals("ADT") ? "selected" : ""}>成人</option>
                                <option value="CHD" ${product.pstype.equals("CHD") ? "selected" : ""}>儿童</option>
                                <option value="INF" ${product.pstype.equals("INF") ? "selected" : ""}>婴儿</option>
                            </select>
                            <select name="adidtypes" class="selectGroup" style="margin-top: 8px;">
                                <option value="0" ${product.adidtypes.equals("0") ? "selected" : ""}>辅助证件类别无限制</option>
                                <option value="disabled" ${product.adidtypes.equals("disabled") ? "selected" : ""}>
                                    残疾类证件限制
                                </option>
                            </select>
                            <select name="ageLimit" id="ageLimit" style="margin-top: 8px;">
                                <option value="1" id="limit_option" ${product.ageLimit == 1 ? "selected" : ""}>年龄段限制
                                </option>
                                <option value="0" id="nolimit_option" ${product.ageLimit == 0 ? "selected" : ""}>年龄段无限制
                                </option>
                            </select>
                            <div style="display: inline-flex; margin-top: 8px;">
                                <input type="text" name="minAge" value="${product.minAge}" class="ageInput" style="width: 318px" placeholder="岁以上"/>
                                <input type="text" name="maxAge" value="${product.maxAge}" class="ageInput" style="width: 317px; margin-left: 3px;" placeholder="岁以下"/>
                            </div>
                            <select name="cardLimit" class="cardLimit" selectGroup style="margin-top: 8px;">
                                <option value="1" ${product.cardLimit == 1 ? "selected" : ""}>证件类型限制</option>
                                <option value="0" ${product.cardLimit == 0 ? "selected" : ""}>证件类型无限制</option>
                            </select>
                            <label class="am-checkbox-inline cardCheckbox">
                                <input class="cardCheckbox" name="idtype" type="checkbox" ${product.idtype.contains("0") ? "checked" : ""} value="0"> 身份证
                            </label>
                            <label class="am-checkbox-inline cardCheckbox">
                                <input class="cardCheckbox" name="idtype" type="checkbox" ${product.idtype.contains("1") ? "checked" : ""} value="1"> 护照
                            </label>
                            <label class="am-checkbox-inline cardCheckbox">
                                <input class="cardCheckbox" name="idtype" type="checkbox" ${product.idtype.contains("2") ? "checked" : ""} value="2"> 户口本
                            </label>
                            <label class="am-checkbox-inline cardCheckbox">
                                <input class="cardCheckbox" name="idtype" type="checkbox" ${product.idtype.contains("3") ? "checked" : ""} value="3"> 其他
                            </label>
                        </div>
                    </div>
                    <%--购买限制 end--%>

                    <%--特殊预定参数begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">特殊预定参数</label>
                        <div class="am-u-sm-9">
                            <input class="am-form-field" name="bookParam" value='${product.bookParam}' placeholder="若出票组有要求，则找他们提供"/>
                        </div>
                    </div>
                    <%--特殊预定参数end--%>

                    <%-- 客规ID begin--%>
                    <div class="am-form-group am-form-group-sm">
                        <label class="am-u-sm-3 am-form-label">客规ID</label>
                        <div class="am-u-sm-9">
                            <input class="am-form-field" name="ruleId" value="${product.ruleId}"/>
                        </div>
                    </div>
                    <%-- 客规ID end--%>

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
        // 控制运价方式单选框输入限制
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

        // 控制是否返现单选框输入限制
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

        // 控制加减价单选框输入限制
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

        // 控制用户可见单选框输入限制
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

        // 控制购买限制输入限制
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
            submitHandler:function(form){
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


