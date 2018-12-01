<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html style="height: 100%; width: 100%">
<head>
<title>RIB-Security:
	<sitemesh:title /></title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/iconic.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/mmgrid/mmGrid.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/mmgrid/mmPaginator.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/mmgrid/theme/bootstrap-rib/mmGrid-bootstrap-rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/mmgrid/theme/bootstrap-rib/mmPaginator-bootstrap-rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap/buttons.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-ztree/3.5.17/css/zTreeStyle.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-datetimepicker/2.1.9/css/jquery.datetimepicker.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap-switch/3.3.2/css/bootstrap3/bootstrap-switch.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-icheck/1.0.2/css/all.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/dynamic-table-processor/css/dynamicTableProcessor.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
<script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/mmgrid/mmGrid.js" type="text/javascript"></script>
<script src="${ctx}/static/component/mmgrid/mmPaginator.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-ztree/3.5.17/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-ztree/3.5.17/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<script src="${ctx}/static/js/HashMap.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-dropdownlist/jquery.dropdownlist.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-datetimepicker/2.1.9/js/jquery.datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/static/component/bootstrap-switch/3.3.2/js/bootstrap-switch.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-icheck/1.0.2/js/icheck.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-uniform/2.1.2/js/jquery.uniform.js" type="text/javascript"></script>
<script src="${ctx}/static/component/dynamic-table-processor/js/dynamicTableProcessor.js" type="text/javascript"></script>
<script src="${ctx}/static/component/grid-operation/js/grid-operation.js" type="text/javascript"></script>
<!--[if lte IE 9]>
    <script src="${ctx}/static/compatible/respond.min.js"></script>
    <script src="${ctx}/static/compatible/html5shiv.min.js"></script>
    <![endif]-->
<sitemesh:head />
</head>
<body>
	<div style="height: 100%; width: 100%;">
		<div style="height: 100%; width: 100%;">
			<sitemesh:body />
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$(".modal").on('show.bs.modal', function(e) {
				$('.modal').each(function(i) {
					var $clone = $(this).clone().css('display', 'block').appendTo('body');
					var marginTop = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 4);
					marginTop = marginTop > 10 ? marginTop : 0;
					$clone.remove();
					$(this).find('.modal-content').css("margin-top", marginTop);
				});
			});

			$('input').bind('input propertychange', function(e) {
				var value = "";
				if ($.browser && $.browser.msie) {
					value = e.srcElement.value;
				} else {
					value = e.target.value;
				}
				if (value.length != 0) {
					removeAllAlert();
				}
			});
		});
	</script>
</body>
</html>