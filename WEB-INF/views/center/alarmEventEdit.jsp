<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style>
#div-puv .mmg-head {
	background-color: #fff;
	color: #000;
	border-bottom: 1px solid #ccc;
}
</style>
<div>
 <form id="alarm-form">
	<table>
		<tr>
			<td align="right" width="90">事件编号：</td>
			<td>
				<input id="codes" class="form-control required" placeholder="事件编号" type="text" style="width:150px;" readonly="readonly"/>
				<input id="id" type="text" style="display:none;"/>
			</td>
			<td align="right" width="90">一级分类：</td>
		    <td>
				<div id="one-scheme-dropdownlist"></div>
			</td>
		</tr>
		<tr>
			<td align="right" width="90">二级分类：</td>
		    <td>
				<div id="two-scheme-dropdownlist"></div>
			</td>
			<td align="right" width="90">设备类型：</td>
			<td>
				<div id="three-scheme-dropdownlist"></div>
			</td>
		</tr>
		<tr>
			<td align="right" width="90">优先级：</td>
			<td>
				<div id="level_type-dropdownlist"></div>
			</td>
			<td align="right" width="90">事件描述：</td>
			<td>
				<input id="describes" class="form-control required" placeholder="事件描述" type="text" style="width:150px;" readonly="readonly"/>
			</td>
		</tr>
	</table>
</form>
</div>

<script type="text/javascript">
var levelTypes;
//一级分类
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
$(document).ready(function(){
	var levelList=[{itemText: "高", itemData: 1},{itemText: "中", itemData: 2},{itemText:"低",itemData: 3}];
	levelTypes = $("#level_type-dropdownlist").dropDownList({
			inputName : 'levelType',
			inputValName : 'levelTypeValue',
			buttonText : "",
			width : "115px",
			readOnly : false,
			required : true,
			maxHeight : 100,
			onSelect : function(i, data, icon) {
			},
			items : levelList
		});
	
	//获取配置的一级分类
	var code1 = "SYSTEM_FROM";
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
					readOnly: true,
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
					readOnly: true,
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
					readOnly: true,
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
	 
 	$("#one-scheme-dropdownlist").attr("disabled", "disabled");
	$("#two-scheme-dropdownlist").attr("disabled", "disabled");
	$("#three-scheme-dropdownlist").attr("disabled", "disabled");
	
	if('' != "${param.rowIndex}"){
		var row = tbAlarmEven.row("${param.rowIndex}");
		$("#codes").val(row.code);
		$("#id").val(row.id);
		$("#describes").val(row.describe);
		var level = row.level;
		if(level == 1){
			levelTypes.setData("高", 1, "");
		}else if(level == 2){
			levelTypes.setData("中", 2, "");
		}else{
			levelTypes.setData("低", 3, "");
		}
	    var levelType = levelTypeMaps.get(row.systemCode);
	    levelTypeObj.setData(levelType ,row.systemCode, "");
	    
	    var levelTwoType = levelTwoTypeMaps.get(row.subSystemCode);
	    levelTwoTypeObj.setData(levelTwoType ,row.subSystemCode, "");
	    
	    var levelThreeType = levelThreeTypeMaps.get(row.deviceTypeCode);
	    levelThreeTypeObj.setData(levelThreeType ,row.deviceTypeCode, "");
	} 
});


	function saveConfig() {
		var from = getFormData("alarm-form");
		var id = $("#id").val();
		var level = from.levelTypeValue;
		$.ajax({
			type : "post",
			url : "${ctx}/alarm-center/alarmEventDefine/update?id="+id+"&level="+level,
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