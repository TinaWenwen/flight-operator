package com.huoli.flight.operator.domain.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
public class ProductDto implements Serializable {

    private Integer id;
    /* 产品名称 */
    private String proName;
    /* 数据源 */
    private String dataSrc;
    /* 预定渠道 */
    private String bookSrc;
    /* 航司 */
    private String airLine;
    /* 舱位运价匹配方式 1:政策id 0:舱位id 2:产品代码 3：供应商渠道 4：全渠道 */
    private int priceFlag;
    /* 政策id */
    private String proCode;
    /* 舱位id */
    private String cabinCode;
    /* 产品代码 */
    private String code;
    /* 供应商渠道 */
    private String channel;
    /* 返现标识 1：是 0：否 */
    private int fxFlag;
    /* 返现金额是否固定 1代表固定 0代表按比例 */
    private int fxisFixed;
    /* 返现金额 */
    private double fxCount;
    /* 是否加减价 1：是 0：否 */
    private int isPriceChange;
    /* 1：加价 0 ：减价 */
    private int changePrice;
    /* 加减价金额是否固定 1代表固定 0代表按比例 */
    private int subisFixed;
    /* 直减金额 */
    private double subCount;
    /* 是否添加直减标识 */
    private int subFlag;
    /* 是否可见 1：全部 0：部分 */
    private int allSee;
    /* 产品名称 */
    private String userInfo;
    /* 是否检验购买人 1：是 0：检验乘机人 */
    private int ckBuyer;
    /* 排除用户的信息 */
    private String exUser;
    /* 产品优先级 01234 */
    private int priority;
    /* 适用航程类型 */
    private String tripType;
    /* 适用app类型 */
    private String appType;
    /* 购买限制 1：全部可买 0:部分可买 */
    private int allBuy;
    /* 人数限制 0无限制 12345对应人数限制 */
    private String psnum;
    /* 性别限制 0无限制 1 男 2 女 */
    private String gender;
    /* 乘机人类型限制：无限制 "" ，成人ADT，儿童CHD，婴儿 INF */
    private String pstype;
    /* 辅助类证件限制 0 无限制 disabled 残疾限制 */
    private String adidtypes;
    /* 年龄是否限制 1:限制 0不限制 */
    private int ageLimit;
    /* 最小年龄 */
    private Integer minAge;
    /* 最大年龄 */
    private Integer maxAge;
    /* 证件类型限制 1：限制 0：不限制 */
    private int cardLimit;
    /* 证件类型 0：身份证 1：护照 2：户口本 3：其他 */
    private String idtype;
    /* 特殊预定参数 */
    private String bookParam;
    /* 客规id */
    private String ruleId;
}
