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
<style type="text/css">
.rib-block {
	display: -webkit-inline-box;
	height: 37px;
	display: -moz-inline-box;
	display: inline-table;
}
.rib-block table {
	width: 100%;
	height: 100%;
}

.rib-block td {
	text-align: right;
	width: 100px;
}
#alarmCode-ul {
    width: 150px;
}
#deviceName-ul {
    width: 150px;
}
#alarmStatus-ul {
    width: 150px;
}
</style>
</head>
<body>
	<div class="content-default">
		<form id="select-form">
		<div class="rib-block">
				<table>
					<tr>
						<td>电梯名称：</td>
						<td style="width: 170px;"><div id="device-name-dropdownlist"></div></td>
					</tr>
				</table>
			</div>
			<div class="rib-block">
				<table>
					<tr>
						<td>报警类型：</td>
						<td style="width: 170px;"><div id="alarm-code-dropdownlist"></div></td>
					</tr>
				</table>
			</div>
			<div class="rib-block">
				<table>
					<tr>
						<td>状态：</td>
						<td style="width: 170px;"><div id="alarm-status-dropdownlist"></div></td>
					</tr>
				</table>
			</div>
			<div class="rib-block">
				<table>
					<tr>
						<td>上报开始时间：</td>
						<td style="width:150px"><input id="occurredStartTime" name="occurredStartTime" placeholder="开始时间" class="form-control required" type="text" style="width:150px"/></td>
					</tr>
				</table>
			</div>
			<div class="rib-block">
				<table>
					<tr>
						<td>上报结束时间：</td>
						<td style="width:150px"><input id="occurredEndTime" name="occurredEndTime" placeholder="结束时间" class="form-control required" type="text" style="width:150px"/></td>
					</tr>
				</table>
			</div>
			<div class="rib-block">
				<table>
					<tr>
						<td align="right" colspan="2" style="width:275px;">
						<button id="btn-query-alarm-detail" type="button" class="btn btn-default btn-common btn-common-green btnicons">
                        <p class="btniconimg"><span>查询</span></p>
                        </button></td>
					</tr>
				</table>
			</div>
		</form>
	</div>

	<table id="tb_groups" class="tb_groups" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<div id="datetimepicker-div"></div>
 <script type="text/javascript">
/* $("#occurredStartTime").val(new Date().format("yyyy-MM-dd")+" 00:00:00");
$("#occurredEndTime").val(new Date().format("yyyy-MM-dd")+" 23:59:59"); */
$("#occurredStartTime").val("");
$("#occurredEndTime").val("");
var locationId;
var deviceId;
var tempAlarmCodeDropdownList;
var alarmCodeDropdownList = [ {
 				itemText : '请选择',
 				itemData : ''
 			}, {
 				itemText : '困人',
 				itemData : '37'
 			}, {
 				itemText : '运行中开门',
 				itemData : '38'
 			}, {
 				itemText : '轿厢在开锁区域外停止',
 				itemData : '39'
 			}, {
 				itemText : '厅(轿)门开门不到位',
 				itemData : '40'
 			}, {
 				itemText : '厅(轿)门关门不到位',
 				itemData : '41'
 			}, {
 				itemText : '冲顶',
 				itemData : '42'
 			}, {
 				itemText : '蹲底',
 				itemData : '43'
 			}, {
 				itemText : '设备断电',
 				itemData : '44'
 			}, {
 				itemText : '长时间开门',
 				itemData : '45'
 			} , {
 				itemText : '数据异常-运行中开门',
 				itemData : '136'
 			}];
  
 var tempAlarmStatusDropdownList;
 var alarmStatusDropdownList = [{itemText : '请选择', itemData : '0'},{itemText : '未解除', itemData : '1'},{itemText : '已解除', itemData : '2'}]
 var deviceMap = new HashMap();
 var tempDeviceNameDropdownList;
 var deviceNameDropdownList = new Array();
 var currDevice;
    $(document).ready(function() {
    	deviceNameDropdownList[0] = {itemText : '请选择', itemData : ''};
		$(returnData.items).each(function(key,item) {
			deviceNameDropdownList[deviceNameDropdownList.length] = {itemText:item.name, itemData:item.deviceNumber};
			deviceMap.put(item.id, item);
		});
		if('' != "${param.deviceId}"){
			deviceId = "${param.deviceId}";
			currDevice = deviceMap.get(deviceId);
		}
    	// 电梯名称列表
		tempDeviceNameDropdownList = $('#device-name-dropdownlist').dropDownList({
			inputName: "deviceName",
			inputValName: "deviceNameVal",
			buttonText: "",
			width: "116px",
			readOnly: false,
			required: true,
			maxHeight: 300,
			onSelect: function(i, data,icon) {
			},
			items: deviceNameDropdownList
		});
		tempDeviceNameDropdownList.setData(currDevice.name,currDevice.deviceNumber);
    	
    	// 报警类型列表
		tempAlarmCodeDropdownList = $('#alarm-code-dropdownlist').dropDownList({
			inputName: "alarmCode",
			inputValName: "alarmCodeVal",
			buttonText: "",
			width: "116px",
			readOnly: false,
			required: true,
			maxHeight: 300,
			onSelect: function(i, data,icon) {
			},
			items: alarmCodeDropdownList
		});
		tempAlarmCodeDropdownList.setData('请选择','');
		
		// 报警状态列表
		tempAlarmStatusDropdownList = $('#alarm-status-dropdownlist').dropDownList({
			inputName: "alarmStatus",
			inputValName: "alarmStatusVal",
			buttonText: "",
			width: "116px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data,icon) {
			},
			items: alarmStatusDropdownList
		});
		if(talarmNum==""){
			tempAlarmStatusDropdownList.setData('已解除','2');
		}else{
			tempAlarmStatusDropdownList.setData('未解除','1');
		}
		
    	
    	
    	$("#occurredStartTime").datetimepicker({
    		id: 'datetimepicker-startDate',
    		containerId: 'datetimepicker-div',
    		lang: 'ch',
    		timepicker: true,
    		hours12:false,
    		allowBlank:true,
    		format: 'Y-m-d H:i:s',
    		formatDate: 'YYYY-mm-dd hh:mm:ss'
   		});
	   		$("#occurredEndTime").datetimepicker({
	   		id: 'datetimepicker-endDate',
	   		containerId: 'datetimepicker-div',
	   		lang: 'ch',
	   		timepicker: true,
	   		hours12:false,
	   		allowBlank:true,
	   		format: 'Y-m-d H:i:s',
	   		formatDate: 'YYYY-mm-dd hh:mm:ss'
   		});
    		
	   	// 电梯报警明细列表
		    var cols = [
					{title:'id',name:'id',width:120,sortable:false,align:'left',hidden:'true'},
					{title:'电梯名称',name:'deviceName',width:200,sortable:false,align:'left'},
					{title:'报警类型',name:'alarmCode',width:200,sortable:false,align:'left',
					renderer : function(val, item, rowIndex) {
						if (item && item.alarmCode == 37) {
							return "困人";
						} else if (item && item.alarmCode == 38) {
							return "运行中开门";
						}else if (item && item.alarmCode == 39) {
							return "轿厢在开锁区域外停止";
						}else if (item && item.alarmCode == 40) {
							return "厅(轿)门开门不到位";
						}else if (item && item.alarmCode == 41) {
							return "厅(轿)门关门不到位";
						}else if (item && item.alarmCode == 42) {
							return "冲顶";
						}else if (item && item.alarmCode == 43) {
							return "蹲底";
						}else if (item && item.alarmCode == 44) {
							return "设备断电";
						}else if (item && item.alarmCode == 45) {
							return "长时间开门";
						}else if (item && item.alarmCode == 136) {
							return "数据异常-运行中开门";
						}
					}},
					{title:'上报时间',name:'occurredTime',width:200,sortable:false,align:'left'},
					{title:'状态',name:'alarmStatus',width:200,sortable:false,align:'left',
					renderer : function(val, item, rowIndex) {
						if (item && item.alarmStatus == 1) {
							return "未解除";
						} else if (item && item.alarmStatus == 2) {
							return "已解除";
						}
					}},
					{
						title:'抓拍记录',
						name:'snapshotImages',
						width:205,
						sortable:false,
						align:'left',
						renderer : function(val, item, rowIndex) {
							if (item.snapshotImages != undefined && item.snapshotImages.length > 0) {
								return '<img id="" src="${ctx}/static/images/icon34.png" />';
							} else {
								return "无";
							}
					}}
				];
				var pg = $('#pg').mmPaginator({"limitList":[8]});
				alarmDetailGrid = $('#tb_groups').mmGrid({
				height:332,
				cols:cols,
				url:"${ctx}/elevator/elevatorDataService/list",
				method:'post',
				remoteSort:false,
				multiSelect:true,
				fullWidthRows:false,
				autoLoad:false,
				params:function(){
					var data = {
							"sortName" : "occurredTime",
							"sortType" : "desc",
							"page" : 1,
							"limit" : 10
						};
					var deviceName = $("#deviceNameVal").val();
					if (deviceName != "" && deviceName != undefined){
						$(data).attr({"deviceName": deviceName});
					}
					var alarmCode = $("#alarmCodeVal").val();
					if (alarmCode != "" && alarmCode != undefined){
						$(data).attr({"alarmCode": alarmCode});
					}
					var alarmStatus = $("#alarmStatusVal").val();
					if (alarmStatus != "" && alarmStatus != undefined){
						$(data).attr({"alarmStatus": alarmStatus});
					}
					var selectForm = getFormData("select-form");
					var occurredStartTime = selectForm.occurredStartTime.trim();
					var occurredEndTime = selectForm.occurredEndTime.trim();
					if (occurredStartTime != "" && occurredStartTime != undefined){
						$(data).attr({"occurredStartTime": occurredStartTime});
					}
					if (occurredEndTime != "" && occurredEndTime != undefined){
						$(data).attr({"occurredEndTime": occurredEndTime});
					}
					return data;
				},
				plugins:[pg]
			});
				alarmDetailGrid.on('cellSelect',function(e,item,rowIndex,colIndex){
					alarmDetailGridRow = alarmDetailGrid.row(rowIndex);
				}).on('loadSuccess',function(e,data){
				}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
					if (alarmDetailGridRow.snapshotImages != undefined && alarmDetailGridRow.snapshotImages.length > 0 && alarmDetailGridRow.snapshotImages != "null") {
						createImgurlsModal(rowIndex);
					}
				}).on('loadError',function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", "数据加载失败：" + errObj);
				}).load();
				$("#btn-query-alarm-detail").on('click',function (){
					pg.load({"page":1});
					alarmDetailGrid.load();
				});	
});
    
    function createImgurlsModal(rowIndex) {
		createModalWithLoad("detail-snapshot-img", 780, 500, "场景抓拍", "elevatorSystem/detailSnapshotImage?rowIndex=" + rowIndex, "", "", "");
		openModal("#detail-snapshot-img-modal", false, false);
		$('#detail-snapshot-img-modal').on('shown.bs.modal', function() {
			loadPic();
		})
	}
	
</script>
</body>
</html>