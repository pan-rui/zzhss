<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="../include/require.jsp"%>--%>
<html>
<head>
  <title>APP使用</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <%@include file="../include/top.jsp"%>
    <!-- showImg-->
    <div class="bg-hui padding-bottom50">
        <div class="wrapper clearfix">
            <div class="content-left">
                <h3 class="menu-title"><span>APP使用</span></h3>
                <ul class="menu">
                    <li class="menu-focus">
                        <a href="${baseUrl}/app/">APP下载</a>
                    </li>
                    <li>
                        <a href="#page2">注册</a>
                    </li>
                    <li>
                        <a href="#page3">添加设备</a>
                    </li>
                    <li>
                        <a href="#page4">手机控车</a>
                    </li>
                    <li>
                        <a href="#page5">位置查询</a>
                    </li>
                    <li>
                        <a href="#page6">快速设置</a>
                    </li>
<%--                    <li>
                        <a href="#page7">更多</a>
                    </li>--%>
                </ul>
                <div class="video-block"><a href="javascript:;" id="video" video="${appVideo}"><img src="<c:url value="/images/videoIcon.png"/>" alt="">APP使用视频</a></div>
            </div>
            <div class="content-right">
                <div class="content app-use">
                    <h3 id="page1" class="content-title">下载安装设备客户端软件</h3>
                    <p>请扫描以下二维码快速下载</p>
                    <%--<p>或访问<a href="www.zhihusan.com" style="color:#555;">www.zhihusan.com</a>下载</p>--%>
                    <p>或扫描包装盒上的二维码下载</p>
                    <ul class="clearfix app-use-img" style="text-align:center;">
                        <li>
                            <img src="<c:url value="${client eq 'ios'?'/images/appUseImg_03.jpg':'/images/appUseImg_06.jpg'}"/>" alt="${client eq 'ios'?'苹果':'安卓'}客户端下载图片">
                            <p>${client eq 'ios'?'苹果':'安卓'}客户端下载</p>
                        </li>
<%--                        <li>
                            <img src="<c:url value="/images/appUseImg_06.jpg"/>" alt="安卓客户端下载图片">
                            <p>安卓客户端下载</p>
                        </li>--%>
                    </ul>
                    <h3 class="content-title" id="page2">注册</h3>
                    <p>请用您的手机号码注册成为智护伞用户。</p>
                    <p><img src="<c:url value="/images/useAppNew2_03.jpg"/>" alt=""></p>
                    <h3 class="content-title" id="page3">添加设备</h3>
                    <ul class="content-list content-list1">
                        <li>
                            <p>请确保设备正常开机，通讯搜星正常，正确安装到车辆中，方可进行添加绑定设备。</p>
                            <p>请扫描彩盒上的条形码，进行添加，如无法扫描，请手动输入条形码下的15位数IMEI号进行添加完成信息确认。</p>
                            <p>
                                <img src="<c:url value="/images/useAppNew2_06.jpg"/>" alt="">
                                <img src="<c:url value="/images/useAppNew2_08.jpg"/>" alt="">
                            </p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page4">手机控车</h3>
                    <ul class="content-list content-list1">
                        <li>
                            <p>操作控车栏按钮（见图示），实现对车辆远程设防/解防，电源开启关闭，远程刹车开启关闭，寻车导航,同时状态栏会实时显示车辆状态。</p>
                            <p>
                                <img src="<c:url value="/images/useAppNew2_12.jpg"/>" alt="">
                            </p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page5">位置查询</h3>
                    <ul class="content-list content-list1">
                        <li>
                            <p>操作位置栏按钮，实现对车辆位置实时跟踪，轨迹回放，以及电子围栏的设置。</p>
                            <p>
                                <img src="<c:url value="/images/useAppNew2_16.jpg"/>" alt="">
                                <img src="<c:url value="/images/useAppNew2_19.jpg"/>" alt="">
                            </p>
                            <p>
                                <img src="<c:url value="/images/useAppNew2_21.jpg"/>" alt="">
                                <img src="<c:url value="/images/useAppNew2_23.jpg"/>" alt="">
                            </p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page6">快速设置</h3>
                    <ul class="content-list content-list1">
                        <li>
                            <p>点击图示按钮，可根据车辆所处环境和车主自身喜好选择对应的模式。</p>
                            <p>
                                <img src="<c:url value="/images/useAppNew2_30.jpg"/>" alt="">
                                <img src="<c:url value="/images/useAppNew2_32.jpg"/>" alt="">
                            </p>
                        </li>
                    </ul>
                    <h3 class="content-title" id="page7">更多</h3>
                    <ul class="content-list content-list1">
                        <li>
                            <p>消息栏中，我们详细知道报警信息，及时进行警情处理。</p>
                            <p>服务栏中，围绕电动车后服务市场，方便快捷的找到充电，维修，救援等服务网店</p>
                            <p>我的栏中，用户可以进行对设备管理，重置密码，意见反馈，操作指南。</p>
                            <p>
                                <img src="<c:url value="/images/useAppNew2_36.jpg"/>" alt="">
                                <img src="<c:url value="/images/useAppNew2_37.jpg"/>" alt="">
                            </p>
                            <p>
                                <img src="<c:url value="/images/useAppNew2_39.jpg"/>" alt="">
                            </p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp"%>
<%--<div class="zhezh" style="position: fixed;width:100%;left:0;top:0;height:100%;background:rgba(243,243,243,1);z-index:2;display: none"></div>--%>
<div style="position:fixed;width: 1024px;height: auto;;display:none;z-index: 99;text-align:center;vertical-align:middle;padding:80px 0px 0px 143px;" id="vDiv">
    <img src="<c:url value="/images/close.jpg"/>" alt="关闭" style="position: relative;top: -580px;z-index: 100;"/>
</div>
</div>
<script>
    playVideo();
    $(function(){
        if(window.innerHeight) $('#vDiv img').css('left','525px')
        else $('#vDiv img').css('left','600px')
    })
</script>
</body>
</html>
