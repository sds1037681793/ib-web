<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div>
 <form id="alarm-form">
	<table>
		<tr>
			<td align="right" width="90">设备编号：</td>
			<td>
				<input id="deviceNum" class="form-control required" placeholder="设备编号" type="text" style="width:150px;" readonly="readonly"/>
				<input id="id" type="text" style="display:none;"/>
			</td>
			<td align="right" width="90">设备名称：</td>
			<td>
				<input id="deviceNames" class="form-control required" placeholder="设备名称" type="text" style="width:150px;"/>
			</td>
		</tr>
		<tr>
			<td align="right" width="90">一级分类：</td>
		    <td>
				<div id="ones-scheme-dropdownlist"></div>
			</td>
			<td align="right" width="90">二级分类：</td>
		    <td>
				<div id="twos-scheme-dropdownlist"></div>
			</td>
		</tr>
		<tr>
			<td align="right" width="90">设备类型：</td>
			<td>
				<div id="threes-scheme-dropdownlist"></div>
			</td>
			<td align="right" width="90">位置：</td>
			<td>
				<input id="locationNames" class="form-control required" placeholder="位置" type="text" style="width:150px;" readonly="readonly"/>
			</td>
		</tr>
	</table>
</form>
</div>

<script type="text/javascript">
var levelTypes;
//一级分类
var levelTypeLists = new Array();
var levelTypeMapss = new HashMap();
var levelTypeObjs;

// 二级分类
var levelTwoTypeLists = new Array();
var levelTwoTypeMapss = new HashMap();
var levelTwoTypeObjs;

// 设备类型
var levelThreeTypeLists = new Array();
var levelThreeTypeMapss = new HashMap();
var levelThreeTypeObjs;
$(document).ready(function(){
	
	//获取配置的一级分类
	$.ajax({
		type: "post",
		url: "${ctx}/device/deviceInfo/listDeviceLevel?category="+1,
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null && data.length > 0) {
				$(eval(data)).each(function(){
					levelTypeMapss.put(this.itemData,this.itemText);
					levelTypeLists[levelTypeLists.length] = {itemText: this.itemText, itemData: this.itemData};
				});
				// 设置用户类型下拉列表
				levelTypeObjs = $("#ones-scheme-dropdownlist").dropDownList({
					inputName: "levelTypeNames",
					inputValName: "levelTypes",
					buttonText: "",
					width: "150px",
					readOnly: true,
					required: true,
					maxHeight: 200,
					onSelect: function(i, data, icon) {},
					items: levelTypeLists
				});
			}
		},
		error: function(req, error, errObj) {
		}
	});
	
	//获取配置的二级分类
	$.ajax({
		type: "post",
		url: "${ctx}/device/deviceInfo/listDeviceLevel?category="+2,
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null && data.length > 0) {
				$(eval(data)).each(function(){
					levelTwoTypeMapss.put(this.itemData,this.itemText);
					levelTwoTypeLists[levelTwoTypeLists.length] = {itemText: this.itemText, itemData: this.itemData};
				});
				// 设置用户类型下拉列表
				levelTwoTypeObjs = $("#twos-scheme-dropdownlist").dropDownList({
					inputName: "levelTwoTypeNames",
					inputValName: "levelTwoTypes",
					buttonText: "",
					width: "150px",
					readOnly: true,
					required: true,
					maxHeight: 200,
					onSelect: function(i, data, icon) {},
					items: levelTwoTypeLists
				});
			}
		},
		error: function(req, error, errObj) {
		}
	});
	
	
	//获取配置的设备类型
	$.ajax({
		type: "get",
		url: "${ctx}/device/deviceInfo/listDeviceType?parentId="+0,
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null && data.length > 0) {
				$(eval(data)).each(function(){
					levelThreeTypeMapss.put(this.itemData,this.itemText);
					levelThreeTypeLists[levelThreeTypeLists.length] = {itemText: this.itemText, itemData: this.itemData};
				});
				// 设置用户类型下拉列表
				levelThreeTypeObjs = $("#threes-scheme-dropdownlist").dropDownList({
					inputName: "levelThreeTypeNames",
					inputValName: "levelThreeTypes",
					buttonText: "",
					width: "150px",
					readOnly: true,
					required: true,
					maxHeight: 200,
					onSelect: function(i, data, icon) {},
					items: levelThreeTypeLists
				});
			}
		},
		error: function(req, error, errObj) {
		}
	});
	if('' != "${param.rowIndex}"){
		var row = tbAlarmEven.row("${param.rowIndex}");
		$("#id").val(row.id);
		$("#deviceNum").val(row.deviceNumber);
		$("#deviceNames").val(row.deviceName);
		$("#locationNames").val(row.locationName);
		
	    var levelType = levelTypeMaps.get(row.deviceSysId);
	    levelTypeObjs.setData(levelType ,row.deviceSysId, "");
	    
	    var levelTwoType = levelTwoTypeMaps.get(row.deviceSubId);
	    levelTwoTypeObjs.setData(levelTwoType ,row.deviceSubId, "");
	    
	    var levelThreeType = levelThreeTypeMaps.get(row.deviceTypeId);
	    levelThreeTypeObjs.setData(levelThreeType ,row.deviceTypeId, "");
	} 
});


	function saveConfig() {
		var from = getFormData("alarm-form");
		var id = $("#id").val();
		var deviceName =$("#deviceNames").val();
		$.ajax({
			type : "post",
			url : "${ctx}/device/deviceInfo/update?id="+id+"&deviceName="+deviceName,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					tbAlarmEven.load();
					$("#rest-config-edit-modal").modal("hide");
					showDialogModal("error-div", "操作成功", "操作成功");
					return true;
				} else {
					showAlert('warning', data.MESSAGE,
							"rest-config-edit-button-confirm", 'top');
					return false;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}
	
</script>