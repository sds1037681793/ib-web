<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
</head>

<body>
<div style="width:1640px;">
	<div class="content-default" style="margin-top: 10px; ">
		<form id="select-form">
			<table>
				<tr>
					<td align="right" width="80">用户姓名：</td>
					<td><input id="custName" name="custName"
						placeholder="用户姓名" class="form-control required" type="text"
						style="width: 150px" /></td>
						<td align="right" width="80">车牌号：</td>
					<td><input id="licensePlate" name="licensePlate"
						placeholder="车牌号" class="form-control required" type="text"
						style="width: 150px" /></td>
						<td align="right" width="100">车辆类型：</td>
					<td><div id="car-type-dropdown"></div></td>
					<td align="right" width="114">开始时间：</td>
					<td><input id="startDate" name="startDate" placeholder="开始时间"
						class="form-control required" type="text" style="width: 150px" />
					</td>
					<td align="right" width="80">结束时间：</td>
					<td><input id="endDate" name="endDate" placeholder="结束时间"
						class="form-control required" type="text" style="width: 150px" />
					</td>
					<td>
						<button id="btn-query-rule" type="button"
							class="btn btn-default btn-common btn-common-green btnicons"
							style="margin-left: 45px;"><p class="btniconimg"><span>查询</span></p></button>
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
	<div id="error-div"></div>
 </div>
  <script type="text/javascript">
  	var returnPassageData = "";
  	var passageDropdownList;
  	var personnelTypeDropdownList;
  	var tempList2;
	var accessRecordHis;
	var ruleTypeMap = new HashMap();
	$("#startDate").val(new Date().format("yyyy-MM-dd")+" 00:00:00");
	$("#endDate").val(new Date().format("yyyy-MM-dd")+" 23:59:59");
    $(document).ready(function() {
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
		var carTypeItems = [{itemText:"请选择",itemData:"",Selected:true},
		                    {itemText:"固定车",itemData:1},
		                    {itemText:"临时车",itemData:0},
		                    {itemText:"访客车",itemData:2}];
		$("#car-type-dropdown").dropDownList({
			inputName: "car-type-name",
			inputValName: "car-type-val",
			buttonText: "",
			width: "116px",
			readOnly: false,
			required: false,
			MultiSelect:true,
			maxHeight: 200,
			onSelect: function(i, data,icon) {
			},
			items: carTypeItems
		});
		// 规则列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'用户姓名',name:'custName',width:287,sortable:false,align:'left',renderer : function(val, item, rowIndex) {
					if (item && item.custName == null||item.custName=="") {
						return "--";
					}else{
						return item.custName;
					}
				}},
				{title:'车牌号',name:'licensePlate',width:300,sortable:false,align:'left'},
				{
					title:'用户类型',
					name:'isFixedCar',
					width:300,
					sortable:false,
					align:'left',
					renderer : function(val, item, rowIndex) {
						if (item && item.isFixedCar ==null||item.isFixedCar=="" ) {
							return "--";
						} else  {
							return item.isFixedCar;
						} 
				}},
				{title:'通道名称',name:'passageName',width:320,sortable:false,align:'left'},
				{title:'出入时间',name:'passTime',width:430,sortable:false,align:'left'},
			];
			var pg = $('#pg').mmPaginator({"limitList":[14]});
			accessRecordHis = $('#tb_groups').mmGrid({
			height:570,
			cols:cols,
			url:'${ctx}/parking/parkingQuery/listQuery',
			method:'post',
			params:function(){
				var selectForm = getFormData("select-form");
				var data = {};
			    var custName = $("#custName").val();
				if (custName != "" && custName != undefined){
					$(data).attr({"custName": custName});
				}
				var licensePlate = $("#licensePlate").val();
				if (licensePlate != "" && licensePlate != undefined){
					$(data).attr({"licensePlate": licensePlate});
				}
				var carType = $("#car-type-val").val();
				if (carType != "" && carType != undefined){
					$(data).attr({"carType": carType});
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
			/* sortName:'passTime',
			sortStatus:'desc', */
			multiSelect:false,
			checkCol:false,
			fullWidthRows:false,
			showBackboard:false,
			autoLoad:false,
			plugins:[pg]
		});
			accessRecordHis.on('cellSelect',function(e,item,rowIndex,colIndex){
				accessRecordHisRow = accessRecordHis.row(rowIndex);
			}).on('loadSuccess',function(e,data){
			}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
			$("#btn-query-rule").on('click',function (){
				accessRecordHis.load();
			});	
});
    
</script>

</body>
</html>