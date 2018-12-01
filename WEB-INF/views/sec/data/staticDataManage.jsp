<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<body>
	<div class="content-default">
		<form>
			<table>
				<tr>
					<td align="right" width="100">数据类型名称：</td>
					<td width="150"><input id="typeName" name="typeName" placeholder="数据类型名称" class="form-control required" type="text" style="width: 150px;" /></td>
					<td align="right" width="150">数据类型编码：</td>
					<td width="150"><input id="typeCode" name="typeCode" placeholder="数据类型编码" class="form-control required" type="text" style="width: 150px;" /></td>
					<td>
						<button id="btn-query-data" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 3rem;">
                         <p class="btniconimg"><span>查询</span></p>
                        </button>
						<button id="btn-add-type" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 2rem;">
                        <p class="btniconimgadd"><span>新增</span>
                        </button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb_types" class="tb_types" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg1" style="text-align: right;"></div>
	<div id="show-type"></div>
	<div id="edit-type"></div>
	<div id="edit-data"></div>
	<div id="error-div"></div>
	<script type="text/javascript">
		var dropDownListDataTypes = new HashMap();
		var dataTypeDdlItems = new Array();
		var tbTypeData;
		$(document).ready(function() {
			var cols = [
					{
						title : 'id',
						name : 'id',
						width : 80,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '编码',
						name : 'code',
						width : 300,
						sortable : false,
						align : 'left'
					}, {
						title : '名称',
						name : 'name',
						width : 300,
						sortable : false,
						align : 'left'
					}, {
						title : '级别',
						name : 'typeLevel',
						width : 250,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '级别',
						name : 'levelName',
						width : 80,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
								var levelName = "";
								if(item.typeLevel == 1){
									levelName = "一级";
								}else{
									levelName = "二级";
								}
								return levelName;
							}
					}, {
						title : '描述',
						name : 'description',
						width : 400,
						sortable : false,
						align : 'left'
					}, {
						title : 'state',
						name : 'state',
						width : 80,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '操作',
						name : 'operate',
						width : 100,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
						    var viewObj = '<a class="calss-view" href="#" title="查看"><span class="glyphicon glyphicon-search" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var deleteObj = '<a class="calss-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>'; 
							if(item.typeLevel == 1){
								return viewObj;
							}else{
								return viewObj + modifyObj + deleteObj;
							}	
							
						}
					}
			];
			var dataPaginator = $('#pg1').mmPaginator({
				"limitList" : [
					20
				]
			});
			tbTypeData = $('#tb_types').mmGrid({
				width:'99%',
				height : 776,
				cols : cols,
				url : '${ctx}/staticData/typeList',
				method : 'get',
				params : function() {
					var name = encodeURI($.trim($('#typeName').val()));
					var code =  $.trim($('#typeCode').val());
					return {
						"code" : code,
						"name" : name
					};
				},
				nowrap : true,
				remoteSort : true,
				sortName : 'id',
				sortStatus : 'desc',
				multiSelect : false,
				checkCol : false,
				fullWidthRows : true,
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
					createModalWithLoad("show-type", 800, 645, "查看数据", "/staticData?typeCode=" + item.code +"&typeName="+encodeURI(encodeURI(item.name))+"&typeLevel="+item.typeLevel, "", "close", "");
					$("#show-type-modal").modal('show');
				} else if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
					// 修改按钮事件
					createModalWithLoad("edit-type", 650, 220, "修改数据", "staticData/editType?rowIndex=" + rowIndex, "saveType()", "confirm-close", "");
					$("#edit-type-modal").modal('show');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
					// 删除按钮事件
					var row = tbTypeData.row(rowIndex);
					showDialogModal("error-div", "操作提示", "确实要删除【" + row.name + "】吗？", 2, "deleteType(" + rowIndex + ");");
				}
			}).on('loadError', function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "初始化菜单数据失败：" + errObj);
			}).load();
			$('#btn-query-data').on('click', function() {
				dataPaginator.load({
					"page" : 1
				});
				tbTypeData.load();
			});
			$('#btn-add-type').on('click', function() {
				createModalWithLoad("edit-type", 650, 220, "新增数据类型", "staticData/editType?rowIndex=" + -1, "saveType()", "confirm-close");
				$("#edit-type-modal").modal('show');
			});

		});

		function deleteType(rowIndex) {
			var row = tbTypeData.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/staticData/deleteType/" + row.id,
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						showDialogModal("error-div", "操作成功", "数据已删除！");
						tbTypeData.load();
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