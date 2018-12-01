<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div>
	<form id="data-edit">
		<table>
			<tr>
				<td align="right" width="100">编码：</td>
				<td>
					<input id="code" name="code" placeholder="编码" class="form-control required" type="text" style="width: 150px;" required />
				</td>
				<td align="right" width="100">显示名称：</td>
				<td>
					<input id="name" name="name" placeholder="名称" class="form-control required" type="text" style="width: 150px;" required />
					<input id="state" name="state" type="text" style="display: none;" />
					<input id="id" name="id" type="text" style="display: none;" />
					<input id="typeId" name="typeId" type="text" style="display: none;" />
				</td>
			</tr>
			<tr>
				<td align="right" width="100">值：</td>
				<td>
					<input id="value" name="value" class="form-control required" type="text" style="width: 150px;" required />
				</td>
				<td align="right" width="100">描述：</td>
				<td>
					<input id="description" name="description" placeholder="描述" class="form-control required" type="text" style="width: 150px;" required />
				</td>
			</tr>
			<tr>
				<td align="right" width="100">排序编号：</td>
				<td>
					<input id="sort" name="sort" placeholder="排序编号" class="form-control required" type="text" style="width: 150px;" required />
				</td>
			</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		debugger;
		dataTypeCode = $('#dataTypeCode').val();
		$('#typeId').val(dropDownListDataTypes.get(dataTypeCode).id);
		if ('${param.rowIndex}' != -1) {
			var row = tbData.row('${param.rowIndex}');
			$('#code').val(row.code);
			$('#state').val(row.state);
			$('#name').val(row.name);
			$('#id').val(row.id);
			$('#value').val(row.value);
			$('#description').val(row.description);
			$('#sort').val(row.sort);
			if(typeLevel == 1){
				$('#value').attr("readonly", "readonly");
				$('#name').attr("readonly", "readonly");
				$('#code').attr("readonly", "readonly");
				$('#description').attr("readonly", "readonly");
				$('#sort').attr("readonly", "readonly");
			}
		}
	});
	function saveData() {
		var staticData = getFormData("data-edit");
		var code = $.trim(staticData.code);
		if (code.length == 0) {
			showAlert('warning', '编码不能为空！', "code", 'top');
			return;
		}
		staticData.code = code;
		var name = $.trim(staticData.name);
		if (name.length == 0) {
			showAlert('warning', '名称不能为空！', "name", 'top');
			return;
		}
		staticData.name = name;
		var value = $.trim(staticData.value);
		if (value.length == 0) {
			showAlert('warning', '值不能为空！', "value", 'top');
			return;
		}
		staticData.value = value;
		var description = staticData.description;
		if (description.length == 0) {
			showAlert('warning', '描述不能为空！', "description", 'top');
			return;
		}
		var sort = staticData.sort;
		if (sort.length == 0) {
			showAlert('warning', '排序不能为空！', "sort", 'top');
			return;
		}
		if (isNaN(sort)) {
			showAlert('warning', '请输入数字！', "sort", 'top');
			return;
		}
		$(staticData).attr({
			staticType : {
				id : staticData.typeId
			}
		})
		delete staticData.typeId;
		$.ajax({
			type : "post",
			url : "${ctx}/staticData/create",
			data : JSON.stringify(staticData),
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					tbData.load();
					$("#edit-data-modal").modal('hide');
					return true;
				} else {
					showAlert('warning', data.MESSAGE, "edit-data-button-confirm", 'top');
					return false;
				}
			},
			error : function(req, error, errObj) {
				showAlert('warning', '提交失败：' + errObj, "edit-data-button-confirm", 'top');
				return false;
			}
		});
	}
</script>