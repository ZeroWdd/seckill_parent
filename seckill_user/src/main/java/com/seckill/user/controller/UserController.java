package com.seckill.user.controller;

import com.seckill.user.pojo.User;
import com.seckill.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @Auther: wdd
 * @Date: 2019/9/12 09:04
 * @Description:
 */
@RestController
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public Map<String, Object> login(User user,HttpSession session){
        //1、取会员
        Map<String, Object> userMap = new HashMap<String, Object>();
        userMap = userService.getUser(user);
        //2、没取到会员，写入会员
        if (!(Boolean) userMap.get("result")){
            userMap = userService.insertUser(user);
        }
        //3、写入session
        session.setAttribute("user", userMap);
        //4、返回信息
        return userMap;
    }
}
