<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta http-equiv="Cache-Control" content="no-store" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="${ctx}/static/css/operate-system.css" type="text/css" rel="stylesheet" />
    <link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
    <link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/styles/iconic.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/bootstrap/buttons.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery-ztree/3.5.17/css/zTreeStyle.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery-datetimepicker/2.1.9/css/jquery.datetimepicker.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/bootstrap-switch/3.3.2/css/bootstrap3/bootstrap-switch.min.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/accordion-menu/css/accordion-menu.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/styles/accordion-1-menu.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/dynamic-table-processor/css/dynamicTableProcessor.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/simple-report/css/simple-report.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery.shutter/css/jquery.shutter.css" type="text/css" rel="stylesheet" />
   	<link href="${ctx}/static/component/dynamic-report-processor/css/photo.css" type="text/css" rel="stylesheet" />
	<link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet" />
	
    <script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-load-resource/js/dynamicLoadResource.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-ztree/3.5.17/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-ztree/3.5.17/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/public.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/HashMap.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/bootstrap-switch/3.3.2/js/bootstrap-switch.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/echarts/echarts.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/busi/hvacHotDataPageMain.js"></script>

<style>

.body {
	height: 299px;
	width: 254px;
	box-shadow: 10px 5px 30px 0 rgba(86, 86, 86, 0.50);
}

.dynamic_water_gif{
    display:none;
}
</style>
</head>
<body class="main_background" style="width: 100%; height: 100%;">
     <div id="coolbox" style="width:1920px;height:1080px;">
     <div class="dynamic_water_gif" style="left:524px;top:527px;position:absolute;transform:rotate(5deg)"><img src="${ctx}/static/img/hvac/redDownward_150.gif"></div>
     <div class="dynamic_water_gif" style="left:734px;top:523px;position:absolute;transform:rotate(2deg)"><img src="${ctx}/static/img/hvac/redDownward_150.gif"></div>
     <div class="dynamic_water_gif" style="left:630px;top:773px;position:absolute;transform:rotate(4deg)"><img src="${ctx}/static/img/hvac/redDownward_150.gif"></div>
     <div class="dynamic_water_gif" style="left:1159px;top:523px;position:absolute;transform:rotate(-4deg)"><img src="${ctx}/static/img/hvac/redDownward_150.gif"></div>
     <div class="dynamic_water_gif" style="left:1368px;top:520px;position:absolute;transform:rotate(-7deg)"><img src="${ctx}/static/img/hvac/redDownward_150.gif"></div>
     <div class="dynamic_water_gif" style="left:828px;top:373px;position:absolute;transform:rotate(1deg)"><img src="${ctx}/static/img/hvac/greenUpward_340.gif"></div>
     <div class="dynamic_water_gif" style="left:914px;top:249px;position:absolute;"><img src="${ctx}/static/img/hvac/greenUpward_80.gif"></div>
     <div class="dynamic_water_gif" style="left:381px;top:371px;position:absolute;transform:rotate(7deg)"><img src="${ctx}/static/img/hvac/greenUpward_340.gif"></div>
     <div class="dynamic_water_gif" style="left:1401px;top:367px;position:absolute;transform:rotate(-7deg)"><img src="${ctx}/static/img/hvac/greenUpward_340.gif"></div>
     <div class="dynamic_water_gif" style="left:391px;top:744px;position:absolute;"><img src="${ctx}/static/img/hvac/greenToTheLeft_400.gif"></div>
     <div class="dynamic_water_gif" style="left:890px;top:742px;position:absolute;"><img src="${ctx}/static/img/hvac/greenToTheRight_500.gif"></div>
     <div class="dynamic_water_gif" style="left:856px;top:910px;position:absolute;"><img src="${ctx}/static/img/hvac/greenToTheLeft_260.gif"></div>
     <div class="dynamic_water_gif" style="left:449px;top:346px;position:absolute;"><img src="${ctx}/static/img/hvac/greenToTheRight_350.gif"></div>
     <div class="dynamic_water_gif" style="left:965px;top:343px;position:absolute;"><img src="${ctx}/static/img/hvac/greenToTheLeft_360.gif"></div>
	</div>  
	<div
		style="width: 360px; left: 1530px; top: 30px; position: absolute; z-index: 2;">
		
		<div style="width: 360px; height: 48px; margin-top: 30px;"
			class="boder">
			<div class="head">
				<div id="head_fonts" class="head_font">B1层今日实时数据</div>
				
			</div>
		</div>

		<div style="width: 360px; height: 250px; margin-top: 20px;"
			class="boder">
			<div class="head">
				<div class="head_font">集水器水温趋势</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
				</div>
			</div>
			<div id="warmManifoldTemp" class="detailCotent" style="width: 360px; height: 200px;margin-top: 15px;"></div>
		</div>

		

		<div style="width: 360px; height: 250px; margin-top: 20px;"
			class="boder">
			<div class="head">
				<div class="head_font">分水器水温趋势</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
				</div>
			</div>
			<div id="warmWaterSeparatorTemp" class="detailCotent" style="width: 360px; height: 200px;margin-top: 15px;"></div>
		</div>
	</div>
	<div id ="device-detail"></div>

<script type="text/javascript">
var manifold = "${ctx}/static/img/hvac/manifolds.gif";
var manifoldClose = "${ctx}/static/img/hvac/manifold.svg";
var hotWaterLoopPump = "${ctx}/static/img/hvac/hot_water_loop_pumps.gif";
var hotWaterLoopPumpClose = "${ctx}/static/img/hvac/hot_water_loop_pump.svg";
var boiler =  "${ctx}/static/img/hvac/boilers.gif";
var boilerClose = "${ctx}/static/img/hvac/boiler.svg";
var refrigeratingPumpBgColor = "#00BFA5";
var refrigeratingPumpBgCloseColor = "#B4B4B4";
var waterSepDeviceId;
var oneRefrigeratorDeviceId;
var twoRefrigeratorDeviceId;
var threeRefrigeratorDeviceId;
var fourRefrigeratorDeviceId;
var isConnectedGateWay=false;
var beginTime;
var endTime;
var openStatusPumpNum = 0;
var boilerNum = 1;
var boilerMap = new HashMap();
var projectCode = "${param.projectCode}";
var projectId = "${param.projectId}";
var orgId = $("#login-org").data("orgId");
	$(document).ready(function() {
		beginTime = getDateStr(0);
		endTime = getDateStr(1);
		toSubscribe();
		  $.ajax({
		        type : "post",
		        url : "${ctx}/device/manage/getDeviceRelate?projectId="+projectId+"&pictureName=锅炉房",
		        dataType : "json",
		        async: false,
		        contentType : "application/json;charset=utf-8",
		        success : function(data) {
		        if(data!=null){
		        	buildDiv(data.data);
		        }
		        	
		        },
		        error : function(req,error, errObj) {
		            return;
		            }
		        });	
		  $.ajax({
		        type : "post",
		        url : "${ctx}/hvac/hvacRunningData/getPageData?projectCode="+projectCode+"&code=WARM_SOURCE",
		        dataType : "json",
		        contentType : "application/json;charset=utf-8",
		        async: false,
		        success : function(data) {
		        	buildRunDiv(data);
		        },
		        error : function(req,error, errObj) {
		            return;
		            }
		        });
		  getData(125, "warmManifoldTemp");
		  getData(126, "warmWaterSeparatorTemp");
		  $(".img_div").mouseover(function(){
			  $(this).next().show();
			});
		  $(".img_div").mouseout(function(){
			  $(this).next().hide();
			});
	});

	function buildDiv(data){
		$("#coolbox").css("background-image",'url('+data[0].filePath+')');
		$.each(data,function(i,val){
			if(val.catagory==='BOILER'){
				boilerMap.put(boilerNum,val.deviceId);
				boilerNum += 1;
				var div ='<div style="left: '+val.xCoordinate+'px; top:'+val.yCoordinate+'px;width:200px;height:30px; position: absolute;" onclick="deviceDetail('+val.deviceId+')">'+
				'<div id=ref'+val.deviceId+' class = "img_div" style=" background-color:'+refrigeratingPumpBgCloseColor+';box-shadow:0px 0px 4px #818181;width:60px;height:60px;float:left; line-height: 30px;text-align:left;padding-left:0px; " '+
				' ><img style="width: 39px; height: 63px;margin-left:10px;" src ='+boilerClose+' /></div><div style=" display:none; background-color:rgba(231, 234, 236,0.8);box-shadow:0px 0px 4px #818181;width:88px;height:60px;float:left;text-align:center;line-height: 66px;font-size: 15px;font-family: PingFangSC-Regular;""><font>'+val.deviceName+'</font></div>'
				+'</div>';
				$("#coolbox").append(div);
				$("#ref"+val.deviceId).data("deviceId", val.deviceId);
				$("#ref"+val.deviceId).data("deviceName", val.deviceName);
				$("#ref"+val.deviceId).data("catagory", val.catagory);
				$("#ref"+val.deviceId).data("deviceNumber", val.deviceNumber);
			}
			if(val.catagory==='HOT_WATER_LOOP_PUMP'){
				var div ='<div style="left: '+val.xCoordinate+'px; top:'+val.yCoordinate+'px;width:200px;height:30px; position: absolute;"onclick="deviceDetail('+val.deviceId+')">'+
				'<div id=pump'+val.deviceId+'  class = "img_div" style="background-color:'+refrigeratingPumpBgCloseColor+';box-shadow:0px 0px 4px #818181;width:60px;height:60px;float:left; line-height: 30px;text-align:left;padding-left:0px; '+
				'"><img style="width: 39px; height: 59px;margin-left:10px;" src ='+hotWaterLoopPumpClose+' /></div><div style=" display:none; background-color:rgba(231, 234, 236,0.8);box-shadow:0px 0px 4px #818181;width:200px;height:60px;text-align:center;line-height: 66px;font-size: 15px;font-family: PingFangSC-Regular;"'+
				'"><p style="line-height: 42px;">'+val.deviceName+'</p><p style="margin-top: -40px;" id=temp'+val.deviceId+'>- -°C</p></div>'
				+'</div>';
				$("#coolbox").append(div);
				 $("#pump"+val.deviceId).data("deviceId", val.deviceId);
				 $("#pump"+val.deviceId).data("deviceName", val.deviceName);
				 $("#pump"+val.deviceId).data("catagory", val.catagory);
				 $("#pump"+val.deviceId).data("deviceNumber", val.deviceNumber);
				 /* $("#pump"+val.deviceId).css("background-color","#00BFA5"); */
				 if(oneRefrigeratorDeviceId == null && twoRefrigeratorDeviceId == null && threeRefrigeratorDeviceId == null
						&& fourRefrigeratorDeviceId == null){
				     oneRefrigeratorDeviceId = val.deviceId;
				 }else if(oneRefrigeratorDeviceId != null && twoRefrigeratorDeviceId == null && threeRefrigeratorDeviceId == null
						 && fourRefrigeratorDeviceId == null){
				     twoRefrigeratorDeviceId = val.deviceId;
				 }else if(oneRefrigeratorDeviceId != null && twoRefrigeratorDeviceId != null && threeRefrigeratorDeviceId == null
						 && fourRefrigeratorDeviceId == null){
					 threeRefrigeratorDeviceId = val.deviceId; 
				 }else if(oneRefrigeratorDeviceId != null && twoRefrigeratorDeviceId != null && threeRefrigeratorDeviceId != null
						 && fourRefrigeratorDeviceId == null){
					 fourRefrigeratorDeviceId = val.deviceId; 
				 }
			}
			if(val.catagory==='WARM_MANIFOLD'||val.catagory==='WARM_WATER_SEPARATOR'){
				var div2 ='<div style="left: '+val.xCoordinate+'px; top:'+val.yCoordinate+'px;width:230px;height:30px; position: absolute;"onclick="deviceDetail('+val.deviceId+')">'+
				'<div id = water'+val.deviceId+'  class = "img_div" style="background-color:'+refrigeratingPumpBgCloseColor +';box-shadow:0px 0px 4px #818181;width:60px;height:60px;float:left; line-height: 30px;text-align:left;padding-left:0px;'+
				' "><img style="width: 39px; height: 63px;margin-left:10px;" src ='+manifoldClose+' /></div><div style=" display:none; background-color:rgba(231, 234, 236,0.8);box-shadow:0px 0px 4px #818181;width:270px;height:60px;text-align:center;line-height: 30px;font-size: 15px;font-family: PingFangSC-Regular;"'+
				'"><p style="line-height: 37px;">'+val.deviceName+'</p>&nbsp<p style="margin-top: -48px;"><span id=temp'+val.deviceId+'>- -°C</span>&nbsp<span id=pre'+val.deviceId+' >- -Mpa</span></p></div>'
				+'</div>';
				$("#coolbox").append(div2);
				 $("#water"+val.deviceId).data("deviceId", val.deviceId);
				 waterSepDeviceId = val.deviceId;
				 $("#water"+val.deviceId).data("deviceName", val.deviceName);
				 $("#water"+val.deviceId).data("catagory", val.catagory);
				 $("#water"+val.deviceId).data("deviceNumber", val.deviceNumber);
			}
			
		})
		
	}

	function buildRunDiv(data){
		$.each(data,function(i,val){
			hvacWarmDataDeals(val);
		})
		 for(var i=1;i<openStatusPumpNum+1;i++){
			var deviceId = boilerMap.get(i);
		$("#ref"+deviceId).data("workStatus", 1);
		$("#ref"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/boilers.gif");
		$("#ref"+deviceId).children("img").css("width","60px");
		$("#ref"+deviceId).children("img").css("height","60px");
		$("#ref"+deviceId).children("img").css("margin-left","0px");
		}
		
		if(openStatusPumpNum > 0){
			$(".dynamic_water_gif").css("display","block"); 
		}
	}
	
	function boilerOpenNum(num){
		var deviceId = boilerMap.get(num);
		$("#ref"+deviceId).data("workStatus", 1);
		$("#ref"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/boilers.gif");
		$("#ref"+deviceId).children("img").css("width","60px");
		$("#ref"+deviceId).children("img").css("height","60px");
		$("#ref"+deviceId).children("img").css("margin-left","0px");
	}
	
	function boilerCloseNum(num){
		var deviceId = boilerMap.get(num);
		$("#ref"+deviceId).data("workStatus", 0);
		$("#ref"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/boiler.svg");
		$("#ref"+deviceId).children("img").css("width","39px");
		$("#ref"+deviceId).children("img").css("height","63px");
		$("#ref"+deviceId).children("img").css("margin-left","10px");
	 	$("#ref"+deviceId).css("background-color","#B4B4B4");
	}
	
	function hvacWarmDataDeal(data){
			var deviceId = data.deviceId;
			if(data.deviceType==='HOT_WATER_LOOP_PUMP'){
				if(data.workStatus===0 && $("#pump"+deviceId).data("workStatus") != 0){
					$("#pump"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/hot_water_loop_pumps.gif");
					$("#pump"+deviceId).children("img").css("width","60px");
					$("#pump"+deviceId).children("img").css("height","60px");
					$("#pump"+deviceId).children("img").css("margin-left","0px");
					if(openStatusPumpNum==0){
						boilerOpenNum(1);
						openStatusPumpNum += 1;
						$(".dynamic_water_gif").css("display","block");
					}else if(openStatusPumpNum==1){
						boilerOpenNum(2);
						openStatusPumpNum += 1;
					}else if(openStatusPumpNum==2){
						boilerOpenNum(3);
						openStatusPumpNum += 1;
					}else if(openStatusPumpNum==3){
						openStatusPumpNum += 1;
					}
				}else if(data.workStatus===1 && $("#pump"+deviceId).data("workStatus") != 1){
					 $("#pump"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/hot_water_loop_pump.svg");
					 $("#pump"+deviceId).children("img").css("width","39px");
					 $("#pump"+deviceId).children("img").css("height","59px");
					 $("#pump"+deviceId).children("img").css("margin-left","10px");
				 	 $("#pump"+deviceId).css("background-color","#B4B4B4");
				 	if(openStatusPumpNum==1){
				 		boilerCloseNum(1);
						openStatusPumpNum -= 1;
						$(".dynamic_water_gif").css("display","none");
					}else if(openStatusPumpNum==2){
						boilerCloseNum(2);
						openStatusPumpNum -= 1;
					}else if(openStatusPumpNum==3){
						boilerCloseNum(3);
						openStatusPumpNum -= 1;
					}else if(openStatusPumpNum==4){
						openStatusPumpNum -= 1;
					}
				}
					 $("#temp"+deviceId).attr("color","#FF6E00");
				if(data.faultStatus ===0){
					$("#pump"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/hot_water_loop_pump.svg");
					$("#pump"+deviceId).children("img").css("width","39px");
					 $("#pump"+deviceId).children("img").css("height","59px");
					 $("#pump"+deviceId).children("img").css("margin-left","10px");
					$("#pump"+deviceId).css("background-color","#FA6900");
				}
				 if(data.workStatus!=null){
					 $("#pump"+data.deviceId).data("workStatus", data.workStatus);
				 }
				 if(data.faultStatus!=null){
				 	$("#pump"+data.deviceId).data("faultStatus", data.faultStatus);
				 }
			}
			if(data.deviceType==='WARM_MANIFOLD'||data.deviceType==='WARM_WATER_SEPARATOR'){
					if(data.workStatus===0){
						$("#water"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/manifold.svg");
						$("#water"+deviceId).children("img").css("width","39px");
						$("#water"+deviceId).children("img").css("height","63px");
						$("#water"+deviceId).children("img").css("margin-left","10px");
					    $("#water"+deviceId).css("background-color","#B4B4B4");
					}else if(data.workStatus===1){
						$("#water"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/manifolds.gif");
						$("#water"+deviceId).children("img").css("width","60px");
						$("#water"+deviceId).children("img").css("height","60px");
						$("#water"+deviceId).children("img").css("margin-left","0px");
					}
					
					if(data.faultStatus ===0){
						$("#water"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/manifold.svg");
						$("#water"+deviceId).children("img").css("width","39px");
						$("#water"+deviceId).children("img").css("height","63px");
						$("#water"+deviceId).children("img").css("margin-left","10px");
						$("#water"+deviceId).css("background-color","#FA6900");
					}
					if(data.deviceType==='WARM_MANIFOLD'){
						if(data.temperature!=null){
							$("#temp"+deviceId).css("color","#FF6E00");
							 $("#temp"+deviceId).html(data.temperature+'°C');
						}
					}else{
						if(data.pumpOutTemperature!=null){
							$("#temp"+deviceId).css("color","#FF6E00");
							$("#temp"+oneRefrigeratorDeviceId).css("color","#FF6E00");
							$("#temp"+twoRefrigeratorDeviceId).css("color","#FF6E00");
							$("#temp"+threeRefrigeratorDeviceId).css("color","#FF6E00");
							$("#temp"+fourRefrigeratorDeviceId).css("color","#FF6E00");
							 $("#temp"+deviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
							 $("#temp"+oneRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
							 $("#temp"+twoRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
							 $("#temp"+threeRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
							 $("#temp"+fourRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
						}
					}
					
					if(data.pressure!=null){
						$("#pre"+deviceId).css("color","#FF6E00");
						 $("#pre"+deviceId).html(data.pressure+'Mpa');
					}
					
					if(data.workStatus!=null){
					 	$("#water"+data.deviceId).data("workStatus", data.workStatus);
					}
					if(data.temperature!=null){
					 	$("#water"+data.deviceId).data("temperature", data.temperature);
					}
					if(data.pressure!=null){
					 	$("#water"+data.deviceId).data("pressure", data.pressure);
					}
					if(data.faultStatus!=null){
					 	$("#water"+data.deviceId).data("faultStatus", data.faultStatus);
					}
					if(data.pumpOutTemperature!=null){
					 	$("#water"+data.deviceId).data("pumpOutTemperature", data.pumpOutTemperature);
					}
			}
			
	}
	
	function hvacWarmDataDeals(data){
		var deviceId = data.deviceId;
		if(data.deviceType==='HOT_WATER_LOOP_PUMP'){
			if(data.workStatus===0){
				$("#pump"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/hot_water_loop_pumps.gif");
				$("#pump"+deviceId).children("img").css("width","60px");
				$("#pump"+deviceId).children("img").css("height","60px");
				$("#pump"+deviceId).children("img").css("margin-left","0px");
				openStatusPumpNum += 1;
			}else if(data.workStatus===1){
				 $("#pump"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/hot_water_loop_pump.svg");
				 $("#pump"+deviceId).children("img").css("width","39px");
				 $("#pump"+deviceId).children("img").css("height","59px");
				 $("#pump"+deviceId).children("img").css("margin-left","10px");
			 	 $("#pump"+deviceId).css("background-color","#B4B4B4");
			}
				 $("#temp"+deviceId).attr("color","#FF6E00");
			if(data.faultStatus ===0){
				$("#pump"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/hot_water_loop_pump.svg");
				$("#pump"+deviceId).children("img").css("width","39px");
				 $("#pump"+deviceId).children("img").css("height","59px");
				 $("#pump"+deviceId).children("img").css("margin-left","10px");
				$("#pump"+deviceId).css("background-color","#FA6900");
			}
			 if(data.workStatus!=null){
				 $("#pump"+data.deviceId).data("workStatus", data.workStatus);
			 }
			 if(data.faultStatus!=null){
			 	$("#pump"+data.deviceId).data("faultStatus", data.faultStatus);
			 }
		}
		if(data.deviceType==='BOILER'){
			/* if(data.workStatus===0){
				 $("#ref"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/boiler.svg");
				 $("#ref"+deviceId).children("img").css("width","39px");
				 $("#ref"+deviceId).children("img").css("height","63px");
				 $("#ref"+deviceId).children("img").css("margin-left","10px");
			 	 $("#ref"+deviceId).css("background-color","#B4B4B4");
				}else if(data.workStatus===1){
					$("#ref"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/boilers.gif");
					$("#ref"+deviceId).children("img").css("width","60px");
					$("#ref"+deviceId).children("img").css("height","60px");
					$("#ref"+deviceId).children("img").css("margin-left","0px");
			} */
			if(data.faultStatus ===0){
				$("#ref"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/boiler.svg");
				 $("#ref"+deviceId).children("img").css("width","39px");
				 $("#ref"+deviceId).children("img").css("height","63px");
				 $("#ref"+deviceId).children("img").css("margin-left","10px");
				$("#ref"+deviceId).css("background-color","#FA6900");
			}
			 /* $("#ref"+data.deviceId).data("workStatus", data.workStatus); */
			 $("#ref"+data.deviceId).data("temperature", data.temperature);
			 $("#ref"+data.deviceId).data("faultStatus", data.faultStatus);
		}
		if(data.deviceType==='WARM_MANIFOLD'||data.deviceType==='WARM_WATER_SEPARATOR'){
				if(data.workStatus===0){
					$("#water"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/manifold.svg");
					$("#water"+deviceId).children("img").css("width","39px");
					$("#water"+deviceId).children("img").css("height","63px");
					$("#water"+deviceId).children("img").css("margin-left","10px");
				    $("#water"+deviceId).css("background-color","#B4B4B4");
				}else if(data.workStatus===1){
					$("#water"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/manifolds.gif");
					$("#water"+deviceId).children("img").css("width","60px");
					$("#water"+deviceId).children("img").css("height","60px");
					$("#water"+deviceId).children("img").css("margin-left","0px");
				}
				
				if(data.faultStatus ===0){
					$("#water"+deviceId).children("img").attr("src","${ctx}/static/img/hvac/manifold.svg");
					$("#water"+deviceId).children("img").css("width","39px");
					$("#water"+deviceId).children("img").css("height","63px");
					$("#water"+deviceId).children("img").css("margin-left","10px");
					$("#water"+deviceId).css("background-color","#FA6900");
				}
				if(data.deviceType==='WARM_MANIFOLD'){
					if(data.temperature!=null){
						$("#temp"+deviceId).css("color","#FF6E00");
						 $("#temp"+deviceId).html(data.temperature+'°C');
					}
				}else{
					if(data.pumpOutTemperature!=null){
						$("#temp"+deviceId).css("color","#FF6E00");
						$("#temp"+oneRefrigeratorDeviceId).css("color","#FF6E00");
						$("#temp"+twoRefrigeratorDeviceId).css("color","#FF6E00");
						$("#temp"+threeRefrigeratorDeviceId).css("color","#FF6E00");
						$("#temp"+fourRefrigeratorDeviceId).css("color","#FF6E00");
						 $("#temp"+deviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
						 $("#temp"+oneRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
						 $("#temp"+twoRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
						 $("#temp"+threeRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
						 $("#temp"+fourRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
					}
				}
				
				if(data.pressure!=null){
					$("#pre"+deviceId).css("color","#FF6E00");
					 $("#pre"+deviceId).html(data.pressure+'Mpa');
				}
				
				if(data.workStatus!=null){
				 	$("#water"+data.deviceId).data("workStatus", data.workStatus);
				}
				if(data.temperature!=null){
				 	$("#water"+data.deviceId).data("temperature", data.temperature);
				}
				if(data.pressure!=null){
				 	$("#water"+data.deviceId).data("pressure", data.pressure);
				}
				if(data.faultStatus!=null){
				 	$("#water"+data.deviceId).data("faultStatus", data.faultStatus);
				}
				if(data.pumpOutTemperature!=null){
				 	$("#water"+data.deviceId).data("pumpOutTemperature", data.pumpOutTemperature);
				}
		}
		
}
	
	function deviceDetail(deviceId){
		createModalWithLoad("device-detail", 600, 328, "查看设备状态明细", "hvacRealTimeDataPage/hvacHotDeviceDetailPage?deviceId="+deviceId+"", "", "", "");
		$("#device-detail-modal").modal('show');
	}
	//更新弹窗页面属性值
	function updateModal(data){
		if(data.deviceId == paramDeviceId){
			if(data.deviceType=='BOILER'){
				//锅炉
				$("#workStatus_id").html( data.workStatus==1 ?"开启":"关闭");
			}
			if (data.deviceType === 'HOT_WATER_LOOP_PUMP') {
				//热水循环泵
				$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
				$("#temperature_id").html(data.temperature ==null?'- -'+'°C':data.temperature+'°C');
			}
			if(data.deviceType=='WARM_MANIFOLD'){
				//集水器
				if(data.workStatus!=null){
					$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
				}
				if(data.temperature!=null){
				$("#temperature_id").html(data.temperature+'°C');
				}
				if(data.pressure!=null){
					$("#pressure_id").html(data.pressure+'Mpa');
				}
			}
			if(data.deviceType=='WARM_WATER_SEPARATOR'){
				//分水器
				if(data.workStatus!=null){
					$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
				}
				if(data.pumpOutTemperature!=null){
					$("#temperature_id").html(data.pumpOutTemperature+'°C');
				}
				if(data.pressure!=null){
					$("#pressure_id").html(data.pressure+'Mpa');
				}
			}
		}
		
	}

	  
	  function getData(id,divId) {
			$.ajax({
				type : "post",
				url : "${ctx}/report/" + id +"?beginTime=" + beginTime+ "&endTime=" + endTime+ "&projectCode=" + projectCode,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					var obj = echarts.init(document.getElementById(divId));
					obj.setOption($.parseJSON(data));
					appendDiv("userStatistics", data)
				},
				error : function(req, error, errObj) {
				}
			});
		}
	  
	  function appendDiv(parent, child) {
			$("." + parent).append(child);
		}  
	  
	  function getDateStr(addDayCount) {
	        var dd = new Date();
	        dd.setDate(dd.getDate()+addDayCount);//获取AddDayCount天后的日期
	        var y = dd.getFullYear();
	        var m = dd.getMonth()+1;//获取当前月份的日期
	        if(m.toString().length == 1){
	        	m = '0' + m;
	        };
	        var d = dd.getDate();
	        if(d.toString().length == 1){
	        	d = '0' + d;
	        };
	        return y+"-"+m+"-"+d+" 00:00";
	    }
</script>
</body>
</html>