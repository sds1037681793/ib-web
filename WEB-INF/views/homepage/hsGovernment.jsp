<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" var="currentYear" pattern="yyyy" />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>云平台首页</title>
<style type="text/css">
.block-div {
	background: #162D39;
	box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.20);
	border-radius: 4px;
	margin-left: 20px;
	float: left;
}

.notice-left-div {
	width: 450px;
	height: 264px;
	float: left;
	margin-left: 8px;
}

.notice-right-div {
	position:relative;
	height: 267px;
	width: 195px;
	margin-right: 10px;
/* 	display:inline */
 	float: right;
	font-size: 16px !important;
	color: #FFFFFF;
	letter-spacing: 0;
	overflow: hidden;
}

.container-div {
	float: left;
	width: 760px;
}

.block-div-title {
	font-size: 24px;
	color: #FFFFFF;
	letter-spacing: 0;
	height: 33px;
	line-height: 33px;
	margin: 10px 10px 0px;
}

.alarm-charts {
	height: 311px;
	width: 420px;
	margin: auto;
	margin-top:22px;
}

.alarm-detail {
	width: 91%;
	padding-top: 20px;
	height: 190px;
	border-top: 2px solid rgba(255, 255, 255, 0.1);
	margin-top:35px;
	margin-left: 20px;
}

.alarm-detail-title {
	font-size: 20px;
	color: #FFFFFF;
	margin-bottom: 15px;
	letter-spacing: 0;
	margin-top: 5px;
}

.alarm-detail-font {
	height: 27px;
	width:591px;
	font-size: 14px;
    color: #FFFFFF;
    letter-spacing: 0;
    line-height: 27px;
    margin: 0;
    vertical-align: center;
}

.div-label-font {
	margin-left: 40px;
	color: #AFBDD1;
	letter-spacing: 0;
	font-size: 18px;
	vertical-align: super;
}

.div-value-font {
	font-size: 36px;
	color: #FFFFFF;
	letter-spacing: 0;
	margin-left: 18px;
}

.charts {
	height: 257px;
	width: 100%;
}

.content-charts {
	height: 193px;
	width: 100%;
}

.human-data-lable-font {
	opacity: 0.8;
	font-size: 14px;
	float: left;
	color: #FFFFFF;
	letter-spacing: 0;
	margin-left: 20px;
}

.human-data-value-font {
	opacity: 0.9;
	font-size: 16px;
	color: #FFFFFF;
	letter-spacing: 0;
	float: left;
	margin-left: 27px;
}

.human-bg-base {
	background: rgba(125, 184, 248, 0.36);
	border-radius: 3px;
	width: 360px;
	float: left;
	margin-left: 20px;
	height: 18px;
}

.human-bg-base div {
	border-radius: 3px;
	height: 18px;
}

.education-span{
    font-size: 18px;
    color: #AFBDD1;
    letter-spacing: 0;
}

.education-div1{
    float:left;
    height: 2.83rem;
    border-radius:5.11px;
    text-align:center;
    font-size: 14px;
    color: #FFFFFF;
    letter-spacing: 0;
    line-height: 36px;
}

.education-div2{
    float:left;
    height: 2.83rem;
    border-radius:5.11px;
    text-align:center;
    font-size: 14px;
    color: #FFFFFF;
    letter-spacing: 0;
    line-height: 36px;
    margin-left: 4.6px;
}

.education-color{
    float:left;
    height: 14px;
    width: 14px;
    border-radius:3.41px;
    margin-top:3px;
}

.education-num{
    float:left;
    margin-left: 6px;
    color:#FFFFFF;
}
.slideBox{
	width:450px;
	height:264px;
	overflow:hidden;
	float: left;
	border:1px solid ;
	margin-left:8px;
}
.slideBox .bdSlide{
	position:relative;
	height:100%;
	z-index:0;
}
.slideBox .bdSlide li{
	zoom:1;
	vertical-align:middle;
}
.silder-img{
 	width:450px;
 	height:264px;
 	display:block;
}
@keyframes move{
	0%{
	top:267px;
	}
	100%{
	top:-1550px;
	}
}
 .text{
	font-family: PingFangSC-Regular;
	font-size: 18px;
	color: #FFFFFF;
	letter-spacing: 0;
  	margin-left:8px;
 }
 .txtScroll-left{
    position:absolute;
 	width:450px;
  	height:42px;
	opacity: 0.66;
 	background: #000000;
 	margin-left:8px;
 	margin-top: 222px;
 }

.txtScroll-left .bd{
	padding:10px;
	width:430px;
}
.txtScroll-left .bd ul li{
 	margin-right:20px;
	float:left;
	height:24px;
	line-height:24px;
	text-align:left;
	_display:inline;
	width：500px;
	}
.notic-text{
	animation: move 80s;
	animation-timing-function: linear;
	animation-iteration-count:infinite;
	width: 100%;
	height: 1550px;
	position: absolute;
	top:267px;
	background-color: transparent;
    color: #f5f5f5;
    border: none;
    font-size: 16px;
    padding: 0px;
    overflow-y:hidden;
    overflow-x:hidden;
}
.text{
	width:400px;
}
#project-no-data{
    width: 642px;
    height: 265px;
    padding-top: 18px;
    margin-left: 18px;
}

.park-picture-div1{
	float:left;
	width:160px;
	height:140px;
	margin-right: 8px;
}
.park-picture-div2{
	float:left;
	width:160px;
	height:90px;
	cursor: pointer;
}
.park-picture-div3{
	float:left;
	width:160px;
	height:24px;
	background: rgba(255, 255, 255,0.09) none repeat scroll 0% 0%;
}
.park-num1{
	float:left;
	width:60%;
	height:24px;
	font-size: 12px;
	color: #FFFFFF;
	letter-spacing: 0.47px;
	margin-left: 7px;
	line-height: 26px;
}

.fixed_car{
    float:left;
	width:32%;
	height:24px;
	font-size: 10px;
	letter-spacing: 0.39px;
	text-align: right;
	line-height: 26px;
    color: #3F95F1;
}

.visit_car{
    float:left;
	width:32%;
	height:24px;
	font-size: 10px;
	letter-spacing: 0.39px;
	text-align: right;
	line-height: 26px;
	color: #EABB58;
}

.temp_car{
    float:left;
	width:32%;
	height:24px;
	font-size: 10px;
	letter-spacing: 0.39px;
	text-align: right;
	line-height: 26px;
	color: #F47C7C;
}

.right_box {
	width: 100%;
	height: 134px;
}

.chexing_font2 {
	font-size: 36px;
	color: #FFFFFF;
	letter-spacing: 0;
	text-align: center;
	width: 230px;
	line-height:40px
}

.chexing_font1 {
	text-align: center;
	width: 115px;
	font-size: 18px;
    color: #AFBDD1;
    letter-spacing: 0;
    line-height:32px
}

.scroll {
	font-size: 10px;
	color: #FFFFFF;
	width: 208px;
	height: 45px;
	/* border-radius: 4px; */
}

.bar {
	margin: 0px 10px;
	width: 226px;
	height: 4.8px;
	background-color: #4095F1;
	position: relative;
	cursor: pointer;
	/* border-radius: 4px; */
}

.mask {
	left: 50%;
	right: 0px;
	height: 4.8px;
	background: #F37B7B;
	display: inline;
	position: absolute;
	/* border-radius: 4px 0 0 4px; */
}

.person-td{
    font-size: 12px;
	color: #FFFFFF;
	letter-spacing: 0.4px;
	line-height: 24px;
}

.percentage-span{
	font-size: 14.4px;
	color: #FFFFFF;
	letter-spacing: 0.48px;
}

.face_info {
	width: 74px;
	height: 74px;
	margin-left: 10px;
	float: left;
}

.face_stranger_img {
	opacity: 0.64;
	background: #161832;
}

.face_img {
	width: 74px;
	height: 74px;
	display: none;
}

.face_img_canvas {
	width: 74px;
	height: 74px;
}

.face_bottom_info{
    position: absolute;
    width: 72px;
    height: 22px;
    text-align: center;
    line-height: 2;
    top: 50px;
    font-size: 12px;
    color: white;
    display: block;
    z-index: 2;
}

.blur {
    background-image: url('${ctx}/static/img/blur.svg');
}

filter: url('${ctx}/static/img/blur.svg#blur'); /* FireFox, Chrome, Opera */

</style>
<script type="text/javascript" src="${ctx}/static/js/jquery.SuperSlide.2.1.1.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/hsGovernment.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.SuperSlide.2.1.1.js"></script>
</head>
<body>
	<div style="width: 1820px; padding-top: 5px;">
	 <div class="block-div"
		style="width: 680px; height: 300px; margin-top: 5px; padding: 18px 0px;">
		<div id = "project-no-data" ></div>
		<div id = "project-data">
		<div class="slideBox">
    		<div class="bdSlide">
    		<ul class = "db-slide-ul"></ul>
    		</div>
		</div>
		 <div class="txtScroll-left">
			<div class="bd">
				<ul class="infoList">
				</ul>
			</div>
		</div>
		<div class="notice-right-div">
		 <div
				width="182" height="267" >
				<pre id = "marquee-text"   class ="notic-text" > </pre>
				</div >
<!-- 				<marquee id = "marquee-text" class ="notic-text" behavior="scroll"  scrollamount="3"  -->
<!-- 				width="182" height="267" direction="up"> -->
<!-- 				</marquee > -->
		</div>
		</div>

	</div>
	<div class="block-div"
		style="width: 540px; height: 300px; margin-top: 5px;">
		<div class="block-div-title">小区人口数据</div>
		<div class="charts">
			<div style="margin-top: 27px; height: 18px;">
				<span class="human-data-lable-font">常住人口</span>
				<div class="human-bg-base">
					<div style="background: #2FCCCE; width: 0%;" id="permanentDiv"></div>
				</div>
				<span class="human-data-value-font" id="permanentNum">-   -</span>
			</div>
			<div style="margin-top: 24px; height: 18px;">
				<span class="human-data-lable-font">流动人口</span>
				<div class="human-bg-base">
					<div style="background: #2ABA97; width: 0%;" id="floatingDiv"></div>
				</div>
				<span class="human-data-value-font" id="floatingNum">-   -</span>
			</div>
			<div style="margin-top: 24px; height: 18px;">
				<span class="human-data-lable-font">人户分离</span>
				<div class="human-bg-base">
					<div style="background: #678CDF; width: 0%;" id="IHseparationDiv"></div>
				</div>
				<span class="human-data-value-font" id="IHseparationNum">-   -</span>
			</div>
			<div style="margin-top: 24px; height: 18px;">
				<span class="human-data-lable-font">境外分离</span>
				<div class="human-bg-base">
					<div style="background: #2B8DF7; width: 0%;"
						id="overseasSeparationDiv"></div>
				</div>
				<span class="human-data-value-font" id="overseasSeparationNum">-   -</span>
			</div>
			<div style="margin-top: 24px; height: 18px;">
				<span class="human-data-lable-font">其他人员</span>
				<div class="human-bg-base">
					<div style="background: #DE8583; width: 0%;"
						id="otherDiv"></div>
				</div>
				<span class="human-data-value-font" id="otherNum">-   -</span>
			</div>

		</div>
	</div>
	<div class="block-div"
		style="width: 520px; height: 300px; margin-top: 5px;">
		<div class="block-div-title">小区人员</div>
		<div id="ageEcharts" class="charts" style="margin-left:25px"></div>
	</div>
	<div class="block-div"
		style="width: 460px; height: 620px; margin-top: 20px;">
		<div class="block-div-title">今日告警安全事件</div>
		<div class="alarm-charts" id="alarm-charts"></div>
		<div class="alarm-detail">
			<div class="alarm-detail-title" >事件明细</div>
			<div id="event-details">
				<div id="event-details-ul"></div>
				<!-- <p class="alarm-detail-font">2018-6-24 17:41:47，犯罪嫌疑人，出现在D座5楼。</p>
				<p class="alarm-detail-font">2018-6-23 15:21:47，8幢楼东西，出现高空抛物。</p>
				<p class="alarm-detail-font">2018-6-22 15:11:23，南门门口，有陌生人尾随。</p>
				<p class="alarm-detail-font">2018-6-22 15:11:23，南门门口，有陌生人尾随。</p>
				<p class="alarm-detail-font">2018-6-22 15:11:23，南门门口，有陌生人尾随。</p> -->
				<div id="playStateCell"></div>
			</div>
		</div>

	</div>
	<div class="container-div">
		<div class="block-div"
			style="width: 760px; height: 300px; margin-top: 20px;">
			<div class="block-div-title">车行流量</div>
			 <div style="float:left;width:100%;height:130px">
			   <div style="width: 505px;height: 100%;float: left;">
			   <div style="width: 100px;float:left;padding: 38px 36px;"><i><img alt="" src="${ctx}/static/img/operateSystem/chexing.svg"></i></div>
			   <div style="height: 100%;float: left;text-align:center;margin-left:69px;">
			      <p id="parking_inPassageCarNum" style="margin-top:48px;font-size: 36px;color: #FFFFFF;letter-spacing: 0;margin: 40px 0 18px;">-   -</p>
			      <p style="font-size: 18px;color: #AFBDD1;letter-spacing: 0;">总流量</p>
			   </div>
			   <div style="height: 100%;float: left;text-align:center;margin-left:89px;">
			      <p id="parking_remainParkingSpace" style="margin-top:48px;font-size: 36px;color: #FFFFFF;letter-spacing: 0;margin: 40px 0 18px;">-   -</p>
			      <p style="font-size: 18px;color: #AFBDD1;letter-spacing: 0;">空余共享车位</p>
			   </div>
			   </div>

			   <div id="parkingEchart" style="width: 250px;height: 100%;float: left;">

			   </div>
			</div>
			<div id="parking_licenceDiv" style="float:left;width:100%;height:140px;margin-left:8px;margin-top:4px">

			</div>
		</div>
		<div class="block-div"
			style="width: 760px; height: 300px; margin-top: 20px;">
			<div class="block-div-title">人行流量</div>
			<div class="right_box" style="width: 100%; height: 214px;">
				<div
					style="width: 370px; height: 55px; margin-top: 62px; float: left;">
					<table>
						<tr>
							<td style="width: 90px; text-align: right;" rowspan="2"><img
								src="${ctx}/static/img/operateSystem/renxing.svg"></td>
							<td id="access-con-totalNum" class="chexing_font2">462</td>
						</tr>
						<tr>
							<td class="chexing_font1">总流量</td>
						</tr>
					</table>
				</div>
				<div
					style="float: left; width: 350px; height: 100px; margin-top: 15px;">
					<table>
						<tr id="access-gender" class="scroll">
							<td align="right" class="person-td" valign="bottom">男</td>
							<td><div style="margin: 0 10px;">
									<span class="percentage-span left-percent">50%</span>
									<div style="float: right;">
										<span class="percentage-span right-percent">50%</span>
									</div>
								</div>
								<div class="bar">
									<div class="mask"></div>
								</div></td>
							<td align="left" class="person-td" valign="bottom">女</td>
						</tr>
						<tr id="access-owner" class="scroll" style="height: 70px;">
							<td align="right" class="person-td" valign="bottom">陌生人</td>
							<td><div style="margin-top: 21px;margin-left: 10px;margin-right: 10px;">
									<span class="percentage-span left-percent">50%</span>
									<div style="float: right;">
										<span class="percentage-span right-percent">50%</span>
									</div>
								</div>
								<div class="bar">
									<div class="mask"></div>
								</div></td>
							<td align="left" class="person-td" valign="bottom">业主</td>
						</tr>
					</table>
				</div>
				<div id="access-face"
					style="width: 700px; float: left; margin-top:51px; padding-left: 0px;">
				</div>
			</div>
		</div>
	</div>

	<div class="block-div"
		style="width: 520px; height: 300px; margin-top: 20px;margin-left:40px;">
		<div class="block-div-title">房屋统计</div>
		<div style="margin-top: 30px;">
			<span class="div-label-font">房屋总数</span><span id="houseCount" class="div-value-font">0</span>
		</div>
		<div class="content-charts" id="houseCharts"></div>
	</div>
	<div class="block-div"
		style="width: 520px; height: 300px; margin-top: 20px;margin-left:40px;">
		<div class="block-div-title">安全监控相机</div>
		<div style="margin-top: 30px;">
			<span class="div-label-font">相机总数</span><span id="videoDeviceCount" class="div-value-font">--</span>
		</div>
		<div class="content-charts" id="camertsCharts"></div>
	</div>
	</div>
	
	<div id="alarm-device-img"></div>
</body>
<script type="text/javascript">
    var ctx = '${ctx}';
    var IncidentHtml;
    var isConnectedGateWay = false;
    $(document).ready(function() {
    	getBannerList();
    	getOverview();
    	getProjectNews();
    	getHouseData();
    	getParkingData();
    	setInterval(getHouseData,60*1000);
    	//获取人员统计数量
		queryPersonnelData();
		eventDetails();
		getFaceWallData();//人行流量首次加载
		getEchart(152, "ageEcharts");
		toSubscribe();
		if (typeof (flushGovernmentProjectPageGrid) != "undefined") {
			//防止多次加载产生多个定时任务
			clearTimeout(flushGovernmentProjectPageGrid);
		}
		flushGovernmentProjectPageGrid = setTimeout("flushGovernmentGrid()", 60000);
		setInterval(getVideoMonitorData,60*1000);
		getVideoMonitorData();
    })
	function getData(id, divId) {
		$.ajax({
			type : "post",
			url : ctx + "/report/" + id + "?projectCode=" + projectCode,
			async : true,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				var obj = echarts.init(document.getElementById(divId));
				obj.setOption($.parseJSON(data));
				clickEvent(id, obj);
			},
			error : function(req, error, errObj) {
			}
		});
	}

	function hiddenScroller() {
		var height = $(window).height();
		if (height > 1060) {
			document.documentElement.style.overflowY = 'hidden';
			$(".modal-open .modal").css("overflow-y", "hidden");
			document.documentElement.style.overflowX = 'hidden';
			$(".modal-open .modal").css("overflow-x", "hidden");
		} else if (height == 943 || height == 926) {
			document.documentElement.style.overflowY = 'auto';
			$(".modal-open .modal").css("overflow-y", "auto");
			document.documentElement.style.overflowX = 'hidden';
			$(".modal-open .modal").css("overflow-x", "hidden");
		} else {
			document.documentElement.style.overflowY = 'auto';
			$(".modal-open .modal").css("overflow-y", "auto");
			document.documentElement.style.overflowX = 'auto';
			$(".modal-open .modal").css("overflow-x", "auto");
		}

	}

	function flushGovernmentGrid() {
		if (typeof (flushGovernmentProjectPageGrid) != "undefined") {
			queryPersonnelData();
			eventDetails();
			getParkingData();
			flushGovernmentProjectPageGrid = setTimeout("flushGovernmentGrid()", 60000);
		}
	}

	$(window).resize(function() {
		hiddenScroller();
	});


	//打开页面请求视频监控设备数量
	function getVideoMonitorData() {
		$.ajax({
			type : "post",
			url : ctx + "/video-monitoring/vmDeviceStatus/getVmProjectData?projectCode="+projectCode,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if(data){
					displayVideoInfo(data);
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}

	//展示视频监控信息
	function displayVideoInfo(data) {
		if(data.projectTotalNum == 0){
			$("#videoDeviceCount").html('--');
		}else{
			$("#videoDeviceCount").html(data.projectTotalNum);
		}

		var obj = echarts.init(document.getElementById("camertsCharts"));
		obj.clear();
		var option = {
			legend : {
				orient : 'vertical',
				x : "80%",
				y : "13%",
				itemGap : 20,
				itemWidth : 14,
				itemHeight : 14,
				data : [
						'在线', '离线'
				],
				textStyle : {
					color : '#979797'
				}
			},
			series : [
				{
					type : 'pie',
					radius : '50px',
					center : [
							"46%", "55%"
					],
					color : [
							'#3F95F1', '#F18B7C'
					],
					label : {
						normal : {
							textStyle : {
								color : '#AFBDD1',
								fontSize : 12
							},
							//color: '#FFFFFF',
							formatter : '{b}：{c}'
						}
					},
					labelLine : {
						normal: {
							lineStyle:{
								color: '#979797'
							},
							length : 20,
							length2 : 35
						}
					},
					data : [
							{
								value : data.projectNormalNum,
								name : '在线'
							}, {
								value : data.projectAbnormalNum,
								name : '离线'
							}
					]
				}
			]
		};
		obj.setOption(option);
	}
</script>
</html>