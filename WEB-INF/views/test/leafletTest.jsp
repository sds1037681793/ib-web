<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />

<!DOCTYPE html>
<html>
<head>
<!-- leaflet  start-->
    <link href="${ctx}/static/component/leaflet/libs/leaflet.css" rel="stylesheet" />
    <link href="${ctx}/static/component/leaflet/leaflet.draw.css" rel="stylesheet" />
   
    <script src="${ctx}/static/component/leaflet/libs/leaflet-src.js" type="text/javascript"></script>
    <%-- <script src="${ctx}/static/component/leaflet/leaflet.draw.js" type="text/javascript"></script> --%>
    <script src="${ctx}/static/component/leaflet/leaflet.draw-src.js" type="text/javascript"></script>
    <%-- <script src="${ctx}/static/component/leaflet/Toolbar.js" type="text/javascript"></script>    
    <script src="${ctx}/static/component/leaflet/Tooltip.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/ext/GeometryUtil.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/ext/LatLngUtil.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/ext/LineUtil.Intersect.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/ext/Polygon.Intersect.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/ext/Polyline.Intersect.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/ext/TouchEvents.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/draw/DrawToolbar.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/draw/handler/Draw.Feature.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/draw/handler/Draw.SimpleShape.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/draw/handler/Draw.Polyline.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/draw/handler/Draw.Circle.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/draw/handler/Draw.Marker.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/draw/handler/Draw.Polygon.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/draw/handler/Draw.Rectangle.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/edit/EditToolbar.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/edit/handler/EditToolbar.Edit.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/edit/handler/EditToolbar.Delete.js" type="text/javascript"></script>
	<script src="${ctx}/static/component/leaflet/edit/handler/Edit.Poly.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/edit/handler/Edit.SimpleShape.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/edit/handler/Edit.Circle.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/edit/handler/Edit.Rectangle.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/edit/handler/Edit.Marker.js" type="text/javascript"></script> --%>
    <script src="${ctx}/static/component/leaflet/leaflet.image.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/leaflet/leaflet.js" type="text/javascript"></script>
	<%-- <script src="${ctx}/static/component/leaflet/Control.Draw.js" type="text/javascript"></script> --%>
  	 
   	<!-- leaflet  end-->

</head>
<body>

<div class="content-default">
	<div id="map" style="width: 1200px; height: 960px;"></div>

</div>
<script type="text/javascript">
$(document).ready(function() {	
	var area_children = [{"id":1016277,"name":"阳台01","location":"603,758|603,851|744,851|744,758","hasSet":false},{"id":1016278,"name":"厨房","location":"","hasSet":false},{"id":1016279,"name":"餐厅","location":"","hasSet":false},{"id":1016280,"name":"客厅","location":"","hasSet":false},{"id":1016282,"name":"卫生间01","location":"","hasSet":false},{"id":1016284,"name":"主卧","location":"","hasSet":false},{"id":1016285,"name":"书房","location":"","hasSet":false},{"id":1016286,"name":"阳台02","location":"","hasSet":false},{"id":1016287,"name":"阳台03","location":"","hasSet":false},{"id":1016288,"name":"阳台04","location":"","hasSet":false},{"id":1016289,"name":"过道","location":"","hasSet":false},{"id":1016290,"name":"其他","location":"","hasSet":false},{"id":1016320,"name":"asdfasdf1","location":"","hasSet":false}];
	initLeaflet("http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg", area_children);

});

function receiveLayer(layer){	
	drawText(layer,"asdasd",213);
}


</script>
</body>
</html>