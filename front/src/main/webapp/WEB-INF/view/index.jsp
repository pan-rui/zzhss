<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="include/require.jsp"%>--%>
<html>
<head>
    <meta name="keywords" content="防盗器，GPS防盗器，电摩防盗器，电摩GPS防盗器，电动车防盗器，摩托车防盗器，智能GPS防盗器，电动车GPS防盗器，摩托车GPS防盗器，GPS防盗系统，GPS方案公司，GPS防盗器价格">
    <meta name="Description" content="智护伞防盗器官网提供最全的GPS防盗器价格，是技术领先的电动车GPS防盗器厂家，在摩托车防盗器的基础上开发云GPS防盗系统，专业的电摩GPS防盗器GPS方案公司">
    <title>防盗器|GPS防盗器|电动车防盗器|智能GPS防盗器|GPS方案公司|智护伞【官网】</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
<%@include file="include/top.jsp"%>
    <!-- banner-->
    <div class="banner">
        <div class="slider slider1">
            <ul class="play" style="width: 400%; left: -300%;">
                <c:forEach items="${productss}" var="product" varStatus="s">
                <li style="width: 25%; background: url(${product.img}) 50% 100% no-repeat rgb(202, 25, 71);"  video1="${y:toMap(product.install).v_install}" video2="${y:toMap(product.install).v_use}" ref="<c:url value="/product?id=${product.id}"/>">
                <%--<a href="<c:url value="/product?id=${product.id}"/>">--%>
                    <div class="wrapper">
                        <div class="bannerWenzi">
                            <h3><i>${product.name}</i></h3>
                            <p class="bannerWenziDetal"><y:toHtml text="${product.description}"></y:toHtml></p>
<%--                            <p class="bannerWenziPrice">￥${product.price}</p>
                            <a href="/user/cart/add?productId=${product.id}" class="">立即购买</a>--%>
                        </div>
                    </div>
                <%--</a>--%>
                </li>
                </c:forEach>
            </ul>
            <%--<div class="btn" style="margin-left: -28.5px;"><span class="cur">1</span><span class="">2</span><span class="">3</span></div></div>--%>
        <%--<div class="slider slider1">
            <ul class="play">
                <li style="background: #ca1947 url(<c:url value="/images/banner1.jpg"/>) no-repeat 50% 100%;"><a href="javascript:void(0);" class="link"></a></li>
                <li style="background: #7fbe52 url(<c:url value="/images/banner2.png"/>) no-repeat 50% 100%;"><a href="#" class="link"></a></li>
                &lt;%&ndash;<li style="background: #7fbe52 url(<c:url value="/images/banner1.jpg"/>) no-repeat 50% 100%;"><a href="#" class="link"></a></li>&ndash;%&gt;
            </ul>
        </div>--%>
    </div>
    <div class="bg-hui bg-hui-center">
        <div class="wrapper">
            <ul class="clearfix productInstallation">
                <li>
                    <a href="javascript:;"><i class="icon icon-anzhuang"></i></a>
                    <a href="javascript:;" id="video1" video="${publicVideo}">产品视频</a>
                </li>
                <li>
                    <a href="javascript:;"><i class="icon icon-anzhuang"></i></a>
                    <a href="javascript:;" id="video10" video="${businessVideo}">企业视频</a>
                </li>
                <li>
                    <a href="javascript:;"><i class="icon icon-anzhuang"></i></a>
                    <a href="javascript:;" id="video111" video="${installVideo}">安装视频</a>
                </li>
                <li>
                    <a href="javascript:;"><i class="icon icon-anzhuang"></i></a>
                    <a href="javascript:;" id="video11" video="${useVideo}">使用视频</a>
                    <%--<a href="<c:url value="/product/install"/>" id="video2" >使用视频</a>--%>
                </li>
            </ul>
        </div>
    </div>
    <div class="bg-hui margin-top8 bg-hui-center">
        <ul class="wrapper clearfix work-tenet">
            <li>
                <div class="work-tenet-bg">
                    <img src="<c:url value="/images/workTenetIcon_03.png"/>" alt="在线客服" height="66">
                </div>
                <h3>在线客服</h3>
                <p>周一至周五 9:00-18:30</p>
            </li>
            <li>
                <div class="work-tenet-bg">
                    <img src="<c:url value="/images/workTenetIcon_05.png"/>" alt="7天无理由退货" height="66">
                </div>
                <h3>7天无理由退货</h3>
                <p>7天无理由退货，请放心购买</p>
            </li>
            <li>
                <div class="work-tenet-bg">
                    <img src="<c:url value="/images/workTenetIcon_07.png"/>" alt="15天免费换货" height="66">
                </div>
                <h3>15天免费换货</h3>
                <p>15天内如遇质量问题 免费换货</p>
            </li>
            <li>
                <div class="work-tenet-bg">
                    <img src="<c:url value="/images/workTenetIcon_09.png"/>" alt="365天无忧保修" height="66">
                </div>
                <h3>365天无忧保修</h3>
                <p>365天内产品自身质量问题保修</p>
            </li>
        </ul>
    </div>
    <!-- footer-->
<%@include file="include/footer.jsp"%>
        <%--<div class="zhezh" style="position: fixed;width:100%;left:0;top:0;height:100%;background:rgba(243,243,243,1);z-index:2;display: none"></div>--%>
        <div style="position:fixed;width: auto;height:auto;display:none;z-index: 99;text-align:center;vertical-align:middle;padding-left: 143px;" id="vDiv">
            <img src="<c:url value="/images/close.jpg"/>" alt="关闭" style="position: relative;top: -280px;z-index: 100;"/>
<%--    <video controls="controls" height="600px">
        <source type="video/mp4" src="http://112.90.152.149/music.qqvideo.tc.qq.com/v0019aqm1qk.mp4?type=mp4&fmt=mp4&vkey=494DC29786E15CA541FC7B503EC8160865626C7682D6FC39161BA0783655BEB62838ED8520C58626E0BB6CE356BD1B9D73C33F596C011ABF6A5D809F2CB28E9912CE5344DB16ADE7A8E520D375ED7170F44EC691DD6F1452"/>
    </video>--%>
    <%--<video controls="controls" height="600px" autoplay src="http://112.90.152.149/music.qqvideo.tc.qq.com/v0019aqm1qk.mp4?type=mp4&amp;fmt=mp4&amp;vkey=494DC29786E15CA541FC7B503EC8160865626C7682D6FC39161BA0783655BEB62838ED8520C58626E0BB6CE356BD1B9D73C33F596C011ABF6A5D809F2CB28E9912CE5344DB16ADE7A8E520D375ED7170F44EC691DD6F1452"></video>--%>
    </div>
</div>
    </div>
    <script>
        $("ul.productInstallation a").click(function(){
//            var videoEl = $('<video autoplay="autoplay" controls="controls" height="600px"></video>'), ind = parseInt($("div.btn>span.cur").html()),$win=$("#vDiv");
//            var vSrc = 'http://yuntv.letv.com/bcloud.swf?uu=ocbbmrqufu&vu=45929a51d1&auto_play=1&gpcflag=1';
            var videoEl = $('<embed src="" allowFullScreen="true" quality="high"  width="1024" height="576" align="middle" allowScriptAccess="always" flashvars="" type="application/x-shockwave-flash"></embed>');
            var ind = parseInt($("div.btn>span.cur").html()),$win=$("#vDiv"),$a=$(this).closest('li').find("a[id^='video']");
            var vInfo = /video1/.test($a.attr('id'))?$a.attr('video'):$("div.slider>ul>a:eq(" + (ind - 1) + ") li:first").attr('video1'),vInfos=vInfo==undefined||vInfo==''?[]:vInfo.split(' ');
//            videoEl.attr('src', '');
            videoEl.attr('src', vInfos[0]);
            videoEl.attr('flashvars', vInfos[1]);
//            videoEl.attr('flashvars', 'uu=ocbbmrqufu&vu=45929a51d1&auto_play=1&gpcflag=1&width=1024&height=576');
            $win.find('embed').remove();
            $win.prepend(videoEl);
            var heigth=$win.css('height'),width=$win.css('width');
            var y=((window.innerHeight?window.innerHeight:document.documentElement.clientHeight)-parseFloat(heigth.substring(0,heigth.length-2)))/ 2+'px' ,x=((window.innerWidth?window.innerWidth:document.documentElement.clientWidth)-parseFloat(width.substring(0,width.length-2)))/2+'px';
            $win.css({left: 0, top: y,opcity:0.3,'padding-left':x});
            $("div.zhezh").fadeIn();
            $("#vDiv").fadeIn();
            return false;
        });
        $(document).on('click','body',function(event){
            var vDiv = $("#vDiv");
            if(vDiv.is(":visible")){
                if(vDiv.find(event.target).length<=0){
                    vDiv.fadeOut().find('embed').remove();
                    $("div.zhezh").fadeOut();
                }
            }
        })
        $("#vDiv img").click(function(){$('#vDiv').fadeOut().find('embed').remove();})
    </script>
<%--<object width=1300 height=613><param name="movie" value="http://share.vrs.sohu.com/2892451/v.swf&topBar=1&autoplay=false&plid=8997103&pub_catecode=0&from=page"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><param name="wmode" value="Transparent"></param><embed width=1300 height=613 wmode="Transparent" allowfullscreen="true" allowscriptaccess="always" quality="high" src="http://share.vrs.sohu.com/2892451/v.swf&topBar=1&autoplay=false&plid=8997103&pub_catecode=0&from=page" type="application/x-shockwave-flash"/></embed></object>--%>
<%--<embed src="http://player.youku.com/player.php/sid/XMTQ3MzAwMDM3Ng==/v.swf" allowFullScreen="true" quality="high" width="480" height="400" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>--%>
<%--<embed type="application/x-shockwave-flash" src="http://static.youku.com/v1.0.0535/v/swf/loader.swf" id="movie_player" name="movie_player" bgcolor="#FFFFFF" quality="high" allowfullscreen="true" wmode="Opaque" allowscriptaccess="always" allownetworking="internal" flashvars="isShowRelatedVideo=false&VideoIDS=XMTQ3MzAwMDM3Ng&embedid=AjM2ODI1MDA5NAJ2LnlvdWt1LmNvbQIvdl9zaG93L2lkX1hNVFEzTkRrME1USTBPQT09Lmh0bWw=&isAutoPlay=false&isDebug=false&UserID=&playMovie=true&MMControl=false&MMout=false" pluginspage="http://www.macromedia.com/go/getflashplayer"height="500" width="650"></embed>--%>

</body>
</html>
