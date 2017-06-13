/**
 * 表格转换成JSON
 * @param el
 * @returns {{}}
 */
function fromData(el) {
    var seriArray = $(el).serializeArray();
    var data = {};
    for (var i in seriArray) {
        if (seriArray[i]["value"] && seriArray[i]["value"] != undefined && seriArray[i]["value"] != '')
            data[seriArray[i]["name"]] = seriArray[i]["value"];
    }
    return data;
}
function fromDataString(el) {
    var seriArray = $(el).serializeArray();
    var data = "";
    for (var i in seriArray) {
        if (seriArray[i]["value"] && seriArray[i]["value"] != '')
            data += '&' + seriArray[i]['name'] + '=' + seriArray[i]['value'];
        //data[seriArray[i]["name"]] = seriArray[i]["value"];
    }
    /*    if (data == '?')
     return '';*/
    return data.substring(1);
}
/**
 * ajax填充数据
 * @param el
 * @param data
 */
function fillData(el, data, fields, formatFields) {
    $(el).find("tbody").children().remove();
    var html = [];

    for (var i = 0; i < data.length; i++) {
        var trHtml = "<tr>";
        var trData = data[i];
        $(el).find("th").each(function (i, domEl) {
            var tdHtml = "<td>";
            for (var da in trData) {
                if ($(domEl).attr("na") == da && trData[da] != undefined) {
                    var flag = -1;
                    if (fields && fields != undefined && fields.length > 0) {
                        for (var ind in fields) {
                            if (fields[ind] == da) {
                                flag = ind;
                                break;
                            }
                        }
                    }
                    if (flag >= 0)
                        tdHtml += formatFields[flag].replace(/\?\?/g, trData[da]);
                    else
                        tdHtml += trData[da];
                    break;
                }
            }
            tdHtml += "</td>";
            trHtml += tdHtml;
        });
        trHtml += "</tr>";
        html[html.length] = trHtml;
    }
    $(el).find("tbody").append(html);
}
/**
 * 分页点击事件
 * @param url
 * @param condEl
 * @param dataEl
 * @param n
 * @param size
 */
function pageClick(url, condEl, dataEl, n, size, fields, formatFields) {

    var param = fromData(condEl);
    param.pageSize = size || "1";
    param.currentPage = n + "";
    $.get(url, param, function (data) {
        if (data.result && data.result != undefined)
            fillData(dataEl, data.result, fields, formatFields);
    }, "json");
//                return false;
}
/**
 * 下拉框设置值
 * @param el
 * @param val
 */
function setStatus(el, val) {
    var els = $(el).find("option");
    els.removeAttr("selected");
    els.each(function (i, domEl) {
        if ($(domEl).attr("value") == val) {
            $(domEl).attr("selected", "selected");
            return false;
        }
    });
}
function ajaxSave(el, url) {
    var param = fromData(el);
    $.post(url, param, function (data) {
        if (data.code == 0) {
            alert("操作成功");
            window.location.reload(true);
        }
        else
            alert("操作失败");
    }, 'json');
};
/**
 * 显示数据
 * @param el 显示元素
 * @param obj
 * @param operator 操作类型
 */
function showData(el, obj, operator) {
    $(el).find("input").each(function (i, domEl) {
        if (operator == 'detail')
            $(domEl).attr("disabled", "disabled");
        else
            $(domEl).attr("disabled", false);
        for (var o in obj) {
            if (o == $(domEl).attr("name")) {
                $(domEl).val(obj[o]);
                break;
            }
        }
    })
    if (operator == 'edit') {
        $("#ok").show();
        $("#close").hide();
    } else {
        $("#ok").hide();
        $("#close").show();
    }
}

validRule = {
    phone: {
        regexp: "^1[345789]+?\\d{9}$",
        msg: "您输入的手机号码格式不正确",
        css: ""
    },
    password: {
        regexp: "\\S{8,32}",
        msg: "密码长度不能小于8位"
    },
    userName: {
        regexp: "\\w{5,32}",
        msg: "用户名长度不能小于5位"
    },
    snCard: {
        regexp: "(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)",
        msg: "您输入的身份证格式不正确"
    },
    nameOrPhone: {
        regexp: "(^1[345789]+?\\d{9}$)|(\\w{5,32})",
        msg: "您输入的身份证格式不正确"
    },
    realName:{
        regexp:"[^\\x00-\\xff]{2,8}",
        msg:"真实姓名为汉字,限定长度为8"
    },
    money:{
        regexp:"\\d{1,7}00(\\.\\d{1,2})?",
        msg:"输入的金额必须为100的倍数"
    },
    month:{
        regexp:"\\d{1,2}",
        msg:"月份为1至60之间的整数"
    },
    address:{
        regexp:"[^\\x00-\\xff]{2,32}(\\d*?[^\\x00-\\xff]*?)*",
        msg:"请输入2~32个汉字或数字"
    },
    china100:{
        regexp:"[^\\x00-\\xff]{2,100}",
        msg:"请输入2至100个左右的汉字"
    },
    filter:"this.reg(value, getAttribute('regexp'))",
    errFun:function(el,current,errEl){
        var err = $(el).next('.erro-msg');
        if (current['msg'] && current['msg'] != '')
            errEl.text(current['msg'])
        if (current['css'] && current['css'] != '')
            errEl.attr("class", current['css'])
        if (err.size() <= 0)
            $(el).after(errEl);
        errEl.show(150);
        return false;
    },
    reg: function (op, reg) {
        return new RegExp(reg, "g").test(op);
    },
    exec: function (el, func) {
        if (typeof func == 'function') return func(el);
        with ($(el).get(0)) {
            var err = $(el).next('.erro-msg'), errEl = err.size() > 0 ? err : $("<h4 class='erro-msg'></h4>");
            if (getAttribute("require") != undefined && (value == undefined || value == '')) {
                if (err.size() <= 0)
                    $(el).after(errEl);
                errEl.show().text("必填项.");
                return false;
            }
            var _datatype = getAttribute("validType");
            if (typeof(_datatype) == "object" || _datatype==undefined||("" + _datatype == "")|| typeof(this[_datatype]) == "undefined"){
                errEl.hide(150, "linear");
                return true;
            }
            var current=this[_datatype];
            switch (_datatype) {
                case "filter" :
                    if (!eval(this[_datatype]))
                       return this.errFun(el,current,errEl);
                case "number":
                case "integer":
                case "double":
                    if (!new RegExp(this[_datatype].regexp,"g").test(value)) {
                        return this.errFun(el, current,errEl);
                    } else {
                        var minValue = getAttribute("min");
                        var maxValue = getAttribute("max");
                        if (minValue)
                            if (Number(value) < Number(minValue))
                                return this.errFun(el,current,errEl);
                        if (maxValue)
                            if (Number(value) > Number(maxValue))
                                return this.errFun(el, current,errEl);
                    }
                    break;
                default :
                    if (!new RegExp(this[_datatype].regexp,'g').test(value))
                        return this.errFun(el,current,errEl)
                    break;
            }
                    errEl.hide(150, "linear");
                    return true;
        }
/*        if (el.attr("require") != undefined && (el.val() == undefined || el.val() == '')) return false;
        if (el.attr("validType") == undefined || el.attr("validType") == "")
            return true;
        var current = this[el.attr("validType")], err = el.next('.erro-msg'), errEl = err.size() > 0 ? err : $("<h4 class='erro-msg'></h4>");
        //if (!new RegExp(current['regexp'], 'g').test(el.val())) {
        if (!current.regexp.test(el.val())) {
            if (current['msg'] && current['msg'] != '')
                errEl.text(current['msg'])
            if (current['css'] && current['css'] != '')
                errEl.attr("class", current['css'])
            if (err.size() <= 0)
                el.after(errEl);
            errEl.show();
            return false;
        }
        errEl.hide(300, "linear");
        return true;*/
    },
    validate: function (formEl) {
        var formE = document.forms[0];
        if (formEl != undefined&&formEl!=null)
            formE = $(formEl);
        $(formE).find("input").each(function (i, el) {
            validRule.exec($(this));
        })
        return $(".erro-msg:visible").size() < 1
    }
};
function inputBlur(el) {
    //$(el).blur(function () {
    $("body").on("blur",el,null,function () {
        if (!validRule.exec($(this))) return false;
        var url = $(this).attr('url'), err = $(this).next(".erro-msg"), erro = err.size() > 0 ? err : $("<h4 class='erro-msg'></h4>");
        if ($(this).attr('require') != undefined && ($(this).val() == undefined || $(this).val() == '')) {
            //if($(this).val()==undefined||$(this).val()==''){
            if (err.size() <= 0)
                $(this).after(erro);
            erro.show().text("必填项.");
            return false;
        }
        if ($(this).val() == '') {
            erro.hide(150);
            return true;
        }
        if (url != undefined && url != '') {
            $.ajax({
                type: "GET",
                url: url,
                context: $(this),
                data: {val: $(this).val()},
                dataType: "json",
                success: function (data) {
                    if (data.code != 0) {
                        if (err.size() <= 0)
                            $(this).after(erro);
                        erro.show(150).text(data.msg);
                        return false;
                    } else
                        erro.hide(150);
                }
            });
            return true;
        }
        //}
    });
}
function getCookie(c_name) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(c_name + "=")
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1
            c_end = document.cookie.indexOf(";", c_start)
            if (c_end == -1) c_end = document.cookie.length
            return decodeURIComponent(document.cookie.substring(c_start, c_end))
        }
    }
    return ""
}

function setCookie(c_name, value, expiredays) {
    var exdate = new Date()
    exdate.setDate(exdate.getDate() + expiredays)
    document.cookie = c_name + "=" + encodeURIComponent(value) + ";path=/" +
        ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString())
}

function checkCookie(el) {
    var cookieValue = getCookie($(el).attr("name"))
    if (cookieValue != null && cookieValue != "") {
        $(el).val(cookieValue)
    } else {
        /*        cookieValue=prompt('Please enter your name:',"")
         if (cookieValue!=null && cookieValue!=""){
         setCookie('cookieValue',cookieValue,30)
         }*/
    }
}

function deleteCookie(name) {
    //sBaseAreaName来自common.js
    document.cookie = name + '=;path=/;expires=Thu, 01-Jan-1970 00:00:01 GMT';
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

function getSessionId(){
    var c_name = 'JSESSIONID';
    if(document.cookie.length>0){
        c_start=document.cookie.indexOf(c_name + "=")
        if(c_start!=-1){
            c_start=c_start + c_name.length+1
            c_end=document.cookie.indexOf(";",c_start)
            if(c_end==-1) c_end=document.cookie.length
            return unescape(document.cookie.substring(c_start,c_end));
        }
    }
}