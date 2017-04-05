package com.suven.article.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.suven.article.dao.BlogTypeDao;
import com.suven.article.entity.BlogType;
import com.suven.article.service.BlogTypeService;
import org.springframework.stereotype.Service;
/**
 * @Description 博客类别Service实现类
 * Created by fp942 on 2017/3/6.
 */
@Service("blogTypeService")
public class BlogTypeServiceImpl implements BlogTypeService {
    @Resource
    private BlogTypeDao blogTypeDao;

    //获取博客类别信息
    public List<BlogType> getBlogTypeData() {

        return blogTypeDao.getBlogTypeData();
    }

    public List<BlogType> listBlogType(Map<String, Object> map) {
        return blogTypeDao.listBlogType(map);
    }

    public Long getTotal(Map<String, Object> map) {
        return blogTypeDao.getTotal(map);
    }

    public Integer addBlogType(BlogType blogType) {
        return blogTypeDao.addBlogType(blogType);
    }

    public Integer updateBlogType(BlogType blogType) {
        return blogTypeDao.updateBlogType(blogType);
    }

    public Integer deleteBlogType(Integer id) {
        return blogTypeDao.deleteBlogType(id);
    }
}
