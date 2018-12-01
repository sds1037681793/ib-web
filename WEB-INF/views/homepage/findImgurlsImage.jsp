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
		row = tbPersonPassGrid.row(rowIndex);
	}
	var imgUrls = row.imgurls;
	var faceImgUrl = row.faceImgUrls;
	var data = new Array;
	data=imgUrls.split(";");
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
		+ '" title="'+srcUrl+'" onerror="src=\'${ctx}/static/img/empty.jpg\'">'; 
		if( typeof(faceImgUrl) != "undefined" ) {
			faceImgUrl = extNetImageMapping(faceImgUrl);
			innerImg = innerImg +'<div style="position:absolute;right:0px;bottom:0px;"><img id="facePic_'+i+'" src = '+ faceImgUrl +' style="width:100px;heigth:100px"></img></div>'
		}
		innerImg = innerImg + '</li>';
		ul.append(innerImg);
		var zoomrBigImg1 = new Wadda('bigImg_'+i,{"doZoom":false});
    	zoomrBigImg1.setZoom(2);
    	
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
    
   
    $(".slide").bind("click",function(){

     	var width = $(this).children("div").children("img").width();
     	if(width==100){
     		$(this).children("div").children("img").width(180);//attr("height","360")
     		$(this).children("div").children("img").height(180);
     	}else{
     		$(this).children("div").children("img").width(100);
     		$(this).children("div").children("img").height(100);
     	}
     	
    });
    
}
</script>
</html>