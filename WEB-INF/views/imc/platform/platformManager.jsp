<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<head>
<style type="text/css">
.form-control {
	height: 25.5px;
}

* {
	margin: 0;
	padding: 0;
	list-style-type: none;
}

a, img {
	border: 0;
}

.demo {
	margin: 100px auto 0 auto;
	width: 400px;
	text-align: center;
	font-size: 18px;
}

.demo .action {
	color: #3366cc;
	text-decoration: none;
	font-family: "微软雅黑", "宋体";
}

.overlay {
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	z-index: 998;
	width: 100%;
	height: 100%;
	_padding: 0 20px 0 0;
	background: #f6f4f5;
	display: none;
}

.showbox {
	position: fixed;
	top: 0;
	left: 50%;
	z-index: 9999;
	opacity: 0;
	filter: alpha(opacity = 0);
	margin-left: -80px;
}

* html, * html body {
	background-image: url(about:blank);
	background-attachment: fixed;
}

* html .showbox, * html .overlay {
	position: absolute;
	top: expression(eval(document.documentElement.scrollTop));
}

#AjaxLoading {
	border: 1px solid #8CBEDA;
	color: #37a;
	font-size: 12px;
	font-weight: bold;
}

#AjaxLoading div.loadingWord {
	width: 180px;
	height: 50px;
	line-height: 50px;
	border: 2px solid #D6E7F2;
	background: #fff;
}

#AjaxLoading img {
	margin: 10px 15px;
	float: left;
	display: inline;
}
</style>
</head>
<body>
	<div class="content-default">
		<form id="select-form">
			<table>
				<tr>
					<td align="right" width="90">平台名称：</td>
					<td>
						<input id="platformName1" name="platformName1" placeholder="平台名称" class="form-control required" type="text" style="width: 150px" />
					</td>
					<td align="right" width="100">平台编码：</td>
					<td>
						<input id="platformCode1" name="platformCode1" placeholder="平台编码" class="form-control required" type="text" style="width: 150px" />
					</td>
					<td align="right">
						<button id="btn-query" type="button" class="btn btn-default btn-common btn-common-green btnicons" style="margin-left: 3rem;">
                        <p class="btniconimg"><span>查询</span></p>
                        </button>
						<button id="btn-add" type="button" class="btn btn-default btn-common btn-common-green btnicons" style=" margin-left:2rem;">
                        <p class="btniconimgadd"><span>新增</span> 
                        </button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb_dbbackup" class="tb_dbbackup" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<!-- 页底控件 -->
	<div id="btn-grp" class="btn-group btn-group-sm" style="width: 400px; left: 200px"></div>
	<div id="AjaxLoading" class="showbox">
		<div class="loadingWord">
			<img src="${ctx}/static/img/loading.gif">
			处理中，请稍候...
		</div>
	</div>
	<div id="edit-platform"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
	<script type="text/javascript">
		var cardTypeArray = new Array();
		var isDescription = false;
		var tbPlatforms;
		var rowEditing = -1;
		var pg;
		var platformTypeList = new Array();
		$(document).ready(function() {
			$.ajax({
				type: "post",
				url: "${ctx}/platformManage/listPlatformType",
				data:"",
				dataType: "json",
				contentType: "application/json;charset=utf-8",
				success: function(data) {
					var length = data.length;
					for(var i = 0 ;i < length;i++)
					{
						platformTypeList[platformTypeList.length] = {itemText:data[i].itemText,itemData:data[i].itemData};
					}
				},
				error: function(req,error,errObj) {
					return;
				}
			});
			var cols = [
					{
						title:'序号',
						name:'id',
						width:100,
						sortable:false,
						align:'left'},
					{
						title : '平台Id',
						name : 'id',
						width : 100,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '平台名称',
						name : 'platformName',
						width : 100,
						sortable : false,
						align : 'left'
					}, {
						title : '平台编码',
						name : 'platformCode',
						width : 100,
						align : 'left'
					}, {
						title : '平台类型Id',
						name : 'platformType',
						width : 150,
						align : 'left',
						hidden : true
					}, {
						title : '平台类型',
						name : 'platformTypeName',
						width : 100,
						align : 'left'
					}, {
						title : '处理类',
						name : 'dealClass',
						width : 300,
						align : 'left'
					}, {
						title : '备注',
						name : 'platformComment',
						width : 100,
						align : 'left'
					}, {
						title : '平台参数',
						name : 'platformConfig',
						width : 150,
						align : 'left',
						hidden : true
					}, {
						title : '操作',
						name : '',
						width : 150,
						align : 'left',
						lockWidth : true,
						lockDisplay : true,
						renderer : function(val, item, rowIndex) {
							var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var modifyObj = '<a class="calss-download" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							return modifyObj + deleteObj;
						}
					}
			];
			pg = $('#pg').mmPaginator({
				"limitList" : [
					20
				]
			});
			tbPlatforms = $('#tb_dbbackup').mmGrid({
				width:'99%',
				height : 776,
				cols : cols,
				url : '${ctx}/platformManage/platformList',
				method : 'get',
				params : function() {
					var platformName = $("#platformName1").val();
					var platformCode = $("#platformCode1").val();
					data = {
						"" : ""
					};
					if (typeof (platformName) != "undefined" && platformName != "") {
						$(data).attr({
							"platformName" : encodeURI(platformName)
						});
					}
					if (platformCode != "") {
						$(data).attr({
							"platformCode" : platformCode
						});
					}
					return data;
				},
				remoteSort : true,
				/* indexCol : true, */
				multiSelect : false,
				checkCol : false,
				nowrap : true,
				fullWidthRows : true,
				autoLoad : false,
				showBackboard : false,
				plugins : [
					pg
				]
			});
			if ($("#login-org").data("organizeType") == 3) {
				tbPlatforms.on('cellSelected', function(e, item, rowIndex, colIndex) {
					e.stopPropagation(); //阻止事件冒泡
					if ($(e.target).is('.class-delete') || $(e.target).is('.glyphicon-remove')) {
						// 删除按钮事件
						var row = tbPlatforms.row(rowIndex);
						showDialogModal("error-div", "操作提示", "删除平台会导致关联的模板一起删除，确实要删除【" + row.platformName + "】吗？", 2, "deletePlatform(" + rowIndex + ");");
					} else if ($(e.target).is('.calss-download') || $(e.target).is('.glyphicon-pencil')) {
						// 修改按钮事件
						rowEditing = rowIndex;
						createModalWithLoad("edit-platform", 650, 0, "修改平台", "platformManage/edit", "updatePlatform()", "confirm-close", "");
						$("#edit-platform-modal").modal('show');
					}
				}).on('loadSuccess', function(e, data) {
					rowEditing = -1;
				}).on('checkSelected', function(e, item, rowIndex) {
				}).on('checkDeselected', function(e, item, rowIndex) {
				}).on('loadError', function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", "查询错误：" + errObj);
				}).load();

			}
			$('#btn-query').on('click', function() {
				loadGrid();
			});

			$('#btn-add').on('click', function() {
				rowEditing = -1;
				createModalWithLoad("edit-platform", 650, 345, "新增平台", "platformManage/edit", "updatePlatform()", "confirm-close");
				$("#edit-platform-modal").modal('show');
			});

		});

		function loadGrid() {
			pg.load({
				"page" : 1
			});
			tbPlatforms.load();
		}

		function savePlatform(platformData) {
			$.ajax({
				type : "post",
				url : "${ctx}/platformManage/create",
				data : JSON.stringify(platformData),
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						$("#edit-platform-modal").modal('hide');
						loadGrid();
						return true;
					} else {
						showDialogModal("error-div", "保存失败", data.MESSAGE);
						return false;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "保存失败", data.MESSAGE);
					return false;
				}
			});
			return true;
		}
		
		//删除平台信息
		function deletePlatform(rowIndex) {
			var row = tbPlatforms.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/platformManage/delete/" + row.id,
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						showDialogModal("error-div", "操作成功", "数据已删除！");
						loadGrid();
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