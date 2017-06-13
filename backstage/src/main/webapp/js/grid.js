// JavaScript Document
function allRecord(){
	datagrid.datagrid({queryParams:{}});
	//reloadGrid();
	return false;
};

function postSearch(){
	if(!validRule.validate("#search_form"))return false;
	  var data = fromData($("#search_form"));
	  datagrid.datagrid({queryParams:data});
	//  reloadGrid();
	  return false;
};

function showSoForm(){
	$(".show-so-frm").toggleClass('show');
	$(".rich-search-box").toggle();
	resizeGrid();
	return false;
}
//加载时，改变浏览器尺寸时，datagrid尺寸
/*jQuery(function(){
	var $window = $(window);
	resizeGrid();
	$window.resize(function(){
		resizeGrid();
	});
});*/
//重新计算datagrid尺寸
function resizeGrid(){
 	datagrid.datagrid('resize' , {height: (document.viewHeight-50) });
}

//刷新datagrid
function reloadGrid(){
	datagrid.datagrid('reload');
	return false;
}

//添加按钮调用
function addRecord(){
	addTab("添加-" + tableName,'/system/'+tableName+'/add?id=0');
	return false;
}
//修改按钮调用
function updRecord(){
	var row=datagrid.datagrid('getSelected');
	if(!row) $.messager.alert("操作提示",'<span style="color:red; font-size:16px;">请选择一条数据？</span>','warning');
	addTab("修改-" + tableName+"["+row['id']+"]",'/system/'+tableName+'/edit?id='+row['id']);
	return false;
}
//查看按钮调用
function viewRecord(){
	var row=datagrid.datagrid('getSelected');
	if(!row) $.messager.alert("操作提示",'<span style="color:red; font-size:16px;">请选择一条数据？</span>','warning');
	addTab("查看-" + tableName+"["+row['id']+"]",'/system/'+tableName+'/detail?id='+row['id']);
	return false;
}

//删除按钮调用
function delRecord(){
	var row=datagrid.datagrid('getSelections');
	if(row.length==0){
		$.messager.alert('操作错误！','<span style="color:red; font-size:16px;">您尚未勾选任何数据！</span>','error');
		return false;
	}
	var ids=[];
	for(var i in row) ids[ids.length]=row[i]['id'];
	top.$.messager.confirm('操作提示！','<span style="color:red; font-size:16px;">您确认要删除选择的数据？</span>',function(r){
		if(r){
			var $form = $('<form method="post" action="'+baseUrl+'/system/del/'+tableName+'"></form>');
			$form.append($('<input type="hidden" name="ids" value="'+ids.join(',')+'" require="true" />'));
			$form.appendTo(document.body);
			delSave($form,reloadGrid);
		}
	});
	return false;
}
function delSave($form,callback){
	var _url = $form.attr('action');
	top.$.messager.progress();
	$form.form("submit",{
		url:_url,
		onSubmit:function(params){
			var isValid = validRule.validate($form);
			if(!isValid||!doCheck($form)){
				top.$.messager.progress('close');
			}
			return isValid;
		},
		success: function(data){
			var j = $.parseJSON(data);
			top.$.messager.progress('close');
			if(j.code!==''&& j.code == 0){
				//if(data=="OK"){
				top.$.messager.confirm('操作成功！','<span style="color:red; font-size:16px;">'+ j.msg+'</span>',function(r){
					callback();
				});
			}else{
				$.messager.alert('操作失败！','<span style="color:red; font-size:16px;">'+ j.msg+'</span>','error');
			}
		}
	});
	$form.remove();
}
//导出数据
function downCsvF(){
	if($('#queryExportCsvForm').length==0)return;
	var $queryExportCsvForm = $('#queryExportCsvForm').clone();
	var params = datagrid.datagrid('options').queryParams;
	for (var n in params)
		$('<input type="hidden" name="'+n+'" value="'+params[n]+'" />').appendTo($queryExportCsvForm);
	var sortName = datagrid.datagrid('options').sortName;
	var sortOrder = datagrid.datagrid('options').sortOrder;
	if(sortName && sortOrder){
		$('<input type="hidden" name="sort" value="'+sortName+'" />').appendTo($queryExportCsvForm);
		$('<input type="hidden" name="order" value="'+sortOrder+'" />').appendTo($queryExportCsvForm);
	}
	$queryExportCsvForm.submit();
}

function doCheck($form){
	return true;
}

/*
 *closeCurrentTab
 *@des 关闭当前Tab
 *@param subtitle  如果该参数不为空，那将关闭标题为该参数值的窗口
 *@return void
 */
function closeTab( subtitle ){
	if(window.top != window.self){
		window.parent._closeTab(subtitle);
	}else{
		_closeTab(subtitle);
	}
}

inputBlur("input");
/*
 *@gdReload
 *@desc 刷新指定的datagrid
 *@param obj  datagrid 选择器 传入方式和jQuery选择器一直 ，如id 为list的 请传入 #list
 *@tabtitle 指定标题的tab,假如该值不为空或者有效，则函数会自动需找标题为该值的tab下面为obj的datagrid{注：目前只是用于tab是通过iframe来加载页面的形式}
 *@return object
 */

function gdReload( obj , tabtitle , treegrid){
	if( tabtitle && $.trim(tabtitle) != '' ){
		$ = returnjQuery();
		if( $("#tabs").tabs('exists',tabtitle) ){
			//$("#tabs").tabs('select', tabtitle );
			var currTab = $("#tabs").tabs('getTab',tabtitle);
			try{
				var $$ = currTab.find('iframe')[0].contentWindow.$;//_gdreload( obj );

				$$( obj ).datagrid('reload');
				;
			}catch(e){ console.log('Function: gdReload! May be the datagrid not exists.'); }
		}else{
			console.log('Tab["'+tabtitle+'"] not exists.')
		}
	}else{
		$( obj ).datagrid('reload');
	}
}
var beforeL;


function doSave(){
	var $form = $('#data_form');
	var isValid = validRule.validate($form);
	if(!isValid || !doCheck($form)){
		return false;
	}
	top.$.messager.confirm('操作提示！','<span style="color:red; font-size:16px;">您确认要保存数据！</span>',function(r){
		if(r){
			//var _data = $form.serialize();
			var _url = $form.attr('action');
			top.$.messager.progress();
			var beforeLoad=beforeL==undefined||beforeL==null?function(){return true;}:beforeL;
			$form.form("submit",{
				onSubmit:beforeLoad,
				url:_url,
				success: function(data){
					var j = $.parseJSON(data);
					top.$.messager.progress('close');
					if(j.code!==''&& j.code == 0){
						top.$.messager.confirm('操作成功！','<span style="color:red; font-size:16px;">操作成功!</span><br\>'+'如果要关闭该编辑窗口，请点击确定!',function(r){
							//gdReload('#list_data',modeltit);
							if(r)
								closeTab();
						});
					}else
						$.messager.alert('操作失败！','<span style="color:red; font-size:16px;">'+ j.msg+'</span>','error');
				}
			});
		}
	});
}

function multiS() {
	if ($('#multiS').linkbutton('options').selected) {
		datagrid.datagrid('options').singleSelect = true;
		$('#multiS').linkbutton({text:"单选模式"});
		$('#multiS').linkbutton('unselect');
	} else {
		datagrid.datagrid('options').singleSelect = false;
		$('#multiS').linkbutton({text:'多选模式'});
		$('#multiS').linkbutton('select');
	}
}

function normal(obj){
	top.$.messager.confirm('操作提示！','<span style="color:red; font-size:16px;">您确认要改变'+obj.name.substring(0,obj.name.length-1)+'?</span>',function(r){
		if(r){
			top.$.messager.progress();
			$.post(obj.url, obj, function (data) {
				top.$.messager.progress('close');
				if($.trim(data.code) == 0){
					top.$.messager.confirm('操作成功！','<span style="color:red; font-size:16px;">操作成功!</span><br\>'+'如果要关闭该编辑窗口，请点击确定!',function(r){
						if(r)
							reloadGrid();
					});
				}else
					$.messager.alert('操作失败！','<span style="color:red; font-size:16px;">'+ data.msg+'</span>','error');
			}, 'json');
		}else reloadGrid();
	});
}
/*function borrow(obj){
	top.$.messager.prompt('提示信息', '请填写审核意见：', function(r) {
		if (r) {
			top.$.messager.progress();
			var sta=obj['bean.' + obj.column],bean='verifyRecord';
			if(parseInt(sta)<4) {
				switch (sta) {
					case '2':obj[bean+'.firstVerifyResult']='1';
					case '3':obj[bean+'.firstVerifyResult']='0';
					default:
						obj[bean + '.borrowId'] = obj.row.id;
						obj[bean + '.personBorrowerId'] = obj.row.personBorrowerId;
				obj[bean+'.firstVerifyId'] = top.adminId;
				obj[bean+'.firstVerifyIdea'] = r;
				obj['bean.firstAuditId']=top.adminId;
						obj.level=1;
				}
			}else if(parseInt(sta)<6) {
				switch (sta) {
					case '4':obj[bean+'.repeatVerifyResult']='1';
					case '5':obj[bean+'.repeatVerifyResult']='0'
					default:
				obj[bean+'.repeatVerifyId'] = top.adminId;
				obj[bean+'.repeatVerifyIdea'] = r;
				obj['bean.fullAuditId']=top.adminId;
						obj.level=2;
				}
			}else if(parseInt(sta)<8){
				switch (sta) {
					case '6':obj[bean+'.lastVerifyResult']='1';
					case '7':obj[bean+'.lastVerifyResult']='0';
					default:
				obj[bean+'.lastVerifyId']=top.adminId;
				obj[bean+'.lastVerifyIdea']=r;
				obj['bean.lastUpdateId'] = top.adminId;
						obj.level=3;
				}
			}
			obj['bean.windControlTip']=r;
			$.post(obj.url+'/'+obj.level, obj, function (data) {
				top.$.messager.progress('close');
				if($.trim(data.code) == 0){
					top.$.messager.confirm('操作成功！','<span style="color:red; font-size:16px;">操作成功!</span><br\>'+'如果要关闭该编辑窗口，请点击确定!',function(r){
						if(r)
							reloadGrid();
					});
				}else
					$.messager.alert('操作失败！','<span style="color:red; font-size:16px;">'+ data.msg+'</span>','error');
			}, 'json');
		}else reloadGrid();
	});
	}*/
function butto(e){
	var obj={'bean.id': $(e).attr('did'),url: $(e).attr('url'),name: e.innerText,column: e.name};
	top.$.messager.prompt('提示信息', '请输入要设定的值：', function(r) {
		if (r) {
			obj['bean.'+ e.name]=r;
			top.$.messager.progress();
			$.post(obj.url, obj, function (data) {
				top.$.messager.progress('close');
				if($.trim(data.code) == 0){
					top.$.messager.confirm('操作成功！','<span style="color:red; font-size:16px;">操作成功!</span><br\>'+'如果要关闭该编辑窗口，请点击确定!',function(r){
						if(r)
							reloadGrid();
					});
				}else
					$.messager.alert('操作失败！','<span style="color:red; font-size:16px;">'+ data.msg+'</span>','error');
			}, 'json');
		}
	})

}

function upload(e){
	var opt=$("#ww").window('window');
	$("#ww").window($.extend(opt,{closed:false}));
	var obj={'bean.id':$(e).attr('did'),column: e.name};
	if($(e).attr('value')=='4097'){
		top.$.messager.prompt('请输入图片代码','输入要上传的图片规格',function(val){
			if(val) obj.key=val;
			else return;
		})
	}
	$("#btnUp").click({url:$(e).attr('url'),obj:obj},function(event){
		top.$.messager.progress();
		$("#upForm").form('submit',{
			url:event.data.url ,
			ajax:false,
			queryParams:event.data.obj,
			success: function(data){
				var j = $.parseJSON(data);
				top.$.messager.progress('close');
				if(j.code!==''&& j.code == 0){
					top.$.messager.alert('上传成功','<span style="color:red; font-size:16px;">上传成功!</span>','info',function(){
						$("#upForm").form('reset');
					});
				}else
					$.messager.alert('上传失败！','<span style="color:red; font-size:16px;">'+ j.msg+'</span>','error');
				$("#ww").window($.extend(opt, {closed: true}));
			}
		})
	})
}

function shipments(e){
	$("#orderId").val($(e).attr('did'));
	var $form=$("#codeForm");
	$.post(baseUrl+"/order/orderInfo",{orderId:$(e).attr('did')},function(data){
		if(data.code==0){
			$.each($.isArray(data.data.orderItems)?data.data.orderItems:[data.data.orderItems],function(i,value){
				$form.append('<span><br>商品名称:<p>' + value['prodName'] + '&nbsp;&nbsp;&nbsp;数量:('+value['count']+')个</p></span>');
				for(var i=0;i<value.count;i++)
				$form.append('<span>第'+(i+1)+'个设备:<input  type="text" class="txt01" name="'+value.id+'_'+i+'"/><br></span>');
			});
			$form.on('keyup','input:gt(1)',function(event){
				if(event.keyCode==13){
					if($(this).is("#codeForm input:last"))
						$("#btnCode").click();
					else{
						var nexts=$(this).parent().nextUntil('span:has(input)');
						if(nexts.length>0)
							nexts.next().find('input').focus();
						else $(this).parent().next().find('input').focus();
					}
				}
			})
		}else $.messager.alert('处理失败！','<span style="color:red; font-size:16px;">订单发生异常,请稍后重试!</span>','error');
	},'json');
	var opt=$("#scan").window('window');
	$("#scan").window($.extend(opt,{closed:false,onClose:function(){
		$form.find('span:gt(0)').remove();
		$form.form('reset');
		$("#installCode").removeAttr('checked');
	}}));
	$('#logis').focus();
	var row=datagrid.datagrid('getRows')[$(e).attr('ind')];
	if(row['payNum']!=undefined&&row['payNum']!='') $("#installCode").click();
	$("#btnCode").click(function(event){
		top.$.messager.progress();
		var orderIt={};
		$form.find('input:gt(2)').each(function(i,n){
			var arr = $(n).attr('name').split('_');
			var item=orderIt[arr[0]]||[];
			item[arr[1]]= n.value;
			orderIt[arr[0]]=item;
		});
		$("#codeForm").form('submit',{
			url: $(e).attr('url'),
			ajax:false,
			queryParams:{id:$(e).attr('did'),shipments:JSON.stringify(orderIt),logisticsId:$('#logis').val(),state:'2'},
			success: function(data){
				var j = $.parseJSON(data);
				top.$.messager.progress('close');
				if(j.code!==''&& j.code == 0){
					$("#scan").window('close');
					window.open(baseUrl + '/order/print/' + $(e).attr('did'));
					reloadGrid();
				}else
					$.messager.alert('提交失败！','<span style="color:red; font-size:16px;">'+ j.msg+'</span>','error');
				$("#scan").window($.extend(opt, {closed: true}));
			}
		})
	})
}

function payout(e){
	var obj={couponDictId: $(e).attr('did'),url: $(e).attr('url')};
	top.$.messager.prompt('提示信息', '请输入生成优惠码的数量：', function(r) {
		if (r) {
			obj.count=r;
			top.$.messager.prompt('提示信息','请输入业务员的用户ID,没有点取消!',function(s){
				if(s) obj.userId=s;
				else obj.userId=0;
			//top.$.messager.progress();
				window.open(obj.url+'?couponDictId='+obj.couponDictId+'&userId='+obj.userId+'&count='+obj.count);
/*			$.post(obj.url, obj, function (data) {
				top.$.messager.progress('close');
				if($.trim(data.code) == 0){
					top.$.messager.confirm('操作成功！','<span style="color:red; font-size:16px;">操作成功!</span><br\>'+'如果要关闭该编辑窗口，请点击确定!',function(r){
						//if(r)
						//	reloadGrid();
					});
				}else
					$.messager.alert('操作失败！','<span style="color:red; font-size:16px;">'+ data.msg+'</span>','error');
			}, 'html');*/
			})
		}
	})
}
//退款按钮调用
function refund(){
	var rows=datagrid.datagrid('getSelections');
	if(rows.length<1) $.messager.alert("操作提示",'<span style="color:red; font-size:16px;">请至少选择一条数据？</span>','warning');
	var ids=[];
	for(var i in rows) ids[ids.length]=rows[i]['id'];
	var datas=$.map(rows,function(n,i){
		var payInfo = eval('(' + n['payInfo'] + ')');
		return payInfo['trade_no']+'^'+payInfo['total_fee']+'^协商退款';
	})
	$.post(baseUrl+'/order/subRefund',{payType:rows[0]['payType'],detailData:datas.join('#'),ids:ids.join(',')},function(dat){
		if(dat.code==0) {
			if (rows[0]['payType'] == 'aliPay') {
				top.$.messager.confirm('提交成功,待确认操作！', '<span style="color:red; font-size:16px;">确认操作!</span><br\>' + '是否确认放款?', function (r) {
					if (r)
						window.open(baseUrl + "/order/toRefund");
				});
			} else if (rows[0]['payType'] == 'wxPay')
				top.$.messager.confirm('提交成功！', '<span style="color:red; font-size:16px;">操作完成!</span><br\>' + '已完成放款,数量(' + dat.data + ')', function (r) {
					if (r)
						;
				});
		}else $.messager.alert('操作失败！','<span style="color:red; font-size:16px;">'+ dat.msg+'</span>','error');
	},'json');
}
