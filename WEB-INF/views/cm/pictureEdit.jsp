<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="${ctx}/static/js/ajaxfileupload.js"></script>
<style>
#div-puv .mmg-head {
	background-color: #fff;
	color: #000;
	border-bottom: 1px solid #ccc;
}
</style>
<form id="rule-form">
	<table style="margin-bottom: 15px;">
		<tr height="10px">
			<td><input id="id" name="id" style="display: none;" /></td>
		</tr>
		<tr>
			<td><input type="file" id="btn-upload-input" name="file" accept="picture/*" onchange="uploadFile(this);" style="display: none;" />
				<button id="btn-upload-picture" type="button" class="btn btn-default btn-common btn-common-green" style="margin-left: 10px;">上传图片 </button></td>
			<td align="right" width="120">自定义图片名称：</td>
			<td><input id="defineFileName" name="defineFileName" placeholder="自定义图片名称" class="form-control required" type="text" style="width: 150px; margin-left: 20px;" /></td>
		</tr>
	</table>
</form>

<script type="text/javascript">
var organizeId = projectId;
var uploadResult;
var pictureId;
var path = "";
var pictureName = "";
var uploadFlag = false;
	$(document).ready(function() {
   		if('' != "${param.pictureId}"){
   			$('#btn-upload-picture').hide();
			pictureId = "${param.pictureId}";
			$.ajax({
				type : "post",
				url : "${ctx}/device/pictureBusiness/find?pictureId=" + pictureId,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data) {
						$("#id").val(pictureId);
						if (data.fileName != '') {
							$("#defineFileName").val(data.fileName);
						}
						if (data.filePath != '') {
							$("#filePath").val(data.filePath);
						}
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		} else {
			pictureId = null;
		}
	});
	
	$("#btn-upload-picture").on("click",function() {
  		$("#btn-upload-input").click();
  	});
	
	function uploadFile(obj) {
  		if ($(obj).val().length == 0) {
			showDialogModal("error-div", "操作提示", "请选择文件！");
			return;
		}
  		var checkFile = getPhotoSize(obj);
  		
  		if (checkFile == "1") {
  			showDialogModal("error-div", "操作提示", "图片格式不符合要求！");
  			return;
  		}
  		if (checkFile == "2") {
  			showDialogModal("error-div", "操作提示", "照片最大尺寸为10Mb，请重新上传!");
  			return;
  		}
  		var fileName = $(obj).attr("id");
  		$.ajaxFileUpload({
			url : '${ctx}/picture/uploadPictureFile',
			type : 'post',
			secureuri : false, //一般设置为false
			fileElementId : fileName, // 上传文件的id、name属性名
			dataType : 'application/json', //返回值类型，一般设置为json、application/json
			//contentType: "application/json;charset=utf-8",
			success : function(data) {
				if(data=="null") {
					showDialogModal("error-div", "操作提示", "图片格式不符合要求！");
					return;
				}
				var value = JSON.parse(data);
				if(value != null){
					showDialogModal("error-div", "操作提示", "上传成功");
					uploadResult = value;
					uploadFlag = true;
					return;
				}else{
					showDialogModal("error-div", "操作提示", "上传图片失败");
					return;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", "上传图片失败");
				return;
			}
		});
	}
	
	//判断图片大小
	function getPhotoSize(obj){
		photoExt=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		if(photoExt!='.jpg' && photoExt!='.png'){
			return "1";
		}
		var fileSize = 0;
		var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
		if (isIE && !obj.files) {
			var filePath = obj.value;
			var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
			var file = fileSystem.GetFile (filePath);
			fileSize = file.Size;
		}else {
			fileSize = obj.files[0].size;
		}
		fileSize=Math.round(fileSize/1024*100)/100; //结算完后这里的单位为KB
		if(fileSize >= (10*1024)){//如果大于10MB则不允许上传
			return "2";
		}
	} 


	function savePicture() {
		if (pictureId == null && !uploadFlag) {
			showAlert('warning', "请上传图片", "rest-config-edit-button-confirm", 'top');
			return;
		}
		var defineFileName = $('#defineFileName').val();
		if (defineFileName == '') {
			showAlert("warning", "请填写图片名称", "defineFileName", "top");
			return;
		}
		if (uploadResult != '' && uploadResult != undefined) {
			path = uploadResult.path;
			pictureName = uploadResult.pictureName;
		}
		var datas = {
			id : pictureId,
			organizeId : organizeId,
			fileName : defineFileName,
			path : path,
			pictureName : pictureName
		};

		$.ajax({
			type : "post",
			url : "${ctx}/device/pictureBusiness/create",
			dataType : "json",
			data : JSON.stringify(datas),
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					picGrid.load();
					$("#rest-config-edit-modal").modal("hide");
					showDialogModal("error-div", "操作成功", "操作成功");
					return true;
				} else {
					showAlert('warning', data.MESSAGE,
							"rest-config-edit-button-confirm", 'top');
					return false;
				}
			},
			error : function(req, error, errObj) {
				showDialogModal("error-div", "操作错误", errObj);
				return;
			}
		});
	}
</script>