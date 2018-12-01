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
<title>阀值设置</title>
<style type="text/css">
.threshold_table {
	border: 1px solid #cccccc;
}

.checker_table {
	width: 100%;
	border: 1px solid #cccccc;
}

.checker_table th {
	text-align: center;
	background-color: #00BFA5;
	width: 33%;
	border: 1px solid #cccccc;
	color: #FFFFFF;
	height: 30px;
	font-weight: normal;
}

.checker_table td {
	text-align: center;
	border: 1px solid #cccccc;
	color: #000000;
}

.checker_content {
	text-align: center;
	font-size: 20px;
}

.checker_content li {
	line-height: 30px;
	height: 30px;
	cursor: pointer;
}

.editLi:hover {
	background-color: #CFCFCF !important;
}
</style>
</head>
<body>
	<div id="div-tree" style="height: 100%; width: 250px; float: left;">
		<div id="checker_list"
			style="height: 685px; overflow: auto; border: 1px solid #ccc; border-radius: 3px;">
			<div class="left">
				<ul id="checker-content" class="checker_content">

					<li id="addCheckerIcon" class="editLi"
						onclick="createChecker(this);" style=""><span
						class="glyphicon glyphicon-plus" style="cursor: pointer;"></span></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="div-content" style="height: 685px; margin-left: 260px;">
		<form id="threshold_form">
			<table class="threshold_table">
				<tr>
					<td align="right" style="width: 100px;">阀值名称：</td>
					<td colspan="3"><input id="checkName" name="name"
						placeholder="阀值名称" class="form-control" type="text"
						style="width: 420px;" /></td>
					<td style="width: 100px;" colspan="2"><input id="enable"
						style="width: 30px; vertical-align: middle; display: table-cell;"
						type="checkbox" class="form-control required" /><span>禁用该阀值</span></td>

					<td style="width: 20px;"><input id="uuid" name="uuid"
						placeholder="uuid" class="form-control" type="text"
						style="width: 150px; display: none" /> <input id="checkId"
						name="id" placeholder="id" class="form-control" type="text"
						style="width: 150px; display: none" /></td>
				</tr>
				<tr>
					<td align="right" style="width: 100px;">校验表达式：</td>
					<td align="center" colspan="3"><input id="expressionStr"
						placeholder="校验选项" class="form-control" type="text"
						style="width: 420px; display: none;" /><input id="expression"
						name="expression" placeholder="校验选项" class="form-control"
						type="text" style="width: 420px;" /></td>
					<td align="left" colspan="2"
						style="width: 100px; padding-left: 30px;"><button
							id="btn-choose" type="button"
							style="width: 40px; height: 30px; color: #00BFA5;">选择</button> <!-- 							 <input		id="expressionChecker" -->
						<!-- 						style="width: 30px; vertical-align: middle; display: table-cell;" -->
						<!-- 						type="checkbox" class="form-control required" /><span>高级</span> -->
					</td>
				</tr>
				<tr>
					<td align="right" style="width: 100px;">校验时间：</td>
					<td><input id="timePeriod" name="timePeriod"
						placeholder="校验时间" style="width: 150px"
						class="form-control required" type="text" style="" /></td>
					<td align="right" style="width: 100px;">告警编码：</td>
					<td><input id="alarmCode" name="alarmCode" placeholder="告警编码"
						style="width: 150px" class="form-control required" type="text"
						style="" /></td>
				</tr>
				<tr>
					<td align="right" style="width: 100px;">校验器：</td>
					<td colspan="4" style="padding-left: 20px;">
						<table id="checker_table" class="checker_table">

						</table>
					</td>
				</tr>
				<tr>
					<td colspan="5" style="padding-left: 15px;"><input
						id="autoChecker"
						style="width: 50px; vertical-align: middle; display: table-cell;"
						type="checkbox" class="form-control required" /><span>主动校验</span>
						<input
						style="width: 50px; vertical-align: middle; display: table-cell;"
						id="autoDeactive" type="checkbox" class="form-control required"
						onclick="isAutoDeactive(this)" /><span>自动恢复 连续</span><input
						class="form-control required" type="text" id="autoDeactiveTime"
						name="autoDeactiveTime"
						style="vertical-align: middle; display: table-cell; width: 100px; margin-left: 10px; margin-right: 10px;" /><span>秒后恢复</span>
				</tr>
			</table>
		</form>
		<div id="checkerDetail-panel" class="mmGrid" style="display: none;">
			<div
				style="text-align: center; background-color: #00BFA5; width: 660px; color: #FFFFFF; height: 30px; line-height: 30px;">校验器信息</div>
			<div class="mmg-bodyWrapper">
				<table class="mmg-body">
					<tr>
						<td style="width: 170px;">校验器</td>
						<td style="width: 490px;"><div id="checker_type_select"></div></td>
					</tr>
					<tr>
						<td>告警级别</td>
						<td><div id="checker_alarm_level"></div></td>
					</tr>
					<tr>
						<td>连续检测时长</td>
						<td><input id="checkerDetail-time_limit"
							data-param="timeLimit" onblur="modifyCheckerDetail(this)"
							style="width: 300px;" class="form-control" /></td>
					</tr>
					<tr>
						<td>校验时间</td>
						<td><span style="margin-left: 20px;">全天</span></td>
					</tr>

					<tr class="checker_mode_1">
						<td>校验模式</td>
						<td><div id="checkerDetail-mode"></div></td>
					</tr>
					<tr class="checker_mode_2">
						<td>告警内容</td>
						<td><input id="checkerDetail-alarm_content"
							onblur="modifyCheckerDetail(this)" data-param="content"
							style="width: 300px;" class="form-control" /></td>
					</tr>

					<tr class="checker_mode_3">
						<td>允许的最大值</td>
						<td><input data-param="max"
							onblur="modifyCheckerDetail(this)" style="width: 150px;"
							class="form-control" /></td>
					</tr>
					<tr class="checker_mode_3">
						<td>告警内容</td>
						<td><input data-param="upper"
							onblur="modifyCheckerDetail(this)" style="width: 300px;"
							class="form-control" /></td>
					</tr>
					<tr class="checker_mode_3">
						<td>允许的最小值</td>
						<td><input data-param="min"
							onblur="modifyCheckerDetail(this)" style="width: 150px;"
							class="form-control" /></td>
					</tr>
					<tr class="checker_mode_3">
						<td>告警内容</td>
						<td><input data-param="lower"
							onblur="modifyCheckerDetail(this)" style="width: 300px;"
							class="form-control" /></td>
					</tr>

					<tr class="checker_mode_4">
						<td>正则表达式</td>
						<td><input data-param="pattern"
							onblur="modifyCheckerDetail(this)" style="width: 300px;"
							class="form-control" /></td>
					</tr>
					<tr class="checker_mode_5">
						<td>允许最长时差(s)</td>
						<td><input data-param="timeBar"
							onblur="modifyCheckerDetail(this)" style="width: 300px;"
							class="form-control" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div style="margin-top: 10px; width: 660px;">
			<button id="btn-delete-checker" type="button"
				class="btn btn-default btn-common btn-common-green"
				onclick="deleteTips();"
				style="margin-left: 3rem; float: right; display: none;">删除</button>

			<button id="btn-save-checker" type="button"
				class="btn btn-default btn-common btn-common-green"
				onclick="saveChecker();" style="margin-left: 3rem; float: right;">保存</button>
		</div>
	</div>
	<!-- modal弹框 -->
	<div id="dataItem-Modal" class="modal fade">
		<div class="modal-dialog" style="width: 480px; top: 50px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<span id="modal-add-label">选择校验项</span><span id="specialDayLable"
							style="color: red; font-size: 15px; margin-left: 20px;"></span>
					</h4>
				</div>
				<div class="modal-body">
					<table id="tb_dataItem" class="tb_dataItem"
						style="height: 90%; width: 100%; margin: 0 auto; min-width: 550px;">
						<tr>
							<th rowspan="" colspan=""></th>
						</tr>
					</table>
					<div id="pg"></div>
				</div>
				<div class="modal-footer">
					<a href="#" class="btn btn-modal" data-dismiss="modal">取消</a>
				</div>
			</div>
		</div>
	</div>
	<div id="error-div"></div>
	<script type="text/javascript">
		var type = "${param.type}";
		var typeId = "${param.typeId}";
		var uuid = "";
		if (type == '0') {
			uuid = $("#code").val();
			$("#uuid").val(uuid);
		} else if (type == '1') {
			uuid = '${param.modId}';
			$("#uuid").val(uuid);
		}

		var checkerTypeItem = [];
		var checkerTypeMap = new HashMap();
		var checkerTypeList;
		var detCheckerDetails = [];
		var checkerAlarmLevel = new HashMap();
		var showCheckerIndex;
		var checkerAlarmLevelDropDown;
		$(document).ready(function() {
			getCheckerList();
			initDataItem(typeId);
			$("#btn-choose").click(function() {
				$("#dataItem-Modal").modal('show');
				pg.load({
					"page" : 1
				});
				tbDataItem.load();
			});
			loadCheckerTypeAlarmType();
			loadCheckerTable([]);
		});

		//此处的id即类型id
		function initDataItem(id) {
			var celRowIndex;
			var cols = [
					{
						title : '排序',
						name : 'orderNo',
						width : 50,
						sortable : false,
						align : 'left'
					}, {
						title : '数据项名称',
						name : 'name',
						width : 100,
						sortable : false,
						align : 'left'
					}, {
						title : '数据项编码',
						name : 'code',
						width : 100,
						sortable : false,
						align : 'left'
					}, {
						title : '格式化类型',
						name : 'storeType',
						width : 100,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (val == 1) {
								return "文本";
							} else if (val == 2) {
								return "整数型";
							} else if (val == 3) {
								return "浮点型";
							}
						}
					}, {
						title : '操作',
						name : '',
						width : 100,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							var modifyObj = '<a class="calss-modify" href="#" title="选择"><span class="glyphicon glyphicon-check" style="font-size: 12px; color: #777; padding-right: 15px;"></span></a>'
							return modifyObj;

						}
					}

			];
			pg = $('#pg').mmPaginator({
				"limitList" : [
					5
				]
			});
			tbDataItem = $('#tb_dataItem').mmGrid({
				width : '99%',
				height : 300,
				cols : cols,
				url : "${ctx}/alarm-center/detDataTypeManage/listTypeDataItem",
				contentType : "application/json;charset=utf-8",
				method : 'get',
				remoteSort : false,
				multiSelect : true,
				showBackboard : false,
				sortName : 'orderNo',
				sortStatus : 'asc',
				autoLoad : false,
				nowrap : true,
				params : function() {
					var data = {
						"typeId" : id
					};
					return data;
				},
				plugins : [
					pg
				]
			});
			tbDataItem.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				celRowIndex = rowIndex;
				if ($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')) {

				} else if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-check')) {
					var data = "\${" + item.code + "[]}";
					var text = $("#expression").val();
					var textStr = $("#expressionStr").val();
					$("#expression").val(text + data);

					var expressionStr = "检测项[" + item.name + "]";
					$("#expressionStr").val(textStr + expressionStr);
					$("#dataItem-Modal").modal('hide');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {

				}
			}).on('loadSuccess', function(e, data) {
			}).on('loadError', function(req, error, errObj) {
			}).on('dblclick', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				var row = tbDataItem.row(celRowIndex);
				var data = "\${" + row.code + "[]}";
				var text = $("#expression").val();
				var textStr = $("#expressionStr").val();
				var expressionStr = "检测项[" + row.name + "]";
				$("#expression").val(text + data);
				$("#expressionStr").val(textStr + expressionStr);
				$("#dataItem-Modal").modal('hide');
			}).load();
		}

		function saveChecker() {
			if (type.length < 1 || typeId.length < 1) {
				return;
			}
			var detCheckerInfoVO = {};
			var detChecker = getFormData("threshold_form");

			if (detChecker.name.length < 1) {
				showAlert("warning", "名称不能为空！", "checkName", "top");
				return;
			}

			if (detChecker.expression.length < 1) {
				showAlert("warning", "校验表达式不能为空！", "expression", "top");
				return;
			}

			if (detChecker.alarmCode.length < 1) {
				showAlert("warning", "校验表达式不能为空！", "alarmCode", "top");
				return;
			}

			if (type == '0') {//类型下的阀值,保存类型code
				$(detChecker).attr({
					"uuid" : detChecker.uuid.length > 0 ? detChecker.uuid : $("#code").val(),
					"type" : type
				});
			} else if (type == '1') {//对象下的阀值,保存对象id
				$(detChecker).attr({
					"uuid" : detChecker.uuid.length > 0 ? detChecker.uuid : '${param.modId}',
					"type" : type
				});
			}
			var enable = 0;
			var autoDeactive = 0;
			var autoChecker = 0;
			if ($("#enable").is(':checked')) {
				enable = 1;
			}
			if ($("#autoDeactive").is(':checked')) {
				autoDeactive = 1;
				if (detChecker.autoDeactiveTime.length < 1) {
					showAlert("warning", "自动恢复时间不能为空！", "autoDeactiveTime", "top");
					return;
				}
			}
			if ($("#autoChecker").is(':checked')) {
				autoChecker = 1;
			}
			$(detChecker).attr({
				"enable" : enable,
				"autoDeactive" : autoDeactive,
				"autoChecker" : autoChecker,
				"fields" : detChecker.expression
			});

			$(detCheckerInfoVO).attr("detChecker", detChecker);
			$(detCheckerInfoVO).attr("detCheckerDetails", detCheckerDetails);

			$.ajax({
				type : "post",
				url : "${ctx}/alarm-center/detCheckerManage/create",
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(detCheckerInfoVO),
				success : function(data) {
					if (data) {
						getCheckerList();
						showDialogModal("error-div", "操作成功", "保存阀值成功！");
						return;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", data.MESSAGE);
					return;
				}
			});

		}

		function queryDetCheckerDetail(checkerId, obj) {
			$(".editLi").css("background-color", "#FFFFFF");
			$(obj).css("background-color", "#CFCFCF");
			$("#btn-delete-checker").show();
			cleanChecker();
			$.ajax({
				type : "post",
				url : "${ctx}/alarm-center/detCheckerManage/getDetChecker?checkerId=" + checkerId,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data || data != null) {
						var detChecker = data.detChecker;
						detCheckerDetails = data.detCheckerDetails;
						$("#checkName").val(detChecker.name);
						$("#uuid").val(detChecker.uuid);
						detChecker.enable == 1 ? $("#enable").prop("checked", true) : $("#enable").prop("checked", false);
						detChecker.autoDeactive == 1 ? $("#autoDeactive").prop("checked", true) : $("#autoDeactive").prop("checked", false);
						detChecker.autoChecker == 1 ? $("#autoChecker").prop("checked", true) : $("#autoChecker").prop("checked", false);
						$("#timePeriod").val(detChecker.timePeriod);
						$("#autoDeactiveTime").val(detChecker.autoDeactiveTime);
						$("#expression").val(detChecker.expression);
						$("#alarmCode").val(detChecker.alarmCode);
						$("#checkId").val(detChecker.id);
						loadCheckerTable(detCheckerDetails);
						return;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", data.MESSAGE);
					return;
				}
			});
		}

		function cleanChecker() {
			$("#checkName").val("");
			$("#uuid").val("");
			$("#enable").prop("checked", false);
			$("#autoDeactive").prop("checked", false);
			$("#autoChecker").prop("checked", false);
			$("#timePeriod").val("");
			$("#autoDeactiveTime").val("");
			$("#expression").val("");
			$("#alarmCode").val("");
			$("#checkId").val("");
			loadCheckerTable([]);
		}

		function createChecker(obj) {
			$("#btn-delete-checker").hide();
			$(".editLi").css("background-color", "#FFFFFF");
			$(obj).css("background-color", "#CFCFCF");
			cleanChecker();
		}

		function deleteTips() {
			showDialogModal("error-div", "操作提示", "确定要删除该阀值？", 2, "deleteChecker()");
			return;
		}

		function deleteChecker() {
			var checkId = $("#checkId").val();
			$.ajax({
				type : "post",
				url : "${ctx}/alarm-center/detCheckerManage/delete?checkerId=" + checkId,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data) {
						getCheckerList();
						showDialogModal("error-div", "操作成功", data.MESSAGE);
						return;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", data.MESSAGE);
					return;
				}
			});

		}

		function getCheckerList() {
			$("#addCheckerIcon").css("background-color", "#CFCFCF");
			$("#checkerDetail-panel").hide();
			$.ajax({
				type : "post",
				url : "${ctx}/alarm-center/detCheckerManage/getDetCheckerList?type=" + type + "&uuid=" + uuid,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data) {
						$(".dataLi").remove();
						cleanChecker();
						$.each(data, function(i, item) {
							var li = '<li class="editLi dataLi" onclick="queryDetCheckerDetail(' + item.id + ',this)">' + item.name + '</li>';
							$("#checker-content").prepend(li);
						})
						return;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", data.MESSAGE);
					return;
				}
			});
		}

		function loadCheckerTypeAlarmType() {
			$.ajax({
				type : "post",
				url : "${ctx}/alarm-center/staticData/query?typeCode=CHECKER&dataCode=CHECKER_TYPE",
				dataType : "json",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data) {
						$(JSON.parse(data[0].value)).each(function(i, item) {
							checkerTypeItem[checkerTypeItem.length] = {
								itemData : item.handler,
								itemText : item.name
							};
							checkerTypeMap.put(item.handler, item);
						})
					}
				},
				error : function(req, error, errObj) {
				}
			});
			checkerTypeList = $("#checker_type_select").dropDownList({
				inputName : "checker_type_name",
				inputValName : "checker_type_val",
				buttonText : "",
				width : "116px",
				readOnly : false,
				required : true,
				maxHeight : 200,
				onSelect : function(i, data, icon) {
					if (data && typeof (showCheckerIndex) != 'undefined') {
						checkerTypeAlarmInfo(data);
					}
					modifyCheckerDetail();
				},
				items : checkerTypeItem
			});
			if (checkerTypeItem.length > 0) {
				checkerTypeList.setData(checkerTypeItem[0].itemText, checkerTypeItem[0].itemData, '');
			}

			var checkerAlarmLevelItems = [];
			$.ajax({
				type : "post",
				url : "${ctx}/alarm-center/staticData/query?typeCode=CHECKER&dataCode=CHECKER_ALARM_LEVEL",
				dataType : "json",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data) {
						data = JSON.parse(data[0].value)
						for ( var i in data) {
							checkerAlarmLevel.put(i, data[i]);
							checkerAlarmLevelItems[checkerAlarmLevelItems.length] = {
								itemData : i,
								itemText : data[i]
							};
						}
					}
				},
				error : function(req, error, errObj) {
				}
			});

			checkerAlarmLevelDropDown = $("#checker_alarm_level").dropDownList({
				inputName : "checker_alarm_level_name",
				inputValName : "checker_alarm_level_val",
				buttonText : "",
				width : "116px",
				readOnly : false,
				required : true,
				maxHeight : 200,
				onSelect : function(i, data, icon) {
					if (data && typeof (showCheckerIndex) != 'undefined') {
						$(detCheckerDetails[showCheckerIndex]).attr({
							alarmLevel : data
						});
						modifyCheckerDetail();
					}
				},
				items : checkerAlarmLevelItems
			});
			if (checkerAlarmLevelItems.length > 0) {
				checkerAlarmLevelDropDown.setData(checkerAlarmLevelItems[0].itemText, checkerAlarmLevelItems[0].itemData, '');
			}
		}
		function loadCheckerTable(detCheckerDetails) {
			$("#checker_table").html("");
			$("#checker_table").html('<tr>' + '<th>级别</th>' + '<th>校验器</th>' + '<th><button id="btn-add-checker" onclick="addCheckerDetail()" type="button"' + 'style="width: 100px; height: 30px; color: #00BFA5;">' + '新增校验器</button></th>' + '</tr>');
			$(detCheckerDetails).each(function(i, item) {
				var innerHtml = '<tr onclick="showCheckerDetail(' + i + ')"><td>' + checkerAlarmLevel.get(item.alarmLevel) + '</td><td>' + item.name + '</td>' + '<td><button id="btn-add-checker" onclick="deleteCheckerDetail(event,' + i + ')" type="button" style="width: 100px; height: 30px; color: #00BFA5;">删除</button>' + '</td></tr>'
				$("#checker_table").append(innerHtml);
			});
		}
		function deleteCheckerDetail(event, id) {
			event.stopPropagation();
			$("#checker_table tr").each(function(index) {
				if (index - 1 == id) {
					$(this).remove();
				}
			})
			detCheckerDetails.splice(id, 1);
			$("#checkerDetail-panel").hide();
		}
		function addCheckerDetail() {
			var item = {
				alarmLevel : 1,
				name : checkerTypeItem[0].itemText,
				handlerClass : checkerTypeItem[0].itemData
			};
			var index = detCheckerDetails.length;
			detCheckerDetails[detCheckerDetails.length] = item;
			var innerHtml = '<tr onclick="showCheckerDetail(' + index + ')"><td>' + checkerAlarmLevel.get(item.alarmLevel) + '</td><td></td>' + '<td><button id="btn-add-checker" onclick="deleteCheckerDetail(event,' + index + ')" type="button" style="width: 100px; height: 30px; color: #00BFA5;">删除</button>' + '</td></tr>'
			$("#checker_table").append(innerHtml);
		}
		function modifyCheckerDetail(target) {
			if (typeof (showCheckerIndex) == 'undefined') {
				return;
			}
			var item = detCheckerDetails[showCheckerIndex];
			if (!item) {
				return;
			}
			if (!item["paramJson"]) {
				item["paramJson"] = "{}";
			}
			var aramJson = JSON.parse(item["paramJson"]);
			//校验paramJson
			$("#checkerDetail-panel input").each(function() {
				if (this.dataset.param) {
					if (!this.offsetHeight) {
						delete aramJson[this.dataset.param];
					} else {
						if (this.dataset.param == "timeLimit") {
							if(this.value){
								item["timeLimit"] = this.value;
							}else{
								item["timeLimit"] = 0;
							}
						} else {
							aramJson[this.dataset.param] = this.value;
						}
					}
				}
			})
			item["paramJson"] = JSON.stringify(aramJson);
			$("#checker_table tr").each(function(index) {
				if (index - 1 == showCheckerIndex) {
					$(this).children("td:eq(0)").html(checkerAlarmLevel.get(item.alarmLevel));
					$(this).children("td:eq(1)").html(item.name);
				}
			})
		}
		function showCheckerDetail(index) {
			showCheckerIndex = index;
			var item = detCheckerDetails[index];
			console.log(item);
			checkerAlarmLevelDropDown.setData(checkerAlarmLevel.get(item.alarmLevel), item.alarmLevel, '');
			if (item.name) {
				$("#checker_type_name").val(item.name);
			}
			if (item.handlerClass) {
				$("#checker_type_val").val(item.handlerClass);
			}
			checkerTypeAlarmInfo(item.handlerClass);
			if (!item["paramJson"]) {
				item["paramJson"] = "{}";
			}
			var aramJson = JSON.parse(item["paramJson"]);
			$("#checkerDetail-panel input").each(function() {
				if (this.dataset.param) {
					if (aramJson[this.dataset.param]) {
						this.value = aramJson[this.dataset.param];
					} else {
						this.value = '';
					}
				}
			})
			if (item.timeLimit) {
				$("#checkerDetail-time_limit").val(item.timeLimit);
			}

			$("#checkerDetail-panel").show();
		}
		//根据校验器类型改变表单内容
		function checkerTypeAlarmInfo(data) {
			var checkerType = checkerTypeMap.get(data);
			$(detCheckerDetails[showCheckerIndex]).attr({
				name : checkerType.name,
				handlerClass : checkerType.handler
			});
			if (checkerType.type.indexOf("1") > -1) {
				$(".checker_mode_1").each(function() {
					$(this).show();
				});
				var checkerModeItems = [
						{
							itemText : checkerType.mode[0],
							itemData : 0
						}, {
							itemText : checkerType.mode[1],
							itemData : 1
						}
				];
				var item = detCheckerDetails[showCheckerIndex];
				if (!item["paramJson"]) {
					item["paramJson"] = "{}";
				}
				var aramJson = JSON.parse(item["paramJson"]);
				if (aramJson["type"]) {
					checkerModeItems[aramJson["type"]]["Selected"] = true;
				} else {
					checkerModeItems[0]["Selected"] = true;
				}
				$("#checkerDetail-mode").dropDownList({
					inputName : "checkerDetail-mode_name",
					inputValName : "checkerDetail-mode_val",
					buttonText : "",
					width : "116px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (typeof (data) != 'undefined' && typeof (showCheckerIndex) != 'undefined') {
							console.log(aramJson["type"]);
							aramJson["type"] = data;
							item["paramJson"] = JSON.stringify(aramJson);
						}
					},
					items : checkerModeItems
				});
			} else {
				$(".checker_mode_1").each(function() {
					$(this).hide();
				});
			}
			for (var i = 2; i < 6; i++) {
				if (checkerType.type.indexOf("" + i) > -1) {
					$(".checker_mode_" + i).each(function() {
						$(this).show();
					});
				} else {
					$(".checker_mode_" + i).each(function() {
						$(this).hide();
					});
				}
			}
		}
		function isAutoDeactive(obj) {
			if (obj.checked) {
				$("#autoDeactiveTime").val("0");
			} else {
				$("#autoDeactiveTime").val("");
			}

		}
	</script>
</body>
</html>