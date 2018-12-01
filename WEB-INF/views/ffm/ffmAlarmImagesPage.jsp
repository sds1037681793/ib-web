<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:useBean id="now" class="java.util.Date" />
<head>
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link type="text/css" rel="stylesheet"	href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script type="text/javascript"
	src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<script type="text/javascript"	src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript"	src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
</head>
<div class="row">
	<div class="col-lg-12">
		<div class="row">
			<div class="col-lg-12">
				<img style="width: 100%; height: 380px;" id = "picture" src="${ctx}/static/img/empty.jpg" />
				<div style="position:absolute;right:15px;bottom:0px;"><img id = "hisPicture"  src="${ctx}/static/img/empty.jpg" style="width:100px;heigth:100px"></img></div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
					<div id="text-info" style="line-height:20px;text-align:center;margin-top:5px"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12"
				style="height: 150px; width: 770px; margin-left: 15px; margin-top: 5px; border: 1px solid #D3D3D3">
				<div id="slider_div"
					style="display: none; line-height: 0; margin-left: -16px; margin-right: -16px;">
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var zoomrPicture = new Wadda('picture',{"doZoom":false});
var deviceNumber="${param.deviceNumber}";
var pictureData;
function loadPic() {
	initData(pictureData);
}
$("#edit-group-add").on('shown.bs.modal', function () {loadPic()});
$(document).ready(function() {
	$.ajax({
		type : "post",
		url : "${ctx}/fire-fighting/fireFightingManage/getFiresAreaSnapshotList?CHECK_AUTHENTICATION=false&deviceNumber="+encodeURI(deviceNumber)+"&projectCode="+projectCode,
		dataType : "json",
		async:false,
		contentType : "application/json;charset=utf-8",
		success : function(item) {
			if (item && item.code==0) {
				if(item.data.length == 0){
					showDialogModal("error-div", "操作提示", "暂无历史数据展示");
					pictureData = null;
					return;
				}else{
					console.log("=====");
					pictureData=item.data;
					$("#edit-group-add-modal").modal('show');
				}
			} else {
				showDialogModal("error-div", "操作错误", item.MESSAGE);
				return;
			}
		},
		error : function(req, error, errObj) {
		}
	});
});
//图像对比
function initData(data) {
	$("#slider_div").html('');
	$("#slider_div").append('<ul class="slider"></ul>');
	var ul = $("#slider_div > ul");
	$("#slider_div").css("display","block");
	jQuery.each(data, function(i, val ) {
		var attr = "";
		attr = "src";
// 		var srcUrl = extNetImageMapping(val.snapshot);
		var srcUrl = val.imageUrl;
		var description = val.description;
		var innerImg = '<li class="slide" style="border:1px solid #DBDBDB;">'
		+ '<img style="height:120px;width:230px;cursor: pointer;" id="bigImg_' + i + '" class="adad" ' + attr + '="' + srcUrl
		+ '" title="'+srcUrl+'" onerror="src=\'${ctx}/static/img/empty.jpg\'" onclick="imgSelectRow(' + i + ');" ondragstart ="return false;" >'; 
		innerImg = innerImg + '<div style="height:15px;line-height:10px;text-align:center;margin-top:10px">'+description+'</div></li>';
		ul.append(innerImg);
    	
 		if(data.length>0){
			imgSelectRow(0);
		}  
    	
    	
	});
	$("img.lazy").lazyload({
    	placeholder : "${ctx}/static/img/empty.jpg",
        effect : " "
    }); 
	
	var slider_config = {
			startingSlide:1,
	        pager: false,
			slideWidth: 230, 
	        slideMargin: 60,
	        infiniteLoop: false,
	        minSlides: 3,
	        maxSlides: 6,
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

function imgSelectRow(index)
{
	$('#hisPicture').show();
// 	$('#picture').attr('src',extNetImageMapping(pictureData[index].snapshot));
// 	$('#picture').attr('title',extNetImageMapping(pictureData[index].snapshot));
	$('#picture').attr('src',pictureData[index].imageUrl);
	$('#picture').attr('title',pictureData[index].imageUrl);
	$('#hisPicture').hide();
	$('#hisPicture').attr('src',"");
	$('#text-info').html("设备类型："+pictureData[index].deviceTypeName+"&nbsp&nbsp&nbsp&nbsp点位号："+pictureData[index].deviceNumber+"&nbsp&nbsp&nbsp&nbsp位置："+pictureData[index].description+"&nbsp&nbsp&nbsp&nbsp"+pictureData[index].createDate);
	zoomrPicture.setZoom(2);
}
</script>
</html>