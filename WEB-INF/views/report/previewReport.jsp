<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
    String id = String.valueOf(request.getAttribute("id"));
%>
<script src="${ctx}/static/js/jqueryPhoto.js" type="text/javascript"></script>
<script src="${ctx}/static/component/dynamic-report-processor/js/dynamicReportPreviewProcessor.js" type="text/javascript"></script>
<div id="reportview-0">0</div>
<div id="modal-picture-0" class="modal">
	<div class="modal-dialog" style="width: 677px; height: 0px">
		<div class="modal-content">
			<div id="pictureDiv" class="modal-body dynamic-table-photo" style="padding: 0px;">
				<!--效果html开始-->
				<div class="main">
					<div class="left">
						<div class="mod18">
							<span id="prev" class="btn prev" style="display: none;"></span>
							<span id="next" class="btn next" style="display: none;"></span>
							<span id="prevTop" class="btn prev"></span>
							<span id="nextTop" class="btn next"></span>
							<div id="picBox" class="picBox">
								<ul id="pictureUL-<%=id%>" class="cf">
									<li>
										<img src="${ctx}/static/component/dynamic-report-processor/img/image-error.png" alt="">
										<span>(1/1)</span>
									</li>
								</ul>
							</div>
							<div id="listBox" class="listBox" style="display: none;">
								<ul style="width: 1792px; left: -512px;" class="cf">
									<li class="">
										<i class="arr2"></i>
										<img src="${ctx}/static/component/dynamic-report-processor/img/image-error.png" alt="">
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	var dynamicreport;
	var reportId = 0;
	$(document).ready(function() {
		// 获取报表参数
		$.ajax({
			type : "post",
			url : "${ctx}/report/getReportDefine/" + reportId,
			data : JSON.stringify(previewObject),
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data != null && data.length > 0) {
					var reportDefine;
					try {
						reportDefine = JSON.parse(data);
					} catch (e) {
					}

					reportDefine["id"] = reportId;
					reportDefine["contextPath"] = "${ctx}";
					reportDefine["containerDivId"] = "reportview-" + reportId;
					reportDefine["previewObject"] = previewObject;

					// 生成动态报表
					dynamicreport = $("#reportview-" + reportId).dynamicPreviewReport(reportDefine);
					//dynamicreport.showPicture(titlesString,imageUrlsString);
				}
			},
			error : function(req, error, errObj) {

			}
		});
	});
	$('#closeImage').on('click', function() {
		$('#imageContentDiv').empty();
		$('#imageDiv-' + reportId).css('display', 'none');
	});

	$("#pictureDiv").click(function(event) {
		event = event || window.event;
		event.stopPropagation();
	});
</script>