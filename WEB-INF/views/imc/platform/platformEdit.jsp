<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<style>
<!--
-->

</style>
<form id="platform-form">
	<table>
		<tr>
			<td align="right" width="100">平台名称：</td>
			<td><input id="platformName" name="platformName"
				placeholder="平台名称" class="form-control required" type="text"
				style="width: 150px;" required /> <input id="state" name="state"
				type="text" style="display: none;" /> <input id="id" name="id"
				type="text" style="display: none;" /></td>
			<td align="right" width="100">平台编码：</td>
			<td><input id="platformCode" name="platformCode"
				placeholder="平台编码" class="form-control required" type="text"
				style="width: 150px;" required /></td>
		</tr>
		<tr>
			<td align="right" width="100">平台类型：</td>
			<td>
				<div id="platformType-dropdownlist"></div>
			</td>
			<td align="right" width="100">平台处理类：</td>
			<td><input id="dealClass" name="dealClass" placeholder="平台处理类"
				class="form-control required" type="text" style="width: 150px;"
				required /></td>
		</tr>
		<tr>
			<td align="right" width="100">备注：</td>
			<td colspan="3"><input id="platformComment"
				name="platformComment" placeholder="备注"
				class="form-control required" type="text" style="width: 420px;"
				required /></td>
		</tr>
		<tr>
			<td align="right" width="100">平台参数：</td>
			<td colspan="3"><textarea id="platformConfig"
					name="platformConfig" placeholder="平台参数"
					class="form-control required"
					style="width: 420px; height: 80px; resize: none;"></textarea></td>
		</tr>
	</table>
</form>
<div id="datetimepicker-div"></div>
<script>
	$(document).ready(
			function() {
				platformTypeCharge = $('#platformType-dropdownlist')
						.dropDownList({
							inputName : "platformTypeName",
							inputValName : "platformType",
							buttonText : "",
							width : "117px",
							readOnly : false,
							required : true,
							maxHeight : 200,
							onSelect : function(i, data, icon) {
							},
							items : platformTypeList
						});
				if (rowEditing > -1) {
					var row = tbPlatforms.row(rowEditing);
					$('#id').val(row.id);
					$('#state').val(row.state);
					$('#platformName').val(row.platformName);
					$('#platformCode').val(row.platformCode);
					$('#dealClass').val(row.dealClass);
					$('#platformComment').val(row.platformComment);
					$('#platformConfig').val(row.platformConfig);
					platformTypeCharge.setData(row.platformTypeName,
							row.platformType, "");
				} else {
					platformTypeCharge.setData(platformTypeList[0].itemText,
							platformTypeList[0].itemData, "");
				}

			});

	function updatePlatform() {
		var platformName = $("#platformName").val();
		if (platformName.length == 0) {
			showAlert('warning', '平台名称不能为空！', "platformName", 'top');
			$("#platformName").focus();
			return;
		}
		var platformCode = $("#platformCode").val();
		if (platformCode.length == 0) {
			showAlert('warning', '平台编码不能为空！', "platformCode", 'top');
			$("#platformCode").focus();
			return;
		}
		var dealClass = $("#dealClass").val();
		if (dealClass.length == 0) {
			showAlert('warning', '平台处理类不能为空！', "dealClass", 'top');
			$("#dealClass").focus();
			return;
		}
		var platformData = getFormData("platform-form");
		delete platformData.platformTypeName;
		savePlatform(platformData);
	}
</script>