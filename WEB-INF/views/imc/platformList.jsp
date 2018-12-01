<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<body>
	<div class="content-default">
		<table>
			<tr>
				<td width="80" align="right">平台编码：</td>
				<td>
					<input id="search-platformCode" type="text" placeholder="平台编码" class="form-control required" style="width: 120px;" />
				</td>
				<td width="100" align="right">平台名称：</td>
				<td>
					<input id="search-platformName" type="text" placeholder="平台名称" class="form-control required" style="width: 120px;" />
				</td>
				<td>
					<button id="query" type="button" class="btn btn-default btn-common btnicons" style="margin-left: 40px;">
                    <p class="btniconimg"><span>查询</span></p>
                    </button>
<!-- 					<button id="btn-add" type="button" class="btn btn-default btn-common">新增</button> -->
				</td>
			</tr>
		</table>
	</div>
	<table id="tb_platforms" class="tb_platforms" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg1" style="text-align: right;"></div>
	<script type="text/javascript">
		var tbPlatforms;
		var platform;
		var platformPaginator
		$(document).ready(function() {
			var cols = [
					{
						title : 'ID',
						name : 'id',
						width : 100,
						sortable : false,
						align : 'center',
						hidden : true
					}, {
						title : '平台编码',
						name : 'platformCode',
						width : 300,
						sortable : false,
						align : 'left'
					}, {
						title : '平台名称',
						name : 'platformName',
						width : 285,
						sortable : false,
						align : 'left'
					}
			];
			
			platformPaginator = $('#pg1').mmPaginator({
				"limitList" : [
					5
				]
			});
			
			tbPlatforms = $('#tb_platforms').mmGrid({
				height : 210,
				cols : cols,
				url : '${ctx}/platformManage/platformList',
				method : 'get',
				params : function() {
					var platformCode = $('#search-platformCode').val();
					var platformName = $('#search-platformName').val();
					return {
						"platformName" : platformName,
						"platformCode" : platformCode
					};
				},
				remoteSort : true,
				multiSelect : false,
				checkCol : true,
				nowrap : true,
				fullWidthRows : false,
				autoLoad : false,
				showBackboard : false,
				plugins : [
					platformPaginator
				]
			});
			
			tbPlatforms.on('cellSelect', function(e, item, rowIndex, colIndex) {
				platform = tbPlatforms.row(rowIndex);
			}).on('loadSuccess', function(e, data) {

			}).on('checkSelected', function(e, item, rowIndex) {
				platform = tbPlatforms.row(rowIndex);
			}).on('checkDeselected', function(e, item, rowIndex) {

			}).on('loadError', function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "初始化菜单数据失败：" + errObj);
			}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
				platform = tbPlatforms.row(rowIndex);
				parent.receivePlatformInfo(platform);
			}).load();

			$('#query').on('click', function() {
				loadGrid1();
			});

			
		});

		function getPlatform(){
			parent.receivePlatformInfo(platform);
		}
		
		function loadGrid1() {
			platformPaginator.load({
				"page" : 1
			});
			tbPlatforms.load();
		}

	</script>
</body>
</html>