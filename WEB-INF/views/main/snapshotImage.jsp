<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<% 
	String systemName = StaticDataUtils.getSystemName(); 
	String copyright = StaticDataUtils.getCopyright();
	Object isExtNetObj = request.getSession().getAttribute("isExtNet");
	boolean isExtNet = false;
	if (isExtNetObj != null ){
	    isExtNet=(Boolean)isExtNetObj;
	}
	String imageServerAddress = (String)request.getSession().getAttribute("IMAGE_SERVER_ADDRESS");
	String mappingImageAddress = (String)request.getSession().getAttribute("MAPPING_IMAGE_ADDRESS");
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script src="${ctx}/static/component/wadda/commons.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/wadda.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/HashMap.js"></script>
<script type="text/javascript"	src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript"	src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>

<div id="slider_div"
	style="line-height: 0; margin-left: -16px; margin-right: -16px;">
</div>
<script type="text/javascript">
	
	var snapshotImages = "${param.snapshotImages}";
	var imgUrls = snapshotImages;
	var data = new Array;
	data=imgUrls.split(",");
$(document).ready(function() {
	$('#alarm-device-img-modal').on('shown.bs.modal', function() {
		loadPic();
	})
});
function loadPic() {
	initData(data);
}
//图像对比
function initData(data)
{
	$("#slider_div").html('');
	$("#slider_div").append('<ul class="slider"></ul>');
	var ul = $("#slider_div > ul");
	$("#slider_div").css("display","block");
	jQuery.each(data, function(i, val ) {
		var attr = "";
		attr = "src";
		var srcUrl = extNetImageMapping(val);
		var innerImg = '<li class="slide" >'
		+ '<img id="bigImg_' + i + '" class="adad" ' + attr + '="' + srcUrl
		+ '" title="'+srcUrl+'" onerror="src=\'${ctx}/static/img/empty.jpg\'" height="370px" width="650px">'; 
		innerImg = innerImg + '</li>';
		ul.append(innerImg);
		var zoomrBigImg1 = new Wadda('bigImg_'+i,{"doZoom":false});
    	zoomrBigImg1.setZoom(2);
	});
	
    $("img.lazy").lazyload({
    	placeholder : "${ctx}/static/img/empty.jpg",
        effect : " "
    });
	
	var slider_config = {
			startingSlide:1,
	        pager: true,
			slideWidth: 654,
			adaptiveHeight: true,
	        slideMargin: 10,
	        infiniteLoop: true,
	        minSlides: 1,
	        maxSlides: 1
	    }
	
	var slider = $('.slider').bxSlider(slider_config);
	
    $("a.bx-prev,a.bx-next").bind("click", function() {
        setTimeout(function() { $(window).trigger("scroll"); }, 400);
    });
    $("#imageContrast-modal").each(function(index) {
        $(this).keyup(function (event) {
            if (event.keyCode == "37") {//Left
            	slider.goToPrevSlide();
            	setTimeout(function() { $(window).trigger("scroll"); }, 400);
            }
            else if(event.keyCode == "39"){//Right 
            	slider.goToNextSlide();
            	setTimeout(function() { $(window).trigger("scroll"); }, 400);
            }
        });
    });
}
    function extNetImageMapping(src){
    	if(src==null||src==""|| typeof(src) == "undefined"){
    		return "";
    	}
    	var isExtNet = <%=isExtNet%>;
    	var imageServerAddress = "<%=imageServerAddress%>";
    	var mappingImageAddress = "<%=mappingImageAddress%>";
    	if(imageServerAddress == null || imageServerAddress == "" || mappingImageAddress == null || mappingImageAddress == ""){
    		return src;
    	}
    	if(isExtNet){
    		var e=new RegExp(imageServerAddress,"g");
    		return src.replace(e,mappingImageAddress);
    	}
    	return src;
    }
</script>
</html>