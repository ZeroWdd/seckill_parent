package com.seckill.user.service;

import com.seckill.user.dao.UserDao;
import com.seckill.user.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: wdd
 * @Date: 2019/9/12 09:06
 * @Description:
 */
@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    public Map<String, Object> getUser(User user){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        //1、判断传入的参数是否有误
        if (StringUtils.isEmpty(user)){
            resultMap.put("result", false);
            resultMap.put("msg", "用户名不能为空！");
            return resultMap;
        }

        //2、取会员列表
        List<User> list = userDao.getUser(user);
        if (list==null||list.isEmpty()){
            resultMap.put("result", false);
            resultMap.put("msg", "没找到会员信息！");
            return resultMap;
        }
        user = list.get(0);

        resultMap.put("user_id", user.getId());
        resultMap.put("username", user.getUsername());
        resultMap.put("phone", user.getPhone());
        resultMap.put("password", user.getPassword());
        resultMap.put("result", true);
        resultMap.put("msg", "");
        return resultMap;
    }

    @Transactional
    public Map<String, Object> insertUser(User user){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        //1、判断传入的参数是否有误
        if (StringUtils.isEmpty(user)){
            resultMap.put("result", false);
            resultMap.put("msg", "用户名不能为空！");
            return resultMap;
        }

        userDao.insertUser(user);

        resultMap.put("user_id", user.getId());
        resultMap.put("username", user.getUsername());
        resultMap.put("phone", user.getPhone());
        resultMap.put("password", user.getPassword());
        resultMap.put("result", true);
        resultMap.put("msg", "");
        return resultMap;
    }
}
