<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style>
/* #tb_summaryDataDiv{ overflow:auto} */
</style>
<link href="${ctx}/static/css/pagination.css" rel="stylesheet"
	type="text/css" />
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script type="text/javascript"
	src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<script src="${ctx}/static/js/jquery.pagination.js"
	type="text/javascript"></script>
<style type="text/css">

 .header-default { 
 	background-color: #fff; 
 	border: 1px solid #e1e1e1; 
 	padding: 17px; 
 	margin-bottom: 20px; 
 	margin-left: 10px; 
 	width: 99%; 
 	background: #FFFFFF; 
 	border: 1px solid #B2B2B2; 
 	border-radius: 4px; 
 } 

.form-control {
	margin-left: 10px;
	border: 1px solid #CCCCCC;
	border-radius: 2px;
}

#quPassageName, #ddl-btn-quPassageName, #ddl-btn-custmTypeName,
	#custmTypeName {
	/* 	border: 1px solid #CCCCCC; */
	/* 	border-radius: 2px; */
	
}

.pagination .current.prev, .pagination .next {
	border-color: #FFFFFF;
	background: #ffffff;
	font-size: 12px;
	color: #00BFA5;
}

.pagination .prev {
	border-color: #FFFFFF;
	background: #ffffff;
	font-size: 12px;
	color: #0B78CC;
}

.pagination .current {
	border: 0px solid #E3EBED;
	background-color: #00BFA5;
	font-size: 14px;
	padding-top: 4px;
}

.pagination a {
	text-decoration: none;
	background: #FFFFFF;
	border: 1px solid #E3EBED;
	font-family: PingFangSC-Regular;
	font-size: 12px;
	color: #00BFA5;
}

.btn-common {
	margin-right: 0px !important;
}

.level{
	width:80px; 
	height:30px; 
	border-radius: 4px; 
	margin-left:30px; 
	border: 1px solid #979797; 
	text-align:center; 
	font-size: 12px; 
	outline: none;
	background-color: #FFF;
	border: 1px solid #979797;

}
.unSelected {
	background-color: #FFF;
	border: 1px solid #979797;
}
.selected {
	color:#FFF;
	background-color: #00BFA5;
	border: 1px solid #00BFA5;
}
 .a{ 
 } 
 .a:hover{ 
     background:#EFEFEF; 
 }

</style>
</head>
<body>
	<div class="content-default" style="">
		<form id="select-form" style="margin-top: -3px;">
			<table style="">
				<tr>
					<td  align ="right" style="font-size: 14px;width:60px;">级别：</td>
					<td>
					<input id="-1" class="level"  type="button" value="全部" onclick="onclickInput(this)">
					<input id="1"class="level"  type="button" value="一级" onclick="onclickInput(this)">
					<input id="2"class="level"  type="button" value="二级" onclick="onclickInput(this)">
					<input id="3"class="level"  type="button" value="三级" onclick="onclickInput(this)">
					<input id="4"class="level"  type="button" value="四级" onclick="onclickInput(this)">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- tag  overflow:scroll; overflow:-moz-scrollbars-vertical;-->
	<div id="tb_summaryDataDiv" class="content-default"
		style="height: 99%; width: 100%; overflow:scroll;overflow:hidden; padding-top: 0px;padding-bottom: 35px; padding-left: 60px; background: #fff; border: 1px solid #ccc;" >
	</div>
	<div class="pagination" style="position: relative; float: right;"></div>
	<div id="electricityDetail-img"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
	<script type="text/javascript">
	
		var firstReturnData;
		var returnData;
		var elctricityLevel="-1";
		var orgId = $("#login-org").data("orgId");
		var electricityDetail;
		var limit = 30;
		var orgId=projectId;
		var currentDisplayPage=0;
		var deviceData;
		var deviceParam;
		var code="THREE_PHASE_POWER_METER";
		var isOpenDetail=0;
		if(orgId==""){
			orgId = $("#login-org").data("orgId");
		}
		var countRecord;
		var meterLocationAndStructure;
		$(document).ready(function() {
			document.getElementById('-1').className="selected level"; 
			initDevice();
			toSubscribe();
		});
		
		
		function onclickInput(obj){
			$(".level").removeClass("selected");
			$(obj).addClass("selected");
			elctricityLevel=obj.id;
			initDevice();
		}
		
		
		function initDevice() {//初始设备
			var data = {
				"projectCode" : projectCode
			};
			$(data).attr({
				"level" : elctricityLevel
			});
			$(data).attr({
				"code" : code
			});
			$.ajax({
					type : "post",
					url : "${ctx}/device/manage/getRunningMeterDevices?page=1&limit=" + limit
					+ "&sortName=deviceName&sortType=desc",
					async : false,
					dataType : "json",
					data : JSON.stringify(data),
					contentType : "application/json;charset=utf-8",
					success : function(data) {
						deviceData = data.items;
						deviceParam=data;
						$("#tb_summaryDataDiv").find("div").remove();
						if(deviceData.length>0){
							initDiv(deviceData,deviceParam);
						}else{
							var nodataDiv= '<div style="width:100%;height:600px;padding-top: 3rem;font-size:20px;line-height:600px;text-align:center;">'
							+"无数据"+'</div>';
							$("#tb_summaryDataDiv").append(nodataDiv);
						}
				},
				error : function(req, error, errObj) {
				}
			});
		}
		
		
		function initDiv(deviceData,deviceParam) {//div
			//这里向后台请求的url需要替换
			//var devideParam=deviceData.items;
			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/pdsElectricityMeterRecord/summaryData",
				data : JSON.stringify(deviceData),
				dataType : "json",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if(data.code==0){
						firstReturnData = data;
					} else {
						showDialogModal("error-div", "提示信息", data.MESSAGE, 1,
								null, true);
					}
				},
				error : function(req, error, errObj) {
				}
			});
			$(".pagination").pagination(deviceParam.totalCount, {
				callback : pageselectCallback,
				prev_text : '上一页',
				next_text : '下一页',
				items_per_page : 30,
				num_display_entries : 5,
				num_edge_entries : 2
			});
		
		}

		function pageselectCallback(page_index, jq) {
			InitData(page_index);
		}
		function InitData(page_id) {
			currentDisplayPage=page_id;
			getData(page_id + 1);
		}
 		function electricityModal(id) {
 			var detailData;
 			if(currentDisplayPage==0){
 				detailData=firstReturnData;
 			}else{
 				detailData=returnData;
 			}
 			for (var i = 0; i < detailData.data.length; i++) {
 				if(detailData.data[i].deviceId==id){
	 				electricityDetail=detailData.data[i];
 		 			var deviceName ='<label style="font-size: 14px;color:#151515;;font-weight:bold;margin-left:8px;" >'+electricityDetail.deviceName + '</label>';
 				}
 			}
 			//这里需要去查询电表位置信息和电表结构欧
 			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/pdsElectricityMeterRecord/getLocationAndStructure?deviceId="+id,
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if(data.code==0){
						meterLocationAndStructure = data.data;
					} else {
						showDialogModal("error-div", "提示信息", data.MESSAGE, 1,
								null, true);
					}
					//查询到数据再跳转页面
					createModalWithLoad("electricityDetail-img", 800, 570, deviceName,
							"psdMain/electricityDetail", "", "", "");
					openModal("#electricityDetail-img-modal", true, false);
					hiddenScroller();
				},
				error : function(req, error, errObj) {
				}
			});
 			
			isOpenDetail=id;
 		}


		function initDivPage() {
			var data;
			if(currentDisplayPage==0){
				data = firstReturnData;
			}else{
				data=returnData;
			}
			$("#tb_summaryDataDiv").find("div").remove();
			var dataLength = data.data.length;
			countRecord = dataLength;

			for (var i = 0; i < dataLength; i++) {
			    var deviceId = "--";
				if (data.data[i].deviceId) {
					deviceId = data.data[i].deviceId;
				}
				var deviceNo = "--";
				if (data.data[i].deviceNo) {
					deviceNo = data.data[i].deviceNo;
				}
				var deviceName = "--";
				if (data.data[i].deviceName) {
					deviceName = data.data[i].deviceName;
				}
				var level = "1";
				if (data.data[i].level) {
					if(data.data[i].level=="1"){
						level="一级电表"
					}else if(data.data[i].level=="2"){
						level="二级电表"
					}else if(data.data[i].level=="3"){
						level="三级电表"
					}else if(data.data[i].level=="4"){
						level="四级电表"
					}
				}
				var recordFlag="2";
				if (data.data[i].recordFlag) {
					recordFlag = data.data[i].recordFlag;
				}
				var alarmFlag="2";
				if (data.data[i].alarmFlag) {
					alarmFlag = data.data[i].alarmFlag;
				}
				var ua = "--";
				var ub = "--";
				var uc = "--";
				var ia = "--";
				var ib = "--";
				var ic = "--";
				var activeElectricity="--";
				var positiveReactivePower="--";
				var yesterdayElectricityConsumption="--";
				if (data.data[i].yesterdayElectricityConsumption) {
					yesterdayElectricityConsumption = data.data[i].yesterdayElectricityConsumption+"kWh";
				}
				//如果有记录则展示记录值,字段值为null，则用默认
				//电表记录数据
				if(recordFlag=="1"){
					if (data.data[i].ua) {
						ua = data.data[i].ua;
					}
					if (data.data[i].ub) {
						ub = data.data[i].ub;
					}
					if (data.data[i].uc) {
						uc = data.data[i].uc;
					}
					if (data.data[i].ia) {
						ia = data.data[i].ia;
					}
					if (data.data[i].ib) {
						ib = data.data[i].ib;
					}
					if (data.data[i].ic) {
						ic = data.data[i].ic;
					}
					if (data.data[i].activeElectricity) {
						activeElectricity = data.data[i].outActiveElectricity;
					}
					if (data.data[i].positiveReactivePower) {
						positiveReactivePower = data.data[i].positiveReactivePower+"kWh";
					}
				}
				//有告警记录（1告警产生，2告警恢复）
				var alarmStatus;
				var alarmName="--"; 
				if(alarmFlag=="1"){
					alarmStatus=data.data[i].alarmStatus;
					if(alarmStatus==1){
						alarmName=data.data[i].alarmName;
					}
					
				}else{
					alarmStatus="--";
				}
				var cell = "cell" + i;
				var imgurl = "${ctx}/static/images/powerSupply/meter.png";//    onmouseover="this.style.backgroundColor='#F4F9FD'"  onmouseout="this.style.backgroundColor='#FFFFFF'"></div>   
				var summaryDiv;
				//imgurls = "${ctx}/static/img/m2.png";//background: #000;-moz-opacity:0.20; opacity:0.20;filter:alpha(opacity=20);color:#FFF;' + '" onclick="electricityModal(\''+cell+'\')"
		 			//这里分割
				var defaultImg = "${ctx}/static/img/m2.png";
				//'</td><td style="width:70px;height:30px;" id=activeElectricity'+deviceId+' >'
	 	 					//+activeElectricity
	 	 					//+ '</td><td style="width:70px;height:30px;">'
		 			summaryDiv= '<div id ='+deviceId+' style="width:500px;padding-top: 3rem;float:left;">'
						+ '<div class="a" style="position:relative; width:500px;height:200px;cursor: pointer;"' + '" onclick="electricityModal(\''+deviceId+'\')"><div style="position:relative; width:179.8px;height:179.8px;float:left;margin-left: 10px;margin-top: 10px;margin-bottom: 10.2px;"><img style="width:179.8px;height:179.8px;cursor: pointer;" src="'
						+ imgurl
						+ '"/><div  id=activeElectricity'+deviceId+' style="position:absolute; top:35px;text-align: center;width:179.8px;height:20px;color:#000;font-size:22px;">'
	 					+activeElectricity
	 					+ '</div><div style="position:absolute; top:55px;text-align: center;width:179.8px;height:20px;color:#000;font-size:12px;">'
	 					+"kWh"
	 					+ '</div><div id=alarm'+deviceId+' style="position:absolute; top:150px;text-align: center;padding-top: 6px;background: #F37B7B;width:179.8px;height:30px;color:#FFF;font-size:12px;">'
	 					+alarmName
	 					+ '</div></div><div style="position:absolute;float:left;margin-left: 221px;margin-top: 10px;color: #000;width:279px;height:179.8px;"><table style="width:279px;height:179.8px;"><tr><td  colspan="4" style="height:33px;font-size: 24px;">'
	 	 					+deviceName
	 	 					+ '</td></tr><tr><td style="width:70px;height:30px;"><div style="background: #4DA1FF;color:#FFF;text-align:center;">'
	 	 					+level
	 	 					+ '</div></td></tr><tr><td style="width:70px;height:30px;font-size: 14px;">'
	 	 					+"I"
	 	 					+'</td><td id=Ia'+deviceId+' >'
	 	 					+ia
	 	 					+'</td><td id=Ib'+deviceId+' >'
	 	 					+ib
	 	 					+'</td><td id=Ic'+deviceId+' >'
	 	 					+ic
	 	 					+ '</td></tr><tr><td style="width:40px;height:30px;font-size: 14px;">'
	 	 					+"U"
	 	 					+'</td><td id=Ua'+deviceId+' >'
	 	 					+ua
	 	 					+'</td><td id=Ub'+deviceId+' >'
	 	 					+ub
	 	 					+'</td><td id=Uc'+deviceId+' >'
	 	 					+uc
	 	 					+ '</td></tr><tr><td style="width:70px;height:30px;">'
	 	 					+"昨日电量"
	 	 					+ '</td><td style="width:70px;height:30px;" id=yesterdayElectricityConsumption'+deviceId+' >'
	 	 					+yesterdayElectricityConsumption
	 	 					+ '</td><td style="width:70px;height:30px;">'
	 	 					+"无功电量"
	 	 					+ '</td><td id=positiveReactivePower'+deviceId+' >'
	 	 					+positiveReactivePower
	 	 					+ '</td></tr></table></div>' + '<div>';
 					$("#tb_summaryDataDiv").append(summaryDiv);
	 	 			if (typeof (alarmStatus) != "undefined" && alarmStatus=="1"){
	 	 			}else{
	 	 				$("#alarm"+deviceId).hide();
	 	 			}
				}
		}

		function getData(load_index) {
			//第一遍查询不需要再进行查询一次
			if (load_index == 1) {
				initDivPage();
			} else {
				var data = {
						"projectCode" : projectCode
					};
					$(data).attr({
						"level" : elctricityLevel
					});
					$(data).attr({
						"code" : code
					});
					$.ajax({
							type : "post",
							url : "${ctx}/device/manage/getRunningMeterDevices?page="+load_index+"&limit=" + limit
							+ "&sortName=deviceName&sortType=desc",
							async : false,
							dataType : "json",
							async:false,
							data : JSON.stringify(data),
							contentType : "application/json;charset=utf-8",
							success : function(data) {
								deviceData = data.items;
								$("#tb_summaryDataDiv").find("div").remove();
								if(deviceData.length>0){
									initLoadIndexDiv(deviceData);
								}
						},
						error : function(req, error, errObj) {
						}
					});
			}
		}
		
		function  initLoadIndexDiv(deviceData){
			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/pdsElectricityMeterRecord/summaryData",
				data : JSON.stringify(deviceData),
				dataType : "json",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if(data.code==0){
						returnData = data;
						initDivPage();
					}
				},
				error : function(req, error, errObj) {
				}
			});
		}
		
		function toSubscribe(){
			if (isConnectedGateWay) {
				//电表运行数据或告警数据上发
				stompClient.subscribe('/topic/meterRecordOrAlarm/'+ projectCode, function(result) {
					var json = JSON.parse(result.body);
					console.log(json);
					updateDrainPageInfo(json);
				});
			}
		}


		function unloadAndRelease() {
			if(stompClient != null) {
				stompClient.unsubscribe('/topic/meterRecordOrAlarm/'+ projectCode);
			}
		}
		
		function updateDrainPageInfo(json){
			updateDeviceInfo(json);
		}
		
		//更换页面数据
		function updateDeviceInfo(data){
 			var result  = data;
 			var deviceId =result.deviceId;
 			var recordFlag= result.recordFlag;
 			var alarmFlag= result.alarmFlag;
 			if(recordFlag=="1"){
 				//推送的是电表数据，更新电表数据值
 				var ua = "--";
				var ub = "--";
				var uc = "--";
				var ia = "--";
				var ib = "--";
				var ic = "--";
				var uab ="--";
				var ubc ="--";
				var uca ="--";
				var activeElectricity="--";
				var outActiveElectricity="--";
				var positiveReactivePower="--";
				if (result.ua) {
					ua = result.ua;
				}
				if (result.ub) {
					ub = result.ub;
				}
				if (result.uc) {
					uc = result.uc;
				}
				if (result.ia) {
					ia = result.ia;
				}
				if (result.ib) {
					ib = result.ib;
				}
				if (result.ic) {
					ic = result.ic;
				}
				if (result.uab) {
					uab = result.uab;
				}
				if (result.ubc) {
					ubc = result.ubc;
				}
				if (result.uca) {
					uca = result.uca;
				}
				if (result.activeElectricity) {
					activeElectricity = result.activeElectricity;
				}
				if (result.activeElectricity) {
					outActiveElectricity = result.outActiveElectricity;
				}
				if (result.positiveReactivePower) {
					positiveReactivePower = result.positiveReactivePower+"kWh";
				}
 				$("#Ia"+deviceId).html(ia);
 				$("#Ib"+deviceId).html(ib);
 				$("#Ic"+deviceId).html(ic);
 				$("#Ua"+deviceId).html(ua);
 				$("#Ub"+deviceId).html(ub);
 				$("#Uc"+deviceId).html(uc);
 				$("#activeElectricity"+deviceId).html(outActiveElectricity);
 				$("#positiveReactivePower"+deviceId).html(positiveReactivePower);
 	 			//跟新页面电表数据集合
 				if(currentDisplayPage==0){
 					var dataLength = firstReturnData.data.length;
 					for (var i = 0; i < dataLength; i++) {
 						//判断推送到页面的数据的设备当前页面是否存在
 						if(deviceId==firstReturnData.data[i].deviceId){
 							firstReturnData.data[i].ia=ia;
 							firstReturnData.data[i].ib=ib;
 							firstReturnData.data[i].ic=ic;
 							firstReturnData.data[i].ua=ua;
 							firstReturnData.data[i].ub=ub;
 							firstReturnData.data[i].uc=uc;
 							firstReturnData.data[i].uab=uab;
 							firstReturnData.data[i].ubc=ubc;
 							firstReturnData.data[i].uca=uca;
 							if(result.reactivePower){
 								firstReturnData.data[i].reactivePower=result.reactivePower;
 							}
 							if(result.powerFactor){
 								firstReturnData.data[i].powerFactor=result.powerFactor;
 							}
 							if (result.activeElectricity) {
 								firstReturnData.data[i].activeElectricity=result.activeElectricity;
 							}
 							if (result.positiveReactivePower) {
 								firstReturnData.data[i].positiveReactivePower=result.positiveReactivePower;
 							}
	 						//如果相等则表示已经打开详情页面，并且当前电表有数据推送过来
			 	 			if(deviceId==isOpenDetail){
			 	 					electricityDetail=firstReturnData.data[i];
			 	 					initPage();
			 	 			}
 						}
 					}
 				}else{
 					var dataLength = returnData.data.length;
 					for (var i = 0; i < dataLength; i++) {
 						//判断推送到页面的数据的设备当前页面是否存在
 						if(deviceId==returnData.data[i].deviceId){
 							returnData.data[i].ia=ia;
 							returnData.data[i].ib=ib;
 							returnData.data[i].ic=ic;
 							returnData.data[i].ua=ua;
 							returnData.data[i].ub=ub;
 							returnData.data[i].uc=uc;
 							returnData.data[i].uab=uab;
 							returnData.data[i].ubc=ubc;
 							returnData.data[i].uca=uca;
 							if(result.reactivePower){
 								returnData.data[i].reactivePower=result.reactivePower;
 							}
 							if(result.powerFactor){
 								returnData.data[i].powerFactor=result.powerFactor;
 							}
 							if (result.activeElectricity) {
 								returnData.data[i].activeElectricity=result.activeElectricity;
 							}
 							if (result.positiveReactivePower) {
 								returnData.data[i].positiveReactivePower=result.positiveReactivePower;
 							}
	 						//如果相等则表示已经打开详情页面，并且当前电表有数据推送过来
			 	 			if(deviceId==isOpenDetail){
			 	 					electricityDetail=returnData.data[i];
			 	 					initPage();
			 	 			}
 						}
 					}
 				}
 			}
 			if(alarmFlag=="1"){
 				//推送的是电表告警记录，更新电表数据值 
 				if(result.alarmStatus=="1"){
 					$("#alarm"+deviceId).show();
 					$("#alarm"+deviceId).html(result.alarmName);
 				}else{
 					$("#alarm"+deviceId).hide();
 				}
 				//将页面集合数据跟新
 				if(currentDisplayPage==0){
 					var dataLength = firstReturnData.data.length;
 					for (var i = 0; i < dataLength; i++) {
 						//判断推送到页面的数据的设备当前页面是否存在
 						if(deviceId==firstReturnData.data[i].deviceId){
 							if(result.alarmStatus=="1"){
 								firstReturnData.data[i].alarmStatus=result.alarmStatus;
 								firstReturnData.data[i].alarmName=result.alarmName;
 			 				}else{
 			 					firstReturnData.data[i].alarmStatus=result.alarmStatus;
 								firstReturnData.data[i].alarmName="--";
 			 				}
	 						//如果相等则表示已经打开详情页面，并且当前电表有数据推送过来
			 	 			if(deviceId==isOpenDetail){
			 	 					electricityDetail=firstReturnData.data[i];
			 	 					initPage();
			 	 			}
 						}
		 	 				
 					}
 					
 				}else{
 					var dataLength = returnData.data.length;
 					for (var i = 0; i < dataLength; i++) {
 						//判断推送到页面的数据的设备当前页面是否存在
 						if(deviceId==returnData.data[i].deviceId){
 							if(result.alarmStatus=="1"){
 								returnData.data[i].alarmStatus=result.alarmStatus;
 								returnData.data[i].alarmName=result.alarmName;
 			 				}else{
 			 					returnData.data[i].alarmStatus=result.alarmStatus;
 			 					returnData.data[i].alarmName="--";
 			 				}
							//如果相等则表示已经打开详情页面，并且当前电表有数据推送过来
			 	 			if(deviceId==isOpenDetail){
			 	 					electricityDetail=returnData.data[i];
			 	 					initPage();
			 	 			}
 						}
		 	 				
		 	 			}
 					}
 				}
		}
		
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
</body>
</html>