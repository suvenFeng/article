package com.suven.article.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.suven.article.entity.Blog;
import com.suven.article.entity.Blogger;
import com.suven.article.entity.Comment;
import com.suven.article.entity.PageBean;
import com.suven.article.service.BlogService;
import com.suven.article.service.BloggerService;
import com.suven.article.service.CommentService;
import com.suven.article.util.DateJsonValueProcessor;
import com.suven.article.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * CommentController
 * Created by fp942 on 2017/3/6.
 */

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Resource
    private CommentService commentService;
    @Resource
    private BlogService blogService;
    @Resource
    private BloggerService bloggerService;

    // 后台分页查询评论信息
    @RequestMapping("/listComment")
    public String listBlog(
            @RequestParam(value = "page", required = false) String page,
            @RequestParam(value = "rows", required = false) String rows,
            @RequestParam(value = "state", required = false) String state,
            HttpServletResponse response) throws Exception {

        PageBean pageBean = new PageBean(Integer.parseInt(page),
                Integer.parseInt(rows));
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", pageBean.getStart());
        map.put("pageSize", pageBean.getPageSize());
        map.put("state", state);
        List<Comment> commentList = commentService.getCommentData(map);
        Long total = commentService.getTotal(map);

        JSONObject result = new JSONObject();
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(java.util.Date.class, (JsonValueProcessor) new DateJsonValueProcessor("yyyy-MM-dd"));
        JSONArray jsonArray = JSONArray.fromObject(commentList, jsonConfig);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }


    // 评论审核
    @RequestMapping("/review")
    public String review(
            @RequestParam(value = "ids", required = false) String ids,
            @RequestParam(value = "state", required = false) Integer state,
            HttpServletResponse response) throws Exception {

        String[] idsStr = ids.split(",");
        JSONObject result = new JSONObject();
        for (int i = 0; i < idsStr.length; i++) {
            Comment comment = new Comment();
            comment.setId(Integer.parseInt(idsStr[i]));
            comment.setState(state);
            commentService.update(comment);
        }
        result.put("success", true);
        ResponseUtil.write(response, result);
        return null;
    }


    //添加或者修改评论
    @RequestMapping("/save")
    public String save(Comment comment,
            @RequestParam("imageCode")String imageCode, //前台传来的验证码
            HttpServletRequest request,
            HttpServletResponse response,
            HttpSession session) throws Exception {
        JSONObject result = new JSONObject();
        //拿到session里的admin实体类,相当于获取到当前登录用户的信息
        Blogger admin = (Blogger)session.getAttribute("admin");
        String sRand = (String) session.getAttribute("sRand");
        //获取session中正确的验证码，验证码产生后会存到session中的

        int resultTotal = 0; //执行记录数
        if (!imageCode.equals(sRand)) {
            result.put("success", false);
            result.put("errorInfo", "验证码有误");
        } else {
            comment.setNickname(admin.getNickname());  //将nickname设置进去
            if (comment.getId() == null) { //没有id表示添加
                resultTotal = commentService.addComment(comment); //添加评论
                Blog blog = blogService.findById(comment.getBlog().getId()); //更新一下博客的评论次数
                blog.setReplyHit(blog.getReplyHit() + 1);
                blogService.update(blog);
            } else { //有id表示修改

            }
        }
        //判断是否添加成功
        if (resultTotal > 0) {
            result.put("success", true);
        }
        ResponseUtil.write(response, result);
        return null;
    }

    // 评论信息删除
    @RequestMapping("/deleteComment")
    public String deleteBlog(
            @RequestParam(value = "ids", required = false) String ids,
            HttpServletResponse response) throws Exception {

        String[] idsStr = ids.split(",");
        for (int i = 0; i < idsStr.length; i++) {
            commentService.deleteComment(Integer.parseInt(idsStr[i]));
        }
        JSONObject result = new JSONObject();
        result.put("success", true);
        ResponseUtil.write(response, result);
        return null;
    }
}
