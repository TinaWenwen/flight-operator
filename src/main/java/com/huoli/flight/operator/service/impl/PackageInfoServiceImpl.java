package com.huoli.flight.operator.service.impl;

import com.huoli.flight.operator.dao.PackageInfoDao;
import com.huoli.flight.operator.domain.po.PackageInfo;
import com.huoli.flight.operator.service.PackageInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PackageInfoServiceImpl implements PackageInfoService {

    @Autowired
    private PackageInfoDao packageInfoDao;

    /*
     * 查询套餐列表
     */
    @Override
    public List<PackageInfo> queryByCondition() {
        return packageInfoDao.queryByCondition();
    }

    /**
     * 通过ID查询套餐
     */
    @Override
    public PackageInfo queryById(int id) {
        return packageInfoDao.queryById(id);
    }

    /**
     * 修改套餐
     */
    @Override
    public void doUpdate(PackageInfo packageInfo) {
        packageInfoDao.update(packageInfo);
    }
}
