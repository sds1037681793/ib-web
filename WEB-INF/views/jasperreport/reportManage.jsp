<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Report Config</title>
</head>
<body>
	<div class="content-default">
		<form>
			<table>
				<tr>
					<td align="right" width="90">报表名称：</td>
					<td>
						<input id="qreportName" name="reportName" placeholder="报表名称" class="form-control required" type="text" style="width: 150px;" />
					</td>
					<td align="right" width="90">报表编码：</td>
					<td>
						<input id="qreportCode" name="reportCode" placeholder="报表编码" class="form-control required" type="text" style="width: 150px;" />
					</td>
					<td>
						<button id="btn-query-report" type="button" class="btn btn-default btn-common" style="margin-left: 20px;">查询</button>
						<button id="btn-add-report" type="button" class="btn btn-default btn-common">新增报表</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb_reports" class="tb_reports" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg_report" style="text-align: right;"></div>
	<div class="content-default">
		<form>
			<table>
				<tr>
					<td align="left" width="190">报表所有条件列表</td>
					<td>
						<button id="btn-add-condition" type="button" class="btn btn-default btn-common">新增条件</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb_conditions" class="tb_conditions" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg_condition" style="text-align: right;"></div>
	<div id="edit-report"></div>
	<div id="edit-condition"></div>
	<div id="error-div"></div>
	<script>
		var tbReports;
		var rowEditingReport = -1;

		var tbConditions;
		var rowEditingCondition = -1;

		var displayStyleMap = new HashMap();
		displayStyleMap.put("1", "输入框");
		displayStyleMap.put("5", "下拉框");
		displayStyleMap.put("6", "单选框");
		displayStyleMap.put("7", "复选框");
		displayStyleMap.put("8", "日期");

		var displayStyleItem = new Array();
		var key = displayStyleMap.keySet();
		for ( var i in key) {
			if (displayStyleItem.length == 0) {
				displayStyleItem[displayStyleItem.length] = {
					itemText : displayStyleMap.get(key[i]),
					itemData : key[i],
					Selected : true
				};
			} else {
				displayStyleItem[displayStyleItem.length] = {
					itemText : displayStyleMap.get(key[i]),
					itemData : key[i]
				};
			}
		}

		var dataTypeMap = new HashMap();
		dataTypeMap.put("1", "数字型");
		dataTypeMap.put("2", "字符型");

		var dataTypeItem = new Array();
		var key = dataTypeMap.keySet();
		for ( var i in key) {
			if (dataTypeItem.length == 0) {
				dataTypeItem[dataTypeItem.length] = {
					itemText : dataTypeMap.get(key[i]),
					itemData : key[i],
					Selected : true
				};
			} else {
				dataTypeItem[dataTypeItem.length] = {
					itemText : dataTypeMap.get(key[i]),
					itemData : key[i]
				};
			}
		}

		var startOrEndMap = new HashMap();
		startOrEndMap.put("1", "开始时间");
		startOrEndMap.put("2", "结束时间");

		var startOrEndItem = new Array();
		var key = startOrEndMap.keySet();
		for ( var i in key) {
			if (startOrEndItem.length == 0) {
				startOrEndItem[startOrEndItem.length] = {
					itemText : startOrEndMap.get(key[i]),
					itemData : key[i],
					Selected : true
				};
			} else {
				startOrEndItem[startOrEndItem.length] = {
					itemText : startOrEndMap.get(key[i]),
					itemData : key[i]
				};
			}
		}

		var conditionMap = new HashMap();
		conditionMap.put("1", "=");
		conditionMap.put("2", "<>");
		conditionMap.put("3", ">");
		conditionMap.put("4", ">=");
		conditionMap.put("5", "<");
		conditionMap.put("6", "<=");
		conditionMap.put("7", "like");

		var conditionItem = new Array();
		var key = conditionMap.keySet();
		for ( var i in key) {
			if (conditionItem.length == 0) {
				conditionItem[conditionItem.length] = {
					itemText : conditionMap.get(key[i]),
					itemData : key[i],
					Selected : true
				};
			} else {
				conditionItem[conditionItem.length] = {
					itemText : conditionMap.get(key[i]),
					itemData : key[i]
				};
			}
		}

		var displayDealClassMap = new HashMap();
		displayDealClassMap.put("", "无");
		displayDealClassMap.put("com.rib.base.util.page.report.handler.JsonDataHandler", "Json");
		displayDealClassMap.put("com.rib.base.util.page.report.handler.SqlDataHandler", "Static");

		var displayDealClassItem = new Array();
		var key = displayDealClassMap.keySet();
		for ( var i in key) {
			if (displayDealClassItem.length == 0) {
				displayDealClassItem[displayDealClassItem.length] = {
					itemText : displayDealClassMap.get(key[i]),
					itemData : key[i],
					Selected : true
				};
			} else {
				displayDealClassItem[displayDealClassItem.length] = {
					itemText : displayDealClassMap.get(key[i]),
					itemData : key[i]
				};
			}
		}

		$(document).ready(function() {
			//report start
			var reportCols = [
					{
						title : '报表ID',
						name : 'id',
						width : 80,
						sortable : true,
						align : 'center',
						hidden : true
					}, {
						title : '报表名称',
						name : 'reportName',
						width : 150,
						sortable : true,
						align : 'left'
					}, {
						title : '报表编码',
						name : 'reportCode',
						width : 150,
						sortable : true,
						align : 'left'
					}, {
						title : '报表文件名',
						name : 'fileName',
						width : 150,
						sortable : true,
						align : 'left'
					}, {
						title : '样式',
						name : 'styles',
						width : 400,
						sortable : true,
						align : 'left'
					}, {
						title : '其他配置',
						name : 'config',
						width : 400,
						sortable : true,
						align : 'left'
					}, {
						title : '操作',
						name : 'operate',
						width : 100,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777"></span></a>';
							return modifyObj + deleteObj;
						}
					}
			];

			tbReports = $('#tb_reports').mmGrid({
				height : 230,
				nowrap : true,
				cols : reportCols,
				url : '${ctx}/reportConfig/listReport',
				method : 'get',
				remoteSort : true,
				sortName : 'id',
				sortStatus : 'desc',
				multiSelect : false,
				checkCol : true,
				fullWidthRows : false,
				autoLoad : false,
				plugins : [
					$('#pg_report').mmPaginator({
						"limitList" : [
							10
						]
					})
				]
			});

			tbReports.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
					// 修改按钮事件
					rowEditingReport = rowIndex;

					createModalWithLoad("edit-report", 850, 0, "修改报表", "reportConfig/editReport", "saveReport()", "confirm-close", "");
					$("#edit-report-modal").modal('show');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
					// 删除按钮事件
					var row = tbReports.row(rowIndex);
					showDialogModal("error-div", "操作提示", "确实要删除报表【" + row.reportName + "】吗？", 2, "deleteReport(" + rowIndex + ");");
				}
			}).on('loadSuccess', function(e, data) {
				rowEditingReport = -1;
			}).on('checkSelected', function(e, item, rowIndex) {
				rowEditingReport = rowIndex;
				tbConditions.load();
			}).on('checkDeselected', function(e, item, rowIndex) {

			}).load();

			$('#btn-add-report').on('click', function() {
				rowEditingReport = -1;
				createModalWithLoad("edit-report", 850, 0, "新增报表", "reportConfig/editReport", "saveReport()", "confirm-close");
				$("#edit-report-modal").modal('show');
			});

			$('#btn-query-report').on('click', function() {
				var reportName = $("#qreportName").val();
				var reportCode = $("#qreportCode").val();
				data = {
					"reportName" : escape(reportName),
					"reportCode" : escape(reportCode)
				};
				tbReports.load(data);
			});
			//report end

			//condition start
			var conditionCols = [
					{
						title : '条件ID',
						name : 'conditionId',
						width : 80,
						sortable : true,
						align : 'center',
						hidden : true
					}, {
						title : '报表ID',
						name : 'bsReportId',
						width : 80,
						sortable : true,
						align : 'center',
						hidden : true
					}, {
						title : '元素ID',
						name : 'bsElementDefineId',
						width : 80,
						sortable : true,
						align : 'center',
						hidden : true
					}, {
						title : '字段名称',
						name : 'paramName',
						width : 120,
						sortable : true,
						align : 'left'
					}, {
						title : '字段编码',
						name : 'paramCode',
						width : 140,
						sortable : true,
						align : 'left'
					}, {
						title : '条件运算',
						name : 'condition',
						width : 70,
						sortable : true,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.condition) {
								return conditionMap.get(item.condition);
							}
						}
					}, {
						title : '默认值',
						name : 'defaultValue',
						width : 80,
						sortable : true,
						align : 'left'
					}, {
						title : '数据类型',
						name : 'dataType',
						width : 80,
						sortable : true,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.dataType) {
								return dataTypeMap.get(item.dataType);
							}
						}
					}, {
						title : '数据处理类',
						name : 'displayDealClass',
						width : 80,
						sortable : true,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.displayDealClass) {
								return displayDealClassMap.get(item.displayDealClass);
							}
						}
					}, {
						title : '数据来源',
						name : 'displayDealData',
						width : 200,
						sortable : true,
						align : 'left'
					}, {
						title : '排序顺序',
						name : 'sort',
						width : 60,
						sortable : true,
						align : 'left'
					}, {
						title : '显示样式',
						name : 'displayStyle',
						width : 80,
						sortable : true,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.displayStyle) {
								return displayStyleMap.get(item.displayStyle);
							}
						}
					}, {
						title : '开始/结束日期',
						name : 'startOrEnd',
						width : 80,
						sortable : true,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.startOrEnd) {
								return startOrEndMap.get(item.startOrEnd);
							}
						}
					}, {
						title : '展示样式',
						name : 'styles',
						width : 200,
						sortable : true,
						align : 'left'
					}, {
						title : '事件配置',
						name : 'events',
						width : 200,
						sortable : true,
						align : 'left'
					}, {
						title : '描述',
						name : 'description',
						width : 110,
						sortable : true,
						align : 'left'
					}, {
						title : '操作',
						name : 'operate',
						width : 90,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777"></span></a>';
							return modifyObj + deleteObj;
						}
					}
			];

			tbConditions = $('#tb_conditions').mmGrid({
				height : 325,
				cols : conditionCols,
				url : '${ctx}/reportConfig/listCondition',
				method : 'get',
				remoteSort : true,
				sortName : 'id',
				nowrap : true,
				sortStatus : 'desc',
				fullWidthRows : false,
				autoLoad : false,
				params : function() {
					var selectForm = {
						"reportId" : tbReports.row(rowEditingReport).id
					}
					return selectForm;
				},
				plugins : [
					$('#pg_condition').mmPaginator({
						"limitList" : [
							10
						]
					})
				]
			});

			tbConditions.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
					// 修改按钮事件
					rowEditingCondition = rowIndex;

					createModalWithLoad("edit-condition", 850, 0, "修改报表", "reportConfig/editCondition", "saveCondition()", "confirm-close", "");
					$("#edit-condition-modal").modal('show');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
					// 删除按钮事件
					var row = tbConditions.row(rowIndex);
					showDialogModal("error-div", "操作提示", "确实要删除条件【" + row.paramName + "】吗？", 2, "deleteCondition(" + rowIndex + ");");
				}
			}).on('loadSuccess', function(e, data) {
				rowEditingCondition = -1;
			}).on('checkSelected', function(e, item, rowIndex) {

			}).on('checkDeselected', function(e, item, rowIndex) {

			});

			$('#btn-add-condition').on('click', function() {
				if (tbReports.selectedRowsIndex().length == 0) {
					showDialogModal("error-div", "操作错误", "请选择报表记录！");
					return;
				}
				rowEditingCondition = -1;
				createModalWithLoad("edit-condition", 850, 0, "新增报表", "reportConfig/editCondition", "saveCondition()", "confirm-close");
				$("#edit-condition-modal").modal('show');
			});

			/* $('#btn-query-condition').on('click', function(){
			    var reportName = $("#qreportName").val();
			    var reportCode = $("#qreportCode").val();
			    data = {"reportName": escape(reportName), "reportCode": escape(reportCode)};
			    tbReports.load(data);
			}); */
			//condition end
		});

		function deleteReport(rowIndex) {
			var row = tbReports.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/reportConfig/deleteReport/" + row.id,
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						showDialogModal("error-div", "操作成功", "数据已删除！");
						tbReports.load();
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

		function deleteCondition(rowIndex) {
			var row = tbConditions.row(rowIndex);
			var conditionData = {
				"bsElementDefineId" : row.bsElementDefineId,
				"conditionId" : row.conditionId
			};
			$.ajax({
				type : "post",
				url : "${ctx}/reportConfig/deleteCondition",
				data : JSON.stringify(conditionData),
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						showDialogModal("error-div", "操作成功", "数据已删除！");
						tbConditions.load();
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