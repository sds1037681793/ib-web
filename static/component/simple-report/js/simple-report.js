(function($) {
	jQuery.fn.simpleReport = function(options) {
		// 默认参数
		var defaults = {
			theme : "default",
			style : "normal", // normal、direct
			direct : {
				method : "append"
			}
		};

		var options = $.extend(defaults, options);
		return this.each(function() {
			var opts = options;
			var obj = $(this);

			if (opts.style == "direct") {
				var datas = getDatas(opts.url);
				createDirectReport(obj, opts, datas);
			} else {
				var datas = opts.items;
				if (opts.url != undefined && opts.url.length > 0) {
					var temp = getDataObject(opts.url);
					if (temp != null) {
						datas = temp;
					}
				}

				if (datas != undefined) {
					if (!opts.style || opts.style == "normal") {
						createNormalReport(obj, opts, datas);
					}
				}
			}
		});

		function getDataObject(url) {
			var result = null;
			var dataStr = getDatas(url);
			eval("result = " + dataStr);
			return result;
		}

		function getDatas(url) {
			var result = null;
			$.ajax({
				type : "post",
				async : false,
				url : url,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					result = data;
				},
				error : function(req, error, errObj) {

				}
			});
			return result;
		}

		function createNormalReport(obj, opts, datas) {
			var html = '<table border="0" cellpadding="0" cellspacing="0" width="100%">';

			// 表头
			html += '<tr class="title-tr title-tr-' + opts.theme + '">';
			var columnParams = new Array();
			$.each(datas.columns, function(n, value) {
				html += '<td width="' + value.width + 'px" style="text-align: center">' + value.title + '</td>';
				columnParams[columnParams.length] = value;
			});
			html += '</tr>';

			// 表数据
			$.each(datas.datas, function(n, value) {
				var lineClass;
				if (n % 2 == 0) {
					lineClass = "tr-odd-row-" + opts.theme;
				} else {
					lineClass = "tr-even-row-" + opts.theme;
				}
				html += '<tr class="data-tr data-tr-' + opts.theme + ' ' + lineClass + '">';
				for (var i = 0; i < columnParams.length; i++) {
					html += '<td style="text-align: ' + columnParams[i].align + '; padding-left: 5px;">' + eval('value.' + columnParams[i].name) + '</td>';
				}
				html += '</tr>';
				i++;
			});
			html += "</table>";

			obj.html(html);
		}

		function createDirectReport(obj, opts, datas) {
			if (opts.direct.method == "append") {
				obj.append(datas);
			} else {
				obj.html(datas);
			}
		}
	};
})(jQuery);