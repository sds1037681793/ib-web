<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div>
	<form id="data-type-form">
		<table>
			<tr>
				<td align="right" width="100">编码：</td>
				<td>
					<input id="code" name="code" placeholder="编码" class="form-control required" type="text" style="width: 150px;" required />
				</td>
				<td align="right" width="100">名称：</td>
				<td>
					<input id="name" name="name" placeholder="名称" class="form-control required" type="text" style="width: 150px;" required />
					<input id="state" name="state" type="text" style="display: none;" />
					<input id="id" name="id" type="text" style="display: none;" />
					<input id="typeLevel" name="typeLevel" value="2" type="text" style="display: none;" />
				</td>
			</tr>
			<tr>
				<td align="right" width="100">描述：</td>
				<td colspan = "3">
					<input id="description" name="description" placeholder="描述" class="form-control required" type="text" style="width: 150px;" required />
				</td>
			</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		if ('${param.rowIndex}' == -1) {

		} else {
			var row = tbTypeData.row('${param.rowIndex}');
			$('#code').val(row.code);
			$('#state').val(row.state);
			$('#name').val(row.name);
			$('#id').val(row.id);
			$('#typeLevel').val(row.typeLevel);
			$('#description').val(row.description);
		}
	});
	function saveType() {
		var staticType = getFormData("data-type-form");
		var code = $.trim(staticType.code);
		if (code.length == 0) {
			showAlert('warning', '编码不能为空！', "code", 'top');
			return;
		}
		staticType.code = code;
		var name = $.trim(staticType.name);
		if (name.length == 0) {
			showAlert('warning', '名称不能为空！', "name", 'top');
			return;
		}
		staticType.name = name;
		var description = staticType.description;
		if (description.length == 0) {
			showAlert('warning', '描述不能为空！', "description", 'top');
			return;
		}
		$.ajax({
			type : "post",
			url : "${ctx}/staticData/createType",
			data : JSON.stringify(staticType),
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					tbTypeData.load();
					$("#edit-type-modal").modal('hide');
					return true;
				} else {
					showAlert('warning', data.MESSAGE, "edit-type-button-confirm", 'top');
					return false;
				}
			},
			error : function(req, error, errObj) {
				showAlert('warning', '提交失败：' + errObj, "edit-type-button-confirm", 'top');
				return false;
			}
		});
	}
</script>