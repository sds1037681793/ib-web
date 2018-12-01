<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.detailCotent {
	margin-bottom: 10px;
	width: 690px;
	height: 480px;
}
</style>
</head>
<div style="width: 680px; height: 480px;">
	<div style="width: 100%;">
		<table style="width: 90%">
			<tr>
				<td style="width: 50%;"><span id="press-deviceName"
					style="margin-left: 10%; font-size: 16px; font-family: PingFangSC-Regular; color: #444444"></span>
				</td>
				<td style="width: 50%"><input id="dailyTimePicker"
					name="dailyTimePicker" placeholder="选择日期"
					class="form-control required" type="text"
					style="margin-left: 70%; width: 144px" /></td>
			</tr>
		</table>
	</div>
	<div id="daily-datetimepicker-div"></div>
	<div id="waterEchartDiv" class="detailCotent"></div>
</div>
<script type="text/javascript">
	var today = "${today}";
	var waterPressure = 134;
	//时间控件
	$("#dailyTimePicker").datetimepicker({
		id : 'datetimepicker-dailyTimePicker',
		containerId : 'daily-datetimepicker-div',
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'YYYY-mm-dd',
		onSelectDate : function(data, inst) {
			var dateText = data.format("yyyy-MM-dd")
			changeWaterDetail(dateText);
		},
	});

	//时间控件
	$(document).ready(function() {
		if (picGridData != null) {
			showWaterDetail();
		}
	});

	/**
	 * 监听时间控件
	 */
	function changeWaterDetail(dateText) {
		var deviceId = picGridData.deviceId;
		var deviceName = picGridData.deviceName;
		$("#press-deviceName").html(deviceName);
		if (dateText > today) {
			showDialogModal("error-div", "操作错误", "时间选择错误：不允许选择大于今天的日期");
			getEchartDataFunc(waterPressure, "waterEchartDiv", deviceId, today);
			$("#dailyTimePicker").val(today);
			return;
		}
		getEchartDataFunc(waterPressure, "waterEchartDiv", deviceId, dateText);
	}
	function showWaterDetail() {
		var deviceId = picGridData.deviceId;
		var deviceName = picGridData.deviceName;
		$("#press-deviceName").html(deviceName);
		var dailyTime = $("#dailyTimePicker").val();
		if (dailyTime = null || dailyTime == "") {
			$("#dailyTimePicker").val(today);
			dailyTime = today;
		}
		getEchartDataFunc(waterPressure, "waterEchartDiv", deviceId, dailyTime);
	}

	//打开echart数据
	function getEchartDataFunc(reportId, divId, deviceId, dailyTime) {
		$.ajax({
			type : "post",
			url : "${ctx}/report/" + reportId + "?projectCode=" + projectCode
					+ "&deviceId=" + deviceId + "&dailyTime=" + dailyTime,
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				var echartData = jQuery.parseJSON(data);
				if (echartData.series.length == 0) {
					showDialogModal("error-div", "操作错误", "该日期下设备无水压数据");
					return;
				}
				var obj = echarts.init(document.getElementById(divId));
				echartData.series[0].areaStyle.normal.color=new echarts.graphic.LinearGradient(
		                0, 0, 0, 1,
		                [
		                    {offset: 0, color: 'DeepSkyBlue'},
		                    {offset: 1, color: 'PaleTurquoise'}
		                ]
		            );
				echartData.tooltip.formatter = function (params) {
			        var res='<div><p>'+params[0].name+'</p></div>' 
			        for(var i=0;i<params.length;i++){
			            if(params[i].data == '0.001'){
			                res+='<p>'+'离线状态'+'</p>'
			            }else{
			                res+='<p>'+params[i].seriesName+':'+params[i].data+'</p>'
			            }
			        }
			        return res;
			        };
				obj.setOption(echartData);
			},
			error : function(req, error, errObj) {
			}
		});
	}
	
	
	//能耗趋势，查询报表
	function getEneryConEchart(id, divId) {
		$.ajax({
		    type : "post",
		    url : ctx+"/report/" + id+"?projectCode="+projectCode,
		    async : true,
		    contentType : "application/json;charset=utf-8",
		    success : function(data) {
			var obj = echarts.init(document.getElementById(divId));
			var option = $.parseJSON(data);
			option.series[0].itemStyle.normal.color=new echarts.graphic.LinearGradient(
	                0, 0, 0, 1,
	                [
	                    {offset: 0, color: '#76DDFB'},
	                    {offset: 1, color: '#53A8E2'}
	                ]
	            );
			option.series[0].itemStyle.normal.color="#EF5D0B";

			obj.setOption(option);
		    },
		    error : function(req, error, errObj) {
		    }
		});
	}
</script>
</html>