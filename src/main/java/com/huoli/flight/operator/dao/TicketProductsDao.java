package com.huoli.flight.operator.dao;

import com.huoli.flight.operator.domain.po.TicketProducts;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface TicketProductsDao {

    /*
     * 条件查询产品
     */
    List<TicketProducts> queryByCondition(@Param("airLine") String airLine, @Param("dataSrc") String dataSrc, @Param("bookSrc") String bookSrc, @Param("status") Integer status, @Param("sort") Integer sort);

    /**
     * ID查询产品
     */
    TicketProducts queryById(@Param("id") int id);

    /**
     * 新增产品
     */
    @Insert("INSERT INTO TICKET_PRODUCTS(AIRLINE, PROCODE, PRONAME, ALLSEE, ALLBUY, SUBFLAG, PRIORITY, FXFLAG, RULEID, TAGFLAG,\n" +
            "APPLYFLAG, DATASRC, BOOKSRC, SUBCOUNT, FXCOUNT, USERINFO, SHOWTXT, TAGNAME, TAGCOLOR, ICON,\n" +
            "USERTYPE, BOOKPARAM, GIFTPACKAGE, LINKTXT, LINKURL, APPTYPE, EXUSER, TRIPTYPE, SALECONTROL,\n" +
            "CKBUYER) VALUES(#{airLine}, #{proCode}, #{proName}, #{allSee}, #{allBuy}, #{subFlag}, #{priority}, #{fxFlag}, #{ruleId}, #{tagFlag}, #{applyFlag}, #{dataSrc}, #{bookSrc},\n" +
            "#{subCount}, #{fxCount}, #{userInfo}, #{showTxt}, #{tagName}, #{tagColor}, #{icon}, #{userType}, #{bookParam}, #{giftPackage}, #{linkTxt}, #{linkUrl},\n" +
            "#{appType}, #{exUser}, #{tripType}, #{saleControl}, #{ckBuyer})")
    void insert(TicketProducts ticketProducts);

    /**
     * 修改产品
     */
    void update(TicketProducts ticketProducts);

}
