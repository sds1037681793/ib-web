<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<link href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
	<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript" ></script>
	<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
	<style type="text/css">
 .menu{ 
 	font-family: PingFangSC-Regular;
	font-size: 12px;
	color: #4A4A4A;
 	cursor:pointer;
 	display:block;
 	width:84px;
 	height:26px;
 	line-height: 28px;
 	text-align: center;
 	border-radius: 4px 4px 0px 0px ;
 	box-shadow: inset 0 1px 0 0 #E1E1E1, inset -1px 0 0 0 #E1E1E1, inset 1px 0 0 0 #E1E1E1;
 } 
.menu_active{
	font-family: PingFangSC-Light;
	font-size: 12px;
	display:block;
	width:48px;
	text-align:center; 
 	height:30px;
	letter-spacing: 0;
	line-height: 30px;
	color:#999;
}
.menu_time{
	height:30px;
	width:60px;
	text-align:center; 
	line-height: 30px;
	outline: none; 
	cursor:pointer;
	background-color: #FFF;
	font-size: 12px;
	color: #666;
	display:block;
}
.checked_time{
	font-family: PingFangSC-Regular;
	font-size: 12px;
	color: #FFF;
	letter-spacing: 0;
	background: #00C0A6;
}
.checked_active{
	font-family: PingFangSC-Light;
	font-size: 12px;
	color: #00BFA5;
	letter-spacing: 0;
	box-shadow: 0px 2px 0px 0px #00BFA5;
}
.checked{
	font-family: PingFangSC-Regular;
	font-size: 12px;
	color: #00BFA5;
	background: #FFFFFF;
	box-shadow: inset 0 2px 0 0 #00BFA5, inset -1px 0 0 0 #E1E1E1, inset 1px 0 0 0 #E1E1E1;
}
.word_limit {
	display: inline-block;
	*display: inline;
	*zoom: 1;
	width: 20em;
	height: 20px;
	line-height: 20px;
	font-size: 12px;
	overflow: hidden;
	-ms-text-overflow: ellipsis;
	text-overflow: ellipsis;
	white-space: nowrap;
	font-size:14px;
}
.td_style{
	width:100px;
	height: 25px;
}

</style>
</head>
<body>
	<div class="" style="font-size: 14px;margin-left: 10px;margin-right: 10px;">
		<div style="margin-top:20px;background: #FFFFFF;box-shadow: 0 1px 0 0 #E1E1E1;">
			<span id="summary_detail" class="menu" style="margin-left:10px;" onclick="onclickInput(this)">实时概况</span>
<!-- 			<span id="alarm_record" class="menu" style="margin-left:100px;margin-top:-26px;"onclick="onclickInput(this)">报警记录</span> -->
		</div>
		<div id="div_model" style="height:auto;overflow:scroll;overflow:hidden;margin-left:20px;"><!-- class="a" -->
			<div style="position:relative; width:370px;float:left;">
			<div style="position:relative; width:200px;margin-top: 20px;">
			<img style="width:200px;height:200px;" src="${ctx}/static/images/powerSupply/meter.png"/>
			<div  id=activeElectricity style="position:absolute; top:35px;text-align: center;width:200px;height:20px;color:#000;font-size:22px;">
	 		--</div><div style="position:absolute; top:55px;text-align: center;width:200px;height:20px;color:#000;font-size:12px;">kWh</div>
			</div>
			<div style="height:25px; text-align: center;position:relative;width:200px;margin-left: 20px;">
			<div style="width:80px;float:left;text-align: right;">
			<img id="alarm" style="width:24px;height:24.1px;" src="${ctx}/static/images/powerSupply/wubaojing.svg" >
			</div>
			<div style="color:#666;font-size:24px;text-algin:center;float:left;margin-left:10px; margin-top:3px;">0</div>
			</div>
			<div style="position:relative;color: #000;margin-top:10px;">
			<table style="width:370px;color: #666666;">
			<tr>
			<td colspan="3" id="deviceLocation" class="td_style"><div style="float:left;"><img style="width:15.3px;height:20.1px;" src="${ctx}/static/images/powerSupply/dingdian.svg"/></div><div id="locationInfo" class="word_limit" style="float:left;margin-left:10px;margin-top: 5px;cursor: pointer;" target="_blank" data-toggle="tooltip" title=""></div>
			</td>
			</tr>
			<tr>
			<td colspan="3" id="deviceNo" class="td_style"><div style="float:left;">设备编号： </div><div id="deviceNumber" class="word_limit" style="float:left;cursor: pointer;" target="_blank" data-toggle="tooltip" title="">
			</div></td>
			</tr>
			<tr>
			<td colspan="3" id="level" class="td_style">电表级别：</td>
			</tr>
			<tr>
			<td colspan="3" id="meterStructure" class="td_style"><div style="float:left;">上级电表： </div><div id="parentMeter" class="word_limit" style="float:left;cursor: pointer;" target="_blank" data-toggle="tooltip" title="">
			</div></td>
			</tr>
			<tr>
			<td id="powerFactor" class="td_style">功率因数：</td>
			</tr>
			<tr>
			<td id="multiply" class="td_style">电表倍率：</td>
			</tr>
			<tr>
			<td id="Uab" class="td_style">Uab：</td>
			<td id="Ubc" class="td_style">Ubc：</td>
			<td id="Uca" class="td_style">Uca：</td>
			</tr>
			<tr>
			<td id="Ua" class="td_style">Ua：</td>
			<td id="Ub" class="td_style">Ub：</td>
			<td id="Uc" class="td_style">Uc：</td>
			</tr>
			<tr>
			<td id="Ia" class="td_style">Ia：</td>
			<td id="Ib" class="td_style">Ib：</td>
			<td id="Ic" class="td_style">Ic：</td>
			</tr>
			</table>
		</div>
		</div>
		<div style="position:relative; width:580px;cursor: pointer;float:left;">
			<div style="margin-top:20px;margin-left:50px;">
			<span id="active_electricity" class="menu_active" onclick="onclickSpan(this)">有功电量</span>
			<span id="reactive_power" class="menu_active" style="margin-left: 90px;margin-top: -30px;"onclick="onclickSpan(this)">无功电量</span>
			</div>
			<div id="meter_Type_resident" style="margin-left:390px;margin-top:10px;font-size:0;">
			<span id="today" class="menu_time"  style="border-radius: 4px 0px 0px 4px;border:1px solid #00BFA5;border-right:0;" onclick="onclickTime(this)">今日</span>
			<span id="this_month" class="menu_time" style="margin-left: 60px;margin-top: -30px;border:1px solid #00BFA5;border-right:0;" onclick="onclickTime(this)">本月</span>
			<span id="this_year" class="menu_time" style="margin-left:120px;margin-top:-30px;border-radius: 0px 4px 4px 0px;border:1px solid #00BFA5;" onclick="onclickTime(this)">本年</span>
			</div>
			<div id="meter_Type_apartment" style="margin-left:450px;margin-top:10px;font-size:0;">
			<span id="this_month" class="menu_time"  style="border-radius: 4px 0px 0px 4px;border:1px solid #00BFA5;border-right:0;" onclick="onclickTime(this)">本月</span>
			<span id="this_year" class="menu_time" style="margin-left:60px;margin-top:-30px;border-radius: 0px 4px 4px 0px;border:1px solid #00BFA5;" onclick="onclickTime(this)">本年</span>
			</div>
						<!-- echarts -->
			<div style="width:580px;height:400px;margin-top:10px;">
				<div style="width: 570px; height: 400px; margin-left:20px;" id="realTime_data">
				</div>
			</div>
		</div>
	</div>
	<!-- 报警记录列表页面 -->
<!-- 	<table id="tb-alarmData" style="border: 1px solid; height:99%; width:99%; margin:0 auto; min-width: 750px;" > -->
<!-- 		<tr><th rowspan="" colspan=""></th></tr> -->
<!-- 	</table> -->
<!-- 	<div id="pg" style="text-align: right;"></div> -->
<!-- 	<div id="datetimepicker-div"></div> -->
	</div>

 	<script type="text/javascript"> 
	 	var  isAlarm;
	 	var deviceId="${param.deviceId}";//设备id
	 	var meterType="${param.meterType}";//电表类型
	 	var meterLevel="${param.level}";
	 	var tbAlarmEvent;
		var activeType="1";//有功功率
		var showTimeType="1";//今日
		if(meterType=="1"){//1.居民楼，2.供配电
			showTimeType="2";//本月
		}
		var meterDetailData;
	 	$(document).ready(function(){
	 		document.getElementById('summary_detail').className="checked menu";
	 		document.getElementById('active_electricity').className="checked_active menu_active";
	 		if(meterType=="1"){
	 			$("#meter_Type_resident").remove();
	 			document.getElementById('this_month').className="checked_time menu_time";
	 		}else{
	 			$("#meter_Type_apartment").remove();
		 		document.getElementById('today').className="checked_time menu_time";
	 		}
// 			$("#tb-alarmData").hide();
// 			$("#pg").hide();
			showEchart(activeType,showTimeType,deviceId);
			initMeterData();
			//定时获取环境数据
			setInterval(initMeterData,15*60000);
			//$('#ddl-btn-floorName').removeAttr("disabled");
	 		//initPage();
	 	});//overflow:scroll;overflow:-moz-scrollbars-vertical;
	 	
	 	//切换展示模式(电表数据展示模式和报警列表模式)
	 	 function onclickInput(obj){
	     	$(".menu").removeClass("checked");
	     	$(obj).addClass("checked");
	     	var id = obj.id;
			$("#div_model").show();
// 			if ( id == "summary_detail"){
// 				$("#tb-alarmData").hide();
// 				$("#pg").hide();
// 				$(".mmGrid").hide();
// 			}else if(id == "alarm_record"){
// 				$("#div_model").hide();
// 				$("#tb-alarmData").show();
// 				$("#pg").show();
// 				$(".mmGrid").show();
// 				//showTableModel();
// 			}
	     }
	 	 //==============================================展示报表数据业务=======================================================
	 	//有功无功用电量选择
	 	 function onclickSpan(obj){
		     	$(".menu_active").removeClass("checked_active");
		     	$(obj).addClass("checked_active");
		     	var id = obj.id;
	 	 		if(id == "active_electricity"){
	 	 			activeType="1";
	 	 		}else if(id == "reactive_power"){
	 	 			activeType="2";
	 	 		}
	 	 		var timeType =document.getElementsByClassName("checked_active")[0];
	 	 		if(timeType.id=="today"){
	 	 			showTimeType="1";
	 	 		}else if(timeType.id=="this_month"){
	 	 			showTimeType="2";
	 	 		}else if(timeType.id=="this_year"){
	 	 			showTimeType="3";
	 	 		}
	 	 		showEchart(activeType,showTimeType,deviceId);
	 	 		
		     }
	 	 //时间类型选择
	 	 function onclickTime(obj){
		     	$(".menu_time").removeClass("checked_time");
		     	$(obj).addClass("checked_time");
	 	 		if(obj.id=="today"){
	 	 			showTimeType="1";
	 	 		}else if(obj.id=="this_month"){
	 	 			showTimeType="2";
	 	 		}else if(obj.id=="this_year"){
	 	 			showTimeType="3";
	 	 		}
	 			var active =document.getElementsByClassName("checked_active")[0];
	 			if(active.id=="active_electricity"){
	 				activeType="1";
	 			}else if(active.id== "reactive_power"){
	 				activeType="2";
	 			}
	 			showEchart(activeType,showTimeType,deviceId);
		     }

	 	 function showEchart(activeType,showTimeType,deviceId){
	 		var timeLine=new Array();
	 		var meterValue=new Array();
	 		
	 		var startTime=0;
	 		var endTime=50;
	 		$.ajax({
	 			type : "post",
	 			url : "${ctx}/power-supply/pdsElectricityMeterRecord/meterRealDataReport?deviceId="+deviceId+"&showTimeType="+showTimeType,
	 			contentType : "application/json;charset=utf-8",
	 			async:false,
	 			success : function(data) {
	 				if(data!=null && data.code==0 && data.data!=null){
	 					var dataLength = data.data.length;
	 					var today = new Date();
	 					var month = today.getMonth() + 1;
	 					var day = today.getDate();
	 					var hour = today.getHours();
	 					var thisMonth=month < 10 ? thisMonth = '0' + month : month;
	 					if(dataLength==0){
	 						if(showTimeType==3){
	 							for (var i = 0; i < 12; i++) {
	 								meterValue.push(0.00);
	 								if(i+1<10){
	 									timeLine.push("0"+(i+1)+"月");
	 								}else{
	 									timeLine.push(i+1+"月");
	 								}
	 							}
	 						}else if(showTimeType==1){
	 							for (var i = 0; i < 24; i++) {
	 								meterValue.push(0.00);
	 								if(i+1<10){
	 									timeLine.push("0"+(i+1)+":00");
	 								}else{
	 									timeLine.push(i+1+":00");
	 								}
	 							}
	 						}
						
	 					}else{
	 					for (var i = 0; i < dataLength; i++) {
	 					if(showTimeType==3){
	 						if(month<=i+1){
	 							meterValue.push(0.00);
	 						}else{
	 							if(activeType==2){
	 								if(data.data[i].positiveReactivePower==null){
	 									meterValue.push(0.00);
	 								}else{
		 								meterValue.push(data.data[i].positiveReactivePower);
	 								}
	 							}else{
	 								if(data.data[i].activeElectricity==null){
	 									meterValue.push(0.00);
	 								}else{
		 								meterValue.push(data.data[i].activeElectricity);
	 								}
	 							}
	 						}
	 						timeLine.push(data.data[i].timeLine);
	 					}else if(showTimeType==2){
	 						if(day-1<=i){
	 							meterValue.push(0.00);
	 						}else{
	 							if(activeType==2){
	 								if(data.data[i].positiveReactivePower==null){
	 									meterValue.push(0.00);
	 								}else{
		 								meterValue.push(data.data[i].positiveReactivePower);
	 								}
	 							}else{
	 								if(data.data[i].activeElectricity==null){
	 									meterValue.push(0.00);
	 								}else{
		 								meterValue.push(data.data[i].activeElectricity);
	 								}
	 							}
	 						}
	 						timeLine.push(thisMonth+"-"+data.data[i].timeLine);
	 					}else if(showTimeType==1){
	 						if(hour<i+1){
	 							meterValue.push(0.00);
	 						}else{
	 							if(activeType==2){
	 								if(data.data[i].positiveReactivePower==null){
	 									meterValue.push(0.00);
	 								}else{
		 								meterValue.push(data.data[i].positiveReactivePower);
	 								}
	 							}else{
	 								if(data.data[i].activeElectricity==null){
	 									meterValue.push(0.00);
	 								}else{
		 								meterValue.push(data.data[i].activeElectricity);
	 								}
	 							}
	 						}
	 						timeLine.push(data.data[i].timeLine);
 						}

 					}
	 			}
	 				if(showTimeType==3){
	 					endTime=100;
	 				}else if(showTimeType==2){
	 					var year = today.getFullYear();
	 					var monthDays=new Date(year,month,0).getDate();
 	 					if(day>monthDays/2){
	 						endTime=day*100/monthDays;
	 						startTime=(day*100-(monthDays+1)*50)/monthDays;
 	 					}
	 				}else if(showTimeType==1){
	 					if(hour>12){
	 						endTime=hour*100/24;
	 						startTime=(hour-12.5)*100/24;
	 					}
	 				}
	 					
	 				initMeterEcharts(timeLine,meterValue,startTime,endTime);
	 				} else {
	 					showDialogModal("error-div", "提示信息", data.MESSAGE, 1,
	 							null, true);
	 				}
	 			},
	 			error : function(req, error, errObj) {
	 			}
	 		});
	 	 }
	 	
	 	//电表读数echarts页面拼装
	 	function initMeterEcharts(timeLine,meterValue,startTime,endTime){
	 		var obj = echarts.init(document.getElementById("realTime_data"));
	 		obj.clear();
	 		var	option = {
	 				title: {
	 			        text: ''
	 			    },
	 			    tooltip : {
	 			        trigger: 'axis'
	 			    },
	 			    color:['#00E6FF','#8D4DE8'],
	 			    grid: {
	 			        left: '3%',
	 			        right: '4%',
	 			        bottom: '3%',
	 			       	top: '4%',
	 			        containLabel: true
	 			    },
	 			    xAxis : [
	 			        {
	 			            type : 'category',
	 			            boundaryGap : false,
	 			            axisLabel : {
	 			            	textStyle : {
	 							color: '#000',
	 					        fontSize:10
	 				            }
	 			            },
	 			            data : timeLine
	 			        }
	 			    ],
	 			    yAxis : [
	 			        {
	 			            type : 'value',
	 			            axisLabel : {
	 				            textStyle:{
	 								color: '#000',
	 						        fontSize:10
	 					            }
	 				            },
	 			        }
	 			    ],
	 		        dataZoom: [{
	 		           type: 'inside',
	 		           start: startTime,
	 		           end: endTime,
	 		           startValue:00,                           
	 		           endValue:50
	 		       }, {
	 		           start: 0,
	 		           end: 50,
	 		           height:0,
	 		           handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
	 		           handleSize: '0%',
	 		           handleStyle: {
	 		               color: '#FFF',
	 		               shadowBlur: 00,
	 		               shadowColor: '#FFF',
	 		               shadowOffsetX: 00,
	 		               shadowOffsetY: 00
	 		           }
	 		       }],
	 			    series : [
	 			        {
	 			            name:'读数',
	 			            type:'line',
	 			            smooth:true,//线条曲线化
	 			            areaStyle: {
	 							normal: {
	 								 color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	 				                        offset: 0,
	 				                        color: 'rgb(11,120,152)'
	 				                    }, {
	 				                        offset: 1,
	 				                        color: 'rgb(0,230,255)'
	 				                    }])
	 			            	}
	 			        	},
	 			        	data:meterValue
	 			        }
	 			    ]
	 			};
	 		obj.setOption(option);
	 		}
	 	//==============================================展示报表数据业务=======================================================
	 	//查询电表相关数据
 		function initMeterData(){
			if(meterLevel=="2"){
 	 			$("#level").html("电表级别： 二级电表");
 	 		}else if(meterLevel=="3"){
 	 			$("#level").html("电表级别： 三级电表");
 	 		}else if(meterLevel=="4"){
 	 			$("#level").html("电表级别： 四级电表");
 	 		}
 			document.getElementById("deviceNumber").title =deviceNo;
 			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/pdsElectricityMeterRecord/getMeterDetail?deviceId="+deviceId,
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if(data.code==0){
						meterDetailData = data.data;
						showMeterData(meterDetailData);
					} else {
						showDialogModal("error-div", "提示信息", data.MESSAGE, 1,
								null, true);
					}
				},
				error : function(req, error, errObj) {
				}
			});
 		}
	 	//展示电表数据
	 	function showMeterData(meterDetailData){
	 		if(meterDetailData.meterBoxName){
				var meterBoxName =meterDetailData.meterBoxName;
				if(meterDetailData.meterRoomName){
					var meterRoomName =meterDetailData.meterRoomName;
					var str = meterRoomName+"&nbsp;&nbsp;&nbsp;"+meterBoxName;
					$("#locationInfo").html("&nbsp;"+str);
					document.getElementById("locationInfo").title =meterRoomName+meterBoxName;
				}else{
					$("#locationInfo").html("&nbsp;"+meterBoxName);
					document.getElementById("locationInfo").title =meterBoxName;
				}
			}else{
				$("#locationInfo").html("&nbsp;--");
			}
		 	if(meterDetailData.parentMeterName){
				$("#parentMeter").html("&nbsp;"+meterDetailData.parentMeterName);
				document.getElementById("parentMeter").title =meterDetailData.parentMeterName;
		 	}else {
 				$("#parentMeter").html("&nbsp;--");
		 	}
	 		if(meterDetailData.deviceNo){
	 			$("#deviceNumber").html("&nbsp;"+meterDetailData.deviceNo);
	 		}
	 		if(meterDetailData.ua){
	 			$("#Ua").html("Ua：&nbsp;"+meterDetailData.ua);
	 		}else{
	 			$("#Ua").html("Ua：&nbsp; --");
	 		}
	 		if(meterDetailData.ub){
	 			$("#Ub").html("Ub：&nbsp;"+meterDetailData.ub);
	 		}else{
	 			$("#Ub").html("Ub： --");
	 		}
	 		if(meterDetailData.uc){
	 			$("#Uc").html("Uc： &nbsp;"+meterDetailData.uc);
	 		}else{
	 			$("#Uc").html("Uc： --");
	 		}
	 		if(meterDetailData.uab){
	 			$("#Uab").html("Uab：&nbsp;"+meterDetailData.uab);
	 		}else{
	 			$("#Uab").html("Uab：--");
	 		}
	 		if(meterDetailData.ubc){
	 			$("#Ubc").html("Ubc： &nbsp;"+meterDetailData.ubc);
	 		}else{
	 			$("#Ubc").html("Ubc：--");
	 		}
	 		if(meterDetailData.uca){
	 			$("#Uca").html("Uca： &nbsp;"+meterDetailData.uca);
	 		}else{
	 			$("#Uca").html("Uca：  --");
	 		}
	 		if(meterDetailData.ia){
	 			$("#Ia").html("Ia： &nbsp;"+meterDetailData.ia);
	 		}else{
	 			$("#Ia").html("Ia：--");//'<span style="visibility:hidden;">11</span>'+
	 		}
	 		if(meterDetailData.ib){
	 			$("#Ib").html("Ib： &nbsp;"+meterDetailData.ib);
	 		}else{
	 			$("#Ib").html("Ib： --");
	 		}
	 		if(meterDetailData.ic){
	 			$("#Ic").html("Ic： &nbsp;"+meterDetailData.ic);
	 		}else{
	 			$("#Ic").html("Ic： --");
	 		}
	 		if(meterDetailData.activeElectricity){
	 			$("#activeElectricity").html(meterDetailData.activeElectricity);
	 		}else{
	 			$("#activeElectricity").html("--");
	 		}
	 		if(meterDetailData.powerFactor){
	 			$("#powerFactor").html("功率因数： "+meterDetailData.powerFactor);
	 		}else{
	 			$("#powerFactor").html("功率因数： --");
	 		}
	 		if(meterDetailData.multiply){
	 			$("#multiply").html("电表倍率： "+meterDetailData.multiply);
	 		}
	 		if(meterDetailData.deviceNo){
	 			$("#deviceNumber").html("&nbsp;"+meterDetailData.deviceNo);
	 		}else{
	 			$("#deviceNumber").html("&nbsp; --");
	 		}
	 	}
	 	
	//==================================================报警列表页面=====================================================================	
// 	function showTableModel(){
// 	  	var infoCols = [
//                {title : '发生时间',name : 'timestamp',width : 100,sortable : true,align : 'center',hidden:true},
//                {title : '优先级',name : 'priorityLevel',width : 100,sortable : true,align : 'center'},
//                {title : '设备名称',name : 'deviceName',width : 150,sortable : true,align : 'center'},
//                {title : '报警事件',name : 'alarmEvent',width : 150,sortable : true,align : 'center'}
//            ]; 

// 	  	tbAlarmEvent = $('#tb-alarmData').mmGrid({
//               height:380,
//               cols:infoCols,
//               url:'${ctx}/power-supply/pdsElectricityMeterRecord/getMeterAlarmEvent',
//               method:'post',
//               params:function(){
//               	var data = {"": ""};
// 				$(data).attr({"deviceId": deviceId});
//               	return data;
//               	}, 
//               remoteSort:true,
//               sortName:'timestamp',
//               sortStatus:'desc',
//               multiSelect:false,
//               checkCol:false,
//               fullWidthRows:false,
//               showBackboard:false,
//               nowrap:true,
//               autoLoad:false,
//               plugins:[$('#pg').mmPaginator({"limitList":[10]})]
//           });
	
// 	  	tbAlarmEvent.on('cellSelect',function(e,item,rowIndex,colIndex){
// 			e.stopPropagation();
// 		}).on('loadSuccess',function(e,data) {
// 			//成功后添加定时任务
// 			//flushtbEnv = setTimeout("tbAlarmEvent.load()",300000);
// 		}).on('checkSelected', function(e, item, rowIndex) {
// 		}).on('checkDeselected', function(e, item, rowIndex) {
// 		}).on('loadError',function(req, error, errObj) {
// 			showDialogModal("error-div", "操作错误", "消息数据跟新失败：" + errObj);
// 		}).load();
// 	}
	//==================================================报警列表页面=====================================================================	
 	</script> 
</body>
</html>