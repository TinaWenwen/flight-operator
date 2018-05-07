package com.huoli.flight.operator.dao;

import com.huoli.flight.operator.domain.po.TicketActivity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface TicketActivityDao {

    /*
     * 条件查询活动
     */
    List<TicketActivity> queryByCondition(@Param("title") String title, @Param("status") Integer status, @Param("type") Integer type);

    /**
     * 通过primaryKey(ID)查询活动
     */
    @Select("SELECT * FROM TICKET_ACTIVITY WHERE id=#{id}")
    TicketActivity queryById(@Param("id") Integer id);

    /**
     * 通过dataCode查询活动
     */
    @Select("SELECT * FROM TICKET_ACTIVITY WHERE data_code=#{dataCode} AND type = #{type} LIMIT 1")
    TicketActivity queryByDataCode(@Param("dataCode") String dataCode, @Param("type") Integer type);

    /**
     * 新增产品
     */
    void insert(TicketActivity ticketActivity);

    /**
     * 修改产品
     */
    void update(TicketActivity ticketActivity);

    /**
     * 修改状态
     */
    @Update("UPDATE TICKET_ACTIVITY SET status=#{status} WHERE id=#{id}")
    void updateStatus(@Param("id") Integer id, @Param("status") Integer status);
}

