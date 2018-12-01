<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${ctx}/static/busi/hvacCoolDataPageMain.js"></script>
<style>
/*  #coolbox{   */
/*   background-image: url("${ctx}/static/img/hvac/coolBg.png");   */
/*   }   */
#tab-id td{
	width:500px; 
}
</style>
</head>
<body class="main_background" style="width: 100%; height: 100%;">
	<div id="coolbox" style="width: 100%; height: 970px;position: relative;">
	</div>
	<div id ="device-detail"></div>
	

<script type="text/javascript">

var coolingPump = "${ctx}/static/img/hvac/cooling_pump.svg";
var coolingTower =  "${ctx}/static/img/hvac/cooling_tower.svg";
var manifold =  "${ctx}/static/img/hvac/manifold.svg";
var refrigeratingPump =  "${ctx}/static/img/hvac/refrigerating_pump.svg";
var refrigerator =  "${ctx}/static/img/hvac/refrigerator.svg";
var refrigeratingPumpBgColor = "#00BFA5";
var ctx = "${ctx}";
var orgId = $("#login-org").data("orgId");
	$(document).ready(function() {
		//websocket
		toSubscribe();
		  	
		  $.ajax({
		        type : "post",
		        url : "${ctx}/device/manage/getDeviceRelateData?projectId="+projectId+"&systemCode=COLD_SOURCE",
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
		        url : "${ctx}/hvac/hvacRunningData/getPageData?projectCode="+projectCode+"&code=COLD_SOURCE",
		        dataType : "json",
		        async: false,
		        contentType : "application/json;charset=utf-8",
		        success : function(data) {
		        	buildRunDiv(data);
		        },
		        error : function(req,error, errObj) {
		            return;
		            }
		        });	

	});

	function buildPicture(data){
		if(typeof(data[0])=="undefined"){
			//默认页面
			$("#content-page").load("/ib-web/projectPage/noDataPage");
			return ;
		}
		$("#coolbox").css("background-image",'url('+data[0].filePath+')');
		$.ajax({
	        type : "post",
	        url : "${ctx}/device/manage/getDeviceRelateData?projectId="+projectId+"&systemCode=COLD_SOURCE",
	        dataType : "json",
	        async: false,
	        contentType : "application/json;charset=utf-8",
	        success : function(data) {
	        if(data!=null){
	        	$(function (){
	                setTimeout(buildDiv(data.data), 300); //延迟0.3秒
	            })
	        }
	        	
	        },
	        error : function(req,error, errObj) {
	            return;
	            }
	        });
		
		
	}
	
	function buildDiv(data){
		$.each(data,function(i,val){
			var srcImg 
			if(val.catagory==='REFRIGERATOR'||val.catagory==='COOLING_TOWER'||val.catagory==='REFRIGERATING_PUMP'){
				if(val.catagory==='REFRIGERATOR'){
					srcImg = refrigerator;
				}else if(val.catagory==='COOLING_TOWER'){
					srcImg = coolingTower;
				}else{
					srcImg = refrigeratingPump;
				}
				var div ='<div  style="left: '+val.xCoordinate+'px; top:'+val.yCoordinate+'px;width:200px;height:30px; position: absolute;z-index: 3;" >'+
				'<div id=ref'+val.deviceId+' class = "img_div" style="background-color:'+refrigeratingPumpBgColor +';box-shadow:0px 0px 4px #818181;width:30px;height:30px;float:left; line-height: 30px;text-align:center; cursor: pointer;" onclick="deviceDetail('+val.deviceId+')" >'+
				'<img src ='+srcImg+' /></div><div  style=" display:none;background-color:rgba(231, 234, 236,0.8);box-shadow:0px 0px 4px #818181;width:80px;height:30px;float:left;text-align:left;line-height: 30px;padding-left: '+
				'8px;font-size: 10px;font-family: PingFangSC-Regular;"">&nbsp<font>'+val.deviceName+'</font></div>'
				+'</div>';
				 $("#coolbox").append(div);
				 $("#ref"+val.deviceId).data("deviceId", val.deviceId);
				 $("#ref"+val.deviceId).data("deviceName", val.deviceName);
				 $("#ref"+val.deviceId).data("catagory", val.catagory);
				 $("#ref"+val.deviceId).data("deviceNumber", val.deviceNumber);
			}
			if(val.catagory==='COOLING_PUMP'){
				if(val.catagory==='COOLING_PUMP'){
					srcImg = coolingPump;
				}
				var div1 ='<div style="left: '+val.xCoordinate+'px; top:'+val.yCoordinate+'px;width:250px;height:30px; position: absolute;z-index: 1;">'+
				'<div id = pump'+val.deviceId+' class = "img_div"  style="background-color:'+refrigeratingPumpBgColor +';box-shadow:0px 0px 4px #818181;width:30px;height:30px;float:left; line-height: 30px;text-align:center; cursor: pointer;" onclick="deviceDetail('+val.deviceId+')">'+
				'<img src ='+srcImg+' /></div><div style="display:none; background-color:rgba(231, 234, 236,0.8);box-shadow:0px 0px 4px #818181;width:175px;height:30px;float:left;text-align:left;line-height: 30px;padding-left: 2px;font-size:'+
				' 10px;font-family: PingFangSC-Regular;"">&nbsp<font >'+val.deviceName+'</font>&nbsp;&nbsp<font >进</font><font id=temp'+val.deviceId+' > - -°C</font>&nbsp;&nbsp<font >出<font><font id=pumpTemp'+val.deviceId+'> '+
				'- -°C</font></div>'
				+'</div>';
				$("#coolbox").append(div1);
				$("#pump"+val.deviceId+"").data("deviceId", val.deviceId);
				$("#pump"+val.deviceId+"").data("deviceName", val.deviceName);
				$("#pump"+val.deviceId+"").data("catagory", val.catagory);
				$("#pump"+val.deviceId).data("deviceNumber", val.deviceNumber);
			}
			if(val.catagory==='MANIFOLD'||val.catagory==='WATER_SEPARATOR'){
				var div2 ='<div style="left: '+val.xCoordinate+'px; top:'+val.yCoordinate+'px;width:230px;height:30px; position: absolute;z-index:2;" >'+
				'<div id = water'+val.deviceId+' class = "img_div" style="background-color:'+refrigeratingPumpBgColor +';box-shadow:0px 0px 4px #818181;width:30px;height:30px;float:left; line-height: 30px;text-align:center;cursor: pointer; "onclick="deviceDetail('+val.deviceId+')">'+
				'<img src ='+manifold+' /></div><div style="display:none; background-color:rgba(231, 234, 236,0.8);box-shadow:0px 0px 4px #818181; width:185px;height:30px;float:left;text-align:left;line-height: 30px;padding-left: 8px;font-size:'+
				' 10px;font-family: PingFangSC-Regular;""><font >'+val.deviceName+'</font>&nbsp<font id=waterTemp'+val.deviceId+'>- -°C</font>&nbsp<font id=pre'+val.deviceId+'>- -Mpa</font></div>'
				+'</div>';
				$("#coolbox").append(div2);
				$("#water"+val.deviceId+"").data("deviceId", val.deviceId);
				$("#water"+val.deviceId+"").data("deviceName", val.deviceName);
				$("#water"+val.deviceId+"").data("catagory", val.catagory);
				$("#water"+val.deviceId).data("deviceNumber", val.deviceNumber);
			}
		})
	}
	function buildRunDiv(data){
		$.each(data,function(i,val){
			hvacCoolDataDeal(val);
		})
	}
	function hvacCoolDataDeal(data){
		//判断 弹窗是否打开
		var isOpenModal  = checkModalIsOpen();
		//更新弹窗数据 
		updateModal(data);
		var deviceId = data.deviceId;
		//弹窗页面根据设备id赋值
		if(data.deviceType==='REFRIGERATOR'||data.deviceType==='COOLING_TOWER'||data.deviceType==='REFRIGERATING_PUMP'){
			if(data.deviceType==='REFRIGERATING_PUMP'){
				if(data.workStatus===0){
						$("#ref"+data.slaDeviceId).css("background-color","#00BFA5");
						$("#ref"+data.coolTowerSlaDeviceId).css("background-color","#00BFA5");
					}else if(data.workStatus===1){
					 $("#ref"+data.slaDeviceId).css("background-color","#B4B4B4");
					 $("#ref"+data.coolTowerSlaDeviceId).css("background-color","#B4B4B4");
					}
			}
			if(data.workStatus===0){
					 $("#ref"+deviceId).css("background-color","#00BFA5");
				}else if(data.workStatus===1){
				 $("#ref"+deviceId).css("background-color","#B4B4B4");
				}
			if(data.faultStatus ===0){
				$("#ref"+deviceId).css("background-color","#FA6900");
			}
			 $("#ref"+data.deviceId).data("workStatus", data.workStatus);
			 $("#ref"+data.slaDeviceId).data("workStatus", data.workStatus);
			 $("#ref"+data.coolTowerSlaDeviceId).data("workStatus", data.workStatus);
			 $("#ref"+data.deviceId).data("faultStatus", data.faultStatus);
		}
		if(data.deviceType==='COOLING_PUMP'){
			if(data.workStatus===0){
			 	 $("#pump"+deviceId).css("background-color","#B4B4B4");
				}else if(data.workStatus===1){
				 $("#pump"+deviceId).css("background-color","#00BFA5");
			}
			if(data.faultStatus ===0){
				$("#pump"+deviceId).css("background-color","#FA6900");
			}
			if(data.temperature!=null){
				 $("#temp"+deviceId).html( data.temperature+'°C');
				 $("#temp"+deviceId).attr("color","#FF6E00");
			}
			if(data.pumpOutTemperature!=null){
				 $("#pumpTemp"+deviceId).html(data.pumpOutTemperature+'°C');
				 $("#pumpTemp"+deviceId).attr("color","#FF6E00");
			}
			if(data.workStatus!=null){
			 $("#pump"+data.deviceId).data("workStatus", data.workStatus);
			}
			if(data.temperature!=null){
			 $("#pump"+data.deviceId).data("temperature", data.temperature);
			}
			if(data.faultStatus!=null){
			 $("#pump"+data.deviceId).data("faultStatus", data.faultStatus);
			}
			if(data.pumpOutTemperature){
			 $("#pumpTemp"+data.deviceId).data("pumpOutTemperature", data.pumpOutTemperature);
			}
			 
		}
		if(data.deviceType==='MANIFOLD'||data.deviceType==='WATER_SEPARATOR'){
			if(data.workStatus===0){
			 $("#water"+deviceId).css("background-color","#B4B4B4");
			}else if(data.workStatus===1){
				 $("#water"+deviceId).css("background-color","#00BFA5");
			
			}
			if(data.deviceType==='WATER_SEPARATOR'){
				if(data.pumpOutTemperature!=null){
					 $("#waterTemp"+deviceId).attr("color","#FF6E00");
					 $("#waterTemp"+deviceId).html(data.pumpOutTemperature+'°C');
				}
			}else{
				if(data.temperature!=null){
					 $("#waterTemp"+deviceId).attr("color","#FF6E00");
					 $("#waterTemp"+deviceId).html(data.temperature+'°C');
				}
			}
			if(data.pressure!=null){
				 $("#pre"+deviceId).attr("color","#FF6E00");
				 $("#pre"+deviceId).html(data.pressure+'Mpa');
			}
			if(data.faultStatus ===0){
				$("#water"+deviceId).css("background-color","#FA6900");
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
			if(data.pumpOutTemperature){
			 $("#water"+data.deviceId).data("pumpOutTemperature", data.pumpOutTemperature);
			}
		}
	}
	function websocketCallBack(json) {
			hvacCoolDataDeal(json);
		}
	function deviceDetail(deviceId){
		createModalWithLoad("device-detail", 600, 300, "查看设备状态明细", "hvacRealTimeDataPage/hvacDeviceDetailPage?deviceId="+deviceId+"", "", "", "");
		$("#device-detail-modal").modal('show');
	}
	//判断弹窗是否打开 
	function checkModalIsOpen(){
		var isOpenModal = $("#tb_deviceStatus").val();
		if(typeof(isOpenModal)=="undefined"){
			return false;
		}
		return true;
	}
	//更新弹窗页面属性值
	function updateModal(data){
		if(typeof(paramDeviceId)!='undefined' && data.deviceId == paramDeviceId){
			if(data.deviceType=='REFRIGERATOR'||data.deviceType=='COOLING_TOWER'){
				//冷却塔、冷机
				$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
			}
			if (data.deviceType === 'COOLING_PUMP'
						|| data.deviceType === 'REFRIGERATING_PUMP') {
				//冷却泵、冷冻泵
				if(data.workStatus!=null){
					if(data.deviceType == 'COOLING_PUMP'){
					$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
					}else if(data.deviceType == 'REFRIGERATING_PUMP'){
						$("#workStatus_id").html( data.workStatus==1 ?"关闭":"开启");
					}
				}
				if(data.temperature!=null){
					$("#temperature_id").html(data.temperature+'°C');
				}
				if(data.pumpOutTemperature!=null){
					$("#out_temperature_id").html(data.pumpOutTemperature+'°C');
				}
			}
			if(data.deviceType=='MANIFOLD'){
				//集水器、分水器
				if(data.workStatus!=null){
					$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
				}
				if(data.temperature !=null){
					$("#temperature_id").html(data.temperature+'°C');
				}
				if(data.pressure!=null){
					$("#pressure_id").html(data.pressure+'Mpa');
				}
			}
			if(data.deviceType=='WATER_SEPARATOR'){
				//分水器
				if(data.workStatus!=null){
					$("#workStatus_id").html( data.workStatus==0 ?"关闭":"开启");
				}
				if(data.pumpOutTemperature!=null){
					$("#out_temperature_id").html(data.pumpOutTemperature+'°C');
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