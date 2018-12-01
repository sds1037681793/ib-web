//function Stage(faceCtx) {
//	this.faceCtx = faceCtx;
//	this.displayObjects = [];
//}
//
//Stage.prototype.add = function(displayObject) {
//	this.displayObjects.push(displayObject);
//};
//
//// 渲染循环
//Stage.prototype.render = function() {
//	var displayObjects = this.displayObjects;
//	var faceCtx = this.faceCtx;
//
//	function loop() {
//		// 清空画布
//		faceCtx.clearRect(0, 0, faceCanvas.width, faceCanvas.height);
//		// 重绘每一个displayObject
//		displayObjects.forEach(function(displayObject) {
//			displayObject.update(faceCtx);
//		});
//		stop = requestAnimationFrame(loop);
//	}
//
//	loop();
//};
//
//// 一个简单的display object
//function Rectangle(x, y, w, h) {
//	this.x = x;
//	this.y = y;
//	this.w = w;
//	this.h = h;
//}
//
//// display object主要是根据自己的属性知道如何绘制自己
//Rectangle.prototype.update = function(faceCtx) {
//	faceCtx.beginPath();
//	faceCtx.fillStyle = "rgba(3,237,255,0.18)";
//	faceCtx.fillRect(this.x, this.y, this.w, this.h);
//	if (this.h - 20 > 0) {
//		// faceCtx.drawImage(faceImage,this.x+40,this.y+30,faceImage.width,this.h-20,this.x+10,this.y+10,faceImage.width,this.h-20);
//		try {
//			faceCtx.drawImage(faceImage, this.x + 10, this.y + 10, faceImage.width, this.h - 20);
//		} catch (err) {
//			if (faceImageQueue.size() > 0) {
//				initFace();
//			} else {
//				$("#tangan").toggleClass("tangan");
//				faceCtx.clearRect(0, 0, faceCanvas.width, faceCanvas.height);
//				$("#faceCvs").hide();
//				$("#faceBg").hide();
//				console.log("人脸图片错误:" + err);
//			}
//		}
//
//	}
//
//	faceCtx.stroke();
//	faceCtx.closePath();
//};

function initFace() {
	var faceParam = faceImageQueue.pop();
	faceImage.src = faceParam.faceUrl;
	var personType = faceParam.personType;
//	 创建1个display object
//	// 放入stage并开始渲染循环
	$("#faceCvs").empty();
//	$("#faceCvs").removeClass();
	var faceHtml = "";
//	var div = "<img id = 'faceCvs-img' style = 'width:90px;' src ='"+faceParam.faceUrl+"'/>";
	 if (personType == 0 || personType == 1) {//陌生人 
         	faceHtml = "<div id ='personType-div' style='width:96px;height: 96px;'><img id = 'faceCvs-img' style = 'width:95px;height: 95px;padding:2px' src ='"+faceParam.faceUrl+"'/></div>";
		} else if (personType == 2) { //VIP
         faceHtml = "<div id ='personType-div' style='width:96px;height: 96px; border: 1px solid #F8E71C ;'><img id = 'faceCvs-img' style = 'width:95px;height: 95px;padding:2px' src ='"+faceParam.faceUrl+"'/>" +
             '<div style="display: block;height: 30px;z-index: 2;position: absolute;width: 30px;top: 65px;left: 65px;color: #F8E71C;"><img src="'+ctx+'/static/img/video/vip_img.svg" style="width: 30px;height: 30px;"/></div></div>';
		} else if (personType == 3) { //重点关注人员
         faceHtml = "<div id ='personType-div' style='width:96px;height: 96px; position: relative;border: 1px solid #D632FF;'><img id = 'faceCvs-img' style = 'width:95px;height: 95px;padding:2px' src ='"+faceParam.faceUrl+"'/>" +
             '<div class="face_bottom_info" style="background-color: rgba(214,50,255,0.6);">重点关注</div></div>';
		} else if (personType == 4) { //黑名单
         faceHtml = "<div id ='personType-div' style='width:96px;height: 96px; position: relative;border: 1px solid #FF6262 ;'><img id = 'faceCvs-img' style = 'width:95px;height: 95px;padding:2px' src ='"+faceParam.faceUrl+"'/>" +
             '<div class="face_bottom_info" style="background-color: rgba(255,98,98,0.6);">黑名单</div></div>';
		} else {
			faceHtml = "<div id ='personType-div' style='width:96px;height: 96px;'><img id = 'faceCvs-img' style = 'width:95px;height: 95px;padding:2px' src ='"+faceParam.faceUrl+"'/></div>";
     }
	$("#faceCvs").append(faceHtml);
	$("#faceCvs").show(1000);
	// 这里不断改变一个display object的显示属性
	flushImage = setInterval(function() {
			clearInterval(flushImage);
			flushImageOut = setTimeout(function() {
				if (faceImageQueue.size() > 0) {
					$("#faceCvs").hide(100);
					initFace();
				} else {
					$("#tangan").removeClass("tangan");
					$("#faceCvs").hide();
				}
			}, 2000);
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

// 开始人脸识别
function startFaceRecoginaze(faceParam) {
	faceImageQueue.push(faceParam);// 放入识别队列中展现效果
	if ($("#tangan").hasClass("tangan")) {
//		$("#face_start").removeClass("face_regonized");
//		$("#tangan").removeClass("tangan");
//		faceCtx.clearRect(0, 0, faceCanvas.width, faceCanvas.height);
//		$(".focus_face").hide();
	} else {
		$("#tangan").toggleClass("tangan");
		if (typeof (flushImageOut) != 'undefined') {
			clearTimeout(flushImageOut);
		}
	}
}
