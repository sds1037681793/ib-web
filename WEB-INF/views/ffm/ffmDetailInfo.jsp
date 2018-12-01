<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消防事件概况</title>
<style>
.event_detail_info {
	width: 1620px;
	position: relative;
	margin-left: 10px;
	margin-top: 10px;
}

.detail_item {
	width: 100%;
	background: #FFFFFF;
	border: 1px solid #E1E1E1;
	padding: 20px 0px 0px 30px;
}

.item_info_name {
	height: 25px;
	font-size: 18px;
	color: #363A3D;
	line-height: 25px;
}

.item_block {
	width: 280px;
	height: 140px;
	float: left;
	margin-top: 20px;
	border-radius: 4px;
}

.green {
	background: #00BFA5;
}

.sky_blue {
	background: #26C6DA;
}

.deep_blue {
	background: #4DA1FF;
}

.red {
	background: #F37B7B;
}

.yellow {
	background: #FFC107;
}

.item_value {
	font-size: 60px;
	color: #FFFFFF;
	height: 84px;
	line-height: 84px;
	margin-top: 8px;
	width: 100%;
	text-align: center;
}

.item_name {
	font-size: 18px;
	color: #FFFFFF;
	width: 100%;
	text-align: center;
	height: 25px;
	line-height: 25px;
	margin-top: 4px;
}
</style>
</head>
<body>
	<div class="event_detail_info">
		<div class="detail_item" style="height: 230px;">
			<div class="item_info_name">消防报警系统事件</div>
			<div class="item_block sky_blue">
				<div class="item_value" id="alarmMasterOffline">0</div>
				<div class="item_name">报警系统主机离线总数</div>
			</div>
			<div class="item_block deep_blue" style="margin-left: 40px;">
				<div class="item_value" id="fires">0</div>
				<div class="item_name">实时火警总数</div>
			</div>
			<div class="item_block green" style="margin-left: 40px;">
				<div class="item_value" id="fireAbnormal">0</div>
				<div class="item_name">实时故障总数</div>
			</div>
			<div class="item_block red" style="margin-left: 40px;">
				<div class="item_value" id="feedbacks">0</div>
				<div class="item_name">实时回答总数</div>
			</div>
			<div class="item_block yellow" style="margin-left: 40px;">
				<div
					style="font-size: 36px; color: #FFFFFF; margin-top: 12px; height: 50px; width: 100%; line-height: 50px; text-align: center;">
					<span id="fires_day">--</span><span style="font-size: 14px;">天</span>
				</div>
				<div
					style="font-size: 24px; color: #FFFFFF; height: 33px; width: 100%; line-height: 33px; text-align: center;"
					id="fires_time">
					<span id="fires_hour">--</span><span style="font-size: 14px;">小时</span>
					<span id="fires_minute">--</span><span style="font-size: 14px;">分钟</span>
					<span id="fires_second">--</span><span style="font-size: 14px;">秒</span>
				</div>
				<div class="item_name">火警未处理最长时长</div>
			</div>
		</div>

		<div class="detail_item" style="height: 230px; margin-top: 20px;">
			<div class="item_info_name">消防水系统事件</div>
			<div class="item_block sky_blue">
				<div class="item_value" id="waterMasterOffline">0</div>
				<div class="item_name">水系统主机离线总数</div>
			</div>
			<div class="item_block green" style="margin-left: 40px;">
				<div class="item_value" id="waterOffline">0</div>
				<div class="item_name">水系统测点离线总数</div>
			</div>
			<div class="item_block deep_blue" style="margin-left: 40px;">
				<div class="item_value" id="waterAlarm">0</div>
				<div class="item_name">水系统测点报警总数</div>
			</div>
		</div>

		<div class="detail_item" style="height: 460px; margin-top: 20px;">
			<div class="item_info_name" style="margin-top: -5px;">消防维保事件</div>
			<div style="width: 750px; height: 400px; float: left;"
				id="maintenance_pie"></div>
			<div style="width: 810px; height: 400px; float: left;"
				id="maintenance_bar"></div>
		</div>
	</div>

	<script type="text/javascript">
		var firesSummaryMaxTime;
		var flushSummaryFiresTime;
		var barChart;

		$(document).ready(function() {
			getFfmIncidentsSummaryData();
			toFireSummarySubscribe();
			getMaintenanceData(130, "maintenance_pie");
			getFireMaintenancedVO();
		})

		function getFfmIncidentsSummaryData() {
			$.ajax({
				type : "post",
				url : "${ctx}/fire-fighting/fireFightingManage/getFfmIncidentsSummaryData?projectCode=" + projectCode,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data.code == 0 && data.data) {
						var fireMaintenancedVO = data.data;
						setFiresSummaryValue(fireMaintenancedVO);
					}
				},
				error : function(req, error, errObj) {
				}
			});
		}

		function setFiresSummaryValue(fireMaintenancedVO) {
			$("#alarmMasterOffline").html(fireMaintenancedVO.alarmMasterOffline);
			$("#waterMasterOffline").html(fireMaintenancedVO.waterMasterOffline);
			$("#fires").html(fireMaintenancedVO.fires);
			$("#fireAbnormal").html(fireMaintenancedVO.fireAbnormal);
			$("#feedbacks").html(fireMaintenancedVO.feedbacks);
			$("#waterOffline").html(fireMaintenancedVO.waterOffline);
			$("#waterAlarm").html(fireMaintenancedVO.waterAlarm);
			firesSummaryMaxTime = fireMaintenancedVO.firesMaxTime;
			if (firesSummaryMaxTime > 0) {
				if (typeof (flushSummaryFiresTime) != "undefined") {
					// 防止多次加载产生多个定时任务
					clearTimeout(flushSummaryFiresTime);
				}
				flushSummaryFiresTime = setTimeout("SummaryTimeChange()", 1000);
			} else {
				$("#fires_day").html("--");
				$("#fires_hour").html("--");
				$("#fires_minute").html("--");
				$("#fires_second").html("--");
			}

		}

		// 消防最长时间变化
		function SummaryTimeChange() {
			if (typeof (flushSummaryFiresTime) != "undefined" && 'undefined' != typeof ($("#fires_time").val())) {
				firesSummaryMaxTime = firesSummaryMaxTime + 1000;
				var days = parseInt(firesSummaryMaxTime / (1000 * 60 * 60 * 24));
				var hours = parseInt((firesSummaryMaxTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
				var minutes = parseInt((firesSummaryMaxTime % (1000 * 60 * 60)) / (1000 * 60));
				var seconds = (firesSummaryMaxTime % (1000 * 60)) / 1000;
				$("#fires_day").html(days);
				$("#fires_hour").html(hours);
				$("#fires_minute").html(minutes);
				$("#fires_second").html(parseInt(seconds));
				flushSummaryFiresTime = setTimeout("SummaryTimeChange()", 1000);
			}
		}

		//订阅定制
		function toFireSummarySubscribe() {
			if (isConnectedGateWay) {
				stompClient.subscribe('/topic/ffmIncidentsSummaryData/' + projectCode, function(result) {
					var json = JSON.parse(result.body);
					console.log(json);
					setFiresSummaryValue(json);
					getMaintenanceData(130, "maintenance_pie");
					getFireMaintenancedVO();
				});
			}
		}

		function unloadAndRelease() {
			if (stompClient != null) {
				stompClient.unsubscribe('/topic/ffmIncidentsSummaryData/' + projectCode);
			}
		}

		function getFireMaintenancedVO() {
			$.ajax({
				type : "post",
				url : "${ctx}/fire-fighting/fireFightingManage/getFireMaintenancedVO?projectCode=" + projectCode,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data.code == 0 && data.data) {
						var fireMaintenancedVO = data.data;
						initBarChart(fireMaintenancedVO);
					}
				},
				error : function(req, error, errObj) {
				}
			});
		}

		function initBarChart(fireMaintenancedVO) {
			barChart = echarts.init(document.getElementById('maintenance_bar'));

			option = {
				title : {
					text : "维保计划完成率",
					left : "40%",
					top : 10,
					textStyle:{
						color:"#666666",
						fontSize :"12px"
					}
				},
				grid : {
					width : "750",
					height : "330",
					left : 50,
					top : 40
				},
				xAxis : {
					axisTick : {
						show : false
					},
					type : 'category',
					max : 11,
					data : fireMaintenancedVO.monthNames
				},
				yAxis : {
					splitLine : {
						show : false
					},
					name : "点位"
				},
				series : [
						{
							type : 'bar',
							itemStyle : {
								normal : {
									color : '#FFC107',
									opacity : 0.8
								}
							},
							label : {
								normal : {
									show : true,
									position : 'top'
								}
							},
							barWidth : 40,
							barGap : '-100%',
							barCategoryGap : 24,
							data : fireMaintenancedVO.maintenancedPlans
						}, {
							type : 'bar',
							barWidth : 40,
							itemStyle : {
								normal : {
									color : "#00BFA5",
									opacity : 0.8
								}
							},
							label : {
								normal : {
									show : true,
									position : 'top'
								}
							},
							data : fireMaintenancedVO.maintenanceds
						}
				]
			};
			barChart.setOption(option, true);
		}

		function getMaintenanceData(id, divId) {
			$.ajax({
				type : "post",
				url : ctx + "/report/" + id + "?projectCode=" + projectCode,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					var obj = echarts.init(document.getElementById(divId));
					obj.setOption($.parseJSON(data));
				},
				error : function(req, error, errObj) {
				}
			});
		}
	</script>

</body>
</html>