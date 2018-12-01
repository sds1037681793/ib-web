<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd HH:mm:ss" />
<fmt:formatDate value="${now}" var="currentYear" pattern="yyyy" />
<fmt:formatDate value="${now}" var="currentMonthFmt" pattern="MM" />
<!DOCTYPE html>
<html>
<head>
<link
	href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css"
	type="text/css" rel="stylesheet" />
<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<script src="${ctx}/static/js/ibTree/jquery.jOrgChart.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/ibTree/prettify.js"></script>
<script src="${ctx}/static/js/jquery-ui.min.js" type="text/javascript"></script>
<!-- ib-tree -->

<link rel="stylesheet" href="${ctx}/static/js/ibTree/css/jquery.jOrgChart.css"/>
<link rel="stylesheet" href="${ctx}/static/js/ibTree/css/custom.css"/>
<link href="${ctx}/static/js/ibTree/css/prettify.css" type="text/css" rel="stylesheet" />
<style type="text/css">
   	body{   
   		color: #333;  
    	padding-top:10px; 
   		font-family:"Helvetica Neue",Helvetica,Arial,sans-serif; 
   	} 
    .clickImg{
   	 width:27px;
   	 height:26px;
   	 cursor: pointer;
   	 margin-left:26px;
   	 background:url("${ctx}/static/images/powerSupply/clickGroup.png");
    }
    .clickImg2{
     width:27px;
   	 height:26px;
   	 cursor: pointer;
   	 margin-left:30px;
   	 background:url("${ctx}/static/images/powerSupply/notClickGroup.svg");
    }
    
    .leftLevelDiv1{
       width:70px;
   	   height:30px;
       background:url("${ctx}/static/images/powerSupply/level1.png");
       margin-top:80px;
    }
    .leftLevelDiv2{
       width:70px;
   	   height:30px;
       background:url("${ctx}/static/images/powerSupply/level2.png");
       margin-top:150px;
    }
    .leftLevelDiv3{
       width:70px;
   	   height:30px;
       background:url("${ctx}/static/images/powerSupply/level3.png");
       margin-top:150px;
    }
    .leftLevelDiv4{
       width:70px;
       margin-top:170px;
   	   height:30px;
       background:url("${ctx}/static/images/powerSupply/level4.png");
    }
    
</style>
</head>
<body >
   	<div id="dv" class="content-default" style="min-width: 1050px;min-height:780px;overflow-x:scroll;white-space:nowrapl;cursor:move;
    -webkit-user-select:none;
    -moz-user-select:none;
    -ms-user-select:none;
    user-select:none;">
	   	   <div style="width:70px;float:left">
			  <ul>
				 <li class="leftLevel">
				 	<div class="leftLevelDiv1" ></div>
				 </li>
			     <li class="leftLevel">
			   		  <div  class="leftLevelDiv2" ></div>
			     </li>
			     <li class="leftLevel">
			    	  <div  class="leftLevelDiv3" ></div>
			      </li>
			       <li class="leftLevel">
			    	  <div  class="leftLevelDiv4" ></div>
			      </li>
			  </ul>   	   	
	   	   	
	   	   </div>
	 	   <div style="width:1000px;height:780px;float:left">
	    	<ul id="org" style="display:none" >
	   		</ul>            
	    	<div id="chart" class="orgChart"></div>
	    </div>
   	</div>
   	<div id="meterDetail-img"></div>
	<div id="error-div"></div>
    <script>
	 	var ctx = "${ctx}";
		var imgurl = "${ctx}/static/images/powerSupply/newMeter.png";
		var flushPowerStruct;
        $(document).ready(function() {
        	hiddenScroller();
        	//这里需要去查询电表位置信息和电表结构
 			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/supplyPowerMain/getPowerStructData?projectCode="+projectCode,
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if(data.code==0){
						handlePdsStruct(data);
					} else {
						showDialogModal("error-div", "提示信息", "查询电表结构信息错误", 1,
								null, true);
					}
				},
				error : function(req, error, errObj) {
				}
			});
        	
            /* Custom jQuery for the example */
            $("#show-list").click(function(e){
                e.preventDefault();
                
                $('#list-html').toggle('fast', function(){
                    if($(this).is(':visible')){
                        $('#show-list').text('Hide underlying list.');
                        $(".topbar").fadeTo('fast',0.9);
                    }else{
                        $('#show-list').text('Show underlying list.');
                        $(".topbar").fadeTo('fast',1);                  
                    }
                });
            });
            
            $('#list-html').text($('#org').html());
            
            $("#org").bind("DOMSubtreeModified", function() {
                $('#list-html').text('');
                
                $('#list-html').text($('#org').html());
                
                prettyPrint();                
            });
        	 $("#org").jOrgChart({
                 chartElement : '#chart',
                 dragAndDrop  : true
             });
        	 
			if (typeof (flushPowerStruct) != "undefined") {
     				//防止多次加载产生多个定时任务
     				clearTimeout(flushPowerStruct);
     		}
			flushPowerStruct = setTimeout("flushNewPowerRecordData()", 1000*60*15);
			
			
			
			 var dv = document.getElementById('dv'), ox;
		        //上一次的位置 scrollLeft
		        var last_left = 0;
		        function mousemove(e) {
		            console.log('移动事件');
		            console.log(' dv.scrollLeft' +dv.scrollLeft);
		            e = e || window.event;
		            last_left = -(e.clientX - ox);
		            dv.scrollLeft = -(e.clientX - ox);
		            console.log('clientX:'+e.clientX);
		            console.log('ox:'+ox);
		        }
		        function mouseup() {
		        	 console.log('up事件');
		            dv.className = 'content-default';
		            dv.onmouseup = dv.onmousemove = null;
		        }
		        dv.onmousedown = function (e) {
		           console.log('down事件');
		            dv.onmousemove = mousemove;
		            dv.onmouseup = mouseup;
		            e = e || window.event;
		            //如果上次有记录
		            if(last_left > 0 ){
		                //就减掉上次的距离
		                ox = e.clientX + last_left;
		            }else{
		                console.log(dv.scrollLeft)
		                ox = e.clientX + dv.scrollLeft;
		                // ox = e.clientX;
		            }
		            dv.className = 'content-default';
		        }
		    
			
    	});
        
        //处理电表结构
        function handlePdsStruct(data){
        	if(data.data==null){
        		return;
        	}
        	var result = data.data;
        	
    		//一级电表
    		if(result.twoChilds.length>0){
    			var oneLevel ="<li>"+ getMeterHtml(result.deviceId,result.power,result.name,1) +"</li>"; //1:收缩状态
            	$("#org").append(oneLevel);
    		}else{
    			return;
    		}
        	var twoLevel = result.twoChilds;
        	var twoNodes ="";
        	//二级电表
        	for(var iTwo in twoLevel){
        		var twoNode="<li>"+ getMeterHtml(twoLevel[iTwo].deviceId,twoLevel[iTwo].power,twoLevel[iTwo].name,2);
        		//三级电表
        		var threeNodes = "";	
        		if(twoLevel[iTwo].threeChilds.length>0){
        			twoNode = "<li>"+ getMeterHtml(twoLevel[iTwo].deviceId,twoLevel[iTwo].power,twoLevel[iTwo].name,1);
        			var threeLevel = twoLevel[iTwo].threeChilds;
        			for(var iThree in threeLevel){
        				var threeNode="<li>"+ getMeterHtml(threeLevel[iThree].deviceId,threeLevel[iThree].power,threeLevel[iThree].name,2);
        				//	四级电表
        				var fourNodes = "";
        				if(threeLevel[iThree].fourChilds.length >0){
        					threeNode="<li>"+ getMeterHtml(threeLevel[iThree].deviceId,threeLevel[iThree].power,threeLevel[iThree].name,1);
        					var fourLevel = threeLevel[iThree].fourChilds;
        					for(var iFour in fourLevel){
        						var fourNode = "<li>"+ getMeterHtml(fourLevel[iFour].deviceId,fourLevel[iFour].power,fourLevel[iFour].name,2);
        						fourNodes = fourNodes + fourNode+"</li>";
        					}
        					fourNodes = "<ul>"+fourNodes +"</ul>";
        				}
        				threeNodes = threeNodes + threeNode + fourNodes +"</li>";
        			}
        			threeNodes ="<ul>"+threeNodes + "</ul>";
        		}
        		twoNodes = twoNodes + twoNode +threeNodes +"</li>";
        	}
        	$("#org").children("li").append("<ul>"+twoNodes+"</ul>");
        	
        }
        
        //获取电表html组装元素
        function getMeterHtml(deviceId,power,deviceName,showNext){
        	var clickImgHtml = '<div  class="clickImg" onClick="toggleImg(this)" ></div>';
        	if(showNext ==2){
        		clickImgHtml ="";
        	}
        	
        	//1:未展开
        	var summaryDiv='<div style="position:relative; width:78;height:108px;float:left;margin-bottom: 10.2px;">'
     			+'<div id=deviceName'+deviceId+' style="font-family: PingFangSC-Regular;font-size: 10px;color: #424242;letter-spacing: 0.03px;">'+ deviceName +'</div>'
     			+'<img style="width:78px;height:108px;cursor: pointer;" src="'
    			+ imgurl + '" onclick="meterDetail(\''+deviceId+'\')"/>'
    			+'<div  id=power_'+deviceId+' style="position:absolute; top:30px;width:80px;text-align: center;font-family: PingFangSC-Regular;font-size: 12px;color: #424242;letter-spacing: 0.03px;cursor: pointer;" onclick="meterDetail(\''+deviceId+'\')">'
    			+ power + '</div>'
    			+'<div style="position:absolute; top:45px;width:80px;text-align: center;color:#000;font-size:10px;cursor: pointer;" onclick="meterDetail(\''+deviceId+'\')">kWh</div>'
    			+ clickImgHtml
    		+'</div>';
    		return summaryDiv;
        }
        
        function toggleImg(obj){
        	if($(obj).attr("class")=='clickImg'){
        		$(obj).removeClass("clickImg");
            	$(obj).addClass("clickImg2");
        	}else{
        		$(obj).removeClass("clickImg2");
            	$(obj).addClass("clickImg");
        	}
        	
        }
   		//获取新的电表记录
        function getNewPowerRecord(){
        	$.ajax({
				type : "post",
				url : "${ctx}/power-supply/supplyPowerMain/getPdsNewRecord?projectCode="+projectCode,
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if(data.code==0){
						updatePowerRecord(data);
					} else {
						showDialogModal("error-div", "提示信息", "查询电表结构信息错误", 1,
								null, true);
					}
				},
				error : function(req, error, errObj) {
				}
			});
   			
        }
   		//更新数据
   		function updatePowerRecord(data){
			var result = data.data;   
   			for(var i in result){
        		$('div[id=power_'+result[i].deviceId+']').html(result[i].activeElectricity);
        	}
   		}

   		function flushNewPowerRecordData() {
   			if (typeof (flushPowerStruct) != "undefined") {
   				getNewPowerRecord();
   				flushPowerStruct = setTimeout("flushNewPowerRecordData()", 1000*60*15);

   			}
   		}
   		//点击跳转详情页面
 		function meterDetail(deviceId){
 			var devicename=$("#deviceName"+deviceId).text();
   			if(deviceId=="null"){
   				showDialogModal("error-div", "操作提示", "该一级电表【"+devicename+"】不支持实时查看");
 				return;
   			}
 			var meterType=1;
 			var level=1;
 			//点击之前查好数据
 			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/pdsElectricityMeterRecord/getMeterType?deviceId="+deviceId,
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if(data!=null && data.code==0 && data.data!=null){
						meterType = data.data.powerType;
						level = data.data.level;
						
					} 
					//查询到数据再跳转页面
		 			//虚拟的一级电表
		 			if(meterType==1 && level==2){
						showDialogModal("error-div", "操作提示", "该二级电表【"+devicename+"】不支持实时查看");
		 				return;
		 			}
					
		 			var deviceName ='<label style="font-size: 20px;color: #4A4A4A;margin-left:10px;" >'+devicename + '</label>';
					createModalWithLoad("meterDetail-img", 1040, 600, deviceName,
							"psdMain/meterDetail?deviceId="+deviceId+"&meterType="+meterType+"&level="+level, "", "", "");
					$(".modal-body").css("padding-top","0px");
					openModal("#meterDetail-img-modal", true, false);
					hiddenScroller();
				},
				error : function(req, error, errObj) {
				}
			});
 		}
   		
 		function hiddenScroller() {
 			var height = $(window).height();
 			if (height > 1060) {
 				document.documentElement.style.overflowY = 'hidden';
 				$(".modal-open .modal").css("overflow-y", "hidden");
 				document.documentElement.style.overflowX = 'hidden';
 				$(".modal-open .modal").css("overflow-x", "hidden");
 			}else if(height == 943 || height == 926){
 				document.documentElement.style.overflowY = 'auto';
 				$(".modal-open .modal").css("overflow-y", "auto");
 				document.documentElement.style.overflowX = 'hidden';
 				$(".modal-open .modal").css("overflow-x", "hidden");
 			}else {
 				document.documentElement.style.overflowY = 'auto';
 				$(".modal-open .modal").css("overflow-y", "auto");
 				document.documentElement.style.overflowX = 'auto';
 				$(".modal-open .modal").css("overflow-x", "auto");
 			}
 			
 		}

 		$(window).resize(function() {
 			hiddenScroller();
 		});
    </script>

</body>
</html>