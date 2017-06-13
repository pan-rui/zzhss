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
    <script type="text/javascript" src="${baseUrl}/js/grid.js"></script>
    <script type="text/javascript" src="${baseUrl}/js/datagrid-detailview.js"></script>
    <script type="text/javascript" src="${baseUrl}/js/customExcel.js"></script>
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
            <c:forEach items="${urlList}" var="url" varStatus="u">
                <c:if test="${fn:startsWith(y:concat('/system/save/',tableName ),url )}">
                    <a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="addRecord()">增加</a>
                    <a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="updRecord()">修改</a>
                </c:if>
                <c:if test="${fn:startsWith(y:concat('/system/del/', tableName),url )}">
                    <a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-remove" onclick="delRecord()">删除</a>
                </c:if>
                <c:if test="${fn:startsWith('/system/multi/',url )}">
                    <a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-filter" onclick="multiS()" id="multiS">单选模式</a>
                </c:if>
                <c:if test="${fn:startsWith('/system/refund/',url )}">
                    <a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-filter" onclick="refund()" id="refund">退款</a>
                </c:if>
                <c:if test="${fn:startsWith(y:concat('/statistic/export/', tableName),url )}">
                    <a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-remove" onclick="save_Excel()">导出到Excel</a>
                </c:if>
            </c:forEach>
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
                                            <y:select id="${column.column_name}" name="page.params.${column.column_name}" data="${y:toMap(fn:substring(column.column_comment ,fn:indexOf(column.column_comment,'{' ),-1))}" defVal="${column.column_default}" range="${column.column_name eq key?val:''}"></y:select>
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
<div id="mmm" class="easyui-menu" style="width:150px;">
    <c:forEach items="${y:toArray(menuInfo.cMenu)}" var="me" varStatus="m">
        <c:forEach items="${urlList}" var="url" varStatus="u">
            <%--<c:set var="ur" value="${not empty me.title?me.url:(y:concat('/system/list/',me.tableName ))}"/>--%>
        <c:if test="${fn:startsWith(me.url,fn:contains(url,'?')?fn:substring(url,0 ,fn:indexOf(url, '?')):url )}">
            <div url="${baseUrl}${me.url}" data-options="iconCls:'${me.icon}'" tableName="${me.tableName}" cascadeName="${me.cascadeName}" title="${me.title}">${me.mName}</div>
        </c:if>
        </c:forEach>
    </c:forEach>
</div>
<div id="ww" class="easyui-window" title="上传文件" collapsible="false" minimizable="false" maximizable="false"  icon="icon-save" style="width: 350px; height: 150px; padding: 5px; background: #fafafa;" data-options="closed: true">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="upForm" method="post" enctype="multipart/form-data">
                    <input id="file" type="file" class="txt01" name="file"/>
<%--                    <input id="file" type="file" class="txt01" name="file"/>
                    <input id="file" type="file" class="txt01" name="file"/>--%>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a id="btnUp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">上传</a>
        </div>
    </div>
</div>
<div id="scan" class="easyui-window" title="扫描发货" collapsible="false" minimizable="false" maximizable="false"  icon="icon-save" style="width: 350px; height: 480px; padding: 5px; background: #fafafa;" data-options="closed: true">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="codeForm" method="post" enctype="application/x-www-form-urlencoded">
                安装码:<input type="checkbox" id="installCode"/><br>
                订单号:<input id="orderId" type="text" class="txt01" name="orderId" disabled="disabled"/><br>
                <span>运单号:<input id="logis" type="text" class="txt01" name="logis"/></span>
                <%--                    <input id="file" type="file" class="txt01" name="file"/>
                                    <input id="file" type="file" class="txt01" name="file"/>--%>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a id="btnCode" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">提交</a>
        </div>
    </div>
</div>
<script type="text/javascript">
    var datagrid; //定义datagrid全局变量
    var tableName = "${tableName}"; //定义datagrid全局变量
    var listUrl=baseUrl+"${listUrl}";
    var columnsInfo=${y:toArrayStr(columnsInfo)};
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
                "${column.column_name}": '<y:toHtml text="${bean[column.column_name]}"/>'${c.last?"":","}
                </c:otherwise>
                </c:choose>
                </c:forEach>
                <c:if test="${not empty menuInfo.operate}">
                ,"controler":"<y:toHtml text="${menuInfo.operate}"/>"
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
            ${fn:startsWith(column.data_type,'date')?',formatter:dateFt':column.data_type eq 'enum'?',formatter:enumFt':''}
        }</c:if>
        </c:forEach>
        ${s.last?"":","}
        </c:forEach>
        </c:if>
        ,{field: "controler", title: "操作", align: "left", formatter: control_btn}
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
            ${fn:startsWith(column.data_type,'date')?',formatter:dateFt':column.data_type eq 'enum'?',formatter:enumFt':''}
        }${c.last?"":","}
        </c:forEach>
        </c:when>
        <c:otherwise>
        <c:forEach items="${y:toArray(menuInfo.active)}" var="active" varStatus="s">
        <c:forEach items="${columnsInfo}" var="column" varStatus="c">
            <c:if test="${column.column_name eq active}">{
            field: "${active}",
            title: "${column.data_type ne 'enum'?column.column_comment:fn:substringBefore(column.column_comment,'{')}",
            sortable: true,
            align: "left"
            ${fn:startsWith(column.data_type,'date')?',formatter:dateFt':column.data_type eq 'enum'?',formatter:enumFt':''}
        }</c:if>
        </c:forEach>
        ${s.last?"":","}
        </c:forEach>
        </c:otherwise>
        </c:choose>
 /*       ,{field: "controler", title: "操作", align: "center", formatter: control_btn}*/
    ]];
    function dateFt(value,row,index) {
        if(!value) return '';
        return dateFormat(value,'yyyy-MM-dd HH:mm:ss');
    }
    function enumFt(value,row,index){
        var fieldOpt=this;
            var eMap={},val='';
      var sss= $.each(columnsInfo,function(i,o){
            if(o.column_name==fieldOpt.field){
                eMap= eval('('+o.column_comment.substring(o.column_comment.indexOf('{'))+')');
                for(var s in eMap) {
                    if(s==value){
                        val = eMap[s];
                        break;
                    }
                }
                return false;
            }
        })
        return val;
    }
    $(function(){
        if('${menuInfo.cMenu}'!=''&&!$.isEmptyObject(${menuInfo.cMenu})){ //可编辑数据表格
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
                view: detailview,
                method: 'GET',
                toolbar:'#tb',
                //--翻页配置--
                pagination:true,
                pageSize:gridPageSize,
                pageList:[30,50,500,2000],
                //--翻页配置--
                rownumbers:true,
                fit:true, //铺满可是区域显示
                border: false,
//                sortName: 'state',
                idField: 'id',
                nowrap: true,
                autoRowHeight: false,
//                sortOrder: 'desc',
                frozenColumns:fzcolumns,
                columns:tbcolumns,
                singleSelect: true,
                selectOnCheck: true,
                checkOnSelect: true,
                onRowContextMenu: onContextMenu,
                detailFormatter:function(index,row){
                    return '<div style="padding:2px"><table id="ddv-' + index + '"></table></div>';
                },
                onExpandRow: function(index,row){
                    var $this = $(this);
                    var menu=$("#mmm").data('me');
                    if(menu==undefined||menu==null) return false;
                    var url=menu.attr('url'),arr=[],params={},flag=true;
                    if(menu.attr('title')!=undefined&&menu.attr('title')!=''){
                        arr[0]= $.map(menu.attr('title').split(','),function(n){
                            return {field: n, title: n, align: "center"};
                        });
                        params['param.'+menu.attr('tableName').split(',')[1]]=row[menu.attr('cascadeName')];
                    }else{
                        $.ajax({
                            url:url + '/columns',
                            async:false,
                            data:params,
                            dataType:'json',
                            context:$($('#ddv-'+index)),
                            type:'GET',
                            success:function (data) {
                                arr[0]=$.map(data,function(o){
                                    var i=o.column_comment.indexOf('}'),j= o.column_comment.indexOf('{')
                                    var comment = i == o.column_comment.length - 1 ? o.column_comment.substring(0, j): o.column_comment;
                                    if(o.data_type=='enum')
                                    return {field: o.column_name,title:comment ,align: "center",formatter:enumFt};
                                    else if(o.data_type.indexOf('date')==0)
                                        return {field: o.column_name,title:comment ,align: "center",formatter:dateFt};
                                    else  return {field: o.column_name,title:comment ,align: "center"}
                                });
                                params['param.'+menu.attr('tableName').split(',')[1]]=row[menu.attr('cascadeName')];
                            },
                            error:function(){flag=false;}
                        })
                    }
                    $('#ddv-'+index).datagrid({
                        url:url,
                        fitColumns:true,
                        singleSelect:true,
                        rownumbers:true,
                        autoRowHeight:false,
                        loadMsg:'',
                        height:'auto',
                        columns:arr,
                        method: 'POST',
                        queryParams:params,
                        onBeforeLoad:function(_733) {
                                return flag;
                        },
                        onResize:function(){
                            $('#list_data').datagrid('fixDetailRowHeight',index);
                        },
                        onLoadSuccess:function(){
                                $('#list_data').datagrid('fixDetailRowHeight',index);
                        }
                    });
                    $('#list_data').datagrid('fixDetailRowHeight',index);
                },
                onLoadError:function(msg){
                    if (typeof(msg)=='string') {
                        $.messager.alert("错误提示","服务器信息无法正常返回！11"+msg,"error");
                    }else if(typeof(msg)=='object'&&msg.responseText){
                        $.messager.alert("错误提示","服务器信息无法正常返回！22"+msg.responseText,"error");
                    }else{
                        $.messager.alert("错误提示","服务器信息无法正常返回！33","error");
                    }
                }
            });
        }else {
            datagrid = $('#list_data').datagrid({
                url: listUrl,
                loader: function (_6c5, _6c6, _6c7) {
                    if (initData) {
                        _6c6(initData);
                        initData = null;
                    } else {
                        var opts = $(this).datagrid("options");
                        if (!opts.url) {
                            return false;
                        }
                        $.ajax({
                            type: opts.method, url: opts.url, data: _6c5, dataType: "json", success: function (data) {
                                _6c6(data);
                            }, error: function (data) {
                                _6c7.apply(this, arguments);
                            }
                        });
                    }
                },
                multiSort: true,
                method: 'GET',
                toolbar: '#tb',
                //--翻页配置--
                pagination: true,
                pageSize: gridPageSize,
                pageList: [30, 50,500,2000],
                //--翻页配置--
                rownumbers: true,
                fit: true, //铺满可是区域显示
                border: false,
//                sortName: 'state',
                idField: 'id',
                nowrap: true,
                autoRowHeight: false,
//                sortOrder: 'desc',
                frozenColumns: fzcolumns,
                columns: tbcolumns,
                singleSelect: true,
                selectOnCheck: true,
                checkOnSelect: true,
/*                <c:if test="${not empty key} && ${not empty val}">
                queryParams:{'${key}':'${val}'},
                </c:if>*/
                onLoadError: function (msg) {
                    if (typeof(msg) == 'string') {
                        $.messager.alert("错误提示", "服务器信息无法正常返回！1" + msg, "error");
                    } else if (typeof(msg) == 'object' && msg.responseText) {
                        alert(msg.responseText)
                        $.messager.alert("错误提示", "服务器信息无法正常返回！2" + msg, "error");
                    } else {
                        $.messager.alert("错误提示", "服务器信息无法正常返回！3", "error");
                    }
                }
            })
        }
    })
    <%--var arry='${listUrl}'.indexOf('?')>0?'${listUrl}'.substring('${listUrl}'.indexOf('?')+1).split('&'):[];--%>
    function control_btn(value, row, index) {
        var _actStr = [];
        _actStr.push('<div class="dg-ctrl-btn">')
        <c:forEach items="${y:toArray(menuInfo.operate)}" var="operate" varStatus="o">
        <c:forEach items="${urlList}" varStatus="u" var="ur">
        <c:if test="${fn:startsWith(operate.url,fn:contains(ur,'?')?fn:substring(ur,0 ,fn:indexOf(ur, '?')):ur )}">
        <c:choose>
        <c:when test="${columnsInfo[operate.position-1].data_type eq 'enum'}">
        <c:choose>
        <c:when test="${columnsInfo[operate.position-1].column_name eq key && fn:contains(operate.val,',')}">
        <c:if test="${fn:startsWith(val,y:toArray(operate.val).get(0))}">
        _actStr.push('<label url="${baseUrl}${operate.url}" did="' + row['id'] + '" func="${operate.function}">${operate.title}:');
        var $select = $("<y:select name="${columnsInfo[operate.position-1].column_name}" data="${y:toMap(fn:substring(columnsInfo[operate.position-1].column_comment ,fn:indexOf(columnsInfo[operate.position-1].column_comment,'{' ),-1))}" defVal="${columnsInfo[operate.position-1].column_default}"/>");
        var $val ="${operate.val}";
        var cur=row['${columnsInfo[operate.position-1].column_name}'];
        $select.children().each(function(i,n){
            if($.inArray(parseInt(n.value),eval('('+$val+')'))<0 && n.value!=cur) $(n).remove();
        })
        _actStr.push($select.get(0).outerHTML);
        _actStr.push('</label>');
        </c:if>
        </c:when>
        <c:otherwise>
        _actStr.push('<label url="${baseUrl}${operate.url}" did="' + row['id'] + '" func="${operate.function}">${operate.title}:');
        var $select = $("<y:select name="${columnsInfo[operate.position-1].column_name}" data="${y:toMap(fn:substring(columnsInfo[operate.position-1].column_comment ,fn:indexOf(columnsInfo[operate.position-1].column_comment,'{' ),-1))}" defVal="${columnsInfo[operate.position-1].column_default}"/>");
        var $val ="${operate.val}";
        var cur=row['${columnsInfo[operate.position-1].column_name}'];
        if ($val == '') {
            $select.find("option[value='" + cur + "']").attr("selected", "selected");
            _actStr.push($select.get(0).outerHTML);
        } else if ($val.indexOf(',')>0) {
            $select.children().each(function(i,n){
                if($.inArray(parseInt(n.value),eval('('+$val+')'))<0 && n.value!=cur) $(n).remove();
            })
            _actStr.push($select.get(0).outerHTML);
        } else {
            var cur=parseInt(row['${columnsInfo[operate.position-1].column_name}']);
            var $v=parseInt($val);
            $select.children().each(function(i,n){
                if((parseInt(n.value)<cur || parseInt(n.value)>cur+$v))
                    $(n).remove();
            })
            _actStr.push($select.get(0).outerHTML);
        }
//        }
        _actStr.push('</label>');
        </c:otherwise>
        </c:choose>
        </c:when>
        <c:otherwise>
        _actStr.push('<button name="${columnsInfo[operate.position-1].column_name}" value="${operate.val}" url="${baseUrl}${operate.url}" did="' + row['id'] + '" ind="'+index+'" onClick="${operate.function}(this)">${operate.title}</button>');
        </c:otherwise>
        </c:choose>
        </c:if>
        </c:forEach>
        </c:forEach>
        _actStr.push('</div>')
        return _actStr.join('');
    }
    function onContextMenu(e,row){
            e.preventDefault();
            $('#mmm').data({'ind':row});
            $('#mmm').menu('show',{
                left: e.pageX,
                top: e.pageY
            });
    }
    $("#mmm").on('click','div[url]',function(e){
        $("#mmm").data('me',$(this));
        datagrid.datagrid('expandRow',$('#mmm').data('ind'))
    })

    $(function () {
//        $("div.datagrid-view2").on("change", "label > select", function (event) {
        $(document).on("change", "div.dg-ctrl-btn label>select", function (event) {
            var label = $(this).parent();
            var params = {'bean.id': label.attr('did'),url: label.attr('url'),name: label.get(0).innerText,tableName: "${tableName}",column:this.name};
            params['bean.' + this.name] = this.value;
            params.row=datagrid.datagrid('getSelected');
            eval("(" + label.attr("func") + "(params))");
        });
    })
    function save_Excel() {//导出Excel文件
        var title='${tableName}_${admin.adminName}_'+dateFormat(Date(),'yyyy-MM-dd');
        var data = datagrid.datagrid('getExcelXml', { title: title, removeFirstCol: 0, removeLastCol: 1}); //获取datagrid数据对应的excel需要的xml格式的内容
        //用ajax发动到动态页动态写入xls文件中
        var url = baseUrl+'/statistic/export/${tableName}';
        var dlurl = baseUrl+'/statistic/download/'+title;
        $.ajax({
            url: url, data: { data: data }, type: 'POST', dataType: 'json',
            success: function (fn) {
                if(fn.code==0)
                    window.location = dlurl+".xls?filePath=" + fn.msg; //执行下载操作
                else $.messager.alert("操作失败", fn.msg, 'error');
            },
            error: function (xhr) {
                alert('动态页有问题\nstatus：' + xhr.status + '\nresponseText：' + xhr.responseText)
            }
        });
        return false;
    }
/*    $(document).on("keyup",'div.rich-search-box input',function(event){
        if(event.keyCode==13) postSearch();
    })*/
</script>
</body>
</html>
