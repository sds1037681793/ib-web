/**
 * 常量定义 START
 */

var FRAME_HEADER_HEIGHT = 97;
var MODAL_HEADER_HEIGHT = 57;
var MODAL_FOOTER_HEIGHT = 57;
var ALERT_DEFAULT_WIDTH = 120;
var FONT_ICONS_DROPDOWN_DATAS = [
 	{itemText: "iconic home", itemData: "iconic home", itemIcon: "iconic home"},
	{itemText: "iconic at", itemData: "iconic at", itemIcon: "iconic at"},
	{itemText: "iconic quote", itemData: "iconic quote", itemIcon: "iconic quote"},
	{itemText: "iconic quote-alt", itemData: "iconic quote-alt", itemIcon: "iconic quote-alt"},
	{itemText: "iconic arrow-up", itemData: "iconic arrow-up", itemIcon: "iconic arrow-up"},
	{itemText: "iconic arrow-right", itemData: "iconic arrow-right", itemIcon: "iconic arrow-right"},
	{itemText: "iconic arrow-bottom", itemData: "iconic arrow-bottom", itemIcon: "iconic arrow-bottom"},
	{itemText: "iconic arrow-left", itemData: "iconic arrow-left", itemIcon: "iconic arrow-left"},
	{itemText: "iconic arrow-up-alt", itemData: "iconic arrow-up-alt", itemIcon: "iconic arrow-up-alt"},
	{itemText: "iconic arrow-right-alt", itemData: "iconic arrow-right-alt", itemIcon: "iconic arrow-right-alt"},
	{itemText: "iconic arrow-bottom-alt", itemData: "iconic arrow-bottom-alt", itemIcon: "iconic arrow-bottom-alt"},
	{itemText: "iconic arrow-left-alt", itemData: "iconic arrow-left-alt", itemIcon: "iconic arrow-left-alt"},
	{itemText: "iconic move", itemData: "iconic move", itemIcon: "iconic move"},
	{itemText: "iconic move-vertical", itemData: "iconic move-vertical", itemIcon: "iconic move-vertical"},
	{itemText: "iconic move-horizontal", itemData: "iconic move-horizontal", itemIcon: "iconic move-horizontal"},
	{itemText: "iconic move-alt", itemData: "iconic move-alt", itemIcon: "iconic move-alt"},
	{itemText: "iconic move-vertical-alt", itemData: "iconic move-vertical-alt", itemIcon: "iconic move-vertical-alt"},
	{itemText: "iconic move-horizontal-alt", itemData: "iconic move-horizontal-alt", itemIcon: "iconic move-horizontal-alt"},
	{itemText: "iconic cursor", itemData: "iconic cursor", itemIcon: "iconic cursor"},
	{itemText: "iconic plus", itemData: "iconic plus", itemIcon: "iconic plus"},
	{itemText: "iconic plus-alt", itemData: "iconic plus-alt", itemIcon: "iconic plus-alt"},
	{itemText: "iconic minus", itemData: "iconic minus", itemIcon: "iconic minus"},
	{itemText: "iconic minus-alt", itemData: "iconic minus-alt", itemIcon: "iconic minus-alt"},
	{itemText: "iconic new-window", itemData: "iconic new-window", itemIcon: "iconic new-window"},
	{itemText: "iconic dial", itemData: "iconic dial", itemIcon: "iconic dial"},
	{itemText: "iconic lightbulb", itemData: "iconic lightbulb", itemIcon: "iconic lightbulb"},
	{itemText: "iconic link", itemData: "iconic link", itemIcon: "iconic link"},
	{itemText: "iconic image", itemData: "iconic image", itemIcon: "iconic image"},
	{itemText: "iconic article", itemData: "iconic article", itemIcon: "iconic article"},
	{itemText: "iconic read-more", itemData: "iconic read-more", itemIcon: "iconic read-more"},
	{itemText: "iconic headphones", itemData: "iconic headphones", itemIcon: "iconic headphones"},
	{itemText: "iconic equalizer", itemData: "iconic equalizer", itemIcon: "iconic equalizer"},
	{itemText: "iconic fullscreen", itemData: "iconic fullscreen", itemIcon: "iconic fullscreen"},
	{itemText: "iconic exit-fullscreen", itemData: "iconic exit-fullscreen", itemIcon: "iconic exit-fullscreen"},
	{itemText: "iconic spin", itemData: "iconic spin", itemIcon: "iconic spin"},
	{itemText: "iconic spin-alt", itemData: "iconic spin-alt", itemIcon: "iconic spin-alt"},
	{itemText: "iconic moon", itemData: "iconic moon", itemIcon: "iconic moon"},
	{itemText: "iconic sun", itemData: "iconic sun", itemIcon: "iconic sun"},
	{itemText: "iconic map-pin", itemData: "iconic map-pin", itemIcon: "iconic map-pin"},
	{itemText: "iconic pin", itemData: "iconic pin", itemIcon: "iconic pin"},
	{itemText: "iconic eyedropper", itemData: "iconic eyedropper", itemIcon: "iconic eyedropper"},
	{itemText: "iconic denied", itemData: "iconic denied", itemIcon: "iconic denied"},
	{itemText: "iconic calendar", itemData: "iconic calendar", itemIcon: "iconic calendar"},
	{itemText: "iconic calendar-alt", itemData: "iconic calendar-alt", itemIcon: "iconic calendar-alt"},
	{itemText: "iconic bolt", itemData: "iconic bolt", itemIcon: "iconic bolt"},
	{itemText: "iconic clock", itemData: "iconic clock", itemIcon: "iconic clock"},
	{itemText: "iconic document", itemData: "iconic document", itemIcon: "iconic document"},
	{itemText: "iconic book", itemData: "iconic book", itemIcon: "iconic book"},
	{itemText: "iconic book-alt", itemData: "iconic book-alt", itemIcon: "iconic book-alt"},
	{itemText: "iconic magnifying-glass", itemData: "iconic magnifying-glass", itemIcon: "iconic magnifying-glass"},
	{itemText: "iconic tag", itemData: "iconic tag", itemIcon: "iconic tag"},
	{itemText: "iconic heart", itemData: "iconic heart", itemIcon: "iconic heart"},
	{itemText: "iconic info", itemData: "iconic info", itemIcon: "iconic info"},
	{itemText: "iconic chat", itemData: "iconic chat", itemIcon: "iconic chat"},
	{itemText: "iconic chat-alt", itemData: "iconic chat-alt", itemIcon: "iconic chat-alt"},
	{itemText: "iconic key", itemData: "iconic key", itemIcon: "iconic key"},
	{itemText: "iconic unlocked", itemData: "iconic unlocked", itemIcon: "iconic unlocked"},
	{itemText: "iconic locked", itemData: "iconic locked", itemIcon: "iconic locked"},
	{itemText: "iconic mail", itemData: "iconic mail", itemIcon: "iconic mail"},
	{itemText: "iconic mail-alt", itemData: "iconic mail-alt", itemIcon: "iconic mail-alt"},
	{itemText: "iconic phone", itemData: "iconic phone", itemIcon: "iconic phone"},
	{itemText: "iconic box", itemData: "iconic box", itemIcon: "iconic box"},
	{itemText: "iconic pencil", itemData: "iconic pencil", itemIcon: "iconic pencil"},
	{itemText: "iconic pencil-alt", itemData: "iconic pencil-alt", itemIcon: "iconic pencil-alt"},
	{itemText: "iconic comment", itemData: "iconic comment", itemIcon: "iconic comment"},
	{itemText: "iconic comment-alt", itemData: "iconic comment-alt", itemIcon: "iconic comment-alt"},
	{itemText: "iconic rss", itemData: "iconic rss", itemIcon: "iconic rss"},
	{itemText: "iconic star", itemData: "iconic star", itemIcon: "iconic star"},
	{itemText: "iconic trash", itemData: "iconic trash", itemIcon: "iconic trash"},
	{itemText: "iconic user", itemData: "iconic user", itemIcon: "iconic user"},
	{itemText: "iconic volume", itemData: "iconic volume", itemIcon: "iconic volume"},
	{itemText: "iconic mute", itemData: "iconic mute", itemIcon: "iconic mute"},
	{itemText: "iconic cog", itemData: "iconic cog", itemIcon: "iconic cog"},
	{itemText: "iconic cog-alt", itemData: "iconic cog-alt", itemIcon: "iconic cog-alt"},
	{itemText: "iconic x", itemData: "iconic x", itemIcon: "iconic x"},
	{itemText: "iconic x-alt", itemData: "iconic x-alt", itemIcon: "iconic x-alt"},
	{itemText: "iconic check", itemData: "iconic check", itemIcon: "iconic check"},
	{itemText: "iconic check-alt", itemData: "iconic check-alt", itemIcon: "iconic check-alt"},
	{itemText: "iconic beaker", itemData: "iconic beaker", itemIcon: "iconic beaker"},
	{itemText: "iconic beaker-alt", itemData: "iconic beaker-alt", itemIcon: "iconic beaker-alt"}
];

var DEFAULT_THEME = "green"; // 默认主题

/**
 * 显示对话框
 *
 * @param modalDivId
 * @param title
 * @param content
 * @param type 1仅关闭按钮（默认），2显示是否按钮
 * @param yesScript 选择“是”按钮需要执行的js脚本
 * @iframeLayer 用于解决div被activex遮挡的情况
 * @theme 样式
 */
function showDialogModal(modalDivId, title, content, type, yesScript, iframeLayer, theme) {
	if (theme) {
		theme = "-" + theme;
	}
	var innerHtml = new StringBulider();
	innerHtml.append("<div id=\"").append(modalDivId).append("-modal\" class=\"modal fade\">");
	if (iframeLayer && iframeLayer == true) {
		innerHtml.append('<iframe id="').append(modalDivId).append('-iframe-layer" src="javascript:false" style="position:absolute; visibility:inherit; top:0px; left:0px;  height:100% ;width:100%; z-index:-1; border-radius: 5px;"></iframe>');
	}
	innerHtml.append("<div id=\"").append(modalDivId).append("-dialog\" class=\"modal-dialog modal-info-dialog").append(theme).append("\">");
	innerHtml.append("<div id=\"").append(modalDivId).append("-modal-content\" class=\"modal-content\">");

	// title
	innerHtml.append("<div class=\"modal-header modal-header").append(theme).append("\">");
	innerHtml.append("<button type=\"button\" class=\"close").append(theme).append("\" data-dismiss=\"modal\">&times;</button>");
	innerHtml.append("<h4 class=\"modal-title\" id=\"");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal-label\">");
	innerHtml.append(title);
	innerHtml.append("</h4>");
	innerHtml.append("</div>");

	// content
	innerHtml.append("<div class=\"modal-body\" style=\"padding: 15px 15px 30px 15px;\">");
	innerHtml.append("<span class=\"glyphicon glyphicon-info-sign modal-content-icon modal-content-icon").append(theme).append("\"></span>");
	innerHtml.append("<div style=\"margin-top: 5px;\">");
	innerHtml.append(content);
	innerHtml.append("</div>");
	innerHtml.append("</div>");

	// footer
	innerHtml.append("<div class=\"modal-footer modal-footer").append(theme).append("\">");
	if (type && type == 2) {
		innerHtml.append("<a href=\"#");
		if (yesScript.length > 0) {
			innerHtml.append("\" onclick=\"javascript: ").append(yesScript);
		}
		innerHtml.append("\" class=\"btn btn-modal").append(theme).append("\" data-dismiss=\"modal\">&nbsp;&nbsp;是&nbsp;&nbsp;</a>");
		innerHtml.append("<a href=\"#\" class=\"btn btn-primary btn-modal btn-cancel").append(theme).append("\" data-dismiss=\"modal\">&nbsp;&nbsp;否&nbsp;&nbsp;</a>");
	} else {
		innerHtml.append("<a href=\"#\" class=\"btn btn-primary btn-modal").append(theme).append("\" data-dismiss=\"modal\">确定</a>");
	}
	innerHtml.append("</div>");

	innerHtml.append("</div>");
	innerHtml.append("</div>");

	innerHtml.append("</div>");

	$("#" + modalDivId).html(innerHtml.toString(""));

	$("#" + modalDivId + "-dialog").css({
		'margin-top': function () {
            var marginTop = ($(window).height() - 200) / 2;
            return marginTop;
		},
		'left': function() {
			modalWdith = $("#" + modalDivId + "-dialog").width();
			var left = ($(window).width() - modalWdith) / 2;
			return left;
		},
		'position': "absolute"
	});

	$('#' + modalDivId + "-modal").on("hidden.bs.modal", function(e){
		removeDiv(modalDivId + "-modal");
	});

	$('#' + modalDivId + "-modal").modal('show');

	if (iframeLayer && iframeLayer == true) {
		$('#' + modalDivId + "-modal").on("shown.bs.modal", function(e){
			// 处理iframe宽度、高度、上方位置、左侧位置
			var jqIframeObj = $("#" + modalDivId + "-iframe-layer");
			var jqModalObj = $("#" + modalDivId + "-modal-content");
			jqIframeObj.css("width", jqModalObj.width());
			jqIframeObj.css("height", jqModalObj.height());
			jqIframeObj.css("top", jqModalObj.offset().top);
			jqIframeObj.css("left", jqModalObj.offset().left);
		});
	}

	regModalMousedownEvent(modalDivId + "-dialog");
	regModalMouseupEvent(modalDivId + "-dialog");
}

/**
 * 创建带iframe的modal
 * @param modalDivId modal对象id
 * @param width modal 宽度
 * @param height modal高度
 * @param title modal标题
 * @param url iframe引用的url
 * @param callback 回调函数
 * @param footerType 页脚类型：confirm|confirm-close
 * @param iframeParams 传给iframe页面的参数
 */
function createModalWithIframe(modalDivId, width, height, title, url, callback, footerType, iframeParams) {
	var iframeUrl;
	if (url.indexOf("?") == -1) {
		iframeUrl = url + "?modalId=" + modalDivId + "-modal";
	} else {
		iframeUrl = url + "&modalId=" + modalDivId + "-modal";
	}
	if (callback == null || callback == undefined) {
		callback = "";
	}
	iframeUrl += "&height=" + height;
	if (iframeParams != null && iframeParams != undefined && iframeParams != "") {
		iframeUrl += "&" + iframeParams;
	}

	// 计算modal-body高度
	var modalBodyHeight = height - MODAL_HEADER_HEIGHT;
	if (footerType && footerType.length != 0) {
		modalBodyHeight -= MODAL_FOOTER_HEIGHT;
	}

	var innerHtml = new StringBulider();

	innerHtml.append("<div id=\"").append(modalDivId).append("-modal\" class=\"modal fade\">");

	// style
	innerHtml.append("<style type=\"text/css\">");
	innerHtml.append("<!--\n");
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
	innerHtml.append(" .modal-content {");
	if (height > 0) {
		innerHtml.append("min-height: ");
		innerHtml.append(height);
		innerHtml.append("px; \n");
	}
	if (width > 0) {
		innerHtml.append("width: ");
		innerHtml.append(width);
		innerHtml.append("px; ");
		innerHtml.append("}\n");
	}
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
	innerHtml.append(" .modal-body {");
	innerHtml.append("height: ");
	innerHtml.append(modalBodyHeight);
	innerHtml.append("px; ");
	innerHtml.append("}\n");
	innerHtml.append("\n-->");
	innerHtml.append("</style>");

	innerHtml.append("<div id=\"").append(modalDivId).append("-dialog\" class=\"modal-dialog\">");
	innerHtml.append("<div class=\"modal-content\">");

	// title
	innerHtml.append("<div class=\"modal-header\">");
	innerHtml.append("<button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>");
	innerHtml.append("<h4 class=\"modal-title\" id=\"");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal-label\">");
	innerHtml.append(title);
	innerHtml.append("</h4>");
	innerHtml.append("</div>");

	// content
	innerHtml.append("<div class=\"modal-body\">");
	innerHtml.append("<iframe id='" + modalDivId + "-iframe' src='" + iframeUrl + "' scrolling='no'></iframe>");
	innerHtml.append("</div>");

	if (footerType && footerType.length != 0) {
		innerHtml.append("<div class=\"modal-footer\">");
		if (footerType == "confirm") {
			innerHtml.append("<a id=\"").append(modalDivId).append("-button-confirm\" href=\"#\" class=\"btn btn-primary btn-modal\" onclick=\"javascript: ").append(callback).append(";\">确定</a>");
		}
		if (footerType == "confirm-close") {
			innerHtml.append("<a id=\"").append(modalDivId).append("-button-confirm\" href=\"#\" class=\"btn btn-primary btn-modal\" onclick=\"javascript: ").append(callback).append(";\">确定</a>");
			innerHtml.append("<a href=\"#\" class=\"btn btn-modal btn-cancel\" data-dismiss=\"modal\">取消</a>");
		} else if (footerType == "close") {
			innerHtml.append("<a href=\"#\" class=\"btn btn-modal\" data-dismiss=\"modal\">确定</a>");
		}
		innerHtml.append("</div>");
	}

	innerHtml.append("</div>");
	innerHtml.append("</div>");

	innerHtml.append("</div>");

	$("#" + modalDivId).html(innerHtml.toString(""));

	$("#" + modalDivId + "-dialog").css({
		'margin-top': function () {
			var marginTop;
			if(height != "" && height >0){
				marginTop = ($(window).height() - height) / 2;
				if (marginTop < 10) {
					marginTop = 10;
				}
			}else{
				marginTop = $(window).height() / 4;
				if (marginTop < 10) {
					marginTop = 10;
				}
			}
			return marginTop;
		},
		'left': function() {
			var modalWdith = width;
			if (modalWdith == 0) {
				modalWdith = $("#" + modalDivId + "-dialog").width();
			}
			var left = ($(window).width() - modalWdith) / 2;
			return left;
		},
		'position': "absolute"
	});

	$('#' + modalDivId + "-modal").on("hidden.bs.modal", function(e){
		removeDiv(modalDivId + "-iframe");
		removeDiv(modalDivId + "-modal");
	});

	regModalMousedownEvent(modalDivId + "-dialog");
	regModalMouseupEvent(modalDivId + "-dialog");
}

/**
 * 创建带iframe的modal
 * @param modalDivId modal对象id
 * @param width modal 宽度
 * @param height modal高度
 * @param title modal标题
 * @param url iframe引用的url
 * @param callback 回调函数
 * @param footerType 页脚类型：confirm|confirm-close|close
 * @theme 样式
 */
function createModalWithLoad(modalDivId, width, height, title, url, callback, footerType, theme,oriMarginTop) {
	if (theme) {
		theme = "-" + theme;
	}

	if (callback == null || callback == undefined) {
		callback = "";
	}
	// 计算modal-body高度
	var modalBodyHeight = height - MODAL_HEADER_HEIGHT;
	if (footerType && footerType.length != 0) {
		modalBodyHeight -= MODAL_FOOTER_HEIGHT;
	}

	var innerHtml = new StringBulider();

	innerHtml.append("<div id=\"").append(modalDivId).append("-modal\" class=\"modal fade\">");

	// style
	innerHtml.append("<style type=\"text/css\">");
	innerHtml.append("<!--\n");
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
	innerHtml.append(" .modal-dialog {");
	if (height > 0) {
		innerHtml.append("min-height: ");
		innerHtml.append(height);
		innerHtml.append("px; \n");
	}
	if (width > 0) {
		innerHtml.append("width: ");
		innerHtml.append(width);
		innerHtml.append("px; ");
		innerHtml.append("}\n");
	}
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
	innerHtml.append(" .modal-body {");
	innerHtml.append("height: ");
	innerHtml.append(modalBodyHeight);
	innerHtml.append("px; ");
	innerHtml.append("}\n");
	innerHtml.append("\n-->");
	innerHtml.append("</style>");

	innerHtml.append("<div id=\"").append(modalDivId).append("-dialog\" class=\"modal-dialog modal-dialog").append(theme).append("\">");
	innerHtml.append("<div id=\"").append(modalDivId).append("-modal-content\" class=\"modal-content\">");

	// title
	innerHtml.append("<div class=\"modal-header modal-header").append(theme).append("\">");
	innerHtml.append("<button type=\"button\" class=\"close close").append(theme).append("\" data-dismiss=\"modal\">&times;</button>");
	innerHtml.append("<h4 class=\"modal-title\" id=\"");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal-label\">");
	innerHtml.append(title);
	innerHtml.append("</h4>");
	innerHtml.append("</div>");

	// content
	innerHtml.append("<div id=\"").append(modalDivId).append("-modal-body\" class=\"modal-body\">");
	innerHtml.append("</div>");

	if (footerType && footerType.length != 0) {
		innerHtml.append("<div class=\"modal-footer modal-footer").append(theme).append("\">");
		if (footerType == "confirm") {
			innerHtml.append("<a id=\"").append(modalDivId).append("-button-confirm\" href=\"#\" class=\"btn btn-primary btn-modal").append(theme).append("\" onclick=\"javascript: ").append(callback).append(";\">确定</a>");
		}
		if (footerType == "confirm-close") {
			innerHtml.append("<a id=\"").append(modalDivId).append("-button-confirm\" href=\"#\" class=\"btn btn-primary btn-modal").append(theme).append("\" onclick=\"javascript: ").append(callback).append(";\">确定</a>");
			innerHtml.append("<a href=\"#\" class=\"btn btn-modal btn-cancel").append(theme).append("\" data-dismiss=\"modal\">取消</a>");
		}
		if (footerType == "close") {
			innerHtml.append("<a href=\"#\" class=\"btn btn-modal").append(theme).append("\" data-dismiss=\"modal\">确定</a>");
		}
		innerHtml.append("</div>");
	}

	innerHtml.append("</div>");
	innerHtml.append("</div>");

	innerHtml.append("</div>");

	$("#" + modalDivId).html(innerHtml.toString(""));
	if(url && url.indexOf("/") == 0) {
		$("#" + modalDivId + "-modal-body").load(getAppName() + url);
	} else {
		$("#" + modalDivId + "-modal-body").load(getAppName() + "/" + url);
	}
	$("#" + modalDivId + "-dialog").css({
		'margin-top': function () {
			if(oriMarginTop){
				return oriMarginTop;
			}
			if(height != "" && height >0){
				var marginTop = ($(window).height() - height) / 2;
				if (marginTop < 10) {
					marginTop = 10;
				}
			}else{
				var marginTop = $(window).height() / 4;
				if (marginTop < 10) {
					marginTop = 10;
				}
			}
			return marginTop;
		},
		'left': function() {
			var modalWdith = width;
			if (modalWdith == 0) {
				modalWdith = $("#" + modalDivId + "-dialog").width();
			}
			var left = ($(window).width() - modalWdith) / 2;
			return left;
		},
		'position': "absolute"
	});

	$('#' + modalDivId + "-modal").on("hidden.bs.modal", function(e){
		removeDiv(modalDivId + "-modal");
	});


	regModalMousedownEvent(modalDivId + "-dialog");
	regModalMouseupEvent(modalDivId + "-dialog");
}

/**
 * 创建带iframe的modal
 * @param modalDivId modal对象id
 * @param width modal 宽度
 * @param height modal高度
 * @param url iframe引用的url
 * @param iframeParams 传给iframe页面的参数
 * @param closeFunc 页面关闭后调用的方法
 * @param oriMarginTop 弹出框距离顶端位置
 * @param closeLocation 页面关闭按钮位置:left为左边，right为右边
 * @param iframeBlueStyle 3d页面蓝色风格弹窗 blue为蓝色风格
 */
function createSimpleModalWithIframe(modalDivId, width, height, url,iframeParams,closeFunc,oriMarginTop,closeLocation,iframeBlueStyle) {
	var iframeUrl;
	var closeWidth = 20;
	var closeHeight = 20;
	if (url.indexOf("?") == -1) {
		iframeUrl = url + "?modalId=" + modalDivId + "-modal";
	} else {
		iframeUrl = url + "&modalId=" + modalDivId + "-modal";
	}
	iframeUrl += "&height=" + height;
	if (iframeParams != null && iframeParams != undefined && iframeParams != "") {
		iframeUrl += "&" + iframeParams;
	}
	if(closeLocation && closeLocation == "left"){
		closeWidth = 60;
		closeHeight = 48;
	}

	// 计算modal-body高度
	var modalBodyHeight = height;
	//计算
    var modalBottomleft=height;
    var modalBottomRight=height;
	var innerHtml = new StringBulider();

	innerHtml.append("<div id=\"").append(modalDivId).append("-modal\" class=\"modal fade\">");

	// style
	innerHtml.append("<style type=\"text/css\">");
	//innerHtml.append("<!--\n");
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
    if(iframeBlueStyle && iframeBlueStyle == "blue"){
        innerHtml.append(" .modal-contents {");
    }else{
        innerHtml.append(" .modal-content {");
    }
	if (width > 0) {
		innerHtml.append("width: ");
		innerHtml.append(width);
		innerHtml.append("px; ");
	}
	if (width > 0) {
		innerHtml.append("height: ");
		innerHtml.append(height);
		innerHtml.append("px; ");
	}
	innerHtml.append("}\n");
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
    if(iframeBlueStyle && iframeBlueStyle == "blue"){
        innerHtml.append(" .modal-headers {");
    }else{
        innerHtml.append(" .modal-header {");
    }
	innerHtml.append("border:0 !important;");
	innerHtml.append("position:absolute;");
	innerHtml.append("z-index:1;");
	innerHtml.append("text-align:right;");
	if(closeLocation && closeLocation == "left"){
		innerHtml.append("left:0px");
	}else{
		innerHtml.append("right:0px;");
	}
	innerHtml.append("}\n");
	innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-modal");
    innerHtml.append(" .modal-body {");
    innerHtml.append("padding: 0px;");
    innerHtml.append("height: ");
    innerHtml.append(modalBodyHeight);
    innerHtml.append("px; ");
    innerHtml.append("}\n");
    innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-iframe");
    innerHtml.append(" {");
    innerHtml.append("border: medium none;");
    innerHtml.append("}\n");
    if(iframeBlueStyle && iframeBlueStyle == "blue"){
        innerHtml.append("#");
        innerHtml.append(modalDivId);
        innerHtml.append("-modal");
        innerHtml.append(" .modal-bottomLeft {");
        innerHtml.append("top: ");
        innerHtml.append(modalBottomleft);
        innerHtml.append("px; ");
        innerHtml.append("}\n");
        innerHtml.append("#");
        innerHtml.append(modalDivId);
        innerHtml.append("-modal");
        innerHtml.append(" .modal-bottomRight {");
        innerHtml.append("top: ");
        innerHtml.append(modalBottomRight);
        innerHtml.append("px; ");
        innerHtml.append("}\n");
        innerHtml.append("\n");
    }
	//innerHtml.append("\n-->");
	innerHtml.append("</style>");
    if(iframeBlueStyle && iframeBlueStyle == "blue"){
        innerHtml.append("<div id=\"").append(modalDivId).append("-dialog\" class=\"modal-dialogs\">");
        innerHtml.append("<div class=\"modal-bottomRight\">");
        innerHtml.append("</div>");
        innerHtml.append("<div class=\"modal-bottomLeft\">");
        innerHtml.append("</div>");
        innerHtml.append("<div class=\"modal-contents\">");
        // title
        innerHtml.append("<div class=\"modal-topRight\">");
        innerHtml.append("</div>");
        innerHtml.append("<div class=\"modal-headers\">");
	}else{
        innerHtml.append("<div id=\"").append(modalDivId).append("-dialog\" class=\"modal-dialog\">");
        innerHtml.append("<div class=\"modal-content\">");
        // title
        innerHtml.append("<div class=\"modal-header\">");
	}
	innerHtml.append("<div class=\"close ");
	if(closeLocation && closeLocation == "left"){
		innerHtml.append("closeLeft");
	}else{
		innerHtml.append("closeRight");
	}
	innerHtml.append("\" data-dismiss=\"modal\" style=\"width:"+closeWidth+"px;height:"+closeHeight+"px\"></div>");
	innerHtml.append("</div>");
    if(iframeBlueStyle && iframeBlueStyle == "blue"){
        innerHtml.append("<div class=\"modal-topLeft\">");
        innerHtml.append("</div>");
	}
	// content
	innerHtml.append("<div class=\"modal-body\">");
	innerHtml.append("<iframe id='" + modalDivId + "-iframe' src='" + iframeUrl + "' style='height:100% ;width:100%;' scrolling='no'></iframe>");
	innerHtml.append("</div>");
	innerHtml.append("</div>");
	innerHtml.append("</div>");
	innerHtml.append("</div>");
	$("#" + modalDivId).html(innerHtml.toString(""));
	$("#" + modalDivId + "-dialog").css({
		'margin-top': function () {
			var marginTop;
			if(oriMarginTop){
				return oriMarginTop;
			}
			if(height != "" && height >0){
                if(iframeBlueStyle && iframeBlueStyle == "blue"){
                    var marginTop = ($(window).height() - height-100) / 2;
                }else{
                    var marginTop = ($(window).height() - height) / 2;
                }
			}else{
				marginTop = $(window).height() / 4;
				if (marginTop < 0) {
					marginTop = 0;
				}
			}
			return marginTop;
		},
		'left': function() {
			var modalWdith = width;
			if (modalWdith == 0) {
				modalWdith = $("#" + modalDivId + "-dialog").width();
			}
			var left = ($(window).width() - modalWdith) / 2;
			return left;
		},
		'position': "absolute"
	});

	$('#' + modalDivId + "-modal").on("hidden.bs.modal", function(e){
		if(closeFunc && typeof(closeFunc)=="function" ){
			closeFunc();
		}
		removeDiv(modalDivId + "-iframe");
		removeDiv(modalDivId + "-modal");
	});
	//regModalMousedownEvent(modalDivId + "-dialog");
	//regModalMouseupEvent(modalDivId + "-dialog");
}
/**
 * 创建带iframe的modal　淡入淡出效果
 * @param modalDivId modal对象id
 * @param width modal 宽度
 * @param height modal高度
 * @param url iframe引用的url
 * @param iframeParams 传给iframe页面的参数
 * @param closeFunc 页面关闭后调用的方法
 * @param oriMarginTop 弹出框距离顶端位置
 * @param closeLocation 页面关闭按钮位置:left为左边，right为右边
 */
function createSimpleModalWithIframefade(modalDivId, width, height, url,iframeParams,closeFunc,oriMarginTop,closeLocation) {
    var iframeUrl;
    var closeWidth = 20;
    var closeHeight = 20;
    if (url.indexOf("?") == -1) {
        iframeUrl = url + "?modalId=" + modalDivId + "-modal";
    } else {
        iframeUrl = url + "&modalId=" + modalDivId + "-modal";
    }
    iframeUrl += "&height=" + height;
    if (iframeParams != null && iframeParams != undefined && iframeParams != "") {
        iframeUrl += "&" + iframeParams;
    }
    if(closeLocation && closeLocation == "left"){
        closeWidth = 60;
        closeHeight = 48;
    }

    // 计算modal-body高度
    var modalBodyHeight = height;

    var innerHtml = new StringBulider();

    innerHtml.append("<div id=\"").append(modalDivId).append("-modal\" class=\"modal fade\">");

    // style
    innerHtml.append("<style type=\"text/css\">");
    innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-modal");
    innerHtml.append(" .modal-content {");
    if (width > 0) {
        innerHtml.append("width: ");
        innerHtml.append(width);
        innerHtml.append("px; ");

    }
    if (width > 0) {
        innerHtml.append("height: ");
        innerHtml.append(height);
        innerHtml.append("px; ");

    }
    innerHtml.append("}\n");
    innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-modal");
    innerHtml.append(" .modal-header {");
    innerHtml.append("border:0 !important;");
    innerHtml.append("position:absolute;");
    innerHtml.append("z-index:1;");
    innerHtml.append("text-align:right;");
    if(closeLocation && closeLocation == "left"){
        innerHtml.append("left:0px");
    }else{
        innerHtml.append("right:0px;");
    }
    innerHtml.append("}\n");
    innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-modal");
    innerHtml.append(" .modal-body {");
    innerHtml.append("padding: 0px;");
    innerHtml.append("height: ");
    innerHtml.append(modalBodyHeight);
    innerHtml.append("px; ");
    innerHtml.append("}\n");
    innerHtml.append(".fade{");
    innerHtml.append("opacity:0;");
    innerHtml.append("-moz-transition:opacity 1.5s linear;");
    innerHtml.append("-webkit-transition:opacity 1.5s linear;");
    innerHtml.append("-o-transition:opacity 1.5s linear;");
    innerHtml.append("transition:opacity 1.5s linear;");
    innerHtml.append("}\n");
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
    innerHtml.append(".fade.in {");
    innerHtml.append("opacity:1;");
    innerHtml.append("}\n");
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
    innerHtml.append(".fade.out {");
    innerHtml.append("opacity:0;");
    innerHtml.append("-moz-transition:opacity 2s linear;");
    innerHtml.append("-webkit-transition:opacity 2s linear;");
    innerHtml.append("-o-transition:opacity 2s linear;");
    innerHtml.append("transition:opacity 2s linear;");
    innerHtml.append("}\n");
    innerHtml.append("</style>");

    innerHtml.append("<div id=\"").append(modalDivId).append("-dialog\" class=\"modal-dialog\">");
    innerHtml.append("<div class=\"modal-content\">");

    // title
    innerHtml.append("<div class=\"modal-header\">");
    innerHtml.append("<div class=\"close ");
    if(closeLocation && closeLocation == "left"){
        innerHtml.append("closeLeft");
    }else{
        innerHtml.append("closeRight");
    }
    innerHtml.append("\" data-dismiss=\"modalFadeOut\" style=\"width:"+closeWidth+"px;height:"+closeHeight+"px\"></div>");
    innerHtml.append("</div>");

    // content
    innerHtml.append("<div class=\"modal-body\">");
    innerHtml.append("<iframe id='" + modalDivId + "-iframe' src='" + iframeUrl + "' style='height:100% ;width:100%;' scrolling='no'></iframe>");
    innerHtml.append("</div>");

    innerHtml.append("</div>");
    innerHtml.append("</div>");

    innerHtml.append("</div>");

    $("#" + modalDivId).html(innerHtml.toString(""));
    $("#" + modalDivId + "-dialog").css({
        'margin-top': function () {
			var marginTop;
            if(oriMarginTop){
                return oriMarginTop;
            }
			if(height != "" && height >0){
				marginTop = ($(window).height() - height-50) / 2;
				if (marginTop < 0) {
					marginTop = 0;
				}
			}else{
				marginTop = $(window).height() / 4;
				if (marginTop < 0) {
					marginTop = 0;
				}
			}
			return marginTop;
        },
        'left': function() {
            var modalWdith = width;
            if (modalWdith == 0) {
                modalWdith = $("#" + modalDivId + "-dialog").width();
            }
            var left = ($(window).width() - modalWdith) / 2;
            return left;
        },
        'position': "absolute"
    });
    $('#' + modalDivId + "-modal").on('click.dismiss.bs.modal', '[data-dismiss="modalFadeOut"]',function(e){
        $('#' + modalDivId + "-modal").removeClass("fade in");
        $('#' + modalDivId + "-modal").addClass("fade out");
        setTimeout(function(e){
            if(closeFunc && typeof(closeFunc)=="function" ){
                closeFunc();
            }
            removeDiv(modalDivId + "-iframe");
            removeDiv(modalDivId + "-modal");
        },2000);
    });
}

/**
 * 创建带iframe的modal,3D投屏页面蓝色版
 * @param modalDivId modal对象id
 * @param width modal 宽度
 * @param height modal高度
 * @param url iframe引用的url
 * @param iframeParams 传给iframe页面的参数
 * @param closeFunc 页面关闭后调用的方法
 * @param oriMarginTop 弹出框距离顶端位置
 * @param closeLocation 页面关闭按钮位置:left为左边，right为右边
 * @param 等createSimpleModalWithIframe方法稳定后 该方法将停止使用
 */
function createSimpleModalWithIframeBlue(modalDivId, width, height, url,iframeParams,closeFunc,oriMarginTop,closeLocation) {
    var iframeUrl;
    var closeWidth = 20;
    var closeHeight = 20;
    if (url.indexOf("?") == -1) {
        iframeUrl = url + "?modalId=" + modalDivId + "-modal";
    } else {
        iframeUrl = url + "&modalId=" + modalDivId + "-modal";
    }
    iframeUrl += "&height=" + height;
    if (iframeParams != null && iframeParams != undefined && iframeParams != "") {
        iframeUrl += "&" + iframeParams;
    }
    if(closeLocation && closeLocation == "left"){
        closeWidth = 60;
        closeHeight = 48;
    }

    // 计算modal-body高度
    var modalBodyHeight = height;
    var modalBottomleft=height;
    var modalBottomRight=height;

    var innerHtml = new StringBulider();

    innerHtml.append("<div id=\"").append(modalDivId).append("-modal\" class=\"modal fade\">");
    // style
    innerHtml.append("<style type=\"text/css\">");
    innerHtml.append("\n");
    innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-modal");
    innerHtml.append(" .modal-contents {");
    if (width > 0) {
        innerHtml.append("width: ");
        innerHtml.append(width);
        innerHtml.append("px; ");

    }
    if (width > 0) {
        innerHtml.append("height: ");
        innerHtml.append(height);
        innerHtml.append("px; ");

    }
    innerHtml.append("}\n");
    innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-modal");
    innerHtml.append(" .modal-headers {");
    innerHtml.append("border:0 !important;");
    innerHtml.append("position:absolute;");
    innerHtml.append("z-index:1;");
    innerHtml.append("text-align:right;");
    if(closeLocation && closeLocation == "left"){
        innerHtml.append("left:0px");
    }else{
        innerHtml.append("right:0px;");
    }
    innerHtml.append("}\n");
    innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-modal");
    innerHtml.append(" .modal-body {");
    innerHtml.append("padding: 0px;");
    innerHtml.append("height: ");
    innerHtml.append(modalBodyHeight);
    innerHtml.append("px; ");
    innerHtml.append("}\n");
    innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-modal");
    innerHtml.append(" .modal-bottomLeft {");
    innerHtml.append("top: ");
    innerHtml.append(modalBottomleft);
    innerHtml.append("px; ");
    innerHtml.append("}\n");
    innerHtml.append("#");
    innerHtml.append(modalDivId);
    innerHtml.append("-modal");
    innerHtml.append(" .modal-bottomRight {");
    innerHtml.append("top: ");
    innerHtml.append(modalBottomRight);
    innerHtml.append("px; ");
    innerHtml.append("}\n");
    innerHtml.append("\n");
    innerHtml.append("</style>");
    innerHtml.append("<div id=\"").append(modalDivId).append("-dialog\" class=\"modal-dialogs\">");
    innerHtml.append("<div class=\"modal-bottomRight\">");
    innerHtml.append("</div>");
    innerHtml.append("<div class=\"modal-bottomLeft\">");
    innerHtml.append("</div>");
    innerHtml.append("<div class=\"modal-contents\">");
    // title
    innerHtml.append("<div class=\"modal-topRight\">");
    innerHtml.append("</div>");
    innerHtml.append("<div class=\"modal-headers\">");
    innerHtml.append("<div class=\"close ");
    if(closeLocation && closeLocation == "left"){
        innerHtml.append("closeLeft");
    }else{
        innerHtml.append("closeRight");
    }
    innerHtml.append("\" data-dismiss=\"modal\" style=\"width:"+closeWidth+"px;height:"+closeHeight+"px\"></div>");
    innerHtml.append("</div>");

    // content
    innerHtml.append("<div class=\"modal-topLeft\">");
    innerHtml.append("</div>");
    innerHtml.append("<div class=\"modal-body\">");
    innerHtml.append("<iframe id='" + modalDivId + "-iframe' src='" + iframeUrl + "' style='height:100% ;width:100%;' scrolling='no'></iframe>");
    innerHtml.append("</div>");
    innerHtml.append("</div>");
    innerHtml.append("</div>");

    innerHtml.append("</div>");

    $("#" + modalDivId).html(innerHtml.toString(""));

    $("#" + modalDivId + "-dialog").css({
        'margin-top': function () {
			var marginTop;
			if(oriMarginTop){
				return oriMarginTop;
			}
			if(height != "" && height >0){
				marginTop = ($(window).height() - height) / 2;
				if (marginTop < 10) {
					marginTop = 10;
				}
			}else{
				marginTop = $(window).height() / 4;
				if (marginTop < 10) {
					marginTop = 10;
				}
			}
			return marginTop;
        },
        'left': function() {
            var modalWdith = width;
            if (modalWdith == 0) {
                modalWdith = $("#" + modalDivId + "-dialog").width();
            }
            var left = ($(window).width() - modalWdith) / 2;
            return left;
        },
        'position': "absolute"
    });

    $('#' + modalDivId + "-modal").on("hidden.bs.modal", function(e){
        if(closeFunc && typeof(closeFunc)=="function" ){
            closeFunc();
        }
        removeDiv(modalDivId + "-iframe");
        removeDiv(modalDivId + "-modal");
    });

}

/**
 * 创建带iframe的modal
 * @param modalDivId modal对象id
 * @param width modal 宽度
 * @param height modal高度
 * @param title modal标题
 * @param url iframe引用的url
 * @param callback 回调函数
 * @param footerType 页脚类型：confirm|confirm-close|close|user-defined(自定义)
 * @theme 样式
 * @footerButtons 自定义按钮，footerType为user-defined，格式{id:按钮id,func:按钮响应方法,name:按钮显示名称}
 * @oriMarginTop 自定义marginTop
 */
function createModalWithLoadOptions(options) {
	var defaults = {
	    modalDivId : "",
	    width : 600,
	    height : 300,
	    title : "",
	    url : "",
	    footerType : "confirm-close",
	    footerButtons :[],
	    callback : "",
	    theme : "",
	    oriMarginTop : -1
	 };
	var options = $.extend(defaults, options);
	var theme = options.theme;
	var modalDivId = options.modalDivId;
	var width = options.width;
	var height = options.height;
	var title = options.title;
	var url = options.url;
	var footerType = options.footerType;
	var callback = options.callback;
	var oriMarginTop = options.oriMarginTop;
	var buttons = options.footerButtons;
	if (theme) {
		theme = "-" + theme;
	}

	if (callback == null || callback == undefined) {
		callback = "";
	}

	// 计算modal-body高度
	var modalBodyHeight = height - MODAL_HEADER_HEIGHT;
	if (footerType && footerType.length != 0) {
		modalBodyHeight -= MODAL_FOOTER_HEIGHT;
	}

	var innerHtml = new StringBulider();

	innerHtml.append("<div id=\"").append(modalDivId).append("-modal\" class=\"modal fade\">");

	// style
	innerHtml.append("<style type=\"text/css\">");
	innerHtml.append("<!--\n");
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
	innerHtml.append(" .modal-dialog {");
	if (height > 0) {
		innerHtml.append("min-height: ");
		innerHtml.append(height);
		innerHtml.append("px; \n");
	}
	if (width > 0) {
		innerHtml.append("width: ");
		innerHtml.append(width);
		innerHtml.append("px; ");
		innerHtml.append("}\n");
	}
	innerHtml.append("#");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal");
	innerHtml.append(" .modal-body {");
	innerHtml.append("height: ");
	innerHtml.append(modalBodyHeight);
	innerHtml.append("px; ");
	innerHtml.append("}\n");
	innerHtml.append("\n-->");
	innerHtml.append("</style>");

	innerHtml.append("<div id=\"").append(modalDivId).append("-dialog\" class=\"modal-dialog modal-dialog").append(theme).append("\">");
	innerHtml.append("<div id=\"").append(modalDivId).append("-modal-content\" class=\"modal-content\">");

	// title
	innerHtml.append("<div class=\"modal-header modal-header").append(theme).append("\">");
	innerHtml.append("<button type=\"button\" class=\"close close").append(theme).append("\" data-dismiss=\"modal\">&times;</button>");
	innerHtml.append("<h4 class=\"modal-title\" id=\"");
	innerHtml.append(modalDivId);
	innerHtml.append("-modal-label\">");
	innerHtml.append(title);
	innerHtml.append("</h4>");
	innerHtml.append("</div>");

	// content
	innerHtml.append("<div id=\"").append(modalDivId).append("-modal-body\" class=\"modal-body\">");
	innerHtml.append("</div>");

	if (footerType && footerType.length != 0) {
		innerHtml.append("<div class=\"modal-footer modal-footer").append(theme).append("\">");
		if (footerType == "confirm") {
			innerHtml.append("<a id=\"").append(modalDivId).append("-button-confirm\" href=\"#\" class=\"btn btn-primary btn-modal").append(theme).append("\" onclick=\"javascript: ").append(callback).append(";\">确定</a>");
		}
		if (footerType == "confirm-close") {
			innerHtml.append("<a id=\"").append(modalDivId).append("-button-confirm\" href=\"#\" class=\"btn btn-primary btn-modal").append(theme).append("\" onclick=\"javascript: ").append(callback).append(";\">确定</a>");
			innerHtml.append("<a href=\"#\" class=\"btn btn-modal btn-cancel").append(theme).append("\" data-dismiss=\"modal\">取消</a>");
		}
		if (footerType == "close") {
			innerHtml.append("<a href=\"#\" class=\"btn btn-modal").append(theme).append("\" data-dismiss=\"modal\">确定</a>");
		}
		if(footerType == "user-defined"){
			if(buttons.length > 0){
				for(var bIndex = 0; bIndex < buttons.length; bIndex++){
					var button = buttons[bIndex];
					innerHtml.append("<a id=\"").append(button.id).append("\" href=\"#\" class=\"btn btn-primary btn-modal").append(theme).append("\" onclick=\"javascript: ").append(button.func).append(";\">").append(button.name).append("</a>");
				}
			}
			innerHtml.append("<a href=\"#\" class=\"btn btn-modal").append(theme).append("\" data-dismiss=\"modal\">取消</a>");
		}
		innerHtml.append("</div>");
	}

	innerHtml.append("</div>");
	innerHtml.append("</div>");

	innerHtml.append("</div>");

	$("#" + modalDivId).html(innerHtml.toString(""));
	if(url && url.indexOf("/") == 0) {
		$("#" + modalDivId + "-modal-body").load(getAppName() + url);
	} else {
		$("#" + modalDivId + "-modal-body").load(getAppName() + "/" + url);
	}
	$("#" + modalDivId + "-dialog").css({
		'margin-top': function () {
			var marginTop;
			if(oriMarginTop){
				return oriMarginTop;
			}
			if(height != "" && height >0){
				marginTop = ($(window).height() - height) / 2;
				if (marginTop < 10) {
					marginTop = 10;
				}
			}else{
				marginTop = $(window).height() / 4;
				if (marginTop < 10) {
					marginTop = 10;
				}
			}
			return marginTop;
		},
		'left': function() {
			var modalWdith = width;
			if (modalWdith == 0) {
				modalWdith = $("#" + modalDivId + "-dialog").width();
			}
			var left = ($(window).width() - modalWdith) / 2;
			return left;
		},
		'position': "absolute"
	});

	$('#' + modalDivId + "-modal").on("hidden.bs.modal", function(e){
		removeDiv(modalDivId + "-modal");
	});

	regModalMousedownEvent(modalDivId + "-dialog");
	regModalMouseupEvent(modalDivId + "-dialog");
}

function regModalMousedownEvent(id) {
	$("#" + id + " .modal-header").mousedown(function(e) {
		$("#" + id + " .modal-header").css("cursor","move");

		var offset = $("#" + id).offset();
		var x = e.pageX - offset.left;
		var y = e.pageY - offset.top;
		$(document).bind("mousemove",function(ev) {
			$("#" + id + " .modal-header").stop();
			var _x = ev.pageX - x; // 获得X轴方向移动的值
			var _y = ev.clientY - y; // 获得Y轴方向移动的值
			$("#" + id).css({
				"left": _x + "px",
				"marginTop": _y + "px"
			});
		});
	});

	$("#" + id + " .modal-footer").mousedown(function(e) {
		$("#" + id + " .modal-footer").css("cursor","move");

		var offset = $("#" + id).offset();
		var x = e.pageX - offset.left;
		var y = e.pageY - offset.top;
		$(document).bind("mousemove",function(ev) {
			$("#" + id + " .modal-footer").stop();
			var _x = ev.pageX - x; // 获得X轴方向移动的值
			var _y = ev.clientY - y; // 获得Y轴方向移动的值
			$("#" + id).css({
				"left": _x + "px",
				"marginTop": _y + "px"
			});
		});
	});

}

function regModalMouseupEvent(id) {
	$(document).mouseup(function() {
		$("#" + id + " .modal-header").css("cursor","default");
		$("#" + id + " .modal-footer").css("cursor","default");
		$(document).unbind("mousemove");
	});
}

/**
 * 删除DIV
 * @param divId
 */
function removeDiv(divId) {
	do {
		try {
			removeObj($('#' + divId));
		} catch (e) {

		}
	} while ($('#' + divId).length > 0);

	do {
		try {
			removeObj(document.getElementById(divId));
		} catch(e) {

		}
	} while (document.getElementById(divId) != null);
}

function removeObj(obj) {
	try {
		obj.remove();
		return;
	} catch (e) {

	}

	try {
		obj.removeNode(true);
		return;
	} catch (e) {

	}
}

/**
 *
 * @param jqObj JQuery Object
 * @param position Top|Bottom|Left|Right
 * @returns
 */
function getMarginValue(jqObj, position) {
	return parseInt(jqObj.css('margin' + position));
}

/**
 * 弹出告警框
 * @param type success|info|warning|danger
 * @param info
 * @param relativeObjId
 * @param position right|left|top|bottom
 */
function showAlert(type, info, relativeObjId, position) {
	var relativeJqObj = $("#" + relativeObjId);
	var id = relativeObjId + '-alertdiv';
	removeDiv(id);

	// 创建alert对象
	var cls = 'alert alert-' + type + " alert-dismissible";
	var style = "position:absolute; text-align: left; z-index: 10;";
	var closeButton = "<button type=\"button\" class=\"alert-close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>";
	var alertDiv = $('<div>', {'id': id, 'class': cls, 'style': style, 'role': 'alert'});
	alertDiv.html(closeButton + info);
	relativeJqObj.parent().append(alertDiv);

	// 根据参数position调整alert位置
	if (position.length == 0) {
		position = "right";
	}
	position = position.toLocaleLowerCase();
	if (position == "right") {
		$("#" + id).css("top", (relativeJqObj.position().top + relativeJqObj.height()/2 - $("#" + id).height()/2) + "px");
		$("#" + id).css("left", (relativeJqObj.position().left + relativeJqObj.outerWidth() + getMarginValue(relativeJqObj, "Left") + 5) + "px");
	} else if (position == "left") {
		$("#" + id).css("top", (relativeJqObj.position().top + relativeJqObj.height()/2 - $("#" + id).height()/2) + "px");
		$("#" + id).css("left", (relativeJqObj.position().left - $("#" + id).outerWidth() + getMarginValue(relativeJqObj, "Left") - 5) + "px");
	} else if (position == "top") {
		$("#" + id).css("top", (relativeJqObj.position().top - $("#" + id).outerHeight() - 5) + "px");
		$("#" + id).css("left", (relativeJqObj.position().left + getMarginValue(relativeJqObj, "Left")) + "px");
	} else if (position == "bottom") {
		$("#" + id).css("left", (relativeJqObj.position().left + getMarginValue(relativeJqObj, "Left")) + "px");
		$("#" + id).css("top", (relativeJqObj.position().top + relativeJqObj.outerHeight() + getMarginValue(relativeJqObj, "Top") + 5) + "px");
	}

	// 如果宽度不足，则置为一个默认长度 ALERT_DEFAULT_WIDTH
	var width = $("#" + id).width();
	if (width < ALERT_DEFAULT_WIDTH) {
		$("#" + id).width(ALERT_DEFAULT_WIDTH);

		// 因可能换行引起高度变化，重新计算alert的top属性
		if (position == "top") {
			$("#" + id).css("top", (relativeJqObj.position().top - $("#" + id).outerHeight() - 5) + "px");
		}
	}
	return alertDiv;
}

function removeAllAlert() {
	var alerts = $(".alert");
	if (alerts && alerts.length > 0) {
		for (var i=0; i<alerts.length; i++) {
			removeObj(alerts[i]);
		}
	}
}

$.extend({
	getUrlVars: function(){
		var vars = [], hash;
		var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
		for(var i = 0; i < hashes.length; i++) {
			hash = hashes[i].split('=');
			vars.push(hash[0]);
			vars[hash[0]] = hash[1];
		}
		return vars;
	},
	getUrlVar: function(name){
		return $.getUrlVars()[name];
	}
});

/**
 * 获取form的参数（json对象）
 * @param formId
 * @returns
 */
function getFormData(formId) {
	var result = {};
	$.each($("#" + formId).serializeArray(), function() {
		result[this.name] = this.value;
	});
	return result;
}

/**
 * 获取form的参数做必填验证（json对象）
 * @param formId
 * @returns
 */
function getFormDataByVerify(formId) {
	var isError = 0;
	var result = {};
	$.each($("#" + formId).serializeArray(), function() {
		if($("#" + this.name)[0].required && $.trim(this.value)== ""){
			showAlert('warning', $("#" + this.name)[0].placeholder+'不能为空！', this.name, 'top');
			isError = 1;
			return false;
		}
		result[this.name] = this.value;
	});
	if(isError == 1){
		return "";
	}else{
		return result;
	}
}

/**
 * 获取form的参数（json对象,带特殊字符的）
 * @param formId
 * @returns
 */
function getSpecialFormData(formId) {
	var result = {};
	$.each($("#" + formId).serializeArray(), function() {
		result[this.name] = encodeURIComponent(encodeURIComponent(this.value));
	});
	return result;
}

function createMask(id, zIndex) {
	var maskDiv = $('<div>', {'id': id, 'class': 'position: absolute; '});
}

function getTheme() {
	var theme = DEFAULT_THEME;
	// 从配置获取主题
	$.ajax({
		type: "post",
		async: false,
		url: getAppName() + "/staticData/query?typeCode=SYSTEM_THEME&dataCode=" + $("#login-operator").data("operatorId"),
		success: function(data) {
			if (data && data.length > 0 && data != "null") {
				theme = JSON.parse(data)[0].value;
			}
		},
		error: function(req, error, errObj) {

		}
	});
	return theme;
}

function addThemeClass(className, theme) {
	if (!theme) {
		theme = getTheme();
	}
	theme = "-" + theme;
	$.each($("." + className), function(n, value) {
		$(value).addClass(className + theme);
	});
}

/**
 * 打开modal
 * @param modalSelector modal选择器
 * @param backdropClose 是否允许点击背景关闭modal
 * @param escClose 是否允许按ESC键关闭modal
 */
function openModal(modalSelector, backdropClose, escClose) {
	if (typeof(backdropClose) != "boolean") {
		backdropClose = true;
	}
	if (typeof(escClose) != "boolean") {
		escClose = true;
	}

	if (backdropClose && escClose) {
		$(modalSelector).modal('show');
	} else if (backdropClose && !escClose) {
		$(modalSelector).modal({keyboard: false});
	} else if (!backdropClose && !escClose) {
		$(modalSelector).modal({backdrop: "static", keyboard: false});
	} else if (!backdropClose && escClose) {
		$(modalSelector).modal({backdrop: "static"});
	}
}

/**
 * 循环json对象，将方法定义由字符串类型改成方法类型
 * @param obj
 */
function strToFunction(obj) {
	for ( var i in obj) {
		if (obj[i] != null && typeof (obj[i]) != "function"
				&& typeof (obj[i]) == "object") {
			strToFunction(obj[i]);
		}

		if(obj[i] != null){
			if(typeof (obj[i]) == "string" && obj[i].indexOf("function") > -1){
				obj[i] = eval("("+obj[i]+")");
			}
		}
	}
}

/**
 * 检查输入字符串是否只由英文字母和数字组成
 * @param s 字符串
 * @returns {Boolean} 如果通过验证返回true,否则返回false
 */
function isNumberOrLetter(s){
	var regu = "^[0-9a-zA-Z]+$";
	var re = new RegExp(regu);
	if (re.test(s)) {
		return true;
	}else{
		return false;
	}
}

/**
 * 检查输入字符串是否符合金额格式 格式定义为带小数的正数，小数点后最多两位
 * @param s 字符串
 * @returns {Boolean} 如果通过验证返回true,否则返回false
 */
function isMoney(s){
	var regu = "^[0-9]+[\.][0-9]{0,2}$";
	var re = new RegExp(regu);
	if (re.test(s)) {
		return true;
	} else {
		return false;
	}
}

/**
 * email校验
 * @param str 字符串
 * @returns {Boolean} 如果通过验证返回true,否则返回false
 */
function isEmail(str){
	var myReg = /^[-_A-Za-z0-9]+@([_A-Za-z0-9]+\.)+[A-Za-z0-9]{2,3}$/;
	if(myReg.test(str)){
		return true;
	}else{
		return false;
	}
}

/**
 * 检查输入手机号码是否正确
 * @param s 字符串
 * @returns {Boolean} 如果通过验证返回true,否则返回false
 */
function checkMobile(s){
	var regu =/^[1][3][0-9]{9}$/;
	var re = new RegExp(regu);
	if (re.test(s)) {
		return true;
	}else{
		return false;
	}
}



