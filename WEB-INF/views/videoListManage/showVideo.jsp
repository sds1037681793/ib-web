<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd"/>
<iframe src="${ctx}/videomonitoring/iframeShow?height=400&width=775" id="iframe" frameborder="0" style="width: 790px;height: 421px;"></iframe>
<script type="text/javascript">
    var deviceId = videoListManageData.row.deviceId;
    var channel = videoListManageData.row.channel;
    $(".modal-dialog").css("transform","none");
</script>

