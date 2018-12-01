<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<script type="text/javascript" src="${ctx}/static/component/jquery.dragsort/js/jquery.dragsort-0.5.2.min.js"></script>
<style>
.mmGrid .mmg-first {
	width: 30px;
	max-width: 100px;
	text-align: center;
	padding-left: 15px !important;
}

.mmGrid .mmg-input {
	width: 120px;
	max-width: 100px;
	text-align: center;
}

.mmGrid .mmg-input-long {
	width: 180px;
	max-width: 180px;
	text-align: center;
}

.mmGrid .mmg-input-middle {
	width: 140px;
	max-width: 140px;
	text-align: center;
}

.mmGrid .mmg-checkbox {
	width: 80px;
	max-width: 150px;
	text-align: center;
}

.mmGrid .mmg-select {
	width: 150px;
	max-width: 150px;
	text-align: center;
}

.mmGrid .mmg-select-long {
	width: 190px;
	max-width: 190px;
	text-align: center;
}

.mmGrid .mmg-span {
	width: 100px;
	max-width: 100px;
	text-align: center;
}

.mmGrid .mmg {
	width: 100px;
	max-width: 100px;
	text-align: center;
}
</style>
<div class="content-default">
	<table>
		<tr>
			<td width="100" align="right">查询SQL：</td>
			<td width="400">
				<textarea id="querySql" name="querySql" placeholder="查询SQL" class="form-control required" style="width: 650px; height: 80px;"></textarea>
			</td>
			<td>
				<button id="generateReport" type="button" class="btn btn-default btn-common" style="margin-left: 20px;">生成</button>
				<button id="btn-clear" type="button" class="btn btn-default btn-common">清空</button>
			</td>
		</tr>
	</table>
</div>
<div id="reportDiv" style="display: none">
	<form id="cust-center-form">
		<div class="content-default">
			<div style="font-size: 16px;">
				<span>基本信息</span>
			</div>
			<input id="id" name="id" style="display: none;" />
			<div style="border: 1px solid #E1E1E1; border-radius: 5px; padding: 20px; margin-top: 5px;">
				<table id="cust-center-table" style="border: 0px solid #E1E1E1; padding: 10px 0px 10px 0px;">
					<tbody>
						<tr>
							<td align="right" width="80">报表名称：</td>
							<td>
								<input id="reportName" name="reportName" placeholder="报表名称" class="form-control " style="width: 150px;" type="text">
							</td>
							<td align="right" width="80">报表编号：</td>
							<td>
								<input id="formCode" name="formCode" placeholder="报表编号" class="form-control" style="width: 150px;" type="text">
							</td>
							<td align="right" width="80">显示行数：</td>
							<td>
								<input id="rowlimit" name="rowlimit" placeholder="显示行数" class="form-control " style="width: 150px;" type="text">
							</td>
							<td align="right" width="80">列表高度：</td>
							<td>
								<input id="height" name="height" placeholder="列表高度" class="form-control " style="width: 150px;" type="text">
							</td>
							<td align="right" width="100">导出文件名：</td>
							<td>
								<input id="exportFileName" name="exportFileName" placeholder="导出文件名" class="form-control " style="width: 150px;" type="text">
							</td>
							<td align="right" width="100">导出最大数：</td>
							<td>
								<input id="exportMaxNum" name="exportMaxNum" placeholder="导出最大数" class="form-control " style="width: 150px;" type="text">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="content-default">
			<div style="font-size: 16px;">
				<span>查询条件</span>
			</div>
			<div style="width: auto; height: auto; margin-bottom: 10px" class="mmGrid">
				<div class="mmg-headWrapper">
					<table style="left: 0px;" class="mmg-head">
						<thead>
							<tr>
								<th class="mmg-first" rowspan="1" colspan="1" data-colindex="0">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">序号</span>
									</div>
								</th>
								<th class="mmg-span" rowspan="1" colspan="1" style="" data-colindex="1">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">条件编码</span>
									</div>
								</th>
								<th class="mmg-input-middle" rowspan="1" colspan="1" data-colindex="2">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">条件名称</span>
									</div>
								</th>
								<th class="mmg-select" rowspan="1" colspan="1" data-colindex="3">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">查询类型</span>
									</div>
								</th>
								<th class="mmg-select-long" rowspan="1" colspan="1" data-colindex="4">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">展示类型</span>
									</div>
								</th>
								<th class="mmg-select" rowspan="1" colspan="1" data-colindex="4">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">数据类型</span>
									</div>
								</th>
								<th class="mmg-input-long" rowspan="1" colspan="1" data-colindex="5">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">处理类</span>
									</div>
								</th>
								<th class="mmg-input-long" rowspan="1" colspan="1" data-colindex="6">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">处理数据</span>
									</div>
								</th>
							</tr>
						</thead>
					</table>
				</div>
				<div style="height: auto; width: auto;" class="mmg-bodyWrapper">
					<table id="conditionTable" class="tb_operators mmg-body">
						<tr class="modelTitle">
							<td class="mmg-first">
								<span class="">1</span>
							</td>
							<td class="mmg-span">
								<span class="">organizeName</span>
							</td>
							<td class="mmg-input">
								<input id="querySql1" type="text" placeholder="条件名称" class="form-control required" style="width: 80px; margin-left: auto;" />
							</td>
							<td class="mmg-input">
								<input id="querySql1" type="text" placeholder="null" class="form-control required" style="width: 80px; margin-left: auto;" />
							</td>
							<td class="mmg-select">
								<div id="type-dropdownlist" class="type-dropdownlist"></div>
							</td>
							<td class="mmg-input">
								<input id="querySql1" type="text" placeholder="处理类" class="form-control required" style="width: 80px; margin-left: auto;" />
							</td>
							<td class="mmg-input">
								<input id="querySql1" type="text" placeholder="处理数据" class="form-control required" style="width: 80px; margin-left: auto;" />
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="content-default">
			<div style="font-size: 16px;">
				<span>展示列信息</span>
			</div>
			<div style="width: auto; height: auto" class="mmGrid">
				<div class="mmg-headWrapper">
					<table style="left: 0px;" class="mmg-head">
						<thead>
							<tr>
								<th class="mmg-first" rowspan="1" colspan="1" data-colindex="0">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">序号</span>
									</div>
								</th>
								<th class="mmg-span" rowspan="1" colspan="1" style="" data-colindex="1">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">属性名</span>
									</div>
								</th>
								<th class="mmg-input-middle" rowspan="1" colspan="1" data-colindex="2">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">列名</span>
									</div>
								</th>
								<th class="mmg-input " rowspan="1" colspan="1" data-colindex="3">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">列宽</span>
									</div>
								</th>
								<th class="mmg-checkbox" rowspan="1" colspan="1" data-colindex="5">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">显示列</span>
									</div>
								</th>
								<th class="mmg-checkbox" rowspan="1" colspan="1" data-colindex="6">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">导出列</span>
									</div>
								</th>
								<th class="mmg-checkbox" rowspan="1" colspan="1" data-colindex="7">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">合计列</span>
									</div>
								</th>
								<th class="mmg-select" rowspan="1" colspan="1" data-colindex="7">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">合计类型</span>
									</div>
								</th>
								<th class="mmg-input" rowspan="1" colspan="1" data-colindex="7">
									<div class="mmg-titleWrapper">
										<span class="mmg-title mmg-canSort ">合计列名</span>
									</div>
								</th>
							</tr>
						</thead>
					</table>
				</div>
				<div style="height: auto; width: auto;" class="mmg-bodyWrapper">
					<table id="colTable" class="tb_operators mmg-body">
						<tr class="modelTitle">
							<td class="mmg-first">
								<span class="">1</span>
							</td>
							<td class="mmg-span">
								<span class="">user_id</span>
							</td>
							<td class="mmg-input">
								<input id="querySql1" type="text" placeholder="列名" class="form-control required" style="width: 80px; margin-left: auto;" />
							</td>
							<td class="mmg-input">
								<input id="querySql1" type="text" placeholder="列宽" value="140" class="form-control required" style="width: 80px; margin-left: auto;" />
							</td>
							<td class="mmg-checkbox">
								<div class="checker" style="float: none;">
									<span style="margin-left: auto;">
										<input id="TEMPORARY_VEHICLE_0" name="TEMPORARY_VEHICLE" value="1" style="opacity: 0;" type="checkbox">
									</span>
								</div>
							</td>
							<td class="mmg-checkbox">
								<div class="checker" style="float: none;">
									<span style="margin-left: auto;">
										<input id="TEMPORARY_VEHICLE_0" name="TEMPORARY_VEHICLE" value="1" style="opacity: 0;" type="checkbox">
									</span>
								</div>
							</td>
							<td class="mmg-checkbox">
								<div class="checker" style="float: none;">
									<span style="margin-left: auto;">
										<input id="TEMPORARY_VEHICLE_0" name="TEMPORARY_VEHICLE" value="1" style="opacity: 0;" type="checkbox">
									</span>
								</div>
							</td>
							<td class="mmg-select">
								<input id="querySql1" type="text" placeholder="列名" class="form-control required" style="width: 80px; margin-left: auto;" />
							</td>
							<td class="mmg-input">
								<input id="querySql1" type="text" placeholder="合计列名" value="140" class="form-control required" style="width: 80px; margin-left: auto;" />
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>
	<div class="content-default" style="text-align: center;">
		<button id="previewReport" type="button" class="btn btn-default btn-common">预览</button>
		<button id="saveReport" type="button" class="btn btn-default btn-common">保存</button>
	</div>
</div>
<div id="edit-oper"></div>
<div id="select-org"></div>
<div id="ext-operation-div"></div>
<div id="error-div"></div>
<script type="text/javascript">
	var previewObject = new Array();
	//多选框字段数组
	var checkBoxObjects = new Array();
	// 下拉列表字段数组
	var dropdownlistObjects = new Array();
	var ddlItems = new Array();
	ddlItems[0] = {
		name : " ",
		value : ""
	};
	ddlItems[1] = {
		name : "文本",
		value : "1"
	};
	ddlItems[2] = {
		name : "日期",
		value : "8"
	};
	ddlItems[3] = {
		name : "单选框",
		value : "6"
	};
	ddlItems[4] = {
		name : "复选框",
		value : "7"
	};
	ddlItems[5] = {
		name : "下拉框（静态）",
		value : "5"
	};
	ddlItems[6] = {
		name : "下拉框（sql）",
		value : "15"
	};
	ddlItems[7] = {
	    name : "下拉选择树",
	    value : "16"
	};
	//1正常，2右模糊，3左模糊，4全模糊
	var searchTypeItems = new Array();
	searchTypeItems[0] = {
		name : " ",
		value : ""
	};
	searchTypeItems[1] = {
		name : "正常",
		value : "1"
	};
	searchTypeItems[2] = {
		name : "右模糊",
		value : "2"
	};
	searchTypeItems[3] = {
		name : "左模糊",
		value : "3"
	};
	searchTypeItems[4] = {
		name : "全模糊",
		value : "4"
	};
	//1数字，2字符
	var dataTypeItems = new Array();
	dataTypeItems[0] = {
		name : " ",
		value : ""
	};
	dataTypeItems[1] = {
		name : "数字",
		value : "1"
	};
	dataTypeItems[2] = {
		name : "字符",
		value : "2"
	};

	//合计类型：1整数，2小数
	var sumTypeItems = new Array();
	sumTypeItems[0] = {
		name : " ",
		value : ""
	};
	sumTypeItems[1] = {
		name : "整数",
		value : "Long"
	};
	sumTypeItems[2] = {
		name : "小数",
		value : "BigDecimal"
	};

	$(document).ready(function() {
		//生成按钮
		$('#generateReport').on('click', function(event) {
			generateReport(checkBoxObjects);
		});
		$('#saveReport').on('click', function(event) {
			saveReport();
		});

		$('#previewReport').on('click', function(event) {
			previewReport();
		});

		$('#btn-clear').on('click', function(event) {
			clearQuerySql();
		});
	});

	function clearQuerySql() {
		document.getElementById("querySql").value = "";
		document.getElementById("reportDiv").style.display = "none";
	}

	//生成报表配置
	function generateReport() {
		checkBoxObjects = new Array();
		dropdownlistObjects = new Array();
		var sql = $('#querySql').val();
		if (sql == "" || typeof (sql) == undefined) {
			showDialogModal("error-div", "操作错误", "请输入查询sql");
		}
		$.ajax({
			type : "post",
			url : "${ctx}/report/analyse",
			dataType : "json",
			data : sql,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data.RETURN_PARAM != undefined) {
					analyseResult(data.RETURN_PARAM);
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "解析sql错误：" + errObj);
			}
		});

	}

	function previewReport() {
		previewObject = new Object();
		if (!checkAndGetReport(previewObject)) {
			return;
		}
		createModalWithLoad("edit-oper", 1300, 0, "预览报表", "report/previewReport", "saveOperator()", "confirm-close");
		$("#edit-oper-modal").modal('show');
	}

	function closePreviewReportModal() {
		$("#edit-oper-modal").modal('hide');
	}

	function saveReport() {
		var resultObject = new Object();
		if (!checkAndGetReport(resultObject)) {
			return;
		}
		$.ajax({
			type : "post",
			url : "${ctx}/report/create",
			dataType : "json",
			data : JSON.stringify(resultObject),
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					showDialogModal("error-div", "保存成功", "保存成功，菜单路径为：/report/view/" + data.RETURN_PARAM.id);
					return;
				} else {
					showDialogModal("error-div", "保存失败", data.MESSAGE);
					return;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
			}
		});
	}

	/**
	 * 检查和获取报表配置
	 */
	function checkAndGetReport(obj) {
		var reportName = $('#reportName').val();
		if (reportName == "") {
			showDialogModal("error-div", "操作错误", "请输入报表名称");
			return false;
		}
		var querySql = $('#querySql').val();
		var formCode = $('#formCode').val();
		if (formCode == "") {
			showDialogModal("error-div", "操作错误", "请输入报表编号");
			return false;
		}
		var rowlimit = $('#rowlimit').val();
		if (rowlimit == "") {
			showDialogModal("error-div", "操作错误", "请输入显示行数");
			return false;
		}
		if (isNumber(rowlimit)) {
			showDialogModal("error-div", "操作错误", "显示行数必须为数字");
			return false;
		}
		var exportFileName = $('#exportFileName').val();
		if (exportFileName == "") {
			showDialogModal("error-div", "操作错误", "请输入导出文件名");
			return false;
		}
		var height = $('#height').val();
		if (height == "") {
			showDialogModal("error-div", "操作错误", "请输入列表高度");
			return false;
		}
		if (isNumber(height)) {
			showDialogModal("error-div", "操作错误", "列表高度必须为数字");
			return false;
		}
		if ($('#exportMaxNum').val() != "" && isNumber($('#exportMaxNum').val())) {
			showDialogModal("error-div", "操作错误", "导出最大数必须为数字");
			return false;
		}
		obj.reportName = reportName;
		obj.querySql = querySql;
		obj.formCode = formCode;
		obj.rowlimit = rowlimit;
		obj.exportFileName = exportFileName;
		obj.height = height;
		obj.exportMaxNum = $('#exportMaxNum').val();
		if (!analySearchParamsTable(obj)) {
			return false;
		}
		if (!analyColTable(obj)) {
			return false;
		}
		return true;
	}

	/**
	 * 检测是否数字
	 */
	function isNumber(s) {
		var regu = "^[0-9]+$";
		var re = new RegExp(regu);
		if (s.search(re) != -1) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 获取查询条件
	 */
	function analySearchParamsTable(obj) {
		var searchParams = new Array();
		var rows = document.getElementById("conditionTable").rows;
		if (rows.length > 0) {
			for (var i = 0; i < rows.length; i++) {
				var searchParam = new Object();
				var orgiIndex = rows[i].cells[0].childNodes[1].value;
				searchParam.index = rows[i].cells[0].childNodes[0].innerHTML;
				searchParam.code = rows[i].cells[1].childNodes[0].innerHTML;
				searchParam.searchSql = rows[i].cells[1].childNodes[1].value;
				searchParam.name = rows[i].cells[2].childNodes[0].value;
				searchParam.type = $("#queryType_" + orgiIndex).val();
				searchParam.displayStyle = $("#displayStyle_" + orgiIndex).val();
				searchParam.dataType = $("#dataType_" + orgiIndex).val();
				searchParam.displayDealClass = $("#displayDealClass_" + orgiIndex).val();
				searchParam.displayDealData = $("#displayDealData_" + orgiIndex).val();
				searchParam.defaultValue = "";
				if (searchParam.displayStyle == 5 || searchParam.displayStyle == 15) {
					if (searchParam.displayDealClass == "") {
						showDialogModal("error-div", "操作错误", "请输入处理类");
						$("#displayDealClass_" + orgiIndex).focus();
						return false;
					}
					if (searchParam.displayDealData == "") {
						showDialogModal("error-div", "操作错误", "请输入处理数据");
						$("#displayDealData_" + orgiIndex).focus();
						return false;
					}

				}
				searchParams = searchParams.concat(searchParam);
			}
		}
		obj.searchParams = searchParams;
		return true;
	}
	/**
	 * 获取属性列
	 */
	function analyColTable(obj) {
		var colParams = new Array();
		var rows = document.getElementById("colTable").rows;
		if (rows.length > 0) {
			for (var i = 0; i < rows.length; i++) {
				var colParam = new Object();
				var orgiIndex = rows[i].cells[0].childNodes[1].value;
				colParam.index = rows[i].cells[0].childNodes[0].innerHTML;
				colParam.name = rows[i].cells[1].childNodes[0].innerHTML;
				colParam.title = rows[i].cells[2].childNodes[0].value;
				colParam.width = $("#width_" + orgiIndex).val();
				colParam.isShow = $("#isShow_" + orgiIndex).attr("checked") == "checked" ? 1 : 0;
				colParam.isExport = $("#isExport_" + orgiIndex).attr("checked") == "checked" ? 1 : 0;
				colParam.isSum = $("#isSum_" + orgiIndex).attr("checked") == "checked" ? 1 : 0;
				colParam.sumDataType = $("#sumDataType_" + orgiIndex).val() == "" ? -1 : $("#sumDataType_" + orgiIndex).val();
				colParam.sumDataName = $("#sumDataName_" + orgiIndex).val();
				if (colParam.isSum == 1) {
					if (colParam.sumDataType == "") {
						showDialogModal("error-div", "操作错误", "请选择合计类型");
						$("#sumDataType_" + orgiIndex).focus();
						return false;
					}
					if (colParam.sumDataName == "") {
						showDialogModal("error-div", "操作错误", "请选择合计类型");
						$("#sumDataName_" + orgiIndex).focus();
						return false;
					}

				}
				colParams = colParams.concat(colParam);
			}
		}
		obj.colParams = colParams;
		return true;
	}

	//分析sql结果
	function analyseResult(data) {
		var colTable = document.getElementById("colTable");
		var conditionTable = document.getElementById("conditionTable");
		//清空列表所有选项
		colTable.innerHTML = "";
		conditionTable.innerHTML = "";
		//解析查询条件
		if (data.searchParams != undefined) {
			var searchIndex = 1;
			$.each(data.searchParams, function(n, value) {
				$("#conditionTable").append(createConditionTableRows(searchIndex, value));
				searchIndex++;
			});
		}
		//解析查询结果列
		if (data.colParams != undefined) {
			var colIndex = 1;
			$.each(data.colParams, function(n, value) {
				$("#colTable").append(createColTableRows(colIndex, value));
				colIndex++;
			});
		}
		// 下拉列表字段，监听dropDownList事件
		dropdownlistApply(dropdownlistObjects);

		//当选框事件
		checkBoxEventListening(checkBoxObjects);

		$("#colTable").dragsort({
			dragSelector : "tr", //容器拖动手柄
			dragBetween : true, //
			dragEnd : saveOrder, //执行之后的回调函数
			placeHolderTemplate : "<tr></tr>", //拖动列表的HTML部分
			scrollSpeed : 15
		//拖动速度
		});
		$("#conditionTable").dragsort({
			dragSelector : "tr", //容器拖动手柄
			dragBetween : true, //
			dragEnd : saveOrder1, //执行之后的回调函数
			placeHolderTemplate : "<tr></tr>", //拖动列表的HTML部分
			scrollSpeed : 15
		//拖动速度
		});

		document.getElementById("reportDiv").style.display = "";
	}

	//组装查询列表
	function createConditionTableRows(index, value) {
		var result = "<tr class='modelTitle'>";
		result += "<td class='mmg-first'><span>" + index + "</span>";
		result += "<input id='orgiIndex_"+index+"' type='text' style='display:none' value='"+index+"'/>";
		result += "</td>";
		result += "<td class='mmg-span'>";
		result += "<span>" + value.code + "</span>";
		result += "<input id='searchSql_"+index+"' type='text' style='display:none' value='"+value.searchSql+"'/>";
		result += "</td>";
		result += "<td class='mmg-input-middle'>";
		result += "<input id='paramName_" + index + "' type='text' placeholder='条件名称' value='" + (value.name == null ? "" : value.name) + "' class='form-control required' style='width: 100px;'/>";
		result += "</td>";
		result += "<td class='mmg-select'>";
		result += "<div id='queryType_"+index+"-dropdownlist' class='type-dropdownlist'></div>";
		result += "</td>";
		result += "<td class='mmg-select-long'>";
		result += "<div id='displayStyle_"+index+"-dropdownlist' class='type-dropdownlist'></div>";
		result += "</td>";
		result += "<td class='mmg-select'>";
		result += "<div id='dataType_"+index+"-dropdownlist' class='type-dropdownlist'></div>";
		result += "</td>";
		result += "<td class='mmg-input-long'>";
		result += "<input id='displayDealClass_" + index + "' type='text' placeholder='处理类' value='" + (value.displayDealClass == null ? "" : value.displayDealClass) + "' class='form-control required' style='width: 160px;margin-left: auto;'/>";
		result += "</td>";
		result += "<td class='mmg-input-long'>";
		result += "<input id='displayDealData_" + index + "' type='text' placeholder='处理数据' value='" + (value.displayDealData == null ? "" : value.displayDealData) + "' class='form-control required' style='width: 160px;margin-left: auto;'/>";
		result += "</td>";
		result += "</tr>";
		//查询类型下拉框
		dropdownlistObjects = dropdownlistObjects.concat({
			id : "queryType_" + index,
			ddlitems : searchTypeItems,
			relValue : value.type,
			width : 80
		});
		dropdownlistObjects = dropdownlistObjects.concat({
			id : "displayStyle_" + index,
			ddlitems : ddlItems,
			relValue : value.displayStyle,
			width : 100
		});
		dropdownlistObjects = dropdownlistObjects.concat({
			id : "dataType_" + index,
			ddlitems : dataTypeItems,
			relValue : value.dataType,
			width : 80
		});
		return result;
	}

	//组装结果列表
	function createColTableRows(index, value) {
		var result = "<tr class='modelTitle'>";
		result += "<td class='mmg-first'><span >" + index + "</span>";
		result += "<input id='orgiIndex_"+index+"' type='text' style='display:none' value='"+index+"'/>";
		result += "</td>";
		result += "<td class='mmg-span'>";
		result += "<span >" + value.name + "</span>";
		result += "</td>";
		result += "<td class='mmg-input-middle'>";
		result += "<input id='title_" + index + "' type='text' placeholder='列名' value='" + (value.title == null ? "" : value.title) + "' class='form-control required' style='width: 120px;margin-left: auto;'/>";
		result += "</td>";
		result += "<td class='mmg-input'>";
		result += "<input id='width_" + index + "' type='text' placeholder='列宽' value='" + (value.width == 0 ? "140" : value.width) + "' class='form-control required' style='width: 80px;margin-left: auto;'/>";
		result += "</td>";
		result += "<td class='mmg-checkbox'>";
		result += "<div style='margin-left: 20px; float: left; margin-top: 3px; margin-bottom: 0px;'>";
		result += "<label id='label-isShow_" + index + "' style='font-weight: 400;'>";
		result += "<input id='isShow_" + index + "' name='isShow' value='1' type='checkbox' style='opacity: 0;'";
		//if (null != value.isShow && value.isShow ==1) {
		result += " checked='checked'";
		//}
		result += " />";
		result += "</label>";
		result += "</div>";
		result += "</td>";
		result += "<td class='mmg-checkbox'>";
		result += "<div style='margin-left: 20px; float: left; margin-top: 3px; margin-bottom: 0px;'>";
		result += "<label id='label-isExport_" + index + "' style='font-weight: 400;'>";
		result += "<input id='isExport_" + index + "' name='isExport' value='1' type='checkbox' style='opacity: 0;'";
		//if (null != value.isExport && value.isExport ==1) {
		result += " checked='checked'";
		//}
		result += " />";
		result += "</label>";
		result += "</div>";
		result += "</td>";
		result += "<td class='mmg-checkbox'>";
		result += "<div style='margin-left: 20px; float: left; margin-top: 3px; margin-bottom: 0px;'>";
		result += "<label id='label-isSum_" + index + "' style='font-weight: 400;'>";
		result += "<input id='isSum_" + index + "' name='isSum' value='1' type='checkbox' style='opacity: 0;' ";
		if (null != value.isSum && value.isSum == 1) {
			result += " checked='checked'";
		}
		result += " />";
		result += "</label>";
		result += "</div>";
		result += "</td>";
		result += "<td class='mmg-select'>";
		result += "<div id='sumDataType_"+index+"-dropdownlist' class='type-dropdownlist'></div>";
		result += "</td>";
		result += "<td class='mmg-input'>";
		result += "<input id='sumDataName_" + index + "' type='text' placeholder='合计列名' value='" + (value.sumDataName == null ? "" : value.sumDataName) + "' class='form-control required' style='width: 80px;margin-left: auto;' />";
		result += "</td>";
		result += "</tr>";
		//查询类型下拉框
		dropdownlistObjects = dropdownlistObjects.concat({
			id : "sumDataType_" + index,
			ddlitems : sumTypeItems,
			relValue : value.sumDataType,
			width : 80
		});
		checkBoxObjects[checkBoxObjects.length] = "isShow_" + index;
		checkBoxObjects[checkBoxObjects.length] = "isExport_" + index;
		checkBoxObjects[checkBoxObjects.length] = "isSum_" + index;
		return result;
	}

	/**
	 * 下拉列表应用及事件监听
	 * @param dropdownlistObjects
	 */
	dropdownlistApply = function(dropdownlistObjects) {
		$.each(dropdownlistObjects, function(n, value) {
			var ddlItems = new Array();
			var ddlItemOjb = value.ddlitems;
			for ( var item in ddlItemOjb) {
				if (value.relValue == ddlItemOjb[item].value) {
					ddlItems[ddlItems.length] = {
						itemText : ddlItemOjb[item].name,
						itemData : ddlItemOjb[item].value,
						Selected : true
					};
				} else {
					ddlItems[ddlItems.length] = {
						itemText : ddlItemOjb[item].name,
						itemData : ddlItemOjb[item].value
					};
				}
			}

			ddlOrgTypeObj = $('#' + value.id + "-dropdownlist").dropDownList({
				inputName : value.id + 'Name',
				inputValName : value.id,
				buttonText : "",
				width : value.width + "px",
				readOnly : false,
				required : true,
				maxHeight : 200,
				onSelect : function(i, data, icon) {

				},
				items : ddlItems
			});
		});
	}

	function saveOrder() {
		changeTableIndx("colTable");
	}

	function saveOrder1() {
		changeTableIndx("conditionTable");
	}

	//移动后改变table序号
	function changeTableIndx(tableId) {
		var index = 1;
		var rows = document.getElementById(tableId).rows;
		if (rows.length > 0) {
			for (var i = 0; i < rows.length; i++) {
				rows[i].cells[0].childNodes[0].innerHTML = index;
				index++;
			}
		}
	}

	/**
	 * 多选框事件监听
	 * @param checkBoxObjects
	 */
	checkBoxEventListening = function(checkBoxObjects) {
		$.each(checkBoxObjects, function(n, value) {
			$('#' + value).uniform();
			$('#' + value).on('click', function(event) {
				$.each($("input[name='" + event.target.name + "']"), function(m, val) {
					if (val.id == event.target.id) {
						if ($('#' + val.id).get(0).checked) {
							$('#' + val.id).attr("checked", true);
						} else {
							$('#' + val.id).attr("checked", false);
						}
					}
				});
			});
		});
	}
</script>
