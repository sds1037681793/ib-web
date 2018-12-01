<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
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
					<td align="right" width="90">组织名称：</td>
					<td>
						<input id="qOrganizeName" name="qOrganizeName" placeholder="组织名称" class="form-control required" type="text" style="width: 150px;" />
					</td>
					<td align="right" width="90">组织编码：</td>
					<td>
						<input id="qOrganizeCode" name="qOrganizeCode" placeholder="组织编码" class="form-control required" type="text" style="width: 150px;" />
					</td>
					<td>
						<button id="btn-query-org" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 3rem;">
                        <p class="btniconimg"><span>查询</span></p>
                        </button>
						<button id="btn-add-org" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 2rem;"> 
                         <p class="btniconimgadd"><span>新增</span> 
                        </button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb_orgs" class="tb_orgs" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<div id="edit-org"></div>
	<div id="select-org"></div>
	<div id="ext-operation-div"></div>
	<div id="edit-subsystem"></div>
	<div id="error-div"></div>
	<div id="edit-data"></div>
	<script>
		var tbOrgs;
		var pg;
		var dropDownListOrgTypes = new HashMap();
		var orgTypeDdlItems = new Array();
		orgTypeDdlItems[orgTypeDdlItems.length] = {
			itemText : "请选择",
			itemData : 0
		};
		var rowEditing = -1;
		$(document).ready(function() {
			var operations = createGridOperation({
				ctx : "${ctx}",
				gridCode : "ORGANIZE_MANAGE"
			});
			// 获取组织类型数据
			$.ajax({
				type : "post",
				url : "${ctx}/staticData/query?typeCode=ORGANIZE_TYPE&dataCode=",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data != null && data.length > 0) {
						$(eval(data)).each(function() {
							dropDownListOrgTypes.put(this.code, {
								"name" : this.name,
								"value" : this.value
							});
							orgTypeDdlItems[orgTypeDdlItems.length] = {
								itemText : this.name,
								itemData : this.code
							};
						});
					}
				},
				error : function(req, error, errObj) {

				}
			});

			var cols = [
					{
						title : '组织ID',
						name : 'id',
						width : 80,
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
						title : '组织名称',
						name : 'organizeName',
						width : 300,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							var span = jQuery('<span data-toggle="tooltip" data-placement="bottom">');
							span.attr("title", item.organizeName);
							span.text(item.organizeName);
							var html = jQuery('<div style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;"></div>');
							html.append(span);
							return html.html();
						}
					}, {
						title : '组织编码',
						name : 'organizeCode',
						width : 200,
						sortable : false,
						align : 'left'
					}, {
						title : '组织类型ID',
						name : 'organizeType',
						width : 200,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '组织类型',
						name : 'organizeTypeName',
						width : 200,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							return dropDownListOrgTypes.get(item.organizeType).name;
						}
					}, {
						title : '父组织ID',
						name : 'parentOrganize.id',
						width : 100,
						sortable : false,
						align : 'left',
						hidden : true,
						renderer : function(val, item, rowIndex) {
							if (item && item.parentOrganize) {
								return item.parentOrganize.id;
							} else {
								return null;
							}
						}
					}, {
						title : '父组织名称',
						name : 'parentOrganize.organizeName',
						width : 150,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.parentOrganize) {
								return item.parentOrganize.organizeName;
							} else {
								return null;
							}
						}
					}, {
						title : '操作',
						name : 'operate',
						width : 120,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777"></span></a>';

							var extOperations = "";
							if (operations) {
								$.each(operations, function(n, v) {
									extOperations += '<a class="' + v.aClass + '" href="#" title="' + v.title + '"><span class="' + v.spanClass + '" style="' + v.spanStyle + '"></span></a>';
								});
							}
							return modifyObj + deleteObj + extOperations;
						}
					}
			];

			pg = $('#pg').mmPaginator({
				"limitList" : [
					20
				]
			});
			tbOrgs = $('#tb_orgs').mmGrid({
				width:'99%',
				height : 776,
				cols : cols,
				url : '${ctx}/organizeManage/list',
				method : 'get',
				remoteSort : false,
				multiSelect : false,
				checkCol : false,
				nowrap : true,
				fullWidthRows :true,
				autoLoad : false,
				showBackboard : false,
				params : function() {
					var organizeName = $("#qOrganizeName").val();
					var organizeCode = $("#qOrganizeCode").val();
					data = {
						"organizeName" : escape($.trim(organizeName)),
						"organizeCode" : escape($.trim(organizeCode))
					};
					return data;
				},
				plugins : [
					pg
				]
			});

			tbOrgs.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
					// 修改按钮事件
					rowEditing = rowIndex;

					createModalWithLoad("edit-org", 740, 0, "修改组织", "organizeManage/edit", "saveOrganize()", "confirm-close", "");
					$("#edit-org-modal").modal('show');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
					// 删除按钮事件
					var row = tbOrgs.row(rowIndex);
					showDialogModal("error-div", "操作提示", "确实要删除【" + row.organizeName + "】吗？", 2, "deleteOrganize(" + rowIndex + ");");
				} else {
					var row = tbOrgs.row(rowIndex);
					createGridOperationEvent(e, operations, "ext-operation-div", rowIndex, row, "error-div");
				}
			}).on('loadSuccess', function(e, data) {
				rowEditing = -1;
			}).on('checkSelected', function(e, item, rowIndex) {

			}).on('checkDeselected', function(e, item, rowIndex) {

			}).load();

			$('#btn-add-org').on('click', function() {
				rowEditing = -1;
				createModalWithLoad("edit-org", 740, 0, "新增组织", "organizeManage/edit", "saveOrganize()", "confirm-close");
				$("#edit-org-modal").modal('show');
			});

			$('#btn-query-org').on('click', function() {
				loadGrid();
			});
		});

		function loadGrid() {
			pg.load({
				"page" : 1
			});
			tbOrgs.load();
		}

		function deleteOrganize(rowIndex) {
			var row = tbOrgs.row(rowIndex);
			if (row.id == 1) {
				showDialogModal("error-div", "操作错误", "根组织不允许删除！");
				return;
			}
			$.ajax({
				type : "post",
				url : "${ctx}/organizeManage/delete/" + row.id,
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