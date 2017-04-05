<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
    //新增博客文章提交
    function submitData() {
        var blogTypeId = document.getElementById("blogTypeId").value;
        var title = $("#title").val();
        var content = UM.getEditor('editor').getContent();
        var keyWord = $("#keyWord").val();
        var summary = UM.getEditor('editor').getContentTxt().substr(0, 150);
        if(${empty sessionScope.admin.id}){
            $("#error").html("请先登录后再试！");
            return false;
        }
        if (title == null || title == '') {
            $("#error").html("标题不能为空");
            return false;
        } else if (blogTypeId == null || blogTypeId == '') {
            $("#error").html("请选择博客类别");
            return false;
        } else if (content == null || content == '') {
            $("#error").html("请书写博客内容");
            return false;
        } else {
            $.post("${pageContext.request.contextPath}/blog/save.do",
                {
                    'id': '${blog.id}',
                    'title' : title,
                    'type_id' : blogTypeId,
                    'content' : content,
                    'keyWord' : keyWord,
                    'summary' : summary
                }, function(result) {
                    if (result.success) {
                        clearValues();
                        window.location.href="${pageContext.request.contextPath}/";
                    } else {
                        $("#error").html("发表失败");
                        return false;
                    }
                }, "json");
        }
    }
</script>
<div class="posts">
    <h1 class="content-subhead">
        <img src="${pageContext.request.contextPath}/static/images/writeBlog.png"/>&nbsp;发表文章
    </h1>
    <div style="margin-top:5px;">
        <p style="color:#008ead;font-size:16px;">博客标题:<input type="text" id="title" name="title" value="${blog.title}" style="width:250px; margin-left: 20px;"></p>
    </div>
    <div style="margin-top: 5px;">
        <p style="color:#008ead;font-size:16px;">博客类别:
            <select id="blogTypeId" name="blogType.id" style="width:250px;margin-left: 15px;" editable="false">
                <c:choose>
                    <c:when test="${empty blog.blogType.typeName}">
                        <option value="">请选择博客类别...</option>
                    </c:when>
                    <c:otherwise>
                        <option value="${blog.blogType.id}">${blog.blogType.typeName}</option>
                    </c:otherwise>
                </c:choose>
                <c:forEach items="${blogTypeList}" var="blogType">
                    <option value="${blogType.id}">${blogType.typeName}</option>
                </c:forEach>
            </select>
        </p>
    </div>
    <div style="margin-top: 5px;">
        <script id="editor" type="text/plain" style="width:850px;height:300px;">${blog.content}</script>
    </div>
    <div style="padding: 10px 50px;">
        <div style="color:#008ead;font-size:16px;padding: 20px;">
            关键字:<input type="text" id="keyWord" name="keyWord" value ="${blog.keyWord}"style="width:100px; margin-left: 20px;"/>&nbsp;&nbsp;&nbsp;<span style="color:red;">多个关键字的话请用空格隔开</span><button onclick="return submitData()" style=" margin-left: 100px; color: #fff3f3; border: 0;width: 60px; height: 35px;background: #008ead;">发布</button><span style="margin-left: 30px;"><font color="red" id="error">${errorInfo }</font></span>
        </div>
    </div>
</div>