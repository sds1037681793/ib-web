<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>

<html>
<head>
<title></title>
</head>
<body>
	<div id="divPlugin" style="overflow: hidden;"></div>
	<div id="divRtsp" style="margin: -8px;overflow: hidden;"></div>
	<div id="error-div"></div>
	<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="${ctx}/static/video-player/js/webVideoCtrl.js"></script>
	<script type="text/javascript"
		src="${ctx}/static/video-player/js/video-player.js"></script>
	<script type="text/javascript">
		var videoParam;
		var videoHeight = "${param.height}";
		var videoWidth = "${param.width}";
		var showDialogModal = window.parent.showDialogModal;
		$(document).ready(function() {
			//页面加载完成后调用父页面回调
			if(typeof(window.parent.callbackLoadVideo) == "function"){
				window.parent.callbackLoadVideo();
			}
			// 关闭浏览器
	 		$(window).unload(function () {
	 			closeVideo();
	 		});
		});
		//获取摄像机播放参数
		function getVideoInfo(deviceId){
			$.ajax({
				type : "post",
				url : "${ctx}/video-monitoring/video/param?deviceId=" + deviceId,
				dataType : "json",
				async: false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if(data && data.isUseNvr != 0){
						if(data && data.rtspUrl) {
							data.isUseNvr = 1;
						}
						videoParam = data;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		}
		//根据摄像机参数选择类型播放
		function startPlay(deviceId){
			getVideoInfo(deviceId);
			if(videoParam){
				console.log("播放类型：" + videoParam.isUseNvr);
				if(videoParam.isUseNvr == 2){
					var divPluginTimer = setInterval(function () {
						if(!$("#divPlugin").height()){
							console.log("divPlugin加载完毕");
							clearInterval(divPluginTimer);
							nvrPlay();
						}
					}, 500);
				}else if(videoParam.isUseNvr == 1){
					rtspPlay();
				}
			}
		}
		//rtsp播放视频
		function rtspPlay(){
			if(videoParam && videoParam.rtspUrl){
				console.log("rtsp播放：" + videoParam.rtspUrl);
				$("#divRtsp").videoPlayer({url: videoParam.rtspUrl, type: "1", height: videoHeight + "px", rtsptcp: true});
			}
		}
		//nvr播放视频
		function nvrPlay() {
			// 检查插件是否已经安装过
			console.log("检查插件");
			var iRet = WebVideoCtrl.I_CheckPluginInstall();
			if (-2 == iRet) {
				showDialogModal("error-div", "操作提示", "您的Chrome浏览器版本过高，不支持NPAPI插件（安装时请将浏览器关闭）！", 1);
				return;
			} else if (-1 == iRet) {
				var szInfo = "您还未安装过插件，请下载WebComponentsKit.exe安装！";
				showDialogModal("error-div", "操作提示", szInfo, 2, "window[0].downloadexe()");
				return;
			}
			nvrPluginInit();
			console.log(videoParam.nvrIp + "=" + videoParam.nvrPort + "=" + videoParam.nvrUserName + "=" + videoParam.nvrPassword + "=" + videoParam.nvrChannel);
			var oLiveView = {
				iProtocol : 1, // protocol 1：http, 2:https
				szIP : videoParam.nvrIp, // protocol ip
				szPort : videoParam.nvrPort, // protocol port
				szUsername : videoParam.nvrUserName, // device username
				szPassword : videoParam.nvrPassword, // device password
				iStreamType : 1, // stream 1：main stream  2：sub-stream  3：third stream  4：transcode stream
				iChannelID : videoParam.nvrChannel, // channel no
				bZeroChannel : false
			// zero channel
			};
			// 登录设备
			WebVideoCtrl.I_Login(oLiveView.szIP, oLiveView.iProtocol, oLiveView.szPort, oLiveView.szUsername, oLiveView.szPassword, {
				success : function(xmlDoc) {
					console.log("登陆成功");
					var playFailedCount = 0;
					var timer = setInterval(function () {
						playFailedCount = playFailedCount + 1;
						console.log("进入定时器");
						// 开始预览
						var iRet = WebVideoCtrl.I_StartRealPlay(oLiveView.szIP, {
							iWndIndex : 0,
							iStreamType : oLiveView.iStreamType,
							iChannelID : oLiveView.iChannelID,
							bZeroChannel : oLiveView.bZeroChannel
						});
						console.log("播放返回值：" + iRet);
						if (0 == iRet){
							clearInterval(timer);
							playFailedCount = 0;
							console.log("关闭定时器");
						}else{
							if (playFailedCount >= 5){
								clearInterval(timer);
								playFailedCount = 0;
								var ret = WebVideoCtrl.I_Stop();
								console.log(new Date() + "停止播放" + ret);
								var logout = WebVideoCtrl.I_Logout(videoParam.nvrIp);
								console.log(new Date() + "退出登录" + logout);
								$("#divPlugin").html("");
								nvrPlay();
							}
						}
					}, 800);
					
				},
				error : function(a, b) {
					console.log("登陆失败：" + a);
				}
			});
		}
		//关闭视频
		function closeVideo() {
			console.log("关闭视频");
			if (videoParam && videoParam.isUseNvr == 1) {
				$("#divRtsp").html("");
			} else if (videoParam && videoParam.isUseNvr == 2) {
				var ret = WebVideoCtrl.I_Stop();
				console.log(new Date() + "停止播放" + ret);
				var logout = WebVideoCtrl.I_Logout(videoParam.nvrIp);
				console.log(new Date() + "退出登录" + logout);
				$("#divPlugin").html("");
			}
			videoParam = null;
		}
		function nvrPluginInit(){
			var oPlugin = {
				iWidth : videoWidth, // plugin width
				iHeight : videoHeight // plugin height
			};
			// 初始化插件参数及插入插件
			WebVideoCtrl.I_InitPlugin(oPlugin.iWidth, oPlugin.iHeight, {
				bWndFull : true,//是否支持单窗口双击全屏，默认支持 true:支持 false:不支持
				iWndowType : 1,
				cbSelWnd : function(xmlDoc) {

				}
			});
			WebVideoCtrl.I_InsertOBJECTPlugin("divPlugin");
			console.log("nvrPlugin：初始化成功!");
		}
		
		/**
	     * 下载插件
	     */
	    function downloadexe() {
	        window.open("static/plugin/WebComponentsKit(has rem cfg).exe", "_self");
	    }
	</script>
</body>
</html>