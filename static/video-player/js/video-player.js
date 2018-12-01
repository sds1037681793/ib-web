/**
参数说明：
以下为公用参数
width：video对象的宽度
height：video对象的高度
url：视频的访问地址
type:播放器类型，1：VLC 2：海康自带播放器 3：HTML5控件

以下为海康单独使用参数
ipAddr：兼容海康原来的播放组件，ip地址
rtspPort：兼容海康原来的播放组件，rtsp端口
ciphertext：兼容海康原来的播放组件，用户名密码
streamType：兼容海康原来的播放组件，流类型

以下为HTML5单独使用的参数
autoplay：是否自动播放，true自动播放；默认true
videotype：视频类型，ogg/webm/mp4，默认ogg
playbackrate：视频播放速率，默认1.1（针对实时视频流，普通视频请设置为1）
controller：是否显示控制条，默认不显示
preventcontextmenu：是否屏蔽右键菜单，默认屏蔽

方法说明：
play()：重新加载并播放视频
stop()：停止播放视频
replay()：视频重播
resize(width, height)：修改video对象的宽度和高度
 */
(function($){
	jQuery.fn.videoPlayer = function(options) {
		var defaults = {
			width:"100%",
			height:"100%",
			url:"",
			type:"",
			rtsptcp:false,
			rtsp:{
				ipAddr:"",
				rtspPort:"554",
				ciphertext:"",
				streamType:0
			},
			video:{
				autoplay: true,
				videotype: "ogg",
				playbackrate: 1.1,
				controller: false,
				preventcontextmenu: true
			}
		};
		var options = $.extend(defaults, options);
		var param = {};
		isIE  = !(/(msie\s|trident.*rv:)([\w.]+)/.exec(navigator.userAgent.toLowerCase()) == null);
		param.ipAddr = options.rtsp.ipAddr;
		param.rtspPort = options.rtsp.rtspPort;
		param.url = options.url;
		param.httpPort = 80;
		param.protocolType = 0;
		param.streamType = options.rtsp.streamType;
		param.ciphertext = options.rtsp.ciphertext;
		param.type = options.type;
		param.HWP = null;
		param.previewOCX = null;
		
		this.stop = function() {
			innerStop();
		}
		this.play = function() {
			innerPlay();
		}
		this.replay = function() {
			innerReplay();
		}
		
		this.resize = function(width, height) {
			param.video.prop("width", width);
			param.video.prop("height", height);
		}
		
		return this.each(function() {
			var opts = options;
			var obj = $(this);
			var divId = obj.attr("id");
			var activeXId = divId + "_ocx";
			param.divId = divId;
			param.activeXId = activeXId;
			if(opts.rtsp.rtspPort == null || opts.rtsp.rtspPort == "" || typeof(opts.rtsp.rtspPort) == "undifined") {
				param.rtspPort = 554;
			}
			
			if(isIPv6Add(opts.ipAddr)){
				opts.rtsp.ipAddr = "[" + opts.rtsp.ipAddr + "]";
			}
			
			if("2" == param.type) {
				param.HWP = null;
				param.HWP = new Plugin(1, opts.rtsp.ipAddr, param.httpPort, opts.rtsp.rtspPort,divId,activeXId);
				
			} 
			if("2" == param.type || "1" == param.type) {
				if(!checkPlugin('2', "请点击此处下载插件，安装时请关闭浏览器", 1,divId,activeXId,param)) {
					$(this).attr("style", "text-align:center;background-color:#343434;");
					$(this).attr("class", "embed-responsive embed-responsive-4by3");
					return;
				}
			} else if("3") {
				$(this).attr("style", "text-align:center;background-color:#343434;");
				$(this).attr("class", "embed-responsive embed-responsive-4by3");
			}
			
			if("2" == param.type) {
				param.previewOCX=document.getElementById(activeXId);
				//设置基本信息
				var szInfo = '<?xml version="1.0" encoding="utf-8"?><Information><WebVersion><Type>ipc</Type><Version>3.1.2.120416</Version><Build>20120416</Build></WebVersion><PluginVersion><Version>3.0.3.5</Version><Build>20120416</Build></PluginVersion><PlayWndType>0</PlayWndType></Information>';
				try {
					param.previewOCX.HWP_SetSpecialInfo(szInfo, 0);
				} catch(e) {	
				}
				var szPathInfo = '';
				try {
					szPathInfo = param.previewOCX.HWP_GetLocalConfig();
				} catch(e) {
					szPathInfo = param.previewOCX.GetLocalConfig();
				}
				var xmlDoc = parseXmlFromStr(szPathInfo);
				param.protocolType = parseInt($(xmlDoc).find("ProtocolType").eq(0).text(), 10);
			}
			
			//isReach();
			playNoIsReach();
		});
		
		function isReach() {
			var ip = "";
			var port = "";
			if(param.url != null && param.url !='null' && param.url != '' && typeof(param.url) != 'undefined'){
				var postString = "";
				if(param.url.indexOf("@") > 0){
				  postString = param.url.substring(param.url.indexOf("@") + 1);
				} else {
				  postString = param.url.substring(7);
				}
				var ipPort = postString.substring(0,postString.indexOf("/"));
				if(ipPort.indexOf(":") > 0){
				  ip = ipPort.split(":")[0];
				  port = ipPort.split(":")[1];
				}
				else {
				  ip = ipPort;
				  port = 554;
				}
			} else {
				//如果rtsp地址为空，但是又是vlc播放方式，将不再继续执行
				if(param.type == "1" || param.type == "3") {
					$('#' + param.divId).attr("style", "text-align:center;background-color:#343434;");
					console.error("播放地址为空");
					return;
				}
				ip = param.ipAddr;
				port = param.rtspPort;
			}
			$.ajax({
                method: "post",
                url: ctx + "/passage/isReachable?hostname=" + ip + "&port=" + port,
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                success: function(data) 
                {
                    if (data && data.CODE && data.CODE == "SUCCESS") 
                    {
                    	//VLC模式下，需要等待页面组建初始化完成之后才能开始播放
                    	if(param.type == "1") {
            				var intervalId = setInterval(checkIsReady,200);
            				param.intervalId = intervalId;
            			} else if(param.type == "2"){
            				innerPlay();
            			} else if(param.type == "3") {
            				videoInit();
            			}
                    	
                    	//由于html5video可以控制是否手工触发播放和暂停，所以这里对暂停时自动触发播放的定时器不予执行
                    	if(param.type == "3") {
                    		return ;
                    	}
            			var detectionId = setInterval(innerReplay,20000);
            			param.detectionId = detectionId;
                    }
                    else
                    {
                    	$('#' + param.divId).attr("style", "text-align:center;background-color:#343434;");
                    }
                },
                error: function(req,error,errObj) 
                {
                    $('#' + param.divId).attr("style", "text-align:center;background-color:#343434;");
                }
            });
			
		}
		
		function playNoIsReach() {
			//VLC模式下，需要等待页面组建初始化完成之后才能开始播放
        	if(param.type == "1") {
				var intervalId = setInterval(checkIsReady,200);
				param.intervalId = intervalId;
			} else if(param.type == "2"){
				innerPlay();
			} else if(param.type == "3") {
				videoInit();
			}
        	
        	//由于html5video可以控制是否手工触发播放和暂停，所以这里对暂停时自动触发播放的定时器不予执行
        	if(param.type == "3") {
        		return ;
        	}
			var detectionId = setInterval(innerReplay,20000);
			param.detectionId = detectionId;
		}
		
		function videoInit() {
			// 创建video对象
			var html = '<div>';
			html += '<video class="vp-class" width="' + options.width + '" height="' + options.height + '" src="'+ options.url + '" type="video/' + options.video.videotype + '" autoplay="' + (options.video.autoplay ? "autoplay" : "") + '"></video>';
			if (options.controller) {
				html += '<div class="vp-ctrl-class" style="width: ' + options.width + 'px; top: ' + (options.height - 30) + 'px; height: 30px; background-color: #000; margin-top: -6px; margin-bottom: 5px; padding-top: 6px; padding-left: 10px;">';
				html += '<a class="vp-play-class"><span class="glyphicon glyphicon-play" style="color: #fff; font-size: 14px; padding-right: 5px; cursor: pointer;"></span></a>';
				html += '<a class="vp-stop-class"><span class="glyphicon glyphicon-stop" style="color: #fff; font-size: 14px; cursor: pointer;"></span></a>';
				html += '</div>';
			}
			html += '</div>';
			$("#" + param.divId).html(html);

			_video = $("#" + param.divId).find(".vp-class");
			param.video = _video;
			
			// 设置播放速率
			_video[0].playbackRate = options.video.playbackrate;

			// 监听video对象事件
			_video.on("abort", function() {
				console.info("aborted");
			}).on("ended", function() {
				console.info("ended");
				_video[0].load();
			}).on("error", function() {
				console.info("error");
				_video[0].load();
			}).on("pause", function() {
				console.info("pause");
			}).on("play", function() {
				console.info("play");
			}).on("playing", function() {
				console.info("playing");
			}).on("waiting", function() {
				console.info("waiting");
			}).on("canplay", function() {
				console.info("canplay");
			}).on("progress", function() {
				console.info("progress");
			});

			if (options.video.preventcontextmenu) {
				_video.bind("contextmenu", function(e) {
					return false;
				});
			}

			// 控制条事件注册
			if (options.video.controller) {
				$(this).find(".vp-play-class").click(function() {
					_video[0].load();
				});
				$(this).find(".vp-stop-class").click(function() {
					_video[0].pause();
				});
			}
		}
		
		
		
		function checkIsReady() {
			try{
				var vlc = getVLC(param.activeXId);
				var opts = new Array();
				if(options.rtsptcp) {
					opts.push("rtsp-tcp");
				}
	            var itemId = vlc.playlist.add(param.url,"rtsp stream name", opts);
				//var itemId = vlc.playlist.add(mrl);
				vlc.video.logo.delay = 0;
				vlc.playlist.playItem(itemId);
				var intervalId = param.intervalId;
				$("#" + param.activeXId).css("width",options.width);
				$("#" + param.activeXId).css("height",options.height);
				if(intervalId != null && intervalId !='' && typeof(intervalId) != 'undefined' && intervalId != "0") {
					window.clearInterval(intervalId);
				}
			}catch (e){
			}
		}
		
		
		function innerStop() {
			if(param.type == "1") {
				var vlc = getVLC(param.activeXId);
				if(typeof(vlc) != 'undefined' && typeof(vlc.playlist) != 'undefined') {
					vlc.playlist.stop();
				}
			} else if(param.type == "2"){
				if(param.HWP.Stop(0) != 0) {
					console.log("预览失败:" + iError + ",服务器：" + options.ipAddr)
					return;
				}
				param.HWP.wnds[0].isPlaying = false; // 可去掉
				//this.m_bChannelRecord = false;
				if(param.previewOCX != null) {
					param.previewOCX.HWP_DisableZoom(0);
				}
			} else if(param.type == "3") {
				param.video[0].pause();
			}
			
			var intervalId = param.intervalId;
			if(intervalId != null && intervalId !='' && typeof(intervalId) != 'undefined' && intervalId != "0") {
				window.clearInterval(intervalId);
			}
			var detectionId = param.detectionId;
			if(detectionId != null && detectionId !='' && typeof(detectionId) != 'undefined' && detectionId != "0") {
				window.clearInterval(detectionId);
			}
			
		}
		
		function innerPlay(){
			if(param.type == "1") {
				var vlc = getVLC(param.activeXId);
				var opt = new Array("rtsp-tcp");
				var itemId = vlc.playlist.add(param.url, "rtsp stream name", opt);
				//var itemId = vlc.playlist.add(mrl);
				vlc.video.logo.delay = 0;
				vlc.playlist.playItem(itemId);
				$("#" + param.activeXId).css("width",options.width);
				$("#" + param.activeXId).css("height",options.height);
			} else if (param.type == "2"){
				if(!param.HWP.wnds[0].isPlaying) {
					var szURL = "";
					if(param.url != null && param.url !='null' && param.url != '' && typeof(param.url) != 'undefined'){
						szURL = param.url;
					} else {
						if(param.protocolType == 4) {
							if(param.streamType == 0) {
								szURL = "rtsp://" + param.ipAddr+ ":" + param.httpPort + "/PSIA/streaming/channels/101";
							} else {
								szURL = "rtsp://" + param.ipAddr+ ":" + param.httpPort + "/PSIA/streaming/channels/102";
							}
						} else {
							if(param.streamType == 0) {
								szURL = "rtsp://" + param.ipAddr+ ":" + param.rtspPort + "/PSIA/streaming/channels/101";
							} else {
								szURL = "rtsp://" + param.ipAddr+ ":" + param.rtspPort + "/PSIA/streaming/channels/102";
							}
						}
					}
					
					var iError = 0;
					for(var i=0; i<3; i++)
					{
						var returncode = param.previewOCX.HWP_Play(szURL, param.ciphertext, 0, "", "");
						iError = param.previewOCX.HWP_GetLastError();
						if(returncode != 0) {
							$('#' + param.divId).attr("style", "text-align:center;background-color:#343434;");
							$('#' + param.divId).attr("class", "embed-responsive embed-responsive-4by3");
							
							continue;
						}
						else
						{
							param.HWP.wnds[0].isPlaying = true;
							//this.m_bChannelRecord = false;
							return;
						}
					}
					if(403 == iError) 
					{
						console.log("操作无权限,服务器：" + param.ipAddr)
					}
					else
					{
						console.log("预览失败:" + iError + ",服务器：" + param.ipAddr)
					}
					param.HWP.wnds[0].isPlaying = false;

				} else {
					innerStop();
				}
			} else if(param.type == "3") {
				param.video[0].load();
			}
		}
		
		function innerReplay() {
			if(param.type == "1") {
				var vlc = getVLC(param.activeXId);
				if(!vlc.playlist.isPlaying) {
					innerStop();
					innerPlay();
				}
			} else if (param.type == "2"){
				if(!param.HWP.wnds[0].isPlaying) {
					innerStop();
					innerPlay();
				}
			}
		}
		
		function getVLC(name) {
			if (window.document[name]) {
				return window.document[name];
			}
			if (navigator.appName.indexOf("Microsoft Internet") == -1) {
				if (document.embeds && document.embeds[name])
					return document.embeds[name];
			} else {
				return document.getElementById(name);
			}
		}
		
		function checkPlugin(iType, szInfo, iWndType, divId, activeXId, device, szPlayMode)
		{
			if(param.type == "1") {
				var isInstalled = isInsalledVLC();
				if(!isInstalled) {
					szInfo = "请点击此处下载插件，安装时请关闭浏览器";
					$("#" + divId).html("<label name='laPlugin' style='margin-top: 35%;' onclick='download(\"" + param.type + "\");' class='pluginLink' onMouseOver='this.className =\"pluginLinkSel\"' onMouseOut='this.className =\"pluginLink\"'>"+szInfo+"</label>");
				} else {
					var ele = '<OBJECT classid="clsid:9BE31822-FDAD-461B-AD51-BE1D1C159921" id="' + activeXId + '"'
						+ 'codebase=""'
						+ 'style="left: 0px; top: 0px; width: ' + options.width + '; height: ' + options.height + ';"'
						+ ' events="True">'
						+ '<param name="mrl" value="" />'
						+ '<param name="autoloop" value="false"/>'
						+ '<param name="autoplay" value="false"/>'
						+ '<param name="time" value="true"/>'
						+ '<param name="controls" value="false"/>'
						+ '<EMBED pluginspage="http://www.videolan.org"'
						+ 'type="application/x-vlc-plugin" version="VideoLAN.VLCPlugin.2"'
						+ 'width="' + options.width + '" height="' + options.height + '" text="请稍后" name="' + activeXId + '"></EMBED>'
						+ '</OBJECT>';
					$("#" + divId).html(ele);
					$("#" + activeXId).css('width','99.99%');
					param.video = document.getElementById(activeXId);
				}
				return isInstalled;
			} else {
				if (!isIE)
				{
					if ($("#" + divId).html() !== "" && $("#" + activeXId).length !== 0)
					{
						var iPlayMode = 0;
						switch (szPlayMode)
						{
							case "normal":
								//iPlayMode = 0;
								break;
							case "motiondetect":
								iPlayMode = 1;
								break;
							case "tamperdetect":
								iPlayMode = 2;
								break;
							case "privacymask":
								iPlayMode = 3;
								break;
							case "textoverlay":
								iPlayMode = 4;
								break;
							case "osdsetting":
								iPlayMode = 5;
								break;
							default:
								//iPlayMode = 0;
								break;
						}
						device.HWP.SetPlayModeType(iPlayMode);
						//HWP.ArrangeWindow(parseInt(iWndType));
						return true;
					}
					
					var bInstalled = false;
					for (var i = 0, len = navigator.mimeTypes.length; i < len; i++)
					{
						if (navigator.mimeTypes[i].type.toLowerCase() == "application/hwitcp-webvideo-plugin")
						{
							bInstalled = true;
							if (iType == '0')
							{
							    $("#" + divId).html("<embed type='application/hwitcp-webvideo-plugin' id='" + activeXId + "' width='1' height='1' name='" + activeXId + "' align='center' wndtype='"+iWndType+"' playmode='"+szPlayMode+"'>");
								setTimeout(function() { $("#" + activeXId).css('height','0px'); }, 10); // 避免插件初始化不完全
							}
							else if (iType == '1')
							{
								$("#" + divId).html("<embed type='application/hwitcp-webvideo-plugin' id='" + activeXId + "' width='" + options.width + "' height='" + options.height + "' name='" + activeXId + "' align='center' wndtype='"+iWndType+"' playmode='"+szPlayMode+"'>");
							}
							else
							{
								$("#" + divId).html("<embed style='position:absolute;z-index:0;' type='application/hwitcp-webvideo-plugin' id='" + activeXId + "' width='" + options.width + "' height='" + options.height + "' name='" + activeXId + "' align='center' wndtype='"+iWndType+"' playmode='"+szPlayMode+"'>");
//								$("#iframe2").contents().find("#" + divId).html("<embed type='application/hwitcp-webvideo-plugin' id='" + activeXId + "' width='100%' height='100%' name='" + activeXId + "' align='center' wndtype='"+iWndType+"' playmode='"+szPlayMode+"'>");
							}
							$("#" + activeXId).css('width','99.99%');
							break;
						}
					}
					if (!bInstalled)
					{
						if (navigator.platform == "Win32")
						{
							szInfo = "请点击此处下载插件，安装时请关闭浏览器";
							$("#" + divId).html("<label name='laPlugin' style='margin-top: 35%;' onclick='download(\"" + param.type + "\");' class='pluginLink' onMouseOver='this.className =\"pluginLinkSel\"' onMouseOut='this.className =\"pluginLink\"'>"+szInfo+"</label>");
						}
						else if (navigator.platform == "Mac68K" || navigator.platform == "MacPPC" || navigator.platform == "Macintosh")
						{
							szInfo = "未检测到插件";
							$("#" + divId).html("<label name='laNotWin32Plugin' style='margin-top: 35%;' onclick='' class='pluginLink' style='cursor:default; text-decoration:none;'>"+szInfo+"</label>");
						}
						else
						{
							szInfo = "未检测到插件";
							$("#" + divId).html("<label name='laNotWin32Plugin' style='margin-top: 35%;' onclick='' class='pluginLink' style='cursor:default; text-decoration:none;'>"+szInfo+"</label>");
						}
					  	return false;
					}
				}
				else
				{
					if ($("#" + divId).html() !== "" && $("#" + activeXId).length !== 0 && $("#" + activeXId)[0].object !== null)
					{
						var iPlayMode = 0;
						switch (szPlayMode)
						{
							case "normal":
								//iPlayMode = 0;
								break;
							case "motiondetect":
								iPlayMode = 1;
								break;
							case "tamperdetect":
								iPlayMode = 2;
								break;
							case "privacymask":
								iPlayMode = 3;
								break;
							case "textoverlay":
								iPlayMode = 4;
								break;
							case "osdsetting":
								iPlayMode = 5;
								break;
							default:
								//iPlayMode = 0;
								break;
						}
						device.HWP.SetPlayModeType(iPlayMode);
						//HWP.ArrangeWindow(parseInt(iWndType));
						return true;
					}
					
					$("#" + divId).html("<object style='position:absolute;z-index:0;' classid='clsid:8C1A66F8-F28E-43fb-AF78-11D3163E6635' codebase='' standby='Waiting...' id='" + activeXId+ "' width='" + options.width + "' height='" + options.height + "' name='ocx' align='center' ><param name='wndtype' value='"+iWndType+"'><param name='playmode' value='"+szPlayMode+"'></object>");
					var previewOCX=document.getElementById(activeXId);
					if(previewOCX == null || previewOCX.object == null)
					{
						if((navigator.platform == "Win32"))
						{
							szInfo = "请点击此处下载插件，安装时请关闭浏览器";
							$("#" + divId).html("<label name='laPlugin' style='margin-top: 35%;' onclick='download(\"" + param.type + "\");' class='pluginLink' onMouseOver='this.className =\"pluginLinkSel\"' onMouseOut='this.className =\"pluginLink\"'>"+szInfo+"<label>");
						}
						else
						{
							szInfo = "未检测到插件";
							$("#" + divId).html("<label style='margin-top: 35%;' name='laNotWin32Plugin' onclick='' class='pluginLink' style='cursor:default; text-decoration:none;'>"+szInfo+"<label>");
						}
						
					  return false;
					}
				}
			}
			return true;
		}
		
		function Plugin(iWndNum, szIP, szHttpPort, szRtspPort, divId, activeXId) {
			this.iWndNum = iWndNum; // 子窗体个数
			this.iProtocolType = 0; // 取流方式，默认为RTSP
			this.wnds = new Array(this.iWndNum);
			this.divId = divId;
			this.activeXId = activeXId;
			var that = this;
			$.each(this.wnds, function(iWndNo) {
				that.wnds[iWndNo] = {
					isPlaying: false
				};
			});
			this.isPlaying = function() {
				var ret = false;
				$.each(this.wnds, function(iWndNo, wnd) {
					if (wnd.isPlaying) {
						ret = true;
						return false;
					}
				});
				return ret;
			};
			this.destory = function() {
				this.Stop();
				$("#" + divId).empty();
			};
			this.ArrangeWindow = function(iWndType) {
				try {
					$("#" + activeXId)[0].HWP_ArrangeFECWindow(iWndType);
				} catch (e) {}
			}
			this.Play = function(iWndNo) {
				if (arguments.length === 0) {
					iWndNo = 0;
				}
				if (this.wnds[iWndNo].isPlaying) {
					return 0;
				}
				try
				{
					var previewOCX = $("#" + activeXId)[0];
					try {
						var szLocalCfg = previewOCX.HWP_GetLocalConfig();
					} catch (e) {
						var szLocalCfg = previewOCX.GetLocalConfig();
					}
					var xmlDoc = parseXmlFromStr(szLocalCfg);
					m_iProtocolType = this.iProtocolType = parseInt(xmlDoc.documentElement.childNodes[0].childNodes[0].nodeValue); // 此全局变量暂时保留，wuyang
					var szURL = "rtsp://" + szIP + ":" + ((this.iProtocolType === 4) ? szHttpPort : szRtspPort) + "/PSIA/streaming/channels/" + (101 + iWndNo);
					var iRet = previewOCX.HWP_Play(szURL, m_szUserPwdValue, iWndNo, "", "");
					if (iRet === 0) {
						this.wnds[iWndNo].isPlaying = true;
					}
					return iRet;
				} catch (e) { return -1; }
			};
			this.Stop = function(iWndNo) {
				function Stop(iWndNo) {
					if (!that.wnds[iWndNo].isPlaying) {
						return 0;
					}
					that.wnds[iWndNo].isPlaying = false;
					try {
						return $("#" + activeXId)[0].HWP_Stop(iWndNo);
					} catch (e) { return -1; }
				}
				
				if (arguments.length === 0) {
					var iRet = 0;
					$.each(this.wnds, function(iWndNo, wnd) {
						if (Stop(iWndNo) !== 0) {
							iRet = -1;
						}
					});
					return iRet;
				} else {
					return Stop(iWndNo);
				}
			};
			this.SetDrawStatus = function(bStartDraw) {
				try {
					return $("#" + activeXId)[0].HWP_SetDrawStatus(bStartDraw);
				} catch (e) { return -1; }
			};
			this.GetRegionInfo = function() {
				try {
					return $("#" + activeXId)[0].HWP_GetRegionInfo();
				} catch (e) {
					return "";
				}
			};
			this.SetRegionInfo = function(szRegionInfo) {
				try {
					return $("#" + activeXId)[0].HWP_SetRegionInfo(szRegionInfo);
				} catch (e) { return -1; }
			};
			this.ClearRegion = function() {
				try {
					return $("#" + activeXId)[0].HWP_ClearRegion();
				} catch (e) { return -1; }
			};
			this.GetTextOverlay = function() {
				try {
					return $("#" + activeXId)[0].HWP_GetTextOverlay();
				} catch (e) {
					return "";
				}
			};
			this.SetTextOverlay = function(szTextOverlay) {
				try {
					return $("#" + activeXId)[0].HWP_SetTextOverlay(szTextOverlay);
				} catch (e) { return -1; }
			};
			this.SetPlayModeType = function(iPlayMode) {
				try {
					return $("#" + activeXId)[0].HWP_SetPlayModeType(iPlayMode);
				} catch (e) { return -1; }
			};
			this.SetSnapPolygonInfo = function(szInfo) {
				try {
					return $("#" + activeXId)[0].HWP_SetSnapPolygonInfo(szInfo);
				} catch (e) { return -1; }
			};
			this.GetSnapPolygonInfo = function() {
				try {
					return $("#" + activeXId)[0].HWP_GetSnapPolygonInfo();
				} catch (e) { return -1; }
			};
			this.SetSnapDrawMode = function(iType) {
				try {
					return $("#" + activeXId)[0].HWP_SetSnapDrawMode(0,iType);
				} catch (e) { return -1; }
			};
			this.SetSnapLineInfo = function(szInfo) {
				try {
					return $("#" + activeXId)[0].HWP_SetSnapLineInfo(szInfo);
				} catch (e) { return -1; }
			};
			this.GetSnapLineInfo = function() {
				try {
					return $("#" + activeXId)[0].HWP_GetSnapLineInfo();
				} catch (e) { return -1; }
			}
			this.FullScreenDisplay = function() {
				try {
					return $("#" + activeXId)[0].HWP_FullScreenDisplay(true);
				} catch (e) { return -1; }
			};
			this.ClearSnapInfo = function(iMode) {
				try {
					return $("#" + activeXId)[0].HWP_ClearSnapInfo(iMode);
				} catch (e) { return -1; }
			};
			this.StartSnapPicDownLoad = function(strURL, strAuth, strFileName) {
				try {
					return $("#" + activeXId)[0].HWP_StartSnapPicDownLoad(strURL, strAuth, strFileName, "","snappic");
				} catch (e) { return -1; }
			};
			this.SnapLoadImage = function(strFileName) {
				try {
					return $("#" + activeXId)[0].HWP_SnapLoadImage(strFileName);
				} catch (e) { return -1; }
			};
			var bOpenFileBrowsing = false; // 解决Linux下Firefox的非模态
			this.OpenFileBrowser = function(iMode, szReserve) { // iMode: 0-文件夹, 1-文件
				if (bOpenFileBrowsing) {
					return;
				}
				bOpenFileBrowsing = true;
				var szPath = null;
				try {
					szPath = $("#" + activeXId)[0].HWP_OpenFileBrowser(iMode, szReserve);
				} catch (e) {}
				setTimeout(function() { bOpenFileBrowsing = false; }, 10); // 解决Linux下Chrome的click记忆
				return szPath;
			};
		}
		
		function GetSelectWndInfo(SelectWndInfo) {
		 	return;
		 }
		
		function createxmlDoc()
		 {
		 	var xmlDoc;
		 	var aVersions = [ "MSXML2.DOMDocument","MSXML2.DOMDocument.5.0",
		 	"MSXML2.DOMDocument.4.0","MSXML2.DOMDocument.3.0",
		 	"Microsoft.XmlDom"];
		 	
		 	for (var i = 0; i < aVersions.length; i++) 
		 	{
		 		try 
		 		{
		 			xmlDoc = new ActiveXObject(aVersions[i]);
		 			break;
		 		}
		 		catch (oError)
		 		{
		 			xmlDoc = document.implementation.createDocument("", "", null);
		 			break;
		 		}
		 	}
		 	xmlDoc.async="false";
		 	return xmlDoc;
		 }
		function parseXmlFromStr(szXml)
		{
			if(null == szXml || '' == szXml)
			{
				return null;
			}
			var xmlDoc=new createxmlDoc();
			if(!$.support.msie)
			{
				var oParser = new DOMParser();
				xmlDoc = oParser.parseFromString(szXml,"text/xml");
			}
			else
			{
				xmlDoc.loadXML(szXml);
			}
			return xmlDoc;
		}
		function  isIPv6Add(strInfo) {
			  return /:/.test(strInfo) && strInfo.match(/:/g).length<8 && /::/.test(strInfo)?(strInfo.match(/::/g).length==1 && /^::$|^(::)?([\da-f]{1,4}(:|::))*[\da-f]{1,4}(:|::)?$/i.test(strInfo)):/^([\da-f]{1,4}:){7}[\da-f]{1,4}$/i.test(strInfo);
		}
		
		function isInsalledVLC() {
			if(isIE) {
				return isInsalledIEVLC();
			} else {
				return isInsalledFFVLC();
			}
		}
		
		function isInsalledFFVLC(){
		    var numPlugins=navigator.plugins.length;
		    for  (i=0;i<numPlugins;i++)
		    {
		         plugin=navigator.plugins[i];
		         if(plugin.name.indexOf("VideoLAN") > -1 || plugin.name.indexOf("VLC") > -1)
		       {            
		            return true;
		       }
		    }
		    return false;
		}

		function isInsalledIEVLC(){ 
		    var vlcObj = null;
		    var vlcInstalled= false;
		    try {
		        vlcObj = new ActiveXObject("VideoLAN.Vlcplugin.1"); 
		        if( vlcObj != null ){ 
		            vlcInstalled = true 
		        }
		    } catch (e) {
		        vlcInstalled= false;
		    }        
		    return vlcInstalled;
		}
		
		
	}
})(jQuery);
// function download(type)
// {
// 	if(type == "1") {
// 		window.open("static/plugin/vlc-2.2.1-win32.exe","_self");
// 	} else {
// 		window.open("static/plugin/ITCPWebComponents.exe","_self");
// 	}
// }
function download(type) {
    if (type == "1") {
        if(ctx){
            window.open(ctx + "/static/plugin/vlc-2.2.1-win32.exe", "_self");
        }else{
            window.open("static/plugin/vlc-2.2.1-win32.exe", "_self");
        }
    } else {
        if(ctx){
            window.open(ctx + "/static/plugin/ITCPWebComponents.exe", "_self");
        }else{
            window.open("static/plugin/ITCPWebComponents.exe", "_self");
        }
    }
}

function GetSelectWndInfo(SelectWndInfo) {
 	return;
 }