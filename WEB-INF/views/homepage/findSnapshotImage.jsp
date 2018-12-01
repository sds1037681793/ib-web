<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div id="slider_div"
	style="line-height: 0; margin-left: -16px; margin-right: -16px;">
</div>
<script type="text/javascript">

	var rowIndex = "${param.rowIndex}";
	if(rowIndex>=0){
		row = tbpassGrid.row(rowIndex);
	}
	var data = new Array;
	if(row.Psnapshot!= undefined && row.Psnapshot.length > 0 && row.Psnapshot!="null"){
		data[data.length] = row.Psnapshot;
	}
	if(row.Pisnapshot!= undefined && row.Pisnapshot.length > 0 && row.Pisnapshot!="null"){
		data[data.length] = row.Pisnapshot;
	}
	
	//data=imgUrls.split(";");
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
			slideWidth: 600,
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
</html>