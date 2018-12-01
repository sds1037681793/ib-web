<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>主机在线状态</title>
<style>
.mmGrid .mmg-headWrapper .mmg-head {
	background: #4DA1FF;
}
.btn-jump {
    color: #4DA1FF;
}
.mmPaginator .pageList li.active {
    background-color: #4DA1FF;
}
.mmPaginator .totalCountLabel span {
    color: #4DA1FF;
}
.mmPaginator .pageList li a, .mmPaginator .pageList li.disable a {
    color: #4DA1FF;
}
.form-control:focus {
	border-color: #4DA1FF;
}
</style>
</head>

<table id="tb_master"
	style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
	<tr>
		<th rowspan="" colspan=""></th>
	</tr>
</table>


<div id="pg" style="text-align: right;"></div>
<body>
	<script type="text/javascript">

$(document).ready(function() {
	
	$('#ffm_page-modal').on('shown.bs.modal', function () {
		// 事件展现列表
	    var cols = [
				{title:'主机号',name:'masterNo',width:100,sortable:false,align:'center'},
				{title:'所属系统',name:'systemType',width:150,sortable:false,align:'left',renderer:function(val, item , rowIndex){
					if(val ==1){
						return "消防报警联动系统"
					}else if(val ==2){
						return "消防水系统";
					}
				}},
				{title:'在线状态',name:'comFlag',width:150,sortable:false,align:'left',renderer:function(val, item , rowIndex){
					if(val ==1){
						return "离线"
					}else if(val ==0){
						return "在线";
					}
				}}
			];
			var pg = $('#pg').mmPaginator({"limitList":[10]});
			var tbMaster = $('#tb_master').mmGrid({
			height:300,
			cols:cols,
			url:"${ctx}/fire-fighting/fireFightingProjectPageManage/masterOnlineRate",
			method:'get',
			remoteSort:false,
//	 		sortName:'masterNo',
//	 		sortStatus:'desc',
			multiSelect:true,
			fullWidthRows:false,
			autoLoad:false,
			params:function(){
				var projectCode = "${param.projectCode}";
				var data = {};
				$(data).attr({"projectCode":projectCode});
				return data;
				
			},
			plugins:[pg]
		});
			tbMaster.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
				if($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')){
					
				}else if($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')){
				}else if($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')){
				}
			}).on('loadSuccess',function(e,data){
				
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
		})
	
	
});

</script>
</body>
</html>