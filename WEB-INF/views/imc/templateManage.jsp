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
		<table>
			<tr>
				<td width="90" align="right">模板编码：</td>
				<td>
					<input id="search-templateCode" type="text" placeholder="模板编码" class="form-control required" style="width: 150px;" />
				</td>
				<td>
					<button id="queryTemplate" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 3rem;">
                    <p class="btniconimg"><span>查询</span></p>
                    </button>
					<button id="btn-add" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 2rem;">
                    <p class="btniconimgadd"><span>新增</span> 
                    </button>
				</td>
			</tr>
		</table>
	</div>
	<table id="tb_templates" class="tb_templates" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<div id="edit-template"></div>
	<div id="platform-list"></div>
	<div id="error-div"></div>
	<script type="text/javascript">
		var tbTemplates;
		var templatePaginator
		var rowEditing = -1;
		$(document).ready(function() {
			var cols = [
					{
						title : 'ID',
						name : 'id',
						width : 100,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '模板编码',
						name : 'templateCode',
						width : 200,
						sortable : false,
						align : 'left'
					}, {
						title : '扩展编码',
						name : 'extendCode',
						width : 200,
						sortable : false,
						align : 'left'
					}, {
						title : '模板内容',
						name : 'templateContent',
						width : 400,
						sortable : false,
						align : 'left',
					}, {
						title : 'ID',
						name : 'platformId',
						width : 100,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '模板策略',
						name : 'strategyConfig',
						width : 100,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '平台名称',
						name : 'platformName',
						width : 100,
						sortable : false,
						align : 'left'
					}, {
						title : '操作',
						name : 'operate',
						width : 100,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							return modifyObj + deleteObj;
						}
					}
			];
			
			templatePaginator = $('#pg').mmPaginator({
				"limitList" : [
					20
				]
			});
			
			tbTemplates = $('#tb_templates').mmGrid({
				width:'99%',
				height : 776,
				cols : cols,
				url : '${ctx}/template/list',
				method : 'get',
				params : function() {
					var templateCode = $('#search-templateCode').val();
					return {
						"templateCode" : templateCode
					};
				},
				remoteSort : true,
				sortName : 'id',
				sortStatus : 'desc',
				multiSelect : false,
				checkCol : false,
				nowrap : true,
				fullWidthRows : true,
				autoLoad : false,
				showBackboard : false,
				plugins : [
					templatePaginator
				]
			});
			
			tbTemplates.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
					// 修改按钮事件
					rowEditing = rowIndex;
					createModalWithLoad("edit-template", 650, 330, "修改模板信息", "template/edit", "saveTemplate()", "confirm-close", "");
					$("#edit-template-modal").modal('show');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
					// 删除按钮事件
					var row = tbTemplates.row(rowIndex);
					showDialogModal("error-div", "操作提示", "确实要删除吗？", 2, "deleteTemplate(" + rowIndex + ");");
				}
			}).on('loadSuccess', function(e, data) {

			}).on('checkSelected', function(e, item, rowIndex) {

			}).on('checkDeselected', function(e, item, rowIndex) {

			}).on('loadError', function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "初始化菜单数据失败：" + errObj);
			}).load();

			$('#btn-add').on('click', function() {
				rowEditing = -1;
				createModalWithLoad("edit-template", 650, 330, "新增模板", "template/edit", "saveTemplate()", "confirm-close");
				$("#edit-template-modal").modal('show');
			});

			$('#queryTemplate').on('click', function() {
				loadGrid();
			});

			
		});

		function loadGrid() {
			templatePaginator.load({
				"page" : 1
			});
			tbTemplates.load();
		}

		function deleteTemplate(rowIndex) {
			var row = tbTemplates.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/template/delete/" + row.id,
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
		
		function saveTemplate() {
			var templateCode = $("#templateCode").val();
			if (templateCode.length == 0) {
				showAlert('warning', '模板编码不能为空！', "templateCode", 'top');
				$("#templateCode").focus();
				return;
			}
			
			var platformId = $("#platformId").val();
			if (platformId.length == 0) {
				showAlert('warning', '平台不能为空！', "platformId", 'top');
				$("#platformId").focus();
				return;
			}
			
			var templateContent = $("#templateContent").val();
			if (templateContent.length == 0) {
				showAlert('warning', '模板内容不能为空！', "templateContent", 'top');
				$("#templateContent").focus();
				return;
			}
			
			var extendCode = $("#extendCode").val();
			if (extendCode.length == 0) {
				showAlert('warning', '扩展编码不能为空！', "extendCode", 'top');
				$("#extendCode").focus();
				return;
			}
			
			var templateData = getFormData("template-form");
			delete templateData.platformName;

			$.ajax({
				type : "post",
				url : "${ctx}/template/create",
				data : JSON.stringify(templateData),
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						loadGrid();
						$("#edit-template-modal").modal('hide');
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