<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!-- 加载js -->
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/iconic.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-datetimepicker/2.1.9/css/jquery.datetimepicker.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap-switch/3.3.2/css/bootstrap3/bootstrap-switch.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-icheck/1.0.2/css/all.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/dropdownlistStyleForCloud.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/elevatorVideoForCloud.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/HashMap.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/commons.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/wadda.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-dropdownlist/jquery.dropdownlist.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-datetimepicker/2.1.9/js/jquery.datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/static/js/dropdownlistBule.js" type="text/javascript"></script>

<style type="text/css">
</style>
</head>
<body class="elevator-video">

	<label class="elevator-title">电梯困人报警视频</label>

	<div class="elevator-form">
		<form id="elevator-alarm-video-form">
			<div class="alarm-data">
				<table class="elevator-table">
					<tr style="height: 40px; margin-top: 60px">
						<td class="elevator-describe" style="padding-right: 4px;">报警点</td>
						<td>
							<img src="${ctx}/static/images/elevator/elevatorTiring.svg" id="firesAlarmTip" style="display: block; padding-right: 2px;">
						</td>
						<td>
							<div id="elevator-num" class="elevator-num"></div>
						</td>
						<td>
							<div id="elevatorDeviceName"></div>
						</td>
						<input type="text" hidden="true" value="" id="cameraListName">
						<td>
							<%--						<div id="alarm_Hint"  align="right" style="height: 17px;width: 57px;display: none;">
						<img alt="告警提示" src="${ctx}/static/img/alarm/alarmHint.svg">
						</div>--%>
						</td>
						<td align="right" style="width: 110px; height: 17px;">电梯层显：</td>
						<td>
							<span id="floorDisplaying" style="width: 100px; margin-left: 12px;"></span>
						</td>
						<td align="right" style="width: 90px; height: 17px;">运行状态：</td>
						<td>
							<span id="runningState" style="width: 100px; margin-left: 12px;"></span>
						</td>
					</tr>
					<tr style="height: 40px">
						<td colspan="10" id="alarm">
							<div style="display: inline-block; display: inline; zoom: 1; float: left;">报警信号：</div>
							<div id="alarmName" style="padding-left: 19px; width: 450px; float: left; word-break: break-all;"></div>
						</td>
					</tr>
				</table>
			</div>
			<div id="show_video" class="right_box" style="height: 340px; width: 600px; display: none;">
				<iframe src="${ctx}/videomonitoring/showVideo?height=340&width=600" id="elevator-video-iframe" name="video-iframe" frameborder="0" scrolling="no"></iframe>
			</div>
			<div id="videoOffLine" class="right_image">
				<img alt="视频离线" src="${ctx}/static/img/alarm/videoOffLine.png">
			</div>
		</form>
	</div>
	<script>
		var alarmElevatorNameList = "";

		$(".modal-dialog").css("transform", "none");

		function callbackLoadVideo() {
			if ("${param.videoType}" == "elevator") {
				init();
			}

		}

		function showElecatorVideoMonitor(cameraDeviceId) {
			$("#elevator-video-iframe")[0].contentWindow.closeVideo();
			$("#elevator-video-iframe")[0].contentWindow.startPlay(cameraDeviceId);
		}

		function init() {
			parent.isNewAlarm = 0;
			if (parent.elevatorDevice != null && parent.elevatorDevice.length > 0) {
				if (parent.elevatorDevice.length > 10) {
					for (var i = 0; i < 10; i++) {
						parent.elevatorList[i] = {
							itemText : parent.elevatorDevice[i].deviceName,
							itemData : parent.elevatorDevice[i].deviceId
						};
					}
				} else {
					for (var i = 0; i < parent.elevatorDevice.length; i++) {
						parent.elevatorList[i] = {
							itemText : parent.elevatorDevice[i].deviceName,
							itemData : parent.elevatorDevice[i].deviceId
						};
					}
				}
				// 设置用户类型下拉列表
				alarmElevatorNameList = $("#elevatorDeviceName").dropDownListBule({
					inputName : "alarmElevatorName",
					inputValName : "alarmElevatorId",
					buttonText : "",
					width : "117px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						parent.elevator = data;
						if (parent.elevator == undefined) {
							return;
						} else {
							//更改选项 更改页面对应数据信息
							for (var i = 0; i < parent.elevatorDevice.length; i++) {
								if (parent.elevatorDevice[i].deviceId == elevator) {
									$("#alarmElevatorId").html(parent.elevatorDevice[i].deviceId);
									$("#alarmElevatorName").html(parent.elevatorDevice[i].deviceName);
									$("#alarmName").html(parent.elevatorDevice[i].alarmName);
									$("#floorDisplaying").text(parent.elevatorDevice[i].floorDisplaying + "层");
									if (parent.elevatorDevice[i].runningState == 1) {
										$("#runningState").text("上行");
									} else if (parent.elevatorDevice[i].runningState == 3) {
										$("#runningState").text("停止");
									} else if (parent.elevatorDevice[i].runningState == 2) {
										$("#runningState").text("下行");
									}
									parent.cameraStatus = parent.elevatorDevice[i].cameraStatus;
									parent.cameraDeviceId = parent.elevatorDevice[i].cameraDeviceId;
									changeVideo();
								}
							}
						}
					},
					items : parent.elevatorList
				});
				$("#elevator-num").html(parent.elevatorList.length);
				if (parent.elevatorDevice.length > 0) {
					alarmElevatorNameList.setData(parent.elevatorDevice[0].deviceName, parent.elevatorDevice[0].deviceId, '');
					$("#alarmName").html(parent.elevatorDevice[0].alarmName);
					parent.elevator = parent.elevatorDevice[0].deviceId;
					$("#floorDisplaying").text(parent.elevatorDevice[0].floorDisplaying + "层");
					if (parent.elevatorDevice[0].runningState == 1) {
						$("#runningState").text("上行");
					} else if (parent.elevatorDevice[0].runningState == 3) {
						$("#runningState").text("停止");
					} else if (parent.elevatorDevice[0].runningState == 2) {
						$("#runningState").text("下行");
					}
					parent.cameraStatus = parent.elevatorDevice[0].cameraStatus;
					parent.cameraDeviceId = parent.elevatorDevice[0].cameraDeviceId;
					changeVideo();
				}
			}
		}

		function deleteElevatorData(deleteDeviceId, deleteDeviceName, deleteAlarmName, num, floorDisplay, runState) {
			if (parent.elevatorIsOpen == 1 && deleteDeviceId == parent.elevator) {
				$("#elevatorDeviceName").empty();
				//删除此设备id
				parent.elevatorDevice.splice(num, 1);

				//当最后一条困人告警恢复后，不关弹窗，然后发生新的困人告警，此时页面电梯名称会出错
				parent.elevatorName = deleteDeviceName;
				parent.elevator = deleteDeviceId;
				parent.elevatorAlarmName = deleteAlarmName;
				parent.elevatorFloorDisplaying = floorDisplay;
				parent.elevatorRunningState = runState;

				for (var i = 0; i < parent.elevatorList.length; i++) {
					if (parent.elevatorList[i].itemData == deleteDeviceId) {
						parent.elevatorList.splice(i, 1);
					}
				}
				if (parent.elevatorDevice.length > 10) {
					for (var i = 0; i < 10; i++) {
						parent.elevatorList[i] = {
							itemText : parent.elevatorDevice[i].deviceName,
							itemData : parent.elevatorDevice[i].deviceId
						};
					}
				} else {
					for (var i = 0; i < parent.elevatorDevice.length; i++) {
						parent.elevatorList[i] = {
							itemText : parent.elevatorDevice[i].deviceName,
							itemData : parent.elevatorDevice[i].deviceId
						};
					}
				}
				// 设置用户类型下拉列表
				//	alarmElevatorNameList = $("#elevatorDeviceName").dropDownList({
				alarmElevatorNameList = $("#elevatorDeviceName").dropDownListBule({
					inputName : "alarmElevatorName",
					inputValName : "alarmElevatorId",
					buttonText : "",
					width : "120px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					async : false,
					onSelect : function(i, data, icon) {
						if (data != undefined) {
							parent.elevator = data;
						}
						if (parent.elevator == undefined) {
							return;
						} else {
							//更改选项 更改页面对应数据信息
							for (var i = 0; i < parent.elevatorDevice.length; i++) {
								if (parent.elevatorDevice[i].deviceId == parent.elevator) {
									$("#alarmElevatorId").html(parent.elevatorDevice[i].deviceId);
									$("#alarmElevatorName").html(parent.elevatorDevice[i].deviceName);
									$("#alarmName").html(parent.elevatorDevice[i].alarmName);
									$("#floorDisplaying").text(parent.elevatorDevice[i].floorDisplaying + "层");
									if (parent.elevatorDevice[i].runningState == 1) {
										$("#runningState").text("上行");
									} else if (parent.elevatorDevice[i].runningState == 3) {
										$("#runningState").text("停止");
									} else if (parent.elevatorDevice[i].runningState == 2) {
										$("#runningState").text("下行");
									}
									if (data != undefined) {
										parent.cameraStatus = parent.elevatorDevice[i].cameraStatus;
										parent.cameraDeviceId = parent.elevatorDevice[i].cameraDeviceId;
										changeVideo();
									}
								}
							}
						}
					},
					items : parent.elevatorList
				});
				$("#elevator-num").html(parent.elevatorList.length);
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
				parent.elevatorDevice.splice(num, 1);
				updateElevatorData();
			}
		}
		function updateElevatorData() {

			$("#elevatorDeviceName").empty();
			parent.elevatorList.splice(0, parent.elevatorList.length);
			if (parent.elevatorDevice.length > 10) {
				for (var i = 0; i < 10; i++) {
					parent.elevatorList[i] = {
						itemText : parent.elevatorDevice[i].deviceName,
						itemData : parent.elevatorDevice[i].deviceId
					};
					if (parent.elevatorDevice[i].deviceId == parent.elevator) {
						parent.elevatorName = parent.elevatorDevice[i].deviceName;
						parent.elevatorAlarmName = parent.elevatorDevice[i].alarmName;
						parent.elevatorFloorDisplaying = parent.elevatorDevice[i].floorDisplaying;
						parent.elevatorRunningState = parent.elevatorDevice[i].runningState;
					}
				}
			} else {
				for (var i = 0; i < parent.elevatorDevice.length; i++) {
					parent.elevatorList[i] = {
						itemText : parent.elevatorDevice[i].deviceName,
						itemData : parent.elevatorDevice[i].deviceId
					};
					if (parent.elevatorDevice[i].deviceId == parent.elevator) {
						parent.elevatorName = parent.elevatorDevice[i].deviceName;
						parent.elevatorAlarmName = parent.elevatorDevice[i].alarmName;
						parent.elevatorFloorDisplaying = parent.elevatorDevice[i].floorDisplaying;
						parent.elevatorRunningState = parent.elevatorDevice[i].runningState;
					}
				}
			}

			// 设置用户类型下拉列表
			//		alarmElevatorNameList = $("#elevatorDeviceName").dropDownList({
			alarmElevatorNameList = $("#elevatorDeviceName").dropDownListBule({
				inputName : "alarmElevatorName",
				inputValName : "alarmElevatorId",
				buttonText : "",
				width : "120px",
				readOnly : false,
				required : true,
				maxHeight : 200,
				onSelect : function(i, data, icon) {

					if (data != undefined) {
						parent.elevator = data;
					}
					if (parent.elevator == undefined) {
						return;
					} else {
						//更改选项 更改页面对应数据信息
						for (var i = 0; i < parent.elevatorDevice.length; i++) {
							if (parent.elevatorDevice[i].deviceId == parent.elevator) {
								$("#alarmElevatorId").html(parent.elevatorDevice[i].deviceId);
								$("#alarmElevatorName").html(parent.elevatorDevice[i].deviceName);
								$("#alarmName").html(parent.elevatorDevice[i].alarmName);
								$("#floorDisplaying").text(parent.elevatorDevice[i].floorDisplaying + "层");
								if (parent.elevatorDevice[i].runningState == 1) {
									$("#runningState").text("上行");
								} else if (parent.elevatorDevice[i].runningState == 3) {
									$("#runningState").text("停止");
								} else if (parent.elevatorDevice[i].runningState == 2) {
									$("#runningState").text("下行");
								}
								if (data != undefined) {
									parent.cameraStatus = parent.elevatorDevice[i].cameraStatus;
									parent.cameraDeviceId = parent.elevatorDevice[i].cameraDeviceId;
									changeVideo();
								}
							}
						}
					}
				},
				items : parent.elevatorList
			});
			$("#elevator-num").html(parent.elevatorList.length);
			alarmElevatorNameList.setData(parent.elevatorName, parent.elevator);
			$("#alarmElevatorId").html(parent.elevator);
			$("#alarmElevatorName").html(parent.elevatorName);
			$("#alarmName").html(parent.elevatorAlarmName);
			$("#floorDisplaying").text(parent.elevatorFloorDisplaying + "层");
			if (parent.elevatorRunningState == 1) {
				$("#runningState").text("上行");
			} else if (parent.elevatorRunningState == 3) {
				$("#runningState").text("停止");
			} else if (parent.elevatorRunningState == 2) {
				$("#runningState").text("下行");
			}
		}

		//隐藏  告警提示
		$("#elevatorDeviceName").click(function() {
			parent.isNewAlarm = 0;

		});
		function changeVideo() {
			if (typeof (parent.cameraDeviceId) != "undefined" && parent.cameraDeviceId != null && parent.cameraStatus == 1) {
				document.getElementById("videoOffLine").style.display = "none";
				document.getElementById("show_video").style.display = 'block';
				showElecatorVideoMonitor(parent.cameraDeviceId);
			} else {
				$("#elevator-video-iframe")[0].contentWindow.closeVideo();
				document.getElementById("show_video").style.display = 'none';
				document.getElementById("videoOffLine").style.display = "block";
			}
		}
	</script>
</body>
</html>