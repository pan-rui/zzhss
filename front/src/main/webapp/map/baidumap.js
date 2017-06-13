var bmap;
var binfoWindow;
var bgeocoder;
var bmarker;
var bmarkersArray = [];
var bpoly;
var bpath = [];
var langs = 0;
var index = 0;
var address;
var _isBMap_ = typeof BMap !== "undefined";

function bInitialize() {
    try {
        bgeocoder = new BMap.Geocoder();
//        var point = new BMap.Point(114.01, 22.55);
        var point = new BMap.Point(106.872884, 33.150084);
        bmap = new BMap.Map(document.getElementById('map_canvas'));
//        bmap = new BMap.Map(document.getElementById('map_canvas'),{mapType:BMAP_HYBRID_MAP});
        bmap.centerAndZoom(point, 5);

        bmap.enableScrollWheelZoom();
        bmap.addControl(new BMap.NavigationControl());
        bmap.addControl(new BMap.MapTypeControl());
        //bmap.addControl(new BMap.MapTypeControl({ mapTypes: [BMAP_NORMAL_MAP, BMAP_SATELLITE_MAP] }));
        bmap.addControl(new BMap.ScaleControl());
        bmap.addControl(new BMap.OverviewMapControl({ isOpen: false }));

        //bmap.addTileLayer(new BMap.PanoramaCoverageLayer());
        var stCtrl = new BMap.PanoramaControl(); //构造全景控件
        stCtrl.setOffset(new BMap.Size(20, 40));
        bmap.addControl(stCtrl);//添加全景控件

        bmap.setCurrentCity("深圳");
        var polyOptions = {
            strokeColor: 'red',
            strokeOpacity: 1,
            strokeWeight: 3
        };

        bpoly = new BMap.Polyline(bpath, polyOptions);
        bmap.addOverlay(bpoly);
    }
    catch (e) {
//        alert(e.name + ": " + e.message);
    }
}

function bclear() {
    try {
        if(timer1){
            window.clearTimeout(timer1);
        }
        if (langs > 0||index>0) {
            index = 0;
            langs = 0;
        }
        if (binfoWindow) {
//            bmarker.closeInfoWindow();
            bmap.closeInfoWindow();
        }

        if (bmarkersArray) {
            for (i in bmarkersArray) {
                bmap.removeOverlay(bmarkersArray[i]);
            }
            bmarkersArray.length = 0;
        }

        bpath = bpoly.getPath();
        for (i = bpoly.getPath().length; i >= 0; i--) {
            bpath.pop();
        }
        bpoly.setPath(bpath);

    } catch (e) {
//        alert(e.name + ": " + e.message);
    }
}
function baddalert() {
    $('#loading').hide();
    alert('轨迹播放完毕！');
}

function baiduLatLng(ln,la,imei,gpsTime,devId,version) {
        try {
            var point = new BMap.Point(ln, la); 
//            bpath = bpoly.getPath();
            if (bmarkersArray) {
                for (i in bmarkersArray) {
                    bmap.removeOverlay(bmarkersArray[i]);
                }
                bmarkersArray.length = 0;
            }
//            var point = new BMap.Point(114.012098, 22.668851);    //根据经纬度创建point
            var myIcon = new BMap.Icon("/images/23.png", new BMap.Size(23, 35), {
            	// 指定定位位置
            	// 当标注显示在地图上时，其所指向的地理位置距离图标左上
            	// 角各偏移10像素和25像素。您可以看到在本例中该位置即是
                // 图标中央下端的尖角位置。    
                offset: new BMap.Size(10, 25),
                // 设置图片偏移。   
                // 当您需要从一幅较大的图片中截取某部分作为标注图标时，您
                // 需要指定大图的偏移位置，此做法与css sprites技术类似
                imageOffset: new BMap.Size(0, 0)   // 设置图片偏移
            });
            bmarker = new BMap.Marker(point, {icon: myIcon});
            //bmarker = new BMap.Marker(point, { title: "纬度:" + la + ",经度:" + ln });
            bmap.addOverlay(bmarker);
            bmarkersArray.push(bmarker);
//            bpath.push(point);
//            bpoly.setPath(bpath);
            // Add a new marker at the new plotted point on the polyline.
            bmap.setZoom(17);
            bmap.setCenter(point);
            
            
            if (bgeocoder) {
                bgeocoder.getLocation(point, function (results) {
                    if (results) {
                        address = results.address;
                        var content = 
                            "<div class='map_info' style='display:block;'>"+
                            "<div class='tit'>"+imei+"</div>"+
                            "<div class='con'>"+
                            "<p><b>IMEI号/ID号：</b>"+imei+"</p>"+
                //            "<p><b>状态：</b>静止</p>"+
                            "<p><b>定位时间：</b>"+gpsTime+"</p>"+
                //            "<p><b>停留时间：</b>暂无</p>"+
                            "<p><b>定位方式：</b>GPS</p>"+
                            "<p><b>GPS定位是否有效：</b>有效</p>"+
                            "<p><b>停留时间：</b>"+address+"</p>"+
                            "</div>"+
                            "<div class='foot'>"+
                            "<a href='javascript:;' onclick='bclear();track("+devId+","+version+","+imei+")'>实时跟踪</a>&nbsp;"+
                            "<a href='javascript:;' onclick='openHistory("+devId+","+imei+","+version+");bclear();'>历史轨迹</a>&nbsp;"+
                            //"<a href='rail.jsp?imei="+imei+"&lng="+ln+"&lat="+la+"&devId="+devId+"&version="+version+"&gpsTime="+gpsTime+"' target='_blank'>电子栅栏</a> "+
                            "<a href='javascript:;' target='_blank'>电子栅栏</a> "+
                            "</div>"+
                            "<div class='fb'><i></i></div>"+
                            "</div>";
                        binfoWindow = new BMap.InfoWindow(content);
                            binfoWindow.setWidth(280);
                            binfoWindow.setHeight(200);
                        bmarker.openInfoWindow(binfoWindow);    //打开信息窗口
                        bmarker.addEventListener('click', function (event) {
                            bmarker.openInfoWindow(binfoWindow);
                        });
                    }
                });
            }
            
        } catch (e) {
            //alert(e.name + ": " + e.message);
        	bInitialize();
        }
        
//alert($('#others_op').height());
//alert(window.document.getElementById('others_op').offsetHeight);
//alert($(this).height());
//        http://www.gpssafesum.com/
}

function baddLatLngH(ln, la, speed, time) {
    try {
        $('#loading').hide();
        bpath = bpoly.getPath();
        var lat = parseFloat(la);
        var lng = parseFloat(ln);
        var point = new BMap.Point(lng, lat);//根据经纬度创建point
        if (index <= 1) {
            langs = 0;
            bmap.setZoom(17);
            bmap.setCenter(point);
        }
        if (index > 1) {
            if ((bpath[index - 2].lat != bpath[index - 1].lat) && (bpath[index - 2].lng != bpath[index - 1].lng)) {
                var numStr = bmap.getDistance(bpath[index - 2], bpath[index - 1]);

                langs += numStr;
                langs = window.parseInt(langs); // 返回数字123
            }

        }
        if (bmarkersArray) {
            for (i in bmarkersArray) {
                bmap.removeOverlay(bmarkersArray[i]);
            }
            bmarkersArray.length = 0;
        }
        if (bgeocoder) {
            bgeocoder.getLocation(point, function (results) {
                if (results) {
                    address = results.address;
                   
                }
            });
        }
        label = new BMap.Label("", { offset: new BMap.Size(18, -90) });
        label.setContent("经度：" + lng + "<br>纬度：" + lat + "<br>速度：" + speed + "千米/时<br>里程："+langs+"米<br>时间："+time+"<br>地址："+address);
        
        bmarker = new BMap.Marker(point, { title: "纬度：" + lat + "  经度：" + lng + "  GPS时间：" + time });
        bmarker.setLabel(label);
        bmap.addOverlay(bmarker);
        bmarkersArray.push(bmarker);
        bpath.push(point);
        bpoly.setPath(bpath);
        index++;
       
        var bound = bmap.getBounds();
        if (!bound.containsPoint(point)) {//如果监控车俩没有在地图范围内就重设地图中心  
            if (_isBMap_) {
                bmap.panTo(point);
                
            } else {

                bmap.setCenter(point);
            }
        }
    } catch (e) {
        //alert(e.name + ": " + e.message);
    }
}
function h(){
            alert(1);
            $('#set_time').show();
        }