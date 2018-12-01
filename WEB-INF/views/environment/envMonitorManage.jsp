<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>环境监测系统</title>
<style>
.envhead {
	background: #FFFFFF;
	border: 1px solid #E1E1E1;
	width: 1620px;
	height: 238px;
}

.envTitle {
	font-family: PingFangSC-Regular;
	font-size: 14px;
	color: #666666;
}

.envFontItem {
	font-family: PingFangSC-Medium;
	font-size: 36px;
	color: #C1C1C1;
	width: 55px;
}

.envContent {
	margin-top: 20px;
	background: #FFFFFF;
	border: 1px solid #E1E1E1;
	width: 1620px;
	height: 685px;
	padding: 20px;
	background: #FFFFFF;
}

.nowFont {
	font-family: PingFangSC-Regular;
	font-size: 30px;
	color: #4DA1FF;
	width: 100%;
	height: 42px;
	line-height: 42px;
}

.mFont {
	font-family: PingFangSC-Regular;
	font-size: 30px;
	color: #666666;
	width: 100%;
	height: 42px;
	line-height: 42px;
}

.itemFont {
	font-family: PingFangSC-Regular;
	font-size: 12px;
	color: #999999;
	width: 100%;
	height: 17px;
}

.envDataTd1 {
	width: 110px;
}

.envDataTd2 {
	width: 110px;
}

.envItemTd {
	width: 110px;
}

.snapShotDiv {
	width: 217px;
	height: 122px;
	margin-right: 10.2px;
	float:left;
}
.snapImg{
width: 217px;
	height: 122px;
}

.statistics_style{
	width:50%;
	height:480px;
	float:left;
}

.div_style_word{
	margin-left:5px;
	margin-top:2px;
	width:192px;
	height:22px;
	font-size: 14px;
	color: #666666;
	float:left;
}

.div_style_drop_down{
	margin-left:380px;
	margin-top:-4px;
	width:192px;
	height:22px;
	font-size: 16px;
	color: #444444;
	float:left;
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
}
.color-outdoor{
	background: #5BCE3E;
}

.color-indoor{
	background: #5BCE3E;
}
</style>
</head>
<body>
	<div style="">
		<div class="envhead" id="envSign">
			<div style="margin-top: 20px; margin-left: 20px;">
				<span class="envTitle">今日环境数据</span>
			</div>
			<div
				style="width: 50%; margin-top: 20px; padding-left: 128px; float: left;">
				<table style="height: 150px;" class="envDataTable">
					<tr>
						<td rowspan="3" class="envFontItem">CO₂</td>
						<td align="center" class="envItemTd"><img
							src="${ctx}/static/img/env/outdoor.svg"><span
							class="envTitle"
							style="margin-left: 10px; vertical-align: bottom;">室外</span></td>
						<td align="center" class="envDataTd1">
							<div class="nowFont" id="co2NowOutDoor">--</div>
							<div class="itemFont">实时</div>
						</td>
						<td align="center" class="envDataTd1">
							<div class="mFont" id="co2MaxOutDoor">--</div>
							<div class="itemFont">最高</div>
						</td>
						<td align="center" class="envDataTd1">
							<div class="mFont" id="co2MinOutDoor">--</div>
							<div class="itemFont">最低</div>
						</td>
					</tr>
					<tr>
						<td style="height: 15px;"></td>
					</tr>
					<tr>
						<td align="center" class="envItemTd"><img
							src="${ctx}/static/img/env/indoor.svg"><span
							class="envTitle"
							style="margin-left: 10px; vertical-align: bottom;">室内</span></td>
						<td align="center" class="envDataTd2">
							<div class="nowFont" id="co2NowInDoor">--</div>
							<div class="itemFont">实时</div>
						</td>
						<td align="center" class="envDataTd2">
							<div class="mFont" id="co2MaxInDoor">--</div>
							<div class="itemFont">最高</div>
						</td>
						<td align="center" class="envDataTd2">
							<div class="mFont" id="co2MinInDoor">--</div>
							<div class="itemFont">最低</div>
						</td>
					</tr>

				</table>

			</div>

			<div
				style="width: 50%; margin-top: 20px; padding-left: 128px; float: left;">
				<table style="height: 150px;" class="envDataTable">
					<tr>
						<td rowspan="3" class="envFontItem">PM2.5</td>
						<td align="center" class="envItemTd">
							<div style="margin-top: 6px;"><img src="${ctx}/static/img/env/outdoor.svg"><span class="envTitle"
							style="margin-left: 10px; vertical-align: bottom;">室外</span></div>
							<div id="outdoor_div" class="air_pollution_div color-outdoor">--</div>
							</td>
						<td align="center" class="envDataTd1">
							<div class="nowFont" id="pm25NowOutDoor">--</div>
							<div class="itemFont">实时</div>
						</td>
						<td align="center" class="envDataTd1">
							<div class="mFont" id="pm25MaxOutDoor">--</div>
							<div class="itemFont">最高</div>
						</td>
						<td align="center" class="envDataTd1">
							<div class="mFont" id="pm25MinOutDoor">--</div>
							<div class="itemFont">最低</div>
						</td>
					</tr>
					<tr>
						<td style="height: 15px;"></td>
					</tr>
					<tr>
						<td align="center" class="envItemTd"><div style="margin-top: 6px;"><img
							src="${ctx}/static/img/env/indoor.svg"><span
							class="envTitle"
							style="margin-left: 10px; vertical-align: bottom;">室内</span></div>
							<div id="indoor_div" class="air_pollution_div color-indoor">--</div></td>
						<td align="center" class="envDataTd2">
							<div class="nowFont" id="pm25NowInDoor">--</div>
							<div class="itemFont">实时</div>
						</td>
						<td align="center" class="envDataTd2">
							<div class="mFont" id="pm25MaxInDoor">--</div>
							<div class="itemFont">最高</div>
						</td>
						<td align="center" class="envDataTd2">
							<div class="mFont" id="pm25MinInDoor">--</div>
							<div class="itemFont">最低</div>
						</td>
					</tr>

				</table>

			</div>
		</div>
		<div class="envContent">
		<div class="statistics_style">
		<div class="div_style_word">CO2统计</div>
		<div class="div_style_drop_down" id="co-dropdownlist"></div>
		<!-- 此处为报表 --> 
		<div style="width: 100%; height: 480px; float: left;" id="co2Div"></div></div>
		
		<div class="statistics_style">
		<div class="div_style_word">PM2.5统计</div>
		<div class="div_style_drop_down" id="pm-dropdownlist"></div>
		<!-- 此处为报表 -->
			<div style="width: 100%; height: 480px; float: left;"  id="pm25Div"></div></div>

			<div style="width: 100%; height: 150px; float: left;">
				<div style="height: 30px; width: 100%;" class="envTitle">室外实景图</div>
				<div style="width: 1600px; hegith: 122px;" id="snapShotList">

				</div>

			</div>

		</div>
	</div>


	<script type="text/javascript">
		var flushData;
		var g_gatewayAddr;
		var ctx = '${ctx}';
		var coList;
		var pmList;
		$(document).ready(function() {
			toSubscribe();
			getEnvMonitorData();
			getData(140, "co2Div");
			getData(142, "pm25Div");
			if (typeof (flushData) != "undefined") {
				//防止多次加载产生多个定时任务
				clearTimeout(flushData);
			}
			flushData = setTimeout("flushEnvNowData()", 60000);
			
			coList = $("#co-dropdownlist").dropDownList({
 				inputName: "coName",
 				inputValName: "co",
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
			coList.setData("最近24小时", "1", "");
 			
 			pmList = $("#pm-dropdownlist").dropDownList({
 				inputName: "pmName",
 				inputValName: "pm",
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
 			pmList.setData("最近24小时", "1", "");

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
								+ projectCode+"&page=ENV_MANAGE_PAGE",
						async : false,
						dataType : "json",
						contentType : "application/json;charset=utf-8",
						success : function(data) {
							if (data && data.CODE && data.CODE == "SUCCESS") {
								var envMonitorVO = data.RETURN_PARAM.envMonitorVO;
								var snapShotList = data.RETURN_PARAM.snapShotImage;
								setEnvMonitorVO(envMonitorVO);
								setEnvMaxMinVO(envMonitorVO);
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
								+ projectCode,
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
									qualityGrade(showValue(envMonitorVO.pm25NowOutDoor),showValue(envMonitorVO.pm25NowInDoor));
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
			qualityGrade(showValue(envMonitorVO.pm25NowOutDoor),showValue(envMonitorVO.pm25NowInDoor)); 
		}
        function qualityGrade(pm25NowOutDoor,pm25NowInDoor){
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
		function setEnvMaxMinVO(envMonitorVO){
			$("#co2MaxOutDoor").html(showValue(envMonitorVO.co2MaxOutDoor));
			$("#co2MinOutDoor").html(showValue(envMonitorVO.co2MinOutDoor));
			$("#co2MaxInDoor").html(showValue(envMonitorVO.co2MaxInDoor));
			$("#co2MinInDoor").html(showValue(envMonitorVO.co2MinInDoor));
			$("#pm25MaxOutDoor").html(showValue(envMonitorVO.pm25MaxOutDoor));
			$("#pm25MinOutDoor").html(showValue(envMonitorVO.pm25MinOutDoor));
			$("#pm25MaxInDoor").html(showValue(envMonitorVO.pm25MaxInDoor));
			$("#pm25MinInDoor").html(showValue(envMonitorVO.pm25MinInDoor));
		}
		function getData(id, divId) {
			$.ajax({
				type : "post",
				url : ctx + "/report/" + id + "?projectCode=" + projectCode,
				async : true,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					var obj = echarts.init(document.getElementById(divId));
					obj.setOption($.parseJSON(data));
				},
				error : function(req, error, errObj) {
				}
			});
		}
		
		function toSubscribe(){
			if (isConnectedGateWay) {
				stompClient.subscribe('/topic/envMonitorPageData/' + projectCode, function(result) {
					var json = JSON.parse(result.body);
					console.log(json);
					setEnvMaxMinVO(json);
				});
			}
		}


		function unloadAndRelease() {
			if(stompClient != null) {
				stompClient.unsubscribe('/topic/envMonitorPageData/' + projectCode);
			}
		}
	</script>
</body>
</html>