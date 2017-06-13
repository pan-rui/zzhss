<%--  显示(固定,非固定)列, 上面搜索条件,下(编辑按钮)button及操作项均为可配置
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/27
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@include file="include/require.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="/js/grid.js"></script>
</head>
<body>
<!--帮助内容-->
<div class="mod-help-info">
    <span title="帮助" class="icon-help"></span>
    <div class="mod-help-content">
        <y:toHtml text="${menuInfo.help}"/>
        <%--这里是帮助，随便写点什么吧，如果不需要，请把内容删掉！--%>
    </div>
</div>
<!--帮助内容end-->
<div class="easyui-panel" fit="true" border="false">
    <table id="list_data"></table>
</div>
<div id="tb" class="toolbar">
    <div class="cmd-ctrl-panel">
        <%--<a href="javascript:void(0);" class="show-so-frm" title="显示搜索" onclick="showSoForm()"></a>--%>
        <div class="cmd-box">
            <a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-search" onclick="postSearch()">查询</a>
            <a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-search" onclick="allRecord()">全部</a>
            <%--<a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-refresh" onclick="reloadGrid();">刷新</a>--%>
            <a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-detail" onclick="viewRecord()">查看</a>
        </div>
    </div>
    <div class="rich-search-box">
        <form action="" method="get" id="search_form">
            <ul>
                <c:forEach items="${y:toArray(menuInfo.search)}" var="search" varStatus="s">
                    <c:forEach items="${columnsInfo}" var="column" varStatus="c">
                        <c:if test="${column.column_name eq search}">
                            <li>
                                <label class="label">${column.data_type ne 'enum'?column.column_comment:fn:substringBefore(column.column_comment,'{')}：</label>
                                <div class="input">
                                    <c:choose>
                                        <c:when test="${column.data_type eq 'enum'}">
                                            <y:select id="${column.column_name}" name="page.params.${column.column_name}" data="${y:toMap(fn:substring(column.column_comment ,fn:indexOf(column.column_comment,'{' ),-1))}" defVal="${column.column_default}"></y:select>
                                        </c:when>
                                        <c:when test="${fn:startsWith(column.data_type,'date')}">
                                            <input type="datetime" class="easyui-datebox" id="${column.column_name}" name="page.params.${column.column_name}" value="${page.params[column.column_name]}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" class="ipt" id="${column.column_name}" name="page.params.${column.column_name}" value="${page.params[column.column_name]}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </li>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </ul>
        </form>
    </div>
</div>
<script type="text/javascript">
    var datagrid; //定义datagrid全局变量
    var tableName = "${tableName}"; //定义datagrid全局变量
    var listUrl="${listUrl}";
    var gridPageSize = ${page.pageSize}; //定义默认的列表显示条数
    var initData = {
        "total":${page.totalRecord}, "rows": [
            <c:forEach items="${page.results}" var="bean" varStatus="s">
            {
                <c:forEach items="${columnsInfo}" var="column" varStatus="c">
                <c:choose>
                <c:when test="${fn:startsWith(column.data_type,'date')}">
                "${column.column_name}": "${fn:replace(bean[column.column_name],'\"','\\\"')}"${c.last?"":","}
                </c:when>
                <c:otherwise>
                "${column.column_name}": "<y:toHtml text="${fn:replace(bean[column.column_name],'\"','\\\"')}"/>"${c.last?"":","}
                </c:otherwise>
                </c:choose>
                </c:forEach>
                <c:if test="${not empty menuInfo.operate}">
                ,"controler":"${fn:replace(menuInfo.operate,'\"','\\\"')}"
                </c:if>
            }
            ${s.last?"":","}
            </c:forEach>
        ], "error": "false", "msg": "处理出错！"
    };
    //固定列
    var fzcolumns = [[
        { field: "cBox",checkbox:true }
        <c:if test="${not empty menuInfo.active}">,
        <c:forEach items="${y:toArray(menuInfo.fixedly)}" var="fixedly" varStatus="s">
        <c:forEach items="${columnsInfo}" var="column" varStatus="c">
            <c:if test="${column.column_name eq fixedly}">{
            field: "${fixedly}",
            title: "${column.column_comment}",
            sortable: true,
            align: "left"
            ${fn:startsWith(column.data_type,'date')?',formatter:dateFt':''}
        }</c:if>
        </c:forEach>
        ${s.last?"":","}
        </c:forEach>
        </c:if>
    ]];
    //数据列
    var tbcolumns = [[
        <c:choose>
        <c:when  test="${empty menuInfo.active}">
        <c:forEach items="${columnsInfo}" var="column" varStatus="c">
        {
            field: "${column.column_name}",
            title: "${column.data_type ne 'enum'?column.column_comment:fn:substringBefore(column.column_comment,'{')}",
            sortable: true,
            align: "left"
            ${fn:startsWith(column.data_type,'date')?',formatter:dateFt':''}
        }${c.last?"":","}
        </c:forEach>
        </c:when>
        <c:otherwise>
        <c:forEach items="${y:toArray(menuInfo.active)}" var="fixedly" varStatus="s">
        <c:forEach items="${columnsInfo}" var="column" varStatus="c">
            <c:if test="${column.column_name eq fixedly}">{
            field: "${fixedly}",
            title: "${column.data_type ne 'enum'?column.column_comment:fn:substringBefore(column.column_comment,'{')}",
            sortable: true,
            align: "left"
            ${fn:startsWith(column.data_type,'date')?',formatter:dateFt':''}
        }</c:if>
        </c:forEach>
        ${s.last?"":","}
        </c:forEach>
        </c:otherwise>
        </c:choose>
        ,{field: "controler", title: "操作", align: "left", formatter: control_btn}
    ]];
    function dateFt(value,row,index) {
        if(!value) return '';
        return dateFormat(value,'yyyy-MM-dd HH:mm:ss');
    }
    $(function(){
        datagrid = $('#list_data').datagrid({
            url: listUrl,
            loader: function(_6c5,_6c6,_6c7){
                if(initData){
                    _6c6(initData);
                    initData = null;
                }else{
                    var opts=$(this).datagrid("options");
                    if(!opts.url){
                        return false;
                    }
                    $.ajax({type:opts.method,url:opts.url,data:_6c5,dataType:"json",success:function(data){
                        _6c6(data);
                    },error:function(){
                        _6c7.apply(this,arguments);
                    }});
                }
            },
            multiSort:true,
            method: 'GET',
            toolbar:'#tb',
            //--翻页配置--
            pagination:true,
            pageSize:gridPageSize,
            pageList:[,20,25,30,50,500,2000],
            //--翻页配置--
            rownumbers:true,
            fit:true, //铺满可是区域显示
            border: false,
            //sortName: 'title',
            idField: 'id',
            nowrap: true,
            autoRowHeight:false,
            sortOrder: 'desc',
            frozenColumns:fzcolumns,
            columns:tbcolumns,
            singleSelect: true,
            selectOnCheck: true,
            checkOnSelect: true,
            onLoadError:function(msg){
                if (typeof(msg)=='string') {
                    $.messager.alert("错误提示","服务器信息无法正常返回！1"+msg,"error");
                }else if(typeof(msg)=='object'&&msg.responseText){
                    $.messager.alert("错误提示","服务器信息无法正常返回！2"+msg,"error");
                }else{
                    $.messager.alert("错误提示","服务器信息无法正常返回！3","error");
                }
            }
        })
    })
    function control_btn(value, row, index) {
        var _actStr = [];
        _actStr.push('<div class="dg-ctrl-btn">')
        <c:forEach items="${y:toArray(menuInfo.operate)}" var="operate" varStatus="o">
        <c:forEach items="${urlList}" varStatus="u" var="ur">
        <c:if test="${fn:startsWith(operate.url,ur)}">
        <c:choose>
        <c:when test="${columnsInfo[operate.position-1].data_type eq 'enum'}">
        _actStr.push('<label url="${operate.url}" did="' + row['id'] + '" func="${operate.function}">${operate.title}:');
        var $select = $("<y:select name="${columnsInfo[operate.position-1].column_name}" data="${y:toMap(fn:substring(columnsInfo[operate.position-1].column_comment ,fn:indexOf(columnsInfo[operate.position-1].column_comment,'{' ),-1))}" defVal="${columnsInfo[operate.position-1].column_default}"/>");
        var $val ="${operate.val}";
        if ($val == '') {
            var cur=row['${columnsInfo[operate.position-1].column_name}'];
            $select.find("option[value='" + cur + "']").attr("selected", "selected");
            _actStr.push($select.get(0).outerHTML);
        } else if ($val.indexOf(',')>0) {
            $select.children().each(function(i,n){
                if($.inArray(n.value,eval('('+$val+")"))<0) $(n).remove();
            })
            _actStr.push($select.get(0).outerHTML);
        } else {
            var cur=parseInt(row['${columnsInfo[operate.position-1].column_name}']);
                var $v=parseInt($val);
            $select.children().each(function(i,n){
                if(parseInt(n.value)<cur || parseInt(n.value)>cur+$v)
                $(n).remove();
            })
            _actStr.push($select.get(0).outerHTML);
        }
        _actStr.push('</label>');
        </c:when>
        <c:otherwise>
        _actStr.push('<button name="${columnsInfo[operate.position-1].column_name}" value="${operate.val}" url="${operate.url}" did="' + row['id'] + '" onClick="${operate.function}(this)">${operate.title}</button>');
        </c:otherwise>
        </c:choose>
        </c:if>
        </c:forEach>
        </c:forEach>
        _actStr.push('</div>')
        return _actStr.join('');
    }
    $(function () {
        $("div.datagrid-view2").on("change", "label > select", function (event) {
            var label = $(this).parent();
            var params = {'bean.id': label.attr('did'),url: label.attr('url'),name: label.get(0).innerText,tableName: "${tableName}",column:this.name};
            params['bean.' + this.name] = this.value;
            params.row=datagrid.datagrid('getSelected');
            eval("(" + label.attr("func") + "(params))");
        });
    })
</script>
</body>
</html>
