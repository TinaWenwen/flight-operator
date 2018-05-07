package com.huoli.flight.operator.service.impl;

import com.huoli.flight.operator.dao.TicketActivityDao;
import com.huoli.flight.operator.domain.param.ActivityListParam;
import com.huoli.flight.operator.domain.param.ActivityParam;
import com.huoli.flight.operator.domain.po.TicketActivity;
import com.huoli.flight.operator.service.TicketActivityService;
import com.huoli.flight.operator.util.MessageContext;
import com.xiaoleilu.hutool.date.DateUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class TicketActivityServiceImpl implements TicketActivityService {

    @Autowired
    private TicketActivityDao ticketActivityDao;

    /*
     * 查询活动列表
     */
    @Override
    public List<TicketActivity> queryByCondition(ActivityListParam param) {
        return ticketActivityDao.queryByCondition(param.getTitle(), param.getStatus(), param.getType());
    }

    /**
     * 通过ID查询活动
     */
    @Override
    public TicketActivity queryById(Integer id) {
        return ticketActivityDao.queryById(id);
    }

    /**
     * 通过dataCode查询活动
     */
    @Override
    public TicketActivity queryByDataCode(String dataCode, Integer type) {
        return ticketActivityDao.queryByDataCode(dataCode, type);
    }

    /**
     * 新增活动
     */
    @Override
    public void doInsert(ActivityParam param) {
        TicketActivity ticketActivity = null;
        if (checkDataExists(param)) return;
        ticketActivity = new TicketActivity();
        BeanUtils.copyProperties(param, ticketActivity);
        ticketActivity.setStatus(0);
        ticketActivity.setBeginTime(DateUtil.parseDateTime(param.getBeginDate() + " 00:00:00"));
        ticketActivity.setEndTime(DateUtil.parseDateTime(param.getEndDate() + " 23:59:59"));
        ticketActivityDao.insert(ticketActivity);
    }

    /**
     * 修改上下架状态
     */
    @Override
    public void doUpdateStatus(Integer id) {
        TicketActivity ticketActivity = ticketActivityDao.queryById(id);
        Integer status = ticketActivity.getStatus();
        Date now = new Date();
        if (status == 0 && now.after(ticketActivity.getEndTime())) {
            MessageContext.addError("已过期无法上架");
            return;
        }
        ticketActivityDao.updateStatus(id, status == 0 ? 1 : 0);
    }

    /**
     * 修改活动
     */
    @Override
    public void doUpdate(ActivityParam param) {
        TicketActivity ticketActivity = null;
        if (checkDataExists(param)) return;
        ticketActivity = new TicketActivity();
        BeanUtils.copyProperties(param, ticketActivity);
        ticketActivity.setBeginTime(DateUtil.parseDateTime(param.getBeginDate() + " 00:00:00"));
        ticketActivity.setEndTime(DateUtil.parseDateTime(param.getEndDate() + " 23:59:59"));
        ticketActivityDao.update(ticketActivity);
    }

    private boolean checkDataExists(ActivityParam param) {
        TicketActivity ticketActivity;
        if (param.getType() == 2) {
            ticketActivity = queryByDataCode(param.getDataCode(), param.getType());
            if (ticketActivity != null) {
                MessageContext.addError("数据标识已经存在");
                return true;
            }
        }
        return false;
    }
}
