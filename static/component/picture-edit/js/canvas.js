/**
 * 图片编辑工具：HTML5+JQuery 
 * options:1代表true,0代表false
 * dialogModel：dialog模式（用jqueryUI的dialog模式展示）
 * scale:是否允许缩放
 * drawPencil：是否显示画笔
 * penWidth：是否显示画笔粗细
 * rectangle：是否显示添加矩形
 * text：是否显示添加文字
 * fontSize：是否显示字体大小选择框
 * fontType：是否显示字体选择框
 * line：是否显示添加直线
 * frameColor：是否显示线条颜色选择框
 * fillColor：是否显示字体颜色选择框
 * frameDefaultColor：线条默认颜色
 * fillDefaultColor：字体默认颜色
 * contextPath：项目路径
 */

(function($){
	jQuery.fn.canvasPic = function(divId,dialogWidth,dialogHeigh,options) {
		var defaults = {
				dialogModel:1,//dialog模式
				scale:1,//是否允许缩放
				drawPencil:1,//画笔
				penWidth:1,//画笔粗细
				rectangle:1,//矩形
				text:1,//文字
				fontSize:1,//字体大小
				fontType:1,//字体
				line:1,//直线
				frameColor:1,//线条颜色
				fillColor:1,//字体颜色
				frameDefaultColor: 'f50808',//线条默认颜色
				fillDefaultColor:'f50808',//字体默认颜色
				contextPath:'rib-security'
			};
		var options = $.extend(defaults, options);
		var isInitCanvas = false;
		var x, y, endX, endY;
		var imgX = 0;
		var imgY = 0;
		var imgScale = 1;
		var canvas;
		var context;
		var img = new Image();// 图片对象
		var imgIsLoaded = false;// 图片是否加载完成
		var commandCallbacks;
		var command;
		var lineTip;
		var cStep;
		var rectTip;
		var fontTip;
		var flag = false;
		var canvasHtml ="";

		//允许跨域
		img.crossOrigin = "Anonymous";
		// 存储历史操作，方便撤销和恢复
		var history = new Array();
		cStep = -1;
		
		if(options.dialogModel == 1){
			//避免重复初始化
			try { 
				$("#pic-dialog").dialog("destroy");
			}catch (e) { 
			
			} 
			
			this.openDialog = function() {
				$( "#pic-dialog" ).dialog("open");
				clearCanvas();//清空画布
				history.length = 0;
				cStep = -1;
				imgScale = 1;
			}
			this.closeDialog = function() {
				$( "#pic-dialog" ).dialog("close");
			}
		}
		
		this.cleanCanvas = function() {
			clearCanvas();//清空画布
			history.length = 0;
			cStep = -1;
			imgScale = 1;
		}
		
		this.setSrcImage = function(imageSrc) {
			clearCanvas();//清空画布
			history.length = 0;
			cStep = -1;
			imgScale = 1;
			var srcImage = new Image();
			srcImage.crossOrigin = "Anonymous";
			srcImage.onload = function() {
				canvas.height = srcImage.height;
				canvas.width = srcImage.width;
				canvas.style.width = srcImage.width + "px";
				canvas.style.height = srcImage.height + "px";
				context.drawImage(srcImage, 0, 0, srcImage.width,
						srcImage.height);
				historyPush();
				imgIsLoaded = true;
			}
			srcImage.src = imageSrc;
		}

		/**
		 * Every function in this app has a corresponding command code:
		 * -------------------------------------------------- function command
		 * code description --------------------------------------------------
		 * brash(pencil) 1 use it as a pencil to draw eraser 2 use it as a
		 * eraser to erase some spots trash 3 you can clean the whole canvas
		 * draw line 4 draws straight lines draw rectangle 5 draw rectangles
		 * draw words 6 you can input words on the canvas
		 * 
		 */

		// Every function has different canvas context and cursor style
		// therefore, we create a callback list to .....
		// 1. switch the canvas context
		// 2. switch the cursor style when the mouse is on the canvas
		command = 1;
		commandCallbacks = $.Callbacks();
		commandCallbacks.add(switchCanvasContext);
		commandCallbacks.add(switchCursorStyle);
		$("#"+divId).empty();
		// 动态生成html
		canvasHtml = "";
		canvasHtml = '<div id="pic-dialog" title="图片编辑工具" class="canvas_dialog">';	
		canvasHtml +='<div style="font-size:12px;">';
		canvasHtml +='<div class="container-top">';
		canvasHtml +='<span style="display: block; float: left;" id="penWidthSpan">';
		canvasHtml +='<span style="text-align: center; line-height: 30px; float: left; display: block;">线条粗细: </span>';
		canvasHtml +='<select id="penWidth">';
		canvasHtml +='<option value="1" selected>1px</option>';
		canvasHtml +='<option value="2">2px</option>';
		canvasHtml +='<option value="4">4px</option>';
		canvasHtml +='<option value="6">6px</option>';
		canvasHtml +='<option value="8">8px</option>';
		canvasHtml +='<option value="12">12px</option>';
		canvasHtml +='<option value="14">14px</option>';
		canvasHtml +='<option value="16">16px</option>';
		canvasHtml +='<option value="18">18px</option>';
		canvasHtml +='</select>';
		canvasHtml +='</span>';
		canvasHtml +='<span style="display: block; float: left;margin-left: 15px;" id="fontSizeSpan">';
		canvasHtml +='<span style="text-align: center; line-height: 30px; float: left; display: block;">字体大小:</span>'; 
		canvasHtml +='<select id="fontSize">';
		canvasHtml +='<option value="8px" selected>8px</option>';
		canvasHtml +='<option value="10px">10px</option>';
		canvasHtml +='<option value="12px">12px</option>';
		canvasHtml +='<option value="14px">14px</option>';
		canvasHtml +='<option value="16px">16px</option>';
		canvasHtml +='<option value="18px">18px</option>';
		canvasHtml +='<option value="20px">20px</option>';
		canvasHtml +='<option value="22px">22px</option>';
		canvasHtml +='<option value="24px">24px</option>';
		canvasHtml +='<option value="26px">26px</option>';
		canvasHtml +='<option value="28px">28px</option>';
		canvasHtml +='<option value="30px">30px</option>';
		canvasHtml +='<option value="32px">32px</option>';
		canvasHtml +='<option value="34px">34px</option>';
		canvasHtml +='<option value="36px">36px</option>';
		canvasHtml +='</select>'; 
		canvasHtml +='</span>';
		canvasHtml +='<span style="display: block; float: left;margin-left: 15px;" id="fontTypeSpan">';
		canvasHtml +='<span style="text-align: center; line-height: 30px; float: left; display: block;">字体选择:</span>';	        		
		canvasHtml +='<select id="fontType">';
		canvasHtml +='<option value="宋体" >宋体</option>';
		canvasHtml +='<option value="微软雅黑">微软雅黑</option>';
		canvasHtml +='<option value="仿宋">仿宋</option>';
		canvasHtml +='<option value="Arial" selected>Arial</option>';
		canvasHtml +='<option value="Consolas">Consolas</option>';
		canvasHtml +='</select>';
		canvasHtml +='</span>';
		canvasHtml +='<span style="display: block; float: left;margin-left: 15px;" id="frameColorSpan">';
		canvasHtml +='<span style="text-align: center; line-height: 30px; float: left; display: block;">线条颜色:</span>';
		canvasHtml +='<input id="colorpicker-popup" type="text"  value="'+options.frameDefaultColor+'" style="width: 72px;display:none; ">';
		canvasHtml +='</span>';
		canvasHtml +='<span style="display: block; float: left;margin-left: 15px;" id="fillColorSpan">';
		canvasHtml +='<span style="text-align: center; line-height: 30px; float: left; display: block;">字体颜色:</span>';
		canvasHtml +='<input id="colorpicker-popup2" type="text" value="'+options.fillDefaultColor+'" style="width: 72px;display:none; ">';
		canvasHtml +='</span>';
		canvasHtml +='<span style="font-weight:bold;display:none;"><input type="checkbox" id="boldOption" name="fontOption"><label for="boldOption">B</label></span>';
		canvasHtml +='<span style="font-style: italic;display:none;"><input type="checkbox" id="italicOption" name="italicOption"><label for="italicOption">I</label></span>';
		canvasHtml +='</div>';
		canvasHtml +='<div style="border:#cccccc solid  1px;height:'+(dialogHeigh-94)+'px;">';
		canvasHtml +='<div class="container-left">';
		canvasHtml +='<span id="pencilSpan">';
		canvasHtml +='<input type="radio" id="tools_pencil" name="toolsOption" checked="checked"><label for="tools_pencil" title="画笔"></label>';
		canvasHtml +='</span>';
		canvasHtml +='<span style="display:none;">';
		canvasHtml +='<input type="radio" id="tools_eraser" name="toolsOption" ><label for="tools_eraser" title="橡皮擦"></label>';
		canvasHtml +='</span>';
		canvasHtml +='<span id="trashSpan">';
		canvasHtml +='<input type="radio" id="tools_trash" name="toolsOption"><label for="tools_trash" title="清空"></label>';
		canvasHtml +='</span>';
		canvasHtml +='<span id="lineSpan">';
		canvasHtml +='<input type="radio" id="tools_line" name="toolsOption"><label for="tools_line" title="直线"></label>';
		canvasHtml +='</span>';
		canvasHtml +='<span id="rectangleSpan">';
		canvasHtml +='<input type="radio" id="tools_rectangle" name="toolsOption"><label for="tools_rectangle" title="矩形"></label>';
		canvasHtml +='</span>';
		canvasHtml +='<span id="circleSpan">';
		canvasHtml +='<input type="radio" id="tools_circle" name="toolsOption"><label for="tools_circle" title="文字"></label>';
		canvasHtml +='</span>';
		canvasHtml +='<span>';
		canvasHtml +='<input type="file" style="display:none" id="imageFile" >';
		canvasHtml +='<button id="tools_open" style="width:40px;height:40px;" title="打开"></button>';
		canvasHtml +='</span>';
		canvasHtml +='<span>';
		canvasHtml +='<button id="tools_save" style="width:40px;height:40px;" title="保存"></button>';
		canvasHtml +='</span>';
		canvasHtml +='<span>';
		canvasHtml +='<button id="tools_undo" style="width:40px;height:40px;" title="撤销"></button>';
		canvasHtml +='</span>';
		canvasHtml +='<span>';
		canvasHtml +='<button id="tools_redo" style="width:40px;height:40px;" title="恢复"></button>';
		canvasHtml +='</span>';
		canvasHtml +='</div>';
		canvasHtml +='<div class="container-main">';
		canvasHtml +='<div style="background:white;position:relative;width:'+(dialogWidth-75)+'px;height:'+(dialogHeigh-96)+'px;" id="container">';
		canvasHtml +='<div id="temp" style="border:1px solid gray;width:1px;height:1px;position:absolute;display:none;"></div>';
		canvasHtml +='<canvas id="myCanvas" width="'+(dialogWidth-75)+'" height="'+(dialogHeigh-96)+'" class="container_pencil">';
		canvasHtml +='</canvas>';
		canvasHtml +='</div>';
		canvasHtml +='</div>';  
		canvasHtml +='<div style="clear:both;"></div>';
		canvasHtml +='</div>';
		canvasHtml +='</div>';
		canvasHtml +='</div>';
		$("#"+divId).html(canvasHtml);

		//画笔
		if(options.drawPencil !=1) {
			document.getElementById("pencilSpan").style.display="none";
		}
		//画笔粗细
		if(options.penWidth !=1) {
			document.getElementById("penWidthSpan").style.display="none";
		}
		//矩形
		if(options.rectangle !=1) {
			document.getElementById("rectangleSpan").style.display="none";
		}
		//文字
		if(options.text !=1) {
			document.getElementById("circleSpan").style.display="none";
		}
		//字体大小
		if(options.fontSize !=1) {
			document.getElementById("fontSizeSpan").style.display="none";
		}
		//字体
		if(options.fontType !=1) {
			document.getElementById("fontTypeSpan").style.display="none";
		}
		//直线
		if(options.line !=1) {
			document.getElementById("lineSpan").style.display="none";
		}
		//边框颜色
		if(options.frameColor !=1) {
			document.getElementById("frameColorSpan").style.display="none";
		}
		//填充色
		if(options.fillColor !=1) {
			document.getElementById("fillColorSpan").style.display="none";
		}

		// simulate line rectangle input dialog when you interact with the UI
		lineTip = $("#container").appendLine({
			width:"1px",
			type : "solid",
			beginX : 0,
			beginY : 0,
			color:"#"+options.frameDefaultColor,
			endX : 1,
			endY : 1
		});
		rectTip = $(" <div style='border:1px solid gray;width:1px;height:1px;position:absolute;display:none;'></div>");
		fontTip = $("<textarea rows='3' cols='20' style='background:transparent;position:absolute;display:none;'></textarea>");
		$("#container").append(rectTip);
		$("#container").append(fontTip);
		canvas = document.getElementById("myCanvas");
		context = canvas.getContext("2d");
		commandCallbacks = $.Callbacks();
		commandCallbacks.add(switchCanvasContext);
		commandCallbacks.add(switchCursorStyle);
		$("#tools_pencil").trigger("click");
		commandCallbacks.fire(command);
		initUI();
		$("#container").mousemove(mouseMoveEventHandler);
		fontTip.blur(drawWords);
		$("#tools_undo").click(undo);
		$("#tools_redo").click(redo);
		$("#italicOption").click(setFont);
		$("#boldOption").click(setFont);
		$("#tools_save").click(saveItAsImage);
		$("#tools_open").click(openImage);

		$("[name='toolsOption']").change(function() {
			var val = $(this).val();
			var type = $(this).attr("id");
			if ("on" == val) {
				switch (type) {
				case "tools_pencil": {
					command = 1;
					break;
				}
				case "tools_eraser": {
					command = 2;
					break;
				}
				case "tools_trash": {
					command = 3;
					break;
				}
				case "tools_line": {
					command = 4;
					break;
				}
				case "tools_rectangle": {
					command = 5;
					break;
				}
				case "tools_circle": {
					command = 6;
					break;
				}
				default: {
					command = 1;
				}
					;
				}
				// initialize canvas context and cursor style
				commandCallbacks.fire(command);
			}
		});

					      
			      
			      
		/**
		* In different function circumstances, the Mouse Move Event
		* should be handled in different behalf.
		*/
		function mouseMoveEventHandler(e) {
			switch (command) {
			case 1: {
				drawPencil(e);
				break;
			}
			case 2: {
				drawPencil(e);
				break;
			}
			case 4: {
				fakeLineInput(e);
				break;
			}
			case 5: {
				fakeRectangleInput(e);
				break;
			}
			case 6: {
				fakeWordsInput(e);
				break;
			}
			}
		}

		/**
		 * When you want to input some words on the canvas, the Input User
		 * Interface should be offered. you can drag a line on the canvas while
		 * mouse button is pressed down
		 */
		function fakeWordsInput(e) {
			var offset = $("#myCanvas").offset();
			endX = e.pageX - offset.left;
			endY = e.pageY - offset.top;
			if (flag) {
				fontTip.show();
				fontTip.css({
					left : x,
					top : y
				});
				fontTip.width(endX - x);
				fontTip.height(endY - y);
			}
		}

					      
		function fakeRectangleInput(e) {
			var offset = $("#myCanvas").offset();
			endX = e.pageX - offset.left;
			endY = e.pageY - offset.top;
			var borderWidth = $("#penWidth").val();
			if (flag) {
				rectTip.css({
					left : x,
					top : y
				});
				rectTip.width(endX - x - borderWidth * 2);
				rectTip.height(endY - y - borderWidth * 2);
				console.log(flag);
			}
		}

		/**
		 * 画线   
		 */
		function fakeLineInput(e) {
			var offset = $("#myCanvas").offset();
			endX = e.pageX - offset.left;
			endY = e.pageY - offset.top;
			if (flag) {
				lineTip.adjustLine({
					beginX : x,
					beginY : y,
					endX : endX,
					endY : endY,
					parent : $("#myCanvas")
				})
			}
		}

		//draw free line
		function drawPencil(e) {

			//if the mouse button is pressed down,draw the mouse moving trace.
			if (flag) {
				var offset = $("#myCanvas").offset();
				var x = e.pageX - offset.left;
				var y = e.pageY - offset.top;
				$("#show").html(x + ", " + y + "  " + e.which);
				context.lineTo(x, y);
				context.stroke();
			} else {
				// set the begin path for brash
				context.beginPath();
				var offset = $("#myCanvas").offset();
				var x = e.pageX - offset.left;
				var y = e.pageY - offset.top;
				context.moveTo(x, y);
			}
		}

		/**
		 * 清空画布
		 */
		function clearCanvas() {
			context.fillStyle = "#FFFFFF";
			var width = $("#myCanvas").attr("width");
			var height = $("#myCanvas").attr("height");
			context.clearRect(0, 0, width, height);
		}
		//鼠标左键按下事件
		canvas.onmousedown = function(e) {
			// set mousedown flag for mousemove event
			flag = true;
			//set the begin path of the brash
			var offset = $("#myCanvas").offset();
			x = e.pageX - offset.left;
			y = e.pageY - offset.top;
			console.log("begin:" + x + " " + y);

			switch (command) {
			case 1: {
				break;
			}
			case 2: {
				break;
			}
			case 4: {
				lineTip.show();
				break;
			}
			case 5: {
				var borderColor = "#" + $("#colorpicker-popup").val();
				var borderWidth = $("#penWidth").val() + "px";
				var sr = borderColor + " " + borderWidth + " solid";
				rectTip.show();
				break;
			}
			case 6: {
				break;
			}
			}
		}

		//鼠标左键抬起事件
		$("#container").mouseup(function(e) {

			flag = false;
			// records operations history for undo or redo
			historyPush();
			switch (command) {
			case 1: {
				break;
			}
			case 2: {
				break;
			}
			case 4: {
				drawline();
				break;
			}
			case 5: {
				drawRectangle();
				break;
			}
			case 6: {
				fontTip.focus();
				break;
			}
			}
		});

		/**
		 * 画直线
		 */
		function drawline() {
			context.beginPath();
			var offset = $("#myCanvas").offset();
			context.moveTo(x, y);
			context.lineTo(endX, endY);
			context.stroke();
			lineTip.hide();
		}

		/**
		 * 画矩形
		 */
		function drawRectangle() {
			var borderWidth = $("#penWidth").val();
			context.strokeRect(x, y, endX - x, endY - y);
			$("#myCanvas").focus();
			rectTip.hide();
		}

		/**
		 * 添加文字
		 */
		function drawWords(e) {
			var words = fontTip.val().trim();
			if (fontTip.css("display") != "none" && words) {
				context.strokeStyle = "#" + $("#colorpicker-popup").val();
				context.fillStyle = "#" + $("#colorpicker-popup2").val();
				var offset = $("#myCanvas").offset();
				var offset2 = fontTip.offset();
				var fontSize = $("#fontSize").val();
				fontSize = fontSize.substring(0, fontSize.length - 2);
				context.fillText(words, offset2.left - offset.left,
						(offset2.top - offset.top + fontSize * 1));

				fontTip.val("");
			}
			fontTip.hide();
		}

		/**
		 * 撤销
		 */
		function undo() {
			if (cStep >= 0) {
				clearCanvas();
				cStep--;
				drawImage(1);
			}
			if (cStep == -1) {
				imgIsLoaded = false;
			}

		}

		/**
		 * 恢复
		 */
		function redo() {
			if (cStep < history.length - 1) {
				clearCanvas();
				cStep++;
				drawImage(1);
			}
			if (cStep >= 0) {
				imgIsLoaded = true;
			}
		}

		// define function
		function initUI() {
			//1.界面UI初始化，对话框
		if(options.dialogModel == 1){
		$("#pic-dialog").dialog({
				autoOpen : false,
				show : {
					effect : "blind",
					duration : 920
				},
				hide : {
					effect : "explode",
					duration : 920
				},
				height : dialogHeigh,
				width : dialogWidth,
				modal:true,
				zIndex: -1,
				beforeclose: function() {
		             alert();
		             true;
		         }
			});
		}

			//2. canvas 被拖动，重新设置画板大小（因为拖动是css效果，而实际画板大小是width 和height属性）				
			$("#myCanvas").resizable({
				stop : function(event, ui) {
					var height = $("#myCanvas").height();
					var width = $("#myCanvas").width();
					$("#myCanvas").attr("width", width);
					$("#myCanvas").attr("height", height);
					//画板大小改变，画笔也会被初始化，这里将画笔复原
					switchCanvasContext();
				},
				grid : [ 20, 10 ]
			});

			//3. 工具条
			$("#tools_pencil").button({
				icons : {
					primary : "ui-icon-pencil"
				}
			});

			$("#tools_eraser").button({
				icons : {
					primary : "ui-icon-bullet"
				}
			});
			$("#tools_trash").button({
				icons : {
					primary : "ui-icon-trash"
				}
			});

			$("#tools_save").button({
				icons : {
					primary : "ui-icon-save"
				}
			});

			$("#tools_open").button({
				icons : {
					primary : "ui-icon-disk"
				}
			});

			$("#tools_undo").button({
				icons : {
					primary : "ui-icon-arrowreturnthick-1-w"
				}
			});

			$("#tools_redo").button({
				icons : {
					primary : "ui-icon-arrowreturnthick-1-e"
				}
			});
			$("#tools_line").button({
				icons : {
					primary : "ui-icon-minusthick"
				}
			});
			$("#tools_rectangle").button({
				icons : {
					primary : "ui-icon-stop"
				}
			});
			$("#tools_circle").button({
				icons : {
					primary : "ui-icon-radio-off"
				}
			});
			$("#boldOption").button();
			$("#italicOption").button();

			//4. 画笔粗细设置	
			$("#penWidth").selectmenu({
				width : 71,
				select : penWidthEventListener
			});

			function penWidthEventListener(event, ui) {

				//1. update brash width
				var lineWidth = ui.item.value;
				context.lineWidth = lineWidth;

				//2. update LineTip Width
				lineTip.css("border-top-width", lineWidth + "px");

				//3.update RectTip width
				rectTip.css("border-width", lineWidth + "px");
				return false;
			}

			$("#fontSize").selectmenu({
				width : 100,
				select : function(event, ui) {
					setFont();
				}
			});

			$("#fontType").selectmenu({
				width : 100,
				select : function(event, ui) {
					setFont();
					return false;
				}
			});

			setFont();
			//5. 颜色选择器
			$("#colorpicker-popup").colorpicker({
				buttonColorize : true,
				alpha : true,
				draggable : true,
				showOn : 'both',
				buttonImage:'../'+options.contextPath+'/static/component/picture-edit/colorpicker-master/images/ui-colorpicker.png',
				close : borderColorEventListener
			});

			function borderColorEventListener(e) {
				// 1. set brash context
				var color = "#" + $(this).val();
				context.strokeStyle = color;

				// 2. set tips info
				lineTip.css({
					"border-color" : color
				});
				rectTip.css({
					"border-color" : color
				});
				//fontTip.css({"border-color":color});
			}

			//5. Fill Color Picker
			$("#colorpicker-popup2").colorpicker({
				buttonColorize : true,
				alpha : true,
				draggable : true,
				showOn : 'both',
				buttonImage:'../'+options.contextPath+'/static/component/picture-edit/colorpicker-master/images/ui-colorpicker.png',
				close : fillColorEventListener
			});

			function fillColorEventListener(e) {
				var color = "#" + $(this).val();
				context.fillStyle = color;
				fontTip.css({
					"color" : color
				});
			}
			//初始化矩形颜色
			rectTip.css({
				"border-color" : "#" + $("#colorpicker-popup").val()
			});
			
		}

		// 设置字体
		function setFont() {
			var size = $("#fontSize").val();
			var type = $("#fontType").val();
			var color = "#" + $("#colorpicker-popup2").val();

			var fontWeight = $("#boldOption").get(0).checked;
			fontWeight = fontWeight ? "bold" : " ";

			var fontItalic = $("#italicOption").get(0).checked;
			fontItalic = fontItalic ? " italic " : " ";
			context.font = fontItalic + fontWeight + " " + size + " " + type;
			fontTip.css({
				"font-size" : size,
				"font-family" : type,
				color : color,
				"font-style" : fontItalic,
				"font-weight" : fontWeight
			});
		}

		document.getElementById("imageFile").onchange = function(e) {
			changeImageFile(e);
		}

		/**
		 * save canvas content as image
		 */
		function saveItAsImage() {
			if (typeof savePic === 'function') {//自定义保存方法
				savePic();
			} else {
				var dataUrl = $("#myCanvas").get(0).toDataURL("image/png")
						.replace("image/png", "image/octet-stream");
				window.location.href = dataUrl;
			}
		}

		function openImage() {
			$("#imageFile").click();
		}

		function changeImageFile(e) {
			var userImgFile = document.getElementById("imageFile").files[0];
			if (userImgFile) {
				if (!/image\/\w+/.test(userImgFile.type)) {
					parent.showDialogModal("error-div", "操作提示", "文件必须为图片！");
					return false;
				}
				//清空历史纪录
				history.length = 0;
				cStep = -1;
				imgScale = 1;
				var reader = new FileReader();
				reader.readAsDataURL(userImgFile);
				reader.onloadend = function() {
					context.clearRect(0, 0, canvas.width, canvas.height);
					var image = new Image();
					image.crossOrigin = "Anonymous";
					image.onload = function() {
						canvas.height = image.height;
						canvas.width = image.width;
						canvas.style.width = image.width + "px";
						canvas.style.height = image.height + "px";
						context.drawImage(image, 0, 0, image.width,
								image.height);
						imgIsLoaded = true;
					}
					image.src = reader.result;
				};

			}
		}

		/**
		 * 保存当前画布
		 */
		function historyPush() {
			cStep++;
			if (cStep < history.length) {
				history.length = cStep;
			}
			history.push(canvas.toDataURL());
		}

		/**
		 * switch the canvas context for different command
		 */
		function switchCanvasContext(command) {
			context.lineWidth = $("#penWidth").val();
			context.strokeStyle = "#" + $("#colorpicker-popup").val();
			context.lineCap = "round";
			context.fillStyle = "#" + $("#colorpicker-popup2").val();

			if (command) {
				switch (command) {
				case 1: {
					break;
				}
				case 2: {
					context.strokeStyle = "#FFFFFF";
					break;
				}
				case 3: {
					clearCanvas();
					$("#tools_pencil").trigger("click");
					$("#tools_pencil").focus();
				}
				}
			}
			return context;
		}

		/**
		 *  switch cursor style for different command
		 */
		function switchCursorStyle(command) {
			switch (command) {
			case 1: {
				$("#myCanvas").removeClass("container_eraser");
				$("#myCanvas").removeClass("container_font");
				$("#myCanvas").addClass("container_pencil");
				break;
			}
			case 2: {
				$("#myCanvas").removeClass("container_pencil");
				$("#myCanvas").removeClass("container_font");
				$("#myCanvas").addClass("container_eraser");
				break;
			}
			case 6: {
				$("#myCanvas").removeClass("container_eraser");
				$("#myCanvas").removeClass("container_pencil");
				$("#myCanvas").addClass("container_font");
				break;
			}
			default: {
				$("#myCanvas").removeClass("container_eraser");
				$("#myCanvas").removeClass("container_font");
				$("#myCanvas").addClass("container_pencil");
				break;
			}
			}

		}

		function drawImage(scale) {
			img.onload = function() {
				canvas.height = img.height * scale;
				canvas.width = img.width * scale;
				canvas.style.width = img.width * scale + "px";
				canvas.style.height = img.height * scale + "px";
				context.clearRect(0, 0, canvas.width, canvas.height);
				context.drawImage(img, 0, 0, img.width, img.height, 0, 0,
						img.width * scale, img.height * scale);
				context.strokeStyle = "#" + $("#colorpicker-popup").val();
				context.fillStyle = "#" + $("#colorpicker-popup2").val();
			}
			img.src = history[cStep];
		}

		canvas.onmousewheel = canvas.onwheel = function(event) {
			//不允许缩放
			if(options.scale !=1) {
				return;
			}
			if (!imgIsLoaded) {
				return;
			}
			event.preventDefault();
			var pos = windowToCanvas(canvas, event.clientX, event.clientY);
			event.wheelDelta = event.wheelDelta ? event.wheelDelta
					: (event.deltaY * (-40));
			if (event.wheelDelta > 0) {
				if (imgScale > 4) {//最大放大到4倍
					return;
				}
				imgScale *= 1.25;
				imgX = imgX * 1.25 - pos.x;
				imgY = imgY * 1.25 - pos.y;
			} else {
				if (imgScale < 0.1) {//最小缩小到原来的二分之一
					return;
				}
				imgScale /= 1.25;
				imgX = imgX / 1.25 + pos.x / 1.25;
				imgY = imgY / 1.25 + pos.y / 1.25;
			}
			drawImage(imgScale);
		}

		function windowToCanvas(canvas, x, y) {
			var bbox = canvas.getBoundingClientRect();
			return {
				x : x - bbox.left - (bbox.width - canvas.width) / 2,
				y : y - bbox.top - (bbox.height - canvas.height) / 2
			};
		}
		return this.each(function() {
			
		});
	}
})(jQuery);