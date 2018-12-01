<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>自定义首页模块</title>
<script type="text/javascript" src="${ctx}/static/js/Tdrag.js"></script>
<style type="text/css">
.modal-header{
border-bottom: 1px solid #3bbce6;
min-height: 16.43px;
padding: 15px;
opacity: 0.8;
}
.modal-content{
background: rgba(20,91,146,0.90);
border-radius: 8px;
}
h4 {
color:#FFFFFF;
}
.modal-footer {
    background: rgba(20,91,146,0.90);
    border-radius: 8px;
}
    
.modal-header .close {
    margin-top: -10px;
    margin-right: -10px;
}
.close {
    color: #ffff;
    float: right;
    font-size: 21px;
    font-weight: 700;
    line-height: 1;
 opacity: 1;
    text-shadow: 0 1px 0 #fff;
}
button.close {
    background : rgba(20,91,146,0.0);
    border-bottom:none !important;
    border-bottom-left-radius: none !important;
    border-left: none !important;
    border-top: none !important;
    border-top-left-radius: none !important;
    font-size: 40px;
    padding: none !important;
}
 .btn-modal:hover, .btn-modal:focus{ 
    background: -webkit-gradient(linear, center top, center bottom, from(#34968e), to(#38a59c)); 
     background-image: linear-gradient(#3bbce6, #3bbce6); 
     background-color: #3bbce6; 
    
     } 
.btn-modal {
    padding-left: 20px;
    padding-right: 20px;
    padding-top: 5px;
    padding-bottom: 5px;
    color: #fff;
    background: -webkit-gradient(linear, center top, center bottom, from(#38a59c), to(#34968e));
    background-image: linear-gradient(#3bbce6 , #3bbce6 );
    background-color: #3bbce6;
    border-width: 0px;
}
.btn-cancle{
padding-left: 20px;
padding-right: 20px;
padding-top: 5px;
padding-bottom: 5px;
color: #fff;
background: -webkit-gradient(linear, center top, center bottom, from(#648CAB), to(#648CAB));
background-image: linear-gradient(#648CAB , #648CAB );
background-color: #648CAB;
border-radius: 4px;
border-width: 0px;
}
.btn-cancle:hover, .btn-cancle:focus{
 color: #fff; 
}
</style>
</head>
<style type="text/css">
.what {
	width: 100%;
	height: 40px;
	position: relative;
	color: #000000;
	margin-left:-5px;
}

.apple {
	width: 120px;
	float: left;
	height: 50px;
	position: relative;
	line-height: 50px;
	text-align: center;
	background: #319BED;
    border: 1px solid rgba(57,207,255,0.30);
    border-radius: 4px;
    font-family: PingFangSC-Regular;
	font-size: 14px;
	color: #FFFFFF;
	letter-spacing: 1.75px;
	padding-left: 15px;
	margin-left:20px;
}

.why {
	margin-top: 20px;
	position: relative;
	width: 100%;
	height: 350px;
	color: #000000;
	margin-left:5px;
}

.pen {
	height: 70px;
	float: left;
	width: 400px;
	margin: 10px;
	margin-top: 10px;
	line-height: 70px;
	text-align: center;
	height: 70px;
	line-height: 70px;
	color:#FFFFFF;
	background: rgba(54,148,255,0.70);
	border: 1px solid rgba(39,193,243,0.30);
	border-radius: 4px;
	font-family: PingFangSC-Regular;
	font-size: 20px;
	letter-spacing: 2.5px;
}

.checkbox {
	position: relative;
	float: right;
	top: -5px;
}
</style>
<body>
	<div style="width:100%;padding-top:20px;">
		<div class="what" id="commonList">
			<div class="apple" id="70">
				固定车新增
			<input  type="checkbox" id="70c" class="checkbox"
					checked="checked" />
			
			</div>
			<div class="apple" id="80">
				车位利用率<input class="checkbox" type="checkbox" id="80c"
					checked="checked">
			</div>
			<div class="apple" id="81">
				场内滞留车<input class="checkbox" type="checkbox" id="81c"
					checked="checked">
			</div>
			<div class="apple" id="71">
				非法开闸<input class="checkbox" type="checkbox" id="71c"
					checked="checked">
			</div>
			<div class="apple" id="72">
				固定车收费<input class="checkbox" type="checkbox" id="72c"
					checked="checked">
			</div>
			<div class="apple" id="73">
				临时车收费<input class="checkbox" type="checkbox" id="73c"
					checked="checked">
			</div>
		</div>
		<div class="why" id="reportList">
			<div class="pen" id="75">
				设备在线状态<input class="checkbox" type="checkbox" id="75c"
					checked="checked">
			</div>
			<div class="pen" id="91_92">
				出入统计<input class="checkbox" type="checkbox" id="91_92c"
					checked="checked">
			</div>
			<div class="pen" id="86_87_88_89">
				车辆出入流量趋势<input class="checkbox" type="checkbox"
					id="86_87_88_89c" checked="checked">
			</div>
			<div class="pen" id="93">
				车辆出入方式<input class="checkbox" type="checkbox" id="93c"
					checked="checked">
			</div>
			<div class="pen" id="82_83_84_85">
				人行出入流量趋势<input class="checkbox" type="checkbox" id="82_83_84_85c"
					checked="checked">
			</div>
			<div class="pen" id="90">
				门禁出入方式<input class="checkbox" type="checkbox" id="90c"
					checked="checked">
			</div>
			<div class="pen" id="74">
				商家优惠时长<input class="checkbox" type="checkbox" id="74c"
					checked="checked">
			</div>
		</div>
		<button  type="button" style="display:none;" id="confirmSave" class="btn btn-default btn-common" style = "position:absolute;left:820px ;background-color:#3BBCE6;color:#FFFFFF">保存</button>
	</div>
	<div id="tip-div"></div>
</body>
<script type="text/javascript">
	var dataList=[];
	var operatorId = <shiro:principal property="id"/>;
	
	jQuery(function() {
		init();
	})

	
	function tdragInit(){
		$(".apple").Tdrag({
			scope : '.what',
			pos : true,
			dragChange : true
		});

		$(".pen").Tdrag({
			scope : '.why',
			pos : true,
			dragChange : true
		});
	}
	function getInfo() {
		$(".what").children(".apple").each(function() {
			var sort =  $(this).attr("index");
			var moduleCode = $(this).attr("id");
			var isShow=1;
			if(!$(this).children(".checkbox").is(':checked')){
				isShow=0;
			}
			var data={"operatorId":operatorId,"sort":sort,"isShow":isShow,"moduleCode":moduleCode,"type":"top","isDefault":1};
			dataList.push(data);
		});
		$(".why").children(".pen").each(function() {
			var sort =  $(this).attr("index");
			var moduleCode = $(this).attr("id");
			var isShow=1;
			if(!$(this).children(".checkbox").is(':checked')){
				isShow=0;
			}
			var data={"operatorId":operatorId,"sort":sort,"isShow":isShow,"moduleCode":moduleCode,"type":"main","isDefault":1};
			dataList.push(data);
		});
		
	}
	$('#confirmSave').on('click', function() {
		saveCustom();
	});
	function saveCustom(){
		getInfo();
		$.ajax({
			url:"${ctx}/projectPage/updateMyHomepage", 
			type:"post",
			dataType:"json",
			data:JSON.stringify(dataList),
			contentType:"application/json;charset=utf-8",
			success:function(data){
				if(data && data.CODE && data.CODE =="SUCCESS"){
					$("#homepage-edit-modal").modal("hide");
					initModuleCustom();
				}
			},
			error:function(req, error, errObj) {
			}
		})
	}
	
	function init(){
		$.ajax({
			url:"${ctx}/projectPage/queryModuleCustom?operatorId="+operatorId,
			type:"post",
			dataType:"json",
			success:function(data){
				if(data && data.CODE && data.CODE =="SUCCESS"){
					var list = data.RETURN_PARAM;
					var divHead = new StringBulider();
					var divBody = new StringBulider();
					$.each(list,function(i,item){
						if(item.type=='top'){
							if(item.isShow==0){
								$("#"+item.moduleCode+"c").attr("checked",false);
							}
							divHead.append($("#"+item.moduleCode).prop("outerHTML"));
						}else if(item.type=='main'){
							if(item.isShow==0){
								$("#"+item.moduleCode+"c").attr("checked",false);
							}
							divBody.append($("#"+item.moduleCode).prop("outerHTML"));
						}
					})
					$("#commonList").html(divHead.toString());
					$("#reportList").html(divBody.toString());
					tdragInit();
				}
			},
			error:function(req, error, errObj) {
			}
			
			
		})
		
	}
	
</script>
</html>