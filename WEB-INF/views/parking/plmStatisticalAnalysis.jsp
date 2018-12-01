<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.headDiv {
	background: #FFFFFF;
	border: 1px solid #E1E1E1;
	border-radius: 4px;
	padding-top: 0.65rem;
	/* float: left;
	overflow: hidden; */
	/* width: 99%; */
	/* width:1290px; */
}

.headDiv .bd {
	width: 100%;
	margin: 0 auto;
}

.bd ul {
	overflow: hidden;
	margin-bottom: 30px;
	zoom: 1;
}

.bd ul li {
	_display: inline;
	text-align: center;
}

.block {
	float: left;
	height: 30%;
	width: 50%;
}

.detailItem {
	width: 100%;
	height: 25rem;
}

.detailHead {
	border: 1px solid #E1E1E1;
	border-radius: 5px;
	margin-top: 5px;
	margin-bottom: 10px;
	background: #FFFFFF;
	width: 100%;
	height: 50px;
	line-height: 50px;
}

.detailCotent {
	border: 1px solid #E1E1E1;
	border-radius: 5px;
	padding-top: 15px;
	padding-left: 10px;
	padding-right: 10px;
	margin-top: 5px;
	margin-bottom: 10px;
	background: #FFFFFF;
	width: 100%;
	height: 350px;
}

.detailFont {
	font-size: 1.25rem;
	color: #666666;
	line-height: 2.75rem;
	left: 5rem;
	margin-left: 1.25rem;
}

.select_style {
	border: 1px #CCCCCC solid;
	width: 150px;
	height: 30px;
	background-color: #FFFFFF;
	color: #666666;
	font-size: 12px;
}

.select_style option {
	border-radius: 2px;
	font-color: #F2F2F2;
	background-color: #FFFFFF;
	color: #666666;
}

.picList li {
	width: 22.60%;
	display: inline-block;
}

.picList li p {
	margin-top: 12px;
}

.item-img {
	margin-right: 10px;
}

.div-li {
	height: 140px;
}

.div-li p {
	height: 70px;
}
</style>
</head>
<body>
	<div id="content">
		<div id="pphead" class="headDiv">
			<div class="bd">
				<p style="font-size: 14px; color: #666666; margin-left: 1.8%">今日统计</p>
				<ul id="picList" class="picList">
					<li
						style="height: 140px; margin-left: 2%; margin-right: 1.5%; background-color: #26C6DA; text-align: center;">
						<div class="div-li">
							<p id="inletFlow"
								style="font-size: 50px; color: #FFFFFF; letter-spacing: 0;line-height: 70px;">-</p>
							<p style="font-size: 16px; color: #FFFFFF;">
								<i><img class="item-img"
									src="${ctx}/static/images/rukouzongliuliang.svg" /></i>入口总流量
							</p>
						</div>
					</li>
					<li
						style="height: 140px; margin-right: 1.5%; background-color: #4DA1FF; text-align: center;"><div
							class="div-li">
							<p id="outletFlow"
								style="font-size: 50px; color: #FFFFFF; letter-spacing: 0;line-height: 70px;">-</p>
							<p style="font-size: 16px; color: #FFFFFF;">
								<i><img class="item-img"
									src="${ctx}/static/images/chukouzongliuliang.svg" /></i>出口总流量
							</p>
						</div></li>
					<li
						style="height: 140px; margin-right: 1.5%; background-color: #00BFA5; text-align: center;">
						<div class="div-li">
							<p id="passengerTrainFlow"
								style="font-size: 50px; color: #FFFFFF; letter-spacing: 0;line-height: 70px;">-</p>
							<p style="font-size: 16px; color: #FFFFFF;">
								<i><img class="item-img"
									src="${ctx}/static/images/fangkecheliuliang.svg" /></i>访客车流量
							</p>
						</div>
					</li>
					<li
						style="height: 140px; margin-right: 2%; background-color: #F37B7B; text-align: center;"><div
							class="div-li">
							<p id="remainingParkingSpace"
								style="font-size: 50px; color: #FFFFFF; letter-spacing: 0;line-height: 70px;">-</p>
							<p style="font-size: 16px; color: #FFFFFF;">
								<i><img class="item-img"
									src="${ctx}/static/images/shengyuchewei.svg" /></i>剩余共享车位
							</p>
						</div></li>
				</ul>
			</div>
		</div>
		<div class="block" id="t86_87_88_89">
			<div class="detailItem">
				<div class="detailHead">
					<table style="width: 100%;">
						<tr>
							<td align="left"><span class="detailFont">车辆流量趋势</span></td>
							<td
								style="font-family: PingFangSC-Regular; font-size: 0.75rem; color: #FFFFFF; padding-right: 1.25rem;"
								align="right">
								<div id="vehicleStatistics-dropdownlist"
									onchange="reload('vehicleStatistics-dropdownlist')">
									<select class="select_style">
										<option value="1">今天</option>
										<option value="2">昨天</option>
										<option value="3">最近7天</option>
										<option value="4">最近30天</option>
									</select>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<!-- 此处为报表 -->
				<div id="vehicleAccessFlow" class="detailCotent"></div>
			</div>
		</div>
		<div class="block" id="t86_87_88_89">
			<div class="detailItem">
				<div class="detailHead">
					<table style="width: 100%;">
						<tr>
							<td align="left"><span class="detailFont">车标统计</span></td>
							<td
								style="font-family: PingFangSC-Regular; font-size: 0.75rem; color: #FFFFFF; padding-right: 1.25rem;"
								align="right">
								<div id="vehicleBrand-dropdownlist"
									onchange="reload('vehicleBrand-dropdownlist')">
									<select class="select_style">
										<option value="1">今天</option>
										<option value="2">昨天</option>
										<option value="3">最近7天</option>
										<option value="4">最近30天</option>
									</select>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<!-- 此处为报表 -->
				<!-- <div id="vehicleAccessFlowa" class="detailCotent"></div> -->
				<div class="detailCotent" style="text-align: center;">
					<img class="item-img" style="margin-top: 80px;"
						src="${ctx}/static/images/nodate.svg" />
				</div>
			</div>
		</div>
		<div id="abnormal-gate-detail-div"></div>
		<div id="fixCar-div"></div>
		<div id="tempCar-div"></div>
	</div>
	<script type="text/javascript">
		var startTime;
		var endTime;
		var todayTime = getTodayTime();
		var organizeId = "${param.orgId}";
		$(document).ready(function() {
			initTodayData();
			//echart模块
			initEchartModuls();
			
			//共享车位数查询
			getShareParkNum();
		});

		function getShareParkNum() {
			// 停车场模块共享车位查询
			$.ajax({
				type : "post",
				url : "${ctx}/fire-fighting/geomagParkingStatus/getShareParkData?projectCode=" + projectCode,
				async : false,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data != null) {
						$("#remainingParkingSpace").html(data.parkingRemain);
					}

				},
				error : function(req, error, errObj) {
				}
			});
		}
		
		//初始化今天的数据
		function initTodayData() {
			$.ajax({
				type : "post",
				url : "${ctx}/parking/parkingQuery/getStatisticalAnalusisData?CHECK_AUTHENTICATION=false&projectCode=" + projectCode + "&dayTime=" + todayTime,
				async : false,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.code == 0) {
						$("#passengerTrainFlow").html(data.data.visitCount);
						$("#outletFlow").html(data.data.exitCount);
						$("#inletFlow").html(data.data.entranceCount);
					}
				},
				error : function(req, error, errObj) {
				}
			});
		}
		function initEchartModuls() {
			reload('vehicleStatistics-dropdownlist');
		}
		function reload(divId) {
			beginTime = getDateStartStr(0);
			endTime = getDateEndStr(0);
			var selectedTime = $("#" + divId).find("option:checked").val();
			switch (selectedTime) {
				case "1" : // 今天
					break;
				case "2" : // 昨天
					beginTime = getDateStartStr(-1);
					endTime = getDateEndStr(-1);
					break;
				case "3" : // 最近7天
					beginTime = getDateStartStr(-6);
					endTime = getDateEndStr(0);
					break;
				case "4" : // 最近30天
					beginTime = getDateStartStr(-29);
					endTime = getDateEndStr(0);
					break;
				default : // 其它情况视为今天
					break;
			}
			if ("vehicleStatistics-dropdownlist" == divId) {
				var reportId = 0;
				switch (selectedTime) {
					case "1" : // 今天
						reportId = 155;
						break;
					case "2" : // 昨天
						reportId = 155;
						break;
					case "3" : // 最近7天
						reportId = 156;
						break;
					case "4" : // 最近30天
						reportId = 156;
						break;
					default : // 其它情况视为今天
						reportId = 155;
						break;
				}
				getDivDataByTime(reportId, "vehicleAccessFlow");
			}
		}

		function getDivDataByTime(id, divId) {
			$.ajax({
				type : "post",
				url : "${ctx}/report/" + id + "?CHECK_AUTHENTICATION=false&beginTime=" + beginTime + "&endTime=" + endTime+"&projectCode="+projectCode,
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					var obj = echarts.init(document.getElementById(divId));
					obj.setOption($.parseJSON(data));
					$("#vehicleAccessFlow").css({
						"background-color" : "#FFFFFF",
					});
				},
				error : function(req, error, errObj) {
				}
			});
		}

		function getDateStartStr(AddDayCount) {
			var dd = new Date();
			dd.setDate(dd.getDate() + AddDayCount);//获取AddDayCount天后的日期
			var y = dd.getFullYear();
			var m = dd.getMonth() + 1;//获取当前月份的日期
			if (m.toString().length == 1) {
				m = '0' + m;
			};
			var d = dd.getDate();
			if (d.toString().length == 1) {
				d = '0' + d;
			};
			return y + "-" + m + "-" + d + " 00:00:00";
		}

		function getDateEndStr(AddDayCount) {
			var dd = new Date();
			dd.setDate(dd.getDate() + AddDayCount);//获取AddDayCount天后的日期
			var y = dd.getFullYear();
			var m = dd.getMonth() + 1;//获取当前月份的日期
			if (m.toString().length == 1) {
				m = '0' + m;
			};
			var d = dd.getDate();
			if (d.toString().length == 1) {
				d = '0' + d;
			};
			return y + "-" + m + "-" + d + " 23:59:59";
		}

		function getTodayTime() {
			var dd = new Date();
			var y = dd.getFullYear();
			var m = dd.getMonth() + 1;//获取当前月份的日期
			if (m.toString().length == 1) {
				m = '0' + m;
			};
			var d = dd.getDate();
			if (d.toString().length == 1) {
				d = '0' + d;
			};
			return y + "-" + m + "-" + d;
		}
	</script>
</body>
</html>