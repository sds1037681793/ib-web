<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${ctx}/static/css/jquery-ui.min.css">
<script type="text/javascript" src="${ctx}/static/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-ui.min.js"></script>

<style>
#div-puv .mmg-head {
	background-color: #fff;
	color: #000;
	border-bottom: 1px solid #ccc;
}

.dragDevice {
	position: absolute;
	cursor: move;
}

.addRelate {
	background: url('${ctx}/static/img/newRelate1.svg');
	width: 140px;
	height: 40px;
	margin-left: 85%;
	margin-top:1%;
	cursor: pointer;
}

#menu{
    position: absolute;
    display: none;
    z-index: 99;
}

</style>
<form id="rule-form">
	<table style="margin-bottom: 15px;">
		<tr height="10px">
			<td><input id="id" name="id" style="display: none;" /></td>
		</tr>
		<tr>
			<div class="addRelate" onclick="addWindow()"></div>
		</tr>
	</table>
	<div id="outBackground" style="position: relative; display: flex; justify-content: center;">
		<div style="position: absolute;"><img id="backgroundImg"></img></div>
		<div id="relateDevices" style="position: relative;">
			<div id="menu" onclick="deleteRelate()">
					<button id="btn-query-resource" type="button"
						class="btn btn-default btn-common btn-common-green btnicons">
						<p class="btniconimgdelete">
							<span>删除</span>
						</p>
					</button>
			</div>
		</div>
	</div>
</form>

<script type="text/javascript">
	var organizeId = $("#login-org").data("orgId");
	var coordinateId;
	var pictureId;
	var ddlItem;
	var deviceName;
	var paramList = new Array();
	var relateDeviceId;
	var relateDeviceName;
	var relatePictureId;
	
	var zoomState = false;
	var checkMap = new HashMap();
	// 声明设备小图标
	var lengji = "${ctx}/static/images/coordinate-device/冷机.svg";
	var lengquebeng = "${ctx}/static/images/coordinate-device/冷却泵.svg";
	var lengqueta = "${ctx}/static/images/coordinate-device/冷却塔.svg";
	var lengdongbeng = "${ctx}/static/images/coordinate-device/冷冻泵.svg";
	var jishuifenshui = "${ctx}/static/images/coordinate-device/集水分水器.svg";
	
	var noPic = "${ctx}/static/images/coordinate-device/问号.svg";

	function eventHandler(e, id, flag){ //鼠标右击事件
        if(e.button == 2){
        	if (flag == 1) {
        		// 第一种删除：已关联的设备删除
				var left=document.getElementById(id).offsetLeft+20;
				var top=document.getElementById(id).offsetTop+20;
	        	$("#menu").css("left",left+'px');
	        	$("#menu").css("top", top+'px');
	        	$("#menu").css("display", "block");
        		$("#menu").removeAttr("newRelate");
	        	$("#menu").attr("related", id);
        	} else {
        		// 第二种删除：新关联的设备删除(此时数据库中还没有关联，直接移除页面上图标即可)
        		var left=document.getElementById("cc"+id).offsetLeft+20;
				var top=document.getElementById("cc"+id).offsetTop+20;
	        	$("#menu").css("left",left+'px');
	        	$("#menu").css("top",top+'px');
	        	$("#menu").css("display", "block");
        		$("#menu").removeAttr("related");
        		$("#menu").attr("newRelate", id);
        	}
        }
    }
	
	$(document).ready(function() {
		// 屏蔽浏览器上图片的右击事件
		$('#outBackground').bind("contextmenu",function(e){  
	          return false;  
	    });
		// 左键取消菜单
		$('body').click(function(){
			$("#menu").css("display", "none");
		});
		   
		if('' != "${param.pictureId}"){
    		relatePictureId = "${param.pictureId}";
    	}
		if ('' != relatePictureId) {
			$.ajax({
				type : "post",
				url : "${ctx}/device/coordinateManage/getPicUrlByPicId?pictureId=" + relatePictureId,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.code == 0 && data.data != null) {
						// 将读取到的图片放置到背景上
						$('#backgroundImg').attr('src', data.data);
						// 创建对象
						var img = new Image();
						// 改变图片的src
						img.src = $('#backgroundImg')[0].src;
						// 加载完成执行
						img.onload = function() {
							var fixHeight = img.height;
							var fixWidth = img.width;
							// 如果图片过大则尺寸缩小一半
							if (img.width >= 1000) {
								zoomState = true;
								$('#backgroundImg').css('width', img.width / 2);
								$('#backgroundImg').css('height', img.height / 2);
								fixHeight = img.height / 2;
								fixWidth = img.width / 2;
							}
							$('#outBackground').css('height', fixHeight);
							$('#relateDevices').css('height', fixHeight);
							$('#relateDevices').css('width', fixWidth);
							loadRelateCoordinate();
						};
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		}
		
	});

	function loadRelateCoordinate() {
		$.ajax({
			type : "post",
			url : "${ctx}/device/coordinateManage/loadRelateCoordinate?pictureId=" + relatePictureId,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.code == 0 && data.data != null) {
					var tempList = data.data;
					for (var i = 0; i < tempList.length; i++) {
						var x = parseInt(tempList[i].xcoordinate);
						var y = parseInt(tempList[i].ycoordinate);
						if (zoomState) {
							x = x / 2;
							y = y / 2;
						}
						var currImg = getImgByDeviceType(tempList[i].deviceTypeId);
						var tempDiv = '<div id="' + tempList[i].id + '" style="position:absolute; left:' + x +
						'px; top:' + y + 'px;" class="dragDevice" title="' + tempList[i].deviceNumber +
						'(' + tempList[i].deviceName + ')"><img onmousedown="eventHandler(event, '+tempList[i].id+', 1)" src="' + currImg + '"></div>';
						$("#relateDevices").append(tempDiv);
						$(".dragDevice").draggable({
							containment : "#relateDevices",
							scroll : false
						});
					}
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}

	function saveRelate() {
		$('.dragDevice').each(function() {
			var newCoordinate;
			var cId = $(this).attr('id');
			if (cId.indexOf('cc') > -1) {// 如果id中包含"cc"则说明是新关联的设备
				var tempDevId = cId.split("cc")[1];
				var tDeviceId = $("#cc" + tempDevId).data("deviceId");
				var tDeviceTypeId = $("#cc" + tempDevId).data("deviceTypeId");
				var tDeviceName = $("#cc" + tempDevId).data("deviceName");
				newCoordinate = {
					id : null,
					xCoordinate : $(this).css('left'),
					yCoordinate : $(this).css('top'),
					deviceId : tDeviceId,
					deviceTypeId : tDeviceTypeId,
					deviceName : tDeviceName
				}
			} else {// 没有"cc"说明是原有设备，则id即为坐标的id(表主键id)
				newCoordinate = {
					id : cId,
					xCoordinate : $(this).css('left'),
					yCoordinate : $(this).css('top'),
					deviceId : "",
					deviceTypeId : "",
					deviceName : ""
				}
			}
			paramList[paramList.length] = newCoordinate;
		})
		var datas = {
			pictureId : relatePictureId,
			projectId : organizeId,
			zoomState : zoomState,
			coordinates : paramList
		};
		$.ajax({
			type : "post",
			url : "${ctx}/device/coordinateManage/create",
			dataType : "json",
			data : JSON.stringify(datas),
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.code == 0 && data.data) {
					$("#rest-config-relate-modal").modal("hide");
					showDialogModal("error-div", "操作成功", "操作成功");
					// 清空页面的map，不然已关联设备会永远留在map中
					checkMap.clear();
					return true;
				} else {
					showDialogModal("error-div", "操作错误", data.msg);
					return;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}

	function newCoordinate(deviceId, deviceTypeId, deviceNumber, deviceName) {
		var currImg = getImgByDeviceType(deviceTypeId);
		var tempDiv = '<div id="cc' + deviceId + '" class="dragDevice" title="' + deviceNumber + '(' + deviceName +
				')"><img onmousedown="eventHandler(event, '+deviceId+', 2)" src="' + currImg + '"></div>';
		$("#relateDevices").append(tempDiv);
		// 将设备id丢入map中来标记该设备以免重复关联
		checkMap.put(deviceId, deviceId);
		$("#cc" + deviceId).data("deviceId", deviceId);
		$("#cc" + deviceId).data("deviceTypeId", deviceTypeId);
		$("#cc" + deviceId).data("deviceName", deviceName);
		$(".dragDevice").draggable({
			containment : "#relateDevices",
			scroll : false
		});
	}
	
	function addWindow() {
		createModalWithLoad("relate-device", 1300, "", "选择关联设备", "picture/chooseRelateDevice", "", "", "", 130);
		openModal("#relate-device-modal", true, true);
	}
	
	function hideDiv(id) {
		$("#cc" + id).remove();
		checkMap.remove(id);
	}
	
	function deleteRelate() {
		var currRelateId = $("#menu").attr("related");
		var newRelateId = $("#menu").attr("newRelate");
		if (currRelateId != null && currRelateId != undefined) {
			showDialogModal("error-div", "操作提示", "确定删除该设备？", 2, "deleteCoordinate(" + currRelateId + ");");
		}
		if (newRelateId != null && newRelateId != undefined) {
			showDialogModal("error-div", "操作提示", "确定删除该设备？", 2, "hideDiv('" + newRelateId + "');");
		}
	}
	
	function deleteCoordinate(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/device/coordinateManage/deleteCoordinate/" + id,
			success : function(data) {
				if (data && data.code == 0 && data.data) {
					$('#'+id).remove();
					$(".dragDevice").css("cursor","move");
					showDialogModal("error-div", "操作成功", "删除成功！");
					return;
				}else {
					showDialogModal("error-div", "操作错误", data.msg);
					return;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}

	function getImgByDeviceType(deviceTypeId) {
		if (deviceTypeId == 6) {
			return lengji;
		} else if (deviceTypeId == 7) {
			return lengquebeng;
		} else if (deviceTypeId == 8) {
			return lengdongbeng;
		} else if (deviceTypeId == 9) {
			return lengqueta;
		} else if (deviceTypeId == 10 || deviceTypeId == 11) {
			return jishuifenshui;
		} else {
			return noPic;
		}
	}
</script>