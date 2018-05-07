package com.huoli.flight.operator.web.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.huoli.flight.operator.domain.BaseResult;
import com.huoli.flight.operator.domain.dto.ActivityDto;
import com.huoli.flight.operator.domain.param.ActivityListParam;
import com.huoli.flight.operator.domain.param.ActivityParam;
import com.huoli.flight.operator.domain.po.TicketActivity;
import com.huoli.flight.operator.domain.result.ActivityListResult;
import com.huoli.flight.operator.service.TicketActivityService;
import com.xiaoleilu.hutool.date.DateUtil;
import com.xiaoleilu.hutool.util.CollectionUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/activity")
public class ActivityController {

    private final static Integer TYPE = 1;

    @Resource
    private TicketActivityService ticketActivityService;

    @Value("${h5.activity.url}")
    private String activityUrl;

    /**
     * 活动列表查询
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model, ActivityListParam param) {
        PageHelper.startPage(param.getPageNumber(), param.getPageSize());
        param.setType(TYPE);
        List<TicketActivity> activitys = ticketActivityService.queryByCondition(param);
        if (CollectionUtil.isNotEmpty(activitys)) {
            List<ActivityListResult> list = Lists.newArrayList();
            activitys.forEach(i -> {
                ActivityListResult result = new ActivityListResult();
                BeanUtils.copyProperties(i, result);
                result.setPreviewUrl(String.format(activityUrl, i.getDataCode(), i.getId()));
                Date now = new Date();
                if (i.getStatus() == 1 && now.after(i.getEndTime())) {// 过期做下架处理
                    result.setStatus(0);
                    ticketActivityService.doUpdateStatus(i.getId());
                }
                list.add(result);
            });
            PageInfo<ActivityListResult> pageInfo = new PageInfo<>(list);
            model.addAttribute("list", list);
            model.addAttribute("page", pageInfo);
        } else {
            model.addAttribute("page", new PageInfo<>());
        }
        model.addAttribute("param", param);
        return "activity/list";
    }

    /**
     * 新增活动跳转
     */
    @RequestMapping(value = "/insert", method = RequestMethod.GET)
    public String toInsert(Model model) {
        model.addAttribute("action", "insert");
        return "activity/insert";
    }

    /**
     * 新增活动
     */
    @ResponseBody
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    public BaseResult insert(ActivityParam param) {
        BaseResult result = BaseResult.builder().build(() -> {
            param.setType(TYPE);
            param.setStatus(0);
            param.setData(param.getStyleStr().getBytes());
            ticketActivityService.doInsert(param);
            return null;
        });
        return result;

    }

    /**
     * 更新活动跳转
     */
    @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
    public String toUpdate(Model model, @PathVariable Integer id) {
        TicketActivity ticketActivity = ticketActivityService.queryById(id);
        if (ticketActivity != null) {
            ActivityDto activity = JSON.parseObject(new String(ticketActivity.getData()), ActivityDto.class);
            BeanUtils.copyProperties(ticketActivity, activity);
            activity.setBeginDate(DateUtil.formatDate(ticketActivity.getBeginTime()));
            activity.setEndDate(DateUtil.formatDate(ticketActivity.getEndTime()));
            activity.setRuleStr(StringUtils.join(activity.getRule().getItems(), "\n"));
            model.addAttribute("action", "update");
            model.addAttribute("activity", activity);
        }
        return "activity/insert";
    }

    /**
     * 更新活动
     */
    @ResponseBody
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public BaseResult update(ActivityParam param) {
        BaseResult result = BaseResult.builder().build(() -> {
            param.setType(TYPE);
            param.setData(param.getStyleStr().getBytes());
            ticketActivityService.doUpdate(param);
            return null;
        });
        return result;
    }

    /**
     * 更新活动状态
     */
    @ResponseBody
    @RequestMapping(value = "/status/update/{id}", method = RequestMethod.POST)
    public BaseResult updateStatus(@PathVariable Integer id) {
        BaseResult result = BaseResult.builder().build(() -> {
            ticketActivityService.doUpdateStatus(id);
            return null;
        });
        return result;
    }
}