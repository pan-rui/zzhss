/**
 * Created by panrui on 2015/10/7.
 */
document.write('<div id="divShow" style="display:none;"></div>');
function floatdiv(s, url) {
    var html = "" + s + "";
    if (document.getElementById("divShow")) {
        document.getElementById("divShow").style.display = "none";
        document.getElementById("divShow").style.position = "absolute";
        document.getElementById("divShow").style.zIndex = "110000";
        document.getElementById("divShow").innerHTML = html;
        document.getElementById("divShow").style.display = "";
        var divShow_left = (document.body.offsetWidth - document.getElementById("divShow").offsetWidth) / 2 + document.body.scrollLeft;
        var divShow_top = (document.body.clientHeight - document.getElementById("divShow").offsetHeight) / 2 + document.body.scrollTop;
        document.getElementById("divShow").style.display = "";
        document.getElementById("divShow").style.left = divShow_left + "px";
        document.getElementById("divShow").style.top = divShow_top + "px";
        clseopacity("divShow", 0, url)
    }
}
function clseopacity(id, n, url) {
    if (n < 95) {
        n = n + 10;
        document.getElementById(id).style.filter = "alpha(opacity=" + n + ")";
        document.getElementById(id).style.opacity = n / 100;
        setTimeout("clseopacity('" + id + "'," + n + ",'" + url + "')", 100)
    } else {
        setTimeout("timeoutjs('" + id + "','" + url + "')", 1000)
    }
}
function timeoutjs(id, url) {
    document.getElementById(id).style.display = "none";
    if (url != "#") {
        location.href = url
    }
}
function showMask(show, widthVal, heightVal) {
    var mask = document.getElementById("dmask");
    var frmmask = document.getElementById("frmmask");
    var frmDialog = document.getElementById("frmDialog");
    if (mask && frmmask) {
        var width = document.body.scrollWidth;
        if (width < document.body.clientWidth) {
            width = document.body.clientWidth
        }
        if (width < document.documentElement.clientWidth) {
            width = document.documentElement.clientWidth
        }
        if (width < document.documentElement.scrollWidth) {
            width = document.documentElement.scrollWidth
        }
        var height = document.body.scrollHeight;
        if (height < document.body.clientHeight) {
            height = document.body.clientHeight
        }
        if (height < document.documentElement.clientHeight) {
            height = document.documentElement.clientHeight
        }
        if (height < document.documentElement.scrollHeight) {
            height = document.documentElement.scrollHeight
        }
        if (window.XMLHttpRequest) {
            mask.style.position = "fixed";
            frmmask.style.position = "fixed"
        }
        mask.style.top = "0px";
        mask.style.left = "0px";
        mask.style.width = width + "px";
        mask.style.height = height + "px";
        frmmask.style.top = "0px";
        frmmask.style.left = "0px";
        frmmask.style.width = width + "px";
        frmmask.style.height = height + "px";
        if (show) {
            mask.style.visibility = "visible";
            frmmask.style.visibility = "visible";
            frmDialog.style.visibility = "visible"
        } else {
            mask.style.visibility = "hidden";
            frmmask.style.visibility = "hidden";
            frmDialog.style.visibility = "hidden"
        }
    }
    var width = widthVal;
    var height = heightVal;
    var top = (window.screen.height / 2 + (document.body.scrollTop > document.documentElement.scrollTop ? document.body.scrollTop : document.documentElement.scrollTop) - height / 2 - 100) > 0 ? (window.screen.height / 2 + (document.body.scrollTop > document.documentElement.scrollTop ? document.body.scrollTop : document.documentElement.scrollTop) - height / 2 - 100) : 0;
    var left = (window.screen.width / 2 + (document.body.scrollLeft > document.documentElement.scrollLeft ? document.body.scrollLeft : document.documentElement.scrollLeft) - width / 2) > 0 ? (window.screen.width / 2 + (document.body.scrollLeft > document.documentElement.scrollLeft ? document.body.scrollLeft : document.documentElement.scrollLeft) - width / 2) : 0;
    frmDialog.style.top = top + "px";
    frmDialog.style.left = left + "px";
    frmDialog.style.width = width + "px";
    frmDialog.style.height = height + "px";
    document.getElementById("divShow").style.display = "none"
}
function closeForm() {
    var objF = document.getElementById("filter");
    document.getElementById("divShow").innerHTML = "";
    document.getElementById("divShow").style.display = "none";
    if (objF) {
        objF.parentNode.removeChild(objF)
    }
}
function div_show(id, none) {
    document.getElementById(id).style.display = "";
    document.getElementById(none).style.display = "none"
}
$(function () {
    $(".sitebottom .tag").mouseenter(function () {
        $(this).css("background-position", "0 -42px")
    }).mouseleave(function () {
        $(this).css("background-position", "0 0")
    })
});
$(function () {
    $("#downs").click(function () {
        var m_submit = "add_downs";
        $.ajax({
            url: "post.php?" + Math.random(),
            type: "post",
            async: false,
            data: {id: $("#file_key").val(), u: $("#u").val(), type: m_submit},
            dataType: "text",
            error: function () {
                return false
            },
            success: function (result) {
                if (result == "timeout") {
                    $("#downs").attr("href", "/file/" + $("#file_key").val() + ".html")
                } else {
                    if ($("#go")) {
                    }
                }
            }
        })
    })
});
function putcode(id) {
    var code = document.yzcode.code.value;
    if (code == "") {
        alert("请填写验证码。");
        return false
    }
    $.ajax({
        url: "/downcode.php",
        type: "post",
        data: {action: "yz", id: id, code: code},
        dataType: "text",
        error: function () {
            alert("提交失败。");
            return false
        },
        success: function (result) {
            if (result == 1) {
                document.getElementById("downbtn").style.display = "";
                document.getElementById("yzm").style.display = "none"
            } else {
                if (result == 0) {
                    alert("验证码不正确")
                } else {
                    alert("下载地址已超时，请重新下载。");
                    window.location.href = ("/file/" + result + ".html")
                }
            }
        }
    })
}
function getCookie(A) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(A + "=");
        if (c_start != -1) {
            c_start = c_start + A.length + 1;
            c_end = document.cookie.indexOf(";", c_start);
            if (c_end == -1) {
                c_end = document.cookie.length
            }
            return unescape(document.cookie.substring(c_start, c_end))
        }
    }
    return ""
}
function go_(s) {
    $.ajax({
        url: "http://s" + s + ".su" + "fi" + "le.net:36" + "37/go_.php?callback=?",
        type: "get",
        data: {c: getCookie("C_user_id")},
        dataType: "jsonp",
        crossDomain: true,
        error: function () {
            return false
        },
        success: function (result) {
        }
    })
}
function down_file(file_key, p) {
    var obj = document.createElement("div");
    obj.id = "filter";
    obj.innerHTML = '<div id="dmask" style="z-index:10000;display:block;background:#000;filter:alpha(opacity=40);-moz-opacity:0.4;opacity:0.4;position:absolute;visibility:hidden;"></div>' + '<div id="frmmask" style="z-index:9999;display:block;background:#000;filter:alpha(opacity=0);-moz-opacity:0;opacity:0;position:absolute;visibility:hidden;"></div>' + '<div id="frmDialog" style="background-color:#FFFFFF;vertical-align:middle;width:346px;height:356px;z-index:10010;position:absolute;display:block;visibility:hidden;border:1px solid #fff;">' + '<div style="width:346px;height:350px;float:left;overflow:hidden;">' + '<div style="background:#2499d7;color:#FFF;height:30px;font-size:14px;font-weight:bold;padding-top:6px;"><div style="position:absolute;margin-left:326px;margin-top:2px;"><a href="javascript:;" onclick="closeForm()" title="关闭"><img src="/member/images/close.png" width="14" height="14" border="0"></a></div>　文件下载　</div>' + '<iframe id="show_down" style="margin-top:4px;" frameborder="0" scrolling="no" width="352" height="316" scrolling="auto" src="about:blank"></iframe></div></div>';
    document.body.appendChild(obj);
    showMask(true, 346, 356);
    document.getElementById("show_down").src = "/dd.php?file_key=" + file_key + "&p=" + p
}
function jubao_file(file_key, userlogin) {
    var obj = document.createElement("div");
    obj.id = "filter";
    obj.innerHTML = '<div id="dmask" style="z-index:10000;display:block;background:#000;filter:alpha(opacity=40);-moz-opacity:0.4;opacity:0.4;position:absolute;visibility:hidden;"></div>' + '<div id="frmmask" style="z-index:9999;display:block;background:#000;filter:alpha(opacity=0);-moz-opacity:0;opacity:0;position:absolute;visibility:hidden;"></div>' + '<div id="frmDialog" style="background-color:#FFFFFF;vertical-align:middle;height:325px;width:500px;z-index:10010;position:absolute;display:block;visibility:hidden;border:1px solid #fff;">' + '<div style="width:500px;height:319px;float:left;overflow:hidden;">' + '<div style="background:#2499d7;color:#FFF;height:30px;font-size:14px;font-weight:bold;padding-top:6px;"><div style="position:absolute;margin-left:480px;margin-top:2px;"><a href="javascript:;" onclick="closeForm()" title="关闭"><img src="/member/images/close.png" width="14" height="14" border="0"></a></div>　文件举报　</div>' + '<iframe id="show_jubao" style="margin-top:4px;" frameborder="0" scrolling="no" width="500" height="316" scrolling="auto" src="about:blank"></iframe></div></div>';
    document.body.appendChild(obj);
    showMask(true, 500, 325);
    document.getElementById("show_jubao").src = "/jubao.php?file_key=" + file_key + "&d_user=" + userlogin
}
function pay_vip_() {
    var obj = document.createElement("div");
    obj.id = "filter";
    obj.innerHTML = '<div id="dmask" style="z-index:10000;display:block;background:#000;filter:alpha(opacity=40);-moz-opacity:0.4;opacity:0.4;position:absolute;visibility:hidden;"></div>' + '<div id="frmmask" style="z-index:9999;display:block;background:#000;filter:alpha(opacity=0);-moz-opacity:0;opacity:0;position:absolute;visibility:hidden;"></div>' + '<div id="frmDialog" style="background-color:#FFFFFF;vertical-align:middle;width:346px;height:206px;z-index:10010;position:absolute;display:block;visibility:hidden;border:1px solid #fff;">' + '<div style="width:346px;height:200px;float:left;overflow:hidden;">' + '<div style="background:#2499d7;color:#FFF;height:30px;font-size:14px;font-weight:bold;padding-top:6px;"><div style="position:absolute;margin-left:326px;margin-top:2px;"><a href="javascript:;" onclick="closeForm()" title="关闭"><img src="/member/images/close.png" width="14" height="14" border="0"></a></div>　在线支付　</div>' + '<table width="100%" border="0" cellpadding="0" style="margin-left:10px;margin-top:5px;"><tr><td width="22%" align="center" style="font-size:16px; font-weight:bold;"><img src="/images/gth.gif" /></td><td width="78%" style="font-size:16px; font-weight:bold;">请您在新打开的支付宝付款页面<br>完成付款</td></tr><tr><td colspan="2" height="20">付款完成前请不要关闭此窗口</td></tr><tr><td colspan="2" height="20">完成付款后请根据您的情况点击下列按钮：</td></tr><tr><td colspan="2" align="center" height="65"><a href="/bd.php" class="imitate-btn imitate-green">完成付款</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="closeForm()">付款失败了</a></td></tr></table></div></div>';
    document.body.appendChild(obj);
    showMask(true, 346, 206)
};
