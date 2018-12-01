<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
<head>
<style>
.btn-tr td {
	text-align: center;
}

.font_item {
	opacity: 0.8;
	font-size: 1rem;
}

.btn-tr td button {
	width: 80px;
	height: 32px;
	margin: 0 0 20px 0;
	font-size: 14px;
}

#deviceName {
	height: 30px;
	width: 120px;
	margin-top: -15px;
}

#ddl-btn-deviceName {
	width: 30px;
	height: 30px;
	margin-top: -15px;
}

#deviceMaintenanceName {
	height: 30px;
	width: 120px;
	margin-top: -15px;
}

#ddl-btn-deviceMaintenanceName {
	width: 30px;
	height: 30px;
	margin-top: -15px;
}

#query_alarms {
	color: #F37B7B;
}

#statistical_analysisIndex {
	margin-left: 190px;
	position: absolute;
	left: 0px;
	top: 220px;
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
.query-num{
background: #FFFFFF;
border: 1px solid #CCCCCC;
font-family: PingFangSC-Regular;
font-size: 14px;
color: #999999;
letter-spacing: 0;
	width: 80px;
	height: 32px;
	margin: 0 0 20px 0;
}
#startTimePicker{
background: #FFFFFF;
border: 1px solid #CCCCCC;
font-family: PingFangSC-Regular;
font-size: 12px;
color: #999999;
letter-spacing: 0;
width: 110px;
height: 30px;
margin: 0 0 20px 10px;
}
#endTimePicker{
background: #FFFFFF;
border: 1px solid #CCCCCC;
font-family: PingFangSC-Regular;
font-size: 12px;
color: #999999;
letter-spacing: 0;
width: 110px;
height: 30px;
margin: 0 0 20px 5px;
}
</style>
<link href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
</head>
<body>

	<div class="content-default" style="padding:17.1px 14.4px;min-width: 1640px; height: 900px;">
		<div style=" margin-left: 20px; margin-top: 43.2px; float: left;width:55%">
			<div style="height: 43.2px">
				<span style="font-family: PingFangSC-Medium; font-size: 16px; color: #444444;height: 22px;">报警类型分析</span>
			</div>
			<div class="font_item" style="float: left; margin-top: 5px">
				<span>总数：</span>
				<span id="query_alarms" style="font-family: PingFangSC-Medium; font-size: 24px; color: #FC4D4D;">-</span>
				<span style="height: 30px;">次</span>
			</div>
			<div style="width:700px; float: left;">
				<form id="select-form">
					<table style="min-width: 450px;">
						<tr class="btn-tr">
							<td style="width:90px">
								<button id="btn-today-banner" style="margin-left: 10px; height: 30px;" type="button" class="level selected">今日</button>
							</td>
							<!-- 		<td>
								<button id="btn-yesterday-banner" type="button" class="level" style="margin-left: 15px; height: 30px;">昨日</button>
							</td> -->
							<td style="width:90px">
								<button id="btn-sevendays-banner" type="button" class="level" style="height: 30px;margin-left:15px">最近7天</button>
							</td>
							<!-- 	<td>
								<button id="btn-Thirtydays-banner" type="button" class="level" style="margin-left: 15px; height: 30px;">最近30天</button>
							</td>-->
							<td>
								<input id="startTimePicker" name="startTimePicker" placeholder="开始日期" class="form-control required" type="text" style="marmargin-bottom: 20px;float: left;" />
						   		<label style="float: left;margin-left: 5px;">-</label>
							</td>
							
							<td>
								<input id="endTimePicker" name="endTimePicker" placeholder="结束日期" class="form-control required" type="text" style="margin-bottom: 20px" />
							</td>
							<td>
								<button id="btn_query" class="level" type="button" style=" height: 30px;margin-left:10px">区间查询</button>
							</td>
							<td>
								<div  id="elevator-dropdownlist"></div>
							</td>
						</tr>
					</table>
				</form>
			</div>

		</div>
		<div style="height: 5.6%; margin-left: 6px; margin-top: 43.2px; float: left;width: 42%">
			<div style="height: 43.2px">
				<span style="font-family: PingFangSC-Medium; font-size: 16px; color: #444444;height: 22px;margin-left: -7px;">维保超期分析</span>
			</div>
			<div style="width: 800px; float: left;margin-left:-24px;">
				<form id="elevator-maintenance-form">
					<table style="min-width: 450px;">
						<tr class="btn-tr" style="">
							<td>
								<button id="btn-current-month" style="margin-left: 20px; height: 30px;" type="button" class="level selected">当月</button>
							</td>
							<td>
								<button id="btn-three-month" style="margin-left: 20px; height: 30px;" type="button" class="level">3个月</button>
							</td>
							<td>
								<input id="query-num" class="query-num" type="text" style="height: 30px;margin-left: 20px;width:120px;" placeholder="请输入区间数字"   maxlength="2" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();" >
							</td>
							<td>
								<button id="more-month-query" style="height: 30px; margin-left: 7.2px;" type="button" class="level">区间查询</button>
							</td>
							<td>
								<div id="elevator-maintenance-dropdownlist"></div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

		<div style="float: left;width: 53%; height: auto; ">
			<!--此处为报表-->
			<div id="statistical_analysisIndex" style="height: 600px; width: 55%; margin-left: 10px;"></div>
		</div>
		<!-- 维保超期分析报表 -->
			<div style="float: left;width: 800px; height: 600px;margin-top: 11px;">
			<!--此处为报表 -->
			<div id="maintenance_reportForms" style="height: 580px; width:650px; margin-left: 876px;"></div>
		</div>
	</div>
	<div id="end-datetimepicker-div"></div>
	<div id="start-datetimepicker-div"></div>
	<script type="text/javascript">
		//var passageNameList = new Array();
		var ddlItems;
		var dropdownlist;
		var deviceId;
		var beginTime;
		var endTime;
		var beginTimeNum;
		var endTimeNum;
		var rangeTimeQuery = 0;//是否点击了区间查询（1：选择了区间查询）
		var typeCode = "ELEVATOR";
		//电梯维保超期分析
		var elevatorItems;
		var elevatorDropdownlist;
		var elevatorDeviceId;
		var startTime;
		var overTime;
		var startTimeNum;
		var overTimeNum;
		//时间控件
		$("#startTimePicker").datetimepicker({
			id : 'datetimepicker-startTimePicker',
			containerId : 'start-datetimepicker-div',
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'YYYY-mm-dd'
		});
		//时间控件
		$("#endTimePicker").datetimepicker({
			id : 'datetimepicker-endTimePicker',
			containerId : 'end-datetimepicker-div',
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'YYYY-mm-dd'
		});

		$(document).ready(function() {
			deviceId = "";
			beginTimeNum = 0;
			endTimeNum = -1;
			beginTime = GetDateStr(0);
			endTime = GetDateStr(1);
			queryAlarms(beginTime, endTime);
			getData(108, "statistical_analysisIndex");
			elevatorDeviceId = "";
			startTime = getNowDate(1);
			overTime = getNowDate(1);
// 			getMaintenanceData( "maintenance_reportForms",startTime, overTime);
			$.ajax({
				type : "post",
				url : "${ctx}/alarmStatisticalAnalysis/queryElevators?typeCode=" + typeCode + "&projectId=" + projectId,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					ddlItems = data;
					elevatorItems = data;
					dropdownlist = $('#elevator-dropdownlist').dropDownList({
						inputName : "deviceName",
						inputValName : "deviceNameId",
						buttonText : "",
						width : "117px",
						readOnly : false,
						required : true,
						maxHeight : 200,
						onSelect : function(i, data, icon) {
							deviceId = data;
							if (deviceId == undefined) {
								deviceId = "";
							}
							if(rangeTimeQuery == 0){
								getData(108, "statistical_analysisIndex");
								queryAlarms(beginTime, endTime);
							}else{
								rangeTimeQuqeryFunc();
							}
							
						},
						items : ddlItems
					});
					dropdownlist.setData(ddlItems[0].itemText, ddlItems[0].itemData);
					
					//电梯维保超期统计
					elevatorDropdownlist = $('#elevator-maintenance-dropdownlist').dropDownList({
						inputName : "deviceMaintenanceName",
						inputValName : "deviceMaintenanceNameId",
						buttonText : "",
						width : "117px",
						readOnly : false,
						required : true,
						maxHeight : 200,
						onSelect : function(i, data, icon) {
							elevatorDeviceId = data;
							if (elevatorDeviceId == undefined) {
								elevatorDeviceId = "";
							}

						getMaintenanceData( "maintenance_reportForms",startTime, overTime);
						},
						items : elevatorItems
					});
					elevatorDropdownlist.setData(elevatorItems[0].itemText, elevatorItems[0].itemData);
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		})

		$("#btn-today-banner").on("click", function() {
			rangeTimeQuery = 0;
			$("#btn-today-banner").addClass("selected").parent().siblings().children("button").removeClass("selected");
			beginTimeNum = 0;
			endTimeNum = -1;
			beginTime = GetDateStr(0);
			endTime = GetDateStr(1);
			queryAlarms(beginTime, endTime);
			getData(108, "statistical_analysisIndex");
		});

		//电梯维保分析查询当月
		$("#btn-current-month").on("click", function() {
			$("#btn-current-month").addClass("selected").parent().siblings().children("button").removeClass("selected");
			startTime = getNowDate(1);
			overTime = getNowDate(1);
			getMaintenanceData( "maintenance_reportForms",startTime, overTime);
		});
		//电梯维保分析查询3个月
		$("#btn-three-month").on("click", function() {
			$("#btn-three-month").addClass("selected").parent().siblings().children("button").removeClass("selected");
			//需要查几个月，就传入数字几
			startTime = getNowDate(3);
			//传1查当月
			overTime = getNowDate(1);
			getMaintenanceData( "maintenance_reportForms",startTime, overTime);
		});
		//电梯维保分析查询更多月
		$("#more-month-query").on("click", function() {
			$("#more-month-query").addClass("selected").parent().siblings().children("button").removeClass("selected");
			var monthNo = $(".query-num").val();
			if(monthNo == "undefined" || monthNo == "" || monthNo == null || monthNo > 24 ||  monthNo < 1){
				showAlert('warning','请输入1-24的数字！',"query-num",'top');
				$("#query-num").focus();
				return;
			}
			startTime = getNowDate(monthNo);
			overTime = getNowDate(1);
			getMaintenanceData( "maintenance_reportForms",startTime, overTime);
		});
		//	$("#btn-yesterday-banner").on("click", function() {
		//		$("#btn-yesterday-banner").addClass("selected").parent().siblings().children("button").removeClass("selected");
		//		beginTimeNum = 1;
		//		endTimeNum = 0;
		//		beginTime = GetDateStr(-1);
		//		endTime = GetDateStr(0);
		//		queryAlarms(beginTime, endTime);
		//		getData(108, "statistical_analysisIndex");
		//	});
		$("#btn-sevendays-banner").on("click", function() {
			rangeTimeQuery =0;
			$("#btn-sevendays-banner").addClass("selected").parent().siblings().children("button").removeClass("selected");
			beginTimeNum = 6;
			endTimeNum = -1;
			beginTime = GetDateStr(-6);
			endTime = GetDateStr(1);
			queryAlarms(beginTime, endTime);
			getData(108, "statistical_analysisIndex");
		});
		//$("#btn-Thirtydays-banner").on("click", function() {
		//	$("#btn-Thirtydays-banner").addClass("selected").parent().siblings().children("button").removeClass("selected");
		//	beginTimeNum = 30;
		//	endTimeNum = -1;
		//		beginTime = GetDateStr(-29);
		//		endTime = GetDateStr(1);
		//		queryAlarms(beginTime, endTime);
		//		getData(108, "statistical_analysisIndex");
		//	});
		function getData(id, divId) {
			$.ajax({
				type : "post",
				url : "${ctx}/report/" + id + "?beginTime=" + beginTimeNum + "&endTime=" + endTimeNum + "&projectCode=" + projectCode + "&deviceId=" + deviceId,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					var obj = echarts.init(document.getElementById(divId));
					obj.setOption($.parseJSON(data));
				},
				error : function(req, error, errObj) {
				}
			});
		}

		//查询电梯维保超期统计信息
		function getMaintenanceData(elevatorDivId,startTime, overTime) {
			$.ajax({
				type : "post",
// 				dataType : "json",
				url : "${ctx}/elevator/elevatorMaintenanceRecord/queryRecord?startTime=" + startTime + "&overTime=" + overTime + "&projectCode=" + projectCode + "&deviceId=" + elevatorDeviceId,
				contentType : "application/json;charset=utf-8",
	 			async:false,
				success : function(data) {
// 					var data = JSON.parse(data);
					if(data!=null && data.length > 0){	
				 	var xvalue=new Array();
				 	var yvalue=new Array();
				 	
					$(eval(data)).each(function() {
						xvalue[xvalue.length] = this.month;
						yvalue[yvalue.length] = this.overTimeNum;
					});
				 	
					var obj = echarts.init(document.getElementById(elevatorDivId));
					obj.clear();
					var	option;
					if(xvalue.length >= 12 ){
						//报表
						option = {
						   	    color: ['#26C6DA'],
						   	    tooltip : {
						   	        trigger: 'axis',
						   	    },
						   	    grid: {
						   	        left: '3%',
						   	        right: '10%',
						   	        bottom: '3%',
						   	        containLabel: true
						   	    },
						   	     dataZoom: [
						   	        {  
						   	        	   type: 'inside',
						 		           start: 0,
						 		           end: 50
						   	        }
						   	    ],
						   	    xAxis : [
						   	        {
						   	     	   name :"月份",
						   	            type : 'category',
						   	            data : xvalue,
						   	            axisTick: {
						   	                alignWithLabel: true
						   	            },
						   			nameTextStyle: {
						   				color: "#666666"
						   			},
						   			axisLabel: {
						   				show: true,
						   				interval: 0,
						   				rotate:-30,
						   				textStyle: {
						   			    color: "#666666"
						   				}
						   			},
						   			splitLine: {
						   				show: false,
						   				color: "#C2C9D1"
						   			},
						   			axisLine: {
						   				lineStyle: {
						   					color: "#E7EBEF",
						   					width: 2,
						   					type: "solid"
						   				}
						   			}
						   	     }],
						   	    yAxis : [
						   	        {
						   	        	name: "次数",
						   	 		nameTextStyle: {
						   	 			color: "#666666"
						   	 		},
						   	            type : 'value',
						   	            
						   	         axisLabel: {
						   				show: true,
						   				textStyle: {
						   					color: "#666666"
						   				}
						   			},
						   			axisLine: {
						   				lineStyle: {
						   					color: "#E7EBEF",
						   					width: 2,
						   					type: "solid"
						   				}
						   			}
						   	        }
						   	    ],
						   	    series : [
						   	        {
						   				itemStyle: {
						   					normal: {
						   						color: "#26C6DA",
						   						label: {
						   							show: true,
						   							position: "top"
						   						}

						   					}
						   				},
						   	            name:'超期',
						   	            type:'bar',
						   	            barWidth: '30',
						   	     	barGap: "30%",
						   			symbolSize: 8,
						   	            data:yvalue
						   	        }
						   	    ]
					    };
					}else{
						option = {
						   	    color: ['#26C6DA'],
						   	    tooltip : {
						   	        trigger: 'axis',
						   	    },
						   	    grid: {
						   	        left: '3%',
						   	        right: '10%',
						   	        bottom: '3%',
						   	        containLabel: true
						   	    },
						   	    xAxis : [
						   	        {
						   	     	   name :"月份",
						   	            type : 'category',
						   	            data : xvalue,
						   	            axisTick: {
						   	                alignWithLabel: true
						   	            },
						   			nameTextStyle: {
						   				color: "#666666"
						   			},
						   			axisLabel: {
						   				show: true,
						   				interval: 0,
						   				rotate:-30,
						   				textStyle: {
						   			    color: "#666666"
						   				}
						   			},
						   			splitLine: {
						   				show: false,
						   				color: "#C2C9D1"
						   			},
						   			axisLine: {
						   				lineStyle: {
						   					color: "#E7EBEF",
						   					width: 2,
						   					type: "solid"
						   				}
						   			}
						   	     }],
						   	    yAxis : [
						   	        {
						   	        	name: "次数",
						   	 		nameTextStyle: {
						   	 			color: "#666666"
						   	 		},
						   	            type : 'value',
						   	            
						   	         axisLabel: {
						   				show: true,
						   				textStyle: {
						   					color: "#666666"
						   				}
						   			},
						   			axisLine: {
						   				lineStyle: {
						   					color: "#E7EBEF",
						   					width: 2,
						   					type: "solid"
						   				}
						   			}
						   	        }
						   	    ],
						   	    series : [
						   	        {
						   				itemStyle: {
						   					normal: {
						   						color: "#26C6DA",
						   						label: {
						   							show: true,
						   							position: "top"
						   						}

						   					}
						   				},
						   	            name:'超期',
						   	            type:'bar',
						   	            barWidth: '30',
						   	     	barGap: "30%",
						   			symbolSize: 8,
						   	            data:yvalue
						   	        }
						   	    ]
					    };
					}
					   	          
					obj.setOption(option);	
					}
				},
				error : function(req, error, errObj) {
				}
			});
		}
		//项目首页统计分析页面查询报警总数
		function queryAlarms(beginTime, endTime) {
			$.ajax({
				type : "post",
				url : "${ctx}/elevator/elevatorProjectPage/queryAlarms?beginTime=" + beginTime + "&endTime=" + endTime + "&projectCode=" + projectCode + "&deviceId=" + deviceId,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						var returnVal = data.RETURN_PARAM;
						$("#query_alarms").html(returnVal.alarms);
					} else {
						showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
					}
				},
				error : function(req, error, errObj) {
				}

			});

		}

		//项目首页统计分析页面查询报警总数(旧方法不支持，写新方法支持结束时间点)
		function queryAlarmsV2(beginTime, endTime) {
			var beginTime = beginTime+" 00:00:00";
			var endTime = endTime+" 23:59:59";
			$.ajax({
				type : "post",
				url : "${ctx}/elevator/elevatorProjectPage/queryAlarmsV2?beginTime=" + beginTime + "&endTime=" + endTime + "&projectCode=" + projectCode + "&deviceId=" + deviceId,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						var returnVal = data.RETURN_PARAM;
						$("#query_alarms").html(returnVal.alarms);
					} else {
						showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
					}
				},
				error : function(req, error, errObj) {
				}

			});

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
			return y + "-" + m + "-" + d;
		}

		//维保超期查询月份
		function getNowDate(addMonthNum) {
			var dd = new Date();
			dd.setMonth(dd.getMonth()+1 - (addMonthNum-1));//获取addMonthNum月后的日期
			var y = dd.getFullYear();
			//获取当前月份的日期
			var m = dd.getMonth();
			if(m == 0){
				y = y-1;
				m = 12;
			}
			if (m.toString().length == 1) {
				m = '0' + m;
			};
			return y + "-" + m;
		}
		
		$("#btn_query").click(function(){
			rangeTimeQuqeryFunc();
		});

		function getDataV2(id, divId, startTime, endTime) {
			var startTime = startTime +" 00:00:00";
			var endTime = endTime +" 23:59:59";
			$.ajax({
				type : "post",
				url : "${ctx}/report/" + id + "?beginTime=" + startTime + "&endTime=" + endTime + "&projectCode=" + projectCode + "&deviceId=" + deviceId,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					var obj = echarts.init(document.getElementById(divId));
					obj.setOption($.parseJSON(data));
				},
				error : function(req, error, errObj) {
				}
			});
		}
		
		function rangeTimeQuqeryFunc(){
			rangeTimeQuery = 1;
			var startTime = $("#startTimePicker").val();
			var endTime = $("#endTimePicker").val();
			if(startTime==null || startTime==""){
				showAlert('warning', '开始时间不能为空', "startTimePicker", 'bottom');
				return;
			}
			if(endTime==null || endTime==""){
				showAlert('warning', '结束时间不能为空', "endTimePicker", 'bottom');
						return;
			}
			if(endTime < startTime ){
				showAlert('warning', '结束时间不能小于开始时间', "endTimePicker", 'bottom');
				return;
			}
			
			queryAlarmsV2(startTime,endTime);
			getDataV2(136, "statistical_analysisIndex",startTime,endTime);
			$("#btn_query").addClass("selected").parent().siblings().children("button").removeClass("selected");
		}
	</script>
</body>
</html>