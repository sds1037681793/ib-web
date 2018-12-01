<%@ page language="java" contentType="text/html; charset=utf-8" %> 
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<body>
	<div class="content-default">
		<button id="btn-add-data" type="button" class="btn btn-default btn-common" style="margin-left: 20px;">新增</button>
	</div>
	<table id="tb_datas" class="tb_datas" style="border: 1px solid;width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg1" style="text-align: right;"></div>
	<script type="text/javascript">
		var ProjectNewsListData = {
            projectCode: tbOrgs.row("${param.rowIndex}").organizeCode,
			projectId: tbOrgs.row("${param.rowIndex}").id
		}
		var pjNewsData;
		$(document).ready(function() {
			var cols = [
					{
						title : 'id',
						name : 'id',
						width : 80,
						sortable : true,
						align : 'center',
						hidden : true
					},{
						title : '新闻标题',
						name : 'newsTitle',
						width : 200,
						sortable : true,
						align : 'left'
					},{
						title : '新闻内容',
						name : 'newsContent',
						width : 360,
						sortable : true,
						align : 'left'
					},{
						title : 'state',
						name : 'state',
						width : 80,
						sortable : true,
						align : 'center',
						hidden : true
					}, {
						title : '操作',
						name : 'operate',
						width : 100,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							return modifyObj + deleteObj;
						}
					}
			];
			var dataPaginator = $('#pg1').mmPaginator({
				"limitList" : [
					8
				]
			});
            pjNewsData = $('#tb_datas').mmGrid({
				height : 365,
				cols : cols,
				url : '${ctx}/system/secProjectNews/getProjectNewsList/' + ProjectNewsListData.projectCode,
				method : 'post',
				nowrap : true,
				remoteSort : true,
				sortName : 'id',
				sortStatus : 'desc',
				multiSelect : false,
				checkCol : false,
				fullWidthRows : false,
				autoLoad : false,
				showBackboard : false,
				plugins : [
					dataPaginator
				]
			});
			pjNewsData.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
					// 修改按钮事件
					createModalWithLoad("edit-data", 650, 520, "修改数据", "projectPage/projectNews?rowIndex=" + rowIndex, "ProjectNewsUtil.saveProjectNews()", "confirm-close", "");
					$("#edit-data-modal").modal('show');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
					// 删除按钮事件
					var row = pjNewsData.row(rowIndex);
                    RowIndex = rowIndex;
					showDialogModal("error-div", "操作提示", "确实要删除该条新闻吗？", 2, "deleteData(" + rowIndex + ");");
				}
			}).on('loadError', function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "初始化菜单数据失败：" + errObj);
			}).load();
			$('#btn-query-data').on('click', function() {
				dataPaginator.load({
					"page" : 1
				});
                pjNewsData.load();
			});
			$('#btn-add-data').on('click', function() {
				createModalWithLoad("edit-data", 650, 520, "新增数据", "projectPage/projectNews?rowIndex=" + -1, "ProjectNewsUtil.saveProjectNews()", "confirm-close");
				$("#edit-data-modal").modal('show');
			});

		});
		function deleteData(rowIndex) {
			var row = pjNewsData.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/system/secProjectNews/delete/" + row.id,
                dataType: 'json',
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						showDialogModal("error-div", "操作成功", "数据已删除！");
                        $("#edit-data-modal").modal('hide');
                        pjNewsData.load();
						return;
					} else {
						showDialogModal("error-div", "操作失败", data.MESSAGE);
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