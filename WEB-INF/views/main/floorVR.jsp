<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Page-Exit" content="revealTrans(Duration=3,Transition=5)">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script	src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>

<title>西子国际设施运营系统</title>
<style type="text/css">
html {
	font-family: SimHei;
	/* 		overflow:-moz-scrollbars-horizontal;   */
	overflow: -moz-scrollbars-vertical;
}

body {
	margin: 0;
	padding: 0;
}

.oneBack{
	width: 1920px;
	height: 1080px;
	background-image:
		url('${ctx}/static/images/operator-system/oneFloorVR.png');
	position: absolute;
	left: 0px;
	top: 0px;
}
.gOneBack{
	width: 1920px;
	height: 1080px;
	background-image:
		url('${ctx}/static/images/operator-system/gFloorVR.png');
	position: absolute;
	left: 0px;
	top: 0px;
}
.bOneBack{
	width: 1920px;
	height: 1080px;
	background-image:
		url('${ctx}/static/images/operator-system/bOneFloorVR.png');
	position: absolute;
	left: 0px;
	top: 0px;
}
.threeBack{
	width: 1920px;
	height: 1080px;
	background-image:
		url('${ctx}/static/images/operator-system/threeFloorVR.png');
	position: absolute;
	left: 0px;
	top: 0px;
}
.goBack{
	position: absolute;
	left: 70px;
	top: 70px;
	width: 95.5px;
    height: 108px;
	background-image:
		url('${ctx}/static/images/operator-system/vrgoback.svg');
	z-index: 2;
}
.leftAllFloor{
	position: absolute;
	left: 502px;
	top: 840px;
	z-index: 2;
/* 	opacity:0.4;
	background: rgb(9,162,221); */
}
.leftAllFloor div{
	width: 100px;
	height: 34px;
	font-family: PingFangSC-Regular;
	font-size: 20px;
	color: #56E4FF;
	letter-spacing: 1.3px;
	text-align: center;
	line-height: 34px;
	background: rgb(9,162,221);
	opacity:0.4;
	border: 1px solid #56E4FF;
}
.threeFloorAccess{
    position: absolute;
    left: 861px;
    top: 795px;
    width: 182px;
    height: 69px;
    transform: rotateZ(22.3deg) skew(-33deg);
    transform-origin: 0 0;
    z-index: 2;
}
.oneFloorAccess{
    position: absolute;
    left: 862px;
    top: 856px;
    width: 182px;
    height: 69px;
    transform: rotateZ(22.3deg) skew(-33deg);
    transform-origin: 0 0;
    z-index: 2;
}
.b1FloorBoiler{
    position: absolute;
    left: 750px;
    top: 985px;
    width: 92px;
    height: 65px;
    transform: rotateZ(-36deg) skew(23deg);
    transform-origin: 0 0;
    z-index: 2;
}
.b1FloorBoilerHover {
	position: absolute;
	left: 761px;
	top: 932px;
	width: 128px;
	height: 89px;
    background-image: url('${ctx}/static/images/operator-system/b1-glf-yellow.svg');
    z-index:1
}
.gFloorFireOne {
	position: absolute;
    left: 842px;
    top: 924px;
    width: 120px;
    height: 34px;
    transform: rotateZ(-37deg) skew(28deg);
    transform-origin: 0 0;
    z-index: 2;
}
.gFloorFireTwo {
    position: absolute;
    left: 931px;
    top: 856px;
    width: 124px;
    height: 72.5px;
    transform: rotateZ(-38deg) skew(31deg);
    transform-origin: 0 0;
    z-index: 2;
}
.gFloorParkingOne {
    position: absolute;
    left: 980px;
    top: 913px;
    width: 190px;
    height: 78px;
    transform: rotateZ(-40deg) skew(31deg);
    transform-origin: 0 0;
    z-index: 2;
}
.gFloorParkingTwo {
    position: absolute;
    left: 962px;
    top: 978px;
    width: 134px;
    height: 69px;
    transform: rotateZ(-39deg) skew(28deg);
    transform-origin: 0 0;
    z-index: 2;
}
.gFloorParkingThree {
    position: absolute;
    left: 1011px;
    top: 943px;
    width: 76px;
    height: 90px;
    transform: rotateZ(-39deg) skew(28deg);
    transform-origin: 0 0;
    z-index: 2;
}
.gFloorParkingHover {
	position: absolute;
	left: 972px;
	top: 791px;
	width: 238px;
	height: 217px;
    background-image: url('${ctx}/static/images/operator-system/g-parking-green.svg');
    z-index:1
}
.gFloorFireHover {
	position: absolute;
	left: 843px;
	top: 781px;
	width: 264px;
	height: 160px;
    background-image: url('${ctx}/static/images/operator-system/g-fire-red.svg');
    z-index:1
}

</style>
</head>
<body >
	<div class="goBack" onclick="goBack()"></div>
	<div name="floorBack" class="threeBack">
		<div class="threeFloorAccess" onclick="openBusiSystem('ACCESS3')"></div>
	</div>
	<div name="floorBack" class="oneBack">
		<div class="oneFloorAccess" onclick="openBusiSystem('ACCESS1')"></div>
	</div>
	<div name="floorBack" class="gOneBack">
		<div class="gFloorFireOne" onmouseenter="fireHoverShow()" onmouseleave="fireHoverHide()"  onclick="openBusiSystem('FIRE')"></div>
		<div class="gFloorFireTwo" onmouseenter="fireHoverShow()" onmouseleave="fireHoverHide()" onclick="openBusiSystem('FIRE')"></div>
		<div class="gFloorFireHover" style="display:none"></div>
		<div class="gFloorParkingOne" onmouseenter="parkingHoverShow()" onmouseleave="parkingHoverHide()" onclick="openBusiSystem('PARKING')"></div>
		<div class="gFloorParkingTwo" onmouseenter="parkingHoverShow()" onmouseleave="parkingHoverHide()" onclick="openBusiSystem('PARKING')"></div>
		<div class="gFloorParkingThree" onmouseenter="parkingHoverShow()" onmouseleave="parkingHoverHide()" onclick="openBusiSystem('PARKING')"></div>
		<div class="gFloorParkingHover" style="display:none" ></div>
	</div>
	<div name="floorBack" class="bOneBack">
		<div class="b1FloorBoiler" onmouseenter="havcHoverShow()" onmouseleave="havcHoverHide()"  onclick="openBusiSystem('HAVC')"></div>
		<div class="b1FloorBoilerHover" style="display:none;" ></div>
	</div>
	<div class="leftAllFloor" >
		<div id="selectThreeFloor" name="selectfloor" onclick="goOtherVR('3F')">三层</div>
		<div id="selectOneFloor" name="selectfloor" onclick="goOtherVR('1F')">一层</div>
		<div id="selectGFloor" name="selectfloor" onclick="goOtherVR('G')">G层</div>
		<div id="selectBFloor" name="selectfloor" onclick="goOtherVR('B1')">负一层</div>
	</div>
	<div id="busi-system"></div>
	<div id="hvac_page"></div>
</body>
<script>
	var floor = "${param.floor}";
	var projectCode = "${param.projectCode}";
	var ctx = "${ctx}";
	var projectId = "${param.projectId}";
/* 	if(floor == '1F'){
		$("#selectOneFloor").css("opacity","0.6");
		$(".oneBack").show();
	}else if(floor == '3F'){
		$("#selectThreeFloor").css("opacity","0.6");
		$(".threeBack").show();
	} */
	$(document).ready(function() {
		goOtherVR(floor);
	});
	function goOtherVR(otherFloor){
		//$("[name='floorBack']").hide();
		$("[name='floorBack']").css("z-index","-1");
		$("[name='selectfloor']").css("opacity","0.4")
		showFloor(otherFloor);
	}
	function showFloor(otherFloor){
		if(otherFloor =='3F'){
			$("#selectThreeFloor").css("opacity","0.6");
			//$(".threeBack").show();
			$(".threeBack").css("z-index","1");
		}else if(otherFloor =='1F'){
			$("#selectOneFloor").css("opacity","0.6");
			//$(".oneBack").show();
			$(".oneBack").css("z-index","1");
		}else if (otherFloor =='G'){
			$("#selectGFloor").css("opacity","0.6");
			//$(".gOneBack").show();
			$(".gOneBack").css("z-index","1");
		}else{
			$("#selectBFloor").css("opacity","0.6");
			//$(".bOneBack").show();
			$(".bOneBack").css("z-index","1");
		}
	}
	function goBack(){
		window.history.back();
	}
	function havcHoverShow(){
		$(".b1FloorBoilerHover").show();
	}
	function havcHoverHide(){
		$(".b1FloorBoilerHover").hide();
	}
	function parkingHoverShow(){
		$(".gFloorParkingHover").show();
	}
	function parkingHoverHide(){
		$(".gFloorParkingHover").hide();
	}
	function fireHoverShow(){
		$(".gFloorFireHover").show();
	}
	function fireHoverHide(){
		$(".gFloorFireHover").hide();
	}
	
	//
	function openBusiSystem(code){
		if(code =='ACCESS1'){
			createSimpleModalWithIframe("busi-system",1920,1080,"http://16m2p14769.iask.in:9090/icop/embed/acmMonitoringData?isExternal=true&location=1","","");
			openModal("#busi-system-modal", false, false);
		}else if(code =='ACCESS3'){
			createSimpleModalWithIframe("busi-system",1920,1080,"http://16m2p14769.iask.in:9090/icop/embed/acmMonitoringData?isExternal=true&location=3","","");
			openModal("#busi-system-modal", false, false);
		}else if(code =='HAVC'){
			createSimpleModalWithIframe("hvac_page",1920,1080,"${ctx}/hvacRealTimeDataPage/hvacHotMapBOnePage?projectCode="+projectCode+"&projectId=" + projectId,"","");
			openModal("#hvac_page-modal", false, false);
		}else if(code =='PARKING'){
			createSimpleModalWithIframe("busi-system",1920,1080,"http://16m2p14769.iask.in:9090/icop/embed/parkingMonitoringData?isExternal=true&code=PARKINGLOTMAP?projectId=" + projectId,"","");
			openModal("#busi-system-modal", false, false);
		}else if(code =='FIRE'){
			createSimpleModalWithIframe("busi-system",1920,1080,"${ctx}/fireFightingManage/gFloorFiresManage?projectCode="+projectCode, null,null);
			openModal("#busi-system-modal", false, false);
			$(".modal-dialog").css("transform", "none");
		}
	}
	
	function hiddenScroller() {
		var height = $(window).height();
		if (height > 1070) {
			document.documentElement.style.overflowY = 'hidden';
			$(".modal-open .modal").css("overflow-y","hidden");
		} else {
			document.documentElement.style.overflowY = 'auto';
		}
	}

	$(window).resize(function() {
		hiddenScroller();
	});
</script>
</html>