<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style type="text/css">


</style>
<link rel="stylesheet" href="${ctx}/static/component/picture-edit/jquery-ui-1.11.0.custom/jquery-ui.css" />
<link rel="stylesheet" href="${ctx}/static/component/picture-edit/jquery-ui-1.11.0.custom/jquery-ui.structure.css" />
<link rel="stylesheet" href="${ctx}/static/component/picture-edit/colorpicker-master/jquery.colorpicker.css" />
<link rel="stylesheet" href="${ctx}/static/component/picture-edit/css/canvas-pic.css" />
<script type="text/javascript" src="${ctx}/static/component/picture-edit/jquery-ui-1.11.0.custom/jquery-ui.js"></script>
<script type="text/javascript" src="${ctx}/static/component/picture-edit/js/anyLine.js"></script>
<script type="text/javascript" src="${ctx}/static/component/picture-edit/colorpicker-master/jquery.colorpicker.js"></script>
<script type="text/javascript" src="${ctx}/static/component/picture-edit/colorpicker-master/parts/jquery.ui.colorpicker-rgbslider.js"></script>
<script type="text/javascript" src="${ctx}/static/component/picture-edit/js/canvas.js"></script>
<div id="pic-dialog" title="图片编辑工具" class="canvas_dialog">	
	<div style="font-size:12px;">
		<div class="container-top">
			<span style="display: block; float: left;">
				<span style="text-align: center; line-height: 30px; float: left; display: block;">线条粗细: </span>
		             <select id="penWidth">
		                 <option value="1" selected>1px</option>
		                 <option value="2">2px</option>
		                 <option value="4">4px</option>
		                 <option value="6">6px</option>
		                 <option value="8">8px</option>
		                 <option value="12">12px</option>
		                 <option value="14">14px</option>
		                 <option value="16">16px</option>
		                 <option value="18">18px</option>
		         </select>
			</span>
			<span style="display: block; float: left;margin-left: 10px;">
				<span style="text-align: center; line-height: 30px; float: left; display: block;">字体大小:</span> 
					<select id="fontSize">
							<option value="8px" selected>8px</option>
							<option value="10px">10px</option>
							<option value="12px">12px</option>
							<option value="14px">14px</option>
							<option value="16px">16px</option>
							<option value="18px">18px</option>
							<option value="20px">20px</option>
							<option value="22px">22px</option>
							<option value="24px">24px</option>
							<option value="26px">26px</option>
							<option value="28px">28px</option>
							<option value="30px">30px</option>
							<option value="32px">32px</option>
							<option value="34px">34px</option>
							<option value="36px">36px</option>
					</select> 
			</span>
			<span style="display: block; float: left;margin-left: 10px;">
				<span style="text-align: center; line-height: 30px; float: left; display: block;">字体选择:</span>	        		
		        	<select id="fontType">
						<option value="宋体" >宋体</option>
						<option value="微软雅黑">微软雅黑</option>
						<option value="仿宋">仿宋</option>
						<option value="Arial" selected>Arial</option>
						<option value="Consolas">Consolas</option>
		             </select>
			</span>
			<span style="display: block; float: left;margin-left: 10px;">
				<span style="text-align: center; line-height: 30px; float: left; display: block;">边框色:</span>
				<input id="colorpicker-popup" type="text"  value="000000" style="width: 72px;display:none; ">
			</span>
			<span style="display: block; float: left;margin-left: 10px;">
				<span style="text-align: center; line-height: 30px; float: left; display: block;">填充色:</span>
				<input id="colorpicker-popup2" type="text" value="f50808" style="width: 72px;display:none; ">
			</span>
		    <span style="font-weight:bold;display:none;"><input type="checkbox" id="boldOption" name="fontOption"><label for="boldOption">B</label></span>
		    <span style="font-style: italic;display:none;"><input type="checkbox" id="italicOption" name="italicOption"><label for="italicOption">I</label></span>
		</div>
		<div style="border:#cccccc solid  1px;height:456px;">
			<div class="container-left">
				<span>
					<input type="radio" id="tools_pencil" name="toolsOption" checked="checked"><label for="tools_pencil" title="画笔"></label>
				</span>
				<span style="display:none;">
					<input type="radio" id="tools_eraser" name="toolsOption" ><label for="tools_eraser" title="橡皮擦"></label>
				</span>
				<span>
					<input type="radio" id="tools_trash" name="toolsOption"><label for="tools_trash" title="清空"></label>
				</span>
				<span>
					<input type="radio" id="tools_line" name="toolsOption"><label for="tools_line" title="直线"></label>
				</span>
				<span>
					<input type="radio" id="tools_rectangle" name="toolsOption"><label for="tools_rectangle" title="矩形"></label>
				</span>
				<span>
					<input type="radio" id="tools_circle" name="toolsOption"><label for="tools_circle" title="文字"></label>
				</span>
				<span>
					<input type="file" style="display:none" id="imageFile" >
					<button id="tools_open" style="width:40px;height:40px;" title="打开"></button>
				</span>
				<span>
					<button id="tools_save" style="width:40px;height:40px;" title="保存"></button>
				</span>
				<span>
					<button id="tools_undo" style="width:40px;height:40px;" title="撤销"></button>
				</span>
				<span>
					<button id="tools_redo" style="width:40px;height:40px;" title="恢复"></button>
				</span>
			</div>
			<div class="container-main">
				<div style="background:white;position:relative;width:815px;height:454px;" id="container">
				     <div id="temp" style="border:1px solid gray;width:1px;height:1px;position:absolute;display:none;"></div>
					<canvas id="myCanvas" width="815" height="454" class="container_pencil">
					  
					</canvas>
				</div>
			</div>   
		     <div style="clear:both;"></div>
	    </div>
	</div>
</div>
<script>
var canvasPic;
$(document).ready(function() {
	canvasPic = $("#pic-dialog").canvasPic();
});

function savePic(){
	var Pic = document.getElementById("myCanvas").toDataURL("image/png");
	Pic = Pic.replace(/^data:image\/(png|jpg);base64,/, "")
	$.ajax({
		type: "post",
		url: "${ctx}/test/uploadPicture2",
		contentType: "application/json; charset=utf-8",
		data: '{ "imageData" : "' + Pic + '" }',
		dataType: "json",
		success:function(data) {
			if(data.isSucceed){
				showDialogModal("error-div", "保存成功", "保存成功");
			}
		},
		error: function(req,error,errObj) {
			showAlert('warning','提交失败：'+errObj,"save",'top');
			$("#rechargeAmount").val("");
			return false;		
		}
	});
	console.log(image);
}

</script>

	

