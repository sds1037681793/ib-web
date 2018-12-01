<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
</head>
<body>
	<div style="margin-top: 10px;"
		class="content-default">
		<form id="select-form">
			<table>
				<tr>
<!-- 					<td align="right" width="100">坐标名称：</td> -->
<!-- 					<td> -->
<!-- 					<input id="coordinateName" name="coordinateName" placeholder="坐标名称" class="form-control required" type="text" style="width:140px"/> -->
<!-- 					</td> -->
					<td align="right" width="80">设备名称：</td>
					<td>
					<input id="deviceName" name="deviceName" placeholder="设备名称" class="form-control required" type="text" style="width:140px"/>
					</td>
					<td>
						<button id="btn-query-relate" type="button"
							class="btn btn-default btn-common btn-common-green btnicons"
							style="margin-left: 45px;"><p class="btniconimg"><span>查询</span></p></button>
						<button id="btn-add-relate" type="button"
							class="btn btn-default btn-common btn-common-green btniconsedit"
							style="margin-left: 2px;"><p class="btniconimgedit"><span>编辑坐标</span></button>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<table id="tb_relate_groups" class="tb_relate_groups" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>

	<div id="relatePg" style="text-align: right;"></div>
  <script type="text/javascript">
	var relatePictureId;
    $(document).ready(function() {
    	$('#rest-config-relate').show();
    	if('' != "${param.pictureId}"){
    		relatePictureId = "${param.pictureId}";
    	}
		// 图片关联信息展现列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
// 				{title:'坐标名称',name:'coordinateName',width:160,sortable:true,align:'left'},
				{title:'x坐标',name:'xCoordinate',width:120,sortable:false,align:'left'},
				{title:'y坐标',name:'yCoordinate',width:120,sortable:false,align:'left'},
				{title:'设备名称',name:'deviceName',width:180,sortable:false,align:'left'},
				{title:'创建时间',name:'createTime',width:160,sortable:false,align:'left'},
				{title:'操作', name:'' ,width:100, align:'center', lockWidth:true, lockDisplay: true, renderer: function(val){
// 					var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
					var deleteObj = '<a class="calss-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>'; 
					return deleteObj;
				}}
			];
			var relatePg = $('#relatePg').mmPaginator({"limitList":[10]});
			picRelateGrid = $('#tb_relate_groups').mmGrid({
			height:408,
			cols:cols,
			url:"${ctx}/device/coordinateManage/list",
			method:'post',
			remoteSort:true,
			showBackboard:false,
			multiSelect:true,
			fullWidthRows:false,
			autoLoad:false,
			params:function(){
				data = {};
// 				var coordinateName = $('#coordinateName').val();
// 				if (coordinateName != "" && coordinateName != undefined){
// 					$(data).attr({"coordinateName": coordinateName});
// 				}
				var deviceName = $('#deviceName').val();
				if (deviceName != "" && deviceName != undefined){
					$(data).attr({"deviceName": deviceName});
				}
				if (relatePictureId != "" && relatePictureId != undefined){
					$(data).attr({"pictureId": relatePictureId});
				}
				return data;
			},
			plugins:[relatePg]
		});
			picRelateGrid.on('cellSelect',function(e,item,rowIndex,colIndex){
// 				e.stopPropagation();
// 				if($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')){
// 					// 修改事件
// 					e.stopPropagation();  //阻止事件冒泡
// 					createModalWithLoad("relate-edit", 750, 0, "修改关联信息", "picture/relateEdit?id=" + item.id,  "saveRelate()", "confirm-close", "");
// 		            openModal("#relate-edit-modal", true, true);
// 				}else 
				if($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')){
					// 删除按钮事件
					e.stopPropagation();  //阻止事件冒泡
					showDialogModal("error-div","操作提示","确定要删除这条记录吗？",2,"deleteCoordinate("+ item.id +");");
				}
			}).on('loadSuccess',function(e,data){
				
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
			$("#btn-query-relate").on('click',function (){
				relatePg.load({"page":1});
				picRelateGrid.load();
			});
			
  	$('#btn-add-relate').on('click',function(){
		createModalWithLoad("relate-edit", 1000, "", "新增关联信息", "picture/relateEdit", "saveRelate()", "confirm-close", "",110);
        openModal("#relate-edit-modal", true, true);
	});
});
	
	
 	function deleteCoordinate(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/device/coordinateManage/deleteCoordinate/" + id,
			success : function(data) {
				if (data && data.code == 0 && data.data) {
					$('#'+id).remove();
					$(".dragDevice").css("cursor","move");
					showDialogModal("error-div", "操作成功", "删除成功！");
					deleteState = false;
					picRelateGrid.load();
					return;
				}else {
					showDialogModal("error-div", "操作错误", data.msg);
					return;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}
 	
 	function close1() {
 		$('#rest-config-relate').hide();
 	}
</script>
</body>
</html>