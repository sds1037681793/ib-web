(function($) {
	jQuery.fn.dynamicReport = function(options) {
		var defaults = {
			reportType : "3", // MMGrid
			colPerRow : "2"
		};

		var options = $.extend(defaults, options);
		var mmgrid;
		var pg;
		var dynamicTable;
		var dynamicTableItems;

		this.query = function() {
			pg.load({
				"page" : 1
			});
			mmgrid.load();
		}
		this.exportExecl = function() {
			exportExecl();
		}
		this.showPicture = function(titlesString, imageUrlsString) {
			addPicture(titlesString, imageUrlsString);
		}

		return this.each(function() {
			var opts = options;
			var obj = $(this);

			var reportHtml = "";

			// 查询条件
			reportHtml = '<div class="content-default">';
			reportHtml += '<form id="dynamic-report-query-' + opts.id + '"></form>';
			reportHtml += '</div>';

			// MMGrid
			reportHtml += '<table id="dynamic-report-mmgrid-' + opts.id + '" class="dynamic-report" style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">';
			reportHtml += '<tr><th rowspan="" colspan=""></th></tr>';
			reportHtml += '</table>';
			reportHtml += '<div id="dynamic-report-mmgrid-pg-' + opts.id + '" style="text-align: right;"></div>';

			// 生成报表内容
			$("#" + opts.containerDivId).html(reportHtml);

			// 获取动态表单参数并初始化
			$.ajax({
				type : "post",
				async : "false",
				url : opts.contextPath + "/report/getQueryParamDefine/" + opts.id,
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(new Object()),
				success : function(data) {
					if (data != null && data.length > 0) {
						try {
							dynamicTableItems = eval(data);// JSON.parse(data);
						} catch (e) {
						}
						if (dynamicTable) {
							dynamicTable.destroy();
						}
						if (dynamicTableItems != undefined && dynamicTableItems != null) {
							// 查询条件表单初始化
							dynamicTable = $("#dynamic-report-query-" + opts.id).dynamicTable({
								items : dynamicTableItems,
								method : "all",
								groupId : "dynamic-report-query-group-" + opts.id,
								colPerRow : opts.colPerRow,
								dateFormat : opts.conditionDateFormate
							});

							//在动态表格加载成功后，在加载mmgrid的数据，防止默认值还没获取到时直接加载，导致数据有问题
							if(opts.autoLoad){
								mmgrid.load();
							}
						}
					} else {
						if (dynamicTable) {
							dynamicTable.destroy();
						}
					}
				},
				error : function(req, error, errObj) {
					console.info("Failed to get params define: " + error);
				}
			});

			// MMGrid初始化
			pg = $('#dynamic-report-mmgrid-pg-' + opts.id).mmPaginator({
				"limitList" : [
					opts.rowlimit
				]
			});
			mmgrid = $("#dynamic-report-mmgrid-" + opts.id).mmGrid({
				height : opts.height,
				cols : opts.cols,
				// TODO URL如何处理
				url : opts.contextPath + '/report/' + opts.id,
				method : opts.method,
				/*
				 * remoteSort: opts.remoteSort, sortName: opts.sortName,
				 * sortStatus: opts.sortStatus,
				 */
				multiSelect : opts.multiSelect,
				checkCol : opts.checkCol,
				fullWidthRows : opts.fullWidthRows,
				autoLoad : false,
				showBackboard : opts.showBackboard,
				params : function() {
					// 查询参数处理
					var queryParams = {};
					if (dynamicTableItems) {
						$.each(dynamicTableItems, function(n, item) {
							var object = $("#" + item.inputName);
							if (object != undefined && object != null) {
								queryParams[item.inputName] = $.trim(object.val());
							}
						});
					}
					return queryParams;
				},
				plugins : [
					pg
				]
			});
			mmgrid.on('loadSuccess', function(e, data) {
				var className = "sumLabel";
				var spanResult = data.spanResult;
				var tableHeight = (data.totalCount) * 35;
				if (spanResult != "" || spanResult != null) {
					var divshow = $("#dynamic-report-mmgrid-" + opts.id).parent();
					// 计算列表高度，设置合计展现形式
					var divHeight = $("#dynamic-report-mmgrid-" + opts.id).parent()[0].offsetHeight;
					if (tableHeight < divHeight) {
						className = "sumLabelAbsolute";
					}
					var div = document.getElementById("sumDiv-" + opts.id);
					if (undefined != div && null != div) {
						div.parentNode.removeChild(div);
					}
					var html = '<div id="sumDiv-' + opts.id + '"  class="' + className + '"></div>';
					divshow.append(html);
					$('#sumDiv-' + opts.id).html(spanResult);
				}
			});
			mmgrid.on('cellSelected', function(e, item, rowIndex, colIndex) {
				mmgridRow = mmgrid.row(rowIndex);
			}).on('dblclick', function(e, item, rowIndex) {
				if (null != opts.events && opts.events.length > 0) {
					if (null != opts.events[0].dblclick && undefined != opts.events[0].dblclick) {
						eval(opts.events[0].dblclick);
					}
				}
			});

		});

		function exportExecl() {
			var opts = options;
			var url = opts.contextPath + '/report/exportExecl/' + opts.id
			var prams = "?id=" + opts.id + "&userAgent=" + navigator.userAgent;
			$.each(dynamicTableItems, function(n, item) {
				var object = $("#" + item.inputName).val();
				if (object != undefined && object != null) {
					prams = prams + "&" + item.inputName + "=" + $.trim($("#" + item.inputName).val());
				}
			});
			window.open(url + prams);
		}

		function addPicture(titlesString, imageUrlsString) {
			var opts = options;
			var srcTitles = titlesString.split(",");
			var srcImageUrls = imageUrlsString.split(",");
			var titles = new Array();
			var imageUrls = new Array();
			if ("" != imageUrlsString && srcImageUrls.length > 0) {
				for (var j = 0; j < srcImageUrls.length; j++) {
					if (null != srcImageUrls[j] && "" != srcImageUrls[j]) {
						imageUrls.push(srcImageUrls[j]);
						if (j < srcTitles.length) {
							titles.push(srcTitles[j]);
						}
					}
				}
			}
			var index = 1;
			var total = imageUrls.length;
			if ("" != imageUrlsString && imageUrls.length > 0) {
				$('#pictureUL-' + opts.id).empty();
				for (var i = 0; i < total; i++) {
					var indexStr = "(" + index + "/" + total + ")";
					var html = '<li>';
					var spanContent = "";
					html += '<img alt="" id="pictureUL-' + opts.id + '-imag-' + i + '" src="' + imageUrls[i] + '"' + 'onerror=" src=\'' + opts.contextPath + '/static/component/dynamic-report-processor/img/image-error.png\'" title="' + imageUrls[i] + '"/>';
					if (i < titles.length) {
						spanContent += titles[i];
					}
					spanContent += indexStr;
					html += '<span>' + spanContent + '</span>';
					html += '</li>';
					$('#pictureUL-' + opts.id).append(html);
					var wad = new Wadda('pictureUL-' + opts.id + '-imag-' + i, {
						"doZoom" : false
					});
					wad.setZoom(2);
					index++;
				}
				openModal("#modal-picture-" + opts.id, true, false);
				showPhotos();

			} else {
				showDialogModal("error-div", "未找到图片", "未找到图片");
			}
		}
	}
})(jQuery);