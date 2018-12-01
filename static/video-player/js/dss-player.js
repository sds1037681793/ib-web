/**
参数说明：
width：video对象的宽度
height：video对象的高度
ipAddr：dss ip地址
port：dss端口
username：用户名密码
password：密码
cameraId:channalId 播放通道号
recordSource : 录像来源  2设备 3 平台
startTime:回放开始时间
endTime:回放结束时间
nWndCount:窗口个数
 */
(function($){
	jQuery.fn.dssPlayer = function(options) {
		var defaults = {
			width:"100%",
			height:"100%",
			ipAddr:"",
			port:"9000",
			username:"system",
			password:'123456',
			recordSource:2,
			nWndCount:1
		};
		var options = $.extend(defaults, options);
		var param = {};
		isIE  = !(/(msie\s|trident.*rv:)([\w.]+)/.exec(navigator.userAgent.toLowerCase()) == null);
		
		this.stop = function() {
			innerStop();
			logout();
		}
		this.pause = function() {
			innerStop();
		}
		this.login = function(ipAddr,port,username,password) {
			dssLogin(ipAddr,port,username,password);
		}
		this.play = function(cameraId,startTime,endTime) {
			innerPlay(cameraId,startTime,endTime);
		}
		this.playByWnd = function(nWndNo,cameraId) {
			innerPlayByWnd(nWndNo,cameraId);
		}
		this.replay = function() {
			innerReplay();
		}
		
		this.resize = function(width, height) {
			param.video.prop("width", width);
			param.video.prop("height", height);
		}
		this.setWndCount = function(nWndCount) 
		{
			var obj = document.getElementById("DPSDK_OCX");
		    obj.DPSDK_SetWndCount(options.gWndId, nWndCount); 
			obj.DPSDK_SetSelWnd(options.gWndId, 0); 
		}
		this.ptzDirection = function(nDirect,szCameraId,stop)
		{
			if(options.logined == true){
				console.log("云台nDirect：" + nDirect + szCameraId);
				var obj = document.getElementById("DPSDK_OCX");
				var nStep = 1;//步长 默认1 (1-8)
				var nRet = obj.DPSDK_PtzDirection(szCameraId, nDirect, nStep, stop);
				console.log("云台nRet：" + nRet);
			}
		}
		this.ptzOperation = function(nOper,szCameraId,stop)
		{
			if(options.logined == true){
				console.log("镜头nOper：" + nOper + szCameraId);
				var obj = document.getElementById("DPSDK_OCX");
				var nStep = 1;//倍速 默认1 (1-8)
				var nRet = obj.DPSDK_PtzCameraOperation(szCameraId, nOper, nStep, stop);
				console.log("镜头nRet：" + nRet);
			}
		}
		this.loadDGroupInfo = function() 
		{
			if(options.logined == true){
				console.log("加载组织结构");
				var obj = document.getElementById("DPSDK_OCX");
				obj.DPSDK_LoadDGroupInfo();
				//alert(obj.DPSDK_GetDGroupStr());
			}
		}
		
		return this.each(function() {
			var obj = $(this);
			var divId = obj.attr("id");
			var activeXId = divId + "_ocx";
			options.divId = divId;
			options.activeXId = activeXId;
			if(checkInit()){
				dssLogin(options.ipAddr, options.port, options.username, options.password);
			}
		});
		
		function videoInit() {
			// 创建video对象
			var html = '<div id="' + options.activeXId + '" style="width:'+options.width+';height:'+options.height+';">';
			html += '<object id="DPSDK_OCX" classid="CLSID:D3E383B6-765D-448D-9476-DFD8B499926D" style="width: 100%; height: 99%" codebase="DpsdkOcx.cab#version=1.0.0.0"></object>';
			html += '</div>';
			$("#" + options.divId).html(html);
			
			var obj = document.getElementById("DPSDK_OCX");
		    var gWndId = obj.DPSDK_CreateSmartWnd(0, 0, 100, 100);
		    console.log("初始化"+ obj.DPSDK_GetLastError());
		    options.gWndId = gWndId;
			//设置窗口数量
		    obj.DPSDK_SetWndStyle(1);
		    obj.DPSDK_SetWndCount(gWndId, options.nWndCount); 
			obj.DPSDK_SetSelWnd(gWndId, 0); 
			console.log("初始化完毕");
			//obj.DPSDK_SetLog(2, "D:\\DPSDK_OCX_log", false, false); //初始化后设置日志路径
			//var obj = document.getElementById("DPSDK_OCX");
			//ShowCallRetInfo(obj.DPSDK_Login("172.7.123.123", 9000, "1", "1"), "登录");
			//ShowCallRetInfo(obj.DPSDK_AsyncLoadDGroupInfo(), "异步加载组织结构");
			//var nWndNo = obj.DPSDK_GetSelWnd(gWndId);
			//ShowCallRetInfo(obj.DPSDK_DirectRealplayByWndNo(gWndId, nWndNo, "1000001$1$0$0", 1, 1, 1), "直接实时播放");
			/*for(var i=1;i<=4;i++)
			    obj.DPSDK_SetToolBtnVisible(i, false);
			obj.DPSDK_SetToolBtnVisible(7, false);
			obj.DPSDK_SetToolBtnVisible(9, false);*/
			obj.DPSDK_SetControlButtonShowMode(1, 0);
			obj.DPSDK_SetControlButtonShowMode(2, 0);
		}
		
		function checkInit(){
			try
			{
				var obj = new ActiveXObject("DPSDK_OCX.DPSDK_OCXCtrl.1");
			}
			catch(e)
			{
				options.inited = false;
				console.log(e);
				var szInfo = "控件未注册，请先注册控件！";
				showDialogModal("error-div", "操作提示", szInfo, 2, "downloadOCX()");
				return false;
			}
			options.inited = true;
			videoInit();
			return true;
		}
		
		
		function innerStop() {
			if(options.inited == true){
				var obj = document.getElementById("DPSDK_OCX");
				var nWndNo = obj.DPSDK_GetSelWnd(options.gWndId);
				if(options.backPlay){
					obj.DPSDK_StopPlaybackByWndNo(options.gWndId, nWndNo);
				}else{
				    obj.DPSDK_StopRealplayByWndNo(options.gWndId, nWndNo);
				}
				
			}
		}
		function logout(){
			if(options.inited == true){
				var obj = document.getElementById("DPSDK_OCX");
				var nRet =  obj.DPSDK_Logout();
				console.log("登出nRet：" + nRet);
			}
		}
		function dssLogin(ipAddr,port,username,password){
			if(options.inited == false){
				return;
			}
			if(typeof(ipAddr) == 'undefined' || ipAddr == ''){
				return;
			}
			console.log("登陆"+ ipAddr+ port+ username+ password);
			var obj = document.getElementById("DPSDK_OCX");
			var nRet = obj.DPSDK_Login(ipAddr, port, username, password);
			console.log("登陆nRet：" + nRet);
			if(nRet == 0)
			{
				options.logined = true;
				return true;
			}else{
				//alert("登录失败");
				if(typeof(showDModal) == 'function')
				showDModal("登录失败");
			}
			options.logined = false;
			return false;
		}
		function innerPlay(cameraId,startTime,endTime){
			if(options.logined == true)
			{
				var obj = document.getElementById("DPSDK_OCX");
				var nWndNo = obj.DPSDK_GetSelWnd(options.gWndId);
				if(typeof(startTime) != 'undefined' && startTime != null){
					options.backPlay == true
					var nStartTime = getDate(startTime).getTime()/1000;
					var nEndTime = getDate(endTime).getTime()/1000;
					console.log("回放:" + cameraId + "时间:" + startTime + "------" + endTime);
					var record = obj.DPSDK_QueryRecordInfo(cameraId, options.recordSource,0, nStartTime, nEndTime)
					console.log(record);
					if(record != null && record != '' && record.indexOf('count="0"') == -1){
						var nsRet = obj.DPSDK_StartTimePlaybackByWndNo(options.gWndId, nWndNo, cameraId, options.recordSource, nStartTime, nEndTime);
						console.log("回放：" + nsRet);
						if(nsRet != 0 && typeof(showDModal) == 'function')
							showDModal("回放失败");
					}else{
						if(nsRet != 0 && typeof(showDModal) == 'function')
							showDModal("回放失败录像不存在");
					}
				}else{
					var nStreamType = 1;// 1主码流 2副码流
					var nMediaType = 1;// 1视频 2音频 3视频+音频
					var nTransType = 1;//1 tcp 2udp
					console.log("播放：" + cameraId);
					var nsRet =  obj.DPSDK_StartRealplayByWndNo(options.gWndId, nWndNo, cameraId, nStreamType, nMediaType, nTransType);
					console.log("播放：" + nsRet);
					if(nsRet != 0 && typeof(showDModal) == 'function')
						showDModal("播放失败");
				}
			}
		}
		
		function innerPlayByWnd(wndNo,cameraId){
			if(options.logined == true)
			{
				var obj = document.getElementById("DPSDK_OCX");
				var nStreamType = 1;// 1主码流 2副码流
				var nMediaType = 1;// 1视频 2音频 3视频+音频
				var nTransType = 1;//1 tcp 2udp
				console.log(wndNo + "播放：" + cameraId);
				var nsRet =  obj.DPSDK_StartRealplayByWndNo(options.gWndId, wndNo, cameraId, nStreamType, nMediaType, nTransType);
				console.log("播放：" + nsRet);
				if(nsRet != 0 && typeof(showDModal) == 'function')
					showDModal("播放失败");
			}
		}
		
		function innerReplay() {
		}
		
		function getDate(strDate) 
		{
			var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,
			function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
			return date;
		}
	}
	
})(jQuery);

function downloadOCX() {
    if(ctx){
        window.open(ctx + "/static/plugin/DPSDK_OCX_Win32andWin64.exe", "_self");
    }else{
        window.open("static/plugin/DPSDK_OCX_Win32andWin64.exe", "_self");
    }
}