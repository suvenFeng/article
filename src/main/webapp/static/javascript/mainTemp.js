//新增博客文章提交
function submitData() {
    var blogTypeId = document.getElementById("blogTypeId").value;
    var title = $("#title").val();
    var content = UE.getEditor('editor').getContent();
    var summary = UE.getEditor('editor').getContentTxt().substr(0, 155);
    var keyWord = $("#keyWord").val();
    var contentNoTag = UE.getEditor('editor').getContentTxt();

    if (title == null || title == '') {
        $.messager.show({
            title:'系统提示',
            msg:'请输入标题',
            showType:'fade',
            style:{
                right: '',
                top:document.body.scrollTop+document.documentElement.scrollTop,
                bottom: ''
            }
        });
    } else if (blogTypeId == null || blogTypeId == '') {
        $.messager.show({
            title:'系统提示',
            msg:'请选择博客类型',
            showType:'fade',
            style:{
                right:'',
                top:document.body.scrollTop+document.documentElement.scrollTop,
                bottom:''
            }
        });
    } else if (content == null || content == '') {
        $.messager.show({
            title:'系统提示',
            msg:'请编辑博客内容',
            top:document.body.scrollTop+document.documentElement.scrollTop,
            showType:'fade',
            style:{
                right:'',
                bottom:''
            }
        });
    } else {
        $.post("${pageContext.request.contextPath}/blog/save.do",
            {
                'title' : title,
                'blogType.id' : blogTypeId,
                'content' : content,
                'summary' : summary,
                'keyWord' : keyWord,
                'contentNoTag' : contentNoTag
            }, function(result) {
                if (result.success) {
                    $.messager.show({
                        title:'系统提示',
                        msg:'博客发布成功',
                        top:document.body.scrollTop+document.documentElement.scrollTop,
                        showType:'1000',
                        style:{
                            right:'',
                            bottom:''
                        }
                    });
                    clearValues();
                } else {
                    $.messager.show({
                        title:'系统提示',
                        msg:'博客发布失败',
                        top:document.body.scrollTop+document.documentElement.scrollTop,
                        showType:'fade',
                        style:{
                            right:'',
                            bottom:''
                        }
                    });
                }
            }, "json");
    }
}
function clearValues() {
    $("#title").val("");
    $("#blogTypeId").combobox("setValue", "");
    UE.getEditor("editor").setContent("");
    $("#keyWord").val("");
}

/*modifyInfo.jsp    修改个人信息页面*/
function submitModifyInfo() {
    $("#fm").form("submit",{
        url: "${pageContext.request.contextPath}/blogger/modifyInfo/save.do",
        onSubmit: function() {
            var profile = UE.getEditor("profile").getContent();
            $("#pf").val(profile); //将UEditor编辑器中的内容放到隐藏域中提交到后台
            return $(this).form("validate");
        }, //进行验证，通过才让提交
        success: function(result) {
            var result = eval("(" + result + ")"); //将json格式的result转换成js对象
            if(result.success) {
                $.messager.alert("系统提示", "博主信息更新成功");
            } else {
                $.messager.alert("系统提示", "博主信息更新失败");
                return;
            }
        }
    });
}
var ue = UE.getEditor('profile');
ue.addListener("ready", function(){
    //通过UE自己封装的ajax请求数据
    UE.ajax.request("${pageContext.request.contextPath}/blogger/findBlogger.do",
        {
            method: "post",
            async: false,
            data: {},
            onsuccess: function(result) { //
                result = eval("(" + result.responseText + ")");
                $("#nickname").val(result.nickname);
                $("#sign").val(result.sign);
                UE.getEditor('profile').setContent(result.profile);
            }
        });
});


/*blogTypeManager.jsp   修改博客信息类型页面*/
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