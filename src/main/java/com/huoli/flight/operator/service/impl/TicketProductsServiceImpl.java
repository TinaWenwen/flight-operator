package com.huoli.flight.operator.service.impl;

import com.huoli.flight.operator.dao.TicketProductsDao;
import com.huoli.flight.operator.domain.dto.ProductDto;
import com.huoli.flight.operator.domain.param.ProductListParam;
import com.huoli.flight.operator.domain.po.TicketProducts;
import com.huoli.flight.operator.service.TicketProductsService;
import com.huoli.flight.operator.util.TransformUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Slf4j
@Service
public class TicketProductsServiceImpl implements TicketProductsService {

    @Resource
    private TicketProductsDao ticketProductsDao;

    /*
     * 查询产品列表
     */
    @Override
    public List<TicketProducts> queryByCondition(ProductListParam param) {
        return ticketProductsDao.queryByCondition(param.getAirLine(), param.getDataSrc(), param.getBookSrc(), param.getStatus(), param.getSort());
    }

    /**
     * 通过ID查询产品
     */
    @Override
    public ProductDto queryById(Integer id) {
        TicketProducts ticketProducts = ticketProductsDao.queryById(id);
        return TransformUtil.transProductDto(ticketProducts);
    }

    /**
     * 新增产品
     */
    @Override
    public void doInsert(ProductDto ticketDto) {
        TicketProducts ticketProducts = TransformUtil.transTicketProducts(ticketDto);
        ticketProducts.setTagFlag(0);
        ticketProducts.setApplyFlag(0);
        ticketProducts.setUserType(0);
        ticketProductsDao.insert(ticketProducts);
    }

    /**
     * 修改上下架状态
     */
    @Override
    public void doUpdateStatus(Integer id) {
        TicketProducts ticketProducts = ticketProductsDao.queryById(id);
        Integer status = ticketProducts.getStatus();
        if (status == 1) {
            ticketProducts.setStatus(0);
        }
        if (status == 0) {
            ticketProducts.setStatus(1);
        }
        ticketProductsDao.update(ticketProducts);
    }

    /**
     * 修改产品
     */
    @Override
    public void doUpdate(ProductDto ticketDto) {
        TicketProducts ticketProducts = TransformUtil.transTicketProducts(ticketDto);
        ticketProductsDao.update(ticketProducts);
    }

    /**
     * 查询标签
     */
    @Override
    public TicketProducts.TagInfo queryTagById(Integer id) {
        TicketProducts ticketProducts = ticketProductsDao.queryById(id);
        if (ticketProducts == null) return null;
        TicketProducts.TagInfo tagInfo = new TicketProducts.TagInfo();
        tagInfo.setId(ticketProducts.getId());
        tagInfo.setProName(ticketProducts.getProName());
        tagInfo.setTagName(ticketProducts.getTagName());
        tagInfo.setTagColor(ticketProducts.getTagColor());
        String showText = ticketProducts.getShowTxt();
        if (StringUtils.isNotBlank(showText)) {
            String[] arr = showText.split("\\|");
            if (arr.length == 0) return tagInfo;
            for (String str : arr) {
                if (StringUtils.isNotBlank(str)) {
                    if (str.contains(":")) {
                        String[] item = str.split(":");
                        if (item.length != 2 || StringUtils.isBlank(item[0]) || StringUtils.isBlank(item[1])) continue;
                        String key = item[0];
                        String value = item[1];
                        switch (key) {
                            case "bx":/* 报销凭证 */
                                tagInfo.setBx(value);
                                break;
                            case "fx":/* 返现说明 */
                                tagInfo.setFx(value);
                                break;
                            case "tj":/* 预定限制 */
                                tagInfo.setTj(value);
                                break;
                            case "fw":/* 服务说明 */
                                tagInfo.setFw(value);
                                break;
                            case "hd":/* 活动说明 */
                                tagInfo.setHd(value);
                                break;
                            case "lb":/* 礼包说明 */
                                tagInfo.setLb(value);
                                break;
                        }
                    } else {
                        /* 其他说明 */
                        tagInfo.setQt(str);
                    }
                }
            }
        }
        return tagInfo;
    }

    /**
     * 修改标签
     */
    @Override
    public void doUpdateTag(Integer id, TicketProducts.TagInfo tagInfo) {
        StringBuffer showText = new StringBuffer();
        if (StringUtils.isNotBlank(tagInfo.getFx())) {
            showText.append("|").append("fx").append(":").append(tagInfo.getFx());
        }
        if (StringUtils.isNotBlank(tagInfo.getBx())) {
            showText.append("|").append("bx").append(":").append(tagInfo.getBx());
        }
        if (StringUtils.isNotBlank(tagInfo.getTj())) {
            showText.append("|").append("tj").append(":").append(tagInfo.getTj());
        }
        if (StringUtils.isNotBlank(tagInfo.getFw())) {
            showText.append("|").append("fw").append(":").append(tagInfo.getFw());
        }
        if (StringUtils.isNotBlank(tagInfo.getHd())) {
            showText.append("|").append("hd").append(":").append(tagInfo.getHd());
        }
        if (StringUtils.isNotBlank(tagInfo.getLb())) {
            showText.append("|").append("lb").append(":").append(tagInfo.getLb());
        }
        if (StringUtils.isNotBlank(tagInfo.getQt())) {
            showText.append("|").append(tagInfo.getQt());
        }
        TicketProducts ticketProducts = new TicketProducts();
        ticketProducts.setId(id);
        ticketProducts.setShowTxt(showText.toString());
        ticketProducts.setTagFlag(1);
        // 同时修改其他两个字段的标签信息
        ticketProducts.setTagName(tagInfo.getTagName());
        ticketProducts.setTagColor(tagInfo.getTagColor());
        ticketProductsDao.update(ticketProducts);
    }

    /**
     * 查询礼包
     */
    @Override
    public TicketProducts.GiftPackage queryGiftById(Integer id) {
        TicketProducts ticketProducts = ticketProductsDao.queryById(id);
        if (ticketProducts == null) return null;
        TicketProducts.GiftPackage giftPackage = new TicketProducts.GiftPackage();
        giftPackage.setId(ticketProducts.getId());
        giftPackage.setProName(ticketProducts.getProName());
        String giftPackageStr = ticketProducts.getGiftPackage();
        if (StringUtils.isNotBlank(giftPackageStr)) {
            String[] arr = giftPackageStr.split(",", -1); // 避免输入为空出现数组越界异常
            giftPackage.setPtag(arr[0]);
            giftPackage.setPcode(arr[1]);
            giftPackage.setPtype(arr[2]);
            giftPackage.setPcount(StringUtils.defaultString(arr[3], "0"));
            giftPackage.setPprice(arr[4]);
            giftPackage.setPfxtype(StringUtils.defaultString(arr[5], "1"));
        }
        return giftPackage;
    }

    /**
     * 修改礼包
     */
    @Override
    public void doUpdateGift(Integer id, TicketProducts.GiftPackage giftPackage) {
        StringBuffer sb = new StringBuffer();
        sb.append(StringUtils.defaultString(giftPackage.getPtag(), "")).append(",");
        sb.append(StringUtils.defaultString(giftPackage.getPcode(), "")).append(",");
        sb.append(StringUtils.defaultString(giftPackage.getPtype(), "")).append(",");
        sb.append(StringUtils.defaultString(giftPackage.getPcount(), "")).append(",");
        sb.append(StringUtils.defaultString(giftPackage.getPprice(), "")).append(",");
        sb.append(StringUtils.defaultString(giftPackage.getPfxtype(), ""));
        TicketProducts ticketProducts = new TicketProducts();
        ticketProducts.setId(id);
        if (StringUtils.isBlank(giftPackage.getPcode())) {
            ticketProducts.setGiftPackage("");
        } else {
            ticketProducts.setGiftPackage(sb.toString());
        }
        ticketProductsDao.update(ticketProducts);
    }
}