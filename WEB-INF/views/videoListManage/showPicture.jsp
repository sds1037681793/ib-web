<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ page import="com.rib.base.util.StaticDataUtils" %>
<%
    String systemName = StaticDataUtils.getSystemName();
    String copyright = StaticDataUtils.getCopyright();
    Object isExtNetObj = request.getSession().getAttribute("isExtNet");
    boolean isExtNet = false;
    if (isExtNetObj != null) {
        isExtNet = (Boolean) isExtNetObj;
    }
    String imageServerAddress = (String) request.getSession().getAttribute("IMAGE_SERVER_ADDRESS");
    String mappingImageAddress = (String) request.getSession().getAttribute("MAPPING_IMAGE_ADDRESS");
%>
<script type="text/javascript"
        src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js?CHECK_AUTHENTICATION=false"></script>
<link type="text/css" rel="stylesheet"
      href="${ctx}/static/js/bxslider/jquery.bxslider.min.css?CHECK_AUTHENTICATION=false"/>
<script type="text/javascript"
        src="${ctx}/static/js/bxslider/jquery.bxslider.min.js?CHECK_AUTHENTICATION=false"></script>
<div class="row">
    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-12">
                <img style="width: 100%; height: 380px;" id="picture" src="${ctx}/static/img/empty.jpg"/>
                <div style="position:absolute;right:15px;bottom:0px;"><img id="facePicture"
                                                                           src="${ctx}/static/img/empty.jpg"
                                                                           style="width:100px;heigth:100px"></img></div>
            </div>
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
    var zoomrPicture = new Wadda('picture', {"doZoom": false});
    var openDoorTypeNameArr = new Array("IC卡开门", "二维码开门", "身份证开门", "按键密码开门", "蓝牙开门", "按键开门");
    openDoorTypeNameArr[9] = "远程开门";
    var deviceId = videoListManageData.deviceId;
    var deviceNumber = videoListManageData.deviceNumber;

    function loadPic() {
        initData(videoListManageData.pictureData);
    }

    $(document).ready(function () {
        $.ajax({
            type: "post",
            url: "${ctx}/video-monitoring/videoMonitoringDataService/getPicture/" + deviceId + "/" + deviceNumber + "?CHECK_AUTHENTICATION=false",
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            success: function (item) {
                if (item && item.CODE && item.CODE == "SUCCESS") {
                    if (item.RETURN_PARAM.length == 0) {
                        showDialogModal("error-div", "操作提示", "暂无历史数据展示");
                        return;
                    } else {
                        videoListManageData.pictureData = item.RETURN_PARAM;
                        $("#show-picture-modal").modal('show');
                    }
                } else {
                    showDialogModal("error-div", "操作错误", item.MESSAGE);
                    return;
                }
            },
            error: function (req, error, errObj) {
            }
        });
    });

    //图像对比
    function initData(data) {
        $("#slider_div").html('');
        $("#slider_div").append('<ul class="slider"></ul>');
        var ul = $("#slider_div > ul");
        $("#slider_div").css("display", "block");
        jQuery.each(data, function (i, val) {
            var authType = val.authType;//开门方式
            var authTypeName = "按键开门";
            if (authType || authType == 0) {
                authTypeName = openDoorTypeNameArr[authType];
            }
            var attr = "";
            attr = "src";
            var srcUrl = extNetImageMapping(val.path);
            var innerImg = '<li class="slide" style="border:1px solid #DBDBDB;">'
                + '<img style="height:120px;width:230px;cursor: pointer;" id="bigImg_' + i + '" class="adad" ' + attr + '="' + srcUrl
                + '" title="' + srcUrl + '" onerror="src=\'${ctx}/static/img/empty.jpg\'" onclick="imgSelectRow(' + i + ');" ondragstart ="return false;" >';
            if (null != val.imageUrl && typeof(val.imageUrl) != "undefined") {
                var faceImgUrl = extNetImageMapping(val.imageUrl);
                if (faceImgUrl && typeof(faceImgUrl) != "undefined") {
                    innerImg = innerImg + '<div style="position:absolute;right:0px;bottom:26px;"><img src = "' + faceImgUrl + '" style="width:30px;heigth:30px" ondragstart ="return false;" ></img></div>';
                }
                innerImg = innerImg + '<div style="position:absolute;left:0px;bottom:29px;"><span>' + val.createDate + '</span></div>';
                innerImg = innerImg + '<div style="height:15px;line-height:10px;text-align:center;margin-top:10px">' + val.custName + '</div>';
            } else {
                innerImg = innerImg + '<div style="position:absolute;left:0px;bottom:29px;"><span>' + val.createDate + '</span></div>';
                innerImg = innerImg + '<div style="height:15px;line-height:10px;text-align:center;margin-top:10px">' + val.custName + ' ' + authTypeName + '</div>';
            }


            innerImg = innerImg + '</li>';
            ul.append(innerImg);

            if (data.length > 0) {
                imgSelectRow(0);
            }


        });

        $("img.lazy").lazyload({
            placeholder: "${ctx}/static/img/empty.jpg",
            effect: " "
        });

        var slider_config = {
            startingSlide: 1,
            pager: false,
            slideWidth: 230,
            slideMargin: 60,
            infiniteLoop: false,
            minSlides: 3,
            maxSlides: 6,
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
                }
                else if (event.keyCode == "39") {//Right
                    slider.goToNextSlide();
                    setTimeout(function () {
                        $(window).trigger("scroll");
                    }, 400);
                }
            });
        });
    }

    function imgSelectRow(index) {
        $('#facePicture').show();
        var authType = videoListManageData.pictureData[index].authType;
        var authTypeName = "按键开门";
        if (authType || authType == 0) {
            authTypeName = openDoorTypeNameArr[authType];
        }
        $('#picture').attr('src', extNetImageMapping(videoListManageData.pictureData[index].path));
        $('#picture').attr('title', extNetImageMapping(videoListManageData.pictureData[index].path));
        if (null != videoListManageData.pictureData[index].imageUrl && typeof(videoListManageData.pictureData[index].imageUrl) != "undefined" && videoListManageData.pictureData[index].imageUrl != "") {
            $('#facePicture').attr('src', extNetImageMapping(videoListManageData.pictureData[index].imageUrl));
            $('#custName').html(videoListManageData.pictureData[index].custName);
        } else {
            $('#facePicture').hide();
            $('#facePicture').attr('src', "");
            $('#custName').html(videoListManageData.pictureData[index].custName + " " + authTypeName);
        }

        zoomrPicture.setZoom(2);
    }

    /**
     * 内外网转换
     */
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
</html>