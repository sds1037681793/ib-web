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
<title>数据检测类型</title>
</head>
<body>
	<table id="tb_type-mo" class="tb_type-mo" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg1" style="text-align: right;"></div>
	<div id="show-type"></div>
	<div id="edit-type"></div>
	<div id="edit-data"></div>
	<div id="error-div"></div>
</body>
<script type="text/javascript">
var typeId = "${param.typeId}";
$(document).ready(function() {
	var cols = [
			{
				title : 'id',
				name : 'id',
				width : 80,
				sortable : true,
				align : 'center',
				hidden : true
			}, {
				title : '对象名称',
				name : 'name',
				width : 200,
				sortable : true,
				align : 'left'
			}, {
				title : '对象编码',
				name : 'code',
				width : 200,
				sortable : true,
				align : 'left'
			}, {
				title : '对象描述',
				name : 'description',
				width : 300,
				sortable : true,
				align : 'center',
			}
			/* , {
				title : '操作',
				name : 'operate',
				width : 100,
				sortable : false,
				align : 'center',
				renderer : function(val, item, rowIndex) {
				    var viewObj = '<a class="calss-view" href="#" title="查看"><span class="glyphicon glyphicon-search" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
					
					return viewObj;
					
				}
			} */
	];
	var dataPaginator = $('#pg1').mmPaginator({
		"limitList" : [
			10
		]
	});
	tbTypeData = $('#tb_type-mo').mmGrid({
		height : 380,
		cols : cols,
		url : '${ctx}/alarm-center/detDataTypeManage/listTypeDataMo',
		method : 'get',
		params : function() {
			return {
				"typeId" : typeId
			};
		},
		nowrap : true,
		remoteSort : true,
		sortName : 'id',
		sortStatus : 'desc',
		multiSelect : false,
		checkCol : false,
		fullWidthRows : false,
		autoLoad : false,
		showBackboard : false,
		plugins : [
			dataPaginator
		]
	});
	tbTypeData.on('cellSelect', function(e, item, rowIndex, colIndex) {
		e.stopPropagation();
		if ($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')) {
			//查看静态数据事件
			createModalWithLoad("show-type", 800, 0, "查看数据", "/staticData?typeCode=" + item.code +"&typeName="+encodeURI(encodeURI(item.name))+"&typeLevel="+item.typeLevel, "", "close", "");
			$("#show-type-modal").modal('show');
		} else if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
			// 修改按钮事件
		} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
			// 删除按钮事件
		}
	}).on('loadError', function(req, error, errObj) {
		showDialogModal("error-div", "操作错误", "查询对象数据失败：" + errObj);
	}).load();

});
</script>
</html>