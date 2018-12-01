<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date"/>
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
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/theme/rib-green.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/operateSystemMain.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/swiper.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/operate-system.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/operateSystemFloor.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/modleIframeBlue.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/rodeTraffic.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
<script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<script src="${ctx}/static/js/echarts/echarts.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/charts.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/HashMap.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/operateSystemCommon.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/operateSystemElevator.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/swiper.min.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/rotate.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/operateSystemFloor.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/operateSystemElevatorPopover.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/operateSystemRodeTraffic.js"></script>
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<title>西子国际设施运营系统</title>
<style type="text/css">
.all {
	width: 1920px;
	height: 1080px;
	/* background-image:
		url('${ctx}/static/images/operator-system/main-background.png'); */
}

.page_slide {
	background-image:
		url('${ctx}/static/images/operator-system/3d-solid.png');
	width: 186px;
	height: 200px;
	position: absolute;
	left: 140px;
	top: 140px;
	zoom: 0.5;
	-moz-transform: scale(0.5);
	-moz-transform-origin: -180px -150px
}

.env_position {
/* 	animation: show-dingwei1 3s; */
/* 	animation-timing-function: linear; */
/* 	animation-iteration-count:infinite; */
	position: absolute;
	left: 624px;
    top: 167px;
	width: 39px;
	height: 39px;
	background-image:url('${ctx}/static/images/operator-system/environment.svg');
}
.env_position_one {
	animation: show-dingwei2 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite ;
	position: absolute;
	left: 573px;
	top: 160px;
	width: 129px;
	height: 58px;
	background-image:url('${ctx}/static/images/operator-system/dingwei02.svg');
}
.env_position_two {
	animation: show-dingwei3 3s; 
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	position: absolute;
	left: 573px;
	top: 160px;
	width: 129px;
	height: 58px;
	background-image:url('${ctx}/static/images/operator-system/dingwei.svg');
}
.env_bubble_big {
	z-index: 1;
	position: absolute;
	left: 400px;
	top: 150px;
	width: 50px;
	height: 50px;
	background-image:
		url('${ctx}/static/images/operator-system/huanjing02.svg');
}

.env_bubble_small {
	z-index: 1;
	position: absolute;
	left: 470px;
	top: 175px;
	width: 40px;
	height: 40px;
	background-image:
		url('${ctx}/static/images/operator-system/huanjing01.svg');
}

.env_rel {
	position: absolute;
	left: 539px;
	top: 177px;
	border-style: solid;
	border-width: 8px 8px 8px 16px;
	border-color: transparent transparent transparent
		rgba(86, 228, 255, 0.83);
}

.env_realTime {
	position: absolute;
	left: 379px;
	top: 160px;
	background: rgba(9, 162, 221, 0.40);
	border: 1px solid #56E4FF;
	width: 160px;
	height: 50px;
	font-family: PingFangSC-Regular;
	font-size: 20px;
	color: #FFFFFF;
	letter-spacing: 0.78px;
	text-align: center;
	padding-top: 10px;
}

.elevatorRel {
    position: absolute;
    z-index:3;
	border-style: solid;
	border-width: 8px 8px 8px 16px;
	border-color: transparent transparent transparent
		rgba(86, 228, 255, 0.83);
    top:18px; 
    left:188px ;
}

.elevatorm{
    position: absolute;
	z-index:3;
	background: rgba(9, 162, 221, 0.40);
	border: 1px solid #56E4FF;
	width: 190px;
	height: 50px;
	font-family: PingFangSC-Regular;
	font-size: 20px;
	color: #FFFFFF;
	letter-spacing: 0.78px;
	text-align: center;
	padding-top: 10px;
    animation:moveelvator 15s ease-in-out infinite alternate; 
    -moz-animation:moveelvator 15s ease-in-out infinite alternate; /* Firefox */
    backface-visibility: hidden;
}

.elevatorm:hover{
    animation-play-state: paused;
} 
.env_bubble {
	position: absolute;
	left: 129px;
	top: 40px;
	width: 265px;
	height: 180px;
	background-image:
		url('/ib-web/static/images/operator-system/environment03.svg');
}

.underGround {
	animation: show-dingwei1 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	position: absolute;
	left: 452px;
	top: 921px;
    width: 129px;
    height: 58px;
	z-index: 1;
	opacity:1;
	background-image:url('${ctx}/static/images/operator-system/dingwei01.svg');
}
.oneUnderGround{
	animation: show-dingwei2 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	background-image:url('${ctx}/static/images/operator-system/dingwei02.svg');
	position: absolute;
	left: 452px;
	top: 921px;
    width: 129px;
    height: 58px;
	z-index: 1;
	opacity:1;
}
.twoUnderGround{
	animation: show-dingwei3 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	background-image:url('${ctx}/static/images/operator-system/dingwei.svg');
	position: absolute;
	left: 452px;
	top: 921px;
    width: 129px;
    height: 58px;
	z-index: 1;
	opacity:1;
}

.underGroundRel {
	z-index: 1;
	position: absolute;
	left: 512px;
	top: 907px;
	width: 16px;
	border-style: solid;
	border-width: 16px 8px 16px 8px;
	border-color: rgba(86, 228, 255, 0.83) transparent transparent transparent;
}

.carFlow {
	z-index: 1;
	position: absolute;
	left: 1162px;
	top: 768px;
	width: 129px;
	height: 58px;
	background-image:
		url('${ctx}/static/images/operator-system/dingwei.svg');
}
.carBackground {
	z-index: 1;
	position: absolute;
	left: 1145px;
	top: 655px;
	width: 162px;
	height: 107px;
	background-image:
		url('${ctx}/static/images/operator-system/chedikuang.svg');
}

.env_system_rel {
	position: absolute;
	left: 634px;
	top: 143px;
	border-style: solid;
	border-width: 16px 8px 16px 8px;
	border-color: rgba(86, 228, 255, 0.83) transparent transparent transparent;
}

.env_system_detail {
	position: absolute;
	left: 540px;
	top: 93px;
	background: rgba(9, 162, 221, 0.40);
	border: 1px solid #56E4FF;
	width: 200px;
	height: 50px;
	font-family: PingFangSC-Regular;
	font-size: 20px;
	color: #FFFFFF;
	letter-spacing: 0.78px;
	text-align: center;
}
.water_system_rel {
	position: absolute;
	left: 818px;
	top: 63px;
	border-style: solid;
	border-width: 16px 8px 16px 8px;
	border-color: rgba(86, 228, 255, 0.83) transparent transparent transparent;
}

.water_system_detail {
	position: absolute;
	left: 740px;
	top: 13px;
	background: rgba(9, 162, 221, 0.40);
	border: 1px solid #56E4FF;
	width: 170px;
	height: 50px;
	font-family: PingFangSC-Regular;
	font-size: 20px;
	color: #FFFFFF;
	letter-spacing: 0.78px;
	text-align: center;
}
.water_system {
/* 	animation: show-dingweismall1 3s; */
/* 	animation-timing-function: linear; */
/* 	animation-iteration-count:infinite; */
	position: absolute;
	left: 805px;
	top: 89px;
	width: 39px;
	height: 39px;
	background-image:url('${ctx}/static/images/operator-system/watersystem.svg');
}
.water_system_one {
	animation: show-dingweismall2 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	position: absolute;
	left: 805px;
	top: 89px;
	width: 58px;
	height: 26px;
	background-image:url('${ctx}/static/images/operator-system/dingweismall02.svg');
}
.water_system_two {
	animation: show-dingweismall3 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	position: absolute;
	left: 805px;
	top: 89px;
	width: 58px;
	height: 26px;
	background-image:url('${ctx}/static/images/operator-system/dingweismall.svg');
}
.moveElevatorDiv{
    width:28px;
    height:58px;
    background-image: url('${ctx}/static/img/dianti.png');
	position: absolute;
	z-index:3;
	top:10px; 
    left:203px ;
}
.redMoveElevatorDiv{
    width:28px;
    height:58px;
    background-image: url('${ctx}/static/img/redElevator.png');
	position: absolute;
	z-index:2;
    animation:redmymove 20s linear  infinite ; 
	-moz-animation:redmymove 20s  infinite ; /* Firefox */
	-webkit-animation:redmymove 20s  infinite ; /* Safari and Chrome */
	-o-animation:redmymove 20s  infinite ; /* Opera */ 
    top:10px; 
    left:203px ;
}
  @keyframes moveelvator{
     
   0%{

   transform:translate(408px,-300px);
   -ms-transform:translate(408px,-300px); /* IE 9 */
   -webkit-transform: translate(408px,-300px); /* Safari and Chrome */
   -o-transform: translate(408px,-300px);  /* Opera */
   -moz-transform:translate(408px,-300px);

   }
   100%{
   transform:translate(380px,-520px);
   -webkit-transform: translate(380px,-520px); /* Safari and Chrome */
   -o-transform: translate(380px,-520px);  /* Opera */
   -moz-transform:translate(380px,-520px);
   }

  
}  
/* 不兼容火狐 在火狐下存在抖动 */
 @-moz-keyframes moveelvator{
  
   0%{
   -moz-transform:translate(388px,-300px);
   }
   100%{ 
   -moz-transform:translate(360px,-520px);
   }

} 
/*    @keyframes moveelvator{
  
    0%{  
        top:800px; 
        left:420px ;
     }  
    50%{  
        top:588px; 
        left:393px ;
     }
    100%{  
         top:800px;
         left:420px;
     } 
}  */  
 @keyframes redmymove
{
10% {opacity:0.5;}
20% {opacity:1;} 
30% {opacity:0.5;} 
40% {opacity:1;} 
50% {opacity:0.5;} 
60% {opacity:1;} 
70% {opacity:0.5;} 
80% {opacity:1;} 
90% {opacity:0.5;} 
100% {opacity:1;} 
}  

@-webkit-keyframes moveElevator{
  0%{
      -webkit-transform:scale(1);
  }
  100%{
      -webkit-transform:scale(.465);
  }
}

@keyframes show-dingwei1 {
	0% {  
        opacity: 0.8;  
    }
    100% {  
        opacity: 0.0;  
    } 

}
@keyframes show-dingwei2 {
	0% {  
        opacity: 0.0;  
    }  
    20% {  
        opacity: 0.3;  
    }  
    40% {  
        opacity: 0.6;  
    }  
    60% {  
        opacity: 1;  
    }  
    100% {  
        opacity: 0.0;  
    }     
}
@keyframes show-dingwei3 {
    0% {  
        opacity: 0.0;  
    }  
    20% {  
        opacity: 0.0;  
    }  
    40% {  
        opacity: 0.3;  
    }  
    60% {  
        opacity: 0.6;  
    }  
    80% {  
        opacity: 1;  
    }
    100% {  
        opacity: 0.0;  
    }  
}
@keyframes show-dingweismall1 {
	0% {  
        opacity: 0.8;  
    }
    100% {  
        opacity: 0.0;  
    } 
}
@keyframes show-dingweismall2 {
	0% {  
        opacity: 0.0;  
    }  
    20% {  
        opacity: 0.3;  
    }  
    40% {  
        opacity: 0.6;  
    }  
    60% {  
        opacity: 1;  
    }  
    100% {  
        opacity: 0.0;  
    } 
}
@keyframes show-dingweismall3 {
    0% {  
        opacity: 0.0;  
    }  
    20% {  
        opacity: 0.0;  
    }  
    40% {  
        opacity: 0.3;  
    }  
    60% {  
        opacity: 0.6;  
    }  
    80% {  
        opacity: 1;  
    }
    100% {  
        opacity: 0.0;  
    } 
}

.fire_system_rel {
	width: 16px;
	margin-left: 70px;
	border-style: solid;
	border-width: 16px 8px 16px 8px;
	border-color: rgba(86, 228, 255, 0.83) transparent transparent transparent;
}

.fire_system_detail {
	background: rgba(9, 162, 221, 0.40);
	border: 1px solid #56E4FF;
	width: 160px;
	height: 80px;
	font-family: PingFangSC-Regular;
	font-size: 20px;
	color: #FFFFFF;
	letter-spacing: 0.78px;
	text-align: center;
	padding-top: 10px;
}
.fire_system {
/* 	animation: show-dingweismall1 3s; */
/* 	animation-timing-function: linear; */
/* 	animation-iteration-count:infinite; */
	margin-left: 58px;
	margin-top: -6px;
	width: 39px;
	height: 39px;
	background-image:url('${ctx}/static/images/operator-system/firealarmsystem.svg');
}
.fire_system_one {
	animation: show-dingweismall2 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	margin-left: 50px;
	margin-top: -26px;
	width: 58px;
	height: 26px;
	background-image:url('${ctx}/static/images/operator-system/dingweismall02.svg');
}
.fire_system_two {
	animation: show-dingweismall3 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	margin-left: 50px;
	margin-top: -26px;
	width: 58px;
	height: 26px;
	background-image:url('${ctx}/static/images/operator-system/dingweismall.svg');
}
#fires-alarm-video {
	position: relative;
	z-index: 1045;
}
#show-elevator-alarm-video {
	position: relative;
	z-index: 1045;
}
.system_deviceNum {
	background: rgba(1,10,85,0.3);
	border-radius: 5px;
	color: #00FFE5;
	padding-right: 8px;
	padding-left: 8px;
}

.gFloor{
	width:440px;
	height:92.6px;
	left: 502.6px;
	top: 957.9px;
	z-index:2;
	position: absolute;
	cursor: pointer;
}
.gFloorHover{
	width:440px;
	height:92.6px;
	left: 502.6px;
	top: 957.9px;
	z-index:2;
	position: absolute;
	cursor: pointer;
}
.gFloorAlarm {
	animation: floor-shine 1.5s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	width:440px;
	height:92.6px;
	left: 502.6px;
	top: 957.9px;
	z-index:2;
	position: absolute;
	background-image: url('${ctx}/static/images/operator-system/gfloor.svg');
	cursor: pointer;
}
.b1Floor{
	width:440px;
	height: 77.8px;
	left: 503.4px;
	top: 988.2px;
	z-index:3;
	position: absolute;
	cursor: pointer;
}
.b1FloorHover{
	width:440px;
	height: 77.8px;
	left: 503.4px;
	top: 988.2px;
	z-index:3;
	position: absolute;
	cursor: pointer;
}
.b1FloorAlarm {
	width:440px;
	height: 77.8px;
	left: 503.4px;
	top: 988.2px;
	z-index:3;
	position: absolute;
	background-image: url('${ctx}/static/images/operator-system/negativefirstfloor.svg');
	cursor: pointer;
}
.traffic_one {
	animation: show-dingwei1 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	position: absolute;
	left: 1291px;
    top: 773px;
    width: 129px;
    height: 58px;
	z-index: 1;
	opacity:1;
	background-image:url('${ctx}/static/images/operator-system/dingwei01.svg');
}
.traffic_two{
	animation: show-dingwei2 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	background-image:url('${ctx}/static/images/operator-system/dingwei02.svg');
	position: absolute;
	left: 1291px;
	top: 773px;
    width: 129px;
    height: 58px;
	z-index: 1;
	opacity:1;
}
.traffic_three{
	animation: show-dingwei3 3s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	background-image:url('${ctx}/static/images/operator-system/dingwei.svg');
	position: absolute;
	left: 1291px;
	top: 773px;
    width: 129px;
    height: 58px;
	z-index: 1;
	opacity:1;
}
div#ffm_error_div-modal-content {
    width: 400px;
}
div#ffm_error_div-modal-content > div > a.btn.btn-primary.btn-modal {
    /* margin: 20px 164px 10px 10px; */
    margin-right: 156px;
}

</style>
</head>
<body>
	<!--主页面-->
	<div class="all" id="systemMainJsp">
		<div class="oneFloorLeft" onmouseenter="oneFloorHoverShow()" onmouseleave="oneFloorHoverHide()" onclick="floorVR('1F')"></div>
		<div class="oneFloorRight" onmouseenter="oneFloorHoverShow()" onmouseleave="oneFloorHoverHide()" onclick="floorVR('1F')"></div>
		<div class="oneFloorHover" style="display: none;"></div>
		<div class="threeFloorLeft" onmouseenter="threeFloorHoverShow()" onmouseleave="threeFloorHoverHide()" onclick="floorVR('3F')"></div>
		<div class="threeFloorRight" onmouseenter="threeFloorHoverShow()" onmouseleave="threeFloorHoverHide()" onclick="floorVR('3F')"></div>
		<div class="threeFloorHover" style="display: none;"></div>
		<div class="threeFloorAlarm" id="threeFloorAlarm" style="display: none;"></div>
		<div class="oneFloorAlarm" id="oneFloorAlarm" style="display: none;"></div>
		<div class="basement" onclick="floorVR('G')"></div>
		<div class="basementBlock" onclick="floorVR('G')">
			<span>停车场系统</span>
			<span id="basementBlock_parking_num" class="system_deviceNum" class="system_deviceNum" style="display:inline-block;min-width:24px;text-align: center;"></span>
		</div>
		<div class="basementAlarm" id="basementAlarm" style="display: none;"></div>
		<!-- g层-->
		<div class="gFloor" onmouseenter="gFloorHoverShow()" onmouseleave="gFloorHoverHide()" onclick="floorVR('G')">
		</div>
		<div class="gFloor" style="display: none;">
		</div>
		<div class="gFloorAlarm" id="gFloorAlarm" style="display: none;" onmouseenter="gFloorHoverShow()" onmouseleave="gFloorHoverHide()" onclick="floorVR('G')"><!-- style="display: none;"-->
		</div>
		<!-- 负一层 -->
<!-- 		<div class="b1Floor" onmouseenter="b1FloorHoverShow()" onmouseleave="b1FloorHoverHide()" onclick="floorVR('B')"></div> -->
<!-- 		<div class="b1Floor" style="display: none;"></div> -->
<!--		<div class="b1FloorAlarm" id="b1FloorAlarm" ><!-- style="display: none;" -->
		<div class="swiper-container gallery-top">
			<div class="swiper-wrapper">
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/main-background.png)"></div>
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/1.png)"></div>
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/2.png)"></div>
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/3.png)"></div>
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/4.png)"></div>
			</div>
			<!-- Add Arrows -->
			<div class="swiper-button-next swiper-button-white" style="display: none;"></div>
			<div class="swiper-button-prev swiper-button-white" style="display: none;"></div>
		</div>
		<div class="swiper-container gallery-thumbs" style="display: none;">
			<div class="swiper-wrapper">
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/main-background.png)"></div>
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/1.png)"></div>
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/2.png)"></div>
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/3.png)"></div>
				<div class="swiper-slide" style="background-image:url(${ctx}/static/images/operator-system/4.png)"></div>
			</div>
		</div>
		<!-- 	<div class="system_title">西子国际设施运营系统</div> -->
		<!-- 点击跳转页面 -->
		<div class="page_slide"></div>
		<div class=""></div>
		<!-- 	<!-- 室外实时环境数据 -->
		<!-- 	<div class="env_realTime" id="env_realTime" style="z-index: 3;"> -->
		<!-- 		户外环境监控 -->
		<!-- 	</div> -->
		<!--  	<!-- 环境数据关联图标  -->
		<!-- 	<div class="env_rel" id="env_rel" style="z-index: 3;"></div> -->
		<!-- 环境数据气泡  -->
		<div class="env_bubble" id="env_bubble" style="z-index: 3; font-size: 12px; color: rgb(255, 255, 255); cursor: pointer;display: none;">
			<div id="pm25" style="z-index: 1; width: 280px; height: 90px; text-align: center; padding-top: 70px;">
				PM2.5：
				<span id="pm25RealTimeOutDoor" style="font-size: 20px;">0</span>
				μg/m3
			</div>
			<div id="co2"style="z-index: 1; width: 280px; height: 90px; text-align: center;padding-top: 20px;">
				CO₂：
				<span id="co2RealTimeOutDoor" style="font-size: 20px;">0</span>
				ppm
			</div>
		</div>
		<div class="env_bubble_big" id="env_bubble_big" style="display: none;"></div>
		<div class="env_bubble_small" id="env_bubble_small" style="display: none;"></div>
		<!-- 环境位置 -->
		<div class="env_system_detail" id="env_system_detail" style="z-index: 3; font-size: 20px; color: rgb(255, 255, 255); cursor: pointer;">
			<div style="z-index: 1; width: 200px;height: 50px;text-align: center;padding-top:10px;">
			 	<span>环境监测系统</span>
			 	<span id="env_system_detail_num" class="system_deviceNum" style="display:inline-block;min-width:24px;text-align: center;margin-left: 8px;"></span>
			</div>
		</div>
		<!-- 消防水系统关联图标 -->
		<div class="env_system_rel" id="env_system_rel" style="z-index: 3;"></div>
		<div class="env_position" id="env_position" style="z-index: 3;"></div>
<!-- 		<div class="env_position_one"  style="z-index: 3;"></div> -->
<!-- 		<div class="env_position_two" style="z-index: 3;"></div> -->
		
		<!-- 消防水系统详情  -->
		<div class="water_system_detail" id="water_system_detail" style="z-index: 3; font-size: 20px; color: rgb(255, 255, 255); cursor: pointer;">
			<div style="z-index: 1;height: 50px;text-align: center;padding-top:10px;">
			 	<span>消防水系统</span>
			 	<span id="water_system_detail_num" class="system_deviceNum" class="system_deviceNum" style="display:inline-block;min-width:24px;text-align: center;"></span>
			</div>
		</div>
		<!-- 消防水系统关联图标 -->
		<div class="water_system_rel" id="water_system_rel" style="z-index: 3;"></div>
		<!-- 消防水系统位置 -->
		<div class="water_system" id="water_system" style=" z-index: 3;"></div>
<!-- 		<div class="water_system_one" id="water_system_one" style=" z-index: 3;"></div> -->
<!-- 		<div class="water_system_two" id="water_system_two" style=" z-index: 3;"></div> -->
		
		<!-- 地下室位置 -->
		<div class="underGround"></div>
		<div class="oneUnderGround"></div>
		<div class="twoUnderGround"></div>
		
		<div class="underGroundRel"></div>
		<!-- <div class="underGroundBolck"></div> -->
		
		
		<!-- 消防报警系统 -->
		<div
			style="position: absolute; width: 160px; height: 100px; z-index: 4;left: 670px;top: 490px;">
			<!-- 消防报警系统详情  -->
			<div class="fire_system_detail" id="fire_system_detail" style="cursor: pointer;">
				<div>
					<span>消防报警系统</span>
					<span id="fire_system_detail_num" class="system_deviceNum" style="text-align: center;display:block;margin: 5px 40px"></span>
				</div>
			</div>
			<!-- 消防报警系统关联图标 -->
			<div class="fire_system_rel" id="fire_system_rel" style=""></div>
			<!-- 消防报警系统位置 -->
			<div class="fire_system" id="fire_system" style=""></div>
<!-- 			<div class="fire_system_one" ></div> -->
<!-- 			<div class="fire_system_two" ></div> -->
		</div>



		<!-- 电梯数据 -->
        <div class="elevatorm" id="elevatorm" >
        <div style="z-index: 3; cursor: pointer;" onclick="showElevatorRunningMonitorPage()">
        	<span>电梯监测系统</span>
        	<span id="elevatorm_device_num" class="system_deviceNum" style="display:inline-block;min-width:24px;text-align: center;"></span>
       	</div>
        <!-- 电梯数据关联图标 -->
        <div class="elevatorRel" id="elevatorRel" style="z-index:3;"></div>
        <!-- 首页电梯展示 -->
        <div class="moveElevatorDiv" id="moveElevatorDiv"></div>
        <div class="redMoveElevatorDiv" id="redMoveElevatorDiv"></div>
        </div>
		<!-- 车流量位置 -->
		<div class="carBackground" style="display: none;">
			<div style="text-align: center; margin-top: 15px;">
				<span style="font-family: PingFangSC-Regular; font-size: 15px; color: #FFFFFF; letter-spacing: 0.78px;">车流量</span>
			</div>
			<div style="text-align: center; margin-top: 10px;">
				<span id="car_inPassageNum" style="font-family: PingFangSC-Regular; font-size: 20px; color: #FFFFFF; letter-spacing: 0.78px;">--</span>
				<span style="font-family: PingFangSC-Regular; font-size: 20px; color: #FFFFFF; letter-spacing: 0.78px;">次</span>
			</div>
		</div>
		<div class="carFlow" style="display: none;"></div>
		<div id="rodeTrafficShow" class=""></div>
		<div id="rodeTrafficShowTwo" class=""></div>
		<div id="rodeTraffic1" class="rodeTraffic1"></div>
		<div id="rodeTraffic2" class="rodeTraffic2"></div>
		<div id="rodeTraffic3" class="rodeTraffic3"></div>
		<div id="rodeTraffic4" class="rodeTraffic4"></div>
		<div id="rodeTraffic5" class="rodeTraffic5"></div>
		<div id="rodeTraffic6" class="rodeTraffic6"></div>
        <div id="rodeTraffic7" class="rodeTraffic7"></div>
        <div id="rodeTraffic8" class="rodeTraffic8"></div>
        <div id="rodeTraffic9" class="rodeTraffic9"></div>
        <div id="rodeTraffic10" class="rodeTraffic10"></div>
        <div id="rodeTraffic11" class="rodeTraffic11"></div>
				<!-- 暖通系统 -->
		<div style="left:302px;top:1001px;z-index:3;position: absolute;font-size: 20px;cursor: pointer;width: 186px;height: 52px;background: rgba(9, 162, 221, 0.40);border: 1px solid #56E4FF;font-family: PingFangSC-Regular;color: #FFFFFF;letter-spacing: 0.78px;text-align: center;" onclick="openBusiSystem('HAVC')">
		<div style="float:left;text-align: center;line-height:52px;width:110px;">暖通系统</div>
        <div style="float:left;text-align: center;line-height:30px;min-width:24px;height:30px;margin-top:11px;margin-left:2px;" id="hvac_system_detail_num" class="system_deviceNum"></div>
		</div>
        <div style="position: absolute;z-index:3;border-style: solid;border-width: 8px 8px 8px 16px;border-color: transparent transparent transparent rgba(86, 228, 255, 0.83);top:1020px; left:488px;"></div>
		<!-- 人脸识别系统 -->
		<div style="left:855px;top:843px;z-index:3;position: absolute;text-align: center;font-size: 20px;color: rgb(255, 255, 255);cursor: pointer;width: 216px;height: 52px;background: url(${ctx}/static/images/operator-system/facerecognitionsystem.png) repeat;" onclick="openBusiSystem('ACCESS3')">
		<div style="float:left;text-align: center;line-height:52px;width:156px;margin-left: 15px;">人脸识别系统</div>
        <div style="float:left;text-align: center;line-height:30px;min-width:24px;height:30px;margin-top:11px;" id="face_system_detail_num" class="system_deviceNum"></div>
		</div>
		<!-- 自助访客系统 -->
		<div style="left:855px;top:909px;z-index:3;position: absolute;text-align: center;font-size: 20px;color: rgb(255, 255, 255);cursor: pointer;width: 216px;height: 52px;background: url(${ctx}/static/images/operator-system/facerecognitionsystem.png) repeat;" onclick="openBusiSystem('ACCESS1')">
		<div style="float:left;text-align: center;line-height:52px;width:156px;margin-left: 15px;">自助访客系统</div>
        <div style="float:left;text-align: center;line-height:30px;min-width:24px;height:30px;margin-top:11px;" id="visitor_system_detail_num" class="system_deviceNum"></div>
		</div>
		<!-- 实时路况监测--> 
		<div style="left:1256px;top:697px;z-index:3;position: absolute;text-align: center;font-size: 20px;color: rgb(255, 255, 255);width: 202px;height: 66px;background: url(${ctx}/static/images/operator-system/parkingcarsystem.png) repeat;">
		<div style="float:left;text-align: center;line-height:52px;width:156px;">实时路况监测</div>
        <div style="float:left;text-align: center;line-height:30px;min-width:24px;height:30px;margin-top:11px;" id="traffic_system_detail_num" class="system_deviceNum"></div>
		</div>
		<div class="traffic" id="traffic"></div>
		<div class="traffic_one"></div>
		<div class="traffic_two"></div>
		<div class="traffic_three"></div>
<%-- 		<div style="width:440px;height:92.6px;left: 502.6px;top: 957.9px;z-index:3;position: absolute;cursor: pointer;background: url(${ctx}/static/images/operator-system/gfloor.svg) repeat;" onclick="floorVR('G')"> --%>
<!-- 		</div> -->
<%-- 		<div style="width:440px;height: 77.8px;left: 503.4px;top: 988.2px;z-index:2;position: absolute;cursor: pointer;background: url(${ctx}/static/images/operator-system/negativefirstfloor.svg) repeat;" onclick="floorVR('B1')"> --%>
<!-- 		</div> -->
		<div class="system_title" >西子国际设施运营系统</div>
		<div style="width: 360px; left: 1530px; top: 10px; position: absolute; z-index: 2;">
			<div style="width: 360px; height: 180px; margin-top: 90px;" class="boder">
				<div class="head">
					<div class="head_font">设备总数</div>
                    <div style="float: right;">
						<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
					</div>
				</div>
				<div class="right_box">
					<div style="height: 67px; width: 100%; text-align: center; margin-top: 7px; display: inline-block;">
						<span id="deviceProjectCount" style="font-size: 48px; color: #56E4FF; letter-spacing: 1.6px; line-height: 67px;"></span>
						<span id="deviceWan" style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>
					</div>
					<div style="height: 25px; width: 100%; margin-top: 7px; line-height: 25px;">
						<span class="power_font" style="margin-left: 44px;">
							正常：
							<span id="deviceNormal"></span>
						</span>
						<span class="power_font" style="margin-left: 206px;">
							<span style="color: #FF5E72;">异常：</span>
							<span style="color: #FF5E72;" id="deviceAbnormal"></span>
					</div>
				</div>
			</div>
			<div style="width: 360px; height: 350px; margin-top: 10px;" class="boder">
				<div class="head">
					<div class="head_font_alarm" id ="alarm_font" style ="cursor: pointer;" ><span id="alarm_active_span" class="alarm-active-line">事件异常</span></div>
					<div  class="head_font_spilt"></div>
					<div class="head_font_alarm" id = "fault_font" style ="cursor: pointer;color: rgba(255,255,255,0.50);"><span id="fault_active_span">设备异常</span></div>
					<div style="float: right;">
						<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
						<div id="alarmRecordJsp" style="font-size: 20px; cursor: pointer; color: #56E4FF; letter-spacing: 0.67px; margin-top: -37px; margin-left: 110px;">更多</div>
					</div>
				</div>
				<!-- 告警列表开始 -->
				<div id="alarm-num" class="right_box alarm_info">
				</div>
				<div id="alarmLimit" class="right_box alarm_info"></div>
				<div id="faultLimit" class="right_box alarm_info"></div>
				<!-- 告警列表结束 -->
			</div>
			<!-- 临时代码到时候会删除的-Huangxx -->
			<!-- <button id="elevatorm" style="float: left; margin-left: -1500px; margin-top: -580px;" onclick="showElevatorRunningMonitorPage()">电梯页面</button> -->
			<!-- <button id="elevator1" onclick="getCertainElevator('elevator1', projectCode)">电梯编号：elevator1</button> -->
			<!-- 临时代码到时候会删除的-Huangxx -->
			<div style="width: 360px; height: 150px; margin-top: 10px;" class="boder">
				<div class="head">
					<div class="head_font">能耗情况</div>
					<div style="float: right;">
						<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
					</div>
				</div>
				<div class="right_box" style="width: 360px; height: 100%; text-align: center; display: table;">
					<div style="width:50%;height:100%;float:left;">
						<div style="height:65%;padding-top:10%;">
							<span id="id_allPowerConsumption" class="pdsValue">--</span>
							<span class="pdsUnit">Kwh</span>
						</div>
						<div style="height:50%;margin-top:10px">
						<span style="font-family: PingFangSC-Regular;font-size: 14px;color: #FFFFFF;letter-spacing: 0.47px;">总能耗</span>
						</div>
					</div>
					<div style="width:50%;height:100%;float:left;">
						<div style="height:65%;padding-top:10%;">
							<span id="id_publicPowerConsumption"  class="pdsValue">--</span>
							<span class="pdsUnit">Kwh</span>
						</div>
						<div style="height:50%;margin-top:10px">
							<span style="font-family: PingFangSC-Regular;font-size: 14px;color: #FFFFFF;letter-spacing: 0.47px;">公共能耗</span>
						</div>
					</div>
				</div>
			</div>
			<div style="width: 360px; height: 250px; margin-top: 10px;" class="boder">
				<div class="head">
					<div class="head_font">能耗曲线图</div>
					<div style="float: right;">
						<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
					</div>
				</div>
				<div id="power_echart" class="right_box" style="width: 360px; height: 190px;"></div>
			</div>
		</div>
		<div id="page_slide"></div>
		<div id="env-detail"></div>
		<div id="elevator-detail"></div>
		<div id="elevatorRunningMonitorPage"></div>
		<div id="ffm-water-system"></div>
		<div id="ffm-fire-system"></div>
	</div>
			<!-- 电梯困人 报警弹窗 -->
		<div id="show-elevator-alarm-video"></div>
		<div id="fires-alarm-video"></div>
		<div id ="ffm_error_div"></div>
	<!--虚化页面-->
	<div id="floorVrJsp" style="display: none">
		<div class="goBack" onclick="goBack()" ></div>
		<div name="floorBack" class="threeBack">
			<div class="threeFloorAccess" onclick="openBusiSystem('ACCESS3')"></div>
		</div>
		<div name="floorBack" class="oneBack">
			<div class="oneFloorAccess" onclick="openBusiSystem('ACCESS1')"></div>
		</div>
		<div name="floorBack" class="gOneBack">
			<div class="gFloorFireOne" onmouseenter="fireHoverShow()" onmouseleave="fireHoverHide()"  onclick="openBusiSystem('FIRE')"></div>
			<div class="gFloorFireTwo" onmouseenter="fireHoverShow()" onmouseleave="fireHoverHide()" onclick="openBusiSystem('FIRE')"></div>
			<div class="gFloorFireArea" ></div>
			<div class="gFloorFireHover" style="display: none;"></div>
			<div class="gFloorParkingOne" onmouseenter="parkingHoverShow()" onmouseleave="parkingHoverHide()" onclick="openBusiSystem('PARKING')"></div>
			<div class="gFloorParkingTwo" onmouseenter="parkingHoverShow()"  onmouseleave="parkingHoverHide()" onclick="openBusiSystem('PARKING')"></div>
			<div class="gFloorParkingThree" onmouseenter="parkingHoverShow()"  onmouseleave="parkingHoverHide()" onclick="openBusiSystem('PARKING')"></div>
			<div class="gFloorParkingArea"></div>
			<div class="gFloorParkingHover" style="display: none;"></div>
			<div class="gFloorSupplyOne" onmouseenter="supplyHoverShow()" onmouseleave="supplyHoverHide()" onclick="openBusiSystem('SUPPLY')"></div>
			<div class="gFloorSupplyTwo" onmouseenter="supplyHoverShow()"  onmouseleave="supplyHoverHide()" onclick="openBusiSystem('SUPPLY')"></div>
			<div class="gFloorSupplyArea" ></div>
			<div class="gFloorSupplyHover" style="display: none;"></div>
		</div>
		<div name="floorBack" class="bOneBack">
			<div class="b1FloorBoiler" onmouseenter="havcHoverShow()" onmouseleave="havcHoverHide()" onclick="openBusiSystem('HAVC')"></div>
			<div class="b1FloorBoilerArea" ></div>
			<div class="b1FloorBoilerHover" style="display: none;" ></div>
		</div>
		<div class="leftAllFloor">
			<div id="selectThreeFloor" name="selectfloor" onmouseover="goOtherVR('3F')"><span>三层</span></div>
			<div id="selectOneFloor" name="selectfloor" onmouseover="goOtherVR('1F')"><span>一层</span></div>
			<div id="selectGFloor" name="selectfloor" onmouseover="goOtherVR('G')"><span>G层</span></div>
			<div id="selectBFloor" name="selectfloor" onmouseover="goOtherVR('B1')"><span>负一层</span></div>
		</div>
	</div>
	<div id="busi-system"></div>
	<div id="hvac_page"></div>
</body>
<script>
	// 小图标
	var weixiuIcon = "${ctx}/static/images/elevator/weixiu.svg";
	var kunrenIcon = "${ctx}/static/images/elevator/kunren.svg";
	var shangshengIcon = "${ctx}/static/images/elevator/shangsheng.png";
	var xiajiangIcon = "${ctx}/static/images/elevator/xiajiang.png";
	var tingzhiIcon = "${ctx}/static/images/elevator/tingzhi.png";
	var cameraBackIcon = "${ctx}/static/images/elevator/cameraBack.png";
	var lixianIcon = "${ctx}/static/images/elevator/lixian.png";

	// 电梯图片
	var kaimenIcon = "${ctx}/static/images/elevator/kaimen.png";
	var guanmenIcon = "${ctx}/static/images/elevator/guanmen.png";
	var yourenIcon = "${ctx}/static/images/elevator/youren.png";
	var backIcon = "${ctx}/static/images/elevator/back.png";
	var dikuangIcon = "${ctx}/static/images/elevator/dikuang.svg"
	var isConnectedGateWay = false;
	var projectCode = "${param.projectCode}";
	var ctx = "${ctx}";
	var projectId = "${param.projectId}";
	//刷新环境数据定时任务
	var flushEnvRealTimeData;
	var isShowFiresVideo = false;
	// 告警相关全局
	var alarmState;
<%--电梯视频弹窗缓存（开始） --%>
	//缓存设备id数组
	var elevatorAlarmDevice = new Array();
	//电梯告警弹窗打开状态0关闭1打开
	var elevatorVideoIsOpen = 0;
	var elevatorList = new Array();
	var cameraDeviceId = null;
	var elevator = null;
	var elevatorName = null;
	var elevatorAlarmName = null;
	var elevatorFloorDisplaying = null;
	var elevatorRunningState = null;
	var cameraStatus = null;
	//判断是否产生新的电梯困人告警数据：0否1是
	var isNewElevatorAlarm = 0;
	//消防选择的摄像机id缓存
	var cameraDeviceId = null;
	//消防推送视频弹窗id
	var tempCameraId = null;
<%--电梯视频弹窗缓存（结束） --%>
	var firesVideoDeviceMap = new HashMap();
	var firesVideoDeviceList = new Array();
	var isShowFiresVideo = false;
    var elevatorAlarmNum = 0;
    var maintenanceState;
    var elevatorDataList=new Array();
	//楼层
	document.getElementById('threeFloorAlarm').addEventListener("animationend", function() { //动画结束时事件 
		console.log("threeFloorAlarm");
		$(".threeFloorAlarm").hide();
	}, false);
	document.getElementById('oneFloorAlarm').addEventListener("animationend", function() { //动画结束时事件 
		console.log("oneFloorAlarm");
		$(".oneFloorAlarm").hide();
	}, false);
	document.getElementById('basementAlarm').addEventListener("animationend", function() { //动画结束时事件 
		console.log("basementAlarm");
		$(".basementAlarm").hide();
	}, false);
	document.getElementById('gFloorAlarm').addEventListener("animationend", function() { //动画结束时事件 
		console.log("gFloorAlarm");
		$(".gFloorAlarm").hide();
	}, false);
	$(document).ready(function() {
		hiddenScroller();
		// 项目首页马路流量
		getRodeTraffic();
		getElevatorStatus();
		// 跳转告警中心
		$("#alarmRecordJsp").click(function() {
			// 弹框显示告警记录
			createSimpleModalWithIframe("page_slide", 1450, 950, ctx + "/alarmRecords/alarmRecordSystem?projectCode=" + projectCode, "", "",100);
			//$(".modal-content").css("background", "rgba(9, 162, 221, 0.4) none repeat scroll 0% 0%");
			openModal("#page_slide-modal", false, false);
		});
		//init();
		// 获取最新的六条告警信息
		getNewestAlarmData(1);
		$("#alarmLimit").show();
		$("#faultLimit").hide();
		
		// 获取设备
		getProjectAllDeviceCount();
		getProjectDeviceNum();
		// 获取设备正常异常总数
		getSubsystemNormalCount();
		//获取环境数据
		getEnvRealTimeData();
		setTimeout(function() {
			startConn('${ctx}')
		}, 6000);
		//获取马路流量
 		setInterval(getRodeTraffic,60000);
		//定时获取环境数据
		setInterval(getEnvRealTimeData,5000);
		//加载供配电数据
		getSupplyPowerProjectData();
		//停车场模块数据
		getParking3DPageData();
		//2s后获取火警视频弹窗（20180416需求：添加火警确认，并且同一火警弹窗，无论是否确认，只弹一次）
//  		setTimeout("getAllFireFightingCameras()",2000);
	});
	//跳转环境详情页面
	$("#env_bubble").click(function() {
		createSimpleModalWithIframe("env-detail", 1232, 775, ctx + "/envMonitorManage/envMonitorDetail", "","",150);
		$("#env-detail-dialog").css("transform", "none");
		//$(".modal-content").css("background", "rgba(9, 162, 221, 0.4) none repeat scroll 0% 0%");
		//$(".modal-header").css("background","rgba(255, 255, 255, 0.9) none repeat scroll 0% 0%");
		openModal("#env-detail-modal", false, false);
		hiddenScroller();
	});
	$("#env_system_detail").click(function() {
		createSimpleModalWithIframe("env-detail", 1232, 775, ctx + "/envMonitorManage/envMonitorDetail", "","","");
		$("#env-detail-dialog").css("transform", "none");
		//$(".modal-content").css("background", "rgba(9, 162, 221, 0.4) none repeat scroll 0% 0%");
		//$(".modal-header").css("background","rgba(255, 255, 255, 0.9) none repeat scroll 0% 0%");
		openModal("#env-detail-modal", false, false);
		hiddenScroller();
	});
	
	//跳转消防水系统页面
	$("#water_system_detail").click(function() {
		createSimpleModalWithIframe("ffm-water-system", 1640, 920, ctx + "/fireFightingManage/ffmWaterMapManageDisplay", "","","");
		$(".modal-content").css("background", "rgba(215, 226, 239, 1) none repeat scroll 0% 0%");
		openModal("#ffm-water-system-modal", false, false);
		hiddenScroller();
	});
	//跳转消防报警系统页面
	$("#fire_system_detail").click(function(){
		createSimpleModalWithIframe("ffm-fire-system", 1690, 1080, ctx
				+ "/fireFightingManage/ffmDetailInfoForDisplay", "", "","","right");
		openModal("#ffm-fire-system-modal", false, false);
		$(".modal-header").css("padding-right","10px");
		hiddenScroller();
	});
	//切换报警
	$("#alarm_font").click(function(){
		$("#alarm-num").empty();
		$("#alarmLimit").empty();
		$("#alarmLimit").show();
		$("#faultLimit").hide();
		$("#fault_font").css("color","rgba(255,255,255,0.50)");
		$("#alarm_font").css("color","#56E4FF");
		$("#fault_active_span").removeClass("alarm-active-line");
		$("#alarm_active_span").addClass("alarm-active-line");
		getNewestAlarmData(1);
	});
	//切换故障
	$("#fault_font").click(function(){
		$("#alarm-num").empty();
		$("#faultLimit").empty();
		$("#alarmLimit").hide();
		$("#faultLimit").show();
		$("#alarm_font").css("color","rgba(255,255,255,0.50)");
		$("#fault_font").css("color","#56E4FF");
		$("#alarm_active_span").removeClass("alarm-active-line");
		$("#fault_active_span").addClass("alarm-active-line");
		getNewestAlarmData(2);
	});
	
	function hiddenScroller() {
		var height = $(window).height();
		if (height > 1060) {
			document.documentElement.style.overflowY = 'hidden';
			$(".modal-open .modal").css("overflow-y", "hidden");
			document.documentElement.style.overflowX = 'hidden';
			$(".modal-open .modal").css("overflow-x", "hidden");
		}else if(height == 943 || height == 926){
			document.documentElement.style.overflowY = 'auto';
			$(".modal-open .modal").css("overflow-y", "auto");
			document.documentElement.style.overflowX = 'hidden';
			$(".modal-open .modal").css("overflow-x", "hidden");
		}else {
			document.documentElement.style.overflowY = 'auto';
			$(".modal-open .modal").css("overflow-y", "auto");
			document.documentElement.style.overflowX = 'auto';
			$(".modal-open .modal").css("overflow-x", "auto");
		}
		
	}

	$(window).resize(function() {
		hiddenScroller();
	});
</script>
</html>