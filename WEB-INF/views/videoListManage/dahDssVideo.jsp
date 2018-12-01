<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>

<html>
<head>
    <title>大华DSS播放</title>
    <script language="javascript" for="DPSDK_OCX" event="OnWndLBtnClick(nWndId, nWndNo, xPos, yPos)">
		if(typeof(nWndNo) != 'undefined')
			selectWnd = nWndNo;
	</script>
	<script type="text/javascript" src="${ctx}/static/video-player/js/dss-player.js"></script>
    <style type="text/css">
        div#rMenu {
            position: absolute;
            visibility: hidden;
            top: 0;
            background-color: #555;
            text-align: left;
            padding: 2px;
        }

        div#rMenu ul li {
            margin: 1px 0;
            padding: 0 5px;
            cursor: pointer;
            list-style: none outside none;
            background-color: #DFDFDF;
        }

        .greenImg{
            width: 40px;
            height: 40px;
            position: absolute;
            cursor: pointer;
        }
        .smallGreenButton{
            width: 32px;
            height: 32px;
            background: none;
            border-width: 1px;
            border-style: solid;
            border-color: #00BFA5;
            position: absolute;
            font-size: 20px;
            color: #00BFA5;
        }

        .bigGreenButton{
            width: 64px;
            height: 32px;
            background: none;
            border-width: 1px;
            border-style: solid;
            border-color: #00BFA5;
            position: absolute;
            font-size: 14px;
        }

        .screenImg{
            width: 60px;
            height: 46px;
            position: absolute;
            cursor: pointer;
        }

        .downImg{
            width: 46px;
            height: 46px;
            position: absolute;
            cursor: pointer;
        }
        .ico_close,.ico_open,.ico_docu{
        	vertical-align: middle !important;
        	background-size:12px 12px !important; 
        }
    </style>
</head>
<body>
<div>
    <div style="position: absolute;left: 1460px;font-size: 18px">监控区域</div><br>
    <div id="div-tree" class="content-default" style="height: 250px; width: 226px;margin-top:10px; float: right;background-color: transparent">
        <div id="tree-wrap" style="height: 250px; overflow: auto; border: 1px; border-radius: 3px;min-height: 250px;">
            <div class="zTreeDemoBackground right" style="height: 225px; overflow-y:scroll;">
                <ul id="tree-content" class="ztree"></ul>
            </div>
        </div>
    </div>
    <div style="float: right;border: 1px solid #ccc; border-radius: 3px;height: 90%;margin-right: 55px;overflow-y: auto;">
        <div id="divPlugin" class="plugin"></div>
    </div>
    <div style="position: absolute;left: 1470px;top: 360px;font-size: 18px">云台控制</div><br>
    <div style="width: 250px;height: 360px;position: absolute;left: 1460px;top: 400px">
        <img src="${ctx}/static/hkImage/left-up.svg" class="greenImg" style="top: 10px;left: 10px" onclick="PTZControl(5)">
        <img src="${ctx}/static/hkImage/up.svg" class="greenImg" style="top: 10px;left: 60px" onclick="PTZControl(1)">
        <img src="${ctx}/static/hkImage/right-up.svg" class="greenImg" style="top: 10px;left: 110px" onclick="PTZControl(7)">
        <img src="${ctx}/static/hkImage/left.svg" class="greenImg" style="top: 60px;left: 10px" onclick="PTZControl(3)">
        <img src="${ctx}/static/hkImage/stopVideoTapeL.svg" class="greenImg" style="top: 60px;left: 60px" onclick="PTZControl(9)">
        <img src="${ctx}/static/hkImage/right.svg" class="greenImg" style="top: 60px;left: 110px" onclick="PTZControl(4)">
        <img src="${ctx}/static/hkImage/left-down.svg" class="greenImg" style="top: 110px;left: 10px" onclick="PTZControl(6)">
        <img src="${ctx}/static/hkImage/down.svg" class="greenImg" style="top: 110px;left: 60px" onclick="PTZControl(2)">
        <img src="${ctx}/static/hkImage/right-down.svg" class="greenImg" style="top: 110px;left: 110px" onclick="PTZControl(8)">
        <button class="smallGreenButton" style="top: 180px;left: 10px" onclick="PTZOperation(3)">-</button>
        <button class="bigGreenButton" style="top: 180px;left: 48px" disabled: disabled>变倍</button>
        <button class="smallGreenButton" style="top: 180px;left: 118px" onclick="PTZOperation(0)">+</button>
        <button class="smallGreenButton" style="top: 218px;left: 10px" onclick="PTZOperation(4)">-</button>
        <button class="bigGreenButton" style="top: 218px;left: 48px" disabled: disabled>变焦</button>
        <button class="smallGreenButton" style="top: 218px;left: 118px" onclick="PTZOperation(1)">+</button>
        <button class="smallGreenButton" style="top: 256px;left: 10px" onclick="PTZOperation(5)">-</button>
        <button class="bigGreenButton" style="top: 256px;left: 48px" disabled: disabled>光圈</button>
        <button class="smallGreenButton" style="top: 256px;left: 118px" onclick="PTZOperation(2)">+</button>
    </div>
</div>
<div class="container">
    <div class="row">
        <%--<div class="dropdown" style="margin-left: 1px;margin-top: 1px;">--%>
            <%--<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="margin-left: 5px;margin-top: 1px;"> 窗口分割数 <span class="caret"></span>--%>
            <%--</button><!--btn-default默认颜色-->--%>
            <%--<ul class="dropdown-menu">--%>
                <%--<li><a href="#" onclick="changeWndNum(1);">1x1</a></li>--%>
                <%--<li><a href="#" onclick="changeWndNum(2);">2x2</a></li>--%>
                <%--<li><a href="#" onclick="changeWndNum(3);">3x3</a></li>--%>
                <%--<li><a href="#" onclick="changeWndNum(4);">4x4</a></li>--%>
            <%--</ul>--%>
        <%--</div>--%>
            <img id="screen1" src="${ctx}/static/hkImage/1screen.svg" class="screenImg" style="top: 810px;left: 150px" onclick="changeWndNum(1)">
            <div style="width: 30px;height: 15px;position: absolute;top: 860px;left: 166px">全屏</div>
            <img id="screen4" src="${ctx}/static/hkImage/4screen.svg" class="screenImg" style="top: 810px;left: 250px" onclick="changeWndNum(4)">
            <div style="width: 36px;height: 15px;position: absolute;top: 860px;left: 264px">4分屏</div>
            <img id="screen9" src="${ctx}/static/hkImage/9screenL.svg" class="screenImg" style="top: 810px;left: 350px" onclick="changeWndNum(9)">
            <div style="width: 36px;height: 15px;position: absolute;top: 860px;left: 364px">9分屏</div>
            <img id="screen16" src="${ctx}/static/hkImage/16screen.svg" class="screenImg" style="top: 810px;left: 450px" onclick="changeWndNum(16)">
            <div style="width: 45px;height: 15px;position: absolute;top: 860px;left: 458px">16分屏</div>

            <%-- <img id="catchP" src="${ctx}/static/hkImage/catchP.svg" style="width: 56.6px;height: 46px;position: absolute;top: 810px;left: 580px" onclick="clickCapturePic()">
            <div style="width: 30px;height: 15px;position: absolute;top: 860px;left: 596px">抓图</div>
            <img id="startVideoTape" src="${ctx}/static/hkImage/startVideoTape.svg" class="downImg" style="top: 810px;left: 670px" onclick="clickStartRecord()">
            <div style="width: 60px;height: 15px;position: absolute;top: 860px;left: 670px">开始录像</div>
            <img id="stopVideoTape" src="${ctx}/static/hkImage/stopVideoTape.svg" class="downImg" style="top: 810px;left: 750px" onclick="clickStopRecord()">
            <div style="width: 60px;height: 15px;position: absolute;top: 860px;left: 750px">停止录像</div> --%>
            <img id="stopVideo" src="${ctx}/static/hkImage/stopVideo.svg" class="downImg" style="top: 810px;left: 550px" onclick="dssStop()">
            <div style="width: 60px;height: 15px;position: absolute;top: 860px;left: 545px">关闭视频</div>
            <img id="carousel-button" src="${ctx}/static/hkImage/startVideoTapeL.svg" class="downImg" style="top: 810px;left: 630px" pause="true" onclick="switchCarousel()">
            <div id="carousel-text" style="width: 60px;height: 15px;position: absolute;top: 860px;left: 625px">开始轮播</div>
    </div>
</div>
<div id="error-div"></div>
<script type="text/javascript">
    var ctx = "${ctx}";
    var dssPlayerObj = null;
    var nowDSSId = null;
    var ctx = "${ctx}";
    var directs = null;
    var selectWnd = 0;
    var channelMap = {};
    $(document).ready(function () {
    	dssPlayerObj = $("#divPlugin").dssPlayer({
    		nWndCount:9,
			width : "1300px",
			height : "700px"
		});
    	switchCarouselO = {
                               data:[],
                               page:1,
                               limit:9,
                               singlePage:false,
                               nextPage:function(){
                            	   var that = this;
                            	   if((that.page-1)*that.limit>=that.data.length){
                            		   that.page = 1;
                            	   }
                            	   var result = $.map(that.data, function(n, i){
                            		    if(i >= (that.page-1)*that.limit
                            		    		&& i < that.page*that.limit)
	                            	        return n;
                           	       });
                            	   if(that.data.length < that.limit){
                            		   that.singlePage = true;
                            	   }else{
                            		   that.singlePage = false;
                            	   }
                            	   that.page++;
                            	   return result;
                               }
        }
    	
        $.ajax({
            type: "post",
            url: "${ctx}/device/manage/queryDSSTree?CHECK_AUTHENTICATION=false&projectCode="+projectCode,
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            success: function (data) {
            	$.each(data,function(i,val){
            		val.icon = ctx+val.icon;
            		for(var i in val.children){
            			val.children[i].icon = ctx+val.children[i].icon;
            			switchCarouselO.data[switchCarouselO.data.length] = val.children[i].channel;
            		}
            	});
                var ztree = $.fn.zTree.init($("#tree-content"), {
                    data: {
                        simpleData: {enable: true}
                    },
                    callback: {
                        beforeExpand: zTreeBeforeExpand,
                        beforeClick: checkNode,
                        onExpand: zTreeOnExpand,
                        onDblClick: onClick
                    }
                }, data);
                var znode = ztree.getNodeByTId("tree-content_1");
                ztree.expandNode(znode,true, true, true, true);
            },
            error: function (req, error, errObj) {
                showDialogModal("error-div", "操作错误", "初始化功能数据失败！");
            }
        });
        resize();
    });

    $(window).resize(function () {
        resize();
    });
	function changeWndNum(num){
		$("#screen1").attr("src",ctx+'/static/hkImage/1screen.svg');
	    $("#screen4").attr("src",ctx+'/static/hkImage/4screen.svg');
	    $("#screen9").attr("src",ctx+'/static/hkImage/9screen.svg');
	    $("#screen16").attr("src",ctx+'/static/hkImage/16screen.svg');
	    if(num == 1){
	        $("#screen1").attr("src",ctx+'/static/hkImage/1screenL.svg');
	    }else if(num == 4){
	        $("#screen4").attr("src",ctx+'/static/hkImage/4screenL.svg');
	    }else if(num == 9){
	        $("#screen9").attr("src",ctx+'/static/hkImage/9screenL.svg');
	    }else if(num == 16){
	        $("#screen16").attr("src",ctx+'/static/hkImage/16screenL.svg');
	    }
		if(dssPlayerObj == null){
    		return;
    	}
		dssPlayerObj.setWndCount(num);
		switchCarouselO.limit = num;
	    switchCarouselO.page = 1;
	    nextCarousel();
	}
    function resize() {
        var treeMinHeight = $(document.body).height() - 96 - 30 - 40;
        $("#tree-wrap").css("minHeight", treeMinHeight);
        $("#div-content").css("minHeight", $("#div-tree").outerHeight());
    };

    function onClick(event, treeId, treeNode) {
    	if(treeNode == null){
    		return
    	}
    	console.log("treeNode" + treeNode.treeLevel);
        if (treeNode.treeLevel == 1) {
        	dssLogin(treeNode);
        }else if (treeNode.treeLevel == 2){
        	var treeNodeP = treeNode.parentTId ? treeNode.getParentNode() : null;
        	dssLogin(treeNodeP);
        	dssPlay(treeNode);
        }
    };
    
    function dssLogin(treeNode){
    	console.log("dssLogin");
    	if(treeNode == null || nowDSSId == treeNode.id || treeNode.treeLevel != 1)
    		return;
    	nowDSSId = treeNode.id;
    	dssPlayerObj.login(
			treeNode.ip,
			treeNode.port,
			treeNode.userName,
			treeNode.password
			);
    	dssPlayerObj.loadDGroupInfo();
    }
    function dssPlay(treeNode){
    	console.log("dssPlay");
    	if(dssPlayerObj == null){
    		return;
    	}
    	$("#stopVideo").attr("src",ctx+"/static/hkImage/stopVideoL.svg");
    	channelMap[selectWnd] = treeNode.channel;
    	dssPlayerObj.play(treeNode.channel);
    }
    function dssPlayByWnd(nWnd,channel){
    	console.log("dssPlay");
    	if(dssPlayerObj == null){
    		return;
    	}
    	channelMap[nWnd] = channel;
    	dssPlayerObj.playByWnd(nWnd,channel);
    }
    
    function dssStop(){
    	if(dssPlayerObj == null){
    		return;
    	}
    	$("#stopVideo").attr("src",ctx+"/static/hkImage/stopVideo.svg");
    	dssPlayerObj.pause();
    }
    function PTZControl(direct){
    	if(dssPlayerObj == null || channelMap[selectWnd] == null){
    		return;
    	}
   		if(direct == 9 && directs != null){
	    	dssPlayerObj.ptzDirection(directs,channelMap[selectWnd],true);
   		}else{
   			dssPlayerObj.ptzDirection(direct,channelMap[selectWnd],false);
   		}
    	directs = direct;
    }
    
    function PTZOperation(nOper){
    	if(dssPlayerObj == null || channelMap[selectWnd] == null){
    		return;
    	}
    	dssPlayerObj.ptzOperation(nOper,channelMap[selectWnd],false);
    	dssPlayerObj.ptzOperation(nOper,channelMap[selectWnd],true);
    }
    
    function checkNode(treeId, treeNode){
    	if (treeNode.treeLevel == 1) {
    		return false;
    	}
    }
    
    function zTreeBeforeExpand(treeId, treeNode) {
    };

    function zTreeOnExpand(event, treeId, treeNode) {
    	console.log("zTreeOnExpand=====================")
    	dssLogin(treeNode)
    };
    /*轮播不弹窗 function showDModal(msg){
		showDialogModal("error-div", "操作错误", msg);
		$("#error-div-modal-content").append('<iframe id="iframe-dss" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:400px; height:186px;z-index:-1; filter:alpha(opacity=0);"></iframe>');
	} */
    function switchCarousel(){
    	if($("#carousel-button").attr("pause") == "false"){
    		$("#carousel-button").attr("src",ctx+"/static/hkImage/startVideoTapeL.svg");
    		$("#carousel-text").html("开始轮播");
    		$("#carousel-button").attr("pause","true");
    		$('#stopVideo').removeAttr("disabled");
    		stopCarousel();
    	}else{
    		$("#carousel-button").attr("src",ctx+"/static/hkImage/stopVideoTapeL.svg");
    		$("#carousel-text").html("关闭轮播");
    		$("#carousel-button").attr("pause","false");
    		$("#stopVideo").attr("disabled","disabled");
    		nextCarousel();
    	}
    }
    function nextCarousel(close){
    	if($("#carousel-button").attr("pause") == "true"){
    		return;
    	}
    	var channels = switchCarouselO.nextPage();
    	for(var i = 0;i < channels.length; i++){
	    	dssPlayByWnd(i,channels[i]);
    	}
    	if(typeof(timeoutId) != 'undefined'){
    		clearTimeout(timeoutId);
    	}
    	if(!switchCarouselO.singlePage){
	    	timeoutId = setTimeout(nextCarousel,60*1000);
    	}
    }
    function stopCarousel(){
    	if(typeof(timeoutId) != 'undefined'){
    		clearTimeout(timeoutId);
    	}
    }
</script>
</body>
</html>
