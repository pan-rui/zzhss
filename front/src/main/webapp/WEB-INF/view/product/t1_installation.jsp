<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="../include/require.jsp"%>--%>
<!DOCTYPE html>
<html>
<head>
    <title>产品安装</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <%@include file="../include/top.jsp" %>
    <!-- showImg-->
    <div class="bg-hui padding-bottom50">
        <div class="wrapper clearfix">
            <div class="content-left">
                <h3 class="menu-title"><span>产品安装</span></h3>
                <ul class="menu">
                    <li class="menu-focus">
                        <a href="#page1">安装前准备</a>
                    </li>
                    <li>
                        <a href="#page2">测试设备</a>
                    </li>
                    <li>
                        <a href="#page3">设备安装</a>
                    </li>
                    <li>
                        <a href="#page4">位置选择</a>
                    </li>
                    <li>
                        <a href="#page5">注意事项</a>
                    </li>
                </ul>
                <c:if test="${not empty y:toMap(product.install).v_install}">
                    <div class="video-block"><a href="javascript:;" id="video"
                                                video="${y:toMap(product.install).v_install}"><img
                            src="<c:url value="/images/videoIcon.png"/>" alt="">产品视频安装</a></div>
                </c:if>
            </div>
            <div class="content-right">
                <div class="content">
                    <h3 id="page1" class="content-title">安装前准备</h3>
                    <ul class="content-list">
                        <li>安装前准备好安装工具，剪钳/螺丝刀/万能表/电工胶布等.</li>
                        <li>打开包装盒，检查配件是否齐全，核对终端与彩盒序号是否一致.</li>
                    </ul>
                    <p style="padding-left:16px;">特别注意：本终端需移动联通GPRS流量卡一张。如有问题请联系当地经销商处理。</p>
                    <h3 class="content-title" style="font-size:16px;padding-left:16px;">包装清单</h3>
                    <table class="anzhuang-table">
                        <tbody>
                        <tr>
                            <th style="width:138px;">名称</th>
                            <th style="width:226px;">数量</th>
                        </tr>
                        <tr>
                            <td>定位防盗主机</td>
                            <td>1台</td>
                        </tr>
                        <tr>
                            <td>背贴</td>
                            <td>1个</td>
                        </tr>
                        <tr>
                            <td>说明书</td>
                            <td>1册</td>
                        </tr>
                        <tr>
                            <td>合格证书</td>
                            <td>1张</td>
                        </tr>
                        </tbody>
                    </table>
                    <h3 class="content-title" id="page2">测试设备</h3>
                    <ul class="content-list">
                        <li>
                            <h3>安装SIM卡</h3>
                            <p>打开设备上盖，掀开SIM卡槽上盖，将SIM卡金属面朝下，缺角对应放入卡槽中，盖上卡座上盖。</p>
                        </li>
                        <li>
                            <h3>功能检查</h3>
                            <p>
                                按压终端开关键3S左右，绿色指示灯长亮，开机正常，闪烁代表GSM信号正常，然后需在室外空旷处LOGO面朝上搜星，蓝色GPS指示灯闪烁。代表搜星成功,调试成功后，装上上盖（有logo面），锁好螺丝。</p>
                            <p>如需关机，常按开机键，待指示灯全灭，表示关机成功。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page3">设备安装</h3>
                    <ul class="content-list">
                        <li>
                            <h3>产品接线</h3>
                            <p>找到控制器电源正负极插头与终端红黑正负极端子头对插，注意红黑线序。</p>
                        </li>
                        <li>
                            <h3>控制器常电电源查找方法：</h3>
                            <p>电动车钥匙开/关两种状态，电压显示接近电瓶电压。判断为常电电源线。</p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page4">位置选择</h3>
                    <p><img src="<c:url value="/images/anzImg_14.jpg"/>" alt=""></p>
                    <h3 class="content-title" id="page5">注意事项</h3>
                    <ul class="content-list">
                        <li>
                            产品安装需要防止水淋泥溅,以及位置尽量隐蔽，以免盗窃破坏。
                        </li>
                        <li>避免与发射源放在一起，如自带防盗器以及其它车载通讯终端。</li>
                        <li>安装时确保设备LOGO面正面朝天空，且上方无金属物遮挡。</li>
                        <li>请用专用背胶或扎带固定。</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp" %>
    <%--<div class="zhezh" style="position: fixed;width:100%;left:0;top:0;height:100%;background:rgba(243,243,243,1);z-index:2;display: none"></div>--%>
    <div style="position:absolute;width: 1024px;height:auto;display:none;z-index: 99;text-align:center;vertical-align:middle;padding:80px 0px 0px 143px;"
         id="vDiv">
        <img src="<c:url value="/images/close.jpg"/>" alt="关闭"
             style="position: relative;top: -580px;left:525px;z-index: 100;"/>
    </div>
</div>
<script>
    playVideo();
</script>
</body>
</html>
