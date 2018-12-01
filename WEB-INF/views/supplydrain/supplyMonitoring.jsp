<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd HH:mm:ss" />
<!DOCTYPE html>
<html>
<head>
<link
	href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css"
	type="text/css" rel="stylesheet" />
<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<style type="text/css">
.li_style{
	height:40px;
	width:100%;
	text-align:center;
	line-height:40px;
	color:#666666;
	font-size:16px;
	font-family: PingFangSC-Regular;
}

a, a:hover, a:focus, a:link, a:visited{
	color:#666666;
}
	
.li_style_checked{
	height:40px;
	width:100%;
	text-align:center;
	line-height:40px;
	background-color:#99E5DB;
	color:#666666;
	font-size:16px;
	font-family: PingFangSC-Regular;
}

</style>
</head>
<body class="main_background" style="width: 100%; height: 100%;">
	<div style="width:9.4%;height: 894px;background-color:#FFFFFF;float:left;box-shadow: 5px  1px 1px 1px #888888; ">
		<ul style="width:100%" id="ul_location_list">
			<div id="li_fristLi" style="width:100%;height:60px;">
				<div style="float:left;width:20%;height:100%;padding-left:20px;padding-top:18px">
					<div style="width:4px;height:20px;background-color:#00BFA5;"></div>
				</div>
				<div style="float:left;height:100%;width:80%;    padding-right:17px;padding-top:7px">
					<div><span style="font-family: PingFangSC-Medium;font-size: 20px;color: #00BFA5;letter-spacing: 0;">给水</span></div>
				</div>
			</div>
		</ul>
	</div>
	<div id="supplyBox" style="width:1459px;height:897px; float:left;position: relative;">
	</div>
	<div id="div-supplyDeviceDetail"></div>
	<div id="error-div"></div>
	<script type="text/javascript">

	var lifeBengIcon =  "${ctx}/static/img/supply-drain/lifeBeng.svg";
	var stopBgColor = "#B4B4B4"; //停止运行状态颜色
	var normalBgColor = "#00BFA5";//正常状态颜色
	var faultBgColor= "#FA6900";//故障状态颜色
	var deviceDivBgColor = "#E7E7E7 ";//设备背景色
	var filePath;
	var ctx = "${ctx}";
	var openDetailDeviceId=0;
	var deviceObjData={};
	
		$(document).ready(function() {
			toSubscribe();
			  //初始化位置列表
			  initLocation();
			 
		});
		
		
		function buildRunDiv(data){
			$.each(data,function(i,val){
				hvacCoolDataDeal(val);
			});
		}
		
	
		//初始化位置列表(区域)
		function initLocation(){
			  $.ajax({
			        type : "post",
			        url : "${ctx}/device/manage/getLocationByCategoryAndProjectCode?projectCode="+projectCode+"&code=WATER_SUPPLY&locationType=2",
			        dataType : "json",
			        contentType : "application/json;charset=utf-8",
			        success : function(data) {
			        	debugger;
				        if( data.code==0&&data.data!=null){
				        	var result  = data.data;
				        	for(var i in result){
				        		var liContent= "<li onclick = 'changeLocationShowDeviceMap("+result[i].id+")' id="+result[i].id+" class='li_style'><a>"+result[i].locationName
				        		+"</a></li>";
					        	$("#ul_location_list").append(liContent);
				        	}
				        	
				        	//改变选中的地址
				        	changeLocationShowDeviceMap(result[0].id);
				        	
				        }else{
				        	$("#content-page").load("/ib-web/projectPage/noDataPage");
				        }
			        },
			        error : function(req,error, errObj) {
			            return;
			            }
			        });	
		}
		

		
		//切换地址,请求数据：地图和设备
		function changeLocationShowDeviceMap(locationId){
			//改变颜色
			$("#"+locationId).removeClass('li_style').addClass('li_style_checked');
      	  	$("#"+locationId).siblings().removeClass('li_style_checked').addClass('li_style');
			
			 $.ajax({
			        type : "post",
			        url : "${ctx}/device/manage/getDeviceLocationDTOByLocationId?projectId="+projectId+"&locationId="+locationId,
			        dataType : "json",
			        contentType : "application/json;charset=utf-8",
			        success : function(data) {
				        if( data.code==0&&data.data!=null){
				        		buildDiv(data.data);
				        }
			        },
			        error : function(req,error, errObj) {
			            return;
			            }
			        });	
		}
		
		//展示展示设备和地图上的设备
		function buildDiv(data){
			$("#supplyBox").html("");
		//	$("#supplyBox").css("background-image",'url('+data[0].pictureUrl+')');
			$("#supplyBox").css("background",'url('+data[0].pictureUrl+') no-repeat center');
			$.each(data,function(i,val){
				var srcImg;
				//给水设备类型
				if(val.catagory=='CONSTANT_PRESSURE_PUMP'){
				
					srcImg = lifeBengIcon;
					//生成界面位置
					var div ='<div onclick=openShowDeviceDetail("'+val.deviceNumber+'") style="left: '+val.coordinate.xCoordinate+'px; top:'+val.coordinate.yCoordinate+'px;width:200px;height:30px; position: absolute;">'
					+'<input style="display:none" id="ftStatus_'+val.deviceNumber+'"/><input style="display:none"  id="opStatus_'+val.deviceNumber+'"><input style="display:none"  value ="'+val.locationName+'" id="dLocation_'+val.deviceNumber+'">'
					+'<input style="display:none" id="dpType_'+val.deviceNumber+'" value="'+ val.supplyDeviceParam+'">'
					+'<input style="display:none" id="fa_'+val.deviceNumber+'" value="'+ val.supplyDeviceParam+'">'
					+'<input style="display:none" id="oa_'+val.deviceNumber+'" value="'+ val.supplyDeviceParam+'">'
					+'<input style="display:none" id="fb_'+val.deviceNumber+'" value="'+ val.supplyDeviceParam+'">'
					+'<input style="display:none" id="ob_'+val.deviceNumber+'" value="'+ val.supplyDeviceParam+'">'
					+'<div id=dNumber_'+val.deviceNumber+' style="background-color:'+normalBgColor +';width:30px;height:30px;float:left; line-height: 30px;text-align:center; "><img src ='+srcImg+' /></div>'
					+'<div style="background-color:#E7E7E7;width:70px;height:30px;float:left;text-align:center;line-height: 30px;""><font id="dName_'+val.deviceNumber+'">'+val.deviceName+'</font></div>'
					+'</div>';
					$("#supplyBox").append(div);
					  //设备状态
					
				}
			});
			getDeviceStatusInfo();
		}
		
		//获取设备状态信息(进入页面时查询)
		function getDeviceStatusInfo(){
			  $.ajax({
			        type : "post",
			        url : "${ctx}/supply-drain/supplyDrainMain/getSupplyDeviceStatusInfo?projectCode="+projectCode+"&systemCode=WATER_SUPPLY",
			        dataType : "json",
			        contentType : "application/json;charset=utf-8",
			        success : function(data) {
				        if( data.code==0&&data.data!=null){
				        	var result  = data.data;
				        	for(var i in result){
				        		$("#ftStatus_"+result[i].deviceCode).val(result[i].falutStatus);
				        		$("#opStatus_"+result[i].deviceCode).val(result[i].openStatus);
				        		//关闭状态
				        		if(result[i].openStatus ==2){
				        			$("#dNumber_"+result[i].deviceCode).css("background-color",stopBgColor);
				        		}
				        		//故障状态
				        		if(result[i].falutStatus==2){
				        			$("#dNumber_"+result[i].deviceCode).css("background-color",faultBgColor);
				        		}
				        		if(result[i].childDevices!=null){
				        			
				        			
				        			if(result[i].childDevices[0]!=null){
				        				$("#fa_"+result[i].deviceCode).val(result[i].childDevices[0].childFalutStatus);
						        		$("#oa_"+result[i].deviceCode).val(result[i].childDevices[0].childOpenStatus);
				        			}
				        			if(result[i].childDevices[1]!=null){
					        			$("#fb_"+result[i].deviceCode).val(result[i].childDevices[1].childFalutStatus);
					        			$("#ob_"+result[i].deviceCode).val(result[i].childDevices[1].childOpenStatus);
					        		}
				        		}
				        		
				        	}
				        }
			        },
			        error : function(req,error, errObj) {
			            return;
			            }
			        });		
		}
		//查看设备详情
		function openShowDeviceDetail(paramCode){
			
			var deviceName = $("#dName_"+paramCode).html();
			createDetailObjData(paramCode);
			
			createModalWithLoad("div-supplyDeviceDetail", 600,380, deviceName,
					"supplyDrain/supplyDeviceDetail", "", "", "");
			openModal("#div-supplyDeviceDetail-modal", true, false);
		}
		
		
		
		function updateWatersupplyPageInfo(json){
			updateDeviceInfo(json);
		}
		
		function toSubscribe(){
			if (isConnectedGateWay) {
				//给水页面识别结果
				stompClient.subscribe('/topic/watersupplyPageStatus/'+ projectCode, function(result) {
					var json = JSON.parse(result.body);
					console.log(json);
					updateWatersupplyPageInfo(json);
				});
			}
		}


		function unloadAndRelease() {
			if(stompClient != null) {
				stompClient.unsubscribe('/topic/watersupplyPageStatus/'+ projectCode);
			}
		}
		
		//更换页面数据
		function updateDeviceInfo(data){
			var result  = data;
        	for(var i in result){
        		$("#ftStatus_"+result[i].deviceCode).val(result[i].falutStatus);
        		$("#opStatus_"+result[i].deviceCode).val(result[i].openStatus);
        		$("#dNumber_"+result[i].deviceCode).css("background-color",normalBgColor);
        		//关闭状态
        		if(result[i].openStatus ==2){
        			$("#dNumber_"+result[i].deviceCode).css("background-color",stopBgColor);
        		}
        		//故障状态
        		if(result[i].falutStatus==2){
        			$("#dNumber_"+result[i].deviceCode).css("background-color",faultBgColor);
        		}
        		if(result[i].childDevices!=null){
        			
        			if(result[i].childDevices[0]!=null){
        				$("#fa_"+result[i].deviceCode).val(result[i].childDevices[0].childFalutStatus);
		        		$("#oa_"+result[i].deviceCode).val(result[i].childDevices[0].childOpenStatus);
        			}
        			if(result[i].childDevices[1]!=null){
	        			$("#fb_"+result[i].deviceCode).val(result[i].childDevices[1].childFalutStatus);
	        			$("#ob_"+result[i].deviceCode).val(result[i].childDevices[1].childOpenStatus);
	        		}
        		}
            	//更新页面
            	if(openDetailDeviceId!=0 && openDetailDeviceId==result[i].deviceCode){
            		createDetailObjData(result[i].deviceCode)
            		initDeviceDetailInfo(deviceObjData);
            	}
        	}
        	
		}
		
		function createDetailObjData(paramCode){
			
			var deviceLocation = $("#dLocation_"+paramCode).val();
			var deviceOpenStatus = $("#opStatus_"+paramCode).val();
			var deviceFalutStatus = $("#ftStatus_"+paramCode).val();
			var deviceTypeParam = $("#dpType_"+paramCode).val();
			
			var faStatus = $("#fa_"+paramCode).val();
    		var oaStatus = $("#oa_"+paramCode).val();
    		var fbStatus = $("#fb_"+paramCode).val();
			var obStatus = $("#ob_"+paramCode).val();
			
			deviceObjData={};
			//初始化对象信息
			$(deviceObjData).attr({
				"deviceCode" : paramCode
			});
			//位置
			$(deviceObjData).attr({
				"deviceLocation" : deviceLocation
			});
			//单双泵
			$(deviceObjData).attr({
				"deviceTypeParam" : deviceTypeParam
			});
			$(deviceObjData).attr({
				"deviceOpenStatus" : deviceOpenStatus
			});
			$(deviceObjData).attr({
				"deviceFalutStatus" : deviceFalutStatus
			});
			
			$(deviceObjData).attr({
				"faStatus" : faStatus
			});
			$(deviceObjData).attr({
				"oaStatus" : oaStatus
			});
			$(deviceObjData).attr({
				"fbStatus" : fbStatus
			});
			$(deviceObjData).attr({
				"obStatus" : obStatus
			});
		}
		
	</script>
</body>
</html>