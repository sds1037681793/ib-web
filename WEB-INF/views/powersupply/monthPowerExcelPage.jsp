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
    <script src="${ctx}/static/component/dynamic-report-processor/js/dynamicReportProcessor.js" type="text/javascript"></script>
</head>
<body>
	<div class="content-default" style="min-width: 1050px;">
		<form>
			<table style="min-width: 1000px;">
				<tr>
					<td align="right" style="width:4rem;">年份：</td>
					<td><div id="power-year-dropdownlist"></div></td>
					<td align="right" style="width:11rem;">电表名称：</td>
					<td><input id="id-powerName" name="id-powerName" class="form-control required" type="text" style="width:150px;" /></td>
					<td align="right" style="width:8rem;">类型：</td>
					<td><div id="power-Type-dropdownlist"></div></td>
 					<td>
						<button id="btn-query-info" type="button" class="btn btn-default btnicons" style="margin-left:68px;">
						<p class="btniconimg"><span>查询</span></p>
					    </button> 
					<td>
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
      var powerYearNameList;
      var powerYearNameCols;
      var powerTypeList;
      var dynamicTableItems;
  		var date = new Date();
  		var today = "${today}";
		var currentDate=date.getDate();
		var month = date.getMonth();  
		var year = date.getYear();
		var yearTime=today.substring(0,4);
		var day = new Date(year,month,0);    
      //var dynamicreport;
 		$(document).ready(function(){
 			initPowerYearNameList();
 			// 电表级别类型下拉列表
 			powerTypeList = $("#power-Type-dropdownlist").dropDownList({
 				inputName: "powerTypeName",
 				inputValName: "powerTypeValue",
 				buttonText: "",
 				width: "116px",
 				readOnly: false,
 				required: true,
 				maxHeight: 200,
 				items: [{itemText:'居民用电',itemData:'1'},{itemText:'供配电',itemData:'2'}]
 			});
 			powerTypeList.setData("居民用电", "1", "");

 		  	var infoCols = [
                {title : '设备序号',name : 'deviceId',width : 100,sortable : false,align : 'left'},
                {title : '电表名称',name : 'deviceName',width : 100,sortable : false,align : 'left'},
                {title : '类型',name : 'powerType',width : 100,sortable : false,align : 'left'},
                {title : '等级',name : 'level',width : 80,sortable : false,align : 'left'},
                {title : '倍率',name : 'multiply',width : 80,sortable : false,align : 'left'},
                {title : '1月',name : 'january',width : 80,sortable : false,align : 'left'},
                {title : '2月',name : 'february',width : 80,sortable : false,align : 'left'},
                {title : '3月',name : 'march',width : 80,sortable : false,align : 'left'},
                {title : '4月',name : 'april',width : 80,sortable : false,align : 'left'},
                {title : '5月',name : 'may',width : 80,sortable : false,align : 'left'},
                {title : '6月',name : 'june',width : 80,sortable : false,align : 'left'},
                {title : '7月',name : 'july',width : 80,sortable : false,align : 'left'},
                {title : '8月',name : 'august',width : 80,sortable : false,align : 'left'},
                {title : '9月',name : 'september',width : 80,sortable : false,align : 'left'},
                {title : '10月',name : 'october',width : 80,sortable : false,align : 'left'},
                {title : '11月',name : 'november',width : 80,sortable : false,align : 'left'},
                {title : '12月',name : 'december',width : 80,sortable : false,align : 'left'},
             ]; 
 		$('#btn-query-info').on('click', function(){ 
 			tbEcTotal.load(); 
		}); 
 		tbEcTotal = $('#tb-ecTotal').mmGrid({
     			width:'99%',
                height:776,
                cols:infoCols,
                url:'${ctx}/power-supply/supplyPowerMain/getPowerMonthReportData',
                method:'post',
                params:function(){
                	var data = {"": ""};
                	var deviceName = $("#id-powerName").val();
                	var yearTime = $("#powerYearValue").val().trim();
    				var powerType = $("#powerTypeValue").val();
    				$(data).attr({"deviceName" : deviceName});
    				$(data).attr({"yearTime" : yearTime});
    				$(data).attr({"powerType" : powerType});
    				$(data).attr({"projectCode" : projectCode});
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
		function exportExecl() {
			var deviceName = $("#id-powerName").val();
        	var yearTime = $("#powerYearValue").val().trim();
			var powerType = $("#powerTypeValue").val();
			var url = "${ctx}/power-supply/supplyPowerMain/exportMonthExecl";
			var prams = "?deviceName=" + deviceName + "&yearTime=" + yearTime+ "&powerType=" + powerType+ "&projectCode=" + projectCode
					+"&pageNumber=1&pageSize=500&sortType=desc&sortName=deviceNo";
			window.open(url + prams);
		}
 		
		// 电表级别类型下拉列表
 		function initPowerYearNameList(){
 			$.ajax({
 				type: "post",
 				url: "${ctx}/power-supply/supplyPowerMain/getYearCols?projectCode="+projectCode,
 				dataType: "json",
 				async:false,
 				contentType: "application/json;charset=utf-8",
 				success: function(data) {
 					powerYearNameCols = data; 
 					powerYearNameList = $("#power-year-dropdownlist").dropDownList({
 				        inputName: 'powerYearName',
 				        inputValName: 'powerYearValue',
 				        buttonText: "",
 				        width: "116px",
 				        readOnly: false,
 				        required: true,
 				        maxHeight: 200,
 				        onSelect: function(i, data, icon) {		
 				        	
 				        },
 				        items:powerYearNameCols
 					});
 					powerYearNameList.setData(powerYearNameCols[powerYearNameCols.length-1].itemText,powerYearNameCols[powerYearNameCols.length-1].itemData,'');
 				},
 				error: function(req,error,errObj) {		
 					showDialogModal("error-div","查找年份数据失败",errObj);
 						return;
 				}
 			}); 
 		}
  		

 	 </script> 
 </body>
 </html>