<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico"
	rel="shortcut icon">
<link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap-switch/3.3.2/css/bootstrap3/bootstrap-switch.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js"
	type="text/javascript"></script>
<script
	src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/js/echarts/echarts.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-dropdownlist/jquery.dropdownlist.js" type="text/javascript"></script>
<title></title>
<style>
.envhead {
	width: 580px;
	height: 775px;
}

.envTitle {
	font-family: PingFangSC-Regular;
	font-size: 24px;
	color: #C1C1C1;
}

.envRoom{
    font-family: PingFangSC-Regular;
    font-size: 14px;
    color: #666666;
}

.envFontItem {
	font-family: PingFangSC-Medium;
	font-size: 24px;
	width: 55px;
}

.envContent {
	margin-top: 20px;
	width: 606px;
	height: 340px;
}

.nowFont {
	font-family: PingFangSC-Regular;
	font-size: 30px;
    color: #4DA1FF;
	width: 100%;
	height: 20px;
	line-height: 20px;
}

.mFont {
	font-family: PingFangSC-Regular;
	font-size: 24px;
	width: 100%;
	height: 20px;
	line-height: 20px;
}

.itemFont {
	font-family: PingFangSC-Regular;
	font-size: 24px;
	width: 100%;
	height: 17px;
}

.envDataTd1 {
	width: 180px;
}

.envDataTd2 {
	width: 180px;
}

.envItemTd {
	width: 120px;
	padding-right: 24px;
}

.envItemTdPm {
	width: 60px;
}

.snapShotDiv {
	width: 192px;
	height: 108px;
	margin-right:15px;
	margin-top: 14px;
	float:left;
}
.snapImg{
	width: 192px;
	height: 108px;
}

.air_pollution_div{
	font-size: 12px;
	color: #FFFFFF;
	letter-spacing: 0;
	width:54px;
	height:18px;
	border-radius:3px;
	line-height:18px;
	margin-top:10px;
	text-align:center;
	/* padding:0 5px; */
	margin-top: 2px;
}

.color-outdoor{
	background: #B540C1;
}

.color-indoor{
	background: #B540C1;
}

.statistics_style{
	width:100%;
	height:316px;
	float:left;
}

.div_style_word{
	margin-left:40px;
	margin-top:-1px;
	width:192px;
	height:22px;
	font-size: 14px;
	color: #666666;
	float:left;
	position: absolute;
}

.div_style_drop_down{
	margin-left:358px;
	margin-top:-5px;
	width:192px;
	height:22px;
	font-size: 16px;
	color: #444444;
	float:left;
	position: absolute;
}

</style>
</head>
<body >
	<div style="width:1230px;height:770px;color:#888;" >
		<div class="envhead" id="envSign" style="float: left;">
			<div
				style="width: 290px; float: left;margin-top:25px;">
				<table style="height: 100px;" class="envDataTable">
				    <tr>
						<td align="right" class="envItemTd" style="padding-right: 31px;"><span
							class="envTitle"
							style=" vertical-align: bottom;">CO₂</span></td>
					   
					</tr>
					<tr style="height: 36px;">
					     <td align="right" class="envItemTd"><img
							src="${ctx}/static/img/env/outdoor.svg"><span class="envRoom"
							style="margin-left: 10px; vertical-align: bottom;">室外</span></td>
						<td align="left" class="envDataTd1">
							<div class="nowFont" id="co2NowOutDoor">--</div>
						</td>
					</tr>
					
					<tr style="height: 42px;">
					     <td align="right" class="envItemTd"><img
							src="${ctx}/static/img/env/indoor.svg"><span class="envRoom"
							style="margin-left: 10px; vertical-align: bottom;">室内</span></td>
						<td align="left" class="envDataTd2">
							<div class="nowFont" id="co2NowInDoor">--</div>
						</td>
					</tr>
				</table>
			</div>
			<div
				style="width: 290px;float: left;margin-top:25px;">
				<table style="height: 100px;" class="envDataTable">
				<tr>
						<td align="left" class="envItemTdPm"><span
							class="envTitle"
							style=" vertical-align: bottom;">PM2.5</span></td>
					   
					</tr>
					<tr style="height: 36px;">
					     <td align="left" class="envItemTdPm"><img
							src="${ctx}/static/img/env/outdoor.svg"><span class="envRoom"
							style="margin-left: 10px; vertical-align: bottom;">室外</span></td>
						<td align="left" style="width:105px;">
							<div class="nowFont" id="pm25NowOutDoor">--</div>
						</td>
						<td><div id="outdoor_div" class="air_pollution_div color-outdoor">严重污染</div></td>
					</tr>
					<tr style="height: 42px;">
					     <td align="left" class="envItemTdPm"><img
							src="${ctx}/static/img/env/indoor.svg"><span class="envRoom"
							style="margin-left: 10px; vertical-align: bottom;">室内</span></td>
						<td align="left" style="width:105px;">
							<div class="nowFont" id="pm25NowInDoor">--</div>
						</td>
						<td><div id="indoor_div" class="air_pollution_div color-indoor">严重污染</div></td>
					</tr>
				</table>
			</div>
			<!-- 室内外环境数据echarts -->
			<div style="width:560px;height:620px;float: left;margin-top:20px;">
			   <div class="statistics_style">
		         <div class="div_style_word">CO2统计</div>
				      <div style="width: 560px; height: 316px; margin-left:20px; float: left;" id="co2Div"></div>
		           <div class="div_style_drop_down" id="coo-dropdownlist"></div>
				      </div>
			   <div class="statistics_style">
	             <div class="div_style_word">PM2.5统计</div>
				      <div style="width: 560px; height: 316px; margin-left:20px; float: left;"  id="pm25Div"></div>
		           <div class="div_style_drop_down" id="pmm-dropdownlist"></div>
				      </div>
			</div>
		</div>
		<div style="width: 620px; height: 770px; float: left;">
			<!-- 环境视频展示 -->
			<div id="env_video_monitor" style="width: 606px; height: 340px; margin-top:40px;margin-right:30px;border: 1px solid #666;float: left;font-size:40px;text-align:center;line-height:340px;color:rgb(213, 255, 0);">
			</div>
			<!-- 环境抓拍场景图 -->
			<div class="envContent">
				<div style="width: 640px; height: 360px; float: left;">
					<div style="width: 640px; hegith: 360px;" id="snapShotList">
					</div>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		var flushData;
		var ctx = '${ctx}';
		var cooList;
		var pmmList;
		function callbackLoadVideo() {
	  		$.ajax({
				type: "post",
				url: "${ctx}/system/lightDevice/getlightDeviceNum?typeCode=ENV_CAMERA_XIZIGUOJI&dataCode=ENV_CAMERA_DEVICE_ID",
				contentType: "application/json;charset=utf-8",
				success: function(data) {
					if (data != null) {
						showEnvVideoMonitor(data);
					}else{
						$("#env_video_monitor").html("未配置环境抓拍摄像机");
					}
				},
				error: function(req, error, errObj) {
				}
			});
		}
		function showEnvVideoMonitor(deviceId) {
			$("#env_video_iframe")[0].contentWindow.closeVideo();
			$("#env_video_iframe")[0].contentWindow.startPlay(deviceId);
		}
		$(document).ready(function() {
			getEnvMonitorData();
			html='<iframe src="${ctx}/videomonitoring/showVideo?height=340&width=606"'
				+'id="env_video_iframe" name="env_video_iframe" frameborder="0"'
				+'style="width: 606px; height: 340px;"></iframe>';
			$("#env_video_monitor").append(html);
			getData(140, "co2Div");
			getData(142, "pm25Div");
			if (typeof (flushData) != "undefined") {
				//防止多次加载产生多个定时任务
				clearTimeout(flushData);
			}
			flushData = setTimeout("flushEnvNowData()", 60000);
			
			cooList = $("#coo-dropdownlist").dropDownList({
 				inputName: "coNames",
 				inputValName: "cos",
 				buttonText: "",
 				width: "116px",
 				readOnly: false,
 				required: true,
 				maxHeight: 200,
 				onSelect: function(i, data, icon) {
 					if(data == 1){
 						getData(140, "co2Div");
 					}else if(data == 2){
 						getData(116, "co2Div");
 					}else if(data == 3){
 						getData(141, "co2Div");
 					}
 				},
 				items: [{itemText:'最近24小时',itemData:'1'},{itemText:'最近7天',itemData:'2'},{itemText:'最近30天',itemData:'3'}]
 			});
			cooList.setData("最近24小时", "1", "");
			
			pmmList = $("#pmm-dropdownlist").dropDownList({
 				inputName: "pmNames",
 				inputValName: "pms",
 				buttonText: "",
 				width: "116px",
 				readOnly: false,
 				required: true,
 				maxHeight: 200,
 				onSelect: function(i, data, icon) {
 					if(data == 1){
 						getData(142, "pm25Div");
 					}else if(data == 2){
 						getData(115, "pm25Div");
 					}else if(data == 3){
 						getData(143, "pm25Div");
 					}
 				},
 				items: [{itemText:'最近24小时',itemData:'1'},{itemText:'最近7天',itemData:'2'},{itemText:'最近30天',itemData:'3'}]
 			});
 			pmmList.setData("最近24小时", "1", "");
		});

		function flushEnvNowData() {
			if (typeof (flushData) != "undefined"
					&& 'undefined' != typeof ($("#envSign").val())) {
				getEnvNowData();
				flushData = setTimeout("flushEnvNowData()", 60000);
			}
		}

		function getEnvMonitorData() {
			$.ajax({
						type : "post",
						url : "${ctx}/system/envMonitorManage/getAllEnvMonitorData?projectCode="
								+ parent.projectCode+"&page=ENV_DETAIL_PAGE",
						async : false,
						dataType : "json",
						contentType : "application/json;charset=utf-8",
						success : function(data) {
							if (data && data.CODE && data.CODE == "SUCCESS") {
								var envMonitorVO = data.RETURN_PARAM.envMonitorVO;
								var snapShotList = data.RETURN_PARAM.snapShotImage;
								setEnvMonitorVO(envMonitorVO);
								buildSnapShotImage(snapShotList);
							}
						},
						error : function(req, error, errObj) {
						}
					});
		}

		function getEnvNowData() {
			$.ajax({
						type : "post",
						url : "${ctx}/system/envMonitorManage/getEnvNowData?projectCode="
								+ parent.projectCode,
						async : false,
						dataType : "json",
						contentType : "application/json;charset=utf-8",
						success : function(data) {
							if (data && data.CODE && data.CODE == "SUCCESS") {
								var envMonitorVO = data.RETURN_PARAM;
									$("#co2NowOutDoor").html(
											showValue(envMonitorVO.co2NowOutDoor));
									$("#co2NowInDoor").html(
											showValue(envMonitorVO.co2NowInDoor));
									$("#pm25NowOutDoor").html(
											showValue(envMonitorVO.pm25NowOutDoor));
									$("#pm25NowInDoor").html(
											showValue(envMonitorVO.pm25NowInDoor));
									qualityGradeScreen(showValue(envMonitorVO.pm25NowOutDoor),showValue(envMonitorVO.pm25NowInDoor));
							}
						},
						error : function(req, error, errObj) {
						}
					});
		}

		function buildSnapShotImage(snapShotList) {
			if (snapShotList.length > 0) {
				$.each(
								snapShotList,
								function(key, value) {
									var div = '<div class="snapShotDiv"><img class="snapImg" src="'+value+'"></div>';
									$("#snapShotList").append(div);
								})
			}
		}

		
		function showValue(data) {
			if (data != "--") {
				return Number(data).toFixed(1);
			} else {
				return "--";
			}
		}
		function setEnvMonitorVO(envMonitorVO) {
			$("#co2NowOutDoor").html(showValue(envMonitorVO.co2NowOutDoor));
			$("#co2NowInDoor").html(showValue(envMonitorVO.co2NowInDoor));
			$("#pm25NowOutDoor").html(showValue(envMonitorVO.pm25NowOutDoor));
			$("#pm25NowInDoor").html(showValue(envMonitorVO.pm25NowInDoor));
			qualityGradeScreen(showValue(envMonitorVO.pm25NowOutDoor),showValue(envMonitorVO.pm25NowInDoor));
		}
		function getData(id, divId) {
			$.ajax({
				type : "post",
				url : ctx + "/report/" + id + "?projectCode=" + parent.projectCode,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
 					var obj = echarts.init(document.getElementById(divId));
// 					var option = $.parseJSON(data);
// 					option.xAxis[0].axisLabel.textStyle.color="#FFF";
// 					option.yAxis[0].axisLabel.textStyle.color="#FFF";
// 					option.title.textStyle.color="#FFF";
// 					obj.setOption(option);
					obj.setOption($.parseJSON(data));
				},
				error : function(req, error, errObj) {
				}
			});
		}
		
		function qualityGradeScreen(pm25NowOutDoor,pm25NowInDoor){
        	var pm25NowOutDoor = parseInt(pm25NowOutDoor);
        	var pm25NowInDoor = parseInt(pm25NowInDoor);
        	if(0<=pm25NowOutDoor && pm25NowOutDoor<35){
        		$("#outdoor_div").html("优");
        		$(".color-outdoor").css("background","#5BCE3E");
        	}else if(35<=pm25NowOutDoor && pm25NowOutDoor<75){
        		$("#outdoor_div").html("良");
        		$(".color-outdoor").css("background","#00D1FF");
        	}else if(75<=pm25NowOutDoor && pm25NowOutDoor<115){
        		$("#outdoor_div").html("轻度污染");
        		$(".color-outdoor").css("background","#FFD014");
        	}else if(115<=pm25NowOutDoor && pm25NowOutDoor<150){
        		$("#outdoor_div").html("中度污染");
        		$(".color-outdoor").css("background","#FF8827");
        	}else if(150<=pm25NowOutDoor && pm25NowOutDoor<250){
        		$("#outdoor_div").html("重度污染");
        		$(".color-outdoor").css("background","#FC5E5E");
        	}else if(250<=pm25NowOutDoor){
        		$("#outdoor_div").html("严重污染");
        		$(".color-outdoor").css("background","#B540C1");
        	}
        	if(0<=pm25NowInDoor && pm25NowInDoor<35){
        		$("#indoor_div").html("优");
        		$(".color-indoor").css("background","#5BCE3E");
        	}else if(35<=pm25NowInDoor && pm25NowInDoor<75){
        		$("#indoor_div").html("良");
        		$(".color-indoor").css("background","#00D1FF");
        	}else if(75<=pm25NowInDoor && pm25NowInDoor<115){
        		$("#indoor_div").html("轻度污染");
        		$(".color-indoor").css("background","#FFD014");
        	}else if(115<=pm25NowInDoor && pm25NowInDoor<150){
        		$("#indoor_div").html("中度污染");
        		$(".color-indoor").css("background","#FF8827");
        	}else if(150<=pm25NowInDoor && pm25NowInDoor<250){
        		$("#indoor_div").html("重度污染");
        		$(".color-indoor").css("background","#FC5E5E");
        	}else if(250<=pm25NowInDoor){
        		$("#indoor_div").html("严重污染");
        		$(".color-indoor").css("background","#B540C1");
        	}
        }
	</script>
</body>
</html>