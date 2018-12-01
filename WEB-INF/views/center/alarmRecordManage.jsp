<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<link href="${ctx}/static/css/pagination.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script src="${ctx}/static/js/jquery.pagination.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<style type="text/css">
.menu{
height:30px;  background-color: #fff; margin-left:8px; border: none;
		text-align:center; font-size: 14px; outline: none; margin-right: 50px;
		cursor:pointer;
}
.selected{
font-size: 14px;
color: #00BFA5;
}
.bx-controls bx-has-controls-direction bx-has-pager {
	    margin-top: -66px;
}
/* @media only screen and (max-width: 1024px) {
	.headDiv {
		margin-left: 1.2rem;
	}
	.content {
		padding-left: 0.625rem;
	}
	#setting, #fullScreen {
		width: 1rem;
		height: 1rem;
	}
	.func {
		padding: 0.625rem 0.5rem 0.625rem 0.5rem;
	}
}

@media only screen and (min-width: 1025px) {
	.headDiv {
		margin-left: 1.8rem;
	}
	.content {
		padding-left: 1.25rem;
	}
	#setting, #fullScreen {
		width: 1.2rem;
		height: 1.2rem;
	}
	.func {
		padding: 0.625rem;
	}
}

.headDiv {
	background: rgba(255, 255, 255, 0.11);
	border: 1px solid rgba(132, 199, 255, 0.2);
	border-radius: 4px;
	padding-top: 0.65rem;
	float: left;
	/* 	margin-left: 1.8rem; */
	/* overflow: hidden;
}

.headDiv .hd {
	overflow: hidden;
}

.headDiv .hd .prev, .headDiv .hd .next {
	width: 2rem;
	height: 100%;
	cursor: pointer;;
}

.headDiv .hd .prevStop {
	background-position: -60px 0;
}

.headDiv .hd .nextStop {
	background-position: -60px -50px;
}

.hd img {
display: none;
}

.hd:hover img {
	display: block; 
}

.headDiv .bd {
	float: left;
	margin: 0 auto;
}

.headDiv .bd ul {
	overflow: hidden;
	zoom: 1;
}

.headDiv .bd ul li {
	margin: 0 8px;
	float: left;
	_display: inline;
	overflow: hidden;
	text-align: center;
} */ 
</style>
</head>
<body>
<div style="margin-top: 10px;margin-right: 10px;width: 100%;"
		class="content-default">
		<div>
		<span id="qb" class="menu" onclick="onclickInput(this)">全部</span>
		<span id="xf" class="menu" onclick="onclickInput(this)">消防系统</span>
		<span id="rx" class="menu" style="" onclick="onclickInput(this)">人行系统</span>
		<span id="tk" class="menu"  onclick="onclickInput(this)">梯控系统</span>
		<span id="tcc" class="menu"  onclick="onclickInput(this)">停车场系统</span>
		<span id="sp" class="menu"  onclick="onclickInput(this)">视频监控系统</span>
		<!-- <span id="nt" class="menu"  onclick="onclickInput(this)">暖通空调</span>
		<span id="gps" class="menu"   onclick="onclickInput(this)">给排水</span>
		<span id="gpd" class="menu" onclick="onclickInput(this)">供配电</span> -->
		<span id="wlw" class="menu"  onclick="onclickInput(this)">物联网传感器系统</span>
		</div>
			<form id="select-form" style="    margin-top: 13px;">
			<table>
				<tr>
					<td align="right" width="100">设备编号：</td>
                    <td><input id="deviceNumber" type="text" class="form-control required" style="width:150px"/></td>
					<td align="right" width="100">设备类型：</td>
					<td>
						<div id="three-scheme-dropdownlist"></div>
					</td>
						<td align="right" width="100">优先级：</td>
					<td>
						<div id="priority-level-dropdownlist"></div>
					</td>
					<td align="right" width="120">事件类型：</td>
					<td>
						<div id="alarmEventType-dropdownlist"></div>
					</td>
					<td align="right" width="120">报警事件：</td>
					<td>
						<div id="alarmEventDescribe-dropdownlist"></div>
					</td>
				</tr>
				<tr>
					<td align="right" width="120">处理状态：</td>
					<td>
						<div id="deal-status-dropdownlist"></div>
					</td>
					<td align="right" style="width: 11rem;">开始时间：</td>
					<td><input id="startDate" name="startDate"
						class="form-control required" type="text" style="width:150px"/></td>
					<td align="right" style="width: 9rem;">结束时间：</td>
					<td><input id="endDate" name="endDate"
						class="form-control required" type="text" style="width:150px"/></td>
					<td>
					
						<button id="btn-query" type="button"
							class="btn btn-default btn-common btn-common-green btnicons" style="margin-left: 3rem;">
                          <p class="btniconimg"><span>查询</span></p>
                     </button>
					</td>
				</tr>
			</table>
		</form>
	</div>
		<div  style="margin-top: 19px;">
		</div>
	<table id="tb_groups" class="tb_groups" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>
			
	<%-- 	<div id="pphead" class="headDiv">
			<div class="hd" style="float:left;">
				<img class="next "
					style="float: left; width: 1.5rem; height: 3.75rem;"
					src="${ctx}/static/img/index/left.png" />
			</div>
			<div class="bd">
				<ul id="picList" class="picList">
				</ul>
			</div>
			<div class="hd" style="float:right;">
				<img class="prev"
					style="float: right; width: 1.5rem; height: 3.75rem;"
					src="${ctx}/static/img/index/right.png" />
			</div>

		</div> --%>
		
    <input id="systemCode" type="text" style="display:none;"/>
	<div id="pg" style="text-align: right;"></div>
	<div id="rest-config-info"></div>
	<div id="rest-config-edit"></div>
	<div id="rest-config-relate"></div>
	<div id="rest-config-door"></div>
	<div id="show-video-dss"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
	<div id="alarm-snapshot-img"></div>
  <script type="text/javascript">
	var tbAlarmEven;
	var pieTbAccessPassGridrow;
	// 一级分类
	var levelTypeList = new Array();
    var levelTypeMaps = new HashMap();
    var levelTypeObj;
    var pg;
    // 二级分类
    var levelTwoTypeList = new Array();
    var levelTwoTypeMaps = new HashMap();
    var levelTwoTypeObj;
    // 设备类型
    var levelThreeTypeList = new Array();
    var levelThreeTypeMaps = new HashMap();
    var levelThreeTypeObj;
    function onclickInput(obj){
    	$(".menu").removeClass("selected");
    	$(obj).addClass("selected");
    	var id = obj.id;
    	var systemCode="";
		if(id == "xf"){
			$("#systemCode").val("01");
			systemCode = "01";
		}else if(id == "rx"){
			$("#systemCode").val("02");
			systemCode = "02";
		}else if(id == "tk"){
			$("#systemCode").val("03");
			systemCode = "03";
		}else if(id == "tcc"){
			$("#systemCode").val("04");
			systemCode = "04";
		}else if(id == "sp"){
			$("#systemCode").val("05");
			systemCode = "05";
		}else if(id == "nt"){
			$("#systemCode").val("06");
			systemCode = "06";
		}else if(id == "gps"){
			$("#systemCode").val("07");
			systemCode = "07";
		}else if(id == "gpd"){
			$("#systemCode").val("08");
			systemCode = "08";
		}else if(id == "wlw"){
			$("#systemCode").val("09");
			systemCode = "09";
		}else if(id == "qb"){
			$("#systemCode").val("");
		}
		// 更新下拉框
		getDeviceTypeByCheck(systemCode);
		// 更新列表
		pg.load({"page":1});
		tbAlarmEven.load();
    }
    
    
	function AlarmCreateImgurlsModal(rowIndex) {
		createModalWithLoad("alarm-snapshot-img", 780, 500, "告警抓拍", "alarmRecords/alarmFindSnapshotImage?rowIndex=" + rowIndex, "", "", "");
		openModal("#alarm-snapshot-img-modal", false, false);
		$('#alarm-snapshot-img-modal').on('shown.bs.modal', function() {
			loadPic();
		})
	}
	
	// 根据选择的系统 查询不同系统下的设备类型
	function getDeviceTypeByCheck(systemCode){
		levelThreeTypeList = new Array();
		var code3 = "DEVICE_TYPE_FROM";
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/alarmEventDefine/listAlarmStatic?code="+code3+"&systemCode="+systemCode,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data != null && data.length > 0) {
					levelThreeTypeList[levelThreeTypeList.length] = {itemText: "请选择", itemData: ""};
					$(eval(data)).each(function(){
						levelThreeTypeMaps.put(this.itemData,this.itemText);
						levelThreeTypeList[levelThreeTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		// 设置用户类型下拉列表
		levelThreeTypeObj = $("#three-scheme-dropdownlist").dropDownList({
			inputName: "levelThreeTypeName",
			inputValName: "levelThreeType",
			buttonText: "",
			width: "117px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {},
			items: levelThreeTypeList
		});
		levelThreeTypeObj.setData("请选择" ,"", "");
		
	}
    
    $(document).ready(function() {
    	// 页面默认选中全部
    	document.getElementById('qb').className="selected menu"; 
    	//开始时间格式年月日时分秒
			$("#startDate").datetimepicker({
				id: 'datetimepicker-startDate',
				containerId: 'datetimepicker-div',
				lang: 'ch',
				minView: "month",
				timepicker: false,
				hours12:false,
				allowBlank:true,
				format: 'Y-m-d 00:00:00',
			    formatDate: 'YYYY-mm-dd HH:mm:ss'
			});
		    //结束时间格式年月日时分秒
			$("#endDate").datetimepicker({
				id: 'datetimepicker-endDate',
				containerId: 'datetimepicker-div',
				lang: 'ch',
				timepicker: false,
				hours12:false,
				allowBlank:true,
				format: 'Y-m-d 23:59:59',
			    formatDate: 'YYYY-mm-dd HH:mm:ss'
			});
		    
			
			
			//获取一级分类下的信息
	    	var code1 = "SYSTEM_FROM";
			$.ajax({
				type: "post",
				url: "${ctx}/alarm-center/alarmRecord/listAlarmRecordCount?code="+code1+"&projectCode="+projectCode,
				async: false,
				contentType: "application/json;charset=utf-8",
				success: function(data) {
					if (data != null && data.length > 0) {
						$(eval(data)).each(function(){
							var value = this.itemData;
							var name = this.itemText;
							if(value == 01){
								$("#xf").text(name);
							}else if(value == 02){
								$("#rx").text(name);
							}else if(value == 03){
								$("#tk").text(name);
							}else if(value == 04){
								$("#tcc").text(name);
							}else if(value == 05){
								$("#sp").text(name);
							}else if(value == 06){
								$("#nt").text(name);
							}else if(value == 07){
								$("#gps").text(name);
							}else if(value == 08){
								$("#gpd").text(name);
							}else if(value == 09){
								$("#wlw").text(name);
							}else if(value == 0000){
								$("#qb").text(name);
							}
							
						});
					}
				},
				error: function(req, error, errObj) {
				}
			});
			
			
			
			
    	//获取配置的一级分类
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/alarmEventDefine/listAlarmStatic?code="+code1,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data != null && data.length > 0) {
					$(eval(data)).each(function(){
						levelTypeMaps.put(this.itemData,this.itemText);
						levelTypeList[levelTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
					});
					// 设置用户类型下拉列表
					levelTypeObj = $("#one-scheme-dropdownlist").dropDownList({
						inputName: "levelTypeName",
						inputValName: "levelType",
						buttonText: "",
						width: "117px",
						readOnly: false,
						required: true,
						maxHeight: 200,
						onSelect: function(i, data, icon) {},
						items: levelTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		
		//获取配置的二级分类
		var code2 = "SUB_SYSTEM_FROM";
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/alarmEventDefine/listAlarmStatic?code="+code2,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data != null && data.length > 0) {
					$(eval(data)).each(function(){
						levelTwoTypeMaps.put(this.itemData,this.itemText);
						levelTwoTypeList[levelTwoTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
					});
					// 设置用户类型下拉列表
					levelTwoTypeObj = $("#two-scheme-dropdownlist").dropDownList({
						inputName: "levelTwoTypeName",
						inputValName: "levelTwoType",
						buttonText: "",
						width: "117px",
						readOnly: false,
						required: true,
						maxHeight: 200,
						onSelect: function(i, data, icon) {},
						items: levelTwoTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		
		
		//获取配置的设备类型
		var code3 = "DEVICE_TYPE_FROM";
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/alarmEventDefine/listAlarmStatic?code="+code3,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data != null && data.length > 0) {
					levelThreeTypeList[levelThreeTypeList.length] = {itemText: "请选择", itemData: ""};
					$(eval(data)).each(function(){
						levelThreeTypeMaps.put(this.itemData,this.itemText);
						levelThreeTypeList[levelThreeTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		// 设置用户类型下拉列表
		levelThreeTypeObj = $("#three-scheme-dropdownlist").dropDownList({
			inputName: "levelThreeTypeName",
			inputValName: "levelThreeType",
			buttonText: "",
			width: "117px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {},
			items: levelThreeTypeList
		});
		levelThreeTypeObj.setData("请选择" ,"", "");
		
		//优先级别 
	    var priorityLevelItemList = new Array();
	    priorityLevelItemList[priorityLevelItemList.length]= {itemText: "请选择", itemData:""};
	    priorityLevelItemList[priorityLevelItemList.length]= {itemText: "高级", itemData:"1"};
	    priorityLevelItemList[priorityLevelItemList.length]={itemText: "中级", itemData:"2"};
	    priorityLevelItemList[priorityLevelItemList.length]={itemText: "低级", itemData:"3"};
		priorityLevelObj = $("#priority-level-dropdownlist").dropDownList({
			inputName: "priorityLevelName",
			inputValName: "priorityLevelVal",
			buttonText: "",
			width: "117px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {},
			items: priorityLevelItemList
		});
		priorityLevelObj.setData("请选择" ,"", "");
		
		
		//处理状态
	    var dealStatusItemList = new Array();
	    dealStatusItemList[dealStatusItemList.length]= {itemText: "请选择", itemData:""};
	    dealStatusItemList[dealStatusItemList.length]= {itemText: "未恢复", itemData:"0"};
	    dealStatusItemList[dealStatusItemList.length]={itemText: "已恢复", itemData:"1"};
	    dealStatusObj = $("#deal-status-dropdownlist").dropDownList({
			inputName: "dealStatusName",
			inputValName: "dealStatusVal",
			buttonText: "",
			width: "117px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {},
			items: dealStatusItemList
		});
	    dealStatusObj.setData("请选择" ,"", "");	
	    
	    //事件类型
	    var alarmEventType;
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/alarmEventDefine/getAlarmEventType",
			dataType : "json",
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				// 设置用户类型下拉列表
				alarmEventType = $("#alarmEventType-dropdownlist").dropDownList({
					inputName: "alarmEventTypeName",
					inputValName: "alarmEventTypeVal",
					buttonText: "",
					width: "117px",
					readOnly: false,
					required: true,
					maxHeight: 200,
					onSelect: function(i, data, icon) {
						var type = "";
						if(typeof(data) != "undefined"){
							type = data;
						}
						alarmEventDropDownList(type);
					},
					items: data
				});
				alarmEventType.setData("请选择" ,"", "");
			},
			error: function(req, error, errObj) {
			}
		});
		function alarmEventDropDownList(type){
			 var alarmEventDescribeObj;
				$.ajax({
					type: "post",
					url: "${ctx}/alarm-center/alarmEventDefine/getAlarmEventList?type="+type,
					dataType : "json",
					async: false,
					contentType: "application/json;charset=utf-8",
					success: function(data) {
						// 设置用户类型下拉列表
						alarmEventDescribeObj = $("#alarmEventDescribe-dropdownlist").dropDownList({
							inputName: "alarmEventDescribeName",
							inputValName: "alarmEventDescribeVal",
							buttonText: "",
							width: "117px",
							readOnly: false,
							required: true,
							maxHeight: 200,
							onSelect: function(i, data, icon) {
							},
							items: data
						});
						alarmEventDescribeObj.setData("请选择" ,"", "");
					},
					error: function(req, error, errObj) {
					}
			
				})
		}
		
		
		// 事件展现列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'首次发生时间',name:'firstAlarmTime',width:150,sortable:false,align:'left'},
				{title:'恢复时间',name:'lastAlarmTime',width:150,sortable:false,align:'left'},
				{title:'优先级',name:'level',width:50,sortable:false,align:'left',renderer:function(val, item , rowIndex){
					var itemcontent = "";
					if(item && item.level){
						if(item.level ==1){
							itemcontent="高";
						}else if(item.level ==2){
							itemcontent="中";
						}else if(item.level ==3){
							itemcontent="低";
						}
					}
					return itemcontent;
				}},
				{title:'报警事件',name:'describe',width:150,sortable:false,align:'left'},
				{title:'位置',name:'position',width:130,sortable:false,align:'left'},
				{title:'一级分类',name:'systemCode',width:100,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.systemCode!=null){
						return levelTypeMaps.get(item.systemCode);
					}  
				}},
				{title:'二级分类',name:'subSystemCode',width:100,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.subSystemCode!=null){
						return levelTwoTypeMaps.get(item.subSystemCode);
					}  
				}},
				{title:'设备类型',name:'deviceTypeCode',width:100,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.deviceTypeCode!=null){
						return levelThreeTypeMaps.get(item.deviceTypeCode);
					}  
				}},
				{title:'设备名称',name:'deviceName',width:130,sortable:false,align:'left'},
				{title:'事件类型',name:'eventType',width:130,sortable:false,align:'left'},
				{title:'设备编号',name:'deviceNumber',width:130,sortable:false,align:'left'},
				{title : '抓拍',name : 'imgurls',width : 50,sortable : false,align : 'left',renderer : function(val, item, rowIndex) {
						if (item.imgurls != undefined && item.imgurls.length > 0) {
							return '<img id="" src="${ctx}/static/images/icon34.png" />';
						} else {
							return "无";
						}
					}
				},
				{title : '回放',name : 'deviceId',width : 50,sortable : false,align : 'left',renderer : function(val, item, rowIndex) {
					return '<a class="calss-menu" href="#" title="回放"><img class="glyphicon-list-alt" src="${ctx}/static/images/playback.svg" /></a>';
				}
				},
				{title:'状态',name:'level',width:80,sortable:false,align:'left',renderer:function(val, item , rowIndex){
						if(item.lastAlarmTime == "" || item.lastAlarmTime == undefined){
							return '<div style="background-color: #F5A623;width: 52px;"><span style="text-align:center;display:block;color:#FFFFFF;">未恢复</span></div>';
						}else if(item.lastAlarmTime != ""){
							return '<div style="background-color: #2DBA6C;width: 52px;"><span style="text-align:center;display:block;color:#FFFFFF;">已恢复</span></div>';
						}
				}}
			];
			pg = $('#pg').mmPaginator({"limitList":[20]});
			tbAlarmEven = $('#tb_groups').mmGrid({
			width:'100%',
			height:776,
			cols:cols,
			url:"${ctx}/alarm-center/alarmRecord/list",
			method:'get',
			remoteSort:false,
			showBackboard:false,
			sortName:'id',
			sortStatus:'desc',
			multiSelect:true,
			fullWidthRows:true,
			autoLoad:false,
			nowrap:true,
			params:function(){
				var selectForm = getFormData("select-form");
			    var code = selectForm.levelThreeType;
			    var deviceNumber = $("#deviceNumber").val().trim();
			    var startDate = $("#startDate").val();
			    var endDate = $("#endDate").val();
			    var systemCode = $("#systemCode").val();
			    var priorityLevel = $("#priorityLevelVal").val();
			    var dealStatus = $("#dealStatusVal").val();
			    var eventType = $("#alarmEventTypeVal").val();
			    var eventCode = $("#alarmEventDescribeVal").val();
				data = {};
				if (projectCode != "" && projectCode != undefined){
					$(data).attr({"projectCode": projectCode});
				}
				if (code != "" && code != undefined){
					$(data).attr({"code": code});
				}
				if (deviceNumber != ""){
					$(data).attr({"deviceNumber": deviceNumber});
				}
				if (systemCode != ""){
					$(data).attr({"systemCode": systemCode});
				}
				if (startDate != ""){
					$(data).attr({"startTime": startDate});
				}
				if (endDate != ""){
					$(data).attr({"endTime": endDate});
				}
				if (priorityLevel != "" && priorityLevel != undefined){
					$(data).attr({"priorityLevel": priorityLevel});
				}
				if (dealStatus != "" && dealStatus != undefined){
					$(data).attr({"dealStatus": dealStatus});
				}
				if (eventType != "" && eventType != undefined){
					$(data).attr({"eventType": eventType});
				}
				if (eventCode != "" && eventCode != undefined){
					$(data).attr({"alarmEventCode": eventCode});
				}
				return data;
			},
			plugins:[pg]
		});
			tbAlarmEven.on('cellSelect',function(e,item,rowIndex,colIndex){
				pieTbAccessPassGridrow = tbAlarmEven.row(rowIndex);
				e.stopPropagation();
				if($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')){
					
				}else if($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')){
				}else if($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')){
				}else if ($(e.target).is('.calss-menu') || $(e.target).is('.glyphicon-list-alt')) {
					playBack(rowIndex);
				}
			}).on('doubleClicked',function(e, item, rowIndex, colIndex) {
				if (pieTbAccessPassGridrow.imgurls != undefined && pieTbAccessPassGridrow.imgurls.length > 0 && pieTbAccessPassGridrow.imgurls != "null") {
					AlarmCreateImgurlsModal(rowIndex);
				}
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
			$("#btn-query").on('click',function (){
				pg.load({"page":1});
				tbAlarmEven.load();
			});	
			function playBack(rowIndex){
		    	var row = tbAlarmEven.row(rowIndex);
		    	if(row.deviceId){
		        	createModalWithLoad("show-video-dss", 730, 500, "视频回放",
		        			"videomonitoring/showDssVideo?type=1&deviceNo="+ row.deviceId +"&playbackTime=" + encodeURI(row.firstAlarmTime), "", "", "","");
		    	}
		    }
			
});
</script>
</body>
</html>