<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="include/require.jsp"%>--%>
<!DOCTYPE html>
<html>
<head>
  <title>服务中心</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <%@include file="include/top.jsp"%>
    <!-- showImg-->
    <div class="bg-hui padding-bottom50">
        <div class="wrapper clearfix">
            <div class="content-left">
                <h3 class="menu-title"><span>常见问题</span></h3>
                <ul class="menu">
                    <li class="menu-focus">
                        <a href="#page1">安装</a>
                    </li>
                    <li>
                        <a href="#page2">下载</a>
                    </li>
                    <li>
                        <a href="#page3">注册</a>
                    </li>
                    <li>
                        <a href="#page4">添加设备</a>
                    </li>
                    <li>
                        <a href="#page5">定位</a>
                    </li>
                    <li>
                        <a href="#page6">报警</a>
                    </li>
                    <li>
                        <a href="#page7">设置</a>
                    </li>
                    <li>
                        <a href="#page8">其他</a>
                    </li>
                    <li>
                        <a href="#page9">售后</a>
                    </li>
                    <li>
                        <a href="#page10">联系我们</a>
                    </li>
                </ul>
                <h3 class="menu-title"><span>售后服务</span></h3>
                <ul class="menu">
                    <li>
                        <a href="#page11">购买须知</a>
                    </li>
                    <li>
                        <a href="#page12">购买指南</a>
                    </li>
                    <li>
                        <a href="#page13">支付方式</a>
                    </li>
                    <li>
                        <a href="#page14">配送方式</a>
                    </li>
                    <li>
                        <a href="#page15">订单查询</a>
                    </li>
                    <li>
                        <a href="#page16">365天无忧服务</a>
                    </li>
                    <li>
                        <a href="#page17">7天无理由退货</a>
                    </li>
                    <li>
                        <a href="#page18">30天只换不修</a>
                    </li>
                    <li>
                        <a href="#page19">保修细则</a>
                    </li>
                    <li>
                        <a href="#page20">智护伞零售部件三包标准</a>
                    </li>
                    <li>
                        <a href="#page21">保修免责范围</a>
                    </li>
                    <li>
                        <a href="#page22">保修零部件指导价</a>
                    </li>
                </ul>
               <%-- <h3 class="menu-title"><span>智护伞使用攻略</span></h3>
                <ul class="menu">
                    <li>
                        <a href="#page23">智护伞产品安装教程</a>
                    </li>
                    <li>
                        <a href="#page24">智护伞APP使用手册</a>
                    </li>
                </ul>--%>
            </div>
            <div class="content-right">
                <div class="content">
                    <h3 id="page1" class="content-title">安装</h3>
                    <ul class="content-list">
                        <li>
                            <h3> 【安装线如何接】</h3>
                            <p>找到控制器电源正负接插头与终端红黑正负极端子头对插，注意红黑线序。</p>
                            <p>找到控制器三防接插头与终端橙黄端子头对插，注意三色线序需对应。</p>
                            <p>终端白黄绿端子头与外置喇叭端子头对插，注意三色线序需对应。</p>
                        </li>
                        <li>
                            <h3> 【安装线如何判断】</h3>
                            <p>ACC线 </p>
                            <p>万用表红笔接电线，黑笔接地，当电动车钥匙在OFF状态时电压为0伏，钥匙转到ON状态时电压为电瓶电压。</p>
                            <p>低电平刹车线</p>
                            <p>万用表调直流（DC）电压200V档，黑色表针与电瓶负极相连，红色表针与控制器上的线路逐个接触，电压显示4.5-5V。这条线判断为低电平刹车线。</p>
                            <p>电机相线</p>
                            <p>万用表调 直流（DC）电压200V档，黑色表针与控制器上输入端电源负极连接，滚动车轮，用红色表针接触控制器上的每一条线，看万用表是否有电压显示，有电压显示，滚动车轮速度块，电压高，速度慢，电压低。（电压高低与车轮速度相关）。这样确认为电机相线。</p>
                        </li>
                    </ul>
                    <%--<p>特别注意：本终端需移动联通GPRS流量卡一张。如有问题请联系当地经销商处理。</p>--%>
                    <h3 class="content-title" id="page2">下载</h3>
                    <ul class="content-list">
                        <li>
                            <h3> 【下载智护伞APP】</h3>
                            <p>您可登录智护伞官网（<a href="www.zhihusan.com" style="color:red;">www.zhihusan.com</a>）或者扫码说明书中二维码进行下载，iOS用户还可登录App Store搜索智护伞进行客户端下载。</p>
                        </li>
                        <li>
                            <h3>【用微信扫描二维码，无法下载智护伞APP，应该如何操作】</h3>
                            <p>长按二维码扫出的网址链接，选择打开后转跳至智护伞官网。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page3">注册</h3>
                    <ul class="content-list">
                        <li>
                            <h3>【注册帐号，无法收到验证短信（无信号）】</h3>
                            <p>请确认手机短信收发功能是否正常（确保无欠费，有信号）；如果没有信息，请到有手机信号的区域进行注册。</p>
                        </li>
                        <li>
                            <h3>【注册帐号时，无法收到验证短信，手机有信号，没有欠费】</h3>
                            <p>一天最多可发送5次短信验证码，若已经超过次数，需等到第二天再进行注册。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page4">添加设备</h3>
                    <ul class="content-list">
                        <li>
                            <h3>【设备添加失败（未重启设备）】</h3>
                            <p>出厂时设备为关机状态，若设备没有供电开机则无法添加成功。需要将设备充电约1~3分钟后再进行添加；或者将设备安装到电动车上，并保证电瓶车供电开机成功。</p>
                        </li>
                        <li>
                            <h3>【扫描二维码绑定设备时，提示无效二维码】</h3>
                            <p>请核对APP扫描到的二维码与设备上二维码下方的字串，若显示不相同，请拨打我们的客服电话。若显示相同，继续使用。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page5">定位</h3>
                    <ul class="content-list">
                        <li>
                            <h3>【GPS无法定位（首次定位）】</h3>
                            <p>定位器在首次定位时需要有1-3分钟连接GPS信号进行定位，建议车辆在空旷区域行驶一段时间后，重新尝试定位。不要选择在高楼密集或者地库等卫星信号的盲区进行定位。</p>
                        </li>
                        <li>
                            <h3>【设备定位有误差（30米以内）】</h3>
                            <p>确认人显示位置是否正确？30米误差值，目前是属于正常范围内。</p>
                        </li>
                        <li>
                            <h3>【设备定位有误差（30米以外/人显示位置不正确）】</h3>
                            <p>人物的位置不精准，用户手机地图存在问题，建议打开WIFI，重定位人物，确认人与车位置。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page6">报警</h3>
                    <ul class="content-list">
                        <li>
                            <h3>【报警模式定义】</h3>
                            <p>用户可以在快速设置栏中，设定报警模式。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page7">其他</h3>
                    <ul class="content-list">
                        <li>
                            <h3>【GPS最高可承受多少电压】</h3>
                            <p>可安装在 36V / 48V / 60V / 72V (以产品实际包装为准)的车辆上。</p>
                        </li>
<%--                        <li>
                            <h3>【离线地图无法下载】</h3>
                            <p>因之前下载地图时，该地图下载出错，错误数据已在手机中，需在手机SD卡根目录-Amap文件夹（存放离线地图）整个删除后重新尝试。</p>
                        </li>--%>
                    </ul>
                    <h3 class="content-title" id="page8">联系我们</h3>
                    <ul class="content-list">
                        <li>
                            <p>微信公众号：智护伞</p>
                            <p><img src="images/bbsWeixin_03.jpg" alt=""></p>
                            <p>微信二维码</p>
                            <p>扫一扫使用更方便</p>
                            <p>官方微博：@智护伞</p>
                            <p>客服电话：4008 - 345 - 866（工作日 9:00 ~ 18:30）</p>
                            <p>官网地址：www.zhihusan.com</p>
                            <p>有任何问题或建议，欢迎您随时联系我们</p>
                            <p>以上信息仅供参考，如有变更恕不另行通知</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page9">购买须知</h3>
                    <ul class="content-list">
                        <li>
                            <h3>【下单后信息不可修改】</h3>
                            <p>用户在下单时填写的收货信息，在您成功购买后，将作为您的最终收货信息，一经提交，不可更改。信息包含姓名、联系电话、收货地址、型号、颜色等。</p>
                        </li>
                        <li>
                            <h3>【销售区域限制】</h3>
                            <p>由于物流配送原因，个别地区出现无法到货情况，对于不能正常参与购买的用户，我们非常抱歉。。</p>
                            <p>同时，我们将每天对订单信息进行筛选，无法送达的订单，我们将主动与您联系，并在7个工作日内进行退款。请您保持电话畅通。</p>
                        </li>
                        <li>
                            <h3>【关于发货】</h3>
                            <p>下单后您的商品会在7个工作日由智护伞货品部统一发出。</p>
                            <p>物流配送服务由德邦物流提供，您在收到商品后，如出现产品包装损坏等原因，请拒签并及时联系官方客服热线。</p>
                            <p>您可以登录<a href="www.zhihusan.com" style="color:red;">www.zhihusan.com</a>，进入“我的订单”了解订单信息。</p>
                        </li>
                        <li>
                            <h3>【物流进度查询】</h3>
                            <%--<p>您可以通过订单在智护伞官网www.zhihusan.com或快递方官网进行查询。</p>--%>
                            <p>你可以登陆智护伞官网进行订单查询，或者通过快递公司官网，查询物流进度。</p>
                        </li>
                        <li>
                            <h3>【关于服务网点】</h3>
                            <p>目前，智护伞在全国已拥有合作体验店100家。大部分地区暂时未开设售后维修服务网点。我们会尽快在全国进行网点完善，敬请期待。</p>
                        </li>
                        <li>
                            <h3>【若购买错误需要申请退款】</h3>
                            <p>您的订单在下单后2小时内，可以在线申请退款。</p>
                            <p>超过2小时后将无法在线申请退款，您可以在物流电话预约送货的时候告知拒收，我们会在您拒收后7个工作日为您办理全额退款。</p>
                        </li>
                        <li>
                            <h3>【关于运费】</h3>
                            <p>我们向消费者实行全国统一包邮。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page10">购买指南</h3>
                    <ul class="content-list">
                        <li>
                            <h3>1.新用户注册或已有账号登陆</h3>
                            <p>亲爱的智粉，首先您需要在智护伞官网注册账号</p>
                        </li>
                        <li>
                            <h3>2.选择购买区域 </h3>
                            <p>请选择您需要配送的区域。请认真核对填写的收货联系人、电话、地址等相关详细信息。</p>
                        </li>
                        <li>
                            <h3>3.加入购物车 </h3>
                            <p>选择您喜爱的智护伞型号及颜色，点击“加入购物车” 。</p>
                        </li>
                        <li>
                            <h3>4.填写购物信息</h3>
                            <p>点击“下一步”，填写收货人、地址、手机号等信息、并选择支付方式、配送方式、发票类型等。订单提交后无法修改，请您付款前仔细核实。</p>
                        </li>
                        <li>
                            <h3>5.完成支付 </h3>
                            <p>确认购物信息及“商品清单”无误后，点击“去支付”，依据页面的提示，选择您熟悉的支付方式，并完成支付。</p>
                        </li>
                        <li>
                            <h3>6. 签收须知</h3>
                            <p>为保障大家的切身利益，我们在此提醒您，收到商品时需要注意以下各项：</p>
                            <ul class="content-list">
                                <li>
                                    <p>1．下单时，请务必留下本人能够签收的地址与联系电话；</p>
                                </li>
                                <li>
                                    <p>2．收到商品时请当场验货，检查外包装是否完好，商品种类数量是否与订单明细相符，不支持签收前拆产品包装验货；</p>
                                </li>
                                <li>
                                    <p>3．在本人不能亲自签收的情况下，请委托他人签收并严格按照第2项内容操作；</p>
                                </li>
                                <li>
                                    <p>4．如签收后商品出现质量问题，如功能性故障，请您及时联系智护伞客服中心4008-345-866 或者 0755-3290 3188。</p>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page11">支付方式</h3>
                    <p class="content-hui">智护伞官网支持“微信支付”和“支付宝”两种第三方平台支付。暂时不支持货到付款。请智粉们购买时留意，避免影响您的正常收货。</p>
                    <h3 class="content-title" id="page12">配送方式</h3>
                    <p class="content-hui">智护伞官网购物采用第三方快递配送，为提高智粉们的收货体验，我们选择了<a href="javascript:;" style="color:red;">德邦快递</a>的服务支持。</p>
                    <h3 class="content-title" id="page13">订单查询</h3>
                    <p class="content-hui">智粉可以在"我的订单"里查询到订单的物流信息及配送状态。</p>
                    <h3 class="content-title" id="page14">365天无忧服务</h3>
                    <p>智护伞向您承诺：</p>
                    <ul class="content-list">
                        <li>
                            <p>智护伞提供全国统一服务热线4008-345-866，用户的一切服务需求、投诉建议都将得到快速解答。</p>
                        </li>
                        <li>
                            <p>智护伞提供在线客服，及时为用户提供专业的技术咨询和服务咨询。（论坛在线服务为“智护伞论坛区版块”，微博在线服务为新浪微博号“@智护伞）。</p>
                        </li>
                        <li>
                            <p>智护伞在全国拥有近100家的授权服务中心，能够为用户提供一站式无忧安装服务。</p>
                        </li>
                        <li>
                            <p>智护伞采用系统化管理后台，让用户的数据信息得到专业档案管理。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page15">7天无理由退货</h3>
                    <p>· 自您收到商品之日起7日内可享受无理由退货。</p>
                    <p>· 您可拨打电话客服4008-345-866与客服人员申诉服务，智护伞授权服务中心的工作人员会跟您联系处理。</p>
                    <p>· 消费者的商品价款自收到退回商品之日起7个工作日内返还至订单对应支付帐户。</p>
                    <p class="content-hui">详细条款：</p>
                    <ul class="content-list">
                        <li>
                            <p>7天无理由退货仅对智护伞认证网站销售的商品有效。</p>
                        </li>
                        <li>
                            <p>7天无理由退货所产生的服务费人民币15元（包括快递费和人工费）及包装费5元（包括纸盒包装）由用户自行承担，或用户自行退回到“智护伞货品部”（需经智护伞工作人员确认自选快递或自行退回到仓库时的产品与货品部发货时外观、性能保持一致，检验合格后才予以退货），用户在购买智护伞产品时已经支付的快递费不予以退还。</p>
                        </li>
                        <li>
                            <p>用户7天无理由退货不包含以下行为：发票遗失、人为损坏、保修与防伪标签损毁、外观破损、零配件缺失、包装箱（纸箱）破损或缺失等影响二次销售的情况。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page16">30天只换不修</h3>
                    <p>· 自您收到商品之日起30日内发生非人为损坏功能性故障，可自行选择换货或者修理。</p>
                    <p>· 如换货，您可拨打电话客服4008-345-866或0755-3290-3188与客服人员联系，智护伞授权服务中心的工作人员会跟您联系处理。</p>
                    <p class="content-hui">详细条款：</p>
                    <ul class="content-list">
                        <li>
                            <p>30天只换不修仅对智护伞网站销售的商品有效。</p>
                        </li>
                        <li>
                            <p>用户30天只换不修不包含以下行为：三包凭证及发票遗失、人为损坏、保修与防伪标签损毁等情况。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page17">保修细则</h3>
                    <ul class="content-list">
                        <li>
                            <p>1. 智护伞核心部件质保1年，以先达到的时间期限为准（核心部件包括智护伞的防盗硬件、喇叭器、遥控器），其它智护伞零部件质保应按照《智护伞三包标准》来实施。</p>
                        </li>
                        <li>
                            <p>2. 保修期限内，由智护伞的授权服务中心提供免费维修及置换服务。超过“三包”服务期限和范围内的维修，根据各地市场行情及维修价格，由智护伞授权服务中心提供有偿服务。</p>
                        </li>
                        <li>
                            <p>3. 用户购买的产品因产品质量问题无法使用的，由智护伞授权服务中心提供免费维修服务。</p>
                        </li>
                        <li>
                            <p>4. 售出产品保修服务期限自用户签署的送货签收单当日开始计算。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page18">智护伞零部件三包标准</h3>
                    <table style="width:600px;border:1px solid #999999" class="service-center-table">
                        <tr>
                            <th colspan="4">智护伞零部件三包标准</th>
                        </tr>
                        <tr>
                            <td>项目</td>
                            <td>零部件所属种类</td>
                            <td>质保说明</td>
                            <td>保质期限</td>
                        </tr>
                        <tr>
                            <td>智护伞体件</td>
                            <td>D6终端</td>
                            <td>自然损坏，非人为现象</td>
                            <td>12个月</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>遥控器</td>
                            <td>自然损坏，非人为现象</td>
                            <td>12个月</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>喇叭</td>
                            <td>自然损坏，非人为现象</td>
                            <td>12个月</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>其它（连接线）</td>
                            <td>易损坏</td>
                            <td>不在保修范围之内</td>
                        </tr>
                    </table>
                    <h3 class="content-title" id="page19">保修免责范围</h3>
                    <p>售出产品发生以下情况的，不属于保修服务范围，需用户付费进行维修及相关服务：</p>
                    <ul class="content-list">
                        <li>
                            <p>1. 以《智护伞零部件三包标准》为基准，超过规定服务期限和范围的。</p>
                        </li>
                        <li>
                            <p>2. 用户及用户未按智护伞产品使用说明书的规定正确使用、安装、app操作及调整而造成的产品故障或相关损坏的。</p>
                        </li>
                        <li>
                            <p>3. 售出产品因雨水、冰雪浸泡、烟熏、药品、化学用品腐蚀等造成的损坏或自然损耗不属于保修范围。以及售出产品遭遇不可抗力影响的（包括但不限于地震、台风、火灾、水灾、社会事件、群体事件、暴力犯罪等）造成的故障或损坏的。</p>
                        </li>
                        <li>
                            <p>4. 用户未在智护伞授权服务中心进行购买安装，自行改装、分解、维修以及破坏产品整体及零部件正常使用状态的。</p>
                        </li>
                        <li>
                            <p>5. 用户使用非原厂配件造成的智护伞零部件损坏或擅自改动电路、线路配置的。</p>
                        </li>
                        <li>
                            <p>6. 用户在行驶过程中撞车、摔车、超载、超速等人为因素而造成的产品故障或损坏的。</p>
                        </li>
                        <li>
                            <p>7. 无有效三包凭证、售后服务卡或购买产品发票、凭证或卡上编号与产品不符的。</p>
                        </li>
                        <li>
                            <p>8. 用户擅自涂改、变更智护伞产品及零部件的三包服务日期的。</p>
                        </li>
                        <li>
                            <p>9. 非产品本身质量问题，如用户购买产品后对于颜色、形状、外观等不满意的。</p>
                        </li>
                        <li>
                            <p>10. 整身产品及主要零部件保修与防伪标签损毁的。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page20">保修零部件指导价</h3>
                    <p>根据原材料采购价及人工成本的变动，研冠科技及智护伞有权对该指导价进行修改和调整</p>
                 <%--   <h3 class="content-title" id="page21">智护伞使用攻略</h3>
                    <ul class="content-list">
                        <li>拆盒视频</li>
                        <li>签收注意事项</li>
                        <li>智护伞产品安装教程</li>
                        <li>智护伞APP使用手册</li>
                    </ul>--%>
                </div>
            </div>
        </div>
    </div>
    <!-- footer-->
    <%@include file="include/footer.jsp"%>
</div>
<script>
    window.onscroll = function(){
        var t = document.documentElement.scrollTop || document.body.scrollTop;
        var top_div = $("div.content-left");
        if( t >= 200) {
            top_div.css({top:20});
        } else {
            top_div.css({top:'auto'});
        }
    }
/*    $("h3.menu-title").click(function(){
        $("ul.menu").hide();
        $(this).next("ul.menu").show();
    });*/
    $("h3.menu-title").click(function(){
        $(this).next("ul.menu").toggle(100,'linear');
    })
    $("h3.menu-title:gt(0)").click();
</script>
</body>
</html>
