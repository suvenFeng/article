<%--
  Created by IntelliJ IDEA.
  User: fp942
  Date: 2017/3/6
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A layout example that shows off a blog page with a list of posts.">

    <!--bootstrap、JS、JQuery-->
    <script src="${pageContext.request.contextPath}/static/bootstrap3/js/jquery-1.11.2.min.js"></script>


    <!-- UMeditor富文本编辑器 -->
    <!-- 配置文件 -->
    <link href="${pageContext.request.contextPath}/static/umeditor1.2.3/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/umeditor1.2.3/third-party/template.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/static/umeditor1.2.3/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/static/umeditor1.2.3/umeditor.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/static/umeditor1.2.3/lang/zh-cn/zh-cn.js"></script>


    <!-- PURE CSS-->
    <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/pure-min.css" integrity="sha384-" crossorigin="anonymous">
    <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/grids-responsive-min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/pure/blog.css">

    <!-- JS-->

    <title>${title }</title>
    <style>
        .headPic{
            position: absolute;
            top: 120px;
            right: 35px;
            width:128px;
            height:128px;
        }
        .headPic img{
            vertical-align: middle;
            margin-bottom: 20px;
            border-radius:50%;
            border: 6px solid rgba(255,255,255,0.15);
        }
    </style>
</head>
<body>

    <div id="layout" class="pure-g">
        <div class="sidebar pure-u-1 pure-u-md-1-4">
            <c:choose>
                <c:when  test="${!empty sessionScope.admin.imagename}">
                    <div class="headPic">
                        <a href="${pageContext.request.contextPath}/blogger/aboutMe.html"><img src="${pageContext.request.contextPath}/static/userImages/${sessionScope.admin.imagename}" width="128" height="128"/></a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="headPic">
                        <a href="${pageContext.request.contextPath}/index.html" style="position: absolute;top: 75px;right: 10px;font-size: 40px;color:#FFFFFF;">HI</a>
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="header">
                <h1 class="brand-title">原&nbsp;创&nbsp;文&nbsp;字</h1>
                <h2 class="brand-tagline">Writing u blog publish<br> it Here</h2>

                <c:choose>
                    <c:when  test="${empty sessionScope.admin.id}">
                <nav class="nav">
                    <ul class="nav-list">
                        <li class="nav-item">
                            <a class="pure-button" href="${pageContext.request.contextPath}/login.jsp">登录</a>
                        </li>
                        <li class="nav-item">
                            <a class="pure-button" href="${pageContext.request.contextPath}/register.jsp">注册</a>
                        </li>
                    </ul>
                </nav>
                    </c:when>
                    <c:otherwise>
                        <p style="font-size:20px;"><a href="${pageContext.request.contextPath}/blogger/logout.do" style="text-decoration: none;">${sessionScope.admin.nickname }</a></p>
                        <nav class="nav">
                            <ul class="nav-list">
                                <li class="nav-item">
                                    <a class="pure-button" href="${pageContext.request.contextPath}/index.html">Home</a>
                                </li>
                            </ul>
                        </nav>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="content pure-u-1 pure-u-md-3-4">
            <div style="text-align:right;">
                <iframe width="420" scrolling="no" height="60" frameborder="0"
                        src="http://i.tianqi.com/index.php?c=code&id=12&icon=1&num=5">
                </iframe>
            </div>
            <c:choose>
                <c:when test="${!empty sessionScope.admin.imagename}">
                    <div style="margin-right: 40px;">
                        <a href="${pageContext.request.contextPath}/blog/writeBlog.html" style="font-family: Georgia;font-size:25px; color: #00daff; text-decoration: none;font-weight:bold; padding: 0 140px;">发&nbsp;&nbsp;&nbsp;表</a><span style="color:#FF6600;">&nbsp;&nbsp;&nbsp;ENJOY WRITING</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="margin-right: 40px;" id="showModal">
                        <a type="button" onclick="ShowModal()" style="font-family: Georgia;font-size:25px; color: #00daff; text-decoration: none;font-weight:bold; padding: 0 140px;">发&nbsp;&nbsp;&nbsp;表</a><span style="color:#FF6600;">&nbsp;&nbsp;&nbsp;ENJOY WRITING</span>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- 动态加载页面-->
            <jsp:include page="${commonPage }"/>
        </div>
    </div>
</body>
    <!-- JS -->
    <script type="text/javascript">
        /*mainTemp页面的JS*/
        function changeClass(obj) {
            var li = obj.parentNode; //获取父节点
            li.className = "active";
        }

/*writeBlog.jsp 写博客页面*/
        //实例化编辑器
        var um = UM.getEditor('editor');
        function clearValues() {
            $("#title").val("");
//            $("#blogTypeId").empty();
            UM.getEditor("editor").setContent("");
            $("#keyWord").val("");
        }

        /*modifyInfo.jsp    修改个人信息页面*/
        var um = UM.getEditor('profile');
        um.addListener("ready", function(){
            //通过UM自己封装的ajax请求数据
            UM.ajax.request("${pageContext.request.contextPath}/blogger/findBlogger.do",
                {
                    method: "post",
                    async: false,
                    data: {},
                    onsuccess: function(result) { //
                        result = eval("(" + result.responseText + ")");
                        $("#nickname").val(result.nickname);
                        $("#sign").val(result.sign);
                        UM.getEditor('profile').setContent(result.profile);
                    }
                });
        });

    </script>
</html>
