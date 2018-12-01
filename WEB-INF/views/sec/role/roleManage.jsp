<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<body>
	<div class="content-default">
		<form>
			<table>
				<tr>
					<td align="right" width="90">角色名称：</td>
					<td>
						<input id="qRoleName" name="qRoleName" placeholder="角色名称" class="form-control required" type="text" style="width: 150px;" />
					</td>
					<td>
						<button id="btn-query-role" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 3rem;">
                        <p class="btniconimg"><span>查询</span></p>
                        </button>
						<button id="btn-add-role" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 2rem;">
                        <p class="btniconimgadd"><span>新增</span>
                        </button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb-roles" class="tb-roles" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<div id="edit-role"></div>
	<div id="select-org"></div>
	<div id="select-role-function"></div>
	<div id="ext-operation-div"></div>
	<div id="error-div"></div>
	<script>
		var tbRoles;
		var pg;
		var rowEditing = -1;
		$(document).ready(function() {

			var operations = "";
			var operations = createGridOperation({
				ctx : "${ctx}",
				gridCode : "ROLE_MANAGE"
			});

			var cols = [
					{
						title : '角色ID',
						name : 'id',
						width : 100,
						sortable : false,
						align : 'left'
					}, {
						title : '状态',
						name : 'state',
						width : 100,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '角色名称',
						name : 'roleName',
						width : 300,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							var span = jQuery('<span data-toggle="tooltip" data-placement="bottom">');
							span.attr("title", item.roleName);
							span.text(item.roleName);
							var html = jQuery('<div style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;"></div>');
							html.append(span);
							return html.html();
						}
					}, {
						title : '生效时间',
						name : 'validDate',
						width : 200,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item.validDate != undefined && item.validDate.length > 0) {
								return item.validDate.substr(0, 10);
							} else {
								return "";
							}
						}
					}, {
						title : '失效时间',
						name : 'expireDate',
						width : 200,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item.expireDate != undefined && item.expireDate.length > 0) {
								return item.expireDate.substr(0, 10);
							} else {
								return "";
							}
						}
					}, {
						title : '操作',
						name : 'operate',
						width : 150,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var roleFuncObj = '<a class="class-role-function" href="#" title="角色权限"><span class="glyphicon glyphicon-list-alt" style="font-size: 12px; color: #777;"></span></a>';
							var extOperations = "";
							if (operations) {
								$.each(operations, function(n, v) {
									extOperations += '<a class="' + v.aClass + '" href="#" title="' + v.title + '"><span class="' + v.spanClass + '" style="' + v.spanStyle + '"></span></a>';
								});
							}

							return modifyObj + deleteObj + roleFuncObj + extOperations;
						}
					}
			];

			pg = $('#pg').mmPaginator({
				"limitList" : [
					20
				]
			});
			tbRoles = $('#tb-roles').mmGrid({
				width:'99%',
				height : 776,
				cols : cols,
				url : '${ctx}/roleManage/list',
				method : 'get',
				remoteSort : false,
				multiSelect : false,
				checkCol : false,
				fullWidthRows : true,
				autoLoad : false,
				nowrap : false,
				showBackboard : false,
				params : function() {
					var roleName = $("#qRoleName").val();
					return {
						"roleName" : escape($.trim(roleName))
					};
				},
				plugins : [
					pg
				]
			});

			tbRoles.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
					// 修改按钮事件
					rowEditing = rowIndex;

					createModalWithLoad("edit-role", 650,260, "修改角色", "roleManage/edit", "updateRole()", "confirm-close", "");
					$("#edit-role-modal").modal('show');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
					// 删除按钮事件
					var row = tbRoles.row(rowIndex);
					showDialogModal("error-div", "操作提示", "确实要删除【" + row.roleName + "】吗？", 2, "deleteRole(" + rowIndex + ");");
				} else if ($(e.target).is('.class-role-function') || $(e.target).is('.glyphicon-list-alt')) {
					// 角色权限事件
					rowEditing = rowIndex;
					removeAllAlert();
					createModalWithIframe("select-org",
							800, 550, "选择组织",
							"organizeSelect/tree?expandAll=true");
					$("#select-org-modal").modal('show');
				} else {
					var row = tbRoles.row(rowIndex);
					createGridOperationEvent(e, operations, "ext-operation-div", rowIndex, row, "error-div");
				}
			}).on('loadSuccess', function(e, data) {
				rowEditing = -1;
			}).on('checkSelected', function(e, item, rowIndex) {

			}).on('checkDeselected', function(e, item, rowIndex) {

			}).load();

			$('#btn-add-role').on('click', function() {
				rowEditing = -1;
				createModalWithLoad("edit-role", 650, 260, "新增角色", "roleManage/edit", "updateRole()", "confirm-close");
				$("#edit-role-modal").modal('show');
			});

			$('#btn-query-role').on('click', function() {
				loadGrid();
			});
			
		});

		function loadGrid() {
			pg.load({
				"page" : 1
			});
			tbRoles.load();
		}

		function saveRole(roleData, updateRoleFunction) {
			$.ajax({
				type : "post",
				url : "${ctx}/roleManage/create?updateRoleFunction=" + updateRoleFunction,
				data : JSON.stringify(roleData),
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						var datas = data.RETURN_PARAM;
						saveParam(datas.roleId);
						loadGrid();
						$("#edit-role-modal").modal('hide');
						return true;
					} else {
						showAlert('warning', data.MESSAGE, "btn-save", 'top');
						return false;
					}
				},
				error : function(req, error, errObj) {
					showAlert('warning', '提交失败：' + errObj, "btn-save", 'top');
					return false;
				}
			});
			return true;
		}

		function saveRoleFunctions(rowIndex,organizeId) {
			var row = tbRoles.row(rowIndex);
			var roleData = row;
			roleData.validDate = roleData.validDate + " 00:00:00";
			roleData.expireDate = roleData.expireDate + " 00:00:00";
			var funcs = $("#select-role-function-iframe")[0].contentWindow.getAllSelectedFunctionsStr();
			$.ajax({
				type : "get",
				url : "${ctx}/roleFunction/saveFunctions?funcsStr="+funcs+"&roleId="+roleData.id + "&organizeId=" + organizeId,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						loadGrid();
						$("#edit-role-modal").modal('hide');
						$("#select-role-function-modal").modal('hide');
						return true;
					} else {
						showDialogModal("error-div", "操作错误", data.MESSAGE);
						$("#select-role-function-modal").modal('hide');
						return false;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					$("#select-role-function-modal").modal('hide');
					return false;
				}
			});
		}

		function deleteRole(rowIndex) {
			var row = tbRoles.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/roleManage/delete/" + row.id,
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						showDialogModal("error-div", "操作成功", "数据已删除！");
						loadGrid();
						return;
					} else {
						showDialogModal("error-div", "操作错误", data.MESSAGE);
						return;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		}
		
		function receiveOrganizeInfo(orgObj) {
			//$('#organize')[0].value = orgObj.organizeName;
			//$('#organizeId')[0].value = orgObj.id;
			if(orgObj.organizeType != 3){
				showDialogModal("error-div", "操作错误", "请选择项目！");
				return;
			}
			$("#select-org-modal").modal('hide');
			var row = tbRoles.row(rowEditing);
			createModalWithIframe("select-role-function", 600, 420, "选择菜单权限", "roleFunctionManage?roleId=" + row.id + "&organizeId=" + orgObj.id, "saveRoleFunctions(" + rowEditing + "," + orgObj.id +")", "confirm-close");
			$("#select-role-function-modal").modal('show');
		}
	</script>
</body>
</html>