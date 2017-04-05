package com.suven.article.service.impl;

import javax.annotation.Resource;

import com.suven.article.dao.BloggerDao;
import com.suven.article.entity.Blogger;
import com.suven.article.service.BloggerService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description 博主Service实现类
 * @author fp942
 * Created by fp942 on 2017/2/25.
 */
@Service("bloggerService")
public class BloggerServiceImpl implements BloggerService {

    @Resource
    private BloggerDao bloggerDao;

    //根据用户名查询博主信息，用于登陆
    public boolean getByUsername(Blogger blogger) {

        //对输入账号进行查询,取出数据库中保存对信息
        Blogger user = bloggerDao.getByUsername(blogger.getUsername());
        if(user != null && user.getUsername().equals(blogger.getUsername()) && user.getPassword().equals(blogger.getPassword())){
            return true;
        }
        return false;
    }

    //根绝ID获取用户信息
    public Blogger getBloggerData(Integer id) {
        return bloggerDao.getBloggerData(id);
    }

    //获取博主信息
    public Blogger getAdminData(String username) {
        return bloggerDao.getAdminData(username);
    }

    //更改博主资料
    public Integer updateBlogger(Blogger blogger) {
        return bloggerDao.updateBlogger(blogger);
    }

    //注册成为博主
    public boolean register(Blogger blogger) {
        if(bloggerDao.getByUsername(blogger.getUsername())!=null){
            try {
                throw new Exception("注册的用户名已存在！！！");
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        bloggerDao.addBlogger(blogger);
        return true;
    }

}
