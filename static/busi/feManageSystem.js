function startConn(gatewayAddr) {
	connect(gatewayAddr);
	setInterval("connect('" + gatewayAddr + "')", 40000);
}

function connect(gatewayAddr) {
	if (isConnectedGateWay) {
		return;
	}
	var url = gatewayAddr + '/websocket';
	g_gatewayAddr = gatewayAddr;
	var socket = new SockJS(url);
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame) {
		isConnectedGateWay = true;
		console.info("网关连接成功！");
		stompClient.subscribe('/topic/feManageSystemData/' + projectCode,
				function(result) {
					var json = JSON.parse(result.body);
					websocketCallBack(json);
				});
	}, onerror);

}

// 根据类型转入不同的方法
function websocketCallBack(json) {
	if (json.type == 'ALARM') {
	} else if (json.type == 'TEST') {
	} else if (json.type == 'ACCESS_CONTROL') {
	} else if (json.type == 'FIRE_FIGHTING') {
		displayFireFighting(json.data);
	} else if (json.type == 'SUPPLY_DRAIN') {
	} else if (json.type == 'VIDEO_MORNITORING') {
	} else if (json.type == 'POWER_SUPPLY') {
	} else if (json.type == 'SYS_DYNAMIC') {
		dynamicSysData(json);
	} else if (json.type == 'PARKING') {
	} else if (json.type == 'ENV_MONITOR') {
	} else if (json.type == 'MONITOR_HEARTBEAT') {
		displayMonitorHeartbeat(json.data);
	} else if (json.type == 'HEALTH_RATING') {
		updateHealthValue(JSON.parse(json.data.healthRating));
	}

}

function onerror(frame) {
	if (frame.indexOf("Lost connection") > -1) {
		console.info("未连接上网关地址：" + g_gatewayAddr);
		isConnectedGateWay = false;
		disconnect();
	}
}

function unloadAndRelease() {
	disconnect();
}

function disconnect() {
	if (stompClient != null) {
		stompClient.disconnect();
	}
}

function getHeartbeatData() {
	$
	.ajax({
		type : "post",
		url : ctx
				+ "/sysStatusData/query?projectCode="
				+ projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.data != null && data.data.length > 0) {
				for (var i = 0; i < 6; i++) {
					if(data.data[i] != null){
					var json = data.data[i];
					if ('FIRE_FIGHTING' == json.systemCode) {
						if (json.systemState == 0) {
							$('#monitor_fire_fighting').html("心跳异常，正在重连...");
							$('#monitor_fire_fighting_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_fire_fighting_state').html("异常");
							$("#monitor_fire_fighting_state").removeClass("normal").addClass("abnormal");  
						} else if (json.systemState == 1) {
							$('#monitor_fire_fighting').html("正在监听消防系统的心跳");
							$('#monitor_fire_fighting_img').attr("src",
									ctx + "/static/images/ecgcurve.png");
							$('#monitor_fire_fighting_state').html("正常");
						}
					} else if ('ACCESS_CONTROL' == json.systemCode) {
						var status = $("#monitor_hvac_state").html();
						if("正常" == status){
						if (json.systemState == 0) {
							$('#monitor_access_control').html("心跳异常，正在重连...");
							$('#monitor_access_control_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_access_control_state').html("异常");
							$("#monitor_access_control_state").removeClass("normal").addClass("abnormal"); 
						} else if (json.systemState == 1) {
							$('#monitor_access_control').html("正在监听人行系统的心跳");
							$('#monitor_access_control_img').attr("src",
									ctx + "/static/images/ecgcurve.png");
							$('#monitor_access_control_state').html("正常");
						}
						}
					} else if ('ELEVATOR' == json.systemCode) {
						if (json.systemState == 0) {
							$('#monitor_elevator').html("心跳异常，正在重连...");
							$('#monitor_elevator_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_elevator_state').html("异常");
							$("#monitor_elevator_state").removeClass("normal").addClass("abnormal");
						} else if (json.systemState == 1) {
							$('#monitor_elevator').html("正在监听电梯系统的心跳");
							$('#monitor_elevator_img').attr("src",
									ctx + "/static/images/ecgcurve.png");
							$('#monitor_elevator_state').html("正常");
						}
					} else if ('POWER_SUPPLY' == json.systemCode) {
						if (json.systemState == 0) {
							$('#monitor_power_supply').html("心跳异常，正在重连...");
							$('#monitor_power_supply_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_power_supply_state').html("异常");
							$("#monitor_power_supply_state").removeClass("normal").addClass("abnormal");
						} else if (json.systemState == 1) {
							$('#monitor_power_supply').html("正在监听供配电系统的心跳");
							$('#monitor_power_supply_img').attr("src",
									ctx + "/static/images/ecgcurve.png");
							$('#monitor_power_supply_state').html("正常");
						}
					} else if ('HVAC' == json.systemCode) {
						if (json.systemState == 0) {
							$('#monitor_hvac').html("心跳异常，正在重连...");
							$('#monitor_hvac_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_hvac_state').html("异常");
							$("#monitor_hvac_state").removeClass("normal").addClass("abnormal");
							$('#monitor_supply_drain').html("心跳异常，正在重连...");
							$('#monitor_supply_drain_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_supply_drain_state').html("异常");
							$("#monitor_supply_drain_state").removeClass("normal").addClass("abnormal");
							$('#monitor_access_control').html("心跳异常，正在重连...");
							$('#monitor_access_control_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_access_control_state').html("异常");
							$("#monitor_access_control_state").removeClass("normal").addClass("abnormal");
						} else if (json.systemState == 1) {
							$('#monitor_hvac').html("正在监听暖通系统的心跳");
							$('#monitor_hvac_img').attr("src",
									ctx + "/static/images/ecgcurve.png");
							$('#monitor_hvac_state').html("正常");
						}
					} else if ('SUPPLY_DRAIN' == json.systemCode) {
						var status = $("#monitor_hvac_state").html();
						if("正常" == status){
						if (json.systemState == 0) {
							$('#monitor_supply_drain').html("心跳异常，正在重连...");
							$('#monitor_supply_drain_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_supply_drain_state').html("异常");
							$("#monitor_supply_drain_state").removeClass("normal").addClass("abnormal");
						} else if (json.systemState == 1) {
							$('#monitor_supply_drain').html("正在监听给排水系统的心跳");
							$('#monitor_supply_drain_img').attr("src",
									ctx + "/static/images/ecgcurve.png");
							$('#monitor_supply_drain_state').html("正常");
						}
						}
					}
					}
				}
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

// 处理定时器
function handleSetTime() {
	if (typeof (point1) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point1);
	}
	if (typeof (point2) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point2);
	}
	if (typeof (point3) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point3);
	}
	if (typeof (point4) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point4);
	}
	if (typeof (point5) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point5);
	}
	if (typeof (point6) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point6);
	}
	if (typeof (point7) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point7);
	}
	if (typeof (point8) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point8);
	}
	if (typeof (point9) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point9);
	}
	if (typeof (point10) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point10);
	}
	if (typeof (point11) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point11);
	}
	if (typeof (point12) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point12);
	}
	if (typeof (point13) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point13);
	}
	if (typeof (point14) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point14);
	}
	if (typeof (point15) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point15);
	}
	if (typeof (point16) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point16);
	}
	if (typeof (point17) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point17);
	}
	if (typeof (point18) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point18);
	}
	if (typeof (point19) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(point19);
	}
}

// 控制雷达扫描是否显示
function pointIsDisplay() {
	document.getElementById("xs1").style.visibility = "hidden";
	document.getElementById("xs2").style.visibility = "hidden";
	document.getElementById("xs3").style.visibility = "hidden";
	document.getElementById("xs4").style.visibility = "hidden";
	document.getElementById("xs5").style.visibility = "hidden";
	document.getElementById("xs6").style.visibility = "hidden";
	document.getElementById("xs7").style.visibility = "hidden";
	document.getElementById("xs8").style.visibility = "hidden";

	// 第一步显示三个
	document.getElementById("xs1").style.visibility = "";
	document.getElementById("xs2").style.visibility = "";
	document.getElementById("xs3").style.visibility = "";

	// 十秒后弹窗消失
	point1 = setTimeout("idByNull1('" + "xs1" + "')", 8000);
	point2 = setTimeout("idByNull2('" + "xs2" + "')", 9000);
	point3 = setTimeout("idByNull3('" + "xs3" + "')", 10000);

}

// 隐藏显示的div并且把div下的id值置为空
function idByNull1(id) {
	document.getElementById(id).style.visibility = "hidden";
	point4 = setTimeout("idByShow4('" + "xs4" + "')", 1000);
	point5 = setTimeout("idByNull4('" + "xs4" + "')", 8000);
}
function idByShow4(id) {
	document.getElementById(id).style.visibility = "";
}
function idByNull4(id) {
	document.getElementById(id).style.visibility = "hidden";
	point6 = setTimeout("idByShow7('" + "xs7" + "')", 1000);
	point7 = setTimeout("idByNull7('" + "xs7" + "')", 8000);
}
function idByShow7(id) {
	document.getElementById(id).style.visibility = "";
}
function idByNull7(id) {
	document.getElementById(id).style.visibility = "hidden";
	point8 = setTimeout("idByShow1('" + "xs1" + "')", 1000);
	point9 = setTimeout("idByNull1('" + "xs1" + "')", 8000);
}
function idByShow1(id) {
	document.getElementById(id).style.visibility = "";
}
function idByNull2(id) {
	document.getElementById(id).style.visibility = "hidden";
	point10 = setTimeout("idByShow5('" + "xs5" + "')", 1000);
	point11 = setTimeout("idByNull5('" + "xs5" + "')", 9000);
}
function idByShow5(id) {
	document.getElementById(id).style.visibility = "";
}
function idByNull5(id) {
	document.getElementById(id).style.visibility = "hidden";
	point12 = setTimeout("idByShow8('" + "xs8" + "')", 1000);
	point13 = setTimeout("idByNull8('" + "xs8" + "')", 9000);
}
function idByShow8(id) {
	document.getElementById(id).style.visibility = "";
}
function idByNull8(id) {
	document.getElementById(id).style.visibility = "hidden";
	point14 = setTimeout("idByShow2('" + "xs2" + "')", 1000);
	point15 = setTimeout("idByNull2('" + "xs2" + "')", 9000);
}
function idByShow2(id) {
	document.getElementById(id).style.visibility = "";
}
function idByNull3(id) {
	document.getElementById(id).style.visibility = "hidden";
	point16 = setTimeout("idByShow6('" + "xs6" + "')", 1000);
	point17 = setTimeout("idByNull6('" + "xs6" + "')", 10000);
}
function idByShow6(id) {
	document.getElementById(id).style.visibility = "";
}
function idByNull6(id) {
	document.getElementById(id).style.visibility = "hidden";
	point18 = setTimeout("idByShow3('" + "xs3" + "')", 1000);
	point19 = setTimeout("idByNull3('" + "xs3" + "')", 10000);
}
function idByShow3(id) {
	document.getElementById(id).style.visibility = "";
}
// 获取一级分类下的信息
function handleCategoryInfo() {
	var code1 = "SYSTEM_FROM";
	feCategoryTime = setTimeout("handleCategoryInfo()", 120000);
	$.ajax({
		type : "post",
		url : ctx
				+ "/alarm-center/alarmRecord/getAlarmRecordNoHandelCount?code="
				+ code1 + "&projectCode=" + projectCode,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null && data.length > 0) {
				$(eval(data)).each(function() {
					var value = this.itemData;
					var name = this.itemText;
					if (value == 01) {
						$("#xf").text("消防" + name);
					} else if (value == 02) {
						$("#rx").text("人行" + name);
					} else if (value == 03) {
						$("#dt").text("电梯" + name);
					} else if (value == 04) {
						$("#tcc").text("停车场" + name);
					} else if (value == 05) {
						$("#spjk").text("视频监控" + name);
					} else if (value == 06) {
						$("#ntkt").text("暖通空调" + name);
					} else if (value == 07) {
						$("#gps").text("给排水" + name);
					} else if (value == 08) {
						$("#gpd").text("供配电" + name);
					} else if (value == 0000) {
						$("#alarmDeviceCount").text(name);
					}
				});
			}
		},
		error : function(req, error, errObj) {
		}
	});
}



function getSubsystemNormalCount() {
	$.ajax({
		type : "post",
		url : ctx+ "/device/homePage/getSubsystemNormalCount?projectCode=" + projectCode,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null && data.length > 0) {
				data = $.parseJSON(data);
				abnormalCount =data.numberCount;
				if(isNaN(abnormalCount) || abnormalCount == undefined){
					abnormalCount = 0;
				}
				$('#deviceChart').ClassyCountdown({
					value : abnormalCount
				});
			}
		},
		error : function(req, error, errObj) {
		}
	});
}


// 获取项目所有的设备
function getProjectAllDeviceCount() {
	$
			.ajax({
				type : "get",
				url : ctx
						+ "/device/homePage/getProjectCodeAllDeviceCount?projectCode="
						+ projectCode,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data != null && data.length > 0) {
						var domdiv = document.getElementById('deviceNum');
						// 判断参数有几位 最多十一位
						var size = data.length;
						var One = 0;
						var Two = 0;
						var Three = 0;
						var Four = 0;
						var Five = 0;
						var Six = 0;
						var Seven = 0;
						if (size == 1) {
							$("#num1").html(data);
							$("#num1").show();
							domdiv.style = 'padding-left:402.4px;height: 97.1px;margin-top: 5px;';
						} else if (size == 2) {
							One = data.substring(0, 1);
							Two = data.substring(1, 2);
							$("#num1").html(One);
							$("#num2").html(Two);
							$("#num1").show();
							$("#num2").show();
							domdiv.style = 'padding-left:348.4px;height: 97.1px;margin-top: 5px;';
						} else if (size == 3) {
							One = data.substring(0, 1);
							Two = data.substring(1, 2);
							Three = data.substring(2, 3);
							$("#num1").html(One);
							$("#num2").html(Two);
							$("#num3").html(Three);
							$("#num1").show();
							$("#num2").show();
							$("#num3").show();
							domdiv.style = 'padding-left:286.4px;height: 97.1px;margin-top: 5px;';
						} else if (size == 4) {
							One = data.substring(0, 1);
							Two = data.substring(1, 2);
							Three = data.substring(2, 3);
							Four = data.substring(3, 4);
							$("#num1").html(One);
							$("#num2").html(Two);
							$("#num3").html(Three);
							$("#num4").html(Four);
							$("#num1").show();
							$("#num2").show();
							$("#num3").show();
							$("#num4").show();
							domdiv.style = 'padding-left:232.4px;height: 97.1px;margin-top: 5px;';
						} else if (size == 5) {
							One = data.substring(0, 1);
							Two = data.substring(1, 2);
							Three = data.substring(2, 3);
							Four = data.substring(3, 4);
							Five = data.substring(4, 5);
							$("#num1").html(One);
							$("#num2").html(Two);
							$("#num3").html(Three);
							$("#num4").html(Four);
							$("#num5").html(Five);
							$("#num1").show();
							$("#num2").show();
							$("#num3").show();
							$("#num4").show();
							$("#num5").show();
							domdiv.style = 'padding-left:171.4px;height: 97.1px;margin-top: 5px;';
						} else if (size == 6) {
							One = data.substring(0, 1);
							Two = data.substring(1, 2);
							Three = data.substring(2, 3);
							Four = data.substring(3, 4);
							Five = data.substring(4, 5);
							Six = data.substring(5, 6);
							$("#num1").html(One);
							$("#num2").html(Two);
							$("#num3").html(Three);
							$("#num4").html(Four);
							$("#num5").html(Five);
							$("#num6").html(Six);
							$("#num1").show();
							$("#num2").show();
							$("#num3").show();
							$("#num4").show();
							$("#num5").show();
							$("#num6").show();
							domdiv.style = 'padding-left:113.4px;height: 97.1px;margin-top: 5px;';
						} else if (size == 7) {
							One = data.substring(0, 1);
							Two = data.substring(1, 2);
							Three = data.substring(2, 3);
							Four = data.substring(3, 4);
							Five = data.substring(4, 5);
							Six = data.substring(5, 6);
							Seven = data.substring(6, 7);
							$("#num1").html(One);
							$("#num2").html(Two);
							$("#num3").html(Three);
							$("#num4").html(Four);
							$("#num5").html(Five);
							$("#num6").html(Six);
							$("#num7").html(Seven);
							$("#num1").show();
							$("#num2").show();
							$("#num3").show();
							$("#num4").show();
							$("#num5").show();
							$("#num6").show();
							$("#num7").show();
							domdiv.style = 'padding-left:58.4px;height: 97.1px;margin-top: 5px;';
						}
					}
				},
				error : function(req, error, errObj) {
				}
			});
}


// 消防最长时间变化
function timeChange() {
	if (typeof (flushFiresTime) != "undefined"
			&& 'undefined' != typeof ($("#firesMaxTime").val())) {
		firesMaxTime = firesMaxTime + 1000;
		var days = parseInt(firesMaxTime / (1000 * 60 * 60 * 24));
		var hours = parseInt((firesMaxTime % (1000 * 60 * 60 * 24))
				/ (1000 * 60 * 60));
		var minutes = parseInt((firesMaxTime % (1000 * 60 * 60)) / (1000 * 60));
		// var seconds =(firesMaxTime % (1000 * 60)) / 1000;
		$("#firesMaxTime").html(days + "天" + hours + "小时" + minutes + "分钟");
		flushFiresTime = setTimeout("timeChange()", 1000);
	}

}

// 展示消防系统数据
function displayFireFighting(data) {
	if (data.timeChanged) {
		if (typeof (flushFiresTime) != "undefined") {
			// 防止多次加载产生多个定时任务
			clearTimeout(flushFiresTime);
		}
		firesMaxTime = data.firesMaxTime;
		if (firesMaxTime > 0) {
			flushFiresTime = setTimeout("timeChange()", 1000);
		} else {
			$("#fires_day").html("--天");
			$("#fires_time").html("--小时" + "--分钟" + "--秒");
		}
	}
	$('#fire_main').ClassyCountdown({
		value : data.maintainNumber
	});
	$("#fires_num").html(data.fires);
	var normalCount = data.firesNormal + data.waterOnline - data.waterAlarm
			+ (data.masterTotal - data.abnormalTotal);
	var abnormalCount = data.firesAbnormal + data.waterOffline
			+ data.waterAlarm + data.abnormalTotal;
	if ('undefined' != typeof ($("#fire_alarm_bar").val())) {
		getEchartsData(119, "fire_alarm_bar");
	}
}

// 打开页面请求消防数据
function getFireFightingProjectData() {
	$
			.ajax({
				type : "post",
				url : ctx
						+ "/fire-fighting/fireFightingManage/getProjectPageData?projectCode="
						+ projectCode,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.code == 0 && data.data) {
						displayFireFighting(data.data);
					}

				},
				error : function(req, error, errObj) {
				}
			});
}

function getData(percent, colorParam) {
	return [ {
		value : percent,
		name : percent,
		itemStyle : {
			normal : {
				color : new echarts.graphic.LinearGradient(0, 0, 0, 1, [ {
					offset : 0,
					color : 'rgba('+colorParam+',0.5)'
				}, {
					offset : 1,
					color : 'rgba('+colorParam+',0.5)'
				} ])
			}
		}
	}, {
		value : 1 - percent,
		itemStyle : {
			normal : {
				color : 'transparent'
			}
		}
	} ];
}

// 组装设备数量分布图ECharts
function getDeviceNumEchart(divId) {
	var placeHolderStyle = {
			normal : {
				label : {
					show : false,
				},
				labelLine : {
					show : false,
				}
			}
	};
	$.ajax({
	    type : "post",
	    url : ctx + "/device/manage/getDeviceSumBySystemCodeAndProjectCode?projectCode="+projectCode,
	    async : true,
	    contentType : "application/json;charset=utf-8",
	    success : function(data) {
	    	if (data && data.code == 0 && data.data) {
				var resultList = data.data;
				// 组装ECharts
				var obj = echarts.init(document.getElementById(divId));
				var mySeries = [];
				var legendData = [];
				var colorArr = [];
				var leftRadius = 39;
				var currName;
				for (var i = 0; i < resultList.length; i++) {
					var currVO = resultList[i];
					if (currVO.systemName.length == 5) {
						currName = currVO.systemName + ' ' + currVO.deviceNum;
					} else if (currVO.systemName.length == 4) {
						currName = currVO.systemName + '    ' + currVO.deviceNum;
					} else {
						currName = currVO.systemName + '           ' + currVO.deviceNum;
					}
					var myData = {
						name : currName,
						type : 'pie',
						clockWise : true, // 顺时加载
						hoverAnimation : false, // 鼠标移入变大
						radius : [ leftRadius, leftRadius + 10 ],
						itemStyle : placeHolderStyle,
						data : getData(currVO.idata, currVO.colorParam)
					}
					leftRadius = leftRadius + 15;
					mySeries[i] = myData;
					legendData[resultList.length - i - 1] = currName;
					colorArr[i] = 'rgb('+currVO.colorParam+')';
				}

				var option = {
					tooltip : {
						trigger : 'item',
						formatter : function(params, ticket, callback) {
							return params.seriesName + ": "
									+ params.name * 100 + "%";
						}
					},
					color : colorArr,
					legend : {
						top : "1%",
						left : "8%",
						itemGap : 3,
						itemHeight : 3,
						data : legendData,
						textStyle: {
				            color: colorArr
				        },
						selectedMode : true,
						orient : "vertical",
						icon: 'none',
					},
					series : mySeries
				};
				obj.setOption(option);
	    	}
	    },
	    error : function(req, error, errObj) {
	    }
	});
}

function getEchartsData(id, divId) {
	$
			.ajax({
				type : "post",
				url : ctx + "/report/" + id + "?projectCode=" + projectCode,
				async : true,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					var obj = echarts.init(document.getElementById(divId));
					var option = $.parseJSON(data);
					option.series[0].itemStyle.normal.color = new echarts.graphic.LinearGradient(
							0, 0, 0, 1, [ {
								offset : 0,
								color : '#76DDFB'
							}, {
								offset : 1,
								color : '#53A8E2'
							} ]);
					obj.setOption(option);
				},
				error : function(req, error, errObj) {
				}
			});
}

//获取设备健康状态
function getDeviceHealth(){
	$.ajax({
		type : "post",
		url : ctx+ "/device/deviceInfo/getDeviceHealthRating?projectCode=" + projectCode,
		async : false,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null) {
				updateHealthValue(data);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}
//设备健康状态
//0-30分=告警，30=60分=危险，60-85=良好，85-100=健康
function updateHealthValue(value){
	jQuery.each(value, function(i, val) { 
		val = parseInt(val);
		$("#HEALTH_" + i +" .health_value").animate({width:val + "%"}, 500);
		$("#HEALTH_" + i +" .health_text").html(val);
		if(val < 30){
			$("#HEALTH_" + i +" .health_level").html("告警")
			$("#HEALTH_" + i +" .health_level").removeClass().addClass("health_level health_alarm");
		}else if(30 <= val && val < 60){
			$("#HEALTH_" + i +" .health_level").html("危险")
			$("#HEALTH_" + i +" .health_level").removeClass().addClass("health_level health_dangerous");
		}else if(60 <= val && val < 85){
			$("#HEALTH_" + i +" .health_level").html("良好")
			$("#HEALTH_" + i +" .health_level").removeClass().addClass("health_level health_good");
		}else if(val >= 85){
			$("#HEALTH_" + i +" .health_level").html("健康")
			$("#HEALTH_" + i +" .health_level").removeClass().addClass("health_level health_healthy");
		}
	});
}

//推送各系统心跳状态到西子国际设施设备页面
function displayMonitorHeartbeat(json) {
	var alarm = $("#totalOfAlarm").text();
	if ('FIRE_FIGHTING' == json.systemCode) {
		if (json.systemState == 0) {
			$('#monitor_fire_fighting').html("心跳异常，正在重连...");
			$('#monitor_fire_fighting_img').attr("src",
					ctx + "/static/images/ecgline.png");
			$('#monitor_fire_fighting_state').html("异常");
			$("#monitor_fire_fighting_state").removeClass("normal").addClass("abnormal");
		} else if (json.systemState == 1) {
			$('#monitor_fire_fighting').html("正在监听消防系统的心跳");
			$('#monitor_fire_fighting_img').attr("src",
					ctx + "/static/images/ecgcurve.png");
			$('#monitor_fire_fighting_state').html("正常");
			$("#monitor_fire_fighting_state").removeClass("abnormal").addClass("normal");
		}
	} else if ('ACCESS_CONTROL' == json.systemCode) {
		if (json.systemState == 0) {
			$('#monitor_access_control').html("心跳异常，正在重连...");
			$('#monitor_access_control_img').attr("src",
					ctx + "/static/images/ecgline.png");
			$('#monitor_access_control_state').html("异常");
			$("#monitor_access_control_state").removeClass("normal").addClass("abnormal");
		} else if (json.systemState == 1) {
			$('#monitor_access_control').html("正在监听人行系统的心跳");
			$('#monitor_access_control_img').attr("src",
					ctx + "/static/images/ecgcurve.png");
			$('#monitor_access_control_state').html("正常");
			$("#monitor_access_control_state").removeClass("abnormal").addClass("normal");
		}
	} else if ('ELEVATOR' == json.systemCode) {
		if (json.systemState == 0) {
			$('#monitor_elevator').html("心跳异常，正在重连...");
			$('#monitor_elevator_img').attr("src",
					ctx + "/static/images/ecgline.png");
			$('#monitor_elevator_state').html("异常");
			$("#monitor_elevator_state").removeClass("normal").addClass("abnormal");
		} else if (json.systemState == 1) {
			$('#monitor_elevator').html("正在监听电梯系统的心跳");
			$('#monitor_elevator_img').attr("src",
					ctx + "/static/images/ecgcurve.png");
			$('#monitor_elevator_state').html("正常");
			$("#monitor_elevator_state").removeClass("abnormal").addClass("normal");
		}
	} else if ('POWER_SUPPLY' == json.systemCode) {
		if (json.systemState == 0) {
			$('#monitor_power_supply').html("心跳异常，正在重连...");
			$('#monitor_power_supply_img').attr("src",
					ctx + "/static/images/ecgline.png");
			$('#monitor_power_supply_state').html("异常");
			$("#monitor_power_supply_state").removeClass("normal").addClass("abnormal");
		} else if (json.systemState == 1) {
			$('#monitor_power_supply').html("正在监听供配电系统的心跳");
			$('#monitor_power_supply_img').attr("src",
					ctx + "/static/images/ecgcurve.png");
			$('#monitor_power_supply_state').html("正常");
			$("#monitor_power_supply_state").removeClass("abnormal").addClass("normal");
		}
	} else if ('HVAC' == json.systemCode) {
		if (json.systemState == 0) {
			$('#monitor_hvac').html("心跳异常，正在重连...");
			$('#monitor_hvac_img').attr("src",
					ctx + "/static/images/ecgline.png");
			$('#monitor_hvac_state').html("异常");
			$("#monitor_hvac_state").removeClass("normal").addClass("abnormal");
			$('#monitor_supply_drain').html("心跳异常，正在重连...");
			$('#monitor_supply_drain_img').attr("src",
					ctx + "/static/images/ecgline.png");
			$('#monitor_supply_drain_state').html("异常");
			$("#monitor_supply_drain_state").removeClass("normal").addClass("abnormal");
			$('#monitor_access_control').html("心跳异常，正在重连...");
			$('#monitor_access_control_img').attr("src",
					ctx + "/static/images/ecgline.png");
			$('#monitor_access_control_state').html("异常");
			$("#monitor_access_control_state").removeClass("normal").addClass("abnormal");
		} else if (json.systemState == 1) {
			$('#monitor_hvac').html("正在监听暖通系统的心跳");
			$('#monitor_hvac_img').attr("src",
					ctx + "/static/images/ecgcurve.png");
			$('#monitor_hvac_state').html("正常");
			$("#monitor_hvac_state").removeClass("abnormal").addClass("normal");
			getAccessAndDrainHeartbeatData();
		}
	} else if ('SUPPLY_DRAIN' == json.systemCode) {
		if (json.systemState == 0) {
			$('#monitor_supply_drain').html("心跳异常，正在重连...");
			$('#monitor_supply_drain_img').attr("src",
					ctx + "/static/images/ecgline.png");
			$('#monitor_supply_drain_state').html("异常");
			$("#monitor_supply_drain_state").removeClass("normal").addClass("abnormal");
		} else if (json.systemState == 1) {
			$('#monitor_supply_drain').html("正在监听给排水系统的心跳");
			$('#monitor_supply_drain_img').attr("src",
					ctx + "/static/images/ecgcurve.png");
			$('#monitor_supply_drain_state').html("正常");
			$("#monitor_supply_drain_state").removeClass("abnormal").addClass("normal");
		}
	}
}

function hiddenScroller() {
	var height = $(window).height();
	if (height > 1070) {
		document.documentElement.style.overflowY = 'hidden';
	} else {
		document.documentElement.style.overflowY = 'auto';
	}
}
$(window).resize(function() {
	var height = $(this).height();
	if (height > 1070) {
		document.documentElement.style.overflowY = 'hidden';
	} else {
		document.documentElement.style.overflowY = 'auto';
	}

});

function getAccessAndDrainHeartbeatData() {
	$
	.ajax({
		type : "post",
		url : ctx
				+ "/sysStatusData/query?projectCode="
				+ projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.data != null && data.data.length > 0) {
				for (var i = 0; i < 6; i++) {
					if(data.data[i] != null){
					var json = data.data[i];
				    if ('ACCESS_CONTROL' == json.systemCode) {
						var status = $("#monitor_hvac_state").html();
						if("正常" == status){
						if (json.systemState == 0) {
							$('#monitor_access_control').html("心跳异常，正在重连...");
							$('#monitor_access_control_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_access_control_state').html("异常");
							$("#monitor_access_control_state").removeClass("normal").addClass("abnormal"); 
						} else if (json.systemState == 1) {
							$('#monitor_access_control').html("正在监听人行系统的心跳");
							$('#monitor_access_control_img').attr("src",
									ctx + "/static/images/ecgcurve.png");
							$('#monitor_access_control_state').html("正常");
							$("#monitor_access_control_state").removeClass("abnormal").addClass("normal");
						}
						}
					}else if ('SUPPLY_DRAIN' == json.systemCode) {
						var status = $("#monitor_hvac_state").html();
						if("正常" == status){
						if (json.systemState == 0) {
							$('#monitor_supply_drain').html("心跳异常，正在重连...");
							$('#monitor_supply_drain_img').attr("src",
									ctx + "/static/images/ecgline.png");
							$('#monitor_supply_drain_state').html("异常");
							$("#monitor_supply_drain_state").removeClass("normal").addClass("abnormal");
						} else if (json.systemState == 1) {
							$('#monitor_supply_drain').html("正在监听给排水系统的心跳");
							$('#monitor_supply_drain_img').attr("src",
									ctx + "/static/images/ecgcurve.png");
							$('#monitor_supply_drain_state').html("正常");
							$("#monitor_supply_drain_state").removeClass("abnormal").addClass("normal");
						}
						}
					}
					}
				}
			}
		},
		error : function(req, error, errObj) {
		}
	});
}
