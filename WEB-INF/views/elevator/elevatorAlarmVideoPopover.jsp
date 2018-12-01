<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.elevator-video {
	font-family: PingFangSC-Regular;
	font-size: 12px;
	color: #4A4A4A;
	letter-spacing: 0;
}
</style>
</head>
<body class="elevator-video">
	<div style="padding-left: 12px;">
		<form id="elevator-alarm-video-form">
			<div style="position: relative; z-index: 9999; padding-left: 10px;">
				<table style="margin-bottom: 15px;">
					<tr style="height: 40px">
						<td align="left" style="height: 17px;">电梯名称：</td>
						<td>
							<div id="elevatorDeviceName"></div>
						</td>
						<td>
						<div id="alarmHint"  align="right" style="height: 17px;width: 57px;display: none;">
						<img alt="告警提示" src="${ctx}/static/img/alarm/alarmHint.svg">
						</div>
						</td>
						<td align="right" style="width: 110px; height: 17px;">电梯层显：</td>
						<td><span id="floorDisplaying"
							style="width: 100px; margin-left: 12px;"></span></td>
						<td align="right" style="width: 90px; height: 17px;">运行状态：</td>
						<td><span id="runningState"
							style="width: 100px; margin-left: 12px;"></span></td>
					</tr>
					<tr style="height: 60px">
						<td colspan="10" id="alarm">
							<div
								style="display: inline-block; display: inline; zoom: 1; float: left;">报警信号：</div>
							<div id="alarmName"
								style="padding-left: 19px; width: 450px; float: left; word-break: break-all;"></div>
						</td>
					</tr>
				</table>
			</div>
			<div id="show_video"  class="right_box" style="width: 790px; height: 454px;display: none;">
				<iframe src="${ctx}/videomonitoring/showVideo?height=443&width=798"
					id="elevator-video-iframe" name="video-iframe" frameborder="0"
					style="width: 798px; height: 443px;"></iframe>
			</div>
			<div  id="videoOffLine" class="right_image" style="width: 790px; height: 454px;display: none;"><img alt="视频离线" src="${ctx}/static/img/alarm/videoOffLine.png">  </div>
		</form>
	</div>
	<script>
		var elevatorList = new Array();
		var alarmElevatorNameList = "";
		var cameraDeviceId = null;
		var elevator = null;
		var elevatorName = null;
		var elevatorAlarmName = null;
		var elevatorFloorDisplaying = null;
		var elevatorRunningState = null;
		var cameraStatus = null;
		$(".modal-dialog").css("transform","none");

		function callbackLoadVideo() {
			if("${param.videoType}"=="elevator"){
				init();
			}
			
		}
		
		function showElecatorVideoMonitor(cameraDeviceId) {
			$("#elevator-video-iframe")[0].contentWindow.closeVideo();
			$("#elevator-video-iframe")[0].contentWindow.startPlay(cameraDeviceId);
		}

		function init(){ 
			isNewAlarm = 0;
			if (elevatorDevice != null && elevatorDevice.length > 0) {
				if (elevatorDevice.length > 10) {
					for (var i = 0; i < 10; i++) {
						elevatorList[i] = {
							itemText : elevatorDevice[i].deviceName,
							itemData : elevatorDevice[i].deviceId
						};
					}
				} else {
					for (var i = 0; i < elevatorDevice.length; i++) {
						elevatorList[i] = {
							itemText : elevatorDevice[i].deviceName,
							itemData : elevatorDevice[i].deviceId
						};
					}
				}
				// 设置用户类型下拉列表
				alarmElevatorNameList = $("#elevatorDeviceName").dropDownList({
					inputName : "alarmElevatorName",
					inputValName : "alarmElevatorId",
					buttonText : "",
					width : "117px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						elevator = data;
						if (elevator == undefined) {
							return;
						} else {
							//更改选项 更改页面对应数据信息
							for (var i = 0; i < elevatorDevice.length; i++) {
								if (elevatorDevice[i].deviceId == elevator) {
									$("#alarmElevatorId").html(elevatorDevice[i].deviceId);
									$("#alarmElevatorName").html(elevatorDevice[i].deviceName);
									$("#alarmName").html(elevatorDevice[i].alarmName);
									$("#floorDisplaying").text(elevatorDevice[i].floorDisplaying + "层");
									if (elevatorDevice[i].runningState == 1) {
										$("#runningState").text("上行");
									} else if (elevatorDevice[i].runningState == 3) {
										$("#runningState").text("停止");
									} else if (elevatorDevice[i].runningState == 2) {
										$("#runningState").text("下行");
									}
									cameraStatus = elevatorDevice[i].cameraStatus;
									cameraDeviceId = elevatorDevice[i].cameraDeviceId;
									changeVideo();
								}
							}
						}
					},
					items : elevatorList
				});
				if (elevatorDevice.length > 0) {
					alarmElevatorNameList.setData(elevatorDevice[0].deviceName, elevatorDevice[0].deviceId, '');
					$("#alarmName").html(elevatorDevice[0].alarmName);
					elevator = elevatorDevice[0].deviceId;
					$("#floorDisplaying").text(elevatorDevice[0].floorDisplaying + "层");
					if (elevatorDevice[0].runningState == 1) {
						$("#runningState").text("上行");
					} else if (elevatorDevice[0].runningState == 3) {
						$("#runningState").text("停止");
					} else if (elevatorDevice[0].runningState == 2) {
						$("#runningState").text("下行");
					}
					cameraStatus = elevatorDevice[0].cameraStatus;
					cameraDeviceId = elevatorDevice[0].cameraDeviceId;
					changeVideo();
				}
			}
		}

		function deleteElevatorData(deleteDeviceId, deleteDeviceName, deleteAlarmName, num, floorDisplay, runState) {
			if (elevatorIsOpen == 1 && deleteDeviceId == elevator) {
				$("#elevatorDeviceName").empty();
				//删除此设备id
				elevatorDevice.splice(num, 1);

				//当最后一条困人告警恢复后，不关弹窗，然后发生新的困人告警，此时页面电梯名称会出错
				elevatorName = deleteDeviceName;
				elevator = deleteDeviceId;
				elevatorAlarmName = deleteAlarmName;
				elevatorFloorDisplaying = floorDisplay;
				elevatorRunningState = runState;
				
				for (var i = 0; i < elevatorList.length; i++) {
					if (elevatorList[i].itemData == deleteDeviceId) {
						elevatorList.splice(i, 1);
					}
				}
				if (elevatorDevice.length > 10) {
					for (var i = 0; i < 10; i++) {
						elevatorList[i] = {
							itemText : elevatorDevice[i].deviceName,
							itemData : elevatorDevice[i].deviceId
						};
					}
				} else {
					for (var i = 0; i < elevatorDevice.length; i++) {
						elevatorList[i] = {
							itemText : elevatorDevice[i].deviceName,
							itemData : elevatorDevice[i].deviceId
						};
					}
				}
				// 设置用户类型下拉列表
				// 设置用户类型下拉列表
				alarmElevatorNameList = $("#elevatorDeviceName").dropDownList({
					inputName : "alarmElevatorName",
					inputValName : "alarmElevatorId",
					buttonText : "",
					width : "117px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					async : false,
					onSelect : function(i, data, icon) {
						if(data != undefined){							
						elevator = data;
						}
						if (elevator == undefined) {
							return;
						} else {
							//更改选项 更改页面对应数据信息
							for (var i = 0; i < elevatorDevice.length; i++) {
								if (elevatorDevice[i].deviceId == elevator) {
									$("#alarmElevatorId").html(elevatorDevice[i].deviceId);
									$("#alarmElevatorName").html(elevatorDevice[i].deviceName);
									$("#alarmName").html(elevatorDevice[i].alarmName);
									$("#floorDisplaying").text(elevatorDevice[i].floorDisplaying + "层");
									if (elevatorDevice[i].runningState == 1) {
										$("#runningState").text("上行");
									} else if (elevatorDevice[i].runningState == 3) {
										$("#runningState").text("停止");
									} else if (elevatorDevice[i].runningState == 2) {
										$("#runningState").text("下行");
									}
									if(data != undefined){	
									cameraStatus = elevatorDevice[i].cameraStatus;
									cameraDeviceId = elevatorDevice[i].cameraDeviceId;
									changeVideo();
									}
								}
							}
						}
					},
					items : elevatorList
				});
				alarmElevatorNameList.setData(deleteDeviceName, deleteDeviceId);
				$("#alarmName").html(deleteAlarmName);
				$("#floorDisplaying").text(floorDisplay + "层");
				if (runState == 1) {
					$("#runningState").text("上行");
				} else if (runState == 3) {
					$("#runningState").text("停止");
				} else if (runState == 2) {
					$("#runningState").text("下行");
				}
			} else {
				//删除此设备id
				elevatorDevice.splice(num, 1);
				updateElevatorData();
			}
		}
		function updateElevatorData() {
			if(isNewAlarm == 1){
				document.getElementById("alarmHint").style.display = "block"; 
			}
			$("#elevatorDeviceName").empty();
			elevatorList.splice(0, elevatorList.length);
			if (elevatorDevice.length > 10) {
				for (var i = 0; i < 10; i++) {
					elevatorList[i] = {
						itemText : elevatorDevice[i].deviceName,
						itemData : elevatorDevice[i].deviceId
					};
					if (elevatorDevice[i].deviceId == elevator) {
						elevatorName = elevatorDevice[i].deviceName;
						elevatorAlarmName = elevatorDevice[i].alarmName;
						elevatorFloorDisplaying = elevatorDevice[i].floorDisplaying;
						elevatorRunningState = elevatorDevice[i].runningState;
					}
				}
			} else {
				for (var i = 0; i < elevatorDevice.length; i++) {
					elevatorList[i] = {
						itemText : elevatorDevice[i].deviceName,
						itemData : elevatorDevice[i].deviceId
					};
					if (elevatorDevice[i].deviceId == elevator) {
						elevatorName = elevatorDevice[i].deviceName;
						elevatorAlarmName = elevatorDevice[i].alarmName;
						elevatorFloorDisplaying = elevatorDevice[i].floorDisplaying;
						elevatorRunningState = elevatorDevice[i].runningState;
					}
				}
			}

			// 设置用户类型下拉列表
			alarmElevatorNameList = $("#elevatorDeviceName").dropDownList({
				inputName : "alarmElevatorName",
				inputValName : "alarmElevatorId",
				buttonText : "",
				width : "117px",
				readOnly : false,
				required : true,
				maxHeight : 200,
				onSelect : function(i, data, icon) {

					if(data != undefined){							
						elevator = data;
					}
					if (elevator == undefined) {
						return;
					} else {
						//更改选项 更改页面对应数据信息
						for (var i = 0; i < elevatorDevice.length; i++) {
							if (elevatorDevice[i].deviceId == elevator) {
								$("#alarmElevatorId").html(elevatorDevice[i].deviceId);
								$("#alarmElevatorName").html(elevatorDevice[i].deviceName);
								$("#alarmName").html(elevatorDevice[i].alarmName);
								$("#floorDisplaying").text(elevatorDevice[i].floorDisplaying + "层");
								if (elevatorDevice[i].runningState == 1) {
									$("#runningState").text("上行");
								} else if (elevatorDevice[i].runningState == 3) {
									$("#runningState").text("停止");
								} else if (elevatorDevice[i].runningState == 2) {
									$("#runningState").text("下行");
								}
								if(data != undefined){
								cameraStatus = elevatorDevice[i].cameraStatus;
								cameraDeviceId = elevatorDevice[i].cameraDeviceId;
								changeVideo();
								}
							}
						}
					}
				},
				items : elevatorList
			});
			alarmElevatorNameList.setData(elevatorName, elevator);
			$("#alarmElevatorId").html(elevator);
			$("#alarmElevatorName").html(elevatorName);
			$("#alarmName").html(elevatorAlarmName);
			$("#floorDisplaying").text(elevatorFloorDisplaying + "层");
			if (elevatorRunningState == 1) {
				$("#runningState").text("上行");
			} else if (elevatorRunningState == 3) {
				$("#runningState").text("停止");
			} else if (elevatorRunningState == 2) {
				$("#runningState").text("下行");
			}
		}
		$(".close").click(function() {
			elevatorIsOpen = 0;
			elevator = null;
			elevatorName = null;
			elevatorAlarmName = null;
			elevatorFloorDisplaying = null;
			elevatorRunningState = null;
		});
		//隐藏  告警提示
		$("#elevatorDeviceName").click(function() {
			isNewAlarm = 0;
			document.getElementById("alarmHint").style.display = "none";  
		});
		function changeVideo() {
			if(typeof(cameraDeviceId) != "undefined"&& cameraDeviceId!=null && cameraStatus == 1){
				document.getElementById("videoOffLine").style.display = "none";  
			    document.getElementById("show_video").style.display ='block';  
				showElecatorVideoMonitor(cameraDeviceId);
			}else{
				$("#elevator-video-iframe")[0].contentWindow.closeVideo();
				document.getElementById("show_video").style.display ='none';  
				document.getElementById("videoOffLine").style.display = "block";  
			}
		}
	</script>
</body>
</html>