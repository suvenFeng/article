package com.suven.article.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.suven.article.dao.BlogDao;
import com.suven.article.entity.Blog;
import com.suven.article.service.BlogService;
import org.springframework.stereotype.Service;
/**
 * @Description 博客Service实现类
 * Created by fp942 on 2017/3/6.
 */
@Service("blogService")
public class BlogServiceImpl implements BlogService {
    @Resource
    private BlogDao blogDao;

    public List<Blog> getBlogData() {

        return blogDao.getBlogData();
    }

    public List<Blog> listBlog(Map<String, Object> map) {
        return blogDao.listBlog(map);
    }

    public Long getTotal(Map<String, Object> map) {
        return blogDao.getTotal(map);
    }

    public Blog findById(Integer id) {
        return blogDao.findById(id);
    }

    public List<Blog> findByUserId(Map<String, Object> map){
        return blogDao.findByUserId(map);
    }
    public Integer update(Blog blog) {
        return blogDao.update(blog);
    }

    @Override
    public Integer updateClickHit(Blog blog) {
        return blogDao.updateClickHit(blog);
    }

    public Blog getPrevBlog(Integer id) {
        return blogDao.getPrevBlog(id);
    }

    public Blog getNextBlog(Integer id) {
        return blogDao.getNextBlog(id);
    }

    public Integer addBlog(Blog blog) {
        return blogDao.addBlog(blog);
    }

    public Integer deleteBlog(Integer id) {
        return blogDao.deleteBlog(id);
    }

    public Integer getBlogByTypeId(Integer typeId) {
        return blogDao.getBlogByTypeId(typeId);
    }


}
