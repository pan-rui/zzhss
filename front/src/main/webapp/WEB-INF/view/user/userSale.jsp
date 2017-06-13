<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="include/require.jsp"%>--%>
<html>
<head>
    <meta name="keywords" content="防盗器，GPS防盗器，电摩防盗器，电摩GPS防盗器，电动车防盗器，摩托车防盗器，智能GPS防盗器，电动车GPS防盗器，摩托车GPS防盗器，GPS防盗系统，GPS方案公司，GPS防盗器价格">
    <meta name="Description" content="智护伞防盗器官网提供最全的GPS防盗器价格，是技术领先的电动车GPS防盗器厂家，在摩托车防盗器的基础上开发云GPS防盗系统，专业的电摩GPS防盗器GPS方案公司">
    <title>首页</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <%@include file="../include/top.jsp"%>
    <!-- showImg-->
    <div class="bg-hui afterSale-padding">
        <div class="wrapper bgfff afterSale">
            <form id="dataForm" method="post" action="<c:url value="/user/sale"/>" enctype="multipart/form-data">
            <div class="afterSale-apply">
                <h2 class="clearfix">申请售后<a href="javascript:;" id="sale" link="After_Service" target="_blank">售后政策</a><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2025825045&site=qq&menu=yes">联系卖家</a></h2>
                <table class="afterSale-table" width="100%">
                    <tr>
                        <th></th>
                        <th>商品名称</th>
                        <th>包装清单</th>
                        <th>赠送清单</th>
                        <th>购买数量</th>
                    </tr>
                    <tbody>
                    <c:forEach items="${orderInfo.orderItems}" var="orderItem" varStatus="s">
                        <tr>
                            <td>
                                <a href=""><img src="${y:toMap(orderItem.product.imgs).small}" alt="" title=""></a>
                            </td>
                            <td>
                                <h3><a href="<c:url value="/product?id=${orderItem.product.id}"/>">${orderItem.product.name}</a></h3>
                                <p>${orderItem.product.description}</p>
                            </td>
                            <td></td>
                            <td>
                                
                            </td>
                            <td>
                                <h3>${orderItem.count}</h3>
                            </td>
                            <input type="hidden" value="${orderItem.product.id}" name="productId">
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <ul class="afterSale-question">
                    <li>
                        <span><i>*温馨提示：</i></span>
                        <p style="line-height:34px;">本次售后服务将有<i>深圳研冠科技有限公司</i>为您提供</p>
                    </li>
                    <li class="clearfix">
                        <span><i>*</i>服务类型：</span>
                        <!-- <div class="selectFloat select1"> -->
                            <select name="saleType" id="afterSale-question-type" class="chosen-select-deselect">
                                <option value="0" checked="checked" name="afterSale-question-type">维修</option>
                                <option value="1" name="afterSale-question-type">换货</option>
                                <option value="2" name="afterSale-question-type">退货</option>
                            </select>
                        <!-- </div> -->
                    </li>
                    <li>
                        <span><i>*</i>提交数量：</span>
                        <input type="text" name="saleCount" maxlength="5" onkeyup="value=value.replace(/[^\d]/g,'')" require="true">
                    </li>
                    <li class="afterSale-question-desc">
                        <span><i>*</i>问题描述：</span>
                        <textarea name="description" cols="44" rows="3"></textarea>
                        <p>1-500字</p>
                    </li>
                    <li class="afterSale-question-button">
                        <span>图片信息：</span>
                        <a href="javascript:void(0);" class="files">
                            <input type="file" id="afterSale-question-button" name="pic">
                            上传图片
                        </a>
                            <%--<input type="file" id="afterSale-question-button" name="pic">--%>
                        <h3>为了帮助我们更好的解决问题，请您上传图片</h3>
                        <p>最多可上传5张图片，每张图片大小不超过5M,支持bmp.gif.jpg.jpeg格式文件</p>
                    </li>
                </ul>
            </div>
           <div class="afterSale-Confirm">
                <h2>确认信息</h2>
                <ul class="afterSale-message">
                    <li class="afterSale-message-accord">
                        <span>申请凭据：</span>
                        <input type="radio" value="0" checked="checked" name="evidence">有发票
                        <input type="radio" value="1" name="evidence">有检测报告
                    </li>
                    <li>
                        <span>返回方式：</span>
                        <select name="backType" id="afterSale-message-back">
                            <option value="快递至第三方卖家">快递至第三方卖家</option>
                        </select>
                    </li>
                    <li>
                        <span>收货地址：</span>
                        <input type="text" name="address" value="${Sale_Address}" disabled="disabled">
<%--                        <select id="s1" name="province"></select>
                        <select id="s2" name="city"></select>
                        <select id="s3" name="area"></select>
                        <textarea name="" id="afterSale-message-address" cols="36" rows="2" placeholder="请输入详细地址"></textarea>--%>
                    </li>
                    <li>
                        <span>收货人：</span>
                        <input type="text" placeholder="周" name="name" value="${Sale_Name}" disabled="disabled">
                    </li>
<%--                    <li>
                        <span>客户姓名：</span>
                        <input type="text" placeholder="周" value="" name="userName" require="true">
                    </li>--%>
                    <li>
                        <span>手机号码：</span>
                        <input type="text" placeholder="" name="phone" value="${Sale_Phone}" disabled="disabled">
                        <%--<input type="checkbox" checked="checked">与订单中手机号相同--%>
                    </li>
                </ul>
               <input type="submit" value="提  交" class="afterSale-btn">
            </div>
                <input type="hidden" value="${user.id}" name="userId">
                <input type="hidden" value="${orderInfo.id}" name="orderId">
            </form>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp"%>
</div>
<script>
    $(function(){
        inputBlur("input[name]");
        $("#dataForm").submit(function(){
            return validRule.validate($(this));
        })
    })
</script>
</body>
</html>
