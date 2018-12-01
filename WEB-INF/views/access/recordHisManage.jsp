<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<script type="text/javascript" src="${ctx}/static/map/map.js"></script>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/css/fontColor.css" rel="stylesheet" type="text/css" />
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
String orgId = request.getParameter("orgId");//用request得到 
if (orgId == null) {
	orgId = "";
}
%>
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/video-player/css/video-player.css" />
<script type="text/javascript"
	src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/video-player/js/video-player.js"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<script type="text/javascript" src="${ctx}/static/map/map.js"></script>
<script src="${ctx}/static/wadda/commons.js" type="text/javascript"></script>
<script src="${ctx}/static/wadda/wadda.js" type="text/javascript"></script>
<script src="${ctx}/static/js/jqueryPhoto.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script type="text/javascript"
	src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/jquery.SuperSlide.2.1.1.js"></script>
</head>
<body>
<div style="width:1640px;">
	<div class="content-default" style="margin-top: 10px;">
		<form id="select-form">
			<table>
				<tr>
					<td align="right" width="80">用户姓名：</td>
					<td><input id="personnelName" name="personnelName"
						placeholder="用户姓名" class="form-control required" type="text"
						style="width: 150px" /></td>
					<td align="right" width="60">通道：</td>
					<td>
						<div id="passage-dropdownlist"></div>
					</td>
					<td align="right" width="130">开始时间：</td>
					<td><input id="startDate" name="startDate" placeholder="开始时间"
						class="form-control required" type="text" style="width: 150px" />
					</td>
					<td align="right" width="100">结束时间：</td>
					<td><input id="endDate" name="endDate" placeholder="结束时间"
						class="form-control required" type="text" style="width: 150px" />
					</td>
					<td align="right" width="100">用户类型：</td>
					<td>
						<div id="personnelType-dropdownlist"></div>
					</td>
					<td>
						<button id="btn-query-rule" type="button"
							class="btn btn-default btn-common btn-common-green btnicons"
							style="margin-left: 60px;"><p class="btniconimg"><span>查询</span></p></button>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<table id="tb_groups" class="tb_groups" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>

	<div id="pg" style="text-align: right;"></div>
	<div id="datetimepicker-div"></div>
	<div id="access-snapshot-img"></div>
	<div id="error-div"></div>
	<div id = "show-video-dss"></div>
 </div>
  <script type="text/javascript">
  	var returnPassageData = "";
  	var organizeId = $("#login-org").data("orgId");
  	var passageDropdownList;
  	var personnelTypeDropdownList;
  	var tempList2;
	var accessRecordHis;
	var ruleTypeMap = new HashMap();
	$("#startDate").val(new Date().format("yyyy-MM-dd")+" 00:00:00");
	$("#endDate").val(new Date().format("yyyy-MM-dd")+" 23:59:59");
    $(document).ready(function() {
    	var orgId = '<%=orgId%>';
   		if(orgId != "") {
    		organizeId = orgId;
    	} 
		// 加载通道列表
		$.ajax({
			type: "post",
			url: "${ctx}/access-control/accessStatistics/queryAllPassage?CHECK_AUTHENTICATION=false&projectCode=" + projectCode,
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			success: function(passageData) {
					passageDropdownList = $('#passage-dropdownlist').dropDownList({
						inputName: "passageName",
						inputValName: "passageId",
						buttonText: "",
						width: "116px",
						readOnly: false,
						required: false,
						MultiSelect:true,
						maxHeight: 200,
						onSelect: function(i, data,icon) {
						},
						items: passageData.data
					});
					passageDropdownList.setData("请选择","","");
			},
			error: function(req,error,errObj) {
				showDialogModal("error-div","操作错误",errObj);
				return;
			}
		});
		
		// 用户类型列表
		personnelTypeDropdownList = $("#personnelType-dropdownlist").dropDownList({
			inputName: "personnelType",
			inputValName: "personnelTypeId",
			buttonText: "",
			width: "116px",
			readOnly: false,
			required: false,
			maxHeight: 200,
			onSelect: function(i, data, icon) {
			},
			items: [{itemText:'请选择',itemData:''},{itemText:'业主',itemData:'1'},{itemText:'访客',itemData:'2'},{itemText:'陌生人',itemData:'0'},{itemText:'其它',itemData:'9'}]
		});
		personnelTypeDropdownList.setData("请选择","","");
		
		$("#startDate").datetimepicker({
			id: 'datetimepicker-startDate',
			containerId: 'datetimepicker-div',
			lang: 'ch',
			timepicker: true,
			hours12:false,
			allowBlank:true,
			format: 'Y-m-d H:i:s',
		    formatDate: 'YYYY-mm-dd hh:mm:ss'
		});
		$("#endDate").datetimepicker({
			id: 'datetimepicker-endDate',
			containerId: 'datetimepicker-div',
			lang: 'ch',
			timepicker: true,
			hours12:false,
			allowBlank:true,
			format: 'Y-m-d H:i:s',
		    formatDate: 'YYYY-mm-dd hh:mm:ss'
		});
		
		// 规则列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'姓名',name:'userName',width:297,sortable:false,align:'left'},
				{
					title:'用户类型',
					name:'personnelType',
					width:300,
					sortable:false,
					align:'left',
					renderer : function(val, item, rowIndex) {
						if (item && item.personnelType == 1) {
							return "业主";
						} else if (item && item.personnelType == 2) {
							return "访客";
						} else if (item && item.personnelType == 0) {
							return "陌生人";
						} else if (item && item.personnelType == 4) {
							return "访客";
						} else if (item && item.personnelType == 9) {
							return "其他";
						} else {
							return "未知类型";
						}
				}},
				{title:'出入时间',name:'openDate',width:300,sortable:false,align:'left'},
				{title:'设备唯一号',name:'projectDeviceUuid',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'通道名称',name:'passageName',width:300,sortable:false,align:'left'},
				{
					title:'出入方式',
					name:'authType',
					width:240,
					sortable:false,
					align:'left',
					
					renderer : function(val, item, rowIndex) {
						if (item && item.authType == 0) {
							return "IC卡";
						} else if (item && item.authType == 1) {
							return "二维码";
						} else if (item && item.authType == 2) {
							return "身份证";
						} else if (item && item.authType == 3) {
							return "按键密码";
						} else if (item && item.authType == 4) {
							return "蓝牙按键开门";
						} else if (item && item.authType == 5) {
							return "远程开门";
						} else if (item && item.authType == 6) {
							return "人脸开门";
						} else {
							return "未知类型";
						}
				}},
				{
					title:'抓拍记录',
					name:'snapshotImages',
					width:200,
					sortable:false,
					align:'left',
					hidden:'true',
					renderer : function(val, item, rowIndex) {
						if (item.snapshotImages != undefined && item.snapshotImages.length > 0) {
							return '<img id="" src="${ctx}/static/images/icon34.png" />';
						} else {
							return "无";
						}
				}},
				{
					title : '操作',
					name : '',
					width : 200,
					align : 'center',
					lockWidth : true,
					lockDisplay : true,
					renderer : function(val, item, rowIndex) {
						if(item.projectDeviceUuid  != "" && item.projectDeviceUuid != null){
							var playBack = '<a class="calss-menu" href="#" title="回放"><img class="glyphicon-list-alt" src="${ctx}/static/images/playback.svg" /></a>';
							return playBack;
						}else{
							return "无";
						}
					}
				}
				
				
			];
			var pg = $('#pg').mmPaginator({"limitList":[14]});
			accessRecordHis = $('#tb_groups').mmGrid({
			height: 570,
			cols:cols,
			url:'${ctx}/access-control/accessStatistics/list?CHECK_AUTHENTICATION=false&projectCode='+projectCode,
			method:'post',
			params:function(){
				var selectForm = getFormData("select-form");
				var data = {};
			    var personnelName = $("#personnelName").val();
				if (personnelName != "" && personnelName != undefined){
					$(data).attr({"personnelName": personnelName});
				}
				var passageId = $("#passageId").val();
				if (passageId != "" && passageId != undefined){
					$(data).attr({"passageId": passageId});
				}
			    var personnelType = $("#personnelTypeId").val();
				if (personnelType != "" && personnelType != undefined){
					$(data).attr({"personnelType": personnelType});
				}
				var startDate = selectForm.startDate.trim();
				if (startDate != "" && startDate != undefined){
					$(data).attr({"startDate": startDate});
				}
				var endDate = selectForm.endDate.trim();
				if (endDate != "" && endDate != undefined){
					$(data).attr({"endDate": endDate});
				}
				$(data).attr({"projectCode": projectCode});
				return data;
			},
			remoteSort:false,
			multiSelect:false,
			checkCol:false,
			fullWidthRows:false,
			showBackboard:false,
			autoLoad:false,
			plugins:[pg]
		});
			
		accessRecordHis.on('cellSelect',function(e,item,rowIndex,colIndex){
// 			回放
				if ($(e.target).is('.calss-menu') || $(e.target).is('.glyphicon-list-alt')) {
					playBack(rowIndex);
				}else{
					accessRecordHisRow = accessRecordHis.row(rowIndex);
				}
			}).on('loadSuccess',function(e,data){
			}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
				if (accessRecordHisRow.snapshotImages != undefined && accessRecordHisRow.snapshotImages.length > 0 && accessRecordHisRow.snapshotImages != "null") {
					AccessCreateImgurlsModal(rowIndex);
				}
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
			$("#btn-query-rule").on('click',function (){
				accessRecordHis.load();
			});	
});
//     播放回放
    function playBack(rowIndex){
    	var row = accessRecordHis.row(rowIndex);
    	console.log("播放回放：id"+ row.id +",projectDeviceUuid:" + row.projectDeviceUuid + "，playbackTime：" + row.openDate);
    	if(row.projectDeviceUuid  != "" && row.projectDeviceUuid != null){
        	createModalWithLoad("show-video-dss", 730, 500, "视频回放",
        			"videomonitoring/showDssVideo?type=2&deviceNo="+ row.projectDeviceUuid +"&playbackTime=" + encodeURI(row.openDate), "", "", "","");
    	}
    }
    function AccessCreateImgurlsModal(rowIndex) {
		createModalWithLoad("access-snapshot-img", 780, 500, "人行出入情况", "/accessControl/accessFindSnapshotImage?CHECK_AUTHENTICATION=false&rowIndex=" + rowIndex, "", "", "");
		openModal("#access-snapshot-img-modal", false, false);
		$('#access-snapshot-img-modal').on('shown.bs.modal', function() {
			loadPic();
		})
	}
</script>
</body>
</html>