<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<link href="${ctx}/static/css/pagination.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script src="${ctx}/static/js/jquery.pagination.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<style type="text/css">
.menu{
height:30px;  background-color: #fff; margin-left:8px; border: none;
		text-align:center; font-size: 14px; outline: none; margin-right: 50px;
		cursor:pointer;
}
.selected{
font-size: 14px;
color: #00BFA5;
}
.bx-controls bx-has-controls-direction bx-has-pager {
	    margin-top: -66px;
}
/* @media only screen and (max-width: 1024px) {
	.headDiv {
		margin-left: 1.2rem;
	}
	.content {
		padding-left: 0.625rem;
	}
	#setting, #fullScreen {
		width: 1rem;
		height: 1rem;
	}
	.func {
		padding: 0.625rem 0.5rem 0.625rem 0.5rem;
	}
}

@media only screen and (min-width: 1025px) {
	.headDiv {
		margin-left: 1.8rem;
	}
	.content {
		padding-left: 1.25rem;
	}
	#setting, #fullScreen {
		width: 1.2rem;
		height: 1.2rem;
	}
	.func {
		padding: 0.625rem;
	}
}

.headDiv {
	background: rgba(255, 255, 255, 0.11);
	border: 1px solid rgba(132, 199, 255, 0.2);
	border-radius: 4px;
	padding-top: 0.65rem;
	float: left;
	/* 	margin-left: 1.8rem; */
	/* overflow: hidden;
}

.headDiv .hd {
	overflow: hidden;
}

.headDiv .hd .prev, .headDiv .hd .next {
	width: 2rem;
	height: 100%;
	cursor: pointer;;
}

.headDiv .hd .prevStop {
	background-position: -60px 0;
}

.headDiv .hd .nextStop {
	background-position: -60px -50px;
}

.hd img {
display: none;
}

.hd:hover img {
	display: block;
}

.headDiv .bd {
	float: left;
	margin: 0 auto;
}

.headDiv .bd ul {
	overflow: hidden;
	zoom: 1;
}

.headDiv .bd ul li {
	margin: 0 8px;
	float: left;
	_display: inline;
	overflow: hidden;
	text-align: center;
} */
</style>
</head>
<body>
<div style="margin-top: 10px;margin-right: 10px;width: 100%;"
		class="content-default">
		<div>
		<span id="qb" class="menu" onclick="onclickInput(this)">全部</span>
		<span id="xfhj" class="menu" onclick="onclickInput(this)">消防火警</span>
		<span id="xftd" class="menu" style="" onclick="onclickInput(this)">消防通道堵塞</span>
		<span id="gkpw" class="menu"  onclick="onclickInput(this)">高空抛物</span>
		<span id="zdgz" class="menu"  onclick="onclickInput(this)">重点关注人员</span>
		<span id="jrwx" class="menu"  onclick="onclickInput(this)">进入危险区域</span>
		<span id="qtsj" class="menu"  onclick="onclickInput(this)">群体事件</span>
		<span id="hmdr" class="menu"   onclick="onclickInput(this)">黑名单人员</span>
		<span id="dtkr" class="menu" onclick="onclickInput(this)">电梯困人</span>
		</div>
			<form id="select-form" style="    margin-top: 13px;">
			<table>
				<tr>
					<td align="right" width="100">等级：</td>
					<td>
						<div id="priority-level-dropdownlist"></div>
					</td>
					<td align="right" style="width: 11rem;">开始时间：</td>
					<td><input id="startDate" name="startDate"
						class="form-control required" type="text" style="width:150px"/></td>
					<td align="right" style="width: 9rem;">结束时间：</td>
					<td><input id="endDate" name="endDate"
						class="form-control required" type="text" style="width:150px"/></td>
					<td>
					<td align="right" width="100">关注：</td>
					<td>
						<div id="attention-dropdownlist"></div>
					<td>
						<button id="btn-query" type="button"
							class="btn btn-default btn-common btn-common-green btnicons" style="margin-left: 6rem;">
                          <p class="btniconimg"><span>查询</span></p>
                     </button>

						<button id="export" name="export" type="button" class="btn btn-default btnicons" style="margin-left: 2rem;">
                    	   <p class="btniconimgexport"><span>导出</span></p>
                        </button>
					</td>
				</tr>
			</table>
		</form>
	</div>
		<div  style="margin-top: 19px;">
		</div>
	<table id="tb_groups" class="tb_groups" style="border: 1px solid; height:99%;width:99%;margin:0 auto;" >
		<tr><th rowspan="" colspan=""></th></tr>
	</table>

    <input id="category" type="text" style="display:none;"/>
	<div id="pg" style="text-align: right;"></div>
	<div id="rest-config-info"></div>
	<div id="rest-config-edit"></div>
	<div id="rest-config-relate"></div>
	<div id="rest-config-door"></div>
	<div id="show-video-dss"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
	<div id="alarm-snapshot-img"></div>
  <script type="text/javascript">
	var tbSecurityEven;
	var pieTbAccessPassGridrow;
    // 设备类型
    var levelThreeTypeObj;

    var attentionObject;
    var attention  = [
        {itemText: "请选择", itemData:""},
        {itemText: "已关注", itemData:"1"},
        {itemText: "未关注", itemData:"0"}
	];

    function onclickInput(obj){
    	$(".menu").removeClass("selected");
    	$(obj).addClass("selected");
    	var id = obj.id;
    	var category="";
		if(id == "xfhj"){
			$("#category").val("1");
			category = "1";
		}else if(id == "xftd"){
			$("#category").val("2");
			category = "2";
		}else if(id == "gkpw"){
			$("#category").val("3");
			category = "3";
		}else if(id == "zdgz"){
			$("#category").val("4");
			category = "4";
		}else if(id == "jrwx"){
			$("#category").val("5");
			category = "5";
		}else if(id == "qtsj"){
			$("#category").val("6");
			category = "06";
		}else if(id == "hmdr"){
			$("#category").val("7");
			category = "7";
		}else if(id == "dtkr"){
			$("#category").val("8");
			category = "8";
		}else if(id == "qb"){
			$("#category").val("");
		}
		// 更新列表
		pg.load({"page":1});
		tbSecurityEven.load();
    }

    function initAttention() {
        attentionObject = $("#attention-dropdownlist").dropDownList({
            inputName: "attentionName",
            inputValName: "attentionValue",
            buttonText: "",
            width: "117px",
            readOnly: false,
            required: true,
            maxHeight: 200,
            onSelect: function(i, data, icon) {},
            items: attention
        });
        attentionObject.setData("请选择" ,"", "");
    }

	function AlarmCreateImgurlsModal(rowIndex) {
		createModalWithLoad("alarm-snapshot-img", 780, 500, "告警抓拍", "alarmRecords/alarmFindSnapshotImage?rowIndex=" + rowIndex, "", "", "");
		openModal("#alarm-snapshot-img-modal", false, false);
		$('#alarm-snapshot-img-modal').on('shown.bs.modal', function() {
			loadPic();
		})
	}

	//开始时间格式年月日时分秒
	$("#startDate").datetimepicker({
		id: 'datetimepicker-startDate',
		containerId: 'datetimepicker-div',
		lang: 'ch',
		minView: "month",
		timepicker: false,
		hours12:false,
		allowBlank:true,
		format: 'Y-m-d 00:00:00',
	    formatDate: 'YYYY-mm-dd HH:mm:ss'
	});
    //结束时间格式年月日时分秒
	$("#endDate").datetimepicker({
		id: 'datetimepicker-endDate',
		containerId: 'datetimepicker-div',
		lang: 'ch',
		timepicker: false,
		hours12:false,
		allowBlank:true,
		format: 'Y-m-d 23:59:59',
	    formatDate: 'YYYY-mm-dd HH:mm:ss'
	});

    $(document).ready(function() {
        initAttention();
    	// 页面默认选中全部
    	document.getElementById('qb').className="selected menu";

		//优先级别
	    var priorityLevelItemList = new Array();
	    priorityLevelItemList[priorityLevelItemList.length]= {itemText: "请选择", itemData:""};
	    priorityLevelItemList[priorityLevelItemList.length]= {itemText: "高级", itemData:"1"};
	    priorityLevelItemList[priorityLevelItemList.length]={itemText: "中级", itemData:"2"};
	    priorityLevelItemList[priorityLevelItemList.length]={itemText: "低级", itemData:"3"};
		priorityLevelObj = $("#priority-level-dropdownlist").dropDownList({
			inputName: "priorityLevelName",
			inputValName: "priorityLevelVal",
			buttonText: "",
			width: "117px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {},
			items: priorityLevelItemList
		});
		priorityLevelObj.setData("请选择" ,"", "");

		// 事件展现列表
	    var cols = [
				{title:'id',name:'id',width:100,sortable:false,align:'left',hidden:'true'},
				{title:'发生时间',name:'recordTime',width:150,sortable:false,align:'left'},
				{title:'小区名称',name:'projectName',width:130,sortable:false,align:'left'},
				{title:'位置信息',name:'incidentLocation',width:130,sortable:false,align:'left'},
				{title:'安全事件名称',name:'incidentName',width:130,sortable:false,align:'left'},
				{title:'等级',name:'level',width:100,sortable:false,align:'left',renderer:function(val, item , rowIndex){
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
				{title:'分类',name:'categoryName',width:100,sortable:false,align:'left'},
				{title:'监测设备名称',name:'deviceName',width:100,sortable:false,align:'left'},
				{title : '抓拍',name : 'imgurls',width : 50,sortable : false,align : 'left',renderer : function(val, item, rowIndex) {
						if (item.imgurls != undefined && item.imgurls.length > 0) {
							return '<img id="" src="${ctx}/static/images/icon34.png" />';
						} else {
							return "无";
						}
					}
				},
				{title : '回放',name : 'deviceId',width : 50,sortable : false,align : 'left',renderer : function(val, item, rowIndex) {
				    var retrunObj;
				    if (item.deviceId) {
				        returnObj = '<a class="calss-menu" href="#" title="回放"><img class="glyphicon-list-alt" ' +
							'src="${ctx}/static/images/playback.svg" /></a>';
					} else {
				        returnObj = "无回放";
				    }
					return returnObj;
				}},
                {
                    title: '关注',
                    name: 'attention',
                    width: 50,
                    sortable: false,
                    align: 'left',
                    renderer: function (val,item, rowIndex) {
                        var result;
                        if (item.attention == 1) {

                            result =
                                '<div onclick="attentionIncident(' + item.id + ',' + 0 + ')" style="width: 60px;height: 20px;border: 1px solid #00BFA5;border-radius: 2px;cursor:pointer">' +
                                '<div style="float:left;width:20px;height:20px"><img src="${ctx}/static/images/hvac/attentioned.svg" style="margin-left: 7px;margin-bottom:10px"/></div>' +
                                '<div style="float:left;font-size: 12px;color: #00BFA5;line-height: 18px;text-align: center;">已关注</div></div>';
						} else {
                            result =
                                '<div onclick="attentionIncident(' + item.id + ',' + 1 + ')" style="width: 60px;height: 20px;border: 1px solid #F5A623;border-radius: 2px;cursor:pointer">' +
                                '<div style="float:left;width:26px;height:20px"><img src="${ctx}/static/images/hvac/attention.svg" style="margin-left: 7px;margin-bottom:10px"/></div>' +
                                '<div style="float:left;font-size: 12px;color: #F5A623;line-height: 18px;text-align: center;">关注</div></div>';
                        }
                        return result;
                    }
                }
				];
			pg = $('#pg').mmPaginator({"limitList":[20]});
			tbSecurityEven = $('#tb_groups').mmGrid({
			width:'100%',
			height:776,
			cols:cols,
			url:"${ctx}/system/securityIncident/securityDataList",
			method:'get',
			remoteSort:false,
			showBackboard:false,
			sortName:'id',
			sortStatus:'desc',
			multiSelect:true,
			fullWidthRows:true,
			autoLoad:false,
			nowrap:true,
			params:function(){
				var typeId = $("#category").val();
				var startDate = $("#startDate").val();
			    var endDate = $("#endDate").val();
			    var level = $("#priorityLevelVal").val();
			    var attention = $("#attentionValue").val();
				data = {};
				if (projectId != "" && projectId != undefined){
					$(data).attr({"projectId": projectId});
				}
				if (startDate != ""){
					$(data).attr({"startTime": startDate});
				}
				if (endDate != ""){
					$(data).attr({"endTime": endDate});
				}
				if(typeId!=""){
					$(data).attr({"typeId": typeId});
				}
				if(level!=""){
					$(data).attr({"level": level});
				}
				if(attention!=""){
					$(data).attr({"attention": attention});
				}
				return data;
			},
			plugins:[pg]
		});
			
			//数据操作
			tbSecurityEven.on('cellSelect',function(e,item,rowIndex,colIndex){
				pieTbAccessPassGridrow = tbSecurityEven.row(rowIndex);
				e.stopPropagation();
				if($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')){
					
				}else if($(e.target).is('.calss-modify') || $(e.target).is('.glyphicon-pencil')){
				}else if($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')){
				}else if ($(e.target).is('.calss-menu') || $(e.target).is('.glyphicon-list-alt')) {
					playBack(rowIndex);
				}
			}).on('doubleClicked',function(e, item, rowIndex, colIndex) {
				if (pieTbAccessPassGridrow.imgurls != undefined && pieTbAccessPassGridrow.imgurls.length > 0 && pieTbAccessPassGridrow.imgurls != "null") {
					AlarmCreateImgurlsModal(rowIndex);
				}
			}).on('loadError',function(req, error, errObj) {
				showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
			}).load();
			
			
		});
    
    //获取安全事件记录数量
    getSecurityRecordCount();
    
    //按钮查询
	$("#btn-query").on('click',function (){
		pg.load({"page":1});
		tbSecurityEven.load();
	});	
	
	//视频回放
	function playBack(rowIndex){
    	var row = tbSecurityEven.row(rowIndex);
    	if(row.deviceId){
        	createModalWithLoad("show-video-dss", 730, 500, "视频回放",
        			"videomonitoring/showDssVideo?type=1&deviceNo="+ row.deviceId +"&playbackTime=" + encodeURI(row.recordTime), "", "", "","");
    	}
    }

    function attentionIncident (incidentId,attention) {
        $.ajax({
            type: "post",
            url: "${ctx}/system/securityIncident/attentionIncident/" + incidentId,
            data: {
                attention: attention
            },
            success: function () {
                tbSecurityEven.load();
                if (attention == 1) {
                    showDialogModal("error-div", "提示", "关注成功");
                } else if (attention == 0) {
                    showDialogModal("error-div", "提示", "成功取消关注");
                }
                return true;
            },
            error: function (req, error, errObj) {
                showDialogModal("error-div", "操作错误", errObj);
                return;
            }
        });

    }
	
	//获取安全事件数量
	function getSecurityRecordCount(){
			//获取一级分类下的信息
			$.ajax({
				type: "post",
				url: "${ctx}/system/securityIncident/listSecurityRecordCount?projectId="+projectId,
				async: false,
				contentType: "application/json;charset=utf-8",
				success: function(data) {
					var result = JSON.parse(data);
					$("#xfhj").append("(" + result.xfhj + ")");
					$("#xftd").append("(" +result.xftd+ ")");
					$("#gkpw").append("(" +result.gkpw+ ")");
					$("#zdgz").append("(" +result.zdgz+ ")");
					$("#jrwx").append("(" +result.jrwx+ ")");
					$("#qtsj").append("(" +result.qtsj+ ")");
					$("#hmdr").append("(" +result.hmdr + ")");
					$("#dtkr").append("(" +result.dtkr + ")");
					$("#qb").append("(" +result.qb + ")" );
							
				},error: function(req, error, errObj) {
					
				}
		});
	}
	
	$('#export').on('click',function(){
		exportExecl();
		});
	
	//导出excel
	function exportExecl() {
		var typeId = $("#category").val().trim();
		var startDate = $("#startDate").val().trim();
	    var endDate = $("#endDate").val().trim();
	    var level = $("#priorityLevelVal").val().trim();
        var attention = $("#attentionValue").val();
	    
		var url = "${ctx}/system/securityIncident/securityRecordExecl";
		var prams = "?projectId=" + projectId +"&typeId=" + typeId + "&startDate=" + startDate+  "&endDate=" + endDate
				+"&pageNumber=1&pageSize=500&sortType=desc&sortName=deviceNo&attention=" + attention;
		window.open(url + prams);
	}
</script>
</body>
</html>