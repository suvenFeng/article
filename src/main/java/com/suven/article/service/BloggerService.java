package com.suven.article.service;

import com.suven.article.entity.Blogger;

import java.util.List;

/**
 * @Description 博主Service接口
 * @author fp942
 * Created by fp942 on 2017/2/25.
 */
public interface BloggerService {

    boolean getByUsername(Blogger blogger);

    //根据用户ID获取用户信息
    public Blogger getBloggerData(Integer id);

    //查询登录用户的所有信息
    public Blogger getAdminData(String username);

    // 更新博主个人信息
    public Integer updateBlogger(Blogger blogger);

    //注册成为博主
    boolean register(Blogger blogger);
}
