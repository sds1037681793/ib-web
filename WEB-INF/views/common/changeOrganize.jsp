<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="organizeId" value="${param.organizeId}"/>
<c:set var="organizeName" value="${param.organizeName}"/>
<c:set var="organizeType" value="${param.organizeType}"/>

<div id="org-panel" class="panel panel-default"></div>

<style>
.panel-button {
	padding: 8px 20px 8px 20px;
	font-size: 13px;
	margin-right: 10px;
	margin-bottom: 4px;
}
.panel-heading {
	padding: 5px 15px;
}
</style>
<script>
var classes = ["btn-primary", "btn-success", "btn-info", "btn-warning", "btn-danger"];
var orgId = parseInt("${organizeId}");
var orgType = parseInt("${organizeType}");
var orgName = "${organizeName}";
var lastSelectedOrg = {};

$(document).ready(function() {
	function queryOrganize(id) {
		var result = null;
		$.ajax({
			type: "post",
			url: "${ctx}/common/queryOrganizes4Change?organizeId=" + id,
			contentType: "application/json;charset=utf-8",
			async: false,
			success: function(data) {
				result = data;
			},
			error: function(req, error, errObj) {

			}
		});
		return result;
	}

	function createPanelContent(org, data) {
		if (!data || data.length <0) {
			return;
		}
		var panelTitle = "";
		var panelName = "";
		var parentPanelTitle = "";
		var parentPanelName = "";
		if (org.organizeType == 0) {
			removePannel("group");
			removePannel("company");
			removePannel("project");
			panelTitle = "集团";
			panelName = "group";
		} else if (org.organizeType == 1) {
			removePannel("group");
			removePannel("company");
			removePannel("project");
			panelTitle = "分公司";
			panelName = "company";
			parentPanelTitle = "集团";
			parentPanelName = "group";
		} else if (org.organizeType == 2) {
			removePannel("project");
			panelTitle = "物业项目";
			panelName = "project";
			parentPanelTitle = "分公司";
			parentPanelName = "company";
		} else {
			return;
		}
		var innerHtml = new StringBulider();
		if ((orgType == 1 || orgType == 2) && orgType == org.organizeType) {
			innerHtml.append('<div id="').append(parentPanelName).append('-panel-title" class="panel-heading" style="font-size: 14px;">').append(parentPanelTitle).append('</div>');
			innerHtml.append('<div id="').append(parentPanelName).append('-panel-body" class="panel-body">');

			innerHtml.append('<button id="btn-organize-').append(parentPanelName).append('" type="button" class="btn panel-button ').append(getRadomClass()).append('" value="').append(org.organizeId).append('" orgType="').append(org.organizeType).append('"><span class="glyphicon glyphicon-ok" aria-hidden="true" style="margin-right: 10px;"></span>').append(org.organizeName).append('</button>');

			innerHtml.append('</div>');
			
			lastSelectedOrg = {organizeId: orgId, organizeName: orgName, organizeType: orgType};
		}
		innerHtml.append('<div id="').append(panelName).append('-panel-title" class="panel-heading" style="font-size: 14px;">').append(panelTitle).append('</div>');
		innerHtml.append('<div id="').append(panelName).append('-panel-body" class="panel-body">');

		// 生成按钮数据
		var useClasses = new HashMap();
		$.each(JSON.parse(data), function(n, value) {
			var radomClass = getRadomClass();
			if (useClasses.size() <5 && useClasses.containsKey(radomClass)) {
				radomClass = getRadomClass();
			}
			innerHtml.append('<button id="btn-organize-').append(panelName).append('" type="button" class="btn panel-button ').append(radomClass).append('" value="').append(value.id).append('" orgType="').append(value.organizeType).append('">').append(value.organizeName).append('</button>');
		});

		innerHtml.append('</div>');

		$("#org-panel").append(innerHtml.toString());

		// 取消绑定，否则会导致重复绑定
		$("button[id=btn-organize-"+ panelName + "]").unbind('click').click(function () {
		    
		});

		$("button[id=btn-organize-"+ panelName + "]").on("click", function() {
			/* if ($(this).html().length > 20) {
				return;
			} */
			$.each($("button[id=btn-organize-" + panelName + "]"), function(n, value) {
				$(value).html($(value).text());
			});
			$(this).html('<span class="glyphicon glyphicon-ok" aria-hidden="true" style="margin-right: 10px;"></span>' + $(this).text());

			lastSelectedOrg = {organizeId: $(this).val(), organizeName: $(this).text(), organizeType: $(this).attr("orgType")};

			// 生成下级组织
			createPanelContent(lastSelectedOrg, queryOrganize(this.value));
		});
		
		if ((orgType == 1 || orgType == 2) && orgType == org.organizeType) {
			$("button[id=btn-organize-"+ parentPanelName + "]").unbind('click').click(function () {
			    
			});

			$("button[id=btn-organize-"+ parentPanelName + "]").on("click", function() {
				lastSelectedOrg = {organizeId: $(this).val(), organizeName: $(this).text(), organizeType: $(this).attr("orgType")};
				// 生成下级组织
				createPanelContent(lastSelectedOrg, queryOrganize(this.value));
			});
		}
	}

	function removePannel(type) {
		var title = $("#" + type + "-panel-title");
		if (title && title.length > 0) {
			title.remove();
		}
		var body = $("#" + type + "-panel-body");
		if (body && body.length > 0) {
			body.remove();
		}
	}

	function getRadomClass() {
		var i = Math.floor(Math.random()*5);
		return classes[i];
	}

	var childData = queryOrganize(parseInt("${organizeId}"));

	createPanelContent({organizeId: orgId, organizeType: orgType, organizeName: orgName}, childData);
});

</script>