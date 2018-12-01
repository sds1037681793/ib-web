<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<form id="role-form">
	<table id="role-form-table">
		<tr>
			<td align="right" width="100">角色名称：</td>
			<td>
				<input id="roleName" name="roleName" placeholder="角色名称" class="form-control required" type="text" style="width: 150px;" required />
				<input id="state" name="state" type="text" style="display: none;" />
				<input id="id" name="id" type="text" style="display: none;" />
			</td>
			<td align="right" width="100">生效时间：</td>
			<td>
				<input id="validDate" name="validDate" placeholder="生效时间" class="form-control required" type="text" style="width: 150px;" required readonly />
			</td>
		</tr>
		<tr>
			<td align="right" width="100">失效时间：</td>
			<td colspan="3">
				<input id="expireDate" name="expireDate" placeholder="失效时间" class="form-control required" type="text" style="width: 150px;" required readonly />
			</td>
		</tr>
	</table>
</form>
<div id="datetimepicker-div"></div>
<script>
  var dynamicRoleTableObj;
	$(document).ready(function() {
		if (rowEditing > -1) {
			var row = tbRoles.row(rowEditing);
			$('#id').val(row.id);
			$('#state').val(row.state);
			$('#roleName').val(row.roleName);
			$('#validDate').val(row.validDate.substr(0, 10));
			$('#expireDate').val(row.expireDate.substr(0, 10));
		} else {
			$("#validDate").val("${today}");
			$("#expireDate").val("2099-12-31");
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
		
		var roleId = $('#id').val();
		var jsonData = {
				"ownerType" : "126",
				"filter" : "1",
				"ownerId" : "" + roleId
			};
			$.ajax({
				type : "post",
				url : "${ctx}/param/getParamValue",
				data : "params=" + JSON.stringify(jsonData),
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						var datas = data.RETURN_PARAM;
						if (datas) {
							dynamicRoleTableObj = $("#role-form-table").dynamicTable({
								items : datas,
								method : "append",
								groupId : "role_attribute_group_id"
							});
						} else {
							if (dynamicRoleTableObj) {
								dynamicRoleTableObj.destroy();
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

	function updateRole() {
		var roleName = $("#roleName").val();
		if (roleName.length == 0) {
			showAlert('warning', '角色名称不能为空！', "roleName", 'top');
			$("#roleName").focus();
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

		// 组织提交数据（按com.rib.sec.entity.SecRole实体类构造）
		var roleData = getFormData("role-form");
		var result = {};
		result.id = roleData.id;
		result.validDate = roleData.validDate + " 00:00:00";
		result.expireDate = roleData.expireDate + " 00:00:00";
		result.state = roleData.state;
		result.roleName = roleData.roleName;
		saveRole(result, false);
	}
	
	
	//保存参数
	function saveParam(ownerId){
		var ownerType = "126";
		var filter = "1";
		if(!dynamicRoleTableObj){
			return true;
		}
		var formData = dynamicRoleTableObj.getFormData();
        $.ajax({
             type: "post",
             url: "${ctx}/param/saveParamValue?ownerType=" + ownerType + "&filter="+ filter + "&ownerId=" + ownerId,
             data:"params=" + JSON.stringify(formData),
             success: function(data) 
             {
            	 debugger;
                 if (data && data.CODE && data.CODE == "SUCCESS") {
                     return true;
                 } else {
                     showMsg(data.MESSAGE);
                     return false;
                 }
                 return true;
             },
             error: function(req,error,errObj) 
             {
                 showDialogModal("error-div","操作错误",errObj);
                 return;
             }
        });
	}
</script>