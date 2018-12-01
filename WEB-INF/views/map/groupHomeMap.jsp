<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
	body, html{width: 100%;height: 100%;}
	#projectmap {height: 800px;width:100%;}
	 .baidu-maps label {
	  max-width: none;
	} 
	</style>
	
	<link href="${ctx}/static/groupMap/adv_search.css" type="text/css" rel="stylesheet" />
	<link href="${ctx}/static/groupMap/SearchInfoWindow_min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/static/groupMap/SearchInfoWindow_min.js"></script>
	<title>百度地图</title>
</head>
<body>
	<div id="projectmap" class="baidu-maps"></div>
	
	<div class="advancedSearch">
		<div>
			<span class="advancedSearch_left">
				<label style="display: block;" class="advancedSearch_left_label" for="txtSearchValue">
					请输入工程名称</label>
				<input id="txtSearchValue" class="advancedSearch_input" value="" type="text">
			</span><span onclick="searchForMap();" class="advancedSearch_right"><span class="advancedSearch_button icon-advancedSearch_button"></span></span>
		</div>
	</div>
	
	<div id="topSearch" class="advancedSearchDiv" style="width: 275px; top: 80px; right: 20px; z-index: 96;">
        <div style="float: right;" id="closeSearch">
            <a href="javascript:closeSearch();" class="search-closeicon" style="font-size: 14px; position: relative; right: -10px;">×</a>
        </div>
        <div style="clear: both">
        </div>
        <div id="project_list">
        <div id="mapItem0" style="display: none;" class="img_position" title="双击定位到工程"  onc   onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div><div id="mapItem1" style="display: none;" class="img_position" title="双击定位到工程" onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div><div id="mapItem2" style="display: none;" class="img_position" title="双击定位到工程" onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div><div id="mapItem3" style="display: none;" class="img_position" title="双击定位到工程" onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div><div id="mapItem4" style="display: none;" class="img_position" title="双击定位到工程" onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div><div id="mapItem5" style="display: none;" class="img_position" title="双击定位到工程" onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div><div id="mapItem6" style="display: none;" class="img_position" title="双击定位到工程" onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div><div id="mapItem7" style="display: none;" class="img_position" title="双击定位到工程" onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div><div id="mapItem8" style="display: none;" class="img_position" title="双击定位到工程" onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div><div id="mapItem9" style="display: none;" class="img_position" title="双击定位到工程" onclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div>
    </div>
        <div id="noresultInfo" style="display: none;" class="panel-search-body search-closeicon">
                 	没有找到符合要求的工程，请重新搜索！
             </div>
         </div>

	<div id="mapItemTemplate" style="display: none;" class="img_position" title="双击定位到工程" ondblclick="dblclickProject(this)">
        <img src="${ctx}/static/groupMap/image/Normal.png" style="width: 15px; height: 20px; border-width: 0px;">
        <span style="font-family: 微软雅黑; width: 250px; height: 22px; padding-top: 3px; font-size: 14px; border-width: 0px; vertical-align: top;"></span>
    </div>
	
</body>
<script type="text/javascript">
var cur_projectId = $("#login-org").data("projectId");
var map=null;
var formerly_lng=null;
var formerly_lat=null;
$(function () {
    initMap();
    $("#txtSearchValue").keydown(function (e) {
        if (e.keyCode == 13) { //若按了enter键 则触发搜索事件
            e.preventDefault();
            searchForMap();
        }
    }).focus(function () {
        $(".advancedSearch_left_label").hide();
    }).blur(function () {
        if ($("#txtSearchValue").val() == "") {
            $(".advancedSearch_left_label").show();
        }
    });

    if ($("#txtSearchValue").val() != "") {
        $(".advancedSearch_left_label").hide();
    }

    $("ul.detail-ul").find("li").click(function () {
        var $this = $(this);
        var _index = $this.index();
        $this.addClass("cur").siblings().removeClass("cur");
        $("ul.item:eq(" + _index + ")").show().siblings("ul.item").hide();
    });

});

function initMap() {
    map = new BMap.Map("projectmap",{enableMapClick: false}); // 创建Map实例
    //console.log(map.getCenter());
    var myCity = new BMap.LocalCity();
    myCity.get(function (res) {
        map.centerAndZoom(res.center, 13);
    });
    //var point=new BMap.Point(res.center);
    //map.centerAndZoom(point,15);      // 初始化地图,用城市名设置地图中心点
    var myIcon = new BMap.Icon("${ctx}/static/groupMap/image/tuzi.gif", new BMap.Size(113, 113));
    var icon = new BMap.Icon("${ctx}/static/groupMap/image/qibiao.png", new BMap.Size(21, 21));
    current_icon = new BMap.Icon("${ctx}/static/groupMap/image/qibiao_red.png", new BMap.Size(21, 21));

    //map.panTo(point);
    //var overView = new BMap.OverviewMapControl();
    //var overViewOpen = new BMap.OverviewMapControl({isOpen:true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT});
    var ctrl_nav = new BMap.NavigationControl({
        anchor: BMAP_ANCHOR_TOP_LEFT,
        type: BMAP_NAVIGATION_CONTROL_LARGE,
        enableGeolocation: true,
        offset: new BMap.Size(10, 60)
    });

    //var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
    //map.addControl(overViewOpen);
    map.addControl(ctrl_nav);
    map.addControl(new BMap.MapTypeControl({
        mapTypes: [BMAP_NORMAL_MAP, BMAP_SATELLITE_MAP, BMAP_HYBRID_MAP],
        anchor: BMAP_ANCHOR_TOP_LEFT
    }));

    map.enableScrollWheelZoom();

    map.addEventListener("rightclick", function (e) {
        setLongitude(e.point.lng, e.point.lat);
        if (flag == 1) {
            addMarker(e.point, icon_label);
            flag = -1;
        }
    });

    //监听拖动
    map.addEventListener("dragend", function (e) {
        //installMap(map);
    });

    //监听缩放
    map.addEventListener("zoomend", function () {
        //alert("地图缩放至：" + this.getZoom() + "级");    
        //installMap(map);
    });
    
    var size = new BMap.Size(110, 10);
    map.addControl(new BMap.CityListControl({
        anchor: BMAP_ANCHOR_TOP_LEFT,
        offset: size,
        onChangeBefore: function(){
           //cur_zoom=map.getZoom();
           //cur_center=map.getCenter();
        	//map.setZoom(14);
       },
       onChangeAfter:function(){
         //alert('after');
    	  map.setZoom(13);
       }
    }));

    installMap(map);
}


function installMap(map) {
    $.ajax({
        type: 'post',
        url: '${ctx}/emMap/getAllMap',
        async: true,
        dataType: 'json',
        success: function (data) {
            if (data.OK == true) {
                var results = data.returnTarget;
                $.each(results, function (i, result) {
                	if(result.projectId==cur_projectId)
                		addMerchantMap(map, result, true);
                	else
                    	addMerchantMap(map, result, false);
                });
            } else {
                //showDialogModal("error-div", "操作错误", data.msg);
            }
        }
    });
}

function addMerchantMap(map, result, flag) {
    var poi = new BMap.Point(result.longitude, result.latitude);
    //map.centerAndZoom(poi, 15);
    var marker = new BMap.Marker(poi); //创建marker对象
  // marker.setIcon(new BMap.Icon("${ctx}/static/groupMap/image/"+result.icons, new BMap.Size(result.iconsWidth, result.iconsHeight)));
    //marker.enableDragging(); //marker可拖拽
    var content = '<div style="margin:0;line-height:20px;padding:2px;">' + result.content + '</div>';
    console.info(content);
    var title = result.title + '';
    marker.addEventListener("dragend", function () {
        var current_poi = marker.getPosition();
        setLongitude(current_poi.lng, current_poi.lat);
    });
    marker.addEventListener("click", function (e) {
        console.info(result);
        new BMapLib.SearchInfoWindow(map, content, {
            title: title, //标题
            width: result.panelWidth, //宽度
            height: result.panelHeight, //高度
            panel: result.id, //检索结果面板
            enableSendToPhone: false, //去除发送手机
            enableAutoPan: true, //自动平移
            searchTypes: [
                //BMAPLIB_TAB_SEARCH,   //周边检索
                //BMAPLIB_TAB_TO_HERE,  //到这里去
                //BMAPLIB_TAB_FROM_HERE //从这里出发
            ]
        }).open(marker);
    });
    var label = new BMap.Label(title, {
        offset: new BMap.Size(20, -10)
    });
    console.info(label);
    marker.setLabel(label);
    map.addOverlay(marker); //在地图中添加marker
    if (flag) {
        //marker.setAnimation(BMAP_ANIMATION_BOUNCE);
        map.panTo(poi);
    }
}

function findCurrentMarker(map, projectId) {
    $.ajax({
        type: 'post',
        url: '${ctx}/emMap/getCurrentMap',
        data: {
            projectId: projectId
        },
        async: true,
        dataType: 'json',
        success: function (data) {
            if (data.ok == true) {
                var result = data.returnTarget;
                if (result != null) {
                    var marker = findOverlayByCoord(map, result.longitude, result.latitude);
                    if (marker != null)
                        map.removeOverlay(marker);
                    addMerchantMap(map, result, true);
                    formerly_lng = result.longitude;
                    formerly_lat = result.latitude;
                }
            }
        }
    });
}

function findOverlayByCoord(map, lng, lat) {
    var allOverlay = map.getOverlays();
    var marker = null;
    for (var i = 0; allOverlay != null && i < allOverlay.length; i++) {
        if (allOverlay[i].getPosition().lng == lng && allOverlay[i].getPosition().lat == lat) {
            marker = allOverlay[i];
        }
        if (allOverlay[i].getPosition().lng == formerly_lng && lng && allOverlay[i].getPosition().lat == formerly_lat) {
            allOverlay[i].setAnimation(null);
        }
    }
    return marker;
}


function searchForMap() {
    searchProject($("#txtSearchValue").val());
}

//查找工程
function searchProject(value) {
    $("#noresultInfo").hide();
    openSearchDiv();
    $.ajax({
        type: 'get',
        url: '${ctx}/emMap/filterProject',
        data: {
            keyword: value
        },
        async: true,
        dataType: 'json',
        success: function (json) {
            if (json != null && json.length > 0) {
                var mapItem = null;
                var minHideIndex = 0;
                var proInfo = null;
                $.each(json, function (i, data) {
                    mapItem = $("#mapItem" + i);
                    proInfo = mapItem.find("span");
                    proInfo.text(data.title);
                    mapItem.attr("projectId", data.projectId);
                    if (data.longitude == "" || data.latitude == "") {
                        mapItem.css("cursor", "");
                        mapItem.attr("allowLocate", "false");
                        mapItem.attr("title", "项目名称：" + $.trim(data.title) + "\n该工程未标注坐标，无法定位");
                    } else {
                        mapItem.css("cursor", "pointer");
                        mapItem.attr("allowLocate", "true");
                        mapItem.attr("longitude", data.longitude);
                        mapItem.attr("latitude", data.latitude);
                        mapItem.attr("title", data.title);
                        mapItem.attr("title", "项目名称：" + $.trim(data.title) + "\n双击定位到工程");
                    }
                    mapItem.show();
                    minHideIndex = i + 1;

                });
                hideProjects(minHideIndex);
            } else {
                $("#noresultInfo").show();
                hideProjects();
            }
        }
    });
}


function hideProjects(index) {
    if (index == null || index == undefined) {
        index = 0;
    }

    while (index < 10) {
        $("#mapItem" + index).hide();
        index++;
    }
}

//双击工程
function dblclickProject(mapItem) {
    var mapItem = $(mapItem);
    if (mapItem.attr("allowLocate") == "false") {
        return;
    }
    var actuallongitude = parseFloat(mapItem.attr("longitude"), 10);
    var actuallatitude = parseFloat(mapItem.attr("latitude"), 10);
    var point = new BMap.Point(actuallongitude, actuallatitude);
    //map.centerAndZoom(point, 14);
    map.panTo(point);
    //$("#project_list").css("display","none");
   // $("#topSearch").css("display","none");
    closeSearch()
}

/*打开高级搜索框*/
function openSearchDiv() {
    var topsearch = $("#topSearch");
    if (topsearch.css("display") == "none") {
        topsearch.show(300);
    }
}

/*关闭高级搜索框*/
function closeSearch() {
    $("#topSearch").hide(200);

}
	
</script>
</html>