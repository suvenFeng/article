<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div>
	<!-- A wrapper for all the blog posts -->
	<div class="posts">
		<h1 class="content-subhead"><img src="${pageContext.request.contextPath}/static/images/list_icon.png"/>&nbsp;最新博客</h1>
		<c:forEach items="${blogList}" var="blog">
		<!-- A single blog post -->
			<section class="post">
				<header class="post-header">
					<img width="48" height="48" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src="${pageContext.request.contextPath}/static/userImages/${blog.imagename}">

					<a href="${pageContext.request.contextPath}/blog/articles/${blog.id}.html" style=" text-decoration: none;cursor:pointer;"><h2 class="post-title">${blog.title }</h2></a>

					<p class="post-meta">
						By <a class="post-author">${blog.author }</a> under <span class="post-category post-category-design">原</span> <span class="post-category post-category-pure">阅读(${blog.clickHit })</span> <span class="post-category post-category-yui">评论(${blog.replyHit })</span>
					</p>
				</header>

				<div class="post-description">
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;${blog.summary }....
					</p>
				</div>
			</section>
		</c:forEach>
	</div>

	<div class="footer">
		<div class="pure-menu pure-menu-horizontal">
			<ul>
				<li class="pure-menu-item"><a href="https://github.com/suvenFeng/article/blob/master/README.md" class="pure-menu-link">关于</a></li>
				<li class="pure-menu-item"><a href="https://github.com/suvenFeng" class="pure-menu-link">联系作者</a></li>
				<li class="pure-menu-item"><a href="https://github.com/suvenFeng/article.git" class="pure-menu-link">GitHub</a></li>
			</ul>
		</div>
	</div>
</div>
