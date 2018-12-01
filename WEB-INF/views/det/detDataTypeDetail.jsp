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
	border: 1px solid #999;
	width: 240px;
	text-align: center;
	background: #00BFA5;
	color:#FFF;
}
/* background: #98F5FF; */
.tb-attributes th {
	border: 1px solid #999;
	width: 200px;
	text-align: center;
	background: #00BFA5;
	color:#FFF;
}

.tb-dataItems td {
	border: 1px solid #999;
	width: 240px;
	text-align: center;
	background: #FFF;
}

.tb-attributes td {
	border: 1px solid #999;
	width: 200px;
	text-align: center;
	background: #FFF;
}
</style>
<title>数据检测类型详情</title>
</head>
<body>
	<div id="basicType">
		<ul id="myTypeTab" class="nav nav-tabs" style="padding-left: 0px">
			<li class="active"><a href="#baseTypeInfo"
				onclick="loadDetPage(0)" data-toggle="tab">类型基本信息</a></li>
			<li><a href="#modInfo" onclick="loadDetPage(1)"
				data-toggle="tab">对象信息</a></li>
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
						<td align="right" style="width: 100px;">名称：</td>
						<td style="width: 150px;"><input id="name" name="name"
							placeholder="名称" class="form-control" type="text"
							disabled="disabled" style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">编码：</td>
						<td style="width: 150px;"><input id="code" name="code"
							placeholder="编码" class="form-control" type="text"
							disabled="disabled" style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">父类型：</td>
						<td style="width: 150px;"><input id="parentName"
							name="parentName" placeholder="父类型" class="form-control"
							type="text" disabled="disabled" style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">描述信息：</td>
						<td style="width: 150px;"><input id="description"
							name="description" placeholder="描述信息" class="form-control"
							type="text" disabled="disabled" style="width: 150px;" /></td>
					</tr>
				</table>
				<div style="padding-left: 5px;">属性字段</div>
				<table id="tb-attributes" class="tb-attributes" style="">
					<tr>
						<th>属性名称</th>
						<th>属性编码</th>
						<th>排序</th>
						<th>默认值</th>
						<th>是否必写</th>
						<th>是否继承</th>
					</tr>
				</table>

				<div style="padding-left: 5px;">检测项字段</div>
				<table id="tb-dataItems" class="tb-dataItems" style="">
					<tr>
						<th>名称</th>
						<th>编码</th>
						<th>排序</th>
						<th>格式化类型</th>
						<th>是否继承</th>
					</tr>
				</table>

				<table id="queryButtons" style="width: 1370px;">
					<tr style="" id="operation-cust">

					</tr>
				</table>
			</form>
		</div>
		<!-- 对象信息 -->
		<div class="tab-pane fade" id="modInfo"></div>
		<!-- 阀值信息 -->
		<div class="tab-pane fade" id="checkerInfo"></div>
	</div>
</body>
<script type="text/javascript">
	id = "${param.id}";
	var storeTypeList = new Array({
		itemText : "请选择格式化类型",
		itemData : ""
	}, {
		itemText : "文本",
		itemData : "0"
	}, {
		itemText : "浮点型",
		itemData : "1"
	}, {
		itemText : "时间",
		itemData : "2"
	}, {
		itemText : "整数值",
		itemData : "3"
	});

	$(document).ready(function() {
		dataTypeInit();
	});

	function dataTypeInit() {
		$.ajax({
			type : "post",
			url : "${ctx}/alarm-center/detDataTypeManage/listDetDataTypeData?id=" + id,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data != "" && data != undefined) {
					returnData = data;
					dynamicLoad(data);
				}
			},
			error : function(req, error, errObj) {
			}
		});
	}

	function dynamicLoad(data) {
		$(".bute").remove();
		$(".item").remove();
		if (data.name) {
			$("#name").val(data.name);
		}
		if (data.code) {
			$("#code").val(data.code);
		}
		if (data.parentName) {
			$("#parentName").val(data.parentName);
		}else{
			$("#parentName").val("无");
		}
		if (data.description) {
			$("#description").val(data.description);
		}
		var detDataTypeAttribute = data.DetDataTypeAttributes;
		var detDataTypeDataitem = data.DetDataTypeDataitems;
		if (detDataTypeAttribute != null && detDataTypeAttribute != undefined) {
			for (var i = 0; i < detDataTypeAttribute.length; i++) {
				var name = "";
				if (detDataTypeAttribute[i].name != undefined) {
					name = detDataTypeAttribute[i].name;
				}

				var code = "";
				if (detDataTypeAttribute[i].code != undefined) {
					code = detDataTypeAttribute[i].code;
				}

				var orderNo = "";
				if (detDataTypeAttribute[i].orderNo != undefined) {
					orderNo = detDataTypeAttribute[i].orderNo;
				}

				var defaultValue = "";
				if (detDataTypeAttribute[i].defaultValue != undefined) {
					defaultValue = detDataTypeAttribute[i].defaultValue;
				}

				var nullable = "";
				if (detDataTypeAttribute[i].nullable != undefined) {
					if (detDataTypeAttribute[i].nullable == 0) {
						nullable = "否";
					} else {
						nullable = "是";
					}

				}
				var isExtend = "";
				if (detDataTypeAttribute[i].isExtend == true) {
					isExtend = "是";
				} else {
					isExtend = "否";
				}

				html = '<tr class="bute"><td>' + name + '</td><td>' + code + '</td><td>' + orderNo + '</td><td>' + defaultValue + '</td><td>' + nullable + '</td><td>' + isExtend + '</td></tr>'
				$("#tb-attributes").append(html);
			}
		}

		if (detDataTypeDataitem != null && detDataTypeDataitem != undefined) {
			for (var i = 0; i < detDataTypeDataitem.length; i++) {
				var name = "";
				if (detDataTypeDataitem[i].name != undefined) {
					name = detDataTypeDataitem[i].name;
				}

				var code = "";
				if (detDataTypeDataitem[i].code != undefined) {
					code = detDataTypeDataitem[i].code;
				}

				var orderNo = "";
				if (detDataTypeDataitem[i].orderNo != undefined) {
					orderNo = detDataTypeDataitem[i].orderNo;
				}

				var storeType = "";
				if (detDataTypeDataitem[i].storeType != undefined) {
					storeType = detDataTypeDataitem[i].storeType;
					if(storeType == 0){
						storeType = "文本";
					}else if(storeType == 1){
						storeType = "浮点值";
					}else if(storeType == 2){
						storeType = "时间";
					}else if(storeType == 3){
						storeType = "整数值";
					}
				}

				var isExtend = "";
				if (detDataTypeDataitem[i].isExtend == true) {
					isExtend = "是";
				} else {
					isExtend = "否";
				}

				html = '<tr class="item"><td>' + name + '</td><td>' + code + '</td><td>' + orderNo + '</td><td>' + storeType + '</td><td>' + isExtend + '</td></tr>'
				$("#tb-dataItems").append(html);
			}
		}
	}
	$("#btn-add").click(function() {
		type = 1;
		createModalWithLoad("show-addDetails", 1400, 828, "新增数据监测类型详情", "detDataManage/detDataTypeTableDetail", "", "", "");
		$("#show-addDetails-modal").modal('show');
	});

	$("#btn-update").click(function() {
		type = 2;
		createModalWithLoad("show-addDetails", 1400, 828, "修改数据监测类型详情", "detDataManage/detDataTypeTableDetail", "", "", "");
		$("#show-addDetails-modal").modal('show');
	});

	$("#btn-delete").click(function() {
		showDialogModal("error-div", "操作提示", "确认删除该数据监测类型？", 2, "deleteType(" + id + ");");
	});

	function deleteType(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/alarm-center/detDataTypeManage/delete?id=" + id,
			dataType : "json",
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					showDialogModal("error-div", "操作成功", "数据已删除！");
					initializeTree();
					$("#basicType").remove();
					$("#myTypeTabContent").remove();
					html = '<button id="btn-add-highest" type="button" onclick="addNodeType()" class="btn btn-default btn-common btn-common-green" style="margin-left: 3rem;">新增</button>'
					$("#div-content").append(html);
					return;
				} else {
					showDialogModal("error-div", "提示", data.RETURN_PARAM);
					return;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", data.MESSAGE);
			}
		});
	}
	
	function loadDetPage(data) {
		if (data == 1) {
			$("#baseInfoButtons").hide();
			$("#modInfo").empty();
			$("#modInfo").load("${ctx}/detDataManage/detDataMoPage?typeId=" + id);
		} else if (data == 2) {
			$("#baseInfoButtons").hide();
			$("#checkerInfo").empty();
			$("#checkerInfo").load("${ctx}/detDataManage/detThreshold?type=0&typeId=" + id);
		} else if (data == 0) {
			$("#baseInfoButtons").show();
		}

	}
</script>
</html>