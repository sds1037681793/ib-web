<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<title>地图展示</title>
 <style type="text/css">
	body, html{width: 100%;height: 100%;}
	#allmap {height: 100%;width:100%;overflow:hidden;}
	 label {
	  max-width: none;
	}
	.BMap_cpyCtrl span {
	    display: none;
	}  
	</style> 
	<!-- <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=B9T26e32mYcYMzs6LzRuGHKHrWCf9q3Y"></script> -->
	<link href="${ctx}/static/groupMap/adv_search.css" type="text/css" rel="stylesheet" />
	<link href="${ctx}/static/groupMap/SearchInfoWindow_min.css" type="text/css" rel="stylesheet" />
	<%-- <script type="text/javascript" src="${ctx}/static/groupMap/SearchInfoWindow_min.js"></script> --%>
</head>
<body>
	<div>
	<input id="longitude" name="longitude" placeholder="经度" class="form-control required" style="width:150px" type='hidden'/>
	<input id="latitude" name="latitude" placeholder="纬度" class="form-control required" style="width:150px" type='hidden'/>
	
	</div>
	<div class="advancedSearch">
		<div>
			<span class="advancedSearch_left">
				<!-- <label id="searchLabel" style="display: block;" class="advancedSearch_left_label" for="txtSearchValue">
					请输入小区名称</label> -->
				<input id="txtLocSearchValue" class="advancedSearch_input form-control" value="请输入小区名称" type="text">
			</span><span onclick="searchForLocation();" class="advancedSearch_right"><span class="advancedSearch_button icon-advancedSearch_button"></span></span>
		</div>
	</div>
	<div style="width: 100%;padding-left: auto;padding-right: auto;">
	<div id="drag" >
	
		<allmap class="content" display="block">
			<div id="f_container" >
			
				<div id="container" >
				 </div>
			</div>
			<div id="allmap"  style="width:660px;height:444px;overflow:hidden;"></div>
			
		</div>
	</div>
</div>
	
	
</body>
<script type="text/javascript">
 
var title=null;
var flag=-1;//0禁用  1开启新增
var lng=120.171179;
var lat=30.274788;
var	map =null;
var cur_result=null;
var cityNameLoc;
$(function(){
	loadJScript();
	$("#txtLocSearchValue").focus(function(){
		$("#txtLocSearchValue").attr("value","");
	});
	
	$("#txtLocSearchValue").blur(function(){
		if($("#txtLocSearchValue").val().trim()==""||$("#txtLocSearchValue").val().trim()=="[]"){
			$("#txtLocSearchValue").attr("value","请输入项目名称");
		}
	});
});

function loadJScript() {
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = "http://api.map.baidu.com/api?v=2.0&ak=B9T26e32mYcYMzs6LzRuGHKHrWCf9q3Y&callback=initMap"; 
	document.body.appendChild(script);
	script.type = "text/javascript";
	script.src = "${ctx}/static/groupMap/SearchInfoWindow_min.js"; 
	document.body.appendChild(script);
}

function searchForLocation(){
	 var searchValue=$("#txtLocSearchValue").val().trim();
	 if(searchValue==""||searchValue=="请输入项目名称"){
		 return;
	 }
	 if(cityNameLoc=="undefined"){
		 cityNameLoc="";
	 }
	 var local = new BMap.LocalSearch(map, {      
	      renderOptions:{map: map}      
	});      
	local.search(searchValue);
}


function initMap(){
	if(tbOrgs.row("${param.rowIndex}").id>0){
		findCurrentPoint();
	}
	
	map =new BMap.Map("allmap",{enableMapClick:false});  // 创建Map实例
   
 	//如果有坐标就定位到坐标，如果没有坐标，则是当前城市
	if(cur_result==null){
		var myCity = new BMap.LocalCity();
		myCity.get(function(res,result){
			map.centerAndZoom(res.center,13);
			cityNameLoc = result.name;
		});
		
	}else{
	
		map.centerAndZoom(new BMap.Point(cur_result.longitude,cur_result.latitude),13);
		addMerchantMap(map,cur_result);	
		 
	}
	
	//地图平移缩放控件
	var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
	map.addControl(ctrl_nav);
	//地图类型控件
	map.addControl(new BMap.MapTypeControl({mapTypes: [BMAP_NORMAL_MAP,BMAP_SATELLITE_MAP,BMAP_HYBRID_MAP ]}));
	// 启用滚轮放大缩小,默认禁用
	map.enableScrollWheelZoom();
	//添加监听事件，右键，
	map.addEventListener("rightclick", function(e){
	
		
		
		if(cur_result==undefined&&flag==-1){
			setLongitude(e.point.lng,e.point.lat);
			addMarker(e.point);
    		flag=1;
		};
		
		
	});
	
	//监听拖动
	map.addEventListener("dragend", function(e){    
		//installMap(map);
	});
	
	//监听缩放
	map.addEventListener("zoomend", function(){    
	 	//alert("地图缩放至：" + this.getZoom() + "级");    
		//installMap(map);
	});
	
	var size = new BMap.Size(70, 10);
    map.addControl(new BMap.CityListControl({
        anchor: BMAP_ANCHOR_TOP_LEFT,
        offset: size,
        onChangeBefore: function(){
        	//map.clearOverlays();
			//map.isClearMap = true;
       },
       onChangeAfter:function(){
    	   //map.setZoom(13);
    	  // map.isClearMap = false;
       }
    }));
 
}

 function addMarker(point){
	var marker = new BMap.Marker(point);
	map.addOverlay(marker);
	marker.enableDragging();
	marker.addEventListener("dragend", function(){ 
		point=marker.getPosition();
		setLongitude(point.lng,point.lat);
	});
} 

function setLongitude(lng,lat) {
	$("#longitude").val(lng);
	$("#latitude").val(lat);
	//$("#position").val(lng+","+lat);
};


function findCurrentPoint(){
	var row = tbOrgs.row("${param.rowIndex}");
	
	$.ajax({  
		type:'post',  
		url:'${ctx}/system/projectMap/getCurrentMap',
		data:{projectId:row.id},  
	    async: false,  
	    dataType:'json',  
	    success:function(data){
    	 	 if(data.CODE=="SUCCESS"){
				cur_result=data.RETURN_PARAM.ReturnTarget;
				
				if(cur_result==null){
					//flag=1;
					$("#longitude").val("");
					$("#latitude").val("");
					}else{
						$("#longitude").val(cur_result.longitude);
						$("#latitude").val(cur_result.latitude);
						
						}
				
			} 
     	}  
	}); 
}

function addMerchantMap(map,result){
	var poi=new BMap.Point(result.longitude, result.latitude);
    var marker = new BMap.Marker(poi); //创建marker对象
	//marker.setIcon(new BMap.Icon("${ctx}/static/map/image/"+result.icons, new BMap.Size(result.iconsWidth, result.iconsHeight)));
    marker.enableDragging(); //marker可拖拽
    var content='<div style="margin:0;line-height:20px;padding:2px;">' +result.content+'</div>';
    var title=result.title+'';
    marker.addEventListener("dragend", function(){ 
		var current_poi=marker.getPosition();
		setLongitude(current_poi.lng,current_poi.lat);
	});
    marker.addEventListener("click", function(e){
    	 new BMapLib.SearchInfoWindow(map,content , {
 			title  : title,      //标题
 			width  : result.panelWidth,   //宽度
 			height : result.panelHeight,  //高度
 			panel  : result.id, //检索结果面板
 			enableSendToPhone:false,//去除发送手机
 			enableAutoPan : true,     //自动平移
 			searchTypes   :[
 				//BMAPLIB_TAB_SEARCH,   //周边检索
 				//BMAPLIB_TAB_TO_HERE,  //到这里去
 				//BMAPLIB_TAB_FROM_HERE //从这里出发
 			]
 		}).open(marker);
    });
    var label=new BMap.Label(title,{offset:new BMap.Size(20,-10)});
	marker.setLabel(label);
    map.addOverlay(marker); //在地图中添加marker
    map.panTo(poi); 
  
  
 // map.reset();
}


function saveOrganizeMap(){
	var row = tbOrgs.row("${param.rowIndex}");
	var lon=  $("#longitude").val();
	 var la =$("#latitude").val();
	 
	 var  pmMap = {};
	
		if (typeof(lon) != "undefined" && lon != ""){
			$(pmMap).attr({"longitude": lon});
		}
		if (typeof(la) != "undefined" && la != ""){
			$(pmMap).attr({"latitude": la});
		}
		 if(cur_result!=null){
			 var id = cur_result.id;
			 if (typeof(id) != "undefined" && id != ""){
					$(pmMap).attr({"id": id});
				}

		 }
		if (typeof (row.organizeName) != "undefined" && row.organizeName != ""){
			$(pmMap).attr({"title": row.organizeName});
		}
		
		if (typeof (row.id) != "undefined" && row.id != ""){
			$(pmMap).attr({"projectId": row.id});
		}
		if(cur_result==undefined&&lon==""&&la=="" ){
			 showDialogModal("error-div", "操作错误",  "坐标不能为空");
			 return;
			}
	$.ajax({
       type:"post",
       url:"${ctx}/system/projectMap/saveCurrentMap",
       async:false,
       data:JSON.stringify(pmMap),
       dataType:'json',
       contentType: "application/json;charset=utf-8",
       success:function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				$("#ext-operation-div-modal").modal('hide');
				tbOrgs.load();
				return true;
			} else {
				showDialogModal("error-div", "操作提示", " 操作失败");
				return false;
			}
		},
		error: function(req,error,errObj) {
			showDialogModal("error-div", "操作提示", " 操作失败");
			return false;		
		}




		}); 

	}
</script>
</html>