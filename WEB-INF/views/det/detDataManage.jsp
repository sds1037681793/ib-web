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
<title>数据检测系统数据类型管理页面</title>
</head>
<body>
	<div id="div-tree" class="content-default"
		style="height: 100%; width: 250px; float: left;">
		<div id="tree-wrap"
			style="height: 742px; overflow: auto; border: 1px solid #ccc; border-radius: 3px;">
			<div class="zTreeDemoBackground left">
				<ul id="tree-content" class="ztree"></ul>
			</div>
			<!-- <div id="error-div"></div> -->
		</div>
	</div>
	<div id="div-content" class="content-default"
		style="height: 774px; margin-left: 260px;">
		<button id="btn-add-highest" type="button" onclick="addNodeType()" class="btn btn-default btn-common btn-common-green" style="margin-left: 3rem;">新增</button>
		</div>
	<div id="error-div"></div>
</body>
<div id="show-addDetails" style="position:absolute;z-index:1000;"></div>
<script type="text/javascript">
	var detDataTypeTree;
	var type;
	var returnData;
	var id;
	$(document).ready(function() {
		initializeTree();
	});
	function addNodeType(){
		type = 1;
		id = null;
    	createModalWithLoad("show-addDetails", 1400,828, "新增数据监测类型详情", "detDataManage/detDataTypeTableDetail", "", "", "");
		$("#show-addDetails-modal").modal('show');
	}
	function initializeTree() {
		$.ajax({
			type : "post",
			url : "${ctx}/alarm-center/detDataTypeManage/queryTreeList",
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data.length === 0) {
					openModal("#modal-add", false, false);
				}
				detDataTypeTree = $.fn.zTree.init($("#tree-content"), {
					data : {
						simpleData : {
							enable : true
						}
					},
					callback : {
						onClick : onClick,
					}
				}, data);
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "初始化功能数据失败！");
			}
		});
	}
	
	function onClick(event, treeId, treeNode) {
		if (treeNode.id <= 0) {
			return;
		}
		$("#div-content").empty();
		$("#div-content").load("${ctx}/detDataManage/detDataTypeDetail?id=" + treeNode.id);
		
	}
</script>

</html>