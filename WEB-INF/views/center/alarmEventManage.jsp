<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
</head>
<body>
	<table id="tb_groups" class="tb_groups" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>

	<div id="pg" style="text-align: right;"></div>
	<div id="rest-config-info"></div>
	<div id="rest-config-edit"></div>
	<div id="rest-config-relate"></div>
	<div id="rest-config-door"></div>
	<div id="error-div"></div>
  <script type="text/javascript">
	var tbAlarmEven;
	// 一级分类
	var levelTypeList = new Array();
    var levelTypeMaps = new HashMap();
    var levelTypeObj;
    
    // 二级分类
    var levelTwoTypeList = new Array();
    var levelTwoTypeMaps = new HashMap();
    var levelTwoTypeObj;
    
    // 设备类型
    var levelThreeTypeList = new Array();
    var levelThreeTypeMaps = new HashMap();
    var levelThreeTypeObj;
    $(document).ready(function() {
    	
    	//获取配置的一级分类
    	var code1 = "SYSTEM_FROM";
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/alarmEventDefine/listAlarmStatic?code="+code1,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data != null && data.length > 0) {
					$(eval(data)).each(function(){
						levelTypeMaps.put(this.itemData,this.itemText);
						levelTypeList[levelTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
					});
					// 设置用户类型下拉列表
					levelTypeObj = $("one-_scheme-dropdownlist").dropDownList({
						inputName: "levelTypeName",
						inputValName: "levelType",
						buttonText: "",
						width: "117px",
						readOnly: false,
						required: true,
						maxHeight: 200,
						onSelect: function(i, data, icon) {},
						items: levelTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		
		//获取配置的二级分类
		var code2 = "SUB_SYSTEM_FROM";
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/alarmEventDefine/listAlarmStatic?code="+code2,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data != null && data.length > 0) {
					$(eval(data)).each(function(){
						levelTwoTypeMaps.put(this.itemData,this.itemText);
						levelTwoTypeList[levelTwoTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
					});
					// 设置用户类型下拉列表
					levelTwoTypeObj = $("two-scheme-dropdownlist").dropDownList({
						inputName: "levelTwoTypeName",
						inputValName: "levelTwoType",
						buttonText: "",
						width: "117px",
						readOnly: false,
						required: true,
						maxHeight: 200,
						onSelect: function(i, data, icon) {},
						items: levelTwoTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		
		
		//获取配置的设备类型
		var code3 = "DEVICE_TYPE_FROM";
		$.ajax({
			type: "post",
			url: "${ctx}/alarm-center/alarmEventDefine/listAlarmStatic?code="+code3,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				if (data != null && data.length > 0) {
					$(eval(data)).each(function(){
						levelThreeTypeMaps.put(this.itemData,this.itemText);
						levelThreeTypeList[levelThreeTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
					});
					// 设置用户类型下拉列表
					levelThreeTypeObj = $("three-scheme-dropdownlist").dropDownList({
						inputName: "levelThreeTypeName",
						inputValName: "levelThreeType",
						buttonText: "",
						width: "117px",
						readOnly: false,
						required: true,
						maxHeight: 200,
						onSelect: function(i, data, icon) {},
						items: levelThreeTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		 
		
		// 事件展现列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'事件编号',name:'code',width:100,sortable:false,align:'left'},
				{title:'一级分类',name:'systemCode',width:100,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.systemCode!=null){
						return levelTypeMaps.get(item.systemCode);
					}  
				}},
				{title:'二级分类',name:'subSystemCode',width:100,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.subSystemCode!=null){
						return levelTwoTypeMaps.get(item.subSystemCode);
					}  
				}},
				{title:'设备类型',name:'deviceTypeCode',width:100,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.deviceTypeCode!=null){
						return levelThreeTypeMaps.get(item.deviceTypeCode);
					}  
				}},
				{title:'优先级',name:'level',width:160,sortable:false,align:'left',renderer:function(val, item , rowIndex){
					var itemcontent = "";
					if(item && item.level){
						if(item.level ==1){
							itemcontent="高";
						}else if(item.level ==2){
							itemcontent="中";
						}else if(item.level ==3){
							itemcontent="低";
						}
					}
					return itemcontent;
				}},
				{title:'事件描述',name:'describe',width:160,sortable:false,align:'left'},
				{title:'操作', name:'' ,width:100, align:'left', lockWidth:true, lockDisplay: true, renderer: function(val){
					var modifyObj = '<a class="calss-modify" href="#" title="修改"><span style="font-size: 12px; color: #777; padding-right: 10px;"><img class="modify" src="${ctx}/static/img/alarm/xiugai.png"></span></a>';
					return modifyObj;
				}}
			];
			var pg = $('#pg').mmPaginator({"limitList":[20]});
			tbAlarmEven = $('#tb_groups').mmGrid({
			width:'100%',
			height:776,
			cols:cols,
			url:"${ctx}/alarm-center/alarmEventDefine/list",
			contentType : "application/json;charset=utf-8",
			method:'post',
			remoteSort:false,
			showBackboard:false,
			sortName:'id',
			sortStatus:'desc',
			multiSelect:true,
			fullWidthRows:true,
			autoLoad:false,
			nowrap:true,
			params:function(){
			},
			plugins:[pg]
		});
			tbAlarmEven.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
				if($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')){
					
				}else if($(e.target).is('.calss-modify') || $(e.target).is('.modify')){
					    e.stopPropagation();  //阻止事件冒泡
				    	createModalWithLoad("rest-config-edit", 600, 0, "修改事件优先级", "alarmEventDefines/edit?rowIndex=" + rowIndex, "saveConfig()", "confirm-close", "");
			            openModal("#rest-config-edit-modal", true, true);
				}else if($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')){
				}
			}).on('loadSuccess',function(e,data){
				
			}).on('loadError',function(req, error, errObj) {
 			}).load();
});
</script>
</body>
</html>