package com.suven.article.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.suven.article.entity.*;
import com.suven.article.service.BlogTypeService;
import com.suven.article.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


import com.suven.article.service.BlogService;
import com.suven.article.service.BloggerService;
import com.suven.article.service.CommentService;
import com.suven.article.util.PageUtil;
import com.suven.article.util.StringUtil;

/**
 * @Description 博客Controller层
 * Created by fp942 on 2017/2/28.
 */
@Controller
@RequestMapping("/blog")
public class BlogController {

    @Resource
    private BlogService blogService;
    @Resource
    private CommentService commentService;
    @Resource
    private BlogTypeService blogTypeService;
    @Resource
    private BloggerService bloggerService;



    //打开写博客页面
    @RequestMapping("/writeBlog")
    public ModelAndView writeBlog() {
        ModelAndView modelAndView = new ModelAndView();
        // 获取博客类别信息
        List<BlogType> blogTypeList = blogTypeService.getBlogTypeData();
        modelAndView.addObject("blogTypeList", blogTypeList);
        modelAndView.addObject("commonPage", "foreground/blog/writeBlog.jsp");
        modelAndView.setViewName("mainTemp");
        return modelAndView;
    }
    //添加或更新博客
    @RequestMapping("/save")
    public String save(Blog blog, HttpServletRequest request,HttpServletResponse response) throws Exception {
        //获取到session
        HttpSession session = request.getSession(true);
        //拿到session里的admin实体类
        Blogger admin = (Blogger)session.getAttribute("admin");

        //将session里的用户set到blog的author
        blog.setAuthor(admin.getUsername());

        //将session里的用户ID set到blog的author_id
        blog.setAuthor_id(admin.getId());

        if(blog.getKeyWord() == ""){
            blog.setKeyWord("无");
        }
        int resultTotal = 0; //接收返回结果记录数
        if(blog.getId() == null) {
            //无ID说明是第一次插入
            resultTotal = blogService.addBlog(blog);
        }else{
            //有id表示修改
            resultTotal = blogService.update(blog);
        }
        JSONObject result = new JSONObject();
        if(resultTotal > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        ResponseUtil.write(response, result);
        return null;
    }

    //删除博客
    @RequestMapping("/delete")
    public String delete(Blog blog,HttpServletRequest request,HttpServletResponse response)throws Exception{
        int resultTotal = 0; //接收返回结果记录数
        JSONObject result = new JSONObject();
        if(blog.getId() == null) {//说明选中博客为空
            result.put("success", false);
        }else{
            resultTotal = blogService.deleteBlog(blog.getId());
        }
        if(resultTotal > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        ResponseUtil.write(response, result);
        return null;
    }


    //请求博客详细信息
    @RequestMapping("/articles/{id}")
    public ModelAndView details(@PathVariable("id") Integer id,HttpServletRequest request) {

        ModelAndView modelAndView = new ModelAndView();
        Blog blog = blogService.findById(id); // 根据id获取博客

        // 获取关键字
        String keyWords = blog.getKeyWord();
        if (StringUtil.isNotEmpty(keyWords)) {
            String[] strArray = keyWords.split(" ");
            List<String> keyWordsList = StringUtil.filterWhite(Arrays.asList(strArray));
            modelAndView.addObject("keyWords", keyWordsList);
        } else {
            modelAndView.addObject("keyWords", null);
        }

        modelAndView.addObject("blog", blog);
        blog.setClickHit(blog.getClickHit() + 1); // 将博客访问量加1
        blogService.updateClickHit(blog); // 更新博客

        // 查询评论信息
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("blogId", blog.getId());
        map.put("state", 1);
        List<Comment> commentList = commentService.getCommentData(map);

        modelAndView.addObject("commentList", commentList);
        modelAndView.addObject("commonPage", "foreground/blog/blogDetail.jsp");
        modelAndView.addObject("title", blog.getTitle() + " - " + blog.getAuthor() + "的博客");

        // 存入上一篇和下一篇的显示代码
        modelAndView.addObject("pageCode", PageUtil.getPrevAndNextPageCode(
                blogService.getPrevBlog(id), blogService.getNextBlog(id),
                request.getServletContext().getContextPath()));

        modelAndView.setViewName("mainTemp");

        return modelAndView;
    }

    //跳转到修改博客页面
    @RequestMapping("/edit/{id}")
    public ModelAndView editBlog(@PathVariable("id") Integer id,HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        Blog blog = blogService.findById(id); // 根据id获取博客信息
        List<BlogType> blogTypeList = blogTypeService.getBlogTypeData();// 获取博客类别信息
        modelAndView.addObject("blogTypeList", blogTypeList);
        modelAndView.addObject("blog", blog);
        modelAndView.addObject("commonPage", "foreground/blog/writeBlog.jsp");
        modelAndView.setViewName("mainTemp");
        return modelAndView;
    }
    //打开博客类别管理页面
    @RequestMapping("/blogTypeManager")
    public ModelAndView blogTypeManager() {
        ModelAndView modelAndView = new ModelAndView();
        // 获取博客类别信息
//        List<BlogType> blogTypeList = blogTypeService.getBlogTypeData();
//        modelAndView.addObject("blogTypeList", blogTypeList);
        modelAndView.addObject("commonPage", "foreground/blog/blogTypeManager.jsp");
        modelAndView.addObject("title","博客类别管理");
        modelAndView.setViewName("mainTemp");
        return modelAndView;
    }

    // 分页查询博客类别
//    @RequestMapping("/listBlogType")
//    public String listBlogType(
//            @RequestParam(value = "page", required = false) String page,
//            @RequestParam(value = "rows", required = false) String rows,
//            HttpServletResponse response) throws Exception {
//
//        PageBean pageBean = new PageBean(Integer.parseInt(page),
//                Integer.parseInt(rows));
//        Map<String, Object> map = new HashMap<String, Object>();
//
//        map.put("start", pageBean.getStart());
//        map.put("pageSize", pageBean.getPageSize());
//        List<BlogType> blogTypeList = blogTypeService.listBlogType(map);
//        Long total = blogTypeService.getTotal(map);
//
//        JSONObject result = new JSONObject();
//        JSONArray jsonArray = JSONArray.fromObject(blogTypeList);
//        result.put("rows", jsonArray);
//        result.put("total", total);
//        ResponseUtil.write(response, result);
//        return null;
//    }

    // 添加和更新博客类别
//    @RequestMapping("/saveBlogType")
//    public String save(BlogType blogType, HttpServletResponse response)
//            throws Exception {
//
//        int resultTotal = 0;
//        if (blogType.getId() == null) {
//            resultTotal = blogTypeService.addBlogType(blogType);
//        } else { // 有id表示修改
//            resultTotal = blogTypeService.updateBlogType(blogType);
//        }
//
//        JSONObject result = new JSONObject();
//        if (resultTotal > 0) {
//            result.put("success", true);
//        } else {
//            result.put("success", false);
//        }
//        ResponseUtil.write(response, result);
//        return null;
//    }


    // 博客类别信息删除
//    @RequestMapping("/deleteBlogType")
//    public String deleteBlog(
//            @RequestParam(value = "ids", required = false) String ids,
//            HttpServletResponse response) throws Exception {
//
//        String[] idsStr = ids.split(",");
//        JSONObject result = new JSONObject();
//        for (int i = 0; i < idsStr.length; i++) {
//            int id = Integer.parseInt(idsStr[i]);
//            if(blogService.getBlogByTypeId(id) > 0) {
//                result.put("exist", "该类别下有博客，不能删除!");
//            } else {
//                blogTypeService.deleteBlogType(id);
//            }
//        }
//        result.put("success", true);
//        ResponseUtil.write(response, result);
//        return null;
//    }

}
