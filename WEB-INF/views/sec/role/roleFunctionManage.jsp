<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="roleId" value="${param.roleId}" />
<c:set var="organizeId" value="${param.organizeId}" />
<div id="tree-wrap" style="height: 100%; overflow: auto; border: 1px solid #ccc; border-radius: 3px;">
	<div class="zTreeDemoBackground left">
		<ul id="tree-role-functions" class="ztree"></ul>
	</div>
	<div id="error-div"></div>
</div>
<script>
	$(document).ready(function() {
		$.ajax({
			type : "post",
			url : "${ctx}/roleFunction/queryTree?roleId=${roleId}&organizeId=${organizeId}",
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				$.fn.zTree.init($("#tree-role-functions"), {
					check : {
						enable : true,
						chkboxType : {
							"Y" : "ps",
							"N" : "ps"
						}
					},
					data : {
						simpleData : {
							enable : true
						}
					}
				}, data);
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "初始化菜单数据失败：" + errObj);
			}
		});

		$("#tree-wrap").css("height", (parseInt("${height}") - MODAL_HEADER_HEIGHT - MODAL_FOOTER_HEIGHT - 30) + "px");
	});

	function getAllSelectedFunctions() {
		var tree = $.fn.zTree.getZTreeObj("tree-role-functions");
		var nodes = tree.getCheckedNodes(true);
		if (nodes && nodes.length > 0) {
			var result = new Array(nodes.length);
			for (var i = 0; i < nodes.length; i++) {
				result[i] = {
					id : nodes[i].id,
					funcName : nodes[i].name
				};
			}
			return result;
		}
		return null;
	}
	function getAllSelectedFunctionsStr() {
		var functionsStr = "";
		var tree = $.fn.zTree.getZTreeObj("tree-role-functions");
		var nodes = tree.getCheckedNodes(true);
		if (nodes && nodes.length > 0) {
			var result = new Array(nodes.length);
			for (var i = 0; i < nodes.length; i++) {
				if(functionsStr == ""){
					functionsStr = nodes[i].id;
				}else{
					functionsStr = functionsStr +","+nodes[i].id;
				}
			}
			return functionsStr;
		}
		return functionsStr;
	}
</script>