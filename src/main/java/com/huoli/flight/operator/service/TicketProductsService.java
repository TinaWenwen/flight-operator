package com.huoli.flight.operator.service;

import com.huoli.flight.operator.domain.dto.ProductDto;
import com.huoli.flight.operator.domain.param.ProductListParam;
import com.huoli.flight.operator.domain.po.TicketProducts;

import java.util.List;

public interface TicketProductsService {

    /*
     * 查询产品列表
     */
    List<TicketProducts> queryByCondition(ProductListParam param);

    /**
     * 通过ID查询产品
     */
    ProductDto queryById(Integer id);

    /**
     * 新增产品
     */
    void doInsert(ProductDto ticketDto);

    /**
     * 修改上下架状态
     */
    void doUpdateStatus(Integer id);

    /**
     * 修改产品
     */
    void doUpdate(ProductDto ticketDto);

    /**
     * 查询标签
     */
    TicketProducts.TagInfo queryTagById(Integer id);

    /**
     * 修改标签
     */
    void doUpdateTag(Integer id, TicketProducts.TagInfo tagInfo);

    /**
     * 查询礼包
     */
    TicketProducts.GiftPackage queryGiftById(Integer id);

    /**
     * 修改礼包
     */
    void doUpdateGift(Integer id, TicketProducts.GiftPackage giftPackage);
}
