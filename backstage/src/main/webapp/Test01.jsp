<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2014/11/26
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Test01</title>
</head>
<body>
<script type="text/javascript" src="js/jquery-1.11.1.js"></script>
<script type="text/javascript">
    function query(a) {
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/jcyt_hhn/test01",
            dataType: "json",
            data: "id=" + a,
            success: function (data) {
                alert(data);
            }
        })
    }
</script>
<p>${fn:startsWith('fdfd'+'fdfd','fdf' )}</p>
<button id="cart" name="cartTest" onclick="query(1)">查看数据</button>
</body>
<script>
    var mm = {
        "cardlist": [{
            "bindid": "528",
            "bindvalidthru": 1476253248,
            "card_last": "5688",
            "card_name": "招商银行贷记卡",
            "card_top": "356889",
            "merchantaccount": "YB01000000144",
            "phone": "13301003095"
        }, {
            "bindid": "541",
            "bindvalidthru": 1475991834,
            "card_last": "2697",
            "card_name": "招商银行借记卡",
            "card_top": "622588",
            "merchantaccount": "YB01000000144",
            "phone": "13301003095"
        }, {
            "bindid": "2011933",
            "bindvalidthru": 1472719272,
            "card_last": "1912",
            "card_name": "中国银行借记卡",
            "card_top": "621790",
            "merchantaccount": "YB01000000144",
            "phone": "13466502360"
        }, {
            "bindid": "2013402",
            "bindvalidthru": 1472719325,
            "card_last": "3052",
            "card_name": "中国银行借记卡",
            "card_top": "621785",
            "merchantaccount": "YB01000000144",
            "phone": "18463101691"
        }, {
            "bindid": "2014398",
            "bindvalidthru": 1473043760,
            "card_last": "5520",
            "card_name": "中信银行贷记卡",
            "card_top": "622689",
            "merchantaccount": "YB01000000144",
            "phone": "13301003095"
        }, {
            "bindid": "2015997",
            "bindvalidthru": 1475918720,
            "card_last": "3557",
            "card_name": "建设银行借记卡",
            "card_top": "622700",
            "merchantaccount": "YB01000000144",
            "phone": "17751779664"
        }],
        "identityid": "493002407599521",
        "identitytype": 0,
        "merchantaccount": "YB01000000144",
        "sign": "jDgR3KIQMNVeHYuZd/eQZkj3oaafss6bKaTRfcPKzUN7xdG+scCZ1YbhL5zgm7HS49FgBcz6eGN12OKL00Y+qEDk2pLAQX1qXzOAnGvfMFwAT/16SRPoPh6O/8WanjRhjzrn5lmQ3s2xhpdMpcx0LgG1RR4ObYG/pwjyQHtsEZg="
    };
    [{
        "id": 654655,
        "menuLevel": "1",
        "isIntercept": "0",
        "parentId": 0,
        "icon": "",
        "sort": 1,
        "fixedly": "[\"id\"]",
        "search": "[\"id\"]"
    }, {
        "id": 1242,
        "menuName": "用户管理",
        "url": "/user",
        "menuLevel": "1",
        "isIntercept": "0",
        "parentId": 0,
        "icon": "users",
        "sort": 1,
        "fixedly": "[\"id\"]",
        "search": "[\"id\"]",
        "menus": [{
            "id": 535,
            "menuName": "用户列表",
            "url": "/system/t_user/list",
            "menuLevel": "2",
            "isIntercept": "1",
            "parentId": 1242,
            "icon": "users",
            "sort": 1,
            "fixedly": "[\"id\"]",
            "search": "[\"id\"]"
        }, {
            "id": 2432,
            "menuName": "权限列表",
            "url": "/system/t_role/list",
            "menuLevel": "2",
            "isIntercept": "1",
            "parentId": 1242,
            "icon": "set",
            "sort": 2,
            "fixedly": "[\"id\"]",
            "search": "[\"id\"]"
        }]
    }, {
        "id": 25243,
        "menuName": "借款管理",
        "url": "/borrow",
        "menuLevel": "1",
        "isIntercept": "0",
        "parentId": 0,
        "icon": "set",
        "sort": 2,
        "fixedly": "[\"id\"]",
        "search": "[\"id\"]",
        "menus": [{
            "id": 2535,
            "menuName": "借款列表",
            "url": "/system/t_borrow/list",
            "menuLevel": "2",
            "isIntercept": "1",
            "parentId": 25243,
            "icon": "",
            "sort": 1,
            "fixedly": "[\"id\"]",
            "search": "[\"id\"]"
        }]
    }, {
        "id": 5567,
        "menuName": "系统设置",
        "url": "/system",
        "menuLevel": "1",
        "isIntercept": "1",
        "parentId": 0,
        "icon": "set",
        "sort": 9,
        "fixedly": "[\"id\"]",
        "search": "[\"id\"]",
        "menus": [{
            "id": 654654,
            "menuName": "菜单列表",
            "url": "/system/t_menu/list",
            "menuLevel": "2",
            "isIntercept": "1",
            "parentId": 5567,
            "icon": "set",
            "sort": 1,
            "fixedly": "[\"id\"]",
            "search": "[\"id\",\"menuName\"]"
        }]
    }]

    var abc = {
        "gmt_create": "2016-03-23 22:43:48",
        "seller_email": "18898765373@163.com",
        "subject": "智护伞T1",
        "use_coupon": "N",
        "sign": "4ec9c275be813cb0fdf433c546ddbc6a",
        "discount": "0.00",
        "body": "简单/使用/好玩/价值迭代，只为离你更近一些 至真至简，为你而来！",
        "buyer_id": "2088002706705164",
        "notify_id": "e15679aa0b55de77af6352c0e18350eh8i",
        "notify_type": "trade_status_sync",
        "price": "0.11",
        "trade_status": "TRADE_SUCCESS",
        "total_fee": "0.11",
        "sign_type": "MD5",
        "seller_id": "2088811216437780",
        "is_total_fee_adjust": "N",
        "buyer_email": "panrui-520@163.com",
        "notify_time": "2016-03-23 22:50:19",
        "gmt_payment": "2016-03-23 22:43:53",
        "refund_status": "REFUND_SUCCESS",
        "quantity": "1",
        "gmt_refund": "2016-03-23 22:50:18.866",
        "payment_type": "1",
        "out_trade_no": "256",
        "trade_no": "2016032321001004160275971483"
    }
</script>
</html>
