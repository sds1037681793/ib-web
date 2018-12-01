<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<style type="text/css">
.right_box {
	background:
		url('${ctx}/static/images/powerSupply/hightPowerBgDetail.png');
}
</style>
<div class="right_box" style="width: 100%; height: 100%;"></div>
<script>
	
</script>
