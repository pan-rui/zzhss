<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: panrui
  Date: 2016/3/30
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<html><head><%--<script async="" src="https://login.weixin.qq.com/cgi-bin/mmwebwx-bin/login?uuid=3b8f4b74c5c04d&tip=1&_=1459320651261&code=408"></script>--%>
    <meta charset="utf-8">

    <title>微信支付</title>
    <link rel="stylesheet" type="text/css" href="/css/common1c2d8f.css">
    <%--<link rel="stylesheet" type="text/css" href="/zh_CN/htmledition/style/emoji190985.css">--%>
    <script type="text/javascript" src="/zh_CN/htmledition/js/jquery.min14eed9.js"></script>
    <script type="text/javascript" src="/zh_CN/htmledition/js/index1c2d68.js"></script>
    <!--<script type="text/javascript" src="https://getfirebug.com/firebug-lite-debug.js"></script>-->
</head>
<body mycollectionplug="bind">
<div class="header pngFix">
    <h1 class="pay_logo"><a href="/" class="index_access"><img class="pngFix" src="<c:url value="/images/logo_pay.png"/>" alt="微信支付标志" title="微信支付"></a></h1>
</div>
<div class="content">
    <div class="wrapper mail_box">
        <div class="mail_box_inner pngFix">
            <div class="area primary">
                <div class="pay_msg qr_default" id="payMsg">
                    <div class="area_hd">
                        <h2>支付结果</h2>
                    </div>
                    <div class="area_bd" id="pay_succ">
                        <i class="icon110_msg pngFix"></i>
                        <h3 class="pay_msg_t">购买成功</h3>
                        <div id="payMsgDetail" class="vh">
                            <p class="pay_msg_desc"><span id="userName">&lt;用户&gt;</span>，你使用<strong id="bankCard">&lt;银行卡&gt;</strong>银行卡完成了本次交易。</p>
                            <p class="pay_tip"><span id="redirectTimer">5</span>秒后返回商户网页，你也可以点击 <a href="javascript:;" target="_blank" id="resultLink">这里</a> 立即返回。</p>
                        </div>
                    </div>

                    <div class="area_bd" id="pay_error">
                        <i class="icon110_msg pngFix"></i>
                        <h3 class="pay_msg_t">无法支付</h3>
                        <p class="pay_msg_desc">商品金额大于银行卡快捷支付限额</p>
                    </div>

                    <div class="area_bd" id="qr_normal">
                        <span class="qr_img_wrapper"><img class="qrcode" alt="二维码" id="QRcode" src="<c:url value="/wxQRCode"/>"><img class="guide pngFix" src="/zh_CN/htmledition/images/webpay_guide.png" alt="" id="guide" style="left: 50%; opacity: 0; display: none; margin-left: -101px;"></span>
                        <div class="msg_default_box">
                            <i class="icon60_qr pngFix"></i>
                            <p>请使用微信扫描<br>二维码以完成支付</p>
                        </div>
                        <div class="msg_box">
                            <i class="icon60_qr pngFix"></i>
                            <p><strong>扫描成功</strong>请在手机确认支付</p>
                        </div>
                    </div>

                </div>
            </div>
            <div class="area second">
                <div class="pay_bill shopping">
                    <div class="area_hd">
                        <h2>支付清单</h2>
                        <span class="icon_wrapper"><i class="icon60_pay pngFix"></i></span>
                    </div>
                    <div class="area_bd">
                        <h3 class="pay_money"> <span>￥</span>${orderMoney}</h3>
                        <div class="pay_bill_unit no_extra">
                            <dl>
                                <dt>${product}</dt>
                                <dd>${productDesc}</dd>
                            </dl>
                            <div class="pay_bill_info">
                                <p><label>交易单号</label><span class="pay_bill_value" id="orderId">${orderId}</span></p>
                                <p><label>创建时间</label><span class="pay_bill_value">${tTime}</span></p>
                            </div>
                        </div>
                        <!--
<div class="pay_bill_unit no_extra">
<dl>
<dt></dt>
<dd></dd>
</dl>
<div class="pay_bill_info">
<p><label>交易单号</label><span class="pay_bill_value"></span></p>
<p><label>创建时间</label><span class="pay_bill_value"></span></p>
</div>
</div>
-->
                    </div>
                </div>
            </div>
            <div class="aside">
                <div class="pay_widget help">
                    <div class="pay_widget_hd">
                        <i class="icon30_add_on pngFix"></i>
                    </div>
                    <div class="pay_widget_bd">
                        <strong class="widget_name">客服</strong>
                        <p class="widget_desc">${salePhone}</p>
                    </div>
                </div>
                <!--         
                  这是另一种更简单的结构，但是扩展性较差。
                        <dl class="pay_widget help">
                          <dt class="widget_name">客服</dt>
                          <dd class="widget_desc">020 - 865437767</dd>
                          <dd class="widget_pic"><i class="icon30_add_on"></i></dd>
                        </dl>
                 -->
            </div>
        </div>
        <b class="mail_box_corner left pngFix"></b>
        <b class="mail_box_corner right pngFix"></b>
    </div>
</div>
<div class="footer">
    <p class="linklist">
        <a href="http://www.tencent.com/zh-cn/index.shtml">关于腾讯</a>
        <a href="http://weixin.qq.com/cgi-bin/readtemplate?uin=&stype=&promote=&fr=&lang=zh_CN&ADTAG=&check=false&nav=faq&t=weixin_agreement&s=default">服务条款</a>
        <a href="http://kf.qq.com/product/weixin.html">反馈建议</a>
    </p>
    <p class="copyright">© 1998 - 2014 Tencent Inc. All reserved.</p>
</div>
<!--[if IE 6]>
<!--<script type="text/javascript" src="/zh_CN/htmledition/js/DD_belatedPNG1c27aa.js"></script>
<script type="text/javascript"> window.onload = function() { DD_belatedPNG.fix(".pngFix"); } </script>-->
<![endif]-->
<script src="<c:url value="/js/jquery-1.11.3.min.js"/>"></script>
<script>
    function queryState(){
        var orderId= $.trim($('#orderId').html());
        $.post("${baseUrl}/buy/loopState", {orderId: orderId}, function (data) {
            if(data.code==0) {
                if(data.data==0){
                    alert("订单支付成功!");
                    clearInterval(cle);
                    location.href = "/user/order";
                }
            }else alert(data.msg);
        }, 'json');
    }
    var cle=setInterval("queryState()", 3500);
</script>

</body></html>