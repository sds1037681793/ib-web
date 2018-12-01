function oneFloorHoverShow(){
	$(".oneFloorHover").show();
}
function oneFloorHoverHide(){
	$(".oneFloorHover").hide();
}
function threeFloorHoverShow(){
	$(".threeFloorHover").show();
}
function threeFloorHoverHide(){
	$(".threeFloorHover").hide();
}
function gFloorHoverShow(){
	$(".gFloorHover").show();
}
function gFloorHoverHide(){
	$(".gFloorHover").hide();
}

function floorAlarm(floor){
	if(floor !=null && floor!= ''){
		if(floor.indexOf("3F")> -1||floor.indexOf("3楼") > -1 ||floor.indexOf("3层") > -1){
			$(".threeFloorAlarm").show();
		}else if(floor.indexOf("1F")> -1 || floor.indexOf("1楼")> -1 || floor.indexOf("1层")> -1){
			$(".oneFloorAlarm").show();
		}else if(floor.indexOf("G")> -1 || floor.indexOf("G层")> -1||floor.indexOf("夹层")||floor.indexOf("消控")> -1){
			$(".basementAlarm").show();
			$(".gFloorAlarm").show();
		}
	}
}


function floorAlarmClose(floor){
	if(floor !=null && floor!= ''){
		if(floor.indexOf("13")> -1){
			$(".threeFloorAlarm").hide();
		}else if(floor.indexOf("11")> -1){
			$(".oneFloorAlarm").hide();
		}else if(floor.indexOf("10")> -1){
			$(".basementAlarm").hide();
			$(".gFloorAlarm").hide();
		}
	}
}


function floorAlarmLocation(floor){
	if(floor !=null && floor!= ''){
		if(floor.indexOf("13")> -1){
			$(".threeFloorAlarm").show();
		}else if(floor.indexOf("11")> -1){
			$(".oneFloorAlarm").show();
		}else if(floor.indexOf("10")> -1){
			$(".basementAlarm").show();
			$(".gFloorAlarm").show();
		}
	}
}

function goOtherVR(otherFloor){
	//$("[name='floorBack']").hide();
	$("[name='floorBack']").css("z-index","-1");
	$("[name='selectfloor']").css("background", "rgba(9,162,221,0.40)");
	$("[name='selectfloor']").css("border", "1px solid rgba(86,228,255,0.40)");
	$("[name='selectfloor'] span").css("opacity", "0.4");
	showFloor(otherFloor);
}
function showFloor(otherFloor){
	if(otherFloor =='3F'){
		$("#selectThreeFloor").css("background", "rgba(9,162,221,0.60)");
		$("#selectThreeFloor").css("border", "1px solid rgba(86,228,255,0.60)");
		$("#selectThreeFloor span").css("opacity", "0.8");
		//$(".threeBack").show();
		$(".threeBack").css("z-index","1");
	}else if(otherFloor =='1F'){
		$("#selectOneFloor").css("background", "rgba(9,162,221,0.60)");
		$("#selectOneFloor").css("border", "1px solid rgba(86,228,255,0.60)");
		$("#selectOneFloor span").css("opacity", "0.8");
		//$(".oneBack").show();
		$(".oneBack").css("z-index","1");
	}else if (otherFloor =='G'){
		$("#selectGFloor").css("background", "rgba(9,162,221,0.60)");
		$("#selectGFloor").css("border", "1px solid rgba(86,228,255,0.60)");
		$("#selectGFloor span").css("opacity", "0.8");
		//$(".gOneBack").show();
		$(".gOneBack").css("z-index","1");
	}else if(otherFloor =='B1'){
		$("#selectBFloor").css("background", "rgba(9,162,221,0.60)");
		$("#selectBFloor").css("border", "1px solid rgba(86,228,255,0.60)");
		$("#selectBFloor span").css("opacity", "0.8");
		//$(".bOneBack").show();
		$(".bOneBack").css("z-index","1");
	}
}
function goBack(){
	//window.history.back();
	$("#floorVrJsp").fadeOut(1500);
	$("#systemMainJsp").fadeIn(1500);

}
function floorVR(floor){
	$("#systemMainJsp").fadeOut(1500);
	$("#floorVrJsp").fadeIn(1500);
	goOtherVR(floor);
	//window.location=ctx + "/projectPage/floorVR?floor="+floor+"&projectCode="+projectCode+"&projectId="+projectId;
	//window.open(ctx + "/projectPage/floorVR?floor="+floor);
}
function havcHoverShow(){
	$(".b1FloorBoilerHover").show();
}
function havcHoverHide(){
	$(".b1FloorBoilerHover").hide();
}
function parkingHoverShow(){
	$(".gFloorParkingHover").show();
}
function parkingHoverHide(){
	$(".gFloorParkingHover").hide();
}
function fireHoverShow(){
	$(".gFloorFireHover").show();
}
function fireHoverHide(){
	$(".gFloorFireHover").hide();
}
function supplyHoverShow(){
	$(".gFloorSupplyHover").show();
}
function supplyHoverHide(){
	$(".gFloorSupplyHover").hide();
}
//
/**
 * 项目URL处理
 * @url 请求链接
 */
function dealProjectUrl(code,projectCode){
	var url = "";
	$.ajax({
		type : "post",
		url : ctx + "/secFunctionProject/getProjectUrlByFunctionCode?functionCode="+code+"&projectCode="+projectCode,
		async : false,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				url = data.RETURN_PARAM;
			}
		},
		error : function(req, error, errObj) {
		}
	});
	return url;
}
function openBusiSystem(code){
	if(code =='ACCESS1'){
		createSimpleModalWithIframe("busi-system",1920,1080,dealProjectUrl("ACCESS-3D-FLOOR1",projectCode),"","","-1px","left");
		openModal("#busi-system-modal", false, false);
		hiddenScroller();
		$(".modal-dialog").css("transform", "none");
	}else if(code =='ACCESS3'){
		createSimpleModalWithIframe("busi-system",1920,1080,dealProjectUrl("ACCESS-3D-FLOOR3",projectCode),"","","-1px","left");
		openModal("#busi-system-modal", false, false);
		hiddenScroller();
		$(".modal-dialog").css("transform", "none");
	}else if(code =='HAVC'){
		createSimpleModalWithIframe("hvac_page",1920,1080,ctx +"/hvacRealTimeDataPage/hvacHotMapBOnePage?projectCode="+projectCode+"&projectId=" + projectId,"","","-1px","left");
		openModal("#hvac_page-modal", false, false);
		hiddenScroller();
		$(".modal-dialog").css("transform", "none");
	}else if(code =='PARKING'){
		createSimpleModalWithIframe("busi-system",1920,1080,dealProjectUrl("PARKING-3D-MONITORING",projectCode),"","","-1px","left");
		openModal("#busi-system-modal", false, false);
		hiddenScroller();
		$(".modal-dialog").css("transform", "none");
	}else if(code =='FIRE'){
		createSimpleModalWithIframe("busi-system",1920,1080,ctx + "/fireFightingManage/gFloorFiresManage?projectCode="+projectCode, "","","-1px","left");
		openModal("#busi-system-modal", false, false);
		hiddenScroller();
		$(".modal-dialog").css("transform", "none");
	}else if(code == 'SUPPLY'){
		createSimpleModalWithIframe("busi-system",1920,1080,ctx +"/psdMain/gPowerSupplyManage?projectCode="+projectCode+"&projectId=" + projectId,"","","-1px","left");
		openModal("#busi-system-modal", false, false);
		hiddenScroller();
		$(".modal-dialog").css("transform", "none");
	}
}