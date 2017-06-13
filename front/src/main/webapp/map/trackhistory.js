
        var timer1;
        var boo=true;
        function track(devId,version,imei) {
            $('#set_time').hide();
		window.clearTimeout(timer1);
		if(imei !== ""){
		$.ajax({
			type : "get", //提交方式
			url : baseUrl+"/find/"+devId+"/"+imei, //请求的服务器路径
			data : "version="+version, //向服务器发送的参数
			dataType : "json", //指定服务器返回的数据类型json
			success : function(msg) {
				if (msg) {
					if (msg.code==0) {
						var lnglats = msg.data;
                                                var ln = lnglats.gpsLng;
                                                var la = lnglats.gpsLat;
//                                                alert(la+"+++"+ln+"+++"+imei+"+++"+lnglats.gpsTime);
						if (la !== 0.008728984041221487 || ln !== 0.02200129584349762) {
							baiduLatLng(ln,la,imei,isNaN(lnglats.gpsTime)?lnglats.gpsTime:dateFormat(lnglats.gpsTime,'yyyy-MM-dd HH:mm:ss'),devId,version);
							if (boo) {
                                                            timer1 = window.setTimeout("track("+devId+","+version+","+imei+")", 9000);
							}
						}else {
							alert("设备位置信息解析失败！请重新定位");
						}
					} else {
						alert("设备近期没有上传位置信息！");
//                                                alert(msg.message);
					}
				} 
//                                else {
//					findbaidu();
//				}
			}
		});
		}
	}
        function trackImei(imei) {
		window.clearTimeout(timer1);
		$.ajax({
			type : "post", //提交方式
			url : "trackImei.do", //请求的服务器路径	
			data : "imei=" + imei, //向服务器发送的参数
			dataType : "json", //指定服务器返回的数据类型json
			success : function(msg) {
				if (msg) {
					if (msg.success) {
						track(msg.result.devId,msg.result.devVersion,msg.result.devImei);
					} else {
//						alert(msg.message);
                                                 alert("没有查询到设备！");
					}
				} 
			}
		});
	}
        var ls = 0;
        var num = 0;
        var t = true;
        var cs = [];
        var devId;
        var imei;
        var version;
        function openHistory(did,im,ver){
            devId = did;
            imei=im;
            version=ver;
            $('#set_time').show();
        }
        function findhistory() {
            boo=false;
//            $('#btnstop').attr('disabled', 'disabled');
            ls=0;
            if(ls>0){
                ls=0;
            }
            if(num>0){
                num=0;
            }
            if(cs.length>0){
                cs = [];
            }
		window.clearTimeout(timer1);
		$('#loading').show();
		var begintime = $("#_begintime").val();
		var endtime = $("#_endtime").val();
		var t1 = Date.parse(new Date(begintime.replace(/-/g, "/")));
		var t2 = Date.parse(new Date(endtime.replace(/-/g, "/")));
		if (imei != '') {
			if (t1 < t2) {
				var hours = Math.floor((t2 - t1) / (3600 * 1000));

				if (hours <= 48) {
					$.ajax({
						type : "post", //提交方式
						url : baseUrl+"/find/"+devId+"/"+imei, //请求的服务器路径
						data : "stTime=" + t1/1000 + "&endTime=" + t2/1000
								+ "&version="+version, //向服务器发送的参数
						dataType : "json", //指定服务器返回的数据类型json
						success : function(msg) {
							$('#loading').hide();
							if (msg.code==0) {
								cs = msg.data;
								num = cs.length;
//                                                                alert(cs[0].gpsTime);
								if (num > 0) {
                                                                    play();
								} else {
									alert("没有查询到轨迹信息！");
								}
							}else{
                                                            alert("没有查询到轨迹信息！");
//                                                                alert(msg.message);
                                                        }
							//if(t){
							//setInterval(play,1100 - (document.getElementById('speed').value - 50) * 20);
							//}
						},
						error : function() {
							$('#loading').hide();
//							alert("网络异常啦！");
						}
					});
				} else {
					$('#loading').hide();
					alert("可查询一天以内的轨迹，请重新输入时间！");
				}
			} else {
				$('#loading').hide();
				alert("开始时间必须小于结束时间！");
			}
		} else {
			alert("登录失效，请重新登录！");
		}

	}
        function play(){
//            $('#btnstop').attr('disabled', '');
            ls++;
            if(ls<=num){
                var i = ls-1;
                baddLatLngH(cs[i].gpsLng, cs[i].gpsLat, 0, cs[i].gpsTime);
                if (t) {
                        timer1 = window.setTimeout(play, 500);
                }
//            setInterval(play,1000);
            }else {
//                $('#btnstop').attr('disabled', 'disabled');
                baddalert();
//$('#loading').hide();
//    alert('轨迹播放完毕！');
            }
        }
        function findImei(){
            $('#set_time').hide();
            var imei = document.getElementById("track_imei").value;
            if(imei==""){
                alert("请输入IMEI号！");
                return ;
            }
            bclear();
            trackImei(imei);
        }
function GetQueryString(name){
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null)return  unescape(r[2]); return null;
}
		function stop() {
			if ($('#btnstop').val() == '暂停') {
				t = false;
				$('#btnstop').val('继续');
			} else {
				t = true;
				play();
				$('#btnstop').val('暂停');
			}
		}
		function dateFormat(date, format) {

			date = isNaN(date) ? new Date(date.replace('CST', '')) : new Date(date);

			var o = {
				'M+' : date.getMonth() + 1, //month
				'd+' : date.getDate(), //day
				'H+' : date.getHours(), //hour
				'm+' : date.getMinutes(), //minute
				's+' : date.getSeconds(), //second
				'q+' : Math.floor((date.getMonth() + 3) / 3), //quarter
				'S' : date.getMilliseconds() //millisecond
			};

			if (/(y+)/.test(format))
				format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));

			for (var k in o)
				if (new RegExp('(' + k + ')').test(format))
					format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length));

			return format;
		}