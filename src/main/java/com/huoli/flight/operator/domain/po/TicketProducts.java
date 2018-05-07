package com.huoli.flight.operator.domain.po;

import lombok.Data;

import java.util.Date;

@Data
public class TicketProducts {

    /* 主键ID */
    private Integer id;
    /* 航司 */
    private String airLine;
    private String proCode;
    /* 产品名称 */
    private String proName;
    private Integer allSee;
    private Integer allBuy;
    private Integer subFlag;
    private Integer priority;
    private Integer fxFlag;
    private String ruleId;
    private Integer tagFlag;
    private Integer applyFlag;
    /* 数据源 */
    private String dataSrc;
    /* 预定渠道 */
    private String bookSrc;
    private Double subCount;
    private Double fxCount;
    private String userInfo;
    private String showTxt;
    private String tagName;
    /* 标签颜色 */
    private String tagColor;
    private String icon;
    private Integer userType;
    /* 上下架状态 */
    private Integer status;
    private String bookParam;
    private String giftPackage;
    private String linkTxt;
    private String linkUrl;
    private String appType;
    private String exUser;
    private String tripType;
    private String saleControl;
    private Integer ckBuyer;
    private Date createTime;

    @Data
    public static class GiftPackage {
        // 冗余字段
        private Integer id;
        private String proName;

        /* 礼包标识 */
        private String pcode;
        /* 订单填写页礼包标签 */
        private String ptag;
        /* 礼包类型 */
        private String ptype;
        /* 礼包份数 */
        private String pcount;
        /* 返现金额 */
        private String pprice;
        /* 返现类型 */
        private String pfxtype;
    }

    @Data
    public static class TagInfo {
        // 冗余字段
        private Integer id;
        private String proName;
        private String tagName;
        private String tagColor;
        private String linkTxt;
        private String linkUrl;

        /* 报销凭证 */
        private String bx;
        /* 返现说明 */
        private String fx;
        /* 预定限制 */
        private String tj;
        /* 服务说明 */
        private String fw;
        /* 活动说明 */
        private String hd;
        /* 礼包说明 */
        private String lb;
        /* 其他说明 */
        private String qt;
    }
}
