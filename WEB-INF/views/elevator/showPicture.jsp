<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="row">
	<div class="col-lg-12">
		<div class="row">
			<div class="col-lg-12">
				<img style="width: 100%; height: 380px;" id = "picture" src="${ctx}/static/img/empty.jpg" />
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
					<div id="alarmName" style="line-height:20px;text-align:center;margin-top:5px"></div>
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
var pictureData = new Array;
var zoomrPicture = new Wadda('picture',{"doZoom":false});
function loadPic() {
	initData(pictureData);
}

$(document).ready(function() {
	if('' != "${param.deviceId}"){
		deviceId = "${param.deviceId}";
	}
	$.ajax({
		type : "post",
		url : "${ctx}/elevator/elevatorDataService/getPicture?deviceId=" + deviceId,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(item) {
			if (item) {
				if(item.totalCount == 0){
					showDialogModal("error-div", "操作提示", "暂无历史数据展示");
					return;
				}else{
					console.log("=====");
					pictureData=item.items;
					$("#show-picture-modal").modal('show');
					/**
					 *加载图片
					 */
					$("#show-picture").on('shown.bs.modal', function () {
						loadPic();
					});
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
function initData(data)
{
	$("#slider_div").html('');
	$("#slider_div").append('<ul class="slider"></ul>');
	var ul = $("#slider_div > ul");
	$("#slider_div").css("display","block");
	jQuery.each(data, function(i, val ) {
		var alarmName = val.alarmName;
		var attr = "";
		attr = "src";
		var innerImg = '<li class="slide" style="border:1px solid #DBDBDB;">'
		+ '<img style="height:120px;width:230px;cursor: pointer;" id="bigImg_' + i + '" class="adad" ' + attr + '="' + val.path
		+ '" title="'+val.path+'" onerror="src=\'${ctx}/static/img/empty.jpg\'" onclick="imgSelectRow(' + i + ');" ondragstart ="return false;" >'; 
		if(null != val.path && typeof(val.path) != "undefined" ) {
			innerImg = innerImg + '<div style="height:15px;line-height:10px;text-align:center;margin-top:10px">'+alarmName+'</div>';
		}
		innerImg = innerImg + '</li>';
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
	$('#picture').attr('src',pictureData[index].path);
	$('#picture').attr('title',pictureData[index].path);
	if(null != pictureData[index].path &&  typeof(pictureData[index].path) != "undefined" ) {
		$('#alarmName').html(pictureData[index].alarmName);
	}
}
</script>
</html>