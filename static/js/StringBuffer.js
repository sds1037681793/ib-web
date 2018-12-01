/**
 * @Description: 字符串拼接
 * @CreateTime: 2014-1-18 下午2:42:35
 */
function StringBulider() {
	this.data = new Array();
}

/**
 * 拼接字符串,可以连续拼接
 * @return {}
 */
StringBulider.prototype.append = function() {
	this.data.push(arguments[0]);
	return this;
};

/**
 * 转成字符串输出
 * @return {}
 */
StringBulider.prototype.toString = function() {
	if (arguments.length > 0) {
		return this.data.join(arguments[0]);
	} else {
		return this.data.join('');
	}
};

/**
 * 判断字符串数组是否为空
 * @return {}
 */
StringBulider.prototype.isEmpty = function() {
	return this.data.length <= 0;
};

/**
 * 清空字符串数组
 */
StringBulider.prototype.clear = function() {
	this.data = [];
	this.data.length = 0;
};

/** 测试方法
var sb = new StringBulider();
sb.append("a").append("b").append("c").append("d");
alert(sb.toString(',')); //结果: a,b,c,d
*/
