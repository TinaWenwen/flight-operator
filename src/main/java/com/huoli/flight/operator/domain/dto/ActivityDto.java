package com.huoli.flight.operator.domain.dto;

import com.huoli.flight.operator.domain.result.ActivityResult;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ActivityDto extends ActivityResult {

    private Integer id;
    /* 数据标识 */
    private String dataCode;
    /* 生效日期 */
    private String beginDate;
    /* 失效日期 */
    private String endDate;
    /* */
    private String ruleStr;
    /* */
    private String dataStr;
}