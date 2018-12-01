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
		style="height: 774px; margin-left: 260px;"></div>
	<div id="error-div"></div>
</body>

<script type="text/javascript">
	var detDataTypeTree;
	$(document).ready(function() {
		initializeTree();
	});

	function initializeTree() {
		$.ajax({
			type : "post",
			url : "${ctx}/alarm-center/detDataMoManage/queryTreeList",
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
		var moType=1;
		var pathNodes = treeNode.id.split(".");
		//偶数是对象， 奇数是类型 
		if(pathNodes.length % 2==0){
			moType = 0;
		}
		$("#div-content").empty();
		$("#div-content").load("${ctx}/detDataManage/detDataMoDetail?path=" +treeNode.id+"&moType="+moType);
		
	}
</script>

</html>