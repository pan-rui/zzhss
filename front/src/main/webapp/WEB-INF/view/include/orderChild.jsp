<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="y" uri="http://www.yg.com/y" %>
<%--
  Created by IntelliJ IDEA.
  User: panrui
  Date: 2016/1/27
  Time: 18:34
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<c:forEach items="${orders}" var="orderInfo" varStatus="s">
    <table class="user-order-table user-order-table-list" statu="${orderInfo.state}">
        <colgroup>
            <col style="width:15%;">
            <col style="width:20%;">
            <col style="width:15%;">
            <col style="width:8%;">
            <col style="width:12%;">
            <col style="width:10%;">
        </colgroup>
        <tr class="bg-hui">
            <td colspan="2">
                <span class="order-time"><fmt:formatDate value="${orderInfo.ctime}" pattern="yyyy-MM-dd HH:mm:ss" /> </span>
                <span class="order-id">订单号：${orderInfo.id}</span>
            </td>
                <%--<td>Voollcci</td>--%>
            <td colspan="2">${salePhone}</td>
            <td>&nbsp;</td>
        </tr>
        <c:forEach items="${orderInfo.orderItems}" var="orderItem" varStatus="ss">
            <tr class="orderItem">
                <td>
                    <a href="<c:url value="/product?id=${orderItem.product.id}"/>"><img src="${y:toMap(orderItem.product.imgs).small}" alt=""></a>
                </td>
                <td>
                    <h3 class="order-center-title">
                        <a href="<c:url value="/product?id=${orderItem.product.id}"/>">${orderItem.product.name}</a>
                    </h3>
                    <p class="order-center-title-hui">${orderItem.product.description}</p>
                </td>
                <td><p class="order-user-img">${orderInfo.delivery.name}</p></td>
                <td>x${orderItem.count}</td>
                <td>
                    <p class="order-single-sum">订单总额￥${orderInfo.orderMoney}(含运费:￥${orderInfo.freight})</p>
                    <p class="order-pay">价格￥${orderItem.priceY}</p>
                    <p>${orderInfo.remark}</p>
                </td>
                <c:if test="${ss.first}">
                <td>
                    <c:choose>
                        <c:when test="${orderInfo.state eq 0}">
                            <a href="<c:url value="/buy/directBuy?orderId=${orderInfo.id}"/>" target="_blank" style="color: #d11721;">立即付款</a>
                        </c:when>
                        <c:otherwise>
                            <p class="wait-delivery">${y:getComment(stateEnum,orderInfo.state)}</p>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${orderInfo.state eq 0}">
                            <p oid="${orderInfo.id}"><a href="javascript:;" style="color: #999999;" class="cancelOrder">取消订单</a></p>
                        </c:when>
                        <c:when test="${orderInfo.state eq 1}">
                            <p><a href="<c:url value="/buy/sale?orderId=${orderInfo.id}"/>">申请退款</a></p>
                        </c:when>
                        <c:when test="${orderInfo.state eq 2}">
                            <p class="tracking"><a href="javascript:;" class="logistics" <%--onclick="return ${orderInfo.state lt 2?'false':'true'};"--%> logistics="${orderInfo.logistics}" logisticsId="${orderInfo.logisticsId}">跟踪</a></p>
                            <p><a href="<c:url value="/buy/sale?orderId=${orderInfo.id}"/>">申请售后</a></p>
                        </c:when>
                        <c:when test="${orderInfo.state eq 5}">
                            <p class="tracking"><a href="javascript:;" class="logistics" <%--onclick="return ${orderInfo.state lt 2?'false':'true'};"--%> logistics="${orderInfo.logistics}" logisticsId="${orderInfo.logisticsId}">跟踪</a></p>
                            <p><a href="<c:url value="/buy/sale?orderId=${orderInfo.id}"/>">申请售后</a></p>
                        </c:when>
                        <c:when test="${orderInfo.state eq 7}">
                            <p><a href="<c:url value="/buy/sale?orderId=${orderInfo.id}"/>">申请售后</a></p>
                        </c:when>
                        <c:otherwise>
                            <%--<p class="tracking"><a href="javascript:;" class="logistics" &lt;%&ndash;onclick="return ${orderInfo.state lt 2?'false':'true'};"&ndash;%&gt; logistics="${orderInfo.logistics}" logisticsId="${orderInfo.logisticsId}">跟踪</a></p>--%>
                        </c:otherwise>
                    </c:choose>
                    <p><a href="<c:url value="/buy/orderDetail?orderId=${orderInfo.id}&couponId=${empty orderInfo.couponId?'':orderInfo.couponId}"/>">订单详情</a></p>

<%--                    <c:if test="${orderInfo.state gt 2 && orderInfo.state lt 8}">
                        <p><a href="<c:url value="/buy/sale?orderId=${orderInfo.id}"/>">${orderInfo.state eq 1?'退款':'申请售后'}</a></p>
                    </c:if>--%>
                </td>
                </c:if>
            </tr>
        </c:forEach>
    </table>
</c:forEach>

<script>
$("a.logistics").click(function(){
    var $this=$(this);
    var logisticsId = $(this).attr('logisticsId'), logistics = $(this).attr('logistics');
    if(logisticsId==undefined||logisticsId=='')
    return false;
    $.post(baseUrl + "/logistics", {com: logistics, no: logisticsId}, function (data) {
        var $win = $("#device"), logisticsTab = $('<table id="logisticsTab"></table>');
        $win.html('');
        if(data.code==0){
          $.each(data.data.list,function(i,n){
            logisticsTab.append('<tr><td>'+n['datetime']+'</td>&nbsp;&nbsp;<td>【'+n['zone']+'】'+n['remark']+'</td></tr>')
        })
        }else{
            logisticsTab.append('<tr><td>查询物流结果超时,请稍后重试!</td></tr>');
        }
        $win.append(logisticsTab);
        var  x = $this.closest('tr').find('td:eq(2)').offset().left, y = $this.offset().top+$this.height();
        $win.css({left:x,top:y});
        $win.fadeIn();
    }, "json");
})
/*    $("#device").mouseleave(function(){
        $("#device").fadeOut();
    })*/
/*    $("tr.orderItem>td").has("p.tracking").mouseleave(function(){
        $("#device").fadeOut();
    })*/
    $("body").click(function(event){
        var $popWin=$("#device");
        if($popWin&&$popWin.is(":visible")&&$popWin.find(event.target).length<=0)
            $popWin.fadeOut();
    })
    $(".cancelOrder").click(function(){
        var $this = $(this);
        $this.html("取消中...");
        $.ajax({
            url:baseUrl + "/buy/cancelOrder",
            type:'post',
            async:false,
            dataType:'json',
            success:function (result) {
                if(result.code==0){
                    alert('订单取消成功,请联系客服(QQ:2025825045)退款!');
                    location.reload(true);
//                    $this.closest("table[statu]").remove();
                }else alert('取消失败,请联系客服人员!')
            },
            data:{id: $(this).closest("p").attr("oid")}
        })
        return false;
    })
</script>
