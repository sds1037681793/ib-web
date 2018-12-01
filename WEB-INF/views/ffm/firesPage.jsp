<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>火警未处理信息</title>
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

<table id="tb_fires"
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
			{title:'id',name:'deviceId',width:100,sortable:false,align:'left',hidden:'true'},
			{title:'主机号-回路号-测点号',name:'deviceNumber',width:150,sortable:false,align:'left'},
			{title:'位置',name:'position',width:150,sortable:false,align:'left'},
			{title:'事件',name:'event',width:150,sortable:false,align:'left',renderer:function(val, item , rowIndex){
				if(val ==1||val==2||val==3||val==4){
					return "火警";
				}
			}},
			{title:'发生时间',name:'firstAlarmTime',width:150,sortable:true,align:'left'},
			{title:'状态',name:'state',width:100,sortable:false,align:'left',renderer:function(val, item , rowIndex){
				if(val ==1){
					return "未处理";
				}else if(val ==0){
					return "已处理";
				}
			}},
			{title:'未处理累计时长',name:'alarmMaxTime',width:150,sortable:false,align:'left',renderer:function(val, item , rowIndex){
				return val+"分钟";
			}}
			
		];
		var pg = $('#pg').mmPaginator({"limitList":[10]});
		var tbFires = $('#tb_fires').mmGrid({
		height:300,
		cols:cols,
		url:"${ctx}/alarm-center/alarmRecord/listFiresAlarmNoDealRecord",
		method:'get',
		remoteSort:false,
		sortName:'masterNo',
		sortStatus:'desc',
		multiSelect:true,
		fullWidthRows:false,
		autoLoad:false,
		params:function(){
			var alarmEventCodes ="1,2,3,4";
			var projectCode = "${param.projectCode}";
			var data = {"projectCode":projectCode,"systemCode":"01","fireStatus":1,"alarmEventCodes":alarmEventCodes};
			return data;
			
		},
		plugins:[pg]
	});
		tbFires.on('cellSelect',function(e,item,rowIndex,colIndex){
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