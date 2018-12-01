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
	<div id="rest-config-edit"></div>
	<div id="error-div"></div>
  <script type="text/javascript">
  var tbSecurityEven;
  $(document).ready(function() {
		// 事件展现列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'安全事件名称',name:'type',width:100,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.type != null){
						if(item.type == 1){
							return "消防火警";
						}else if(item.type ==2){
							return "消防通道堵塞";
						}else if(item.type == 3){
							return "高空抛物";
						}else if(item.type == 4){
							return "重点关注人员";
						}else if(item.type == 5){
							return "进入危险区域";
						}else if(item.type == 6){
							return "群体事件";
						}else if(item.type == 7){
							return "黑名单人员";
						}else if(item.type == 8){
							return "电梯困人";	
						}
					}  
				}},
				{title:'等级',name:'level',width:160,sortable:false,align:'left',renderer:function(val, item , rowIndex){
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
				{title:'分类',name:'category',width:100,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.category!= null){
						   if(item.category == 1){
							   return "消防安全类";
						   }else if(item.category == 2){
							   return "治安类";
						   }else if(item.category == 3){
							   return "安监类";
						   }
						}  
				}},
				{title:'修改', name:'' ,width:100, align:'left', lockWidth:true, lockDisplay: true, renderer: function(val){
					var modifyObj = '<a class="calss-modify" href="#" title="修改"><span style="font-size: 12px; color: #777; padding-right: 10px;"><img class="modify" src="${ctx}/static/img/alarm/xiugai.png"></span></a>';
					return modifyObj;
				}}
			];
			var pg = $('#pg').mmPaginator({"limitList":[20]});
			tbSecurityEven = $('#tb_groups').mmGrid({
			width:'100%',
			height:776,
			cols:cols,
			url:"${ctx}/system/securityIncident/list",
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
			
		tbSecurityEven.on('cellSelect',function(e,item,rowIndex,colIndex){
		e.stopPropagation();
		if($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')){
					
		}else if($(e.target).is('.calss-modify') || $(e.target).is('.modify')){
					 e.stopPropagation();  //阻止事件冒泡
				     createModalWithLoad("rest-config-edit", 600, 0, "修改事件优先级", "securityIncident/edit?rowIndex=" + rowIndex, "saveConfig()", "confirm-close", "");
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