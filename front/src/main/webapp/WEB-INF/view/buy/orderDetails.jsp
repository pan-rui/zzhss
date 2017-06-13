<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="../include/require.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单详情</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <header class="header">
        <div class="wrapper clearfix">
            <div class="logo">
                <a href="<c:url value="/"/>"><img src="<c:url value="/images/logo.png"/>" alt="智护伞"></a>
                <img src="<c:url value="/images/logo1.png"/>" alt="智护伞"/>
            </div>
            <ul class="nav">
                <li class="nav-focus"><a href="<c:url value="/"/>">首页</a></li>
                <li>
                    <a href="javascript:;" onclick="return false;">产品中心</a>
                    <div class="sub-nav">
                        <c:forEach items="${productss}" var="product">
                            <a href="${baseUrl}/product?id=${product.id}">${product.name}</a>
                        </c:forEach>
                    </div>
                </li>
                <li><a href="<c:url value="/app/"/>">APP下载</a></li>
                <li><a href="<c:url value="/find/"/>" id="find">智护伞查车</a></li>
                <li><a href="<c:url value="/service"/>">服务中心</a></li>
                <li><a href="http://75549.vhost1.cloudvhost.cn/bbs" target="_blank">官方论坛</a></li>
            </ul>
            <%--            <div class="shopping-header">
            <h3><span>我的购物车</span><a href="#">问题反馈 ></a></h3>
        </div>--%>
            <div class="order-user">
                <div class="order-hover">
                    <a href="javascript:;" class="icon-xiala">${user.cellPhone}</a>
                    <ul class="user-xiala">
                        <%--<li><a href="javascript:;">优惠券</a></li>--%>
                        <li><a href="<c:url value="/user/modifyPass"/> ">修改密码</a></li>
                        <li><a href="<c:url value="/user/exit"/>">退出登录</a></li>
                    </ul>
                </div>
                <div class="order-left">|<a href="<c:url value="/user/order"/>">我的订单</a></div>
            </div>
        </div>
    </header>
    <!-- showImg-->
    <div class="bg-hui orderDetails">
        <div class="wrapper">
            <ul class="order-details-pos clearfix">
                <li><h3><a href="javascript:; ">我的订单</a></h3></li>
                <li>&nbsp;>&nbsp;<a href="<c:url value="/user/order"/>">订单中心</a>&nbsp;>&nbsp;</li>
                <li>订单：${order.id}</li>
            </ul>
            <div class="bgfff user-order-state">
                <p>订单号：${order.id}&nbsp;&nbsp;状态：<i
                        class="order-ok">${order.state ne 8?y:getComment(stateEnum,order.state):'交易结束(已取消)'}</i></p>
                <p>订单已完成，感谢您在智护伞购物，欢迎您对本次交易及所购商品进行评价。 <%--<a href="#">发表评价</a>--%></p>
                <%--<p class="order-tips">重要提醒：智护伞及销售商不会以<i>订单异常、系统升级</i>为由，要求您点击任何网址链接进行退款操作，烦请关注平台“<a href="#">谨防诈骗公告声明</a>”</p>--%>
                <ul class="order-state-shaft">
                    <li class="order-state-shaft1 order-state-shaft-ok">
                        <p class="order-state-shaftBu">1</p>
                        <h3>提交订单</h3>
                        <p><fmt:formatDate value="${order.ctime}" pattern="yyyy-MM-dd"/><br><fmt:formatDate
                                value="${order.ctime}" pattern="HH:mm:ss"/></p>
                    </li>
                    <li class="order-state-shaft2 ${order.state gt 1?'order-state-shaft-ok':''}">
                        <c:choose>
                            <c:when test="${order.state eq '2' || order.state eq '5' || order.state eq '7'|| order.state eq '1'|| order.state eq '0'}">
                                <p class="order-state-shaftBu">2</p>
                                <h3>商品已出库</h3>
                                <p><fmt:formatDate value="${order.startDeliveryTime}"
                                                   pattern="yyyy-MM-dd"/><br><fmt:formatDate
                                        value="${order.startDeliveryTime}" pattern="HH:mm:ss"/></p>
                            </c:when>
                            <c:when test="${order.state eq '3'|| order.state eq '4'}">
                                <p class="order-state-shaftBu">2</p>
                                <h3>售后处理中</h3>
                            </c:when>
                            <c:when test="${order.state eq '6' || order.state eq '9'}">
                                <p class="order-state-shaftBu">2</p>
                                <h3>售后审核通过</h3>
                            </c:when>
                            <c:otherwise></c:otherwise>
                        </c:choose>
                    </li>
                    <li class="order-state-shaft3 ${order.state gt 3?'order-state-shaft-ok':''}">
                        <c:choose>
                            <c:when test="${order.state eq '4'|| order.state eq '3'}">
                                <p class="order-state-shaftBu">3</p>
                                <h3>售后审核失败</h3>
                            </c:when>
                            <c:when test="${order.state eq '2' || order.state eq '5' || order.state eq '7'|| order.state eq '1'|| order.state eq '0'}">
                                <p class="order-state-shaftBu">3</p>
                                <h3>等待收货</h3>
                                <p>${y:toMap(order.endDeliveryTime)['5']}</p>
                            </c:when>
                            <c:when test="${order.state eq '6' || order.state eq '9'}">
                                <p class="order-state-shaftBu">3</p>
                                <h3>待换货/放款</h3>
                            </c:when>
                        </c:choose>
                    </li>
                    <li class="order-state-shaft4 ${order.state gt 6?'order-state-shaft-ok':''}">
                        <c:choose>
                            <c:when test="${order.state eq '2' || order.state eq '5' || order.state eq '7'|| order.state eq '1'|| order.state eq '0'}">
                                <p class="order-state-shaftBu">4</p>
                                <h3>交易完成</h3>
                                <p> ${y:toMap(order.endDeliveryTime)['7']}<br></p>
                            </c:when>
                            <c:when test="${order.state eq '8'}">
                                <p class="order-state-shaftBu">2</p>
                                <h3>交易结束</h3>
                                <p> ${y:toMap(order.endDeliveryTime)['7']}<br></p>
                            </c:when>
                            <c:when test="${order.state eq '9'|| order.state eq '6'||order.state eq '3'}">
                                <p class="order-state-shaftBu">4</p>
                                <h3>退货成功</h3>
                            </c:when>
                        </c:choose>
                    </li>
                    <li class="order-state-buwei ${order.state gt 6?'order-state-shaft-ok':''}">&nbsp;</li>
                </ul>
            </div>
            <ul class="order-details-tab clearfix">
                <li class="order-details-tab-focus">订单跟踪</li>
                <%--<li>付款信息</li>--%>
            </ul>
            <div class="bgfff order-details-tab-content">
                <div class="order-details-order">
                    <table width="100%">
                        <c:forEach items="${logistics.list}" var="logis" varStatus="s">
                            <tr>
                                <th width="160">${logis.datetime}</th>
                                <th>${logis.remark}</th>
                            </tr>
                        </c:forEach>
                    </table>
                    <ul class="order-details-courier clearfix">
                        <li>送货方式：普通快递</li>
                        <li>承运人：${order.remark}<%--<a href="#">快递咨询</a>--%></li>
                        <li>货运单号：${order.logisticsId}<%--<a href="#">点击查询</a>--%></li>
                    </ul>
                </div>
            </div>
            <div class="order-details-show">
                <h3 class="order-details-show-title">订单消息</h3>
                <div class="bgfff">
                    <ul class="order-details-show-list">
                        <li>
                            <h3>收货人信息</h3>
                            <p>收货人：${order.delivery.name}</p>
                            <p>
                                地址：${order.delivery.province}${order.delivery.city}${order.delivery.area}${order.delivery.exact}</p>
                            <p>手机号码：${order.delivery.phone}</p>
                            <p>邮政编码：${order.delivery.zip}</p>
                        </li>
                        <li>
                            <h3>支付、配送方式</h3>
                            <p>支付方式：${payType}</p>
                            <p>配送方式：${order.remark}</p>
                            <p>运费：￥${order.freight}</p>
                        </li>
                        <li>
                            <h3>发票信息</h3>
                            <p>发票类型：不开发票</p>
                        </li>
                        <li>
                            <h3>订单返赠信息</h3>
                            <p>
                                优惠券：${order.couponDict.couponName}&nbsp;&nbsp;抵扣${empty order.couponDict.couponAmount?0:order.couponDict.couponAmount}元</p>
                        </li>
                    </ul>
                    <div class="order-details-order-list clearfix">
                        <h3 class="order-details-order-list-title">商品清单</h3>
                        <table class="user-order-table user-order-table-list">
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
                                    <span class="order-time"><fmt:formatDate value="${order.ctime}"
                                                                             pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                    <%--<span class="order-id">订单详情：${order.id}</span>--%>
                                </td>
                                <td></td>
                                <td colspan="2">${salePhone}</td>
                                <td>&nbsp;</td>
                            </tr>
                            <c:forEach items="${order.orderItems}" var="orderItem" varStatus="s">
                                <tr>
                                    <td>
                                        <a href="<c:url value="/product?id=${orderItem.product.id}"/>"><img
                                                src="${y:toMap(orderItem.product.imgs).small}" alt=""></a>
                                    </td>
                                    <td>
                                        <h3 class="order-center-title">
                                            <a href="<c:url value="/product?id=${orderItem.product.id}"/>">${orderItem.product.name}</a>
                                        </h3>
                                        <p class="order-center-title-hui">${orderItem.product.description}</p>
                                    </td>
                                    <td><p class="order-user-img">${order.delivery.name}</p></td>
                                    <td>x${orderItem.count}</td>
                                    <td>
                                        <p class="order-single-sum">订单总额￥${order.orderMoney}</p>
                                        <p class="order-pay">价格￥${orderItem.priceY}</p>
                                        <p>${order.remark}</p>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <ul class="price-content">
                            <li>
                                <span class="price-content-title">金额合计：</span>
                                <p class="price-important">${order.money+order.preferential}元</p>
                            </li>
                            <li>
                                <span class="price-content-title">优惠</span>
                                <p class="price-important">-${order.preferential+order.couponDict.couponAmount}元</p>
                            </li>
                            <li>
                                <span class="price-content-title">运费：</span>
                                <p class="price-important">${order.freight}元</p>
                            </li>
                            <li>
                                <span class="price-content-title zonge">应付总额：</span>
                                <p class="price-important"><i class="price-sum">${order.orderMoney}</i>元 </p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <p style="height:80px;"></p>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp" %>
</div>
</body>
</html>
