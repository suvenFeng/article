<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--
  Created by IntelliJ IDEA.
  User: fp942
  Date: 2017/3/8
  Time: 0:10
  To change this template use File | Settings | File Templates.
--%>


<script type="text/javascript">
    function submitModifyInfo() {
        var username = $("#username").val();
        var nickname = $("#nickname").val();
        var sign = $("#sign").val();
        var imagename = $("#imagename").val();
        var profile = UM.getEditor('profile').getContent();
        if(${empty sessionScope.admin.id}){
            $("#error").html("请先登录后再试！");
            return false;
        }
        if (username == null || username == '') {
            $("#error").html("用户名不能为空");
            return false;
        } else if (nickname == null || nickname == '') {
            $("#error").html("昵称不能为空");
            return false;
        }else{
            <%--$.post("${pageContext.request.contextPath}/blogger/modifyInfo/save.do",--%>
                <%--{--%>
                    <%--'username':username,--%>
                    <%--'nickname':nickname,--%>
                    <%--'sign':sign,--%>
                    <%--'imagename':imagename,--%>
                    <%--'profile':profile--%>
                <%--},function (result) {--%>
                    <%--if (result.success) {--%>
                        <%--clearValues();--%>
                        <%--window.location.href="${pageContext.request.contextPath}/blogger/aboutMe.html";--%>
                    <%--}else{--%>
                        <%--$("#error").html("更改失败！");--%>
                        <%--return false;--%>
                    <%--}--%>
            <%--},"json");--%>
            return true;
        }
    }
</script>
<div>
    <section class="posts">
        <form class="pure-form pure-form-stacked" method='post' onsubmit = "return submitModifyInfo();" action="${pageContext.request.contextPath}/blogger/modifyInfo/save.do" enctype="multipart/form-data">
            <fieldset>
                <legend><img src="${pageContext.request.contextPath}/static/images/modifyUser.png"/>&nbsp;信息更改</legend>

                <p>
                    用户名&nbsp;&nbsp;&nbsp;<input id="username" name="username" value="${sessionScope.admin.username}" readOnly="true">
                </p>
                <p>
                    昵&nbsp;&nbsp;称&nbsp;&nbsp;&nbsp;
                    <input id="nickname" name="nickname" value="${sessionScope.admin.nickname}">
                </p>
                <p>
                    S&nbsp;i&nbsp;g&nbsp;n&nbsp;&nbsp;&nbsp;
                    <input id="sign" name="sign" value="${sessionScope.admin.sign}">
                </p>
                <p>
                    头像&nbsp;&nbsp;&nbsp;${sessionScope.admin.imagename}<input id="imagename" name="imageFile" type="file">
                </p>
                <p>
                    个人简介
                    <script type="text/plain" id="profile" name="profile" style="width:600px;height:200px;">
                        ${sessionScope.admin.profile }
                    </script>
                </p>
                <button type="submit" class="pure-button pure-button-primary">提交</button><span style="margin-left: 30px;"><font color="red" id="error">${errorInfo }</font></span>
            </fieldset>
        </form>
    </section>
</div>