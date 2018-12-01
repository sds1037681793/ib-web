<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html >
<html>
<body>
<div>
</div>
<div style="margin-left: 10px;margin-right: 10px;">
	<table id="tb_devices_export" class="tb_devices" style="border: 1px solid;width:99%;margin:0 auto;">
		<tr><th rowspan="" colspan=""></th></tr>
	</table>
	<div id="pg-export" style="text-align: right;">
		<button id="btn-caces-address" style="float: left;" type="button" class="btn btn-common query-btn">刷新</button>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	var cols = [
			{title:'Id',name:'id',width:100,sortable:false,align:'center',hidden:true},
			{title:'名称',name:'title',width:400,sortable:false,align:'left'},
			{title:'导出时间',name:'exportTime',width:180,sortable:false,align:'left',hidden:true},
        	{title:'状态',name:'status',width:100,sortable:false,align:'left', renderer: function(val, item, rowIndex){
        	        if(item.status == 1){
        	            return "导出中";
					}else if(item.status == 2){
        	            return  "导出完成";
					}else if(item.status == 0){
        	            return  "导出失败";
					}else if(item.status == 3){
        	            return  "已下载";
					}
				}},
			{ title:'操作', name:'' ,width:145, align:'left', lockWidth:true, lockDisplay: true, renderer: function(val, item, rowIndex){
                   var modifyObj = '';
                   if(item.status == 2){
                	   modifyObj = '<a class="class-export" href="#" title="下载">下载</a>';
                   }
                   //var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 20px;"></span></a>';
                   return modifyObj;
               }}
	            ];
	tbParkings = $('#tb_devices_export').mmGrid({
		height:420,
		cols:cols,
		url:'${ctx}/device/deviceInfo/listDeviceExport',
		method:'get',
		params:function(){
		},
		remoteSort:true,
		sortName:'id',
		sortStatus:'desc',
		multiSelect:false,
		checkCol:false,
		fullWidthRows:false,
		autoLoad:false,
		showBackboard:false,
		plugins:[$('#pg-export').mmPaginator({"limitList":[10]})]
	});
	
	tbParkings.on('cellSelect',function(e,item,rowIndex,colIndex){
		e.stopPropagation();
        if ($(e.target).is('.class-export')) {
        	var row = tbParkings.row(rowIndex);
        	downloadEventExecl(row.id);
        }
	}).on('loadSuccess',function(e,data){
		
	}).on('loadError',function(req, error, errObj) {
		showDialogModal("error-div", "操作错误", "数据加载失败：" + errObj);
	}).load();
	
	$('#btn-caces-address').on('click', function(){
		tbParkings.load({"page":1});
	});
	
	
});
//导出excel
function downloadEventExecl(id) {
	var url = ctx + "/device/deviceInfo/downloadDeviceInfoExcel?id="+id;
	window.open(url);
	$("#export-device-modal").modal("hide");
}
</script>
</body>
</html>