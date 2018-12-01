<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM" />
<!DOCTYPE html>
<html style="height: 100%">
<title>建设地图</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Page-Exit" content="revealTrans(Duration=3,Transition=5)">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
<meta name="viewport" content="initial-scale=1.0" />
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">

<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/theme/rib-green.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
<script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<script src="${ctx}/static/js/echarts/echarts.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/china.js" type="text/javascript"></script>
<script src="${ctx}/static/js/charts.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/groupMain.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/deviceStateData.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/elevatorStateData.js"></script>
<style type="text/css">
html {
	font-size: 12px;
	font-family: SimHei;
/* 		overflow:-moz-scrollbars-horizontal;   */
    overflow:-moz-scrollbars-vertical;
}

::-webkit-scrollbar{
  display:none;
}

.head {
	background: rgba(0, 7, 49, 0.4);
	width: 1920px;
	height: 100px;
	z-index: 99;
	position: relative;
}
button.close{
    background-color: #999;
	border-top-left-radius: 12px;
	border-bottom-left-radius: 12px;
	padding-top: 1px;
	padding-bottom: 1px;
	padding-left: 8px;
	padding-right: 20px;
	border-top: 1px solid #666;
	border-bottom: 1px solid #666;
	border-left: 1px solid #666;
	font-size: 20px;
}
    
.close{
	float: right;
    font-size: 21px;
    font-weight: 700;
    line-height: 1;
    color: #000;
    text-shadow: 0 1px 0 #fff;
    filter: alpha(opacity=20);
    opacity: 0.2;
}
.form-control{
	border-radius: 0px;
    box-shadow: none;
}
.modal-footer{
    background-color: #E8F4F0;
    border-top-width: 0px;
    text-align: center;
    border-bottom-left-radius: 6px;
    border-bottom-right-radius: 6px;


}
.btn-modal{
	padding-left: 20px;
    padding-right: 20px;
    padding-top: 5px;
    padding-bottom: 5px;
    color: #fff;
    background-color: #129D7C;
    border-width: 0px;

}


.area {
	width: 480px;
	height: 800px;
	background: rgba(23, 29, 78, 0.5);
	box-shadow: 0 2px 73px 0 #15295F;
	z-index: 99;
	position: relative;
	margin-top: 90px;
}

.block {
	float: left;
	height: 100px;
	margin-top: 18px;
}

.font_type1 {
	opacity: 0.5;
	font-size: 14px;
	color: #FFFFFF;
}

.font_type2 {
	font-size: 36px;
	color: #56E4FF;
}

.font_type3 {
	font-size: 12px;
	color: #FFFFFF;
	letter-spacing: 0;
	opacity: 0.5;
}

::-webkit-input-placeholder, ::-moz-placeholder {
	font-size: 16px;
	color: rgba(255, 255, 255, 0.80);
}

.reportClass {
	position: relative;
	margin-top: 32px;
	margin-left: auto;
	margin-right: auto;
	background: rgba(0, 0, 0, 0.39);
	box-shadow: -20px 0 30px 0 rgba(0, 0, 0, 0.20);
	border-radius: 4px;
	width: 300px;
	height: 100px;
}

.inner-div::-webkit-scrollbar {
    display: none;
}
scrollbar{display:none!important;}
</style>
<link
	href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css"
	type="text/css" rel="stylesheet" />
<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js"
	type="text/javascript"></script>
</head>
<body style="width: 1920px; height: 1080px;" >
	<div style="width: 1920px; height: 1080px; position: relative;" class="inner-div" style="opacity: 0.9;background-image: linear-gradient(-180deg, #1E305F 0%, #1C366F 100%);">
		<div id="groupMapDisplay" style="width: 1920px; height: 1080px; position: absolute; z-index: 0;"></div>
		<div class="head">
			<div style="width: 240px; height: 100%; float: left;">
				<img src="${ctx}/static/group/greentownlogo1.svg" style="margin-top: 25px; margin-left: 30px;">
			</div>
			<div style="width: 1210px; height: 100%; float: left; padding-left: 30px;">
				<div style="float: left; margin-left: 946px; height: 100px; line-height: 100px; width: 80px;">
					<img id="weatherIcon" src="${ctx}/static/group/one_qingtian.png" />
				</div>
				<div style="float: left; height: 100px; line-height: 100px; text-align: center; padding-top: 21px; padding-left: 20px">
					<span id="temperature" style="font-family: PingFangSC-Light;font-size: 24px; color: #FFFFFF; display: block; height: 33px; line-height: 33px;">28～30℃</span>
					<span id="weatherType" style="font-family: PingFangSC-Light; font-size: 14px; color: #FFFFFF; display: block; height: 20px; line-height: 20px;">晴</span>
				</div>
			</div>
			<div style="background: rgba(0, 0, 0, 0.1); width: 340px; height: 100%; float: left; text-align: right;">
				<div id="time" style="font-size: 64px; color: #FFFFFF; width: 156px; float: left; padding-top: 5px; padding-bottom: 5px; margin-left: 26px;">18:07</div>
				<div id="week" style="font-size: 20px; color: #FFFFFF; letter-spacing: 0; float: left; width: 120px; margin-top: 17.64px;">星期三</div>
				<div id="ymd" style="font-size: 20px; color: #FFFFFF; letter-spacing: 0; float: left; width: 120px; margin-top: 10px;">2017-6-21</div>
			</div>
			<div id="user_setting" style="float: left; width: 130px; height: 100%;">
				<div style="display: table-cell; vertical-align: middle; text-align: center; width: 130px; height: 100px;">
					<img id ="user_login" style="vertical-align: middle;cursor: pointer;" alt="" src="${ctx}/static/group/yonghu.png">
				</div>
				<ul id="ul_user_setting" style="width:130px;height: 80%;background-color: #FFF;min-width: 10rem;padding: 0;display:none;">
					<li style="height: 50%;list-style-type:none;text-align: center;vertical-align: middle;">
						<a id="p-change-password" href="#" style="font-size: 14px;color: #6D6D6D;letter-spacing: 0;display:block;padding-top: 10px;height: 100%;">修改密码</a>
					</li>
					<li style="height: 50%;list-style-type:none;text-align: center;vertical-align: middle;">
						<a href="${ctx}/logout" style="font-size: 14px;color: #6D6D6D;letter-spacing: 0;display:block;height: 100%;padding-top: 10px;">注销</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="area" style="float: left; box-shadow: 20px 0 30px 0 rgba(0, 0, 0, 0.20);" id="left_area">
			<div style="width: 440px; height: 200px; margin-left: 20px; margin-right: 20px; padding-top: 20px;">
				<div style="width: 100%; float: left; font-size: 16px; color: #FFFFFF; height: 22px;">集团总监管设备</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td
								style="padding-top: 16px; text-align: center; padding-left: 10px;"><span 
								id="deviceCount" class="font_type2"></span><span id="deviceWan" 
								style="font-size: 14px; color: #56E4FF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">总数</span>
							</td>
						</tr>
					</table>
				</div>
				<div id="deviceState" style="width: 270px;" class="block"></div>
			</div>
			<div style="width: 440px; height: 200px; margin-left: 20px; margin-right: 20px; padding-top: 20px; border-top: 1px solid rgba(255, 255, 255, 0.3);">
				<div style="width: 100%; float: left; font-size: 16px; color: #FFFFFF; height: 22px;">集团总消防设备</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center; padding-left: 10px;">
								<span id="master_total" class="font_type2">0</span>
								<span id="master_total_unit" style="font-size: 14px; color: color: #56E4FF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">主机总数</span>
							</td>
						</tr>
					</table>
				</div>
				<div style="width: 140px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center; padding-left: 10px;">
								<span id="master_abnormal" class="font_type2">0</span>
								<span id="master_abnormal_unit" style="font-size: 14px; color: #56E4FF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">异常总数</span>
							</td>
						</tr>
					</table>
				</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px; padding-left: 10px;">
						<tr>
							<td style="padding-top: 16px; text-align: center;">
								<span id="master_fires" class="font_type2">0</span>
								<span id="master_fires_unit" style="font-size: 14px; color: #56E4FF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">火警总数</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div id="left_button" class="small" style="background: rgba(0, 0, 0, 0.3); box-shadow: 20px 0 30px 0 rgba(0, 0, 0, 0.20); width: 32px; height: 60px; left: 480px; top: 370px; position: absolute;">
				<img id="left_img" src="${ctx}/static/group/zuofan.svg" style="margin-top: 21px; margin-left: 8px;">
			</div>
			<div style="width: 440px; height: 200px; margin-left: 20px; margin-right: 20px; padding-top: 20px; border-top: 1px solid rgba(255, 255, 255, 0.3);">
				<div style="width: 100%; float: left; font-size: 16px; color: #FFFFFF; height: 22px;">集团总电梯设备</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center; padding-left: 10px;">
								<span id="allElevators" class="font_type2"></span>
								<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">总数</span>
							</td>
						</tr>
					</table>
				</div>
				<div id="elevator_group" style="width: 270px;" class="block"></div>
			</div>
			<div style="width: 440px; height: 200px; margin-left: 20px; margin-right: 20px; padding-top: 20px; border-top: 1px solid rgba(255, 255, 255, 0.3);">
				<div style="width: 100%; float: left; font-size: 16px; color: #FFFFFF; height: 22px;">
					能耗排行
					<div style="background: rgba(0, 191, 165, 0.5); border-radius: 4px; width: 36px; height: 20px; margin-top: -20px; margin-left: 343px; line-height: 20px; text-align: center">
						<span id="power_supply_month" style="font-size: 12px; color: #FFFFFF; letter-spacing: 0;">七月</span>
					</div>
				</div>
				<div style="width: 100%;float: left;margin-top: 18px;">
					<table id="power-supply" style="width: 90%; height: 100%;">
						<tr style="font-size: 14px; opacity: 0.8; color: #FFFFFF; letter-spacing: 0;">
							<td style="text-align: left; width: 30%; padding-left: 20px;">项目名称</td>
							<td style="text-align: center; width: 52%;">月度能耗</td>
							<td style="text-align: center;" colspan="2">同比</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 右侧展示 -->
		<div class="area" style="float: right; box-shadow: -20px 0 30px 0 rgba(0, 0, 0, 0.20);" id="right_area">
			<div style="width: 440px; height: 200px; margin-left: 20px; margin-right: 20px; padding-top: 20px;">
				<div style="width: 100%; float: left; font-size: 16px; color: #FFFFFF; height: 22px;">
					<div style="width: 150px; float: left;">集团总停车场设备</div>
					<div style="float: left; margin-left: 190px;">
						<span style="font-size: 12px; color: #FFFFFF; letter-spacing: 0;">设备异常：</span>
						<span id="parking_deviceFalutNum" style="font-size: 12px; color: #000000; letter-spacing: 0; line-height: 17px; color: #F37B7B;">--</span>
					</div>
				</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center; padding-left: 10px;">
								<span class="font_type2" id="parking_parkingNum">--</span>
								<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1" >停车场总数</span>
							</td>
						</tr>
					</table>
				</div>
				<div style="width: 140px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center; padding-left: 10px;">
								<span class="font_type2" id="parking_inPassageCarNum" >--</span>
								<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">总车流量</span>
							</td>
						</tr>
					</table>
				</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center; padding-left: 10px;">
								<span class="font_type2" id="parking_visitorCarNum">--</span>
								<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">访客车流量</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div style="width: 440px; height: 200px; margin-left: 20px; margin-right: 20px; padding-top: 20px; border-top: 1px solid rgba(255, 255, 255, 0.3);" id="group-access-control">
				<div style="width: 100%; float: left; font-size: 16px; color: #FFFFFF; height: 22px;">
					<div style="width: 150px; float: left;">集团总人行出入设备</div>
					<div style="float: left; margin-left: 190px;">
						<span style="font-size: 12px; color: #FFFFFF; letter-spacing: 0;">设备异常：</span>
						<span id="group-access-control-abnormal" style="font-size: 12px; color: #000000; letter-spacing: 0; line-height: 17px; color: #F37B7B;">0</span>
					</div>
				</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center; padding-left: 10px;">
								<span id="group-access-control-door" class="font_type2">0</span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">重要门未关总数</span>
							</td>
						</tr>
					</table>
				</div>
				<div style="width: 140px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center; padding-left: 10px;">
								<span id="group-access-control-in" class="font_type2">0</span>
								<span style="font-size: 14px; color:  #56E4FF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">总人流量</span>
							</td>
						</tr>
					</table>
				</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center; padding-left: 10px;">
								<span id="group-access-control-visitor" class="font_type2">0</span>
								<span style="font-size: 14px; color:  #56E4FF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">访客人流量</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div id="right_button" class="small" style="background: rgba(0, 0, 0, 0.3); box-shadow: -20px 0 30px 0 rgba(0, 0, 0, 0.20); width: 32px; height: 60px; left: -32px; top: 370px; position: absolute;">
				<img id="right_img" src="${ctx}/static/group/youfan.svg" style="margin-top: 21px; margin-left: 8px;">
			</div>
			<div style="width: 440px; height: 200px; margin-left: 20px; margin-right: 20px; padding-top: 20px; border-top: 1px solid rgba(255, 255, 255, 0.3);">
				<div style="width: 100%; float: left; font-size: 16px; color: #FFFFFF; height: 22px;">
					<div style="width: 150px; float: left;">集团总暖通设备</div>
					<div style="float: left; margin-left: 190px;">
						<span style="font-size: 12px; color: #FFFFFF; letter-spacing: 0;">设备异常：</span>
						<span style="font-size: 12px; color: #000000; letter-spacing: 0; line-height: 17px; color: #F37B7B;">0</span>
					</div>
				</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center;">
								<span id="total_count" class="font_type2">0</span>
								<span id="ten_thousand" style="font-size: 14px; color: #56E4FF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">主机总数</span>
							</td>
						</tr>
					</table>
				</div>
				<div id="blocks" style="width: 270px;" class="block"></div>
			</div>
			<div style="width: 440px; height: 200px; margin-left: 20px; margin-right: 20px; padding-top: 20px; border-top: 1px solid rgba(255, 255, 255, 0.3);">
				<div style="width: 100%; float: left; font-size: 16px; color: #FFFFFF; height: 22px;">
					<div style="width: 150px; float: left;">集团总给排水设备</div>
					<div style="float: left; margin-left: 190px;">
						<span style="font-size: 12px; color: #FFFFFF; letter-spacing: 0;">设备异常：</span><span
							 id="id_sdm_error" style="font-size: 12px; color: #000000; letter-spacing: 0; line-height: 17px; color: #F37B7B;">--</span>
					</div>
				</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center;"><span id="supple_device_numer"
								class="font_type2">--</span>
								<!-- <span
								style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span> --> 
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">给水总数</span>
							</td>
						</tr>
					</table>
				</div>
				<!-- 给水饼图 -->
				<div class="block" style="width: 65px;" id="watersupple_bing">
				</div>
				<div style="width: 150px;" class="block">
					<table style="width: 100%; height: 100px;">
						<tr>
							<td style="padding-top: 16px; text-align: center;"><span id="drain_device_numer"
								class="font_type2">--</span> <!--<span
								style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>!-->
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; padding-top: 14px; padding-left: 15px;">
								<span class="font_type1">排水总数</span>
							</td>
						</tr>
					</table>
				</div>
				<div class="block" style="width: 65px;"  id="drain_bing"></div>
				<div style="width: 100%; height: 30px; float: left; padding-top: 13px;">
					<table style="width: 40%; height: 1.67rem; margin-left: 160px;">
						<tr>
							<td align="center">
								<div style="width: 10px; height: 10px; background: #00BFA5; float: left;"></div>
							</td>
							<td>
								<div style="font-size: 12px; color: #999999; letter-spacing: 0; float: left;">正常</div>
							</td>
							<td>
								<div style="width: 10px; height: 10px; background: #F4CC8A; float: left;"></div>
							</td>
							<td>
								<div style="font-size: 12px; color: #999999; letter-spacing: 0; float: left;">关闭</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div
			style="width: 569px; height: 170px; margin: 0 auto; margin-top: 60px; position: relative; z-index: 99;">
			<div
				style="width: 100%; height: 70px; font-family: PingFangSC-Regular;font-size: 50px;color: #56E4FF;letter-spacing: 1.67px; text-align: center;">设施设备云平台建设地图</div>
			<div id="project_num" style="width: 314px; height: 24px; opacity: 0.5;font-family: PingFangSC-Regular;font-size: 12px;color: #FFFFFF;letter-spacing: 0.16px; text-align: center; line-height:24px;margin-top: 44px;margin-left: 138px;background: rgba(255,255,255,0.12);border: 1px solid #00BFA5;float：left;">
					<span id="project_proportion" style="color: #1F2E56;">已接入100%项目</span>
<!-- 				<span id="project_proportion" style="width:100px; height:17px; margin-top:3px;margin-left:107px;"> -->
<!-- 				</span> -->
			</div>
			<div id="project_item" style="width:18px;height:24px;background: #56E4FF;border: 1px solid #00BFA5;margin-top: -24px;margin-left: 138px;">
			</div>
		</div>
		<!-- 弹窗开始 -->
		<!-- 第一个弹窗style="visibility: hidden;" -->
		<div id="report_one_div" style="visibility: hidden;"
			class="reportClass">
			<input id="idone" type="text" style="display: none;" /> <input
				id="codeone" type="text" style="display: none;" />
			<div
				style="margin-top: 28px; margin-left: 20px; width: 60px; float: left;">
				<img src="${ctx}/static/group/gaojinginfo.svg">
			</div>
			<div
				style="height: 80%; float: left; margin-left: 3px; margin-top: 10px;">
				<div style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">
					最新事件：<span id="sjone"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					项目名称：<span id="xmone"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					最新时间：<span id="zsjone"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>

			</div>
		</div>
		<!-- 第二个弹窗 style="visibility: hidden;"-->
		<div id="report_two_div" style="visibility: hidden;"
			class="reportClass">
			<input id="idtwo" type="text" style="display: none;" /> <input
				id="codetwo" type="text" style="display: none;" />
			<div
				style="margin-top: 28px; margin-left: 20px; width: 60px; float: left;">
				<img src="${ctx}/static/group/gaojinginfo.svg">
			</div>
			<div
				style="height: 80%; float: left; margin-left: 3px; margin-top: 10px;">
				<div style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">
					最新事件：<span id="sjtwo"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					项目名称：<span id="xmtwo"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					最新时间：<span id="zsjtwo"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>

			</div>
		</div>
		<!-- 第三个弹窗 style="visibility: hidden;"-->
		<div id="report_three_div" style="visibility: hidden;"
			class="reportClass">
			<input id="idthree" type="text" style="display: none;" /> <input
				id="codethree" type="text" style="display: none;" />
			<div
				style="margin-top: 28px; margin-left: 20px; width: 60px; float: left;">
				<img src="${ctx}/static/group/gaojinginfo.svg">
			</div>
			<div
				style="height: 80%; float: left; margin-left: 3px; margin-top: 10px;">
				<div style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">
					最新事件：<span id="sjthree"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					项目名称：<span id="xmthree"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					最新时间：<span id="zsjthree"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>

			</div>
		</div>
		<!-- 第四个弹窗 style="visibility: hidden;"-->
		<div id="report_four_div" style="visibility: hidden;"
			class="reportClass">
			<input id="idfour" type="text" style="display: none;" /> <input
				id="codefour" type="text" style="display: none;" />
			<div
				style="margin-top: 28px; margin-left: 20px; width: 60px; float: left;">
				<img src="${ctx}/static/group/gaojinginfo.svg">
			</div>
			<div
				style="height: 80%; float: left; margin-left: 3px; margin-top: 10px;">
				<div style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">
					最新事件：<span id="sjfour"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					项目名称：<span id="xmfour"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					最新时间：<span id="zsjfour"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>

			</div>
		</div>
		<!-- 第五个弹窗 style="visibility: hidden;"-->
		<div id="report_five_div" style="visibility: hidden;"
			class="reportClass">
			<input id="idfive" type="text" style="display: none;" /> <input
				id="codefive" type="text" style="display: none;" />
			<div
				style="margin-top: 28px; margin-left: 20px; width: 60px; float: left;">
				<img src="${ctx}/static/group/gaojinginfo.svg">
			</div>
			<div
				style="height: 80%; float: left; margin-left: 3px; margin-top: 10px;">
				<div style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">
					最新事件：<span id="sjfive"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					项目名称：<span id="xmfive"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>
				<div
					style="font-size: 12px; color: #999999; letter-spacing: 0; margin-top: 10px;">
					最新时间：<span id="zsjfive"
						style="font-size: 12px; color: #999999; letter-spacing: 0;"></span>
				</div>

			</div>
		</div>
	</div>
	<div id="change-password"></div>
	<div id="error-div"></div>
</body>
<script>
var normal=0;
var abnormal=0;
// 正常主机数量（即主机未离线数量）与非正常数量
var hostFlag = false;
var hostNormal=0;
var hostAbnormal=0;

// 正常电表数量（无故障）与非正常数量
var electricFlag = false;
var electricNormal=0;
var electricAbnormal=0;

// 正常电梯数量（无报警）与非正常数量
var elevatorFlag = false;
var elevatorNormal=0;
var elevatorAbnormal=0;

// 停车场正常设备（未离线）总数与非正常数量
var vehicleFlag = false;
var vehicleNormal=0;
var vehicleAbnormal=0;

// 人行出入正常设备（未离线）与非正常数量
var peopleFlag = false;
var peopleNormal=0;
var peopleAbnormal=0;

// 暖通正常设备总数（无故障）与非正常数量
var havcFlag = false;
var havcNormal=0;
var havcAbnormal=0;

// 给排水正常总数（无故障）与非正常数量
var waterFlag = false;
var waterNormal=0;
var waterAbnormal=0;

// 监控相机正常总数与非正常数量
var cameraFlag = false;
var cameraNormal=0;
var cameraAbnormal=0;
//电梯饼图正常异常电梯数全局变量
var normals=null;
var abnormals=null;
var chartsJsObj=null;
var times = 0;
	var accessControlDeviceNo;
	var flushAccessControl;
	var flushElevator;
	var flushParking;
	var divids;
	var idss;
	var isConnectedGateWay = false;
	var dataList = new Array();
	var alarmList = new Array();
	var qList = new Array();
	var today="${today}";
	var ctx = "${ctx}";
	//项目总数
	var projectTotal = 0;
	//开通的项目数
	var projectOpenNum = 0;
	$(document).ready(function() {
		hiddenScroller();
        $("body").css("display","none");
        $("body").fadeIn("normal");
        $("a[target],a[href*='javascript'],a.lightbox-processed,a[href*='#']").addClass("speciallinks");
        $("a:not(.speciallinks)").click(function(){
            $("body").fadeOut("normal");
            $("object,embed").css("visibility","hidden");
        });
		deviceStateDatas(normal,abnormal);
		elevatorStateDatas();
		getParkingGroupData();
		initGroupMapDisplay();
		groupChartsClickEnventInit();
		findWeather();
		showTime();
		hvac();
		//getData(103, "supervision_equipment");
		$("#search").on('click',function (){
			searchHandle();
		});
		getAccessControlData(1);
		getVideoMonitoringData();
		if(typeof(flushAccessControl) != "undefined"){
			//防止多次加载产生多个定时任务
			clearTimeout(flushAccessControl);
		}
		if(typeof(flushElevator) != "undefined"){
			//防止多次加载产生多个定时任务
			clearTimeout(flushElevator);
		}
		if(typeof(flushParking) != "undefined"){
			//防止多次加载产生多个定时任务
			clearTimeout(flushParking);
		}
		flushAccessControl = setTimeout("flushAccessControlData()",60000);
		flushParking = setTimeout("flushParkingData()",60000);
		flushElevator = setTimeout("elevatorStateDatas()",60000);
		energyConsumptionTotal();
		getAllDeviceCount();
		getAllOrganizeCount();
		getAllFireFightingData();
		getElevatorData();
		setTimeout(function(){startConn('${ctx}')}, 6000);
		supplyDrainData();
		initSupplyDrainEchart();
		getHvacData(103, "blocks");
		
		$("#left_button").css("cursor", "pointer").click(function() {
			if ($("#left_button").hasClass("small")) {
				$("#left_area").animate({
					left : "-480px"
				}, 500, function() {
					$("#left_button").removeClass().addClass("big");
					$("#left_img").attr("src", ctx + "/static/group/youfan.svg");
				});
			} else {
				$("#left_area").animate({
					left : "0px"
				}, 500, function() {
					$("#left_button").removeClass().addClass("small");
					$("#left_img").attr("src", ctx + "/static/group/zuofan.svg");
				});
			}

		});
		$(window).resize(function() {  
			var height = $(this).height();  
			if(height>1070){
				document.documentElement.style.overflowY = 'hidden';
			}else{
				document.documentElement.style.overflowY = 'auto';
			}
			
			});  

		$("#right_button").css("cursor", "pointer").click(function() {
			if ($("#right_button").hasClass("small")) {
				$("#right_area").animate({
					right : "-480px"
				}, 500, function() {
					$("#right_button").removeClass().addClass("big");
					$("#right_img").attr("src", ctx + "/static/group/zuofan.svg");
				});
			} else {
				$("#right_area").animate({
					right : "0px"
				}, 500, function() {
					$("#right_button").removeClass().addClass("small");
					$("#right_img").attr("src", ctx + "/static/group/youfan.svg");
				});
			}
		});
		//点击用户图片弹出密码修改和注销下拉菜单
		$("#user_login").click(function(){
			//弹出修改密码和注销下拉框
			$("#ul_user_setting").toggle();
		});
		//点击其他区域下拉框消失
		$(document).click(function(e){
			var id=$(e.target).attr("id");
			 if(id!="user_login"){
			    $("#ul_user_setting").hide();
			 }
		});
		//点击修改密码跳转修改密码弹窗
	    $("#p-change-password").on("click", function() {
	    	createModalWithLoad("change-password", 400, 250, "修改密码", "operatorManage/changePassword", "updatePassword()", "confirm-close", "");
	        $("#change-password-modal").modal("show");
	        $("#ul_user_setting").css("display","none");
	    });
		
		
	})
    function hiddenScroller(){
		var height = $(window).height();
    	if(height>1070){
    		document.documentElement.style.overflowY = 'hidden';
    		document.documentElement.style.overflowX = 'hidden';
    	}else{
    		document.documentElement.style.overflowY = 'auto';
    		document.documentElement.style.overflowX = 'auto';
    	}
	}
	
	function hiddenScrollerPage() {
		var height = $(window).height();
		if (height > 1060) {
			document.documentElement.style.overflowY = 'hidden';
			document.documentElement.style.overflowX = 'hidden';
		}else if(height == 943 || height == 926){
			document.documentElement.style.overflowY = 'auto';
			document.documentElement.style.overflowX = 'hidden';
		}else {
			document.documentElement.style.overflowY = 'auto';
			document.documentElement.style.overflowX = 'auto';
		}
		
	}

	$(window).resize(function() {
		hiddenScrollerPage();
	});
</script>
</html>