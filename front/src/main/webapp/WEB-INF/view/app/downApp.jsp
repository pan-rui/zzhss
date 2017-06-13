<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="../include/require.jsp"%>--%>
<html>
<head>
  <title>APP下载</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <%@include file="../include/top.jsp"%>
    <!-- showImg-->
    <div class="bg-hui bg-hui-app">
        <div class="wrapper">
            <div class="down-content clearfix">
                <div class="down">
                    <h3>智护伞APP</h3>
                    <p>GPS云防盗开创者</p>
                    <p class="qr-code" style="font-size: 85%;"><img src="<c:url value="/images/footerErweima_03.jpg"/>" alt="">智护伞公众号</p>
                    <ul class="down-list">
                        <li class="down-list-Android">
                            <a href="<c:url value="/app/use?client=android"/>"><img src="<c:url value="/images/downIcon_03.png"/>" alt="">Android版下载</a>
                        </li>
                        <li class="down-list-ios">
                            <a href="<c:url value="/app/use?client=ios"/>"><img src="<c:url value="/images/downIcon_07.png"/>" alt="">App Store下载</a>
                        </li>
                    </ul>
                </div>
                <img src="<c:url value="/images/phone.png"/>" alt="手机">
            </div>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp"%>
</div>
</body>
</html>
