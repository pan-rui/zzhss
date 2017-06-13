<%--
  Created by IntelliJ IDEA.
  User: wangwei
  Date: 2016/1/11
  Time: 19:05
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="../include/require.jsp"%>
<html>
<head>
    <meta name="keywords" content="" />
    <title>寻车</title>
    <link href="<c:url value="/map/map.css"/> " rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=419b656fd194f05fceefd0871e060d8a"></script>
    <script type="text/javascript" src="<c:url value="/map/baidumap.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/map/trackhistory.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/My97DatePicker/WdatePicker.js"/>"></script>
</head>
<body>
<div id="Wrap">
  <%@include file="../include/top.jsp"%>
<%--<div id="result" style="width:15%;height:100%;float: left">
    <div class="btn_main1" style="text-align: left;padding: 10px;">
        <p><input type="button" id="trackOn" value="开启跟踪" onclick="bclear();" class="button"/>
        </p>
        <input type="button" id="trackOff" value="停止跟踪" onclick="bclear();" class="button"/>
    </div>
    <div style="background-color: red;width: 100%;height: 2px;"></div>
    <div style=" text-align: left;padding: 10px;">
        <p><input type="text" id="_begintime" class="time_box1" placeholder="开始时间" onclick="WdatePicker({el:'_begintime',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
        </p>
        <p><input type="text" id="_endtime" class="time_box1"  placeholder="结束时间" onclick="WdatePicker({el:'_endtime',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
        </p>
        <p><input type="button" id="play" value="轨迹回放" onclick="bclear();" class="button"/>
        </p>
        <input type="button" id="btnstop" value="暂停" class="button" onclick="stop();" />
    </div>
</div>--%>

<div id="map_canvas" style="width:800px;height:500px;float: left">
</div>
    </div>
<div id="set_time">
    <div style=" text-align: center">
        <input type="text" id="_begintime" class="time_box1" placeholder="开始时间" onclick="WdatePicker({el:'_begintime',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
        <input type="text" id="_endtime" class="time_box1"  placeholder="结束时间" onclick="WdatePicker({el:'_endtime',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
        <input type="button" id="play" value="轨迹回放" onclick="bclear();findhistory();" class="button"/>
        <input type="button" id="btnstop" value="暂停" class="button" onclick="stop();" />
    </div>
</div>
    <div id="loading">
        <img src="<c:url value="/images/loading.gif"/>" />正在查询,请稍等...
    </div>
<script>
    $(function(){
        $("#map_canvas").css({width:window.innerWidth?window.innerWidth:document.documentElement.clientWidth,height:window.innerHeight?window.innerHeight-$("header.header").outerHeight(true):document.documentElement.clientHeight-$("header.header").outerHeight(true)});
        bInitialize()
        bclear();
        track(${device.Device_ID},${device.Device_Version},${device.Device_Imei})
    })
</script>
</body>
</html>
