package com.huoli.flight.operator.domain.result;

import com.huoli.flight.operator.domain.po.TicketActivity;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ActivityListResult extends TicketActivity {
    /* 预览链接 */
    private String previewUrl;
}
