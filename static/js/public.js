/**
 * 获取应用名
 *
 * @returns
 */
function getAppName() {
	var pathname = window.location.pathname;
	var index = pathname.substr(1).indexOf("/");
	return pathname.substr(0, index + 1);
}

/**
 * 根据参数名获取URL中的参数
 * @param url
 * @param name
 * @returns
 */
function getUrlParam(url, name, codeType) {
	var reg = new RegExp("(^|[&\?])" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
	var r = url.match(reg); // 匹配目标参数
	if (r != null) {
		if (codeType && codeType.toUpperCase() == "encodeURI".toUpperCase()) {
			return decodeURI(r[2]);
		} else {
			return unescape(r[2]);
		}
	} else {
		return null; // 返回参数值
	}
}