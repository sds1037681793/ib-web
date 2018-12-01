<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<table>
	<tr>
		<td align="right">执行代码: </td>
		<td>
			<input id="code" name="code" value="" class="form-control" style="width: 740px; float: left; margin-right: 5px;"/><button id="call" type="button" onclick="javascript: call();" class="btn btn-default">执行</button>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top" style="margin-top: 5px;">执行结果: </td>
		<td><textarea id="result" name="result" rows="40" class="form-control" style="width: 800px"></textarea></td>
	</tr>
</table>

<script>
	function call() {
		var code = $("#code").val();
		$("#result").val("");
		if (!code || code.length <= 0) {
			showAlert('warning', '请输入待执行的代码！', "call", 'bottom');
			return;
		}
		$.ajax({
			type: "post",
			url: "${ctx}/common/execMethod?byExpose=false&code=" + code,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				$("#result").val(data);
			},
			error: function(req, error, errObj) {

			}
		});
	}
</script>