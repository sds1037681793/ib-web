<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>测试页面</title>
</head>
<body>
	<form id="select-form"></form>
	<input type="button" id="btn" value="Click" />
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
</body>
<script type="text/javascript">
	var dynamicTableObj;
	//var jsonData = {"ownerType":"2","filter":"1","formCode":"TEST"};
	var jsonData = {
		"ownerType" : "1",
		"formCode" : "TEST"
	};
	$(document).ready(function() {
		$.ajax({
			type : "post",
			url : "${ctx}/param/getDefine",
			data : "params=" + JSON.stringify(jsonData),
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					var datas = data.RETURN_PARAM;
					var jsonData = datas;
					var form = $("#select-form");
					dynamicTableObj = form.dynamicTable({
						items : jsonData,
						lineCount : 4,
						dateFormat : "YYYY-mm-dd hh:mm:ss",
						method : "all",
						groupId : "table-id",
						setName : true
					});
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

		$("#btn").on("click", function() {
			alert(JSON.stringify(dynamicTableObj.getFormData()));
		});
	});
</script>
</html>