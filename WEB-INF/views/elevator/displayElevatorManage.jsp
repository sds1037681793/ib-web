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
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
</head>
<body>
	<div style="margin-top: 10px;" class="content-default">
		<form id="select-form">
			<table>
				<tr>
					<td align="right" width="100">电梯编号：</td>
					<td>
					<input id="deviceNumber" name="deviceNumber" placeholder="电梯编号" class="form-control required" type="text" style="width:140px"/>
					</td>
					<td align="right" width="100">电梯名称：</td>
					<td>
					<input id="deviceName" name="deviceName" placeholder="电梯名称" class="form-control required" type="text" style="width:140px"/>
					</td>
					<td align="right" width="128">投屏状态：</td>
					<td>
						<div id="display-status-dropdownlist"></div>
					</td>
					<td>
						<button id="btn-query-display" type="button" class="btn btn-default btn-common btn-common-green btnicons"style="margin-left:68px;">
                           <p class="btniconimg"><span>查询</span></p>
                     </button>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<table id="tb_groups" class="tb_groups" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
	</table>

	<div id="pg" style="text-align: right;"></div>
	<div id="error-div"></div>
  <script type="text/javascript">
  	var displayStatusObj;
  	var currDisplayStatus;
  	var maxDisplayCheck = 0;
  	var displayStatusDropList = [{itemText: "请选择", itemData: ""}, {itemText: "已投屏", itemData: "1"}, {itemText: "未投屏", itemData: "0"}];
    $(document).ready(function() {
    	// 设置投屏状态下拉列表
		displayStatusObj = $("#display-status-dropdownlist").dropDownList({
			inputName: "displayStatusName",
			inputValName: "displayStatusVal",
			buttonText: "",
			width: "117px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {
				currDisplayStatus = data;
			},
			items: displayStatusDropList
		});
		displayStatusObj.setData("请选择" ,"", "");
    	
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'电梯编号',name:'deviceNumber',width:180,sortable:false,align:'left'},
				{title:'电梯名称',name:'deviceName',width:140,sortable:false,align:'left'},
				{title:'投屏状态',name:'displayStatus',width:120,sortable:false,align:'left',
					renderer : function(val, item, rowIndex) {
					if (item && item.displayStatus == 1) {
						return "已投屏";
					} else {
						return "未投屏";
					}
			}},
				{title:'操作', name:'' ,width:120, align:'left', lockWidth:true, lockDisplay: true, renderer: function(val){
					var relateObj = '<a class="calss-link" href="#" title="投屏"><span class="glyphicon glyphicon-link" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
					var deleteObj = '<a class="calss-delete" href="#" title="取消投屏"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>'; 
					return relateObj + deleteObj;
				}}
			];
			var pg = $('#pg').mmPaginator({"limitList":[20]});
			picGrid = $('#tb_groups').mmGrid({
			width:'99%',
			height:776,
			cols:cols,
			url:"${ctx}/device/manage/getDisplayElevatorPage",
			method:'post',
			remoteSort:false,
			fullWidthRows:true,
			autoLoad:false,
			showBackboard:false,
			params:function(){
			    var deviceNumber = $("#deviceNumber").val();
			    var deviceName = $("#deviceName").val();
			    var data = {};
				if (deviceNumber != "" && deviceNumber != undefined){
					$(data).attr({"deviceNumber": deviceNumber});
				}
				if (deviceName != "" && deviceName != undefined){
					$(data).attr({"deviceName": deviceName});
				}
				if (currDisplayStatus != "" && currDisplayStatus != undefined){
					$(data).attr({"displayStatus": currDisplayStatus});
				}
				if (projectCode != "" && projectCode != undefined){
					$(data).attr({"projectCode": projectCode});
				}
				return data;
			},
			plugins:[pg]
		});
			picGrid.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
				if($(e.target).is('.calss-link') || $(e.target).is('.glyphicon-link')){
					// 添加投屏事件
				 	e.stopPropagation();  //阻止事件冒泡
					if (item.displayStatus == 1) {
						showDialogModal("error-div", "操作失败", "该电梯已投屏");
						return;
					}
				 	checkMax();
				 	if (maxDisplayCheck == 0) {
				 		showDialogModal("error-div", "操作失败", "投屏已达最大数，请先取消至少一台电梯投屏");
						return;
				 	}
				 	addDisplay(item.deviceId);
				}else if($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')){
					// 取消投屏事件
					e.stopPropagation();  //阻止事件冒泡
					if (item.displayStatus == 0) {
						showDialogModal("error-div", "操作失败", "该电梯未投屏");
						return;
					}
					removeDisplay(item.deviceId);
				}
			}).on('loadSuccess',function(e,data){
				$(function() {
					$("[data-toggle='tooltip']").tooltip();
				});
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
			$("#btn-query-display").on('click',function (){
				pg.load({"page":1});
				picGrid.load();
			});	
			
});
    
function checkMax() {
	$.ajax({
		type : "post",
		async : false,
		url : "${ctx}/device/manage/checkMaxNum",
		success : function(data) {
			if (data && data.code == 0) {
				maxDisplayCheck = data.data;
			}
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
}

function addDisplay(id) {
	$.ajax({
		type : "post",
		async : false,
		url : "${ctx}/device/manage/addDisplay?deviceId="+id,
		success : function(data) {
			if (data && data.code == 0 && data.data == 0) {
				showDialogModal("error-div", "操作成功", "投屏成功");
				picGrid.load();
				return;
			}else {
				showDialogModal("error-div", "操作错误", "投屏失败");
				return;
			}
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
}
   
function removeDisplay(id) {
	$.ajax({
		type : "post",
		url : "${ctx}/device/manage/removeDisplay?deviceId="+id,
		success : function(data) {
			if (data && data.code == 0 && data.data == 0) {
				showDialogModal("error-div", "操作成功", "取消投屏成功");
				picGrid.load();
				return;
			}else if (data && data.code == 0 && data.data != 0) {
				showDialogModal("error-div", "操作失败", "取消投屏失败");
				return;
			}else {
				showDialogModal("error-div", "操作错误", "投屏失败");
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