<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sitemesh"
           uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd"/>
<%
    Object isExtNetObj = request.getSession().getAttribute("isExtNet");
    boolean isExtNet = false;
    if (isExtNetObj != null) {
        isExtNet = (Boolean) isExtNetObj;
    }
    String imageServerAddress = (String) request.getSession().getAttribute("IMAGE_SERVER_ADDRESS");
    String mappingImageAddress = (String) request.getSession().getAttribute("MAPPING_IMAGE_ADDRESS");
%>
<!DOCTYPE html>
<html>
<head>

    <link type="text/css" rel="stylesheet" href="${ctx}/static/video-player/css/video-player.css"/>
    <link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/css/modleIframeBlue.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/css/windowsBule.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/styles/theme/rib-green.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/css/operateSystemMain.css" type="text/css" rel="stylesheet" />
<%--     <script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" --%>
<!-- 	type="text/javascript"></script> -->
	<script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js"
	type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
    <script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
    
    <style type="text/css">
/*         body { */
/*             background-color: transparent !important; */
/*         } */

        .tab-class {
            border: 1px solid #e1e1e1;
            padding: 3px;
            height: 280px;
        }

        .crgl31 {
            border: 0px;
            margin: 0 auto;
        }

        .crgl31:hover {
            cursor: pointer;
        }

        .imgClass {
            border-collapse: separate;
            display: table;
            position: relative;
            line-height: 27px;
            heigth: 100%;
            width: 100%;
            padding-top: 5px;
        }

        .dateStyle {
            height: 15px;
            white-space: nowrap;
            font-size: 12px;
/*             color: #D0E4EE; */
            diplay: block;
            margin-top: 10px;
        }

        .fontUserName {
/*             font-size: 18px; */
            font-weight: bold;
            height: 25px;
            padding-top: 17px;
        }

        .bx-controls-direction a {
            position: absolute;
            top: 75%;
            margin-top: -26px;
            outline: 0;
            width: 16px;
            height: 30px;
            text-indent: -9999px;
            z-index: 9999;
            margin-left: 7px;
            margin-right: 7px;
        }

        .bx-wrapper .bx-pager.bx-default-pager {
            text-indent: -9999px !important;
        }
        #slider_div{
        margin-top: 25px;
        }
    </style>
</head>
<body>
<div id="BigImageDiv" align="center"
     style="position: relative; height: 320px; width: 830px;margin-top:30px;">
    <div>
        <div id="strangerImg_Big"></div>
        <img alt="" id="bigImage" src="${ctx}/static/img/empty.jpg"
             style="width: 300px; height: 300px; position: relative;margin-left:-6px"
             onerror="src='${ctx}/static/img/empty.jpg'"
             ondragstart="return false;"/>
    </div>
    <table style="height: 25px;">
        <tr align="center">
            <td id="faceUserName" class="fontUserName"></td>
            <td id="faceGetTime" class="fontUserName"></td>
        <tr>
    </table>
</div>
<div
        style="height: 130px; width: 800px;">
    <div id="slider_div" style="display: none;"></div>
</div>
<div id = "error-div"></div>
<script>

    var imageObject = [];
    var tagIndex = 0;
    var initIndex = 0;
    var passageId = "${param.passageId}";
    $(document).ready(function () {
    });

    //图像对比
    function initData(data) {
        $("#slider_div").html('');
        $("#slider_div").append('<ul class="slider"></ul>');
        var ul = $("#slider_div > ul");
        $("#slider_div").css("display", "block");
        jQuery.each(data, function (i, val) {
            var hisFaceImageUrl = extNetImageMapping(val.url);
            var type = val.personnelType;
            var strangerImg;
            var strangerslideCheckStyle = "";
            var imgStyeleBorder ="";
            if (type == "0") {//识别为陌生人
                strangerImg = "strangerSmallTwoImage";
                imgStyeleBorder = "border: 6px solid #F96363";
            }
            if (type == "2") {//识别为访客
                strangerImg = "vipSmallTwoImage";
            }
            if(type == "4"){//黑名单
            	strangerImg = "blacklistSmallImage";
            	imgStyeleBorder = "border: 6px solid #F96363";
            }
            if(type == "3"){//重点关注
            	strangerImg = "focusPersonSmallImage";
            	imgStyeleBorder = "border: 6px solid #D623FF";
            }
            if (i == initIndex && type != "0" && type != "3" && type != "4") {
                strangerslideCheckStyle = "slideCheckStyle ";
            }
            var attr = "src";
            var innerImg = '<li class="slide" id="slideCutImg">'
                + '<div class="smallImg ' + strangerImg + '" id="smallImg_' + i + '"></div>'
                + '<img id="bigImg_'
                + i
                + '" class="crgl31 ' + strangerslideCheckStyle + '" '
                + attr
                + '="'
                + hisFaceImageUrl
                + '" style="height:100px;width:100px;'+imgStyeleBorder+'" onerror="src=\'${ctx}/static/img/empty.jpg\'" '
                +'onclick="imgSelectRow('
                + i + ');" ondragstart ="return false;">'
                + '<font class="dateStyle" id="spaceId_' + i + '">'
                + val.createTime + '</font>'
                + '</li>';

            ul.append(innerImg);
        });
        $("img.lazy").lazyload({
            placeholder: "${ctx}/static/img/empty.jpg",
            effect: "fadeIn"
        });
        var slider_config = {
            startingSlide: 1,
            pager: true,
            slideWidth: 100,
            slideMargin: 28,
            infiniteLoop: false,
            minSlides: 6,
            maxSlides: 6
        }

        var slider = $('.slider').bxSlider(slider_config);

        $("a.bx-prev,a.bx-next").bind("click", function () {
            setTimeout(function () {
                $(window).trigger("scroll");
            }, 400);
        });
        $("#imageContrast-modal").each(function (index) {
            $(this).keyup(function (event) {
                if (event.keyCode == "37") {//Left
                    slider.goToPrevSlide();
                    setTimeout(function () {
                        $(window).trigger("scroll");
                    }, 400);
                } else if (event.keyCode == "39") {//Right
                    slider.goToNextSlide();
                    setTimeout(function () {
                        $(window).trigger("scroll");
                    }, 400);
                }
            });
        });
    }

    function imgSelectRow(index) {
        $.ajax({
            type: "post",
            url: "${ctx}/access-control/accessStatistics/getUserInfo?&recordId=" + imageObject[index].recordId,
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                if (data == null && data.length < 0) {
                    showDialogModal("error-div", "查找数据失败", "未找到该设备相关人脸记录！");
                    return;
                }
                var faceResult = JSON.parse(data);
                var userTypeStr = "";
                if (faceResult.personnelType == 1) {
                    userTypeStr = "业主"
                    $("#strangerImg_Big").removeClass("vipBigImage");
                } else if (faceResult.personnelType == 2) {
                    userTypeStr = "访客"
                    $("#strangerImg_Big").addClass("vipBigImage");
                } else if (faceResult.personnelType == 3 ) {
                    userTypeStr = "重点关注人员";
                    $("#strangerImg_Big").removeClass("vipBigImage");
                    $("#strangerImg_Big").addClass("focusPersonBigImage");
                } else if (faceResult.personnelType == 4 ) {
                    userTypeStr = "黑名单"; 
                    $("#strangerImg_Big").removeClass("vipBigImage");
                    $("#strangerImg_Big").addClass("blacklistBigImage");
                } else if (faceResult.personnelType == 0 ) {
                	 userTypeStr = "";
                    $("#strangerImg_Big").removeClass("vipBigImage");
                	$("#strangerImg_Big").addClass("strangerBigImage");
                	$("#bigImage").addClass("strangerBorder");
                }else {
                    $("#strangerImg_Big").removeClass("vipBigImage");
                }
              
                var hisObjectImg = extNetImageMapping(imageObject[index].url)
                $("#bigImage").attr("src",
                    hisObjectImg);
                if (faceResult.userName != null && faceResult.userName != "") {
                    $("#faceUserName").html(faceResult.userName + "&nbsp;&nbsp;&nbsp;" + userTypeStr + "&nbsp;&nbsp;&nbsp; ");
                    if(faceResult.personnelType != 0){
                   		$("#strangerImg_Big").removeClass("strangerBigImage");
                   		$("#bigImage").removeClass("strangerBorder");
                    }
                    if(faceResult.personnelType != 3){
                    	$("#strangerImg_Big").removeClass("focusPersonBigImage");
                    }
                    if(faceResult.personnelType != 4){
                    	$("#strangerImg_Big").removeClass("blacklistBigImage");
                    }
                } else {
                    $("#strangerImg_Big").addClass("strangerBigImage");
                    var strangeBig = '<label style="color:#FFFFFF;" >陌生人 </label>';
                    $("#faceUserName").html(strangeBig);
                }
                $("#faceGetTime").html(imageObject[index].createTime);
            },
            error: function (req, error, errObj) {
                showDialogModal("error-div", "查找数据失败", "未找到该设备相关人脸记录！");
                return;
            }
        });
        $("#slider_div .smallImg").each(function (i, element) {
            if ($("#" + element.id).hasClass("strangerSmallImage")) {
                $("#" + element.id).removeClass("strangerSmallImage");
                $("#" + element.id).addClass("strangerSmallTwoImage");
            }
        });
        $("#slideCutImg .smallImg").each(function (i, element) {
            if ($("#" + element.id).hasClass("vipSmallImage")) {
                $("#" + element.id).removeClass("vipSmallImage");
                $("#" + element.id).addClass("vipSmallTwoImage");
            }
        });
        $("#slider_div .dateStyle").each(function (i, element) {
                $("#" + element.id).removeClass("weightStyle");
            if ($("#" + element.id).hasClass("weightStyle")) {
            }
        });
        $("#slider_div .crgl31").each(function (i, element) {
            if ($("#" + element.id).hasClass("slideCheckStyle")) {
                $("#" + element.id).removeClass("slideCheckStyle");
            }
        });
        if ($("#smallImg_" + index).hasClass("strangerSmallTwoImage")) {
            $("#smallImg_" + index).addClass("strangerSmallImage");
            $("#smallImg_" + index).removeClass("strangerSmallTwoImage");
        }
        if ($("#smallImg_" + index).hasClass("vipSmallTwoImage")) {
            $("#smallImg_" + index).addClass("vipSmallImage");
            $("#smallImg_" + index).removeClass("vipSmallTwoImage");
        }
//         $("#spaceId_" + index).addClass("weightStyle");
        $("#bigImg_" + index).addClass("slideCheckStyle");
    }

    function initFaceInfo(pageIndex) {
        $.ajax({
            type: "post",
            url: "${ctx}/access-control/accessStatistics/showFaceAllImageInfo?page=" + pageIndex + "&limit=50&passageId=" + passageId+"&projectCode=HUOJUXIAOQU",
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                var faceInfo = JSON.parse(data);
                if (faceInfo.items == "" || faceInfo.items == null) {
                    showDialogModal("error-div", "查找数据失败", "未找到该设备相关人脸记录！");
                    return;
                }
                if (faceInfo != null) {
                	
                    imageObject = faceInfo.items;
                    initData(imageObject);
                    initBigUserName(imageObject);
                }
            },
            error: function (req, error, errObj) {
                return;
            }
        });
    }

    function initBigUserName(imageObject) {
        var hisImg = extNetImageMapping(imageObject[initIndex].url);
        $("#bigImage").attr("src", hisImg);
        $("#faceGetTime").html(imageObject[initIndex].createTime);
        $.ajax({
            type: "post",
            url: "${ctx}/access-control/accessStatistics/getUserInfo?&recordId=" + imageObject[0].recordId,
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                if (data == null) {
                    showDialogModal("error-div", "查找数据失败", "未找到该设备相关人脸记录！");
                    return;
                }
                var faceResult = JSON.parse(data);
                var userTypeStr ="";
                if (faceResult.personnelType == 1) {
                    userTypeStr = "业主"
                    $("#strangerImg_Big").removeClass("vipBigImage");
                }  else if (faceResult.personnelType == 2) {
                    userTypeStr = "访客"
                    $("#strangerImg_Big").addClass("vipBigImage");
                }else if (faceResult.personnelType == 3 ) {
                    userTypeStr = "重点关注人员";
                    $("#strangerImg_Big").removeClass("vipBigImage");
                    $("#strangerImg_Big").addClass("focusPersonBigImage");
                } else if (faceResult.personnelType == 4 ) {
                    userTypeStr = "黑名单"; 
                    $("#strangerImg_Big").removeClass("vipBigImage");
                    $("#strangerImg_Big").addClass("blacklistBigImage");
                } else if (faceResult.personnelType == 0) {
                    userTypeStr = ""
                    $("#strangerImg_Big").addClass("strangerBigImage");
                    $("#strangerImg_Big").removeClass("vipBigImage");
                } else {
                	 userTypeStr = "其它";
                    $("#strangerImg_Big").removeClass("vipBigImage");
                }
                if (faceResult.userName != null && faceResult.userName != "") {
                    $("#faceUserName").html(faceResult.userName + "&nbsp;&nbsp;&nbsp;" + userTypeStr + "&nbsp;&nbsp;&nbsp; ");
                    $("#strangerImg_Big").removeClass("strangerBigImage");
                } else {
                    $("#strangerImg_Big").addClass("strangerBigImage");
                    var strangeBig = '<label style="color:#FFFFFF;" >陌生人 </label>';
                    $("#faceUserName").html(strangeBig);
                }
            },
            error: function (req, error, errObj) {
                return;
            }
        });
    }

    function extNetImageMapping(src) {
        if (src == null || src == "" || typeof(src) == "undefined") {
            return "";
        }
        var isExtNet = <%=isExtNet%>;
        var imageServerAddress = "<%=imageServerAddress%>";
        var mappingImageAddress = "<%=mappingImageAddress%>";
        if (imageServerAddress == null || imageServerAddress == "" || mappingImageAddress == null || mappingImageAddress == "") {
            return src;
        }
        if (isExtNet) {
            var e = new RegExp(imageServerAddress, "g");
            return src.replace(e, mappingImageAddress);
        }
        return src;
    }
</script>
</body>
</html>