<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter" %>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException" %>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException" %>
<%@ page import="com.rib.base.util.StaticDataUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%
    String systemName = StaticDataUtils.getSystemName();
			String copyright = StaticDataUtils.getCopyright();
			Object isExtNetObj = request.getSession().getAttribute("isExtNet");
			boolean isExtNet = true;
			if (isExtNetObj != null) {
				isExtNet = (Boolean) isExtNetObj;
			}
			String imageServerAddress = (String) request.getSession().getAttribute("IMAGE_SERVER_ADDRESS");
			String mappingImageAddress = (String) request.getSession().getAttribute("MAPPING_IMAGE_ADDRESS");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>火炬小区可视化运营</title>
</head>
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/theme/rib-green.css" type="text/css" rel="stylesheet" /><link href="${ctx}/static/css/operateSystemMain.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/mapDeleteScroll.css" type="text/css"
      rel="stylesheet"/>
<link href="${ctx}/static/css/operationManagerScreenPage.css" type="text/css"
      rel="stylesheet"/>
<link type="text/css" rel="stylesheet" href="${ctx}/static/js/bxslider/jquery.bxslider.min.css"/>
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js"
	type="text/javascript"></script>
<script
	src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/busi/operationManagerScreenPage.js"
        type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.SuperSlide.2.1.1.js"></script>
<script type="text/javascript" src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/websocket/stomp.min.js"></script>
	<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
<script src="${ctx}/static/js/HashMap.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/commons.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/wadda.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/canvas/faceCanvasRecognize.js"></script>
<script src="${ctx}/static/js/HashMap.js" type="text/javascript"></script>
<style>
    .snapshot {
        background-image: url("${ctx}/static/img/canvas/car/snapshot_bg.svg");
  		display: none; 
    }

    #spanTxt {
        font-family: PingFangSC-Regular;
        font-size: 12px;
        color: #FFFFFF;
        letter-spacing: 0.4px;
    }

    .licensePlate {
        margin-left：20px;
    }

    #snapshot_div_id {
        left: 1050px;
        top: 170px;
        width: 174px;
        height: 122px;
        position: absolute;
    }

    .snapshotDiv {
        margin-left: 7px;
        margin-top: 10px;
        position: relative;
    }

    #spanTxt {
        width: 180px;
        height: 17px;
        line-height: 17px;
        position: relative;
        padding-left: 9px;
        padding-right: 12px
    }

    #snapshot_li_img {
        width: 160px;
        height: 90px;
    }

    .snapshot-out {
        background-image: url("${ctx}/static/img/canvas/car/snapshot_bg.svg");
        background: norepeat;
        display: none;  
    }

    #spanTxt-out {
        font-family: PingFangSC-Regular;
        font-size: 12px;
        color: #FFFFFF;
        letter-spacing: 0.4px;
    }

    .licensePlate-out {
        margin-left：20px;
    }

    #snapshot-div-id-out {
        left: 1380px;
        top: 170px;
        width: 174px;
        height: 122px;
        position: absolute;
    }

    .snapshotDiv-out {
        margin-left: 7px;
        margin-top: 10px;
        position: relative;
    }

    #spanTxt-out {
        width: 180px;
        height: 17px;
        line-height: 17px;
        position: relative;
        padding-left: 9px;
        padding-right: 12px
    }

    #snapshot-li-img-out {
        width: 160px;
        height: 90px;
    }

    .device-info {
        background-color: rgba(0, 28, 42, 0.61);
        border: 1px solid #54C1F0;
        box-shadow: 0 10px 16px 0 rgba(0, 3, 4, 0.50);
        border-radius: 4px;
        width: 269px;
        height: 123px;
        margin: 0 10px;
        display: inline-block;
    }

    #show-device-info-container {
        position: absolute;
        margin-top: 933px;
        margin-left: 88px;
        height: 143px;
        float: left;
        overflow-x: auto;
        overflow-y: hidden;
        width: 1740px;
        white-space: nowrap;
    }

    #popBox {
        position: absolute;
        height: 340px;
        margin-top: 300px;
        margin-left: 440px;
        z-index: 100;
    }

    .showPop {
        width: 566px;
        height: 346px;
        margin-left: 245px;
        background: url('${ctx}/static/img/video/Rectangle12.svg') -14px -4px no-repeat;
        box-shadow: 0 10px 16px 0;
        float: left;
    }

    .popTitle {
        font-size: 24px;
        color: #FFFFFF;
        letter-spacing: 0;
        text-align: center;
        height: 33px;
        margin-top: 16px;
        width: 496px;
        float: left;
    }
	.carType{
	float:right;
	padding-right: 3px;
	}
	.carType-out{
	float:right;
	padding-right: 3px;
	}
	.env_bubble {
	position: absolute;
	width: 240px;
	height: 130px;
	background-image:
		url('${ctx}/static/img/operationManagerScreenPage/huanjing03.svg');
    }
    .env_ele_bubble {
	position: absolute;
	width: 120px;
	height: 50px;
    }
    .env_bubble_big {
	z-index: 1;
	position: absolute;
	width: 50px;
	height: 50px;
	background-image:
		url('${ctx}/static/img/operationManagerScreenPage/huanjing02.svg');
	}
	
	.env_bubble_small {
		z-index: 1;
		position: absolute;
		width: 40px;
		height: 40px;
		background-image:
			url('${ctx}/static/img/operationManagerScreenPage/huanjing01.svg');
	}
    .screen_page_body{
        line-height: 20px;
        height: 1080px;
        margin: 0px;
        margin-top: -18px;
        background: #162D39 !important;
        width: 1920px;
    }
    html{
        margin-top: -2px;
    }
    .focus_face{
	width: 300px; 
	height: 210px;
	position: absolute;
	left:536px;
	top:375px;
/* 	display: none; */
	}

	#faceCvs{
	position: absolute;
    left: 1101px;
    top: 23px;
    width: 95px;
    height: 95px;
    background: url('${ctx}/static/img/canvas/accessFaceBg.svg');
    background-size: 100%;
    display: none; 
	}
	
	.tangan{
 	animation: recognize-face 2s forwards; 
	animation-timing-function: linear;
	transform-origin: center;
	margin-top: -57px;
    left: -30px;
	position: absolute;
	background: url('${ctx}/static/img/canvas/guideLine.svg') no-repeat 0 0;
	width: 31px;
    height: 41px;
	}
	@keyframes recognize-face { 
		0% {
			background-position:-31px 100%;
  			margin-left:31px;   
		}
		
		100%{
			background-position:0 0;
 			margin-left:0px; 
		}
	}
	.face_bottom_info{
	position: absolute;
    width: 94px;
    height: 22px;
    text-align: center;
    line-height: 2;
    top: 72px;
    font-size: 12px;
    color: white;
    display: block;
    z-index: 2;
}
</style>
<body class="screen_page_body">
<div id="page-box" style="width: 1920px; height: 1080px;position: relative;">
    <div style="position: absolute;left: 744px;top: 35px;color: #5F95B1;font-size: 48px;">火炬小区可视化运营</div>
    <div id="show-device-info-container">
    	<div id="show-device-info"></div>
    	<div id="playStateCell"></div>
    </div>
    <div id="popBox">

    </div>
    <div class="snapshot" id="snapshot_div_id">
        <div class="snapshotDiv">
            <img id="snapshot_li_img"
                 src="${ctx}/static/img/empty.jpg"
                 onerror="src='${ctx}/static/img/empty.jpg'"
                 onclick="historyRecord(1)">
        </div>
        <div id="spanTxt">
            <span id="licensePlate" class="licensePlate">浙A0057</span><span
                class="carType" id="carType">固定车</span>
        </div>
    </div>
    <div class="snapshot-out" id="snapshot-div-id-out">
        <div class="snapshotDiv-out">
            <img id="snapshot-li-img-out"
                 src="${ctx}/static/img/empty.jpg"
                 onerror="src='${ctx}/static/img/empty.jpg'"
                 onclick="historyRecord(2)">
        </div>
        <div id="spanTxt-out">
            <span id="licensePlate-out" class="licensePlate-out">浙A0057</span><span
                class="carType-out" id="carType-out">固定车</span>
        </div>
        <div id="custNameTxt"
             style=" margin-top:5px;width: 180px; height: 22px;line-height: 17px; position: relative; padding-left:10px;padding-right:10px;  ">
            <span id="custName" class="custName"></span>
        </div>
    </div>
    <div id ="faceCvs"></div>
</div>
<div id="face-slide-image"></div>
<div id="record-slide-image"></div>
<div id="show-video"></div>
<div id="show-picture"></div>
<div id="error-div"></div>
<script>
	var projectCode = "${param.projectCode}";
	var projectId ="${param.projectId}";
	var ctx = '${ctx}';
	var parkingDevNorNum;
	var parkingDevUnNorNum;
    var videoListManageData = {
        row: {}
    };
    var pmNum = "-   -";
    var pollution = "-   -";
    var hjcolor="#5BCE3E";
    var videoIconList = {
        L: "${ctx}/static/img/video/left.svg",
        LO: "${ctx}/static/img/video/left_offline.svg",
        LU: "${ctx}/static/img/video/left_upper.svg",
        LUO: "${ctx}/static/img/video/left_upper_offline.svg",
        U: "${ctx}/static/img/video/up.svg",
        UO: "${ctx}/static/img/video/up_offline.svg",
        RU: "${ctx}/static/img/video/right_upper.svg",
        RUO: "${ctx}/static/img/video/right_upper_offline.svg",
        R: "${ctx}/static/img/video/right.svg",
        RO: "${ctx}/static/img/video/right_offline.svg",
        RD: "${ctx}/static/img/video/right_down.svg",
        RDO: "${ctx}/static/img/video/right_down_offline.svg",
        D: "${ctx}/static/img/video/down.svg",
        DO: "${ctx}/static/img/video/down_offline.svg",
        LD: "${ctx}/static/img/video/left_down.svg",
        LDO: "${ctx}/static/img/video/left_down_offline.svg",
        F: "${ctx}/static/img/canvas/faceCamera.svg"
    };
    var parkingGeomagnetismPictureList = {
        NuNV: "${ctx}/static/img/geomagnetism/ParkingGeomagnetismNuNV.svg",
        NuAbNV: "${ctx}/static/img/geomagnetism/ParkingGeomagnetismNuAbNV.svg",
        UNV: "${ctx}/static/img/geomagnetism/ParkingGeomagnetismUNV.svg",
        UAbNV: "${ctx}/static/img/geomagnetism/ParkingGeomagnetismUAbNV.svg",
        NuNH: "${ctx}/static/img/geomagnetism/ParkingGeomagnetismNuNH.svg",
        NuAbNH: "${ctx}/static/img/geomagnetism/ParkingGeomagnetismNuAbNH.svg",
        UNH: "${ctx}/static/img/geomagnetism/ParkingGeomagnetismUNH.svg",
        UAbNH: "${ctx}/static/img/geomagnetism/ParkingGeomagnetismUAbNH.svg"
    };

    var popBoxInfo = {
        deviceId: "1",
        title:"户外烟感温感",
        popImg: "${ctx}/static/img/geomagnetism/yanganNew.png",
        showInfo:["设备型号：0165646546546464","类型：户外烟感温感","位置信息：xxx","火灾报警：正常"]
    };

    var fireGateGeomagnetismPictureList = {
        N: "${ctx}/static/img/geomagnetism/FireGateGeomagnetismN.svg",
        AbN: "${ctx}/static/img/geomagnetism/FireGateGeomagnetismAbN.svg",
        LB: "${ctx}/static/img/geomagnetism/FireGateGeomagnetismLB.svg",
        OL: "${ctx}/static/img/geomagnetism/FireGateGeomagnetismOL.svg"
    };

    var manholeCoverPictureList = {
        N: "${ctx}/static/img/geomagnetism/ManholeCoverN.svg",
        OL: "${ctx}/static/img/geomagnetism/ManholeCoverOL.svg",
        M: "${ctx}/static/img/geomagnetism/ManholeCoverM.svg",
        LB: "${ctx}/static/img/geomagnetism/ManholeCoverLB.svg"
    };

    var videoFrameData = {
        deviceType: 'VIDEO',
        icon: "${ctx}/static/img/video/camera.svg",
        num: 0,
        numDesc: "视频监控总数",
        normalInfo: [],
        warnInfo: []
    };
    var parkingFrameData = {
            deviceType: 'LICENSE_PLATE_RECOGNITION_CAMERA',
            icon: "${ctx}/static/img/operationManagerScreenPage/parking-camera.svg",
            num: 0,
            numDesc: "车牌识别相机",
            normalInfo: [],
            warnInfo: [],
            warnInfo1: []
        };
    var garbageFrameData = {
            deviceType: 'IOT_TRASHCAN',
            icon: "${ctx}/static/img/operationManagerScreenPage/lajitongzhengchang.svg",
            num: 0,
            numDesc: "垃圾桶",
            normalInfo: [],
            warnInfo: [],
            warnInfo1: [],
            warnInfo2: []
        };
    var environFrameData = {
            deviceType: 'IOT_ENVIRONMENT',
            icon: "${ctx}/static/img/operationManagerScreenPage/huanjingzhengchang.svg",
            num: 0,
            numDesc: "环境终端",
            normalInfo: [],
            warnInfo: [],
            warnInfo1: [],
            warnInfo2: []
        };
    var electricityFrameData = {
            deviceType: 'IOT_ELECTRICITY_METER',
            icon: "${ctx}/static/img/operationManagerScreenPage/zhinengdianbiao.svg",
            num: 0,
            numDesc: "电表",
            normalInfo: [],
            warnInfo: []
        };
       var deviceInfos = ['VIDEO','PARKING_GEOMAGNETISM','FIRE_GATE_GEOMAGNETISM','TBS-110','LICENSE_PLATE_RECOGNITION_CAMERA','IOT_TRASHCAN','IOT_ENVIRONMENT','IOT_ELECTRICITY_METER'];

       var deviceIds = [];
       var manholeCoverDeviceIds = [];
       
       
       var faceImageQueue = new Queue();
       var faceImage = new  Image();
       var faceCanvas;
       var deviceStatusMap = new HashMap();
       var deviceIconMap = new HashMap();
       var type = 1;
$(document).ready(function() {
	window.setInterval('changColor()',1000);
    initDeviceInoFrame();
	var inPassageName;
	var outPassageName;
	//start websocket
	startConn(ctx);
	getGarbageStatistics();
	getParkingStatistics();
	getFfStatistics();
	getEnvironmentStatistics();
	getElectricityStatistics();
	$.ajax({
		type : "post",
		url : "${ctx}/device/manage/getDeviceRelate?projectId="+projectId+"&pictureName=huoju",
		dataType : "json",
		async: false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if(data.msg=="success" && data.data.length>0){
		  	  $("#page-box").css("background-image",'url('+data.data[0].filePath+')');
		  	  buildDiv(data.data);
			}

		},
		error : function(req,error, errObj) {
			return;
		    }
		});
	//定时获取环境数据
	setInterval(getEnvironmentStatistics,5000);
});
	
function showEnvironmentDeviceInfo(data) {
    var icon = data.icon ? "<img src = '" + data.icon + "' style='width:45px;height:45px'/>" : "无图";
    var num = data.num ? data.num : 0;
    var numDesc = data.numDesc ? data.numDesc : "无描述信息";
    var normalInfo = data.normalInfo ? data.normalInfo.length > 0 ? data.normalInfo : [] : [];
    var warnInfo = data.warnInfo ? data.warnInfo.length > 0 ? data.warnInfo : [] : [];
 	var warnInfo1 = data.warnInfo1 ? data.warnInfo1.length > 0 ? data.warnInfo1 : [] : [];
    var warnInfo2 = data.warnInfo2 ? data.warnInfo2.length > 0 ? data.warnInfo2 : [] : [];

    var normalInfoHtml = "";
    var warnInfoHtml = "";
    var warnInfo1Html = "";
    var warnInfo2Html = "";
    
    $.each(normalInfo, function (i, val) {
        normalInfoHtml += '<div id = "nor-'+data.deviceType+'" style="font-size: 12px;color: #FFFFFF;height:20px">' + val + '</div>';
    });
    $.each(warnInfo, function (i, val) {
        warnInfoHtml += '<div id = "warn-'+data.deviceType+'" style="font-size: 12px;color: #FF5F5F;height:20px">' + val + '</div>';
    });
	 $.each(warnInfo1, function (i, val) {
		 warnInfo1Html += '<div style="font-size: 12px;color: #FFFFFF;height: 20px;">' + val + '</div>';
	 });
     $.each(warnInfo2, function (i, val) {
         warnInfo2Html += '<div style="font-size: 12px;color: '+hjcolor+';height: 20px;">' + val + '</div>';
     });

    var deviceInfoId = "deviceInfo" + data.deviceType;
    if ($("#" + deviceInfoId).length > 0) {
        $("#" + deviceInfoId).html('<div style="float: left;margin-top: 48px;margin-left: 20px;">' + icon + '</div>' +
            '<div style="width: 90px;float: left;margin-left: 10px;margin-top: 39px;">' +
            '<div style="font-size: 33px;color: #50E3C2;text-align: center;height: 40px;margin-left:-10px;">' + num + '</div>' +
            '<div style="font-size: 12px;color: #FFFFFF;text-align: center;margin-left:-10px">' + numDesc + '</div>' +
            '</div>' +
            '<div style="float: left;margin-top: 40px;margin-left: -10px;">' +
            normalInfoHtml +
            warnInfoHtml +
            warnInfo1Html +
            warnInfo2Html +
            '</div>');
    } else {
        $('#show-device-info').append(
            '<div id="' + deviceInfoId + '" class="device-info">' +
            '<div style="float: left;margin-top: 48px;margin-left: 20px;">' + icon + '</div>' +
            '<div style="width: 90px;float: left;margin-left: 10px;margin-top: 39px;">' +
            '<div style="font-size: 33px;color: #50E3C2;text-align: center;height: 40px;margin-left:-10px;">' + num + '</div>' +
            '<div style="font-size: 12px;color: #FFFFFF;text-align: center;margin-left:-10px">' + numDesc + '</div>' +
            '</div>' +
            '<div style="float: left;margin-top: 40px;margin-left: -10px;">' +
            normalInfoHtml +
            warnInfoHtml +
            warnInfo1Html +
            warnInfo2Html +
            '</div></div>'
        );
    }
}
	
function getEnvironmentStatistics(){
	$.ajax({
		type : "post",
		url : "${ctx}/fire-fighting/iotSensorManage/getEnvironmentByDeviceTypeCode?projectCode="+projectCode+"&deviceTypeCode="+'IOT_ENVIRONMENT',
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if(data){
				 showEnvDiv();
				 environFrameData.normalInfo = [];
				 environFrameData.warnInfo = [];
				 environFrameData.warnInfo1 = [];
				 environFrameData.warnInfo2 = [];
				 if(data.data.noraml == "0" && data.data.offline == "0"){
					 environFrameData.normalInfo.push("正常：" + "-   -");
					 environFrameData.warnInfo.push("离线："+"-   -");
					 environFrameData.warnInfo1.push("pm2.5："+"-   -");
					 environFrameData.warnInfo2.push("污染等级："+"-   -");
					 environFrameData.num = "-   -";
				     showEnvironmentDeviceInfo(environFrameData);	
				}else{
				 var deviceTotal = data.data.deviceTotal;
				 var noraml = data.data.noraml;
				 var offline = data.data.offline;
				 var monitorValue = data.data.monitorValue;
				 if(monitorValue !=null && monitorValue != ""){
					 pmNum = monitorValue;
					 }else {
						 pmNum = "-   -" 
					 }
				 $("#pm25").children().html(pmNum);
			    if(monitorValue == "" || monitorValue == null){
	 					pollution = "-   -";
	             		hjcolor="#5BCE3E";
	 			}else if(monitorValue<35){
             		pollution = "优";
             		hjcolor="#5BCE3E";
 				}else if(35<=monitorValue && monitorValue<75){
 					pollution = "良";
 					hjcolor="#00D1FF";
 				}else if(75<=monitorValue && monitorValue<115){
 					pollution = "轻度污染";
 					hjcolor="#FFD014";
 				}else if(115<=monitorValue && monitorValue<150){
 					pollution = "中度污染";
 					hjcolor="#FF8827";
 				}else if(150<=monitorValue && monitorValue<250){
 					pollution = "重度污染";
 					hjcolor="#FC5E5E";
 				}else if(250<=monitorValue){
 					pollution = "严重污染";
 					hjcolor="#B540C1";
 				}
			    $('#pm25').next().html(pollution);
				 environFrameData.normalInfo.push("正常：" + noraml);
				 environFrameData.warnInfo.push("离线："+offline);
				 environFrameData.warnInfo1.push("pm2.5："+pmNum);
				 environFrameData.warnInfo2.push("污染等级："+pollution);
				 environFrameData.num = deviceTotal;
			     showEnvironmentDeviceInfo(environFrameData);
			}
			     removeEnvDiv();
			}
	
		},
		error : function(req, error, errObj) {
		}
	});
} 

function getElectricityStatistics(){
	$.ajax({
		type : "post",
		url : "${ctx}/fire-fighting/iotSensorManage/getEnvironmentByDeviceTypeCode?projectCode="+projectCode+"&deviceTypeCode="+'IOT_ELECTRICITY_METER',
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if(data){
				 electricityFrameData.normalInfo = [];
				 electricityFrameData.warnInfo = [];
				 if(data.data.noraml == "0" && data.data.offline == "0"){
					 electricityFrameData.normalInfo.push("正常：" + "-   -");
					 electricityFrameData.warnInfo.push("离线："+"-   -");
					 electricityFrameData.num = "-   -";
				     showEnvironmentDeviceInfo(electricityFrameData);	
				}else{
				 var deviceTotal = data.data.deviceTotal;
				 var noraml = data.data.noraml;
				 var offline = data.data.offline;
				 electricityFrameData.normalInfo.push("正常：" + noraml);
				 electricityFrameData.warnInfo.push("离线："+offline);
				 electricityFrameData.num = deviceTotal;
			     showEnvironmentDeviceInfo(electricityFrameData);
			}
			}
	
		},
		error : function(req, error, errObj) {
		}
	});
} 

function getGarbageStatistics(){
	$.ajax({
		type : "post",
		url : "${ctx}/fire-fighting/iotSensorManage/getDeviceAlarmInfoByDeviceTypeCode?projectCode="+projectCode+"&deviceTypeCode="+'IOT_TRASHCAN',
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if(data){
				 var deviceTotal = data.data.deviceTotal;
				 var noraml = data.data.noraml;
				 var monitorAlarm = data.data.monitorAlarm;
				 var offline = data.data.offline;
				 var lowBatteryAlarm = data.data.lowBatteryAlarm;
				 
				 garbageFrameData.normalInfo = [];
				 garbageFrameData.warnInfo = [];
				 garbageFrameData.warnInfo1 = [];
				 garbageFrameData.warnInfo2 = [];
				 garbageFrameData.normalInfo.push("正常：" + noraml);
			     garbageFrameData.warnInfo.push("离线："+offline);
			     garbageFrameData.warnInfo1.push("溢满报警："+monitorAlarm);
			     garbageFrameData.warnInfo2.push("欠压告警："+lowBatteryAlarm);
			     garbageFrameData.num = deviceTotal; 
			     showDeviceInfo(garbageFrameData);
			}
	
		},
		error : function(req, error, errObj) {
		}
	});
} 

	function buildDiv(data){
		$.each(data,function(i,val){
 		   if (val.catagory == 'LICENSE_PLATE_RECOGNITION_CAMERA') {
                //停车场
                buildParkingDevice(val);
            }else if(val.catagory == 'IOT_ENVIRONMENT') {
                //环境终端
                environmentDeviceDiv(val);
            } else if (val.catagory == 'PARKING_GEOMAGNETISM') {
                //车位地磁
                buildParkingGeomagnetism(val);
                deviceIds.push(val.deviceId);
            } else if (val.catagory == 'FIRE_GATE_GEOMAGNETISM') {
                //消防门地磁
                buildFireGateGeomagnetism(val);
                deviceIds.push(val.deviceId);
            } else if (val.catagory == 'VIDEO' || val.category == 'VIDEO_CAMERA') {
                //人行抓拍//摄像机设备
                showCamera(val);
            } else if( val.catagory == 'TBS-110' ){
            	buildFfDeviceDiv(val);
            } else if( val.catagory == 'IOT_TRASHCAN' ){
            	//垃圾桶
            	buildGarbageDeviceDiv(val);
            } else if ( val.catagory == 'IOT_MANHOLECOVER') {
                //井盖
                buildManholeCover(val);
                manholeCoverDeviceIds.push(val.deviceId);
            } else if ( val.catagory == 'IOT_ELECTRICITY_METER') {
                //电表
                buildElectricityDeviceDiv(val);
            }

		})

        if(deviceIds.length != 0){
            changeGeomagnetism();
        }
        if(manholeCoverDeviceIds.length != 0){
            changeManholeCover();
        }

        videoFrameData.normalInfo.push("正常：" + videoFrameData.num);
		videoFrameData.warnInfo.push("异常：0");
        showDeviceInfo(videoFrameData);

        getParkingDeviceAlarmInfo();

        getFireDeviceAlarmInfo();

        getManholeCoverAlarmInfo();
        initFaceCanvas();
	}
	
	function deviceElectricityData(deviceId){
		var location = "-   -";
		$.ajax({
            type : "post",
            url : ctx + "/device/manage/getDeviceDTOByDeviceId?deviceId="+deviceId,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                    if(data){
                    	location = data.data.locationName;
                    }                
            },
            error : function(req, error, errObj) {
            }
        });
		
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceId?deviceId="+deviceId,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                	var deviceStatus = data.data.deviceStatus==1?"异常":"正常";
                	var deviceType = "-   -";
                	if(data.data.deviceType != null){
                		deviceType = data.data.deviceType;
                	}
                    var popBoxInfo = {
                        deviceId: deviceId,
                        title: data.data.deviceName,
                        popImg: "${ctx}/static/img/operationManagerScreenPage/dianbiao.svg",
                        showInfo:["设备编号："+data.data.deviceNo,"设备类型："+deviceType,"位置信息："+location,"设备状态："+deviceStatus]
                    };
                    popDeviceInfo(popBoxInfo);
                }
            },
            error : function(req, error, errObj) {
            }
        });
    }
	
	//电表
	function buildElectricityDeviceDiv(data){
		var eleName = "ELE_NAME";
		var normal = "${ctx}/static/img/operationManagerScreenPage/dianbiaozhengchang.svg";
		var abNormal = "${ctx}/static/img/operationManagerScreenPage/lixiandianbiao.svg";
		var dbDiv = '<div id="db-device-'+data.deviceId+'"  style="left: '+data.xCoordinate+'px; top:'+data.yCoordinate+'px;width:30px;height:30px; position: absolute;cursor:pointer;">'+
		 '<img  id = "db-'+data.deviceId+'" name = "'+ eleName+'" onclick="deviceElectricityData(' + data.deviceId + ')" src ="'+normal+'" />'+
		 '</div>'
		 +'<div id="dby-device-'+data.deviceId+'"  style="left: '+(data.xCoordinate-(-23))+'px; top:'+(data.yCoordinate-(-45))+'px;width:30px;height:30px; position: absolute;cursor:pointer;display:none;">'+
		 '<img  id = "dby-'+data.deviceId+'"  onclick="deviceElectricityData(' + data.deviceId + ')" src ="'+abNormal+'" />'+
		 '</div>';
		$("#page-box").append(dbDiv);
		
		var x1 = data.xCoordinate - (-3);
		var y1 = data.yCoordinate - (-8);
		var qpDiv = '<div id="db-div-'+data.deviceId+'" class="env_ele_bubble" id="env_ele_bubble" style="left: '+x1+'px; top:'+y1+'px;z-index: 3;text-align: center; font-size: 12px; color: rgb(255, 255, 255);">'
		+'<span id="db-span-'+data.deviceId+'" style="text-align: center;font-size: 16px;color: #FFFFFF;line-height: 18px;">'
		+ "-   -"
		+'</span><span id="db-span1-'+data.deviceId+'" style="font-size: 14px;color: #FFFFFF;letter-spacing: 0;text-align: right;line-height: 14px;">kwh</span></div>'
			
	    $("#page-box").append(qpDiv);
		
		$("#db-device-"+data.deviceId).data("location", data.locationName);
		$("#db-device-"+data.deviceId).data("deviceNumber", data.deviceNumber);
		buildRunElectricityDeviceData(data.deviceId);
	}
	
	function changColor(){
		var normal = "${ctx}/static/img/operationManagerScreenPage/dianbiaozhengchang.svg";
		var abnormal = "${ctx}/static/img/operationManagerScreenPage/dianbiaoyichang.svg";
		if(type == 1){
		   $("[name='ELE_NAME']").attr('src',abnormal);
		   type = 2;
		}else if(type == 2){
			$("[name='ELE_NAME']").attr('src',normal);
			type = 1;
		}
		
	}
	
	function buildRunElectricityDeviceData(deviceId){
		  $.ajax({
		        type : "post",
		        url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceId?deviceId="+deviceId,
		        dataType : "json",
		        async: false,
		        contentType : "application/json;charset=utf-8",
		        success : function(data) {
		        	if (data && data.msg == "success") {
		        		var idName = "#db-span-"+deviceId;
		        		$(idName).html(data.data.monitorValue);
		        		buildElectricityRunDiv(data);
		        	}
		        },
		        error : function(req,error, errObj) {
		            return;
		            }
		        });	
	}
	
	function buildElectricityRunDiv(data){
		var deviceId = data.data.deviceId;
		var deviceStatus = data.data.deviceStatus;
		if(deviceStatus == 1){
			$("#dby-device-"+deviceId).show();
			$("#db-device-"+deviceId).hide();
			/* $("#db-div-"+deviceId).css('display','none'); */
			$("#db-span-"+deviceId).hide();
			$("#db-span1-"+deviceId).hide();
		}
	}
	
	//垃圾桶
	function buildGarbageDeviceDiv(data){
		var garbageNormal = "${ctx}/static/img/operationManagerScreenPage/lajitongzhengchang.svg";
		var ljDiv = '<div id="lj-device-'+data.deviceId+'"  style="left: '+data.xCoordinate+'px; top:'+data.yCoordinate+'px;width:30px;height:30px; position: absolute;cursor:pointer;">'+
		 '<img  id = "lj-'+data.deviceId+'" name = "'+ data.deviceId+'" onclick="deviceGarbageData(' + data.deviceId + ')" src ="'+garbageNormal+'" />'+
		 '</div>';
		$("#page-box").append(ljDiv);
		$("#lj-device-"+data.deviceId).data("location", data.locationName);
		$("#lj-device-"+data.deviceId).data("deviceNumber", data.deviceNumber);
		buildRunGarbageDeviceData(data.deviceId);
	}
	
	//环境终端
	function environmentDeviceDiv(data){
		var garbageNormal = "${ctx}/static/img/operationManagerScreenPage/huanjingzhengchang.svg";
		var hjDiv = '<div id="hj-device-'+data.deviceId+'"  style="left: '+data.xCoordinate+'px; top:'+data.yCoordinate+'px;width:30px;height:30px; position: absolute;cursor:pointer;">'+
		 '<img  id = "hj-'+data.deviceId+'" name = "'+ data.deviceId+'" onclick="deviceEnvironmentData(' + data.deviceId + ')" src ="'+garbageNormal+'" />'+
		 '</div>';
		 $("#page-box").append(hjDiv);
		 var x1 = data.xCoordinate - 280;
		 var x2 = data.xCoordinate - 80;
		 var x3 = data.xCoordinate - 40;
		 var y1 = data.yCoordinate -180;
		 var y2 = data.yCoordinate -80;
		 var y3 = data.yCoordinate -40;
		 var qpDiv = '<div class="env_bubble" id="env_bubble" style="left: '+x1+'px; top:'+y1+'px;z-index: 3; font-size: 12px; color: rgb(255, 255, 255); cursor: pointer;display: none;">'
			+'<div id="pm25" style="z-index: 1; width: 280px; font-size: 12px;height: 90px; text-align: center; padding-top: 40px;margin-left: -10px;">PM2.5：'
			+'<span id="pm-'+data.deviceId+'" style="font-size: 20px;letter-spacing: 0.91px;">'
			+ pmNum
			+'</span>μg/m3</div>'
		    +'<div id="pollution-'+data.deviceId+'" style="z-index: 1; width: 80px; height: 24px; border-radius: 91px;text-align: center;padding-top:3px;margin-top: -10px;margin-left: 90px;background-color:'+hjcolor+'">'
		    + pollution
		    +'</div></div>'
	        +'<div class="env_bubble_big" id="env_bubble_big" style="left: '+x2+'px; top:'+y2+'px;display: none;"></div>'
	        +'<div class="env_bubble_small" id="env_bubble_small" style="left: '+x3+'px; top:'+y3+'px;display: none;"></div>'
			
	        $("#page-box").append(qpDiv);
		
		$("#hj-device-"+data.deviceId).data("location", data.locationName);
		$("#hj-device-"+data.deviceId).data("deviceNumber", data.deviceNumber);
		buildEnvironmentDeviceData(data.deviceId);
	}
	
	function showEnvDiv() {
		setTimeout(function() {// 2秒后显示ʾ
			$("#env_bubble_small").fadeIn();
		}, 1000);
		setTimeout(function() {// 2秒后显示ʾ
			$("#env_bubble_big").fadeIn();
		}, 1500);
		setTimeout(function() {// 6秒后显示ʾ
			$("#env_bubble").fadeIn();
			$("#pm25").fadeIn();
			$("#co2").fadeIn();
			$("#co2RealTimeOutDoor").fadeIn();
			$("#pm25RealTimeOutDoor").fadeIn();
		}, 2000);
	}

	function removeEnvDiv() {
		setTimeout(function() {// 2秒后消失
			$("#co2RealTimeOutDoor").fadeOut();
			$("#pm25RealTimeOutDoor").fadeOut();
			$("#env_bubble").fadeOut();
			$("#env_bubble_big").fadeOut();
			$("#env_bubble_small").fadeOut();
			$("#pm25").fadeOut();
			$("#co2").fadeOut();
		}, 5000);
	}
	
	function buildEnvironmentDeviceData(deviceId){
		  $.ajax({
		        type : "post",
		        url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceId?deviceId="+deviceId,
		        dataType : "json",
		        async: false,
		        contentType : "application/json;charset=utf-8",
		        success : function(data) {
		        	if (data && data.msg == "success") {
		        		buildEnvironmentRunDiv(data);
		        	}
		        },
		        error : function(req,error, errObj) {
		            return;
		            }
		        });	
	}
	
	function buildEnvironmentRunDiv(data){
		var deviceId = data.data.deviceId;
		var deviceStatus = data.data.deviceStatus;
		if(deviceStatus == 1){
			var url  = "${ctx}/static/img/operationManagerScreenPage/huanjinglixian.svg"
		}else{
			var url  = "${ctx}/static/img/operationManagerScreenPage/huanjingzhengchang.svg"
		}
	    $("#hj-"+deviceId).attr('src', url);
	}
	
	function deviceEnvironmentData(deviceId){
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceId?deviceId="+deviceId,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                	var deviceStatus = data.data.deviceStatus==1?"异常":"正常";
                	var monitorValue = data.data.monitorValue;
                	if(monitorValue ==null || monitorValue == ""){
                		monitorValue = "-   -" 
       				 }
                	var pollution = "-   -";
                	if(monitorValue<35){
                		pollution = "优";
    				}else if(monitorValue == "" || monitorValue == null){
     					pollution = "-   -";
     				}else if(35<=monitorValue && monitorValue<75){
    					pollution = "良";
    				}else if(75<=monitorValue && monitorValue<115){
    					pollution = "轻度污染";
    				}else if(115<=monitorValue && monitorValue<150){
    					pollution = "中度污染";
    				}else if(150<=monitorValue && monitorValue<250){
    					pollution = "重度污染";
    				}else if(250<=monitorValue){
    					pollution = "严重污染";
    				}
                    var popBoxInfo = {
                        deviceId: deviceId,
                        title: data.data.deviceName,
                        popImg: "${ctx}/static/img/operationManagerScreenPage/huanjing.png",
                        showInfo:["设备编号："+data.data.deviceNo,"设备名称："+data.data.deviceName,"在线状态："+deviceStatus,"PM2.5："+monitorValue,
                                  "污染等级："+pollution]
                    };
                    popDeviceInfo(popBoxInfo);
                }
            },
            error : function(req, error, errObj) {
            	
            }
        });
        
    }
	
	function deviceGarbageData(deviceId){
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceId?deviceId="+deviceId,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
            	
                if (data && data.msg == "success") {
                	var deviceStatus = data.data.deviceStatus==1?"异常":"正常";
                	var monitorStatus = data.data.monitorStatus==1?"异常":"正常";
                	var lowBatteryStatus = data.data.lowBatteryStatus==1?"异常":"正常";
                    var popBoxInfo = {
                        deviceId: deviceId,
                        title: data.data.deviceName,
                        popImg: "${ctx}/static/img/operationManagerScreenPage/lajitong.png",
                        showInfo:["设备编号："+data.data.deviceNo,"设备名称："+data.data.deviceName,"在线状态："+deviceStatus,"满溢状态："+monitorStatus,
                                  "电压状态："+lowBatteryStatus]
                    };
                    popDeviceInfo(popBoxInfo);
                }
            },
            error : function(req, error, errObj) {
            }
        });
    }
	
	function buildRunGarbageDeviceData(deviceId){
		  $.ajax({
		        type : "post",
		        url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceId?deviceId="+deviceId,
		        dataType : "json",
		        async: false,
		        contentType : "application/json;charset=utf-8",
		        success : function(data) {
		        	if (data && data.msg == "success") {
		        		buildGarbageRunDiv(data);
		        	}
		        },
		        error : function(req,error, errObj) {
		            return;
		            }
		        });	
	}
	
	function buildGarbageRunDiv(data){
		var url = "${ctx}/static/img/operationManagerScreenPage/lajitongzhengchang.svg";
		var deviceId = data.data.deviceId;
		var deviceStatus = data.data.deviceStatus;
		var lowBatteryStatus = data.data.lowBatteryStatus;
		var monitorStatus = data.data.monitorStatus;
		if(deviceStatus == 1){
			url = "${ctx}/static/img/operationManagerScreenPage/lajitonglixian.svg"
		}else{
			if(monitorStatus == 1){
				url = "${ctx}/static/img/operationManagerScreenPage/lajitonggaojing.svg"
			}else{
				if(lowBatteryStatus == 1){
					url = "${ctx}/static/img/operationManagerScreenPage/lajitongbaojing.svg"
				}
			}
		}
	    $("#lj-"+deviceId).attr('src', url);
	}

	function changeGeomagnetism(){
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceIds?deviceIds="+deviceIds,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                   $.each(data.data,function(i,val){
                       var direction = $("#"+val.deviceId).attr('direction');
                       if(direction == "H"){
                           if(val.lowBatteryStatus == 0 && val.monitorStatus == 0){
                               $("#"+val.deviceId).attr('src', parkingGeomagnetismPictureList.NuNH);
                           }else if(val.lowBatteryStatus == 0 && val.monitorStatus == 1){
                               $("#"+val.deviceId).attr('src', parkingGeomagnetismPictureList.UNH);
                           }else if(val.lowBatteryStatus == 1 && val.monitorStatus == 0){
                               $("#"+val.deviceId).attr('src', parkingGeomagnetismPictureList.NuAbNH);
                           }else if(val.lowBatteryStatus == 1 && val.monitorStatus == 1){
                               $("#"+val.deviceId).attr('src', parkingGeomagnetismPictureList.UAbNH);
                           }
                       }else if(direction == "V"){
                           if(val.lowBatteryStatus == 0 && val.monitorStatus == 0){
                               $("#"+val.deviceId).attr('src', parkingGeomagnetismPictureList.NuNV);
                           }else if(val.lowBatteryStatus == 0 && val.monitorStatus == 1){
                               $("#"+val.deviceId).attr('src', parkingGeomagnetismPictureList.UNV);
                           }else if(val.lowBatteryStatus == 1 && val.monitorStatus == 0){
                               $("#"+val.deviceId).attr('src', parkingGeomagnetismPictureList.NuAbNV);
                           }else if(val.lowBatteryStatus == 1 && val.monitorStatus == 1){
                               $("#"+val.deviceId).attr('src', parkingGeomagnetismPictureList.UAbNV);
                           }
                       }else{
                           if(val.deviceStatus == 1){
                               $("#"+val.deviceId).attr('src', fireGateGeomagnetismPictureList.OL);
                           }else if(val.deviceStatus == 0){
                               if(val.monitorStatus == 1){
                                   $("#"+val.deviceId).attr('src', fireGateGeomagnetismPictureList.AbN);
                               }else if(val.monitorStatus == 0 && val.lowBatteryStatus == 1){
                                   $("#"+val.deviceId).attr('src', fireGateGeomagnetismPictureList.LB);
                               }else{
                                   $("#"+val.deviceId).attr('src', fireGateGeomagnetismPictureList.N);
                               }
                           }
                       }
                    });
                }
            },
            error : function(req, error, errObj) {
            }
        });
    }

    function changeManholeCover(){
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceIds?deviceIds="+manholeCoverDeviceIds,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                    $.each(data.data,function(i,val){
                        if(val.deviceStatus == 1){
                            $("#"+val.deviceId).attr('src', manholeCoverPictureList.OL);
                        }else if(val.deviceStatus == 0){
                            if(val.monitorStatus == 1){
                                $("#"+val.deviceId).attr('src', manholeCoverPictureList.M);
                            }else if(val.monitorStatus == 0 && val.lowBatteryStatus == 1){
                                $("#"+val.deviceId).attr('src', manholeCoverPictureList.LB);
                            }else{
                                $("#"+val.deviceId).attr('src', manholeCoverPictureList.N);
                            }
                        }
                    });
                }
            },
            error : function(req, error, errObj) {
            }
        });
    }
	
	//获取车库地磁设备欠压报警数、 总数、正常统计数量
	function getParkingDeviceAlarmInfo(){
        var videoFrameData1 = {
            deviceType: 'PARKING_GEOMAGNETISM',
            icon: "${ctx}/static/img/geomagnetism/ParkingGeomagnetismBig.svg",
            num: 0,
            num1: 0,
            num2: 0,
            num3: 0,
            numDesc: "车位地磁总数",
            normalInfo: [],
            warnInfo: [],
            warnInfo1: []
        };
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getDeviceAlarmInfoByDeviceTypeCode?deviceTypeCode="+"PARKING_GEOMAGNETISM"+"&projectCode="+projectCode,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                    videoFrameData1.num = data.data.deviceTotal;
                    videoFrameData1.num1 = data.data.noraml;
                    videoFrameData1.num2 = data.data.offline;
                    videoFrameData1.num3 = data.data.lowBatteryAlarm;

                    videoFrameData1.normalInfo = ["正常：" + videoFrameData1.num1];
                    videoFrameData1.warnInfo = ["离线：" + videoFrameData1.num2];
                    videoFrameData1.warnInfo1 = ["欠压报警：" + videoFrameData1.num3];
                    showDeviceInfo(videoFrameData1);
                }
            },
            error : function(req, error, errObj) {
            }
        });
	}

    //获取消防门地磁设备欠压报警数、 总数、正常统计数量
    function getFireDeviceAlarmInfo(){
        var videoFrameData2 = {
            deviceType: 'FIRE_GATE_GEOMAGNETISM',
            icon: "${ctx}/static/img/geomagnetism/FireGateGeomagnetismBig.svg",
            num: 0,
            num1: 0,
            num2: 0,
            num3: 0,
            num4: 0,
            numDesc: "消防门地磁总数",
            normalInfo: [],
            warnInfo: [],
            warnInfo1: [],
            warnInfo2: []
        };
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getDeviceAlarmInfoByDeviceTypeCode?deviceTypeCode="+"FIRE_GATE_GEOMAGNETISM"+"&projectCode="+projectCode,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                    videoFrameData2.num = data.data.deviceTotal;
                    videoFrameData2.num1 = data.data.noraml;
                    videoFrameData2.num2 = data.data.lowBatteryAlarm;
                    videoFrameData2.num3 = data.data.monitorAlarm;
                    videoFrameData2.num4 = data.data.offline;

                    videoFrameData2.normalInfo = ["正常：" + videoFrameData2.num1];
                    videoFrameData2.warnInfo = ["欠压报警：" + videoFrameData2.num2];
                    videoFrameData2.warnInfo1 = ["通道堵塞：" + videoFrameData2.num3];
                    videoFrameData2.warnInfo2 = ["离线：" + videoFrameData2.num4];
                    showDeviceInfo(videoFrameData2);
                }
            },
            error : function(req, error, errObj) {
            }
        });
    }

    //获取井盖设备欠压报警，总数，正常数，倾斜告警数
    function getManholeCoverAlarmInfo(){
        var manholeCoverFrameData = {
            deviceType: 'IOT_MANHOLECOVER',
            icon: "${ctx}/static/img/geomagnetism/ManholeCoverBig.svg",
            num: 0,
            num1: 0,
            num2: 0,
            num3: 0,
            num4: 0,
            numDesc: "井盖",
            normalInfo: [],
            warnInfo: [],
            warnInfo1: [],
            warnInfo2: []
        };
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getDeviceAlarmInfoByDeviceTypeCode?deviceTypeCode="+"IOT_MANHOLECOVER"+"&projectCode="+projectCode,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                    manholeCoverFrameData.num = data.data.deviceTotal;
                    manholeCoverFrameData.num1 = data.data.noraml;
                    manholeCoverFrameData.num2 = data.data.offline;
                    manholeCoverFrameData.num3 = data.data.monitorAlarm;
                    manholeCoverFrameData.num4 = data.data.lowBatteryAlarm;

                    manholeCoverFrameData.normalInfo = ["正常：" + manholeCoverFrameData.num1];
                    manholeCoverFrameData.warnInfo = ["离线：" + manholeCoverFrameData.num2];
                    manholeCoverFrameData.warnInfo1 = ["倾斜报警：" + manholeCoverFrameData.num3];
                    manholeCoverFrameData.warnInfo2 = ["欠压告警：" + manholeCoverFrameData.num4];
                    showDeviceInfo(manholeCoverFrameData);
                }
            },
            error : function(req, error, errObj) {
            }
        });
    }

//消防烟感
function buildFfDeviceDiv(data){
	var smokeNormal = "${ctx}/static/img/operationManagerScreenPage/smokeNormal.svg";
	var ffDiv = '<div id="f-device-'+data.deviceId+'"  style="left: '+data.xCoordinate+'px; top:'+data.yCoordinate+'px;width:30px;height:30px; position: absolute;cursor:pointer;">'+
	 '<img  id = "f-'+data.deviceId+'" name = "'+ data.deviceId+'" onclick="deviceRunData(this,event)" src ="'+smokeNormal+'" />'+
	 '</div>';
	$("#page-box").append(ffDiv);
	$("#f-device-"+data.deviceId).data("location", data.locationName);
	$("#f-device-"+data.deviceId).data("deviceNumber", data.deviceNumber);
	buildRunFfDeviceData(data.deviceId);
}
function buildRunFfDeviceData(deviceId){
	  $.ajax({
	        type : "post",
	        url : "${ctx}/fire-fighting/fireAlarmSystem/getDeviceRealTimeData?projectCode="+projectCode+"&deviceId="+deviceId,
	        dataType : "json",
	        async: false,
	        contentType : "application/json;charset=utf-8",
	        success : function(data) {
	        	if(data){
	        		buildFfRunDiv(data);
	        	}
	        },
	        error : function(req,error, errObj) {
	            return;
	            }
	        });	
}
function buildFfRunDiv(data){
	var smokeUnNormal = "${ctx}/static/img/operationManagerScreenPage/smokeUnNormal.svg";
    var smokeOtherUnNormal = "${ctx}/static/img/operationManagerScreenPage/smokeOtherUnNormal.svg";
    var smokeOffline = "${ctx}/static/img/operationManagerScreenPage/smokeOffline.svg";

	var deviceId = data.deviceId;
	var comFlag = data.comFlag;
	var fireStatus = data.fireStatus;
 	var slba = data.slba;
 	var slfa = data.slfa;
 	var soa = data.slfa;
 	var tpa = data.tpa;

	if(comFlag == 1){
        $("#f-"+deviceId).attr('src', smokeOffline);
    }else{
	    if(fireStatus == 1){
            $("#f-"+deviceId).attr('src', smokeUnNormal);
        }else{
	        if(slba == 1 || slfa == 1 || soa == 1 || tpa==1){
                $("#f-"+deviceId).attr('src', smokeOtherUnNormal);
            }
        }
    }
}
//停车场
function buildParkingDevice(data){
	var snapshotLeft="${ctx}/static/img/operationManagerScreenPage/snapshotLeft.svg";
	var snapshotRight = "${ctx}/static/img/operationManagerScreenPage/snapshotRight.svg";
	var img;
	var deviceId = data.deviceId;
	var coordinateName = data.coordinateName;
	var deviceIcon = data.deviceIcon;
	if(deviceIcon==1){
		img=snapshotLeft;
	}else{
		img = snapshotRight;
	}
	var parkingDiv = '<div id="p-device-'+deviceId+'"  style="left: '+data.xCoordinate+'px; top:'+data.yCoordinate+'px;width:30px;height:200px; position: absolute;cursor:pointer;">'+
					 '<img name = "'+ data.locationName+'" onclick="historyRecord(this,event)" src ="'+img+'" />'+
					 '</div>';
	$("#page-box").append(parkingDiv);

}

    function showCamera(data) {
        videoFrameData.num++;
        var deviceId = data.deviceId;
        if(!data || !data.deviceIcon){
            return;
        }
        var iconType = JSON.parse(data.deviceIcon);
        if(!iconType){
            return;
        }
        var icon = iconType.icon;
        deviceIconMap.put(deviceId,icon);
        if (data.status == "0"){
        	//数据只配置摄像机方向，页面设置在线离线 +“O”表示离线
        	icon = icon+"O";
        	
        } 
	    deviceStatusMap.put(deviceId,data.status);
        
        var iconUrl = videoIconList[icon];
        if (!iconUrl) { 
            iconUrl = "${ctx}/static/images/zaixian.svg";
        }
        if(iconType.icon=="F"){
        	$("#page-box").append('<div id = camera-'+data.deviceId+' style="position: absolute;width:20px;height:20px;cursor: pointer;margin-left: ' + data.xCoordinate + 'px; margin-top: ' + data.yCoordinate + 'px;" onclick="showHisRecord(' + iconType.passageId + ')">' +
                    '<img src="' + iconUrl + '" style="width: 25px;height: 25px;"/>' +
                    '<div class="" id="tangan"></div>'+
                    '</div>');
        }else{
        	$("#page-box").append('<div id = camera-'+data.deviceId+' style="position: absolute;width:20px;height:20px;cursor: pointer;left: ' + data.xCoordinate + 'px; top: ' + data.yCoordinate + 'px;" onclick="showVideo(' + data.deviceId + ')">' +
                    '<img id = camera-img-'+data.deviceId+'  src="' + iconUrl + '" style="width: 25px;height: 25px;"/>' +
                    '</div>');
        }
        

    }

    function showVideo(deviceId) {
        videoListManageData.row.deviceId = deviceId;
        var status = deviceStatusMap.get(deviceId+"");
        if(status == "0"){
        	$(".access-monitoring-menu").remove();
        	var str="<div class = 'access-monitoring-menu' id='accessMonitoring"+deviceId+"' style='background-image: url(\"${ctx}/static/img/access-control/Rectangle7.png\");width:150px;height:30px;z-index:2;box-shadow: 0 6px 12px rgba(0,0,0,.175);margin-left:-50px;margin-top: 10px;'>"
    		+ '<span class="popover_text"  style="margin-top: 10px;font-size: 12px;color: #FFFFFF;line-height:30px;margin-left:8px">摄像机离线，请尽快处理</span>'
    		+ "</div>";
    		$("#camera-"+deviceId).append(str);
    		$("#camera-"+deviceId).hover( function () {
    	   	 	$(".access-monitoring-menu").remove();
    	    });
        	return;
        }
        $.ajax({
            type: "post",
            url: "${ctx}/device/manage/getDeviceChannel/" + deviceId,
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                if (!data) {
                    return;
                }
                videoListManageData.row.channel = data;
            },
            error: function (req, error, errObj) {
            }

        });
        var options = {
            modalDivId: "show-video",
            width: 820,
            height: 560,
            title: "查看视频",
            url: "videomonitoring/showVideo1?CHECK_AUTHENTICATION=false",
            footerType: "user-defined",
            oriMarginTop: 180,
            footerButtons: []
        };
        createModalWithLoadOptions(options);
        openModal("#show-video-modal", false, false);
    }

    //车位地磁
    function buildParkingGeomagnetism(val) {
        var url = '';
        var deviceIcon = JSON.parse(val.deviceIcon);
        if(deviceIcon.icon == 'V'){//竖向车位
            url = parkingGeomagnetismPictureList.NuNV;
            $("#page-box").append('<div style="position: absolute;width: 20px;height: 40px;cursor: pointer;" onclick="showParkingGeomagnetism(' + val.deviceId + ')">' +
                '<img id='+ val.deviceId +' src="' + url + '" style="width: 20px;height: 40px;margin-left: ' + val.xCoordinate + 'px; margin-top: ' + val.yCoordinate + 'px;"/>' +
                '</div>');
            $("#"+val.deviceId).attr('direction', "V");
        }else if(deviceIcon.icon == 'H'){//横向车位
            url = parkingGeomagnetismPictureList.NuNH;
            $("#page-box").append('<div style="position: absolute;width: 40px;height: 20px;cursor: pointer;" onclick="showParkingGeomagnetism(' + val.deviceId + ')">' +
                '<img id='+ val.deviceId +' src="' + url + '" style="width: 40px;height: 20px;margin-left: ' + val.xCoordinate + 'px; margin-top: ' + val.yCoordinate + 'px;"/>' +
                '</div>');
            $("#"+val.deviceId).attr('direction', "H");
        }
    }

    function showParkingGeomagnetism(deviceId){
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceId?deviceId="+deviceId,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                    var parkingName = '';
                    if(data.data.monitorStatus == 0){
                        parkingName = '空闲';
                    }else if(data.data.monitorStatus == 1){
                        parkingName = '占用';
                    }
                    var lowBatteryName = '';
                    if(data.data.lowBatteryStatus == 0){
                        lowBatteryName = '正常';
                    }else if(data.data.lowBatteryStatus == 1){
                        lowBatteryName = '欠压';
                    }
                    var popBoxInfo = {
                        deviceId: deviceId,
                        title: data.data.deviceName,
                        popImg: "${ctx}/static/img/geomagnetism/diciNew.png",
                        showInfo:["设备编号："+data.data.deviceNo,"设备类型："+data.data.deviceType,"占用状态："+parkingName,"低电压状态："+lowBatteryName]
                    };
                    popDeviceInfo(popBoxInfo);
                }
            },
            error : function(req, error, errObj) {
            }
        });
    }

    //消防门地磁
    function buildFireGateGeomagnetism(val) {
        var url = fireGateGeomagnetismPictureList.N;
        $("#page-box").append('<div style="position: absolute;width:20px;height:40px;cursor: pointer;" onclick="showFireGateGeomagnetism(' + val.deviceId + ')">' +
            '<img id='+ val.deviceId +' src="' + url + '" style="width: 20px;height: 40px;margin-left: ' + val.xCoordinate + 'px; margin-top: ' + val.yCoordinate + 'px;"/>' +
            '</div>');
    }

    function showFireGateGeomagnetism(deviceId){
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceId?deviceId="+deviceId,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                    var lowBatteryName = '';
                    if(data.data.lowBatteryStatus == 0){
                        lowBatteryName = '正常';
                    }else if(data.data.lowBatteryStatus == 1){
                        lowBatteryName = '欠压';
                    }
                    var monitorStatus = '';
                    if(data.data.monitorStatus == 0){
                        monitorStatus = '正常';
                    }else if(data.data.monitorStatus == 1){
                        monitorStatus = '堵塞';
                    }
                    var popBoxInfo = {
                        deviceId: deviceId,
                        title: data.data.deviceName,
                        popImg: "${ctx}/static/img/geomagnetism/diciNew.png",
                        showInfo:["设备编号："+data.data.deviceNo,"设备类型："+data.data.deviceType,"低电压状态："+lowBatteryName,"堵塞状态："+monitorStatus]
                    };
                    popDeviceInfo(popBoxInfo);
                }
            },
            error : function(req, error, errObj) {
            }
        });
    }

    function buildManholeCover(val){
        var url = manholeCoverPictureList.N;
        $("#page-box").append('<div style="position: absolute;width:30px;height:30px;cursor: pointer;" onclick="showManholeCover(' + val.deviceId + ')">' +
            '<img id='+ val.deviceId +' src="' + url + '" style="width: 30px;height: 30px;margin-left: ' + val.xCoordinate + 'px; margin-top: ' + val.yCoordinate + 'px;"/>' +
            '</div>');
    }

    function showManholeCover(deviceId){
        $.ajax({
            type : "post",
            url : ctx + "/fire-fighting/iotSensorManage/getIotSensorRecordByDeviceId?deviceId="+deviceId,
            async : false,
            dataType : "json",
            contentType : "application/json;charset=utf-8",
            success : function(data) {
                if (data && data.msg == "success") {
                    var deviceStatus = '';
                    if(data.data.deviceStatus == 0){
                        deviceStatus = '正常';
                    }else if(data.data.deviceStatus == 1){
                        deviceStatus = '离线';
                    }
                    var lowBatteryName = '';
                    if(data.data.lowBatteryStatus == 0){
                        lowBatteryName = '正常';
                    }else if(data.data.lowBatteryStatus == 1){
                        lowBatteryName = '欠压';
                    }
                    var monitorStatus = '';
                    if(data.data.monitorStatus == 0){
                        monitorStatus = '正常';
                    }else if(data.data.monitorStatus == 1){
                        monitorStatus = '倾斜';
                    }
                    var popBoxInfo = {
                        deviceId: deviceId,
                        title: data.data.deviceName,
                        popImg: "${ctx}/static/img/geomagnetism/jinggai.png",
                        showInfo:["设备编号："+data.data.deviceNo,"设备类型："+data.data.deviceType,"设备状态："+deviceStatus,"低电压状态："+lowBatteryName,"倾斜状态："+monitorStatus]
                    };
                    popDeviceInfo(popBoxInfo);
                }
            },
            error : function(req, error, errObj) {
            }
        });
    }

    function initDeviceInoFrame(){
        videoFrameData.num++;
	    $.each(deviceInfos,function(i,val){
            var deviceInfoId = "deviceInfo" + val;
	        $("#show-device-info").append('<div id="' + deviceInfoId + '" class="device-info"></div>');
        });
    }

 function showDeviceInfo(data) {
        if (!data.deviceType) {
            return;
        }
        if(data.deviceType == 'VIDEO_CAMERA'){
            data.deviceType = 'VIDEO';
        }
        var icon = data.icon ? "<img src = '" + data.icon + "' style='width:45px;height:45px'/>" : "无图";
        var num = data.num ? data.num : 0;
        var numDesc = data.numDesc ? data.numDesc : "无描述信息";
        var normalInfo = data.normalInfo ? data.normalInfo.length > 0 ? data.normalInfo : [] : [];
        var warnInfo = data.warnInfo ? data.warnInfo.length > 0 ? data.warnInfo : [] : [];
     	var warnInfo1 = data.warnInfo1 ? data.warnInfo1.length > 0 ? data.warnInfo1 : [] : [];
        var warnInfo2 = data.warnInfo2 ? data.warnInfo2.length > 0 ? data.warnInfo2 : [] : [];

        var normalInfoHtml = "";
        var warnInfoHtml = "";
        var warnInfo1Html = "";
        var warnInfo2Html = "";
        $.each(normalInfo, function (i, val) {
            normalInfoHtml += '<div id = "nor-'+data.deviceType+'" style="font-size: 12px;color: #FFFFFF;height:20px">' + val + '</div>';
        });
        $.each(warnInfo, function (i, val) {
            warnInfoHtml += '<div id = "warn-'+data.deviceType+'" style="font-size: 12px;color: #FF5F5F;height:20px">' + val + '</div>';
        });
		 $.each(warnInfo1, function (i, val) {
			 warnInfo1Html += '<div style="font-size: 12px;color: #FF5F5F;height: 20px;">' + val + '</div>';
		 });
         $.each(warnInfo2, function (i, val) {
             warnInfo2Html += '<div style="font-size: 12px;color: #FF5F5F;height: 20px;">' + val + '</div>';
         });

        var deviceInfoId = "deviceInfo" + data.deviceType;
        if ($("#" + deviceInfoId).length > 0) {
            $("div[id^='"+ deviceInfoId+"']").each(function(){
                $(this).html('<div style="float: left;margin-top: 48px;margin-left: 20px;">' + icon + '</div>' +
                    '<div style="width: 90px;float: left;margin-left: 10px;margin-top: 39px;">' +
                    '<div style="font-size: 33px;color: #50E3C2;text-align: center;height: 40px;">' + num + '</div>' +
                    '<div style="font-size: 12px;color: #FFFFFF;text-align: center;">' + numDesc + '</div>' +
                    '</div>' +
                    '<div style="float: left;margin-top: 40px;margin-left: 10px;">' +
                    normalInfoHtml +
                    warnInfoHtml +
                    warnInfo1Html +
                    warnInfo2Html +
                    '</div>');
            });
        } else {
            $('#show-device-info').append(
                '<div id="' + deviceInfoId + '" class="device-info">' +
                '<div style="float: left;margin-top: 48px;margin-left: 20px;">' + icon + '</div>' +
                '<div style="width: 90px;float: left;margin-left: 10px;margin-top: 39px;">' +
                '<div style="font-size: 33px;color: #50E3C2;text-align: center;height: 40px;">' + num + '</div>' +
                '<div style="font-size: 12px;color: #FFFFFF;text-align: center;">' + numDesc + '</div>' +
                '</div>' +
                '<div style="float: left;margin-top: 40px;margin-left: 10px;">' +
                normalInfoHtml +
                warnInfoHtml +
                warnInfo1Html +
                warnInfo2Html +
                '</div></div>'
            );
        }
        alarmSlide();
    }
 
 function alarmSlide() {
		if ($("#playStateCell").hasClass("pauseState")) {
			$("#playStateCell").removeClass("pauseState");
		}
		$("#playStateCell").triggerHandler('click');
		$("#show-device-info-container").unbind();
		$("#playStateCell").unbind();
		$("#show-device-info .clone").remove();
		if ($("#show-device-info-container .tempWrap").length > 0) {
			$("#show-device-info").unwrap();
		}
		$("#show-device-info-container").slide({
			mainCell : "#show-device-info",
			autoPage : true,
			effect : "leftLoop",
			autoPlay : true,
			vis : 6,
			interTime : 3500,
			playStateCell : "#playStateCell"
		});
	}
 
 function getParkingStatistics(){
		$.ajax({
			type : "post",
			url : "${ctx}/parking/parkingQuery/getStatistics?projectCode="+projectCode,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(item) {
				if(item){
					 parkingDevNorNum = item.deviceNormalNum;
					 parkingDevUnNorNum = item.deviceFalutNum;
					 if(typeof(parkingDevNorNum)=="undefined"){
						 parkingDevNorNum =0;
					 }
					 if(typeof(parkingDevUnNorNum)=="undefined"){
						 parkingDevUnNorNum=0;
					 }
				     parkingFrameData.normalInfo.push("正常：" + parkingDevNorNum);
				     parkingFrameData.warnInfo.push("异常："+parkingDevUnNorNum);
				     parkingFrameData.num=parseInt(parkingDevNorNum)+parseInt(parkingDevUnNorNum); 
				     showDeviceInfo(parkingFrameData);
				}
		
			},
			error : function(req, error, errObj) {
			}
		});
	} 
	  function popDeviceInfo(popInfo) {
        var deviceId = popInfo.deviceId;
        if (popInfo.showInfo.length < 0) {
            return;
        }

        var showInfoHtml = "";
        $.each(popInfo.showInfo, function (i, val) {
            showInfoHtml += '<div style="height: 30px;">' + val + '</div>';
        });

        var imgHtml = '<img src="' + popInfo.popImg + '" style="width:100%;height:100%"/>';
        $("#popBox").html('<div class="showPop" id="showPop' + deviceId + '">' +
            '<div style="height: 50px;">' +
            '<div style="width: 28px;height: 28px;float: left;margin-top: 6px;margin-left: 6px;">' +
            '<img style="width: 28px;height: 28px;" src="${ctx}/static/img/video/zuoshangjiao.svg"/>' +
            '</div>' +
            '<div class="popTitle">' + popInfo.title + '</div>' +
            '<div onclick="removePopBox(\'showPop' + deviceId + '\')" style="width: 28px;height: 28px;float: left;margin-top: 12px;cursor: pointer;">' +
            '<img style="width: 20px;height: 20px;" src="${ctx}/static/img/video/close.png"/>' +
            '</div>' +
            '</div>' +
            '<div style="margin-top: 24px;">' +
            '<div style="float: left;width: 160px;border: 0px white solid;height: 200px;margin-left: 40px;">' + imgHtml + '</div>' +
            '<div style="float: left;width: 300px;font-size: 14px;color: #FFFFFF; text-align: left;margin-left: 20px;">' +
            showInfoHtml +
            '</div>' +
            '</div>' +
            '<div style="width: 28px;height: 28px;float: left;margin-top: 236px;margin-left: 10px;">' +
            '<img style="width: 28px;height: 28px;" src="${ctx}/static/img/video/youxiajiao.svg"/>' +
            '</div>' +
            '</div>');
    }

    function removePopBox(elId) {
        $("#" + elId).remove();
    }
 function getFfStatistics(){
     var FfSmokeDevNorNum;
     var FfSmokeDevUnNorNum;
     var FfSmokeDevOtherUnNorNum;
     var FfSmokeDevOfflineNum;
     var smokerFrameData = {
         deviceType: 'TBS-110',
         icon: "${ctx}/static/img/operationManagerScreenPage/out-smoke.svg",
         num: 0,
         numDesc: "户外烟感温感",
         normalInfo: [],
         warnInfo: [],
         warnInfo1: [],
         warnInfo2: []
     };
		$.ajax({
			type : "post",
			url : "${ctx}/fire-fighting/fireOutsideSystem/getDeviceAlarmInfoByDeviceTypeCode?projectCode="+projectCode+"&deviceTypeCode=TBS-110",
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(item) {
				if(item.data){
					FfSmokeDevNorNum = item.data.noraml;
					FfSmokeDevUnNorNum = item.data.monitorAlarm;
                    FfSmokeDevOtherUnNorNum = item.data.lowBatteryAlarm;
                    FfSmokeDevOfflineNum = item.data.offline;
					 if(typeof(FfSmokeDevNorNum)=="undefined"){
						 FfSmokeDevNorNum =0;
					 }
					 if(typeof(FfSmokeDevUnNorNum)=="undefined"){
						 FfSmokeDevUnNorNum=0;
					 }
                    if(typeof(FfSmokeDevOtherUnNorNum)=="undefined"){
                        FfSmokeDevOtherUnNorNum=0;
                    }
                    if(typeof(FfSmokeDevOfflineNum)=="undefined"){
                        FfSmokeDevOfflineNum=0;
                    }
					 smokerFrameData.normalInfo = ["正常：" + FfSmokeDevNorNum];
					 smokerFrameData.warnInfo = ["离线："+FfSmokeDevOfflineNum];
                     smokerFrameData.warnInfo1 = ["火警："+FfSmokeDevUnNorNum];
                     smokerFrameData.warnInfo2 = ["其他告警："+FfSmokeDevOtherUnNorNum];
					 smokerFrameData.num=item.data.deviceTotal;
				     showDeviceInfo(smokerFrameData);
				}
		
			},
			error : function(req, error, errObj) {
			}
		});
	} 
 
 function deviceRunData(data,event){
	 event.stopPropagation();
	 var deviceId = $(data).attr("name");
	  $.ajax({
	        type : "post",
	        url : "${ctx}/fire-fighting/fireAlarmSystem/getDeviceRealTimeData?projectCode="+projectCode+"&deviceId="+deviceId,
	        dataType : "json",
	        async: false,
	        contentType : "application/json;charset=utf-8",
	        success : function(data) {
	        	if(data){
	        		var fireStatus= data.fireStatus==1?"异常":"正常";
 	        	 	var slba = data.slba==1?"异常":"正常";
 	        	 	var slfa = data.slfa==1?"异常":"正常";
 	        	 	var soa = data.soa==1?"异常":"正常";
 	        	 	var tpa = data.tpa==1?"异常":"正常";
 	        	 	var locationName = $("#f-device-"+data.deviceId).data("location");
 	        	 	var deviceNumber = $("#f-device-"+data.deviceId).data("deviceNumber");
 	        		var info = ["设备型号："+deviceNumber,"类型：户外烟感温感","位置信息："+locationName,"火灾报警："+fireStatus,"低电压报警："+slba,
 	        		            "烟感失联报警："+slfa,"无限底座防拆报警："+soa,"独立式温度超限报警："+tpa]
 	        		popBoxInfo.showInfo=info;
 	        		popBoxInfo.title=data.deviceName;
 	        		popDeviceInfo(popBoxInfo);
	        	}
	        },
	        error : function(req,error, errObj) {
	            return;
	            }
	        });	
 }
 /**
	 * 内外网转换
	 */
	function extNetImageMapping(src){
		if(src==null||src==""|| typeof(src) == "undefined"){
			return "";
		}
		var isExtNet = <%=isExtNet%>;
		var imageServerAddress = "<%=imageServerAddress%>";
		var mappingImageAddress = "<%=mappingImageAddress%>";
		if(imageServerAddress == null || imageServerAddress == "" || mappingImageAddress == null || mappingImageAddress == ""){
			return src;
		}
		if(isExtNet){
			var e=new RegExp(imageServerAddress,"g");
			return src.replace(e,mappingImageAddress);
		}
		return src;
	}
 
 function initFaceCanvas(){
	   	document.getElementById('tangan').addEventListener("animationend", function () { //动画结束时事件 
	           console.log("人脸识别图片显示。。。");
	           initFace();
	       }, false);
 }
 function showHisRecord(passageId){
			createModalWithLoad("face-slide-image", 830, "", "人脸识别实时动态", "accessControl/historyFaceImage?passageId="+passageId,"", "close", "","100");
			openModal("#face-slide-image-modal", false, false);
			$('#face-slide-image').on('shown.bs.modal', function () {
				initFaceInfo(1);	
			})
 }
 
</script>
</body>
</html>