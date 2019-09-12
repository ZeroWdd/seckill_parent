package com.seckill.stock.controller;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.seckill.stock.pojo.LimitPolicy;
import com.seckill.stock.service.SkuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @Auther: wdd
 * @Date: 2019/9/8 12:05
 * @Description:
 */
@Controller
public class SkuController {
    @Autowired
    private SkuService skuService;

    // json处理工具
    private ObjectMapper jsonMapper = new ObjectMapper();

    @RequestMapping("/getStockList")
    @ResponseBody
    public Map<String,Object> findAll(){
        return skuService.findAll();
    }

    @RequestMapping("/getStock/{sku_id}")
    @ResponseBody
    public Map<String,Object> getStock(@PathVariable String sku_id){
        return skuService.getStock(sku_id);
    }

    @RequestMapping(value = "/insertLimitPolicy/{jsonObj}")
    @ResponseBody
    public Map<String, Object> insertLimitPolicy(@PathVariable("jsonObj") String jsonObj) throws IOException {
        System.out.println(jsonObj);
        //LimitPolicy limitPolicy = jsonMapper.readValue(jsonObj, LimitPolicy.class);
        LimitPolicy limitPolicy = JSONObject.parseObject(jsonObj, LimitPolicy.class);
        return skuService.insertLimitPolicy(limitPolicy);
    }
}
