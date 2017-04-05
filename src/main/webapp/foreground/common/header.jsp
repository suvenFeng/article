<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="header">
	<div class='logo'>原创文字</div>
	<ul>
		<li class='first'><a href="${pageContext.request.contextPath}/index.html">首页</a></li>
		<li class='item'><a href="${pageContext.request.contextPath}/blog/writeBlog.html" onclick="changeClass(this)">发表</a></li>
		<%--<li  class='item'><a href="javascript:void(0)">热门专题</a></li>--%>
		<%--<li  class='item'><a href="javascript:void(0)">欣赏美文</a></li>--%>
		<li  class='item'><a href="${pageContext.request.contextPath}/blogger/aboutMe.html" onclick="changeClass(this)">个人中心</a></li>
	</ul>
	<div class='login'>
		<c:choose>
			<c:when  test="${empty sessionScope.admin.id}">
				<span><a href="${pageContext.request.contextPath}/login.jsp">登录</a></span>
				<span>|</span>
				<span><a href="${pageContext.request.contextPath}/register.jsp">注册</a></span>
			</c:when>
			<c:otherwise>
				<span>欢迎您，${sessionScope.admin.username}</span>
				<span>&nbsp;|&nbsp;</span>
				<span><a href="${pageContext.request.contextPath}/blogger/logout.do">登出</a></span>
			</c:otherwise>
		</c:choose>
	</div>
	<%--<div id="wait" style="display:none;width:69px;height:89px;border:1px solid black;position:absolute;top:50%;left:50%;padding:2px;"><img src='${pageContext.request.contextPath}/static/img/loading.gif' width="64" height="64" /><br>Loading..</div>--%>
</div>