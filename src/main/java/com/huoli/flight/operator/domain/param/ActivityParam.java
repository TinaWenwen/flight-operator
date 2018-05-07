package com.huoli.flight.operator.domain.param;

import com.huoli.flight.operator.domain.po.TicketActivity;
import lombok.Data;
import lombok.NonNull;

import javax.validation.constraints.NotNull;

@Data
public class ActivityParam extends TicketActivity {
    /* 样式 */
    @NotNull
    private String styleStr;
    /* 航线 */
    private String flightStr;
    /* 生效日期 */
    private String beginDate;
    /* 失效日期 */
    private String endDate;
}