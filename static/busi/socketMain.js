var isConnectedGateWay = false;
var stompClient = null;
function startConn() {
	var curPath=window.document.location.href;
    var pathName=window.document.location.pathname;
    var pos=curPath.indexOf(pathName);
    var localhostPaht=curPath.substring(0,pos);
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    var path2= localhostPaht+projectName;
    var gatewayAddr = path2;
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
		toSubscribe();
	}, onerror);

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