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
					<td align="right" style="width:4rem;">月份：</td>
					<td><div id="power-month-dropdownlist"></div></td>
					<td align="right" style="width:8rem;">电表名称：</td>
					<td><input id="id-powerName" name="id-powerName" class="form-control required" type="text" style="width:150px;" /></td>
 					<td>
						<button id="btn-query-info" type="button" class="btn btn-default btnicons">
						<p class="btniconimg"><span>查询</span></p>
					</button > 
                    </td>
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
      
      var powerMonthNameList;
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
 			initPowerMonthNameList();
 		  	var infoCols = [
                {title : '设备序号',name : 'deviceId',width : 80,sortable : false,align : 'left'},
                {title : '电表名称',name : 'deviceName',width : 80,sortable : false,align : 'left'},
                {title : '账户余额(元)',name : 'accountBalance',width : 80,sortable : false,align : 'left'},
                {title : '剩余时长(天)',name : 'remianTime',width : 80,sortable : false,align : 'left'},
                {title : '1日',name : 'one',width : 70,sortable : false,align : 'left'},
                {title : '2日',name : 'two',width : 70,sortable : false,align : 'left'},
                {title : '3日',name : 'three',width : 70,sortable : false,align : 'left'},
                {title : '4日',name : 'four',width : 70,sortable : false,align : 'left'},
                {title : '5日',name : 'five',width : 70,sortable : false,align : 'left'},
                {title : '6日',name : 'six',width : 70,sortable : false,align : 'left'},
                {title : '7日',name : 'seven',width : 70,sortable : false,align : 'left'},
                {title : '8日',name : 'eight',width : 70,sortable : false,align : 'left'},
                {title : '9日',name : 'nine',width : 70,sortable : false,align : 'left'},
                {title : '10日',name : 'ten',width : 70,sortable : false,align : 'left'},
                {title : '11日',name : 'eleven',width : 70,sortable : false,align : 'left'},
                {title : '12日',name : 'twelve',width : 70,sortable : false,align : 'left'},
                {title : '13日',name : 'thirteen',width : 70,sortable : false,align : 'left'},
                {title : '14日',name : 'fourteen',width : 70,sortable : false,align : 'left'},
                {title : '15日',name : 'fifteen',width : 70,sortable : false,align : 'left'},
                {title : '16日',name : 'sixteen',width : 70,sortable : false,align : 'left'},
                {title : '17日',name : 'seventeen',width : 70,sortable : false,align : 'left'},
                {title : '18日',name : 'eighteen',width : 70,sortable : false,align : 'left'},
                {title : '19日',name : 'nineteen',width : 70,sortable : false,align : 'left'},
                {title : '20日',name : 'twenty',width : 70,sortable : false,align : 'left'},
                {title : '21日',name : 'twentyOne',width : 70,sortable : false,align : 'left'},
                {title : '22日',name : 'twentyTwo',width : 70,sortable : false,align : 'left'},
                {title : '23日',name : 'twentyThree',width : 70,sortable : false,align : 'left'},
                {title : '24日',name : 'twentyFour',width : 70,sortable : false,align : 'left'},
                {title : '25日',name : 'twentyFive',width : 70,sortable : false,align : 'left'},
                {title : '26日',name : 'twentySix',width : 70,sortable : false,align : 'left'},
                {title : '27日',name : 'twentySeven',width : 70,sortable : false,align : 'left'},
                {title : '28日',name : 'twentyEight',width : 70,sortable : false,align : 'left'},
                {title : '29日',name : 'twentyNine',width : 70,sortable : false,align : 'left'},
                {title : '30日',name : 'thirty',width : 70,sortable : false,align : 'left'},
                {title : '31日',name : 'thirtyOne',width : 70,sortable : false,align : 'left'}
             ]; 
 		$('#btn-query-info').on('click', function(){ 
 			tbEcTotal.load(); 
		}); 
 		tbEcTotal = $('#tb-ecTotal').mmGrid({
 				width:'99%',
                height:776,
                cols:infoCols,
                url:'${ctx}/power-supply/supplyPowerMain/getPowerRecordReportData',
                method:'post',
                params:function(){
                	var data = {"": ""};
                	var deviceName = $("#id-powerName").val();
                	var yearTime = $("#powerYearValue").val().trim();
                	var montTime = $("#powerMonthValue").val().trim();
                	var timestamp = yearTime+"-"+montTime;
    				$(data).attr({"deviceName" : deviceName});
    				$(data).attr({"timestamp" : timestamp});
    				$(data).attr({"projectCode" : projectCode});
                	return data;
                	}, 
                remoteSort:true,
                multiSelect:false,
                checkCol:false,
                fullWidthRows:true,
                showBackboard:false,
                shrinkToFit:false,  
                autoScroll: true, 
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
        	var montTime = $("#powerMonthValue").val().trim();
        	var timestamp = yearTime+"-"+montTime;
			var url = "${ctx}/power-supply/supplyPowerMain/exportDailyRecordExecl";
			var prams = "?deviceName=" + deviceName + "&timestamp=" + timestamp+  "&projectCode=" + projectCode
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
		
		// 电表级别类型下拉列表
 		function initPowerMonthNameList(){
 			powerMonthNameList = $("#power-month-dropdownlist").dropDownList({
 				inputName : 'powerMonthName',
 				inputValName : 'powerMonthValue',
 				buttonText : "",
 				width : "118px",
 				readOnly : false,
 				required : true,
 				maxHeight : 100,
 				onSelect : function(i, data, icon) {
 				},
 				items : [ {itemText : '1月',itemData : '01'}, 
 				          {itemText : '2月',itemData : '02'},
 				          {itemText : '3月',itemData : '03'},
 				          {itemText : '4月',itemData : '04'},
 				          {itemText : '5月',itemData : '05'},
 				          {itemText : '6月',itemData : '06'},
 				          {itemText : '7月',itemData : '07'},
 				          {itemText : '8月',itemData : '08'},
 				          {itemText : '9月',itemData : '09'},
 				          {itemText : '10月',itemData : '10'},
 				          {itemText : '11月',itemData : '11'},
 				          {itemText : '12月',itemData : '12'}]
 			});
 			powerMonthNameList.setData("1月","01","");
 		}
 		
  		

 	 </script> 
 </body>
 </html>