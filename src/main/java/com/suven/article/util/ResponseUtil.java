package com.suven.article.util;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
/**
 * Created by fp942 on 2017/3/6.
 */
public class ResponseUtil {

    public static void write(HttpServletResponse response, Object obj)throws Exception{
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(obj.toString());
        out.flush();
        out.close();
    }
}
