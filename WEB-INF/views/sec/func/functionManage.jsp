<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<head>
<style type="text/css">
.form-control {
	width: 100% !important;
}

#parentName {
	width: 125px !important;
}

#funcIcon {
	width: 339px !important;
}
</style>

</head>
<body>
	<div id="div-tree" class="content-default"
		style="height: 100%; width: 250px; float: left;">
		<div id="tree-wrap"
			style="height: 100%; overflow: auto; border: 1px solid #ccc; border-radius: 3px; min-height: 200px;">
			<div class="zTreeDemoBackground left">
				<ul id="tree-functions" class="ztree"></ul>
			</div>
			<div id="error-div"></div>
		</div>
	</div>
	<div id="div-content" class="content-default"
		style="height: 100%; margin-left: 260px;">
		<form id="func-form">
			<table style="width: 450px;">
				<tr>
					<td align="right" style="width: 100px;">菜单名称：</td>
					<td style="width: 100px;"><input id="funcName" name="funcName"
						placeholder="菜单名称" class="form-control required" type="text"
						style="" required disabled /> <input id="state" name="state"
						type="text" style="display: none;" /> <input id="id" name="id"
						type="text" style="display: none;" /></td>
					<td align="right" style="width: 100px;">菜单编码：</td>
					<td style="width: 100px;"><input id="funcCode" name="funcCode"
						placeholder="菜单编码" class="form-control" type="text" style=""
						disabled /></td>
				</tr>
				<tr>
					<td align="right">菜单链接：</td>
					<td colspan="3"><input id="funcUrl" name="funcUrl"
						placeholder="菜单链接" class="form-control" type="text" style=""
						disabled /></td>
				</tr>
				<tr>
					<td align="right">菜单图标：</td>
					<td colspan="3">
						<input id="funcIcon" name="funcIcon" placeholder="菜单图标" class="form-control" type="text" style="width: 150px;" required disabled/> 
						<!-- <div id="func-icon-dropdownlist"></div> -->
					</td>
				</tr>
				<tr>
					<td align="right">上级菜单：</td>
					<td>
						<div style="width: 100px;">
							<div class="input-group">
								<input id="parentId" name="parentId" type="text"
									style="display: none;" /> <input id="parentName"
									name="parentName" placeholder="上级菜单" class="form-control"
									type="text" style="width: 112px;" readonly /> <span
									class="input-group-btn">
									<button id="btn-select-func" class="btn btn-default btn-input"
										type="button" data-toggle="modal"
										data-target="#select-func-modal" disabled>+</button>
								</span>
							</div>
						</div>
					</td>
					<td align="right">排序编号：</td>
					<td><input id="sort" name="sort" placeholder="排序编号"
						class="form-control" type="text" style="" required disabled /></td>
				</tr>
			</table>
		</form>
		<div id="btn-grp"
			style="position: relative; display: inline-block; vertical-align: middle; width: 210px; left: 180px; padding-top: 15px;">
			<button id="btn-add" type="button" class="btn btn-default btn-common btnicons"
				data-toggle="modal" data-target="#modal-add"><p class="btniconimgadd"><span>新增</span></button>
			<button id="btn-modify" type="button"
				class="btn btn-default btn-common btnicons"><p class="btniconimgedit"><span>修改</span></button>
			<button id="btn-delete" type="button"
				class="btn btn-default btn-common btnicons"><p class="btniconimgdelete"><span>删除</span></button>
			<button id="btn-save" type="button"
				class="btn btn-default btn-common btnicons"><p class="btniconimgsave"><span>保存</span></button>
		</div>
		<div id="error-div"></div>
	</div>
	<script>
		var funcIconDropDownList;
		var isModify = false;
		$(document).ready(function() {
			$.ajax({
				type : "post",
				url : "${ctx}/functionManage/queryTree",
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					$.fn.zTree.init($("#tree-functions"), {
						data : {
							simpleData : {
								enable : true
							}
						},
						callback : {
							onClick : onClick
						}
					}, data);
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", "初始化功能数据失败！");
				}
			});

			resize();

			/* var ddlItems = [ {
				itemText : "无",
				itemData : ""
			} ];
			ddlItems = ddlItems.concat(FONT_ICONS_DROPDOWN_DATAS);
			funcIconDropDownList = $("#func-icon-dropdownlist").dropDownList({
				inputName : "funcIcon",
				buttonText : "",
				width : "339px",
				readOnly : true,
				maxHeight : 200,
				onSelect : function(i, data, icon) {
					// $("#funcIcon").val(data);
				},
				items : ddlItems
			});

			funcIconDropDownList.disable(); */

			$("#btn-add").attr("disabled", true);
			$("#btn-modify").attr("disabled", true);
			$("#btn-delete").attr("disabled", true);
			$("#btn-save").attr("disabled", true);
		});

		$(window).resize(function() {
			resize();
		});

		$("#btn-add").on("click", function() {
			enableEdit();
			var parentId = $("#id").val();
			var parentName = $("#funcName").val();
			$("#id").val("");
			$("#funcName").val("");
			$("#state").val(1);
			$("#funcCode").val("");
			$("#funcUrl").val("");
			$("#funcIcon").val("");
			//funcIconDropDownList.setData("无", "", "");
			$("#parentId").val(parentId);
			$("#parentName").val(parentName);
			$("#sort").val("");

			$("#btn-add").attr("disabled", true);
			$("#btn-modify").attr("disabled", true);
			$("#btn-delete").attr("disabled", true);
			$("#btn-save").attr("disabled", false);
		});

		$('#btn-modify').on('click', function() {
			enableEdit();
			$("#btn-add").attr("disabled", true);
			$("#btn-modify").attr("disabled", true);
			$("#btn-delete").attr("disabled", true);
			$("#btn-save").attr("disabled", false);
			isModify = true;
		});

		$('#btn-delete').on(
				'click',
				function() {
					showDialogModal("error-div", "操作提示", "确实要删除当前的数据吗？", 2,
							"deleteFunction();");
				});

		function deleteFunction() {
			var funcId = $("#id").val();
			$.ajax({
				type : "post",
				url : "${ctx}/functionManage/delete/" + funcId,
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						showDialogModal("error-div", "操作成功", "数据已删除！");
						var tree = $.fn.zTree.getZTreeObj("tree-functions");
						var currentNode = tree.getSelectedNodes()[0];
						var parentNode = currentNode.getParentNode();
						tree.removeNode(currentNode);
						tree.selectNode(parentNode, false);
						onClick(null, parentNode.id, parentNode);
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

		$('#btn-save')
				.on(
						'click',
						function() {
							var funcName = $("#funcName").val();
							if (funcName.length == 0) {
								showAlert('warning', '菜单名称不能为空！', "funcName",
										'bottom');
								$("#funcName").focus();
								return;
							}

							var sort = $("#sort").val();
							if (sort.length == 0) {
								showAlert('warning', '排序编号不能为空！', "sort",
										'bottom');
								$("#sort").focus();
								return;
							}
							if (!$.isNumeric(sort)) {
								showAlert('warning', '排序编号必须为数字！', "sort",
										'bottom');
								$("#sort").focus();
								return;
							}

							// 组织提交数据（按com.rib.sec.entity.SecFunction实体类构造）
							var funcData = getFormData("func-form");
							var parentId = funcData.parentId;
							var parentName = funcData.parentName;
							delete funcData.parentId;
							delete funcData.parentName;
							$(funcData).attr({
								"parentFunction" : {
									"id" : parentId,
									"funcName" : parentName
								}
							});
							if (funcData.funcName == "无") {
								funcData.funcName = "";
							}

							$
									.ajax({
										type : "post",
										url : "${ctx}/functionManage/create?updateRoles=" + false,
										data : JSON.stringify(funcData),
										dataType : "json",
										contentType : "application/json;charset=utf-8",
										success : function(data) {
											if (data && data.CODE
													&& data.CODE == "SUCCESS") {
												var tree = $.fn.zTree
														.getZTreeObj("tree-functions");
												var currentNode = tree
														.getSelectedNodes()[0];
												if (currentNode) {
													if (isModify) {
														currentNode.name = data.RETURN_PARAM.funcName;
														tree.updateNode(
																currentNode,
																false);
													} else {
														var newNode = {
															"id" : data.RETURN_PARAM.id,
															"pId" : data.RETURN_PARAM.parentId,
															"name" : data.RETURN_PARAM.funcName
														};
														currentNode = tree
																.addNodes(
																		currentNode,
																		newNode)[0];
													}
													tree.selectNode(
															currentNode, false);
													onClick(null,
															currentNode.id,
															currentNode);
												}
												isModify = false;
												return;
											} else {
												showAlert('warning',
														data.MESSAGE,
														"btn-save", 'bottom');
												return;
											}
										},
										error : function(req, error, errObj) {
											showAlert('warning', '提交失败：'
													+ errObj, "btn-save",
													'bottom');
											return;
										}
									});
						});

		function resize() {
			// $("#div-content").css("width", ($(document.body).width() - 250) * 0.98 + "px");
			//var treeHeight = $("#div-tree").outerHeight();
			//var height = ($(document.body).width() - 250)
			//$("#div-content").css("height", ($(document.body).width() - 250) * 0.98 + "px");

			var treeMinHeight = $(document.body).height() - 96 - 30 - 40;
			$("#tree-wrap").css("minHeight", treeMinHeight);
			$("#div-content").css("minHeight", $("#div-tree").outerHeight());
		}

		function onClick(event, treeId, treeNode) {
			isModify = false;
			disableEdit();
			if (treeNode.id <= 0) {
				return;
			}
			$.ajax({
				type : "post",
				url : "${ctx}/functionManage/query/" + treeNode.id,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					setFunctionInfo(data);
					setOperationButton(treeNode);
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", "查询菜单信息出错：" + errObj);
				}
			});
		}

		function enableEdit() {
			$("#funcName").attr("disabled", false);
			$("#funcCode").attr("disabled", false);
			$("#funcUrl").attr("disabled", false);
			$("#funcIcon").attr("disabled", false);
			//funcIconDropDownList.enable();
			$("#sort").attr("disabled", false);
		}

		function disableEdit() {
			$("#funcName").attr("disabled", true);
			$("#funcCode").attr("disabled", true);
			$("#funcUrl").attr("disabled", true);
			$("#funcIcon").attr("disabled", true);
			//funcIconDropDownList.disable();
			$("#sort").attr("disabled", true);
		}

		function setFunctionInfo(data) {
			$("#id").val(data.id);
			$("#funcName").val(data.funcName);
			$("#state").val(data.state);
			$("#funcCode").val(data.funcCode);
			$("#funcUrl").val(data.funcUrl);
			$("#funcIcon").val(data.funcIcon);
/* 			if (data.funcIcon !== undefined && data.funcIcon.length > 0) {
				funcIconDropDownList.setData(data.funcIcon, data.funcIcon,
						data.funcIcon);
			} else {
				funcIconDropDownList.setData("无", data.funcIcon, data.funcIcon);
			} */
			if (data.parentId) {
				$("#parentId").val(data.parentId);
			} else {
				$("#parentId").val("");
			}
			if (data.parentFunction) {
				$("#parentName").val(data.parentFunction.funcName);
			}
			$("#sort").val(data.sort);
		}

		function setOperationButton(treeNode) {
			if (treeNode.level == 3) {
				$("#btn-add").attr("disabled", true);
			} else {
				$("#btn-add").attr("disabled", false);
			}
			$("#btn-modify").attr("disabled", false);
			if (treeNode.level == 0) {
				$("#btn-delete").attr("disabled", true);
			} else {
				$("#btn-delete").attr("disabled", false);
			}
			$("#btn-save").attr("disabled", true);
		}
	</script>
</body>
</html>