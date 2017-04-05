<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="data_list">
	<c:choose>
		<c:when  test="${empty sessionScope.admin.id}">
			登录后查看
		</c:when>
		<c:otherwise>
			<div class="data_list_title">
				<img
						src="${pageContext.request.contextPath}/static/images/user_icon.png" />
				个人信息
				<a style="float:right;" href="${pageContext.request.contextPath}/blogger/modifyInfo.html">修改</a>
			</div>
			<div class="user_image">
				<img src="${pageContext.request.contextPath}/static/userImages/${sessionScope.admin.imagename}"/>
			</div>
			<div class="nickName"><strong><font style="color: #EE6A50">昵称：${sessionScope.admin.nickname}</font></strong></div>
			<%-- <div class="visitNum">访问量：6666</div>  --%>
			<div class="userSign">『<strong><font style="color: #EE6A50">${sessionScope.admin.sign }</font></strong>』</div>
		</c:otherwise>
</c:choose>
</div>


<div class="data_list">
	<div class="data_list_title">
		<img
			src="${pageContext.request.contextPath}/static/images/byType_icon.png" />
		文章分类
		<a style="float:right;" href="${pageContext.request.contextPath}/blog/blogTypeManager.html">管理</a>
	</div>
	<div class="datas">
		<ul>
			<c:forEach items="${blogTypeList }" var="blogType">
				<li><span> <a href="${pageContext.request.contextPath}/index.html?typeId=${blogType.id }">${blogType.typeName }（${blogType.blogCount }）
					</a></span></li>
			</c:forEach>
		</ul>
	</div>
</div>

<div class="data_list">
	<div class="data_list_title">
		<img
			src="${pageContext.request.contextPath}/static/images/byDate_icon.png" />
		文章存档
	</div>
	<div class="datas">
		<ul>
			<c:forEach items="${blogTimeList }" var="blog">
				<li><span> <a
						href="${pageContext.request.contextPath}/index.html?releaseDateStr=${blog.releaseDateStr }">${blog.releaseDateStr }（${blog.blogCount }）
					</a></span></li>
			</c:forEach>
		</ul>
	</div>
</div>