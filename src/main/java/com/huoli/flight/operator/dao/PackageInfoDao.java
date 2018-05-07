package com.huoli.flight.operator.dao;

import com.huoli.flight.operator.domain.po.PackageInfo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface PackageInfoDao {

    /*
     * 条件查询套餐
     */
    List<PackageInfo> queryByCondition();

    /**
     * 通过primaryKey(ID)查询套餐
     */
    PackageInfo queryById(Integer id);

    /**
     * 修改套餐
     */
    void update(PackageInfo packageInfo);
}
