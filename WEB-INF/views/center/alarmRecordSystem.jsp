<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM" />
<!DOCTYPE html>
<html>
<head>
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/iconic.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/mmgrid/mmGrid.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/mmgrid/mmPicture.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/mmgrid/mmPaginator.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/mmgrid/theme/bootstrap-rib/mmGrid-bootstrap-rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/mmgrid/theme/bootstrap-rib/mmPaginator-bootstrap-rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap/buttons.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-datetimepicker/2.1.9/css/jquery.datetimepicker.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/theme/rib-green.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/mmgrid/mmGrid.js" type="text/javascript"></script>
<script src="${ctx}/static/component/mmgrid/mmPaginator.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/HashMap.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-dropdownlist/jquery.dropdownlist.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-datetimepicker/2.1.9/js/jquery.datetimepicker.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<style type="text/css">
/* .alarms {
    color: #141F36;
}

.content-default {
font-family: PingFangSC-Regular;
	font-size: 12px;
	color:white;
	letter-spacing: 0;
    background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
    border: none;
}
.form-control {
    background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
    margin-left: 20px;
    margin-bottom: 2px;
    color: #fff;
    margin-top: 2px;
    font-size: 12px;
    height: 26px;
    line-height: 12px;
    border: 1px solid #56E4FF;
}
.input-group .form-control {
    position: relative;
    z-index: 2;
    float: left;
    width: 100%;
    margin-bottom: 0;
    background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
    border: 1px solid #56E4FF;
}
.btn-default {
    background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
}
.dropdown-menu {
    background-color: rgba(0, 162, 221, 0.6);
    }
    
.dropdown-menu>li>a:focus, .dropdown-menu>li>a:hover {
    color: #262626;
    text-decoration: none;
      background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
}
.mmGrid {
    position: relative;
    overflow: hidden;
    background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
    border: 0px solid #56E4FF;
    text-align: left;
}
.even{

}
.mmGrid .mmg-bodyWrapper .mmg-body tr.even {
       background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
       font-weight: bold;
}

.mmGrid .mmg-headWrapper {
    background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
    filter: none;
    -moz-box-shadow: none;
    -webkit-box-shadow: none;
    box-shadow: none;
    border-top: 0;
    font-size: 15px;
    color:#56E4FF;
    border-bottom: 0px solid #5f1313;
}
.input-group-btn:last-child>.btn, .input-group-btn:last-child>.btn-group {
   background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
}

.mmGrid .mmg-bodyWrapper .mmg-body td.colSelected {
    background: rgba(9, 162, 221, -0.6) none repeat scroll 0% 0%;
}
.mmGrid .mmg-bodyWrapper .mmg-body tr:hover td {
    background: rgba(59, 188, 230, 0.3) none repeat scroll 0 0;
}
#ddl-btn-levelThreeTypeName{
  border: 1px solid #56E4FF;
}

.mmGrid .mmg-bodyWrapper .mmg-body td {
    padding: 4px 6px;
    border-right: 0px solid #56E4FF;
    border-bottom: 1px solid #105478;
}

.mmGrid table {
    border-right: 1px solid #105478;
}

.mmGrid .mmg-bodyWrapper {
    color:#ccc;
}
 */
.menu{
height:30px;  margin-left:8px; border: none;
		text-align:center; font-size: 14px; outline: none; margin-right: 50px;
		cursor:pointer;
}
.dropdown-menu{
left:20px;
}
.selected{
font-size: 14px;
color: #00BFA5;
}
</style>
</head>
<body class="alarms" style="padding: 26px 10px 10px;">
<div style="margin-top: 10px;margin-right: 10px;width: 100%;"
		class="content-default">
		<div>
		<span id="qb" class="menu" onclick="onclickInput(this)">全部</span>
		<span id="xf" class="menu" onclick="onclickInput(this)">消防系统</span>
		<span id="rx" class="menu" style="" onclick="onclickInput(this)">人行系统</span>
		<span id="tk" class="menu"  onclick="onclickInput(this)">梯控系统</span>
		<span id="tcc" class="menu"  onclick="onclickInput(this)">停车场系统</span>
		<span id="sp" class="menu"  onclick="onclickInput(this)">视频监控系统</span>
		<span id="nt" class="menu"  onclick="onclickInput(this)">暖通空调</span>
		<span id="gps" class="menu"   onclick="onclickInput(this)">给排水</span>
		<span id="gpd" class="menu" onclick="onclickInput(this)">供配电</span>
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
					
				</tr>
				<tr>
				<td align="right" width="120">报警事件：</td>
					<td>
						<div id="alarmEventDescribe-dropdownlist"></div>
					</td>
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
							class="btn btn-default btn-common btn-common-green"
							style="margin-left: 67px;width:56px;color:#00BFA5;border: 1px solid #00BFA5;background-color: #fff;"><img style="margin-left:-8px" src="${ctx}/static/img/alarm/search.png">&nbsp;&nbsp;查询</button>
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
			
    <input id="systemCode" type="text" style="display:none;"/>
	<div id="pg" style="text-align: right;"></div>
	<div id="rest-config-info"></div>
	<div id="rest-config-edit"></div>
	<div id="rest-config-relate"></div>
	<div id="rest-config-door"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
	<div id="alarm-snapshot-img1"></div>
  <script type="text/javascript">
  var rows;
  var projectCode = "${param.projectCode}";
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
		}else if(id == "qb"){
			$("#systemCode").val("");
		}
		// 更新下拉框
		getDeviceTypeByCheck(systemCode);
		pg.load({"page":1});
		tbAlarmEven.load();
    }
    
    function getAppName() {
    	var pathname = window.location.pathname;
    	var index = pathname.substr(1).indexOf("/");
    	return pathname.substr(0, index + 1);
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
    dealStatusObj.setData("未恢复" ,"0", "");	
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
	function AlarmCreateImgurlsModal(rows) {
		//createModalWithLoad("alarm-snapshot-img1", 780, 500, "告警抓拍", "alarmRecords/alarmFindSnapshotImage?rows=" + rows, "", "", "");
		//createSimpleModalWithIframe("alarm-snapshot-img1",780,500,"${ctx}/alarmRecords/alarmFindSnapshotImage?rows=" + rows, null);
		//createSimpleModalWithIframe("alarm-snapshot-img1",780,500,"${ctx}/alarmRecords/alarmRecordPage", null);
		//openModal("alarm-snapshot-img1-modal", false, false);
		//createModalWithLoad("device-detail", 600, 328, "查看设备状态明细", "hvacRealTimeDataPage/hvacHotDeviceDetailPage?deviceId="+deviceId+"", "", "", "");
		//createModalWithLoad("alarm-snapshot-img1", 780, 500, "告警抓拍", "alarmRecords/alarmSystemFindSnapshotImage?rows=" + rows, "", "", "");
		createSimpleModalWithIframe("alarm-snapshot-img1",750,400,"${ctx}/alarmRecords/alarmSystemFindSnapshotImage?rows=" + rows, null);
		//$(".modal-content").css("background","rgba(9, 162, 221, 0.4) none repeat scroll 0% 0%");
		$("#alarm-snapshot-img1-modal").modal('show');
 		$('#alarm-snapshot-img1-modal').on('shown.bs.modal', function() {
			var tempFrame = document.getElementById('alarm-snapshot-img1-iframe');
			if (tempFrame == undefined) {
				return;
			}
			tempFrame.contentWindow.loadPic();
		}) 
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
		
		// 事件展现列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'首次发生时间',name:'firstAlarmTime',width:180,sortable:false,align:'left'},
				{title:'优先级',name:'level',width:70,sortable:false,align:'left',renderer:function(val, item , rowIndex){
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
				{title:'设备类型',name:'deviceTypeCode',width:115,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.deviceTypeCode!=null){
						return levelThreeTypeMaps.get(item.deviceTypeCode);
					}  
				}},
				{title:'设备名称',name:'deviceName',width:130,sortable:false,align:'left'},
				{title:'事件类型',name:'eventType',width:130,sortable:false,align:'left'},
				{title:'设备编号',name:'deviceNumber',width:130,sortable:false,align:'left'},
				{title : '抓拍',name : 'imgurls',width : 90,sortable : false,align : 'center',renderer : function(val, item, rowIndex) {
						if (item.imgurls != undefined && item.imgurls.length > 0) {
							return '<img id="" src="${ctx}/static/images/icon34.png" />';
						} else {
							return "无";
						}
					}
				},
				{title:'状态',name:'level',width:100,sortable:false,align:'left',renderer:function(val, item , rowIndex){
						if(item.lastAlarmTime == "" || item.lastAlarmTime == undefined){
							return '<div style="background-color: #F5A623;width: 52px;"><span style="text-align:center;display:block;color:#FFFFFF;">未恢复</span></div>';
						}else if(item.lastAlarmTime != ""){
							return '<div style="background-color: #2DBA6C;width: 52px;"><span style="text-align:center;display:block;color:#FFFFFF;">已恢复</span></div>';
						}
				}}
			];
			pg = $('#pg').mmPaginator({"limitList":[20]});
			tbAlarmEven = $('#tb_groups').mmGrid({
			height:700,
			cols:cols,
			url:"${ctx}/alarm-center/alarmRecord/list?projectCode="+projectCode,
			method:'get',
			remoteSort:false,
			sortName:'id',
			sortStatus:'desc',
			multiSelect:true,
			fullWidthRows:false,
			autoLoad:false,
			nowrap:true,
			showBackboard : false,
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
				}
			}).on('doubleClicked',function(e, item, rowIndex, colIndex) {
				if (pieTbAccessPassGridrow.imgurls != undefined && pieTbAccessPassGridrow.imgurls.length > 0 && pieTbAccessPassGridrow.imgurls != "null") {
					rows = tbAlarmEven.row(rowIndex);
					AlarmCreateImgurlsModal(rows.imgurls);
				}
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
			$("#btn-query").on('click',function (){
				pg.load({"page":1});
				tbAlarmEven.load();
			});	
			
});
</script>
</body>
</html>