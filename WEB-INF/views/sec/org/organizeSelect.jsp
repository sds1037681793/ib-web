<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="content-panel">
	<div>
		<form>
			<table>
				<tr>
					<td align="right" width="90">组织名称：</td>
					<td>
						<input id="organizeName" name="organizeName" placeholder="组织名称" class="form-control required" type="text" style="width: 150px;" />
					</td>
					<td align="right" width="90">组织编码：</td>
					<td>
						<input id="organizeCode" name="organizeCode" placeholder="组织编码" class="form-control required" type="text" style="width: 150px;" />
					</td>
					<td>
						<div id="btn-grp" class="btn-group btn-group-sm" style="padding-left: 20px;">
							<button id="btn-org-query" type="button" class="btn btn-default">查询</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<div class="content-panel">
	<table id="tb-orgs-result" class="tb-orgs-result" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="orgs-result-pg" style="text-align: right;"></div>
</div>
<script>
	var tbOrgsResultGrid;
	$(document).ready(function() {
		var cols = [
				{
					title : '组织ID',
					name : 'id',
					width : 100,
					sortable : true,
					align : 'center',
					hidden : true
				}, {
					title : '组织名称',
					name : 'organizeName',
					width : 200,
					sortable : true,
					align : 'left'
				}, {
					title : '组织编码',
					name : 'organizeCode',
					width : 156,
					sortable : true,
					align : 'left'
				}, {
					title : '父组织ID',
					name : 'parentOrganizeId',
					width : 200,
					sortable : true,
					align : 'center',
					hidden : true,
					renderer : function(val, item, rowIndex) {
						if (item && item.parentOrganize) {
							return item.parentOrganize.id;
						} else {
							return null;
						}
					}
				}, {
					title : '父组织名称',
					name : 'parentOrganizeName',
					width : 200,
					sortable : true,
					align : 'left',
					renderer : function(val, item, rowIndex) {
						if (item && item.parentOrganize) {
							return item.parentOrganize.organizeName;
						} else {
							return null;
						}
					}
				}
		];

		tbOrgsResultGrid = $('#tb-orgs-result').mmGrid({
			height : 205,
			cols : cols,
			method : 'get',
			url : "${ctx}/organizeSelect/query",
			remoteSort : true,
			sortName : 'id',
			sortStatus : 'desc',
			multiSelect : false,
			checkCol : false,
			fullWidthRows : false,
			autoLoad : false,
			plugins : [
				$('#orgs-result-pg').mmPaginator({
					"limitList" : [
						7
					]
				})
			]
		});

		tbOrgsResultGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {

		}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
			parent.receiveOrganizeInfo(item);
		});

		$('#btn-org-query').on('click', function() {
			var organizeName = $("#organizeName").val();
			var organizeCode = $("#organizeCode").val();
			data = {
				"organizeName" : escape(organizeName),
				"organizeCode" : escape(organizeCode)
			};
			tbOrgsResultGrid.load(data);
		});

	});
</script>