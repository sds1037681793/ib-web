<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>

</head>
<body>
<div style="margin-top: 10px;margin-right: 10px;width: 100%;"
		class="content-default">
			<form id="select-form" style="margin-top: 13px;">
			<table>
				<tr>
					<td align="right" width="80">选择系统：</td>
				    <td>
						<div id="one-scheme-dropdownlist"></div>
					</td>
					<td align="right" width="168">选择二级系统：</td>
				    <td>
						<div id="two-scheme-dropdownlist"></div>
					</td>
					<td align="right" width="168">设备类型：</td>
					<td>
						<div id="three-scheme-dropdownlist"></div>
					</td>
				    <td align="right" width="168">设备编号：</td>
                    <td><input id="deviceNumber" type="text" class="form-control required" style="width:150px"/></td>
					<td>
						<button id="btn-query" type="button"
							class="btn btn-default btn-common btn-common-green btnicons"  
						style="margin-left: 3rem;">
                          <p class="btniconimg"><span>查询</span></p>
                     </button>
                     </td>
                     <td>
							<button onclick="exportEventExecl()" type="button" style="margin-left: 30px;margin-top: -1px;width:80px;height: 30px;color:#FFFFFF;border: 1px solid #00BFA5;background-color: #00BFA5;">导出设备</button>
                     		<button id="downloadExeclManage" type="button" style="margin-left: 30px;margin-top: -1px;width:80px;height: 30px;color:#FFFFFF;border: 1px solid #00BFA5;background-color: #00BFA5;">导出管理</button>
							<button id="import" type="button" style="margin-left: 30px;margin-top: -1px;width:80px;height: 30px;color:#FFFFFF;border: 1px solid #00BFA5;background-color: #00BFA5;">导入设备</button>
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
	<div id="export-device"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
  <script type="text/javascript">
	var tbAlarmEven;
	// 一级分类
	var levelTypeList = new Array();
    var levelTypeMaps = new HashMap();
    var levelTypeObj;
    
    // 二级分类
    var levelTwoTypeList = new Array();
    var levelTwoTypeMaps = new HashMap();
    var levelTwoTypeObj;
    
    // 设备类型
    var levelThreeTypeList = new Array();
    var levelThreeTypeMaps = new HashMap();
    var levelThreeTypeObj;
    $(document).ready(function() {
    	//获取配置的一级分类
		$.ajax({
			type: "post",
			url: "${ctx}/device/deviceInfo/listDeviceLevel?category="+1,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				levelTypeList[levelTypeList.length] = {itemText: "请选择系统", itemData: ""};
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
						onSelect: function(i, data, icon) {
							if(data != "" && data != undefined){
								//根据一级分类获取二级分类
								getCategoryTwo(data);
								// 同时更新三级分类
								getDeviceType(data,1);
							}else if(data == ""){
								getTwoCreatyType();
								getDeviceType(data,"");
							}
						},
						items: levelTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		levelTypeObj.setData("请选择系统" ,"", "");
		
		//获取配置的二级分类
		getTwoCreatyType();
		
		// 获取设备类型
		getDeviceTypeNoParentId();
		
		
		// 事件展现列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'设备类型id',name:'deviceTypeId',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'设备一级分类id',name:'deviceSysId',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'设备二级分类id',name:'deviceSubId',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'设备一级分类code',name:'deviceSysCode',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'设备编号',name:'deviceNumber',width:235,sortable:false,align:'left'},
				{title:'设备名称',name:'deviceName',width:235,sortable:false,align:'left'},
				{title:'设备类型',name:'deviceTypeName',width:235,sortable:false,align:'left'},
				{title:'一级分类',name:'systemCode',width:235,sortable:false,align:'left'},
				{title:'二级分类',name:'subSystemCode',width:235,sortable:false,align:'left'},
				{title:'位置',name:'locationName',width:232.6,sortable:false,align:'left'},
				{title:'操作', name:'' ,width:230, align:'left', lockWidth:true, lockDisplay: true, renderer: function(val){
					var viewObj = '<a class="calss-view" href="#" title="查看"><span style="font-size: 12px; color: #777; padding-right: 10px;"><img class="view" src="${ctx}/static/img/device/chakan.png"></span></a>';
					var modifyObj = '<a class="calss-modify" href="#" title="修改"><span style="font-size: 12px; color: #777; padding-right: 10px;"><img class="modify" src="${ctx}/static/img/alarm/xiugai.png"></span></a>';
					var deleteObj = '<a class="calss-delete" href="#" title="删除"><span style="font-size: 12px; color: #777; padding-right: 10px;"><img class="delete" src="${ctx}/static/img/device/shanchu.png"></span></a>'; 
					return viewObj + modifyObj + deleteObj;
				}}
			];
			var pg = $('#pg').mmPaginator({"limitList":[20]});
			tbAlarmEven = $('#tb_groups').mmGrid({
			width:'100%',
			height:776,
			cols:cols,
			url:"${ctx}/device/deviceInfo/list?projectCode="+projectCode,
			method:'post',
			remoteSort:false,
			sortName:'id',
			sortStatus:'desc',
			multiSelect:false,
			fullWidthRows:false,
			showBackboard:false,
			autoLoad:false,
			nowrap:true,
			params:function(){
				data = {};
				var selectForm = getFormData("select-form");
			    var deviceType = selectForm.levelThreeType;
				if (deviceType != "" && deviceType != undefined){
					$(data).attr({"deviceType": deviceType});
				}
			    var subSystemCode = selectForm.levelTwoType;
				if (subSystemCode != "" && subSystemCode != undefined){
					$(data).attr({"subSystemCode": subSystemCode});
				}
			    var systemCode = selectForm.levelType;
				if (systemCode != "" && systemCode != undefined){
					$(data).attr({"systemCode": systemCode});
				}
			    var deviceNum = $("#deviceNumber").val();
				if (deviceNum != ""){
					$(data).attr({"deviceNum": deviceNum});
				}
				return data;
			},
			plugins:[pg]
		});
			tbAlarmEven.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
				if($(e.target).is('.calss-view') || $(e.target).is('.view')){
					var row = tbAlarmEven.row(rowIndex);
					e.stopPropagation();  //阻止事件冒泡
			    	createModalWithLoad("rest-config-edit", 300,"" , row.deviceName, "deviceInfos/view?rowIndex=" + rowIndex, "", "", "");
		            openModal("#rest-config-edit-modal", true, true);
				}else if($(e.target).is('.calss-modify') || $(e.target).is('.modify')){
				    e.stopPropagation();  //阻止事件冒泡
			    	createModalWithLoad("rest-config-edit", 600, 260, "修改设备信息", "deviceInfos/edit?rowIndex=" + rowIndex, "saveConfig()", "confirm-close", "");
		            openModal("#rest-config-edit-modal", true, true);
				}else if($(e.target).is('.calss-delete') || $(e.target).is('.delete')){
					e.stopPropagation();  //阻止事件冒泡
					showDialogModal("error-div", "提示", "删除功能暂未开放！");
				}
			}).on('loadSuccess',function(e,data){
				
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
			$("#btn-query").on('click',function (){
				pg.load({"page":1});
				tbAlarmEven.load();
			});	
			$("#import").on('click',function (){
				showDialogModal("error-div", "提示", "导入功能暂未开放！");
			});
			
			$("#downloadExeclManage").on('click',function (){
				createModalWithLoad("export-device", 700, 0, "导出下载", "deviceInfos/deviceExportPage", "", "", "", 120);
	            openModal("#export-device-modal", true, true);
			});	
});
    
    // 设备类型
    function getDeviceTypeNoParentId(){
    	levelThreeTypeList.splice(0, levelThreeTypeList.length);
    	levelThreeTypeMaps = new HashMap();
    	var parentIds = null;
		//获取配置的设备类型
		$.ajax({
			type: "get",
			url: "${ctx}/device/deviceInfo/listDeviceType?parentId="+0,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data != null && data.length > 0) {
					levelThreeTypeList[levelThreeTypeList.length] = {itemText: "请选择设备类型", itemData: ""};
					$(eval(data)).each(function(){
						levelThreeTypeMaps.put(this.itemData,this.itemText);
						levelThreeTypeList[levelThreeTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
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
						onSelect: function(i, data, icon) {
							
						},
						items: levelThreeTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		levelThreeTypeObj.setData("请选择设备类型" ,"", "");
    }
    
    // 二级分类
    function getTwoCreatyType(){
    	levelTwoTypeList.splice(0, levelTwoTypeList.length);
    	levelTwoTypeMaps = new HashMap();
		$.ajax({
			type: "post",
			url: "${ctx}/device/deviceInfo/listDeviceLevel?category="+2,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				levelTwoTypeList[levelTwoTypeList.length] = {itemText: "请选择二级系统", itemData: ""};
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
						onSelect: function(i, data, icon) {
							if(data != "" && data != undefined){
								getDeviceType(data,"");
							}/* else if(data == ""){
								getDeviceTypeNoParentId()
							} */
						},
						items: levelTwoTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		levelTwoTypeObj.setData("请选择二级系统" ,"", "");
    }
    
    // 根据二级分类获取设备类型
    function getDeviceType(parentId,item){
    	levelThreeTypeList.splice(0, levelThreeTypeList.length);
    	levelThreeTypeMaps = new HashMap();
    	//获取配置的设备类型
		$.ajax({
			type: "get",
			url: "${ctx}/device/deviceInfo/listDeviceType?parentId="+parentId+"&items="+item,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data != null && data.length > 0) {
					levelThreeTypeList[levelThreeTypeList.length] = {itemText: "请选择设备类型", itemData: ""};
					$(eval(data)).each(function(){
						levelThreeTypeMaps.put(this.itemData,this.itemText);
						levelThreeTypeList[levelThreeTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
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
						onSelect: function(i, data, icon) {
							
						},
						items: levelThreeTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		levelThreeTypeObj.setData("请选择设备类型" ,"", "");
    }
    
    // 根据一级分类获取二级分类
    function getCategoryTwo(parentId){
    	levelTwoTypeList.splice(0, levelTwoTypeList.length);
    	levelTwoTypeMaps = new HashMap();
		//获取配置的二级分类
		$.ajax({
			type: "post",
			url: "${ctx}/device/deviceInfo/listDeviceParentId?parentId="+parentId,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				levelTwoTypeList[levelTwoTypeList.length] = {itemText: "请选择二级系统", itemData: ""};
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
						onSelect: function(i, data, icon) {
							if(data != "" && data != undefined){
								getDeviceType(data,"");
							}/* else if(data == ""){
								getDeviceTypeNoParentId();
							} */
						},
						items: levelTwoTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		levelTwoTypeObj.setData("请选择二级系统" ,"", "");
    }
    
 	// 导出excel
    function exportEventExecl() {
    	var url = ctx + "/device/deviceInfo/getDeviceInfoExcel";
    	var selectForm = getFormData("select-form");
	    var deviceType = selectForm.levelThreeType;
	    var subSystemCode = selectForm.levelTwoType;
	    var systemCode = selectForm.levelType;
	    var deviceNum = $("#deviceNumber").val();
    	var params = "?projectCode=" + projectCode
    	+ "&deviceType=" + deviceType + "&subSystemCode=" + subSystemCode
    	+ "&systemCode=" + systemCode + "&deviceNum=" + deviceNum;
    	params = params.replace(/undefined/g,"");
    	//获取配置的设备类型
		$.ajax({
			type: "get",
			url: url + params + "&_=" + new Date().toTimeString(),
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				createModalWithLoad("export-device", 700, 0, "导出下载", "deviceInfos/deviceExportPage", "", "", "", 120);
	            openModal("#export-device-modal", true, true);
			},
			error: function(req, error, errObj) {
			}
		});
    }
 	
</script>
</body>
</html>