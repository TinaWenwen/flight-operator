package com.huoli.flight.operator.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.huoli.flight.operator.domain.BaseResult;
import com.huoli.flight.operator.domain.dto.ActivityDto;
import com.huoli.flight.operator.domain.param.ActivityListParam;
import com.huoli.flight.operator.domain.param.ActivityParam;
import com.huoli.flight.operator.domain.po.TicketActivity;
import com.huoli.flight.operator.service.TicketActivityService;
import com.huoli.flight.operator.util.MessageContext;
import com.xiaoleilu.hutool.date.DateUtil;
import com.xiaoleilu.hutool.util.CollectionUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/activity/data")
public class ActivityDataController {

    private final static Integer TYPE = 2;

    @Resource
    private TicketActivityService ticketActivityService;

    /**
     * 活动列表查询
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model, ActivityListParam param) {
        PageHelper.startPage(param.getPageNumber(), param.getPageSize());
        param.setType(TYPE);
        List<TicketActivity> activitys = ticketActivityService.queryByCondition(param);
        if (CollectionUtil.isNotEmpty(activitys)) {
            PageInfo<TicketActivity> pageInfo = new PageInfo<>(activitys);
            model.addAttribute("list", activitys);
            model.addAttribute("page", pageInfo);
        } else {
            model.addAttribute("page", new PageInfo<>());
        }
        model.addAttribute("param", param);
        return "activity/data/list";
    }

    /**
     * 新增活动数据跳转
     */
    @RequestMapping(value = "/insert", method = RequestMethod.GET)
    public String toInsert(Model model) {
        model.addAttribute("action", "insert");
        return "activity/data/insert";
    }

    /**
     * 新增活动数据
     */
    @ResponseBody
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    public BaseResult insert(ActivityParam param) {
        BaseResult result = BaseResult.builder().build(() -> {
            if (!param.getDataCode().startsWith("fly")) {
                MessageContext.addError("数据标识必须以'fly开头'");
                return null;
            }
            param.setType(TYPE);
            param.setData(param.getFlightStr().getBytes());
            ticketActivityService.doInsert(param);
            return null;
        });
        return result;
    }

    /**
     * 更新活动数据跳转
     */
    @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
    public String toUpdate(Model model, @PathVariable Integer id) {
        TicketActivity ticketActivity = ticketActivityService.queryById(id);
        if (ticketActivity != null) {
            ActivityDto activity = new ActivityDto();
            BeanUtils.copyProperties(ticketActivity, activity);
            activity.setBeginDate(DateUtil.formatDate(ticketActivity.getBeginTime()));
            activity.setEndDate(DateUtil.formatDate(ticketActivity.getEndTime()));
            activity.setDataStr(new String(ticketActivity.getData()).replace("[", "").replace("]", "") + ",");
            model.addAttribute("action", "update");
            model.addAttribute("activity", activity);
        }
        return "activity/data/insert";
    }

    /**
     * 更新活动数据
     */
    @ResponseBody
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public BaseResult update(ActivityParam param) {
        BaseResult result = BaseResult.builder().build(() -> {
            if (!param.getDataCode().startsWith("fly")) {
                MessageContext.addError("数据标识必须以'fly开头'");
                return null;
            }
            param.setType(TYPE);
            param.setData(param.getFlightStr().getBytes());
            ticketActivityService.doUpdate(param);
            return null;
        });
        return result;
    }

    /**
     * 更新活动数据状态
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