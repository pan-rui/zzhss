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
        注意:列顺序是根据复选框选中的顺序,新勾选的列排在已勾选的列后面!
    </div>
</div>
<!--帮助内容end-->
<div class="easyui-panel" fit="true" border="false">
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'north',border:false">
            <div id="toolbar" class="toolbar">
                <div class="cmd-box">
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" id="doSave" plain="true"
                       onclick="columnSave()">保存</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-refresh"
                       onclick="resetThisTab();" plain="true">重置</a>
                </div>
                <div class="cmd-right">
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-close" onclick="closeTab()" plain="true">关闭标签</a>
                </div>
            </div>
        </div>
        <div data-options="region:'center',border:false">
            <form id="setColumn" action="/system/setColumn/${tableName}" method="post">
                <%--<input type="hidden" name="tableName" value="${tableName}"/>--%>
            <table class="edit-table" cellspacing="0">
                <tbody>
            <tr>
                <td class="label"><label for="fixedly">固定列：</label></td>
            </tr>
            <tr>
                <c:forEach items="${columnsInfo}" var="column" varStatus="c">
                    <td><label>${column.data_type ne 'enum'?column.column_comment:fn:substringBefore(column.column_comment,'{')}:
                        <input type="checkbox" name="fixedly" value="${column.column_name}"
                            <c:forEach items="${y:toArray(bean.fixedly)}" var="fixedly" varStatus="f">
                                <c:if test="${fixedly eq column.column_name}">checked="checked"</c:if>
                            </c:forEach>
                        /></label>
                    </td>
                ${c.last||c.index%5==4?'</tr>':''}
                </c:forEach>
                    <tr><td><br/></td></tr>

            <tr>
                <td class="label"><label for="active">活动列：</label></td>
            </tr>
            <tr>
                <c:forEach items="${columnsInfo}" var="column" varStatus="c">
                <td><label>${column.data_type ne 'enum'?column.column_comment:fn:substringBefore(column.column_comment,'{')}:
                    <input type="checkbox" name="active" value="${column.column_name}"
                            <c:forEach items="${y:toArray(bean.active)}" var="active" varStatus="f">
                                <c:if test="${active eq column.column_name}">checked="checked"</c:if>
                            </c:forEach>
                    /></label>
                </td>
                    ${c.last||c.index%5==4?'</tr>':''}
                </c:forEach>
            <tr><td><br/></td></tr>

            <tr>
                <td class="label"><label for="search">过滤条件：</label></td>
            </tr>
            <tr>
                <c:forEach items="${columnsInfo}" var="column" varStatus="c">
                <td><label>${column.data_type ne 'enum'?column.column_comment:fn:substringBefore(column.column_comment,'{')}:
                    <input type="checkbox" name="search" value="${column.column_name}"
                            <c:forEach items="${y:toArray(bean.search)}" var="search" varStatus="s">
                                <c:if test="${search eq column.column_name}">checked="checked"</c:if>
                            </c:forEach>
                    /></label>
                </td>
                    ${c.last||c.index%5==4?'</tr>':''}
                </c:forEach>
                </tbody>
                </table>
            </form>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    var fixedlys= $.map($("input[name='fixedly']:checked"),function(n){
        return '"'+n.value+'"';
    });
    var actives= $.map($("input[name='active']:checked"),function(n){
        return '"'+n.value+'"';
    });
    var searchs= $.map($("input[name='search']:checked"),function(n){
        return '"'+n.value+'"';
    });
    $("input[name='fixedly']").click(function(){
        if(this.checked==true) fixedlys[fixedlys.length] = '"' + this.value + '"';
        else
            fixedlys.splice($.inArray('"' + this.value + '"', fixedlys), 1);
    })
    $("input[name='active']").click(function(){
        if(this.checked==true) actives[actives.length] = '"' + this.value + '"';
        else
            actives.splice($.inArray('"' + this.value + '"', actives), 1);
    })
    $("input[name='search']").click(function(){
        if(this.checked==true) searchs[searchs.length] = '"' + this.value + '"';
        else
            searchs.splice($.inArray('"' + this.value + '"', searchs), 1);
    })
    function columnSave(){
        var $form = $('#setColumn');
        top.$.messager.confirm('操作提示！','<span style="color:red; font-size:16px;">您确认要保存数据！</span>',function(r){
            if(r){
                var _url = $form.attr('action');
                top.$.messager.progress();
                $form.form("submit",{
                    url:_url,
                    queryParams:{'menu.fixedly':'['+fixedlys+']','menu.active':actives.length>0?'['+actives+']':'','menu.search':'['+searchs+']','menu.id':${bean.id}},
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

