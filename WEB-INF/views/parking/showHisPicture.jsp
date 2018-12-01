<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<Style>
#passTime{
	width: 181px;
    height: 58px;
    position: absolute;
    top: 18px;
    left: 592px;
    font-size: 18;
    color: #fff;
    opacity: 0.8;
}
</Style>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="row">
	<div class="col-lg-12">
		<div class="row">
			<div class="col-lg-12">
				<img style="width: 100%; height: 380px;" id = "picture" src="${ctx}/static/img/empty.jpg" onerror="src='${ctx}/static/img/empty.jpg'" />
				<div style="position:absolute;right:15px;bottom:0px;"><img id = "hisPicture"  src="${ctx}/static/img/empty.jpg" style="width:100px;heigth:100px"></img></div>
			</div>
			<div  id = "passTime" >1234</div>
			
		</div>
		<div class="row">
			<div class="col-lg-12">
					<div id="custName" style="line-height:20px;text-align:center;margin-top:5px"></div>
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
var isFixedArr = new Array("临时车","固定车","访客车");
var passageName = encodeURI(encodeURI(gPassageName));
$(document).ready(function() {
	$("#record-slide-image").on('shown.bs.modal', function () {
		initData(pictureData);
	});
	$.ajax({
		type : "post",
		url : "${ctx}/parking/parkingQuery/getPicture?passageName=" + passageName +"&projectCode="+projectCode,
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
					$("#record-slide-image-modal").modal('show');
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
		var isFixed = val.isFixedCar; 
		var isFixedName="临时车";
		if(isFixed || isFixed==0){
			isFixedName = isFixedArr[isFixed];
		}
		var attr = "";
		attr = "src";
		var srcUrl = extNetImageMapping(val.snapshot);
		var innerImg = '<li class="slide" style="border:1px solid #DBDBDB;">'
		+ '<img style="height:120px;width:230px;cursor: pointer;" id="bigImg_' + i + '" class="adad" ' + attr + '="' + srcUrl
		+ '" title="'+srcUrl+'" onerror="src=\'${ctx}/static/img/empty.jpg\'" onclick="imgSelectRow(' + i + ');" ondragstart ="return false;" >'; 
		innerImg = innerImg + '<div style="height:15px;line-height:10px;text-align:center;margin-top:10px">'+val.licensePlate +' '+ isFixedName+'</div>';
		
		
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
	debugger;
	$('#hisPicture').show();
	var isFixed = pictureData[index].isFixCar;
	var isFixedName="临时车";
	var passTime = pictureData[index].passTime;
	if(isFixed || isFixed==0){
		isFixedName = isFixedArr[isFixed];
	}
	$('#picture').attr('src',extNetImageMapping(pictureData[index].snapshot));
	$('#passTime').attr('passTime',extNetImageMapping(pictureData[index].snapshot));
	$('#hisPicture').hide();
	$('#hisPicture').attr('src',"");
 	$('#custName').html(pictureData[index].licensePlate +" "+isFixedName);
	$('#passTime').html(passTime);

	zoomrPicture.setZoom(2);
}
</script>
</html>