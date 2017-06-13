<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/23
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@include file="include/require.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>智护伞后台管理</title>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
<div region="north" split="true" border="false" style="overflow: hidden; height: 30px;background: url(/css/images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%;line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
    <%--<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">--%>
            <span style="float:right; padding-right:20px;" class="head">欢迎您 ${admin.adminName} <a href="#" id="editpass">修改密码</a> <a href="#" id="loginOut">安全退出</a></span>
    <span style="padding-left:10px; font-size: 16px; "><img src="../../css/images/blocks.gif" width="20" height="20" align="absmiddle"/>智护伞后台管理</span>
</div>
<div region="south" split="true" style="height: 30px; background: #D2E0F2; ">
    <div class="footer">3个任务等完成</div>
</div>
<div region="west" hide="true" split="true" title="导航菜单" style="width:180px;height: 800px" id="west">
    <div id="nav" class="easyui-accordion" fit="true" border="false">
        <!--  导航内容 -->
    </div>
</div>
<div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
    <div id="tabs" class="easyui-tabs" fit="true" border="false">
        <div title="欢迎使用" style="padding:20px;overflow:hidden; color:red; ">

        </div>
    </div>
</div>
<!--修改密码窗口-->
<div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false" maximizable="false"
     icon="icon-save" style="width: 300px; height: 250px; padding: 5px; background: #fafafa;">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <table cellpadding=3 style="font-size: 10px">
                <tr>
                    <td>新密码：</td>
                    <td><input id="txtNewPass" type="password" class="txt01" validType="password"/></td>
                </tr>
                <tr>
                    <td>确认密码：</td>
                    <td><input id="txtRePass" type="password" class="txt01" validType="password"/></td>
                </tr>
            </table>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">确定</a>
            <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
        </div>
    </div>
</div>

<div id="mm" class="easyui-menu" style="width:150px;">
    <div id="mm-tabupdate">刷新</div>
    <div class="menu-sep"></div>
    <div id="mm-tabclose">关闭</div>
    <div id="mm-tabcloseall">全部关闭</div>
    <div id="mm-tabcloseother">除此之外全部关闭</div>
    <div class="menu-sep"></div>
    <div id="mm-tabcloseright">当前页右侧全部关闭</div>
    <div id="mm-tabcloseleft">当前页左侧全部关闭</div>
    <div class="menu-sep"></div>
    <div id="mm-exit">退出</div>
</div>
<script type="text/javascript">
    var _menus = {menus:${menus}};
    var auths=${y:toArrayStr(urlList)};
    var adminId='${admin.id}';
    var tabIndex=0;
    //设置修改密码窗口
    function openPwd() {
        $('#w').window({
            title: '修改密码',
            width: 300,
            modal: true,
            shadow: true,
            closed: true,
            height: 160,
            resizable: false
        });
    }
    //关闭修改密码窗口
    function closePwd() {
        $('#w').window('close');
    }
    //修改密码
    function serverLogin() {
        var $newpass = $('#txtNewPass');
        var $rePass = $('#txtRePass');


        if ($newpass.val() != $rePass.val()) {
            $.messager.alert('系统提示', '两次密码不一至！请重新输入', 'warning');
            return false;
        }
        if ($(".erro-msg:visible").size() < 1)
            $.post(baseUrl + '/admin/modifyPass', {newpass: $newpass.val()}, function (data) {
                if (data.code == 0)
                    $.messager.alert('系统提示', '恭喜，密码修改成功！<br>您的新密码为：' + $newpass.val(), 'info');
                else
                    $.messager.alert("错误", data.msg, "error");
                $newpass.val('');
                $rePass.val('');
                closePwd();
            }, "json");

    }
    inputBlur("input");
    //初始化左侧
    function initLeftMenu() {
        $("#nav").accordion({animate: false});
        $.each(_menus.menus, function (i, n) {
            var menulist = '';
            menulist += '<ul>';
            if(n.menus!=undefined)
            $.each(n.menus, function (j, o) {
                for(var u in auths)
                    if(o.url.indexOf(auths[u].indexOf('?')>0?auths[u].substring(0,auths[u].indexOf('?')):auths[u])==0 ){
                        menulist += '<li><div><a ref="' + o.id + '" href="javascript:;" rel="' + baseUrl+(auths[u].indexOf('?')>0?auths[u].substring(0,auths[u].indexOf('?'))== o.url?auths[u]: o.url:o.url) + '" ><span class="icon icon-' + o.icon + '" >&nbsp;</span><span class="nav">' + o.menuName + '</span></a></div></li> ';
                        break;
                    }
            })
            menulist += '</ul>';
            $('#nav').accordion('add', {
                title: n.menuName,
                content: menulist,
                iconCls: 'icon icon-' + n.icon
            });
        });
        $('.easyui-accordion li a').click(function () {
            var tabTitle = $(this).children('.nav').text();

            var url = $(this).attr("rel");
            var id = $(this).attr("ref");
            var icon = getIcon(id);

            _addNewTab(tabTitle, url, icon);
            $('.easyui-accordion li div').removeClass("selected");
            $(this).parent().addClass("selected");
        }).hover(function () {
            $(this).parent().addClass("hover");
        }, function () {
            $(this).parent().removeClass("hover");
        });

        //选中第一个
        var panels = $('#nav').accordion('panels');
        var t = panels[0].panel('options').title;
        $('#nav').accordion('select', t);
    }
    //获取左侧导航的图标
    function getIcon(id) {
        var icon = 'icon icon-';
        $.each(_menus.menus, function (i, n) {
            if(n.menus!=undefined)
            $.each(n.menus, function (j, o) {
                if (o.id == id) {
                    icon += o.icon;
                    return false;
                }
            })
        })
        return icon;
    }
    $(function () {
        openPwd();
        $('#editpass').click(function () {
            $('#w').window('open');
        });
        $('#btnEp').click(function () {
            serverLogin();
        })
        $('#btnCancel').click(function () {
            closePwd();
        })
        $('#loginOut').click(function () {
            $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function (r) {
                if (r)
                    location.href = baseUrl+'/exit';
            });
        });
        initLeftMenu();
        contextMenu();
        tabCloseEven();
        $('#tabs').tabs({
            onSelect: function (title,i) {
                var currTab = $('#tabs').tabs('getTab', title);
                var iframe = $(currTab.panel('options').content);
                var src = iframe.attr('src');
                if(src&&i!=tabIndex){
                    $('#tabs').tabs('update', { tab: currTab, options: { content: createFrame(src)}});
                    tabIndex=i;
                }
            },
            onAdd:function(title,index){
                tabIndex=index;
            }
        });
        $("#nav").accordion('getPanel','其它设置').panel('options').onExpand=
            function(){
                var $pan = $(this);
                $.messager.prompt('提示信息', '请输要操作的表名：', function(r){
                    if (r)
                        $pan.find("li a[rel]").each(function(i,domE){
                            domE.rel=domE.rel.substring(0,domE.rel.lastIndexOf('/')+1)+r;
                        })
                });
            }
    });
</script>
</body>
</html>
