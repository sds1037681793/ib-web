<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<table id="tb_apis" class="tb_apis" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
	<tr>
		<th rowspan="" colspan=""></th>
	</tr>
</table>
<script>
	$(document).ready(function() {
		var cols = [
				{
					title : '接口名',
					name : 'apiName',
					width : 150,
					sortable : true,
					align : 'left'
				}, {
					title : '请求地址',
					name : 'requestUrl',
					width : 150,
					sortable : true,
					align : 'left'
				}, {
					title : '接口描述',
					name : 'apiDesc',
					width : 250,
					sortable : true,
					align : 'left'
				}, {
					title : '接口组',
					name : 'group',
					width : 150,
					sortable : true,
					align : 'left'
				}, {
					title : '接口参数',
					name : 'paramsStr',
					width : 250,
					sortable : true,
					align : 'left'
				},
		];

		var tbApis = $('#tb_apis').mmGrid({
			height : 365,
			cols : cols,
			url : '${ctx}/common/apiList',
			method : 'get',
			remoteSort : true,
			sortName : 'id',
			sortStatus : 'desc',
			multiSelect : false,
			checkCol : false,
			fullWidthRows : false,
			autoLoad : false,
			showBackboard : false
		});

		tbApis.load();
	});
</script>