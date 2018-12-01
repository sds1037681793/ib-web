var stompClient = null;
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

	month < 10 ? month = '0' + month : month;
	day < 10 ? day = '0' + day : day;
	hour < 10 ? hour = '0' + hour : hour;
	minutes < 10 ? minutes = '0' + minutes : minutes;
	second < 10 ? second = '0' + second : second;
	var ymd = year + '-' + month + '-' + day;
	var week = show_day[today.getDay() - 1];
	var time = hour + ":" + minutes;
	$("#time").html(time);
	// 今天的日期
	$("#week").html(week);
	$("#ymd").html(ymd);
	setTimeout("showTime();", 1000);
}

// 获取集团所有消防主机数据
function getAllFireFightingData(){
	$.ajax({
		type: "post",
		url: ctx + "/fire-fighting/fireFightingManage/getGroupPageData",
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data && data.code==0 && data.data !=null) {
				setFireFighting(data.data);
			}
		},
		error: function(req, error, errObj) {
		}
	});
}

// 获取集团所有的设备
function getAllDeviceCount(){
	$.ajax({
		type: "get",
		url: ctx + "/device/homePage/getAllDeviceCount",
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null && data.length > 0) {
				$("#deviceCount").text(data);
				if(data.indexOf(".") < 0 ){
					$("#deviceWan").text("");
				}else{
					$("#deviceWan").text("万");
				}
			}
		},
		error: function(req, error, errObj) {
		}
	});
}

// 获取集团所有的项目
function getAllOrganizeCount(){
	$.ajax({
		type: "get",
		url: ctx + "/system/homePageOrganize/getAllOrganizeCount",
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null && data.length > 0) {
				$("#organizeCount").text(data);
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
        'data': ctx+"/system/homePageOrganize/getProjectData",
        'width': 'auto',
        'ajaxType': 'post',
        'ajaxDataType': 'json',
        'emphasis': false,
        'listStyle': 'custom',
        'matchHandler': function(keyword, data) {
        		return true;
        },
        'createItemHandler': function(index, data){
        	$("#showNoProject").text("");
        	datas = data;
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
		// 告警中心告警
		stompClient.subscribe('/topic/groupData', function(result) {
			var json = JSON.parse(result.body);
			websocketCallBack(json);
		});
	}, onerror);

}

// 根据类型转入不同的方法
function websocketCallBack(json) {
	if (json.type == 'ALARM') {
		displayAlarmInfo(json.data, 1);
	} else if (json.type == 'TEST') {
		console.log(json.data.name);
	} else if (json.type == 'ACCESS_CONTROL') {
		setAccessControlAbnormal(json.data)
	} else if (json.type == 'FIRE_FIGHTING') {
		setFireFighting(json.data);
	} else if (json.type == 'SUPPLY_DRAIN') {
		updateSdmInfo(json.data);
	} else if (json.type == 'VIDEO_MORNITORING') {
		deviceStateData("VIDEO_MORNITORING",json.data.groupNormalNum,json.data.groupAbnormalNum);
	}else if (json.type == 'POWER_SUPPLY') {
		powerSupplyAlarm(json.data);
	}else if (json.type == 'HVAC') {
		setHvacInfo(json.data);
	}else if(json.type == 'PARKING'){
		updateParkingData(json.data);
	}

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

// 弹框显示告警信息
// 弹窗最多五条 依次往上累加
// 弹窗十秒后消失
// 点图项目点显示红色
function displayAlarmInfo(data, flag) {
	// data参数
	var projectName = data.projectName;
	var projectCode = data.projectCode;
	var alarmTime = data.alarmTime;
	var description = data.description;
	var deviceTypeName = data.deviceTypeName;
	var idFour = $("#idfour").val();
	var idThree = $("#idthree").val();
	var idTwo = $("#idtwo").val();
	var idOne = $("#idone").val();
	var idFive = $("#idfive").val();
	var event = "";
	if(deviceTypeName == undefined){
		event = description;
	}else{
		if(description.length >= 8){
			description = description.substring(0,8);
		}
		if(deviceTypeName.length >= 6){
			deviceTypeName = deviceTypeName.substring(0,6);
		}
		event = deviceTypeName+" "+description;
	}
	// 新弹窗一个弹窗时，给各自的id一个值；弹窗消失时值置为空
	if (idFive == "") {
		var divid = "report_five_div";
		var ids = "idfive";
		var code = "codefive";
		$("#sjfive").text(event);
		$("#xmfive").text(projectName);
		$("#zsjfive").text(alarmTime);
		$("#idfive").val(1);
		$("#codefive").val(projectCode);
		showDivData(data, divid, ids, code);
		return true;
	} else if (idFour == "") {
		var divid = "report_four_div";
		var ids = "idfour";
		var code = "codefour";
		$("#sjfour").text(event);
		$("#xmfour").text(projectName);
		$("#zsjfour").text(alarmTime);
		$("#idfour").val(1);
		$("#codefour").val(projectCode);
		showDivData(data, divid, ids, code);
		return true;
	} else if (idThree == "") {
		var divid = "report_three_div";
		var ids = "idthree";
		var code = "codethree";
		$("#sjthree").text(event);
		$("#xmthree").text(projectName);
		$("#zsjthree").text(alarmTime);
		$("#idthree").val(1);
		$("#codethree").val(projectCode);
		showDivData(data, divid, ids, code);
		return true;
	} else if (idTwo == "") {
		var divid = "report_two_div";
		var ids = "idtwo";
		var code = "codetwo";
		$("#sjtwo").text(event);
		$("#xmtwo").text(projectName);
		$("#zsjtwo").text(alarmTime);
		$("#idtwo").val(1);
		$("#codetwo").val(projectCode);
		showDivData(data, divid, ids, code);
		return true;
	} else if (idOne == "") {
		var divid = "report_one_div";
		var ids = "idone";
		var code = "codeone";
		$("#sjone").text(event);
		$("#xmone").text(projectName);
		$("#zsjone").text(alarmTime);
		$("#idone").val(1);
		$("#codeone").val(projectCode);
		showDivData(data, divid, ids, code);
		return true;
	}
	// 只有新的报警才放入集合，集合里循环的不放入
	if (flag == 1) {
		dataList.push(data);
	}
	showDivAlarm = setTimeout("monitorAlarmDiv()", 5000);


    // showDivAlarm = setTimeout("monitorAlarmDiv()", 5000);
	return false;
}

function monitorAlarmDiv(){
	var idFour = $("#idfour").val();
	var idThree = $("#idthree").val();
	var idTwo = $("#idtwo").val();
	var idOne = $("#idone").val();
	var idFive = $("#idfive").val();
	if(idFour == "" || idThree=="" || idTwo =="" || idOne =="" || idFive == ""){
		ReProcessing();// TODO
	}else{
		showDivAlarm = setTimeout("monitorAlarmDiv()", 5000);
	}
}

// 五个弹窗都有弹出，后面的报警数据放到list里，循环不断去弹窗
function ReProcessing() {
	// 循环list 取出数据弹窗显示
	for (var i = 0; i < dataList.length; i++) { // 循环LIST
		var data = dataList[i];// 获取LIST里面的对象
		var info = displayAlarmInfo(data, 2);
		if (info == true) {
			// 当返回结果为true时，代表此报警已弹窗，在集合里删除当前循环的，下面的集合自动顶替删除的集合
			dataList.shift();
		}
	}
}

// 处理搜索的请求 1为变大 2为变小
function searchHandle(size){
	var project = $("#projectName").val().trim().replace(/\s/g,"");
	if(project != ""){
		var isHave = getProjectData(1);
		if(!isHave && isHave != undefined){
			$("#showNoProject").text("● 该项目不存在");
			size =1;
		}
	}
	// size等于1代表此时操作：在搜索框内输入了招不到的项目
	var codes = "";
	if(size != 1){
		codes = $("#codes").val();
	}
	var flag = 3;
	var idFour = $("#idfour").val();
	var idThree = $("#idthree").val();
	var idTwo = $("#idtwo").val();
	var idOne = $("#idone").val();
	var idFive = $("#idfive").val();
	if (idFour == "" && idThree == "" && idTwo == "" && idOne == ""
			&& idFive == "") {
		var groupMapId = document.getElementById("groupMap");
		if(groupMapId !=null){
			initGroupMap(flag, codes,"","");
		}
		var groupMapDisplayId = document.getElementById("groupMapDisplay");
		if(groupMapDisplayId !=null){
			initGroupMapDisplay(flag, codes,"","");
		}
	// initGroupMap(flag, codes,"","");
	// initGroupMapDisplay(flag, codes,"","");
	} else {
		var isClose = "";
		if (idFour != "") {
			var code = $("#codefour").val();
			if (code != "") {
				qList.push(code);
			}
		}
		if (idThree != "") {
			var code = $("#codethree").val();
			if (code != "") {
				qList.push(code);
			}
		}
		if (idTwo != "") {
			var code = $("#codetwo").val();
			if (code != "") {
				qList.push(code);
			}
		}
		if (idOne != "") {
			var code = $("#codeone").val();
			if (code != "") {
				qList.push(code);
			}
		}
		if (idFive != "") {
			var code = $("#codefive").val();
			if (code != "") {
				qList.push(code);
			}
		}
		if (qList != "") {
			var flags = 4;
			var groupMapId = document.getElementById("groupMap");
			if(groupMapId !=null){
				initGroupMap(flags, codes, qList,"");
			}
			var groupMapDisplayId = document.getElementById("groupMapDisplay");
			if(groupMapDisplayId !=null){
				initGroupMapDisplay(flags, codes, qList,"");
			}
			// initGroupMap(flags, codes, qList,"");
			// initGroupMapDisplay(flags, codes, qList,"");
			qList.splice(0, qList.length);
		}
	}
}

// 显示div弹窗告警信息
function showDivData(data, divid, ids, code) {
	// 1報警 2取消报警
	var flag = 1;
	alarmList.push(data.projectCode);
	// var projectCode ={code:data.projectCode};
	var code5 = $("#codefive").val();
	var code4 = $("#codefour").val();
	var code3 = $("#codethree").val();
	var code2 = $("#codetwo").val();
	var code1 = $("#codeone").val();
	if (code5 != "" && code5 != data.projectCode) {
		alarmList.push(code5);
	}
	if (code4 != "" && code4 != data.projectCode) {
		alarmList.push(code4);
	}
	if (code3 != "" && code3 != data.projectCode) {
		alarmList.push(code3);
	}
	if (code2 != "" && code2 != data.projectCode) {
		alarmList.push(code2);
	}
	if (code1 != "" && code1 != data.projectCode) {
		alarmList.push(code1);
	}
	var projectName = $("#projectName").val();
	var projetcodes = $("#codes").val();
	var maxCode="";
	if(projectName != ""){
		maxCode = projetcodes;
	}
	// 报警时根据code显示红色点
	var groupMapId = document.getElementById("groupMap");
	if(groupMapId!=null){
		initGroupMap(flag, alarmList,"",maxCode);
	}
	var groupMapDisplayId = document.getElementById("groupMapDisplay");
	if(groupMapDisplayId!=null){
		initGroupMapDisplay(flag, alarmList,"",maxCode);
	}
// initGroupMap(flag, alarmList,"",maxCode);
// initGroupMapDisplay(flag, alarmList,"",maxCode);
	// 清空
	alarmList.splice(0, alarmList.length);
	// 弹窗显示
	document.getElementById(divid).style.visibility = "visible";
	// 十秒后弹窗消失
	setTimeout("idByNull('" + ids + "','" + divid + "','" + data.projectCode + "','" + code + "')", 10000);

}

// 隐藏显示的div并且把div下的id值置为空
function idByNull(ids, divid, projectCode, code) {
	document.getElementById(divid).style.visibility = "hidden";
	$("#" + ids).val("");
	$("#" + code).val("");
	var projectName = $("#projectName").val();
	var projetcodes = $("#codes").val();

	var idFour = $("#idfour").val();
	var idThree = $("#idthree").val();
	var idTwo = $("#idtwo").val();
	var idOne = $("#idone").val();
	var idFive = $("#idfive").val();
	if (idFour == "" && idThree == "" && idTwo == "" && idOne == "" && idFive == "") {
		var maxCode="";
		if(projectName != ""){
			maxCode = projetcodes;
		}
		var flag = 2;
		var groupMapId = document.getElementById("groupMap");
		if(groupMapId !=null){
			initGroupMap(flag, projectCode,"",maxCode);
		}
		var groupMapDisplayId = document.getElementById("groupMapDisplay");
		if(groupMapDisplayId !=null){
			initGroupMapDisplay(flag, projectCode,"",maxCode);
		}
// initGroupMap(flag, projectCode,"",maxCode)
// initGroupMapDisplay(flag, projectCode,"",maxCode);
	} else {
		var isClose = "";
		if (idFour != "") {
			var code = $("#codefour").val();
			if (projectCode != code) {
				qList.push(code);
			}
		}
		if (idThree != "") {
			var code = $("#codethree").val();
			if (projectCode != code) {
				qList.push(code);
			}
		}
		if (idTwo != "") {
			var code = $("#codetwo").val();
			if (projectCode != code) {
				qList.push(code);
			}
		}
		if (idOne != "") {
			var code = $("#codeone").val();
			if (projectCode != code) {
				qList.push(code);
			}
		}
		if (idFive != "") {
			var code = $("#codefive").val();
			if (projectCode != code) {
				qList.push(code);
			}
		}
		if (qList != "") {
			var maxCode="";
			if(projectName != ""){
				maxCode = projetcodes;
			}
			var flag = 2;
			var groupMapId = document.getElementById("groupMap");
			if(groupMapId !=null){
				initGroupMap(flag, projectCode, qList,maxCode);
			}
			var groupMapDisplayId = document.getElementById("groupMapDisplay");
			if(groupMapDisplayId !=null){
				initGroupMapDisplay(flag, projectCode, qList,maxCode);
			}
// initGroupMap(flag, projectCode, qList,maxCode);
// initGroupMapDisplay(flag, projectCode, qList,maxCode);
			qList.splice(0, qList.length);
		}
	}
}

// 根据当前ip获取天气信息
function findWeather() {
	var cityUrl = 'http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js';
	$.getScript(cityUrl, function(script, textStatus, jqXHR) {
		var citytq = remote_ip_info.city;// 获取城市
		var url = "http://service.envicloud.cn:8082/v2/citycode/ETK4NJCYNTKYMZE0NJE3MJU3MJA1NTE=/"+citytq;
		$.ajax({
			url : url,
 			async:true,
			dataType : "json",
			success : function(data) {
				var cityCode=data.citycode;
				var secondUrl = "http://service.envicloud.cn:8082/v2/weatherforecast/ETK4NJCYNTKYMZE0NJE3MJU3MJA1NTE=/"+cityCode;
				$.ajax({
					type:'get',
					url : secondUrl,
					dataType:"json",
					success : function(data) {
						var cond = data.forecast[0].cond.cond_d;
						var now = new Date();
						var hour = now.getHours();
						
						if(hour > 18){
							cond = data.forecast[0].cond.cond_n;
						}
						
						var type ="duoyun";
						
						if(cond=='暴雪'){
							type ='baoxue';
						}else if(cond=='暴雨'){
							type='baoyu';
						}else if(cond=='大雪'){
							type='daxue';
						}else if(cond=='大雨'){
							type='dayu';
						}else if(cond=='多云'){
							type='duoyun';
						}else if(cond=='浮尘'){
							type='fuchen';
						}else if(cond=='雷阵雨'){
							type='leizhenyu';
						}else if(cond=='霾'){
							type='mai';
						}else if(cond.indexOf('晴')>-1){
							type='qingtian';
						}else if(cond=='特大暴雨'){
							type='tedabaoyu';
						}else if(cond=='雾'){
							type='wu';
						}else if(cond=='小雪'){
							type='xiaoxue';
						}else if(cond=='小雨'){
							type='xiaoyu';
						}else if(cond.indexOf('阴')>-1){
							type='yintian';
						}else if(cond=='阵雨'){
							type='zhenyu';
						}else if(cond=='阵雪'){
							type='zhenxue'
						}else if(cond=='中雨'){
							type='zhongyu';
						}else if(cond=='中雪'){
							type='zhongxue';
						}

						var icon = "one_" +type+".svg" ;
						$("#weatherIcon").attr("src",ctx+"/static/group/weatherIcon/"+icon);
						$("#weatherType").html(cond);
						$("#temperature").html(data.forecast[0].tmp.min + "~" + data.forecast[0].tmp.max + "℃ ");
					}
				})
			}
		});
	});
}

function getAccessControlData(type) {
	$.ajax({
		type : "post",
		url : ctx + "/access-control/accessStatistics/groupData",// TODO需要添加项目编号
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(result) {
			if (result && typeof(result.code) != undefined && result.code == 0) {
				var returnVal = result.data;
				$("#group-access-control-abnormal").html(returnVal.deviceAbnormalNum);
				$("#group-access-control-door").html(returnVal.doorNum);
				var visitor = returnVal.pgInVisitorRecordNum
				if (visitor >= 10000) {
					$("#group-access-control-visitor").next().show();
					visitor = Math.floor(visitor*100/10000) / 100
				} else {
					$("#group-access-control-visitor").next().hide();
				}
				$("#group-access-control-visitor").html(visitor);
				var pgInRecordNum = returnVal.pgInRecordNum;
				if (pgInRecordNum >= 10000) {
					$("#group-access-control-in").next().show();
					pgInRecordNum = Math.floor(pgInRecordNum *100/10000) / 100
				} else {
					$("#group-access-control-in").next().hide();
				}

				$("#group-access-control-in").html(pgInRecordNum);
				accessControlDeviceNo = returnVal.deviceNum;
				if(type==1){
					deviceStateData("ACCESS_CONTROL",returnVal.deviceNum-returnVal.deviceAbnormalNum,returnVal.deviceAbnormalNum);
				}
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

function setAccessControlAbnormal(data) {
	$("#group-access-control-abnormal").html(data.num);
	deviceStateData("ACCESS_CONTROL",accessControlDeviceNo-data.num,data.num);
}

// 打开页面请求视频监控设备数量
function getVideoMonitoringData() {
	$.ajax({
		type : "post",
		url : ctx + "/video-monitoring/vmDeviceStatus/getVmProjectData?projectCode=",
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if(data){
				deviceStateData("VIDEO_MORNITORING",data.groupNormalNum,data.groupAbnormalNum);
			}
		},
		error : function(req, error, errObj) {
			console.log("操作错误："+errObj);
// showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
}

// 打开集团首页梯控查询数据
function getElevatorData() {
	var typeCode = "ELEVATOR";
	var projectId=0;
	$.ajax({
		type : "post",
		url : ctx + "/elevator/elevatorProjectPage/getElevatorGroupData?typeCode=" + typeCode + "&projectId=" + projectId,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				var returnVal = data.RETURN_PARAM;
				var elevators = returnVal.elevators
				if (elevators >= 10000) {
					elevators = elevators / 10000;
					elevators = Math.floor(elevators * 100) / 100
				} else {
					$("#allElevators").next().hide();
				}
				$("#allElevators").html(elevators);

			} else {
				console.log("提示信息："+data.MESSAGE);
// showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

function setFireFighting(data) {
	if (data.masterTotal >= 10000) {
		$("#master_total").html((data.masterTotal / 10000).toFixed(2));
		$("#master_total_unit").html("万");
	} else {
		$("#master_total").html(data.masterTotal);
		$("#master_total_unit").html("");
	}

	if (data.masterAbnormal >= 10000) {
		$("#master_abnormal").html((data.abnormalTotal / 10000).toFixed(2));
		$("#master_abnormal_unit").html("万");
	} else {
		$("#master_abnormal").html(data.abnormalTotal);
		$("#master_abnormal_unit").html("");
	}

	if (data.masterFires >= 10000) {
		$("#master_fires").html((data.firesTotal / 10000).toFixed(2));
		$("#master_fires_unit").html("万");
	} else {
		$("#master_fires").html(data.firesTotal);
		$("#master_fires_unit").html("");
	}
	var normalCount=data.masterTotal-data.abnormalTotal-data.firesTotal;
	var abnormalCount=data.abnormalTotal+data.firesTotal;
	deviceStateData("FIRE_FIGHTING",normalCount,abnormalCount);
}

// 能耗统计一栏数据展示
function energyConsumptionTotal() {
	var month = new Date().getMonth();
	if (month == "1") {
		month = "一月";
	} else if (month == "2") {
		month = "二月";
	} else if (month == "3") {
		month = "三月";
	} else if (month == "4") {
		month = "四月";
	} else if (month == "5") {
		month = "五月";
	} else if (month == "6") {
		month = "六月";
	} else if (month == "7") {
		month = "七月";
	} else if (month == "8") {
		month = "八月";
	} else if (month == "9") {
		month = "九月";
	} else if (month == "10") {
		month = "十月";
	} else if (month == "11") {
		month = "十一月";
	} else if (month == "0") {
		month = "十二月";
	}
	$("#power_supply_month").html(month);

	var powerSupplyDate = today;
	$.ajax({
				type : "post",
				url : ctx + "/power-supply/pdsElectricityProjectMonthly/energyConsumptionTotal?powerSupplyDate="+ powerSupplyDate,
				data : "",
				success : function(data) {
					if (data.code == 0) {
						var result = data.data.projectMonthlyVO;
						var y =0;
						for ( var i in result) {
							var projectName = result[i].projectName;
							if(projectName!=null && projectName!=""){
								var thisYearMonthlyConsumption
								if(result[i].thisYearMonthlyConsumption=="--"){
									thisYearMonthlyConsumption= result[i].thisYearMonthlyConsumption;
								}else{
									thisYearMonthlyConsumption= result[i].thisYearMonthlyConsumption+"kwh";
								}
							var comparison = result[i].comparison;
							var trContent = "<tr style='height:22px;'><td style='font-size: 12px;color: #FFFFFF;letter-spacing: 0;opacity: 0.5;text-align: left; width: 30%; padding-left: 20px;padding-top:10px;'>"
									+ projectName
									+ "</td><td style='font-size: 12px;color: #FFFFFF;letter-spacing: 0;opacity: 0.5;text-align: center;padding-top:10px;'>"
									+ thisYearMonthlyConsumption
									+ "</td><td id=Comparison"
									+ i
									+ " style='text-align: center; padding-left: 8px;font-size: 12px;color: #FFFFFF;letter-spacing: 0;opacity: 0.5;padding-top:10px;'>"
									+ comparison
									+ "</td><td id=td"
									+ i
									+ " style='padding-top:10px;'>"
									+ "<img id=img"
									+ i
									+ " src=''></td></tr>"
							$("#power-supply").append(trContent);
							if (comparison != "--") {
								$("#Comparison" + i).html(changeTwoDecimal_f(Math.abs(comparison))+"%");
								if (comparison > 0) {// 上涨
									$("#img" + i).attr('src',ctx + '/static/group/shangsheng.svg');
								} else if (comparison == 0) {// 持平
									$("#img" + i).attr('src',ctx + '/static/group/pingdeng.svg');
								} else if (comparison < 0) {// 下降
									$("#img" + i).attr('src',ctx + '/static/group/xiajiang.svg');
								}
							} else {
								$("#td" + i).hide();
								$("#Comparison" + i).css("text-align","center");
							}
							// 最多展示三条数据
							if(y==2){
								break;
							}
							y++;
						}
						}
						// 查询设备数据，调用设备监控总数的方法
						var deviceNum = powerSupplyDevcieNum();
						var alarmDeviceNum = powerSupplyAlarmDeviceNum();
						var normalNum =deviceNum-alarmDeviceNum;
						if(normalNum<0){
							normalNum=0;
						}
						deviceStateData("POWER_SUPPLY",normalNum,alarmDeviceNum);
					} else {
						console.log("操作错误："+data.MESSAGE);
// showDialogModal("error-div", "操作错误", data.MESSAGE);
						return false;
					}
				},
				error : function(req, error, errObj) {
					console.log("操作错误，获取数据失败："+errObj);
// showDialogModal("error-div", "操作错误", "获取数据失败：" + errObj);
					return false;
				}
			});
}

// 数字强制补0
function changeTwoDecimal_f(x)    
{    
　　var f_x = parseFloat(x);    
　　if (isNaN(f_x))    
　　{    
　　　　return 0;    
　　}    
　　var f_x = Math.round(x*100)/100;    
　　var s_x = f_x.toString();    
　　var pos_decimal = s_x.indexOf('.');    
　　if (pos_decimal < 0)    
　　{    
　　　　pos_decimal = s_x.length;    
　　s_x += '.';    
　　}    
　　while (s_x.length <= pos_decimal + 2)    
　　{    
　　　　s_x += '0';    
　　}    
　　return s_x;    
}  
// 统计供配电设备数量
function powerSupplyDevcieNum(){
	var totalNum;
	$.ajax({
		type : "post",
		url : ctx + "/device/manage/getCountBySystemCodeAndProjectCode?systemCode=POWER_SUPPLY&projectCode=ALL",
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		async : false,
		success : function(data) {
			if(data.code==0){
				totalNum = data.data;
			}

		},
		error : function(req, error, errObj) {
			console.log("操作错误："+errObj);
// showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
	return totalNum;
}
function powerSupplyAlarm(data){
	var alarmNum=data.alarmNum;
	var totalNum=powerSupplyDevcieNum();
	var normalNum =totalNum-alarmNum;
	if(normalNum<0){
		normalNum=0;
	}
	deviceStateData("POWER_SUPPLY",normalNum,alarmNum);

}

// 集团首页暖通主机数量推送
function setHvacInfo(data){
	if (data.totalCount < 10000) {
		$("#ten_thousand").hide();
		$("#total_count").html(data.totalCount);
	} else {
		$("#ten_thousand").show();
		$("#total_count").html(
				Math.floor(data.totalCount / 10000 * 100) / 100);
	}
	if(data.groupPageDataChange == true){
	getHvacData(103,'blocks');
	}
}

// 统计供配电告警设备数量
function powerSupplyAlarmDeviceNum(){
	var alarmNum;
	$.ajax({
		type : "post",
		url : ctx + "/power-supply/supplyPowerMain/getCountAlarmDevice",
		dataType : "json",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if(data.code==0){
				alarmNum = data.data;
			}
		},
		error : function(req, error, errObj) {
			console.log("操作错误："+errObj);
// showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
	return alarmNum;
}

function hvac() {
	$.ajax({
		type : "post",
		url : ctx + "/hvac/hvacHomeInformationQuery/projectGroup",
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.totalCount < 10000) {
				$("#ten_thousand").hide();
				$("#total_count").html(data.totalCount);
			} else {
				$("#total_count").html(
						Math.floor(data.totalCount / 10000 * 100) / 100);
			}
			var normalCount=data.groupTotalCount-data.faultCount;
			var abnormalCount=data.faultCount;
			deviceStateData("HVAC",normalCount,abnormalCount);
		},
		error : function(req, error, errObj) {
			console.log("操作错误："+errObj);
// showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
}
function getHvacData(id, divId) {
	$.ajax({
		type : "post",
		url : ctx + "/report/" + id,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var obj = echarts.init(document.getElementById(divId));
			obj.setOption($.parseJSON(data));
			// appendDiv("blocks", data)
		},
		error : function(req, error, errObj) {
		}
	});
	// flushDeviceGrid = setTimeout("getData(103,'blocks')", 10000);
}

// 获取给排水设备总数和排水设备总数
function supplyDrainData() {
	  $.ajax({
	        type : "post",
	        url : ctx + "/supply-drain/supplyDrainMain/getSdmGroupData",
	        dataType : "json",
	        contentType : "application/json;charset=utf-8",
	        success : function(data) {
		        if( data.code==0&&data.data!=null){
		        	var result  = data.data;
		        		$("#id_sdm_error").html(result.deviceAlarmNum);
		        		$("#supple_device_numer").html(result.supplyDeviceNum);
		        		$("#drain_device_numer").html(result.drainDeviceNum);
		        		deviceStateData("SUPPLY_DRAIN",result.normalNum,result.deviceAlarmNum);
		        }else{
		        	 deviceStateData("SUPPLY_DRAIN",0,0);
		        }
	        },
	        error : function(req,error, errObj) {
	            return;
	            }
	        });
}

// 给排水-接收到websoket改变排水信息
function updateSdmInfo(result){
	$("#id_sdm_error").html(result.deviceAlarmNum);
	$("#supple_device_numer").html(result.supplyDeviceNum);
	$("#drain_device_numer").html(result.drainDeviceNum);
	 deviceStateData("SUPPLY_DRAIN",result.normalNum,result.deviceAlarmNum);
	 initSupplyDrainEchart();
}
// 获取饼图echart
function getBingEchart(reportId,divId){
	$.ajax({
		type : "post",
		url :ctx +"/report/"+reportId,
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
// 给排水-初始化饼图信息
function initSupplyDrainEchart() {
	getBingEchart(110,"watersupple_bing");
	getBingEchart(111,"drain_bing");
}
// 停车场模块数据初始化
function getParkingGroupData(){
	  $.ajax({
	        type : "post",
	        url : ctx + "/parking/parkingMain/getParkingGroupData",
	        dataType : "json",
	        contentType : "application/json;charset=utf-8",
	        success : function(data) {
		        if( data.code==0&&data.data!=null){
		        	var result  = data.data;
		        	var dvFalutNum = result.deviceFalutNum;
		        	var dvNormalNum = result.deviceNormalNum;
		        		if(dvFalutNum == null){
		        			$("#parking_deviceFalutNum").html("--"); // 设备异常数
		        			dvFalutNum = 0;
		        		}else{
		        			$("#parking_deviceFalutNum").html(dvFalutNum); // 设备异常数
		        		}
		        	if(dvNormalNum == null){
		        			dvNormalNum = 0;
		        	}
		        		
		        		$("#parking_parkingNum").html(result.parkingNum); // 停车场数
		        		$("#parking_inPassageCarNum").html(result.inPassageCarNum); // 总车流量
		        		$("#parking_visitorCarNum").html(result.visitorCarNum);// 总访客车流量
		        		deviceStateData("PARKING",dvNormalNum,dvFalutNum);
		        }else{
		        	 deviceStateData("PARKING",0,0);
		        }
	        },
	        error : function(req,error, errObj) {
	            return;
	            }
	        });
}


function updateParkingData(result){
	var dvFalutNum = result.deviceFalutNum ;
	if(dvFalutNum == null){
		$("#parking_deviceFalutNum").html("--"); // 设备异常数
		dvFalutNum = 0;
	}else{
		$("#parking_deviceFalutNum").html(dvFalutNum); // 设备异常数
	}
	
	$("#parking_parkingNum").html(result.parkingNum); // 停车场数
	$("#parking_inPassageCarNum").html(result.inPassageCarNum); // 总车流量
	$("#parking_visitorCarNum").html(result.visitorCarNum);// 总访客车流量
	 deviceStateData("PARKING",result.deviceNormalNum,dvFalutNum);
}


function flushAccessControlData() {
	if (typeof (flushAccessControl) != "undefined"
			&& 'undefined' != typeof ($("#group-access-control").val())) {
		getAccessControlData(2);
		flushAccessControl = setTimeout("flushAccessControlData()", 60000);
	}
}

function flushParkingData() {
	if (typeof (flushParking) != "undefined"
			&& 'undefined' != typeof ($("#parking_deviceFalutNum").val())) {
		getParkingGroupData();
		flushParking = setTimeout("flushParkingData()", 60000);
	}
}
