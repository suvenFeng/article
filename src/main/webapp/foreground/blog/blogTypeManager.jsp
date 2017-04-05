<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script type="text/javascript">
    var url;

    function openBlogTypeAddDialog() {
        $("#dlg").dialog("open").dialog("setTitle", "添加博客类别信息");
        url = "${pageContext.request.contextPath}/blog/saveBlogType.do";
    }

    function openBlogTypeModifyDialog() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if(selectedRows.length != 1) {
            $.messager.alert("系统提示", "请选择一个要修改的博客类别");
            return;
        }
        var row = selectedRows[0];
        $("#dlg").dialog("open").dialog("setTitle", "修改博客类别信息");
        $("#fm").form("load", row);//会自动识别name属性，将row中对应的数据，填充到form表单对应的name属性中
        url = "${pageContext.request.contextPath}/blog/saveBlogType.do?id=" + row.id;
    }

    function saveBlogType() {
        $("#fm").form("submit",{
            url: url,
            onSubmit: function() {
                return $(this).form("validate");
            }, //进行验证，通过才让提交
            success: function(result) {
                var result = eval("(" + result + ")"); //将json格式的result转换成js对象
                if(result.success) {
                    $.messager.alert("系统提示", "博客类别保存成功");
                    $("typeName").val(""); //保存成功后将内容置空
                    $("typeNum").val("");
                    $("#dlg").dialog("close"); //关闭对话框
                    $("#dg").datagrid("reload"); //刷新一下
                } else {
                    $.messager.alert("系统提示", "博客类别保存失败");
                    return;
                }
            }
        });
    }

    function closeBlogTypeDialog() {
        $("typeName").val(""); //保存成功后将内容置空
        $("typeNum").val("");
        $("#dlg").dialog("close"); //关闭对话框
    }


    function deleteBlogType() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if(selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的数据");
            return;
        }
        var idsStr = [];
        for(var i = 0; i < selectedRows.length; i++) {
            idsStr.push(selectedRows[i].id);
        }
        var ids = idsStr.join(","); //1,2,3,4
        $.messager.confirm("系统提示", "<font color=red>您确定要删除选中的"+selectedRows.length+"条数据么？</font>", function(r) {
            if(r) {
                $.post("${pageContext.request.contextPath}/blog/deleteBlogType.do",
                    {ids: ids}, function(result){
                        if(result.exist) {
                            $.messager.alert("系统提示", result.exist);
                        } else if(result.success) {
                            $.messager.alert("系统提示", "数据删除成功！");
                            $("#dg").datagrid("reload");
                        } else {
                            $.messager.alert("系统提示", "数据删除失败！");
                        }
                    }, "json");
            }
        });
    }
    function reload() {
        $("#dg").datagrid("reload");
    }
</script>
<%--
  Created by IntelliJ IDEA.
  User: fp942
  Date: 2017/3/9
  Time: 9:44
  To change this template use File | Settings | File Templates.
--%>
<div class="data_list">
    <div class="data_list_title">
        <img src="${pageContext.request.contextPath}/static/images/about_icon.png"/>&nbsp;博客类别管理
    </div>
    <div class="datas" style="text-align: center;">
        <div>
            <table>
                <tr>
                    <td></td>
                </tr>
            </table>
        </div>
        <table cellspacing="10" style="width:500px; text-align:center;">
            <tr>
                <th style="text-align:center;">编号</th>
                <th style="text-align:center;">博客分类名称</th>
                <th style="text-align:center;">类别排序</th>
            </tr>
            <c:forEach items="${blogTypeList}" var="blogType">
                <tr>
                    <td>${blogType.id}</td>
                    <td>${blogType.typeName}</td>
                    <td>${blogType.orderNum}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
