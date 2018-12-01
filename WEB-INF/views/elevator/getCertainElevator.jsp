<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<link href="${ctx}/static/css/pagination.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script src="${ctx}/static/js/jquery.pagination.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/operateSystemElevator.js"></script>

<style type="text/css">
.outBag {
	float: left;
	margin-left: 40px;
	margin-top: -50px;
}

.eleSuvey {
	font-size: 14px;
	margin-top: 3px;
	margin-left: 10px;
}

.eleSuvey1 {
	font-size: 14px;
	margin-left: 80px;
}

.float-lf {
	float: left;
	margin-top: 20px;
	margin-left: 14px;
}

.body {
	height: 299px;
	width: 254px;
	box-shadow: 10px 5px 30px 0 rgba(86, 86, 86, 0.50);
}

.display {
	width: 98px;
	height: 30px;
	text-align: center;
	background-image: url('${ctx}/static/images/elevator/back.png');
	margin: 0 auto;
	top: 8px;
	position: relative;
}

.bottom {
	width: 254px;
	height: 36px;
	text-align: center;
	margin-top: -36px;
	background: rgba(0, 0, 0, 0.5);
}

.visitor-info{
	background:#4DA1FF;
	width:100px;
	height:50px;
}
.visitor-info p.first-p{
	padding-top:16px;
}
.visitor-info p.second-p{
	padding-top:8px;
}
.visitor-info p{
    margin:0;
    padding-left:8px;
    color:#fff;
    font-size:12px;
    letter-spacing:2px;
}
.only-one{
/* text-align:center; */
    position: absolute;
    left: 50%;
    margin-left: -50px;
    top: 50%;
    margin-top: 80px;
    list-style: none;
}
.only-two{
/* text-align:center; */
    position: absolute;
    left: 73%;
    margin-left: -17px;
    top: 50%;
    margin-top: 80px;
    list-style: none;
}
.only-three{
/* text-align:center; */
    position: absolute;
    left: 73%;
    margin-left: -50px;
    top: 50%;
    margin-top: -50px;
    visibility: hidden;
    list-style: none;
}
.visits li{
	display:inline-block;
}
.item-avatar{
    width: 100%;
    height: 100%;
    objec-fit: cover;
}
.item-ul{
    width: 100px;
    height: 100px;
}

</style>
</head>
<body>
<div style="padding-left: 40px; margin-top:-20px;">
	<div id="upHalfBox" class="right_box">
		<iframe src="${ctx}/videomonitoring/showVideo?height=340&width=608"
			id="video-iframe2" name="video-iframe" frameborder="0"
			style="width: 606px; height: 340px;"></iframe>
	</div>
<!-- 	<div id="video_Off_Line1" style="width: 490px; height: 300px;"> -->
<%-- 		<img alt="视频离线" src="${ctx}/static/img/alarm/videoOffLine.png" style="width: 490px; height: 300px;"> --%>
<!-- 	</div> -->
	<div id="downHalfBox"></div>
</div>

<script>
// 小图标
var weixiuIcon = "${ctx}/static/images/elevator/weixiu.svg";
var kunrenIcon = "${ctx}/static/images/elevator/kunren.svg";
var shangshengIcon = "${ctx}/static/images/elevator/shangsheng.png";
var xiajiangIcon = "${ctx}/static/images/elevator/xiajiang.png";
var tingzhiIcon = "${ctx}/static/images/elevator/tingzhi.png";
var cameraBackIcon = "${ctx}/static/images/elevator/cameraBack.png";
var lixianIcon = "${ctx}/static/images/elevator/lixian.png";
var baojingIcon = "${ctx}/static/images/elevator/baojing3.svg";
var baojingwuIcon = "${ctx}/static/images/elevator/wubaojing3.svg";

// 电梯图片
var kaimenIcon = "${ctx}/static/images/elevator/kaimen.png";
var guanmenIcon = "${ctx}/static/images/elevator/guanmen.png";
var yourenIcon = "${ctx}/static/images/elevator/youren.png";
var backIcon = "${ctx}/static/images/elevator/back.png";
var dikuangIcon = "${ctx}/static/images/elevator/bluedikuang.svg"

// 组装div的图片
var jiankong;
var baojing;
var weixiu;
var kunren;
var dianti;
var yunxingStatus;
var defaultUrl = "${ctx}/static/images/elevator/morentouxiang2.png";
var judgment = false;
var projectCode = "${param.projectCode}";
var ctx = "${ctx}";
var flushImage;
var currDeviceNo =  "${param.deviceNo}";

var queueArray1 = new Array();

	//加载电梯实时运行数据(上面视频+下面运行)
	function showElevator(deviceNo) {
		$.ajax({
			type : "post",
			url : ctx
					+ "/elevator/elevatorDataService/getElevatorData?param="
					+ deviceNo + "&projectCode=" + projectCode,
			success : function(data) {
				if (data) {
 					showFiresVideoMonitor2(data[0].cameraDeviceId);
					var val = data[0].runningRecord;
					var survey = data[0].survey;
					var lastAlarm = data[0].lastAlarmType;
					var alarmStr = "";

					// 报警数
					if (data[0].alarmNum == 0) {
						baojing = baojingwuIcon;
						alarmStr = '<div style="margin-left: 30px;">无报警信息</div>';
					} else {
						baojing = baojingIcon;
						if(lastAlarm.length > 30){
							lastAlarm = lastAlarm.substring(0,29)+"...";
						}
						alarmStr = '<div style="margin-left: 30px; color: red;">'
								+ lastAlarm + '</div>';
					}
					// 电梯概况
					var eleTable = '<div style="float: left; width: 608px; height: 266px; margin-top:20px; background-image: url('
						+ dikuangIcon + ');">'
					+ '<table style="width: 570px; color: white; font-size: 14px; " align="center"; cellspacing="10";>'
					+ '<tr></tr>'
					+ '<tr><td colspan="2" style="font-size: 18px; text-align: center;">电梯概况</td><td></td></tr>'
					+ '<tr></tr>'
					+ '<tr><td>电梯编号：' + val.deviceNo + '</td><td>电梯名称：' + val.deviceName + '</td></tr>'
					+ '<tr><td>位置：' + survey.location + '</td><td>当日客流量：' + survey.currDayPassengerFlow + '</td></tr>'
					+ '<tr><td>品牌：' + survey.brand + '</td><td>厂商：' + survey.manufacturer + '</td></tr>'
					+ '<tr><td>维保时间：' + survey.maintenanceTime + '</td><td id="fixTime'+val.deviceNo+'">下次维保：'+survey.nextMaintenanceTime + '</td></tr>'
					+ '<tr><td colspan="2"><img src="'+baojing+'" style="float: left;">'+ alarmStr +'</td></tr></table></div>'

					$("#downHalfBox").html(eleTable);
					if (survey.nextMaintenanceTime.indexOf("超期") != -1) {
						$('#fixTime' + val.deviceNo)
								.css('color', 'red');
					}
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}

	function callbackLoadVideo(){
		showElevator(currDeviceNo);
	}
	
	
	function showFiresVideoMonitor2(deviceId) {
		if (deviceId == null || deviceId == undefined) {
			return;
		}
		$("#video-iframe2")[0].contentWindow.closeVideo();
		$("#video-iframe2")[0].contentWindow.startPlay(deviceId);
	}
</script>
</body>
</html>