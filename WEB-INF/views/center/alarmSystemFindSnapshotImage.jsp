<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<link href="${ctx}/static/css/pagination.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script src="${ctx}/static/js/jquery.pagination.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<script src="${ctx}/static/component/wadda/commons.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/wadda.js" type="text/javascript"></script>
 <style type="text/css">
/* .alarm {
	font-family: PingFangSC-Regular;
	font-size: 12px;
	color:white;
	letter-spacing: 0;
    background: rgba(0, 71, 101,0.9);
    border: 1px solid #56E4FF;
} */
.bx-wrapper img {
    max-width: 100%;
    display: block;
    margin-top: -12px;
}
</style> 
<body class="alarm">
<div id="slider_div"
	style="line-height: 0; margin-left: -16px; margin-right: -16px;">
</div>
</body>
<script type="text/javascript">
    var imgurls="";
	var imgurls = "${param.rows}";
	var data = new Array;
	data=imgurls.split(";");
	//initData(data);
	
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
		var srcUrl = val;
		var innerImg = '<li class="slide" style="border:1px solid #DBDBDB;">'
		+ '<img id="bigImg_' + i + '" class="" ' + attr + '="' + srcUrl
		+ '" title="'+srcUrl+'" onerror="src=\'${ctx}/static/img/empty.jpg\' " width="645" height="350">' 
		+ '</li>';
		ul.append(innerImg);
		var zoomrBigImg0 = new Wadda('bigImg_'+i,{"doZoom":false});
    	zoomrBigImg0.setZoom(2);
	});
/* 	var checklength = 5 - data.length;
	if( checklength > 0){
		for(var i=0;i < checklength ; i++){
			var innerImg = '<li class="slide"></li>'
			ul.append(innerImg);
		}
	} */

    $("img.lazy").lazyload({
    	placeholder : "${ctx}/static/img/empty.jpg",
        effect : " "
    });
	
	var slider_config = {
			startingSlide:1,
	        pager: true,
			slideWidth: 646,
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
</script>
