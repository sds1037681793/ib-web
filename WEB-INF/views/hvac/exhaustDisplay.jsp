<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>排风界面实时展示</title>
 <link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
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
<script type="text/javascript" src="${ctx}/static/js/push.js"></script>
<style type="text/css">
</style>
</head>
<style>
* {
	padding: 0;
	margin: 0;
}

ul li {
	list-style: none;
}

.item {
	color: #4a4a4a;
	width: 500px;
	height: 200px;
	overflow: hidden;
	border: 1px solid #ccc;
}

.item-img {
	width: 179.8px;
	margin: 10px;
	/*border:1px solid #ccc;*/
}

.item-equip {
	color: #4a4a4a;
	font-size: 24px;
}

.item-name {
	color: #666;
	font-size: 14px;
}

.item-baseinfo {
	margin: 20px 0 0 11.2px;
}
.position-device{
	width:170px;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}
.float-lf {
	float: left;
}

.float-rt {
	float: right;
}

.equip-status {
	margin-top: 20px;
	font-size: 14px;
}

 .status-color {
	  color: #00BFA5;  
	 /* color:#B4B4B4; */
} 
.statuss-color {
	  color: #FF0000;  
	 /* color:#B4B4B4; */
} 


.equip-place {
	font-size: 14px;
	margin-top: 10px;
}

.clearfix {
	overflow: hidden;
}

.adj-position {
	margin-left: 65px;
}

.item-list li {
	display: inline-block;
	margin: 15px 13px 15px 24px;
}

#btn-query-parkingSpaceArea {
	color: #00BFA5;
	border-color: #00BFA5
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
	color: #00BFA5;
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
	color:  #00BFA5;
}

.content-default {
	background-color: #fff;
	border: 1px solid #e1e1e1;
	padding: 10px;
	margin-bottom: 10px;
}
</style>
<body>
	<div class="content-default">
		<form id="select-form">
			<table>
				<tr>
					<td align="right" width="80">选择楼栋：</td>
					<td>
						<div id="all-buildingslist"></div>
					</td>
					<td align="right" width="140">选择楼层：</td>
					<td>
						<div id="floorlist"></div>
					</td>
					<td align="right" width="140">设备编号：</td>
					<td><input id="deviceNumber" name="deviceNumber"
						placeholder="设备编号" class="form-control" type="text"
						style="width: 150px" /></td>

					<td align="right" width="170px">
						<button id="btn-query-parkingSpaceArea" type="button"
							class="btn btn-default btnicons" onclick="onclickInput(this)"  style="margin-left: 3rem;">
						<p class="btniconimg"><span>查询</span></p>
                 	</button>				
                     </td> 
				</tr>
			</table>
		</form>
	</div>
	<div id="tb_exhaustDataDiv" class="content-default" style="min-height: 100px; width: 1700px;">
		<ul id="item-lists" class="item-list">
		</ul>
	</div>
	<div class="pagination" style="position: relative; float: right;"></div>
</body>
<script type="text/javascript">
	//判断是新风还是排风推送
	var judge = 2;
	var g_gatewayAddr;
	var ctx = '${ctx}';
	var code = "EXHAUST_FAN";
	var locationType = 5;
	var oneCount = 30;
	var returnData;
	var firstReturnData;
	var currentDisplayPage=0;
	var margin = 10;//这里设置间距
	var li_W = 476;//图片宽
	var elctricityLevel = "-1";
	var electricityDetail;
	var scrollTimer = null;
	var sentIt = true;
	var ddlItems;
	var ddlItemc;
	var dropdownlist;
	var banlist;
	var floorlist;
	var levelTypes;
	var levelTypeList = new Array();
	var organizeId = $("#login-org").data("orgId");
	$(document).ready(function() {
		levelTypes = $("#floorlist").dropDownList({
			inputName : 'levelType',
			inputValName : 'levelTypeValue',
			buttonText : "",
			width : "115px",
			readOnly : true,
			required : true,
			maxHeight : 100,
			onSelect : function(i, data, icon) {
				var ddl = $("#ddl-btn-levelType").val();
			},
			items : levelTypeList
		});
		levelTypes.setData("所有楼层", "", "");
		ban();
		deviceInit();
		
		toSubscribe();

	});

	function onclickInput(obj){
		deviceInit();
	}
	
 function getAirData(load_index) {
		//第一遍查询不需要再进行查询一次
		if (load_index == 1) {
			firstPageInit();
		} else {
			var limit = oneCount;
			var data = {};
			var deviceNumber = $("#deviceNumber").val();
			var selectForm = getFormData("select-form");
			var buildingId = selectForm.banNameId;
			var floorId = selectForm.floorNameId;
			var locationId;
			if (buildingId != "") {
				$(data).attr({
					"buildingId" : buildingId
				});
			}
			if (floorId != "") {
				$(data).attr({
					"floorId" : floorId
				});
			}
			if (deviceNumber != "") {
				$(data).attr({
					"deviceNumber" : deviceNumber
				});
			}
			$(data).attr({
				"projectCode" : projectCode
			});
			$(data).attr({
				"code" : code
			});
			$.ajax({
				type : "post",
				url : "${ctx}/device/manage/newBuildInfo?page="+load_index+"&limit=" + limit
				+ "&sortName=deviceName&sortType=desc",
				async : false,
				dataType : "json",
				data : JSON.stringify(data),
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					deviceData = data.items;
					if(deviceData.length>0){
						againPage(deviceData);
					}
			},
			error : function(req, error, errObj) {
			}
		});

		}
		
	}
 
 function againPage(deviceData) {//再次请求页面
		$.ajax({
			type : "post",
			url : "${ctx}/hvac/freshAirDisplay/newBuilding",
			data : JSON.stringify(deviceData),
			dataType : "json",
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				returnData = data;
				firstPageInit();
			},
			error : function(req, error, errObj) {
				$("#item-lists").find("li").remove();
			}
		});

	}
 
	function firstPageInit() {
		var data;
		if(currentDisplayPage==0){
			data = firstReturnData;
		}else{
			data=returnData;
		}
		$("#item-lists").find("li").remove();
		var html = '';
		var dataLength = data.length;
		countRecord = dataLength;
		for (var i = 0; i < dataLength; i++) {
			//设备编号
			var code = "-&nbsp;&nbsp;-&nbsp;&nbsp;";
			
			if (data[i].code) {
				code = data[i].code;
			}
			//开关状态							
			var workStatus = "-&nbsp;&nbsp;-&nbsp;&nbsp;";
		
			if (data[i].workStatus == 1) {
					workStatus = "开启";
			} else if (data[i].workStatus == 0) {
					workStatus = "关闭";
			}

			//故障状态
			var faultStatus = "-&nbsp;&nbsp;-&nbsp;&nbsp;";

			if(data[i].faultStatus==0){
					faultStatus = "故障";
			}else if(data[i].faultStatus==1){
					faultStatus = "正常";
			} 
			//位置
			var locationName = "-&nbsp;&nbsp;-&nbsp;&nbsp;";
			if (data[i].locationName) {
				locationName = data[i].locationName;
			}
			//手自动
			var automatic = "-&nbsp;&nbsp;-&nbsp;&nbsp;";
			if(data[i].automatic==0){
				automatic = "手动";
		    }else if(data[i].automatic==1){
		    	automatic = "自动";
		    } 
			//设备ID
			var deviceId;
			if (data[i].deviceId) {
				deviceId = data[i].deviceId;
			}

			html = '<li class="item">'
					+ '<div class="float-lf">'
					+ '<img class="item-img" src="static/img/device/Exhaust.png"/>'
					+ '</div>'
					+ '<div class="float-lf item-baseinfo">'
					+ '<div class="">'
					+ '<p class="item-equip" id=code_'+deviceId+'>'
					+ code
					+ '</p><p class="item-name">排风机</p>'
					+ '</div>'
					+ '<div class="equip-status clearfix">'
					+ '<p class="float-lf">开关：<span  id=workStatus_'+deviceId+'>'
					+ workStatus
					+ '</span></p><p class="float-rt adj-position">故障状态：<span id=faultStatus_'+deviceId+'>'
					+ faultStatus
					+ '</span></p></div>'
					+ '<div class="equip-place clearfix">'
					+ '<p class="float-lf position-device" >位置：<span id=locationName_'+deviceId+'>'
					+ locationName
					+ '</span></p><p class="float-rt ">手自动：<span id=automatic_'+deviceId+'>'
					+ automatic + '</span></p></div>' + '</div>' + '</li>'
			$("#item-lists").append(html);
			if (data[i].workStatus == 1) {
				$("#workStatus_" +deviceId).addClass("status-color");
			} else if (data[i].workStatus == 0) {
				$("#workStatus_" +deviceId).addClass("statuss-color");
			}
			if(data[i].faultStatus==0){
				$("#faultStatus_" +deviceId).addClass("statuss-color");
			
		    }else if(data[i].faultStatus==1){
		    	$("#faultStatus_" +deviceId).addClass("status-color");
	
		    } 
		}
	}

	function ban() {
		//楼栋选项请求
		$.ajax({
			type : "post",
			url : "${ctx}/device/manages/newBuildings?projectCode=" + projectCode
					+ "&code=" + code + "&locationType=" + locationType,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {

				ddlItems = data;
				banlist = $('#all-buildingslist').dropDownList({
					inputName : "banName",
					inputValName : "banNameId",
					buttonText : "",
					width : "117px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (undefined == data) {
							return;
						} else {
							var id = data;
							floor(id);
						}

					},
					items : ddlItems
				});
				banlist.setData(ddlItems[0].itemText, ddlItems[0].itemData);
				;
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}

	function floor(id) {
		//楼层选项请求
		$.ajax({
			type : "post",
			url : "${ctx}/device/manages/freshAirFloor?parentId=" + id,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				ddlItemc = data;
				floorlist = $('#floorlist').dropDownList({
					inputName : "floorName",
					inputValName : "floorNameId",
					buttonText : "",
					width : "117px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {

					},
					items : ddlItemc
				});
				floorlist.setData(ddlItemc[0].itemText, ddlItemc[0].itemData);
				;
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}

	function deviceInit() {//初始设备
		var limit = oneCount;
		var data = {};
		var deviceNumber = $("#deviceNumber").val();
		var selectForm = getFormData("select-form");
		var buildingId = selectForm.banNameId;
		var floorId = selectForm.floorNameId;
		var locationId;
		if (buildingId != "") {
			$(data).attr({
				"buildingId" : buildingId
			});
		}
		if (floorId != "") {
			$(data).attr({
				"floorId" : floorId
			});
		}
		if (deviceNumber != "") {
			$(data).attr({
				"deviceNumber" : deviceNumber
			});
		}
		$(data).attr({
			"projectCode" : projectCode
		});
		$(data).attr({
			"code" : code
		});
		$.ajax({
				type : "post",
				url : "${ctx}/device/manage/newBuildInfo?page=1&limit=" + limit
				+ "&sortName=deviceName&sortType=desc",
				async : false,
				dataType : "json",
				data : JSON.stringify(data),
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					deviceData = data;
					$("#tb_exhaustDataDiv").find("div").remove();
					if(deviceData.items.length>0){
						initPage(deviceData);
					}else{
					$("#item-lists").find("li").remove();
					var nodataDiv= '<div style="width:100%;height:600px;padding-top: 3rem;font-size:20px;line-height:600px;text-align:center;">'
						+"无数据"+'</div>';
						$("#tb_exhaustDataDiv").append(nodataDiv);
						$(".pagination").pagination(1, {
							prev_text : '上一页',
							next_text : '下一页',
							items_per_page : 1,
							num_display_entries : 5,
							num_edge_entries : 2
						});
					}
			},
			error : function(req, error, errObj) {
				$("#item-lists").find("li").remove();
			}
		});
	}
	
	
		
		
	
	function initPage(deviceData) {//初始页
		//这里向后台请求的url需要替换
		$.ajax({
			type : "post",
			url : "${ctx}/hvac/freshAirDisplay/newBuilding",
			data : JSON.stringify(deviceData.items),
			dataType : "json",
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				firstReturnData = data;
 				 $(".pagination").pagination(deviceData.totalCount, {
 					callback : pageselectCallback,
 					prev_text : '上一页',
 					next_text : '下一页',
 					items_per_page : oneCount,
 					num_display_entries : 5,
 					num_edge_entries : 2
 				}); 
			},
			error : function(req, error, errObj) {
				$("#item-lists").find("li").remove();
			}
		});
		

	}

	function pageselectCallback(page_index, jq) {
		InitData(page_index);
	}
	function InitData(page_id) {
		currentDisplayPage=page_id;
		getAirData(page_id + 1);
	}

</script>
</html>