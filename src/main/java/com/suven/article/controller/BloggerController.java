package com.suven.article.controller;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.suven.article.entity.Blog;
import com.suven.article.entity.BlogType;
import com.suven.article.entity.Blogger;
import com.suven.article.entity.PageBean;
import com.suven.article.service.BlogService;
import com.suven.article.service.BlogTypeService;
import com.suven.article.service.BloggerService;
import com.suven.article.util.*;
import net.sf.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description 博主Controller层，前台部分，不需要认证
 * Created by fp942 on 2017/3/6.
 */
@Controller
@RequestMapping("/blogger")
public class BloggerController {
    
    @Resource
    private BloggerService bloggerService;

    @Resource
    private BlogService blogService;

    @Resource
    private BlogTypeService blogTypeService;

    //登录
    @RequestMapping("/login")
    public String login(Blogger blogger, HttpServletRequest request) {
        //调用login方法来验证是否是注册用户
        boolean login = bloggerService.getByUsername(blogger);
        JSONObject result = new JSONObject();
        if(login) {
            //如果登陆成功，查询该用户的所有信息
            Blogger admin = bloggerService.getAdminData(blogger.getUsername());
            //获得session
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(30*60);
            request.getSession().setAttribute("admin", admin);
            result.put("success", true);
            return "redirect:/index.do";
        } else{
            //若验证失败，则将信息显示到错误页面
            request.setAttribute("errorInfo", "用户名或密码错误");
            result.put("success", false);
            return "login";
        }
    }
    //注册
    @RequestMapping("/register")
    public String register(Blogger  blogger,HttpServletRequest request){
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String profile = request.getParameter("profile");
        String nickname = request.getParameter("nickname");
        String sign = request.getParameter("sign");
        String imagename = request.getParameter("imagename");
        boolean register = bloggerService.register(blogger);
        if(register){
            return "login";
        }
        return "register";
    }

    //注销登录账户
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession(false);//防止创建Session
        if(session == null){
            try {
                response.sendRedirect("/blogger/login.do");
            } catch (IOException e) {
                e.printStackTrace();
            }
            session.removeAttribute("admin");
        }
        return "redirect:/blogger/login.do";
    }
    //个人资料
    @RequestMapping("/aboutMe")
    public ModelAndView aboutMe(
            @RequestParam(value = "page", required = false) String page,
            @RequestParam(value = "releaseDateStr", required = false) String releaseDateStr,
            HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();

        //获得session
        HttpSession session = request.getSession(true);
        //获得session中保留的信息
        Blogger admin = (Blogger)session.getAttribute("admin");

//        if (StringUtil.isEmpty(page)) {
//            page = "1";
//        }
        // 获取分页的bean
//        PageBean pageBean = new PageBean(Integer.parseInt(page), 5); //每页显示10条数据
        // map中封装起始页和每页的记录
        Map<String, Object> map = new HashMap<String, Object>();
//        map.put("start", pageBean.getStart());
//        map.put("pageSize", pageBean.getPageSize());
        map.put("releaseDateStr", releaseDateStr);
        map.put("authorId",admin.getId());
        //查询当前登录用户的所有文章
        List<Blog> adminBlogList = blogService.findByUserId(map);
        for(Blog blog : adminBlogList) {
            String blogInfo = blog.getContent(); //获取博客内容
            Document doc = Jsoup.parse(blogInfo); //将博客内容(网页中也就是一些html)转为jsoup的Document
//            blog.setImagename(admin.getImagename());
        }
        // 分页
        StringBuffer param = new StringBuffer();
        if(StringUtil.isNotEmpty(releaseDateStr)) {
            param.append("releaseDateStr=" + releaseDateStr + "&");
        }
//        modelAndView.addObject("pageCode", PageUtil.genPagination(
//            request.getContextPath() + "/index.html",
//            blogService.getTotal(map),
//            Integer.parseInt(page), 5,
//            param.toString()));
        modelAndView.addObject("adminBlogList", adminBlogList);
        modelAndView.addObject("commonPage", "foreground/blogger/bloggerInfo.jsp");
        modelAndView.addObject("adminBlogPage", "../blog/adminBlog.jsp");
        modelAndView.addObject("title", "关于博主");
        modelAndView.setViewName("mainTemp");
        return modelAndView;
    }

    //跳转修改资料
    @RequestMapping("/modifyInfo")
    public ModelAndView modifyInfo(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        //获得session
        HttpSession session = request.getSession(true);
        //获得session中保留的信息
        Blogger admin = (Blogger)session.getAttribute("admin");
        Blogger blogger = bloggerService.getBloggerData(admin.getId());
        modelAndView.addObject("blogger", blogger);
        modelAndView.addObject("commonPage", "foreground/blogger/modifyInfo.jsp");
        modelAndView.setViewName("mainTemp");
        return modelAndView;
    }
    // 查询博主信息
    @RequestMapping("/findBlogger/{id}")
    public String findBlogger(@PathVariable("id") Integer id,HttpServletResponse response) throws Exception {
        Blogger blogger = bloggerService.getBloggerData(id);
        JSONObject jsonObject = JSONObject.fromObject(blogger);
        ResponseUtil.write(response, jsonObject);
        return null;
    }
    //修改资料信息
    @RequestMapping("/modifyInfo/save")
    public String save(
            @RequestParam("imageFile") MultipartFile imageFile,
            Blogger blogger,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        if(!imageFile.isEmpty()) { //如果用户有传过照片，就更新
            String filePath = request.getServletContext().getRealPath("/"); //获取服务器根路径
            String imageName = DateUtil.getCurrentDateStr() + "." + imageFile.getOriginalFilename().split("\\.")[1];
            imageFile.transferTo(new File(filePath + "static/userImages/" + imageName));
            blogger.setImagename(imageName);
        }
        //获得session
        HttpSession session = request.getSession(true);
        //获得session中保留的信息
        Blogger admin = (Blogger)session.getAttribute("admin");
        //将当前登录用户的ID拿出来更新该ID博主信息
        blogger.setId(admin.getId());
        int resultTotal = bloggerService.updateBlogger(blogger);
        JSONObject result = new JSONObject();
        if(resultTotal > 0) {

            //更新session
            session.removeAttribute("admin");
            admin = bloggerService.getAdminData(blogger.getUsername());
            request.getSession().setAttribute("admin", admin);
            result.put("success", true);
            //更新成功就重定向到个人资料页面
            return "redirect:/blogger/aboutMe.html";
        } else {
            result.put("success", false);
        }
        ResponseUtil.write(response, result);
        return null;
    }


    @RequestMapping("/resource")
    public ModelAndView resource() {
        ModelAndView modelAndView = new ModelAndView();
        //
        //....
        modelAndView.addObject("commonPage", "foreground/blogger/resource.jsp");
        modelAndView.setViewName("mainTemp");
        return modelAndView;
    }
}
