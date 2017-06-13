<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>产品中心</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <%@include file="../include/top.jsp"%>
<%--content right--%>
    <div class="bg-hui padding-bottom50">
        <div class="wrapper clearfix">
            <div class="content-right">
                <div class="content">
                    <div class="clearfix introduce">
                        <div class="introduceImg">
                            <img src="${y:toMap(product.imgs).single}" alt="">
                        </div>
                        <div class="introduce1">
                            <h3>规格参数</h3>
                            <ul>
                                <c:forEach items="${y:toLinkedMap(product.spec)}" var="entry" varStatus="s">
                                    <li>${entry.key}${empty entry.value?"":"："}${entry.value}</li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="introduce2" width="100%">
                            <h3>配件明细</h3>
                            <table>
                                <tr>
                                    <th style="width:140px;">名称</th>
                                    <th style="width:70px;">单位</th>
                                    <th style="width:70px;">数量</th>
                                </tr>
                                <c:forEach items="${y:toArray(product.accessories)}" var="accessories" varStatus="s">
                                    <tr>
                                        <td>${accessories.name}</td>
                                        <td>${accessories.unit}</td>
                                        <td>${accessories.count}</td>
                                    </tr>
                                </c:forEach>
                                <%-- <tr>
                                     <td>遥控器</td>
                                     <td>个</td>
                                     <td>1</td>
                                 </tr>
                                 <tr>
                                     <td>喇叭</td>
                                     <td>个</td>
                                     <td>1</td>
                                 </tr>
                                 <tr>
                                     <td>使用说明书</td>
                                     <td>册</td>
                                     <td>1</td>
                                 </tr>
                                 <tr>
                                     <td>备贴</td>
                                     <td>张</td>
                                     <td>1</td>
                                 </tr>
                                 <tr>
                                     <td>保修卡</td>
                                     <td>张</td>
                                     <td>1</td>
                                 </tr>
                                 <tr>
                                     <td>合格证</td>
                                     <td>张</td>
                                     <td>1</td>
                                 </tr>--%>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp"%>
    <!-- floatmenu -->
    <div class="float-menu">
        <h3 class="menu-title"><span>${product.name}</span></h3>
        <%@include file="../include/leftMenu.jsp"%>
    </div>
    <%--<div class="zhezh" style="position: fixed;width:100%;left:0;top:0;height:100%;background:rgba(243,243,243,1);z-index:2;display: none"></div>--%>
    <div style="position:fixed;width: 1024px;height:auto;display:none;z-index: 99;text-align:center;vertical-align:middle;padding:80px 0px 0px 143px;" id="vDiv">
        <img src="<c:url value="/images/close.jpg"/>" alt="关闭" style="position: relative;top: -580px;left: 525px;;z-index: 100;"/>

    </div>
</div>
<script>
    $("ul.menu li a[link]").on("click",function(){
        $.get(baseUrl+"/link",{content:$(this).attr("link")},function(data){
            if(data.code==0){
                $("#Wrap > div").not(".header,.footer,.float-menu").remove();
                $(".header").after(data.msg);
            }else alert(data.msg);
        },'json')
    })
    $("h3.menu-title").click(function(){
        $(this).next("ul.menu").toggle(100,'linear');
    });
</script>
</body>
</html>
