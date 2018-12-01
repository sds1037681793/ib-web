<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>

<html>
<head>
    <title>海康NVR播放</title>
    <style type="text/css">
        div#rMenu {
            position: absolute;
            visibility: hidden;
            top: 0;
            background-color: #555;
            text-align: left;
            padding: 2px;
        }

        div#rMenu ul li {
            margin: 1px 0;
            padding: 0 5px;
            cursor: pointer;
            list-style: none outside none;
            background-color: #DFDFDF;
        }

        .greenImg{
            width: 40px;
            height: 40px;
            position: absolute;
        }
        .smallGreenButton{
            width: 32px;
            height: 32px;
            background: none;
            border-width: 1px;
            border-style: solid;
            border-color: #00BFA5;
            position: absolute;
            font-size: 20px;
            color: #00BFA5;
        }

        .bigGreenButton{
            width: 64px;
            height: 32px;
            background: none;
            border-width: 1px;
            border-style: solid;
            border-color: #00BFA5;
            position: absolute;
            font-size: 14px;
        }

        .screenImg{
            width: 60px;
            height: 46px;
            position: absolute;
        }

        .downImg{
            width: 46px;
            height: 46px;
            position: absolute;
        }
    </style>
</head>
<body>
<div>
    <div style="position: absolute;left: 1460px;font-size: 18px">监控区域</div><br><br>
    <div id="div-tree" class="content-default" style="height: 250px; width: 226px; float: right;background-color: transparent">
        <div id="tree-wrap" style="height: 250px; overflow: auto; border: 1px; border-radius: 3px;min-height: 250px;">
            <div class="zTreeDemoBackground right">
                <ul id="tree-content" class="ztree"></ul>
            </div>
        </div>
    </div>
    <div style="float: right;border: 1px solid #ccc; border-radius: 3px;height: 90%;margin-right: 5px;overflow-y: auto;">
        <div id="divPlugin" class="plugin"></div>
    </div>
    <div style="position: absolute;left: 1470px;top: 360px;font-size: 18px">云台控制</div><br>
    <div style="width: 250px;height: 360px;position: absolute;left: 1460px;top: 400px">
        <img src="${ctx}/static/hkImage/left-up.svg" class="greenImg" style="top: 10px;left: 10px" onclick="PTZControl(5)">
        <img src="${ctx}/static/hkImage/up.svg" class="greenImg" style="top: 10px;left: 60px" onclick="PTZControl(1)">
        <img src="${ctx}/static/hkImage/right-up.svg" class="greenImg" style="top: 10px;left: 110px" onclick="PTZControl(7)">
        <img src="${ctx}/static/hkImage/left.svg" class="greenImg" style="top: 60px;left: 10px" onclick="PTZControl(3)">
        <img src="${ctx}/static/hkImage/auto.svg" class="greenImg" style="top: 60px;left: 60px" onclick="PTZControl(9)">
        <img src="${ctx}/static/hkImage/right.svg" class="greenImg" style="top: 60px;left: 110px" onclick="PTZControl(4)">
        <img src="${ctx}/static/hkImage/left-down.svg" class="greenImg" style="top: 110px;left: 10px" onclick="PTZControl(6)">
        <img src="${ctx}/static/hkImage/down.svg" class="greenImg" style="top: 110px;left: 60px" onclick="PTZControl(2)">
        <img src="${ctx}/static/hkImage/right-down.svg" class="greenImg" style="top: 110px;left: 110px" onclick="PTZControl(8)">
        <button class="smallGreenButton" style="top: 180px;left: 10px" onclick="PTZZoomout()">-</button>
        <button class="bigGreenButton" style="top: 180px;left: 48px" disabled: disabled>变倍</button>
        <button class="smallGreenButton" style="top: 180px;left: 118px" onclick="PTZZoomIn()">+</button>
        <button class="smallGreenButton" style="top: 218px;left: 10px" onclick="PTZFoucusOut()">-</button>
        <button class="bigGreenButton" style="top: 218px;left: 48px" disabled: disabled>变焦</button>
        <button class="smallGreenButton" style="top: 218px;left: 118px" onclick="PTZFocusIn()">+</button>
        <button class="smallGreenButton" style="top: 256px;left: 10px" onclick="PTZIrisOut()">-</button>
        <button class="bigGreenButton" style="top: 256px;left: 48px" disabled: disabled>光圈</button>
        <button class="smallGreenButton" style="top: 256px;left: 118px" onclick="PTZIrisIn()">+</button>
    </div>
</div>
<div class="container">
    <div class="row">
        <%--<div class="dropdown" style="margin-left: 1px;margin-top: 1px;">--%>
            <%--<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="margin-left: 5px;margin-top: 1px;"> 窗口分割数 <span class="caret"></span>--%>
            <%--</button><!--btn-default默认颜色-->--%>
            <%--<ul class="dropdown-menu">--%>
                <%--<li><a href="#" onclick="changeWndNum(1);">1x1</a></li>--%>
                <%--<li><a href="#" onclick="changeWndNum(2);">2x2</a></li>--%>
                <%--<li><a href="#" onclick="changeWndNum(3);">3x3</a></li>--%>
                <%--<li><a href="#" onclick="changeWndNum(4);">4x4</a></li>--%>
            <%--</ul>--%>
        <%--</div>--%>
            <img id="screen1" src="${ctx}/static/hkImage/1screen.svg" class="screenImg" style="top: 810px;left: 150px" onclick="changeWndNum(1)">
            <div style="width: 30px;height: 15px;position: absolute;top: 860px;left: 166px">全屏</div>
            <img id="screen4" src="${ctx}/static/hkImage/4screen.svg" class="screenImg" style="top: 810px;left: 250px" onclick="changeWndNum(2)">
            <div style="width: 36px;height: 15px;position: absolute;top: 860px;left: 264px">4分屏</div>
            <img id="screen9" src="${ctx}/static/hkImage/9screenL.svg" class="screenImg" style="top: 810px;left: 350px" onclick="changeWndNum(3)">
            <div style="width: 36px;height: 15px;position: absolute;top: 860px;left: 364px">9分屏</div>
            <img id="screen16" src="${ctx}/static/hkImage/16screen.svg" class="screenImg" style="top: 810px;left: 450px" onclick="changeWndNum(4)">
            <div style="width: 45px;height: 15px;position: absolute;top: 860px;left: 458px">16分屏</div>

            <img id="catchP" src="${ctx}/static/hkImage/catchP.svg" style="width: 56.6px;height: 46px;position: absolute;top: 810px;left: 580px" onclick="clickCapturePic()">
            <div style="width: 30px;height: 15px;position: absolute;top: 860px;left: 596px">抓图</div>
            <img id="startVideoTape" src="${ctx}/static/hkImage/startVideoTape.svg" class="downImg" style="top: 810px;left: 670px" onclick="clickStartRecord()">
            <div style="width: 60px;height: 15px;position: absolute;top: 860px;left: 670px">开始录像</div>
            <img id="stopVideoTape" src="${ctx}/static/hkImage/stopVideoTape.svg" class="downImg" style="top: 810px;left: 750px" onclick="clickStopRecord()">
            <div style="width: 60px;height: 15px;position: absolute;top: 860px;left: 750px">停止录像</div>
            <img id="stopVideo" src="${ctx}/static/hkImage/stopVideo.svg" class="downImg" style="top: 810px;left: 830px" onclick="clickStopRealPlay()">
            <div style="width: 60px;height: 15px;position: absolute;top: 860px;left: 830px">关闭视频</div>
    </div>
</div>
<div id="rMenu">
    <ul>
        <li id="m_record" onclick="showPicture();">抓拍记录</li>
    </ul>
</div>
<div id="show-picture"></div>
<div id="error-div"></div>
<script type="text/javascript" src="${ctx}/static/video-player/js/hik-player.js"></script>
<script type="text/javascript">
    var ctx = "${ctx}";
    var orgId = "${param.projectId}";
    if (orgId == "") {
        orgId = $("#login-org").data("orgId");
    }
    var videoListManageData = {
        deviceId: null,
        pictureData: new Array
    };
    $(document).ready(function () {
        $.ajax({
            type: "post",
            url: "${ctx}/device/manage/queryHikTree?CHECK_AUTHENTICATION=false&projectCode="+projectCode,
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                $.fn.zTree.init($("#tree-content"), {
                    data: {
                        simpleData: {enable: true}
                    },
                    callback: {
                        beforeExpand: zTreeBeforeExpand,
                        onExpand: zTreeOnExpand,
                        onDblClick: onClick,
                        onRightClick: zTreeOnRightClick
                    }
                }, data);
            },
            error: function (req, error, errObj) {
                showDialogModal("error-div", "操作错误", "初始化功能数据失败！");
            }
        });
        resize();
    });

    $(window).resize(function () {
        resize();
    });

    function resize() {
        var treeMinHeight = $(document.body).height() - 96 - 30 - 40;
        $("#tree-wrap").css("minHeight", treeMinHeight);
        $("#div-content").css("minHeight", $("#div-tree").outerHeight());
    };

    function onClick(event, treeId, treeNode) {
        if (treeNode.treeLevel != 1) {
            clickStartRealPlay(treeNode.channel);
        }
    };
    var curExpandNode = null;

    function zTreeBeforeExpand(treeId, treeNode) {
        var pNode = curExpandNode ? curExpandNode.getParentNode() : null;
        var treeNodeP = treeNode.parentTId ? treeNode.getParentNode() : null;
        var zTree = $.fn.zTree.getZTreeObj("tree-content");
        for (var i = 0, l = !treeNodeP ? 0 : treeNodeP.children.length; i < l; i++) {
            if (treeNode !== treeNodeP.children[i]) {
                zTree.expandNode(treeNodeP.children[i], false);
            }
        }
        while (pNode) {
            if (pNode === treeNode) {
                break;
            }
            pNode = pNode.getParentNode();
        }
        if (!pNode) {
            singlePath(treeNode);
        }
    };

    function singlePath(newNode) {
        if (newNode === curExpandNode) return;

        var zTree = $.fn.zTree.getZTreeObj("tree-content"),
            rootNodes, tmpRoot, tmpTId, i, j, n;

        if (!curExpandNode) {
            tmpRoot = newNode;
            while (tmpRoot) {
                tmpTId = tmpRoot.tId;
                tmpRoot = tmpRoot.getParentNode();
            }
            rootNodes = zTree.getNodes();
            for (i = 0, j = rootNodes.length; i < j; i++) {
                n = rootNodes[i];
                if (n.tId != tmpTId) {
                    zTree.expandNode(n, false);
                }
            }
        } else if (curExpandNode && curExpandNode.open) {
            if (newNode.parentTId === curExpandNode.parentTId) {
                zTree.expandNode(curExpandNode, false);
            } else {
                var newParents = [];
                while (newNode) {
                    newNode = newNode.getParentNode();
                    if (newNode === curExpandNode) {
                        newParents = null;
                        break;
                    } else if (newNode) {
                        newParents.push(newNode);
                    }
                }
                if (newParents != null) {
                    var oldNode = curExpandNode;
                    var oldParents = [];
                    while (oldNode) {
                        oldNode = oldNode.getParentNode();
                        if (oldNode) {
                            oldParents.push(oldNode);
                        }
                    }
                    if (newParents.length > 0) {
                        zTree.expandNode(oldParents[Math.abs(oldParents.length - newParents.length) - 1], false);
                    } else {
                        zTree.expandNode(oldParents[oldParents.length - 1], false);
                    }
                }
            }
        }
        curExpandNode = newNode;
        clickLogout(newNode);
        clickLogin(newNode);
    };

    function zTreeOnExpand(event, treeId, treeNode) {
        curExpandNode = treeNode;
    };

    function zTreeOnRightClick(event, treeId, treeNode) {
        if (treeNode.treeLevel != 1) {
            var zTree = $.fn.zTree.getZTreeObj("tree-content");
            if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
                zTree.cancelSelectedNode();
                showRMenu("root", event.clientX, event.clientY);
            } else if (treeNode && !treeNode.noR) {
                zTree.selectNode(treeNode);
                showRMenu("node", event.clientX, event.clientY);
            }
        }
    };

    function showRMenu(type, x, y) {
        var rMenu = $("#rMenu");
        $("#rMenu ul").show();
        if (type == "root") {
            $("#m_record").hide();
        } else {
            $("#m_record").show();
        }

        y += document.body.scrollTop - 30;
        x += document.body.scrollLeft - 200;
        rMenu.css({"top": y + "px", "left": x + "px", "visibility": "visible"});

        $("body").bind("mousedown", onBodyMouseDown);
    };

    function onBodyMouseDown(event) {
        var rMenu = $("#rMenu");
        if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
            rMenu.css({"visibility": "hidden"});
        }
    };

    function showPicture() {
        var zTree = $.fn.zTree.getZTreeObj("tree-content");
        var nodes = zTree.getSelectedNodes();
        videoListManageData.deviceId = nodes[0].id;
        createModalWithLoad("show-picture", 800, 650, "场景抓拍历史记录", "videoManage/showPicture?CHECK_AUTHENTICATION=false", "", "", "");
        jQuery("#show-picture-modal").css("z-index", 200);
    }

</script>
</body>
</html>
