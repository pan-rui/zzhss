<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@include file="/koudai/include/require.jsp" %>
<!DOCTYPE html>
<head>
    <meta charset=utf-8/>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport"/>
    <title>我要投资</title>


</head>
<body style="min-width: 1260px;">
<!--顶部topbar通道栏-->
<%@include file="/koudai/include/top.jsp" %>
<!--头部导航栏-->
</div>
<!--内容区-->
<div class="invest">
    <div class="invest-wrap">
        <div class="invest-top">
            <dl>
                <dt class="pro-type">产品类型：</dt>
                <dd class="pro-line">
                    <a class="active" href="javascript:;" val="">全部</a>
                    <a href="javascript:;" val="1">新手专区</a>
                    <a href="javascript:;" val="2">银票专区</a>
                    <a href="javascript:;" val="3">保理专区</a>
                </dd>
            </dl>
            <dl>
                <dt class="invest-time">投资期限：</dt>
                <dd class="invest-time-list">
                    <a class="active" href="javascript:;" val="">全部</a>
                    <a href="javascript:;" val="0">1个月内</a>
                    <a href="javascript:;" val="1">1-3个月</a>
                    <a href="javascript:;" val="2">3-6个月</a>
                    <a href="javascript:;" val="3">6个月以上</a>
                </dd>
            </dl>
        </div>
        <form>
            <input type="hidden" id="typeId" name="typeId" value=""/>
            <input type="hidden" id="deadline" name="deadline" value=""/>
            <input type="hidden" id="currentPage" name="pageBean.pageNum" value=""/>
        </form>
        <div class="invest-navlist">
            <p><span>产品系列</span>>></p>
        </div>
        <div class="invest-contain"></div>
        <!--分页标签-->

    </div>
</div>
<script type="text/javascript">
    function fillData(){
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
    };
    fillData();
</script>
<!--底部footer-->
<%@include file="/koudai/include/footer.jsp" %>
<!--侧边栏-->
<script type="text/javascript" src="/koudai/js/invest.js"></script>
</body>
</html>