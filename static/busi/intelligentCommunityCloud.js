var stompClient = null;
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
		// 消防火警报警、电梯困人报警 视频弹窗websocket连接
		toSubscribeElevatorAlarmInfo();
		// 告警中心告警
		stompClient.subscribe('/topic/groupData', function(result) {
			var json = JSON.parse(result.body);
			websocketCallBack(json);
		});

		stompClient.subscribe('/topic/waSuAlarmSnapshotPageData' , function(result) {
			var json = JSON.parse(result.body);
			alarmQueue.push(json);
		});
	}, onerror);
}

function showSnapshotImage(){
	var json = alarmQueue.pop();
	if(json){
		var location = json.location.substring(0,8);
		if(alarmOut){
			clearTimeout(alarmOut);
		}
		if(alarmQueue.size>0){
				$("#alarmImg").attr("src",json.imageUrl);
				$("#alarmType").html(json.alarmTypeName);
				$("#location").html(location);
				$("#alarmImageDiv").show();
				alarmOut = setTimeout(function(){
					$("#alarmImageDiv").hide();
					clearTimeout(alarmOut);
				},1500);
		}else{
			$("#alarmImg").attr("src",json.imageUrl);
			$("#alarmType").html(json.alarmTypeName);
			$("#location").html(location);
			$("#alarmImageDiv").show();
			alarmOut = setTimeout(function(){
				$("#alarmImageDiv").hide();
				clearTimeout(alarmOut);
			},10000);
		}
	}
}

// 根据类型转入不同的方法
function websocketCallBack(json) {
	if (json.type == 'ALARM') {
		displayAlarmInfo(json.data);
	} else if (json.type == 'TEST') {
	} else if (json.type == 'ACCESS_CONTROL') {
	} else if (json.type == 'FIRE_FIGHTING') {
	} else if (json.type == 'SUPPLY_DRAIN') {
	} else if (json.type == 'VIDEO_MORNITORING') {
	} else if (json.type == 'POWER_SUPPLY') {
	} else if (json.type == 'HVAC') {
	} else if (json.type == 'PARKING') {
	} else if (json.type == 'ENV_MONITOR') {
	} else if (json.type == 'ELEVATOR') {
	}

}

// 点图项目点显示红色
function displayAlarmInfo(data) {
	/*
	 * $(".red-point").remove(); $(".green-fluctuation").remove();
	 * $(".green-point").remove(); fillPiontImg();
	 */
	var projectName = data.projectName;
	initProjectIcon(projectName);
}

function onerror(frame) {
	if (frame.indexOf("Lost connection") > -1) {
		console.info("未连接上网关地址：" + g_gatewayAddr);
		isConnectedGateWay = false;
		disconnect();
	}
}

function disconnect() {
	if (stompClient != null) {
		stompClient.disconnect();
	}
}
/*function unloadAndRelease() {
	disconnect();
}*/

// 获取饼图echart
function getBingEchart(reportId, divId) {
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
// 获取重要告警
function getImportantAlaramRecord() {
	$.ajax({
		type : "post",
		url : ctx + "/alarm-center/alarmRecord/getAlarmRecordLimit?limit=7&diagCode=BIN_JIANG",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data) {
				var result = JSON.parse(data);
				showImportantAlaram(result);
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

// 重要告警
function showImportantAlaram(data) {
	$("#device-alaram-div").empty();
	$("#device-alaram-div").append("<div class='bd'> <ul id='item-text-ul'></ul></div>");
	for ( var index in data) {

		var projectName = data[index].projectName;
		var location = data[index].devicePosition;
		var describe = data[index].describe;
		var timeDesc = data[index].lastAlarmTime;
		var systemCode = data[index].systemCode;
		if(typeof(timeDesc)=="undefined"){
			continue;
		}
		var desc = "";
		if (projectName != "") {
			desc = desc + projectName;
		}
		if (location != "" && location != undefined) {
			desc = desc + "," + location;
		}
		if (describe != "") {
			desc = desc + "," + describe;
		}

		var alaramIcon = ctx + "/static/img/bjCloud/alarmImg/fireIcon.svg";

		if (systemCode == "01") {
			alarmIcon = ctx + "/static/img/bjCloud/alarmImg/fireIcon.svg";
		} else if (systemCode == "02") {
			alarmIcon = ctx + "/static/img/bjCloud/alarmImg/accessIcon-red.svg";
		} else if (systemCode == "03") {
			alarmIcon = ctx + "/static/img/bjCloud/alarmImg/elevIcon-red.svg";
		} else if (systemCode == "04") {
			alarmIcon = ctx + "/static/img/bjCloud/alarmImg/parkingIcon-red.svg";
		} else if (systemCode == "05") {
			alarmIcon = ctx + "/static/img/bjCloud/alarmImg/vedioIcon-red.svg";
		} else if (systemCode == "06") {
			alarmIcon = ctx + "/static/img/bjCloud/alarmImg/warmIcon-red.svg";
		} else if (systemCode == "07") {
			alarmIcon = ctx + "/static/img/bjCloud/alarmImg/waterIcon-red.svg";
		} else if (systemCode == "08") {
			alarmIcon = ctx + "/static/img/bjCloud/alarmImg/powerIcon-red.svg";
		}
		var importAlarmDeviceImg =  ctx + "/static/img/alarm/importAlarmDeviceImg.svg";
		var imgHtml =  '';
		  if(data[index].snapImages){
			  imgHtml =  '<div class = "device-snapImage-div" ><img class = "device-snapImage" src="' + importAlarmDeviceImg + '"/></div>';
		  }
		var alaramContent = '<li class="alarm_text" onclick="createSnapModal(\''+ data[index].snapImages+ '\')">'+
		  '<div style="width:429px">'+
		  '<div class = "device-icon-div"><img class = "device-icon" src="' + alarmIcon + '"/></div>'+
		  '<div class="alarm-text-item">' + desc + '</div>'+
		  '<div class="alarm-time">' + timeDesc + '</div>'+
		  imgHtml +
		  '<div class="border-line"></div></div>'+
		  '</li>';
// var alaramContent = '<div class="alarm-item"><img src="' + alarmIcon + '"/>'
// + '<span class="alarm-text-item">' + desc + '</span>' +
// '<span class="alarm-time">' + timeDesc + '</span><div
// class="border-line"></div></div>';
		$("#item-text-ul").append(alaramContent);
	}
	bindDeviceSlide();
}
function createSnapModal(snapshotImages) {
	if(snapshotImages=="undefined"){
		return;
	}
	createModalWithLoad("alarm-device-img", 730, 500, "重要告警抓拍",
			"alarmEventDefines/snapshotImage?snapshotImages=" + snapshotImages, "", "", "");
	openModal("#alarm-device-img-modal", true, false);
	$('#alarm-device-img-modal').on('shown.bs.modal', function() {
		loadPic();
	})
}

// 安全事件报警展示
function securityIncident() {
	$.ajax({
		type : "post",
		url : ctx + "/securityIncident/getIncident?diagrammaticCode=BIN_JIANG",
		contentType : "application/json;charset=utf-8",
		dataType : "json",
		async : false,
		success : function(data) {
			securityData = data.items;
			showSecurityIncident();

		},
		error : function(req, error, errObj) {
		}
	})
}
function bindSafeSlide(){
	// if(!bindSafeStatus){
	// bindSafeStatus = true;
		jQuery("#event-alarm").slide({ mainCell:".event-bd ul",autoPage:true,effect:"topLoop",autoPlay:true,vis:7,interTime:1500});

	// }
}
//展示安全事件
function showSecurityIncident(){

	//解决对象拷贝修改原值的问题
//	var	securityDataJson =  JSON.stringify(securityData);
//  var tmpSecurityData = JSON.parse(securityDataJson);
	var tmpSecurityData = $.extend(true,[],securityData);

	var length = tmpSecurityData.length;
	var pageSize =  Math.ceil(length /7);//页数
	var end = 7 * secPageNumber + 7;
	var  secData = null;
	if(end <  length){
		secData  = tmpSecurityData.slice(7 * secPageNumber,end);
		secPageNumber++;
	}else{
		secData  = tmpSecurityData.slice(7 * secPageNumber);
		secPageNumber=0;
	}

	//IncidentHtml = '';
	if (secData && length > 0) {
		$("#event-alarm").empty();
		$("#event-alarm").append("<div class='event-bd text1'><ul id='safe-text-ul'></ul></div>");
		for(var i in secData){
			    var itema = secData[i];
			  //  alarmInfoData[itema.deviceId] = itema;
				var level = itema.level;
				var time = itema.occurTime;
				var attention = itema.attention;
				var deviceId = itema.deviceId;
				if (itema.incidentType == 1) {
					// 消防火警
					showIncident(itema, fireFightingAlarm,level,deviceId,time,attention);
				} else if (itema.incidentType == 2) {
					// 消防通道堵塞
					showIncident(itema, fireFightingBlock,level,deviceId,time,attention);
				} else if (itema.incidentType == 3) {
					//高空抛物
					showIncident(itema, gaokongpaowu ,level,deviceId,time,attention);
				} else if (itema.incidentType == 4) {
					// 重点关注人员
					showIncident(itema,importantFocus ,level,deviceId,time,attention);
				} else if (itema.incidentType == 5) {
					// 进入危险区域
					showIncident(itema, dangerousArea,level,deviceId,time,attention);
				} else if (itema.incidentType == 6) {
					// 群体事件
					showIncident(itema, peopleEvent,level,deviceId,time,attention);
				} else if (itema.incidentType == 7) {
					// 黑名单人员
					showIncident(itema, blackList,level,deviceId,time,attention);
				} else if (itema.incidentType == 8) {
					// 电梯困人
					showIncident(itema, elevPeople,level,deviceId,time,attention);
				}
		}

	//	bindSafeSlide();
	}
}

function bindDeviceSlide(){

// if(!bindDeviceStatus){
// bindDeviceStatus = true;
		jQuery(".device-alaram-div").slide({ mainCell:".bd ul",autoPage:true,effect:"topLoop",autoPlay:true,vis:7,interTime:1500});
// }
}
function showIncident(item,incidentType,level,deviceId,time,attention) {
    var ele = JSON.stringify(item);
    var tmpLocation = "";
	if (item.projectName == undefined || item.projectName == null) {
		item.projectName = "";
	}
	if (item.incidentLocation == undefined || item.incidentLocation == null) {
		item.incidentLocation = "";
	} else {
		tmpLocation = "，"+ item.incidentLocation;
		if(item.incidentLocation.length>4){
			item.incidentLocation = item.incidentLocation.substring(0,4)+"..."
		}
		item.incidentLocation = "，" + item.incidentLocation;
	}


	if (item.incidentName == undefined || item.incidentName == null) {
		item.incidentName = "";
	} else {
		item.incidentName = "，出现" + item.incidentName;
	}


    var	eventText =  item.projectName + item.incidentLocation + item.incidentName ;
    var alertContent = item.projectName + tmpLocation + item.incidentName; //鼠标悬浮提醒
	if(eventText.length>18){
		eventText = eventText.substring(0,18)+"..."
	}


	var imgVideoHtml =  '';
	var importVideoImg = ctx + "/static/img/replay.svg";
//	var importSnapImg =  ctx + "/static/img/alarm/importAlarmDeviceImg.svg";
//	var imgSnapHtml =  '';

//	if(data[index].snapImages){
/*	if(1==1){
		imgSnapHtml =  '<div class = "safe-snapImage-div"><img class = "safe-snapImage" src="' + importSnapImg + '"/></div>';
	}*/
	var textColor ="#ABBCD7";
	if(level == 1){
		textColor ="#FF5454"
	}
	var timeColor = "#6B7A95";
	if(attention == 1){
		timeColor = "#F5A623";
	}
	
	if(item.display == 1){
		textColor ="#FF5454"
		timeColor = "#FF5454";
	}

	if((deviceId!= "" && deviceId != undefined) || (item.path != "" && item.path != "undefined")){
		imgVideoHtml =  '<div class = "safe-snapImage-div" data-url="'+ item.path +'"  data-time="'+ time +'" data-deviceId="'+ deviceId +'" onClick="replayVideo(this)"><img class = "safe-snapImage" src="' + importVideoImg + '"/></div>';
	}
	var IncidentHtml = '<li >'+
	  '<div style="width:429px">'+
	  '<div class = "incident-type-image-div"><img class="incident-type-image" src="' + incidentType + '"/></div>'+
	  '<div class="alarm-text-data" style="color:' + textColor +'" onclick=\'showAlarmInfo(' + item.incidentType + ','+ ele + ')\' data-toggle="tooltip" data-placement="bottom" title='+ alertContent +'>'+ eventText + '</div>'  +
	  '<div class="safe-time" style="color:' + timeColor +'">' + item.alarmTime + '</div>'  + imgVideoHtml +
	  '<div class="border-line"></div></div>'+
	  '</li>';
	$("#safe-text-ul").append(IncidentHtml);
}

function showAlarmInfo(type,dataStr) {

    if($('#alarm-info-div') && $('#alarm-info-div').length > 0){
        return;
    }

    var data = dataStr;
    var projectName = data.projectName ? data.projectName : "";
    var incidentName = data.incidentName ? data.incidentName : "";
    var incidentLocation = data.incidentLocation ? data.incidentLocation : "";
    var occurTime = data.occurTime ? data.occurTime : "";
    var categoryName = data.categoryName ? data.categoryName : "";
    var levelName = data.levelName ? data.levelName :"";

	//重点关注人员
	//黑名单
	if(type == 7 || type == 4){
		var recordUuid = data.recordUuid ? data.recordUuid : "";
		$.ajax({
            type : "get",
            url : ctx + "/access-control/accessStatistics/getAccessRecord?recordUuid=" + recordUuid,
            async: false,
            contentType : "application/json;charset=utf-8",
			success: function(data){
                if (data) {
                	var resultInfo = JSON.parse(data);
                	var defaultImgUrl = ctx + "/static/img/video/default_head_img.png";
                	var image = resultInfo.faceImgUrl ? resultInfo.faceImgUrl : defaultImgUrl;
                	var username = incidentName + (resultInfo.username ?  "-" + resultInfo.username : "");
                    $("body").append('<div id="alarm-info-div">' +
                        '<div onclick="closeAlarm()" style="position: absolute;width: 20px;height: 20px;margin-left: 666px;margin-top: 20px;cursor: pointer;">' +
                        '<img src="'+ctx+'/static/img/video/close.png" onerror="' +defaultImgUrl+ '">' +
                        '</div>' +
                        '<div id="alarm-person" class="alarm-video-replay">' +
                        '<div id="alarm-person-photo">' +
                        '<img style="width:200px;height:200px" src="'+image+'"/>' +
                        '</div>' +
                        '<div id="alarm-person-info">' + username +
                        '</div>' +
                        '</div>' +
                        '<div id="alarm-info-desc">' +
                        '<div id="alarm-info-desc-title">安全事件详情</div>' +
                        '<div id="alarm-info-desc-content">' +
                        '<div class="content-tb">' +
                        '<div class="alarm-info">小区名称：'+projectName+'</div>' +
                        '<div class="alarm-info content-tb-right">安全类型：<span class="alarm-warn">'+incidentName+'</span></div>' +
                        '</div>' +
                        '<div class="content-tb">' +
                        '<div class="alarm-info"  title="' + incidentLocation + '">位置信息：' + incidentLocation + '</div>' +
                        '<div class="alarm-info content-tb-right">安全等级：' + levelName + '</div>' +
                        '</div>' +
                        '<div class="content-tb">' +
                        '<div class="alarm-info">发生时间：' + occurTime + '</div>' +
                        '<div class="alarm-info content-tb-right">事件分类：' + categoryName + '</div>' +
                        '</div></div></div></div>');
                }
			},
			error: function(){

			}
        });
	} else {
        $("body").append('<div id="alarm-info-div">' +
            '<div onclick="closeAlarm()" style="position: absolute;width: 20px;height: 20px;margin-left: 666px;margin-top: 20px;cursor: pointer;">' +
            '<img src="'+ctx+'/static/img/video/close.png">' +
            '</div>' +
            '<div id="alarm-video-replay" class="alarm-video-replay">' +
            '</div>' +
            '<div id="alarm-info-desc">' +
            '<div id="alarm-info-desc-title">安全事件详情</div>' +
            '<div id="alarm-info-desc-content">' +
            '<div class="content-tb">' +
            '<div class="alarm-info">小区名称： ' + projectName + '</div>' +
            '<div class="alarm-info content-tb-right">安全事件：<span class="alarm-warn">' + incidentName + '</span></div>' +
            '</div>' +
            '<div class="content-tb">' +
            '<div class="alarm-info" title="' + incidentLocation + '">位置信息：' + incidentLocation + '</div>' +
            '<div class="alarm-info content-tb-right">安全等级：' + levelName + '</div>' +
            '</div>' +
            '<div class="content-tb">' +
            '<div class="alarm-info">发生时间：' + occurTime + '</div>' +
            '<div class="alarm-info content-tb-right">事件分类：' + categoryName + '</div>' +
            '</div></div></div></div>');
            initDSS(data.deviceId,occurTime);
    }
}

function closeAlarm(){
	if($('#alarm-info-div') && $('#alarm-info-div').length > 0){
        if(dssPlayerAlarm != null){
            dssPlayerAlarm.stop();
            dssPlayerAlarm = null;
        }
        $('#alarm-info-div').remove();
    }
}

function initDSS(deviceNo,time){
    var dssProjectCode = "";
    if(typeof(projectCode) != 'undefined'){
        dssProjectCode = projectCode;
    }

	var whithoudVideoShow = ctx + "/static/img/video/without_video_show.png";
    if(!deviceNo){
        $("#alarm-video-replay").html('<img src="'+ whithoudVideoShow +'"/>');
        console.log("设备ID为空");
        return;
    }

    $.ajax({
        type : "get",
        url : ctx + "/device/deviceInfo/dssParam?deviceNo=" + deviceNo + "&type=1&projectCode=" + dssProjectCode,
        dataType : "json",
        async: false,
        contentType : "application/json;charset=utf-8",
        success : function(data) {
            if (data && data.CODE && data.CODE == "SUCCESS") {
                var dssParam = data.RETURN_PARAM;
                loadVideo(dssParam,time);
            } else {
                showDialogModal("error-div", "操作错误", data.MESSAGE);
                $("#alarm-video-replay").html('<img src="'+ whithoudVideoShow +'"/>');
            }
        },
        error : function(req, error, errObj) {
            $("#alarm-video-replay").html('<img src="'+ whithoudVideoShow +'"/>');
            return;
        }
    });
}

function loadVideo(dssParam,playbackTime){
	var beShown = false;

    var playbackDate = new Date(playbackTime.replace(/-/g,'/'));
    var playbackStartTime = formatDateTime(playbackDate.getTime()-10*1000);
    var playbackEndTime = formatDateTime(playbackDate.getTime()+10*1000);
    if($("#alarm-video-replay").length > 0){
        if(!beShown){
            if(dssParam != null){
                dssPlayerAlarm = $("#alarm-video-replay").dssPlayer({
                    ipAddr : dssParam.ipAddr,
                    port : dssParam.port,
                    username : dssParam.userName,
                    password : dssParam.password,
                    width : "100%",
                    height : "100%"
                });
                dssPlayerAlarm.play(dssParam.channel,playbackStartTime,playbackEndTime);
            }
            beShown = true;
        }
    }
}

function formatDateTime(inputTime) {
    var date = new Date(inputTime);
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    m = m < 10 ? ('0' + m) : m;
    var d = date.getDate();
    d = d < 10 ? ('0' + d) : d;
    var h = date.getHours();
    h = h < 10 ? ('0' + h) : h;
    var minute = date.getMinutes();
    var second = date.getSeconds();
    minute = minute < 10 ? ('0' + minute) : minute;
    second = second < 10 ? ('0' + second) : second;
    return y + '-' + m + '-' + d + ' ' + h + ':' + minute + ':' + second;
};

// 获取设备完好率排名数据
function getDeviceNormalRateTop() {

	$.ajax({
		type : "post",
		url : ctx + "/device/deviceInfo/getDeviceNormalRateTop",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data) {
				var result = JSON.parse(data);
				showDeviceNormalRateTop(result);
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

// 展示设备完好率排名
function showDeviceNormalRateTop(data) {
	$("#device-village-div").empty();
	for ( var i in data) {
		if(i=="add"){
			break;
		}
		var projectName = data[i].projectName;
		if(projectName.length>6){
			projectName = projectName.substr(0,5)+"..";
		}

		var rate = data[i].rate;
		var deviceNormalRate = '<div class="device-village"><div class="font"><font class="inner-font">' + projectName + '<font></div><div class="bg-item">' + '<div class="inset-item" style="width:' + rate + '"></div><span class="percentage-value">' + rate + '</span></div></div>';
		$("#device-village-div").append(deviceNormalRate);
		if(i==4){
			break;
		}
	}

}

// 获取设备重要告警排名数据
function getImportAlarmTop() {

	$.ajax({
		type : "post",
		url : ctx +"/alarm-center/alarmRecord/getGroupImportantAlarmTop?limit=5&diagCode=BIN_JIANG",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data) {
				var result = JSON.parse(data);
				showImportAlarmTop(result);
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}
// 重要告警排名
function showImportAlarmTop(data) {
	$("#important-alarm-div").empty();
	var top = 1;
	for ( var i in data) {
		if(i=="add"){
			break;
		}
		var projectName = data[i].projectName;
		var rate = data[i].rate;
		var alarmNum = data[i].alarmNum;
		var deviceNormalRate = '<div class="important-alarm-class"><div class="icon-class">' + top + '</div><div class="font">' + projectName + '</div><div class="alarm-value">' + '<div class="fill-parent-div"><div class="fill-div" style="width: ' + rate + '"></div>' + '</div></div><span class="alarm-value-font">' + alarmNum + '</span></div>';
		$("#important-alarm-div").append(deviceNormalRate);
		top = top +1;

		if( i==4){
			break;
		}
	}

}
// 安全事件排名
function getSafeRanking(id, divId) {
	$.ajax({
		type : "post",
		url : ctx + "/report/" + id +"?diagrammaticCode=BIN_JIANG",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var obj = echarts.init(document.getElementById(divId));
			var optionData = $.parseJSON(data);
			for(var i=0;i< optionData.xAxis[0].data.length;i++ ){
				optionData.xAxis[0].data[i] = formatter(optionData.xAxis[0].data[i]);
			}
			obj.setOption(optionData);
		},
		error : function(req, error, errObj) {
		}
	});
}

//安全事件排行：文字过长换行显示
  function formatter(params){
    var newParamsName = "";
    var paramsNameNumber = params.length;
    var provideNumber = 4;
    var rowNumber = Math.ceil(paramsNameNumber / provideNumber);
    if (paramsNameNumber > provideNumber) {
        for (var p = 0; p < rowNumber; p++) {
            var tempStr = "";
            var start = p * provideNumber;
            var end = start + provideNumber;
            if (p == rowNumber - 1) {
                tempStr = params.substring(start, paramsNameNumber);
            } else {
                tempStr = params.substring(start, end) + "\n";
            }
            newParamsName += tempStr;
        }

    } else {
        newParamsName = params;
    }
    return newParamsName
}


// ==============================================zqy=================================
function showTime() {
	var show_day = new Array('星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日');
	var today = new Date();
	var s = today.getSeconds();
	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var day = today.getDate();
	var hour = today.getHours();
	var minutes = today.getMinutes();
	var second = today.getSeconds();

	//month < 10 ? month = '0' + month : month;
	//day < 10 ? day = '0' + day : day;
	hour < 10 ? hour = '0' + hour : hour;
	minutes < 10 ? minutes = '0' + minutes : minutes;
	second < 10 ? second = '0' + second : second;
	var ymd = year + '年' + month + '月' + day +'日';
	var week = show_day[today.getDay() - 1];
	var time = hour + ":" + minutes+":"+second;
	// $("#time").html(time);
	// 今天的日期
	$("#week").html(week);
	$("#ymd").html(ymd);
	$("#hms").html(time);
	setTimeout("showTime();", 1000);
}

// 获取集团所有的项目
function getAllOrganizeCount(){
	$.ajax({
		type: "get",
		url: ctx + "/system/diagrammatic/getAllOrganizeCount",
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null && data.length > 0) {
				$("#organizeCount").text(parseInt(data)-1);
			}
		},
		error: function(req, error, errObj) {
		}
	});
}

function getPopulationNum(totalType){
	$.ajax({
		type: "post",
		url: ctx + "/access-control/personSummaryData/getPopulationNum?diagrammaticCode=BIN_JIANG&totalType="+totalType,
		async: false,
		dataType : "json",
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if(data && data.code==0){
				populationEchart(data.data.populationTotalVOs);
			}
		},
		error: function(req, error, errObj) {
		}
	});
}
function populationEchart(totalVOs){
	var obj = echarts.init(document.getElementById("permanent-div"));
	obj.clear();
	var projectNames = new Array;
	var populations =new Array;
	for ( var i in totalVOs) {
		if(i=="add"){
			break;
		}
		projectNames[projectNames.length]=totalVOs[i].projectName;
		populations[populations.length]=totalVOs[i].populationTotal;
		if(i==4){
			break;
		}
	}
	var level=3;
	var datas = populations;
	var len = datas.length;
	var datastyle = [];
	var normalcolor = new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	    offset: 0,
	    color: 'rgba(80,164,206, 1)'
	}, {
	    offset: 1,
	    color: 'rgba(80,164,206, 1)'
	}]);
	var maxcolor = new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	    offset: 0,
	    color: '#50A4CE'
	}, {
	    offset: 1,
	    color: '#50A4CE'
	}]);
	for(var i = 0;i<datas.length;i++){
		if(i=="add"){
			break;
		}
	    datastyle.push(
	        {
	            value:datas[i],
	            itemStyle:{
	                normal:{
	                    color:normalcolor,
	                    barBorderRadius: [45, 45, 0, 0]
	                }
	            }
	        }
	    )
	}
	var option = {
	    color: ['#50A4CE'],
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '10%',
	        top:'35%',
	        containLabel: true
	    },
	    xAxis :
	        {
	            type : 'category',
	            axisLabel:{
	                textStyle:{
	                    fontSize:16,
	                    color:'#5FAEDA'
	                }
	            },
	            axisLine:{
	                lineStyle:{
	                    color:'#3E495B'
	                }
	            },
	            axisTick:{
	                show:false
	            },
	            splitLine:{
	                show:false
	            },
	            splitArea:{
	                show:false
	            },
	            data : projectNames
	        },
	    yAxis : {
	        min:0,
	        // max:maxData,
	        axisLabel:{
	            textStyle:{
	                fontSize:10,
	                color:'#626F86'
	            }
	        },
	        axisTick:{
	            inside:false
	        },
	        axisLine:{
	            show:false,
	            lineStyle:{
	                color:'#3E495B'
	            }
	        },
	        splitLine:{
	            show:true,
                lineStyle:{
                    color:'#3E495B'
                }
	        },
	        splitArea:{
	            show:false
	        },
	        splitNumber:level
	    },
	    series : [
	        {
	        type: 'pictorialBar',
	        symbol: 'circle',
	        symbolSize: [16.2, 16.2],
	            symbolPosition: 'end',
	            symbolOffset: [0, '-110%'],
	        z: 10,
	        data: datas
	     },
	        {
	            name:'',
	            type:'bar',
	            barWidth: 24,
	            data:datastyle,
	            label: {
	                normal: {
	                    show: false,
	                }
	            }
	        },

	    ],
	    label: {
	        normal: {
	            show: true,
	            offset:[0,-10],
	            color:'#5FAEDA;',
	            fontSize:30,
	            position: 'top',
	            // formatter: '{c}人'
	            formatter: function(params) {
	                var val = params.value + '';
	                var firstNum="";
	                var otherNum="";
	                if(val.length>1){
		                firstNum = val.substring(0, 1);
		                otherNum = val.substring(1);
	                }else{
	                	otherNum = val;
	                }
	                var person ="人";
	                return '{firstNum|' + firstNum + '}' + '{otherNum|' + otherNum + '}' + '{person|' + person + '}';
	            },
	            rich: {
	                firstNum: {
	                    color: "#5FAEDA",
	                    fontSize: 30,
	                    padding: [0, 0, -7, 0]
	                },
	                otherNum: {
	                    color: "#5FAEDA",
	                    fontSize: 24,
	                    padding: [0, 0, 0, 0]
	                },
	                person: {
	                    color: "#5FAEDA",
	                    fontSize: 18,
	                    padding: [0, 0, 0, 0]
	                }
	            }
	        }
	    }
	};
	obj.setOption(option);
}



function fillPiontImg() {
	$.ajax({
		type: "post",
		url: ctx + "/system/diagrammatic/fillPiontImg?diagrammaticCode=BIN_JIANG",
		async: false,
		dataType : "json",
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			$.each(data.data, function(i, item) {
				var pointImg="";
				projectMap[item.projectName]=item.projectCode;
				projectCodeMap[item.projectCode]=item.projectName;
				projectIcons[item.projectName]=item.icons;
				$("#project-span-"+item.projectName).remove();
				$("#project-name-"+item.projectName).remove();
				if(item.icons=="huashu"){
					pointImg='<span id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:74px;height:30px;text-align:center;line-height:30px;left:'+(item.marginLeft-22)+'px;top:'+(item.marginTop-35)+'px;opacity: 0.4;background: #000;border-radius: 4px;font-family: PingFangSC-Regular;font-size: 14px;color: #EEEEEE;letter-spacing: 0;">'+item.projectName+'</span>'
					+'<img class="head-point" id="project-name-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/huashu.svg" style="left:'+(item.marginLeft)+'px;top:'+(item.marginTop)+'px;" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>';
				}else if(item.icons=="huoju"){
                    if(item.isAbnormal == 1){
                    	//pointImg='<span id="project-span-'+item.projectName+'" style="position: absolute;width:74px;height:30px;text-align:center;line-height:30px;left:'+(item.marginLeft-29)+'px;top:'+(item.marginTop-48)+'px;opacity: 0.4;background: #000;border-radius: 4px;font-family: PingFangSC-Regular;font-size: 14px;color: #EEEEEE;letter-spacing: 0;">'+item.projectName+'</span>'
						pointImg='<div id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:187px;height:239px;text-align:left;line-height:22px;left:'+(item.marginLeft-93.5)+'px;top:'+(item.marginTop-254)+'px;background: #000;opacity:0.8;font-family: PingFangSC-Regular;font-size: 16px;color: #EEEEEE;letter-spacing: 0;background-image: url('+ ctx + '/static/img/bjCloud/projectDetail.svg);">'
						+'<div style="width:187px;height:28px;text-align:center;line-height:28px;font-size:12px;margin-top:10px;color: #4DA1FF;font-family: PingFangSC-Medium;font-size: 20px;">'
						+item.projectName+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:15.2px;">'
						+"常住人口："+item.residentPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"流动人口："+item.floatingPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"重点关注人员："+item.focusAttentionPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"空余共享车位："+item.restParkingSpaces+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"今日安全事件："+item.securityEvent+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"安全小区排名：1"+'</div>'
						+'</div>'
                    	+'<img class="green-point green-fluctuation" id="project-name-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/hongsequan.svg" style="left:'+(item.marginLeft-9)+'px;top:'+(item.marginTop-5)+'px;z-index:100;width:40px;height:40px;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>'
				        /*+'<img class="green-point" id="project-names-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/hongsexiaoquan.svg" style="left:'+(item.marginLeft+1)+'px;top:'+(item.marginTop+1)+'px;width:18px;height:18px;z-index:10;opacity:0.6" onclick="groupChartsClickEnventInit(this)"/>'*/;
					}else{
						//pointImg='<span id="project-span-'+item.projectName+'" style="position: absolute;width:74px;height:30px;text-align:center;line-height:30px;left:'+(item.marginLeft-29)+'px;top:'+(item.marginTop-48)+'px;opacity: 0.4;background: #000;border-radius: 4px;font-family: PingFangSC-Regular;font-size: 14px;color: #EEEEEE;letter-spacing: 0;">'+item.projectName+'</span>'
						pointImg='<div id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:187px;height:239px;text-align:left;line-height:22px;left:'+(item.marginLeft-93.5)+'px;top:'+(item.marginTop-254)+'px;background: #000;opacity:0.8;font-family: PingFangSC-Regular;font-size: 16px;color: #EEEEEE;letter-spacing: 0;background-image: url('+ ctx + '/static/img/bjCloud/projectDetail.svg);">'
						+'<div style="width:187px;height:28px;text-align:center;line-height:28px;font-size:12px;margin-top:10px;color: #4DA1FF;font-family: PingFangSC-Medium;font-size: 20px;">'
						+item.projectName+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:15.2px;">'
						+"常住人口："+item.residentPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"流动人口："+item.floatingPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"重点关注人员："+item.focusAttentionPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"空余共享车位："+item.restParkingSpaces+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"今日安全事件："+item.securityEvent+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"安全小区排名：1"+'</div>'
						+'</div>'
						+'<img class="green-point green-fluctuation" id="project-name-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/huashudianshichanyeyuan.svg" style="left:'+(item.marginLeft-9)+'px;top:'+(item.marginTop-5)+'px;z-index:100;width:40px;height:40px;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>'
				        /*+'<img class="green-point" id="project-names-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/lvsexiaoquan.svg" style="left:'+(item.marginLeft+1)+'px;top:'+(item.marginTop+1)+'px;width:18px;height:18px;z-index:10;opacity:0.6" onclick="groupChartsClickEnventInit(this)"/>'*/;
					}
				}else if(item.icons=="wujiang"){
                    if(item.isAbnormal == 1){
                    	//pointImg='<span id="project-span-'+item.projectName+'" style="position: absolute;width:74px;height:30px;text-align:center;line-height:30px;left:'+(item.marginLeft-29)+'px;top:'+(item.marginTop-48)+'px;opacity: 0.4;background: #000;border-radius: 4px;font-family: PingFangSC-Regular;font-size: 14px;color: #EEEEEE;letter-spacing: 0;">'+item.projectName+'</span>'
						pointImg='<div id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:187px;height:239px;text-align:left;line-height:22px;left:'+(item.marginLeft-80)+'px;top:'+(item.marginTop+40)+'px;background: #000;opacity:0.8;font-family: PingFangSC-Regular;font-size: 16px;color: #EEEEEE;letter-spacing: 0;background-image: url('+ ctx + '/static/img/bjCloud/projectDetail.svg);">'
						+'<div style="width:187px;height:28px;text-align:center;line-height:28px;font-size:12px;margin-top:10px;color: #4DA1FF;font-family: PingFangSC-Medium;font-size: 20px;">'
						+item.projectName+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:15.2px;">'
						+"常住人口："+item.residentPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"流动人口："+item.floatingPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"重点关注人员："+item.focusAttentionPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"空余共享车位："+item.restParkingSpaces+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"今日安全事件："+item.securityEvent+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"安全小区排名：1"+'</div>'
						+'</div>'
                    	+'<img class="green-point green-fluctuation" id="project-name-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/hongsequan.svg" style="left:'+(item.marginLeft-9)+'px;top:'+(item.marginTop-5)+'px;z-index:100;width:40px;height:40px;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>'
				        /*+'<img class="green-point" id="project-names-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/hongsexiaoquan.svg" style="left:'+(item.marginLeft+1)+'px;top:'+(item.marginTop+1)+'px;width:18px;height:18px;z-index:10;opacity:0.6" onclick="groupChartsClickEnventInit(this)"/>'*/;
					}else{
						//pointImg='<span id="project-span-'+item.projectName+'" style="position: absolute;width:74px;height:30px;text-align:center;line-height:30px;left:'+(item.marginLeft-29)+'px;top:'+(item.marginTop-48)+'px;opacity: 0.4;background: #000;border-radius: 4px;font-family: PingFangSC-Regular;font-size: 14px;color: #EEEEEE;letter-spacing: 0;">'+item.projectName+'</span>'
						pointImg='<div id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:187px;height:239px;text-align:left;line-height:22px;left:'+(item.marginLeft-80)+'px;top:'+(item.marginTop+40)+'px;background: #000;opacity:0.8;font-family: PingFangSC-Regular;font-size: 16px;color: #EEEEEE;letter-spacing: 0;background-image: url('+ ctx + '/static/img/bjCloud/projectDetail.svg);">'
						+'<div style="width:187px;height:28px;text-align:center;line-height:28px;font-size:12px;margin-top:10px;color: #4DA1FF;font-family: PingFangSC-Medium;font-size: 20px;">'
						+item.projectName+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:15.2px;">'
						+"常住人口："+item.residentPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"流动人口："+item.floatingPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"重点关注人员："+item.focusAttentionPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"空余共享车位："+item.restParkingSpaces+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"今日安全事件："+item.securityEvent+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"安全小区排名：1"+'</div>'
						+'</div>'
						+'<img class="green-point green-fluctuation" id="project-name-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/huashudianshichanyeyuan.svg" style="left:'+(item.marginLeft-9)+'px;top:'+(item.marginTop-5)+'px;z-index:100;width:40px;height:40px;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>'
				        /*+'<img class="green-point" id="project-names-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/lvsexiaoquan.svg" style="left:'+(item.marginLeft+1)+'px;top:'+(item.marginTop+1)+'px;width:18px;height:18px;z-index:10;opacity:0.6" onclick="groupChartsClickEnventInit(this)"/>'*/;
					}
				}else  if(item.icons=="xingxing"){
					//pointImg='<span id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:90px;height:30px;text-align:center;line-height:30px;left:'+(item.marginLeft-40)+'px;top:'+(item.marginTop-35)+'px;opacity: 0.4;background: #000;border-radius: 4px;font-family: PingFangSC-Regular;font-size: 14px;color: #EEEEEE;letter-spacing: 0;">'+item.projectName+'</span>'
					pointImg='<div id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:187px;height:239px;text-align:left;line-height:22px;left:'+(item.marginLeft-93.5)+'px;top:'+(item.marginTop+20)+'px;background: #000;opacity:0.8;font-family: PingFangSC-Regular;font-size: 16px;color: #EEEEEE;letter-spacing: 0;background-image: url('+ ctx + '/static/img/bjCloud/projectDetail.svg);">'
					+'<div style="width:187px;height:28px;text-align:center;line-height:28px;font-size:12px;margin-top:10px;color: #4DA1FF;font-family: PingFangSC-Medium;font-size: 20px;">'
					+item.projectName+'</div>'
					+'<div style="width:187px;height:22px;margin-left:16px;margin-top:15.2px;">'
					+"常住人口："+item.residentPopulation+'</div>'
					+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
					+"流动人口："+item.floatingPopulation+'</div>'
					+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
					+"重点关注人员："+item.focusAttentionPopulation+'</div>'
					+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
					+"空余共享车位："+item.restParkingSpaces+'</div>'
					+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
					+"今日安全事件："+item.securityEvent+'</div>'
					+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
					+"安全小区排名："+item.securityCommunity+'</div>'
					+'</div>'
					+'<img class="red-point" id="project-name-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/xingxing.png" style="left:'+(item.marginLeft-2)+'px;top:'+(item.marginTop-2)+'px;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>';
				}else{
					if(item.isAbnormal == 1){
						//pointImg='<span id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:74px;height:30px;text-align:center;line-height:30px;left:'+(item.marginLeft-32)+'px;top:'+(item.marginTop-48)+'px;opacity: 0.4;background: #000;border-radius: 4px;font-family: PingFangSC-Regular;font-size: 14px;color: #EEEEEE;letter-spacing: 0;">'+item.projectName+'</span>'
						pointImg='<div id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:187px;height:239px;text-align:left;line-height:22px;left:'+(item.marginLeft-93.5)+'px;top:'+(item.marginTop-254)+'px;background: #000;opacity:0.8;font-family: PingFangSC-Regular;font-size: 16px;color: #EEEEEE;letter-spacing: 0;background-image: url('+ ctx + '/static/img/bjCloud/projectDetail.svg);">'
						+'<div style="width:187px;height:28px;text-align:center;line-height:28px;font-size:12px;margin-top:10px;color: #4DA1FF;font-family: PingFangSC-Medium;font-size: 20px;">'
						+item.projectName+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:15.2px;">'
						+"常住人口："+item.residentPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"流动人口："+item.floatingPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"重点关注人员："+item.focusAttentionPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"空余共享车位："+item.restParkingSpaces+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"今日安全事件："+item.securityEvent+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"安全小区排名："+item.securityCommunity+'</div>'
						+'</div>'
						+'<img class="red-point green-fluctuation" id="project-name-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/hongsequan.svg" style="left:'+(item.marginLeft-9)+'px;top:'+(item.marginTop-5)+'px;width:29.5px;height:29.5px;z-index:100;width:40px;height:40px;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>'
						/*+'<img class="green-point" id="project-names-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/hongsexiaoquan.svg" style="left:'+(item.marginLeft+1)+'px;top:'+(item.marginTop+1)+'px;width:18px;height:18px;z-index:10;opacity:0.6;z-index:10;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>'*/;
					}else{
					//pointImg='<span id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:74px;height:30px;text-align:center;line-height:30px;left:'+(item.marginLeft-32)+'px;top:'+(item.marginTop-40)+'px;opacity: 0.4;background: #000;border-radius: 4px;font-family: PingFangSC-Regular;font-size: 14px;color: #EEEEEE;letter-spacing: 0;">'+item.projectName+'</span>'
						pointImg='<div id="project-span-'+item.projectName+'" style="display:none;position: absolute;width:187px;height:239px;text-align:left;line-height:22px;left:'+(item.marginLeft-93.5)+'px;top:'+(item.marginTop-254)+'px;background: #000;opacity:0.8;font-family: PingFangSC-Regular;font-size: 16px;color: #EEEEEE;letter-spacing: 0;background-image: url('+ ctx + '/static/img/bjCloud/projectDetail.svg);">'
						+'<div style="width:187px;height:28px;text-align:center;line-height:28px;font-size:12px;margin-top:10px;color: #4DA1FF;font-family: PingFangSC-Medium;font-size: 20px;">'
						+item.projectName+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:15.2px;">'
						+"常住人口："+item.residentPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"流动人口："+item.floatingPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"重点关注人员："+item.focusAttentionPopulation+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"空余共享车位："+item.restParkingSpaces+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"今日安全事件："+item.securityEvent+'</div>'
						+'<div style="width:187px;height:22px;margin-left:16px;margin-top:7.8px;">'
						+"安全小区排名："+item.securityCommunity+'</div>'
						+'</div>'
						+'<img class="red-point" id="project-name-'+item.projectName+'" src="'+ ctx + '/static/img/bjCloud/xiaoqu.png" style="left:'+(item.marginLeft-2)+'px;top:'+(item.marginTop-2)+'px;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>';
					}
				}
				$('body').append(pointImg);
			});
		},
		error: function(req, error, errObj) {
		}
	});
}


function initProjectIcon(name){
	$.ajax({
		type: "post",
		url: ctx + "/system/diagrammatic/getProjectData?keyword="+name,
		async: false,
		dataType : "json",
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if(data){
				for (var i=0; i<data.length; i++) {
					$("#project-name-"+data[i].projectName).remove();
					/* $("#project-names-"+data[i].projectName).remove(); */
					if(data[i].projectCode != "HUOJUXIAOQU"){
					if(data[i].isAbnormal == 1){
						var img="";
						img = '<img class="red-point green-fluctuation" id="project-name-'+data[i].projectName+'" src="'+ ctx + '/static/img/bjCloud/hongsequan.svg" style="left:'+(data[i].marginLeft-7)+'px;top:'+(data[i].marginTop-7)+'px;width:29.5px;height:29.5px;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>';
						/*
						 * +'<img class="green-point"
						 * id="project-names-'+data[i].projectName+'" src="'+
						 * ctx + '/static/img/bjCloud/hongsexiaoquan.svg"
						 * style="left:'+(data[i].marginLeft+1)+'px;top:'+(data[i].marginTop+1)+'px;width:13.4px;height:13.5px;z-index:10;opacity:0.6"
						 * onclick="groupChartsClickEnventInit(this)"
						 * onmouseout="hideSpan(this)"
						 * onmouseover="showSpan(this)"/>'
						 */
						$("#project-span-"+data[i].projectName).after(img);
					}else{
						var img="";
						img = '<img class="red-point" id="project-name-'+data[i].projectName+'" src="'+ ctx + '/static/img/bjCloud/xiaoqu.png" style="left:'+(data[i].marginLeft)+'px;top:'+(data[i].marginTop)+'px;" onclick="groupChartsClickEnventInit(this)" onmouseout="hideSpan(this)" onmouseover="showSpan(this)"/>';
						$("#project-span-"+data[i].projectName).after(img);
					}
					}else{
						if(data[i].isAbnormal == 1){
							var img="";
							img = '<img class="green-point green-fluctuation" id="project-name-'+data[i].projectName+'" src="'+ ctx + '/static/img/bjCloud/hongsequan.svg" style="left:'+(data[i].marginLeft-15)+'px;top:'+(data[i].marginTop-15)+'px;z-index:100;width:40px;height:40px" onclick="groupChartsClickEnventInit(this)"/>';
					        /*
							 * +'<img class="green-point"
							 * id="project-names-'+data[i].projectName+'"
							 * src="'+ ctx +
							 * '/static/img/bjCloud/hongsexiaoquan.svg"
							 * style="left:'+(data[i].marginLeft+1)+'px;top:'+(data[i].marginTop+1)+'px;width:13.4px;height:13.5px;z-index:10;opacity:0.6"
							 * onclick="groupChartsClickEnventInit(this)"/>'
							 */
							$("#project-span-"+data[i].projectName).after(img);
						}else{
							var img="";
							img = '<img class="green-point green-fluctuation" id="project-name-'+data[i].projectName+'" src="'+ ctx + '/static/img/bjCloud/huashudianshichanyeyuan.svg" style="left:'+(data[i].marginLeft-7)+'px;top:'+(data[i].marginTop-7)+'px;z-index:100;width:40px;height:40px" onclick="groupChartsClickEnventInit(this)"/>';
					        /*
							 * +'<img class="green-point"
							 * id="project-names-'+data[i].projectName+'"
							 * src="'+ ctx +
							 * '/static/img/bjCloud/lvsexiaoquan.svg"
							 * style="left:'+(data[i].marginLeft+1)+'px;top:'+(data[i].marginTop+1)+'px;width:13.4px;height:13.5px;z-index:10;opacity:0.6"
							 * onclick="groupChartsClickEnventInit(this)"/>'
							 */
							$("#project-span-"+data[i].projectName).after(img);
						}
					}
				}
			}
		},
		error: function(req, error, errObj) {
		}
	});
}

// 根据输入的项目出现模糊匹配的项目
function getProjectData(isShow){
	var project = $("#projectName").val().trim().replace(/\s/g,"");
	if(project == ""){
		$('#codes').val("");
		$("#showNoProject").text("");
		// 把所有的大球变小，如果有报警则不变
		searchHandle();
	}
	var datas ="";
	if(project.length>=1){
	  $('#projectName').AutoComplete({
   'data': ctx+"/system/diagrammatic/getProjectData",
   'width': 'auto',
   'ajaxType': 'post',
   'ajaxDataType': 'json',
   'ajaxContentType': 'application/json;charset=utf-8',
   'emphasis': false,
   'listStyle': 'custom',
   'matchHandler': function(keyword, data) {
   		return true;
   },
   'createItemHandler': function(index, data){
   	$("#showNoProject").text("");
       if(isShow == 1){
       	return "<span style='color:#FFFFFF;font-size: 18px;display:none;cursor: pointer;'>"+data.projectName+"</span>";
   	}else{
   	    return "<span style='color:#FFFFFF;font-size: 18px;cursor: pointer;'>"+data.projectName+"</span>";
   	}
   },
   'afterSelectedHandler': function(data) {
   	$('#codes').val(data.projectCode);
   	$('#projectName').val(data.projectName);
   }
   }).AutoComplete('show');
	  if(datas == ""){
		 /*
			 * $("#showNoProject").text("● 该项目不存在"); // 把所有的大球变小，如果有报警则报警变小
			 * searchHandle(1);
			 */
		  return false;
	  }
}
}



// 处理搜索的请求 1为变大 2为变小
function searchHandle(size){
	var projectName = $("#projectName").val().trim().replace(/\s/g,"");
	if(projectName != ""){
		var isHave = getProjectData(1);
		if(!isHave && isHave != undefined && projectIcons[projectName]!="huoju" && projectIcons[projectName]!="huashu" && projectIcons[projectName]!="xingxing"&&projectIcons[projectName]!="wujiang"){
			$("#showNoProject").text("● 该项目不存在");
			size =1;
		}
	}
	var icons=projectIcons[projectName];
	if(typeof(icons) == 'undefined'||icons == 'undefined'){
		$("#project-span-"+projectCodeMap['HUOJUXIAOQU']).hide();
		var greenClassElements = document.getElementsByClassName('green-point');
		$("span").removeClass("green-title");
		for (var i=0; i<greenClassElements.length; i++) {
			if(projectIcons[greenClassElements[i].id.split("project-name-")[1]] =='xingxing'){
				$("#project-span-"+greenClassElements[i].id.split("project-name-")[1]).hide();
				greenClassElements[i].src=ctx + "/static/img/bjCloud/xingxing.png";
// greenClassElements[i].style.top=(greenClassElements[i].style.top.split("px")[0]+15)+"px";
// greenClassElements[i].style.left=(greenClassElements[i].style.left.split("px")[0]+15)+"px";
// var projectSpan
// =document.getElementById("project-span-"+greenClassElements[i].id.split("project-name-")[1]);
// projectSpan.style.top=(parseInt(projectSpan.style.top.split("px")[0])+15)+"px";
// projectSpan.style.left=(parseInt(projectSpan.style.left.split("px")[0])+7)+"px";
				greenClassElements[i].className ="red-point";
			}else if(projectIcons[greenClassElements[i].id.split("project-name-")[1]] ==null){
				$("#project-span-"+greenClassElements[i].id.split("project-name-")[1]).hide();
				greenClassElements[i].src=ctx + "/static/img/bjCloud/xiaoqu.png";
// greenClassElements[i].style.top=(greenClassElements[i].style.top.split("px")[0]+15)+"px";
// greenClassElements[i].style.left=(greenClassElements[i].style.left.split("px")[0]+15)+"px";
// var projectSpan
// =document.getElementById("project-span-"+greenClassElements[i].id.split("project-name-")[1]);
// projectSpan.style.top=(parseInt(projectSpan.style.top.split("px")[0])+15)+"px";
// projectSpan.style.left=(parseInt(projectSpan.style.left.split("px")[0])+7)+"px";
				greenClassElements[i].className ="red-point";
			}
		}
	}else if( (icons == null && icons != "huashu")||icons == "huoju"||icons == "xingxing"||icons == "wujiang"){
		$("#showNoProject").text("");
		var project=document.getElementById("project-name-"+projectName);
		/* project.src=ctx + "/static/img/bjCloud/huashudianshichanyeyuan.svg"; */
		var greenClassElements = document.getElementsByClassName('green-point');
		for (var i=0; i<greenClassElements.length; i++) {
			if(projectIcons[greenClassElements[i].id.split("project-name-")[1]] =='xingxing'){
				$("#project-span-"+greenClassElements[i].id.split("project-name-")[1]).hide();
				greenClassElements[i].src=ctx + "/static/img/bjCloud/xingxing.png";
				greenClassElements[i].className ="red-point";
			}else if(projectIcons[greenClassElements[i].id.split("project-name-")[1]] ==null){
				greenClassElements[i].src=ctx + "/static/img/bjCloud/xiaoqu.png";
				$("#project-span-"+greenClassElements[i].id.split("project-name-")[1]).hide();
				greenClassElements[i].className ="red-point";
			}
		}

// project.style.top=(project.style.top.split("px")[0]-15)+"px";
// project.style.left=(project.style.left.split("px")[0]-15)+"px";
// var projectSpan=document.getElementById("project-span-"+projectName);
// projectSpan.style.top=(projectSpan.style.top.split("px")[0]-15)+"px";
// projectSpan.style.left=(projectSpan.style.left.split("px")[0]-7)+"px";
		$("#project-span-"+projectName).show();
		var projectSpan=document.getElementById("project-span-"+projectName);
		projectSpan.className="green-title";
		/* var projects=document.getElementById("project-names-"+projectName); */
		if(!$("#project-name-"+projectName).is('.green-fluctuation')){
		/* if(projects==null){ */
	    project.src=ctx + "/static/img/bjCloud/huashudianshichanyeyuan.svg";
		project.className="green-point green-fluctuation2";
		}
	}

}

function initMap(){
	$.ajax({
		type: "post",
		url: ctx + "/system/diagrammatic/getProjectMapInfoVO?diagrammaticCode=BIN_JIANG",
		async: false,
		dataType : "json",
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if(data && data.code==0){
				$.each(data.data, function(i, item) {
					if(item.icons == 'huashu') {
						keyName = item.projectName;
					}
					if(item.icons == 'huashu' || item.icons == 'huoju') {
						cityData[cityData.length] = {name:item.projectName,value:100};
					} else {
						cityData[cityData.length] = {name:item.projectName,value:50};
					}
					projectMap[item.projectName]=item.projectCode;
					HZ_DATA_GEO_CoordMap[item.projectName] = new Array(item.longitude,item.latitude);
				});
				showMap();
			}
		},
		error: function(req, error, errObj) {
		}
	});
}
	function showMap(){
		$("#map").empty();
		var Maps = new HMap('map', {
		    controls: {
		      loading: true,
		      zoomSlider: false,
		      fullScreen: false
		    },
		    view: {
		      center: [120.172664,30.169957],
		      projection: 'EPSG:4326',
		      zoom: 13, // resolution
		    },
		    baseLayers: [
		      {
		        layerName: 'vector',
		        isDefault: true,
		        layerType: 'TileXYZ',
		        projection: 'EPSG:3857',
		        tileGrid: {
		          tileSize: 256,
		          extent: [-2.0037507067161843E7, -3.0240971958386254E7, 2.0037507067161843E7, 3.0240971958386205E7],
		          origin: [-2.0037508342787E7, 2.0037508342787E7],
		          resolutions: [
		            156543.03392800014,
		            78271.51696399994,
		            39135.75848200009,
		            19567.87924099992,
		            9783.93962049996,
		            4891.96981024998,
		            2445.98490512499,
		            1222.992452562495,
		            611.4962262813797,
		            305.74811314055756,
		            152.87405657041106,
		            76.43702828507324,
		            38.21851414253662,
		            19.10925707126831,
		            9.554628535634155,
		            4.77731426794937,
		            2.388657133974685
		          ]
		        },
		        layerUrl: 'http://cache1.arcgisonline.cn/arcgis/rest/services/ChinaOnlineStreetPurplishBlue/MapServer/tile/{z}/{y}/{x}'
		      }
		    ]
		  });
		var echartslayer = new ol3Echarts(getOptions());
		echartslayer.appendTo(Maps.getMap());
	}
	  function getOptions () {
		HSData=[];
		for(i =0;i<cityData.length;i++) {
			HSData[HSData.length] = new Array({name:keyName},cityData[i]);
		}
	    var convertData_gz = function (data) {
	      var res = [];
	      for (var i = 0; i < data.length; i++) {
	        var dataItem = data[i];
	        var fromCoord = HZ_DATA_GEO_CoordMap[dataItem[0].name];
	        var toCoord = HZ_DATA_GEO_CoordMap[dataItem[1].name];
	        if (fromCoord && toCoord) {
	          res.push({
	            fromName: dataItem[0].name,
	            fromValue : dataItem[1].value,
	            toName: dataItem[1].name,
	            coords: [toCoord, fromCoord]
	          });
	        }
	      }
	      return res;
	    };
	    var color = ['#00FCD9'];
	    var series = [];
	    [[keyName, HSData]].forEach(function (item, i) {
	      series.push(
	        {
	          name: item[0],
	          type: 'lines',
	          zlevel: 1,
	          effect: {
	            show : true,
	            period : 6,
	            trailLength : 0.7,
	            color : '#fff',
	            symbolSize : 3,
	            shadowBlur : 4.4
	          },
	          lineStyle: {
	            normal: {
	              color: color[i],
	              width: 0,
	              curveness: 0.2
	            }
	          },
	          data: convertData_gz(item[1])
	        },
	        {
	          name: item[0],
	          type: 'lines',
	          zlevel: 2,
	          // symbol: ['none', 'arrow'],
	          symbol: ['none'],
	          symbolSize: 10,
	          effect: {
	            show: true,
	            period: 6,
	            trailLength: 0,
	            // symbol: planePath_gz,
	            symbolSize: 6
	          },
	          lineStyle: {
	            normal: {
	              color: color[i],
	              width: 1,
	              opacity: 0.5,
	              curveness: 0.2
	            }
	          },
	          data: convertData_gz(item[1])
	        },
	        {
	          name: item[0],
	          type: 'effectScatter',
	          zlevel: 2,
	          rippleEffect: {
	            brushType: 'stroke'
	          },
	          label: {
	            normal: {
	              show: (i == 0 ? true : false),
	              position: 'right',
	              formatter: ''
	            }
	          },
	          symbolSize: function (val) {
	            return val[2] / 10;
	          },
	          itemStyle: {
	            normal: {
	              color: color[i]
	            }
	          },
	          data: item[1].map(function (dataItem) {
	            return {
	              name: dataItem[1].name,
	              value: HZ_DATA_GEO_CoordMap[dataItem[1].name].concat([dataItem[1].value])
	            };
	          })
	        });
	    });
	    return {
	      tooltip: {
	        trigger: 'item',
	          formatter: function (params) {
	          if (params.data.fromName) {
	            // return params.data.fromName + " > " + params.data.toName + "
				// <br/>流量数 : " + params.data.fromValue;
	            return "";
	          }else{
	            // return params.name + "<br/>流向广州人数：" + params.value[2];
	            return params.name;
	          }
	        }
	      },
	      /*
			 * legend: { orient: 'vertical', top:'5%', left: 'right',
			 * data:['增城区'], textStyle: { color: '#fff' }, selectedMode:
			 * 'mutipla', bottom:'50%' },
			 */
	      visualMap: {
	          min: 0,
	          max: 100,
	          calculable: true,
	          inRange: {
	          color: ['#00FCD9']
	        },
	        textStyle: {
	          color: '#fff'
	        },
	        bottom:"-30%"
	      },
	      series : series
	    };
	  }



  function showSpan(obj){
		$("#project-span-"+obj.id.split("project-name-")[1]).show();
	}
  function hideSpan(obj){
		$("#project-span-"+obj.id.split("project-name-")[1]).hide();
	}


function groupChartsClickEnventInit(obj){
	var projectCode=projectMap[obj.id.split("project-name-")[1]];
		$.ajax({
			type: "get",
			url: ctx + "/projectPage/toProjectPage?projectCode="+projectCode,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if(data && data.code == 0) {
					var projectId = data.data.projectId;
					//disconnect();
					window.open(ctx + "/main?projectCode="+projectCode+"&projectId="+projectId);
				} else {
					console.log("设置登录信息发生错误!");
				}
			},
			error: function(req, error, errObj) {
				console.log("设置登录信息发生错误!");
			}
		});
	}

	function getPopulationAndHouseTotal(){
		$.ajax({
			type: "post",
			url: ctx + "/access-control/personSummaryData/getPopulationAndHouseTotal?diagrammaticCode=BIN_JIANG",
			async: false,
			dataType : "json",
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if(data && data.code==0){
					if(parseInt(data.data.residentPopulation)>10000){
						$("#resident-population").text(Math.round(data.data.residentPopulation*10/10000) / 10);
						$("#resident-population-unit").show();
					}else{
						$("#resident-population").text(data.data.residentPopulation);
						$("#resident-population-unit").hide();
					}
					if(parseInt(data.data.floatingPopulation)>10000){
						$("#floating-population").text(Math.round(data.data.floatingPopulation*10/10000) / 10);
						$("#floating-population-unit").show();
					}else{
						$("#floating-population").text(data.data.floatingPopulation);
						$("#floating-population-unit").hide();
					}
					if(parseInt(data.data.houseRegistration)>10000){
						$("#house-registration").text(Math.round(data.data.houseRegistration*10/10000) / 10);
						$("#house-registration-unit").show();
					}else{
						$("#house-registration").text(data.data.houseRegistration);
						$("#house-registration-unit").hide();
					}
					if(typeof ($('.counter').val()) !="undefined"){
						$('.counter').countUp({
							delay: 10,
						    time: 2000
						});
					}
				}
			},
			error: function(req, error, errObj) {
			}
		});
	}


	function getPopulationTable(){
		if(permanentFloating == 'permanent' ){
			tabClick(permanentObj);
			permanentFloating='floating';
		}else{
			tabClick(floatingObj);
			permanentFloating='permanent';
		}
	}
	// 切换tab
	function switchTab(){
		if(tabFlag == 'tabA' ){
			tabClick(tabObjA);
			tabFlag='tabB';
		}else{
			tabClick(tabObjB);
			tabFlag='tabA';
		}
	}
	// 解决方案是重新加载地图，
	// 根据输入的项目出现模糊匹配的项目
// function getProjectData(isShow){
// var project = $("#projectName").val().trim().replace(/\s/g,"");
// if(project == ""){
// $('#codes').val("");
// $("#showNoProject").text("");
// // 把所有的大球变小，如果有报警则不变
// searchHandle();
// }
// var datas ="";
// if(project.length>=1){
// $('#projectName').AutoComplete({
// 'data': ctx+"/system/diagrammatic/getProjectData",
// 'width': 'auto',
// 'ajaxType': 'post',
// 'ajaxDataType': 'json',
// 'ajaxContentType': 'application/json;charset=utf-8',
// 'emphasis': false,
// 'listStyle': 'custom',
// 'matchHandler': function(keyword, data) {
// return true;
// },
// 'createItemHandler': function(index, data){
// $("#showNoProject").text("");
// if(isShow == 1){
// return "<span style='color:#FFFFFF;font-size: 18px;display:none;cursor:
// pointer;'>"+data.projectName+"</span>";
// }else{
// return "<span style='color:#FFFFFF;font-size: 18px;cursor:
// pointer;'>"+data.projectName+"</span>";
// }
// },
// 'afterSelectedHandler': function(data) {
// $('#projectName').val(data.projectName);
// }
// }).AutoComplete('show');
// if(datas == ""){
// /*
// * $("#showNoProject").text("● 该项目不存在"); // 把所有的大球变小，如果有报警则报警变小
// * searchHandle(1);
// */
// return false;
// }
// }
// }



// //处理搜索的请求 1为变大 2为变小
// function searchHandle(size){
// var projectName = $("#projectName").val().trim().replace(/\s/g,"");
// if(projectName != "" && size==1){
// $.each(cityData, function(i, item) {
// if(item.name == projectName) {
// cityData[i] = {name:projectName,value:150};
// }
// });
// //更改HSData的数据，改变对应小区的显示点的变大
// }else{
// //更改HSData的数据，改变对应小区的显示点的变小
// $.each(cityData, function(i, item) {
// if(item.name != '华数产业园' && item.name != '火炬小区') {
// cityData[i] = {name:item.name,value:50};
// }else if(item.name == '华数产业园' || item.name == '火炬小区'){
// cityData[i] = {name:item.name,value:100};
// }
// });
// }
// showMap();
// }
// =============================================zqy===============================


// 房屋登记排名
function getStreetHouseRank() {
	$.ajax({
		type : "post",
		url : ctx + "/access-control/personSummaryData/getStreetHouseNum?diagrammaticCode=BIN_JIANG",
		async : false,
		contentType : "application/json;charset=utf-8",
		dataType : "json",
		success : function(data) {
			if (data) {
				$.each(data.items, function(i, item) {
					// 浦沿街道
					if (item.streetCode.trim() == 'PUYAN') {
						var xinxinData =[];
						var a = {};
						a.value = item.registerNum - item.rentNum;
						a.name = "";
						var b = {};
						b.value = item.rentNum;
						b.name = "";

						xinxinData.push(b);
						xinxinData.push(a);
						getYanfuHousePieData(xinxinData);
						$('#yanfu-register').html(item.registerNum);
						$('#yanfu-rent').html(item.rentNum);
					} else if (item.streetCode.trim() == 'CHANGHE') {
						var yanfuData =[];
						var a = {};
						a.value =item.registerNum - item.rentNum;
						a.name = "";
						var b = {};
						b.value =  item.rentNum;
						b.name = "";
						yanfuData.push(b);
						yanfuData.push(a);
						getChangheHousePieData(yanfuData);
						// 长河街道
						$('#changhe-register').html(item.registerNum);
						$('#changhe-rent').html(item.rentNum);
					} else {
						var xixinData =[];
						var a = {};
						a.value =item.registerNum - item.rentNum;
						a.name = "";
						var b = {};
						b.value =  item.rentNum;
						b.name = "";
						xixinData.push(b);
						xixinData.push(a);
						// 西兴街道
						getXixinHousePieData(xixinData);
						$('#xixin-register').html(item.registerNum);
						$('#xixin-rent').html(item.rentNum);
					}
				})
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

function Queue(size) {
	var list = [];

	// 向队列中添加数据
	this.push = function(data) {
		if (data == null) {
			return false;
		}
		// 如果传递了size参数就设置了队列的大小
		if (size != null && !isNaN(size)) {
			if (list.length == size) {
				this.pop();
			}
		}
		list.unshift(data);
		return true;
	}

	// 从队列中取出数据
	this.pop = function() {
		return list.pop();
	}

	// 返回队列的大小
	this.size = function() {
		return list.length;
	}

	// 返回队列的内容
	this.quere = function() {
		return list;
	}
}

// ==================电梯、消防视频弹窗开始=============================
// 电梯告警视频弹窗
function toSubscribeElevatorAlarmInfo() {
	if (isConnectedGateWay) {
		stompClient.subscribe('/topic/elevatorAlarmVideoPopover/' + huojuProjectCode, function(result) {
			var json = JSON.parse(result.body);
			console.log(json);
			// 摄像机id为空，不进行推送
			if (json.cameraDeviceId != undefined) {
				// 判断数组是否有值
				if (elevatorAlarmDevice.length > 0) {
					// 如果为空，代表告警已经全部恢复
					if (json.alarmType == 2) {
						if (json.alarmCode == "37") {
							for (var i = 0; i < elevatorAlarmDevice.length; i++) {
								if (elevatorAlarmDevice[i].deviceId == json.deviceId) {
									elevatorAlarmDevice[i].alarmName = json.alarmName;
									elevatorAlarmDevice[i].floorDisplaying = json.floorDisplaying;
									elevatorAlarmDevice[i].runningState = json.runningState;
									elevatorAlarmDevice[i].cameraStatus = json.cameraStatus;
									// 判断此是否正在查看，如果正在查看，则不删除，否则删除
									document.getElementById('show-elevator-alarm-video-iframe').contentWindow.deleteElevatorInfo(json.deviceId, json.deviceName, json.alarmName, i, json.floorDisplaying, json.runningState);
								}
							}
						} else {
							for (var i = 0; i < elevatorAlarmDevice.length; i++) {
								if (elevatorAlarmDevice[i].deviceId == json.deviceId) {
									elevatorAlarmDevice[i].floorDisplaying = json.floorDisplaying;
									elevatorAlarmDevice[i].runningState = json.runningState;
									elevatorAlarmDevice[i].alarmName = json.alarmName;
									elevatorAlarmDevice[i].cameraStatus = json.cameraStatus;
									if (elevatorVideoIsOpen == 1) {
										document.getElementById('show-elevator-alarm-video-iframe').contentWindow.updateElevatorInfo();
									}
								}
							}
						}
					} else {
						if (json.alarmCode == "37") {
							for (var i = 0; i < elevatorAlarmDevice.length; i++) {
								if (elevatorAlarmDevice[i].deviceId == json.deviceId) {
									// 删除原有数据
									elevatorAlarmDevice.splice(i, 1);
								}
							}
							// 在数组最前面添加数据
							elevatorAlarmDevice.unshift({
								"deviceId" : json.deviceId,
								"deviceName" : json.deviceName,
								"alarmName" : json.alarmName,
								"runningState" : json.runningState,
								"floorDisplaying" : json.floorDisplaying,
								"cameraDeviceId" : json.cameraDeviceId,
								"cameraStatus" : json.cameraStatus
							});
							// 判断窗口是否被打开
							if (elevatorVideoIsOpen == 0) {
								showElevatorAlarmVideo(elevatorAlarmDevice);
								elevatorVideoIsOpen = 1;
							} else {
								isNewElevatorAlarm = 1;
								// 更新数据
								document.getElementById('show-elevator-alarm-video-iframe').contentWindow.updateElevatorInfo();
							}
						} else {
							for (var i = 0; i < elevatorAlarmDevice.length; i++) {
								if (elevatorAlarmDevice[i].deviceId == json.deviceId) {
									elevatorAlarmDevice[i].floorDisplaying = json.floorDisplaying;
									elevatorAlarmDevice[i].runningState = json.runningState;
									elevatorAlarmDevice[i].alarmName = json.alarmName;
									elevatorAlarmDevice[i].cameraStatus = json.cameraStatus;
									if (elevatorVideoIsOpen == 1) {
										document.getElementById('show-elevator-alarm-video-iframe').contentWindow.updateElevatorInfo();
									}
								}
							}
						}
					}
				} else {
					if (json.alarmType == 1 && json.alarmCode == "37") {
						getelevatorAlarmData();
					}
				}
			}
		});

		stompClient.subscribe('/topic/elevatorAlarmVideoPopoverRunningData/' + huojuProjectCode, function(result) {
			var elevatorJson = JSON.parse(result.body);
			if (elevatorAlarmDevice.length > 0) {
				for (var i = 0; i < elevatorAlarmDevice.length; i++) {
					if (elevatorAlarmDevice[i].deviceId == elevatorJson.deviceId) {
						elevatorAlarmDevice[i].floorDisplaying = elevatorJson.floorDisplaying;
						elevatorAlarmDevice[i].runningState = elevatorJson.runningState;
						if (elevatorVideoIsOpen == 1) {
							document.getElementById('show-elevator-alarm-video-iframe').contentWindow.updateElevatorInfo();
						}
					}
				}
			}
		});

		/**
		 * 消防火警报警视频弹窗
		 */
		stompClient.subscribe('/topic/ffmAlarmVideoData/' + huojuProjectCode, function(result) {
			var json = JSON.parse(result.body);
			var busiType;
			console.log(json);
			if (json.firesVideoMonitorDTO != null) {
				firesVideoDeviceMap = new HashMap();
				busiType = json.firesVideoMonitorDTO.busiType;
				getAllFireFightingCameras();
				// 清除原来的，防止有影响
				tempCameraId = null;
			    tempCameraId = json.firesVideoMonitorDTO.cameraDeviceId;
				var dto = {
					"firesDeviceId" : json.firesVideoMonitorDTO.firesDeviceId,
					"cameraName" : json.firesVideoMonitorDTO.cameraName,
					"fireAlarm" : json.firesVideoMonitorDTO.fireAlarm,
					"cameraDeviceId" : json.firesVideoMonitorDTO.cameraDeviceId,
					"cameraStatus" : json.firesVideoMonitorDTO.cameraStatus,
					"recordId" : json.firesVideoMonitorDTO.recordId,
					"eventConfirm" : json.firesVideoMonitorDTO.eventConfirm,
					"confirmType" : json.firesVideoMonitorDTO.confirmType,
					"mark" : json.firesVideoMonitorDTO.mark,
					"msgId" : json.firesVideoMonitorDTO.msgId
				};
				if(firesVideoDeviceMap.get(tempCameraId) != null || typeof (firesVideoDeviceMap.get(tempCameraId)) != "undefined"){
					firesVideoDeviceMap.remove(tempCameraId);
				}
				firesVideoDeviceMap.put(json.firesVideoMonitorDTO.cameraDeviceId, dto);
                firesVideoDeviceList = new Array();
                doorBlockDeviceList = new Array();
				var values = firesVideoDeviceMap.values();
				for ( var i in values) {
					if (values[i].fireAlarm == 1) {
						if(busiType == 'FIRES'){
							if (values[i].cameraDeviceId == tempCameraId) {
								firesVideoDeviceList.unshift({
									"itemText" : values[i].cameraName,
									"itemData" : values[i].cameraDeviceId
								});
							} else {
								firesVideoDeviceList[firesVideoDeviceList.length] = {
									"itemText" : values[i].cameraName,
									"itemData" : values[i].cameraDeviceId
								};
							}
						}else if(busiType == 'DOOR_BLOCK'){
							if (values[i].cameraDeviceId == tempCameraId) {
								doorBlockDeviceList.unshift({
									"itemText" : values[i].cameraName,
									"itemData" : values[i].cameraDeviceId
								});
							} else {
								doorBlockDeviceList[doorBlockDeviceList.length] = {
									"itemText" : values[i].cameraName,
									"itemData" : values[i].cameraDeviceId
								};
							}
						}
					}
				}
				if (json.firesVideoMonitorDTO.fireAlarm == 1) {
                    openVideoPage(busiType);
				}else{
					if (typeof ($("#fires-alarm-video-modal").val()) != "undefined") {
						document.getElementById('fires-alarm-video-iframe').contentWindow.initFiresVideoDropDownList();
					}
				}
			}
		});
	}
}

/**
 * 消防火警视频弹窗：获取所有的消防摄像头
 *
 * @param deviceId
 * @returns
 */
function getAllFireFightingCameras() {
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingManage/getFiresAlarmVideoCache",
		dataType : "json",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.code == 0 && data.data != null) {
				console.log(data);
				var lists = data.data;
				$.each(lists, function(index, value) {
					if (value.fireAlarm == 1) {
						var dto = {
							"firesDeviceId" : value.firesDeviceId,
							"cameraName" : value.cameraName,
							"fireAlarm" : value.fireAlarm,
							"cameraDeviceId" : value.cameraDeviceId,
							"cameraStatus" : value.cameraStatus,
							"recordId" : value.recordId,
							"eventConfirm" : value.eventConfirm,
							"confirmType" : value.confirmType,
							"mark" : value.mark,
							"msgId" : value.msgId
						};
						firesVideoDeviceMap.put(value.cameraDeviceId, dto);
					}
				});
			}
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	})

}

// 消防火警视频弹窗
function openVideoPage(busiType) {
	if (typeof ($("#fires-alarm-video-modal").val()) == "undefined") {
		if(busiType=="DOOR_BLOCK"){
			createSimpleModalWithIframe("fires-alarm-video", 704, 540, ctx + "/fireFightingManage/firesVideoForCloud?videoType=fire-fighting&busiType=DOOR_BLOCK", "", "", "100px","","blue");
		}else{
			createSimpleModalWithIframe("fires-alarm-video", 704, 878, ctx + "/fireFightingManage/firesVideoForCloud?videoType=fire-fighting", "", "", "100px","","blue");
		}
		openModal("#fires-alarm-video-modal", false, false);
		$(".modal-dialog").css("transform", "none");
// hiddenScroller();
	} else {
		document.getElementById('fires-alarm-video-iframe').contentWindow.initFiresVideoDropDownList();
		document.getElementById('fires-alarm-video-iframe').contentWindow.showTip();
	}
}
/*function unloadAndRelease() {
	if (stompClient != null) {
		stompClient.unsubscribe('/topic/ffmAlarmVideoData/' + huojuProjectCode);
		stompClient.unsubscribe('/topic/elevatorAlarmVideoPopoverRunningData/' + huojuProjectCode);
		stompClient.unsubscribe('/topic/elevatorAlarmVideoPopover/' + huojuProjectCode);
	}
}*/
// ==================电梯、消防视频弹窗结束=============================
// 展示房屋饼图
function showHousePie(divId,houseData){
	var myChart = echarts.init(document.getElementById(divId));
	var option = {
		    title : {
		        text: '',
		        subtext: '',
		        x:'center'
		    },
		    tooltip : {

		    	show:false,
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    color:['#F5A623', 'transparent'],
		    calculable : true,
		    series : [
		        {
		            name: '访问来源',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:houseData,
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                },
		                normal : {
		                    // 引导线
		                    labelLine : {

		                      show: false
		                }, label: { // 控制
		                        show: false,
		                        formatter: '{d}%'
		                    }

		                }
		            }
		        }
		    ]
		};


	myChart.setOption(option);
}


function getYanfuHousePieData(houseData){
	// var houseData=[{value:27247, name:''},{value:108988, name:''}];
	var houseDiv ='yanfu-house-pie';
	showHousePie(houseDiv,houseData);
}
function getChangheHousePieData(houseData){
// var houseData=[{value:26844, name:''},{value:107376, name:''}];
	var houseDiv ='changhe-house-pie';
	showHousePie(houseDiv,houseData);
}
function getXixinHousePieData(houseData){
// var houseData=[{value:22342, name:''},{value:89368, name:''}];
	var houseDiv ='xixin-house-pie';
	showHousePie(houseDiv,houseData);
}

// 获取设备重要告警排名数据
function getShareSpaceInfo() {

	$.ajax({
		type : "post",
		url : ctx +"/fire-fighting/fireFightingManage/getGeomagParkingSpaceList",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data) {
				spaceData = JSON.parse(data);
				showShareSpaceInfo();
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

// 共享车位
function showShareSpaceInfo() {
	$("#bd-share-ul").empty();
	var length = spaceData.length;
	var pageSize =  Math.ceil(length /5);//页数
	var end = 5 * pageNumber + 5;
	var  data;
	if(end < length){
		data  = spaceData.slice(5 * pageNumber,end);
		pageNumber++;
	}else{
		data  = spaceData.slice(5 * pageNumber);
		pageNumber=0;
	}

	for ( var i in data) {

		if(i=="add"){
			break;
		}
		var projectName = data[i].projectName;
		var parkingTotal = data[i].parkingTotal;
		var parkingRemain = data[i].parkingRemain;
		var remainColor = "#FF5454";
		if(parkingRemain == 0){
			remainColor="#FF5454";
		}else if(parkingRemain >0 && parkingRemain <10){
			remainColor="#F5A623";
		}else{
			remainColor="#03EACA";
		}

		var parkingItem = '<li class="share-space-content-class"><div class="share-space-content-name"><div style="float:right">'+ projectName +'</div></div>'
			+'<div class="share-space-content-totalNum">'+ parkingTotal +'</div><span class="share-space-content-remain" style="color:'+ remainColor +'">'+ parkingRemain +' </span></li>';

		$("#bd-share-ul").append(parkingItem);

	}
//	jQuery("#share-space-content-div").slide({ mainCell:".bd-share ul",autoPage:true,effect:"topLoop",autoPlay:true,vis:5,interTime:1500});

}


function replayVideo(e){
	var deviceId =	e.dataset.deviceid;
	var time =	e.dataset.time;
	var url =	e.dataset.url;
	createModalWithLoad("show-video-dss", 730, 500, "视频回放",
			"videomonitoring/showDssVideo?type=1&deviceNo="+ deviceId +"&width=700&height=393&playbackTime=" + encodeURI(time) + "&url=" + encodeURI(url), "", "", "","");

}




