<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>缓存管理</title>
</head>
<body>
<div>
<div>
<table>
<tr>
	<td align="right" width="150">缓存类型:</td>
	<td  align="right" width="150">
	<div id="cacheType-dropdownlist"></div>
		<!--<select id="cacheType">
		<option value="0">全部</option>
		<option value="1">黑名单</option>
		<option value="2">固定车辆</option>
		<option value="3">停车场出入记录</option>
		</select>-->
	</td>
	<td>
	<td align="right" width="150" style="display: none;">查询值:</td>
	</td>
	<td width="12"></td>
	<td><input id="value" type="text" style="width:150px;display: none;" class="form-control required" /></td>
	<td align="right" colspan = "2">
		<button id="query" type="button" class="btn btn-default btn-common btn-common-green" style="margin-left: 100px;">查询</button>
		<button id="reload" type="button" class="btn btn-default btn-common btn-common-green" style="margin-left: 20px;">重载</button>
	</td>
</tr>
</table>
<!-- <a id="query" href="#" class="btn btn-primary" style="float:right;">查询</a>
	<a id="reload" href="#" class="btn btn-primary" style="float:right;">重载</a> -->	
</div>
<div>
	<textarea id="result" rows="30" cols="240" style="margin-top: 20px;"></textarea>
</div>
<div id="error-div"></div>
</div>
<script type="text/javascript">
	var cacheTypeList = new Array();
	cacheTypeList[cacheTypeList.length] = {itemText: "全部", itemData: "0", Selected:true};
	cacheTypeList[cacheTypeList.length] = {itemText: "黑名单", itemData: "1"};
	cacheTypeList[cacheTypeList.length] = {itemText: "固定车辆", itemData: "2"};
	cacheTypeList[cacheTypeList.length] = {itemText: "停车场场内记录", itemData: "3"};
	cacheTypeList[cacheTypeList.length] = {itemText: "设备参数", itemData: "4"};
	cacheTypeList[cacheTypeList.length] = {itemText: "区域参数", itemData: "5"};
	cacheTypeList[cacheTypeList.length] = {itemText: "项目参数", itemData: "6"};
	cacheTypeList[cacheTypeList.length] = {itemText: "区域通道关联参数", itemData: "7"};
	cacheTypeList[cacheTypeList.length] = {itemText: "通道参数", itemData: "8"};
	cacheTypeList[cacheTypeList.length] = {itemText: "通道设备关联参数", itemData: "9"};
	cacheTypeList[cacheTypeList.length] = {itemText: "项目与区域关联参数", itemData: "10"};
	cacheTypeList[cacheTypeList.length] = {itemText: "子系统参数", itemData: "11"};
	cacheTypeList[cacheTypeList.length] = {itemText: "收费方案参数", itemData: "12"};
	cacheTypeList[cacheTypeList.length] = {itemText: "共享组车辆关联", itemData: "13"};
	cacheTypeList[cacheTypeList.length] = {itemText: "共享组剩余车辆", itemData: "14"};
	cacheTypeList[cacheTypeList.length] = {itemText: "白名单", itemData: "15"};
	cacheTypeList[cacheTypeList.length] = {itemText: "动态SQL", itemData: "16"};
	var ddlValueType;
	var valueTypeList = new Array();
	valueTypeList[valueTypeList.length] = {itemText: "卡号", itemData: "1", Selected:true};
	valueTypeList[valueTypeList.length] = {itemText: "车牌号", itemData: "2"};
	$(document).ready(function() {
		ddlCacheType = $("#cacheType-dropdownlist").dropDownList({
	        inputName: "cacheTypeName",
	        inputValName: "cacheType",
	        buttonText: "",
	        width: "117px",
	        readOnly: false,
	        required: true,
	        maxHeight: 200,
	        onSelect: function(i, data, icon) {},
	        items: cacheTypeList
	    });
	    ddlValueType = $("#valueType-dropdownlist").dropDownList({
	        inputName: "valueTypeName",
	        inputValName: "valueType",
	        buttonText: "",
	        width: "87px",
	        readOnly: false,
	        required: true,
	        maxHeight: 200,
	        onSelect: function(i, data, icon) {},
	        items: valueTypeList
	    });
		
		$('#query').on('click',function(){
			$('#result').val('');
			var cacheType = $('#cacheType').val();
			if(cacheType == 0){
				showDialogModal("error-div", "操作错误", "请先选择缓存类型", 1, null, true);
				return;
			}
			var valueType = $('#valueType').val();
			var value = $('#value').val();
			$.ajax({
				type:"get",
		         url:"${ctx}/cacheManage/query?busiType="+cacheType+"&queryMethod="+valueType+"&value="+value,
		         dataType:"json",
		         success: function(data){
		             if (data && data.CODE && data.CODE == "FAILED"){
		            	 showDialogModal("error-div", "操作失败", data.MESSAGE, 1, null, true);
		             }else{
		            	 $('#result').val(data);
		             }
		         },
		         error: function(req,error,errorObj){
		             showDialogModal("error-div", "操作错误", errorObj, 1, null, true);
		             return;
		         }
			});
		});
		$('#reload').on('click',function(){
			var cacheType = $('#cacheType').val();
// 			if(cacheType == 0){
// 				showDialogModal("error-div", "操作错误", "请先选择缓存类型", 1, null, true);
// 				return;
// 			}
			$.ajax({
				type:"get",
		         url:"${ctx}/cacheManage/reload?busiType="+cacheType,
		         dataType:"json",
		         success: function(data){
		             if (data && data.CODE && data.CODE == "SUCCESS") 
		             {
		            	 showDialogModal("error-div", "操作成功", "缓存已重载", 1, null, true);
		             }
		             else
		             {
		                 showDialogModal("error-div", "操作失败", data.MESSAGE, 1, null, true);
		             }
		             return;
		         },
		         error: function(req,error,errorObj){
		             showDialogModal("error-div", "操作错误", errorObj, 1, null, true);
		             return;
		         }
			});
		});
	});
</script>
</body>
</html>