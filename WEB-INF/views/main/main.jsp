<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<% 
	String systemName = StaticDataUtils.getSystemName(); 
	String copyright = StaticDataUtils.getCopyright();
	Object isExtNetObj = request.getSession().getAttribute("isExtNet");
	boolean isExtNet = false;
	if (isExtNetObj != null ){
	    isExtNet=(Boolean)isExtNetObj;
	}
	String imageServerAddress = (String)request.getSession().getAttribute("IMAGE_SERVER_ADDRESS");
	String mappingImageAddress = (String)request.getSession().getAttribute("MAPPING_IMAGE_ADDRESS");
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
  <head>
    <title><%=systemName %></title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta http-equiv="Cache-Control" content="no-store" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
    <link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/styles/iconic.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/mmgrid/mmGrid.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/mmgrid/mmPicture.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/mmgrid/mmPaginator.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/mmgrid/theme/bootstrap-rib/mmGrid-bootstrap-rib.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/mmgrid/theme/bootstrap-rib/mmPaginator-bootstrap-rib.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/bootstrap/buttons.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery-ztree/3.5.17/css/zTreeStyle.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery-datetimepicker/2.1.9/css/jquery.datetimepicker.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/bootstrap-switch/3.3.2/css/bootstrap3/bootstrap-switch.min.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery-icheck/1.0.2/css/all.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/accordion-menu/css/accordion-menu.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/styles/accordion-1-menu.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/dynamic-table-processor/css/dynamicTableProcessor.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/simple-report/css/simple-report.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery.shutter/css/jquery.shutter.css" type="text/css" rel="stylesheet" />
   	<link href="${ctx}/static/component/dynamic-report-processor/css/photo.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery-autocomplete/1.1.2/css/jquery.autocomplete.css" rel="stylesheet" />
	<link href="${ctx}/static/component/tree-selecter/css/treeSelecter.css" rel="stylesheet" />
	<link href="${ctx}/static/css/theme/hsMain.css" rel="stylesheet" />
<!-- 	电梯、消防视频弹窗 -->
	<link href="${ctx}/static/css/cloudModleIframeBlue.css" type="text/css" rel="stylesheet" />
	<link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet" />
	
    <script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-load-resource/js/dynamicLoadResource.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/mmgrid/mmGrid.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/mmgrid/mmPaginator.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-ztree/3.5.17/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-ztree/3.5.17/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/public.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/HashMap.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/wadda/commons.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/wadda/wadda.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-dropdownlist/jquery.dropdownlist.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-datetimepicker/2.1.9/js/jquery.datetimepicker.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/bootstrap-switch/3.3.2/js/bootstrap-switch.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-icheck/1.0.2/js/icheck.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/accordion-menu-1.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/echarts/echarts.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-uniform/2.1.2/js/jquery.uniform.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-table-processor/js/dynamicTableProcessor.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-table-processor/js/dynamicTableProcessor2.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-report-processor/js/dynamicReportProcessor.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/simple-report/js/simple-report.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery.shutter/js/jquery.shutter.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/grid-operation/js/grid-operation.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/tree-selecter/js/treeSelecter.js" type="text/javascript"></script>
    <script type="text/javascript"	src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
	<script type="text/javascript"	src="${ctx}/static/websocket/stomp.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/video-player/js/webVideoCtrl.js"></script>
    <script type="text/javascript" src="${ctx}/static/busi/ffmVideoMonitor.js"></script>
    <script type="text/javascript" src="${ctx}/static/busi/main.js"></script>
    <!--[if lte IE 9]>
    <script src="${ctx}/static/compatible/respond.min.js"></script>
    <script src="${ctx}/static/compatible/html5shiv.min.js"></script>
    <![endif]-->
<style type="text/css">
#ffm-event-error-div-modal-content {
	margin-top: 252px;
}
</style>

</head>

  <body class="project-main-body">
    <div id="part1" style="position: relative; height: 81px; width: 240px; z-index: -9; outline: medium none !important;background: #162D39;box-shadow: 0 4px 12px 0 rgba(0,0,0,0.20);">
      <div id="projectLogo" style="background-size:100%; background-position: center left; height: 80px; margin-left: 50px;background-repeat: no-repeat;width:144px;"></div>
    </div>
    <div id="part2" class="navbar user-nav" style="position: absolute; left: 238px; top: 0px; z-index: 20; margin: 0px; overflow: visible; outline: medium none">
    <!-- 组织信息 隐藏 -->
		<div style="display: none;">
			<ul class="nav">
				<li id="user-messages" class="dropdown"><a title="" href="#"
					data-toggle="dropdown" data-target="#user-messages"
					class="dropdown-toggle" style="background-color: #2E363F;"> <span
						class="icon icon-user"></span> <span class="text">欢迎：<shiro:principal
								property="name" /></span> <span id="operator-id" style="display: none"><shiro:principal
								property="id" /></span> <span id="login-name" style="display: none"><shiro:principal
								property="loginName" /></span> <b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li><a id="a-change-password" href="#"><span
								class="glyphicon glyphicon-pencil"
								style="color: #555; font-size: 13px; margin-right: 6px;"></span>修改密码</a>
						</li>
						<li role="separator" class="divider"></li>
						<li><a href="${ctx}/logout"><span
								class="glyphicon glyphicon-log-out"
								style="color: #555; font-size: 13px; margin-right: 6px;"></span>注销</a>
						</li>
					</ul></li>
				<li id="org-messages" class="dropdown"><a id="a-login-org"
					title="" href="#" data-toggle="dropdown"
					data-target="#org-messages" class="dropdown-toggle"
					style="background-color: #2E363F;"> <span
						id="login-organize-id" style="display: none"><shiro:principal
								property="organizeId" />^<shiro:principal
								property="organizeType" /></span>登录组织： <span id="login-organize-name"><shiro:principal
								property="organizeName" /></span><b class="caret"></b>
				</a>
					<div id="select-operator-org"></div></li>
				<li id="search-menu" class="dropdown"><span
					class="glyphicon glyphicon-search form-control-feedback"
					style="color: #ccc; font-size: 16px;"></span> <input
					id="menu-search-value" name="menu-search-value"
					style="padding: 10px 30px 7px 10px; width: 250px; height: 37px; background-color: #555; border-width: 0px; color: #ccc"
					placeholder="輸入菜单名查詢……" /></li>
			</ul>

		</div>
      <div class="head">
			<div class="menu_head" id="project_menu_head">
<%-- 			<ul class="navbar-nav" >
			<li class="dropdown" style ="display: none;">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown">
				<div class="menu_item">
					<div style="width: 100%; height: 0.5rem; background: #00BFA5;"></div>
					<table>
						<tr class="first_one">
							<td align="center"><img src="${ctx}/static/icon/index/xiaofang.svg" /></td>
						</tr>
						<tr class="second"><td  align="center">消防系统</td></tr>
					</table>
				</div>
				</a>
				<ul class="dropdown-menu">
					<li><a href="#">消费报警联动系统</a></li>
					<li class="divider"></li>
					<li><a href="#">消费水系统</a></li>
				</ul>
			</li>
			</ul>
			<ul class="navbar-nav" >
			<li class="dropdown">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown">
				<div class="menu_item">
					<div style="width: 100%; height: 0.5rem; background: #00BFA5;"></div>
					<table>
						<tr class="first_one">
							<td align="center"><img src="${ctx}/static/icon/index/dianti.svg" /></td>
						</tr>
						<tr class="second"><td  align="center">电梯系统</td></tr>
					</table>
				</div>
			</a>
				<ul class="dropdown-menu">
					<li><a href="#">实时统计</a></li>
					<li class="divider"></li>
					<li><a href="#">统计分析</a></li>
				</ul>
			</li>
				<div class="menu_item">
					<div style="width: 100%; height: 0.5rem; background: #00BFA5;"></div>
					<table>
						<tr class="first_one">
							<td align="center"><img src="${ctx}/static/icon/index/gongpeidian.svg" /></td>
						</tr>
						<tr class="second"><td  align="center">供配电系统</td></tr>
					</table>
				</div>
				<div class="menu_item">
					<div style="width: 100%; height: 0.5rem; background: #4DA1FF;"></div>
					<table>
						<tr class="first_one">
							<td align="center"><img src="${ctx}/static/icon/index/tingche.svg" /></td>
						</tr>
						<tr class="second"><td  align="center">停车系统</td></tr>
					</table>
				</div>
				<div class="menu_item">
					<div style="width: 100%; height: 0.5rem; background: #4DA1FF;"></div>
					<table>
						<tr class="first_one">
							<td align="center"><img src="${ctx}/static/icon/index/renxing.svg" /></td>
						</tr>
						<tr class="second"><td  align="center">人行系统</td></tr>
					</table>
				</div>
				<div class="menu_item">
					<div style="width: 100%; height: 0.5rem; background: #4DA1FF;"></div>
					<table>
						<tr class="first_one">
							<td align="center"><img src="${ctx}/static/icon/index/jiankong.svg" /></td>
						</tr>
						<tr class="second"><td  align="center">视频监控</td></tr>
					</table>
				</div>
				<div class="menu_item">
					<div style="width: 100%; height: 0.5rem; background: #ED5E5E;"></div>
					<table>
						<tr class="first_one">
							<td align="center"><img src="${ctx}/static/icon/index/kongtiao.svg" /></td>
						</tr>
						<tr class="second"><td  align="center">暖通空调</td></tr>
					</table>
				</div>
				<div class="menu_item">
					<div style="width: 100%; height: 0.5rem; background: #ED5E5E;"></div>
					<table>
						<tr class="first_one">
							<td align="center"><img src="${ctx}/static/icon/index/jishuipai.svg" /></td>
						</tr>
						<tr class="second"><td  align="center">给水排系统</td></tr>
					</table>
				</div>
				<div class="menu_item">
					<div style="width: 100%; height: 0.5rem; background: #ED5E5E;"></div>
					<table>
						<tr class="first_one">
							<td align="center"><img src="${ctx}/static/icon/index/zhaoming.svg" /></td>
						</tr>
						<tr class="second"><td  align="center">照明系统</td></tr>
					</table>
				</div>display:none;
			</ul>
	 --%>		</div>
			<div class="time_head">
				<div class="week">
					<div style="height: 80px; vertical-align: middle; display: table-cell;">
						<table style="height: 80%;"><tr><td id="weak"></td></tr><tr><td id="ymdhms"></td></tr></table></div>
				</div>
			</div>
			<div id="user_setting" style="float: left; width: 10.83rem; height: 100%;">
				<div style="display: table-cell; vertical-align: middle;padding-left: 20px; width: 130px; height: 80px;">
					<img id ="user_login" style="vertical-align: middle;cursor: pointer;" alt="" src="${ctx}/static/group/yonghu.png">
				</div>
				<ul id="ul_user_setting" style="width:130px;height: 80%;background-color: #FFF;min-width: 10rem;padding: 0;display:none;">
					<li style="height: 50%;list-style-type:none;text-align: center;vertical-align: middle;">
						<a id="p-change-password" href="#" style="font-size: 14px;color: #6D6D6D;letter-spacing: 0;display:block;padding-top: 10px;height: 100%;">修改密码</a>
					</li>
					<li style="height: 50%;list-style-type:none;text-align: center;vertical-align: middle;">
						<a href="${ctx}/logout" style="font-size: 14px;color: #6D6D6D;letter-spacing: 0;display:block;height: 100%;padding-top: 10px;">注销</a>
					</li>
				</ul>
			</div>
		</div>
    </div>
    <div id="div-menu-object" style="display: block; float: left; position: relative; width: 100px; z-index: 16; outline: medium none"></div>
    <div id="content" class="project-main-content">
      <div id="content-header" style="width: 100%; margin-top: 0px; z-index: 20; outline: medium none;height:38px;">
        <div id="breadcrumb" class="nav-breadcrumb"></div> 
      </div>
      <div id="container-fluid" style="padding-right: 20px; padding-left: 20px;">
        <div id="content-page" class="clearfix" style="height: auto; width: 100%; padding-top: 15px;"></div>
      </div>
    </div>
    <%-- <div style="width: 100%; outline: medium none">
      <div style="padding: 10px; text-align: center; margin-left: 0px; width: 100%; display: block; float: left; min-height: 30px; box-sizing: border-box; color: #FFF">
        <%=copyright %>
      </div>
    </div> --%>
    <div id="login-org"></div>
    <div id="login-operator"></div>
    <div id="change-password"></div>
    <div id="error-div"></div>
	<div id="homepage-edit"></div>
	<div id="show-alarm-video"></div>
	<div id="fires-alarm-video"></div>
	<div id="ffm-event-error-div"></div>
    <script>
    var menuMap = new HashMap();
    var ctx = '${ctx}';
    isValidPageWhenFlush();
	var projectCode = "${param.projectCode}";
	var projectId = "${param.projectId}";
	var isConnectedIbElevator = false;
	//缓存设备id数组
	var elevatorDevice = new Array();
	//缓存消防设备监控数组
	var firesVideoDeviceMap = new HashMap();
	var firesVideoDeviceList = new Array();
	var doorBlockDeviceList = new Array();
	var isShowFiresVideo = false;
	//消防推送视频弹窗id
	var tempCameraId = null;
	//消防选择的摄像机id缓存
	var cameraDeviceId = null;
	//电梯告警弹窗打开状态0关闭1打开
	var elevatorIsOpen = 0;
	//判断是否产生新的电梯困人告警数据：0否1是
	var isNewAlarm = 0;
	//电梯视频弹窗
	var elevatorList = new Array();
	var cameraDeviceId = null;
	var elevator = null;
	var elevatorName = null;
	var elevatorAlarmName = null;
	var elevatorFloorDisplaying = null;
	var elevatorRunningState = null;
	var cameraStatus = null;
	
    if(projectCode == null||projectCode == ''||projectCode == 'null'){//session过期，跳转到集团首页
    	window.location = ctx + "/projectPage";
    }
    // 禁止页面后退功能（防止退格键导致页面退回到登录界面）
    document.onkeypress = banBackSpace;
    document.onkeydown = banBackSpace;
    // document.onkeydown = disableBackHistory;
    function banBackSpace(e) {
    	var event = e || window.event;
    	var obj = event.target || event.srcElement;
        if (((event.keyCode == 8) && //BackSpace 
                ((obj.type != "text" && obj.type != "textarea" && obj.type != "password") || obj.readOnly == true))) {
            event.keyCode = 0; 
            event.returnValue = false;
            return false;
        }
        return true;
    }

    var tokenKey = "<%=request.getSession().getAttribute("TOKEN_KEY") == null ? "" : request.getSession().getAttribute("TOKEN_KEY") %>";
    var sessionID = "<%=request.getSession().getId() == null ? "" : request.getSession().getId() %>";
    var currentMenuObj;
    $(window).resize(function() {
        $("#content").css("min-height", (parseInt($(window).height()) - 40) + "px");
        $("#content-iframe").css("height", (parseInt($(window).height()) - 155) + "px");
        var height = $(this).height();
    	if(height>1070){
    		document.documentElement.style.overflowY = 'hidden';
    	}else{
    		document.documentElement.style.overflowY = 'auto';
    	}
    });

    function setProjectLogo(){
    	//火炬小区设置logo
    	if(projectCode=="HUOJUXIAOQU"){
    		$("#projectLogo").css("background-image","url('${ctx}/static/group/huojuxiaoqu.svg')");
    	}else if(projectCode =="XIZIGUOJI"){
    		$("#projectLogo").css("background-image","url('${ctx}/static/group/greentownlogo1.svg')");
    	}else if(projectCode =="WJJY"){
    		$("#projectLogo").css("background-image","url('${ctx}/static/group/wujiangjiayuan.svg')");
    	}
    }
    
    $(document).ready(function() {
    	setProjectLogo();
    	showTime();
    	hiddenScroller();
    	$("#content").css("width",function () { return $(document).width()-100; });
        $("body").css("display","none");
        $("body").fadeIn("normal");
        $("a[target],a[href*='javascript'],a.lightbox-processed,a[href*='#']").addClass("speciallinks");
        $("a:not(.speciallinks)").click(function(){
            $("body").fadeOut("normal");
            $("object,embed").css("visibility","hidden");
        });
        
        $.ajaxSetup({
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            complete : function(xhr, textStatus) {
                //session timeout
                if (xhr.status == 911) {
                    window.location = "${ctx}/logout"; //返回应用首页
                    return;
                }
            }
        });

        $("#div-menu-object").accordion1({
            url: "projectMain/getMenus?organizeId=" + projectId,
            goPage: function(id, name, icon, url) {
                createPage(id, name, icon, url);
            }
        }).init();

        $("#content").css("min-height", (parseInt($(window).height()) - 40) + "px");

        createBreadcrumb(null, null);

        // 设置组织id、组织类型及组织名称
        var organizeInfo = $("#login-organize-id").text().split("^");
        var organizeId = organizeInfo[0];
        var organizeType = organizeInfo[1];
        var organizeName = $("#login-organize-name").text();
        $("#login-org").data("orgId", organizeId);
        $("#login-org").data("organizeType", organizeType);
        $("#login-org").data("organizeName", organizeName);
        $("#login-org").data("userOrganizeId", organizeId);
        $("#login-org").data("userOrganizeType", organizeType);
        $("#login-org").data("userOrganizeName", organizeName);

        // 设置操作员id
        var operatorId = $("#operator-id").text();
        var loginName = $("#login-name").text();
        $("#login-operator").data("operatorId", operatorId);
        $("#login-operator").data("loginName", loginName);

        // 创建首页
        createMainPage();

        // 设置主题
        var theme = getTheme();
        dynamicLoadResource.css("${ctx}/static/styles/theme/rib-green" + ".css");

        // 菜单搜索框
        $("#menu-search-value").AutoComplete({
            data: "${ctx}/projectMain/getMenusByName?funcName=" + $("#menu-search-value").val(),
            width: 'auto',
            ajaxDataType: 'json',
            emphasis: false,
            listStyle: 'custom',
            matchHandler: function(keyword, data) {
                return true;
            },
            createItemHandler: function(index, data){
                return "<span style='color: #333;'>" + data.pathName+"</span>";
	        },
            afterSelectedHandler: function(data) {
            	createPage(data.id, data.name, data.icon, data.url);
            }
        }).AutoComplete('show');
        setTimeout(startConn, 1000);
		//获取消防视频弹窗摄像头
// 		setTimeout("getAllFireFightingCameras()",5000);
    	
    });
    //点击用户图片弹出密码修改和注销下拉菜单
	$("#user_login").click(function(){
		//弹出修改密码和注销下拉框
		$("#ul_user_setting").toggle();
	});
	//点击其他区域密码修改和注销下拉菜单消失
	$(document).click(function(e){
		var id=$(e.target).attr("id");
		 if(id!="user_login"){
		    $("#ul_user_setting").hide();
		 }
	});
	//弹出修改密码窗口
    $("#p-change-password").on("click", function() {
    	createModalWithLoad("change-password", 400, 250, "修改密码", "operatorManage/changePassword", "updatePassword()", "confirm-close", "");
        $("#change-password-modal").modal("show");
        $("#ul_user_setting").css("display","none");
    });

    $("#a-login-org").on("click", function() {
        var organizeId = $("#login-org").data("userOrganizeId");
        var organizeType = $("#login-org").data("userOrganizeType");
        var organizeName = $("#login-org").data("userOrganizeName");
        createModalWithIframe("select-operator-org", 800, 520, "选择组织", "organizeSelect/tree", "receiveLoginOrganizeInfo()", "close", "organizeType=" + organizeType + "&organizeId=" + organizeId + "&organizeName=" + organizeName + "&iframeCallbackFunction=receiveLoginOrganizeInfo");
        $("#select-operator-org-modal").modal("show");
    });

    function createMainPage() {
        var organizeId = $("#login-org").data("orgId");
        var organizeType = $("#login-org").data("organizeType");
        var homepage = $.trim(getHomepage(organizeId));
        $("#content-header").hide();
        $("#breadcrumb").hide();
       //var homepage = "/projectPage/V4?projectId=";
        if (homepage && homepage.length > 0) {
            $("#content-page").load(getAppName() + homepage);
           // $("#content").css("background","#404D5A");
           // $("#breadcrumb").css("border-bottom","1px solid #e3ebed");
            $("#container-fluid").css("padding-left","0px");
            $("#container-fluid").css("padding-right","0px");
        } else {
            $("#content-page").html("");
        }
    }

    /**
     * 获取主页url
     * @organizeId 组织ID
     */
    function getHomepage(organizeId) {
    	var url = "";
    	$.ajax({
    		type: "post",
    		url: "${ctx}/organizeManage/getOrganizeAttribute?organizeId=" + organizeId + "&attributeCode=HOME_PAGE", 
    		contentType: "application/json;charset=utf-8",
    		async: false,
    		success: function(data) {
    			if (data && data.length > 0) {
    				var map = JSON.parse(data);
    				if(map[projectId]){
    					url = map[projectId] + projectId;
    				}else{
    					url = map["default"] + projectId;
    				}
    				
    			}
    		},
    		error: function(req, error, errObj) {

    		}
    	});
    	return url;
    }

    function receiveLoginOrganizeInfo() {
        var lastSelectedOrg = $("#select-operator-org-iframe")[0].contentWindow.lastSelectedOrg;
        $("#login-organize-name").text(lastSelectedOrg.organizeName);
        $("#login-org").data("orgId", lastSelectedOrg.organizeId);
        $("#login-org").data("organizeName", lastSelectedOrg.organizeName);
        $("#login-org").data("organizeType", lastSelectedOrg.organizeType);
        $("#select-operator-org-modal").modal("hide");

        // 恢复菜单
        var submenus = $(".submenu");
        if (submenus && submenus.length > 0) {
            $.each(submenus, function(n, value) {
                if ($(value).hasClass("open")) {
                    $(value).removeClass("open");
                    var ul = $(value).children("ul");
                    ul.css("display", "none");
                    $.each(ul.children("li .active"), function(m, li) {
                        $(li).removeClass("active");
                    });
                }
            });
        }

        createBreadcrumb(null, null);

        // 重置首页
        createMainPage();
    }

    function getOrganizeId() {
        return $("#login-org").data("orgId");
    }

    function getOrganizeType() {
        return $("#login-org").data("organizeType");
    }
    
    function getOrganizeName() {
        return $("#login-org").data("organizeName");
    }
    
    function isValidPageWhenFlush() {
    	if("${param.projectCode}"==""||"${param.projectId}"==""){
    		showDialogModal("error-div", "操作提示", "页面路径已变更，将返回集团首页！",2,"redirectGroupPage();");
    	}
    }
    
    function redirectGroupPage(){
    	window.location.href=ctx+"/projectPage";
    }

    function createPage(id, name, icon, url) {
    	if (!url || url.length < 0 ) {
    		return;
    	}

    	// 记录当前菜单对象
    	currentMenuObj = {id: id, name: name, icon: icon, url: url};

    	// 处理组织选择逻辑
    	if (!dealOrganizeSelect(url)) {
    		return;
    	}

    	// 处理单点登录URL
    	url = dealSSO(url);
    	
    	//内嵌项目URL（每个项目地址不一样）
    	url = dealProjectUrl(id,url);
    	if(url==null||url==""){
    		url = "/projectPage/noDataPage";
    		currentMenuObj.url = url;
    	}
    	// 新窗口打开页面
    	if (openNewWindow(url)) {
    		return;
    	}
    	// 加载液面 
    	loadPage();
    }

    /**
     * 单点登录处理
     * @url 请求链接
     */
    function dealSSO(url) {
    	var isSSO = getUrlParam(url, "isSSO");
    	var tokenCert = getUrlParam(url, "tokenCert");
    	var tokenKeyName = getUrlParam(url, "tokenKeyName");

    	if (isSSO && isSSO == "Y") {
    		if (tokenCert && tokenCert.length > 0) {
    			var loginName = $("#login-operator").data("loginName");
    			url += "&" + tokenCert + "=" + loginName;
    		}
    		if (tokenKeyName && tokenKeyName.length > 0) {
    			url += "&" + tokenKeyName + "=" + getToken(url);
    		}
    	}
    	currentMenuObj.url = url;console.info(url);
    	return url;
    }
    
    /**
     * 项目URL处理
     * @url 请求链接
     */
    function dealProjectUrl(id,url) {
    	var isProjectUrl = getUrlParam(url, "isProjectUrl");
    	if (isProjectUrl && isProjectUrl == "Y") {
    		$.ajax({
    			type : "post",
    			url : ctx + "/secFunctionProject/getProjectUrl?functionId="+id+"&projectCode="+projectCode,// TODO需要添加项目编号
    			async : false,
    			dataType : "json",
    			contentType : "application/json;charset=utf-8",
    			success : function(data) {
    				if (data && data.CODE && data.CODE == "SUCCESS") {
    					url = data.RETURN_PARAM;

    				} 
    			},
    			error : function(req, error, errObj) {
    			}
    		});
    	}
		currentMenuObj.url = url;
		return url;
    }

    function getToken(url) {
    	var tokenType = getUrlParam(url, "tokenType");
    	if (tokenType && tokenType == "TOKENKEY") {
    		return tokenKey;
    	} else if (tokenType && tokenType == "SESSIONID") {
    		return sessionID;
    	}
    }

    /**
     * 是否新窗口打开：URL中isNewWindow参数为Y，则打开新窗口
     * @url 待处理的URL
     */
    function openNewWindow(url) {
    	var isNewWindow = getUrlParam(url, "isNewWindow");
    	if (isNewWindow && isNewWindow == "Y") {
    		if (url.indexOf("/") == 0) {
                url = getAppName() + url;
            }
    		url =  url.replace("&isNewWindow=Y","");
    		window.open(url);
    		return true;
    	}

    	return false;
    }
    
    function loadPage() {
    	var id = currentMenuObj.id;
    	var name = currentMenuObj.name;
    	var icon = currentMenuObj.icon;
    	var url = currentMenuObj.url;

    	if (url.indexOf("/") == 0) {
            url = getAppName() + url;
        }
    	
    	try {
    		if(typeof(eval("unloadAndRelease")) == "function") {
                unloadAndRelease();
            }
        } catch(e) {}
    	$("#content-header").show();
    	$("#breadcrumb").show();
        $("#content").css("background","#EEE none repeat scroll 0px 0px");
        $("#breadcrumb").css("background-color","#fff");
        $("#breadcrumb").css("border-bottom","1px solid #e3ebed");
        $("#container-fluid").css("padding-left","20px");
        $("#container-fluid").css("padding-right","20px");
        if (url.indexOf("http") != 0) {
            $("#content-page").load(url, function() {
                $(".modal").on('show.bs.modal', function (e) {
                    $('.modal').each(function(i) {
                        var $clone = $(this).clone().css('display', 'block').appendTo('body');
                        var marginTop = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 4);
                        marginTop = marginTop > 10 ? marginTop : 0;
                        $clone.remove();
                        $(this).find('.modal-content').css("margin-top", marginTop);
                    });
                });
            });
        } else {
            var innerHtml = new StringBulider();
            innerHtml.append("<iframe id='content-iframe' src='" + url + "' scrolling='auto' style='width: 100%; height: 100%; padding-top: 15px;'></iframe>");
            $("#content-page").html(innerHtml.toString());
            $("#content-iframe").css("height", (parseInt($(window).height()) - 165) + "px");
        }
        createBreadcrumb(name, icon);
    }

    function dealOrganizeSelect(url) {
    	var requiredOrganizeType = getUrlParam(url, "requiredOrganizeType");
    	var requiredOrganizeTypeName = getUrlParam(url, "requiredOrganizeTypeName");
    	if (requiredOrganizeType) {
    		if (getOrganizeType() != requiredOrganizeType) {
    			var organizeId = $("#login-org").data("userOrganizeId");
    	        var organizeType = $("#login-org").data("userOrganizeType");
    	        var organizeName = $("#login-org").data("userOrganizeName");
    	        var params = "organizeType=" + organizeType + "&organizeId=" + organizeId + "&organizeName=" + organizeName + "&iframeCallbackFunction=checkOrganizeInfo&requiredOrganizeType=" + requiredOrganizeType + "&requiredOrganizeTypeName=" + requiredOrganizeTypeName;
    	        createModalWithIframe("select-operator-org", 800, 520, "选择组织", "organizeSelect/tree", "", "", params);
    	        $("#select-operator-org-modal").modal("show");
    	        return false;
    		}
    	}
    	return true;
    }

    function checkOrganizeInfo() {
        var lastSelectedOrg = $("#select-operator-org-iframe")[0].contentWindow.lastSelectedOrg;
        if (lastSelectedOrg.organizeType != lastSelectedOrg.requiredOrganizeType) {
        	showDialogModal("error-div", "操作提示", "请选择类型为" + lastSelectedOrg.requiredOrganizeTypeName + "的组织");
        	return;
        }
        $("#login-organize-name").text(lastSelectedOrg.organizeName);
        $("#login-org").data("orgId", lastSelectedOrg.organizeId);
        $("#login-org").data("organizeName", lastSelectedOrg.organizeName);
        $("#login-org").data("organizeType", lastSelectedOrg.organizeType);
        $("#select-operator-org-modal").modal("hide");

        loadPage();
    }

    function createBreadcrumb(name, icon) {
        var innerHtml = new StringBulider();
        innerHtml.append("<a href='${ctx}/main?projectCode="+projectCode+"&projectId="+projectId+"'>").append('<span class="icon glyphicon glyphicon-home" style="padding-right: 10px;"></span>').append("首页</a>");
        if (name && name.length > 0) {
            innerHtml.append("<a href='#'>").append("<span class='icon ").append(icon).append("' style='padding-right: 10px; font-size: 16px;'></span><font style='font-weight: bold;'>").append(name).append("</font></a>");
        }
        $("#breadcrumb").html(innerHtml.toString());
    }
    
    $(document).on('input propertychange', '.form-control', function(e) {
        var value = "";
        if($.browser && $.browser.msie) {
            value = e.srcElement.value;
        } else {
            value = e.target.value;
        }
        if (value.length != 0) {
            removeAllAlert();
        }
    });
    
    function extNetImageMapping(src){
    	if(src==null||src==""|| typeof(src) == "undefined"){
    		return "";
    	}
    	var isExtNet = <%=isExtNet%>;
    	var imageServerAddress = "<%=imageServerAddress%>";
    	var mappingImageAddress = "<%=mappingImageAddress%>";
    	if(imageServerAddress == null || imageServerAddress == "" || mappingImageAddress == null || mappingImageAddress == ""){
    		return src;
    	}
    	if(isExtNet){
    		var e=new RegExp(imageServerAddress,"g");
    		return src.replace(e,mappingImageAddress);
    	}
    	return src;
    }
    
    function showTime() {
		var show_day = new Array('星期日','星期一', '星期二', '星期三', '星期四', '星期五', '星期六');
		var today = new Date();
		var s = today.getSeconds();
		var year = today.getFullYear();
		var month = today.getMonth() + 1;
		var day = today.getDate();
		var hour = today.getHours();
		var minutes = today.getMinutes();
		var second = today.getSeconds();

		//month < 10 ? month = '0' + month : month;
		//day < 10 ? day = '0' + day : day;
		hour < 10 ? hour = '0' + hour : hour;
		minutes < 10 ? minutes = '0' + minutes : minutes;
		second < 10 ? second = '0' + second : second;
		var ymd = year + '-' + month + '-' + day+' ';
		var week = show_day[today.getDay()];
		var hms = hour+':'+minutes+':'+second;
		//今天的日期
		$("#weak").html(week);
		$("#ymdhms").html(ymd+hms);
		setTimeout("showTime();", 1000);
	}
    
	function openPage(name, icon, url) {
		if (url.indexOf("/") == 0) {
			url = getAppName() + url;
		}
		$("#content-header").show();
    	$("#breadcrumb").show();
        $("#content").css("background","#EEE none repeat scroll 0px 0px");
        $("#breadcrumb").css("background-color","#fff");
        $("#breadcrumb").css("border-bottom","1px solid #e3ebed");
        $("#container-fluid").css("padding-left","20px");
        $("#container-fluid").css("padding-right","20px");
		if (url.indexOf("http") != 0) {
			try {
				if (typeof (eval("unloadAndRelease")) == "function") {
					unloadAndRelease();
				}
			} catch (e) {
			}

			$("#content-page").load(url, function() {
				$(".modal").on('show.bs.modal', function(e) {
					$('.modal').each(function(i) {
						var $clone = $(this).clone().css('display', 'block').appendTo('body');
						var marginTop = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 4);
						marginTop = marginTop > 10 ? marginTop : 0;
						$clone.remove();
						$(this).find('.modal-content').css("margin-top", marginTop);
					});
				});
			});
		} else {
			var innerHtml = new StringBulider();
			innerHtml.append("<iframe id='content-iframe' src='" + url + "' scrolling='auto' style='width: 100%; height: 100%; padding-top: 0px;'></iframe>");
			$("#content-page").html(innerHtml.toString());
			$("#content-iframe").css("height", (parseInt($(window).height()) - 165) + "px");
		}
		createBreadcrumb(name, icon);
		//addBreadcrumb(name, icon, url);
	}
    
	
	function hiddenScroller(){
		var height = $(window).height();
    	if(height>1070){
    		document.documentElement.style.overflowY = 'hidden';
    	}else{
    		document.documentElement.style.overflowY = 'auto';
    	}
	}
	

	function showValue(data) {
			if (data != "--") {
				return Number(data).toFixed(1);
			} else {
				return data;
			}
		}
	
	function toSubscribeElevator(){
		if (isConnectedGateWay) {
			stompClient.subscribe('/topic/elevatorAlarmVideoPopover/' + projectCode, function(result) {
				var json = JSON.parse(result.body);
				console.log(json);
				//摄像机id为空，不进行推送
				if (json.cameraDeviceId != undefined) {
					//判断数组是否有值
					if (elevatorDevice.length > 0) {
						//如果为空，代表告警已经全部恢复
						if (json.alarmType == 2) {
							if(json.alarmCode == "37"){
							for (var i = 0; i < elevatorDevice.length; i++) {
								if (elevatorDevice[i].deviceId == json.deviceId) {
									elevatorDevice[i].alarmName = json.alarmName;
									elevatorDevice[i].floorDisplaying = json.floorDisplaying;
									elevatorDevice[i].runningState = json.runningState;
									elevatorDevice[i].cameraStatus = json.cameraStatus;
									//判断此是否正在查看，如果正在查看，则不删除，否则删除
									document.getElementById('show-alarm-video-iframe').contentWindow.deleteElevatorData(json.deviceId, json.deviceName, json.alarmName, i,json.floorDisplaying,json.runningState);
								}
							}
						}else{
							for (var i = 0; i < elevatorDevice.length; i++) {
								if (elevatorDevice[i].deviceId == json.deviceId) {
									elevatorDevice[i].floorDisplaying = json.floorDisplaying;
									elevatorDevice[i].runningState = json.runningState;
									elevatorDevice[i].alarmName = json.alarmName;
									elevatorDevice[i].cameraStatus = json.cameraStatus;
									if(elevatorIsOpen == 1){								
										document.getElementById('show-alarm-video-iframe').contentWindow.updateElevatorData();
									}
								}
							}
						}
						} else {
						  if(json.alarmCode == "37"){
							for (var i = 0; i < elevatorDevice.length; i++) {
								if (elevatorDevice[i].deviceId == json.deviceId) {
									//删除原有数据
									elevatorDevice.splice(i, 1);
								}
							}
							//在数组最前面添加数据
							elevatorDevice.unshift({
								"deviceId" : json.deviceId,
								"deviceName" : json.deviceName,
								"alarmName" : json.alarmName,
								"runningState" : json.runningState,
								"floorDisplaying" : json.floorDisplaying,
								"cameraDeviceId" : json.cameraDeviceId,
								"cameraStatus" : json.cameraStatus
							});
							//判断窗口是否被打开
							if (elevatorIsOpen == 0) {
								showElevatorVideo(elevatorDevice);
								elevatorIsOpen = 1;
							} else {
								isNewAlarm = 1;
								//更新数据
								document.getElementById('show-alarm-video-iframe').contentWindow.updateElevatorData();
							}
						   }else{
								for (var i = 0; i < elevatorDevice.length; i++) {
									if (elevatorDevice[i].deviceId == json.deviceId) {
										elevatorDevice[i].floorDisplaying = json.floorDisplaying;
										elevatorDevice[i].runningState = json.runningState;
										elevatorDevice[i].alarmName = json.alarmName;
										elevatorDevice[i].cameraStatus = json.cameraStatus;
										if(elevatorIsOpen == 1){								
											document.getElementById('show-alarm-video-iframe').contentWindow.updateElevatorData();
										}
									}
								}
							}
						}
					} else {
						if (json.alarmType == 1 && json.alarmCode == "37" ) {
							getElevatorDeviceInfo();
						}
					}
				}
			});

			stompClient.subscribe('/topic/elevatorAlarmVideoPopoverRunningData/' + projectCode, function(result) {
				var elevatorJson = JSON.parse(result.body);
				if (elevatorDevice.length > 0) {
					for (var i = 0; i < elevatorDevice.length; i++) {
						if (elevatorDevice[i].deviceId == elevatorJson.deviceId) {
							elevatorDevice[i].floorDisplaying = elevatorJson.floorDisplaying;
							elevatorDevice[i].runningState = elevatorJson.runningState;
							if(elevatorIsOpen == 1){								
								document.getElementById('show-alarm-video-iframe').contentWindow.updateElevatorData();
							}
						}
					}
				}
			});
			
			stompClient.subscribe('/topic/ffmAlarmVideoData/'+projectCode, function(result) {
				var json = JSON.parse(result.body);
				console.log(json);
				var busiType;
				if(json.firesVideoMonitorDTO != null){
					busiType = json.firesVideoMonitorDTO.busiType;
					firesVideoDeviceMap = new HashMap();
					getAllFireFightingCameras();
					//清除原来的，防止有影响
					tempCameraId = null;
				    tempCameraId = json.firesVideoMonitorDTO.cameraDeviceId;
					var dto={
							"firesDeviceId" : json.firesVideoMonitorDTO.firesDeviceId,
							"cameraName" : json.firesVideoMonitorDTO.cameraName,
							"fireAlarm" : json.firesVideoMonitorDTO.fireAlarm,
							"cameraDeviceId" : json.firesVideoMonitorDTO.cameraDeviceId,
							"cameraStatus":json.firesVideoMonitorDTO.cameraStatus,
							"recordId" : json.firesVideoMonitorDTO.recordId,
							"eventConfirm" : json.firesVideoMonitorDTO.eventConfirm,
							"confirmType" : json.firesVideoMonitorDTO.confirmType,
							"mark" : json.firesVideoMonitorDTO.mark,
							"msgId" : json.firesVideoMonitorDTO.msgId
						};
					if(firesVideoDeviceMap.get(tempCameraId) != null || typeof (firesVideoDeviceMap.get(tempCameraId)) != "undefined"){
						firesVideoDeviceMap.remove(tempCameraId);
					}
				firesVideoDeviceMap.put(json.firesVideoMonitorDTO.cameraDeviceId,dto);
				firesVideoDeviceList = new Array();
				doorBlockDeviceList = new Array();
 				var values = firesVideoDeviceMap.values();
				
					for ( var i in values) {
										if (values[i].fireAlarm == 1) {
											if (busiType == 'FIRES') {
												if (values[i].cameraDeviceId == tempCameraId) {
													firesVideoDeviceList.unshift({
														"itemText" : values[i].cameraName,
														"itemData" : values[i].cameraDeviceId
													});
												} else {
													firesVideoDeviceList[firesVideoDeviceList.length] = {
														"itemText" : values[i].cameraName,
														"itemData" : values[i].cameraDeviceId
													};
												}
											} else if (busiType == 'DOOR_BLOCK') {
												if (values[i].cameraDeviceId == tempCameraId) {
													doorBlockDeviceList.unshift({
														"itemText" : values[i].cameraName,
														"itemData" : values[i].cameraDeviceId
													});
												} else {
													doorBlockDeviceList[doorBlockDeviceList.length] = {
														"itemText" : values[i].cameraName,
														"itemData" : values[i].cameraDeviceId
													};
												}
											}
										}
									}

									if (json.firesVideoMonitorDTO.fireAlarm == 1) {
										openVideoPage(busiType);
									} else {
										if (typeof ($("#fires-alarm-video-modal").val()) != "undefined") {
											document.getElementById('fires-alarm-video-iframe').contentWindow.initFiresVideoDropDownList();
											// 						$("#firesAlarmTip").hide();
											// 						firesVideoObj.setData($("#cameraListName").val(), "", "");
											document.getElementById('fires-alarm-video-iframe').contentWindow.showTip();
										}
									}
								}
							});
						}
					}

					function unloadAndRelease() {
						if (stompClient != null) {
							stompClient.unsubscribe('/topic/elevatorAlarmVideoPopoverRunningData/' + projectCode);
							stompClient.unsubscribe('/topic/elevatorAlarmVideoPopover/' + +projectCode);
							stompClient.unsubscribe('/topic/ffmAlarmVideoData/' + projectCode);
						}
					}

					//首次进入页面，先查询告警电梯信息
					function getElevatorDeviceInfo() {
						$.ajax({
							type : "post",
							url : "${ctx}/elevator/elevatorAlarmVideo/queryElevatorAlarmInfo?projectCode=" + projectCode,
							contentType : "application/json;charset=utf-8",
							dataType : "json",
							async : false,
							success : function(data) {
								if (data != null && data.length > 0) {
									for (var i = 0; i < data.length; i++) {
										elevatorDevice.unshift({
											"deviceId" : data[i].deviceId,
											"deviceName" : data[i].deviceName,
											"alarmName" : data[i].alarmName,
											"runningState" : data[i].runningState,
											"floorDisplaying" : data[i].floorDisplaying,
											"cameraDeviceId" : data[i].cameraDeviceId,
											"cameraStatus" : data[i].cameraStatus
										});
									}
								}
								//视频弹窗，防止首次查询数据过慢，导致页面无数据
								showElevatorVideo(elevatorDevice);
								elevatorIsOpen = 1;
							},
							error : function(req, error, errObj) {
								return;
							}
						});

					}
					function showElevatorVideo(elevatorDevice) {
						var titleName = '<label style=" margin-left: 22px;font-size: 14px;color: #4A4A4A;" >电梯困人报警视频</label>';
						//电梯告警视频弹窗for西子国际项目首页
						// 		createModalWithLoad("show-alarm-video", 852, 655, titleName, "elevatorAlarmVideoPopover/showAlarmVideo?videoType=elevator", "", "", "");
						//电梯告警视频弹窗for政府首页
						createSimpleModalWithIframe("show-alarm-video", 704, 544, "${ctx}/elevatorAlarmVideoPopover/elevatorVideoForHome?videoType=elevator", null, closeAlarmVideoPopover, 100, "right", "blue");
						openModal("#show-alarm-video-modal", false, false);
						$(".modal-dialog").css("transform", "none");
					}
					function closeAlarmVideoPopover() {
						elevatorIsOpen = 0;
						elevator = null;
						elevatorName = null;
						elevatorAlarmName = null;
						elevatorFloorDisplaying = null;
						elevatorRunningState = null;
					}
				</script>
  </body>
</html>