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

<style type="text/css">
.hd {
	overflow: hidden;
	height: 3.75rem;
	/* 	position: relative; */
	/* 	z-index: 999; */
	width: 3%;
	/* 	margin-top: -3.75rem; */
	padding-left: 0.2rem;
	padding-right: 0.2rem;
}

.font1 {
	font-family: PingFangSC-Regular;
	font-size: 18px;
	color: #4A4A4A;
}

.font2{
	font-family: PingFangSC-Light;
	font-size: 60px;
	color: #23B3F5;
}

.font3 {
	font-family: PingFangSC-Light;
	font-size: 60px;
	color: #00BFA5;
}
.headDiv {
	background: #FFFFFF;
	border: 1px solid #E1E1E1;
	border-radius: 4px;
	height: 200px;
	padding-top: 3.5rem;
	float: left;
	overflow: hidden;
	width: 99%;
	margin-top:5px;
}

.headDiv .bd {
	/* 	padding-left: 1rem; */
	/* 	padding-right: 2rem; */
	width: 100%;
	height:100%;
	float: left;
	margin: auto 0 ;
}

.bd ul {
	overflow: hidden;
	zoom: 1;
}

.bd ul li {
	margin: 0 8px;
	float: left;
	_display: inline;
	overflow: hidden;
	text-align: center;
}


.headItem2 {
	width: 50%;
	height: 10rem;
	margin-left: 10%;
	border: 1px solid rgba(255, 255, 255, 0.13);
	border-radius: 4px;
	float: left;
}

.headItem3 {
	width: 35%;
	height: 10rem;
	margin-left: 2%;
	border: 1px solid rgba(255, 255, 255, 0.13);
	border-radius: 4px;
	float: left;
}

.block1 {
	float: left;
	height: 600px;
	width: 60%;
	background: #FFFFFF;
	border: 1px solid #E1E1E1;
	border-radius: 5px;
	margin-top:20px;
}

.block2 {
	float: left;
	height: 600px;
	width: 38%;
	background: #FFFFFF;
	border: 1px solid #E1E1E1;
	border-radius: 5px;
	margin-top:20px;
	margin-left:18px;
}

.detailHead {
	margin-top: 10px;
	width: 100%;
	height: 13%;
	padding-left:5rem;
}
.detailItem {
	width: 99%;
	height: 40rem;
}

.detailCotent {
	margin-bottom: 10px;
	width: 100%;
	height: 70%;
}

.detailFont {
	font-size: 1.25rem;
	color: #666666;
	line-height: 2.75rem;
	left: 5rem;
	margin-left: 1.25rem;
}

.echartHeadDefualtFont {
	font-size: 1.25rem;
	color: #666666;
	line-height: 2.75rem;
	left: 5rem;
	margin-left: 1.25rem;
}
tr{
	width:90%;
}
td{
	height:0px;
	margin:0px;
	padding:0px;
}
span{
	height:0px;
	margin:0px;
	padding:0px;
}

.year_zlp{
	height:5%;
	width: 100%;
	  position:relative;
 
}
</style>
</head>
<body>

	<div class="contentDiv">
		<!-- 第一栏项目 -->
		<div id="pphead" class="headDiv">
			<div class="bd">
				<ul id="picList" class="picList">
					<div class="headItem2" style="cursor: pointer;">
						<table style="width: 100%; height: 100%;">
							<tr >
								<td style="height: 100%;">
									<span  class="font2" id="id_lastMonthDlp">--</span>
									<span id="head_span_month_rate"><span id="id_lastMonthRate" style="font-family: PingFangSC-Regular;font-size: 18px;color: #F20000;margin-left:20px;height:100%"></span>
										<img style='width:11px;height:18px;margin-bottom:5px' id='head_img_span_ratePic'/>
									</span>
								</td>
							</tr>
							<tr>
								<td><span style="width: 105px;" class="font1">上月电量(kWh)</span>
								<a id="skip_history_page" style="font-size:18px;color:#23B3F5;margin-left:50px;border-bottom:1px #23B3F5 solid">查看电表数据</a>
								</td>
								<td></td>
							</tr>
						</table>
					</div>
					<div class="headItem3" style="cursor: pointer;">
						<table style="width: 100%; height: 100%;">
							<tr>
								<td  class="font3" id="id_currentMonthDlp">--</td>
							</tr>
							<tr>
								<td style="width: 105px;" class="font1">本月电量(kWh)</td>
							</tr>
						</table>
					</div>

				</ul>
			</div>
		</div>
		<div class="block1">
				<div class="detailHead">
					<table >
						<tr  id="id_year">
						</tr>
					</table>
				</div>
				<!-- 此处为报表 -->
				<div class="year_zlp"><span style="font-family:PingFangSC-Regular;margin-left:30%;font-size:24px">年度用电量<font id="current_year_zlp" style="color:#3BCBDD">--</font>kwh</span></div>
				<div id="monthEchartContent" class="detailCotent"></div>
		</div>
		<div class="block2">
			<div class="detailItem" >
					<div  id="tb_lastMonthDetail" style="height:99%;width:95%;margin-left:5%">
						
					</div>
				</div>
			</div>
		</div>
		<div id="error-div"></div>
		<div id="div-powerConsumptionDeviceDetail"></div>
		<script type="text/javascript">
		var orgId = projectId;
		var isFristOpen = 'true';
		var chooseYear = null;
		var chooseMonth = null;
		var chinseMonthStr = null;
		var currentYear = '${currentYear}';
		$(document).ready(function() {
			$('#contentDiv').css({

				"margin-left" : "240px",
				"margin-right" : "0px",
				"margin-bottom" : "2px",
				"padding-bottom" : "1.56rem",
				"position" : "relative",
				"min-height" : function() {
					return $(window).height();
				},
				"outline" : "medium none"
			});
			
			getYearInfo();
			//展示头部汇总数据
			initHeadData();
			//右部详情
			monthDetail();
			
			//setInterval("initHeadData()", 900000);
			setInterval("initHeadData()", 900000);
		});
		
		function initEchartModul(){
				reload('vehicleStatistics-dropdownlist');
		}
		
		
		//选择年
		function openEchartDetail(obj) {
			$("#id_year").children().each(function(index,nobj){
				$(nobj).css("border",null);
				$("span",$(nobj)).css("color", "#666666");
				$("span", $(nobj)).css("font-size", "1.25rem");
			});
			//给选中的月份赋值
			chooseYear=obj.textContent;
			$(obj).parent("td").siblings().css("border-bottom", "");
			$(obj).parent("td").css("border-bottom", "3px #3BCBDD solid");
			$("span", $(obj)).css("color", "#3BCBDD");
			$("span", $(obj)).css("font-size", "2rem");
			var yearNum = $("span", $(obj)).html();
			
			oneYearZlp(yearNum);
			var reportId = 104;//当年
			
			var reportShowDiv = "monthEchartContent";
			// 展示eachrt数据
			showEchartFunc(reportId,reportShowDiv,yearNum);
			
			
			//联动右侧
			if(chooseYear==currentYear){
				monthDetail();
			}else{
				monthDetail(chooseYear);
			}
			
		}
		
		//打开echart数据
		function showEchartFunc(reportId, divId,yearNum) {
			$.ajax({
				type : "post",
				url : "${ctx}/report/" + reportId+"?projectCode="+projectCode+"&yearNum="+yearNum,
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					var obj = echarts.init(document.getElementById(divId));
					obj.setOption($.parseJSON(data));
// 					obj.on('click', function(param) {
// 						openPieDetail(param, reportId);
// 					});
					obj.on('mouseover', function(param) {
						openPieDetail(param, reportId);
					});
				},
				error : function(req, error, errObj) {
				}
			});
		}
		
		//展示某个月总用电量图表
		function showZDLByMonth(reportId, divId) {
				
		}
		
		
		function initHeadData(){
			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/supplyPowerMain/getHeadData?projectCode=" + projectCode,
				data : "",
				async : false,
				success : function(data) {
					if ( data.code == 0 && data.data!=null && data.data!="") {
						var result = data.data;
						if(result.lastMonthDlp==null ||result.lastMonthDlp==0){
							$("#id_lastMonthDlp").html("--");
						}else{
							$("#id_lastMonthDlp").html(result.lastMonthDlp);
						}
						if(result.currentMonthDlp==0 ||result.currentMonthDlp==null){
							$("#id_currentMonthDlp").html("--");
						}else{
							$("#id_currentMonthDlp").html(result.currentMonthDlp);
						}
						//箭头指向
						if(result.lastMonthCompare=="1"){//上升
							$("#id_lastMonthRate").html("同比"+result.lastMonthRate);
							$("#id_lastMonthRate").css("color","#F20000");
							$("#head_img_span_ratePic").attr('src','${ctx}/static/images/powerSupply/shangsheng.svg');
						}else if(result.lastMonthCompare=="2"){//跌
							$("#id_lastMonthRate").html("同比"+result.lastMonthRate);
							$("#id_lastMonthRate").css("color","#069B1A ");
							$("#head_img_span_ratePic").attr('src','${ctx}/static/images/powerSupply/xiajiang.svg');
						}else if(result.lastMonthCompare =="0"){ //没有去年数据
							$("#head_span_month_rate").css("display","none");
						}
						
					} else {
						$("#id_lastMonthDlp").html("--");
						$("#id_currentMonthDlp").html("--");
						return false;
					}
				},
				error : function(req, error, errObj) {
					return false;
				}
			});
			
			
		}
		
		
	 	function monthDetail(month){
	 		var monthInfo = month;
	 		if(month==null||month==""){
	 			monthInfo = 0;
	 		}
	 		chooseMonth  = monthInfo;
			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/supplyPowerMain/getDetailData?projectCode=" + projectCode+"&month="+monthInfo,
				data : "",
				success : function(data) {
					if ( data.code == 0 && data.data!=null && data.data!="") {
						var datas = data.data;
						var result = datas.dataList;
						chinseMonthStr = datas.monthDateStr;
						$("#tb_lastMonthDetail").html("");
						var headtr1 = "<div style='color:#4A4A4A;font-size:24px;height:25px;margin-top:30px'><span>"+datas.monthDate.substring(5,7)
						 +"</span><span>月总用电量</span></div>";
						 if(datas.zdlp==0){
							 datas.zdlp="--";
						 }
						var headtr2 ="<div style='height:100px;padding-top:40px'><span style='height:60px;font-size:60px'>"+datas.zdlp+"</span><span style='font-size:60px'>kwh</span><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span id='id_month_rate' style='font-size:18px;' >同比"
							+datas.rate+"<img style='width:11px;height:18px' id='span_ratePic'/></span></div>";
						
						$("#tb_lastMonthDetail").append(headtr1+headtr2);
						if(datas.compareType=="1"){//上涨
							$("#span_ratePic").attr('src','${ctx}/static/images/powerSupply/shangsheng.svg');
							$("#id_month_rate").css("color","#F20000");
						}else if(datas.compareType=="2"){//跌
							$("#span_ratePic").attr('src','${ctx}/static/images/powerSupply/xiajiang.svg');
							$("#id_month_rate").css("color","#069B1A");
						}else if(datas.compareType =="0"){ //没有去年数据
							$("#id_month_rate").css("display","none");
						}
						for(var i in result){
							var bgColor="#00A8E2";
							if(i==0){
								bgColor  = "#00A8E2";
							}else if(i==1){
								bgColor="#F6A436";
							}else if(i==2){
								bgColor="#83B343";
							}else{
								bgColor="#CA2F45";
							}
							var trContent = "<div style='font-size:24px;height:40px;margin-top:25px;'><div style='width:250px;float:left'>"
							+result[i].deviceName+"</div><div style='float:left;width:200px;'>"
							+result[i].deviceDlp+"kwh&nbsp;&nbsp;</div><div style='float:left' id='id_rateDlp'>"
							+result[i].dlpRate+"</div></div>"
							+"<div style='height:30px;'><div style='background-color:"+bgColor+";height:30px;width:"+result[i].dlpRate+"'></div><div>";
							$("#tb_lastMonthDetail").append(trContent);
						}
						
						if(datas.deviceDetailNum>4){
							var showAllDeviceDetail ="<div onclick='openDeviceDetailPage()' style='height:30px;height:40px;margin-top:25px'><span style='border-bottom:1px #00BFA5 solid;color:#00BFA5;font-size:24px;cursor:pointer'>查看全部</span></div>";
							$("#tb_lastMonthDetail").append(showAllDeviceDetail);
						}
						
					} else {
						return false;
					}
				},
				error : function(req, error, errObj) {
					return false;
				}
			});
		}
		
	 	function getYearInfo(){
	 		$.ajax({
				type : "post",
				url : "${ctx}/power-supply/supplyPowerMain/getYearInfo?projectCode=" + projectCode,
				data : "",
				success : function(data) {
					if ( data.code == 0 && data.data!=null && data.data!="") {
						var result = data.data.yearInfo;
						for(var i in result){
							var tdContent = "<td style='width: 7rem;height:5rem;cursor:pointer'  value='"+result[i]+"'><div onclick='openEchartDetail(this)'>"
								+"<span class='echartHeadDefualtFont'>"+result[i]+"</span></div></td>";
							$("#id_year").append(tdContent);
						}
						if(isFristOpen=='true'){
							fristEchart();
				 		}
						isFristOpen = 'false';
					} else {
						return false;
					}
				},
				error : function(req, error, errObj) {
					return false;
				}
			});	
	 		
	 	}
	 	
		function openPieDetail(param, type) {
			var paramId = param.name;
			seriesName = param.seriesName;
			if (type == 104) {
				monthDetail(chooseYear+'-'+paramId);
			}
		}
		function fristEchart(){
			
			$("#id_year").children().each(function(index,obj){
				if(obj.textContent==currentYear){
					openEchartDetail(obj);
				}
			});
		}
		
		
		function oneYearZlp(yearNum){
			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/supplyPowerMain/getOneYearZlp?projectCode=" + projectCode+"&yearNum="+yearNum,
				data : "",
				success : function(data) {
					if ( data.code == 0 && data.data!=null && data.data!="") {
						var result = data.data;
						$("#current_year_zlp").html(result);
					} else {
						return false;
					}
				},
				error : function(req, error, errObj) {
					return false;
				}
			});
			
			
		}
		
		//开启设备详情页面
		function openDeviceDetailPage(){
			createModalWithLoad("div-powerConsumptionDeviceDetail", 560,420, chinseMonthStr+"电表电量分布",
					"psdMain/powerDeviceDetail", "", "", "");
			openModal("#div-powerConsumptionDeviceDetail-modal", true, false);
		}
		//跳转历史数据监控页面
		$("#skip_history_page").click(function(){
			openPage("历史数据监控"," ","/psdMain/historicalDataMonitoring");
		});
	
	</script>
</body>
</html>