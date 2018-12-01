<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>

.bg{
	width: 1644px; 
 	height: 900px; 
	background-repeat: no-repeat;
}
.bg_img { 
 	width: 300px; 
 	height: 200px; 
 	margin-top: 280px;
    margin-left: 680px;
 } 
</style>
</head>
<body>
<div class = "bg">
<img class = "bg_img" src="${ctx}/static/img/noData.svg"></img>
</div>
</body>
</html>