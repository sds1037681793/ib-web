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
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/echarts/echarts.min.js" type="text/javascript"></script>
<script type="text/javascript"	src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript"	src="${ctx}/static/websocket/stomp.min.js"></script>
<script src="${ctx}/static/busi/socketMain.js" type="text/javascript"></script>
<title>水系统地图</title>
<style type="text/css">
.water_bg {
	background: url('${ctx}/static/img/waterMap/backgroundxiaof.png');
	width: 1631px;
	height: 897px;
	position: relative;
}

.water_info {
	position: absolute;
	left: 68px;
	top: 74px;
}

.water_head {
	font-size: 18px;
	color: #424242;
}

.font1 {
	font-size: 18px;
	color: #424242;
	margin-left: 20px;
}

.font2 {
	font-size: 14px;
	color: #424242;
	line-height: 20px;
	margin-left: 20px;
}

.water_status {
	height: 20px;
	line-height: 20px;
}

.water_icon {
	width: 16px;
	height: 20px;
	margin-top: -2px;
}

.point {
	width: 40px;
	height: 50px;
	position: absolute;
	cursor: pointer;
	z-index: 99;
}

.detail_info {
	background: url('${ctx}/static/img/waterMap/youzhankai.svg') no-repeat;
	position: absolute;
	width: 830px;
	height: 340px;
	background-position: 9px 0px;
	display: none; 
	z-index: 100;
}

.detail_info_zuo {
	background: url('${ctx}/static/img/waterMap/zuozhankai.svg') no-repeat;
	position: absolute;
	width: 830px;
	height: 340px;
	background-position: 9px 0px;
	display: none; 
	z-index: 100;
}

.close_head {
	width: 12px;
	height: 12px;
	background: url('${ctx}/static/img/waterMap/guanbi.svg');
	position: absolute;
	margin-top: 10px;
	right:9px;
}

.infoContent {
	width: 280px;
	height: 340px;
	margin-left: 210px;
	position: relative;
}

.deviceName {
	font-size: 20px;
	color: #424242;
	text-align: center;
	height: 20px;
	line-height: 20px;
	width: 280px;
	margin-top: 16px;
	position: absolute;
}

.position {
	height: 17px;
	top: 50px;
	text-align: center;
	font-size: 12px;
	color: #666666;
	position: absolute;
	width: 100%;
}

.water_pressure {
	width: 100%;
	height: 180px;
	position: absolute;
	top: 77px;
}

.info {
	position: absolute;
	width: 280px;
	height: 80px;
	top: 245px;
	padding: 21px;
	font-size: 12px;
	color: #424242;
}

.deviceStatus {
	font-family: PingFangSC-Regular;
	font-size: 12px;
	line-height: 17px;
}

.green {
	color: #00BFA5;
}

.red {
	color: #F37B7B;
}

.black {
	color: #666666;
}

.point-p-info{
    margin-top: 0px;
    font-size: 14px;
    color:#4A4A4A;
    text-align: center;
}

.lf{
    float:left;
}
.sub-title{
	font-size: 16px;
	color: #424242;
	letter-spacing: 0.19px;
	margin-top:16px;
	margin-left:10px;
}
</style>
</head>
<body>
	<div class="water_bg">
		<div class="water_info">
			<div class="water_head" >
				水系统检测装置总数<span class="font1" id="total">0</span>
			</div>
			<div class="water_status" style="margin-top: 21px;">
				<img class="water_icon"
					src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg"> <span
					class="font2">正常状态</span><span class="font2" id="normalNum">0</span>
			</div>
			<div class="water_status" style="margin-top: 14px;">
				<img class="water_icon"
					src="${ctx}/static/img/waterMap/xiaofangyichang.svg"> <span
					class="font2">报警状态</span><span class="font2" id="alarms">0</span>
			</div>
			<div class="water_status" style="margin-top: 14px;">
				<img class="water_icon"
					src="${ctx}/static/img/waterMap/xiaofanglixian.svg"> <span
					class="font2">离线状态</span><span class="font2" id="offlineNum">0</span>
			</div>
		</div>

		<div class="point" style="left: 504px; top: 268px;">
			<img id="1-4-11001"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-4-11001" class="point-p-info" style="width: 83px;margin-left: -22px;"></p>
		</div>
		<div class="point" style="left: 996px; top: 231px;">
			<img id="1-8-14001"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-8-14001" class="point-p-info" style="width: 83px;margin-left: -21px;"></p>
		</div>
		<div class="point" style="left: 482px; top: 480px;">
			<img id="1-4-13001"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-4-13001" class="point-p-info" style="width: 83px;margin-left: -22px;"></p>
		</div>
		<div class="point" style="left: 569px; top: 504px;">
			<img id="1-2-242"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-2-242" class="point-p-info" style="width: 99px;margin-left: -29px;"></p>
		</div>
		<div class="point" style="left: 633px; top: 416px;">
			<img id="1-6-17001"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-6-17001" class="point-p-info" style="width: 83px;margin-left: -22px;"></p>
		</div>
		<div class="point" style="left: 720px; top: 461px;">
			<img id="1-6-27001"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-6-27001" class="point-p-info" style="width: 84px;margin-left: -22px;"></p>
		</div>
		<div class="point" style="left: 703px; top: 576px;">
			<img id="1-4-12002"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-4-12002" class="point-p-info" style="width: 83px;margin-left: -22px;"></p>
		</div>
		<div class="point" style="left: 776px; top: 601px;">
			<img id="1-4-12001"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-4-12001" class="point-p-info" style="width: 83px;margin-left: -22px;"></p>
		</div>
		<div class="point" style="left: 871px; top: 461px;">
			<img id="1-8-10001"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-8-10001" class="point-p-info" style="width: 83px;margin-left: -22px;"></p>
		</div>
		<div class="point" style="left: 965px; top: 522px;">
			<img id="1-4-15003"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-4-15003" class="point-p-info" style="width: 83px;margin-left: -22px;"></p>
		</div>
		<div class="point" style="left: 907px; top: 572px;">
			<img id="1-4-15002"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-4-15002" class="point-p-info" style="width: 83px;margin-left: -22px;"></p>
		</div>
		<div class="point" style="left: 902px; top: 661px;">
			<img id="1-4-15001"
				src="${ctx}/static/img/waterMap/xiaofangzhengchang.svg">
				<p id="p-1-4-15001" class="point-p-info" style="width: 84px;margin-left: -22px;"></p>
		</div>
		
		<div class="detail_info" id="detailInfo" name="deviceInfo">
				<div class="close_head"></div>
			<div class="infoContent lf">
				<div class="deviceName" id="deviceName">管网水压检测装置</div>
				<div class="position">
					<img src="${ctx}/static/img/waterMap/weizhi.svg"
						style="width: 13px; height: 16px; margin-top: -2px;"><span id="position"
						style="font-size: 12px; color: #666666; margin-left: 5px;">C座33层最不利点试验栓</span>
				</div>
				<div class="water_pressure" id="waterChart"></div>
				<div class="info">
					<table style="width: 100%">
						<tr>
							<td style="width: 50%;">水压：<span id="waterPressure">0.00Mpa</span></td>
							<td>流量：<span id="waterFlux">0.00</span></td>
						</tr>
						<tr>
							<td>设备状态：<span class="deviceStatus green" id="deviceStatus">设备离线</span></td>
						</tr>
						<tr>
							<td>设备编号：<span id="deviceNumber">1-4-15003</span></td>
						</tr>
					</table>

				</div>

			</div>
            <div class="lf">
            	<p class="sub-title">今日水压趋势</p>
            	<div id="pressure-info-div-d" style="width:338px;height: 295px;"></div>
            </div>

		</div>
	</div>
</body>
<script type="text/javascript">
	var water_normal_icon = "${ctx}/static/img/waterMap/xiaofangzhengchang.svg";
	var water_abnormal_icon = "${ctx}/static/img/waterMap/xiaofangyichang.svg";
	var water_offline_icon = "${ctx}/static/img/waterMap/xiaofanglixian.svg";
	var option;
	var waterChart;
	var beginTime;
	var endTime;
	var ctx = "${ctx}";
	var isConnectedGateWay;
	$(".water_bg").on("click", function(e) {
		if ($("#detailInfo").css("display") != "none") {
			$("#detailInfo").hide();
		}
	});
	var isConnectedGateWay=false; 
	$(document).ready(function() {
		startConn();
		getBaseDeviceInfo();
		getPosition();
		$(".point").each(function() {
			$(this).click(function(e) {
				e.stopPropagation();
				var a = $(this).css("left");
				if(a>"780px"){
					$("#detailInfo").removeClass("detail_info").addClass("detail_info_zuo");
					$(".infoContent").css("margin-left","10px");
					$(".close_head").css("right","210px");
					var deviceNumber = $(this).children()[0].id;
					var left = $(this).position().left - 810;
					var top = $(this).position().top - 200;
					$("#detailInfo").css("left", left);
					$("#detailInfo").css("top", top);
					$("#detailInfo").show();
					$("#detailInfo").attr("name","deviceInfo"+deviceNumber);
					$("#deviceNumber").html(deviceNumber);
					getWaterDeviceInfo(deviceNumber);	
				}else{
					$("#detailInfo").removeClass("detail_info_zuo").addClass("detail_info");
					$(".infoContent").css("margin-left","210px");
					$(".close_head").css("right","9px");
				    var deviceNumber = $(this).children()[0].id;
				    var left = $(this).position().left + 11;
				    var top = $(this).position().top - 200;
				    $("#detailInfo").css("left", left);
				    $("#detailInfo").css("top", top);
				    $("#detailInfo").show();
				    $("#detailInfo").attr("name","deviceInfo"+deviceNumber);
				    $("#deviceNumber").html(deviceNumber);
				    getWaterDeviceInfo(deviceNumber);
				}
			});
		});

	})
	
	function getEcharsData(id,divId,deviceId) {
			$.ajax({
				type : "post",
				url : "${ctx}/report/" + id +"?beginTime=" + beginTime+ "&endTime=" + endTime+ "&projectCode=" + parent.projectCode+"&deviceId="+deviceId,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					var obj = echarts.init(document.getElementById(divId));
					var option = $.parseJSON(data);
					option.series[0].areaStyle.normal.color = new echarts.graphic.LinearGradient(
							0, 0, 0, 1, [ {
								offset : 0,
								color : 'rgba(38,198,218,1)'
							}, {
								offset : 1,
								color : 'rgba(38,198,218,0.2)'
							} ]);
					option.tooltip.formatter = function (params) {
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
					obj.setOption(option);
				},
				error : function(req, error, errObj) {
				}
			});
		}
	
	function getPosition(){
		$(".point").each(function() {
				var deviceNumber = $(this).children()[0].id;
				$("#deviceNumber").html(deviceNumber);
		      getWaterDevicePosition(deviceNumber);
		});
	}
	
	function getWaterDevicePosition(deviceNumber){
		$.ajax({
			type: "post",
			url: "${ctx}/fire-fighting/fireFightingManage/getDeviceByDeviceNumber?projectCode="+parent.projectCode+"&deviceNumber="+deviceNumber,
			async: true,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data.data != null && data.code==0) {
					var dtoo = data.data;
					var position = "#p-"+deviceNumber;
					$(position).html(dtoo.position);
				}
			},
			error: function(req, error, errObj) {
			}
		});
	}
	
	function getBaseDeviceInfo(){
		$.ajax({
			type: "post",
			url: "${ctx}/fire-fighting/fireFightingManage/getWaterDeviceBaseInfo?projectCode="+parent.projectCode,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data.data != null && data.code==0) {
					var pageDataVO = data.data;
					$("#normalNum").html(pageDataVO.waterOnline-pageDataVO.waterAlarm);
					$("#alarms").html(pageDataVO.waterAlarm);
					$("#offlineNum").html(pageDataVO.waterOffline);
					$("#total").html(pageDataVO.waterOnline+pageDataVO.waterOffline);
					$.each(pageDataVO.waterDevicesList,function(index,value){
						var deviceNumber = value.deviceNumber;
						if(value.devStatus==1){
							$("#"+deviceNumber).attr("src",water_offline_icon);
						}else{
							if(value.waterPressureAlarm==1){
								$("#"+deviceNumber).attr("src",water_abnormal_icon);
							}else{
								$("#"+deviceNumber).attr("src",water_normal_icon);
							}
						}
					     
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
	}
	
	function getWaterDeviceInfo(deviceNumber){
		$.ajax({
			type: "post",
			url: "${ctx}/fire-fighting/fireFightingManage/getDeviceByDeviceNumber?projectCode="+parent.projectCode+"&deviceNumber="+deviceNumber,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data.data != null && data.code==0) {
					var dto = data.data;
					setValue(dto);
				}
			},
			error: function(req, error, errObj) {
			}
		});
	}
	
	function setValue(dto){
		var deviceNumber = dto.deviceNumber;
		var deviceId = dto.deviceId;
		$("#deviceName").html(dto.deviceName);
		$("#position").html(dto.position);
		if(dto.devStatus==1){
			$("#"+deviceNumber).attr("src",water_offline_icon);
			$("#deviceStatus").html("设备离线");
			$("#deviceStatus").removeClass("green");
			$("#deviceStatus").removeClass("red");
			$("#deviceStatus").addClass("black");
		}else{
			if(dto.waterPressureAlarm==1){
				$("#"+deviceNumber).attr("src",water_abnormal_icon);
				$("#deviceStatus").html("水压异常");
				$("#deviceStatus").removeClass("green");
				$("#deviceStatus").removeClass("black");
				$("#deviceStatus").addClass("red");
			}else{
				$("#"+deviceNumber).attr("src",water_normal_icon);
				$("#deviceStatus").html("水压正常");
				$("#deviceStatus").removeClass("black");
				$("#deviceStatus").removeClass("red");
				$("#deviceStatus").addClass("green");
			}
		}
		if(dto.waterFlux!=null){
			$("#waterFlux").html(dto.waterFlux);
		}else{
			$("#waterFlux").html("--");
		}
		if(dto.waterPressure!=null){
			$("#waterPressure").html(dto.waterPressure+"Mpa");
			initWaterPress(dto.waterPressure);
		}else{
			$("#waterPressure").html("--Mpa");
			initWaterPress(0);
		}
		
		if(dto.waterAlarm!=null){
			$("#alarms").html(dto.waterAlarm);
		}
		
		if(dto.waterOnline!=null){
			$("#normalNum").html(pageDataVO.waterOnline);
		}
		if(dto.waterOffline!=null){
			$("#offlineNum").html(pageDataVO.waterOffline);
		}
		beginTime = getDateStr(0);
		endTime = nowTime();
		getEcharsData(138,"pressure-info-div-d",deviceId);
	}
	
	function initWaterPress(value){
		waterChart = echarts.init(document.getElementById('waterChart'));
		option = {
			    tooltip : {
			        formatter: "{a} <br/>{b} : {c}%"
			    },
			    series: [
			          {
			        	radius:'100%',
			        	center:['50%','60%'],
			            name:'水压',
			            type:'gauge',
			            z: 1,
			            min:0,
			            max:2,
			            splitNumber:10,
			            axisLine: {            // 坐标轴线
			                lineStyle: {       // 属性lineStyle控制线条样式
			                    width: 5
			                }
			            },
			            axisTick: {            // 坐标轴小标记
			                length :1.5,        // 属性length控制线长
			                lineStyle: {       // 属性lineStyle控制线条样式
			                    color: 'auto'
			                }
			            },
			            splitLine: {           // 分隔线
			                length :2,         // 属性length控制线长
			                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
			                    color: 'auto'
			                }
			            },
			            title : {
			                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
			                    fontWeight: '100',
			                    fontSize: 2,
			                    fontStyle: ''
			                }
			            },
			            detail : {
			                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
			                    fontWeight: '100',
			                    color: 'auto',
			                    fontSize : 20
			                },
			                formatter:'{value}Mpa'
			            },
			            data:[{value: value, name: '水压'}]
			        }
			        
			    ]
			};
		waterChart.setOption(option,true);
	}
	
	function changeDeviceInfo(data){
		var name = "deviceInfo"+data.deviceNumber;
		if(typeof($("[name="+name+"]").val())!="undefined"){
			setValue(data);
		}
	}
	
	function toSubscribe(){
		if (isConnectedGateWay) {
			// 暖通空调首页信息识别结果
			stompClient.subscribe('/topic/ffmWaterSystemMapData/' + parent.projectCode, function(result) {
				var json = JSON.parse(result.body);
				console.log(json);
				changeDeviceInfo(json);
			});
		}
	}

	function unloadAndRelease() {
		if(stompClient != null) {
			stompClient.unsubscribe('/topic/ffmWaterSystemMapData/' + parent.projectCode);
		}
	}
	
	function getDateStr(addDayCount) {
        var dd = new Date();
        dd.setDate(dd.getDate()+addDayCount);//获取AddDayCount天后的日期
        var y = dd.getFullYear();
        var m = dd.getMonth()+1;//获取当前月份的日期
        if(m.toString().length == 1){
        	m = '0' + m;
        };
        var d = dd.getDate();
        if(d.toString().length == 1){
        	d = '0' + d;
        };
        return y+"-"+m+"-"+d+" 00:00";
    }
	
	function nowTime(){
		var myDate = new Date();
		//获取当前年
		var year=myDate.getFullYear();
		//获取当前月
		var month=myDate.getMonth()+1;
		//获取当前日
		var date=myDate.getDate(); 
		var h=myDate.getHours();       //获取当前小时数(0-23)
		var m=myDate.getMinutes();     //获取当前分钟数(0-59)
		var s=myDate.getSeconds();  

		var now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
		return now;
	}
	
	function p(s) {
	    return s < 10 ? '0' + s: s;
	}

</script>

</html>
