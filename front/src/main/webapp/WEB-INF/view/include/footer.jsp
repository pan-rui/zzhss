<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<footer class="footer">
    <div class="wrapper clearfix">
        <div class="weixin-icon">
            <h3>4008-345-866</h3>
            <div class="border-left">
                <p>周一至周五 9:00-18:30</p>
                <p><img src="<c:url value="/images/footerErweima_03.jpg"/>" alt="微信二维码"/></p>
                <p>智护伞微信公众号</p>
            </div>
        </div>
        <dl>
            <dt>
                <a href="javascript:;">关于我们</a>
            </dt>
            <dd>
                <a href="javascript:;" link="Company_Js">公司介绍</a>
            </dd>
            <dd>
                <a href="javascript:;" link="Call_YanGuan">联系我们</a>
            </dd>
            <dd>
                <a href="javascript:;" link="Add_YanGuan">加入我们</a>
            </dd>
        </dl>
        <dl>
            <dt>
                <a href="javascript:;">帮助中心</a>
            </dt>
            <dd>
                <a href="javascript:;" link="Buy_Guide">购买指南</a>
            </dd>
            <dd>
                <a href="javascript:;" link="Pay_Type">支付方式</a>
            </dd>
        </dl>
        <dl>
            <dt>
                <a href="javascript:;" link="After_Service">服务与支持</a>
            </dt>
            <dd>
                <a href="javascript:;" link="After_Service">售后政策</a>
            </dd>
        </dl>
        <dl>
            <dt>
                <a href="javascript:;">关注我们</a>
            </dt>
            <%--      <dd>
                    <a href="javascript:;" id="wxgzh">微信公共号</a>
                  </dd>--%>
            <dd>
                <a href="http://weibo.com/ygkjgps" target="_blank">新浪微博</a>
            </dd>
        </dl>
        <div class="f_link">
            <ul class="footer_nav">
                <c:forEach var="links" items="${linkss}" varStatus="s">
                    <li><a href="${links.linkUrl}" target="_blank"><img src="${links.imagePath}" alt="${links.linkName}"/></a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div id="seo" style="display: none">
        keywords:
        <a href="<c:url value="/static/sitemap.html"/>" title="GPS防盗器" target="_blank"><strong>GPS防盗器</strong></a>
        <a href="<c:url value="/static/sitemap.xml"/>" title="GPS防盗器" target="_blank"><strong>GPS防盗器</strong></a>
        <a href="<c:url value="/static/sitemap.html"/>" title="摩托车防盗器" target="_blank"><strong>摩托车防盗器</strong></a>
        <a href="<c:url value="/static/sitemap.html"/>" title="摩托车防盗器" target="_blank"><strong>摩托车防盗器</strong></a>
        <a href="<c:url value="/static/sitemap.html"/>" title="电动车租赁" target="_blank"><strong>电动车租赁</strong></a>
        <a href="<c:url value="/static/sitemap.html"/>" title="电动车租赁" target="_blank"><strong>电动车租赁</strong></a>
    </div>
    <p class="copyright">Copyright@2014-2016 深圳市研冠科技有限公司 <a href="http://www.miibeian.gov.cn/" target="_blank"
                                                            style="color:#666;">粤ICP备13050338号</a>
        <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
        document.write(unescape("%3Cspan id='cnzz_stat_icon_1254041069'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s11.cnzz.com/stat.php%3Fid%3D1254041069%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));</script>
    </p>
    <%--  <div id="wxDisplay" style="position: fixed;width:auto;display: none;height: auto;background:rgba(0,0,0,.8);">
        <img src="<c:url value="/images/qrcode.jpg"/>" alt="微信号" />
      </div>--%>
</footer>
<script>
    $(function () {
        $("dl a[link],#sale").on("click", function () {
            $.get(baseUrl + "/link", {content: $(this).attr("link")}, function (data) {
                if (data.code == 0) {
                    if ($("#Wrap > div").is('div.banner')) {
                        $('div.banner').children(':not(footer)').remove();
                        $('#Wrap > div').not('.main,.zhezhao,.device,.banner').remove();
                    } else
                        $("#Wrap > div").not(".header,.footer,.main").remove();
                    $(".header").after(data.msg);
                } else alert(data.msg);
            }, 'json');
        });
        /*  $("#wxgzh").hover(function(event){
         var $wx = $("#wxDisplay"), x = $wx.css('width'), y = $wx.css('height');
         $wx.css({left:event.screenX-x.substring(0,x.length-2)/2,top:event.screenY- y.substring(0,y.length-2)-80});
         $wx.fadeIn();
         },function(){
         $("#wxDisplay").fadeOut();
         })*/
    })
</script>
<!--侧边栏-->