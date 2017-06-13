$(function(){
	//设置导航
	var $nav=$(".nav");
	$nav.find('li').each(function(index){
		$(this).hover(function(event){
			$(this).addClass('nav-hover').siblings().removeClass('nav-hover');
		},function(){
			$nav.find('li').removeClass('nav-hover');
		})
	})
	//设置banner
	$('.slider1').Slider({
		$elem: $('.slider1'),
		speed: 3000
	});
	$("ul.play li").click(function () {
		window.location.href = $(this).attr('ref');
	})
	//设置论坛鼠标hover效果
	$(".bbs-list").find('li').hover(function(event){
		$(this).addClass('bbs-list-hover').siblings().removeClass('bbs-list-hover');
	},function(){
		$(".bbs-list").find('li').removeClass('bbs-list-hover');
	})

	//设置配送时间
	$(".delivery-time").find('a').each(function(index){
		$(this).on('click',function(){
			$(this).addClass('delivery-time-focus').siblings().removeClass('delivery-time-focus');
		})
	})
	//设置发票title
	$(".invoice-title").find('a').each(function(index){
		$(this).on('click',function(){
			$(this).addClass('invoice-title-focus').siblings().removeClass('invoice-title-focus');
		})
	})
	//设置什么事发票拍的提示显示
	var $invoice_layer=$(".invoice-layer");
	$(".know-invoice").hover(function(){
		$invoice_layer.addClass("invoice-layer-focus");
		$(".jiaoImg").css("display","block");
	},function(){
		$invoice_layer.removeClass("invoice-layer-focus");
		$(".jiaoImg").css("display","none");
	})
	//设置添加收货地址
	var $zhezhao=$(".zhezhao"),
		$shipping_address=$(".shipping-address");
	$(".address-add").on('click',function(){
		$zhezhao.fadeIn()
		$shipping_address.fadeIn();
	})
	$(".address-reset").on("click",function(){
		$zhezhao.fadeOut()
		$shipping_address.fadeOut();
	})
	!function nav(){
		var matchs=/^http:\/\/[\w:.]+\/([\w.]+)(\/[\w?.=]+)*/g.exec(location.href);
		var lis=$("ul.nav>li");
		if(matchs&&matchs.length>1){
			lis.removeClass('nav-focus');
			switch (matchs[1]){
				case 'product':lis.eq(1).addClass('nav-focus'); break;
				case 'app':lis.eq(2).addClass('nav-focus');break;
				case 'find':lis.eq(3).addClass('nav-focus');break;
				case 'service':lis.eq(4).addClass('nav-focus');break;
				default:lis.eq(0).addClass('nav-focus');break;
			}
		}
		/*		else{
		 lis.eq(0).addClass('nav-focus');
		 }*/
	}();
	//设置登录后的下拉
	$(".order-hover").hover(function(){
		$(".user-xiala").addClass("user-xiala-show");
		$(this).addClass("icon-xiala-focus");
	},function(){
		$(".user-xiala").removeClass("user-xiala-show");
		$(".order-hover").removeClass("icon-xiala-focus");
	})
//设置用户中心的优惠券
$(".coupons-xiala").hover(function(){
	$(this).addClass("coupons-xiala-hover");
},function(){
	$(".coupons-xiala").removeClass("coupons-xiala-hover");
})
})
	function verifyCode() {
		var src = $(this).attr('src');
		$(this).attr('src', src.substring(0, src.indexOf('?') + 1) + Math.random());
	};

function playVideo(){
	$("#video").click(function(){
//            var videoEl = $('<video autoplay="autoplay" controls="controls" height="600px"></video>'), ind = parseInt($("div.btn>span.cur").html()),$win=$("#vDiv");
//            var vSrc = 'http://yuntv.letv.com/bcloud.swf?uu=ocbbmrqufu&vu=45929a51d1&auto_play=1&gpcflag=1';
		var videoEl = $('<embed src="" allowFullScreen="true" quality="high"  width="1024" height="576" align="middle" allowScriptAccess="always" flashvars="" type="application/x-shockwave-flash"></embed>');
		var $win=$("#vDiv"),vInfo = $(this).attr('video'),vInfos=vInfo==undefined||vInfo==''?[]:vInfo.split(' ');
		videoEl.attr('src', vInfos[0]);
		videoEl.attr('flashvars', vInfos[1]);
		$win.find('embed').remove();
		$win.prepend(videoEl);
		var heigth=$win.css('height'),width=$win.css('width');
		var y=((window.innerHeight?window.innerHeight:document.documentElement.clientHeight)-parseFloat(heigth.substring(0,heigth.length-2)))/2+'px' ,x=((window.innerWidth?window.innerWidth:document.documentElement.clientWidth)-parseFloat(width.substring(0,width.length-2)))/2+'px';
		$win.css({left: 0, top: 0,opcity:0.3,padding:y+' 0px 0px '+x});
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
}
