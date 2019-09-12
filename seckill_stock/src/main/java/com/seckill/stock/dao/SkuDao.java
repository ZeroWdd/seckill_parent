package com.seckill.stock.dao;


import com.seckill.stock.pojo.LimitPolicy;
import com.seckill.stock.pojo.Sku;
import com.seckill.stock.pojo.SpuDetail;
import com.seckill.stock.vo.SkuVo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @Auther: wdd
 * @Date: 2019/9/8 12:06
 * @Description:
 */
@Mapper
public interface SkuDao{

    @Select(value = "select tb_sku.id as sku_id, spu_id, title, images, stock, price, indexes, own_spec, enable, create_time, update_time from tb_sku ")
    List<SkuVo> findAll();

    @Select("select tb_sku.spu_id, tb_sku.title, tb_sku.images, tb_sku.stock, tb_sku.price, tb_sku.indexes, " +
                    "tb_sku.own_spec, tb_sku.enable, tb_sku.create_time, tb_sku.update_time,tb_spu_detail.description," +
                    "tb_sku.id AS sku_id,tb_spu_detail.special_spec " +
                    "from tb_sku " +
                    "INNER JOIN tb_spu_detail ON tb_spu_detail.spu_id=tb_sku.spu_id " +
                    "where tb_sku.id = #{sku_id}")
    List<SkuVo> getStock(String sku_id);

    @Insert("insert into tb_limit_policy (sku_id, quanty, price, begin_time, end_time) " +
            "Values (#{sku_id}, #{quanty}, #{price}, #{begin_time}, #{end_time})")
    int insertLimitPolicy(LimitPolicy limitPolicy);
}
