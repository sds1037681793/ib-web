<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<form id="report-form-edit">
	<table id="report-form-table">
		<tr>
			<td align="right" width="100">报表名称：</td>
			<td>
				<input id="reportName" name="reportName" placeholder="报表名称" class="form-control required" type="text" style="width: 150px;" required />
				<input id="id" name="id" type="text" style="display: none;" />
			</td>
			<td align="right" width="100">报表编码：</td>
			<td>
				<input id="reportCode" name="reportCode" placeholder="报表编码" class="form-control required" type="text" style="width: 150px;" required />
			</td>
			<td align="right" width="100">文件名称：</td>
			<td>
				<input id="fileName" name="fileName" placeholder="文件名称" class="form-control required" type="text" style="width: 150px;" required />
			</td>
		</tr>
		<tr>
			<td align="right" width="100">报表样式：</td>
			<td colspan="5">
				<textarea rows="5" cols="20" id="styles" name="styles" placeholder="报表样式" class="form-control required" style="width: 690px; border-radius: 0px;" required></textarea>
			</td>
		</tr>
		<tr>
			<td align="right" width="100">报表配置：</td>
			<td colspan="5">
				<textarea rows="5" cols="20" id="config" name="config" placeholder="报表配置" class="form-control required" style="width: 690px; border-radius: 0px;" required></textarea>
			</td>
		</tr>
	</table>
</form>
<script>
	$(document).ready(function() {

		if (rowEditingReport > -1) {
			var row = tbReports.row(rowEditingReport);

			$("#id").val(row.id);
			$("#reportName").val(row.reportName);
			$("#reportCode").val(row.reportCode);
			$("#fileName").val(row.fileName);
			$("#styles").val(row.styles);
			$("#config").val(row.config);
		}
	});

	function showEditAlert(type, content, name, position) {
		showAlert(type, content, name, position);
		$("#" + name).focus();
	}

	function saveReport() {
		var reportData = getFormData("report-form-edit");

		var reportName = reportData.reportName;
		if (reportName.length == 0) {
			showEditAlert('warning', '报表名称不能为空！', "reportName", 'top');
			return;
		}
		var reportCode = reportData.reportCode;
		if (reportCode.length == 0) {
			showEditAlert('warning', '报表编码不能为空！', "reportCode", 'top');
			return;
		}
		var fileName = reportData.fileName;
		if (fileName.length == 0) {
			showEditAlert('warning', '报表文件名不能为空！', "fileName", 'top');
			return;
		}

		$.ajax({
			type : "post",
			url : "${ctx}/reportConfig/createReport",
			data : JSON.stringify(reportData),
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					tbReports.load();
					$("#edit-report-modal").modal('hide');
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