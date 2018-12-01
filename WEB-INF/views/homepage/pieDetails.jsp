<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style type="text/css">
#custName{
border: 1px solid #3BBCE6;
border-radius: 2px;
 background: rgba(20,91,146,0.90);
}
#visitorName{
border: 1px solid #3BBCE6;
border-radius: 2px;
 background: rgba(20,91,146,0.90);
}
.form-control {
    background: rgba(20, 91, 146, 0.9) none repeat scroll 0 0;
    border: 1px solid #7bd2f0;
    border-radius: 2px;
    color: #fff;
    padding:6px 12px;
}
#btn-query{
background-color: #3BBCE6;
border: 2px solid #3BBCE6;
font-family: PingFangSC-Regular;
font-size: 12px;
color: #FFFFFF;
margin-left: 150px;
}
#queryButton{
background-color: #3BBCE6;
border: 2px solid #3BBCE6;
font-family: PingFangSC-Regular;
font-size: 12px;
color: #FFFFFF;
margin-left: 150px;
}
#btnQuery{
background-color: #3BBCE6;
border: 2px solid #3BBCE6;
font-family: PingFangSC-Regular;
font-size: 12px;
color: #FFFFFF;
margin-left: 125px;
}
#personAllwayCondition-div23 .mmg-head{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
#vehicleAllwayCondition-div22 .mmg-head{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
.btn-common {
    background-color: rgba(20, 91, 146, 0.1);
    color: #3bbce6;
    font-size: 14px;
    height: 26px;
    min-width: 60px;
}
.mmPaginator .totalCountLabel span {
    color: #FFFFFF;
}
.mmPaginator .totalCountLabel {
    color: #FFFFFF;
}
 .mmPaginator .pageList li.active { 
    padding: 0px;
    width: 40px;
    height: 30px;
    text-align: center;
    background: rgba(20,91,146,0.90);
    font-size: 14px;
    padding-top: 7px;
    border: 1px solid #7BD2F0; 
 } 
 .mmPaginator .pageList li a, .mmPaginator .pageList li.disable a { 
     color: #FFFFFF; 
 } 

.mmPaginator .pageList li {
    display: inline-block;
    line-height: 1.5;
    margin: 0 2px;
    padding-top:  4px;
    vertical-align: top;
    background: rgba(20,91,146,0.90);
    border: 1px solid #7BD2F0; 
    width: 40px;
}
.mmPaginator .pageList li.disable {
    background:  rgba(20,91,146,0.90);
}
.mmGrid .mmg-bodyWrapper .mmg-body td {
border: 0.5px solid #3BBCE6;
border-bottom: 0.5px solid #3BBCE6;
border-radius: 1px;
}
#personAllwayCondition-div23 .mmGrid {
    background: #fff none repeat scroll 0 0;
    border: 0 solid #ccc;
    overflow: hidden;
    position: relative;
    text-align: left;
     color: #FFFFFF; 
}
#newFixedCar-div70 .mmGrid {
    background: #fff none repeat scroll 0 0;
    border: 0 solid #ccc;
    overflow: hidden;
    position: relative;
    text-align: left;
    color: #FFFFFF; 
}
#newFixedCar-div70 .mmg-head{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}

#strandedVehicle-div81 .mmGrid {
    background: #fff none repeat scroll 0 0;
    border: 0 solid #ccc;
    overflow: hidden;
    position: relative;
    text-align: left;
    color: #FFFFFF; 
}
#strandedVehicle-div81 .mmg-head{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
#illegalOpenGate-div71 .mmGrid {
    background: #fff none repeat scroll 0 0;
    border: 0 solid #ccc;
    overflow: hidden;
    position: relative;
    text-align: left;
    color: #FFFFFF; 
}
#illegalOpenGate-div71 .mmg-head{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
#accessAllwayCondition-div24 .mmg-head{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
#fixedVehicleCharge-div72 .mmGrid {
    background: #fff none repeat scroll 0 0;
    border: 0 solid #ccc;
    overflow: hidden;
    position: relative;
    text-align: left;
    color: #FFFFFF; 
}
#fixedVehicleCharge-div72 .mmg-head{
background-color: rgba(59, 188, 230, 0.7) ;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
#tempVehicleCharge-div73 .mmGrid {
    background: #fff none repeat scroll 0 0;
    border: 0 solid #ccc;
    overflow: hidden;
    position: relative;
    text-align: left;
    color: #FFFFFF; 
}
#tempVehicleCharge-div73 .mmg-head{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
#vehicleAllwayCondition-div22 .mmGrid {
    background: #fff none repeat scroll 0 0;
    border: 0 solid #ccc;
    overflow: hidden;
    position: relative;
    text-align: left;
    color: #FFFFFF; 
}
#accessAllwayCondition-div24 .mmg-head{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
#personAllwayCondition-div23 .mmg-bodyWrapper{
 border: 0px;
}
.mmGrid .mmg-bodyWrapper .mmg-body tr.even {
     background: rgba(20,91,146,0.90) !important;
}
.input-group .btn-default, .input-group .btn-default.active, 
.input-group .btn-default.focus, .input-group .btn-default:active,
.input-group .btn-default:focus, .input-group .btn-default:hover, 
.input-group .open > .dropdown-toggle.btn-default {
    background-color: #145B93;
    border-color: #3BBCE6;
    box-shadow: none;
    outline: 0 none;
}
#accessControlDevice-div79 .mmg-head{
/* opacity: 0.33; */
background: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
#merchantDiscount-div74 .mmg-head{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 1px;
}
.tb_personAllwayCondition .mmg-body .tr{
border: 0.5px solid #3BBCE6 !important;
background: rgba(20,91,146,0.90);
border-radius: 4px;
}
.modal-header {
    border-bottom: 1px solid #3bbce6;
    min-height: 16.43px;
    padding: 15px;
    opacity: 0.8;
}
.modal-header .close {
    margin-top: -10px;
    margin-right: -20px;
}
.btn-jump{
font-size: 14px;
color: #3BBCE6;
}
.close {
    color: #ffff;
    float: right;
    font-size: 21px;
    font-weight: 700;
    line-height: 1;
    opacity: 0.2;
    text-shadow: 0 1px 0 #fff;
}
.vehicle-passage-dropdownlist .form-control{
background-color: #3BBCE6;
border: 1px solid #3BBCE6;
border-radius: 2px;
}
.input-group .form-control:focus, .form-control[readonly], .form-control[disabled] {
    border-color: #3bbce6;
    box-shadow: none;
}
.modal-content {
   background: rgba(20,91,146,0.90);
   border-radius: 8px;
}
 .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
color: #FFFFFF;
}
.panel-title-with-input {
font-size: 20px;
color: #FFFFFF;
}
 #accessControlDevice-div79 { 
 color: #FFFFFF; 
 } 
.modal-footer {
background: rgba(20,91,146,0.90);
border-radius: 8px;
}
input, optgroup, select, textarea {
    background:#145B93 90%;
    color: rgba(255,255,255,0.60);
    font: inherit;
    margin: 0;
}
.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
    background-color: #145B93;
    border: 1px solid #3BBCE6;
	border-radius: 2px;
}
#accessControlDevice-div79 .mmGrid{
background: rgba(20,91,146,0.20);
border-radius: 1px;
border: none;
color: #FFFFFF;
}
button.close {
    background : rgba(20,91,146,0.20);
    border-bottom:none !important;
    border-bottom-left-radius: none !important;
    border-left: none !important;
    border-top: none !important;
    border-top-left-radius: none !important;
    font-size: 40px;
    padding: none !important;
}
.mmGrid .mmg-headWrapper {
    background: rgba(20, 91, 146, 0.2) none repeat scroll 0 0;
    filter: none;
    opacity: 0.7;
}
#newFixedCar-div70 .mmGrid{
background: rgba(20,91,146,0.20);
border-radius: 8px;
border: none;
}
#strandedVehicle-div81 .mmGrid{
background: rgba(20,91,146,0.20);
border-radius: 4px;
border: none;
color: #FFFFFF;
}
#illegalOpenGate-div71 .mmGrid{
background: rgba(20,91,146,0.20);
border-radius: 4px;
border: none;
color: #FFFFFF;
}
#fixedVehicleCharge-div72 .mmGrid{
background: rgba(20,91,146,0.20);
border-radius: 4px;
border: none;
/* font-family: PingFangSC-Regular; */
color: #FFFFFF;
}  
#tempVehicleCharge-div73 .mmGrid{
background: rgba(20,91,146,0.20);
border-radius: 4px;
border: none;
/* font-family: PingFangSC-Regular; */
color: #FFFFFF;
}  
#vehicleAllwayCondition-div22 .mmGrid{
background: rgba(20,91,146,0.20);
border-radius: 4px;
border: none;
/* font-family: PingFangSC-Regular; */
color: #FFFFFF;
} 
#personAllwayCondition-div23  .mmGrid{
background: rgba(20,91,146,0.20);
border-radius: 4px;
border: none;
color: #FFFFFF;
} 
#accessAllwayCondition-div24 .mmGrid{
background: rgba(20,91,146,0.20);
border-radius: 4px;
border: none;
/* font-family: PingFangSC-Regular; */
color: #FFFFFF;
} 
#merchantDiscount-div74 .mmGrid{
background: rgba(20,91,146,0.20);
border-radius:4px;
border: none;
font-family: PingFangSC-Regular;
color: #FFFFFF;
} 
#vehicleAllwayCondition-table22{
color:#FFFFFF;
}
#personAllwayCondition-table23{
color:#FFFFFF;
}
#accessAllwayCondition-tab24{
color:#FFFFFF;
} 
.mmGrid .mmg-bodyWrapper .mmg-body tr.selected td {
   background: rgba(59, 188, 230, 0.3) none repeat scroll 0 0; 
}
.mmGrid .mmg-bodyWrapper .mmg-body tr:hover td {
    background: rgba(59, 188, 230, 0.3) none repeat scroll 0 0;
}
.dropdown-menu > li > a {
    clear: both;
    color: #FFFFFF;
    display: block;
    font-weight: 400;
    line-height: 1.42857;
    padding: 3px 20px;
    white-space: nowrap;
    background:#145B93;
    
}
.dropdown-menu {
    background-clip: padding-box;
    background-color: #145B93;
    border: 1px solid rgba(0, 0, 0, 0.15);
    border-radius: 4px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.176);
    display: none;
    float: left;
    font-size: 14px;
    left: 0;
    list-style: outside none none;
    margin: 2px 0 0;
    padding: 5px 0;
    position: absolute;
    text-align: left;
    top: 100%;
    z-index: 1000;
}
/* .dropdown-menu dropdown-menu-right{ */
/* margin-right:none; */
/* margin-left:18px; */
/* } */
.open > .dropdown-menu {
margin-left:18px;
margin-right:none;
}
#pageNum {
margin-top:-1px;
height:33px;
width:40px !important;
}
.form-control:required{
background-color: #145b93;
}
.btn-common:hover, .btn-common:focus{
background-color: #145b93;
}
.mmGrid table {
    border-right: none;
    border-collapse:collapse;
}
.btn .caret {
    color: #ffff;
}
.btn-modal {
    background-color:#3bbce6;
    border-width: 0;
    color: #fff;
    padding: 5px 20px;
}
body {
    color: #fff;
}
</style>

<div class="vehicleAllwayCondition-div22" id="vehicleAllwayCondition-div22" style="padding-top: 6px;">
	<table id = "vehicleAllwayCondition-table22">
		<tr>
			<td align="right"><span style="margin-left: 41px;">车牌号：</span></td>
			<td><input id="licensePlate" class="form-control" name="licensePlate" type="text" style="width: 158px;" /></td>
			<td align="right"><span style="margin-left: 41px;">通道：</span></td>
			<td><div id="vehicle-passage-dropdownlist"></div></td>
			<td align="right"><span style="margin-left: 60px;"><button id = "queryButton" style="width:55px; height: 28px" onclick="pietbpassGrid.load()">查询</button></td>
		</tr>
	</table>
	<table id="vehicle_allwayCondition" class="vehicle_allwayCondition"
		style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPieVehiclePassGrid" style="text-align: right;"></div>
</div>
<div id="personAllwayCondition-div23" style="padding-top: 6px;">
	<table id = "personAllwayCondition-table23">
		<tr>
			<td align="right"><span style="margin-left: 5px;">姓名：</span></td>
			<td><input id="custName"  name="custName" type="text" style="width: 118px;" /></td>
			<td align="right"><span style="margin-left: 5px;">访客类型：</span></td>
			<td><div id="visitor-type-dropdownlist"></div></td>
			<td align="right"><span style="margin-left: 55px;">通道：</span></td>
			<td><div id="passage-dropdownlist"></div></td>
			<td align="right" colspan="4">
					<button id="btn-query" type="button"  style="margin-left: 80px; width: 48px">查询</button>
			</td>
		</tr>
	</table>
	<table id="pie_personAllwayCondition" class="tb_personAllwayCondition"
		style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPiePersonPassGrid" style="text-align: right;"></div>
	<div id="comeOut-datetimepicker-div"></div>
</div>
<div id="accessAllwayCondition-div24" style="padding-top: 6px;">
	<table id="accessAllwayCondition-tab24">
		<tr>
			<td align="right"><span style="margin-left: 5px;">姓名：</span></td>
			<td><input id="visitorName"  name="visitorName" type="text" style="width: 118px;" /></td>
			<td align="right"><span style="margin-left: 25px;">访客类型：</span></td>
			<td><div id="accessControl-visitor-type-dropdownlist"></div></td>
			<td align="right"><span style="margin-left: 50px;">通道：</span></td>
			<td><div id="passage-dropdownlist2"></div></td>
			<td align="right"><span style="margin-left: 50px;">
			<button id = "btnQuery" style="width:55px; height: 28px" onclick="pieTbAccessPassGrid.load()">查询</button></td>
		</tr>
	</table>
	<table id="pie_accessAllwayCondition" class="pie_accessAllwayCondition" style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPieAccessPassGrid" style="text-align: right;"></div>
	<div id="access-datetimepicker-div"></div>
</div>
<div id="accessControlDevice-div79" style="padding-top: 6px;">
	<table>
		<tr>
			<td><span class="panel-title panel-title-with-input">设备情况明细</span></td>
			<td align="right"><span style="margin-left: 55px;">状态：</span></td>
			<td><div id="status-dropdownlist"></div></td>
		</tr>
	</table>
	<table id="pie_accessControlDevice" class="tb_accessControlDevice"
		style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPieDeviceDetailGrid" style="text-align: right;"></div>
</div>
<div id="illegalOpenGate-div71" style="padding-top: 6px;">
	<table id="pie_illegalOpenGate" class="tb_illegalOpenGateGrid"
		style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPieIllegalOpenGateGrid" style="text-align: right;"></div>
</div>
<div id="newFixedCar-div70" style="padding-top: 6px;">
	<table id="pie_newFixedCar" class="tb_newFixedCarGrid"
		style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPieNewFixedCarGrid" style="text-align: right;"></div>
</div>
<div id="merchantDiscount-div74" style="padding-top: 6px;">
	<table id="pie_merchantDiscount" class="tb_merchantDiscountGrid"
		style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPieMerchantDiscountGrid" style="text-align: right;"></div>
</div>
<div id="fixedVehicleCharge-div72" style="padding-top: 6px;">
	<table id="pie_fixedVehicleCharge" class="tb_fixedVehicleChargeGrid"
		style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPieFixedVehicleChargeGrid" style="text-align: right;"></div>
</div>
<div id="tempVehicleCharge-div73" style="padding-top: 6px;">
	<table id="pie_tempVehicleCharge" class="tb_tempVehicleChargeGrid"
		style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPieTempVehicleChargeGrid" style="text-align: right;"></div>
</div>
<div id="strandedVehicle-div81" style="padding-top: 6px;">
	<table id="pie_strandedVehicle" class="tb_strandedVehicleGrid"
		style="border: 1px solid; height: 99%; width: 95%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pgPieStrandedVehicleGrid" style="text-align: right;"></div>
</div>
<script>
	var checkstrDate = "";
	var checkDeviceStatus = "";
	var vehicleStrDate = "";
	var status =  "";
	var returnParam = "";
	var vehiclePassageId = "";
	var returnPassageData = "";
	var returnVisiterType = "";
	var accessControlVisitorType = "";
	var visitorPassageId = "";
	var dropdownlist;
	var ddlItems;
	var areasItem = new Array();
	var accessControlDeviceGrid = null;
	var pieTbPersonPassGrid = null;
	var piePgPerson = $('#pgPiePersonPassGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	var piePgVehicle = $('#pgPieVehiclePassGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	var piePgAccess = $('#pgPieAccessPassGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	var piePgDevice = $('#pgPieDeviceDetailGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	var piePgOpenGate = $('#pgPieIllegalOpenGateGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	var piePgNewFixedCar = $('#pgPieNewFixedCarGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	var piePgTempVehicleCharge = $('#pgPieTempVehicleChargeGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	var piePgFixedVehicleCharge = $('#pgPieFixedVehicleChargeGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	var piePgStrandedVehicle = $('#pgPieStrandedVehicleGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	var piePgMerchantDiscountGrid = $('#pgPieMerchantDiscountGrid').mmPaginator({
		"limitList" : [ 8 ]
	});
	$(document).ready(function() {
		
		$("#comeOutTime").datetimepicker({
			id : 'datetimepicker-comeIorOTime',
			containerId : 'comeOut-datetimepicker-div',
			lang : 'ch',
			timepicker : false,
			hours12 : false,
			allowBlank : true,
			onSelectDate : function() {
				pietbpassGrid.load();
			},
			format : 'Y-m-d',
			formatDate : 'YYYY-mm-dd'
		});
		$("#accessTime").datetimepicker({
			id : 'datetimepicker-accessTime',
			containerId : 'access-datetimepicker-div',
			lang : 'ch',
			timepicker : false,
			hours12 : false,
			allowBlank : true,
			onSelectDate : function() {
				pieTbAccessPassGrid.load();
			},
			format : 'Y-m-d',
			formatDate : 'YYYY-mm-dd'
		});
		$("#status-dropdownlist").dropDownList({
			inputName: "statusName",
			inputValName: "statusValue",
			buttonText: "",
			width: "115px",
			readOnly: false,
			required: false,
			maxHeight: 200,
			onSelect: function(i, data, icon) {
				if(accessControlDeviceGrid != null){
				returnParam = data;
					accessControlDeviceGrid.load();
				}
			},
			items: [{itemText:'在线',itemData:'1'},{itemText:'离线',itemData:'0'}]
		});
		 visitorTypeDropdownlist = $("#visitor-type-dropdownlist").dropDownList({
			inputName: "visitorType",
			inputValName: "visitorTypeId",
			buttonText: "",
			width: "115px",
			readOnly: false,
			required: false,
			maxHeight: 200,
			onSelect: function(i, data, icon) {
				if(pieTbPersonPassGrid != null){
					returnVisiterType = data;
				}
			},
			items: [{itemText:'请选择',itemData:''},{itemText:'业主',itemData:'0'},{itemText:'物业',itemData:'1'},{itemText:'访客',itemData:'2'},{itemText:'其它',itemData:'3'}]
		});
		 visitorTypeDropdownlist.setData("请选择","","");
		
		accessControlVisitorTypeDropdownList = $("#accessControl-visitor-type-dropdownlist").dropDownList({
			inputName: "visitorType1",
			inputValName: "visitorTypeId1",
			buttonText: "",
			width: "115px",
			readOnly: false,
			required: false,
			maxHeight: 200,
			onSelect: function(i, data, icon) {
				accessControlVisitorType = data;
			},
			items: [{itemText:'请选择',itemData:''},{itemText:'业主',itemData:'0'},{itemText:'物业',itemData:'1'},{itemText:'访客',itemData:'2'},{itemText:'其它',itemData:'3'}]
		});
		accessControlVisitorTypeDropdownList.setData("请选择","","");
		
		var dropdownlist;
		var ddlItems;
		$.ajax({
			type: "post",
			url: "${ctx}/projectPage/listAllPassage?typeId="+2,
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			success: function(data) {
					ddlItems=data;
					dropdownlist = $('#passage-dropdownlist').dropDownList({
						inputName: "passageName",
						inputValName: "passageId",
						buttonText: "",
						width: "115px",
						readOnly: false,
						required: false,
						MultiSelect:true,
						maxHeight: 200,
						onSelect: function(i, data,icon) {
							if(pieTbPersonPassGrid != null){
								returnPassageData = data;
								//pieTbPersonPassGrid.load();
							}
						},
						items: ddlItems
					});
					dropdownlist.setData("请选择","","");
			},
			error: function(req,error,errObj) {
				showDialogModal("error-div","操作错误",errObj);
				return;
			}
		});
		
		$.ajax({
			type: "post",
			url: "${ctx}/projectPage/listAllPassage?typeId="+2,
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			success: function(data) {
					ddlItems=data;
					dropdownlist = $('#passage-dropdownlist2').dropDownList({
						inputName: "passageName",
						inputValName: "passageId",
						buttonText: "",
						width: "115px",
						readOnly: false,
						required: true,
						MultiSelect:true,
						maxHeight: 200,
						onSelect: function(i, data,icon) {
							visitorPassageId = data;
						},
						items: ddlItems
					});
					dropdownlist.setData("请选择","","");
			},
			error: function(req,error,errObj) {
				showDialogModal("error-div","操作错误",errObj);
				return;
			}
		});
		
		var dropdownPassagelist;
		var ddlPassageItems;
		$.ajax({
			type: "post",
			url: "${ctx}/projectPage/listAllPassage?typeId="+1,
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				ddlPassageItems=data;
					dropdownPassagelist = $('#vehicle-passage-dropdownlist').dropDownList({
						inputName: "vehiclePassageName",
						inputValName: "vehiclePassageId",
						buttonText: "",
						width: "115px",
						readOnly: false,
						required: true,
						MultiSelect:true,
						maxHeight: 200,
						onSelect: function(i, data,icon) {
							vehiclePassageId = data;
						},
						items: ddlPassageItems
					});
					dropdownPassagelist.setData("请选择","","");
			},
			error: function(req,error,errObj) {
				showDialogModal("error-div","操作错误",errObj);
				return;
			}
		});
		$('#btn-query').on('click', function(){
			if(typeof($("#visitorType").val()) != undefined && $("#visitorType").val()=="请选择"){
					returnVisiterType = "请选择";
				}
			piePgPerson.load({"page":1});
			pieTbPersonPassGrid.load();
		});
		var typeId = ${param.typeId};
		var paramId = '${param.paramId}';
		var seriesName = '${param.seriesName}';
		var merchantTime = '${param.merchantTime}';

		if (typeId == 22 || typeId == 86 || typeId == 87 || typeId == 88 || typeId == 89) {
			$("#vehicleAllwayCondition-div22").show();
			$("#personAllwayCondition-div23").hide();
			$("#accessAllwayCondition-div24").hide();
			$("#newFixedCar-div70").hide();
			$("#illegalOpenGate-div71").hide();
			$("#fixedVehicleCharge-div72").hide();
			$("#tempVehicleCharge-div73").hide();
			$("#merchantDiscount-div74").hide();
			$("#accessControlDevice-div79").hide();
			$("#strandedVehicle-div81").hide();
			var ALcols = [
					{
						title : '车牌号码',
						name : 'PlicensePlate',
						width : 103,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item && item.PlicensePlate) {
								return pattern
										.test(item.PlicensePlate) ? "无车牌"
										: item.PlicensePlate;
							}
						}
					},
					{
						title : '卡号',
						name : 'PcardNo',
						width : 80,
						sortable : false,
						align : 'center'
					},
					{
						title : '车辆类型',
						name : 'isFixedCar',
						width : 80,
						sortable : false,
						align : 'center'
					},
					{
						title : '入口名称',
						name : 'inPassageName',
						width : 80,
						sortable : false,
						align : 'center'
					},
					{
						title : '出口名称',
						name : 'outPassageName',
						width : 80,
						sortable : false,
						align : 'center'
					},
					{
						title : '入场时间',
						name : 'Pdate',
						width : 130,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.Pdate != undefined
									&& item.Pdate.length > 0) {
								return item.Pdate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '出场时间',
						name : 'Poutdate',
						width : 130,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.Poutdate != undefined
									&& item.Poutdate.length > 0) {
								return item.Poutdate.substr(0,
										19);
							} else {
								return "";
							}
						}
					},
					{
						title : '抓拍',
						name : 'Pisnapshot',
						width : 60,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (undefined == typeof (item.Psnapshot)
									&& item.Psnapshot.length == 0
									&& item.Psnapshot == "null"
									&& typeof (item.Pisnapshot) == 'undefined'
									&& item.Pisnapshot.length == 0
									&& item.Pisnapshot == "null") {
								return "无";
							} else {
								return '<img id="" src="${ctx}/static/images/icon34.png" />';
							}
						}
					} ];
			pietbpassGrid = $('#vehicle_allwayCondition').mmGrid(
							{
								height : 330,
								cols : ALcols,
								url : "${ctx}/projectPage/listVehicleWayCondition?organizeId=" + organizeId,
								method : 'get',
								remoteSort : true,
								multiSelect : false,
								params : function() {
									var licensePlate = $("#licensePlate").val();
									data = {};
									if (seriesName.length != 0) {
										$(data).attr({"seriesName" : seriesName});
									}
									if (typeId.length != 0) {
										$(data).attr({"typeId" : typeId});
									}
									if (paramId.length != 0) {
										$(data).attr({"paramId" : paramId});
									}
									if (licensePlate.length != 0) {
										$(data).attr({"licensePlate" : licensePlate});
									}
									if (typeof(vehiclePassageId) != undefined) {
										$(data).attr({"vehiclePassageId" : vehiclePassageId});
									}
									
 									var strDate = "";
									if(typeId == 23 || typeId == 22){
										strDate = $("#statisticsId").val();
									}else{
										strDate = $("#vehicleStatistics-dropdownlist").val();
									}
									if (strDate.length == 0) {
										$(data).attr({"startDate" : ""});
										$(data).attr({"endDate" : ""});
										$(data).attr({"paramId" : paramId});
										$(data).attr({"pieType" : 22});
										if (checkstrDate != strDate) {
											piePgVehicle.load({
												"page" : 1
											});
										}
										checkstrDate = strDate;
									} else {
										var startDate;
										var endDate;
										if(strDate==1){
											//今天
											startDate = GetDateStr(0) + " 00:00:00";
											endDate = GetDateStr(0) + " 23:59:59";
										}if(strDate==2){
											//昨天
											startDate = GetDateStr(-1) + " 00:00:00";
											endDate = GetDateStr(-1) + " 23:59:59";
										}if(strDate==3){
											//最近7天
											startDate = GetDateStr(-7) + " 00:00:00";
											endDate = GetDateStr(0) + " 23:59:59";
										}if(strDate==4){
											//最近30天
											startDate = GetDateStr(-30) + " 00:00:00";
											endDate = GetDateStr(0) + " 23:59:59";
										}
										$(data).attr({"startDate" : startDate});
										$(data).attr({"endDate" : endDate});
										if (checkstrDate != strDate) {
											piePgVehicle.load({
												"page" : 1
											});
										}
										checkstrDate = strDate;
									}
									return data;
								},
								fullWidthRows : false,
								nowrap : true,
								autoLoad : false,
								showBackboard : false,
								plugins : [ piePgVehicle ]
							});
			var zoomrInSearch = new Wadda('insearch-inImage', {"doZoom" : false});
			var zoomrOutEntrance = new Wadda('search-inImage',{"doZoom" : false});
			var zoomrOutExit = new Wadda('search-outImage', {"doZoom" : false});
			pietbpassGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
						pieTbpassGridrow = pietbpassGrid.row(rowIndex);
					}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
						vehicleCreateSnapshotModal(rowIndex);
					}).on('loadError', function(req, error, errObj) {
						showAlert('warning', '数据加载失败：' + errObj, 'tb_allwayCondition', 'top');
					}).load();
		} else if (typeId == 23 || typeId == 82 || typeId ==83 || typeId == 84 || typeId == 85) {
			$("#vehicleAllwayCondition-div22").hide();
			$("#personAllwayCondition-div23").show();
			$("#accessAllwayCondition-div24").hide();
			$("#newFixedCar-div70").hide();
			$("#illegalOpenGate-div71").hide();
			$("#fixedVehicleCharge-div72").hide();
			$("#tempVehicleCharge-div73").hide();
			$("#merchantDiscount-div74").hide();
			$("#accessControlDevice-div79").hide();
			$("#strandedVehicle-div81").hide();
			if(paramId == '业主'){
				 visitorTypeDropdownlist.setData("业主","0","");
			}else if(paramId == '物业'){
				 visitorTypeDropdownlist.setData("物业","1","");
			}else if(paramId == '访客'){
				 visitorTypeDropdownlist.setData("访客","2","");
			}else if(paramId == '其它'){
				 visitorTypeDropdownlist.setData("其它","3","");
			}
			var cols = [
					{
						title : '姓名',
						name : 'cname',
						width : 180,
						sortable : false,
						align : 'center'
					},
					{
						title : '访客类型',
						name : 'personnelTypeName',
						width : 100,
						sortable : false,
						align : 'center'
					},
					{
						title : '进出方式',
						name : 'authTypeName',
						width : 105,
						sortable : false,
						align : 'center'
					},
					{
						title : '通道',
						name : 'passageName',
						width : 140,
						sortable : false,
						align : 'center'
					},
					{
						title : '出入场时间',
						name : 'openDate',
						width : 140,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.openDate != undefined && item.openDate.length > 0) {
								return item.openDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '抓拍',
						name : 'imgurls',
						width : 80,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.imgurls != undefined && item.imgurls.length > 0) {
								return '<img id="" src="${ctx}/static/images/icon34.png" />';
							} else {
								return "无";
							}
						}
					} ];
			pieTbPersonPassGrid = $('#pie_personAllwayCondition').mmGrid(
				{
					height : 330,
					cols : cols,
					url : "${ctx}/projectPage/listPersonWayCondition?organizeId=" + organizeId,
					method : 'get',
					remoteSort : true,
					multiSelect : false,
					params : function() {
						data = {};
					
						var strDate = "";
						if(typeId == 23 || typeId == 22){
							strDate = $("#statisticsId").val();
						}else{
							strDate = $("#pedestrianId").val();
						}
						var passageId = returnPassageData;
						var custName = $("#custName").val();
						var visitorType =returnVisiterType;
						if (strDate.length == 0) {
							$(data).attr({"startDate" : ""});
							$(data).attr({"endDate" : ""});
							$(data).attr({"paramId" : paramId});
							$(data).attr({"pieType" : 23});
							if (checkstrDate != strDate) {
								piePgPerson.load({
									"page" : 1
								});
							}
							checkstrDate = strDate;
						} else if (strDate.length != 0) {
							var startDate ;
							var endDate;
							if(strDate==1){
								//今天
								startDate = GetDateStr(0) + " 00:00:00";
								endDate = GetDateStr(0) + " 23:59:59";
							}if(strDate==2){
								//昨天
								startDate = GetDateStr(-1) + " 00:00:00";
								endDate = GetDateStr(-1) + " 23:59:59";
							}if(strDate==3){
								//最近7天
								startDate = GetDateStr(-7) + " 00:00:00";
								endDate = GetDateStr(0) + " 23:59:59";
							}if(strDate==4){
								//最近30天
								startDate = GetDateStr(-30) + " 00:00:00";
								endDate = GetDateStr(0) + " 23:59:59";
							}
							$(data).attr({"startDate" : startDate});
							$(data).attr({"endDate" : endDate});
							$(data).attr({"pieType" : typeId});
							$(data).attr({"seriesName" : seriesName});
							if(returnVisiterType != "请选择"){
								$(data).attr({"paramId" : paramId});
							}
							$(data).attr({"paramId" : paramId});
							$(data).attr({"passageId" : passageId});
							$(data).attr({"custName" : custName});
							$(data).attr({"visitorType" : visitorType});
							if (checkstrDate != strDate) {
								piePgPerson.load({
									"page" : 1
								});
							}
							checkstrDate = strDate;
						}
						return data;
					},
					fullWidthRows : false,
					nowrap : true,
					autoLoad : false,
					showBackboard : false,
					plugins : [ piePgPerson ]
				});
			pieTbPersonPassGrid.on(
				'cellSelected',
				function(e, item, rowIndex, colIndex) {
					pieTbPersonPassGridrow = pieTbPersonPassGrid.row(rowIndex);
				}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
						if (pieTbPersonPassGridrow.imgurls != undefined && pieTbPersonPassGridrow.imgurls.length > 0 && pieTbPersonPassGridrow.imgurls != "null") {
							pieCreateImgurlsModal(rowIndex);
						}
					}).on('loadError', function(req, error, errObj) {
								showAlert('warning', '数据加载失败：' + errObj, 'tb_personAllwayCondition', 'top');
							}).load();
		} else if (typeId == 24) {
			$("#vehicleAllwayCondition-div22").hide();
			$("#personAllwayCondition-div23").hide();
			$("#accessAllwayCondition-div24").show();
			$("#newFixedCar-div70").hide();
			$("#illegalOpenGate-div71").hide();
			$("#fixedVehicleCharge-div72").hide();
			$("#tempVehicleCharge-div73").hide();
			$("#merchantDiscount-div74").hide();
			$("#accessControlDevice-div79").hide();
			$("#strandedVehicle-div81").hide();
			var cols = [
					{
						title : '姓名',
						name : 'cname',
						width : 180,
						sortable : false,
						align : 'center'
					},
					{
						title : '访客类型',
						name : 'personnelTypeName',
						width : 120,
						sortable : false,
						align : 'center'
					},
					{
						title : '进出方式',
						name : 'authTypeName',
						width : 120,
						sortable : false,
						align : 'center'
					},
					{
						title : '通道',
						name : 'passageName',
						width : 170,
						sortable : false,
						align : 'center'
					},
					{
						title : '出入场时间',
						name : 'openDate',
						width : 160,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.openDate != undefined && item.openDate.length > 0) {
								return item.openDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '抓拍',
						name : 'imgurls',
						width : 90,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.imgurls != undefined && item.imgurls.length > 0) {
								return '<img id="" src="${ctx}/static/images/icon34.png" />';
							} else {
								return "无";
							}
						}
					} ];
			pieTbAccessPassGrid = $('#pie_accessAllwayCondition').mmGrid(
							{
								height : 330,
								cols : cols,
								url : "${ctx}/projectPage/listPersonWayCondition?organizeId=" + organizeId,
								method : 'get',
								remoteSort : true,
								multiSelect : false,
								params : function() {
									var visitorName = $("#visitorName").val();
									data = {};
									$(data).attr({"pieType" : 24});
									if (typeId.length != 0) {
										$(data).attr({"typeId" : typeId});
									}
									if (paramId.length != 0) {
										$(data).attr({"paramId" : paramId});
									}
									if (visitorName.length != 0) {
										$(data).attr({"visitorName" : visitorName});
									}
									if (typeof(accessControlVisitorType) != undefined) {
										$(data).attr({"visitorType" : accessControlVisitorType});
									}
									if (typeof(visitorPassageId) != undefined) {
										$(data).attr({"visitorPassageId" : visitorPassageId});
									}

 									var strDate = $("#entranceGuard-dropdownlist").find("option:checked").val();
									if (strDate.length == 0) {
										$(data).attr({"startDate" : ""});
										$(data).attr({"endDate" : ""});
										if (checkstrDate != strDate) {
											piePgAccess.load({
												"page" : 1
											});
										}
										checkstrDate = strDate;
									} else {
										var startDate;
										var endDate;
										if(strDate==1){
											//今天
											startDate = GetDateStr(0) + " 00:00:00";
											endDate = GetDateStr(0) + " 23:59:59";
										}if(strDate==2){
											//昨天
											startDate = GetDateStr(-1) + " 00:00:00";
											endDate = GetDateStr(-1) + " 23:59:59";
										}if(strDate==3){
											//最近7天
											startDate = GetDateStr(-7) + " 00:00:00";
											endDate = GetDateStr(0) + " 23:59:59";
										}if(strDate==4){
											//最近30天
											startDate = GetDateStr(-30) + " 00:00:00";
											endDate = GetDateStr(0) + " 23:59:59";
										}
										$(data).attr({"startDate" : startDate});
										$(data).attr({"endDate" : endDate});
										$(data).attr({"pieType" : 24});
										if (checkstrDate != strDate) {
											piePgAccess.load({
												"page" : 1
											});
										}
										checkstrDate = strDate;
									}
									return data;
								},
								fullWidthRows : false,
								nowrap : true,
								autoLoad : false,
								showBackboard : false,
								plugins : [ piePgAccess ]
							});
			pieTbAccessPassGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
								pieTbAccessPassGridrow = pieTbAccessPassGrid.row(rowIndex);
							}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
								if (pieTbAccessPassGridrow.imgurls != undefined && pieTbAccessPassGridrow.imgurls.length > 0 && pieTbAccessPassGridrow.imgurls != "null") {
									AccessCreateImgurlsModal(rowIndex);
								}
							}).on('loadError', function(req, error, errObj) {
								showAlert('warning', '数据加载失败：' + errObj, 'tb_personAllwayCondition', 'top');
							}).load();
		} else if (typeId == 77 || typeId == 78 || typeId == 79) {
			$("#vehicleAllwayCondition-div22").hide();
			$("#personAllwayCondition-div23").hide();
			$("#accessAllwayCondition-div24").hide();
			$("#newFixedCar-div70").hide();
			$("#illegalOpenGate-div71").hide();
			$("#fixedVehicleCharge-div72").hide();
			$("#tempVehicleCharge-div73").hide();
			$("#merchantDiscount-div74").hide();
			$("#accessControlDevice-div79").show();
			$("#strandedVehicle-div81").hide();
			var cols = [
					{
						title : '序号',
						name : 'id',
						width : 50,
						sortable : false,
						align : 'center'
					},
					{
						title : '设备类型',
						name : 'deviceType',
						width : 160,
						sortable : false,
						align : 'center'
					},
					{
						title : '通道名称',
						name : 'passageName',
						width : 125,
						sortable : false,
						align : 'center'
					},
					{
						title : '设备名称',
						name : 'deviceName',
						width : 150,
						sortable : false,
						align : 'center'
					},
					{
						title : 'IP地址',
						name : 'ipAddress',
						width : 160,
						sortable : false,
						align : 'center'
					},
					{
						title : '状态',
						name : 'status',
						width : 100,
						sortable : false,
						align : 'center'
					}];
			accessControlDeviceGrid = $('#pie_accessControlDevice').mmGrid(
							{
								height : 310,
								cols : cols,
								url : "${ctx}/projectPage/listDeviceCondition?typeId="+typeId,
								method : 'get',
								remoteSort : true,
								multiSelect : false,
								params : function() {
									if (checkDeviceStatus != returnParam) {
										piePgDevice.load({
											"page" : 1
										});
									}
									checkDeviceStatus = returnParam;
									data = {};
									$(data).attr({"paramId" : paramId});
									$(data).attr({"status" : returnParam});
									return data;
								},
								fullWidthRows : false,
								nowrap : true,
								autoLoad : false,
								showBackboard : false,
								plugins : [ piePgDevice ]
							});
				accessControlDeviceGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
					accessControlDeviceGridrow = accessControlDeviceGrid.row(rowIndex);
							}).on('loadError', function(req, error, errObj) {
								showAlert('warning', '数据加载失败：' + errObj, 'tb_accessControlDevice', 'top');
							}).load();
		} else if (typeId == 71) {
			$("#vehicleAllwayCondition-div22").hide();
			$("#personAllwayCondition-div23").hide();
			$("#accessAllwayCondition-div24").hide();
			$("#newFixedCar-div70").hide();
			$("#illegalOpenGate-div71").show();
			$("#fixedVehicleCharge-div72").hide();
			$("#tempVehicleCharge-div73").hide();
			$("#merchantDiscount-div74").hide();
			$("#accessControlDevice-div79").hide();
			$("#strandedVehicle-div81").hide();
			var cols = [
					{
						title : '车牌号',
						name : 'licensePlate',
						width : 150,
						sortable : false,
						align : 'center'
					},
					{
						title : '通道名称',
						name : 'passageName',
						width : 170,
						sortable : false,
						align : 'center'
					},
					{
						title : '入场时间',
						name : 'comeInDate',
						width : 170,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.comeInDate != undefined&& item.comeInDate.length > 0) {
								return item.comeInDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '操作日期',
						name : 'operateDate',
						width : 170,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.operateDate != undefined&& item.operateDate.length > 0) {
								return item.operateDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '抓拍',
						name : 'picture',
						width : 80,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.picture != undefined && item.picture.length > 0) {
								return '<img id="" src="${ctx}/static/images/icon34.png" />';
							} else {
								return "无";
							}
						}
					}];
			illegalOpenGateGrid = $('#pie_illegalOpenGate').mmGrid(
							{
								height : 310,
								cols : cols,
								url : "${ctx}/projectPage/illegalOpenGate",
								method : 'get',
								remoteSort : true,
								multiSelect : false,
								params : function() {
								},
								fullWidthRows : false,
								nowrap : true,
								autoLoad : false,
								showBackboard : false,
								plugins : [ piePgOpenGate ]
							});
			illegalOpenGateGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
				illegalOpenGateGridrow = illegalOpenGateGrid.row(rowIndex);
							}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
								if (illegalOpenGateGridrow.picture != undefined && illegalOpenGateGridrow.picture.length > 0 && illegalOpenGateGridrow.picture != "null") {
									illegalOpenGateModal(rowIndex);
								}
							}).on('loadError', function(req, error, errObj) {
								showAlert('warning', '数据加载失败：' + errObj, 'tb_illegalOpenGateGrid', 'top');
							}).load();
		} else if (typeId == 70) {
			$("#vehicleAllwayCondition-div22").hide();
			$("#personAllwayCondition-div23").hide();
			$("#accessAllwayCondition-div24").hide();
			$("#newFixedCar-div70").show();
			$("#illegalOpenGate-div71").hide();
			$("#fixedVehicleCharge-div72").hide();
			$("#tempVehicleCharge-div73").hide();
			$("#merchantDiscount-div74").hide();
			$("#accessControlDevice-div79").hide();
			$("#strandedVehicle-div81").hide();
			var cols = [
					{
						title : '用户姓名',
						name : 'custName',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '车位号',
						name : 'parkingSpace',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '车牌号',
						name : 'licensePlate',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '收费类型',
						name : 'chargeType',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '共享组名称',
						name : 'groupName',
						width : 100,
						sortable : false,
						align : 'center'
					},
					{
						title : '生效时间',
						name : 'validDate',
						width : 150,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.validDate != undefined&& item.validDate.length > 0) {
								return item.validDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '失效时间',
						name : 'expireDate',
						width : 150,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.expireDate != undefined&& item.expireDate.length > 0) {
								return item.expireDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '创建时间',
						name : 'createDate',
						width : 150,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.createDate != undefined&& item.createDate.length > 0) {
								return item.createDate.substr(0, 19);
							} else {
								return "";
							}
						}
					}];
			newFixedCarGrid = $('#pie_newFixedCar').mmGrid(
							{
								height : 310,
								cols : cols,
								url : "${ctx}/projectPage/newFixedCar",
								method : 'get',
								remoteSort : true,
								multiSelect : false,
								params : function() {
								},
								fullWidthRows : false,
								nowrap : true,
								autoLoad : false,
								showBackboard : false,
								plugins : [ piePgNewFixedCar ]
							});
			newFixedCarGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
				newFixedCarGridrow = newFixedCarGrid.row(rowIndex);
							}).on('loadError', function(req, error, errObj) {
								showAlert('warning', '数据加载失败：' + errObj, 'tb_newFixedCarGrid', 'top');
							}).load();
		} else if (typeId == 73) {
			$("#vehicleAllwayCondition-div22").hide();
			$("#personAllwayCondition-div23").hide();
			$("#accessAllwayCondition-div24").hide();
			$("#newFixedCar-div70").hide();
			$("#illegalOpenGate-div71").hide();
			$("#fixedVehicleCharge-div72").hide();
			$("#tempVehicleCharge-div73").show();
			$("#merchantDiscount-div74").hide();
			$("#accessControlDevice-div79").hide();
			$("#strandedVehicle-div81").hide();
			var cols = [
					{
						title : '车牌号',
						name : 'licensePlate',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '入口名称',
						name : 'inPassageName',
						width : 95,
						sortable : false,
						align : 'center'
					},
					{
						title : '入场时间',
						name : 'comeInDate',
						width : 145,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.comeInDate != undefined&& item.comeInDate.length > 0) {
								return item.comeInDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '出口名称',
						name : 'outPassageName',
						width : 95,
						sortable : false,
						align : 'center'
					},
					{
						title : '出场时间',
						name : 'getOutDate',
						width : 145,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.getOutDate != undefined&& item.getOutDate.length > 0) {
								return item.getOutDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '应收金额',
						name : 'needPay',
						width : 80,
						sortable : false,
						align : 'center'
					},
					{
						title : '实收金额',
						name : 'actualPay',
						width : 80,
						sortable : false,
						align : 'center'
					},
					{
						title : '收费方式',
						name : 'payType',
						width : 80,
						sortable : false,
						align : 'payType'
					},
					{
						title : '出场操作员',
						name : 'operator',
						width : 100,
						sortable : false,
						align : 'center'
					}];
			tempVehicleChargeGrid = $('#pie_tempVehicleCharge').mmGrid(
							{
								height : 310,
								cols : cols,
								url : "${ctx}/projectPage/tempVehicleCharge",
								method : 'get',
								remoteSort : true,
								multiSelect : false,
								params : function() {
								},
								fullWidthRows : false,
								nowrap : true,
								autoLoad : false,
								showBackboard : false,
								plugins : [ piePgTempVehicleCharge ]
							});
			tempVehicleChargeGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
				tempVehicleChargeGridrow = tempVehicleChargeGrid.row(rowIndex);
							}).on('loadError', function(req, error, errObj) {
								showAlert('warning', '数据加载失败：' + errObj, 'tb_tempVehicleChargeGrid', 'top');
							}).load();
		} else if (typeId == 72) {
			$("#vehicleAllwayCondition-div22").hide();
			$("#personAllwayCondition-div23").hide();
			$("#accessAllwayCondition-div24").hide();
			$("#newFixedCar-div70").hide();
			$("#illegalOpenGate-div71").hide();
			$("#fixedVehicleCharge-div72").show();
			$("#tempVehicleCharge-div73").hide();
			$("#merchantDiscount-div74").hide();
			$("#accessControlDevice-div79").hide();
			$("#strandedVehicle-div81").hide();
			var cols = [
					{
						title : '车牌号',
						name : 'licensePlate',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '收费类型',
						name : 'chargeType',
						width : 95,
						sortable : false,
						align : 'center'
					},
					{
						title : '客户名称',
						name : 'custName',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '操作类型',
						name : 'operType',
						width : 95,
						sortable : false,
						align : 'center'
					},
					{
						title : '生效时间',
						name : 'validDate',
						width : 145,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.validDate != undefined&& item.validDate.length > 0) {
								return item.validDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '失效时间',
						name : 'expireDate',
						width : 145,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.expireDate != undefined&& item.expireDate.length > 0) {
								return item.expireDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '付款金额',
						name : 'payment',
						width : 80,
						sortable : false,
						align : 'center'
					},
					{
						title : '操作时间',
						name : 'createDate',
						width : 145,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.createDate != undefined&& item.createDate.length > 0) {
								return item.createDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '操作员',
						name : 'operator',
						width : 100,
						sortable : false,
						align : 'center'
					}];
			fixedVehicleChargeGrid = $('#pie_fixedVehicleCharge').mmGrid(
							{
								height : 310,
								cols : cols,
								url : "${ctx}/projectPage/fixedVehicleCharge",
								method : 'get',
								remoteSort : true,
								multiSelect : false,
								params : function() {
								},
								fullWidthRows : false,
								nowrap : true,
								autoLoad : false,
								showBackboard : false,
								plugins : [ piePgFixedVehicleCharge ]
							});
			fixedVehicleChargeGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
				fixedVehicleChargeGridrow = fixedVehicleChargeGrid.row(rowIndex);
							}).on('loadError', function(req, error, errObj) {
								showAlert('warning', '数据加载失败：' + errObj, 'tb_fixedVehicleChargeGrid', 'top');
							}).load();
		}else if (typeId == 74) {
			var merchantTime = '${param.merchantTime}';
			$("#vehicleAllwayCondition-div22").hide();
			$("#personAllwayCondition-div23").hide();
			$("#accessAllwayCondition-div24").hide();
			$("#newFixedCar-div70").hide();
			$("#illegalOpenGate-div71").hide();
			$("#fixedVehicleCharge-div72").hide();
			$("#tempVehicleCharge-div73").hide();
			$("#merchantDiscount-div74").show();
			$("#accessControlDevice-div79").hide();
			$("#strandedVehicle-div81").hide();
			var cols = [
					{
						title : '商家名称',
						name : 'merchantName',
						width : 110,
						sortable : false,
						align : 'center'
					},
					{
						title : '优惠类型',
						name : 'discountType',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '优惠创建时间',
						name : 'operateTime',
						width : 140,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.operateTime != undefined&& item.operateTime.length > 0) {
								return item.operateTime.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '车牌号',
						name : 'licensePlate',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '入场时间',
						name : 'comeInDate',
						width : 140,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.comeInDate != undefined&& item.comeInDate.length > 0) {
								return item.comeInDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '出场时间',
						name : 'getOutDate',
						width : 140,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.getOutDate != undefined&& item.getOutDate.length > 0) {
								return item.getOutDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '实际计费时长',
						name : 'actualTime',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '商家优惠时长',
						name : 'discountTime',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '实际使用优惠',
						name : 'actualUsedDiscount',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '操作员',
						name : 'oper',
						width : 100,
						sortable : false,
						align : 'center'
					}];
			merchantDiscountGrid = $('#pie_merchantDiscount').mmGrid(
							{
								height : 310,
								cols : cols,
								url : "${ctx}/projectPage/merchantDiscount?paramId=" + paramId,
								method : 'get',
								remoteSort : true,
								multiSelect : false,
								params : function() {
									data = {};
									if (merchantTime.length != 0) {
										$(data).attr({"merchantTime" : merchantTime});
									}
									return data;
								},
								fullWidthRows : false,
								nowrap : true,
								autoLoad : false,
								showBackboard : false,
								plugins : [ piePgMerchantDiscountGrid ]
							});
			merchantDiscountGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
				merchantDiscountGridrow = merchantDiscountGrid.row(rowIndex);
							}).on('loadError', function(req, error, errObj) {
								showAlert('warning', '数据加载失败：' + errObj, 'tb_merchantDiscountGrid', 'top');
							}).load();
		} else if (typeId == 81) {
			$("#vehicleAllwayCondition-div22").hide();
			$("#personAllwayCondition-div23").hide();
			$("#accessAllwayCondition-div24").hide();
			$("#newFixedCar-div70").hide();
			$("#illegalOpenGate-div71").hide();
			$("#fixedVehicleCharge-div72").hide();
			$("#tempVehicleCharge-div73").hide();
			$("#merchantDiscount-div74").hide();
			$("#accessControlDevice-div79").hide();
			$("#strandedVehicle-div81").show();
			var cols = [
					{
						title : '车牌号',
						name : 'licensePlate',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '客户名称',
						name : 'custName',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '共享组名称',
						name : 'groupName',
						width : 95,
						sortable : false,
						align : 'center'
					},
					{
						title : '收费类型',
						name : 'chargeType',
						width : 100,
						sortable : false,
						align : 'center'
					},
					{
						title : '入口名称',
						name : 'inPassageName',
						width : 120,
						sortable : false,
						align : 'center'
					},
					{
						title : '入场时间',
						name : 'comeInDate',
						width : 145,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.comeInDate != undefined&& item.comeInDate.length > 0) {
								return item.comeInDate.substr(0, 19);
							} else {
								return "";
							}
						}
					},
					{
						title : '滞留天数',
						name : 'strandedDays',
						width : 90,
						sortable : false,
						align : 'center'
					},
					{
						title : '抓拍',
						name : 'picture',
						width : 80,
						sortable : false,
						align : 'center',
						renderer : function(val, item, rowIndex) {
							if (item.picture != undefined && item.picture.length > 0) {
								return '<img id="" src="${ctx}/static/images/icon34.png" />';
							} else {
								return "无";
							}
						}
					}];
			strandedVehicleGrid = $('#pie_strandedVehicle').mmGrid(
							{
								height : 310,
								cols : cols,
								url : "${ctx}/projectPage/strandedVehicle",
								method : 'get',
								remoteSort : true,
								multiSelect : false,
								params : function() {
								},
								fullWidthRows : false,
								nowrap : true,
								autoLoad : false,
								showBackboard : false,
								plugins : [ piePgStrandedVehicle ]
							});
			strandedVehicleGrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
				strandedVehicleGridrow = strandedVehicleGrid.row(rowIndex);
							}).on('doubleClicked', function(e, item, rowIndex, colIndex) {
								if (strandedVehicleGridrow.picture != undefined && strandedVehicleGridrow.picture.length > 0 && strandedVehicleGridrow.picture != "null") {
									strandedVehicleModal(rowIndex);
								}
							}).on('loadError', function(req, error, errObj) {
								showAlert('warning', '数据加载失败：' + errObj, 'tb_strandedVehicleGrid', 'top');
							}).load();
		}
	});
	function pieCreateImgurlsModal(rowIndex) {
		createModalWithLoad("pie-imgurls-img", 780, 500, "人行出入情况", "projectPage/pieFindImgurlsImage?rowIndex=" + rowIndex, "", "", "");
		openModal("#pie-imgurls-img-modal", false, false);
		$('#pie-imgurls-img-modal').on('shown.bs.modal', function() {
			loadPic();
		});
	}
	function vehicleCreateSnapshotModal(rowIndex) {
		createModalWithLoad("vehicle-snapshot-img", 780, 500, "车辆出入情况", "projectPage/pieFindSnapshotImage?rowIndex=" + rowIndex, "","", "");
		openModal("#vehicle-snapshot-img-modal", false, false);
		$('#vehicle-snapshot-img-modal').on('shown.bs.modal', function() {
			loadPic();
		});
	}
	function AccessCreateImgurlsModal(rowIndex) {
		createModalWithLoad("access-snapshot-img", 780, 500, "门禁出入情况", "projectPage/accessFindSnapshotImage?rowIndex=" + rowIndex, "", "", "");
		openModal("#access-snapshot-img-modal", false, false);
		$('#access-snapshot-img-modal').on('shown.bs.modal', function() {
			loadPic();
		})
	}
	function strandedVehicleModal(rowIndex) {
		createModalWithLoad("stranded-vehicle-img", 780, 500, "场内滞留车辆", "projectPage/strandedVehicleImage?rowIndex=" + rowIndex, "", "", "");
		openModal("#stranded-vehicle-img-modal", false, false);
		$('#stranded-vehicle-img-modal').on('shown.bs.modal', function() {
			loadPic();
		})
	}
	function illegalOpenGateModal(rowIndex) {
		createModalWithLoad("illegal-open-gate-img", 780, 500, "非法开闸", "projectPage/illegalOpenGateImage?rowIndex=" + rowIndex, "", "", "");
		openModal("#illegal-open-gate-img-modal", false, false);
		$('#illegal-open-gate-img-modal').on('shown.bs.modal', function() {
			loadPic();
		})
	}
		function GetDateStr(AddDayCount) {
	    var dd = new Date();
	    dd.setDate(dd.getDate()+AddDayCount); //获取AddDayCount天后的日期
	    var y = dd.getFullYear();
	    var m = (dd.getMonth()+1) >= 10 ? dd.getMonth()+1:"0"+ (dd.getMonth()+1); //获取当前月份的日期
	    var d =  (dd.getDate() )>= 10 ? dd.getDate() : "0"+ (dd.getDate());
	    return y+"-"+m+"-"+d;
	}
</script>
