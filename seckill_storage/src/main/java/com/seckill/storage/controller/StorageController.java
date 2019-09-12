package com.seckill.storage.controller;

import com.seckill.storage.service.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @Auther: wdd
 * @Date: 2019/9/10 10:48
 * @Description:
 */
@RestController
public class StorageController {

    @Autowired
    private StorageService storageService;

    @RequestMapping(value = "/getStockStorage/{sku_id}")
    public Map<String, Object> getStockStorage(@PathVariable("sku_id") String sku_id){
        return storageService.getStockStorage(sku_id);
    }

    @RequestMapping(value = "/insertStorage/{sku_id}/{inquanty}/{outquanty}")
    public Map<String, Object> insertStorage(@PathVariable("sku_id") String sku_id,
                                             @PathVariable("inquanty") double inquanty, @PathVariable("outquanty") double outquanty){
        return storageService.insertStorage(sku_id, inquanty, outquanty);
    }
}
