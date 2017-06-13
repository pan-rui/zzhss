<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 18:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<c:forEach items="${page.page}" var="bean" >
  <!--产品列表开始-->
  <div class="pro-line-list">
    <div class="pro-line-list-title">
      <h2>
        <c:choose>
        <c:when test="${bean.isNewTender eq 1}">新手专区</c:when>
        <c:when test="${bean.isNewTender eq 2}">银票专区</c:when>
        <c:when test="${bean.isNewTender eq 3}">保理专区</c:when>
      </c:choose>
      </h2><span>${bean.borrowTittle}</span>
    </div>
    <div class="invest-details">
      <div class="invest-details-one">
        <p>年化收益率:<span>${bean.rateOfYear}%</span></p>

        <p>投资期限：<span>${bean.borrowCycle}个月</span></p>
      </div>
      <div class="invest-details-two">
        <p>融资金额:¥${bean.borrowBalance}万元</p>

        <p>还款方式：${bean.repaymentMode}</p>
      </div>
      <div class="invest-details-there">
        <div class="progressbar">
        </div>
        <p>剩余可投金额：${bean.enableCastAmount}</p>
      </div>
      <div class="invest-details-four">
        <a href="javascript:alert(${bean.id});return false;">立即投资</a>
      </div>
    </div>
  </div>
</c:forEach>
  <!--产品列表结束-->
<div id="kkpager"></div>
<link rel="stylesheet" href="/koudai/css/kkpager_blue.css" />
<script type="text/javascript" src="/koudai/js/kkpager.min.js"></script>
<script type="text/javascript">
  kkpager.generPageHtml({
    pno : ${page.pageNum},
    //总页码
    total : ${page.totalPageNum},
    //总数据条数
    totalRecords : ${page.totalNum},
    mode : 'click',//默认值是link，可选link或者click
    click :function(n){
      this.selectPage(n);
      $("#currentPage").val(n)
      $.ajax({
        url:"/investPage.html",
        type:"GET",
        async:false,
        dataType:"html",
        data:fromData($("form:first")),
        success:function(data,textStatus) {
          $(".invest-contain").html(data);
        }
      })
      return false;
    }
  })
</script>