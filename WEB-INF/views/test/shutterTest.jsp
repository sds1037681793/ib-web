<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<style>
.imgContainer {
	width: 550px;
	height: 366px;
	overflow: hidden;
	-moz-box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	-webkit-box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}
</style>

<body>
	<div id="imgContainer" class="imgContainer">
		<ul>
			<li><img id="img-test" src="${ctx}/static/img/empty.jpg" style=""></li>
		</ul>
	</div>
	
	<div>
		<button id="btn-change1" class="btn">切换1</button>
		<button id="btn-change2" class="btn">切换2</button>
	</div>
</body>

<script>
var container;
var li;
var img = "";
$(document).ready(function() {
	container = $('#imgContainer');
	li = container.find('li');
	container.tzShutter({
		imgSrc: '${ctx}/static/component/jquery.shutter/img/shutter.png',
		closeCallback: function() {
			if (img && img.length > 0) {
				loadImage();
				container.trigger('shutterOpen');
			}
		},
		loadCompleteCallback:function() {
			container.trigger('shutterClose');
		}
	});
});

function loadImage() {
	$("#img-test").attr("src", img);
}

$("#btn-change1").on("click", function() {
	img = "${ctx}/static/img/1.jpg";
	container.trigger('shutterClose', {img: "${ctx}/static/img/2.jpg"});
})

$("#btn-change2").on("click", function() {
	img = "${ctx}/static/img/2.jpg";
	container.trigger('shutterClose', {img: "${ctx}/static/img/2.jpg"});
})
</script>