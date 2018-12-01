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
	<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript" ></script>
	<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
</head>
<body>
	<div class="content-default" style="min-width: 750px;">
		<form>
		
			<table style="min-width: 720px;">
				<tr>
					<td align="right" style="width:8rem;">电表名称：</td>
					<td><div id="meterName-dropdownlist"></div></td>
					<td align="right" style="width:10rem;">操作员：</td>
					<td><div id="operator-dropdownlist"></div></td>
					<td align="right" style="width:11rem;">开始时间：</td>
					<td><input id="startTime" name="startTime" class="form-control required" type="text" style="width:150px;" /></td>
					<td align="right" style="width:8rem;">结束时间：</td>
					<td><input id="endTime" name="endTime" class="form-control required" type="text" style="width:150px;" /></td>
 					<td>
						<button id="btn-query-info" type="button" class="btn btn-default btnicons" style="margin-left: 3rem;">
						<p class="btniconimg"><span>查询</span></p>
               	    </button>				
                    </td> 
					<td>
						<button id="fill_in_data" type="button" class="btn btn-default btnicons" style="margin-left: 3rem;color: #00BFA5; border: 1px solid #00BFA5; background-color: #fff;border-radius: 4px; width:60px; height: 30px;">
						<p class="btniconimgedit"><span>抄表</span></p>
            	 </button>				
                 </td> 
				</tr>
			</table>
		</form>
	</div>

	<table id="tb-extend-data" style="border: 1px solid; height:99%; width:99%; margin:0 auto; min-width: 750px;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>

	<div id="pg" style="text-align: right;"></div>
	<div id="fillIn-data-img"></div>
	<div id="error-div" ></div>
	<div id="datetimepicker-div"></div>

 	<script type="text/javascript"> 
      var operatorId = <shiro:principal property="id"/>;
      var operatorName = "<shiro:principal property="name"/>";
      var orgId = $("#login-org").data("orgId");
      var allMeterNames;
      var meterNameItems = new Array();
      var operatorList;
      var operatorItems = new Array();
      var tbMeterData;
 	  $(document).ready(function(){
 			var today = "${today}";
 			$('#startTime').val(today + " 00:00:00");
 			$('#endTime').val(today + " 23:59:59");
 			// 设置电表名下拉列表组件 
			$.ajax({
					type : "post",
					url : "${ctx}/power-supply/pdsElectricityMeterRecord/allMeterNames?projectCode="+ projectCode+"&type=1",
					async : false,
					dataType : "json",
					contentType : "application/json;charset=utf-8",
					success : function(data) {
						if (data != null && data.length > 0) {
							$(eval(data)).each(function() {
								meterNameItems[meterNameItems.length] = {itemText : this.itemText,itemData : this.itemData};
							});
							// 设置电表名下拉列表
						allMeterNames = $("#meterName-dropdownlist").dropDownList({
								inputName : 'deviceName',
								inputValName : 'deviceNo',
								buttonText : "",
								width : "116px",
								readOnly : false,
								required : true,
								maxHeight : 200,
								onSelect: function(i, data, icon) {
								},
								items : meterNameItems
							});
						allMeterNames.setData("全部","-1", "");
						
					}
					},
					error : function(req, error, errObj) {
					}
			});
			$.ajax({
				type : "post",
				url : "${ctx}/system/secStaff/getAllStaff",
				async : false,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data != null && data.length > 0) {
						$(eval(data)).each(function() {
							operatorItems[operatorItems.length] = {itemText : this.itemText,itemData : this.itemData};
						});
						// 设置操作员下拉列表
					operatorList = $("#operator-dropdownlist").dropDownList({
							inputName : 'operatorName',
							inputValName : 'operatorId',
							buttonText : "",
							width : "116px",
							readOnly : false,
							required : true,
							maxHeight : 200,
							onSelect: function(i, data, icon) {
							},
							items : operatorItems
						});
					operatorList.setData(operatorName,operatorId, "");
					
				}
				},
				error : function(req, error, errObj) {
				}
		});
 			//开始时间
  			$("#startTime").datetimepicker({
  				id: 'datetimepicker-startTime',
  				containerId: 'datetimepicker-div',
  				lang: 'ch',
  				timepicker: true,
  				hours12:false,
  				allowBlank:true,
  				format: 'Y-m-d H:i:s',
  			    formatDate: 'YYYY-mm-dd HH:mm:ss'
  			});
 			//结束时间
  			$("#endTime").datetimepicker({
  				id: 'datetimepicker-endTime',
  				containerId: 'datetimepicker-div',
  				lang: 'ch',
  				timepicker: true,
  				hours12:false,
  				allowBlank:true,
  				format: 'Y-m-d H:i:s',
  			    formatDate: 'YYYY-mm-dd HH:mm:ss'
  			});

 		  	var infoCols = [
                 {title : '流水号',name : 'id',width : 150,sortable : false,align : 'left',hidden:true},
                 {title : '电表编号',name : 'deviceNo',width : 150,sortable : false,align : 'left',hidden:true},
                 {title : '电表名称',name : 'deviceName',width : 150,sortable : false,align : 'left'},
                 {title : '电表级别',name : 'level',width : 150,sortable : false,align : 'left',renderer:function  (val, item , rowIndex){
	 		  		return "一级电表";
             	  }},
                 {title : '抄表读数',name : 'activeElectricity',width : 200,sortable : false,align : 'left'},
                 {title : '抄表时间',name : 'timestamp',width : 200,sortable : false,align : 'left'},
                 {title : '操作时间',name : 'createTime',width : 200,sortable : false,align : 'left'},
                 {title : '操作人',name : 'operatorName',width : 200,sortable : false,align : 'left'}
             ]; 

 		tbMeterData = $('#tb-extend-data').mmGrid({
     			width:'99%',
                height:776,
                cols:infoCols,
                url:'${ctx}/power-supply/pdsElectricityMeterRecord/extendDeviceRecords',
                method:'post',
                params:function(){
                	var data = {"": ""};
                	var startTime = $("#startTime").val().trim();
    				if (startTime != "" && startTime != null){
						$(data).attr({"startTime": startTime});
					}
                	var endTime = $("#endTime").val().trim();
    				if (endTime != "" && endTime != null){
						$(data).attr({"endTime": endTime});
					}
    				$(data).attr({"projectCode" : projectCode});
    				var deviceNo = $("#deviceNo").val();
    				$(data).attr({"deviceNo" : deviceNo});
    				var operId = $("#operatorId").val();
    				$(data).attr({"operatorId" : operId});
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
 		$('#btn-query-info').on('click', function(){ 
 			tbMeterData.load(); 
		});
 		$('#fill_in_data').on('click', function(){ 
			createModalWithLoad("fillIn-data-img", 450, 250, "抄表",
					"psdMain/writeMeterData", "save()", "confirm-close", "");
			openModal("#fillIn-data-img-modal", true, false);
		});
 		
			
 		tbMeterData.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
			}).on('loadSuccess',function(e,data) {
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "查询总表抄表记录失败：" + errObj);
			}).load();
            
 		});

 	
 	</script> 
</body>
</html>