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
</head>
<body>
<div style="margin-top: 10px;margin-right: 10px;width: 100%;"
		class="content-default">
			<form id="select-device-form" style="margin-top: 13px;">
			<table>
				<tr>
					<td align="right" width="80">选择系统：</td>
				    <td>
						<div id="one-scheme-dropdownlist"></div>
					</td>
					<td align="right" width="128">设备类型：</td>
					<td>
						<div id="three-scheme-dropdownlist"></div>
					</td>
					<td align="right" width="128">关联状态：</td>
					<td>
						<div id="relate-status-dropdownlist"></div>
				</tr>
				<tr>
					</td>
				    <td align="right" width="128">设备编号：</td>
                    <td><input id="deviceNumber" type="text" class="form-control required" style="width:150px"/></td>
                    <td align="right" width="128">设备名称：</td>
                    <td><input id="inputDeviceName" type="text" class="form-control required" style="width:150px"/></td>
					<td>
						<button id="btn-query" type="button" class="btn btn-default btn-common btn-common-green"  
								style="margin-left: 66px;margin-top: 1px; font-size: 12px;width:10px;color:#00BFA5;border: 1px solid #00BFA5;background-color: #fff;">
						<img style="margin-left:-8px" src="${ctx}/static/img/alarm/search.png">&nbsp;&nbsp;查询</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb_device_groups" class="tb_groups" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>
	
    <input id="systemCode" type="text" style="display:none;"/>
	<div id="devicePg" style="text-align: right;"></div>
  <script type="text/javascript">
	var tbAlarmEven;
	// 一级分类
	var levelTypeList = new Array();
    var levelTypeMaps = new HashMap();
    var levelTypeObj;
    
    // 设备类型
    var levelThreeTypeList = new Array();
    var levelThreeTypeMaps = new HashMap();
    var levelThreeTypeObj;
    // 设备已关联标记
    var checkResult = false;
    var relateStatus = "";
    
    // 关联状态查询列表
    var relateStatusDropdownList = [
		{
			itemText : '请选择关联状态',
			itemData : ''
		}, {
			itemText : '已关联',
			itemData : '1'
		}, {
			itemText : '未关联',
			itemData : '0'
		}
	];
	var tempRelateStatusDropdownList;
    
    $(document).ready(function() {
//     	alert(relatePictureId);添加relatePictureId到查询条件
    	// 设置关联类型下拉列表
		tempRelateStatusDropdownList = $("#relate-status-dropdownlist").dropDownList({
			inputName : "relateName",
			inputValName : "relateVal",
			buttonText : "",
			width : "110px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
				relateStatus = data;
			},
			items : relateStatusDropdownList
		});
		tempRelateStatusDropdownList.setData("请选择关联状态", "");
    	
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
						onSelect: function(i, data, icon) {},
						items: levelTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		levelTypeObj.setData("请选择系统" ,"", "");
		
		//获取配置的设备类型
		$.ajax({
			type: "get",
			url: "${ctx}/device/deviceInfo/listDeviceType",
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
						onSelect: function(i, data, icon) {},
						items: levelThreeTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		levelThreeTypeObj.setData("请选择设备类型" ,"", "");
		
		// 事件展现列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:true,align:'left',hidden:'true'},
				{title:'设备类型id',name:'deviceTypeId',width:100,sortable:true,align:'left',hidden:'true'},
				{title:'设备一级分类id',name:'deviceSysId',width:100,sortable:true,align:'left',hidden:'true'},
				{title:'设备一级分类code',name:'deviceSysCode',width:100,sortable:true,align:'left',hidden:'true'},
				{title:'设备编号',name:'deviceNumber',width:220,sortable:true,align:'left'},
				{title:'设备名称',name:'deviceName',width:220,sortable:true,align:'left'},
				{title:'设备类型',name:'deviceTypeName',width:200,sortable:true,align:'left'},
				{title:'一级分类',name:'systemCode',width:200,sortable:true,align:'left'},
				{title:'位置',name:'locationName',width:225,sortable:true,align:'left'},
				{title:'关联状态',name:'relateId',width:120,sortable:true,align:'left',
				renderer : function(val, item, rowIndex) {
					if (item.relateId == null || item.pictureId != relatePictureId) {
						return '<span style="text-align:left;">未关联</span>';
						//color:red;
					} else {
						return '<span style="text-align:left;">已关联</span>';
					}
				}},
				{title:'操作', name:'' ,width:80, align:'center', lockWidth:true, lockDisplay: true, renderer: function(val){
					var relateObj = '<a class="calss-link" href="#" title="关联设备"><span class="glyphicon glyphicon-link" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
					return relateObj;
				}}
			];
			var devicePg = $('#devicePg').mmPaginator({"limitList":[10]});
			tbAlarmEven = $('#tb_device_groups').mmGrid({
			height:408,
			cols:cols,
			url:"${ctx}/device/deviceInfo/list?projectCode="+projectCode,
			method:'post',
			remoteSort:true,
			sortName:'id',
			sortStatus:'desc',
			multiSelect:false,
			fullWidthRows:false,
			showBackboard:false,
			autoLoad:false,
			params:function(){
				data = {};
				var selectForm = getFormData("select-device-form");
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
				var inputDeviceName = $("#inputDeviceName").val();
				if (inputDeviceName != ""){
					$(data).attr({"deviceName": inputDeviceName});
				}
				if (relateStatus != "") {
					$(data).attr({"relateStatus": relateStatus});
				}
				if (relatePictureId != "") {
					$(data).attr({"relatePictureId": relatePictureId});
				}
				return data;
			},
			plugins:[devicePg]
		});
			tbAlarmEven.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
				if($(e.target).is('.calss-link') || $(e.target).is('.glyphicon-link')){
					e.stopPropagation();  //阻止事件冒泡
					relateDeviceId = item.id;
					relateDeviceName = item.deviceName;
					checkIsRelated(relatePictureId, relateDeviceId);
					if (checkResult) {
						showDialogModal("error-div","操作失败","该设备已关联");
						checkResult = false;
						return;
					}
					newCoordinate(item.id, item.deviceTypeId, item.deviceNumber, item.deviceName);
					showDialogModal("error-div","关联成功","关联成功");
// 					removeDiv("relate-device-modal");
				}
			}).on('loadSuccess',function(e,data){
				
			}).on('loadError',function(req, error, errObj) {
				
			}).load();
			$("#btn-query").on('click',function (){
				devicePg.load({"page":1});
				tbAlarmEven.load();
			});	
			
});
    
    function checkIsRelated(picId, deviceId) {
    	var checkTempDevice = checkMap.get(deviceId);
    	if (checkTempDevice != null) {
    		checkResult = true;
    		return;
    	}
    	$.ajax({
			type : "post",
			url : "${ctx}/device/coordinateManage/checkIsRelated?pictureId=" + picId + "&deviceId=" + deviceId,
			async : false,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.code == 0 && data.data) {
					checkResult = data.data;
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
</script>
</body>
</html>