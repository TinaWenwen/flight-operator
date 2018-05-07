package com.huoli.flight.operator.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class GatewayResult<T> extends BaseResult {

    public final static Integer ERR_CODE = 2001;

    /* 是否成功 成功 */
    private String success = "true";
}
