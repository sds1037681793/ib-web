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
	<div style="margin-top: 10px;" class="content-default">
		<form id="select-form">
			<table>
				<tr>
					<td align="right" width="120">自定义图片名称：</td>
					<td>
					<input id="fileName" name="fileName" placeholder="自定义图片名称" class="form-control required" type="text" style="width:140px"/>
					</td>
					<td>
                    <button id="btn-query-picture" type="button" class="btn btn-default btn-common btn-common-green btnicons"
                    style="margin-left: 3rem;">
                           <p class="btniconimg"><span>查询</span></p>
                     </button>
                     </td>
                     <td>
					 <button id="btn-add-picture" type="button" class="btn btn-default btn-common btn-common-green btnicons"
							style="margin-left: 2rem;">
                          <p class="btniconimgadd"><span>新增</span>
                     </button>
                     </td>
				</tr>
			</table>
		</form>
	</div>

	<table id="tb_groups" class="tb_groups" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>

	<div id="pg" style="text-align: right;"></div>
	<div id="rest-config-edit"></div>
	<div id="rest-config-relate"></div>
	<div id="relate-edit"></div>
	<div id="relate-device"></div>
	<div id="error-div"></div>
  <script type="text/javascript">
    $(document).ready(function() {
		// 图片展现列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'图片名称',name:'pictureName',width:100,sortable:false,align:'left',renderer: function(val, item, rowIndex){
                    if (item.pictureName.length > 6) {
                    	pictureName = item.pictureName.substr(0, 6) + "...";
	                    return '<span data-toggle="tooltip" data-placement="right" title="'+item.pictureName+'">' + pictureName + '</span>';
					} else {
						return item.pictureName;
					}
                }},
				{title:'图片保存路径',name:'filePath',width:600,sortable:false,align:'left'},
				{title:'自定义图片名称',name:'fileName',width:160,sortable:false,align:'left'},
				{title:'创建时间',name:'createTime',width:160,sortable:false,align:'left'},
				{title:'操作', name:'' ,width:100, align:'left', lockWidth:true, lockDisplay: true, renderer: function(val){
					var modifyObj = '<a class="calss-modify" href="#" title="修改"><span class="glyphicon glyphicon-pencil" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
					var relateObj = '<a class="calss-link" href="#" title="关联信息"><span class="glyphicon glyphicon-link" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
					var deleteObj = '<a class="calss-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>'; 
					return modifyObj + relateObj + deleteObj;
				}}
			];
			var pg = $('#pg').mmPaginator({"limitList":[20]});
			picGrid = $('#tb_groups').mmGrid({
			height:776,
			cols:cols,
			url:"${ctx}/device/pictureBusiness/list",
			method:'post',
			remoteSort:false,
			multiSelect:true,
			fullWidthRows:true,
			showBackboard:false,
			autoLoad:false,
			params:function(){
			    var fileName = $("#fileName").val();
				data = {};
				if (fileName != "" && fileName != undefined){
					$(data).attr({"fileName": fileName});
				}
				$(data).attr({"organizeId": projectId});
				return data;
			},
			plugins:[pg]
		});
			picGrid.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
				if($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')){
					
				}else if($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')){
				 	e.stopPropagation();  //阻止事件冒泡
				 	createModalWithLoad("rest-config-edit", 600, 209, "修改图片", "picture/edit?pictureId=" + item.id,  "savePicture()", "confirm-close", "");
		            openModal("#rest-config-edit-modal", true, true);
				}else if($(e.target).is('.calss-link') || $(e.target).is('.glyphicon-link')){
					// 关联坐标事件
				 	e.stopPropagation();  //阻止事件冒泡
// 				 	createModalWithLoad("rest-config-relate", 715, 0, "图片关联信息", "picture/relateCoordinate?pictureId=" + item.id,  "close1()", "confirm-close", "",110);
				 	createModalWithLoad("rest-config-relate", 1000, 676, "图片关联信息", "picture/relateEdit?pictureId=" + item.id, "saveRelate()", "confirm-close", "",110);
		            openModal("#rest-config-relate-modal", true, true);
				}else if($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')){
					// 删除按钮事件
					 e.stopPropagation();  //阻止事件冒泡
					showDialogModal("error-div","操作提示","确定要删除该图片吗？",2,"deletePicture("+ item.id +");");
				}
			}).on('loadSuccess',function(e,data){
				$(function() {
					$("[data-toggle='tooltip']").tooltip();
				});
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
			$("#btn-query-picture").on('click',function (){
				pg.load({"page":1});
				picGrid.load();
			});	
			
 	$('#btn-add-picture').on('click',function(){
		createModalWithLoad("rest-config-edit", 600, 213, "新增图片", "picture/edit", "savePicture()", "confirm-close", "","");
        openModal("#rest-config-edit-modal", true, true);
	});
});
	
	
	function deletePicture(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/device/pictureBusiness/deletePicture/" + id,
			success : function(data) {
				if (data && data.code == 0 && data.data == false) {
					showDialogModal("error-div", "操作失败", "图片存在关联关系，无法删除");
					return;
				}else if (data && data.code == 0 && data.data) {
					showDialogModal("error-div", "操作成功", "删除成功！");
					picGrid.load();
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
</script>
</body>
</html>