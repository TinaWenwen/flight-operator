package com.huoli.flight.operator.domain.result;

import lombok.Data;

import java.util.List;

@Data
public class ActivityResult {

    /* 标题 */
    private String title;
    /* 状态 1：在线 2：下线 */
    private Integer status;
    /* 背景颜色 */
    private String backColor;
    /* 航线展示样式 */
    private String listStyle;
    /* 头部 */
    private Header header;
    /* 标题栏 */
    private TitleBar titleBar;
    /* 预定按钮 */
    private BookButton bookButton;
    /* 查看更多航线按钮 */
    private ShowMoreButton showMoreButton;
    /* 活动规则 */
    private Rule rule;
    /* 页脚 */
    private Footer footer;
    /* 微信分享 */
    private WechatShare wechatShare;

    @Data
    public static class Header {
        /* 图片url */
        private String img;
    }

    @Data
    public static class TitleBar {
        /* 背景颜色 */
        private String backColor;
    }

    @Data
    public static class BookButton {
        /* 颜色 */
        private String color;
        /* 文案 */
        private String text;
    }

    @Data
    public static class ShowMoreButton {
        /* 颜色 */
        private String color;
    }

    @Data
    public static class Rule {
        /* 标题 */
        private String title;
        /* 背景颜色 */
        private String backColor;
        /* 字体颜色 */
        private String fontColor;
        /* 规则说明 */
        private List<String> items;
    }

    @Data
    public static class Footer {
        /* 图片url */
        private String img;
    }

    @Data
    public static class WechatShare {
        /* 描述 */
        private String desc;
        /* 图标url */
        private String icon;
        /* 标题 */
        private String title;
    }
}
