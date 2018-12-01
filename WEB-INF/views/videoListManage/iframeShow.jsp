<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/video-player/js/webVideoCtrl.js"></script>
<script type="text/javascript" src="${ctx}/static/video-player/js/video-player.js"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<div id="divPlugin" style="overflow: hidden;"></div>
<div id="divRtsp" style="overflow: hidden;"></div>
<div id="error-div"></div>
</div>
<script>
    var videoParam = {};
	var videoHeight = "${param.height}";
	var videoWidth = "${param.width}";
    var nvrChannel = parent.channel;
    var ctx = "${ctx}";
    $(document).ready(function () {
    	startPlay(parent.deviceId);
	     // 关闭浏览器
	     $(window).unload(function () {
	    	 closeVideo();
	     });
    });

  	//根据摄像机参数选择类型播放
	function startPlay(deviceId){
		getVideoInfo(deviceId);
	}
  	//获取摄像机播放参数
	function getVideoInfo(deviceId){
        $.ajax({
            type : "post",
            url : "${ctx}/device/manage/getUrl/" + deviceId + "?CHECK_AUTHENTICATION=false",
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.CODE && data.CODE == "SUCCESS") {
                    console.log("rtsp播放：" + data.RETURN_PARAM);
                    $("#divRtsp").videoPlayer({
                        url : data.RETURN_PARAM,
                        type : "1",
                        width : videoWidth + "px",
                        height : videoHeight + "px",
                        rtsptcp : true
                    });
                } else {
                    getNvrInfo(deviceId);
                }
            },
            error : function(req, error, errObj) {
            }
        });
	}
  	
	//nvr播放视频
	function nvrPlay() {
		// 检查插件是否已经安装过
		console.log("检查插件");
		var iRet = WebVideoCtrl.I_CheckPluginInstall();
		if (-2 == iRet) {
			showTips("您的浏览器版本过高，不支持NPAPI插件", "");
			return;
		} else if (-1 == iRet) {
			var szInfo = "您还未安装过插件，请下载WebComponentsKit.exe安装！";
			showTips(szInfo, "downloadexe()");
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
				var timer = setInterval(function() {
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
					if (0 == iRet) {
						clearInterval(timer);
						playFailedCount = 0;
						console.log("关闭定时器");
					} else {
						if (playFailedCount >= 5) {
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

	function nvrPluginInit() {
		var oPlugin = {
			iWidth : videoWidth, // plugin width
			iHeight : videoHeight
		// plugin height
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

	function getNvrInfo(deviceId) {
        $.ajax({
            type: "post",
            url: "${ctx}/device/manage/getNVR/" + deviceId +"?CHECK_AUTHENTICATION=false",
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            async: false,
            success: function (data) {
                if(data && data.RETURN_PARAM && data.CODE && data.CODE == "SUCCESS"){
                    var NVR = data.RETURN_PARAM;
                    $(videoParam).attr({
                        isUseNvr : NVR.type,
                        nvrIp : NVR.nvrvoList[0].host,
                        nvrPort : NVR.nvrvoList[0].port,
                        nvrUserName : NVR.nvrvoList[0].username,
                        nvrPassword : NVR.nvrvoList[0].password,
                        nvrChannel : nvrChannel
                    });
                } else {
                    showDialogModal("error-div", "操作错误", data.MESSAGE);
                    return;
                }
                //播放nvr
                var divPluginTimer = setInterval(function () {
                    if(!$("#divPlugin").height()){
                        console.log("divPlugin加载完毕");
                        clearInterval(divPluginTimer);
                        nvrPlay();
                    }
                }, 500);
            },
            error : function(req, error, errObj) {
            }
        });
	}
	//关闭视频
	function closeVideo() {
		console.log("关闭视频");
		if (videoParam && videoParam.isUseNvr == 1) {
			var ret = WebVideoCtrl.I_Stop();
			console.log(new Date() + "停止播放" + ret);
			var logout = WebVideoCtrl.I_Logout(videoParam.nvrIp);
			console.log(new Date() + "退出登录" + logout);
			$("#divPlugin").html("");
		}else{
			$("#divRtsp").html("");
		}
		videoParam = null;
	}
	function showTips(szInfo,click){
		$("#error-div").html("<label name='laPlugin' onclick='"+click+";' style='width:"+ videoWidth +"px;'>" + szInfo + "</label>");
		$("#error-div").css({"margin-top":"30%"});
	}
	/**
	 * 下载插件
	 */
	function downloadexe() {
		window.open("${ctx}/static/plugin/WebComponentsKit(has rem cfg).exe", "_self");
	}
</script>