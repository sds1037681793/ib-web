<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div id="tile-group"></div>

<ul id="report-tab-a" class="nav nav-tabs title-bar-green">
	<li role="presentation" class="active"><a href="#temporary-car-charge-statistics" data-toggle="tab">临时车收费月趋势</a></li>
	<li role="presentation"><a id="a-monthly-car-charge-statistics" href="#monthly-car-charge-statistics" data-toggle="tab">固定车收费月趋势</a></li>
</ul>
<div id="tab-content-a" class="tab-content">
	<div id="monthly-car-charge-statistics" class="tab-pane fade" style="width: 100%; height: 300px;"></div>
	<div id="temporary-car-charge-statistics" class="tab-pane fade in active" style="width: 100%; height: 300px;"></div>
</div>

<div id="report-tab-b" class="title-bar title-bar-blue">停车场使用率统计</div>
<div id="tab-content-b" class="tab-content">
	<div id="packing-lot-usage-factor" style="width: 100%; height: 400px;"></div>
</div>

<div id="report-tab-c" class="title-bar title-bar-red">测试报表</div>
<div id="tab-content-c" class="tab-content">
	<div id="test-report" style="width: 100%;"></div>
</div>

<script>
var monthlyCarChargeStatisticsCreated = false;

$(document).ready(function() {
	createTemporaryCarChargeStatistics();
	createPackingLotUsageFactor();
	
	$('#report-tab-a a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');
	});
	
	$("#a-monthly-car-charge-statistics").on("shown.bs.tab", function(e) {
		if (this.id == "a-monthly-car-charge-statistics" && !monthlyCarChargeStatisticsCreated) {
			createMonthlyCarChargeStatistics();
			monthlyCarChargeStatisticsCreated = true;
		}
	});
	
	$("#test-report").simpleReport({url: "report/4"});
	
	$("#tile-group").simpleReport({url: "report/5", style: "direct", method: "append"});
	$("#tile-group").simpleReport({url: "report/6", style: "direct", method: "append"});
	$("#tile-group").simpleReport({url: "report/7", style: "direct", method: "append"});
});

function createMonthlyCarChargeStatistics() {
	$.ajax({
		type: "post",
		url: "${ctx}/report/1?groupId=${groupId}",
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			echarts.init(document.getElementById('monthly-car-charge-statistics')).setOption($.parseJSON(data));
		},
		error: function(req, error, errObj) {
			
		}
	});
}

function createTemporaryCarChargeStatistics() {
	$.ajax({
		type: "post",
		url: "${ctx}/report/2?groupId=${groupId}",
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			echarts.init(document.getElementById('temporary-car-charge-statistics')).setOption($.parseJSON(data));
		},
		error: function(req, error, errObj) {
			
		}
	});
}

function createPackingLotUsageFactor() {
	$.ajax({
		type: "post",
		url: "${ctx}/report/3?groupId=${groupId}",
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			eval("var json=" + data);
			echarts.init(document.getElementById('packing-lot-usage-factor')).setOption(json);
		},
		error: function(req, error, errObj) {
			
		}
	});
}
</script>