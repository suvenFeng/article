<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.post ul li{
		list-style-type:none;
	}

</style>
<div>
	<!-- A wrapper for all the blog posts -->
	<div class="posts">
		<h1 class="content-subhead">
			<img src="${pageContext.request.contextPath}/static/images/about_icon.png"/>&nbsp;个人信息
			<a style="text-decoration: none;margin-left: 50px;" href="${pageContext.request.contextPath}/blogger/modifyInfo.html">修改</a>
		</h1>
		<section class="post">
			<ul>
				<li>
					<c:choose>
						<c:when  test="${!empty sessionScope.admin.imagename}">
							<img src="${pageContext.request.contextPath}/static/userImages/${sessionScope.admin.imagename}" width="128px" height="128px"/>
						</c:when>
						<c:otherwise>
							<span style="height:228px;border:1px solid;">快<a href="${pageContext.request.contextPath}/blogger/modifyInfo.html" style="text-decoration: none;">上传</a>一个帅帅的头像吧！</span>
						</c:otherwise>
					</c:choose>
				</li>
				<li>
					<p>用户名:${sessionScope.admin.username}</p>
				</li>
				<li>
					<p>昵&nbsp;称:${sessionScope.admin.nickname }</p>
				</li>
				<li>
					<p>签&nbsp;名:${sessionScope.admin.sign }</p>
				</li>
				<li>
					<p>简&nbsp;介:${sessionScope.admin.profile }</p>
				</li>
				<hr style="height:5px;border:none;border-top:1px dashed gray;padding-bottom:10px;" />
			</ul>
		</section>
		<jsp:include page="${adminBlogPage }"/>
	</div>
</div>