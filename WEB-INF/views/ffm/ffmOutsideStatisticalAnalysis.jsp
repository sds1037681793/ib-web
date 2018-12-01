<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<script type="text/javascript" src="${ctx}/static/busi/ffmStatisticalAnalysis.js"></script>

<!DOCTYPE html>
<html>
<head>
	<link href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
	<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript" ></script>
	<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
	<style type="text/css">
.content-select {
    background-color: #fff;
    border: 1px solid #e1e1e1;
}
.menu_active{
	font-family: PingFangSC-Light;
	font-size: 18px;
	display:block;
	text-align:center; 
	color: #666;
	float:left;
	line-height:60px;
	cursor: pointer;
}
.checked_active{
	font-family: PingFangSC-Light;
	font-size: 18px;
	color: #00BFA5;
	letter-spacing: 0;
}
.statistics_style{
	width:819px;
	height:420px;
	float:left;
}
.div_style_one{
	margin-left:30px;
	margin-top:38px;
	width:192px;
	height:22px;
	font-size: 16px;
	color: #444444;
	float:left;
}
.div_style_two{
	margin-left:380px;
	margin-top:36px;
	width:192px;
	height:22px;
	font-size: 16px;
	color: #444444;
	float:left;
}
.div_style_three{
	float:left;
	width:770px;
	height:330px;
	margin-top:20px;
	margin-left:20px;
}
</style>
</head>
<body>
	<div class="content-select" style="min-width: 1620px;height:900px;">
		<div style="width:100%;height:62px;border: 1px solid #E1E1E1;">
			<div id="fire_alarm" class="menu_active" style="margin-left: 665px;width:144px;" onclick="onclickSpan(this)">户外消防系统</div>
			<div id="fire_water" class="menu_active" style="margin-left:67px;"onclick="onclickSpan(this)">消防水系统</div>
			<div id="fire_checked" style="position: absolute;left: 685px;top: 114px;background: #00BFA5;width:150px;height:2px;"></div>
		</div>
		<!--消防报警联动系统 -->
		<div id="fire-alarm-link" style="width:100%;height:840px;">
		<!--消防报警联动系统事件统计 -->
		<div class="statistics_style">
		<div class="div_style_one">户外消防事件统计</div>
		<div class="div_style_two" id="fire-alarm-dropdownlist"></div>
		<!-- 此处为报表 -->
		<div id="alarm_system_form" class="div_style_three"></div>
		<div id="alarm_system_form_no" style="text-align: center; display:none"><img class="item-img" style="margin-right: 197px;margin-top: 125px;" src="${ctx}/static/img/ffm/wushuju.png"/></div>
		</div>
		<!--历史火警次数前10名统计 -->
		<div class="statistics_style">
		<div class="div_style_one">历史火警次数前10名统计</div>
		<div class="div_style_two" id="fire-history-dropdownlist"></div>
		<!-- 此处为报表 -->
		<div id="alarm_history_form" class="div_style_three"></div>
		<div id="alarm_history_form_no" style="text-align: center; display:none"><img class="item-img" style="margin-right: 197px;margin-top: 125px;" src="${ctx}/static/img/ffm/wushuju.png"/></div>
		</div>
		<!--火警确认结果统计 -->
		<div class="statistics_style">
		<div class="div_style_one">火警确认结果统计</div>
		<div class="div_style_two" id="fire-dropdownlist"></div>
		<div class="div_style_three" id="fire-confirm-echarts"></div><!-- style="padding-left:100px;" --> 
		<div id="fire-confirm-echarts_no" style="text-align: center; display:none"><img class="item-img" style="margin-right: 197px;margin-top: 125px;" src="${ctx}/static/img/ffm/wushuju.png"/></div>
		</div>
		<!--历史故障次数前10名统计 -->
		<%-- <div class="statistics_style">
		<div class="div_style_one">历史故障次数前10名统计</div>
		<div class="div_style_two" id="fault-history-dropdownlist"></div>
		<div id="fault_history_form" class="div_style_three"></div>
		<div id="fault_history_form_no" style="text-align: center; display:none"><img class="item-img" style="margin-right: 197px;margin-top: 125px;" src="${ctx}/static/img/ffm/wushuju.png"/></div>
		</div> --%>
		</div>
		<!-- 消防水系统 -->
		<div id="fire-water" style="width:100%;height:840px;">
		<!-- 消防水系统事件统计 -->
		<div class="statistics_style">
		<div class="div_style_one">消防水系统事件统计</div>
		<div class="div_style_two" id="fire-water-dropdownlist"></div>
		<div id="waterSystemStatistics" class="div_style_three"></div>
		</div>
		<div class="statistics_style">
		<!-- 水压异常确认结果统计 -->
		<div class="div_style_one">水压异常确认结果统计</div>
 		<div class="div_style_two" id="abnormal-water-dropdownlist"></div>
 		<div style="text-align: center;"><img class="item-img" style="margin-right: 197px;margin-top: 125px;" src="${ctx}/static/img/ffm/wushuju.png"/></div>
		</div>
		</div>
	</div>
	
 	<script type="text/javascript"> 
		var fireAlarmList;
		var fireHistoryList;
		var fireList;
		var faultHistoryList;
		var abnormalWaterList;
		var fireWaterList;
		var result = 0; 
		var day;
		var data;
		var nowTime = "${today}";
	 	$(document).ready(function(){
	 		$("#fire_alarm").addClass("checked_active");
	 		$("#fire-water").hide();
 			fireAlarmList = $("#fire-alarm-dropdownlist").dropDownList({
 				inputName: "fireAlarmName",
 				inputValName: "fireAlarm",
 				buttonText: "",
 				width: "116px",
 				readOnly: false,
 				required: true,
 				maxHeight: 200,
 				onSelect: function(i, data, icon) {
 					getAlarmSystemEchart("alarm_system_form", data);
 				},
 				items: [{itemText:'今天',itemData:'1'},{itemText:'最近7天',itemData:'2'},{itemText:'本月',itemData:'3'},{itemText:'本年',itemData:'4'}]
 			});
 			fireAlarmList.setData("今天", "1", "");
 			
			fireHistoryList = $("#fire-history-dropdownlist").dropDownList({
				inputName: "fireHistoryName",
				inputValName: "fireHistory",
				buttonText: "",
				width: "116px",
				readOnly: false,
				required: true,
				maxHeight: 200,
				onSelect: function(i, data,icon) {
					getDivDataByTime("132", "alarm_history_form",data);
					},
				items: [{itemText:'今天',itemData:'1'},{itemText:'最近7天',itemData:'2'},{itemText:'本月',itemData:'3'},{itemText:'本年',itemData:'4'}]
			});
			fireHistoryList.setData("今天", "1", "");
			
		fireList = $("#fire-dropdownlist").dropDownList({
			inputName: "fireName",
			inputValName: "fire",
			buttonText: "",
			width: "116px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {
				var type = data;
				if(type==undefined){
					return;
				}else{
					var today = new Date();
					var year = today.getFullYear();
					var month = today.getMonth() + 1;
					var day = today.getDate();
					month < 10 ? month = '0' + month : month;
					day < 10 ? day = '0' + day : day;
					
			 		var preDate = new Date((new Date()).getTime() - 24*7*60*60*1000);
			 		var preYear=preDate.getFullYear();
					var preMonth = preDate.getMonth() + 1;
					var preday = preDate.getDate();
					preMonth < 10 ? preMonth = '0' + preMonth : preMonth;
					preday < 10 ? preday = '0' + preday : preday;
					
					var currentDay = year + '-' + month + '-' + day;
			 		var currentMonth= year + '-' + month + '-01';
			 		var currentYear= year + '-01-01';
					var lastDay=preYear + '-' + preMonth + '-' + preday;
					//时间类型选择
					if(type=="1"){
						getBingEchart(131, "fire-confirm-echarts",currentDay,currentDay);
					}else if(type=="2"){
						getBingEchart(131, "fire-confirm-echarts",lastDay,currentDay);
					}else if(type=="3"){
						getBingEchart(131, "fire-confirm-echarts",currentMonth,currentDay);
					}else if(type=="4"){
						getBingEchart(131, "fire-confirm-echarts",currentYear,currentDay);
					}
				}
			},
			items: [{itemText:'今天',itemData:'1'},{itemText:'最近7天',itemData:'2'},{itemText:'本月',itemData:'3'},{itemText:'本年',itemData:'4'}]
		});
		fireList.setData("今天", "1", "");
		
		faultHistoryList = $("#fault-history-dropdownlist").dropDownList({
			inputName: "faultHistoryName",
			inputValName: "faultHistory",
			buttonText: "",
			width: "116px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data,icon) {
				getFaultDivDataByTime("135", "fault_history_form",data);
				},
			items: [{itemText:'今天',itemData:'1'},{itemText:'最近7天',itemData:'2'},{itemText:'本月',itemData:'3'},{itemText:'本年',itemData:'4'}]
		});
		faultHistoryList.setData("今天", "1", "");
		
		fireWaterList = $("#fire-water-dropdownlist").dropDownList({
			inputName: "fireWaterName",
			inputValName: "fireWater",
			buttonText: "",
			width: "116px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {
		 		getWaterSystemEchart("waterSystemStatistics", data);
			},
			items: [{itemText:'今天',itemData:'1'},{itemText:'最近7天',itemData:'2'},{itemText:'本月',itemData:'3'},{itemText:'本年',itemData:'4'}]
		});
		fireWaterList.setData("今天", "1", "");
		
		abnormalWaterList = $("#abnormal-water-dropdownlist").dropDownList({
			inputName: "abnormalWaterName",
			inputValName: "abnormalWater",
			buttonText: "",
			width: "116px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			items: [{itemText:'今天',itemData:'1'},{itemText:'最近7天',itemData:'2'},{itemText:'本月',itemData:'3'},{itemText:'本年',itemData:'4'}]
		});
		abnormalWaterList.setData("今天", "1", "");
		
		//火警确认结果统计饼图
		getBingEchart(131, "fire-confirm-echarts",nowTime,nowTime);
	 	});

	 	
	 //(消防报警联动系统/消防水系统)切换
 	 function onclickSpan(obj){
	     	$(".menu_active").removeClass("checked_active");
	     	$(obj).addClass("checked_active");
	     	var id = obj.id;
 	 		if(id == "fire_alarm"){
 	 			$("#fire-alarm-link").show();
 	 			$("#fire-water").hide();
 	 			$("#fire_checked").css({ "left": "685px","top": "114px","display":"block"});
 	 			fireAlarmList.setData("今天", "1", "");
 	 			fireHistoryList.setData("今天", "1", "");
 	 			faultHistoryList.setData("今天", "1", "");
 	 			getAlarmSystemEchart("alarm_system_form", 1);
 	 			getDivDataByTime("132", "alarm_history_form",1);
 	 			getFaultDivDataByTime("135", "fault_history_form",1);
 	 			getBingEchart(131, "fire-confirm-echarts",nowTime,nowTime);
 	 		}else if(id == "fire_water"){
 	 			$("#fire-alarm-link").hide();
 	 			$("#fire-water").show();
 	 			$("#fire_checked").css({ "left": "870px","top": "114px","display":"block"});
 	 			fireWaterList.setData("今天", "1", "");
 	 			getWaterSystemEchart("waterSystemStatistics", 1);
 	 		}
	     }
	 
 	//消防火警次数统计报表
  	function getDivDataByTime(id, divId,datas) {
  		var beginTime = 0;
		var endTime = -1;
  		getDays();
 		if(datas==1){
 			beginTime = 0;
 			endTime = -1;
 		}else if(datas==2){
 			beginTime = 6;
 			endTime = -1;
 		}else if(datas==3){
 			beginTime = day-1;
 			endTime = -1;
 		}else if(datas==4){
 			beginTime = result-1;
 			endTime = -1;
 		}
 		$.ajax({
 			type : "post",
 			url : "${ctx}/report/" + id + "?beginTime=" + beginTime
 					+ "&endTime=" + endTime+"&projectCode="+projectCode,
 			async : false,
 			contentType : "application/json;charset=utf-8",
 			success : function(data) {
 				var datas = $.parseJSON(data).series;
 				if(datas == ""){
 					$("#alarm_history_form").hide();
 					$("#alarm_history_form_no").show();
 					$("#fire-confirm-echarts").hide();
 					$("#fire-confirm-echarts_no").show();
 					
 				}else{
 					$("#alarm_history_form").show();
 					$("#alarm_history_form_no").hide();
 					$("#fire-confirm-echarts").show();
 					$("#fire-confirm-echarts_no").hide();
 				var obj = echarts.init(document.getElementById(divId));
 				obj.clear();
 				obj.setOption($.parseJSON(data));
 				}
 			},
 			error : function(req, error, errObj) {
 			}
 		});
 	}
 	
  	function getFaultDivDataByTime(id, divId,data){
  		var beginTime = 0;
		var endTime = -1;
  		getDays();
 		if(data==1){
 			beginTime = 0;
 			endTime = -1;
 		}else if(data==2){
 			beginTime = 6;
 			endTime = -1;
 		}else if(data==3){
 			beginTime = day-1;
 			endTime = -1;
 		}else if(data==4){
 			beginTime = result-1;
 			endTime = -1;
 		}
 		$.ajax({
 			type : "post",
 			url : "${ctx}/report/" + id + "?beginTime=" + beginTime
 					+ "&endTime=" + endTime+"&projectCode="+projectCode,
 			async : false,
 			contentType : "application/json;charset=utf-8",
 			success : function(data) {
 				var datas = $.parseJSON(data).series;
 				if(datas == ""){
 					$("#fault_history_form").hide();
 					$("#fault_history_form_no").show();
 				}else{
 					$("#fault_history_form").show();
 					$("#fault_history_form_no").hide();
 				var obj = echarts.init(document.getElementById(divId));
 				obj.clear();
 				obj.setOption($.parseJSON(data));
 				}
 			},
 			error : function(req, error, errObj) {
 			}
 		});
  	}
  	
    //获取本月本年天数
 	function getDays(){
 		result = 0;
 		var dateArr = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);  
 		var date = new Date();  
 		day = date.getDate();  
 		var month = date.getMonth(); //getMonth()是从0开始  
 		var year = date.getFullYear();  
 		for ( var i = 0; i < month; i++) {  
 		    result += dateArr[i];  
 		}  
 		result += day;  
 		//判断是否闰年  
 		if (month > 1 && (year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {  
 		    result += 1;  
 		}  
 	}
    
 	//组装消防火警系统事件统计图ECharts
 	function getAlarmSystemEchart(divId, timeType) {
 		if (timeType == undefined || timeType == "") {
 			timeType = 1;
 		}
 		var zoomData = '';
 		if (timeType == 1 || timeType == 3) {
 			zoomData = [
 				{
 					type : 'inside',
 					start : 50,
 					end : 100,
 					startValue : 0,
 					endValue : 0
 				}
 			];
 		} else {
 			zoomData = '';
 		}
 		$.ajax({
 			type : "post",
 			url : ctx + "/fire-fighting/fireAlarmSystem/getOutsideAlarmSystemStatistics?timeType=" + timeType + "&projectCode=" + projectCode,
 			async : true,
 			contentType : "application/json;charset=utf-8",
 			success : function(data) {
 				if (data != null && data.length > 0) {
 					var date = new Date();
 					var strDate = date.getDate();
 					var width;
 					// 当选择条件为本月(timeType=3)时适当修改条形宽度
 					if (timeType == 3 && strDate <= 10) {
 						width = 35;
 					} else if (timeType == 3 && strDate <= 20) {
 						width = 25;
 					} else if (timeType == 3 && strDate > 20) {
 						width = 15;
 					}
 					if (timeType != 3) {
 						width = 35;
 					}
 					var timeArr = [];
 					var fireStatusNumArr = [];
 					var slbaNumArr = [];
 					var slfaNumArr = [];
 					var soaNumArr = [];
 					var tpaNumArr = [];
 					var num = 0;
 					$(eval(data)).each(function() {
 						timeArr[timeArr.length] = this.timeSpan;
 						fireStatusNumArr[fireStatusNumArr.length] = this.fireStatusNum;
 						slbaNumArr[slbaNumArr.length] = this.slbaNum;
 						slfaNumArr[slfaNumArr.length] = this.slfaNum;
 						soaNumArr[soaNumArr.length] = this.soaNum;
 						tpaNumArr[tpaNumArr.length] = this.tpaNum;
 						num = num+this.fireStatusNum+this.slbaNum+this.slfaNum + this.soaNum + this.tpaNum;
 					});
 	                if(num>0){
 	                	$("#alarm_system_form").show();
 	                	$("#alarm_system_form_no").hide();
 	                	num = 0;
 	                }else{
 	                	$("#alarm_system_form").hide();
 	                	$("#alarm_system_form_no").show();
 	                	num = 0;
 	                }
 					var obj = echarts.init(document.getElementById(divId));
 					obj.clear();
 					var option = {
 						tooltip : {
 							trigger : 'axis',
 							axisPointer : { // 坐标轴指示器，坐标轴触发有效
 								type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
 							}
 						},
 						
 						legend : {
 							data : [
 									'火警        ', '低电压报警        ', '烟感失联报警        ', '底座防拆报警        ', '温度超限报警'
 							],
 							icon : 'circle'
 						},
 						grid : {
 							left : '3%',
 							right : '6%',
 							bottom : '13%',
 							containLabel : true
 						},
 						dataZoom: zoomData,
 					    calculable: true,
 						xAxis : {
 							name :'时间',
 							nameTextStyle:{
 			                    color:'#666666' 
 			                  },
 							type : 'category',
 							axisLabel : {
 			                      show : true,
 			      				interval:0,
 			                      textStyle : {
 			                      color : '#666666'
 			                      }
 			                  },
 							nameGap : 8,
 							data : timeArr,
 							axisLine: {
 				                  lineStyle:{
 				            color:'#C2C9D1',
 							width:1,
 				      		type:'solid'
 				      	}
 				              },
 						
 						},
 					          yAxis: [
 					                    {
 					            						name :'次数',

 					            						nameTextStyle:{
 					                          color:'#666666'
 					                        },
 					            boundaryGap:[0, 0.1],

 					            minInterval : 1, 
 					                        type: "value",
 					                        boundaryGap:[0, 0.1],
 										    minInterval : 1, 
 					            			axisLabel : {
 					                            show : true,
 					                            textStyle : {
 					                            color : '#666666'
 					                            }
 					                        },
 					            			axisLine: {
 					                        lineStyle:{
 					            		color:'#E7EBEF',
 					            		width:2,
 					            		type:'solid'
 					            	}
 					                    }
 					                    }
 					                ],
 						color : [
 								'#4DA1FF', '#FFDC73', '#EF9393'
 						],
 						barWidth : 35,
 						series : [
								{
									name : '温度超限报警',
									type : 'bar',
									stack : '总量',
									data : tpaNumArr
								},
								{
									name : '底座防拆报警        ',
									type : 'bar',
									stack : '总量',
									data : soaNumArr
								},
 								{
 									name : '烟感失联报警        ',
 									type : 'bar',
 									stack : '总量',
 									data : slfaNumArr
 								}, {
 									name : '低电压报警        ',
 									type : 'bar',
 									stack : '总量',
 									data : slbaNumArr
 								}, {
 									name : '火警        ',
 									type : 'bar',
 									stack : '总量',
 									data : fireStatusNumArr
 								}
 						]
 					};
 					obj.setOption(option);
 				}
 			},
 			error : function(req, error, errObj) {
 			}
 		});
 	}
 	</script> 
</body>
</html>