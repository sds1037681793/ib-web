<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<form id="oper-form">
	<table id="oper-form-table">
		<tr>
			<td align="right" width="100">员工姓名：</td>
			<td>
				<input id="staffId" name="staffId" type="text" style="display: none;" />
				<input id="staffName" name="staffName" placeholder="员工姓名" class="form-control required" type="text" style="width: 150px;" required />
			</td>
			<td align="right" width="100">登录名称：</td>
			<td>
				<input id="loginName" name="loginName" placeholder="登录名称" class="form-control required" type="text" style="width: 150px;" required />
				<input id="state" name="state" type="text" style="display: none;" />
				<input id="id" name="id" autocomplete="off" style="display: none;" />
			</td>
		</tr>
		<tr>
			<td align="right" width="100">登录密码：</td>
			<td>
				<input style="display: none" />
				<input id="plainPassword" name="plainPassword" type="password" autocomplete="off" placeholder="登录密码" class="form-control required" type="text" style="width: 150px;" required />
				<input id="password" name="password" type="text" style="display: none;" required />
			</td>
			<td align="right" width="100">确认密码：</td>
			<td>
				<input id="confirmPassword" name="confirmPassword" type="password" placeholder="确认密码" class="form-control required" type="text" style="width: 150px;" required />
				<input id="salt" name="salt" type="text" style="display: none;" required />
			</td>
		</tr>
		<tr>
			<td align="right" width="100">所属组织：</td>
			<td colspan="3">
				<div style="width: 30%">
					<div class="input-group">
						<input id="organizeId" name="organizeId" type="text" style="display: none;" />
						<input id="organize" name="organize" type="text" placeholder="所属组织" class="form-control required" type="text" style="width: 117px;" required readonly />
						<span class="input-group-btn">
							<button id="btn-select-org" class="btn btn-default btn-input" type="button" data-toggle="modal" data-target="#select-org-modal">+</button>
						</span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td align="right" width="100">生效时间：</td>
			<td>
				<input id="validDate" name="validDate" placeholder="生效时间" class="form-control required" type="text" style="width: 150px;" required />
			</td>
			<td align="right" width="100">失效时间：</td>
			<td>
				<input id="expireDate" name="expireDate" placeholder="失效时间" class="form-control required" type="text" style="width: 150px;" required />
			</td>
		</tr>
	</table>
</form>
<div id="datetimepicker-div"></div>
<script>
    
	var dynamicOperTableObj;
	$(document).ready(function() {
		if (rowEditing > -1) {
			var row = tbOpers.row(rowEditing);
			$('#id').val(row.id);
			$('#state').val(row.state);
			$('#loginName').val(row.loginName);
			$('#password').val(row.password);
			$('#salt').val(row.salt);
			$('#validDate').val(row.validDate.substr(0, 10));
			$('#expireDate').val(row.expireDate.substr(0, 10));
			if (row.secStaff && row.secStaff.staffName) {
				if (row.secStaff.secOrganize && row.secStaff.secOrganize.organizeName) {
					$('#organize').val(row.secStaff.secOrganize.organizeName);
					$('#organizeId').val(row.secStaff.secOrganize.id);
				} else {
					$('#organize').val('');
					$('#organizeId').val('');
				}
				$('#staffName').val(row.secStaff.staffName);
				$('#staffId').val(row.secStaff.id);
			} else {
				$('#staffName').val('');
				$('#staffId').val('');
			}
		} else {
			$("#validDate").val("${today}");
			$("#expireDate").val("2099-12-31");
			//火狐下新增情况下id被赋值为其他值，而不是默认的空字符串
			$("#id").val("");
		}
		$("#validDate").datetimepicker({
			id : 'datetimepicker-validDate',
			containerId : 'datetimepicker-div',
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'YYYY-mm-dd'
		});

		$("#expireDate").datetimepicker({
			id : 'datetimepicker-expireDate',
			containerId : 'datetimepicker-div',
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'YYYY-mm-dd'
		});
		$("#btn-select-org").on("click", function() {
			removeAllAlert();
			createModalWithIframe("select-org", 800, 550, "选择组织", "organizeSelect/tree");
		});

		var operateId = $('#id').val();
		var jsonData = {
			"ownerType" : "125",
			"filter" : "1",
			"ownerId" : "" + operateId
		};
		$.ajax({
			type : "post",
			url : "${ctx}/param/getParamValue",
			data : "params=" + JSON.stringify(jsonData),
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					var datas = data.RETURN_PARAM;
					if (datas) {
						dynamicOperTableObj = $("#oper-form-table").dynamicTable({
							items : datas,
							method : "append",
							groupId : "oper_attribute_group_id"
						});
					} else {
						if (dynamicOperTableObj) {
							dynamicOperTableObj.destroy();
						}
					}
					return;
				} else {
					showDialogModal("error-div", "操作错误", data.MESSAGE);
					return false;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "获取数据失败：" + errObj);
				return false;
			}
		});
	});

	function saveOperator() {
		var updatePassword = false;
		var staffName = $("#staffName").val();
		if (staffName.length == 0) {
			showAlert('warning', '员工姓名不能为空！', "staffName", 'top');
			$("#staffName").focus();
			return;
		}
		if (staffName.length > 30) {
			showAlert('warning', '员工姓名不能超过30个字符！', "staffName", 'top');
			$("#staffName").focus();
			return;
		}
		var loginName = $("#loginName").val();
		if (loginName.length == 0) {
			showAlert('warning', '登录名不能为空！', "loginName", 'top');
			$("#loginName").focus();
			return;
		}
		if (loginName.length > 30) {
			showAlert('warning', '登录名不能超过30个字符！', "loginName", 'top');
			$("#loginName").focus();
			return;
		}
		var password = $("#plainPassword").val();
		var id = $("#id").val();
		if (id.length == 0 && password.length == 0) {
			showAlert('warning', '密码不能为空！', "plainPassword", 'top');
			$("#plainPassword").focus();
			return;
		}
		var confirmPassword = $("#confirmPassword").val();
		if (password.length != 0 && confirmPassword.length == 0) {
			showAlert('warning', '确认密码不能为空！', "confirmPassword", 'top');
			$("#confirmPassword").focus();
			return;
		}
		if (password.length != 0 && confirmPassword.length != 0) {
			if (password != confirmPassword) {
				showAlert('warning', '确认密码不一样！', "confirmPassword", 'top');
				$("#confirmPassword").focus();
				return;
			}
		}
		var organize = $("#organize").val();
		if (organize.length == 0) {
			showAlert('warning', '所属组织不能为空！', "organize", 'top');
			$("#organize").focus();
			return;
		}
		var validDate = $("#validDate").val();
		if (validDate.length == 0) {
			showAlert('warning', '生效时间不能为空！', "validDate", 'top');
			$("#validDate").focus();
			return;
		}
		var expireDate = $("#expireDate").val();
		if (expireDate.length == 0) {
			showAlert('warning', '失效时间不能为空！', "expireDate", 'top');
			$("#expireDate").focus();
			return;
		}
		if (expireDate < validDate) {
			showAlert('warning', '失效时间不能小于生效时间！', "expireDate", 'top');
			$("#expireDate").focus();
			return;
		}
		//组织提交数据（按照com.rib.entity.SecOperator实体类构造） 
		var operData = getFormData("oper-form");
		var staffName = operData.staffName;
		var staffId = operData.staffId;
		var state = operData.state;
		var organize = operData.organize;
		var organizeId = operData.organizeId;
		if (password.length != 0) {
			operData.password = operData.plainPassword;
			updatePassword = true;
		}
		operData.validDate = operData.validDate + " 00:00:00";
		operData.expireDate = operData.expireDate + " 00:00:00";
		delete operData.confirmPassword;
		delete operData.staffName;
		delete operData.staffId;
		delete operData.state;
		delete operData.organize;
		delete operData.organizeId;
		delete operData.plainPassword;

		if (staffId.length != 0 && organize.length != 0) {
			$(operData).attr({
				"secStaff" : {
					"id" : staffId,
					"staffName" : staffName,
					"state" : 1,
					"secOrganize" : {
						"id" : organizeId,
						"organizeName" : organize
					}
				}
			});
		} else {
			if (staffId.length == 0 && organizeId.length != 0) {
				$(operData).attr({
					"secStaff" : {
						"staffName" : staffName,
						"state" : 1,
						"secOrganize" : {
							"id" : organizeId,
							"organizeName" : organize
						}
					}
				});
			}
		}
		saveOper(operData, false, updatePassword);
	}
	//保存参数
	function saveOperatorParam(ownerId) {
		var ownerType = "125";
		var filter = "1";
		if(!dynamicOperTableObj){
			return true;
		}
		var formData = dynamicOperTableObj.getFormData();
		$.ajax({
			type : "post",
			url : "${ctx}/param/saveParamValue?ownerType=" + ownerType + "&filter=" + filter + "&ownerId=" + ownerId,
			data : "params=" + JSON.stringify(formData),
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					return true;
				} else {
					showMsg(data.MESSAGE);
					return false;
				}
				return true;
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}
</script>
