<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:useBean id="now" class="java.util.Date" />
<%
	Object isExtNetObj = request.getSession().getAttribute("isExtNet");
	boolean isExtNet = false;
	if (isExtNetObj != null ){
		isExtNet=(Boolean)isExtNetObj;
	}
	String imageServerAddress = (String)request.getSession().getAttribute("IMAGE_SERVER_ADDRESS");
	String mappingImageAddress = (String)request.getSession().getAttribute("MAPPING_IMAGE_ADDRESS");
%>
<!DOCTYPE html>
<html>
<head>
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link type="text/css" rel="stylesheet" href="${ctx}/static/css/all.css" />
<link href="${ctx}/static/css/windowsBule.css" type="text/css" rel="stylesheet"/>
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script	src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" stype="text/javascript"></script>
<script	src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
<script	src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/commons.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/wadda.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/HashMap.js"></script>
<script type="text/javascript"	src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript"	src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<style type="text/css">
	body{
		background-color:transparent !important;
	}
	.bx-controls-direction a {
		position: absolute;
		top: 50%;
		margin-top: -26px;
		outline: 0;
		width: 16px;
		height: 30px;
		text-indent: -9999px;
		z-index: 9999;
		margin-left:-35px;
		margin-right:-35px;
	}
</style>
</head>
<body>
<div class="row">
	<div class="col-lg-12">
		<div class="row">
			<div class="col-lg-12">
				<img style="width: 768px; height: 432px; margin-top: 20px; margin-left: 30px;" id = "picture" src="${ctx}/static/img/empty.jpg" />
				<div style="position:absolute;right:15px;bottom:0px;"><img id = "hisPicture"  src="${ctx}/static/img/empty.jpg" style="width:100px;heigth:100px"></img></div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div id="text-info" style="line-height:20px;text-align:center;margin-top:20px;font-size: 14px;color: #FFFFFF;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12"
				 style="height: 150px; width: 720px; margin-left:69px;margin-top:20px; ">
				<div id="slider_div"
					 style="display: none; line-height: 0; ">
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
    var zoomrPicture = new Wadda('picture',{"doZoom":false});
    var deviceNumber="${param.deviceNumber}";
	var projectCode = "${param.projectCode}";
    function loadPic() {
        initData(pictureData);
    }
    $("#fires-image").on('shown.bs.modal', function () {loadPic()});
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
                        return;
                    }else{
                        console.log("=====");
                        pictureData=item.data;
 					initData(pictureData);
                        $("#fires-image-modal").modal('show');
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
            var attr = "";
            attr = "src";
// 		var srcUrl = extNetImageMapping(val.snapshot);
            var srcUrl = val.imageUrl;
            var description = val.description;
            var innerImg = '<li class="slide" id="fireFightingSlide">'
                + '<img style="height:124px;width:220px;cursor: pointer;" id="bigImg_' + i + '" class="adad fireFightingBorder" ' + attr + '="' + srcUrl
                + '" title="'+srcUrl+'" onerror="src=\'${ctx}/static/img/empty.jpg\'" onclick="imgSelectRow(' + i + ');" ondragstart ="return false;" >';
            innerImg = innerImg + '<div id="fireFightingWeightStyle_'+i+'" class="fireFightingWeightStyle" style="height:20px;line-height:20px;text-align:center;font-size:14px;color: #D0E4EE;margin-top:10px">'+description+'</div></li>';
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
            slideWidth: 220,
            slideMargin: 15,
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
        $("#fireFightingSlide .fireFightingBorder").each(function(i, element) {
            if($("#"+element.id).hasClass("slideCheckStyle")){
                $("#"+element.id).removeClass("slideCheckStyle");
            }
        });
        $("#fireFightingSlide .fireFightingWeightStyle").each(function(i, element) {
            if($("#"+element.id).hasClass("weightStyle")){
                $("#"+element.id).removeClass("weightStyle");
            }
        });
        $("#fireFightingWeightStyle_" + index ).addClass("weightStyle");
        $("#bigImg_" + index ).addClass("slideCheckStyle");
        $("#text-info").addClass("weightStyle");
    }
</script>
</body>
</html>