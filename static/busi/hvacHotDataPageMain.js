function toSubscribe(){
	if (isConnectedGateWay) {
		// 暖通空调首页信息识别结果
		stompClient.subscribe('/topic/HotData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			console.log(json);
			websocketCallBack(json);
		});
	}
}


function unloadAndRelease() {
	if(stompClient != null) {
		stompClient.unsubscribe('/topic/HotData/' + projectCode);
	}
}
