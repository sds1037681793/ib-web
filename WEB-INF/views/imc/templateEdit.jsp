<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />

<form id="template-form">
	<table>
		<tr>
			<td align="right" width="100">模板编码：</td>
			<td>
				<input id="id" name="id" type="text" style="display: none;" />
				<input id="templateCode" name="templateCode" placeholder="模板编码" class="form-control required" type="text" style="width: 150px;" required />
			</td>
			<td align="right" width="100">所属平台：</td>
			<td>
				<div style="width: 30%">
					<div class="input-group">
						<input id="platformId" name="platformId" type="text" style="display: none;" />
						<input id="platformName" name="platformName" placeholder="所属平台" class="form-control" type="text" style="width: 117px;" readonly />
						<span class="input-group-btn" style="display: block">
							<button id="btn-select-platform" class="btn btn-default btn-input" type="button">+</button>
						</span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td align="right" width="100">模板扩展码：</td>
			<td colspan="3">
			<input id="extendCode" name="extendCode" placeholder="项目编号或者系统唯一号" class="form-control required" type="text" style="width: 460px;" required />
			</td>
		</tr>
		<tr>		
			<td align="right" width="100">模板内容：</td>
			<td colspan="3">
				<input id="templateContent" name="templateContent" placeholder="模板内容" class="form-control required" type="text" style="width: 460px;" required />
			</td>
		</tr>
		<tr>
			<td align="right" width="100">模板参数：</td>
			<td colspan="3">
				<input id="templateConfig" name="templateConfig" placeholder="模板参数" class="form-control required" type="text" style="width: 460px;" />
			</td>
		</tr>
		<tr>
			<td align="right" width="100">其他参数：</td>
			<td colspan="3">
				<input id="strategyConfig" name="strategyConfig" placeholder="其他参数" class="form-control required" type="text" style="width: 460px;" />
			</td>
		</tr>
	</table>
</form>
<script>
	$(document).ready(function() {
		if (rowEditing > -1) {
			var row = tbTemplates.row(rowEditing);
			$('#id').val(row.id);
			$('#platformId').val(row.platformId);
			$('#platformName').val(row.platformName);
			$('#templateCode').val(row.templateCode);
			$('#templateContent').val(row.templateContent);
			$('#templateConfig').val(row.templateConfig);
			$('#strategyConfig').val(row.strategyConfig);
			$('#extendCode').val(row.extendCode);
		}
		
		$("#btn-select-platform").on("click", function() {
			createModalWithLoad("platform-list", 650, 490, "平台选择", "platformManage/platform", "getPlatform()", "confirm-close");
			$("#platform-list-modal").modal('show');
		});
	});

	function receivePlatformInfo(platform){
		$('#platformId').val(platform.id);
		$('#platformName').val(platform.platformName);
		$("#platform-list-modal").modal('hide');

	}
</script>
