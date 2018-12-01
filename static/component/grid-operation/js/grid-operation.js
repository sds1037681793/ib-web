/**
 * GRID扩展操作功能（基于mmGrid） 2015-8-17
 *
 * 使用说明： 1、在Grid定义col前，调用createGridOperation(options)方法，options参数： ctx：上下文路径
 * gridCode：表格编码，在bs_grid_operation表定义
 * 2、在mmGrid的cellSelect事件中，调用createGridOperationEvent(e, operations, modalDivId,
 * rowIndex)，监听图标点击事件 3、监听事件中，会自动调用createGridOperationModal(options)方法
 */

/**
 * 创建Grid扩展操作
 * @param options
 * @returns {Array}
 */
function createGridOperation(options) {
	// 获取操作
	var operations;
	$.ajax({
		type : "post",
		url : options.ctx + "/gridOperation/query?gridCode=" + options.gridCode,
		contentType : "application/json;charset=utf-8",
		async : false,
		success : function(data) {
			operations = eval(data);
		},
		error : function(req, error, errObj) {

		}
	});
	var result = new Array();
	if (operations) {
		$.each(operations, function(n, v) {
			var operation = {};
			operation.aClass = v.aClass;
			operation.title = v.title;
			operation.spanClass = v.spanClass;
			operation.spanFeatureClass = v.spanFeatureClass;
			operation.spanStyle = v.spanStyle;
			operation.url = v.url;
			operation.width = v.width;
			operation.height = v.height;
			operation.callback = v.callback;
			operation.footerType = v.footerType;
			operation.theme = v.theme;
			operation.clickEvent = v.clickEvent;
			operation.backdropClose = options.backdropClose;
			operation.escClose = options.escClose;

			result[result.length] = operation;
		});
	}

	return result;
}

/**
 * 创建Grid扩展操作的事件处理
 * @param e
 * @param operations
 * @param modalDivId 弹出modal的id前缀
 * @param rowIndex
 * @param row 供clickEvent中调用
 * @param errorModalDivId 供clickEvent中调用
 */
function createGridOperationEvent(e, operations, modalDivId, rowIndex, row, errorModalDivId) {
	if (operations) {
		$.each(operations, function(n, v) {
			if ($(e.target).is('.' + v.aClass) || $(e.target).is('.' + v.spanFeatureClass)) {
				var exit = false;
				if (v.clickEvent && v.clickEvent.length > 0) {
					eval(v.clickEvent);
				}
				if (exit) {
					return;
				}
				createGridOperationModal({
					modalDivId : modalDivId,
					width : v.width,
					height : v.height,
					title : v.title,
					url : v.url,
					callback : v.callback,
					footerType : v.footerType,
					theme : v.theme,
					rowIndex : rowIndex,
					backdropClose : v.backdropClose,
					escClose : v.escClose
				});
				return;
			}
		});
	}
}

/**
 * 创建Grid扩展操作的弹出Modal
 * @param options
 */
function createGridOperationModal(options) {
	var url = options.url;
	if (url.indexOf("?") >= 0) {
		url = url + "&rowIndex=" + options.rowIndex + "&tmp=" + Math.random();
	} else {
		url = url + "?rowIndex=" + options.rowIndex + "&tmp=" + Math.random();
	}
	createModalWithLoad(options.modalDivId, options.width, options.height, options.title, url, options.callback, options.footerType, options.theme);
	openModal("#" + options.modalDivId + "-modal", options.backdropClose, options.escClose);
}