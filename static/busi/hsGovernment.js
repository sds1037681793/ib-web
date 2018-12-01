
function toSubscribe() {
		if (isConnectedGateWay) {
			// 告警中心告警
			stompClient.subscribe('/topic/operateSystemData/' + projectCode, function(result) {
				var json = JSON.parse(result.body);
				websocketCallBack(json);
			});
		}
}

// 根据类型转入不同的方法
function websocketCallBack(json) {
	if (json.type == 'ALARM') {
	} else if (json.type == 'TEST') {
	} else if (json.type == 'ACCESS_CONTROL') {
		undateAccessData(json.data);
	} else if (json.type == 'FIRE_FIGHTING') {
	} else if (json.type == 'SUPPLY_DRAIN') {
	} else if (json.type == 'VIDEO_MORNITORING') {
	} else if (json.type == 'POWER_SUPPLY') {
	} else if (json.type == 'HVAC') {
	} else if (json.type == 'PARKING') {
		updateParkingDatas(json.data);
	} else if (json.type == 'ENV_MONITOR') {
	} else if (json.type == 'ELEVATOR') {
	}

}

function onerror(frame) {
	if (frame.indexOf("Lost connection") > -1) {
		console.info("未连接上网关地址：" + g_gatewayAddr);
		isConnectedGateWay = false;
		disconnect();
	}
}


// 更新停车场数据
function updateParkingDatas(data) {
	// 车牌信息
	var licenceInfo = data.licenceInfo;

	if (licenceInfo.passageType == 1) {
		$("#parking_inPassageCarNum").html(data.inPassageCarNum); // 入口车流量

		if ($("#parking_licenceDiv").children().length > 3) {
			$("#parking_licenceDiv").children().eq(3).remove();
		}
		var carColor = "temp_car";
		if (licenceInfo.carType == '固定车') {
			carColor = "fixed_car";
		} else if (licenceInfo.carType == '访客车') {
			carColor = "visit_car";
		} else {
			carColor = "temp_car"
		}

		var divLicence = "<div class='park-picture-div1'><div class='park-picture-div2' style = 'cursor:pointer'>" + "<img style='width: 160px;height: 90px;' src='" + licenceInfo.snapshot + "' onerror='onErrorHandle(this)'></img></div>" + "<div class='park-picture-div3'>" + "<div class='park-num1'>" + licenceStrDeal(licenceInfo.licencePlate) + "</div>" + "<div class='" + carColor + "'>" + licenceInfo.carType + "</div></div></div>";

		$("#parking_licenceDiv").prepend(divLicence);
		getTodayEchart(157, "parkingEchart");
	}
}

function onErrorHandle(obj){
	obj.src= ctx+"/static/img/jiazai.svg";
	}

function queryPersonnelData() {
	$.ajax({
		type : "post",
		url : ctx + "/access-control/personSummaryData/getEducationData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.code == 0 && data.data) {
				var data = data.data;
				personnelType(data);
			}
		},
		error : function(req, error, errObj) {
			return;
		}
	});
}

/*function toSubscribe() {
	console.log("websocket订阅");
}*/

function personnelType(data) {
	var classificationOne = data.classificationOne;
	var classificationTwo = data.classificationTwo;
	var classificationThree = data.classificationThree;
	var classificationFour = data.classificationFour;
	var classificationFive = data.classificationFive;
	if (null == data.classificationOne) {
		classificationFive = 0;
	}
	if (null == data.classificationTwo) {
		classificationFive = 0;
	}
	if (null == data.classificationThree) {
		classificationFive = 0;
	}
	if (null == data.classificationFour) {
		classificationFive = 0;
	}
	if (null == data.classificationFive) {
		classificationFive = 0;
	}
	var total = data.classificationOne + data.classificationTwo + data.classificationThree + data.classificationFour + data.classificationFive;
	if (total != 0) {
		$("#permanentNum").html(data.classificationOne);
		$("#floatingNum").html(data.classificationTwo);
		$("#IHseparationNum").html(data.classificationThree);
		$("#overseasSeparationNum").html(data.classificationFour);
		$("#otherNum").html(data.classificationFive);
		$("#permanentDiv").css("width", data.classificationOne / total * 100 + "%");
		$("#floatingDiv").css("width", data.classificationTwo / total * 100 + "%");
		$("#IHseparationDiv").css("width", data.classificationThree / total * 100 + "%");
		$("#overseasSeparationDiv").css("width", data.classificationFour / total * 100 + "%");
		$("#otherDiv").css("width", data.classificationFive / total * 100 + "%");
	}
}

// 轮播
function getBannerList() {
	$.ajax({
		type : "post",
		url : ctx + "/system/projectBanner/getBannerList/" + projectCode,
		dataType : 'json',
		success : function(data) {
			buildBanner(data);
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作提示", " 操作失败");
			return false;
		}

	});
}
// 项目概况
function getOverview() {
	$.ajax({
		type : "post",
		url : ctx + "/system/secProjectOverview/getProjectOverview/" + projectCode,
		success : function(data) {
			if (data) {
				data = JSON.parse(data);
				buildOverview(data);
			}
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	})
}
// 新闻
function getProjectNews() {
	$.ajax({
		type : "post",
		url : ctx + "/system/secProjectNews/getProjectNewsLimit/" + projectCode,
		success : function(data) {
			if (data) {
				data = JSON.parse(data);
				buildNews(data);
			}
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	})
}
function buildBanner(data) {
	if (data.length == 0) {
		$("#project-data").hide();
		$("#project-no-data").show();
		$("#project-no-data").css("background-image", "url(" + ctx + "/static/img/hs-no-data.png)");
		return;
	}
	$("#project-data").show();
	$("#project-no-data").hide();
	$.each(data, function(i, val) {
		var html = '<li><img class ="silder-img" src ="' + val.url + '" ></li>';
		$(".db-slide-ul").append(html);
	})
	jQuery(".slideBox").slide({
		mainCell : ".bdSlide .db-slide-ul",
		autoPlay : true,
		interTime : 5000
	});
}
function buildNews(data) {
	if (data.length == 0) {
		$(".txtScroll-left").hide();
		return;
	}
	$(".txtScroll-left").show();
	$.each(data, function(i, val) {
		var newsTitle = val.newsTitle;
		if (val.newsTitle.length > 20) {
			newsTitle = val.newsTitle.substring(0, 20) + "...";
		}
		var html = '<li><div  title="' + val.newsContent + '" class="text">' + newsTitle + '</div></li>';
		$(".infoList").append(html);
	})
	if (data.length > 1) {
		jQuery(".txtScroll-left").slide({
			mainCell : ".bd ul",
			autoPage : true,
			effect : "leftLoop",
			autoPlay : true,
			interTime : 4000
		});
	}
}
function buildOverview(data) {

	if (typeof (data.overview) != "undefine") {
		$("#marquee-text").html(data.overview);
        /*var height = data.overview.length / 12 * 25;
        $(".notic-text1").css("height", height);

        var oH=document.getElementsByTagName('head')[0];
        var oS=document.createElement('style');
        oH.appendChild(oS);
        oS.innerHTML = "@keyframes move{0%{top:124px;}100%{top: " + -height + "px;}}";*/

    }
}

// 获取echart
function getEchart(reportId, divId) {
	$.ajax({
		type : "post",
		url : ctx + "/report/" + reportId + "?projectCode=" + projectCode,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var obj = echarts.init(document.getElementById(divId));
			obj.setOption($.parseJSON(data));
		},
		error : function(req, error, errObj) {
		}
	});
}

// 获取echart
function getTodayEchart(reportId, divId) {
	var startTime = getDateStr(0);
	var endTime = getDateStr(1);
	$.ajax({
		type : "post",
		url : ctx + "/report/" + reportId + "?projectCode=" + projectCode + "&startTime=" + startTime + "&endTime=" + endTime,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var obj = echarts.init(document.getElementById(divId));
			obj.setOption($.parseJSON(data));
		},
		error : function(req, error, errObj) {
		}
	});
}
// 房屋统计
function getHouseData() {
	$.ajax({
		type : "post",
		url : ctx + "/access-control/projectHouseInfo/getProjectHouseSummaryData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			projectHouseInfo(data);
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
}

function projectHouseInfo(data) {
	var houseSelf = 0;
	var houseLease = 0;
	var houseSublease = 0;
	var houseOther = 0;
	var buildingCount = '--';
	if (data != null) {
		houseSelf = data.houseSelf;
		houseLease = data.houseLease;
		houseSublease = data.houseSublease;
		houseOther = data.houseOther;
		buildingCount = data.buildingCommodity + data.buildingPublic + data.houseOther + data.buildingSelf;
	}
	$("#houseCount").html(buildingCount);
	var obj = echarts.init(document.getElementById("houseCharts"));
	obj.clear();
	var option = {
		legend : {
			orient : 'vertical',
			x : "60%",
			y : "5%",
			itemGap : 20,
			itemWidth : 14,
			itemHeight : 14,
			data : [
					'自住   ' + houseSelf, '出租   ' + houseLease, '转租   ' + houseSublease, '其它   ' + houseOther
			],
			textStyle : {
				padding : [
						5, 5, 5, 10
				],
				color : '#979797',
				fontSize : 14
			}
		},
		series : [
				{
					type : 'pie',
					radius : [
							'30%', '70%'
					],
					center : [
							"26%", "55%"
					],
					data : [
						{
							value : 54.6,
							itemStyle : {
								normal : {
									color : 'rgba(77,161,255,0.1)'
								}
							}
						}
					],
					label : {
						normal : {
							show : false,
						}
					}
				}, {
					type : 'pie',
					radius : [
							'30%', '60%'
					],
					center : [
							"26%", "55%"
					],
					color : [
							'#4095F1', '#F18B7C', '#EABB58', '#2FCCCE'
					],
					label : {
						normal : {
							show : false,
							textStyle : {
								color : '#AFBDD1',
								fontSize : 12
							},
							// color: '#FFFFFF',
							formatter : '{b}: {c}'
						}
					},
					labelLine : {
						normal : {
							lineStyle : {
								color : '#979797'
							},
							length : 20,
							length2 : 35
						}
					},
					data : [
							{
								value : houseSelf,
								name : '自住   ' + houseSelf
							}, {
								value : houseLease,
								name : '出租   ' + houseLease
							}, {
								value : houseSublease,
								name : '转租   ' + houseSublease
							}, {
								value : houseOther,
								name : '其它   ' + houseOther
							}
					]
				}
		]
	};
	obj.setOption(option);
}
// 安全事件报警展示（1分钟刷新1次）
function eventDetails() {
	$.ajax({
		type : "post",
		url : ctx + "/securityIncident/getIncidentByProject?projectId=" + projectId,
		contentType : "application/json;charset=utf-8",
		dataType : "json",
		async : false,
		success : function(data) {
			var safeDiv = document.getElementById("event-details-ul");
			while (safeDiv.hasChildNodes()) // 当div下还存在子节点时 循环继续
			{
				safeDiv.removeChild(safeDiv.firstChild);
			}
			IncidentHtml = '';
			if (data && data.items.length > 0) {
				$.each(data.items, function(i, item) {
					showIncident(item);
				})
				$("#event-details-ul").append(IncidentHtml);
				alarmSlide();
			}
		},
		error : function(req, error, errObj) {
		}
	})
	getEventEcharts("alarm-charts", null);
	var startTime = getDateStr(0);
	var endTime = getDateStr(1);
	$.ajax({
		type : "post",
		url : ctx + "/securityIncident/getTodayIncidentNum?projectId=" + projectId + "&startTime=" + startTime + "&endTime=" + endTime,
		contentType : "application/json;charset=utf-8",
		dataType : "json",
		async : false,
		success : function(data) {
			getEventEcharts("alarm-charts", data);
		},
		error : function(req, error, errObj) {
		}
	})
}
function alarmSlide() {
	if ($("#playStateCell").hasClass("pauseState")) {
		$("#playStateCell").removeClass("pauseState");
	}
	$("#playStateCell").triggerHandler('click');
	$("#event-details").unbind();
	$("#playStateCell").unbind();
	$("#event-details-ul .clone").remove();
	if ($("#event-details .tempWrap").length > 0) {
		$("#event-details-ul").unwrap();
	}
	$("#event-details").slide({
		mainCell : "#event-details-ul",
		autoPage : true,
		effect : "topLoop",
		autoPlay : true,
		vis : 5,
		interTime : 1500,
		playStateCell : "#playStateCell"
	});
}
function showIncident(item, incidentType) {
	if (item.incidentLocation == undefined || item.incidentLocation == null) {
		item.incidentLocation = "";
	} else {
		item.incidentLocation = "，" + item.incidentLocation;
	}
	if (item.incidentName == undefined || item.incidentName == null) {
		item.incidentName = "";
	} else {
		item.incidentName = "，出现" + item.incidentName;
	}
	var content = item.occurTime + item.incidentLocation + item.incidentName;
	IncidentHtml = IncidentHtml + '<p title="' + content + '" class="alarm-detail-font">'
	var length = getBLen(content);
	if (length > 55) {
		content = subString1(content, "55") + "...";
	}
	IncidentHtml = IncidentHtml + content + '</p>';
}

function subString1(str, len) {
	var regexp = /[^\x00-\xff]/g;// 正在表达式匹配中文
	// 当字符串字节长度小于指定的字节长度时
	if (str.replace(regexp, "aa").length <= len) {
		return str;
	}
	// 假设指定长度内都是中文
	var m = Math.floor(len / 2);
	for (var i = m, j = str.length; i < j; i++) {
		// 当截取字符串字节长度满足指定的字节长度
		if (str.substring(0, i).replace(regexp, "aa").length >= len) {
			return str.substring(0, i);
		}
	}
	return str;
}

function getBLen(str) {
	if (str == null)
		return 0;
	if (typeof str != "string") {
		str += "";
	}
	return str.replace(/[^\x00-\xff]/g, "01").length;
}

function getEventEcharts(divId, data) {
	var interval = 2;
	var max = 10;
	var num1 = 0;
	var num2 = 0;
	var num3 = 0;
	var num4 = 0;
	var num5 = 0;
	var num6 = 0;
	var num7 = 0;
	var num8 = 0;
	if (data != null) {
		num1 = data.num1;
		num2 = data.num2;
		num3 = data.num3;
		num4 = data.num4;
		num5 = data.num5;
		num6 = data.num6;
		num7 = data.num7;
		num8 = data.num8;
		max = Math.max(num1, num2, num3, num4, num5, num6, num7, num8);
		if (max == 0) {
			max = 5;
		} else if (max <= 5) {
			max = 5
		} else {
			maxNum = parseInt(max % 10);
			if (maxNum != 0) {
				max = max + 10 - parseInt(max % 10);
			}
		}
		interval = max / 5;
	}
	var obj = echarts.init(document.getElementById(divId));
	obj.clear();
	var option = {
		backgroundColor : '#162D39',
		angleAxis : {
			interval : 1,
			type : 'category',
			data : [
					'消防火警', '消防通道堵塞', '高空抛物', '重点关注人员', '进入危险区域', '群体事件', '黑名单人员', '电梯困人',
			],
			z : 10,
			axisLine : {
				show : true,
				lineStyle : {
					color : "#00C1FA",
					width : 0.1,
					type : "solid",
					opacity : 0.1
				},
			},
			axisLabel : {
				interval : 0,
				show : true,
				color : "#34CFFC",
				margin : 8,
				fontSize : 14
			},
			axisTick : {
				show : false
			}
		},
		radiusAxis : {
			min : 0,
			max : max,
			interval : interval,
			axisLine : {
				show : true,
				lineStyle : {
					color : "#00C1FA",
					width : 1,
					type : "solid",
					opacity : 0.26
				},
			},
			axisLabel : {
				formatter : '{value}',
				show : true,
				padding : [
						0, 0, 20, 0
				],
				color : "#00C1FA",
				fontSize : 10
			},
			axisTick : {
				show : false
			},
			splitLine : {
				lineStyle : {
					color : "#00C1FA",
					width : 1,
					type : "solid",
					opacity : 0.26
				}
			}
		},
		polar : {},
		series : [
			{
				type : 'bar',
				radius : [
						'0', '60%'
				],
				data : [
						{
							value : num1,
							itemStyle : {
								normal : {
									color : "#F37B7B"
								}
							}
						}, {
							value : num2,
							itemStyle : {
								normal : {
									color : "#EF9D7F"
								}
							}
						}, {
							value : num3,
							itemStyle : {
								normal : {
									color : "#EABB58"
								}
							}
						}, {
							value : num4,
							itemStyle : {
								normal : {
									color : "#C4D846"
								}
							}
						}, {
							value : num5,
							itemStyle : {
								normal : {
									color : "#2FCCCE"
								}
							}
						}, {
							value : num6,
							itemStyle : {
								normal : {
									color : "#2B8DF7"
								}
							}
						}, {
							value : num7,
							itemStyle : {
								normal : {
									color : "#678CDF"
								}
							}
						}, {
							value : num8,
							itemStyle : {
								normal : {
									color : "#F37FE2"
								}
							}
						}
				],
				coordinateSystem : 'polar',
			}
		],
	};
	obj.setOption(option);
}

function getParkingData() {
	// 停车场模块数据初始化
	$.ajax({
		type : "post",
		url : ctx + "/parking/parkingMain/getParkingOperationSystemPageData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.code == 0 && data.data != null) {
				var result = data.data;
				$("#parking_inPassageCarNum").html(result.inPassageCarNum); // 入口车流量
				var licenceInfoObj = result.licenceInfos;
				$("#parking_licenceDiv").empty();
				for ( var i in licenceInfoObj) {

					var carColor = "temp_car";
					if (licenceInfoObj[i].carType == '固定车') {
						carColor = "fixed_car";
					} else if (licenceInfoObj[i].carType == '访客车') {
						carColor = "visit_car";
					} else {
						carColor = "temp_car";
					}

					var divLicence = "<div class='park-picture-div1' ><div class='park-picture-div2'>" + "<img style='width: 160px;height: 90px;' src='" + licenceInfoObj[i].snapshot + "'; onclick='createParkingSnapModal(this,event)' ;onerror='onErrorHandle(this)'></img></div>" + "<div class='park-picture-div3'>" + "<div class='park-num1'>" + licenceStrDeal(licenceInfoObj[i].licencePlate) + "</div>" + "<div class='" + carColor + "'>" + licenceInfoObj[i].carType + "</div></div></div>";

					$("#parking_licenceDiv").append(divLicence);

				}

			} else {

			}
		},
		error : function(req, error, errObj) {
			return;
		}
	});

	getTodayEchart(157, "parkingEchart");
	getShareParkNum();
}
//车行弹窗
function createParkingSnapModal(data,event){
	event.stopPropagation();
	var url =data.src;
	if(data=="undefined"){
		return;
	}
	createModalWithLoad("alarm-device-img", 730, 500, "车辆场景抓拍",
			"alarmEventDefines/snapshotImage?snapshotImages=" +url , "", "", "");
	openModal("#alarm-device-img-modal", true, false);
}

//人行弹窗
function createAccessSnapModal(id,event){
	event.stopPropagation();
	var url =$("#facewall_img_" + id).attr("src");
	if(url=="undefined" || typeof(url) == "undefined"){
		return;
	}
	createModalWithLoad("alarm-device-img", 730, 500, "人行场景抓拍",
			"alarmEventDefines/snapshotImage?snapshotImages=" +url , "", "", "");
	openModal("#alarm-device-img-modal", true, false);
}
// 车牌切割-中间加空格
function licenceStrDeal(strData) {
	if (strData != null && strData.length > 2) {
		return strData.substring(0, 2) + "&nbsp" + strData.substring(2, strData.length);
	}
}

function getShareParkNum() {
	// 停车场模块共享车位查询
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/geomagParkingStatus/getShareParkData?projectCode=" + projectCode,
		async : false,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null) {
				$("#parking_remainParkingSpace").html(data.parkingRemain);
			}

		},
		error : function(req, error, errObj) {
		}
	});
}
// 人行流量数据处理
function getFaceWallData() {
	$.ajax({
		type : "post",
		url : ctx + "/access-control/accessStatistics/getProjectFaceWall?projectCode=" + projectCode,
		async : false,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(result) {
			if (result && typeof (result.code) != undefined && result.code == 0) {
				undateAccessData(result.data)
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

function undateAccessData(data) {
	// 数据百分比处理
	if (typeof (data.totalNum) != 'undefined') {
		if (data.totalNum >= 10000) {
			$("#access-con-totalNum").html(Math.floor(data.totalNum * 10 / 10000) / 10 + "万");
		} else {
			$("#access-con-totalNum").html(data.totalNum);
		}
	}
	if (data.totalNum > 0) {
		//以下数据先定死为男：51%，女：49%
		//accessChangePercent("access-gender", Math.round(100 * (data.genderPercent + 50) / (data.totalNum + 100)));
		accessChangePercent("access-gender", Math.round(100 * 51 / 100));
		
		
		// accessChangePercent("access-age", Math.round(100 * data.agePercent / data.totalNum));
		accessChangePercent("access-owner", Math.round(100 * data.ownerPercent / data.totalNum));
	}
	// 人脸图片处理
	if (data.userList) {
		appendFaceImage(data.userList);
	}
}

// 人行流量更改百分比
function accessChangePercent(id, leftPercent) {
	if (typeof (leftPercent) == 'undefined') {
		return;
	}
	if (leftPercent < 0) {
		leftPercent = 0;
	}
	if (leftPercent > 100) {
		leftPercent = 100;
	}
	$("#" + id + " .mask").animate({
		left : leftPercent + "%"
	}, 500);
	$("#" + id + " .left-percent").html(leftPercent + "%");
	$("#" + id + " .right-percent").html((100 - leftPercent) + "%");
}

// 人行流量人脸图片
function appendFaceImage(userList) {
	console.log(JSON.stringify(userList));

	jQuery.each(userList.reverse(), function(i, val) {
		if ($("#facewall_" + val.personId).length > 0) {
			$("#facewall_" + val.personId).remove();
		} else {
			var faceSize = $("#access-face .face_info").size();
			if (faceSize >= 8) {
				$("#access-face .face_info:last").remove();
			}
		}
		var faceClass = "face_img";
		var faceClassCanvas = "face_img_canvas"

        var faceHtml = "";

        // 枚举类型见 com.rib.ib.common.consts.CommonConstant.FACE_WALL_PERSON_TYPE
        if (val.personType == 0) {//陌生人
			faceClass = "face_img";
            faceHtml = '<div class="face_info" id="facewall_' + val.personId + '" style="position: relative; cursor:pointer;" onclick="createAccessSnapModal(\'' + val.personId + '\',event)">' 
            + '<img id="facewall_img_' + val.personId + '" class="' + faceClass + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(this,event)">'
            + '<svg version="1.1" xmlns="http://www.w3.org/2000/svg"> <defs> <filter id="blur" x="0" y="0"> <feGaussianBlur in="SourceGraphic" stdDeviation="1.5" /></filter></defs><rect width="74" height="74" stroke-width="1" filter="url(#blur)" />'
			+ '<image xlink:href="' + val.faceUrl + '" x="0" y="0" height="74" width="74" filter="url(#blur)" /></svg>'
            //+ '<canvas id="facewall_canvas_' + val.personId + '" class="' + faceClassCanvas + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(\'' + val.personId + '\',event)"></canvas>' 
            + '</div>';
		} else if(val.personType == 1){//业主
			faceHtml = '<div class="face_info" id="facewall_' + val.personId + '" style = "cursor:pointer;" onclick="createAccessSnapModal(\'' + val.personId + '\',event)">' 
			+ '<img id="facewall_img_' + val.personId + '" class="' + faceClass + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(this,event)">' 
			+ '<svg version="1.1" xmlns="http://www.w3.org/2000/svg"> <defs> <filter id="blur" x="0" y="0"> <feGaussianBlur in="SourceGraphic" stdDeviation="1.5" /></filter></defs><rect width="74" height="74" stroke-width="1" filter="url(#blur)" />'
			+ '<image xlink:href="' + val.faceUrl + '" x="0" y="0" height="74" width="74" filter="url(#blur)" /></svg>'
			//+ '<canvas id="facewall_canvas_' + val.personId + '" class="' + faceClassCanvas + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(\'' + val.personId + '\',event)"></canvas>' 
			+ '</div>';
			
			
		} else if (val.personType == 2) { //VIP
            faceHtml = '<div class="face_info" id="facewall_' + val.personId + '" style="position: relative;border: 1px solid #F8E71C ;cursor:pointer;" onclick="createAccessSnapModal(\'' + val.personId + '\',event)">' 
            + '<img id="facewall_img_' + val.personId + '" class="' + faceClass + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(this,event)" style="width: 72px;height: 72px;">' 
            + '<svg version="1.1" xmlns="http://www.w3.org/2000/svg"> <defs> <filter id="blur" x="0" y="0"> <feGaussianBlur in="SourceGraphic" stdDeviation="1.5" /></filter></defs><rect width="72" height="70" stroke-width="1" filter="url(#blur)" />'
			+ '<image xlink:href="' + val.faceUrl + '" x="0" y="0" width="72" height="70" filter="url(#blur)" /></svg>'
            //+ '<canvas id="facewall_canvas_' + val.personId + '" class="' + faceClassCanvas + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(\'' + val.personId + '\',event)" style="width: 72px;height: 72px;"></canvas>'
            + '<div style="display: block;height: 30px;z-index: 2;position: absolute;width: 30px;top: 43px;left: 43px;color: #F8E71C;">' 
            + '<img src="'+ctx+'/static/img/video/vip_img.svg" style="width: 30px;height: 30px;"/>' 
            + '</div></div>';
		} else if (val.personType == 3) { //重点关注人员
            faceHtml = '<div class="face_info" id="facewall_' + val.personId + '" style="position: relative;border: 1px solid #D632FF;cursor:pointer;" onclick="createAccessSnapModal(\'' + val.personId + '\',event)">' 
            + '<img id="facewall_img_' + val.personId + '" class="' + faceClass + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(this,event)" style="width: 72px;height:72px">'
            + '<svg version="1.1" xmlns="http://www.w3.org/2000/svg"> <defs> <filter id="blur" x="0" y="0"> <feGaussianBlur in="SourceGraphic" stdDeviation="1.5" /></filter></defs><rect width="72" height="70" stroke-width="1" filter="url(#blur)" />'
			+ '<image xlink:href="' + val.faceUrl + '" x="0" y="0" width="72" height="70" filter="url(#blur)" /></svg>'
            //+ '<canvas id="facewall_canvas_' + val.personId + '" class="' + faceClassCanvas + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(\'' + val.personId + '\',event)" style="width: 72px;height: 72px;"></canvas>'
            + '<div class="face_bottom_info" style="background-color: rgba(214,50,255,0.6);">重点关注</div></div>';
		} else if (val.personType == 4) { //黑名单
            faceHtml = '<div class="face_info" id="facewall_' + val.personId + '" style="position: relative;border: 1px solid #FF6262 ;cursor:pointer;" onclick="createAccessSnapModal(\'' + val.personId + '\',event)">' 
            + '<img id="facewall_img_' + val.personId + '" class="' + faceClass + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(this,event)" style="width: 72px;height: 72px;">'
            + '<svg version="1.1" xmlns="http://www.w3.org/2000/svg"> <defs> <filter id="blur" x="0" y="0"> <feGaussianBlur in="SourceGraphic" stdDeviation="1.5" /></filter></defs><rect width="72" height="70" stroke-width="1" filter="url(#blur)" />'
			+ '<image xlink:href="' + val.faceUrl + '" x="0" y="0" width="72" height="70" filter="url(#blur)" /></svg>'
            //+ '<canvas id="facewall_canvas_' + val.personId + '" class="' + faceClassCanvas + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(\'' + val.personId + '\',event)" style="width: 72px;height: 72px;"></canvas>'
            + '<div class="face_bottom_info" style="background-color: rgba(255,98,98,0.6);">黑名单</div></div>';
		} else {
            faceHtml = '<div class="face_info" style = "cursor:pointer;" id="facewall_' + val.personId + '">' 
            + '<img id="facewall_img_' + val.personId + '" class="' + faceClass + '" src="' + val.faceUrl + '" onclick="createAccessSnapModal(this,event)" onclick="createAccessSnapModal(\'' + val.personId + '\',event)">' 
            + '<svg version="1.1" xmlns="http://www.w3.org/2000/svg"> <defs> <filter id="blur" x="0" y="0"> <feGaussianBlur in="SourceGraphic" stdDeviation="1.5" /></filter></defs><rect width="74" height="74" stroke-width="1" filter="url(#blur)" />'
			+ '<image xlink:href="' + val.faceUrl + '" x="0" y="0" height="74" width="74" filter="url(#blur)" /></svg>'
            //+ '<canvas id="facewall_canvas_' + val.personId + '" class="' + faceClassCanvas + '" src="' + val.faceUrl + ' " onclick="createAccessSnapModal(\'' + val.personId + '\',event)"></canvas>'
            + '</div>';
        }
		// startFaceRecoginaze(val.faceUrl);//开始展现人脸识别效果
		$("#access-face").prepend(faceHtml);
		//setCanvas(val.personId);
	});
}

function setCanvas(personId) {
	console.log(personId);
	stackBlurImage('facewall_img_' + personId, 'facewall_canvas_' + personId, 30, true);
}


function getDateStr(addDayCount) {
	var dd = new Date();
	dd.setDate(dd.getDate() + addDayCount);// 获取AddDayCount天后的日期
	var y = dd.getFullYear();
	var m = dd.getMonth() + 1;// 获取当前月份的日期
	if (m.toString().length == 1) {
		m = '0' + m;
	};
	var d = dd.getDate();
	if (d.toString().length == 1) {
		d = '0' + d;
	};
	return y + "-" + m + "-" + d + " 00:00:00";
}
