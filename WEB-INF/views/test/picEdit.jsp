<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${ctx}/static/component/picture-edit/css/canvas-pic.css" />
<link rel="stylesheet" href="${ctx}/static/component/picture-edit/jquery-ui-1.11.0.custom/jquery-ui.css" />
<link rel="stylesheet" href="${ctx}/static/component/picture-edit/colorpicker-master/jquery.colorpicker.css" />
<script type="text/javascript" src="${ctx}/static/component/picture-edit/jquery-ui-1.11.0.custom/jquery-ui.js"></script>
<script type="text/javascript" src="${ctx}/static/component/picture-edit/js/anyLine.js"></script>
<script type="text/javascript" src="${ctx}/static/component/picture-edit/colorpicker-master/jquery.colorpicker.js"></script>
<script type="text/javascript" src="${ctx}/static/component/picture-edit/colorpicker-master/parts/jquery.ui.colorpicker-rgbslider.js"></script>
<script type="text/javascript" src="${ctx}/static/component/picture-edit/js/canvasPicDialog.js"></script>
<div style="width:100%;height:100%;margin:0 auto;" id="mypicture">
	<form id="select-form">
		<table>
			<tr>
				<td align="right" width="90">账户名称：</td>
					<td>
						<input id="sourceName" name="sourceName" placeholder="账户名称" class="form-control required" type="text" style="width:150px"/>
					</td>
						<td align="right" width="90">车牌号：</td>
						<td>
							<input id="licensePlate" name="licensePlate" placeholder="车牌号" class="form-control required" type="text" style="width:150px"/>
						</td>
						<td>
							<button id="btn-query" type="button" class="btn btn-default btn-common btn-common-green" style="margin-left: 20px;">查询</button>
							<button id="btn-add" type="button" class="btn btn-default btn-common btn-common-green" data-toggle="modal" style="display: none; data-target="#modal-add">新增</button>
						</td>
					</tr>
				</table>
</form>
</div>
<div id="modal-add" class="modal fade">
		<div class="modal-dialog" style="width:990px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="modal-add-label">储值账户充值</h4>
				</div>
				<div class="modal-body" >
				</div>
				<div class="modal-footer">
					<a id="save" href="#" class="btn btn-modal">充值</a>
					<a href="#" class="btn btn-modal" data-dismiss="modal">关闭</a>
				</div>
			</div>
		</div>
	</div>
<div id="pic-edit" ></div>
<script>
	$(document).ready(function() {
		var canvasDefine ={
				scale:0,//是否允许缩放
				drawPencil:1,//画笔
				penWidth:1,//画笔粗细
				rectangle:1,//矩形
				text:1,//文字
				fontSize:1,//字体大小
				fontType:1,//字体
				line:1,//直线
				frameColor:1,//边框颜色
				fillColor:1,//填充色
				frameDefaultColor: '4FC2B9',//边框默认颜色
				fillDefaultColor:'f50808',//填充色默认颜色
				contextPath:'${ctx}'
		};
		canvasPicDialog = $("#pic-edit").canvasPicDialog("pic-edit",990,650,canvasDefine);
		$('#save').on('click', function() {
			canvasPicDialog.openDialog();
		});
		$('#btn-query').on('click', function() {
			$("#modal-add").modal('show');
		});
	});

	function savePic() {
		var Pic = document.getElementById("myCanvas").toDataURL("image/png");
		Pic = Pic.replace(/^data:image\/(png|jpg);base64,/, "")
		$.ajax({
			type : "post",
			url : "${ctx}/test/uploadPicture2",
			contentType : "application/json; charset=utf-8",
			data : '{ "imageData" : "' + Pic + '" }',
			dataType : "json",
			success : function(data) {
				if (data.isSucceed) {
					showDialogModal("error-div", "保存成功", "保存成功");
					canvasPicDialog.closeDialog();
				}
			},
			error : function(req, error, errObj) {
				showAlert('warning', '提交失败：' + errObj, "save", 'top');
				$("#rechargeAmount").val("");
				return false;
			}
		});
	}
</script>
