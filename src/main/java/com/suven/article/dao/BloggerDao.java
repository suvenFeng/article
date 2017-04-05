package com.suven.article.dao;

import com.suven.article.entity.Blogger;

import java.util.List;


/**
 * @Description 博客Dao接口
 * @author fp942
 * Created by fp942 on 2017/2/25.
 */
public interface BloggerDao {

    //通过用户名查询博主
    public Blogger getByUsername(String username);

    //根据ID获取用户信息
    public Blogger getBloggerData(Integer id);

    //获取登录用户的所有信息
    public Blogger getAdminData(String username);

    // 更新博主个人信息
    public Integer updateBlogger(Blogger blogger);

    //添加博主
    public int addBlogger(Blogger blogger);
}
