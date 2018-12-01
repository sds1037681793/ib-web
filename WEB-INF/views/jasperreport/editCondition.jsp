<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<form id="condition-form-edit">
	<table id="condition-form-table">
		<tr>
			<td align="right" width="100">字段名称：</td>
			<td>
				<input id="paramName" name="paramName" placeholder="参数名称" class="form-control required" type="text" style="width: 150px;" required />
			</td>
			<td align="right" width="100">字段编码：</td>
			<td>
				<input id="paramCode" name="paramCode" placeholder="参数编码" class="form-control required" type="text" style="width: 150px;" required />
				<input id="conditionId" name="conditionId" type="text" style="display: none;" />
				<input id="bsReportId" name="bsReportId" type="text" style="display: none;" />
				<input id="bsElementDefineId" name="bsElementDefineId" type="text" style="display: none;" />
			</td>
			<td align="right" width="100">默认值：</td>
			<td>
				<input id="defaultValue" name="defaultValue" placeholder="默认值" class="form-control required" type="text" style="width: 150px;" required />
			</td>
		</tr>
		<tr>
			<td align="right" width="100">显示样式：</td>
			<td>
				<div id="displayStyle-dropdownlist" style="width: 150px;"></div>
			</td>
			<td align="right" width="100">数据类型：</td>
			<td>
				<div id="dataType-dropdownlist" style="width: 150px;"></div>
			</td>
			<td align="right" width="100">排序顺序：</td>
			<td>
				<input id="sort" name="sort" placeholder="排序顺序" class="form-control required" type="text" style="width: 150px;" required />
			</td>
		</tr>
		<tr>
			<td align="right" width="100">条件运算：</td>
			<td>
				<div id="condition-dropdownlist" style="width: 150px;"></div>
			</td>
			<td align="right" width="100">开始/结束时间：</td>
			<td colspan="3">
				<div id="startOrEnd-dropdownlist" style="width: 150px;"></div>
			</td>
		</tr>
		<tr>
			<td align="right" width="100">数据来源：</td>
			<td colspan="5">
				<div id="displayDealClass-dropdownlist" style="width: 150px;"></div>
			</td>
		</tr>
		<tr>
			<td align="right" width="100">数据配置：</td>
			<td colspan="5">
				<textarea rows="5" cols="20" id="displayDealData" name="displayDealData" placeholder="数据配置" class="form-control required" style="width: 690px; border-radius: 0px;" required></textarea>
			</td>
		</tr>
		<tr>
			<td align="right" width="100">展示样式：</td>
			<td colspan="5">
				<textarea rows="5" cols="20" id="styles" name="styles" placeholder="展示样式" class="form-control required" style="width: 690px; border-radius: 0px;" required></textarea>
			</td>
		</tr>
		<tr>
			<td align="right" width="100">事件配置：</td>
			<td colspan="5">
				<textarea rows="5" cols="20" id="events" name="events" placeholder="事件配置" class="form-control required" style="width: 690px; border-radius: 0px;" required></textarea>
			</td>
		</tr>
		<tr>
			<td align="right" width="100">描述：</td>
			<td colspan="5">
				<textarea rows="5" cols="20" id="description" name="description" placeholder="描述" class="form-control required" style="width: 690px; border-radius: 0px;" required></textarea>
			</td>
		</tr>
	</table>
</form>
<script>
	var ddlDisplayStyle = null;
	var ddlDataType = null;
	var ddlStartOrEnd = null;
	$(document).ready(function() {
		ddlStartOrEnd = $("#startOrEnd-dropdownlist").dropDownList({
			inputName : 'startOrEndName',
			inputValName : 'startOrEnd',
			buttonText : "",
			width : "120px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
			},
			items : startOrEndItem
		});
		ddlStartOrEnd.disable();
		ddlStartOrEnd.setData("", "", "");

		ddlDisplayStyle = $("#displayStyle-dropdownlist").dropDownList({
			inputName : 'displayStyleName',
			inputValName : 'displayStyle',
			buttonText : "",
			width : "120px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
				if (data == 8) {
					ddlStartOrEnd.enable();
				} else {
					ddlStartOrEnd.setData("", "", "");
					ddlStartOrEnd.disable();
				}
			},
			items : displayStyleItem
		});
		ddlDataType = $("#dataType-dropdownlist").dropDownList({
			inputName : 'dataTypeName',
			inputValName : 'dataType',
			buttonText : "",
			width : "120px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
			},
			items : dataTypeItem
		});

		ddlCondition = $("#condition-dropdownlist").dropDownList({
			inputName : 'conditionName',
			inputValName : 'condition',
			buttonText : "",
			width : "120px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
			},
			items : conditionItem
		});

		ddlDisplayDealClass = $("#displayDealClass-dropdownlist").dropDownList({
			inputName : 'displayDealClassName',
			inputValName : 'displayDealClass',
			buttonText : "",
			width : "120px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
			},
			items : displayDealClassItem
		});

		if (rowEditingCondition > -1) {
			var row = tbConditions.row(rowEditingCondition);
			$("#bsReportId").val(row.bsReportId);
			$("#conditionId").val(row.conditionId);
			$("#bsElementDefineId").val(row.bsElementDefineId);
			ddlCondition.setData(conditionMap.get(row.condition), row.condition, "");
			//$("#condition").val(row.condition);
			ddlStartOrEnd.setData(startOrEndMap.get(row.startOrEnd), row.startOrEnd, "");
			//$("#startOrEnd").val(row.startOrEnd);
			$("#paramCode").val(row.paramCode);
			$("#paramName").val(row.paramName);
			$("#defaultValue").val(row.defaultValue);
			$("#description").val(row.description);
			ddlDisplayStyle.setData(displayStyleMap.get(row.displayStyle), row.displayStyle, "");
			if (row.displayStyle == 8) {
				ddlStartOrEnd.enable();
			}
			//$("#displayStyle").val(row.displayStyle);
			$("#displayDealClass").val(row.displayDealClass);
			$("#displayDealData").val(row.displayDealData);
			ddlDataType.setData(dataTypeMap.get(row.dataType), row.dataType, "");
			//$("#dataType").val(row.dataType);
			$("#sort").val(row.sort);
			$("#styles").val(row.styles);
			$("#events").val(row.events);
		} else {
			$("#bsReportId").val(tbReports.row(rowEditingReport).id);
		}
	});

	function showEditAlert(type, content, name, position) {
		showAlert(type, content, name, position);
		$("#" + name).focus();
	}

	function saveCondition() {
		var conditionData = getFormData("condition-form-edit");
		delete conditionData["displayStyleName"];
		delete conditionData["dataTypeName"];
		delete conditionData["conditionName"];
		delete conditionData["startOrEndName"];
		delete conditionData["displayDealClassName"];
		var displayStyle = conditionData.displayStyle;
		var startOrEnd = conditionData.startOrEnd;
		if (displayStyle == 8 && startOrEnd.length == 0) {
			showEditAlert('warning', '请选择时间类型！', "startOrEndName", 'top');
			return;
		}

		var paramName = conditionData.paramName;
		if (paramName.length == 0) {
			showEditAlert('warning', '参数名称不能为空！', "paramName", 'top');
			return;
		}
		var paramCode = conditionData.paramCode;
		if (paramCode.length == 0) {
			showEditAlert('warning', '参数编码不能为空！', "paramCode", 'top');
			return;
		}
		var pattern = new RegExp("^-?\\d+$");
		var sort = conditionData.sort;
		if (sort.length == 0) {
			showEditAlert('warning', '排序不能为空！', "sort", 'top');
			return;
		}
		if (!pattern.test(sort)) {
			showEditAlert('warning', '请输入整数！', "sort", 'top');
			return;
		}

		$.ajax({
			type : "post",
			url : "${ctx}/reportConfig/createCondition",
			data : JSON.stringify(conditionData),
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					tbConditions.load();
					$("#edit-condition-modal").modal('hide');
					return;
				} else {
					showAlert('warning', data.MESSAGE, "save", 'top');
					return;
				}
			},
			error : function(req, error, errObj) {
				showAlert('warning', '提交失败：' + errObj, "save", 'top');
				return;
			}
		});

	}
</script>