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
        这里是帮助，随便写点什么吧，如果不需要，请把内容删掉！
    </div>
</div>
<!--帮助内容end-->
<div class="easyui-panel" fit="true" border="false">
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'north',border:false">
        <c:if test="${operate ne 'detail'}">
            <div id="toolbar" class="toolbar">
                <div class="cmd-box">
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" id="doSave" plain="true"
                       onclick="doSave()">保存</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-refresh"
                       onclick="resetThisTab();" plain="true">重置</a>
                </div>
                <div class="cmd-right">
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-close" onclick="closeTab()" plain="true">关闭标签</a>
                </div>
            </div>
        </c:if>
        </div>
        <div data-options="region:'center',border:false">
            <div class="easyui-panel edit-panel" title="${operate eq 'edit'?'修改':operate eq 'add'?'添加':'查看'}[菜单]" data-options="fit:true,border:false">
                <form method='post' id="data_form" name="data_form" action="${baseUrl}/system/save/${tableName}">
                    <input type="hidden" name="tableName" value="${tableName}"/>
                    <input type="hidden" name="operate" value="${operate}"/>
                    <table class="edit-table" cellspacing="0">
                        <tbody>
                        <c:forEach items="${columnsInfo}" var="column" varStatus="c">
                            <c:choose>
                                <c:when test="${column.column_name eq 'id' && operate ne 'add'}">
                                    <tr ${operate eq 'edit'?'style="display:none"':''}>
                                    <td class="label"><label for="${column.column_name}">${column.data_type ne 'enum'?column.column_comment:fn:substringBefore(column.column_comment,'{')}：</label></td>
                                    <td><input type="text" class="ipt20" id="${column.column_name}" name="bean.${column.column_name}" value="${bean[column.column_name]}" ${operate eq 'detail'?'disabled="disabled"':''}/></td>
                                    </tr>
                                </c:when>
                                <c:when test="${column.column_name ne 'id'}">
                                <tr>
                                    <td class="label"><label for="${column.column_name}">${column.data_type ne 'enum'?column.column_comment:fn:substringBefore(column.column_comment,'{')}：</label></td>
                                    <td name="${column.column_name}">
                                        <c:choose>
                                            <c:when test="${column.data_type eq 'enum'}">
                                                <y:select id="${column.column_name}" name="bean.${column.column_name}" data="${y:toMap(fn:substring(column.column_comment ,fn:indexOf(column.column_comment,'{' ),-1))}" defVal="${empty bean[column.column_name]?column.column_default:bean[column.column_name]}"></y:select>
                                            </c:when>
                                            <c:when test="${column.maxLength eq 4097}">
                                                <span>
                                                    <c:if test="${operate ne 'add'}">
                                                        <c:forEach items="${y:toLinkedMap(bean[column.column_name])}" var="map" varStatus="s">
                                                            <div><input type="text" class="ipt15" name="key-${s.index}" value="${map.key}" ${operate eq 'detail'?'disabled="disabled"':''}/>--><input type="text" class="ipt30" name="value-${s.index}" value="${map.value}" ${operate eq 'detail'?'disabled="disabled"':''}/></div>
                                                        </c:forEach>
                                                    </c:if>
                                                    <c:if test="${operate ne 'detail'}">
                                                        <a href="javascript" class="add-list" aid="addKV">添加属性</a>
                                                    </c:if>
                                                </span>
                                                <input type="hidden" name="bean.${column.column_name}" class="json" value=""/>
                                            </c:when>
                                            <c:when test="${column.maxLength eq 4099}">
                                                <c:forEach items="${y:toArray(bean[column.column_name])}" var="child" varStatus="ss">
                                                    <span>
                                                    <c:forEach items="${y:toMap(child)}" var="map" varStatus="s">
                                                        <div><input type="text" class="ipt15" name="key-${s.index}" value="${map.key}" ${operate eq 'detail'?'disabled="disabled"':''}/>--><input type="text" class="ipt30" name="value-${s.index}" value="${fn:replace(map.value,'\"','\'')}" ${operate eq 'detail'?'disabled="disabled"':''}/></div>
                                                    </c:forEach>
                                                        <c:if test="${operate ne 'detail'}">
                                                    <a href="javascript:;" class="add-list" aid="addKV">添加属性</a>
                                                        </c:if>
                                                    </span>
                                                </c:forEach>
                                                <c:if test="${operate ne 'detail'}">
                                                <a href="javascript:;" class="add-list" aid="addArray">添加项</a>
                                                </c:if>
                                                <input type="hidden" name="bean.${column.column_name}" class="json" value=""/>
                                            </c:when>
                                            <c:when test="${column.maxLength eq 4098}">
                                                <span>
                                                <c:forEach items="${y:toArray(bean[column.column_name])}" var="child" varStatus="s">
                                                <input type="text" class="ipt15" name="${column.column_name}-${s.index}" value="${child}" ${column.is_nullable eq 'NO'?'require="true"':''} ${operate eq 'detail'?'disabled="disabled"':''} <c:if test="${not fn:contains(column.data_type, 'char')}">onkeyup="value=value.replace(/[^\d.]/g,'')"</c:if>/>/>
                                                </c:forEach>
                                                <c:if test="${operate ne 'detail'}">
                                                <a href="javascript:;" class="add-list" aid="addSimpleArry">添加项</a>
                                                    </c:if>
                                                </span>
                                                <input type="hidden" name="bean.${column.column_name}" class="json" value=""/>
                                            </c:when>
                                            <c:when test="${fn:startsWith(column.data_type,'date')}">
                                                <input type="datetime" class="easyui-datetimebox" id="${column.column_name}" name="bean.${column.column_name}" value="${bean[column.column_name]}" ${column.is_nullable eq 'NO'?'data-options="required:true"':''}/>
                                            </c:when>
                                            <c:when test="${column.maxLength gt 50}">
                                                <textarea class="ipt-long" id="${column.column_name}" name="bean.${column.column_name}"  ${operate eq 'detail'?'disabled="disabled"':''} rows="5" cols="80" maxlength="${column.maxLength}" ${column.is_nullable eq 'NO'?'required':''}>${bean[column.column_name]}</textarea>
                                            </c:when>
                                            <c:otherwise>
                                                <%--<c:choose><c:when test="${fn:startsWith(bean[column.column_name],'[') || fn:startsWith(bean[column.column_name],'{')}">${y:showJSON(bean[column.column_name])}</c:when><c:otherwise>${bean[column.column_name]}</c:otherwise></c:choose>--%>
                                                <input type="text" class="ipt20" id="${column.column_name}" name="bean.${column.column_name}"
                                                       value="${fn:startsWith(bean[column.column_name],'[') || fn:startsWith(bean[column.column_name],'{')?(y:showJSON(bean[column.column_name])):bean[column.column_name]}" ${column.is_nullable eq 'NO'?'require="true"':''} ${operate eq 'detail'?'disabled="disabled"':''} <c:if test="${not fn:contains(column.data_type, 'char')}">onkeyup="value=value.replace(/[^\d.]/g,'')"</c:if>/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("table.edit-table").on('click',"a[aid='addKV']",function(){
        var td = $(this).closest("td"),index=td.find("div").length;
       var line= $('<div><input type="text" class="ipt15" name="key-'+index+'" value="" />--><input type="text" class="ipt30" name="value-'+index+'" value="" /></div>');
        $(this).before(line);
        return false;
    });
    $("table.edit-table").on('click',"a[aid='addSimpleArry']",function(){
        var td = $(this).closest("td"),index=td.find("div").length;
        var line= $('<input type="text" class="ipt15" name="'+td.attr('name')+'-'+index+'" value="" />');
        $(this).before(line);
        return false;
    });
    $("table.edit-table").on('click',"a[aid='addArray']",function(){
        var line=$('<span><div><input type="text" class="ipt15" name="key-0" value="" />--><input type="text" class="ipt30" name="value-0" value="" /></div><a href="javascript:;" class="add-list" aid="addKV">添加属性</a></span>')
        $(this).before(line);
        return false;
    })
beforeL=function() {
    $("input.json").val(function(i,text){
        var td=$(this).closest('td');
        if(td.find("a[aid='addSimpleArry']").length>0){
            return '[' + $.map(td.find("input"), function(n){return '"'+ n.value+'"'}).join()+']';
        }else if(td.find("a[aid='addArray']").length>0) {
            return '['+$.map(td.find("span"),function(n){
                        return '{'+ $.map($(n).find("div"),function(nn){
                                    if($(nn).children("input:first").val()=='') return;
                                    return '"' + $(nn).children("input:first").val() + '":"' + $(nn).children("input:last").val() + '"'
                                }).join().replace(/\'/g,'\\"')+'}';
                    }).join()+']'
        }else if(td.find("a[aid='addKV']").length>0){
            return '{' + $.map(td.find("div"), function (n) {
                        if($(n).children("input:first").val()=='') return;
                        return '"' + $(n).children("input:first").val() + '":"' + $(n).children("input:last").val() + '"'
                    }).join().replace(/\'/g,'\\"') + '}';
        }
    })
    return true;
}
</script>
</body>
</html>
