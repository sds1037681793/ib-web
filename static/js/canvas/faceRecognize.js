function Stage(faceCtx) {
	this.faceCtx = faceCtx;
	this.displayObjects = [];
}

Stage.prototype.add = function(displayObject) {
	this.displayObjects.push(displayObject);
};

// 渲染循环
Stage.prototype.render = function() {
	var displayObjects = this.displayObjects;
	var faceCtx = this.faceCtx;

	function loop() {
		// 清空画布
		faceCtx.clearRect(0, 0, faceCanvas.width, faceCanvas.height);
		// 重绘每一个displayObject
		displayObjects.forEach(function(displayObject) {
			displayObject.update(faceCtx);
		});
		stop = requestAnimationFrame(loop);
	}

	loop();
};

// 一个简单的display object
function Rectangle(x, y, w, h) {
	this.x = x;
	this.y = y;
	this.w = w;
	this.h = h;
}

// display object主要是根据自己的属性知道如何绘制自己
Rectangle.prototype.update = function(faceCtx) {
	faceCtx.beginPath();
	faceCtx.fillStyle = "rgba(3,237,255,0.18)";
	faceCtx.fillRect(this.x, this.y, this.w, this.h);
	if (this.h - 20 > 0) {
		// faceCtx.drawImage(faceImage,this.x+40,this.y+30,faceImage.width,this.h-20,this.x+10,this.y+10,faceImage.width,this.h-20);
		try {
			faceCtx.drawImage(faceImage, this.x + 10, this.y + 10, faceImage.width, this.h - 20);
		} catch (err) {
			if (faceImageQueue.size() > 0) {
				initFace();
			} else {
				$("#face_start").removeClass("face_regonized");
				$("#tangan").toggleClass("tangan");
				faceCtx.clearRect(0, 0, faceCanvas.width, faceCanvas.height);
				$(".focus_face").hide();
				console.log("人脸图片错误:" + err);
			}
		}

	}

	faceCtx.stroke();
	faceCtx.closePath();
};

function initFace() {
	var urlPath = faceImageQueue.pop();
	faceImage.src = urlPath;
	// 创建1个display object
	var rect = new Rectangle(0, 0, 100, 0);
	stage = new Stage(faceCtx);

	// 放入stage并开始渲染循环
	stage.add(rect);
	stage.render();

	// 这里不断改变一个display object的显示属性
	flushImage = setInterval(function() {
		rect.h = (rect.h + 2);
		if (rect.h > 101) {
			cancelAnimationFrame(stop);
			clearInterval(flushImage);
			flushImageOut = setTimeout(function() {
				if (faceImageQueue.size() > 0) {
					initFace();
				} else {
					$("#face_start").removeClass("face_regonized");
					$("#tangan").removeClass("tangan");
					faceCtx.clearRect(0, 0, faceCanvas.width, faceCanvas.height);
					$(".focus_face").hide();
				}
			}, 1000);
		}
	}, 20);

}

/**
 * [Queue]
 * 
 * @param {[Int]}
 *            size [队列大小]
 */
function Queue(size) {
	var list = [];

	// 向队列中添加数据
	this.push = function(data) {
		if (data == null) {
			return false;
		}
		// 如果传递了size参数就设置了队列的大小
		if (size != null && !isNaN(size)) {
			if (list.length == size) {
				this.pop();
			}
		}
		list.unshift(data);
		return true;
	}

	// 从队列中取出数据
	this.pop = function() {
		return list.pop();
	}

	// 返回队列的大小
	this.size = function() {
		return list.length;
	}

	// 返回队列的内容
	this.quere = function() {
		return list;
	}
}

/** 开闸,车来了* */
// 1入口 2出口
function openDoor(type) {
	var car;
	var ganzi;
	if (type == 1) {
		car = "car_in";
		ganzi = "ganziIn";
	} else if (type == 2) {
		car = "car_out";
		ganzi = "ganziOut";
	}
	$("#" + car).addClass("car_in");
	$("#" + ganzi).addClass("open_door");

}
// 开始人脸识别
function startFaceRecoginaze(urlPath) {
	faceImageQueue.push(urlPath);// 放入识别队列中展现效果
	if ($("#tangan").hasClass("tangan")) {
//		$("#face_start").removeClass("face_regonized");
//		$("#tangan").removeClass("tangan");
//		faceCtx.clearRect(0, 0, faceCanvas.width, faceCanvas.height);
//		$(".focus_face").hide();
	} else {
		$(".focus_face").show();
		$("#face_start").addClass("face_regonized");
		$("#tangan").toggleClass("tangan");
		if (typeof (flushImageOut) != 'undefined') {
			clearTimeout(flushImageOut);
		}
	}
}
