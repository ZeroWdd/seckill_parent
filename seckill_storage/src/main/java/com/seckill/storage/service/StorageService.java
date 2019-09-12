package com.seckill.storage.service;

import com.seckill.storage.dao.StorageDao;
import com.seckill.storage.pojo.Storage;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import util.IdWorker;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: wdd
 * @Date: 2019/9/10 10:48
 * @Description:
 */
@Service
public class StorageService {
    @Autowired
    private StorageDao storageDao;
    @Autowired
    private IdWorker idWorker;
    @Autowired
    private RabbitTemplate rabbitTemplate;

    public Map<String,Object> getStockStorage(String sku_id){
        //1、先取得一个商品的库存
        List<Storage> storageList = storageDao.getStockStorage(sku_id);

        //2、判断如果stockDao取出的商品为空，返回一个提示
        Map<String, Object> resultMap = new HashMap<String, Object>();
        if (storageList==null||storageList.isEmpty()){
            resultMap.put("result", false);
            resultMap.put("msg", "完了，服务器挂了，数据没取出来！");
            return resultMap;
        }

        //3、判断如果取出的商品不为空，返回数据
        resultMap.put("storage", storageList);
        resultMap.put("result", true);
        resultMap.put("msg", "");
        return resultMap;
    }

    @Transactional
    public Map<String,Object> insertStorage(String sku_id, double in_quanty, double out_quanty){
        Map<String, Object> resultMap = new HashMap<>();
        //判断参数是否为空
        if (sku_id.equals("")){
            resultMap.put("result", false);
            resultMap.put("msg", "商品的sku不能为空！");
            return resultMap;
        }
        if (in_quanty==0&&out_quanty==0){
            resultMap.put("result", false);
            resultMap.put("msg", "入库数量和出库数量不能同时为0！");
            return resultMap;
        }
        //1、查询库存主表是否有库存
        List<Storage> storageList = storageDao.getStockStorage(sku_id);
        Long new_id = new Long(0);
        double thisQuanty = in_quanty - out_quanty;
        boolean result = false;
        //2、如果有库存，获取id，作用一写入历史表，作用二反回来更新
        if (storageList!=null&&storageList.size()>0){
            new_id = storageList.get(0).getId().longValue();
            int flag = storageDao.updateStorage(thisQuanty, new_id, thisQuanty);
            if(flag != 1){
                resultMap.put("result", false);
                resultMap.put("msg", "更新库存主表失败了！");
                return resultMap;
            }
        }else{
            //3、如果没有库存，写入主表库存，并且得到id，作用写入历史表
            new_id = idWorker.nextId();
            int flag = storageDao.insertStockStorage(new_id,"1",sku_id, thisQuanty);
            if(flag != 1){
                resultMap.put("result", false);
                resultMap.put("msg", "写入库存主表失败了！");
                return resultMap;
            }
        }
        //4、写入历史表
        int flag = storageDao.updateHistory(new_id, in_quanty, out_quanty);
        if(flag != 1){
            resultMap.put("result", false);
            resultMap.put("msg", "写入库存历史表失败了！");
            return resultMap;
        }
        //6、返回正常数据
        resultMap.put("result", true);
        resultMap.put("msg", "");
        return resultMap;
    }
}
