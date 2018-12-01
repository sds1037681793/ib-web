<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd HH:mm" />

<!DOCTYPE html>
<html>
<head>
    <link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
	<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript" ></script>
	<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
</head>
<body>
	<div class="content-default" style="min-width: 750px;">
		<form>
		
			<table style="min-width: 720px;">
				<tr>
					<td align="right" style="width:8rem;">级别：</td>
					<td><div id="power-type-dropdownlist"></div></td>
					<td align="right" style="width:8rem;">时间：</td>
					<td><input id="currentTime" name="currentTime" class="form-control required" type="text" style="width:150px;" /></td>
 					<td>
						<button id="btn-query-info" type="button" class="btn btn-default btnicons" style="margin-left: 1rem;">
							<p class="btniconimg"><span>查询</span></p>
                     </button>
					</td> 
				</tr>
			</table>
		</form>
	</div>

	<table id="tb-historicalData" class="tb-historicalData" style="border: 1px solid; height:99%; width:99%; margin:0 auto; min-width: 750px;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>

	<div id="pg" style="text-align: right;"></div>
	<div id="error-div" ></div>
	<div id="datetimepicker-div"></div>

 	<script type="text/javascript"> 
      var tbHistoricalData;
      var powerTypeList;
      //var operatorId = <shiro:principal property="id"/>;
      var orgId = $("#login-org").data("orgId");
      var code="THREE_PHASE_POWER_METER";
 		$(document).ready(function(){
 			var today = "${today}";
 			var minute=today.substring(14,16);
 			if(minute<15){
 				minute="00";
 			}else if(minute>=15 && minute<30){
 				minute="15";
 			}else if(minute>=30 && minute<45 ){
 				minute="30";
 			}else if(minute>=45){
 				minute="45";
 			}
 			today=today.substring(0,14);
 			$('#currentTime').val(today+minute+":00");
 			// 设置消息类型下拉列表组件 
 			powerTypeList = $("#power-type-dropdownlist").dropDownList({
 				inputName: "powerTypeName",
 				inputValName: "powerType",
 				buttonText: "",
 				width: "116px",
 				readOnly: false,
 				required: true,
 				maxHeight: 200,
 				items: [{itemText:'全部',itemData:'-1'},{itemText:'一级',itemData:'1'},{itemText:'二级',itemData:'2'},{itemText:'三级',itemData:'3'},{itemText:'四级',itemData:'4'}]
 			});
 			powerTypeList.setData("全部", "-1", "");
 			//时间
  			$("#currentTime").datetimepicker({
  				id: 'datetimepicker-currentTime',
  				containerId: 'datetimepicker-div',
  				lang: 'ch',
  				timepicker: true,
  				hours12:false,
  				allowBlank:true,
  				format: 'Y-m-d H:i:s',
  			    formatDate: 'YYYY-mm-dd HH:mm:ss'
  			});

 		  	var infoCols = [
                 {title : '流水号',name : 'id',width : 150,sortable : false,align : 'left',hidden:true},
                 {title : '编号',name : 'deviceNo',width : 100,sortable : false,align : 'left'},
                 {title : '名称',name : 'deviceName',width : 150,sortable : false,align : 'left'},
                 {title : 'Ua',name : 'ua',width : 100,sortable : false,align : 'left'},
                 {title : 'Ub',name : 'ub',width : 100,sortable : false,align : 'left'},
                 {title : 'Uc',name : 'uc',width : 100,sortable : false,align : 'left'},
                 {title : 'Uab',name : 'uab',width : 100,sortable : false,align : 'left'},
                 {title : 'Ubc',name : 'ubc',width : 100,sortable : false,align : 'left'},
                 {title : 'Uca',name : 'uca',width : 100,sortable : false,align : 'left'},
                 {title : 'Ia',name : 'ia',width : 100,sortable : false,align : 'left'},
                 {title : 'Ib',name : 'ib',width : 100,sortable : false,align : 'left'},
                 {title : 'Ic',name : 'ic',width : 100,sortable : false,align : 'left'},
                 {title : '有功用电量',name : 'activeElectricity',width : 150,sortable : false,align : 'left'},
                 {title : '无功功率',name : 'reactivePower',width : 150,sortable : false,align : 'left'},
                 {title : '功率因素',name : 'powerFactor',width : 150,sortable : false,align : 'left'},
                 {title : '无功用电量',name : 'positiveReactivePower',width : 150,sortable : false,align : 'left'},
             ]; 
 		$('#btn-query-info').on('click', function(){ 
 			tbHistoricalData.load(); 
		}); 
 		tbHistoricalData = $('#tb-historicalData').mmGrid({
                height:694,
                cols:infoCols,
                url:'${ctx}/power-supply/pdsElectricityMeterRecordHis/historicalData',
                method:'post',
                params:function(){
                	var data = {"": ""};
                	var currentTime = $("#currentTime").val().trim();
            		var minute=currentTime.substring(14,16);
         			if(minute<15){
         				minute="00";
         			}else if(minute>=15 && minute<30){
         				minute="15";
         			}else if(minute>=30 && minute<45 ){
         				minute="30";
         			}else if(minute>=45){
         				minute="45";
         			}
                	currentTime = currentTime.substring(0,14)+minute+":00";
    				if (currentTime != "" && currentTime != null){
						$(data).attr({"currentTime": currentTime});
					}
    				$(data).attr({"projectCode" : projectCode});
    				var level = $("#powerType").val();
    				$(data).attr({"level" : level});
    				$(data).attr({"code" : code});
                	return data;
                	}, 
                remoteSort:true,
                sortable : false,
                multiSelect:false,
                checkCol:false,
                fullWidthRows:true,
                showBackboard:false,
                nowrap:true,
                autoLoad:false,
                plugins:[$('#pg').mmPaginator({"limitList":[20]})]
            });
 		
 		tbHistoricalData.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
			}).on('loadSuccess',function(e,data) {
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "历史数据查询失败：" + errObj);
			}).load();
            
 		});

 	
 	</script> 
</body>
</html>