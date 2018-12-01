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
<div id="slider_div"
	style="line-height: 0; ">
</div>
<script type="text/javascript">
	var faceImgUrl = "${param.faceImgUrl}";
	var imgUrls = "${param.imgs}";
	var data = new Array;
	data=imgUrls.split(",");
function loadPic() {
	initData(data);
}
$(document).ready(function() {
});
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
		var innerImg = '<li class="slide" style="border:1px solid #DBDBDB;">'
		+ '<img id="bigImg_' + i + '" class="adad" ' + attr + '="' + srcUrl
		+ '" title="'+srcUrl+'" onerror="src=\'${ctx}/static/img/empty.jpg\'" height="370px" width="670px">'; 
		if( typeof(faceImgUrl) != "undefined" && faceImgUrl !="undefined") {
			faceImgUrl = extNetImageMapping(faceImgUrl);
			innerImg = innerImg +'<div style="position:absolute;right:0px;bottom:0px;"><img src = '+ faceImgUrl +' style="width:100px;heigth:100px"></img></div>'
		}
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