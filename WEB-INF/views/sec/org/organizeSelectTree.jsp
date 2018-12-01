<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="height" value="${param.height}" />
<c:set var="iframeCallbackFunction" value="${param.iframeCallbackFunction}" />
<c:set var="organizeId" value="${param.organizeId}" />
<c:set var="expandAll" value="${param.expandAll}" />
<script type="text/javascript" src="${ctx}/static/component/jquery-ztree/3.5.17/js/search_tree.js"></script>
<div id="tree-wrap" style="overflow: auto; border: 1px solid #ccc; border-radius: 3px;">
	<div style="padding-left: 5px; padding-top: 5px; color: #F66;">请双击目标组织进行选择</div>
	<!-- 	<div class="input-append row-fluid" style="margin-bottom: 0px;">
            <input id="search_condition" type="text" placeholder="请输入搜索条件" class="span8" style="font-size:12px"/>
            <button type="button" class="btn btn-default btn-common" onclick="search_ztree('tree-orgs', 'search_condition')">搜索</button>
    </div> -->
	<div class="zTreeDemoBackground left">
		<ul id="tree-orgs" class="ztree"></ul>
	</div>
	<div id="error-div"></div>
</div>
<script>
	var lastSelectedOrg;
	$(document).ready(function() {
		$.ajax({
			type : "get",
			url : "${ctx}/organizeSelect/queryTree?organizeId=${organizeId}",
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				var treeObj = $.fn.zTree.init($("#tree-orgs"), {
					data : {
						simpleData : {
							enable : true
						}
					},
					callback : {
						onDblClick : onDblClick
					}
				}, data);
				if ("${expandAll}" == "true") {
					treeObj.expandAll(true);
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "初始化组织数据失败！");
			}
		});

		$("#tree-wrap").css("height", (parseInt("${height}") - MODAL_HEADER_HEIGHT - 100) + "px");
	});

	function onDblClick(event, treeId, treeNode) {
		var params = {};
		if (treeNode == null || treeNode.length == 0) {
			showDialogModal("error-div", "操作错误", "请选择组织！");
		} else {
			params.organizeName = treeNode.name;
			params.id = treeNode.id;
			params.organizeType = treeNode.organizeType;

			lastSelectedOrg = params;
			lastSelectedOrg.organizeId = params.id;

			var requiredOrganizeType = "${param.requiredOrganizeType}";
			var requiredOrganizeTypeName = "${param.requiredOrganizeTypeName}";
			if (requiredOrganizeType.length > 0) {
				lastSelectedOrg.requiredOrganizeType = requiredOrganizeType;
				lastSelectedOrg.requiredOrganizeTypeName = requiredOrganizeTypeName;
			}

			var iframeCallbackFunction = "${iframeCallbackFunction}";
			if (iframeCallbackFunction != "undefined" && iframeCallbackFunction != "null" && iframeCallbackFunction != "") {
				eval("parent." + iframeCallbackFunction + "(params)");
			} else {
				parent.receiveOrganizeInfo(params);
			}
		}
	}
</script>