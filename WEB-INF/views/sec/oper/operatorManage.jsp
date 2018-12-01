<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<body>
	<div class="content-default">
		<table id="queryParams">
			<tr>
				<td width="90" align="right">员工姓名：</td>
				<td><input id="search-staffName" type="text" placeholder="员工姓名"
					class="form-control required" style="width: 150px;" /></td>
				<td width="100" align="right">登录名称：</td>
				<td><input id="search-loginName" type="text" placeholder="登录名称"
					class="form-control required" style="width: 150px;" /></td>
				<td align="right" width="100">所属组织：</td>
				<td width="200">
					<div style="width: 30%">
						<div class="input-group">
							<input id="search-organizeId" name="organizeId" type="text"
								style="display: none;" /> <input id="search-organize"
								name="organize" type="text" placeholder="所属组织"
								class="form-control required" type="text" style="width: 117px;"
								required readonly /> <span class="input-group-btn">
								<button id="search-btn-select-org"
									class="btn btn-default btn-input" type="button"
									data-toggle="modal" data-target="#select-org-modal">+</button>
							</span>
						</div>
					</div>
				</td>
   	         <td>
          </td>
			</tr>
		</table>
	</div>
	<table id="tb_operators" class="tb_operators" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<div id="modal-roles" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">修改操作员角色</h4>
				</div>
				<div class="zTreeDemoBackground left" style="height: 150px; width: 100%; overflow-y: auto;">
					<div id="roles-lists" style="margin-top: 20px;"></div>
				</div>
				<div class="modal-footer">
					<a id="saveRoles" href="#" class="btn btn-primary btn-modal">保存</a>
					<a href="#" class="btn btn-modal" data-dismiss="modal">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<div id="edit-oper"></div>
	<div id="select-org"></div>
	<div id="ext-operation-div"></div>
	<div id="error-div"></div>
	<script type="text/javascript">
		var tbOpers;
		var operPaginator
		var rowEditing = -1;
		addQueryButtons();
		$(document).ready(function() {

			var operations = "";
			var operations = createGridOperation({
				ctx : "${ctx}",
				gridCode : "OPERATE_MANAGE"
			});

			var cols = [
					{
						title : '操作员ID',
										name : 'id',
										width : 100,
										sortable : false,
										align : 'left'
									},
									{
										title : '状态',
										name : 'state',
										width : 100,
										sortable : false,
										align : 'left',
										hidden : true
									},
									{
										title : '员工姓名',
										name : 'secStaff.staffName',
										width : 100,
										sortable : false,
										align : 'left',
										renderer : function(val, item, rowIndex) {
											if (item && item.secStaff) {
												return item.secStaff.staffName;
											}
										}
									},
									{
										title : '员工ID',
										name : 'staffId',
										width : 100,
										sortable : false,
										align : 'left',
										hidden : true,
										renderer : function(val, item, rowIndex) {
											if (item && item.secStaff) {
												return item.secStaff.id;
											}
										}
									},
									{
										title : '登录名称',
										name : 'loginName',
										width : 100,
										sortable : false,
										align : 'left'
									},
									{
										title : '登录密码',
										name : 'password',
										width : 200,
										sortable : false,
										align : 'left',
										hidden : true
									},
									{
										title : '确认密码',
										name : 'salt',
										width : 200,
										sortable : false,
										align : 'left',
										hidden : true
									},
									{
										title : '所属组织',
										name : 'secStaff.secOrganize.organizeName',
										width : 150,
										sortable : false,
										align : 'left',
										renderer : function(val, item, rowIndex) {
											if (item && item.secStaff) {
												return item.secStaff.secOrganize.organizeName;
											}
										}
									},
									{
										title : '组织ID',
										name : 'organizeId',
										width : 100,
										sortable : false,
										align : 'left',
										hidden : true,
										renderer : function(val, item, rowIndex) {
											if (item && item.secStaff) {
												return item.secStaff.secOrganize.id;
											}
										}
									},
									{
										title : '生效时间',
										name : 'validDate',
										width : 150,
										sortable : false,
										align : 'left',
										renderer : function(val, item, rowIndex) {
											if (item.validDate != undefined
													&& item.validDate.length > 0) {
												return item.validDate.substr(0,
														10);
											} else {
												return "";
											}
										}
									},
									{
										title : '失效时间',
										name : 'expireDate',
										width : 150,
										sortable : false,
										align : 'left',
										renderer : function(val, item, rowindex) {
											if (item.expireDate != undefined
													&& item.expireDate.length > 0) {
												return item.expireDate.substr(
														0, 10);
											} else {
												return "";
											}
										}
									},
									{
										title : '操作',
										name : 'operate',
										width : 100 + operations.length * 22,
										sortable : false,
										align : 'left',
										renderer : function(val, item, rowIndex) {
											var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
											var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
											var rolesObj = '<a class="calss-roleManage" href="#" title="角色管理"><span class="glyphicon glyphicon-user" style="font-size: 12px; color: #777"></span></a>';
											var extOperations = "";
											if (operations) {
												$
														.each(
																operations,
																function(n, v) {
																	extOperations += '<a class="' + v.aClass + '" href="#" title="' + v.title + '"><span class="' + v.spanClass + '" style="' + v.spanStyle + '"></span></a>';
																});
											}
											return modifyObj + deleteObj
													+ rolesObj + extOperations;
										}
									} ];
							operPaginator = $('#pg').mmPaginator({
								"limitList" : [ 20 ]
							});
							tbOpers = $('#tb_operators')
									.mmGrid(
											{
												width:'99%',
												height : 776,
												cols : cols,
												url : '${ctx}/operatorManage/newList',
												method : 'get',
												params : function() {
													var staffName = $(
															'#search-staffName')
															.val();
													var loginName = $(
															'#search-loginName')
															.val();
													var organizeId = $(
															'#search-organizeId')
															.val();
													return {
														"staffName" : staffName,
														"loginName" : loginName,
														"organizeId" : organizeId
													};
												},
												remoteSort : true,
												multiSelect : false,
												checkCol : false,
												nowrap : true,
												fullWidthRows : true,
												autoLoad : false,
												showBackboard : false,
												plugins : [ operPaginator ]
											});
							tbOpers
									.on(
											'cellSelect',
											function(e, item, rowIndex,
													colIndex) {
												e.stopPropagation();
												if ($(e.target).is(
														'.calss-modify')
														|| $(e.target)
																.is(
																		'.glyphicon-pencil')) {
													// 修改按钮事件
													rowEditing = rowIndex;
													createModalWithLoad(
															"edit-oper",
															650,
															300,
															"修改操作员信息",
															"operatorManage/edit",
															"saveOperator()",
															"confirm-close", "");
													$("#edit-oper-modal")
															.modal('show');
												} else if ($(e.target).is(
														'.calss-delete')
														|| $(e.target)
																.is(
																		'.glyphicon-remove')) {
													// 删除按钮事件
													var row = tbOpers
															.row(rowIndex);
													showDialogModal(
															"error-div",
															"操作提示",
															"确实要删除【"
																	+ row.secStaff.staffName
																	+ "】吗？", 2,
															"deleteOperator("
																	+ rowIndex
																	+ ");");
												} else if ($(e.target).is(
														'.calss-roleManage')
														|| $(e.target)
																.is(
																		'.glyphicon-user')) {
													rowEditing = rowIndex;
													rolesModify(rowIndex);
												} else {
													var row = tbOpers
															.row(rowIndex);
													createGridOperationEvent(
															e,
															operations,
															"ext-operation-div",
															rowIndex, row,
															"error-div");
												}
											}).on('loadSuccess',
											function(e, data) {

											}).on('checkSelected',
											function(e, item, rowIndex) {

											}).on('checkDeselected',
											function(e, item, rowIndex) {

											}).on(
											'loadError',
											function(req, error, errObj) {
												showDialogModal("error-div",
														"操作错误", "初始化菜单数据失败："
																+ errObj);
											}).load();

							$('#btn-add').on(
									'click',
									function() {
										rowEditing = -1;
										createModalWithLoad("edit-oper", 650,
												300, "新增操作员",
												"operatorManage/edit",
												"saveOperator()",
												"confirm-close");
										$("#edit-oper-modal").modal('show');
									});

							$("#search-btn-select-org").on(
									"click",
									function() {
										removeAllAlert();
										createModalWithIframe("select-org",
												800, 550, "选择组织",
												"organizeSelect/tree");
									});

							$('#queryOper').on('click', function() {
								loadGrid();
							});

							function rolesModify(rowIndex) {
								var row = tbOpers.row(rowIndex);
								removeAllAlert();
								$
										.ajax({
											type : "post",
											url : "${ctx}/operatorManage/selectRole?operId="
													+ row.id,
											dataType : "json",
											contentType : "application/json;charset=utf-8",
											success : function(data) {
												if (data != null
														&& data.length > 0) {
													$("#roles-lists").html("");
													result = data;
													for ( var i in result) {
														var id = data[i].id;
														var name = data[i].name;
														var checked = data[i].checked;

														var _span = $('<div style="margin-left: 20px; float: left; margin-top: 3px; margin-bottom: 0px;">'
																+ '<label for="input_'+id+'" style="font-weight: 400;">'
																+ '<input type="checkbox" id="input_'+id+'" value="'+id+'" style="opacity: 0;">'
																+ name
																+ '</label></div>');
														_span.data(id + '',
																data[i]);
														if (checked == "true") {
															_span
																	.find(
																			'input')
																	.prop(
																			"checked",
																			true);
														}
														_span.find('input')
																.uniform();
														$("#roles-lists")
																.append(_span);
														$(function() {
															$(
																	"[data-toggle='tooltip']")
																	.tooltip();
														});
													}
												}
												$('#modal-roles').modal('show');
											},
											error : function(req, error, errObj) {
												showDialogModal("error-div",
														"操作错误", "初始化菜单数据失败："
																+ errObj);
											}
										});
							}

							$('#saveRoles')
									.on(
											'click',
											function() {
												var row = tbOpers
														.row(rowEditing);
												var operData = row;
												var roles = getAllSelectedRolesStr();
												$
														.ajax({
															type : "get",
															url : "${ctx}/operatorManage/saveRoles?roles="
																	+ roles
																	+ "&operId="
																	+ operData.id,
															contentType : "application/json;charset=utf-8",
															success : function(
																	data) {
																if (data
																		&& data.CODE
																		&& data.CODE == "SUCCESS") {
																	loadGrid();
																	$(
																			"#edit-oper-modal")
																			.modal(
																					'hide');
																	$(
																			'#modal-roles')
																			.modal(
																					'hide');
																} else {
																	showAlert(
																			'warning',
																			data.MESSAGE,
																			"edit-oper-button-confirm",
																			'top');
																	$(
																			'#modal-roles')
																			.modal(
																					'hide');
																}
															},
															error : function(
																	req, error,
																	errObj) {
																showAlert(
																		'warning',
																		'提交失败：'
																				+ errObj,
																		"edit-oper-button-confirm",
																		'top');
																$(
																		'#modal-roles')
																		.modal(
																				'hide');
															}
														});
											});

							function getAllSelectedRoles() {
								var tree = $.fn.zTree.getZTreeObj("tree-roles");
								var nodes = tree.getCheckedNodes(true);
								if (nodes && nodes.length > 0) {
									var result = new Array(nodes.length);
									for (var i = 0; i < nodes.length; i++) {
										result[i] = {
											id : nodes[i].id,
											roleName : nodes[i].name
										};
									}
									return result;
								}
								return null;
							}

							function getAllSelectedRolesStr() {
								var rolesStr = "";
								$("#roles-lists").find('input:checked').each(
										function() {
											var id = $(this).val();
											if (rolesStr == "") {
												rolesStr = id;
											} else {
												rolesStr = rolesStr + "," + id;
											}
										});
								return rolesStr;
							}

						});

		function loadGrid() {
			operPaginator.load({
				"page" : 1
			});
			tbOpers.load();
		}

		function receiveOrganizeInfo(orgObj) {
			if ($('#organize')[0]) {
				$('#organize')[0].value = orgObj.organizeName;
				$('#organizeId')[0].value = orgObj.id;
			} else {
				$('#search-organize')[0].value = orgObj.organizeName;
				$('#search-organizeId')[0].value = orgObj.id;
			}
			$("#select-org-modal").modal('hide');
		}

		function saveOper(operData, updateRoles, updatePassword) {
			$.ajax({
				type : "post",
				url : "${ctx}/operatorManage/create?updateRoles=" + updateRoles + "&updatePassword=" + updatePassword,
				data : JSON.stringify(operData),
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						var datas = data.RETURN_PARAM;
						saveOperatorParam(datas.operatorId);
						loadGrid();
						$("#edit-oper-modal").modal('hide');
						return true;
					} else {
						showAlert('warning', data.MESSAGE, "edit-oper-button-confirm", 'top');
						return false;
					}
				},
				error : function(req, error, errObj) {
					showAlert('warning', '提交失败：' + errObj, "edit-oper-button-confirm", 'top');
					return false;
				}
			});
			return true;
		}

		function deleteOperator(rowIndex) {
			var row = tbOpers.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/operatorManage/delete/" + row.id,
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
		function addQueryButtons() {
			if ($(".content-default").width() < 850) {
				var tr = '<tr><td colspan="5"></td><td  align="right"><button id="queryOper" type="button" class="btn btn-default btn-common btnicons" > <p class="btniconimg"><span>查询</span></p></button><button id="btn-add" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 2rem;"> <p class="btniconimgadd"><span>新增</span></button></td></tr>';
				$("#queryParams").append(tr);
			}else{
				var td = '<td  align="right"><button id="queryOper" type="button" class="btn btn-default btn-common btnicons" ><p class="btniconimg"><span>查询</span></p></button><button id="btn-add" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 2rem;"> <p class="btniconimgadd"><span>新增</span></button></td';
				$("#queryParams tr:first td:last").after(td);
			}
		}
	</script>
</body>
</html>