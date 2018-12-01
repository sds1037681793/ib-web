<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<body>
	<div class="content-default">
		<form id="select-form">
			<table>
				<tr>
					<td align="right" width="114">开始时间：</td>
					<td>
						<input id="startDate" name="startDate" placeholder="开始时间" class="form-control required" type="text" style="width: 150px" />
					</td>
					<td align="right" width="80">结束时间：</td>
					<td>
						<input id="endDate" name="endDate" placeholder="结束时间" class="form-control required" type="text" style="width: 150px" />
					</td>
					<td align="right" width="80">处理结果：</td>
					<td>
						<div id="dealState-dropdownlist"></div>
					</td>
					<td>
						<button id="btn-query-role" type="button" class="btn btn-default btn-common" style="margin-left: 50px;">查询</button>
					<!-- 	<button id="btn-add-role" type="button" class="btn btn-default btn-common">新增</button> -->
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb-ftpfiles" class="tb-roles" style="border: 1px solid; height: 99%; width: 96%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<div id="datetimepicker-div"></div>
	<div id="select-role-function"></div>
	<div id="ext-operation-div"></div>
	<div id="error-div"></div>
	<script>
		var tbFtpfiles;
		var pg;
		var rowEditing = -1;
		$(document).ready(function() {
			// 用户类型列表
			dealStateDropdownlist = $("#dealState-dropdownlist").dropDownList({
				inputName : "dealState",
				inputValName : "dealStateId",
				buttonText : "",
				width : "116px",
				readOnly : false,
				required : false,
				maxHeight : 200,
				onSelect : function(i, data, icon) {
				},
				items : [
						{
							itemText : '请选择',
							itemData : ''
						}, {
							itemText : '处理中',
							itemData : '1'
						}, {
							itemText : '成功',
							itemData : '2'
						}, {
							itemText : '失败',
							itemData : '3'
						}, {
							itemText : '定时删除中',
							itemData : '4'
						}, {
							itemText : '已删除',
							itemData : '5'
						}
				]
			});
			dealStateDropdownlist.setData("请选择","","");
			
			$("#startDate").datetimepicker({
				id: 'datetimepicker-startDate',
				containerId: 'datetimepicker-div',
				lang: 'ch',
				timepicker: true,
				hours12:false,
				allowBlank:true,
				format: 'Y-m-d H:i:s',
			    formatDate: 'YYYY-mm-dd hh:mm:ss'
			});
			$("#endDate").datetimepicker({
				id: 'datetimepicker-endDate',
				containerId: 'datetimepicker-div',
				lang: 'ch',
				timepicker: true,
				hours12:false,
				allowBlank:true,
				format: 'Y-m-d H:i:s',
			    formatDate: 'YYYY-mm-dd hh:mm:ss'
			});

			var operations = "";
			var operations = createGridOperation({
				ctx : "${ctx}",
				gridCode : "ROLE_MANAGE"
			});

			var cols = [
					{
						title : '源路径',
						name : 'resourcePath',
						width : 100,
						sortable : true,
						align : 'left'
					}, {
						title : 'ftp路径',
						name : 'ftpPath',
						width : 100,
						sortable : true,
						align : 'left'
					}, {
						title : '是否清除本地文件',
						name : 'isClean',
						width : 100,
						sortable : true,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item.isClean != undefined) {
								if (item.isClean == "0") {
									return "否";
								} else {
									return "是";
								}

							} else {
								return "";
							}
						}
					}, {
						title : '创建时间',
						name : 'createTime',
						width : 200,
						sortable : true,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item.createTime != undefined && item.createTime.length > 0) {
								return item.createTime.substr(0, 19);
							} else {
								return "";
							}
						}
					}, {
						title : '处理结果',
						name : 'dealState',
						width : 200,
						sortable : true,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.dealState == 1) {
								return "处理中";
							} else if (item && item.dealState == 2) {
								return "成功";
							} else if (item && item.dealState == 3) {
								return "失败";
							} else if (item && item.dealState == 4) {
								return "定时删除中";
							} else if (item && item.dealState == 5) {
								return "已删除";
							}
						}
					}, {
						title : '失败原因',
						name : 'failureReason',
						width : 200,
						sortable : true,
						align : 'left'
					}/* , {
						title : '操作',
						name : 'operate',
						width : 150,
						sortable : false,
						align : 'center',
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
					} */
			];

			pg = $('#pg').mmPaginator({
				"limitList" : [
					10
				]
			});
			tbFtpfiles = $('#tb-ftpfiles').mmGrid({
				height : 400,
				cols : cols,
				url : '${ctx}/ftpUploadManage/list',
				method : 'get',
				remoteSort : true,
				sortName : 'id',
				sortStatus : 'desc',
				multiSelect : false,
				checkCol : false,
				fullWidthRows : true,
				autoLoad : true,
				nowrap : true,
				showBackboard : false,
				params : function() {
					var selectForm = getFormData("select-form");
					var data = {};
				    var dealState = $("#dealStateId").val();
					if (dealState != "" && dealState != undefined){
						$(data).attr({"dealState": dealState});
					}
					var startDate = selectForm.startDate.trim();
					if (startDate != "" && startDate != undefined){
						$(data).attr({"queryStartDate": startDate});
					}
					var endDate = selectForm.endDate.trim();
					if (endDate != "" && endDate != undefined){
						$(data).attr({"queryEndDate": endDate});
					}
					return data;
				},
				plugins : [
					pg
				]
			});

			tbFtpfiles.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
					// 修改按钮事件
					rowEditing = rowIndex;

					createModalWithLoad("edit-role", 650, 0, "修改角色", "roleManage/edit", "updateRole()", "confirm-close", "");
					$("#edit-role-modal").modal('show');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
					// 删除按钮事件
					var row = tbRoles.row(rowIndex);
					showDialogModal("error-div", "操作提示", "确实要删除【" + row.roleName + "】吗？", 2, "deleteRole(" + rowIndex + ");");
				} else if ($(e.target).is('.class-role-function') || $(e.target).is('.glyphicon-list-alt')) {
					// 角色权限事件
					var row = tbRoles.row(rowIndex);
					removeAllAlert();
					createModalWithIframe("select-role-function", 600, 420, "选择菜单权限", "roleFunctionManage?roleId=" + row.id, "saveRoleFunctions(" + rowIndex + ")", "confirm-close");
					$("#select-role-function-modal").modal('show');
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
				createModalWithLoad("edit-role", 650, 0, "新增角色", "roleManage/edit", "updateRole()", "confirm-close");
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
			tbFtpfiles.load();
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

		function saveRoleFunctions(rowIndex) {
			var row = tbRoles.row(rowIndex);
			var roleData = row;
			roleData.validDate = roleData.validDate + " 00:00:00";
			roleData.expireDate = roleData.expireDate + " 00:00:00";
			var funcs = $("#select-role-function-iframe")[0].contentWindow.getAllSelectedFunctionsStr();
			$.ajax({
				type : "get",
				url : "${ctx}/roleManage/saveFunctions?funcsStr=" + funcs + "&roleId=" + roleData.id,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						loadGrid();
						$("#edit-role-modal").modal('hide');
						$("#select-role-function-modal").modal('hide');
						return true;
					} else {
						showAlert('warning', data.MESSAGE, "btn-save", 'top');
						$("#select-role-function-modal").modal('hide');
						return false;
					}
				},
				error : function(req, error, errObj) {
					showAlert('warning', '提交失败：' + errObj, "btn-save", 'top');
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
	</script>
</body>
</html>