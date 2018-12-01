<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />

<!DOCTYPE html>
<html>
<head>
    <link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/dynamic-table-processor/css/dynamicTableProcessor.css" type="text/css" rel="stylesheet" />
	<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript" ></script>
	<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
	    <script src="${ctx}/static/component/dynamic-table-processor/js/dynamicTableProcessor.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-table-processor/js/dynamicTableProcessor2.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-report-processor/js/dynamicReportProcessor.js" type="text/javascript"></script>
</head>
<body>
	<div class="content-default" style="min-width: 1050px;">
		<form>
			<table style="min-width: 1000px;">
				<tr>
					<td align="right" style="width:4rem;">级别：</td>
					<td><div id="power-type-dropdownlist"></div></td>
					<td align="right" style="width:11rem;">开始时间：</td>
					<td><input id="startTime" name="startTime" class="form-control required" type="text" style="width:150px;" /></td>
					<td align="right" style="width:8rem;">结束时间：</td>
					<td><input id="endTime" name="endTime" class="form-control required" type="text" style="width:150px;" /></td>
 					<td>
						<button id="btn-query-info" type="button" class="btn btn-default btnicons" style="margin-left: 3rem;">
						<p class="btniconimg"><span>查询</span></p>
					    </button> 
						<button id="export" name="export" type="button" class="btn btn-default btnicons" style="margin-left: 2rem;">
                        <p class="btniconimgexport"><span>导出</span></p>
                        </button>
					</td> 
				</tr>
			</table>
		</form>
	</div>

	<table id="tb-ecTotal" class="tb-ecTotal" style="border: 1px solid; height:99%; width:99%; margin:0 auto; min-width: 750px;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>

	<div id="pg" style="text-align: right;"></div>
	<div id="error-div" ></div>
	<div id="datetimepicker-div"></div>

 	<script type="text/javascript"> 
      var tbEcTotal;
      var powerTypeList;
      var firstdate;
      var lastdate;
      //var dynamicreport;
 		$(document).ready(function(){
 			var date = new Date();
 			var today = "${today}";
 			var currentDate=date.getDate();
	 		var month = date.getMonth();  
 			var year = date.getYear();
	 		var yearTime=today.substring(0,4);
	 		var day = new Date(year,month,0);      
 			//当月一号
 			if(currentDate=="1"){
 				if(month=="0"){
 					yearTime=yearTime-1;
 					month=12;
 				}else if(0<month<10){
					month="0"+month;
				}
 				firstdate = yearTime + '-' + month + '-01';  
	 			lastdate = yearTime + '-' + month + '-' + day.getDate();  
 			}else{
				if(month<10){
					month="0"+(month+1);
				}else{
					month=month+1;
				}
 				firstdate = yearTime + '-' + month + '-01';
 				if(currentDate<"10"){
 					currentDate="0"+currentDate;
 				}
 				lastdate = yearTime + '-' + month +  '-' + currentDate;
 			}
 			
 			$('#startTime').val(firstdate);
 			$('#endTime').val(lastdate);
 			// 电表级别类型下拉列表
 			powerTypeList = $("#power-type-dropdownlist").dropDownList({
 				inputName: "powerTypeName",
 				inputValName: "powerType",
 				buttonText: "",
 				width: "116px",
 				readOnly: false,
 				required: true,
 				maxHeight: 200,
 				items: [{itemText:'一级',itemData:'1'},{itemText:'二级',itemData:'2'},{itemText:'三级',itemData:'3'},{itemText:'四级',itemData:'4'}]
 			});
 			powerTypeList.setData("二级", "2", "");
 			//开始时间
  			$("#startTime").datetimepicker({
  				id: 'datetimepicker-startTime',
  				containerId: 'datetimepicker-div',
  				lang: 'ch',
  				timepicker: false,
  				hours12:false,
  				allowBlank:true,
  				format: 'Y-m-d',
  			    formatDate: 'YYYY-mm-dd'
  			});

 			//结束时间
  			$("#endTime").datetimepicker({
  				id: 'datetimepicker-endTime',
  				containerId: 'datetimepicker-div',
  				lang: 'ch',
  				timepicker: false,
  				hours12:false,
  				allowBlank:true,
  				format: 'Y-m-d',
  			    formatDate: 'YYYY-mm-dd'
  			});

 		  	var infoCols = [
                 {title : '流水号',name : 'id',width : 150,sortable : false,align : 'left',hidden:true},
                 {title : '电表编号',name : 'deviceNo',width : 150,sortable : false,align : 'left'},
                 {title : '电表名',name : 'deviceName',width : 150,sortable : false,align : 'left'},
                 {title : '起始电量',name : 'startElectricPower',width : 150,sortable : false,align : 'left'},
                 {title : '结束电量',name : 'endElectricPower',width : 150,sortable : false,align : 'left'},
                 {title : '用电量',name : 'total',width : 150,sortable : false,align : 'left'},
             ]; 
 		$('#btn-query-info').on('click', function(){ 
 			tbEcTotal.load(); 
		}); 
 		tbEcTotal = $('#tb-ecTotal').mmGrid({
 				width:'99%',
                height:776,
                cols:infoCols,
                url:'${ctx}/power-supply/pdsElectricityMeterRecordHis/getPdsEcStatistics',
                method:'post',
                params:function(){
                	var data = {"": ""};
                	var startTime = $("#startTime").val().trim();
    				var endTime = $("#endTime").val().trim();
                	var curDate=new Date();
    				if (startTime != "" && startTime != null){
    					var startDate=new Date(Date.parse(startTime.replace(/-/g,"/")));
    					if(startDate >curDate){
    						showDialogModal("error-div", "操作提示", "开始时间请选择小于当天的日期");
    						return;
    					}
    					if (endTime!= "" && endTime != null){
	    					if(startTime >endTime){
	    						showDialogModal("error-div", "操作提示", "开始时间大于结束时间");
	    						return;
	    					}
    					}
						$(data).attr({"startTime": startTime});
					}
    				if (endTime != "" && endTime != null){
    					var endDate=new Date(Date.parse(endTime.replace(/-/g,"/")));
    					if(endDate >curDate){
    						showDialogModal("error-div", "操作提示", "结束时间请选择小于当天的日期");
    						return;
    					}
						$(data).attr({"endTime": endTime});
					}
    				$(data).attr({"projectCode" : projectCode});
    				var level = $("#powerType").val();
    				$(data).attr({"level" : level});
    				$(data).attr({"queryType" : "2"});
                	return data;
                	}, 
                remoteSort:true,
                multiSelect:false,
                checkCol:false,
                fullWidthRows:true,
                showBackboard:false,
                nowrap:true,
                autoLoad:false,
                plugins:[$('#pg').mmPaginator({"limitList":[20]})]
            });
 		
 		tbEcTotal.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
			}).on('loadSuccess',function(e,data) {
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "历史数据查询失败：" + errObj);
			}).load();
            
 		});
 		$('#export').on('click',function(){
			exportExecl();
 		});
 		
 		//导出excel
// 		function exportExecl() {
// 			var data = {"projectCode" : projectCode};
// 			var level = $("#powerType").val();
// 			$(data).attr({"level" : level});
// 			var startTime = $("#startTime").val().trim();
// 			$(data).attr({"startTime" : startTime});
// 			var endTime = $("#endTime").val().trim();
// 			$(data).attr({"endTime" : endTime});
// 			$(data).attr({"pageNumber" : "1"});
// 			$(data).attr({"pageSize" : "500"});
// 			$(data).attr({"sortName" : "deviceNo"});
// 			$(data).attr({"sortType" : "desc"});
// 			$(data).attr({"queryType" : "1"});
// 				$.ajax({
// 						type : "post",
// 						url : "${ctx}/power-supply/pdsElectricityMeterRecordHis/exportExecl",
// 						dataType : "json",
// 						data : JSON.stringify(data),
// 						contentType : "application/json;charset=utf-8",
// 						success : function(data) {
// 							var text=data;
// // 							if(data.code==0){
// // 								showDialogModal("error-div", "操作提示", data.data);
// // 							}
// 					},
// 					error : function(req, error, errObj) {
// 					}
// 				});
// 				//alert((eval(a).responseText);
// 		}
 		
		function exportExecl() {
			var level = $("#powerType").val();
			var startTime = $("#startTime").val().trim();
			var endTime = $("#endTime").val().trim();
			var url = "${ctx}/power-supply/pdsElectricityMeterRecordHis/exportExecl";
			var prams = "?startTime=" + startTime + "&endTime=" + endTime+ "&level=" + level+ "&projectCode=" + projectCode
					+"&pageNumber=1&pageSize=500&sortType=desc&sortName=deviceNo&queryType=2";
// 			$.each(dynamicTableItems, function(n, item) {
// 				var object = $("#" + item.inputName).val();
// 				if (object != undefined && object != null) {
// 					prams = prams + "&" + item.inputName + "=" + $.trim($("#" + item.inputName).val());
// 				}
// 			});
			window.open(url + prams);
		}
 		

 	 </script> 
 </body>
 </html>