package com.huoli.flight.operator.service;

import com.huoli.flight.operator.domain.param.ActivityListParam;
import com.huoli.flight.operator.domain.param.ActivityParam;
import com.huoli.flight.operator.domain.po.TicketActivity;

import java.util.List;

public interface TicketActivityService {

    /*
     * 查询活动列表
     */
    List<TicketActivity> queryByCondition(ActivityListParam param);

    /**
     * 通过ID查询活动
     */
    TicketActivity queryById(Integer id);

    /**
     * 通过dataCode查询活动
     */
    TicketActivity queryByDataCode(String dataCode, Integer type);

    /**
     * 新增活动
     */
    void doInsert(ActivityParam param);

    /**
     * 修改上下架状态
     */
    void doUpdateStatus(Integer id);

    /**
     * 修改活动
     */
    void doUpdate(ActivityParam param);
}


