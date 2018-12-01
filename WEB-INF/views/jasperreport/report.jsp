<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String reportCode = request.getParameter("reportCode");
%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>报表</title>
</head>
<body>
	<div class="content-default">
		<form id="select-form"></form>
	</div>
	<div id="content-tb" style="height: 650px; overflow: auto;" class="content-default"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
	<script type="text/javascript">
		var reportCode = "<%=reportCode%>";
		var report = null;
		var lineCount = 3;
		$(document).ready(function() {
			getReport(reportCode);
		});

		function exportReport() {
			window.open("${ctx}/servlets/xls");
		}

		function getReport(reportCode) {
			$.ajax({
				type : "post",
				url : "${ctx}/jasperReport/getReport?reportCode=" + reportCode,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						report = data.RETURN_PARAM;
						if (report.config != null && typeof (report.config) != "undefined" && $.trim(report.config) != 0) {
							var config = JSON.parse(report.config);
							if (typeof (config) != "undefined") {
								$.each(config, function(name, value) {
									if (name == "lineCount") {
										lineCount = value;
									}
								});
							}
						}
						initCondition();
					} else {
						showDialogModal("error-div", "操作错误", data.MESSAGE);
						return false;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", "获取报表数据失败：" + errObj);
					return false;
				}
			});
		}

		function initCondition() {
			$.ajax({
				type : "post",
				url : "${ctx}/jasperReport/getReportCondition",
				dataType : "json",
				data : JSON.stringify(report),
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						var datas = data.RETURN_PARAM;
						var jsonData = datas;
						var form = $("#select-form");
						dynamicTableObj = form.dynamicTable({
							items : jsonData,
							lineCount : lineCount,
							method : "all",
							groupId : "table-id",
							setName : true
						});

						var lastTd = $("#table-id > tbody > tr:last > td:last");
						if ($.trim(lastTd.html()).length == 0) {
							lastTd.append($('<button id="btn-query" onclick="loadData(\'true\',0)" type="button" class="btn btn-default btn-common" style="margin-left: 20px; ">查询</button>'));
							lastTd.append($('<button id="btn-download" onclick="exportReport()" type="button" class="btn btn-default btn-common" style="margin-left: 10px;">导出</button>'));
						} else {
							var str = "<tr>";
							for (var i = 0; i < lineCount; i++) {
								str += "<td colspan='2'>";
								if (i == lineCount - 2) {
									str += '<button id="btn-query" onclick="loadData(\'true\',0)" type="button" class="btn btn-default btn-common" style="margin-left: 20px; ">查询</button>';
									str += '<button id="btn-download" onclick="exportReport()" type="button" class="btn btn-default btn-common" style="margin-left: 10px;">导出</button>';
								}
								str += "</td>";
							}
							str += "</tr>";
							$("#table-id > tbody").append($(str));
						}
						loadData("true", 0);
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
		}

		function loadData(reload, page) {
			//var selectData = getFormData("select-form");
			var selectData = dynamicTableObj.getFormData();
			delete selectData.opType;
			delete selectData.chargeTypeName;
			$.ajax({
				type : "post",
				url : "${ctx}/jasperReport/viewReport?fileName=" + report.fileName + "&reload=" + reload + "&pageIndex=" + page + "&reportId=" + report.id,
				data : JSON.stringify(selectData),
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						$("#content-tb").html("");
						$("#content-tb").append(data.RETURN_PARAM);
					} else {
						showDialogModal("error-div", "操作错误", data.MESSAGE);
						return false;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", "数据加载失败：" + errObj);
					return false;
				}
			});
		}
	</script>
</body>
</html>