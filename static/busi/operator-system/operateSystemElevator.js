/*function startConnForElevatorFace(gatewayAddr) {
	connect(gatewayAddr);
	setInterval("connect('" + gatewayAddr + "')", 40000);
}

function connect(gatewayAddr) {
	if (isConnected) {
		return;
	}
	var url = gatewayAddr + '/websocket';
	g_gatewayAddr = gatewayAddr;
	var t_socket = new SockJS(url);
	stompClient = Stomp.over(t_socket);
	stompClient.connect({}, function(frame) {
		isConnected = true;
		console.info("电梯人脸网关连接成功！");
		// 告警中心告警
		stompClient.subscribe('/topic/elevatorRecord', function(result) {
					var json = JSON.parse(result.body);
					windowPushData(json);
				});
	}, onerror);
}

function elevatorRelease() {
	if(stompClient != null) {
		stompClient.unsubscribe('/topic/elevatorRecord');
	}
}*/


function getCertainElevator(deviceNo, projectCode) {
    createSimpleModalWithIframe("elevator-detail", 702, 700, ctx+ "/elevatorSystem/getCertainElevator?deviceNo="+deviceNo+"&projectCode="+projectCode, null, null, 120,"","blue");
	$("#elevator-detail-dialog").css("transform","none");
//	$(".modal-content").css("background","rgba(9, 162, 221, 0.4) none repeat scroll 0% 0%");
//	$("#elevator-detail-iframe").css("border","1px solid #56E4FF");
	openModal("#elevator-detail-modal", false, false);
	hiddenScroller();
}

//更新某个电梯的运行数据
function updateRunningData1(val){
	var oldBody = $('#body'+val.elevatorCode);
	if (oldBody.attr("class") != 'body') {
		return;
	}
	
	// 修改电梯门
	var t_body = $('#body'+val.elevatorCode);
	if (val.isAnyone == 1 && val.isDoorOpen == 1) {
		dianti = yourenIcon;
	} else if (val.isAnyone != 1 && val.isDoorOpen == 1){
		dianti = kaimenIcon;
	} else {
		dianti = guanmenIcon;
	}
	t_body.css("background-image", "url("+dianti+")");
	
	// 修改楼层
	var t_floorDisplay = $('#floorDisplay'+val.elevatorCode);
	if (val.floorDisplaying != undefined) {
		t_floorDisplay.html(val.floorDisplaying);
	}
	
	// 修改运行状态
	var t_runState = $('#run'+val.elevatorCode);
	if (val.runningState == 1) {
		yunxingStatus = shangshengIcon;
	} else if (val.runningState == 2) {
		yunxingStatus = xiajiangIcon;
	} else {
		yunxingStatus = tingzhiIcon;
	}
	if (val.runningState != undefined) {
		t_runState.attr('src',yunxingStatus);
	}
	
	var t_bottom = $('#bottom+'+val.elevatorCode);
	var t_kunren = $('#kunren'+val.elevatorCode);
	var t_weixiu = $('#weixiu'+val.elevatorCode);
	if (val.elevatorState == 1) {
		if((t_kunren[0].src.indexOf(".svg") != -1)) {//说明当前存在困人小图
			var newBottom = '<div class="bottom">'
			+ '<img id="weixiu'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;">'
			+ '<img id="kunren'+val.elevatorCode+'" src="'+kunrenIcon+'" style="margin-top: 6px;"></div>'
			$("#bottom"+val.elevatorCode).html(newBottom);
		} else {
			var newBottom = '<div class="blank">'
				+ '<img id="weixiu'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;">'
				+ '<img id="kunren'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;"></div>'
				$("#bottom"+val.elevatorCode).html(newBottom);
		}
	}
	
	if (val.elevatorState != 1) {
		if((t_kunren[0].src.indexOf(".svg") != -1)) {//说明当前存在困人小图
			var newBottom = '<div class="bottom">'
			+ '<img id="weixiu'+val.elevatorCode+'" src="'+weixiuIcon+'" style="margin-top: 6px;">'
			+ '<img id="kunren'+val.elevatorCode+'" src="'+kunrenIcon+'" style="margin-left: 50px; margin-top: 6px;"></div>'
			$("#bottom"+val.elevatorCode).html(newBottom);
		} else {
			var newBottom = '<div class="bottom">'
				+ '<img id="weixiu'+val.elevatorCode+'" src="'+weixiuIcon+'" style="margin-top: 6px;">'
				+ '<img id="kunren'+val.elevatorCode+'" src="" style="margin-left: 50px; margin-top: 6px; display: none;"></div>'
				$("#bottom"+val.elevatorCode).html(newBottom);
		}
	}
}

//更新某个电梯的报警数据
function updateAlarmData1(val) {
	var oldBody = $('#body'+val.elevatorCode);
	if (oldBody.attr("class") != 'body') {
		return;
	}
	
	var t_bottom = $('#bottom+'+val.elevatorCode);
	var t_kunren = $('#kunren'+val.elevatorCode);
	var t_weixiu = $('#weixiu'+val.elevatorCode);
	// 维修小图标的东西需求确定以后直接拼整个bottom
	if (val.alarmType == 1 && val.alarmCode == 37) {
		if((t_weixiu[0].src.indexOf(".svg") != -1)) {//说明当前存在维修小图
			var newBottom = '<div class="bottom">'
			+ '<img id="weixiu'+val.elevatorCode+'" src="'+weixiuIcon+'" style="margin-top: 6px;">'
			+ '<img id="kunren'+val.elevatorCode+'" src="'+kunrenIcon+'" style="margin-left: 50px; margin-top: 6px;"></div>'
			$("#bottom"+val.elevatorCode).html(newBottom);
		} else {
			var newBottom = '<div class="bottom">'
			+ '<img id="weixiu'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;">'
			+ '<img id="kunren'+val.elevatorCode+'" src="'+kunrenIcon+'" style="margin-top: 6px;"></div>'
			$("#bottom"+val.elevatorCode).html(newBottom);
		}
	}
	
	if (val.alarmType != 1 && val.alarmCode == 37) {
		if((t_weixiu[0].src.indexOf(".svg") != -1)) {//说明当前存在维修小图
			var newBottom = '<div class="bottom">'
			+ '<img id="weixiu'+val.elevatorCode+'" src="'+weixiuIcon+'" style="margin-top: 6px;">'
			+ '<img id="kunren'+val.elevatorCode+'" src="" style="margin-left: 50px; margin-top: 6px; display: none;"></div>'
			$("#bottom"+val.elevatorCode).html(newBottom);
		} else {
			var newBottom = '<div class="blank">'
			+ '<img id="weixiu'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;">'
			+ '<img id="kunren'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;"></div>'
			$("#bottom"+val.elevatorCode).html(newBottom);
		}
	}
}


//视频弹窗后台推送处理
function windowPushData(json){
	var deviceNo = json.deviceNo;
	var num = $("#ul"+deviceNo).children().length;
	if(num==0){
		generatCenter(json);
	}else if(num==1){
		generatRight(json);
	}else if(num==2){
	queueArray.push(json);
	}
	
	var currDayPassageFlow = json.currDayPassageFlow;
	// 更新当日客流量
	var currDayFlow = $('#currDayFlow'+deviceNo);
	if (currDayFlow != undefined) {
		currDayFlow.html("当日客流量："+currDayPassageFlow);
	}
}

// 定时三秒就执行
function idByNull(liOneId,deviceNo) {
	$(liOneId).remove();
	dequeueArray(deviceNo);
}

function generatCenter(json){
	judgment = true;
	var deviceNo = json.deviceNo;
    html = '<li id="liOne'+deviceNo+'" class="only-one"><div class="item-ul"><img id="imgOne'+deviceNo+'" class="item-avatar"'
		+'src=""/></div><div class="visitor-info">'
		+'<p  id="first-p1'+deviceNo+'" class="first-p"><span id="userTypeOne'+deviceNo+'"></span><span data-toggle="tooltip" title="'+json.userName+'" id="nameOne'+deviceNo+'"></span></p></div></li>'
$("#ul"+deviceNo).append(html);
		$(function() {
		$("[data-toggle='tooltip']").tooltip();
	});
var url = json.faceImage;
var name = json.userName;
var userType = json.userType
if(userType == "1"){
	$("#userTypeOne"+deviceNo).html("业主：");
}else if(userType == "2"){
	$("#userTypeOne"+deviceNo).html("访客：");
}else if(userType == "3"){
	$("#userTypeOne"+deviceNo).html("物业：");
}else{
	$("#userTypeOne"+deviceNo).html("其他：");
}
if(name.length>8){
		name = name.substr(0, 8) + "...";
}
$("#nameOne"+deviceNo).html(name);
if(name.length>3){
	$("#first-p1"+deviceNo).removeClass("first-p").addClass("second-p");
}

if(url != null && url != undefined){
	$("#imgOne"+deviceNo).attr('src',url);
	}else{
		$("#imgOne"+deviceNo).attr('src',defaultUrl);
	}
       var liOneId = "#liOne"+deviceNo;
		var nameOneId = "#nameOne"+deviceNo;
		var imgOneId = "#imgOne"+deviceNo;
// 三秒后弹窗消失
setTimeout("idByNull('" + liOneId + "','" + deviceNo + "')", 5000);
}

function generatRight(json){
	var deviceNo = json.deviceNo;
	var url = json.faceImage;
	var one = document.getElementById("nameOne"+deviceNo); 
	var two = document.getElementById("nameTwo"+deviceNo); 
	
	if(one!=null && two==null){
		if(judgment==true){
	$("#liOne"+deviceNo).animate({marginLeft:"-108px"},50,function(){
		});
		}else{
			$("#liOne"+deviceNo).animate({marginLeft:"-131px"},50,function(){
			});
		}
	html = '<li id="liTwo'+deviceNo+'" class="only-two"><div class="item-ul"><img id="imgTwo'+deviceNo+'" class="item-avatar"'
	+'src=""/></div><div class="visitor-info">'
	+'<p id="first-p2'+deviceNo+'" class="first-p"><span id="userTypeTwo'+deviceNo+'"></span><span data-toggle="tooltip" title="'+json.userName+'" id="nameTwo'+deviceNo+'"></span></p></div></li>'
    $("#ul"+deviceNo).append(html);
	$(function() {
		$("[data-toggle='tooltip']").tooltip();
	});
	var name = json.userName;
	var userType = json.userType
	if(userType == "1"){
		$("#userTypeTwo"+deviceNo).html("业主：");
	}else if(userType == "2"){
		$("#userTypeTwo"+deviceNo).html("访客：");
	}else if(userType == "3"){
		$("#userTypeTwo"+deviceNo).html("物业：");
	}else{
		$("#userTypeTwo"+deviceNo).html("其他：");
	}
	if(name.length>8){
		name = name.substr(0, 8) + "...";
    }
	$("#nameTwo"+deviceNo).html(name);
	if(name.length>3){
		$("#first-p2"+deviceNo).removeClass("first-p").addClass("second-p");
	}
	if(url != null && url != undefined){
		$("#imgTwo"+deviceNo).attr('src',url);
		}else{
			$("#imgTwo"+deviceNo).attr('src',defaultUrl);
		}
	var liTwoId = "#liTwo"+deviceNo;
	var nameTwoId = "#nameTwo"+deviceNo;
	var imgTwoId = "#imgTwo"+deviceNo;
	// 三秒后弹窗消失
	setTimeout("idByNull('" + liTwoId + "','" + deviceNo + "')", 5000);
	}
	if(one==null && two!=null){
		if(judgment==true){
		$("#liTwo"+deviceNo).animate({marginLeft:"-108px"},50,function(){
		});
		}else{
			$("#liTwo"+deviceNo).animate({marginLeft:"-131px"},50,function(){
			});
		}
		html = '<li id="liOne'+deviceNo+'" class="only-two"><div class="item-ul"><img id="imgOne'+deviceNo+'" class="item-avatar"' 
           +'src=""/></div><div class="visitor-info">'
           +'<p id="first-p3'+deviceNo+'" class="first-p"><span data-toggle="tooltip" title="'+json.userName+'" id="userTypeOne'+deviceNo+'"></span><span  id="nameOne'+deviceNo+'">1234</span></p></div></li>'
	    $("#ul"+deviceNo).append(html);
           $(function() {
				$("[data-toggle='tooltip']").tooltip();
			});
	    var name = json.userName;
	    var userType = json.userType
		if(userType == "1"){
			$("#userTypeOne"+deviceNo).html("业主：");
		}else if(userType == "2"){
			$("#userTypeOne"+deviceNo).html("访客：");
		}else if(userType == "3"){
			$("#userTypeOne"+deviceNo).html("物业：");
		}else{
			$("#userTypeOne"+deviceNo).html("其他：");
		}
	    if(name.length>8){
			name = name.substr(0, 8) + "...";
	    }
	   	$("#nameOne"+deviceNo).html(name);
	   	if(name.length>3){
			$("#first-p3"+deviceNo).removeClass("first-p").addClass("second-p");
		}
	   	if(url != null && url != undefined){
			$("#imgOne"+deviceNo).attr('src',url);
			}else{
				$("#imgOne"+deviceNo).attr('src',defaultUrl);
			}
		var liOneId = "#liOne"+deviceNo;
		var nameOneId = "#nameOne"+deviceNo;
		var imgOneId = "#imgOne"+deviceNo;
		// 三秒后弹窗消失
		setTimeout("idByNull('" + liOneId + "','" + deviceNo + "')", 5000);     
	}
	judgment=false;
	}

//弹窗队列
var queueArray = new Array();
//图片消失后调用
function dequeueArray(deviceNo){
	if(queueArray.length > 0){
		var data  = queueArray.shift();
		/* displayAlarmInfo(data); */
		generatRight(data);
	}else{
		var num = $("#ul"+deviceNo).children().length;
		if(num == 1){
			var one = document.getElementById("nameOne"+deviceNo); 
			var two = document.getElementById("nameTwo"+deviceNo); 
			if(one!=null){
			$("#liOne"+deviceNo).animate({marginLeft:"-75px"},50,function(){
				});
		}
			if(two!=null){
				$("#liTwo"+deviceNo).animate({marginLeft:"-75px"},50,function(){
					});
			}
		}
	}
}