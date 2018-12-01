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
<script type="text/javascript"
	src="${ctx}/static/js/jquery.ztree.exhide.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/busi/detDataTypeTree.js"></script>

<style>
.treeFieldName input::-ms-clear {
	display: none;
}

.ownerRole {
	display: none;
}

div.tree-selecter .treeContent {
	width: 160px !important;
	max-height: 300px;
	overflow-y: auto;
	overflow-x: hidden;
}

@media only screen and (max-width: 1024px) {
	div.tree-selecter .treeContent {
		width: 150px !important;
	}
	.detDataMoStyle {
		width: 150px !important;
	}
	#queryButtons {
		width: 550px !important;
	}
	.mmg-message {
		left: 323px !important;
	}
}

@media only screen and (max-width: 1366px) and (min-width:1025px) {
	div.tree-selecter .treeContent {
		width: 224px !important;
	}
	.detDataMoStyle {
		width: 224px !important;
	}
	#queryButtons {
		width: 825px !important;
	}
	.mmg-message {
		left: 492.5px !important;
	}
}

@media only screen and (min-width:1367px) {
	div.tree-selecter .treeContent {
		width: 224px !important;
	}
	.detDataMoStyle {
		width: 224px !important;
	}
	#queryButtons {
		width: 1370px !important;
	}
	.mmg-message {
		left: 769.5px !important;
	}
}

#myTab li {
	margin: 0 5px 0 0;
	background-color: #D7D7D7;
}

.nav-tabs {
	height: 32px;
}

.treeFieldName input::-ms-clear {
	display: none;
}

.nav-tabs>li.active>a, .nav>li.active>a:hover, .nav>li.active>a:focus {
	border-width: 2px 0px 0px 2px !important;
}
/* #myTab li.active { */
/* border-width: 2px 0px 0px 2px ; */
/* } */
.houseHolder {
	display: none;
}

.detDataMoStyle {
	width: 224px !important;
}

.rib-block {
	display: -webkit-inline-box;
	height: 37px;
	display: -moz-inline-box; /* 火狐游览器版本低时使用 */
	/* 	line-height: 37px; */
}

.rib-block table {
	width: 100%;
	height: 100%;
}

.rib-block td {
	text-align: right;
	width: 100px;
}
</style>
<title>数据检测对象</title>
</head>
<body>
	<div>
		<ul id="myTab" class="nav nav-tabs" style="padding-left: 0px">
			<li class="active"><a href="#baseInfo" onclick="" id="basicId"
				data-toggle="tab">对象基本信息</a></li>
			<li id="attrLi"><a href="#attributes" onclick=""
				data-toggle="tab">属性</a></li>
		</ul>
	</div>
	<div id="myTabContent" class="tab-content" style="">
		<!-- 基本信息 -->
		<div class="tab-pane fade in active" id="baseInfo">
			<form id="data-type-base-forms">
				<input id="id" name="id" style="display: none;" />
				<table>
					<tr>
						<td align="right" style="width: 100px;">父对象</td>
						<td style="width: 150px;"><input id="parentName"
							name="parentName" placeholder="所属对象" class="form-control"
							type="text" style="width: 150px;" disabled="true" /></td>
					</tr>
					</tr>
					<td align="right" style="width: 100px;">对象类型：</td>
					<td>
						<div id="detDataMoTra" style="height: 35px;" class="tree-selecter">
							<div class="input-group">
								<input id="menu_id" name="menu_id" class="treeFieldId"
									type="hidden" style="display: none;" value=""> <input
									id="menu_name" type="text" value=""
									class="form-control treeFieldName detDataMoStyle"
									style="width: 120px;" placeholder="类型" autocomplete="off">
								<div class="treeContent box-borderd">
									<ul id="tree" class="ztree"></ul>
								</div>
								<span class="input-group-btn selecter"> <a id="clearBtn"
									href="#" class="clearBtn" hidden="true"><span
										class="glyphicon glyphicon-remove"
										style="font-size: 1rem; color: #6e6868e6; margin-top: 3px;"></span></a></span>
							</div>
						</div>
					</td>
					</tr>
					<tr>
						<td align="right" style="width: 100px;">第三方标识：</td>
						<td style="width: 150px;"><input id="moCode" name="moCode"
							placeholder="第三方标识" class="form-control" type="text"
							style="width: 150px;" /></td>
					</tr>
					<tr>
						<td align="right" style="width: 100px;">名称：</td>
						<td style="width: 150px;"><input id="detDataMoId"
							name="detDataMoName" placeholder="名称" class="form-control"
							type="text" style="width: 150px;" /></td>
					</tr>

					<tr>
						<td align="right" style="width: 100px;">描述信息：</td>
						<td colspan="3"><input id="moDescription"
							name="moDescription" placeholder="描述信息" class="form-control"
							type="text" style="width: 421px;" /></td>
					</tr>
				</table>
				<table id="queryButtons" style="width: 1370px;">
					<tr style="" id="operation-cust">

					</tr>
				</table>
			</form>
			<button id="btn-type" type="button"
				class="btn btn-default btn-common btn-common-green"
				style="position: absolute; left: 55rem; top: 60rem;">保存</button>
		</div>
		<!-- end -->

		<!-- start 属性开始 -->
		<div class="tab-pane fade2" id="attributes">
			<div id="pgAttributes" style="text-align: right;">
				<table id="tb-attributes" class="tb-pay" style="">
					<tr id="att-tr-1">
						<!-- 						<td align="right" style="width: 100px;">编码：</td> -->
						<td style="width: 150px;"><input id="attCode1"
							name="attCode1" placeholder="编码" class="form-control"
							type="hidden" style="width: 150px;" /></td>
						<td align="right" style="width: 60px;">名称：</td>
						<td style="width: 150px;"><input id="attName1" name="attName"
							placeholder="名称" class="form-control" type="text"
							style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">属性值：</td>
						<td style="width: 150px;"><input id=attValue1
							name="attValue1" placeholder="属性值" class="form-control"
							type="text" style="width: 150px;" /></td>
						<!-- 						<td><span class="glyphicon glyphicon-minus" aria-hidden="true" -->
						<!-- 							onclick="deleteAttribute()" style="left: 30px; cursor: pointer;"></span></td> -->
						<!-- 						<td><span class="glyphicon glyphicon-plus" aria-hidden="true" -->
						<!-- 							onclick="addAttribute()" style="left: 60px; cursor: pointer;"></span></td> -->
					</tr>
				</table>
			</div>
			<button id="btn-attribute" type="button"
				class="btn btn-default btn-common btn-common-green"
				style="position: absolute; left: 55rem; top: 60rem;">保存</button>
		</div>
		<!-- end -->

	</div>
</body>
<script type="text/javascript">
	var num = 1;
	var idNum = 1;
	if (typeof (returnData) != "undefined") {
		var parentName = returnData.parentModName;
		$("#parentName").val(parentName);
	}
	var moId;
	$(document).ready(function() {
		setLableAble();
		if (type == 2) {
			updateTypeData();
		}
 		$("#attrLi").hide();
		getDetDataMoTree("detDataMoTra");
	});

	function getDetDataMoTree(id) {
		treeSelecterByURL2('${ctx}/alarm-center/detDataTypeManage/queryTreeList', '#baseInfo #' + id, 'POST');
	}
	$("#btn-type").click(function() {
		var createDetDataMoVO = {};
		var name = $("#detDataMoId").val();
		if (name != "" && name != undefined) {
			$(createDetDataMoVO).attr({
				"name" : name
			});
		}

		var code = $("#moCode").val();
		if (code != "" && code != undefined) {
			$(createDetDataMoVO).attr({
				"code" : code
			});
		}

		var typeId = $("#menu_id").val();
		if (typeId != "" && typeId != undefined) {
			$(createDetDataMoVO).attr({
				"typeId" : typeId
			});
		}

		var description = $("#moDescription").val();
		if (description != "" && description != undefined) {
			$(createDetDataMoVO).attr({
				"description" : description
			});
		}
		var id = $("#id").val();
		if (id != "" && id != undefined) {
			$(createDetDataMoVO).attr({
				"id" : id
			});
		}
		
		if (typeof (returnData) != "undefined") {
			var path = returnData.detDataMo.path;
			if (path != "" && path != undefined) {
				$(createDetDataMoVO).attr({
					"path" : path
				});
			}
		} else {
			$(createDetDataMoVO).attr({
				"path" : "-1"
			});
		}
		$.ajax({
			type : "post",
			url : "${ctx}/alarm-center/detDataMoManage/create",
			data : JSON.stringify(createDetDataMoVO),
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data.CODE == 'SUCCESS') {
					showDialogModal("error-div", "操作成功", "操作成功");
					moId = data.RETURN_PARAM.id;
					setLableDisable();
					initializeTree();
					return true;
				} else {
					showDialogModal("error-div", "操作错误", data.RETURN_PARAM);
					return false;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	});

	function updateTypeData() {
		if (!returnData || !returnData.detDataMo) {
			return;
		}
		if (returnData.detDataMo.name) {
			$("#detDataMoId").val(returnData.detDataMo.name);
		}
		if (returnData.detDataMo.code) {
			$("#moCode").val(returnData.detDataMo.code);
			$("#moCode").attr("disabled","disabled");
		}
		if (returnData.detDataMo.description) {
			$("#moDescription").val(returnData.detDataMo.description);
		}
		if (returnData.detDataMo.typeName) {
			$("#menu_name").val(returnData.detDataMo.typeName);
			$("#menu_name").attr("disabled","disabled");
		}
		if(returnData.detDataMo.typeId){
			$("#menu_id").val(returnData.detDataMo.typeId);
		}
		
		if (returnData.detDataMo.id) {
			$("#id").val(returnData.detDataMo.id);
		}
		var detDataMoAttributes = returnData.detDataAttributes;

		if (detDataMoAttributes != null && detDataMoAttributes != undefined && detDataMoAttributes.length != 0) {
			num = detDataMoAttributes.length;
			idNum = detDataMoAttributes.length;
			$("#att-tr-1").remove();
			for (var i = 1; i < detDataMoAttributes.length + 1; i++) {
				if (i > 1) {
					$("#add").remove();
				}
				html = '<tr id="tr-'+i+'"><td style="width:20px;display:none"><input id="attId'+i+'" type="text" style="width:20px;"/></td>' + '<td align="right" style="width: 100px;">名称：</td>' + '<td style="width: 150px;"><input id="attCode'+i+'" name="attCode" placeholder="名称" class="form-control" type="text" style="width: 150px;" /></td>' + '<td align="right" style="width: 100px;">属性值：</td>' + '<td style="width: 150px;"><input id="attValue'+i+'" name="attValue" placeholder="属性值" class="form-control" type="text" style="width: 150px;" /></td>' + '<td id="delete'+i+'"><span class="glyphicon glyphicon-minus" aria-hidden="true" onclick="deleteAttribute(' + i + ')" style="left: 30px; cursor: pointer;"></span></td>' + '<td id="add"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addAttribute()" style="left: 60px; cursor: pointer;"></span></td>' + '</tr>'
				$("#tb-attributes").append(html);
				var attId = "#attId" + i;
				var attCode = "#attCode" + i;
				var attValue = "#attValue" + i;

				if (detDataMoAttributes[i - 1].code != undefined) {
					$(attCode).val(detDataMoAttributes[i - 1].code);
				}

				if (detDataMoAttributes[i - 1].value != undefined) {
					$(attValue).val(detDataMoAttributes[i - 1].value);
				}
			}
		}
	}
	$("#btn-attribute").click(function() {
		var ary = new Array();
		var createDetDataMoVO = {};
		var detDataAttributeList = new Array();
		for (var i = 1; i < idNum + 1; i++) {
			var detDataAttribute = {};
			var attCode = "#attCode" + i;
			var attValue = "#attValue" + i;
			var code = $(attCode).val();
			ary.push(code);

			$(detDataAttribute).attr({
				"code" : $(attCode).val()
			});
			$(detDataAttribute).attr({
				"value" : $(attValue).val()
			});
			if (typeof (moId) == "undefined") {

			}
			$(detDataAttribute).attr({
				"moId" : moId
			});
			detDataAttributeList.push(detDataAttribute);

		}
		$(createDetDataMoVO).attr({
			"detDataAttributes" : detDataAttributeList
		});
		$.ajax({
			type : "post",
			url : "${ctx}/alarm-center/detDataMoManage/createAttribute",
			data : JSON.stringify(createDetDataMoVO),
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					showDialogModal("error-div", "操作成功", "操作成功");
					return true;
				} else {
					showDialogModal("error-div", "操作错误", data.RETURN_PARAM);
					return false;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});

	});
	function setLableDisable() {
		$("#menu_name").attr("disabled", true);
		$("#moCode").attr("disabled", true);
		$("#detDataMoId").attr("disabled", true);
		$("#moDescription").attr("disabled", true);
		$('#btn-type').attr('disabled', true);
	}
	function setLableAble() {
		$("#menu_name").attr("disabled", false);
		$("#moCode").attr("disabled", false);
		$("#detDataMoId").attr("disabled", false);
		$("#moDescription").attr("disabled", false);
		$('#btn-type').attr('disabled', false);
	}
	function dataTypeInit(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/alarm-center/detDataTypeManage/listDetDataTypeData?id=" + id,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data != "" && data != undefined) {
					dynamicLoad(data);
				}
			},
			error : function(req, error, errObj) {
			}
		});
	}

	function dynamicLoad(data) {
		var detDataMoAttributes = data.DetDataTypeAttributes;
		if (detDataMoAttributes != null && detDataMoAttributes != undefined && detDataMoAttributes.length != 0) {
			num = detDataMoAttributes.length;
			idNum = detDataMoAttributes.length;
			$("#att-tr-1").remove();
			for (var i = 1; i < detDataMoAttributes.length + 1; i++) {
				if (i > 1) {
					$("#add").remove();
				}
				html = '<tr id="tr-'+i+'"><td style="width:20px;display:none"><input id="attCode'+i+'" type="text" style="width:20px;"/></td>' + '<td align="right" style="width: 100px;">名称：</td>' + '<td style="width: 150px;"><input id="attName'+i+'" name="attName" placeholder="名称" class="form-control" type="text" style="width: 150px;" /></td>' + '<td align="right" style="width: 100px;">属性值：</td>' + '<td style="width: 150px;"><input id="attValue'+i+'" name="attValue" placeholder="属性值" class="form-control" type="text" style="width: 150px;" /></td>' + '</tr>'
				$("#tb-attributes").append(html);
				var attId = "#attId" + i;
				var attCode = "#attCode" + i;
				var attName = "#attName" + i;
				var attValue = "#attValue" + i;

				if (detDataMoAttributes[i - 1].name != undefined) {
					$(attName).val(detDataMoAttributes[i - 1].name);
				}

				if (detDataMoAttributes[i - 1].value != undefined) {
					$(attValue).val(detDataMoAttributes[i - 1].value);
				}

				if (detDataMoAttributes[i - 1].code != undefined) {
					$(attCode).val(detDataMoAttributes[i - 1].code);
				}
			}
		}
	}
</script>
</html>