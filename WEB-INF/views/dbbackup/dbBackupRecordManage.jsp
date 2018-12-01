<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<html>
<head>
	<style type="text/css">
	.form-control {
		height: 25.5px;
	}
	*{margin:0;padding:0;list-style-type:none;}
	a,img{border:0;}
	.demo{margin:100px auto 0 auto;width:400px;text-align:center;font-size:18px;}
	.demo .action{color:#3366cc;text-decoration:none;font-family:"微软雅黑","宋体";}
	
	.overlay{position:fixed;top:0;right:0;bottom:0;left:0;z-index:998;width:100%;height:100%;_padding:0 20px 0 0;background:#f6f4f5;display:none;}
	.showbox{position:fixed;top:0;left:50%;z-index:9999;opacity:0;filter:alpha(opacity=0);margin-left:-80px;}
	*html,*html body{background-image:url(about:blank);background-attachment:fixed;}
	*html .showbox,*html .overlay{position:absolute;top:expression(eval(document.documentElement.scrollTop));}
	#AjaxLoading{border:1px solid #8CBEDA;color:#37a;font-size:12px;font-weight:bold;}
	#AjaxLoading div.loadingWord{width:180px;height:50px;line-height:50px;border:2px solid #D6E7F2;background:#fff;}
	#AjaxLoading img{margin:10px 15px;float:left;display:inline;}
	</style>
</head>
<body>
	<div class="content-default">
		<form id="select-form">
			<table>
				<tr>
					<td align="right" width="100">开始时间：</td>
					<td>
						<input id="queryStartDate" name="queryStartDate" placeholder="备份时间" class="form-control required" type="text" style="width: 150px" />
					</td>
					<td align="right" width="100">结束时间：</td>
					<td>
						<input id="queryEndDate" name="queryEndDate" placeholder="备份时间" class="form-control required" type="text" style="width: 150px" />
					</td>
					<td></td>
					<td align="right" width="90">备份类型：</td>
					<td>
						<div id="backupType-dropdownlist"></div>
					</td>
					<td align="right">
						<button id="btn-query" type="button" class="btn btn-default btn-common btn-common-green" style="margin-left: 100px;">查询</button>
						<button id="btn-backup" type="button" class="btn btn-default btn-common btn-common-green">备份</button>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<table id="tb_dbbackup" class="tb_dbbackup" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>
	
	<div id="pg" style="text-align: right;"></div>
	
	<!-- 页底控件 -->
	<div id="btn-grp" class="btn-group btn-group-sm" style="width:400px;left:200px">
	</div>
	
	<div id="AjaxLoading" class="showbox">
		<div class="loadingWord"><img src="${ctx}/static/img/loading.gif">处理中，请稍候...</div>
	</div>
	<div id="edit-recharge"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
	<script type="text/javascript">
	var cardTypeArray = new Array();
	var isDescription = false;
		var tbGroups;
		var organizeId = $("#login-org").data("orgId");
		if($("#login-org").data("organizeType") != 3){
			var organizeId = $("#login-org").data("userOrganizeId");
	    	var organizeType = $("#login-org").data("userOrganizeType");
	    	var organizeName = $("#login-org").data("userOrganizeName");
	    	createModalWithIframe("select-operator-org", 800, 520, "选择组织", "common/changeOrganize", "receiveLoginOrganizeInfo()", "confirm-close", "organizeType=" + organizeType + "&organizeId=" + organizeId + "&organizeName=" + organizeName);
	    	openModal("#select-operator-org-modal", false, false);
		}
		$(document).ready(function() {
			$("#queryStartDate").datetimepicker({
				id: 'datetimepicker-startDate',
				containerId: 'datetimepicker-div',
				lang: 'ch',
				timepicker: false,
				allowBlank:true,
				format: 'Y-m-d',
			    formatDate: 'YYYY-mm-dd'
			});
			$("#queryEndDate").datetimepicker({
				id: 'datetimepicker-endDate',
				containerId: 'datetimepicker-div',
				lang: 'ch',
				timepicker: false,
				allowBlank:true,
				format: 'Y-m-d',
				formatDate: 'YYYY-mm-dd'
			});
			var backupTypeList = new Array();
			backupTypeList[backupTypeList.length] = {itemText:"全部",itemData:-1};
			backupTypeList[backupTypeList.length] = {itemText:"自动",itemData:0};
			backupTypeList[backupTypeList.length] = {itemText:"手工",itemData:1};
			dropdownListCharge = $('#backupType-dropdownlist').dropDownList({
				inputName: "backupTypeName",
				inputValName: "backupType",
				buttonText: "",
				width: "117px",
				readOnly: false,
				required: true,
				maxHeight: 200,
				onSelect: function(i, data,icon) {
				},
				items: backupTypeList
			});

			var cols = [
						{title:'备份Id',name:'id',width:100,sortable:true,align:'center',hidden:true},
						{title:'备份文件名',name:'fileName',width:200,sortable:true,align:'center'},
						{title:'备份文件路径',name:'backupUrl',width:300,align: 'left'},
						{title:'备份类型Id',name:'backupType',width:150,align: 'left',hidden:true},
						{title:'备份类型',name:'backupTypeName',width:100,align: 'left'},
						{title:'备份状态Id',name:'recordState',width:150,align: 'left',hidden:true},
						{title:'备份状态',name:'recordStateName',width:100,align: 'left'},
						{title:'操作员Id',name:'creator',width:100,sortable:true,align:'center',hidden:true},
						{title:'操作员',name:'creatorName',width:100,align: 'left'},
						{title:'创建时间',name:'gmtCreate',width:100,align:'left',renderer: function (val, item, rowIndex){
								return item.gmtCreate.substr(0, 10);
						}},
						{ title:'操作', name:'' ,width:150, align:'center', lockWidth:true, lockDisplay: true, renderer: function(val, item, rowIndex){
							var deleteObj = '<a class="class-delete" href="#" title="删除"><span class="glyphicon glyphicon-remove" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var downloadObj = '<a class="calss-download" href="#" title="下载"><span class="glyphicon glyphicon-sort" style="font-size: 12px; color: #777; padding-right: 10px;"></span></a>';
							var extOperations = "";
							if(item.recordState == 0){
								return;
							}
							if(item.recordState == 1 && item.state ==1){
								return downloadObj + deleteObj;
							}
							return deleteObj;
	                    }}
						];
			var pg=$('#pg').mmPaginator({"limitList":[10]});
			tbGroups = $('#tb_dbbackup').mmGrid({
				height:365,
				cols:cols,
				url:'${ctx}/dbBackupRecordManage/recordList',
				method:'get',
				params:function(){
					var queryStartDate = $("#queryStartDate").val();
					var queryEndDate = $("#queryEndDate").val();
					var backupType = $("#backupType").val();
					data = {"": ""};
					if (typeof(backupType) != "undefined" && backupType != ""){
						$(data).attr({"backupType": backupType});
					} 
					if (queryStartDate != ""){
						$(data).attr({"queryStartDate": encodeURI(queryStartDate)});
					}
					if (queryEndDate != ""){
						$(data).attr({"queryEndDate": encodeURI(queryEndDate)});
					}
					return data;
				},
				remoteSort : true,
				multiSelect : false,
				checkCol : false,
				nowrap : true,
				fullWidthRows : false,
				autoLoad : false,
				showBackboard : false,
				plugins:[pg]
			});
 			if($("#login-org").data("organizeType") == 3){
				tbGroups.on('cellSelected',function(e,item,rowIndex,colIndex){
					 e.stopPropagation();  //阻止事件冒泡
					if ($(e.target).is('.class-delete') || $(e.target).is('.glyphicon-remove')) {
		             // 删除按钮事件
						var row = tbGroups.row(rowIndex);
						showDialogModal("error-div", "操作提示", "确实要删除【" + row.fileName + "】吗？", 2, "deleteDbBackup(" + rowIndex + ");");
		            }else if ($(e.target).is('.calss-download') || $(e.target).is('.glyphicon-sort')) {
		             // 下载按钮事件
						var row = tbGroups.row(rowIndex);
						showDialogModal("error-div", "操作提示", "确实要下载【" + row.fileName + "】吗？", 2, "checkAndDownload(" + rowIndex + ");");
		            }
				}).on('loadSuccess',function(e,data){					
				}).on('checkSelected', function(e, item, rowIndex) {
				}).on('checkDeselected', function(e, item, rowIndex) {
				}).on('loadError',function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", "查询错误：" + errObj);
				}).load();

			} 
			$('#btn-query').on('click', function(){
				pg.load({"page":1});
				tbGroups.load();
			});
			$('#btn-backup').on('click', function(){
				showDialogModal("error-div","操作提示","数据备份需要一段时间，确定备份？",2,"backupDb();");
			});

		});
		
		function backupDb(){
			$.ajax({
				type: "get",
				url: "${ctx}/dbBackupRecordManage/backupDb",
				dataType: "json",
				success:function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						tbGroups.load();
						showDialogModal("error-div", "操作成功", "操作成功");
						return true;
					} else {
						showDialogModal("error-div","操作失败",data.MESSAGE);
						return false;
					}
				},
				error: function(req,error,errObj) {
					showDialogModal("error-div", "提交失败", errObj)
					$("#rechargeAllAmount").val("");
					return false;		
				}
			});
		}

		//删除数据库备份
		function deleteDbBackup(rowIndex) {
			var row = tbGroups.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/dbBackupRecordManage/delete/" + row.id,
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						showDialogModal("error-div", "操作成功", "数据已删除！");
						tbGroups.load();
						return;
					} else {
						showDialogModal("error-div", "操作错误", data.MESSAGE);
						return;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		}
		
		
		//检查文件是否存在并下载
		function checkAndDownload(rowIndex) {
			var row = tbGroups.row(rowIndex);
			$.ajax({
				type : "post",
				url : "${ctx}/dbBackupRecordManage/checkBackup/" + row.id,
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						debugger;
						window.open("${ctx}/dbBackupRecordManage/download/" + row.id);
						return;
					} else {
						showDialogModal("error-div", "操作错误", data.MESSAGE);
						tbGroups.load();
						return;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		}
		
		
	</script>
</body>
