<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<style>
.col {
	padding:10px;
	z-index:10;
	top:30px;
    float: left;
    width:680px;
    /* height:348px; */
    /* position: absolute; */
    /* background-color: rgba(0, 0, 0, 0); */
    background-clip: padding-box;
    background-color: #FFFFFF;
    border: 1px  rgba(13, 13, 13, 0.15);
    border-radius: 6px;
    /* box-shadow: 0 6px 12px rgba(0, 0, 0, 0.176); */
}
.col ul li{
	border:1px solid rgba(0, 0, 0, 0.15);
	border-radius: 5px;
	margin:8px;
	font-size: 16px;
	text-align:center;
	vertical-align:center;
	float:left;
	width:100px;
	height:40px;
	line-height:36px;   
	overflow: hidden;
	cursor: pointer;
	color: #333333;
}
.col li:hover{
	background-color:#4FC2B9;
	color:#313131;
}
</style>
</head>
<body>
<div><span>当前选择</span><div id="selected" class="col"></div></div>
<div><span>可选择</span><div id="select" class="col"></div></div>
</body>
</html>
<script type="text/javascript">
var deviceArray = new Array();
var selectedArray = new Array();
$(document).ready(function() {
	$.ajax({
        type : "post",
        url : "${ctx}/operatorPassage/getOperatorPassage?operatorId="+ operatorId,
        dataType: "json",
        contentType : "application/json;charset=utf-8",
        success : function(data) {
        	//
        	deviceArray = $.map(data,function(val){
        		return val.deviceId;
        	});
        	var innerli = '<ul>';
        	var innerSelectli = '<ul>';
        	jQuery.each(allCameras, function(i,val) {
        		var index = $.inArray(val.deviceId, deviceArray);
        		if(index > -1){
        			selectedArray[index] = '<li id="sld_'+ val.deviceId +'" onclick="removeLi('+ val.deviceId +')">' +val.deviceName+'</li>';
        			//innerSelectli += '<li id="sld_'+ val.deviceId +'" onclick="removeLi('+ val.deviceId +')">' +val.deviceName+'</li>';
        		} else {
        			innerli += '<li id="sl_'+ val.deviceId +'" onclick="addLi('+ val.deviceId +')">'+ val.deviceName+'</li>';
        		}
        	});
        	innerli += '</ul>';
        	
        	jQuery.each(selectedArray, function(i,val) {
        		if(typeof(val) != 'undefined') {
        			innerSelectli += val;
        		}
        	});
        	innerSelectli += '</ul>';
        	
        	$("#select").append(innerli);
        	$("#selected").append(innerSelectli);
        	
        },
        error : function(req,error, errObj) {
            return;
        }
    });
});
function addLi(deviceId){
	if(deviceArray.length == 8){
		showDialogModal("error-div", "提示信息", "最多同时监控8个视频", 1, null, "");
		return;
	}
	if($.inArray(deviceId, deviceArray) == -1 && deviceArray.length < 8){
		$("#selected ul").append('<li id="sld_'+ deviceId +'" onclick="removeLi('+ deviceId +')">' +allPassageMap.get(deviceId)+'</li>');
		$("#sl_" + deviceId).remove();
		deviceArray = deviceArray.concat(deviceId);
		addOrDelete(deviceId,1);
	}
}
function removeLi(deviceId){
	$("#sld_" + deviceId).remove();
	$("#select ul").append('<li id="sl_'+ deviceId +'" onclick="addLi('+ deviceId +')">' +allPassageMap.get(deviceId)+'</li>');
	deviceArray.splice($.inArray(deviceId, deviceArray),1);
	addOrDelete(deviceId,2);
}
function addOrDelete(deviceId,type){
	if(type == 1){
		$.ajax({
	        type : "post",
	        url : "${ctx}/operatorPassage/addOperatorPassage?operatorId="+ operatorId + "&deviceId=" + deviceId,
	        dataType: "json",
	        contentType : "application/json;charset=utf-8",
	        success : function(data) {
	        	if (data && data.CODE && data.CODE == "SUCCESS") 
	            {
	        		
	            }
	        	return false;
			},
		    error : function(req,error, errObj) {
		        return;
		    }
		});
	}else{
		$.ajax({
	        type : "post",
	        url : "${ctx}/operatorPassage/deleteOperatorPassage?operatorId="+ operatorId + "&deviceId=" + deviceId,
	        dataType: "json",
	        contentType : "application/json;charset=utf-8",
	        success : function(data) {
	        	if (data && data.CODE && data.CODE == "SUCCESS") 
	            {
	        		
	            }
	        	return ;
			},
		    error : function(req,error, errObj) {
		        return;
		    }
		});
	}
}
</script>