<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="../include/require.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单确认</title>
    <style type="text/css">
        .erro-msg {
            position: inherit;
            top: 27px;
            left: 50px;
            color: #ff0000;
        }
    </style>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <header class="header">
        <div class="wrapper clearfix">
            <div class="logo">
                <a href="/"><img src="<c:url value="/images/logo.png"/>" alt="智护伞"></a>
            </div>
            <div class="shopping-header">
                <h3><span>确认订单</span></h3>
            </div>
            <div class="order-user">
                <a href="javascript:;" class="icon-xiala">${user.cellPhone}</a>|
                <a href="<c:url value="/user/order"/>">我的订单</a>
            </div>
        </div>
    </header>
    <!-- showImg-->
    <div class="bg-hui">
        <div class="order-confirmation">
            <div class="wrapper">
                <form id="orderFrom" action="/buy/order" method="post" target="_blank">
                    <div class="address">
                        <h3 class="address-title">添加收货地址</h3>

                        <div class="clearfix">
                            <ul class="clearfix address-list">
                                <c:forEach items="${deliverys}" var="address">
                                    <li ${address.isDefault eq '0'?'default="0" style="border:1px solid #ff0000;"':''}
                                            aid="${address.id}">
                                        <h3 at="name">${address.name}</h3>

                                        <p at="phone">${address.phone}</p>

                                        <p at="address">${address.province}${address.city}${address.area}${address.exact}</p>
                                    </li>
                                </c:forEach>
                            </ul>
                            <div class="address-add">
                                <img src="<c:url value="/images/addBtn.png"/>">

                                <p>添加新地址</p>
                            </div>
                        </div>
                    </div>
                    <dl class="clearfix user-list">
                        <dt>支付方式</dt>
                        <dd>
                            <c:forEach items="${pays}" var="pay">
                                <label class="important">
                                    <input type="radio" id="payType-${pay.name}" name="payType" value="${pay.name}" ${pay.isDefault eq '0'?'checked="checked"':''}/>${pay.remark}
                                    </label>
                                    <%--<p class="important">在线支付（支持支付宝、银联、财付通、小米钱包等）</p></label>--%>
                            </c:forEach>
<%--                                    <label class="important">
                                        <input type="radio" id="payType-wxPay" name="payType" value="wxPay" checked="checked" />微信支付
                                        </label>--%>
                        </dd>
                    </dl>
                    <dl class="clearfix user-list">
                        <dt>配送方式</dt>
                        <dd>
                            <c:forEach items="${sends}" var="send">
                                <label class="important" fee="${send.fee}"><input type="radio" id="send-${send.code}" name="logistics"
                                                                                  value="${send.code}"  ${send.isDefault?'checked="checked"':''}/>${send.name}
                                </label>
                            </c:forEach>
                        </dd>
                        <p style="font-size: 10px;font-size:10px;color: #FF0000;padding-left: 125px;">目前仅支持德邦快递</p>
                    </dl>
                    <dl class="clearfix user-list">
                        <dt>配送时间</dt>
                        <dd>
                            <p class="delivery-time">
                                <a href="javascript:void(0);" class="delivery-time-focus" name="deliveryTime"
                                   val="1234567">不限送货时间：周一至周日</a>
<%--                                <a href="javascript:void(0);" name="deliveryTime" val="12345">工作日送货：周一至周五</a>
                                <a href="javascript:void(0);" name="deliveryTime" val="67">双休日、假日送货：周六至周日</a>--%>
                            </p>
                        </dd>
                        <input type="hidden" name="deliveryTime" value=""/>
                    </dl>
<%--                    <dl class="clearfix user-list">
                        <dt>发票</dt>
                        <dd>
                            <div class="invoice">
                                <p class="invoice-title">
                                    <a href="javascript:void(0);" class="invoice-title-focus">电子发票（非纸质）</a>
                                    <a href="javascript:void(0);">普通发票（纸质）</a>
                                </p>

                                <div class="invoice-details">
                                    电子发票目前仅对个人用户开具，不可用于单位报销，不随商品寄送。<a href="#" class="know-invoice">什么是电子发票</a>

                                    <div class="invoice-layer">
                                        <ul>
                                            <li>1.感谢您选择电子发票，智护伞开具的发票均为真实有效的合法发票，与传统纸质发票具有同等法律效力，可作为u、用户维权、保修的有效凭据。</li>
                                            <li>2.电子开票不可用于单位报销，开具后不可更换纸质发票。</li>
                                            <li>3.您在订单详情的“发票信息”栏可查看、下载您的电子发票。</li>
                                        </ul>
                                        <p><a href="javascript:;">了解详情>></a></p>
                                    </div>
                                    <img src="<c:url value="/images/jiao_01.png"/>" class="jiaoImg" alt="">
                                </div>
                            </div>
                        </dd>
                    </dl>--%>
                    <h3 class="order-list-title"><a href="<c:url value="/user/cart"/>">返回购物车></a>商品及优惠券</h3>

                    <div class="order-list-content">
                        <table class="order-list-address" width="100%">
                            <c:set var="amount" value="0.0"/>
                            <c:set var="pAmount" value="0.0"/>
                            <c:forEach items="${productItem}" var="product">
                                <tr>
                                    <td style="width:750px;">
                                        <p><img src="<c:url value="${y:toMap(product.imgs).small}"/>" height="30px"
                                                alt="">${product.name}
                                        </p>
                                    </td>
                                    <td class="center">${product.price}×${product.sellCount}</td>
                                    <td class="center">有货</td>
                                    <td class="center"><i class="red">${y:round((product.priceY * product.sellCount)*100)/100}</i></td>
                                </tr><
                                <c:set var="amount" value="${amount+y:round(product.price * product.sellCount*100)/100}"/>
                                <c:set var="pAmount"
                                       value="${pAmount+y:round(((product.price-product.priceY) * product.sellCount)*100)/100}"/>
                            </c:forEach>
                        </table>
                    </div>
                    <div class="clearfix coupons-price">
                        <div class="coupons-content">
                            <p class="use-coupons">使用优惠券</p>
                            <input type="text" name="couponId" value="" style="display: none"/>
                            <%--                        <ul class="coupons-list">
                                                        <li>＋1元得智护伞礼品袋</li>
                                                    </ul>--%>
                        </div>
                        <ul class="price-content">
                            <li>
                                <span class="price-content-title">商品件数：</span>

                                <p class="price-important">${productCount}件</p>
                            </li>
                            <li id="amount" val="${amount}">
                                <span class="price-content-title">金额合计：</span>

                                <p class="price-important">${amount}元</p>
                            </li>
                            <li id="pAmount" val="${pAmount}" style="display: none;">
                                <span class="price-content-title">活动优惠：</span>

                                <p class="price-important">-${pAmount}元</p>
                            </li>
                            <li id="privilege">
                                <span class="price-content-title">优惠券抵扣：</span>

                                <p class="price-important">-0元</p>
                            </li>
                            <li id="freight">
                                <span class="price-content-title">运费：</span>

                                <p class="price-important">元</p>
                            </li>
                            <li>
                                <span class="price-content-title zonge">应付总额：</span>

                                <p class="price-important"><i class="price-sum">${amount-pAmount-10}</i>元 </p>
                            </li>
                        </ul>
                    </div>
                    <input type="hidden" name="userId" require="true" value="${user.id}"/>
                    <input type="hidden" name="contact" require="true" value=""/>
                    <input type="hidden" name="preferential" value="${pAmount}"/>
                    <input type="hidden" name="couponPrice" value="0"/>
                    <input type="hidden" name="freight" value=""/>
                    <input type="hidden" name="money" validType="money" value="${amount-pAmount}"/>
                    <input type="hidden" name="formToken" value="${formToken}"/>
                    <p class="place-order">
                        <a href="javascript:;" id="order">提交订单</a>
                    </p>
                </form>
            </div>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp" %>
</div>
<!-- 收货地址 -->
<div class="zhezhao" style="display:none;"></div>
<ul class="shipping-address" style="display:none;">
    <form id="deliveryFrom" method="post">
        <li>
            <input type="text" require="realName" name="name" placeholder="姓名">
        </li>
        <li>
            <input type="text" validType="phone" name="phone" placeholder="手机号"
                   onkeyup="value=value.replace(/[^\d.]/g,'')">
        </li>
        <li>
            <select id="s1" name="province"></select>
        </li>
        <li>
            <select id="s2" name="city"></select>
        </li>
        <li>
            <select id="s3" name="area"></select>
        </li>
        <li>
            <input type="text" name="exact" validType="address" placeholder="详细地址" class="detailed-address">
        </li>
        <li>
            <input type="text" name="zip" onkeyup="value=value.replace(/[^\d.]/g,'')" maxlength="7" placeholder="邮政编码">
        </li>
        <li>
            <input type="text" name="mark" placeholder="地址标签">
        </li>
        <input type="hidden" name="id" value=""/>
        <input type="hidden" name="isDefault" value="1"/>
        <input type="hidden" name="userId" require="true" value="${user.id}"/>

        <li>
            <input type="submit" value="保存" class="address-ok">
            <input type="reset" value="取消" class="address-reset">
        </li>
    </form>
</ul>
</body>
<script src="<c:url value="/js/geo.js"/>"></script>
<script>
    setup();
    inputBlur("input[name]");


    //选择配送地址
    $("ul.address-list").on('click', 'li', function () {
        $(this).parent().find('li').css('border', '1px solid #dcdcdc');
        $(this).css('border', '1px solid #ff0000')
        $("input[name='contact']").val($(this).attr('aid'));
    })
    //配送方式改变
    $("input[name='logistics']").on('click', function () {
        var ma = $(this).parent().attr('fee'), li = $("#freight"), p = li.find("p.price-important");
        $("input[name='freight']").val(ma);
        p.html(ma + '元');
        $("ul.price-content li i.price-sum").html(Math.round((parseFloat($("#amount").attr('val')) - parseFloat($("#pAmount").attr('val')) - parseFloat($("input[name='couponPrice']").val()) +
                parseFloat(ma)) * 100) / 100);
    })
    //配送时间改变
    $("p.delivery-time a").click(function () {
        $("input[name='deliveryTime']").val($(this).attr('val'));
        return false;
    })
    $("#deliveryFrom").submit(function () {
        $(".shipping-address a.address-ok").attr("disabled", true);
        $(".shipping-address a.address-ok").val('正在保存');
        $(".shipping-address a.address-ok").css('background', '#A9A9A9');
        if (!validRule.validate("#deliveryFrom")) return false;
        var operate = $("input[name='id']").get(0).value == '' ? 'add' : 'update';
        $.post("${baseUrl}/user/delivery/" + operate, fromData('#deliveryFrom'), function (data) {
            if (data.code == 0) {
                $('.shipping-address').fadeOut();
                $(".zhezhao").fadeOut();
                var li = $('<li aid="' + data.data.id + '"><h3 at="name">' + data.data.name + '</h3><p at="phone">' + data.data.phone + '</p><p at="address">' + data.data.province + data.data.city + data.data.area + data.data.exact + '</p></li>');
                $(li).css('border', '1px solid #ff0000');
                $("ul.address-list").append(li)
                li.click();
            } else {
                $(".shipping-address a.address-ok").attr("disabled", false);
                $(".shipping-address a.address-ok").val('保存');
                $(".shipping-address a.address-ok").css('background', '#D11721');
            }
        }, 'json');
        return false;
    })
    $("#orderFrom").submit(function () {
        if (!validRule.validate(this)) {
            alert("订单信息有误,请核对后提交");
            var focus=$("h4.erro-msg").closest("[id]").attr('id');
            screen.height = focus.css('height');
            return false;
        }
        if(parseFloat($("i.price-sum").html())<0){
            alert("订单信息有误,请核对后提交!");
            return false;
        }
        setTimeout("location.href=baseUrl+'/'", 3000);
    });
    $("#order").click(function () {
        $("#orderFrom").submit()
    });
    /*    $("#order").click(function(){

     })*/
    $("p.use-coupons").click(function () {
        $("input[name='couponId']").show().focus();
//        var coupon = prompt('请输入您的优惠码!', '');
//        if(coupon!='') {
        <%--$.post(baseUrl+"/user/checkCoupon/${user.id}",{userCouponId: $.trim(coupon)},function(data){--%>
        <%--if(data.code!=0) alert(data.msg);--%>
        <%--},'json');--%>
//        }else alert('您输入的优惠码无效!')
    });
    //添加优惠券
    $("input[name='couponId']").blur(function () {
        if(this.value==undefined||this.value==''){
            $(this).fadeOut();return;
        }
        $.post(baseUrl + "/user/checkCoupon/${user.id}", {userCouponId: $.trim($(this).val())}, function (data) {
            if (data.code != 0) {
                alert(data.msg);
                $(this).val('')
                $(this).fadeOut(500);
            } else {
                $(this).attr('disabled', true);
                var couponAmount = parseFloat(data.data.couponAmount);
                $("input[name='couponPrice']").val(couponAmount<1?Math.round((parseFloat(${amount-pAmount})*(1-couponAmount))*100)/100:data.data.couponAmount);
                $("#privilege").find("p.price-important").html('-' + couponAmount<1?Math.round(parseFloat(${amount-pAmount})*(1-couponAmount)*100)/100:data.data.couponAmount + '元');
                $("ul.price-content li i.price-sum").html(Math.round((parseFloat($("#amount").attr('val')) - parseFloat($("#pAmount").attr('val')) - parseFloat($("input[name='couponPrice']").val()) +
                        parseFloat($("input[name='freight']").val())) * 100) / 100);
    }
    }, 'json');
    });
    $(function () {
        if(!$("ul.address-list>li[default]")||$("ul.address-list>li[default]").length==0){
            $("ul.address-list>li").eq(0).click();
        }else  $("input[name='contact']").val($("ul.address-list>li[default]").attr('aid'));
        $("input[name='deliveryTime']").val($("p.delivery-time>a.delivery-time-focus").attr('val'));
        var ma = $("input[name='logistics']:checked").parent().attr('fee');
        $("#freight").find("p.price-important").html(ma+'元');
        $("input[name='freight']").val(ma);
        $("ul.price-content li i.price-sum").html(Math.round((parseFloat($("#amount").attr('val')) - parseFloat($("#pAmount").attr('val')) - parseFloat($("input[name='couponPrice']").val()) + parseFloat(ma))*100)/100);

    })
</script>
</html>
