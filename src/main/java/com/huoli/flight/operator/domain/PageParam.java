package com.huoli.flight.operator.domain;

import lombok.Data;

@Data
public class PageParam {
    private Integer pageNumber = 1;
    private Integer pageSize = 10;
}
