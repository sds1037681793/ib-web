<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${ctx}/static/busi/hvacHotDataPageMain.js"></script>
<style>
/*  #coolbox{   */
/*   background-image: url("${ctx}/static/img/hvac/hotBg.png");   */
/*   }  */
</style>
</head>
<body class="main_background" style="width: 100%; height: 100%;">
	<div id="coolbox" style="width: 100%; height: 980px;position: relative;">
	</div>
<div id ="device-detail"></div>

<script type="text/javascript">
var manifold =  "${ctx}/static/img/hvac/manifold.svg";
var hotWaterLoopPump =  "${ctx}/static/img/hvac/hot_water_loop_pump.svg";
var boiler =  "${ctx}/static/img/hvac/boiler.svg";
var refrigeratingPumpBgColor = "#00BFA5";
var refrigeratingPumpBgCloseColor = "#B4B4B4";
var waterSepDeviceId;
var oneRefrigeratorDeviceId;
var twoRefrigeratorDeviceId;
var threeRefrigeratorDeviceId;
var fourRefrigeratorDeviceId;


var orgId = $("#login-org").data("orgId");
	$(document).ready(function() {
		toSubscribe();
		  $.ajax({
		        type : "post",
		        url : "${ctx}/device/manage/getDeviceRelate?projectId="+projectId+"&pictureName=hotBg1",
		        dataType : "json",
		        async: false,
		        contentType : "application/json;charset=utf-8",
		        success : function(data) {
		        if(data!=null){
		        	buildPicture(data.data);
		        }
		        	
		        },
		        error : function(req,error, errObj) {
		            return;
		            }
		        });	
		  $.ajax({
		        type : "post",
		        url : "${ctx}/hvac/hvacRunningData/getPageData?projectCode="+projectCode+"&code=WARM_SOURCE",
		        dataType : "json",
		        contentType : "application/json;charset=utf-8",
		        async: true,
		        success : function(data) {
		        	buildRunDiv(data);
		        },
		        error : function(req,error, errObj) {
		            return;
		            }
		        });

	});

	function buildPicture(data){
		debugger;
		if(typeof(data[0])=="undefined"){
			$("#content-page").load("/ib-web/projectPage/noDataPage");
			return ;
		}
		$("#coolbox").css("background-image",'url('+data[0].filePath+')');
		$.ajax({
	        type : "post",
	        url : "${ctx}/device/manage/getDeviceRelate?projectId="+projectId+"&pictureName=hotBg1",
	        dataType : "json",
	        async: false,
	        contentType : "application/json;charset=utf-8",
	        success : function(data) {
	        if(data!=null){
	        	if(data!=null){
		        	$(function (){
		                setTimeout(buildDiv(data.data), 300); //延迟0.3秒
		            })
		        }
	        }
	        	
	        },
	        error : function(req,error, errObj) {
	            return;
	            }
	        });
		
	}
	
	function buildDiv(data){
		$.each(data,function(i,val){
			if(val.catagory==='BOILER'){
				var div ='<div style="left: '+val.xCoordinate+'px; top:'+val.yCoordinate+'px;width:200px;height:30px; position: absolute;" >'+
				'<div id=ref'+val.deviceId+' class = "img_div" style=" background-color:'+refrigeratingPumpBgCloseColor +';box-shadow:0px 0px 4px #818181;width:70px;height:67px;float:left; line-height: 30px;text-align:left;padding-left:8px;cursor: pointer; " onclick="deviceDetail('+val.deviceId+')"'+
				' ><img style="width: 51px; height: 70px;" src ='+boiler+' /></div><div style=" display:none; background-color:rgba(231, 234, 236,0.8);box-shadow:0px 0px 4px #818181;width:88px;height:67px;float:left;text-align:center;line-height: 66px;font-size: 15px;font-family: PingFangSC-Regular;""><font>'+val.deviceName+'</font></div>'
				+'</div>';
				$("#coolbox").append(div);
				 $("#ref"+val.deviceId).data("deviceId", val.deviceId);
				 $("#ref"+val.deviceId).data("deviceName", val.deviceName);
				 $("#ref"+val.deviceId).data("catagory", val.catagory);
				 $("#ref"+val.deviceId).data("deviceNumber", val.deviceNumber);
			}
			if(val.catagory==='HOT_WATER_LOOP_PUMP'){
				var div ='<div style="left: '+val.xCoordinate+'px; top:'+val.yCoordinate+'px;width:200px;height:30px; position: absolute;">'+
				'<div id=pump'+val.deviceId+'  class = "img_div" style="background-color:'+refrigeratingPumpBgCloseColor +';box-shadow:0px 0px 4px #818181;width:70px;height:67px;float:left; line-height: 30px;text-align:left;padding-left:8px; cursor: pointer;'+
				'"onclick="deviceDetail('+val.deviceId+')"><img style="width: 51px; height: 70px;" src ='+hotWaterLoopPump+' /></div><div style=" display:none; background-color:rgba(231, 234, 236,0.8);box-shadow:0px 0px 4px #818181;width:200px;height:67px;text-align:center;line-height: 66px;font-size: 15px;font-family: PingFangSC-Regular;"'+
				'"><p style="line-height: 42px;">'+val.deviceName+'</p><p style="margin-top: -37px;" id=temp'+val.deviceId+'>- -°C</p></div>'
				+'</div>';
				$("#coolbox").append(div);
				 $("#pump"+val.deviceId).data("deviceId", val.deviceId);
				 $("#pump"+val.deviceId).data("deviceName", val.deviceName);
				 $("#pump"+val.deviceId).data("catagory", val.catagory);
				 $("#pump"+val.deviceId).data("deviceNumber", val.deviceNumber);
				 if(oneRefrigeratorDeviceId == null && twoRefrigeratorDeviceId == null && threeRefrigeratorDeviceId == null
						&& fourRefrigeratorDeviceId == null){
				     oneRefrigeratorDeviceId = val.deviceId;
				 }else if(oneRefrigeratorDeviceId != null && twoRefrigeratorDeviceId == null && threeRefrigeratorDeviceId == null
						 && fourRefrigeratorDeviceId == null){
				     twoRefrigeratorDeviceId = val.deviceId;
				 }else if(oneRefrigeratorDeviceId != null && twoRefrigeratorDeviceId != null && threeRefrigeratorDeviceId == null
						 && fourRefrigeratorDeviceId == null){
					 threeRefrigeratorDeviceId = val.deviceId; 
				 }else if(oneRefrigeratorDeviceId != null && twoRefrigeratorDeviceId != null && threeRefrigeratorDeviceId != null
						 && fourRefrigeratorDeviceId == null){
					 fourRefrigeratorDeviceId = val.deviceId; 
				 }
			}
			if(val.catagory==='WARM_MANIFOLD'||val.catagory==='WARM_WATER_SEPARATOR'){
				var div2 ='<div style="left: '+val.xCoordinate+'px; top:'+val.yCoordinate+'px;width:230px;height:30px; position: absolute;">'+
				'<div id = water'+val.deviceId+'  class = "img_div" style="background-color:'+refrigeratingPumpBgCloseColor +';box-shadow:0px 0px 4px #818181;width:70px;height:67px;float:left; line-height: 30px;text-align:left;padding-left:8px;cursor: pointer;'+
				' "onclick="deviceDetail('+val.deviceId+')"><img style="width: 51px; height: 70px;" src ='+manifold+' /></div><div style=" display:none; background-color:rgba(231, 234, 236,0.8);box-shadow:0px 0px 4px #818181;width:270px;height:67px;text-align:center;line-height: 30px;font-size: 15px;font-family: PingFangSC-Regular;"'+
				'"><p style="line-height: 37px;">'+val.deviceName+'</p>&nbsp<p style="margin-top: -45px;"><span id=temp'+val.deviceId+'>- -°C</span>&nbsp<span id=pre'+val.deviceId+' >- -Mpa</span></p></div>'
				+'</div>';
				$("#coolbox").append(div2);
				 $("#water"+val.deviceId).data("deviceId", val.deviceId);
				 waterSepDeviceId = val.deviceId;
				 $("#water"+val.deviceId).data("deviceName", val.deviceName);
				 $("#water"+val.deviceId).data("catagory", val.catagory);
				 $("#water"+val.deviceId).data("deviceNumber", val.deviceNumber);
			}
			
		})
	}
	function buildRunDiv(data){
		$.each(data,function(i,val){
			hvacWarmDataDeal(val);
		})
	}
	function hvacWarmDataDeal(data){
			var deviceId = data.deviceId;
			if(data.deviceType==='HOT_WATER_LOOP_PUMP'){
				if(data.workStatus===0){
					 $("#pump"+deviceId).css("background-color","#00BFA5");
				}else if(data.workStatus===1){
					 $("#pump"+deviceId).css("background-color","#B4B4B4");
				}
					 $("#temp"+deviceId).attr("color","#FF6E00");
				if(data.faultStatus ===0){
					$("#pump"+deviceId).css("background-color","#FA6900");
				}
				 if(data.workStatus!=null){
					 $("#pump"+data.deviceId).data("workStatus", data.workStatus);
				 }
				 if(data.faultStatus!=null){
				 	$("#pump"+data.deviceId).data("faultStatus", data.faultStatus);
				 }
			}
			if(data.deviceType==='BOILER'){
				if(data.workStatus===0){
				 	 $("#ref"+deviceId).css("background-color","#B4B4B4");
					}else if(data.workStatus===1){
					 $("#ref"+deviceId).css("background-color","#00BFA5");
				}
				if(data.faultStatus ===0){
					$("#ref"+deviceId).css("background-color","#FA6900");
				}
				 $("#ref"+data.deviceId).data("workStatus", data.workStatus);
				 $("#ref"+data.deviceId).data("temperature", data.temperature);
				 $("#ref"+data.deviceId).data("faultStatus", data.faultStatus);
			}
			if(data.deviceType==='WARM_MANIFOLD'||data.deviceType==='WARM_WATER_SEPARATOR'){
					if(data.workStatus===0){
					 $("#water"+deviceId).css("background-color","#B4B4B4");
					}else if(data.workStatus===1){
						 $("#water"+deviceId).css("background-color","#00BFA5");
					}
					
					if(data.faultStatus ===0){
						$("#water"+deviceId).css("background-color","#FA6900");
					}
					if(data.deviceType==='WARM_MANIFOLD'){
						if(data.temperature!=null){
							$("#temp"+deviceId).css("color","#FF6E00");
							 $("#temp"+deviceId).html(data.temperature+'°C');
						}
					}else{
						if(data.pumpOutTemperature!=null){
							$("#temp"+deviceId).css("color","#FF6E00");
							$("#temp"+oneRefrigeratorDeviceId).css("color","#FF6E00");
							$("#temp"+twoRefrigeratorDeviceId).css("color","#FF6E00");
							$("#temp"+threeRefrigeratorDeviceId).css("color","#FF6E00");
							$("#temp"+fourRefrigeratorDeviceId).css("color","#FF6E00");
							 $("#temp"+deviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
							 $("#temp"+oneRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
							 $("#temp"+twoRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
							 $("#temp"+threeRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
							 $("#temp"+fourRefrigeratorDeviceId).html(data.pumpOutTemperature==null?'- -'+'°C':data.pumpOutTemperature+'°C');
						}
					}
					
					if(data.pressure!=null){
						$("#pre"+deviceId).css("color","#FF6E00");
						 $("#pre"+deviceId).html(data.pressure+'Mpa');
					}
					
					if(data.workStatus!=null){
					 	$("#water"+data.deviceId).data("workStatus", data.workStatus);
					}
					if(data.temperature!=null){
					 	$("#water"+data.deviceId).data("temperature", data.temperature);
					}
					if(data.pressure!=null){
					 	$("#water"+data.deviceId).data("pressure", data.pressure);
					}
					if(data.faultStatus!=null){
					 	$("#water"+data.deviceId).data("faultStatus", data.faultStatus);
					}
					if(data.pumpOutTemperature!=null){
					 	$("#water"+data.deviceId).data("pumpOutTemperature", data.pumpOutTemperature);
					}
			}
			
	}
	function websocketCallBack(json) {
		hvacWarmDataDeal(json);
	}
	function deviceDetail(deviceId){
		createModalWithLoad("device-detail", 600, 328, "查看设备状态明细", "hvacRealTimeDataPage/hvacHotDeviceDetailPage?deviceId="+deviceId+"", "", "", "");
		$("#device-detail-modal").modal('show');
	}
	//更新弹窗页面属性值
	function updateModal(data){
		if(data.deviceId == paramDeviceId){
			if(data.deviceType=='BOILER'){
				//锅炉
				$("#workStatus_id").html( data.workStatus==1 ?"开启":"关闭");
			}
			if (data.deviceType === 'HOT_WATER_LOOP_PUMP') {
				//热水循环泵
				$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
				$("#temperature_id").html(data.temperature ==null?'- -'+'°C':data.temperature+'°C');
			}
			if(data.deviceType=='WARM_MANIFOLD'){
				//集水器
				if(data.workStatus!=null){
					$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
				}
				if(data.temperature!=null){
				$("#temperature_id").html(data.temperature+'°C');
				}
				if(data.pressure!=null){
					$("#pressure_id").html(data.pressure+'Mpa');
				}
			}
			if(data.deviceType=='WARM_WATER_SEPARATOR'){
				//分水器
				if(data.workStatus!=null){
					$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
				}
				if(data.pumpOutTemperature!=null){
					$("#temperature_id").html(data.pumpOutTemperature+'°C');
				}
				if(data.pressure!=null){
					$("#pressure_id").html(data.pressure+'Mpa');
				}
			}
		}
		
	}
	  $(".img_div").mouseover(function(){
		  $(this).next().show();
		});
	  
	  $(".img_div").mouseout(function(){
		  $(this).next().hide();
		});
</script>
</body>
</html>