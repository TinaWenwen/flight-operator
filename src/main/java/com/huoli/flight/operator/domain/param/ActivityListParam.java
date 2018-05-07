package com.huoli.flight.operator.domain.param;

import com.huoli.flight.operator.domain.PageParam;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ActivityListParam extends PageParam {
    private String title;
    private Integer status;
    /* 类型 1：样式 2：航线 */
    private Integer type;
}
