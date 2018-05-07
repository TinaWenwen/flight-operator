package com.huoli.flight.operator.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.huoli.flight.operator.domain.BaseResult;
import com.huoli.flight.operator.domain.dto.ProductDto;
import com.huoli.flight.operator.domain.param.ProductListParam;
import com.huoli.flight.operator.domain.po.TicketProducts;
import com.huoli.flight.operator.service.TicketProductsService;
import com.huoli.flight.operator.util.TransformUtil;
import com.xiaoleilu.hutool.util.CollectionUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private TicketProductsService ticketProductsService;

    /**
     * 产品列表查询
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model, ProductListParam param) {
        PageHelper.startPage(param.getPageNumber(), param.getPageSize());
        List<TicketProducts> list = ticketProductsService.queryByCondition(param);
        if (CollectionUtil.isNotEmpty(list)) {
            list.forEach(i -> {
                // 航程类型
                i.setTripType(TransformUtil.transTripType(i.getTripType()));
                // app平台
                i.setAppType(TransformUtil.transAppType(i.getAppType()));
                // 颜色
                i.setTagColor(TransformUtil.transTagColor(i.getTagColor()));
                //
                if (StringUtils.isEmpty(i.getSaleControl())) i.setSaleControl("无");
                if (StringUtils.isEmpty(i.getExUser())) i.setExUser("全部");
            });
        }
        PageInfo<TicketProducts> pageInfo = new PageInfo<>(list);
        model.addAttribute("list", list);
        model.addAttribute("param", param);
        model.addAttribute("page", pageInfo);
        return "product/list";
    }

    /**
     * 新增产品跳转
     */
    @RequestMapping(value = "/insert", method = RequestMethod.GET)
    public String toInsert() {
        return "product/insert";
    }

    /**
     * 新增产品
     */
    @ResponseBody
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    public BaseResult insert(ProductDto ticketDto) {
        BaseResult result = BaseResult.builder().build(() -> {
            ticketProductsService.doInsert(ticketDto);
            return null;
        });
        return result;
    }

    /**
     * 更新产品跳转
     */
    @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
    public String toUpdate(Model model, @PathVariable Integer id) {
        ProductDto product = ticketProductsService.queryById(id);
        model.addAttribute("product", product);
        return "product/update";
    }

    /**
     * 更新产品
     */
    @ResponseBody
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public BaseResult update(ProductDto ticketDto) {
        BaseResult result = BaseResult.builder().build(() -> {
            ticketProductsService.doUpdate(ticketDto);
            return null;
        });
        return result;
    }

    /**
     * 更新产品状态
     */
    @ResponseBody
    @RequestMapping(value = "/status/update/{id}", method = RequestMethod.POST)
    public BaseResult updateStatus(@PathVariable Integer id) {
        BaseResult result = BaseResult.builder().build(() -> {
            ticketProductsService.doUpdateStatus(id);
            return null;
        });
        return result;
    }

    /**
     * 更新标签跳转
     */
    @RequestMapping(value = "/tag/update/{id}", method = RequestMethod.GET)
    public String toUpdateTag(Model model, @PathVariable Integer id) {
        model.addAttribute("tag", ticketProductsService.queryTagById(id));
        return "product/tag";
    }

    /**
     * 更新标签
     */
    @ResponseBody
    @RequestMapping(value = "/tag/update", method = RequestMethod.POST)
    public BaseResult updateTag(Integer id, TicketProducts.TagInfo tagInfo) {
        BaseResult result = BaseResult.builder().build(() -> {
            ticketProductsService.doUpdateTag(id, tagInfo);
            return null;
        });
        return result;
    }

    /**
     * 更新礼包跳转
     */
    @RequestMapping(value = "/gift/update/{id}", method = RequestMethod.GET)
    public String toUpdateGift(Model model, @PathVariable Integer id) {
        model.addAttribute("gift", ticketProductsService.queryGiftById(id));
        return "product/gift";
    }

    /**
     * 更新礼包
     */
    @ResponseBody
    @RequestMapping(value = "/gift/update", method = RequestMethod.POST)
    public BaseResult updateGift(Integer id, TicketProducts.GiftPackage giftPackage) {
        BaseResult result = BaseResult.builder().build(() -> {
            ticketProductsService.doUpdateGift(id, giftPackage);
            return null;
        });
        return result;
    }
}
