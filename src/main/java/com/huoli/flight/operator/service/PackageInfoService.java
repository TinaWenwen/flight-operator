package com.huoli.flight.operator.service;

import com.huoli.flight.operator.domain.po.PackageInfo;

import java.util.List;

public interface PackageInfoService {

    /*
     * 查询套餐列表
     */
    List<PackageInfo> queryByCondition();

    /**
     * 通过ID查询套餐
     */
    PackageInfo queryById(int id);

    /**
     * 修改套餐
     */
    void doUpdate(PackageInfo packageInfo);
}
