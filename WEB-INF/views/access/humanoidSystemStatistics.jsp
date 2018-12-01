<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
<script src="${ctx}/static/js/echarts/echarts.min.js"
	type="text/javascript"></script>
<head>
<style>
.btn-tr td {
	width: 110px !important;
	text-align: center;
}

.btn-tr td button {
	width: 80px;
	height: 32px;
	margin: 0 0 20px 0;
	font-size: 14px;
}

#passageName {
	height: 30px;
	width: 120px;
	margin-top: -15px;
}

#ddl-btn-passageName {
	width: 30px;
	height: 30px;
	margin-top: -15px;
}

.level {
	width: 80px;
	height: 30px;
	border-radius: 4px;
	margin-left: 30px;
	border: 1px solid #979797;
	text-align: center;
	font-size: 12px;
	outline: none;
	background-color: #FFF;
	border: 1px solid #979797;
}

.selected {
	color: #FFF;
	background-color: #00BFA5;
	border: 1px solid #00BFA5;
}
/* #btn-today-banner {
	color:#00BFA5; 
	border-color:#00BFA5
}  */
html {
	overflow-y: hidden;
}
</style>
<link
	href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css"
	type="text/css" rel="stylesheet" />
<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js"
	type="text/javascript"></script>
</head>
<body>
	<div class="content-default" style="min-width: 1620px; height: 60px;">
		<form id="select-form">
			<table style="min-width: 450px;">
				<tr class="btn-tr">
					<td>
						<button id="btn-today-banner"
							style="margin-left: 20px; height: 30px;" type="button"
							class="level selected">今日</button>
					</td>
					<td>
						<button id="btn-yesterday-banner" type="button" class="level"
							style="margin-left: 15px; height: 30px;">昨日</button>
					</td>
					<td>
						<button id="btn-sevendays-banner" type="button" class="level"
							style="margin-left: 15px; height: 30px;">最近7天</button>
					</td>
					<td>
						<button id="btn-Thirtydays-banner" type="button" class="level"
							style="margin-left: 15px; height: 30px;">最近30天</button>
					</td>
					<td />
					<td />
					<td />
					<td />
					<td />
					<td />
					<td />
					<td />
					<td />
					<td><div id="passage-dropdownlist"></div></td>
				</tr>
			</table>
		</form>
	</div>
	<div class="content-default" style="min-width: 1620px; height: 750px;">
		<div style="width: 700px; height: 350px; float: left; display: inline">
			<!--此处为报表-->
			<div id="userStatistics" style="height: 350px; width: 680px;"></div>
		</div>
		<div style="width: 800px; height: 350px; float: left; display: inline">
			<!--此处为报表-->
			<div id="entryMode" style="height: 350px; width: 730px;"></div>
		</div>
		<div style="float: left; width: 1620px;">
			<p
				style="text-align: center; color: #333; font-size: 16px; font-weight: bold; padding-bottom: 16px;">出入流量趋势</p>
			<div id="EntryFlowTrend"
				style="height: 340px; width: 100%; padding-bottom: 16px; float: -350px"></div>
		</div>
	</div>
<script type="text/javascript">
		var ddlItems;
		var dropdownlist;
		var passageId;
		var beginTime;
		var endTime;
		var beginTimeNum;
		var endTimeNum;
		$(document).ready(function() {
			beginTimeNum = 0;
			endTimeNum = 0;
			beginTime = GetDateStr(0);
			endTime = GetDateStr(1);
			$.ajax({
				type : "post",
				url : "${ctx}/access-control/accessStatistics/queryPassage?CHECK_AUTHENTICATION=false&projectCode=" + projectCode,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.code == 0) {
						ddlItems = data.data;
						dropdownlist = $('#passage-dropdownlist').dropDownList({
							inputName : "passageName",
							inputValName : "passageNameId",
							buttonText : "",
							width : "117px",
							readOnly : false,
							required : true,
							maxHeight : 200,
							onSelect : function(i, data, icon) {
								passageCode = data;
								if (passageCode == undefined) {
									passageCode = "";
								}

								if (beginTimeNum == 0 || beginTimeNum == 1) {
									getData(147, "userStatistics");
									getData(146, "entryMode");
									getDatas(145, "EntryFlowTrend");
								} else if (beginTimeNum == 6 || beginTimeNum == 29) {
									getData(147, "userStatistics");
									getData(146, "entryMode");
									getDatas(144, "EntryFlowTrend");
								}

							},
							items : ddlItems
						});
						dropdownlist.setData(ddlItems[0].itemText, ddlItems[0].itemData);
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		})

		$("#btn-today-banner").on("click", function() {
			$("#btn-today-banner").addClass("selected").parent().siblings().children("button").removeClass("selected");
			beginTimeNum = 0;
			endTimeNum = 0;
			beginTime = GetDateStr(0);
			endTime = GetDateStr(1);
			getData(147, "userStatistics");
			getData(146, "entryMode");
			getDatas(145, "EntryFlowTrend");
		});
		$("#btn-yesterday-banner").on("click", function() {
			$("#btn-yesterday-banner").addClass("selected").parent().siblings().children("button").removeClass("selected");
			beginTimeNum = 1;
			endTimeNum = 1;
			beginTime = GetDateStr(-1);
			endTime = GetDateStr(0);
			getData(147, "userStatistics");
			getData(146, "entryMode");
			getDatas(145, "EntryFlowTrend");
		});
		$("#btn-sevendays-banner").on("click", function() {
			$("#btn-sevendays-banner").addClass("selected").parent().siblings().children("button").removeClass("selected");
			beginTimeNum = 6;
			endTimeNum = 0;
			beginTime = GetDateStr(-6);
			endTime = GetDateStr(1);
			getData(147, "userStatistics");
			getData(146, "entryMode");
			getDatas(144, "EntryFlowTrend");
		});
		$("#btn-Thirtydays-banner").on("click", function() {
			$("#btn-Thirtydays-banner").addClass("selected").parent().siblings().children("button").removeClass("selected");
			beginTimeNum = 29;
			endTimeNum = 0;
			beginTime = GetDateStr(-29);
			endTime = GetDateStr(1);
			getData(147, "userStatistics");
			getData(146, "entryMode");
			getDatas(144, "EntryFlowTrend");
		});
		function getData(id, divId) {
			$.ajax({
				type : "post",
				url : "${ctx}/report/" + id + "?CHECK_AUTHENTICATION=false&beginTime=" + beginTimeNum + "&endTime=" + endTimeNum + "&passageCode=" + passageCode+"&projectCode=" + projectCode,
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

		function getDatas(id, divId) {
			$.ajax({
				type : "post",
				url : "${ctx}/report/" + id + "?CHECK_AUTHENTICATION=false&beginTime=" + beginTime + "&endTime=" + endTime + "&passageCode=" + passageCode+"&projectCode=" + projectCode,
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

		function GetDateStr(AddDayCount) {
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
			return y + "-" + m + "-" + d + " 00:00";
		}
</script>
</body>
</html>