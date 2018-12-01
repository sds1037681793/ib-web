<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet"
	type="text/css" />
<title>数据检测类型</title>
</head>
<body>
	<div>
		<ul id="myTab" class="nav nav-tabs" style="padding-left: 0px">
			<li class="active"><a href="#baseInfo" onclick=""
				data-toggle="tab">类型基本信息</a></li>
			<li><a href="#attributes" onclick="" data-toggle="tab">属性</a></li>
			<li><a href="#dataItems" onclick="" data-toggle="tab">检测项</a></li>
		</ul>
	</div>
	<div id="myTabContent" class="tab-content" style="">
		<!-- 基本信息 -->
		<div class="tab-pane fade in active" id="baseInfo">
			<form id="data-type-base-forms">
				<input id="id" name="id" style="display: none;" />
				<table>
					<tr>
						<td align="right" style="width: 100px;">名称：</td>
						<td style="width: 150px;"><input id="typeName" name="typeName"
							placeholder="名称" class="form-control" type="text"
							style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">编码：</td>
						<td style="width: 150px;"><input id="typeCode" name="typeCode"
							placeholder="编码" class="form-control" type="text"
							style="width: 150px;" /></td>
					</tr>
					<tr>
						<td align="right" style="width: 100px;">描述信息：</td>
						<td colspan="3"><input id="typeDescription" name="typeDescription"
							placeholder="描述信息" class="form-control" type="text"
							style="width: 421px;" /></td>
					</tr>
				</table>
				<table id="queryButtons" style="width: 1370px;">
					<tr style="" id="operation-cust">

					</tr>
				</table>
			</form>
			<button id="btn-type" type="button" class="btn btn-default btn-common btn-common-green" style="position: absolute;left: 55rem;top: 60rem;">保存</button>
		</div>
		<!-- end -->

		<!-- start 属性开始 -->
		<div class="tab-pane fade2" id="attributes">
			<div id="pgAttributes" style="text-align: right;">
				<table id="att-tb-attributes" class="tb-pay" style="">
					<tr id="att-tr-1">
					    <td style="width:20px;display:none"><input id="attId1" type="text" style="width:20px;"/></td>
						<td align="right" style="width: 60px;">名称：</td>
						<td style="width: 150px;"><input id="attName1" name="attName"
							placeholder="名称" class="form-control" type="text"
							style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">编码：</td>
						<td style="width: 150px;"><input id="attCode1" name="attCode"
							placeholder="编码" class="form-control" type="text"
							style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">排序：</td>
						<td style="width: 150px;"><input id="attOrderNo1" name="attOrderNo"
							placeholder="排序" class="form-control" type="text"
							style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">默认值：</td>
						<td style="width: 150px;"><input id="attDefaultValue1"
							name="attDefaultValue" placeholder="默认值" class="form-control"
							type="text" style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">是否必写：</td>
						<td align="right" style=""><input id="attNullAble1"
							type="checkbox"></td>
						<td id="delete1"><span class="glyphicon glyphicon-minus" aria-hidden="true" onclick="deleteAttribute(1)" style="left: 30px; cursor: pointer;"></span></td>
	                    <td id="add"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addAttribute()" style="left: 60px; cursor: pointer;"></span></td>
					</tr>
				</table>
			</div>
			<button id="btn-attribute" type="button" class="btn btn-default btn-common btn-common-green" style="position: absolute;left: 55rem;top: 60rem;">保存</button>
		</div>
		<!-- end -->

		<!-- start 检测项开始 -->
		<div class="tab-pane fade3" id="dataItems">
			<div id="pgDataItems" style="text-align: right;">
				<table id="item-tb-dataItems" class="tb-vistor" style="">
					<tr id="item-tr-1">
					    <td style="width:20px;display:none"><input id="dataitemId1" type="text" style="width:20px;"/></td>
						<td align="right" style="width: 60px;">名称：</td>
						<td style="width: 150px;"><input id="dataitemName1" name="dataitemName"
							placeholder="名称" class="form-control" type="text"
							style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">编码：</td>
						<td style="width: 150px;"><input id="dataitemCode1" name="dataitemCode"
							placeholder="编码" class="form-control" type="text"
							style="width: 150px;" /></td>
						<td align="right" style="width: 100px;">排序：</td>
						<td style="width: 150px;"><input id="dataitemOrderNo1" name="dataitemOrderNo"
							class="form-control" type="text" placeholder="排序"
							style="width: 150px;" /></td>	
						<td align="right" style="width: 130px;">格式化类型：</td>
						<td style="width: 150px;"><div id="store-type-dropdownlist1"></div></td>
						<td id="delete-dataitem1"><span class="glyphicon glyphicon-minus" aria-hidden="true"
							onclick="deleteDataitem(1)" style="margin-left: 70px; cursor: pointer;"></span></td>
						<td id="add-dataitem"><span class="glyphicon glyphicon-plus" aria-hidden="true"
							onclick="addDataitem()" style="margin-left: 47px; cursor: pointer;"></span></td>
					</tr>
				</table>
			</div>
			<button id="btn-dataitem" type="button" class="btn btn-default btn-common btn-common-green" style="position: absolute;left: 55rem;top: 60rem;">保存</button>
		</div>
		<!-- end -->
	</div>
</body>
<script type="text/javascript">
    var num = 1;
    var idNum = 1;
    var dataitemNum = 1;
    var dataitemIdNum = 1;
	var storeTypeList = new Array({
		itemText : "请选择格式化类型",
		itemData : ""
	}, {
		itemText : "文本",
		itemData : "0"
	}, {
		itemText : "浮点值",
		itemData : "1"
	}, {
		itemText : "时间",
		itemData : "2"
	}, {
		itemText : "整数值",
		itemData : "3"
	});

	$(document).ready(function() {
		storeTypeObj = $("#store-type-dropdownlist1").dropDownList({
			inputName : "storeTypeName1",
			inputValName : "storeTypeValue1",
			buttonText : "",
			width : "122px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
				if (data != "" && data != undefined) {

				}
			},
			items : storeTypeList
		});
		storeTypeObj.setData("请选择格式化类型", "", "");
		if(type==2){
			updateTypeData();
		}
	});
	
	//点击新增事件
	function addAttribute() {
		if (num > 17) {
			/* showDialogModal("error-div", "提示", "折算调休规则最多5行!",3); */
			/* showAlert('warning', '折算调休规则最多5行!', "add", 'bottum'); */
			$("#add").hide();
			return;
		}
		$("#add").remove();
		num += 1;
		idNum += 1;
		html = '<tr id="tr-'+idNum+'"><td style="width:20px;display:none"><input id="attId'+idNum+'" type="text" style="width:20px;"/></td>'
		 + '<td style="width:20px;display:none"><input id="isExtend'+idNum+'" type="text" style="width:20px;"/></td>'
	     + '<td align="right" style="width: 60px;">名称：</td>'
	     + '<td style="width: 150px;"><input id="attName'+idNum+'" name="attName" placeholder="名称" class="form-control" type="text" style="width: 150px;" /></td>'
	     + '<td align="right" style="width: 100px;">编码：</td>'
	     + '<td style="width: 150px;"><input id="attCode'+idNum+'" name="attCode" placeholder="编码" class="form-control" type="text" style="width: 150px;" /></td>'
	     + '<td align="right" style="width: 100px;">排序：</td>'
	     + '<td style="width: 150px;"><input id="attOrderNo'+idNum+'" name="attOrderNo" placeholder="排序" class="form-control" type="text" style="width: 150px;" /></td>'
	     + '<td align="right" style="width: 100px;">默认值：</td>'
	     + '<td style="width: 150px;"><input id="attDefaultValue'+idNum+'" name="attDefaultValue" placeholder="默认值" class="form-control" type="text" style="width: 150px;" /></td>'
	     + '<td align="right" style="width: 100px;">是否必写：</td>'
	     + '<td align="right" style=""><input id="attNullAble'+idNum+'" type="checkbox"></td>'
	     + '<td id="delete'+idNum+'"><span class="glyphicon glyphicon-minus" aria-hidden="true" onclick="deleteAttribute('+idNum+')" style="left: 30px; cursor: pointer;"></span></td>'
	     + '<td id="add"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addAttribute()" style="left: 60px; cursor: pointer;"></span></td>'
	     + '</tr>'
		$("#att-tb-attributes").append(html);
		if (num > 17) {
			$("#add").hide();
		}
	}
	
	//点击新增事件
	function addDataitem() {
		if (dataitemNum > 17) {
			$("#add-dataitem").hide();
			return;
		}
		$("#add-dataitem").remove();
		dataitemNum += 1;
		dataitemIdNum += 1;
		html = '<tr id="item-tr-'+dataitemIdNum+'"><td style="width:20px;display:none"><input id="dataitemId'+dataitemIdNum+'" type="text" style="width:20px;"/></td>'
		 + '<td style="width:20px;display:none"><input id="isExtendItem'+dataitemIdNum+'" type="text" style="width:20px;"/></td>'
	     + '<td align="right" style="width: 60px;">名称：</td>'
	     + '<td style="width: 150px;"><input id="dataitemName'+dataitemIdNum+'" name="dataitemName" placeholder="名称" class="form-control" type="text" style="width: 150px;" /></td>'
	     + '<td align="right" style="width: 100px;">编码：</td>'
	     + '<td style="width: 150px;"><input id="dataitemCode'+dataitemIdNum+'" name="dataitemCode" placeholder="编码" class="form-control" type="text" style="width: 150px;" /></td>'
	     + '<td align="right" style="width: 100px;">排序：</td>'
	     + '<td style="width: 150px;"><input id="dataitemOrderNo'+dataitemIdNum+'" name="dataitemOrderNo" class="form-control" type="text" placeholder="排序" style="width: 150px;" /></td>'
	     + '<td align="right" style="width: 130px;">格式化类型：</td>'
	     + '<td style="width: 150px;"><div id="store-type-dropdownlist'+dataitemIdNum+'"></div></td>'
	     + '<td id="delete-dataitem'+dataitemIdNum+'"><span class="glyphicon glyphicon-minus" aria-hidden="true" onclick="deleteDataitem('+dataitemIdNum+')" style="margin-left: 70px; cursor: pointer;"></span></td>'
	     + '<td id="add-dataitem"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addDataitem()" style="margin-left: 47px; cursor: pointer;"></span></td> </tr>'
		$("#item-tb-dataItems").append(html);
		if (dataitemNum > 17) {
			$("#add-dataitem").hide();
		}
		var storeTypeDropdownlist = "#store-type-dropdownlist" + dataitemIdNum;
		var storeTypeName = "storeTypeName"+dataitemIdNum;
		var storeTypeValue = "storeTypeValue"+dataitemIdNum;
		detDataTypeDataitem = $(storeTypeDropdownlist).dropDownList({
			inputName : storeTypeName,
			inputValName : storeTypeValue,
			buttonText : "",
			width : "122px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
				if (data != "" && data != undefined) {
					
				}
			},
			items : storeTypeList
		});
		detDataTypeDataitem.setData("请选择格式化类型", "", "");
	}
	
	//点击删除事件
	function deleteDataitem(number) {
		if (dataitemNum == 1) {
			return;
		}
		var butTd = "#delete-dataitem"+number;
		if (number == dataitemIdNum) {
			html = '<td id="add-dataitem"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addDataitem()" style="margin-left: 47px; cursor: pointer;"></span></td>'
			$(butTd).parent().prev().append(html);
			dataitemIdNum -= 1;
		}
		var cancel = "#item-tr-" + number;
		$(cancel).remove();
		dataitemNum -= 1;
	}
	
	//点击删除事件
	function deleteAttribute(number) {
		if (num == 1) {
			return;
		}
		var butTd = "#delete"+number;
		if (number == idNum) {
			html = '<td id="add"><span  class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addAttribute()" style="left: 60px; cursor: pointer;"></span></td>'
			$(butTd).parent().prev().append(html);
			idNum -= 1;
		}
		var cancel = "#tr-" + number;
		$(cancel).remove();
		num -= 1;
	}
	
	function updateTypeData(){
		if(returnData.name){
			$("#typeName").val(returnData.name);
			}
			if(returnData.code){
		    $("#typeCode").val(returnData.code);
			}
			if(returnData.description){
			$("#typeDescription").val(returnData.description);		
			}
			var detDataTypeAttribute = returnData.DetDataTypeAttributes;
			var detDataTypeDataitem = returnData.DetDataTypeDataitems;
			 if(detDataTypeDataitem != null && detDataTypeDataitem != undefined && detDataTypeDataitem.length != 0){
				dataitemNum = detDataTypeDataitem.length;
				dataitemIdNum = detDataTypeDataitem.length;
			$("#item-tr-1").remove();
				for (var j = 1; j < detDataTypeDataitem.length+1; j++) {
			if (j > 1) {
					$("#add-dataitem").remove();
					}
			html = '<tr id="item-tr-'+j+'"><td style="width:20px;display:none"><input id="dataitemId'+j+'" type="text" style="width:20px;"/></td>'
			     + '<td style="width:20px;display:none"><input id="isExtendItem'+j+'" type="text" style="width:20px;"/></td>'
			     + '<td align="right" style="width: 60px;">名称：</td>'
			     + '<td style="width: 150px;"><input id="dataitemName'+j+'" name="dataitemName" placeholder="名称" class="form-control" type="text" style="width: 150px;" /></td>'
			     + '<td align="right" style="width: 100px;">编码：</td>'
			     + '<td style="width: 150px;"><input id="dataitemCode'+j+'" name="dataitemCode" placeholder="编码" class="form-control" type="text" style="width: 150px;" /></td>'
			     + '<td align="right" style="width: 100px;">排序：</td>'
			     + '<td style="width: 150px;"><input id="dataitemOrderNo'+j+'" name="dataitemOrderNo" class="form-control" type="text" placeholder="排序" style="width: 150px;" /></td>'
			     + '<td align="right" style="width: 130px;">格式化类型：</td>'
			     + '<td style="width: 150px;"><div id="store-type-dropdownlist'+j+'"></div></td>'
			     + '<td id="delete-dataitem'+j+'"><span class="glyphicon glyphicon-minus" aria-hidden="true" onclick="deleteDataitem('+i+')" style="margin-left: 70px; cursor: pointer;"></span></td>'
			     + '<td id="add-dataitem"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addDataitem()" style="margin-left: 47px; cursor: pointer;"></span></td> </tr>'
			$("#item-tb-dataItems").append(html);
			var dataitemId = "#dataitemId" + j;
			var dataitemName = "#dataitemName" + j;
		    var dataitemCode = "#dataitemCode" + j;
		    var dataitemOrderNo = "#dataitemOrderNo" + j;
		    var isExtend = "#isExtendItem" +j
		    var storeType = detDataTypeDataitem[j-1].storeType;
		    if(detDataTypeDataitem[j-1].isExtend != undefined){
				$(isExtend).val(detDataTypeDataitem[j-1].isExtend);
			}
		    
			if(detDataTypeDataitem[j-1].id != undefined){
				$(dataitemId).val(detDataTypeDataitem[j-1].id);
			}
			
			if(detDataTypeDataitem[j-1].name != undefined){
				$(dataitemName).val(detDataTypeDataitem[j-1].name);
			}
			
			if(detDataTypeDataitem[j-1].code != undefined){
				$(dataitemCode).val(detDataTypeDataitem[j-1].code);
			}
			
			if(detDataTypeDataitem[j-1].orderNo != undefined){
				$(dataitemOrderNo).val(detDataTypeDataitem[j-1].orderNo);
			}
			if(detDataTypeDataitem[j-1].isExtend == true){
				$(dataitemName).attr("disabled",true);
				$(dataitemCode).attr("disabled",true);
				$(dataitemOrderNo).attr("disabled",true);
				/* $(storeTypeDropdownlist).attr("disabled",true); */
			}
			var storeTypeDropdownlist = "#store-type-dropdownlist" + j;
			var storeTypeName = "storeTypeName"+j;
			var storeTypeValue = "storeTypeValue"+j;
			storeTypeObj = $(storeTypeDropdownlist).dropDownList({
				inputName : storeTypeName,
				inputValName : storeTypeValue,
				buttonText : "",
				width : "122px",
				readOnly : false,
				required : true,
				maxHeight : 200,
				onSelect : function(i, data, icon) {
					if (data != "" && data != undefined) {
						
					}
				},
				items : storeTypeList
			});
			if(storeType!=undefined){
			storeTypeObj.setData(storeTypeList[storeType+1].itemText,storeTypeList[storeType+1].itemData, "");
			}else{
				storeTypeObj.setData("请选择格式化类型", "", "");	
			}
			
				}
				
				} 
			
			if(detDataTypeAttribute != null && detDataTypeAttribute != undefined && detDataTypeAttribute.length != 0){
				num = detDataTypeAttribute.length;
				idNum = detDataTypeAttribute.length;
			$("#att-tr-1").remove();
				for (var i = 1; i < detDataTypeAttribute.length+1; i++) {
			if (i > 1) {
					$("#add").remove();
					}	
			html = '<tr id="tr-'+i+'"><td style="width:20px;display:none"><input id="attId'+i+'" type="text" style="width:20px;"/></td>'
			     + '<td style="width:20px;display:none"><input id="isExtend'+i+'" type="text" style="width:20px;"/></td>'
			     + '<td align="right" style="width: 60px;">名称：</td>'
			     + '<td style="width: 150px;"><input id="attName'+i+'" name="attName" placeholder="名称" class="form-control" type="text" style="width: 150px;" /></td>'
			     + '<td align="right" style="width: 100px;">编码：</td>'
			     + '<td style="width: 150px;"><input id="attCode'+i+'" name="attCode" placeholder="编码" class="form-control" type="text" style="width: 150px;" /></td>'
			     + '<td align="right" style="width: 100px;">排序：</td>'
			     + '<td style="width: 150px;"><input id="attOrderNo'+i+'" name="attOrderNo" placeholder="排序" class="form-control" type="text" style="width: 150px;" /></td>'
			     + '<td align="right" style="width: 100px;">默认值：</td>'
			     + '<td style="width: 150px;"><input id="attDefaultValue'+i+'" name="attDefaultValue" placeholder="默认值" class="form-control" type="text" style="width: 150px;" /></td>'
			     + '<td align="right" style="width: 100px;">是否必写：</td>'
			     + '<td align="right" style=""><input id="attNullAble'+i+'" type="checkbox"></td>'
			     + '<td id="delete'+i+'"><span class="glyphicon glyphicon-minus" aria-hidden="true" onclick="deleteAttribute('+i+')" style="left: 30px; cursor: pointer;"></span></td>'
			     + '<td id="add"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addAttribute()" style="left: 60px; cursor: pointer;"></span></td>'
			     + '</tr>'
			$("#att-tb-attributes").append(html);
			var attId = "#attId" + i;
			var attName = "#attName" + i;
		    var attCode = "#attCode" + i;
		    var attOrderNo = "#attOrderNo" + i;
			var attDefaultValue = "#attDefaultValue" + i;
			var attNullAble = "#attNullAble" + i;
			var isExtend = "#isExtend" +i;
			if(detDataTypeAttribute[i-1].isExtend == true){
				$(attName).attr("disabled",true);
				$(attCode).attr("disabled",true);
				$(attOrderNo).attr("disabled",true);
				$(attDefaultValue).attr("disabled",true);
				$(attNullAble).attr("disabled",true);
			}
			if(detDataTypeAttribute[i-1].nullable != undefined){
				if(detDataTypeAttribute[i-1].nullable == 0){
					$(attNullAble).prop("checked",false); 
				}else{
					$(attNullAble).prop("checked",true);
				}
				
			}
			if(detDataTypeAttribute[i-1].isExtend != undefined){
				$(isExtend).val(detDataTypeAttribute[i-1].isExtend);
			}
			
			if(detDataTypeAttribute[i-1].id != undefined){
				$(attId).val(detDataTypeAttribute[i-1].id);
			}
			
			if(detDataTypeAttribute[i-1].name != undefined){
				$(attName).val(detDataTypeAttribute[i-1].name);
			}
			
			if(detDataTypeAttribute[i-1].code != undefined){
				$(attCode).val(detDataTypeAttribute[i-1].code);
			}
			
			if(detDataTypeAttribute[i-1].orderNo != undefined){
				$(attOrderNo).val(detDataTypeAttribute[i-1].orderNo);
			}
			
			if(detDataTypeAttribute[i-1].defaultValue != undefined){
				$(attDefaultValue).val(detDataTypeAttribute[i-1].defaultValue);
			} 
			
				}
			}
			
	}
	
	function queryId(code){
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/detDataTypeManage/queryDetDataType?code="+code,
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if(data!=null){
				id = data.id;
				}
			},
			error: function(req,error,errObj) {
				showDialogModal("error-div","操作错误",errObj);
				return;
			}
		});
	}
	
	$("#btn-type").click(function(){
		var detDataTypeVO = {};
		var code = $("#typeCode").val().trim();
		var name = $("#typeName").val().trim();
		if(code == "" || name == ""){
			showDialogModal("error-div", "提示", "数据类型名称或编码不能为空！",3);
		      return;
		}
		if(type == 2){
		$(detDataTypeVO).attr({
			"parentId" : returnData.parentId
		});
		}
		$(detDataTypeVO).attr({
			"id" : id
		});
		$(detDataTypeVO).attr({
			"name" : $("#typeName").val().trim()
		});
		$(detDataTypeVO).attr({
			"code" : $("#typeCode").val().trim()
		});
		$(detDataTypeVO).attr({
			"description" : $("#typeDescription").val().trim()
		});
		$(detDataTypeVO).attr({
			"type" : type
		});
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/detDataTypeManage/create",
			data: JSON.stringify(detDataTypeVO),
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					showDialogModal("error-div","操作成功", "操作成功");
					queryId(code);
					initializeTree();
					dataTypeInit();
					return true;
				}else {
					showDialogModal("error-div", "操作错误", data.RETURN_PARAM);
					return false;
				}
			},
			error: function(req,error,errObj) {
				showDialogModal("error-div","操作错误",errObj);
				return;
			}
		});
	});
	
	$("#btn-attribute").click(function(){
		if(id==null){
			showDialogModal("error-div", "提示", "该数据监测类型为空，请先新增数据类型！",3);
		      return;
		}
		var ary = new Array();
		var detDataTypeAttributeVO={};
		var detDataTypeAttributesList = new Array();
		for (var i = 1; i < idNum + 1; i++) {
			var isExtend = "#isExtend" +i; 
			var isex = $(isExtend).val();
			if(isex == "true"){
				continue;
			}
			var detDataTypeAttributeDatas = {};
			var attId = "#attId" + i;
			var attName = "#attName" + i;
		    var attCode = "#attCode" + i;
		    var attOrderNo = "#attOrderNo" + i;
			var attDefaultValue = "#attDefaultValue" + i;
			var attNullAble = "#attNullAble" + i;
			var code = $(attCode).val();
			var nullable;
			var name = $(attName).val().trim();
			var code = $(attCode).val().trim();
			if(name == "" || code == ""){
				showDialogModal("error-div", "提示", "数据类型属性名称或编码不能为空！",3);
			      return;
			}
			ary.push(code);
			
			if($(attNullAble).is(":checked")){
				nullable = 1;
			}else{
				nullable = 0
			}
			
			$(detDataTypeAttributeDatas).attr({
				"nullable" : nullable
			});
			
			$(detDataTypeAttributeDatas).attr({
				"id" : $(attId).val()
			});
			$(detDataTypeAttributeDatas).attr({
				"name" : $(attName).val().trim()
			});
			$(detDataTypeAttributeDatas).attr({
				"code" : $(attCode).val().trim()
			});
			$(detDataTypeAttributeDatas).attr({
				"orderNo" : $(attOrderNo).val().trim()
			});
			$(detDataTypeAttributeDatas).attr({
				"defaultValue" : $(attDefaultValue).val().trim()
			});
			$(detDataTypeAttributeDatas).attr({
				"typeId" : id
			});
			
			detDataTypeAttributesList.push(detDataTypeAttributeDatas);
		
		}
		var nary=ary.sort();
		for(var i=0;i<ary.length;i++){  
			 if (nary[i]==nary[i+1]){  
			  showDialogModal("error-div", "提示", "类型编码同一类型下唯一，请修改！",3);
		      return; 
			 }  
			}  
		$(detDataTypeAttributeVO).attr({
			"id" : id
		});
		$(detDataTypeAttributeVO).attr({
			"code" : $("#typeCode").val()
		});
		$(detDataTypeAttributeVO).attr({
			"detDataTypeAttributeDatas" : detDataTypeAttributesList
		});
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/detDataTypeManage/createAttribute",
			data: JSON.stringify(detDataTypeAttributeVO),
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					showDialogModal("error-div","操作成功", "操作成功");
					initializeTree();
					dataTypeInit();
					return true;
				}else {
					showDialogModal("error-div", "操作错误", data.RETURN_PARAM);
					return false;
				}
			},
			error: function(req,error,errObj) {
				showDialogModal("error-div","操作错误",errObj);
				return;
			}
		});
		
	});
	$("#btn-dataitem").click(function(){
		if(id==null){
			showDialogModal("error-div", "提示", "该数据监测类型为空，请先新增数据类型！",3);
		      return;
		}
		var ary = new Array();
		var detDataTypeDataitemVO={};
		var detDataTypeDataitemList = new Array();
		for (var i = 1; i < dataitemIdNum + 1; i++) {
			var isExtend = "#isExtendItem" +i; 
			var isex = $(isExtend).val();
			if(isex == "true"){
				continue;
			}
			var detDataTypeDataitemDatas = {};
			
			var dataitemId = "#dataitemId" + i;
			var dataitemName = "#dataitemName" + i;
		    var dataitemCode = "#dataitemCode" + i;
		    var dataitemOrderNo = "#dataitemOrderNo" + i;
		    var storeTypeValue = "#storeTypeValue"+i;
		    var code = $(dataitemCode).val().trim();
		    var name = $($(dataitemName)).val().trim();
		    var type = $(storeTypeValue).val();
		    if(name == "" || code == "" || type == ""){
				showDialogModal("error-div", "提示", "数据类型检测项名称或编码或格式化类型不能为空！",3);
			      return;
			}
		    ary.push(code);
			$(detDataTypeDataitemDatas).attr({
				"id" : $(dataitemId).val()
			});
			$(detDataTypeDataitemDatas).attr({
				"name" : $(dataitemName).val().trim()
			});
			$(detDataTypeDataitemDatas).attr({
				"code" : $(dataitemCode).val().trim()
			});
			$(detDataTypeDataitemDatas).attr({
				"orderNo" : $(dataitemOrderNo).val().trim()
			});
			$(detDataTypeDataitemDatas).attr({
				"typeId" : id
			});
			
			$(detDataTypeDataitemDatas).attr({
				"storeType" : $(storeTypeValue).val()
			});
			
			detDataTypeDataitemList.push(detDataTypeDataitemDatas);
		
		}
		var nary=ary.sort();
		for(var i=0;i<ary.length;i++){  
			 if (nary[i]==nary[i+1]){  
			  showDialogModal("error-div", "提示", "类型编码同一类型下唯一，请修改！",3);
		      return; 
			 }  
			}  
		
		$(detDataTypeDataitemVO).attr({
			"id" : id
		});
		$(detDataTypeDataitemVO).attr({
			"code" : $("#typeCode").val()
		});
		$(detDataTypeDataitemVO).attr({
			"detDataTypeDataitemDatas" : detDataTypeDataitemList
		});
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/detDataTypeManage/createDataitem",
			data: JSON.stringify(detDataTypeDataitemVO),
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					showDialogModal("error-div","操作成功", "操作成功");
					initializeTree();
					dataTypeInit();
					return true;
				}else {
					showDialogModal("error-div", "操作错误", data.RETURN_PARAM);
					return false;
				}
			},
			error: function(req,error,errObj) {
				showDialogModal("error-div","操作错误",errObj);
				return;
			}
		});
		$("#show-addDetails-modal").modal("hide");
	});
</script>
</html>