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
<script src="${ctx}/static/busi/ffmStaticLink.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/busi/ffmDeal.js"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
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
	width: 20px;
	line-height: 30px;
	text-align: center;
	font-size: 20px;
	color: red;
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
	line-height: 60px;
	text-align: center;
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
	width: 40px;
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

.select {
	color: #00BFA5;
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

.span {
	font-size: 12px;
	color: #FFFFFF;
	line-height: 12px;
	width: 52px;
	height: 20px;
	text-align: center;
	margin: auto;
	line-height: 20px;
}

.item-img , .item-imgs {
	cursor: pointer;
}
.confirm {
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="content-select" style="min-width: 1620px; height: 900px;">
		<div
			style="width: 100%; height: 62px;border: 1px solid #E1E1E1;">
			<div id="summary_data" class="menu_active"
				style="margin-left: 710px; width: 72px; height: 25px;"
				onclick="onclickSpan(this)">实时信息</div>
			<div id="history_data" class="menu_active" style="margin-left: 47px;"
				onclick="onclickSpan(this)">历史事件</div>
			<div id="checked"
				style="position: absolute; left: 728px; top: 114px; background: #00BFA5; width: 80px; height: 2px;"></div>
		</div>
		<div id="summary_total" style="width: 100%; height: 60px;">
			<div
				style="width: 80px; height: 30px; float: left; margin-top: 15px; margin-left: 20px; font-size: 16px; line-height: 30px;">
				实时概览：</div>
			<div id="huojing" class="summary_check" style="width: 101px;">
				<div class="div_style_one">
					<img id="huojing-img" src="${ctx}/static/img/ffm/baojing.svg">
				</div>
				<div class="div_style_six">火警</div>
				<div id="fireStatus" class="div_style_two"></div>
			</div>
			<div id="guzhang" class="summary_check" style="width: 101px;">
				<div class="div_style_one">
					<img id="guzhang-img" src="${ctx}/static/img/ffm/guzhang.svg">
				</div>
				<div class="div_style_six">故障</div>
				<div id="faultStatus" class="div_style_two"></div>
			</div>
			<div id="huida" class="summary_check" style="width: 100px;">
				<div class="div_style_one">
					<img id="huida-img" src="${ctx}/static/img/ffm/huida.svg">
				</div>
				<div class="div_style_six">回答</div>
				<div id="linkage" class="div_style_two"></div>
			</div>
			<div
				style="width: 260px; height: 60px; float: left; margin-left: 965px;">
			</div>
			<div
				style="width: 1595px; height: 1px; margin-left: 20px; float: left; background: #D8D8D8;"></div>
		</div>
		<div id="history_total" style="width: 100%; height: 60px;">
			<div
				style="width: 80px; height: 30px; float: left; margin-top: 15px; margin-left: 20px; font-size: 16px; line-height: 30px;">
				历史概览：</div>
			<div id="weihuifu" class="history_check" style="width: 126px;">
				<div class="div_style_one">
					<img id="weihuifu-img" src="${ctx}/static/img/ffm/weihuifu.svg">
				</div>
				<div class="div_style_five">未恢复</div>
				<div class="div_style_two" id="no_revocery_num"></div>
			</div>
			<div id="daiqueren" class="history_check" style="width: 125px;">
				<div class="div_style_one">
					<img id="daiqueren-img" src="${ctx}/static/img/ffm/daiqueren.svg">
				</div>
				<div class="div_style_five">未确定</div>
				<div class="div_style_two" id="no_confirm_num"></div>
			</div>
			<div
				style="width: 260px; height: 60px; float: left; margin-left: 1020px;">
			</div>
			<div
				style="width: 1595px; height: 1px; margin-left: 20px; float: left; background: #D8D8D8;"></div>
		</div>
		<!--实时数据查询条件  -->
		<div id="summary_data_show"
			style="height: 86%; padding-left: 20px; padding-right: 20px; margin-top: 15px;">
			<div class="" style="width: 100%;">
				<form id="select-form">
					<table style="width: 1600px">
						<tr style="height: 40px;">
							<td align="right" style="width: 70px;">设备类型：</td>
							<td style="width: 170px;"><div id="deviceType-dropdownlist"></div></td>
							<td align="right" style="width: 100px;">建筑物：</td>
							<td style="width: 170px;"><div id="ban-dropdownlist"></div></td>
							<td align="right" style="width: 100px;">楼层：</td>
							<td style="width: 170px;"><div id="floor-dropdownlist"></div></td>
							<td align="right">具体区域：</td>
							<td style="width: 170px;"><div
									id="specificArea-dropdownlist"></div></td>
							<td align="right" style="width: 100px;">主机号：</td>
							<td><input id="hostNumber" type="text" name="hostNumber"
								placeholder="主机号" style="width: 150px"
								class="form-control required" /></td>
							<td align="right" style="width: 100px;">回路号：</td>
							<td><input id="loopNumber" type="text" name="loopNumber"
								placeholder="回路号" style="width: 150px"
								class="form-control required" /></td>
						</tr>
						<tr style="height: 60px;">
							<td align="right">测点号：</td>
							<td><input id="measuringPoint" name="measuringPoint"
								placeholder="测点号" style="width: 150px"
								class="form-control required" type="text" /></td>
							<td align="right">报警状态：</td>
							<td style="width: 170px;"><div id="state-dropdownlist"></div></td>
							<td align="right" style="width: 100px;">开始时间：</td>
							<td><input id="startDate" name="startDate"
								placeholder="开始时间" style="width: 150px"
								class="form-control required" type="text" style="" /></td>
							<td align="right" style="width: 100px;">结束时间：</td>
							<td style="width: 150px"><input id="endDate" name="endDate"
								placeholder="结束时间" style="width: 150px"
								class="form-control required" type="text" style="" /></td>
							<td align="right" colspan="4">
								<button id="btn-query-summary" type="button" class="search"
									style="width: 60px; height: 30px; color: #00BFA5; outline: 0; border-color: #00BFA5;">
									<img src="${ctx}/static/img/alarm/search.png">&nbsp;查询
								</button>
								<button id="export-summary" name="export" type="button"
									class="search"
									style="width: 60px; height: 30px; color: #00BFA5; outline: 0; border-color: #00BFA5; margin-left: 20px;">
									<img src="${ctx}/static/img/ffm/daochu.svg">&nbsp;导出
								</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<table id="tb_authorizeOrder" class="tb_authorizeOrder"
				style="height: 90%; width: 100%; margin: 0 auto; min-width: 750px;">
				<tr>
					<th rowspan="" colspan=""></th>
				</tr>
			</table>
		</div>
		<!-- 历史数据  -->
		<div id="history_data_show"
			style="height: 86%; padding-left: 20px; padding-right: 20px; margin-top: 15px;">
			<!--实时数据查询条件  -->
			<div class="" style="width: 100%;">
				<form id="event_alarm_form">
					<table style="width: 1600px">
						<tr style="height: 40px;">
							<td align="right" style="width: 70px;">选择事件：</td>
							<td style="width: 170px;"><div id="event-Type-dropdownlist"></div></td>
							<td align="right" style="width: 100px;">设备类型：</td>
							<td style="width: 170px;"><div id="device-type-dropdownlist"></div></td>
							<td align="right" style="width: 100px;">建筑物：</td>
							<td style="width: 170px;"><div id="building-dropdownlist"></div></td>
							<td align="right">楼层：</td>
							<td style="width: 170px;"><div id="floors-dropdownlist"></div></td>
							<td align="right" style="width: 110px;">具体区域：</td>
							<td style="width: 170px;"><div id="area-dropdownlist"></div></td>
							<td align="right" style="width: 100px;">主机号：</td>
							<td><input id="hostId" name="hostId" placeholder="主机号"
								class="form-control required" type="text" style="width: 150px" />
							</td>
						</tr>
						<tr style="height: 60px;">
							<td align="right">回路号：</td>
							<td><input id="loopId" name="loopId" placeholder="回路号"
								class="form-control required" type="text" style="width: 150px" />
							</td>
							<td align="right">测点号：</td>
							<td><input id="testId" name="" testId" placeholder="测点号"
								class="form-control required" type="text" style="width: 150px" />
							</td>
							<td align="right" style="width: 100px;">开始时间：</td>
							<td><input id="startTime" name="startTime"
								placeholder="开始时间" class="form-control required" type="text"
								style="width: 150px" /></td>
							<td align="right" style="width: 100px;">结束时间：</td>
							<td><input id="endTime" name="endTime" placeholder="结束时间"
								class="form-control required" type="text" style="width: 150px" /></td>
							<td align="right">处理结果：</td>
							<td style="width: 170px;"><div id="confirm-dropdownlist"></div></td>
							<td align="right" colspan="2">
								<button id="btn-query-event" type="button" class="search"
									style="width: 60px; height: 30px; color: #00BFA5; outline: 0; border-color: #00BFA5;">
									<img src="${ctx}/static/img/alarm/search.png">&nbsp;查询
								</button>
								<button id="export-event" name="export" type="button"
									class="search"
									style="width: 60px; height: 30px; color: #00BFA5; outline: 0; border-color: #00BFA5; margin-left: 20px;">
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
	<div id="alarm-record-confirm-div"></div>
	<div id="authorizeOrder-div"></div>
	<div id="pg" style="text-align: right;"></div>
	<div id="pg_two" style="text-align: right;"></div>
	<div id="edit-group-add"></div>
	<div id="error-div"></div>
	<div id="device-detail"></div>
	<div id="datetimepicker-div"></div>
	<script type="text/javascript">
		var ctx = "${ctx}";
		var projectAlarmStatus = "${param.projectAlarmStatus}";
		$(document).ready(function() {
			$("#pg").show();
			$("#pg_two").hide();
			$("#summary_data").addClass("checked_active");
			$("#history_data_show").hide();
			$("#history_total").hide();
			ffmAlarmSysteminit(ctx);
			initFiresSystemHisEvent();
		});
		//(实时数据/历史数据)切换
		function onclickSpan(obj) {
			$(".menu_active").removeClass("checked_active");
			$(obj).addClass("checked_active");
			var id = obj.id;
			if (id == "summary_data") {
				$("#summary_data_show").show();
				$("#history_data_show").hide();
				$("#summary_total").show();
				$("#history_total").hide();
				$("#checked").css({
					"left" : "728px",
					"top" : "114px",
					"display" : "block"
				});
				$("#pg").show();
				$("#pg_two").hide();
				flushRealTimePage();
			} else if (id == "history_data") {
				$("#summary_data_show").hide();
				$("#history_data_show").show();
				$("#history_total").show();
				$("#summary_total").hide();
				$("#checked").css({
					"left" : "846px",
					"top" : "114px",
					"display" : "block"
				});
				$("#pg").hide();
				$("#pg_two").show();
				flushPage();
			}
		}
	</script>
</body>
</html>