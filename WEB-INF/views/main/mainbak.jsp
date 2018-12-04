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
    <link href="${ctx}/static/component/dynamic-table-processor/css/dynamicTableProcessor.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/simple-report/css/simple-report.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery.shutter/css/jquery.shutter.css" type="text/css" rel="stylesheet" />
   	<link href="${ctx}/static/component/dynamic-report-processor/css/photo.css" type="text/css" rel="stylesheet" />
    <link href="${ctx}/static/component/jquery-autocomplete/1.1.2/css/jquery.autocomplete.css" rel="stylesheet" />
	
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=qZYZ978XpdjoqSRiHhkqQxkU"></script>
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
    <script src="${ctx}/static/component/accordion-menu/js/accordion-menu.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/echarts/2.2.2/js/echarts-all.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-uniform/2.1.2/js/jquery.uniform.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-table-processor/js/dynamicTableProcessor.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-table-processor/js/dynamicTableProcessor2.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/dynamic-report-processor/js/dynamicReportProcessor.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/simple-report/js/simple-report.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery.shutter/js/jquery.shutter.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/grid-operation/js/grid-operation.js" type="text/javascript"></script>
    <script src="${ctx}/static/component/jquery-autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript"></script>
    
    <!--[if lte IE 9]>
    <script src="${ctx}/static/compatible/respond.min.js"></script>
    <script src="${ctx}/static/compatible/html5shiv.min.js"></script>
    <![endif]-->
    
	
  </head>

  <body style="line-height: 20px; height: 100%; margin: 0px; margin-top: -20px; background:#273342;!important;">
    <div id="part1" style="position: relative; height: 77px; width: 100%; z-index: -9; margin-top: 10px; outline: medium none !important;">
      <h2 style="padding-top: 20px; background: url('${ctx}/static/img/index/logo.png') no-repeat scroll 0 0 transparent; background-size: 10%; background-position: center left; height: 72px; margin-left: 10px;"></h2>
    </div>
    <div id="part2" class="navbar user-nav" style="position: absolute; left: 218px; top: 0px; z-index: 20; margin: 0px; overflow: visible; outline: medium none">
      <ul class="nav">
        <li id="user-messages" class="dropdown">
          <a title="" href="#" data-toggle="dropdown" data-target="#user-messages" class="dropdown-toggle" style="background-color: #2E363F;">
            <span class="icon icon-user"></span>
            <span class="text">欢迎：<shiro:principal property="name"/></span>
            <span id="operator-id" style="display:none"><shiro:principal property="id"/></span>
            <span id="login-name" style="display:none"><shiro:principal property="loginName"/></span>
            <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li>
              <a id="a-change-password" href="#"><span class="glyphicon glyphicon-pencil" style="color: #555; font-size: 13px; margin-right: 6px;"></span>修改密码</a>
            </li>
            <li role="separator" class="divider"></li>
            <li>
              <a href="${ctx}/logout"><span class="glyphicon glyphicon-log-out" style="color: #555; font-size: 13px; margin-right: 6px;"></span>注销</a>
            </li>
          </ul>
        </li>
        <li id="org-messages" class="dropdown">
          <a id="a-login-org" title="" href="#" data-toggle="dropdown" data-target="#org-messages" class="dropdown-toggle" style="background-color: #2E363F;">
            <span id="login-organize-id" style="display:none"><shiro:principal property="organizeId"/>^<shiro:principal property="organizeType"/></span>登录组织：
            <span id="login-organize-name"><shiro:principal property="organizeName"/></span><b class="caret"></b>
          </a>
          <div id="select-operator-org"></div>
        </li>
        <li id="search-menu" class="dropdown">
          <span class="glyphicon glyphicon-search form-control-feedback" style="color: #ccc; font-size: 16px;"></span>
          <input id="menu-search-value" name="menu-search-value" style="padding: 10px 30px 7px 10px; width: 250px; height: 37px; background-color: #555; border-width: 0px; color: #ccc" placeholder="輸入菜单名查詢……"/>
        </li>
      </ul>
    </div>
    <div id="div-menu-object" style="display: block; float: left; position: relative; width: 220px; z-index: 16; outline: medium none"></div>
    <div id="content" style="background: #EEE none repeat scroll 0px 0px; margin-left: 220px; margin-right: 0px; padding-bottom: 25px; position: relative; min-height: 100%;  outline: medium none; min-height: 500px;">
      <div id="content-header" style="width: 100%; margin-top: -38px; z-index: 20; outline: medium none">
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
    <script>
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
    });

    $(document).ready(function() {
    	$("#content").css("width",function () { return $(document).width()-240; });
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

        $("#div-menu-object").accordion({
            url: "main/getMenus",
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
        dynamicLoadResource.css("${ctx}/static/styles/theme/rib-" + theme + ".css");

        // 菜单搜索框
        $("#menu-search-value").AutoComplete({
            data: "${ctx}/main/getMenusByName?funcName=" + $("#menu-search-value").val(),
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
    });

    $("#a-change-password").on("click", function() {
    	createModalWithLoad("change-password", 350, 240, "修改密码", "operatorManage/changePassword", "updatePassword()", "confirm-close", "");
        $("#change-password-modal").modal("show");
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
        if (homepage && homepage.length > 0) {
            $("#content-page").load(getAppName() + homepage);
            $("#content").css("background","url('${ctx}/static/img/index/background004.png')");
            //$("#content").css("background-color","#121212");
            $("#breadcrumb").css("background-color","rgba(255,255,255,0.15)");
            $("#breadcrumb").css("border-bottom","0px solid #e3ebed");
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
    				url = data + organizeId;
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

    function createPage(id, name, icon, url) {
    	if (!url || url.length < 0) {
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

        if (url.indexOf("http") != 0) {
        	try {
        		if(typeof(eval("unloadAndRelease")) == "function") {
                    unloadAndRelease();
                }
            } catch(e) {}
            
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
        /*    $("#content").css("background","#EEE none repeat scroll 0px 0px");*/
            $("#breadcrumb").css("background-color","#fff");
            $("#breadcrumb").css("border-bottom","1px solid #e3ebed");
            $("#container-fluid").css("padding-left","20px");
            $("#container-fluid").css("padding-right","20px");
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
        innerHtml.append("<a href='${ctx}/main'>").append('<span class="icon glyphicon glyphicon-home" style="padding-right: 10px;"></span>').append("首页</a>");
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
    </script>
  </body>
</html>