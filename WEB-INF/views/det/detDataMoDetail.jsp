<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet"
	type="text/css" />

<style type="text/css">
.tb-dataItems th {
	border: 1px solid #000000;
	width: 240px;
	text-align: center;
	background: #98F5FF;
}

.tb-attributes th {
	border: 1px solid #000000;
	width: 200px;
	text-align: center;
	background: #98F5FF;
}

.tb-dataItems td {
	border: 1px solid #000000;
	width: 240px;
	text-align: center;
	background: #FFF;
}

.tb-attributes td {
	border: 1px solid #000000;
	width: 200px;
	text-align: center;
	background: #FFF;
}
</style>
<title>数据检测对象详情</title>
</head>
<body>
	<div>
		<ul id="myTypeTab" class="nav nav-tabs" style="padding-left: 0px">
			<li class="active"><a href="#baseTypeInfo" id="activeId"
				onclick="loadDetPage(0)" data-toggle="tab">对象基本信息</a></li>
			<li><a href="#checkerInfo" onclick="loadDetPage(2)"
				data-toggle="tab">阀值信息</a></li>
			<li style="float: right;" id="baseInfoButtons"><button
					id="btn-add" type="button"
					class="btn btn-default btn-common btn-common-green"
					style="margin-left: 3rem;">新增</button>
				<button id="btn-update" type="button"
					class="btn btn-default btn-common btn-common-green"
					style="margin-left: 3rem;">修改</button>
				<button id="btn-delete" type="button"
					class="btn btn-default btn-common btn-common-green"
					style="margin-left: 3rem;">删除</button></li>
		</ul>
	</div>
	<div id="myTypeTabContent" class="tab-content" style="">
		<!-- 基本信息 -->
		<div class="tab-pane fade in active" id="baseTypeInfo">
			<form id="data-type-base-forms">
				<input id="id" name="id" style="display: none;" />
				<table>
					<tr>
						<td align="right" style="width: 100px;">对象名称：</td>
						<td style="width: 150px;"><input id="name" name="name"
							placeholder="名称" class="form-control" type="text"
							disabled="disabled" style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">类型：</td>
						<td style="width: 150px;"><input id="typeName"
							name="typeName" placeholder="类型" class="form-control" type="text"
							disabled="disabled" style="width: 150px;" /><input id="typeId"
							name="typeId" placeholder="类型id" class="form-control" type="text"
							disabled="disabled" style="width: 150px; display: none;" /></td>
						<td align="right" style="width: 100px;">第三方标识：</td>
						<td style="width: 150px;"><input id="code" name="code"
							placeholder="第三方标识" class="form-control" type="text"
							disabled="disabled" style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">描述信息：</td>
						<td style="width: 150px;"><input id="description"
							name="description" placeholder="描述信息" class="form-control"
							type="text" disabled="disabled" style="width: 150px;" /></td>
					</tr>
				</table>
				<div style="padding-left: 5px;">属性字段</div>
				<table id="tb-mo-attributes" class="tb-attributes" style="">
					<tr>
						<th>类型编码</th>
						<th>属性值</th>
					</tr>
				</table>

				<table id="queryButtons" style="width: 1370px;">
					<tr style="" id="operation-cust">

					</tr>
				</table>
			</form>
		</div>
		<!-- 阀值信息 -->
		<div class="tab-pane fade" id="checkerInfo"></div>
	</div>
</body>
<div id="show-addDetails"></div>
<script type="text/javascript">
	var id = "${param.id}";
	var moType = "${param.moType}";
	var path = "${param.path}";
	var returnData;
	var type;
	var typeId = 0;
	var moId = 0;
	$(document).ready(function() {
		dataTypeInit();
		if (moType == 1) {
			$("#activeId").html("父对象基本信息");
		}
	});

	function dataTypeInit() {
		$.ajax({
			type : "post",
			url : "${ctx}/alarm-center/detDataMoManage/listDetDataMoData?path=" + path + "&moType=" + moType,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data != "" && data != undefined) {
					returnData = data;
					dynamicLoad(data);
				} else {
					returnData = undefined;
				}
			},
			error : function(req, error, errObj) {
			}
		});
	}

	function dynamicLoad(data) {
		if (!data.detDataMo) {
			return;
		}
		if (data.detDataMo.name) {
			$("#name").val(data.detDataMo.name);
		}
		if (data.detDataMo.code) {
			$("#code").val(data.detDataMo.code);
		}
		if (data.detDataMo.typeName) {
			$("#typeName").val(data.detDataMo.typeName);
		}

		if (data.detDataMo.typeId) {
			$("#typeId").val(data.detDataMo.typeId);
			typeId = data.detDataMo.typeId;
		}

		if (data.detDataMo.description) {
			$("#description").val(data.detDataMo.description);
		}
		if (data.detDataMo.id) {
			moId = data.detDataMo.id;
		}
		var detDataMoAttribute = data.detDataAttributes;
		if (detDataMoAttribute != null && detDataMoAttribute != undefined) {
			for (var i = 0; i < detDataMoAttribute.length; i++) {
				var code = "";
				if (detDataMoAttribute[i].code != undefined) {
					code = detDataMoAttribute[i].code;
				}

				var value = "";
				if (detDataMoAttribute[i].value != undefined) {
					value = detDataMoAttribute[i].value;
				}

				html = '<tr><td>' + code + '</td><td>' + value + '</td></tr>'
				$("#tb-mo-attributes").append(html);
			}
		}
	}
	$("#btn-add").click(function() {
		type = 1;
		createModalWithLoad("show-addDetails", 1400, 828, "新增对象详情", "detDataManage/detDataMoTableDetail", "", "", "");
		$("#show-addDetails-modal").modal('show');
	});

	$("#btn-update").click(function() {
		type = 2;
		createModalWithLoad("show-addDetails", 1400, 828, "修改对象详情", "detDataManage/detDataMoTableDetail", "", "", "");
		$("#show-addDetails-modal").modal('show');
	});

	function loadDetPage(data) {
		if (data == 1) {

		} else if (data == 2) {
			$("#baseInfoButtons").hide();
			$("#checkerInfo").empty();
			$("#checkerInfo").load("${ctx}/detDataManage/detThreshold?type=1&typeId=" + typeId + "&modId=" + moId);
		} else if (data == 0) {
			$("#baseInfoButtons").show();
		}
	}
</script>
</html>