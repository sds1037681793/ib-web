<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link
	href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css"
	type="text/css" rel="stylesheet" />
<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<script type="text/javascript" src="${ctx}/static/js/waterSystemHisRecord.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/waterSystemRealtime.js"></script>
<style type="text/css">
.content-select {
	background-color: #fff;
	border: 1px solid #e1e1e1;
}

.menu_active {
	font-family: PingFangSC-Light;
	font-size: 18px;
	display: block;
	text-align: center;
	line-height: 30px;
	margin-top: 16px;
	color: #666;
	float: left;
	cursor: pointer;
}

.dropdown-menu {
	font-size: 12px;
	min-width: 142px;
	max-width: 142px;
}

.checked_active {
	font-family: PingFangSC-Light;
	font-size: 18px;
	color: #00BFA5;
	letter-spacing: 0;
}

.statistics_style {
	width: 819px;
	height: 420px;
	float: left;
}

.div_style_one {
	float: left;
	height: 25px;
	width: 20px;
	line-height: 25px;
	text-align: center;
	font-size: 20px;
	margin-left: 20px;
}

.div_style_two {
	float: left;
	height: 30px;
	width: 30px;
	line-height: 30px;
	text-align: center;
	font-size: 20px;
	color:red;
}

.div_style_three {
	float: left;
	height: 30px;
	width: 120px;
	line-height: 30px;
	text-align: center;
	font-size: 20px;
}

.div_style_four {
	float: left;
	height: 60px;
	width: 120px;
	line-height: 60px;
	text-align: center;
	font-size: 16px;
	color: #555;
}

.div_style_five {
	float: left;
	height: 30px;
	width: 60px;
	line-height: 30px;
	text-align: center;
	font-size: 14px;
}

.div_style_six {
	float: left;
	height: 30px;
	line-height: 30px;
	text-align: center;
	font-size: 14px;
}

.div_style_seven {
	float: left;
	height: 20px;
	width: 60px;
	line-height: 20px;
	font-size: 14px;
}


.search {
	display: inline-block;
	padding: 3px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: 400;
	line-height: 1.42857143;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-image: none;
	border: 1px solid transparent;
	border-radius: 4px;
	background-color: rgb(255, 255, 255);
}

.summary_check {
	height: 30px;
	float: left;
	margin-top: 15px;
}

.history_check {
	height: 30px;
	float: left;
	margin-top: 15px;
}
.water_pressure_curve{
	font-family: PingFangSC-Regular;
	font-size: 12px;
	width:60px;
	color: #FFFFFF;
	background: #2DBA6C;
	cursor:pointer;
	height:24px;
	line-height:24px;
	text-align:center;
}
</style>
</head>
<body>
	<div class="content-select" style="min-width: 1620px; height: 900px;">
		<div
			style="width: 100%; height: 62px;  border: 1px solid #E1E1E1;">
			<div id="summary_data" class="menu_active"
				style="margin-left: 710px; width: 72px; height: 25px;"
				onclick="onclickSpan(this)">实时信息</div>
			<div id="history_data" class="menu_active" style="margin-left: 47px;"
				onclick="onclickSpan(this)">历史事件</div>
			<div id="checked"
				style="position: absolute; left: 728px; top: 114px; background: #00BFA5; width: 80px; height: 2px;"></div>
		</div>
		<div id="summary_total" style="width: 100%; height: 60px;">
		<div style="width:80px;height: 30px;float: left;margin-top: 15px;margin-left:20px;font-size: 16px;line-height: 30px;">
				实时概览：
			</div>
			<div id="offline" class="summary_check" style="width: 151px;">
				<div class="div_style_one">
					<img id="offline-img" src="${ctx}/static/img/ffm/Offline.svg">
				</div>
				<div class="div_style_six" style="width: 80px;">测点离线</div>
				<div id="offLineNum" class="div_style_two">10</div>
			</div>
			<div id="shuiya" class="summary_check"
				style="width: 151px;">
				<div class="div_style_one">
					<img id="shuiya-img" src="${ctx}/static/img/ffm/shuiya.svg">
				</div>
				<div class="div_style_six" style="width: 80px;">水压异常</div>
				<div id="waterExcNum" class="div_style_two">10</div>
			</div>
			<div id="diandongfa" class="summary_check"
				style="width: 170px; height: 30px;">
				<div class="div_style_one">
					<img id="diandongfa-img" src="${ctx}/static/img/ffm/diandongfa.svg">
				</div>
				<div class="div_style_six" style="width: 100px;">电动阀异常</div>
				<div id="eleExcNum" class="div_style_two">0</div>
			</div>
			<div
				style="width: 260px; height: 60px; float: left; margin-left: 800px;">
				<div style="float: left; width: 140px;">
					<div class="div_style_four" style="color: #555;	font-size: 14px;width:70px;">王海峰</div>
					<div class="div_style_four" style="color: #999;	font-size: 14px;width:70px;">值班人员</div>
				</div>
				<div class="div_style_four" style="color: #555;font-size:16px;width:120px;">13567190082</div>
			</div>
			<div style="width:1595px;height:1px;margin-left:20px;float:left;background:#D8D8D8;"></div>
		</div>
		<div id="history_total" style="width: 100%; height: 60px;">
		<div style="width:80px;height: 30px;float: left;margin-top: 15px;margin-left:20px;font-size: 16px;line-height: 30px;">
				历史概览：
			</div>
			<div id="weihuifu" class="history_check"
				style="width: 146px;">
				<div class="div_style_one">
					<img id="weihuifu-img"
						src="${ctx}/static/img/ffm/weihuifu.svg">
				</div>
				<div class="div_style_five">未恢复</div>
				<div id= "unRecoveryCount" class="div_style_two">10</div>
			</div>
			<div
				style="width: 260px; height: 60px; float: left; margin-left: 1125px;">
				<div style="float: left; width: 140px;">
					<div class="div_style_four" style="color: #555;	font-size: 14px;width:70px;">王海峰</div>
					<div class="div_style_four" style="color: #999;	font-size: 14px;width:70px;">值班人员</div>
				</div>
				<div class="div_style_four" style="color: #555;font-size:16px;width:120px;">13567190082</div>
			</div>
			<div style="width:1595px;height:1px;margin-left:20px;float:left;background:#D8D8D8;"></div>
		</div>
		<!--实时数据查询条件  -->
		<div id="summary_data_show"
			style="height: 86%; padding-left: 20px; padding-right: 20px;margin-top:15px;">
			<div style="width: 100%;">
				<form id="select-form">
					<table style="width: 1600px;">
						<tr style="height: 40px;" valign='buttom'>
							<td align="right" style="width:80px;">设备类型：</td>
							<td style="width: 170px;"><div id="device-type-dropdownlist"></div></td>
							<td align="right" style="width:100px;">建筑物：</td>
							<td style="width: 170px;"><div id="building-dropdownlist"></div></td>
							<td align="right" style="width:100px;">楼层：</td>
							<td style="width: 170px;"><div id="floor-dropdownlist"></div></td>
							<td align="right" style="width:100px;">具体区域：</td>
							<td style="width: 140px;"><div id="area-dropdownlist"></div></td>
							<td align="right" style="width:120px;">主机号：</td>
							<td><input id="hostNumber" name="hostNumber"
								placeholder="主机号" class="form-control required" type="text"
								style="width: 143px" /></td>
							<td align="right" style="width:80px;">回路号：</td>
							<td><input id="loopNumber" name="loopNumber"
								placeholder="回路号" class="form-control required" type="text"
								style="width: 144px" /></td>
						</tr>
						<tr style="height: 60px;" valign='buttom'>
							<td align="right" >测点号：</td>
							<td><input id="testNumber" name="testNumber"
								placeholder="测点号" class="form-control required" type="text"
								style="width: 144px" /></td>
							<td align="right" >报警状态：</td>
							<td style="width: 170px;"><div
									id="alarm-status-dropdownlist"></div></td>
							<td align="right" >通讯状态：</td>
							<td style="width: 170px;"><div id="com-status-dropdownlist"></div></td>
							<td align="right" style="width: 6rem">开始时间：</td>
							<td><input id="startDate" name="startDate"
								placeholder="开始时间" class="form-control required" type="text"
								style="width: 144px" /></td>
							<td align="right" style="width: 6rem">结束时间：</td>
							<td style="width:200px;"><input id="endDate" name="endDate" placeholder="结束时间"
								class="form-control required" type="text" style="width: 144px" /></td>
							<td style="width: 80px;" colspan="2" align="right">
								<button id="btn-query-summary" type="button" class="search"
									style="width: 60px; height: 30px; color: #00BFA5; outline: 0; border-color: #00BFA5;">
									<img src="${ctx}/static/img/alarm/search.png">&nbsp;查询
								</button>
							<button id="export-realtime" name="export" type="button"
									class="search"
									style="width: 60px; height: 30px; color: #00BFA5; outline: 0; border-color: #00BFA5;margin-left:20px;">
									<img src="${ctx}/static/img/ffm/daochu.svg">&nbsp;导出
								</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<!-- 实时数据  -->
			<table id="tb-summaryData" class="tb-historicalData"
				style="height: 90%; width: 100%; margin: 0 auto; min-width: 750px;">
				<tr>
					<th rowspan="" colspan=""></th>
				</tr>
			</table>
		</div>
		<!-- 历史数据  -->
		<div id="history_data_show"
			style="height: 86%; padding-left: 20px; padding-right: 20px;margin-top:15px;">
			<!--历史数据查询条件  -->
			<div style="width: 100%;">
				<form id="select-form_his">
					<table style="width: 1600px;">
						<tr style="height: 40px;">
							<td align="right" style="width:75px;">选择事件：</td>
							<td style="width: 170px;"><div id="alarm-event-type-dropdownlist_his"></div></td>
							<td align="right" style="width:100px;">设备类型：</td>
							<td style="width: 170px;"><div id="device-type-dropdownlist_his"></div></td>
							<td align="right" style="width:100px;">建筑物：</td>
							<td style="width: 170px;"><div id="building-dropdownlist_his"></div></td>
							<td align="right" >楼层：</td>
							<td style="width: 170px;"><div id="floor-dropdownlist_his"></div></td>
							<td align="right" style="width: 100px;">具体区域：</td>
							<td style="width: 170px;"><div id="area-dropdownlist_his"></div></td>
							<td align="right" style="width: 100px;">主机号：</td>
							<td><input id="hostNumber_his" name="hostNumber"
								placeholder="主机号" class="form-control required" type="text"
								style="width: 143px" /></td>
						</tr>
						<tr style="height: 60px;"valign='buttom'>
							<td align="right" style="width:72px;">回路号：</td>
							<td><input id="loopNumber_his" name="loopNumber"
								placeholder="回路号" class="form-control required" type="text"
								style="width: 144px" /></td>
							<td align="right" >测点号：</td>
							<td><input id="testNumber_his" name="testNumber"
								placeholder="测点号" class="form-control required" type="text"
								style="width: 144px" /></td>
							<td align="right" style="width: 6rem">开始时间：</td>
							<td><input id="startDate_his" name="startDate"
								placeholder="开始时间" class="form-control required" type="text"
								style="width: 144px" /></td>
							<td align="right" style="width: 10rem">结束时间：</td>
							<td style="width: 16rem;"><input id="endDate_his" name="endDate" placeholder="结束时间"
								class="form-control required" type="text" style="width: 144px" /></td>
							<td style="width: 80px;" colspan="4" align="right">
								<button id="btn-query-summary_his" type="button" class="search"
									style="width: 60px; height: 30px; color: #00BFA5; outline: 0; border-color: #00BFA5;">
									<img src="${ctx}/static/img/alarm/search.png">&nbsp;查询
								</button>
								<button id="export-summary_his" name="export" type="button"
									class="search"
									style="width: 60px; height: 30px; color: #00BFA5; outline: 0; border-color: #00BFA5;margin-left:20px;">
									<img src="${ctx}/static/img/ffm/daochu.svg">&nbsp;导出
								</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<table id="tb-historicalData" class="tb-historicalData"
				style="height: 90%; width: 100%; margin: 0 auto; min-width: 750px;">
				<tr>
					<th rowspan="" colspan=""></th>
				</tr>
			</table>
		</div>
	</div>
	<!-- 水压曲线 -->
	<div id="water-pressure-detail"></div>
	<div id="pg" style="text-align: right;"></div>
	<div id="pg_his" style="text-align: right;"></div>
	<div id="datetimepicker-div"></div>
	<div id="error-div"></div>
	<script type="text/javascript">
		var ctx = "${ctx}";
		var projectComStatus ="${param.projectComStatus}";
		var projectAlarmStatus = "${param.projectAlarmStatus}";
		$(document).ready(function() {
			$("#summary_data").addClass("checked_active");
			$("#history_data_show").hide();
			$("#history_total").hide();
			$("#pg_his").hide();
			waterSystemRealTimeInit(ctx);
		});
		
		
		// (实时数据/历史数据)切换
		function onclickSpan(obj) {
			$(".menu_active").removeClass("checked_active");
			$(obj).addClass("checked_active");
			var id = obj.id;
			if (id == "summary_data") {
				$("#summary_data_show").show();
				$("#history_data_show").hide();
				$("#summary_total").show();
				$("#history_total").hide();
				$("#pg_his").hide();
				$("#pg").show();
				$("#checked").css({
					"left" : "728px",
					"top" : "114px",
					"display" : "block"
				});
			} else if (id == "history_data") {
				$("#summary_data_show").hide();
				$("#history_data_show").show();
				$("#history_total").show();
				$("#summary_total").hide();
				$("#pg").hide();
				$("#pg_his").show();
				$("#checked").css({
					"left" : "846px",
					"top" : "114px",
					"display" : "block"
				});
				waterSystemHisInit(ctx);
			}
		}
		function getUnrecoveryCount() {
			$.ajax({
				type : "post",
				url : "${ctx}/fire-fighting/fireFightingWaterSystemManage/getUnrecoveryCount",
				dataType : "json",
				data : JSON.stringify(waterSystemData),
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					$("#unRecoveryCount").text(data.unrecoveryCount);
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		}
		
	</script>
</body>
</html>