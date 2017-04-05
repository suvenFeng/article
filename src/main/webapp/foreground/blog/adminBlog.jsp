<%--
  Created by IntelliJ IDEA.
  User: fp942
  Date: 2017/3/14
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
    //删除博客数据
    function deleteData(id) {
        if(confirm("确定删除该博客？") == true){
        $.post("${pageContext.request.contextPath}/blog/delete.do",
            {
                'id': id,
            },function(result) {
                if (result.success) {
                    window.location.reload();
                }else{
                    window.alert("删除失败");
                }
            },"json");
    }}
</script>
<c:forEach items="${adminBlogList}" var="adminBlogList">
    <!-- A single blog post -->
    <section class="post">
        <header class="post-header">
            <img width="48" height="48" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src="${pageContext.request.contextPath}/static/userImages/${sessionScope.admin.imagename}">
            <a href="${pageContext.request.contextPath}/blog/articles/${adminBlogList.id}.html" style=" text-decoration: none;cursor:pointer;"><h2 class="post-title">${adminBlogList.title }</h2></a>

            <p class="post-meta">
                By <a class="post-author">${adminBlogList.author }</a> operation <a href="${pageContext.request.contextPath}/blog/edit/${adminBlogList.id}.html"><span class="post-category post-category-pure">编辑</span></a><a onclick="return deleteData(${adminBlogList.id})" style="cursor: pointer;"><span class="post-category post-category-yui">删除</span></a>
            </p>
        </header>

        <div class="post-description">
            <p>
                    ${adminBlogList.summary }....
            </p>
        </div>
    </section>
</c:forEach>
</div>