package com.huoli.flight.operator.web.api;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.huoli.flight.operator.domain.BaseParam;
import com.huoli.flight.operator.domain.BaseResult;
import com.huoli.flight.operator.domain.po.TicketActivity;
import com.huoli.flight.operator.domain.result.ActivityResult;
import com.huoli.flight.operator.service.TicketActivityService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@RequestMapping("/api/activity/")
public class ActivityApi {

    @Autowired
    private TicketActivityService ticketActivityService;

    @RequestMapping("/bargains/detail")
    public BaseResult<ActivityResult> bargainsDetail(BaseParam param, Integer actId) {
        TicketActivity ticketActivity = ticketActivityService.queryById(actId);
        ActivityResult data = null;
        if (ticketActivity != null) {
            data = JSON.parseObject(new String(ticketActivity.getData()), ActivityResult.class);
            BeanUtils.copyProperties(ticketActivity, data);
            // 处理状态
            Date now = new Date();
            if (ticketActivity.getStatus() == 1 && (now.after(ticketActivity.getEndTime()) || now.before(ticketActivity.getBeginTime()))) {
                data.setStatus(0);
                if (now.after(ticketActivity.getEndTime())) {// 过期做下架处理
                    ticketActivityService.doUpdateStatus(ticketActivity.getId());
                }
            }
        }
        return BaseResult.builder().scm(param.getScm()).data(data).build();
    }

    @RequestMapping("/data/detail")
    public BaseResult dataDetail(BaseParam param, String hid) {
        TicketActivity ticketActivity = ticketActivityService.queryByDataCode(hid, 2);
        JSONObject data = new JSONObject();
        if (ticketActivity != null) {
            JSONArray datas = JSON.parseArray(new String(ticketActivity.getData()));
            data.put("datas", datas);

            // 处理状态
            Date now = new Date();
            if (ticketActivity.getStatus() == 1 && (now.after(ticketActivity.getEndTime()) || now.before(ticketActivity.getBeginTime()))) {
                data.remove("datas");
                if (now.after(ticketActivity.getEndTime())) {// 过期做下架处理
                    ticketActivityService.doUpdateStatus(ticketActivity.getId());
                }
            }
        }
        return BaseResult.builder().scm(param.getScm()).data(data).build();
    }
}
