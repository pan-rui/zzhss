<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/28
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@include file="include/require.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="/js/grid.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/page.css"/>
</head>
<body>
<!--帮助内容-->
<div class="mod-help-info">
    <span title="帮助" class="icon-help"></span>
    <div class="mod-help-content">
        1.每个操作项有5个字段,[val]字段的值可为数字或字符串数组或空    2.数组内元素用单引号     3.简单菜单请填写 "表名"和"关联列名",复杂菜单请填写"url"和"表列名"      4.若存在右键菜单建议不设或少设固定列.
    </div>
</div>
<!--帮助内容end-->
<div class="easyui-panel" fit="true" border="false">
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'north',border:false">
            <div id="toolbar" class="toolbar">
                <div class="cmd-box">
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" id="doSave" plain="true"
                       onclick="controlerSave()">保存</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-refresh"
                       onclick="resetThisTab();" plain="true">重置</a>
                </div>
                <div class="cmd-right">
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-close" onclick="closeTab()" plain="true">关闭标签</a>
                </div>
            </div>
        </div>
        <div data-options="region:'center',border:false">
            <form id="setControler" action="/system/addOpt/${tableName}" method="post">
                <%--<input type="hidden" name="tableName" value="${tableName}"/>--%>
            <table class="edit-table" cellspacing="0">
                <tbody>
                <tr><td><h3>操作项</h3></td></tr>
                <c:forEach items="${y:toArray(bean.operate)}" var="operate" varStatus="m">
                <tr>
                    <c:forEach items="${operate}" var="entry" varStatus="e">
                    <td class="label"><span for="${entry.key}">${entry.key}：
                    <input type="text" class="ipt30" name="${entry.key}" value="${entry.value}" ${entry.key ne 'val'?'require="true"':''}/>
                    </span></td>
                    </c:forEach>
                    <td><button class="aa">删除</button> </td>
                </tr>
                </c:forEach>
                <tr>
                        <td class="label"><span for="url">url：
                            <input type="text" class="ipt30" name="url" value="" require="true"/>
                        </span>
                        </td>
                    <td class="label"><span for="title">操作名：
                        <input type="text" class="ipt30" name="title" value="" require="true"/>
                    </span>
                    </td>
                    <td class="label"><span for="val">设定值：
                        <input type="text" class="ipt30" name="val" value=""/>
                    </span>
                    </td>
                    <td class="label"><span for="function">function：
                        <input type="text" class="ipt30" name="function" value="" require="true"/>
                    </span>
                    </td>
                    <td class="label"><span for="position">列位置：
                        <input type="text" class="ipt30" name="position" value="" require="true"/>
                    </span>
                    </td>
                    <td><button class="bbb">添加</button> </td>
                </tr>
                <tr><td><h3>右键菜单项</h3></td></tr>
                <c:forEach items="${y:toArray(bean.cMenu)}" var="menu" varStatus="m">
                    <tr>
                        <c:forEach items="${menu}" var="entry" varStatus="e">
                            <td class="label"><span for="m_${entry.key}">${entry.key}：
                    <input type="text" class="ipt25" name="m_${entry.key}" value="${entry.value}" ${entry.key eq 'mName'?'require="true"':''}/>
                    </span></td>
                        </c:forEach>
                        <td><button class="aa">删除</button> </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td class="label"><span for="m_url">url：
                            <input type="text" class="ipt25" name="m_url" value="" require="true"/>
                        </span>
                    </td>
                    <td class="label"><span for="m_title">表列名：
                        <input type="text" class="ipt25" name="m_title" value="">
                    </span>
                    </td>
                    <td class="label"><span for="m_mName">菜单名：
                        <input type="text" class="ipt25" name="m_mName" value="" require="true"/>
                    </span>
                    </td>
                    <td class="label"><span for="m_tableName">表名：
                        <input type="text" class="ipt25" name="m_tableName" value=""/>
                    </span>
                    </td>
                    <td class="label"><span for="m_cascadeName">关联列名：
                        <input type="text" class="ipt25" name="m_cascadeName" value=""/>
                    </span>
                    </td>
                    <td class="label"><span for="m_icon">icon：
                        <input type="text" class="ipt25" name="m_icon" value=""/>
                    </span>
                    </td>
                    <td><button class="bbb">添加</button> </td>
                </tr>
                </tbody>
                </table>
            </form>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
        $("form:first").on("click",".aa",function(event){
            $(this).closest("tr").remove();
        return false;
    })
    $("form:first").on("click",".bbb",function(event){
        var tr=$(this).closest("tr");
        var $tr = $(this).closest("tr").clone();
        tr.find("input").blur()
        if($(".erro-msg:visible").size() > 0) return false;
        $tr.find("input").val("");
        $tr.insertAfter(tr);
        $(this).removeClass("bbb").addClass("aa").html("删除");
        return false;
    })
       function controlerSave(){
        var $form = $('#setControler');
        top.$.messager.confirm('操作提示！','<span style="color:red; font-size:16px;">您确认要保存数据！</span>',function(r){
            if(r){
                var urls= $.map($("input[name='url']"),function(n){
                    return n.value;
                });
                var titles= $.map($("input[name='title']"),function(n){
                    return n.value;
                });
                var vals= $.map($("input[name='val']"),function(n){
                    return n.value;
                });
                var functions= $.map($("input[name='function']"),function(n){
                    return n.value;
                });
                var positions= $.map($("input[name='position']"),function(n){
                    return parseInt(n.value);
                });
                var m_urls= $.map($("input[name='m_url']"),function(n){
                    return n.value;
                });
                var m_titles= $.map($("input[name='m_title']"),function(n){
                    return n.value;
                });
                var m_mNames= $.map($("input[name='m_mName']"),function(n){
                    return n.value;
                });
                var m_tableNames= $.map($("input[name='m_tableName']"),function(n){
                    return n.value;
                });
                var m_cascadeNames= $.map($("input[name='m_cascadeName']"),function(n){
                    return n.value;
                });
                var m_icons= $.map($("input[name='m_icon']"),function(n){
                    return n.value;
                });
                var operates=[],cMenus=[];
                for(var i=0;i<urls.length;i++){
                    if(urls[i]&&urls[i]!='')
                    operates[i]={url:urls[i],title:titles[i],val:vals[i],function:functions[i],position:positions[i]};
                }
                for(var i=0;i<m_urls.length;i++) {
                    if(m_urls[i]&&m_urls[i]!='')
                    cMenus[i]={url:m_urls[i],title:m_titles[i],mName:m_mNames[i],tableName:m_tableNames[i],icon:m_icons[i],cascadeName:m_cascadeNames[i]};
                }
                top.$.messager.progress();
                $form.form("submit",{
                    url:$form.attr('action'),
                    queryParams:{'menu.operate':JSON.stringify(operates),'menu.id':${bean.id},'menu.cMenu':JSON.stringify(cMenus)},
                    success: function(data){
                        var j = $.parseJSON(data);
                        top.$.messager.progress('close');
                        if($.trim(j.code) == 0){
                            //if(data=="OK"){
                            top.$.messager.confirm('操作成功！','<span style="color:red; font-size:16px;">操作成功!</span><br\>'+'如果要关闭该编辑窗口，请点击确定!',function(r){
                                //gdReload('#list_data',modeltit);
                                if(r) closeTab();
                            });
                        }else
                            $.messager.alert('操作失败！','<span style="color:red; font-size:16px;">'+ j.msg+'</span>','error');
                    }
                });
            }
        });
    }
</script>
</html>

