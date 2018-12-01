/**
 * 
 */

function getLeftValueById(id){
	var pic_vip = document.getElementById(id);
	var picVipOldLeftPx = window.getComputedStyle(pic_vip, null).getPropertyValue("left");//获取小图片的css的left属性 例如1180px;
	var picVipOldLeft = picVipOldLeftPx.replace("px","");//例如获取结果为1180 用来计算 大图被拖动后的小图片left值
	return picVipOldLeft;
}

//通过ids来获取这个ids的left属性
//参数 array()  ids  例如 ids=array("pic_vip","pic_camera01");
function getLeftValueListByIds(ids){
	var idLeftValueList = new Array();
	for(var i=0;i<ids.length;i++){
		idLeftValueList[ids[i]] = getLeftValueById(ids[i]);
	}
	return idLeftValueList;
}

//用来重新定位 大图上的元素
//参数 array() idLeftValueList 例如 idLeftValueList = array("pic_vip"=>1180,"pic_camera01"=>804)
//参数 offsets 偏移量（要减去的）
function repositionLeft(idLeftValueList,offsets){
	for(i in idLeftValueList){
		$("."+i).css({left:(idLeftValueList[i]-offsets)});
	}
}

function showMenu(code, ctxpath,hasHistoryPic){
	if($("#accessMonitoring"+code) && $("#accessMonitoring"+code).length > 0){
		$(".access-monitoring-menu").remove();
		return;
	} else {
		$(".access-monitoring-menu").remove();
		setTimeout("closeMenu("+code+")",3000);
	}
	var cameraWidth = 27;
	var cameraHeight = 30;
	var left = $('#camera'+code).parent().offset().left;
	var top = $('#camera'+code).parent().offset().top;
	
	var menuTop = top + cameraHeight + 10;
	
	var menuLeft = left + cameraWidth/2 - 75;
	var val = $("#camera"+code).attr("src");
	if(typeof(val) != "undefined" && val.indexOf("camera02")!=-1){
		var str="<div class = 'access-monitoring-menu' id='accessMonitoring"+code+"' style='background-image: url(\""+ctxpath+"/static/img/access-control/Rectangle7.png\");width:150px;height:30px;z-index:2;box-shadow: 0 6px 12px rgba(0,0,0,.175);'>"
		+ '<span class="popover_text"  style="font-size: 12px;color: #FFFFFF;line-height:30px;margin-left:8px">摄像机离线，请尽快处理</span>'
		+ "</div>";
	}else{
		var str="<div class = 'access-monitoring-menu' id='accessMonitoring"+code+"' style='background-image: url(\""+ctxpath+"/static/img/access-control/choose.png\");width:150px;height:30px;z-index:2;box-shadow: 0 6px 12px rgba(0,0,0,.175);'>"
		+ '<span class="popover_text" onClick="checkVideo(' + code + ')"  style="font-size: 12px;color: #FFFFFF;line-height:30px;margin-left:18px">实时监控</span>'
		if(hasHistoryPic){
			str += '<span class="popover_text" onClick="checkPicture(' + code + ')" style="font-size: 12px;color: #FFFFFF;margin-left:18px">历史照片</span>';
		}else{
			str += '<span class="popover_text" style="font-size: 12px;color: #FFFFFF;margin-left:18px;cursor:default;">抓拍未开启</span>'
		}
		str += "</div>";
	}

	

	
	$('#camera'+code).parent().parent().parent().append(str);
	
	$("#accessMonitoring"+code).offset({top:menuTop,left:menuLeft});
	//$(".access-monitoring-menu").offset({top:menuTop,left:menuLeft});
}

function closeMenu(code){
	$("#accessMonitoring"+code).remove();
}










