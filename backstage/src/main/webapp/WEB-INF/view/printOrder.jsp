<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@include file="include/require.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <title>订单打印-${orderInfo.id}</title>
    <style type="text/css">
        table td{
            height:20px;
        }
    </style>
</head>

<body>
<div id="page1">
    <table>
        <tr height="21" border="0">
            <td colspan="5" height="21" width="585" align="center">出货单</td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" border="1">
        <col width="217px"/>
        <col width="207px"/>
        <col width="195px"/>
        <col width="201px"/>
        <col width="265px"/>

        <tr height="21">
            <td height="21">订单号：</td>
            <td colspan="2">${orderInfo.id}</td>
            <td>渠道</td>
            <td>${empty orderInfo.payNum?'直销':'官网'}</td>
        </tr>
        <tr height="21">
            <td height="21">客户名：</td>
            <td colspan="2">${orderInfo.delivery.name}</td>
            <td>手机号</td>
            <td>${orderInfo.delivery.phone}</td>
        </tr>
        <tr height="21">
            <td height="21">联系地址</td>
            <td colspan="4">${orderInfo.delivery.province}${orderInfo.delivery.city}${orderInfo.delivery.area}${orderInfo.delivery.exact}</td>
        </tr>
        <tr height="21">
            <td colspan="5" height="21"></td>
        </tr>
        <tr height="21">
            <td height="21">序号</td>
            <td>产品名称</td>
            <td>单位</td>
            <td>数量</td>
            <td>是否要安装码</td>
        </tr>
        <c:forEach items="${orderInfo.orderItems}" var="orderItem" varStatus="s">
            <tr height="21">
                <td height="21">${s.index+1}</td>
                <td>${orderItem.prodName}</td>
                <td>pcs</td>
                <td>${orderItem.count}</td>
                <td>${empty orderInfo.payNum?'否':'是'}</td>
            </tr>
        </c:forEach>
        <tr height="21">
            <td height="21"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>

        <tr height="21">
            <td height="21">财务：</td>
            <td>库管：</td>
            <td>制单：</td>
            <td></td>
            <td>提货人（默认客户）</td>
        </tr>
    </table>
</div>
<object id="jatoolsPrinter" classid="clsid:B43D3361-D075-4BE2-87FE-057188254255"
        codebase="http://printfree.jatools.com/jatoolsPrinter.cab#version=8,6,0,0"></object>
<script type="text/javascript">
    function doPrint() {
        var myDoc = {
            settings: {
                paperName: 'a4',   //A4纸张
                orientation: 1,     //1为纵向,2为横向
                topMargin: 100,    //设置边距,单位是1/10毫米
                leftMargin: 100,
                bottomMargin: 100,
                rightMargin: 100
            },
            documents: document,
            /*
             要打印的div 对象在本文档中，控件将从本文档中的 id 为 'page1' 的div对象，
             作为首页打印id 为'page2'的作为第二页打印            */
            copyrights: '杰创软件拥有版权  www.jatools.com' // 版权声明,必须
        };
        document.getElementById("jatoolsPrinter").print(myDoc, false); // 直接打印，不弹出打印机设置对话框
    }
    $(function () {
        doPrint()
    })
</script>
</body>
</html>
