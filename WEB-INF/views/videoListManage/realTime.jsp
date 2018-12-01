<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>视频监控地图</title>
    <link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>

    <script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/public.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/HashMap.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/wadda/commons.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/wadda/wadda.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
    <style>
        .real_time_body {
            line-height: 20px;
            height: 1080px;
            margin: 0px;
            margin-top: -20px;
            background: #162D39 !important;
            width: 1920px;
        }
    </style>
</head>
<body class="real_time_body">
<div style="position: absolute;width: 1920px;text-align:center; top: 35px;color: #5F95B1;font-size: 48px;z-index: 2;">视频监控地图</div>
<div id="videoStatePosition"
     style="width: 1920px;height: 1080px;background: url('${ctx}/static/images/huoju.png') no-repeat;position: relative;">
</div>
</body>
<div id="show-video"></div>
<div id="show-picture"></div>
<div id="error-div"></div>
<script>
    var videoListManageData = {
        row: {}
    };
    var RealTimeData = {
        videoMonitoringPosition: {},
        videoIconList: {
            L: "${ctx}/static/img/video/left.svg",
            LO: "${ctx}/static/img/video/left_offline.svg",
            LU: "${ctx}/static/img/video/left_upper.svg",
            LUO: "${ctx}/static/img/video/left_upper_offline.svg",
            U: "${ctx}/static/img/video/up.svg",
            UO: "${ctx}/static/img/video/up_offline.svg",
            RU: "${ctx}/static/img/video/right_upper.svg",
            RUO: "${ctx}/static/img/video/right_upper_offline.svg",
            R: "${ctx}/static/img/video/right.svg",
            RO: "${ctx}/static/img/video/right_offline.svg",
            RD: "${ctx}/static/img/video/right_down.svg",
            RDO: "${ctx}/static/img/video/right_down_offline.svg",
            D: "${ctx}/static/img/video/down.svg",
            DO: "${ctx}/static/img/video/down_offline.svg",
            LD: "${ctx}/static/img/video/left_down.svg",
            LDO: "${ctx}/static/img/video/left_down_offline.svg"
        }

    };

    var RealTimeUtils = {
        init: function () {
            RealTimeUtils.loadDeviceList();
        },
        loadDeviceList: function () {
            $.ajax({
                type: "post",
                url: "${ctx}/device/manage/getVideoMonitoringPosition?CHECK_AUTHENTICATION=false",
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    if (!data || data.length <= 0) {
                        return;
                    }
                    for (var i in data) {
                        RealTimeData.videoMonitoringPosition[data[i].id] = data[i];

                        if(!data[i].showVideoIcon){
                            continue;
                        }

                        var showVideoIcon = JSON.parse(data[i].showVideoIcon);
                        var iconUrl;
                        if(showVideoIcon){
                            iconUrl = RealTimeData.videoIconList[showVideoIcon.icon];
                        }

                        if (!iconUrl) {
                            iconUrl = "${ctx}/static/images/zaixian.svg";
                        }
                        $("#videoStatePosition").append('<div style="position: absolute;width:20px;height:20px;cursor: pointer;margin-left: ' + data[i].marginLeft + 'px; margin-top: ' + data[i].marginTop + 'px;" onclick="RealTimeUtils.showVideo(' + data[i].id + ')">' +
                            '<img src="' + iconUrl + '" style="width: 25px;height: 25px;"/>' +
                            '</div>');
                    }
                },
                error: function (req, error, errObj) {
                }
            });
        },
        showVideo: function (data) {
            videoListManageData.row.deviceId = RealTimeData.videoMonitoringPosition[data].deviceId;
            videoListManageData.row.channel = RealTimeData.videoMonitoringPosition[data].channel;
            var options = {
                modalDivId: "show-video",
                width: 820,
                height: 560,
                title: "查看视频",
                url: "videomonitoring/showVideo1?CHECK_AUTHENTICATION=false",
                footerType: "user-defined",
                oriMarginTop: 180,
                footerButtons: []
            };
            createModalWithLoadOptions(options);
            openModal("#show-video-modal", false, false);
        }
    };

    $(document).ready(function () {
        RealTimeUtils.init();
    })
</script>
</html>
