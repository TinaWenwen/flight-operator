package com.huoli.flight.operator.domain.param;

import com.huoli.flight.operator.domain.PageParam;
import lombok.Data;

@Data
public class ProductListParam extends PageParam {
    private String airLine;
    private String dataSrc;
    private String bookSrc;
    private Integer status;
    private Integer sort = 0;
}
