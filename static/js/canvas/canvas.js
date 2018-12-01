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
	if(this.h-14>0){
		faceCtx.drawImage(faceImage,this.x,this.y,faceImage.width,this.h-14,this.x+8,this.y+7,faceImage.width,this.h-14);
	}
	
// faceCtx.drawImage(faceImage,this.x+8,this.y+7,faceImage.width,this.h-14);
	faceCtx.stroke();
	faceCtx.closePath();
};

function init() {
	// 创建1个display object
	var rect = new Rectangle(0, 0, 83, 0);
	stage = new Stage(faceCtx);

	// 放入stage并开始渲染循环
	stage.add(rect);
	stage.render();

	// 这里不断改变一个display object的显示属性
	var fulshImage = setInterval(function() {
		rect.h = (rect.h + 1);
		if (rect.h > 113) {
			cancelAnimationFrame(stop);
			clearInterval(fulshImage);
		}
	}, 20);
}
function rotate(){
	 var x = cc.width/2; // 画布宽度的一半
    var y = cc.height/2;// 画布高度的一半
    ctx.clearRect(0,0, cc.width, cc.height);// 先清掉画布上的内容
    ctx.translate(x,y);// 将绘图原点移到画布中点
    ctx.rotate(((Math.PI)/180)*5);// 旋转角度
    ctx.translate(-x,-y);// 将画布原点移动
    ctx.drawImage(yuanHuan,0,0);// 绘制图片
   
}

function drawFace() {
	context.strokeStyle = "#03EDFF";
	x = 200, y = 300, length = x + 42, x1 = 0, y1 = 0, length1 = 0, x2 = 0, y2 = 0, length2 = 0;
	context.clearRect(x,0, canvas.width, canvas.height);// 先清掉画布上的内容
	if(typeof(faceCanvas)!="undefined"){
		faceCtx.clearRect(0, 0, faceCanvas.width, faceCanvas.height);
	}
	context.beginPath();
	context.arc(x, y, 1, 0, Math.PI * 2, true);
	context.fillStyle = "#03EDFF";
	context.fill();
	firstRoad();
}

function firstRoad() {
	if (x < length) {
		context.lineWidth = 1;
		context.moveTo(x, y);
		context.lineTo(++x, y);
		y = y - 1.7;
		context.stroke();
		setTimeout("firstRoad()", deloy);
	} else {
		x1 = x;
		y1 = y;
		length1 = x1 + 81;
// context.beginPath();
		context.arc(x, y, 4, 0, Math.PI * 2, true);
		context.fillStyle = "#03EDFF";
		context.fill();
		context.stroke();
		secondRoad();
	}
}
function secondRoad() {
	if (x1 < length1) {
		context.lineWidth = 1;
		context.moveTo(x1, y1);
		context.lineTo(++x1, y1);
		y1 = y1 - 0.7654;
		context.stroke();
		setTimeout("secondRoad()", deloy);
	} else {
		x2 = x1;
		y2 = y1;
		length2 = x2 + 83;
// context.beginPath();
		context.arc(x1, y1, 4, 0, Math.PI * 2, true);
		context.fillStyle = "#03EDFF";
		context.fill();
		context.stroke();
		context.closePath();
		thirdRoad();
	}
}
function thirdRoad() {
	if (x2 < length2) {
		context.lineWidth = 1;
		context.moveTo(x2, y2);
		// x2=374;y2=166.6026000000005
		context.lineTo(++x2, y2);
		context.stroke();
		setTimeout("thirdRoad()", deloy);
	} else {
		init();
	}
}



