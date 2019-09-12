package com.seckill.user.dao;

import com.seckill.user.pojo.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;

import java.math.BigInteger;
import java.util.List;

/**
 * @Auther: wdd
 * @Date: 2019/9/12 09:06
 * @Description:
 */
@Mapper
public interface UserDao {
    @Select("select id, username, phone, password from tb_user where username = #{username} and password = #{password}")
    List<User> getUser(User user);

    @Insert("insert into tb_user (username, phone, password) values(#{username},#{phone},#{password})")
    @Options(useGeneratedKeys=true, keyProperty="id", keyColumn="id")
    int insertUser(User user);
}
