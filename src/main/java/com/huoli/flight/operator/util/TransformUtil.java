package com.huoli.flight.operator.util;

import com.huoli.flight.operator.domain.dto.ProductDto;
import com.huoli.flight.operator.domain.po.TicketProducts;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.BeanUtils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TransformUtil {

    public static String transTripType(String tripType) {
        if (StringUtils.isEmpty(tripType)) {
            tripType = "全部";
        } else if ("OW".equals(tripType)) {
            tripType = "单程";
        } else if ("RT".equals(tripType)) {
            tripType = "往返";
        } else if ("MP".equals(tripType)) {
            tripType = "多程";
        }
        return tripType;
    }

    public static String transAppType(String appType) {
        if (StringUtils.isEmpty(appType)) {
            appType = "全部";
        } else if ("gtgj".equals(appType)) {
            appType = "高铁管家";
        } else if ("hbgj".equals(appType)) {
            appType = "航班管家";
        } else if ("web".equals(appType)) {
            appType = "H5平台";
        }
        return appType;
    }

    public static String transTagColor(String tagColor) {
        if (StringUtils.isEmpty(tagColor)) {
            tagColor = "";
        } else if ("19,142,234,1".equals(tagColor)) {
            tagColor = "蓝色";
        } else if ("62,158,21,1".equals(tagColor)) {
            tagColor = "绿色";
        } else if ("255,114,0,1".equals(tagColor)) {
            tagColor = "橙色";
        } else if ("226,58,19,1".equals(tagColor)) {
            tagColor = "红色";
        }
        return tagColor;
    }

    public static TicketProducts transTicketProducts(ProductDto productDto) {
        TicketProducts ticketProducts = new TicketProducts();
        BeanUtils.copyProperties(productDto, ticketProducts);

        //运价方式
        String proCode;
        if (productDto.getPriceFlag() == 4) {
            proCode = "*";
        } else {
            proCode = productDto.getProCode();
        }
        ticketProducts.setProCode(proCode);

        // 是否加减价
        int isPriceChange = productDto.getIsPriceChange();
        int changePrice = productDto.getChangePrice();
        int isFixed = productDto.getSubisFixed();
        double subCount = productDto.getSubCount();
        if (isPriceChange == 1) {
            if (changePrice == 1) {// 加价
                if (isFixed == 1) {// 固定金额 数据库显示为负数
                    subCount = -subCount;
                }
            }
        }
        ticketProducts.setSubCount(subCount);

        // 是否全部可见 不可见用户信息
        int allSee = productDto.getAllSee();
        if (allSee == 0) {//部分用户可见 需设置可见用户信息
            ticketProducts.setUserInfo(productDto.getUserInfo());
        }
        ticketProducts.setAllSee(allSee);

        // 航程类型
        String tripType = productDto.getTripType();
        if (StringUtils.isBlank(tripType)) {//都没选 则默认全部
            ticketProducts.setTripType("");
        } else {
            ticketProducts.setTripType(tripType);
        }

        // 适用app类型
        String appType = productDto.getAppType();
        if (StringUtils.isBlank(appType)) {//都没选 则默认全部
            ticketProducts.setAppType("");
        } else {
            ticketProducts.setAppType(appType);
        }

        // 购买限制
        if (productDto.getAllBuy() == 0) {//部分可购买
            String psnum = productDto.getPsnum();
            String gender = productDto.getGender();
            String pstype = productDto.getPstype();
            String adidtypes = productDto.getAdidtypes();
            int ageLimit = productDto.getAgeLimit();
            int cardLimit = productDto.getCardLimit();
            if (psnum.equals("0") && gender.equals("0") && pstype.equals("0") && adidtypes.equals("0") && ageLimit == 0 && cardLimit == 0) { //点击乘机人限制但并未选择具体限制的情况 避免出现插入{}数据
                ticketProducts.setSaleControl("");
            } else {
                JSONObject saleControl = new JSONObject();
                int allBuy = productDto.getAllBuy();
                Integer minAge = productDto.getMinAge();
                Integer maxAge = productDto.getMaxAge();
                String psage;

                String idtype = productDto.getIdtype();
                if (allBuy == 0) {//购买限制
                    if (!"0".equals(psnum)) {
                        saleControl.put("psnum", psnum);
                    }
                    if (!"0".equals(gender)) {
                        saleControl.put("gender", gender);
                    }
                    if (!"0".equals(pstype)) {
                        saleControl.put("pstype", pstype);
                    }
                    if (!"0".equals(adidtypes)) {
                        saleControl.put("adidtypes", adidtypes);
                    }

                    if (ageLimit == 1) {//限制年龄
                        if (null != minAge && null != maxAge) { //判断用户是否输入年龄限制
                            psage = "[" + minAge + "," + maxAge + "]";
                            saleControl.put("psage", psage);
                        }
                    }
                    if (cardLimit == 1) {//证件限制
                        saleControl.put("idtype", idtype);
                    }
                }
                ticketProducts.setSaleControl(saleControl.toString());
            }
        }
        if (productDto.getAllBuy() == 1) {//购买无限制
            ticketProducts.setSaleControl("");
        }
        ticketProducts.setAllBuy(productDto.getAllBuy());
        return ticketProducts;
    }

    public static ProductDto transProductDto(TicketProducts ticketProducts) {
        ProductDto productDto = new ProductDto();
        BeanUtils.copyProperties(ticketProducts, productDto);

        // 运价匹配方式
        String proCode = ticketProducts.getProCode();
        if (proCode.toLowerCase().startsWith("cabin")) {// 按舱位匹配
            productDto.setPriceFlag(0);
        } else {
            if (StringUtils.equals(proCode, "*")) { // 全渠道匹配
                productDto.setPriceFlag(4);
            } else {
                Pattern p = Pattern.compile("^([0-9]{1}\\d?\\*?[,]?){1,}$"); // 政策ID
                Matcher matcher = p.matcher(proCode);
                if (matcher.find()) {
                    productDto.setPriceFlag(1);
                } else {
                    p = Pattern.compile("^([a-z]{1}[a-zA-Z]+[\\*]?[,]?)+$");// 供应商渠道
                    matcher = p.matcher(proCode);
                    if (matcher.find()) {
                        productDto.setPriceFlag(3);
                    } else {// 产品代码
                        productDto.setPriceFlag(2);
                    }
                }
            }
        }
        productDto.setProCode(proCode);

        // 是否返现
        productDto.setFxFlag(ticketProducts.getFxFlag());
        if (ticketProducts.getFxCount() < 1 && ticketProducts.getFxCount() > 0) {// 幅度方式
            productDto.setFxisFixed(0);
        } else {
            productDto.setFxisFixed(1);// 固定方式
        }
        productDto.setFxCount(Math.abs(ticketProducts.getFxCount()));

        // 加减价
        productDto.setSubCount(Math.abs(ticketProducts.getSubCount()));
        if (ticketProducts.getSubCount() == 0) {// 不加减价
            productDto.setIsPriceChange(0);
        } else {
            productDto.setIsPriceChange(1);
            if (ticketProducts.getSubCount() > 1) {// 正数 直减
                productDto.setChangePrice(0);
            }
            if (ticketProducts.getSubCount() < 0) {
                productDto.setChangePrice(1);// 加价
            }
            if (ticketProducts.getSubCount() > 0 && ticketProducts.getSubCount() < 1) {// 幅度方式
                productDto.setSubisFixed(0);
            } else {
                productDto.setSubisFixed(1);// 固定金额
            }
        }

        // 是否全部用户可见
        productDto.setAllSee(ticketProducts.getAllSee());
        if (ticketProducts.getAllSee() == 0) {// 部分可见
            productDto.setUserInfo(ticketProducts.getUserInfo());
        }

        productDto.setCkBuyer(ticketProducts.getCkBuyer());
        productDto.setExUser(ticketProducts.getExUser());

        // 航程类型
        String tripType = ticketProducts.getTripType();
        if (StringUtils.isBlank(tripType)) {
            productDto.setTripType("");// 无限制被选中
        } else {
            productDto.setTripType(tripType);
        }

        // APP类型
        String appType = ticketProducts.getAppType();
        if (StringUtils.isBlank(appType)) {
            productDto.setAppType("");// 无限制被选中
        } else {
            productDto.setAppType(appType);
        }

        productDto.setAllBuy(ticketProducts.getAllBuy());

        // 购买限制
        JSONObject salecontrol = null;
        if (StringUtils.isNotBlank(ticketProducts.getSaleControl())) {
            salecontrol = new JSONObject(ticketProducts.getSaleControl());
        }
        if (salecontrol != null && salecontrol.keys().hasNext()) {
            if (salecontrol.keySet().contains("psnum")) {
                productDto.setPsnum(salecontrol.getString("psnum"));
            }
            if (salecontrol.keySet().contains("gender")) {
                productDto.setGender(salecontrol.getString("gender"));
            }
            if (salecontrol.keySet().contains("pstype")) {
                productDto.setPstype(salecontrol.getString("pstype"));
            }
            if (salecontrol.keySet().contains("adidtypes")) {
                productDto.setAdidtypes(salecontrol.getString("adidtypes"));
            }
            String psage = null;
            if (salecontrol.keySet().contains("psage")) {//限制年龄
                psage = salecontrol.getString("psage");
            }
            if (StringUtils.isNotBlank(psage)) {
                productDto.setAgeLimit(1);
                productDto.setMinAge(Integer.parseInt(psage.substring(psage.indexOf("[") + 1, psage.indexOf(","))));
                productDto.setMaxAge(Integer.parseInt(psage.substring(psage.indexOf(",") + 1, psage.indexOf("]"))));
            } else {
                productDto.setAgeLimit(0);
            }
            String idtype = "";
            if (salecontrol.keySet().contains("idtype")) {//限制年龄
                idtype = salecontrol.getString("idtype");
            }
            if (StringUtils.isNotBlank(idtype)) {
                productDto.setCardLimit(1);
            } else {
                productDto.setCardLimit(0);
            }
            productDto.setIdtype(idtype);
        }
        productDto.setBookParam(ticketProducts.getBookParam());
        productDto.setRuleId(ticketProducts.getRuleId());
        return productDto;
    }
}
