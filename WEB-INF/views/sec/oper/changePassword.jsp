<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div style="margin-left: 40px;">
	<table>
		<tr>
			<td align="right">当前密码：</td>
			<td>
				<input id="password" type="password" placeholder="当前密码" style="width: 150px;" class="form-control required" />
			</td>
		</tr>
		<tr>
			<td align="right">新密码：</td>
			<td>
				<input id="newPassword" type="password" placeholder="新密码" style="width: 150px" class="form-control required" />
			</td>
		</tr>
		<tr>
			<td align="right">确认密码：</td>
			<td>
				<input id="newPasswordRe" type="password" placeholder="确认密码" style="width: 150px;" class="form-control required" />
			</td>
		</tr>
	</table>
</div>
<script type="text/javascript">
	function updatePassword() {
		var password = $('#password').val();
		var newPassword = $('#newPassword').val();
		var newPasswordRe = $('#newPasswordRe').val();
		if (password.length == 0) {
			showAlert('warning', '密码不能为空！', "password", 'top');
			$("#password").focus();
			return;
		}
		if (newPassword.length == 0) {
			showAlert('warning', '新密码不能为空！', "newPassword", 'top');
			$("#newPassword").focus();
			return;
		}
		if (newPasswordRe.length == 0) {
			showAlert('warning', '确认密码不能为空！', "newPasswordRe", 'top');
			$("#newPasswordRe").focus();
			return;
		}
		if (password == newPassword) {
			showAlert('warning', '新密码不能与原密码相同！', "newPassword", 'top');
			$("#newPassword").focus();
			return;
		}
		if (newPasswordRe != newPassword) {
			showAlert('warning', '确认密码与新密码不一致！', "newPasswordRe", 'top');
			$("#newPasswordRe").focus();
			return;
		}
		var data = {
			"password" : encodeURI(password),
			"newPassword" : encodeURI(newPassword)
		};
		$.ajax({
			type : "post",
			url : "${ctx}/operatorManage/updatePassword",
			data : data,
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					$('#change-password-modal').modal('hide');
					showDialogModal("error-div", "操作成功", "密码修改成功！");
					return;
				} else {
					showAlert('warning', data.MESSAGE, "change-password-button-confirm", 'top');
					return;
				}
			},
			error : function(req, error, errObj) {
				showAlert('warning', "修改失败!", "change-password-button-confirm", 'top');
				return;
			}
		});
	}
</script>