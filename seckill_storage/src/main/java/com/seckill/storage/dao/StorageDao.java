package com.seckill.storage.dao;

import com.seckill.storage.pojo.Storage;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * @Auther: wdd
 * @Date: 2019/9/10 10:48
 * @Description:
 */
@Mapper
public interface StorageDao {
    @Select("SELECT id,warehouse_id,sku_id, quanty FROM tb_stock_storage WHERE sku_id = #{sku_id}")
    List<Storage> getStockStorage(String sku_id);

    @Insert("INSERT INTO tb_stock_storage(id,warehouse_id,sku_id,quanty) VALUES(#{id},#{warehouse_id},#{sku_id},#{quanty}) ")
    int insertStockStorage(Long id, String warehouse_id, String sku_id, double quanty);

    @Insert("INSERT INTO tb_stock_storage_history (stock_storage_id, in_quanty, out_quanty) VALUES (#{stock_storage_id},#{in_quanty},#{out_quanty})")
    int updateHistory(Long stock_storage_id,double in_quanty, double out_quanty);

    @Update("UPDATE tb_stock_storage SET quanty = quanty + #{this_quanty} WHERE id = #{new_id} AND quanty + #{quanty} >= 0")
    int updateStorage(double this_quanty, Long new_id, double quanty);
}
