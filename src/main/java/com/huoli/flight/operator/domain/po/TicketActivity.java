package com.huoli.flight.operator.domain.po;

import lombok.Data;

import java.util.Date;

@Data
public class TicketActivity {
    private Integer id;
    /* 活动标题 */
    private String title;
    /* 数据标识 */
    private String dataCode;
    /* 状态 1：上线 0：下线 */
    private Integer status;
    /* 类型 1：样式 2：航线 */
    private Integer type;
    /* 数据 */
    private byte[] data;
    /* 创建时间 */
    private Date createTime;
    /* 生效日期 */
    private Date beginTime;
    /* 失效日期 */
    private Date endTime;
}
