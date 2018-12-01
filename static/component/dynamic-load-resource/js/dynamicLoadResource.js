var dynamicLoadResource = {
	css : function(res) {
		if (!res || res.length == 0) {
			throw new Error("DLR：argument 'res' is required!");
		}
		var head = document.getElementsByTagName("head")[0];
		var link = document.createElement("link");
		link.href = res;
		link.rel = "stylesheet";
		link.type = "text/css";
		head.appendChild(link);
	},
	js : function(res) {
		if (!res || res.length == 0) {
			throw new Error("DLR：argument 'res' is required!");
		}
		var head = document.getElementsByTagName("head")[0];
		var script = document.createElement("script");
		script.src = res;
		script.type = "text/javascript";
		head.appendChild(script);
	}
};