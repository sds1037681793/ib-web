<%@ page language="java" contentType="text/html; charset=utf-8" %> 
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<body>
	<div class="content-default">
		<form>
			<table>
				<tr>
					<td align="right" width="110">数据类型名称：</td>
					<td width="150"><input id="dataTypeName" name="dataTypeName" placeholder="数据类型名称" class="form-control required" type="text" style="width: 150px;" readonly/></td>
					<td align="right" width="120">数据类型编码：</td>
					<td width="150"><input id="dataTypeCode" name="dataTypeCode" placeholder="数据类型编码" class="form-control required" type="text" style="width: 150px;" readonly/></td>
					<td>
						<button id="btn-add-data" type="button" class="btn btn-default btn-common" style="margin-left: 20px;">新增</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="tb_datas" class="tb_datas" style="border: 1px solid;width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<script type="text/javascript">
		var dropDownListDataTypes = new HashMap();
		var dataTypeDdlItems = new Array();
		var tbData;
		var dataTypesIdMap = new HashMap();
		var dataTypeCode = '${param.typeCode}';
		var typeLevel = '${param.typeLevel}';
		$(document).ready(function() {
			if(typeLevel == 1){
				document.getElementById("btn-add-data").style.display="none";
			}
			document.getElementById("dataTypeCode").value = '${param.typeCode}';
			document.getElementById("dataTypeName").value = decodeURI('${param.typeName}');
			// 获取静态数据类型

			$.ajax({
				type : "post",
				url : "${ctx}/staticData/allType",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data != null && data.length > 0) {
						$(eval(data)).each(function() {
							dropDownListDataTypes.put(this.code, {
								"name" : this.name,
								"id" : this.id
							});
							dataTypesIdMap.put(this.id, {
								"name" : this.name,
								"code" : this.code
							});
						});
					}
				},
				error : function(req, error, errObj) {
					// showAlert('warning', '操作失败：' + errObj, "save", 'top');
					// return;
				}
			})
			//	$('#queryDateType').val(dropDownListDataTypes.get(dataTypeCode).name);	
			var cols = [
					{
						title : 'id',
						name : 'id',
						width : 80,
						sortable : true,
						align : 'center',
						hidden : true
					},{
						title : '编码',
						name : 'code',
						width : 150,
						sortable : true,
						align : 'left'
					}, {
						title : '名称',
						name : 'name',
						width : 150,
						sortable : true,
						align : 'left'
					}, {
						title : '数据值',
						name : 'value',
						width : 100,
						sortable : true,
						align : 'left'
					}, {
						title : '描述',
						name : 'description',
						width : 200,
						sortable : true,
						align : 'left'
					}, {
						title : '排序编号',
						name : 'sort',
						width : 65,
						sortable : true,
						align : 'center'
					}, {
						title : 'state',
						name : 'state',
						width : 80,
						sortable : true,
						align : 'center',
						hidden : true
					}, {
						title : '操作',
						name : 'operate',
						width : 100,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							if(typeLevel == 1){
								return modifyObj;
							}
							return modifyObj + deleteObj;
						}
					}
			];
			var dataPaginator = $('#pg').mmPaginator({
				"limitList" : [
					10
				]
			});
			tbData = $('#tb_datas').mmGrid({
				height : 365,
				cols : cols,
				url : '${ctx}/staticData/list',
				method : 'get',
				params : function() {
					dataTypeCode = $('#dataTypeCode').val();
					return {
						"code" : dataTypeCode
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
			tbData.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')) {
					// 修改按钮事件
					createModalWithLoad("edit-data", 650, 0, "修改数据", "staticData/edit?rowIndex=" + rowIndex, "saveData()", "confirm-close", "");
					$("#edit-data-modal").modal('show');
				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
					// 删除按钮事件
					var row = tbData.row(rowIndex);
					showDialogModal("error-div", "操作提示", "确实要删除【" + row.name + "】吗？", 2, "deleteData(" + rowIndex + ");");
				}
			}).on('loadError', function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "初始化菜单数据失败：" + errObj);
			}).load();
			$('#btn-query-data').on('click', function() {
				dataPaginator.load({
					"page" : 1
				});
				tbData.load();
			});
			$('#btn-add-data').on('click', function() {
				createModalWithLoad("edit-data", 650, 0, "新增数据", "staticData/edit?rowIndex=" + -1, "saveData()", "confirm-close");
				$("#edit-data-modal").modal('show');
			});

		});
		function deleteData(rowIndex) {
			var row = tbData.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/staticData/delete/" + row.id,
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						showDialogModal("error-div", "操作成功", "数据已删除！");
						tbData.load();
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