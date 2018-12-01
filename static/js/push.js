function toSubscribe(){
	if (isConnectedGateWay) {
		// 暖通空调新风实时展示信息识别结果
		if (judge == 1) {
			stompClient.subscribe('/topic/airMachine', function(result) {
				var json = JSON.parse(result.body);
				console.log(json);
				websocketCallBack(json);
			});
		} else if (judge == 2) {
			stompClient.subscribe('/topic/exhaustFan', function(result) {
				var json = JSON.parse(result.body);
				console.log(json);
				websocketCallBack(json);
			});
		} else if (judge == 3) {
			stompClient.subscribe('/topic/airConditioningUnit',
					function(result) {
						var json = JSON.parse(result.body);
						console.log(json);
						websocketCallBackAir(json);
					});
		}
	}
}

function unloadAndRelease() {
	if(stompClient != null) {
		stompClient.unsubscribe('/topic/airMachine');
		stompClient.unsubscribe('/topic/exhaustFan');
		stompClient.unsubscribe('/topic/airConditioningUnit');
	}
}

function websocketCallBack(json) {
	$("#code_" + json.deviceId).text(json.code);
	//开关状态
	var workStatus;
	if (json.workStatus == 1) {
		workStatus = "开启";
		$("#workStatus_" +json.deviceId).removeClass("statuss-color").addClass("status-color");
    } else if (json.workStatus == 0) {
		workStatus = "关闭";
		$("#workStatus_" +json.deviceId).removeClass("status-color").addClass("statuss-color");
    }
	$("#workStatus_" + json.deviceId).text(workStatus);
	//设备故障
	var faultStatus;
	if(json.faultStatus==0){
		faultStatus = "故障";
		$("#faultStatus_" +json.deviceId).removeClass("status-color").addClass("statuss-color");
    }else if(json.faultStatus==1){
		faultStatus = "正常";
		$("#faultStatus_" +json.deviceId).removeClass("statuss-color").addClass("status-color");
    } 
	$("#faultStatus_" + json.deviceId).text(faultStatus);
	$("#locationName_" + json.deviceId).text(json.locationName);
	//手自动
	var automatic;
	if(json.automatic==0){
		automatic = "手动";
    }else if(json.automatic==1){
    	automatic = "自动";
    } 
	$("#automatic_" + json.deviceId).text(automatic);
}

function websocketCallBackAir(json) {
	$("#code_" + json.deviceId).text(json.code);
	var workStatus;
	if (json.workStatus == 1) {
		workStatus = "开启";
		$("#workStatus_" +json.deviceId).removeClass("statuss-color").addClass("status-color");
    } else if (json.workStatus == 0) {
		workStatus = "关闭";
		$("#workStatus_" +json.deviceId).removeClass("status-color").addClass("statuss-color");
    }
	$("#workStatus_" + json.deviceId).text(workStatus);
	var faultStatus;
	if(json.faultStatus==0){
		faultStatus = "故障";
		$("#faultStatus_" +json.deviceId).removeClass("status-color").addClass("statuss-color");
    }else if(json.faultStatus==1){
		faultStatus = "正常";
		$("#faultStatus_" +json.deviceId).removeClass("statuss-color").addClass("status-color");
    } 
	$("#faultStatus_" + json.deviceId).text(faultStatus);
	$("#locationName_" + json.deviceId).text(json.locationName);
	//手自动
	var automatic;
	if(json.automatic==0){
		automatic = "手动";
    }else if(json.automatic==1){
    	automatic = "自动";
    }
	$("#automatic_" + json.deviceId).text(automatic);
	if(json.supplyWindTemperature == null){
		$("#supplyWindTemperature_" + json.deviceId).text(
				"-    -");
	}else{
	$("#supplyWindTemperature_" + json.deviceId).text(
			json.supplyWindTemperature+"℃");
	}
	if(json.returnWindTemperature == null){
		$("#returnWindTemperature_" + json.deviceId).text(
				"-    -");
	}else{
	$("#returnWindTemperature_" + json.deviceId).text(
			json.returnWindTemperature+"℃");
	}
	var alarmStatus;
	if(json.alarmStatus==0){
		alarmStatus = "故障";
		$("#alarmStatus_" +json.deviceId).removeClass("status-color").addClass("statuss-color");
    }else if(json.alarmStatus==1){
    	alarmStatus = "正常";
    	$("#alarmStatus_" +json.deviceId).removeClass("statuss-color").addClass("status-color");
    }
	$("#alarmStatus_" + json.deviceId).text(alarmStatus);
}