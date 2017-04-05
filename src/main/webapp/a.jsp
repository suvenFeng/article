<%--
  Created by IntelliJ IDEA.
  User: fp942
  Date: 2017/3/6
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 重定向到index.html，让springmvc接收，这里.html是伪静态
springmvc接收所有.do和.html结尾的请求 -->
<% response.sendRedirect("index.html"); %>