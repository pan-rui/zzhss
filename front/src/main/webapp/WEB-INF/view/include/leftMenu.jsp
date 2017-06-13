<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<ul class="menu">
    <li class="menu-focus">
        <a href="${baseUrl}/product?id=${product.id}">产品概述</a>
    </li>
    <c:if test="${product.state eq '0'}">
        <li>
            <a href="<c:url value="/product/install?id=${product.id}"/>">产品安装</a>
        </li>
        <li>
            <a href="<c:url value="/app/use?pName=${product.name}"/> ">APP使用</a>
        </li>
    </c:if>
    <li>
        <a href="<c:url value="/product/spec?id=${product.id}"/>">规格参数</a>
    </li>
    <c:if test="${not empty y:toMap(product.install).v_use}">
        <li>
            <a href="javascript:;" id="video" video="${y:toMap(product.install).v_use}">使用视频</a>
        </li>
    </c:if>
</ul>
<script>
    $(function () {
        playVideo();
    })
</script>