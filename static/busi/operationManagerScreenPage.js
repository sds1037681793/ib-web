var parkingConnectedGateWay = false;
var stompClient = null;
var gPassageName = "";
function startConn(gatewayAddr) {
	connect(gatewayAddr);
	setInterval("connect('" + gatewayAddr + "')", 40000);
}

function connect(gatewayAddr) {
	if (parkingConnectedGateWay) {
		return;
	}
	var url = gatewayAddr + '/websocket';
	g_gatewayAddr = gatewayAddr;
	var socket = new SockJS(url);
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame) {
		parkingConnectedGateWay = true;
		console.info("网关连接成功！");
	
		// parkingData websocket
		stompClient.subscribe('/topic/projectData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			if (json.type == 'VIDEO_MORNITORING') {
				console.log(json);
				showMornitorStatus(json);
			}else{
				console.log(json);
				showPicDiv(json);
			}
		});
        stompClient.subscribe('/topic/waSuIotSensorAlarmData/' + projectCode, function(result) {
            var json = JSON.parse(result.body);
            console.log(json);
            if(json.deviceTypeCode == 'PARKING_GEOMAGNETISM'){
                dealWasuParkingGeomagnetism(json);
			}else if(json.deviceTypeCode == 'FIRE_GATE_GEOMAGNETISM'){
                dealWasuFireGeomagnetism(json);
			}else if(json.deviceTypeCode == 'IOT_TRASHCAN'){
				dealTrashData(json);
			}else if(json.deviceTypeCode == 'IOT_MANHOLECOVER'){
				dealManholeCover(json);
			}else if(json.deviceTypeCode == 'IOT_ENVIRONMENT'){
				dealEnvironmentCover(json);
			}else if(json.deviceTypeCode == 'IOT_ELECTRICITY_METER'){
				dealElectricityCover(json);
			}
        });
		// 告警中心告警
		stompClient.subscribe('/topic/operateSystemMainData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			websocketCallBack(json);
		});
		//烟感
        stompClient.subscribe('/topic/waSuFfmAlarmData/' + projectCode, function(result) {
            var json = JSON.parse(result.body);
            console.log(json);
            displayFfInfo(json);
        });
		stompClient.subscribe('/topic/operateSystemData/' + projectCode,
				function(result) {
					var json = JSON.parse(result.body);
					websocketCallBack(json);
				});	
	}, onerror);
	// 根据类型转入不同的方法
	function websocketCallBack(json) {
		if (json.type == 'ALARM') {
		} else if (json.type == 'TEST') {
		} else if (json.type == 'ACCESS_CONTROL') {
			showFaceRecoginaze(json);
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
	
	//电表推送数据处理
	function dealElectricityCover(json){
		//图标处理
		var deviceId = json.deviceId;
		var deviceStatus = json.deviceStatus;
		if(deviceStatus == 1){
			$("#dby-device-"+deviceId).show();
			$("#db-device-"+deviceId).hide();
			$("#db-span-"+deviceId).hide();
			$("#db-span1-"+deviceId).hide();
		}else if(deviceStatus == 0){
			$("#dby-device-"+deviceId).hide();
			$("#db-device-"+deviceId).show();
			$("#db-span-"+deviceId).show();
			$("#db-span1-"+deviceId).show();
			$("#db-span-"+deviceId).html(json.monitorValue);
		}
		//统计处理
		getElectricityStatistics();
	}
	
	//环境终端推送数据处理
	function dealEnvironmentCover(json){
		//图标处理、
		var url = ctx +"/static/img/operationManagerScreenPage/huanjingzhengchang.svg";
		if(json.deviceStatus == 1){
			url = ctx +"/static/img/operationManagerScreenPage/huanjinglixian.svg"
		}else{
			url = ctx +"/static/img/operationManagerScreenPage/huanjingzhengchang.svg"
		}
		$("#hj-"+json.deviceId).attr('src', url);
		//冒泡处理
		if(json.monitorValue<35){
     		var pushPollution = "优";
     		var color="#5BCE3E";
			}else if(35<=json.monitorValue && json.monitorValue<75){
				pushPollution = "良";
				color="#00D1FF";
			}else if(75<=json.monitorValue && json.monitorValue<115){
				pushPollution = "轻度污染";
				color="#FFD014";
			}else if(115<=json.monitorValue && json.monitorValue<150){
				pushPollution = "中度污染";
				color="#FF8827";
			}else if(150<=json.monitorValue && json.monitorValue<250){
				pushPollution = "重度污染";
				color="#FC5E5E";
			}else if(250<=json.monitorValue){
				pushPollution = "严重污染";
				color="#B540C1";
			}
		var monitorValue = json.monitorValue;
		if(monitorValue == null || monitorValue == ""){
			monitorValue = "-   -";
		}
		$("#pm-"+json.deviceId).html(monitorValue);
		$("#pollution-"+json.deviceId).html(pushPollution);
		$("#pollution-"+json.deviceId).css('background-color', color);
		//统计处理
		getEnvironmentStatistics();
	}
	
	//垃圾桶推送数据处理
	function dealTrashData(json){
		//图标处理
		var url = ctx +"/static/img/operationManagerScreenPage/lajitongzhengchang.svg"
		if(json.deviceStatus == 1){
			url = ctx +"/static/img/operationManagerScreenPage/lajitonglixian.svg"
		}else{
			if(json.monitorStatus == 1){
				url = ctx +"/static/img/operationManagerScreenPage/lajitonggaojing.svg"
			}else{
				if(json.lowBatteryStatus == 1){
					url = ctx +"/static/img/operationManagerScreenPage/lajitongbaojing.svg"
				}else{
					url = ctx +"/static/img/operationManagerScreenPage/lajitongzhengchang.svg"
				}
			}
		}
		$("#lj-"+json.deviceId).attr('src', url);
		//统计处理
		var deviceInfoId = "deviceInfo" + json.deviceTypeCode;
		getGarbageStatistics();
	}

	function dealWasuParkingGeomagnetism(json){
		var direction = $("#"+json.deviceId).attr('direction');
		if(direction == "H"){
			if(json.lowBatteryStatus == 0 && json.monitorStatus == 0){
				$("#"+json.deviceId).attr('src', parkingGeomagnetismPictureList.NuNH);
			}else if(json.lowBatteryStatus == 0 && json.monitorStatus == 1){
				$("#"+json.deviceId).attr('src', parkingGeomagnetismPictureList.UNH);
			}else if(json.lowBatteryStatus == 1 && json.monitorStatus == 0){
				$("#"+json.deviceId).attr('src', parkingGeomagnetismPictureList.NuAbNH);
			}else if(json.lowBatteryStatus == 1 && json.monitorStatus == 1){
				$("#"+json.deviceId).attr('src', parkingGeomagnetismPictureList.UAbNH);
			}
		}else if(direction == "V"){
			if(json.lowBatteryStatus == 0 && json.monitorStatus == 0){
				$("#"+json.deviceId).attr('src', parkingGeomagnetismPictureList.NuNV);
			}else if(json.lowBatteryStatus == 0 && json.monitorStatus == 1){
				$("#"+json.deviceId).attr('src', parkingGeomagnetismPictureList.UNV);
			}else if(json.lowBatteryStatus == 1 && json.monitorStatus == 0){
				$("#"+json.deviceId).attr('src', parkingGeomagnetismPictureList.NuAbNV);
			}else if(json.lowBatteryStatus == 1 && json.monitorStatus == 1){
				$("#"+json.deviceId).attr('src', parkingGeomagnetismPictureList.UAbNV);
			}
		}

        getParkingDeviceAlarmInfo();
	}

    function dealWasuFireGeomagnetism(json){
        if(json.deviceStatus == 1){
            $("#"+json.deviceId).attr('src', fireGateGeomagnetismPictureList.OL);
        }else if(json.deviceStatus == 0){
            if(json.monitorStatus == 1){
                $("#"+json.deviceId).attr('src', fireGateGeomagnetismPictureList.AbN);
            }else if(json.monitorStatus == 0 && json.lowBatteryStatus == 1){
                $("#"+json.deviceId).attr('src', fireGateGeomagnetismPictureList.LB);
            }else{
                $("#"+json.deviceId).attr('src', fireGateGeomagnetismPictureList.N);
            }
        }

        getFireDeviceAlarmInfo();
	}

    function dealManholeCover(json){
        if(json.deviceStatus == 1){
            $("#"+json.deviceId).attr('src', manholeCoverPictureList.OL);
        }else if(json.deviceStatus == 0){
            if(json.monitorStatus == 1){
                $("#"+json.deviceId).attr('src', manholeCoverPictureList.M);
            }else if(json.monitorStatus == 0 && json.lowBatteryStatus == 1){
                $("#"+json.deviceId).attr('src', manholeCoverPictureList.LB);
            }else{
                $("#"+json.deviceId).attr('src', manholeCoverPictureList.N);
            }
        }

        getManholeCoverAlarmInfo();
	}

	function showPicDiv(json){
		data =json.data;
		var passageType =data.passageType;
		if(passageType==1){
			showInPic(data);
		}else{
			showOutPic(data);
		}
	}

	function showInPic(json){
		var snapshot = json.snapshot;
		if (snapshot != null && snapshot != "") {
			snapshot=extNetImageMapping(snapshot);
		}
		
		$("#snapshot_li_img").attr("src",snapshot);
		$("#licensePlate").html(json.licensePlate);
		$("#snapshot_div_id").show(3000);
		setTimeout("closepic()",6000);
		
		if(typeof(json.isFixedCar)!="undefined"){
				if(json.isFixedCar==1){
					$("#carType").html("固定车");
				}else if(json.carType==2){
					$("#carType").html("访客车");
				}else{
					$("#carType").html("临时车");
				}
		}
		
	}
	
	function showOutPic(json){
		var snapshot = json.snapshot;
		if (snapshot != null && snapshot != "") {
			snapshot=extNetImageMapping(snapshot);
		}
		
		$("#snapshot-li-img-out").attr("src",snapshot);
		$("#licensePlate-out").html(json.licensePlate);
		$("#snapshot-div-id-out").show(3000);
		setTimeout("closeOutpic()",6000);
		
		if(typeof(json.isFixedCar)!="undefined"){
			if(json.isVisitor==1){
				$("#custNameTxt-out").show(1000);
				$("#carType-out").html("访客车");
				$("#custName-out").html(json.custName.substring(0,1)+"**  邀请的访客");
			}else{
				if(json.isFixedCar==1){
					$("#carType-out").html("固定车");
				}else if(json.carType==3){
					$("#carType-out").html("储值车");
				}else{
					$("#carType-out").html("临时车");
				}
			}
		}
		
	}
}
function closepic(){
	$("#snapshot_div_id").hide(3000);
	$("#custNameTxt").hide(3000);
}
function closeOutpic(){
	$("#snapshot-div-id-out").hide(3000);
	$("#custNameTxt-out").hide(3000);
}
function historyRecord(data,event){
	event.stopPropagation();
	var passageName = $(data).attr("name");
    gPassageName = passageName;
	createModalWithLoad("record-slide-image", 800, 645, "车牌抓拍记录", "parkingManage/showPicture","", "close", "");
}


function displayFfInfo(data){
	var smokeUnNormal = ctx +"/static/img/operationManagerScreenPage/smokeUnNormal.svg";
	var smokeNormal = ctx +"/static/img/operationManagerScreenPage/smokeNormal.svg";
    var smokeOtherUnNormal = ctx + "/static/img/operationManagerScreenPage/smokeOtherUnNormal.svg";
    var smokeOffline = ctx + "/static/img/operationManagerScreenPage/smokeOffline.svg";

	var deviceStatus = data.deviceStatus;
    var fireStatus = data.fireStatus;
    var tpa = data.tpa;
    var soa = data.soa;
    var slba = data.slba;
    var slfa = data.slfa;
    if(deviceStatus == 1){
        $("#f-"+data.deviceId).attr('src', smokeOffline);
    }else{
        if(fireStatus == 1){
            $("#f-"+data.deviceId).attr('src', smokeUnNormal);
        }else{
            if(slba == 1 || slfa == 1 || soa == 1 || tpa==1){
                $("#f-"+data.deviceId).attr('src', smokeOtherUnNormal);
            }else{
                $("#f-"+data.deviceId).attr('src', smokeNormal);
			}
        }
    }
    getFfStatistics();
}

function showFaceRecoginaze(data){
	jQuery.each(data.data.userList, function(i, val) {
		
		var faceParam = {
				personType: val.personType,
				faceUrl: val.faceUrl
			    };
		startFaceRecoginaze(faceParam);//开始展现人脸识别效果
	});
}
//接收摄像机设备状态
function showMornitorStatus(data){
	var status = data.data.status;
	var deviceId = data.data.deviceId;
	var icon = deviceIconMap.get(deviceId);
	deviceStatusMap.put(deviceId,status);
    if (status == "0"){
    	//数据只配置摄像机方向，页面设置在线离线 +“O”表示离线
    	icon = icon+"O";
    }
    var iconUrl = videoIconList[icon];
    $("#camera-img-"+deviceId).attr("src",iconUrl);
}