function Map() {
	this.container = new Object();
}

Map.prototype.put = function(key, value) {
	this.container[key] = value;
}

Map.prototype.get = function(key) {
	return this.container[key];
}

Map.prototype.keySet = function() {
	var keyset = new Array();
	var count = 0;
	for ( var key in this.container) {
		// 跳过object的extend函数
		if (key == 'extend') {
			continue;
		}
		keyset[count] = key;
		count++;
	}
	return keyset;
}

function getTimeFormat(maxtime) {
	var returnVal = "";
	maxtime = maxtime;
	days = Math.floor(maxtime / 1440);
	hours = Math.floor((maxtime % 1440) / 60);
	minutes = Math.floor(((maxtime % 1440) % 60));
	returnVal = days + "天" + hours + "时" + minutes + "分";
	return returnVal;
}
function getMoneyFormat(val) {
	var str = (val / 100).toFixed(2) + '';
	var intSum = str.substring(0, str.indexOf(".")).replace(
			/\B(?=(?:\d{3})+$)/g, ',');// 取到整数部分
	var dot = str.substring(str.length, str.indexOf("."))// 取到小数部分
	var ret = intSum + dot;
	return ret;
}

Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	}

	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}

	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
}

var map = new Map();

function PlateColor(background,color)
{
	this.background = background;
	this.color = color;
}

var plateColorMap = new Map();
plateColorMap.put("蓝",new PlateColor("blue","white"));
plateColorMap.put("黄",new PlateColor("yellow","black"));
plateColorMap.put("白",new PlateColor("white","black"));
plateColorMap.put("黑",new PlateColor("black","white"));
plateColorMap.put("绿",new PlateColor("green","white"));

(function($) {
	$.fn.wordLimit = function(num) {
		this.each(function() {
			var ori = $(this).text();
			if (!num) {
				var copyThis = $(this.cloneNode(true)).hide().css({
					'position' : 'absolute',
					'width' : 'auto',
					'overflow' : 'visible'
				});
				$(this).after(copyThis);
				if (copyThis.width() > $(this).width()) {
					$(this).text(
							$(this).text().substring(0,
									$(this).text().length - 4));
					$(this).html($(this).html() + '...');
					copyThis.remove();
					$(this).wordLimit();
				} else {
					copyThis.remove(); // 清除复制
					return;
				}
			} else {
				var maxwidth = num;
				if ($(this).text().length > maxwidth) {
					$(this).text($(this).text().substring(0, maxwidth));
					$(this).html($(this).html() + '...');
				}
			}
			$(this).attr("title",ori);
		});
	}
})(jQuery);