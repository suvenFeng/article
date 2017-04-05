<%--
  Created by IntelliJ IDEA.
  User: fp942
  Date: 2017/3/6
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>原创文字-登录</title>
    <script src="${pageContext.request.contextPath}/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/login.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/common.css"/>
    <SCRIPT type="text/javascript">
        $(function() {
            //得到焦点
            $("#password").focus(function() {
                $("#left_hand").animate({
                    left : "150",
                    top : " -38"
                }, {
                    step : function() {
                        if (parseInt($("#left_hand").css("left")) > 140) {
                            $("#left_hand").attr("class", "left_hand");
                        }
                    }
                }, 2000);
                $("#right_hand").animate({
                    right : "-64",
                    top : "-38px"
                }, {
                    step : function() {
                        if (parseInt($("#right_hand").css("right")) > -70) {
                            $("#right_hand").attr("class", "right_hand");
                        }
                    }
                }, 2000);
            });
            //失去焦点
            $("#password").blur(function() {
                $("#left_hand").attr("class", "initial_left_hand");
                $("#left_hand").attr("style", "left:100px;top:-12px;");
                $("#right_hand").attr("class", "initial_right_hand");
                $("#right_hand").attr("style", "right:-112px;top:-12px");
            });
        });

        //验证用户名和密码不能为空
        function checkForm() {
            var username = $("#username").val();
            var password = $("#password").val();
            if (username == null || username == "") {
                $("#error").html("用户名不能为空！");
                return false;
            }
            if (password == null || password == "") {
                $("#error").html("密码不能为空！");
                return false;
            }
            return true;
        }
    </SCRIPT>
    <STYLE>
        .login-border{
            background: rgb(255, 255, 255);
            margin: -100px auto auto;
            border: 1px solid rgb(231, 231, 231);
            border-image: none;
            width: 400px;
            height: 180px;
            text-align: center;
        }
    </STYLE>
</head>
<body>
<div class='show'>
    <img src = "${pageContext.request.contextPath}/static/images/msg.png" />
</div>
<DIV class="top_div"></DIV>
<form action="${pageContext.request.contextPath}/blogger/login.do" method="post" onsubmit="return checkForm()">
    <DIV class="login-border">
        <DIV style="width: 165px; height: 96px; position: absolute;">
            <DIV class="tou"></DIV>
            <DIV class="initial_left_hand" id="left_hand"></DIV>
            <DIV class="initial_right_hand" id="right_hand"></DIV>
        </DIV>
        <P style="padding: 30px 0px 10px; position: relative;">
            <SPAN class="u_logo"></SPAN>
            <INPUT id="username" name="username" class="ipt" type="text"
                   placeholder="请输入用户名">
        </P>
        <P style="position: relative;">
            <SPAN class="p_logo"></SPAN>
            <INPUT id="password" name="password" class="ipt" type="password"
                   placeholder="请输入密码">
        </P>
        <DIV style="height: 40px; line-height: 40px; margin-top: 20px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
            <P style="margin: 0px 35px 20px 45px;">
                <SPAN style="float: left;">没有账号？<a style="color:#3499da" href="${pageContext.request.contextPath}/register.jsp">注册</a></SPAN>
                <span>
                        <font color="red" id="error">${errorInfo }</font>
                    </span>
                <SPAN style="float: right;">
                        <input type="submit" style="background: rgb(0, 142, 173); padding: 7px 10px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;" value="登录" />
                    </SPAN>
            </P>
        </DIV>
    </DIV>
</form>
<div style="text-align:center;padding-top: 30px">Copyright ©2014-2016 suven博客系统  版权所有 >_<</div>
</body>
</html>
