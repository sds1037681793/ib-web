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
			<td align="right" width="90">一级分类：</td>
		    <td>
				<input id="qcategory" class="form-control required" placeholder="一级分类" type="text" style="width:150px;" readonly="readonly"/>
			</td>
			<td align="right" width="90">二级分类：</td>
		    <td>
				<input id="qtypeName" class="form-control required" placeholder="二级分类" type="text" style="width:150px;" readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<td align="right" width="90">级别：</td>
			<td>
				<div id="level_type-dropdownlist"></div>
			</td>
		</tr>
	</table>
</form>
</div>

<script type="text/javascript">
var levelTypes;
var row;
// 设备类型
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
	
	
 	$("#one-scheme-dropdownlist").attr("disabled", "disabled");
	
	if('' != "${param.rowIndex}"){
		debugger;
		row = tbSecurityEven.row("${param.rowIndex}");
		$("#id").val(row.id);
		var level = row.level;
		if(level == 1){
			levelTypes.setData("高", 1, "");
		}else if(level == 2){
			levelTypes.setData("中", 2, "");
		}else{
			levelTypes.setData("低", 3, "");
		}
		
		$("#qcategory").val(row.categoryName);
		$("#qtypeName").val(row.typeName);
	} 
});


	function saveConfig() {
		debugger;
		var sercurityData ={};
		if(row!=null){
			sercurityData.defineId = row.id;
		}
		var from = getFormData("alarm-form");
		var level = from.levelTypeValue;
		sercurityData.level = level;
		$.ajax({
			type : "post",
			url : "${ctx}/system/securityIncident/saveSecurityDefine?",
			data: JSON.stringify(sercurityData),
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					tbSecurityEven.load();
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