<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<style type="text/css">
.dropdown-menu {
   width:274px;
}
</style>
<!DOCTYPE html>
<html>
<head>
    <link href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
	<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript" ></script>
	<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
</head>
<body>
	<div class="">
		<form>
			<table >
				<tr >
				<td align="right" style="width:8rem;height:30px;">电表名称：</td>
				<td><div id="addMeterName-dropdownlist"></div></td>
				</tr>
				<tr>
				<td align="right" style="width:8rem;height:30px;">电表读数：</td>
					<td><input id="meter_number" name="meter_number" placeholder="请输入总表读数" class="form-control" style="width:275px;"/></td>
				</tr>
				<tr>
					<td align="right" style="width:8rem;height:30px;">抄表时间：</td>
					<td><input id="timestamp" name="timestamp" class="form-control required" type="text" style="width:275px;" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="datetimepicker-fill"></div>
	<div id="errorTittle-div" ></div>
 	<script type="text/javascript"> 
      var allAddMeterNames;
      var totalMeterVO = {"":""};
      var addMeterNameItems = new Array();
 	  $(document).ready(function(){
 			// 设置电表名下拉列表组件 
			$.ajax({
					type : "post",
					url : "${ctx}/power-supply/pdsElectricityMeterRecord/allMeterNames?projectCode="+ projectCode+"&type=2",
					async : false,
					dataType : "json",
					contentType : "application/json;charset=utf-8",
					success : function(data) {
						if (data != null && data.length > 0) {
							$(eval(data)).each(function() {
								addMeterNameItems[addMeterNameItems.length] = {itemText : this.itemText,itemData : this.itemData};
							});
					}else{
						addMeterNameItems[0]={itemText :"请选择",itemData : ""};
					}
						// 电表名下拉列表
						allAddMeterNames = $("#addMeterName-dropdownlist").dropDownList({
								inputName : 'addDeviceName',
								inputValName : 'addDeviceNo',
								buttonText : "",
								width : "242px",
								readOnly : false,
								required : true,
								maxHeight : 200,
								onSelect: function(i, data, icon) {
								},
								items : addMeterNameItems
							});
						allAddMeterNames.setData(addMeterNameItems[0].itemText,addMeterNameItems[0].itemData,'');
					},
					error : function(req, error, errObj) {
					}
			});
 			//开始时间
  			$("#timestamp").datetimepicker({
  				id: 'datetimepicker-timestamp',
  				containerId: 'datetimepicker-fill',
  				lang: 'ch',
  				timepicker: true,
  				hours12:false,
  				allowBlank:true,
  				format: 'Y-m-d H:i:s',
  			    formatDate: 'YYYY-mm-dd HH:mm:ss'
  			});
 	 	});
 	  
 	  function save(){
 		//获取数据并校验
      	var timestamp = $("#timestamp").val().trim();
      	if( timestamp == null ||  timestamp == ""){
      		showAlert('warning', '抄表时间不能为空！', "timestamp", 'top');
      		return ;
      	}
    	var deviceName = $("#addDeviceName").val();
		if ( deviceName == null ||  deviceName == ""){
			showAlert('warning', '电表名称不能为空！', "addDeviceName", 'top');
			return ;
		}
    	var deviceNo = $("#addDeviceNo").val();
		if ( deviceNo == null ||  deviceNo == ""){
			showAlert('warning', '电表名称不能为空！', "addDeviceNo", 'top');
			return;
		}
		//校验电表读数是否是数字
		var meterNumber = $("#meter_number").val();
		if(meterNumber==null ||  meterNumber == ""){
			showAlert('warning', '电表读数一栏为空，请输入电表读数！', "meter_number", 'top');
			return;
		}
	    var patrn = /^[0-9]+\.?[0-9]*$/;
	    if (!patrn.test(meterNumber)) {
	    	showAlert('warning', '输入的不是数字，请重新输入！', "meter_number", 'top');
			return;
	    }
	    $(totalMeterVO).attr({"deviceName": deviceName});
	    $(totalMeterVO).attr({"timestamp": timestamp});
	    $(totalMeterVO).attr({"meterNumber": meterNumber});
	    $(totalMeterVO).attr({"deviceNo": deviceNo});
	    $(totalMeterVO).attr({"projectCode": projectCode});
	    $(totalMeterVO).attr({"operatorName": operatorName});
	    $(totalMeterVO).attr({"operatorId": operatorId});
	  	//校验电表读数是否重复
	  	if(checkMeterData(meterNumber)==2){
		    showDialogModal("error-div", "操作提示", "此次抄表读数和上一次抄表读数相同，请核对确认！", 2, "saveTotalMeterData();");
	  	}else{
	  		saveTotalMeterData(totalMeterVO)
	  	}
	  	
 	  }
 	  
 	  function checkMeterData(meterNumber){
 		  var result=1;
			$.ajax({
				type : "get",
				url : "${ctx}/power-supply/pdsElectricityMeterRecord/checkMeterData?meterNumber="+meterNumber,
				dataType : "json",
				async:false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data!=null && data.code==0 &&data.data==true) {
						result=2;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作提示", "新增的抄表数据失败"+errObj);
				}
			});
			return result;
 	  }
 	  
 	  
 	 function saveTotalMeterData(){
 			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/pdsElectricityMeterRecord/saveTotalMeterData",
				data : JSON.stringify(totalMeterVO),
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data!=null && data.code==0) {
						if(data.data==true){
							showDialogModal("error-div", "操作提示", "操作成功！");
							$("#fillIn-data-img-modal").modal('hide');
							tbMeterData.load();
						}else{
							showDialogModal("error-div","操作提示", "新增的抄表数据失败");
						}
					} else {
						showDialogModal("error-div","操作提示", "新增的抄表数据失败"+data.MESSAGE);
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作提示", "新增的抄表数据提交失败"+errObj);
				}
			});
 	  }
		
 	
 	</script> 
</body>
</html>