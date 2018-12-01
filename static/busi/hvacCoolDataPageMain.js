function toSubscribe(){
	if (isConnectedGateWay) {
		stompClient.subscribe('/topic/CoolData/'+projectCode, function(result) {
			var json = JSON.parse(result.body);
			console.log(json);
			websocketCallBack(json);
		});
	}
}

function unloadAndRelease() {
	if(stompClient != null) {
		stompClient.unsubscribe('/topic/CoolData/'+projectCode);
	}
}



