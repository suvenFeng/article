<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	
	function loadimage(){
		document.getElementById("randImage").src="${pageContext.request.contextPath}/image.jsp?"+Math.random();
	}
	
	function submitData() {
		var content = $("#content").val();
		var imageCode = $("#imageCode").val();

		if(${empty sessionScope.admin.id}){
            $("#error").html("请先登录后再试！");
            return false;
		}
		if(content == null || content == "") {
            $("#error").html("评论内容为空！");
            return false;
		} else if( imageCode == null || imageCode == "") {
            $("#error").html("请输入验证码！");
            return false;
		} else {
			$.post(
				"${pageContext.request.contextPath}/comment/save.do",
				{
				    "content":content,
					"imageCode":imageCode,
					"blog.id":"${blog.id}"
				},
				function(result) {
					if(result.success) {
						window.location.reload();
					} else {
                        $("#error").html(result.errorInfo);
					}
				},"json");
		}
	}
	
</script>
<div>
	<!-- A wrapper for all the blog posts -->
	<div class="posts">
		 <h1 class="content-subhead"><img src="${pageContext.request.contextPath}/static/images/blog_show_icon.png" />&nbsp;博客信息</h1>
	</div>

	<!-- 博客标题-->
	<div style="text-align:center;;">
		<h1>
			<strong>${blog.title }</strong>
		</h1>
	</div>

	<!-- 博客作者-->
	<div style="text-align:center;padding: 30px 0;">
		<h4>
			<i>作者:${blog.author}</i>
		</h4>
	</div>

	<!-- 博客内容-->
	<div style="padding:10px 5px;">
		${blog.content }
	</div>

	<!-- 博客版权声明-->
	<div style="text-align:center;">
		<font style="color:#8B2323">尊重博主原创文章，转载请注明文章出于此处。</font>
	</div>

	<!-- 博客其他信息-->
	<div style="padding: 50px 100px;">
		<div style="float:left;">
			标签:${blog.blogType.typeName }
		</div>
		<div style="float:right;">
			发布于：『
			<fmt:formatDate value="${blog.releaseDate }" type="date"
							pattern="yyyy-MM-dd HH:mm" />
			』&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;评论数:&nbsp;&nbsp;${blog.replyHit }
		</div>
	</div>

	<!-- 博客评论区-->
	<div style="text-align:left; padding: 10px 20px;">
		<ul>
			<c:choose>
				<c:when test="${commentList.size()==0 }">
					暂无评论
				</c:when>
				<c:otherwise>
					<c:forEach items="${commentList }" var="comment" varStatus="status">
						<c:choose>
							<c:when test="${status.index<10 }">
								<div style="padding: 5px 0;">
									<span>
										<font>${status.index+1}楼&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#33a5ba;">${comment.nickname }</span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#aaa;font-size: 10px;">[<fmt:formatDate value="${comment.commentDate }" type="date" pattern="yyyy-MM-dd HH:mm" />]</span></span></font>&nbsp;&nbsp;&nbsp;&nbsp;<p style="font-size: 10px;">${comment.content }</p>
								</div>
							</c:when>
							<c:otherwise>
								<div class="otherComment">
									<span><font>
											${status.index+1}楼&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#33a5ba;">${comment.nickname }</span></font>
										&nbsp;&nbsp;&nbsp;&nbsp;${comment.content }&nbsp;&nbsp;&nbsp;&nbsp;
										[<fmt:formatDate value="${comment.commentDate }" type="date"
														 pattern="yyyy-MM-dd HH:mm" />] </span>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>


	<!-- 书写博客评论区-->
	<div>
		<div style="padding: 15px 20px;">
			<img src="${pageContext.request.contextPath}/static/images/publish_comment_icon.png" /> &nbsp;发表评论
		</div>
		<div style="padding: 15px 20px;">
			<div>
				<textarea style="width: 100%" rows="3" id="content" name="content" placeholder="来说两句吧..."></textarea>
			</div>
			<div style="padding: 15px 10px;">
				验证码：<input type="text" name="imageCode" id="imageCode"
						   size="10" onkeydown="if(event.keyCode==13)form1.submit()" />&nbsp;
				<img onclick="javascript:loadimage();" title="换一张试试" name="randImage"
					 id="randImage" src="/image.jsp" width="60" height="20" border="1"
					 align="absmiddle">
				<button style=" margin-left:30px;color: white;border-radius: 4px;text-shadow: 0 1px 1px rgba(0, 0, 0, 0.2);background: rgb(28, 184, 65);" onclick="submitData()">发表评论</button><span style="margin-left: 30px;"><font color="red" id="error">${errorInfo }</font></span>
			</div>
		</div>
</div>