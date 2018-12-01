<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<script src="${ctx}/static/js/ajaxfileupload.js" type="text/javascript"></script>
<body>
	<div class="content-default">
		<form>
			<table>
				<tr>
					<td align="right" width="90">报表名称：</td>
					<td>
						<input id="qReportName" name="qReportName" placeholder="报表名称" class="form-control required" type="text" style="width: 150px;" />
					</td>
					<td>
						<button id="btn-query" type="button" class="btn btn-default btn-common" style="margin-left: 20px;">查询</button>
						<input type="file" id="file" name="file" style="margin-left: 60px; align: center; display: none;" onchange="ajaxFileUpload()">
						<button id="btn-import" type="button" class="btn btn-default btn-common">导入</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb_Reports" class="tb_Reports" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<div id="error-div"></div>
	<div id="edit-report"></div>
	<script>
		var tbReports;
		var pg;
		$(document).ready(function() {

			var cols = [
					{
						title : '报表ID',
						name : 'id',
						width : 80,
						sortable : true,
						align : 'center'
					}, {
						title : '报表名称',
						name : 'reportName',
						width : 200,
						sortable : true,
						align : 'left'
					}, {
						title : '报表配置页面URL',
						name : 'reportViewUrl',
						width : 200,
						sortable : true,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.id) {
								return "/report/view/" + item.id;
							}
						}
					}, {
						title : '操作',
						name : 'operate',
						width : 120,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							var modifyObj = '<a class="class-edit" href="#" title="编辑"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							modifyObj += '<a class="calss-export" href="#" title="导出"><span class="glyphicon glyphicon-th" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>'
							return modifyObj;
						}
					}
			];

			pg = $('#pg').mmPaginator({
				"limitList" : [
					10
				]
			});
			tbReports = $('#tb_Reports').mmGrid({
				height : 365,
				cols : cols,
				url : '${ctx}/report/list',
				method : 'get',
				remoteSort : true,
				sortName : 'id',
				sortStatus : 'desc',
				multiSelect : false,
				checkCol : false,
				fullWidthRows : false,
				autoLoad : false,
				showBackboard : false,
				params : function() {
					var reportName = $("#qReportName").val();
					data = {
						"reportName" : escape(reportName)
					};
					return data;
				},
				plugins : [
					pg
				]
			});

			tbReports.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-export') || $(e.target).is('.glyphicon-th')) {
					// 修改按钮事件
					var row = tbReports.row(rowIndex);
					window.open("${ctx}/report/exportJson/" + row.id);
				} else if ($(e.target).is('.class-edit') || $(e.target).is('.glyphicon-pencil')) {
					var row = tbReports.row(rowIndex);
					/* createModalWithLoad("edit-report", window.innerWidth, 0, "报表编辑", "report/edit/"+row.id, "saveEditReport()", "confirm-close","","10");
					$("#edit-report-modal").modal('show'); */
					openPage(row.reportName, "", "report/edit/" + row.id);
				}
			}).on('loadSuccess', function(e, data) {
				rowEditing = -1;
			}).on('checkSelected', function(e, item, rowIndex) {

			}).on('checkDeselected', function(e, item, rowIndex) {

			}).load();

			$('#btn-import').on('click', function() {

			});

			$('#btn-query').on('click', function() {
				loadGrid();
			});

			$('#btn-import').on('click', function() {
				var fileType = $("#fileTypeValue").val();
				if (fileType <= 0) {
					showAlert('warning', '文件类型不能为空！', "fileTypeValue", 'top');
					return;
				}
				$("#file").click();
			});
		});

		function loadGrid() {
			pg.load({
				"page" : 1
			});
			tbReports.load();
		}

		function ajaxFileUpload() {
			var elementIds = [
				"flag"
			]; //flag为id、name属性名
			if ($("#file").val().length == 0) {
				showDialogModal("error-div", "操作提示", "请选择文件！");
				return;
			}

			$.ajaxFileUpload({
				url : '${ctx}/report/importReportFromJson',
				type : 'post',
				secureuri : false, //一般设置为false
				fileElementId : 'file', // 上传文件的id、name属性名

				dataType : 'application/json', //返回值类型，一般设置为json、application/json
				//contentType: "application/json;charset=utf-8",
				elementIds : elementIds, //传递参数到服务器
				success : function(data) {
					var value = JSON.parse(data.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", ""));
					showDialogModal("error-div", "操作提示", value.MESSAGE);
					tbReports.load();
					$("#file").val("");
					return;

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