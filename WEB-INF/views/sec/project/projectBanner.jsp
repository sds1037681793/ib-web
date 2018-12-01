<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <style>
        .image-select {
            font-size: 14px;
            font-weight: 500;
            padding-left: 3px;
        }

        .image-inner-div {
            width: 18px;
            height: 18px;
            left: 78px;
            position: relative;
            z-index: 1;
            margin: -2px -14px;
            padding: 0;
            background-color: rgb(255, 255, 255);
            filter: alpha(opacity=20); /*ie透明度20%*/
            -moz-opacity: 0.8; /*Moz + FF 透明度20%*/
            opacity: 1.0; /*支持CSS3的浏览器(FF1.5也支持)透明度20%*/
            border: solid rgb(100, 100, 100) 1px;
            border-radius: 50px;
        }

        .image-inner-div:hover {
            cursor: pointer;
            background: #0661AD;
            opacity: 0.8;
        }

        .image-outer-div {
            position: relative;
            width: 10px;
            height: 10px;
            float: left;
            padding: 1px;
            left: 10px;
        }
    </style>
</head>
<body>
<div style="width: 668px;height: 240px;">
    <input id="file" type="file" name="file" style="display: none;" onchange="ProjectBannerUtils.uploadFile(this)"
           accept="image/gif, image/jpeg,image/tiff,image/x-ms-bmp,image/x-photo-cd,image/x-png,.dwg"/>
    <div style="float:left;width:668px;margin-left:18px;margin-top:13px;padding-left: 3px;">
        <div id="addImage"
             style="border:1px dashed #BBBBBB;;width:100px;cursor: pointer; float: left;margin-left: 10px;margin-top: 10px;">
            <img src="${ctx}/static/images/cover_add.png" width="100%" height="100%" title="点击上传"
                 id="upload_image_cover"/>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="${ctx}/static/js/ajaxfileupload.js"></script>
<script>
    var ProjectBannerData = {
        projectCode: null,
        projectId: null,
        bannerNum: 0
    };
    var ProjectBannerUtils = {

        init: function () {
            ProjectBannerData.projectCode = tbOrgs.row("${param.rowIndex}").organizeCode;
            ProjectBannerData.projectId = tbOrgs.row("${param.rowIndex}").id;

            ProjectBannerUtils.initBannerImg();

            $("#addImage").on("click", function () {
                $("#file").click();
            });
        },

        uploadFile: function (obj) {
            if (ProjectBannerData.bannerNum == 7) {
                showDialogModal("error-div", "操作提示", "图片最多上传7张！");
                return;
            }
            if ($(obj).val().length == 0) {
                showDialogModal("error-div", "操作提示", "请选择文件！");
                return;
            }
            var checkFile = ProjectBannerUtils.getPhotoSize(obj);

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
                url: '${ctx}/system/projectBanner/uploadPictureFile',
                type: 'post',
                data: {
                    projectId: ProjectBannerData.projectId,
                    projectCode: ProjectBannerData.projectCode
                },
                secureuri: false, //一般设置为false
                fileElementId: fileName, // 上传文件的id、name属性名
                dataType: 'application/json', //返回值类型，一般设置为json、application/json
                success: function (data) {
                    ProjectBannerData.bannerNum++;
                    if (data == "null") {
                        showDialogModal("error-div", "操作提示", "图片格式不符合要求！");
                        return;
                    }
                    var value = JSON.parse(data);
                    if (value != null) {
                        showDialogModal("error-div", "操作提示", "上传成功");
                        ProjectBannerUtils.appendImage(value.path, value.bannerId);
                        return;
                    } else {
                        showDialogModal("error-div", "操作提示", "上传图片失败");
                        return;
                    }
                },
                error: function (req, error, errObj) {
                    showDialogModal("error-div", "操作错误", "上传图片失败");
                    return;
                }
            });
        },

        initBannerImg: function () {
            $.ajax({
                type: "post",
                url: "${ctx}/system/projectBanner/getBannerList/" + ProjectBannerData.projectCode,
                dataType: 'json',
                success: function (data) {
                    for (var i in data) {
                        ProjectBannerData.bannerNum++;
                        ProjectBannerUtils.appendImage(data[i].url, data[i].id);
                    }
                },
                error: function (req, error, errObj) {
                    showDialogModal("error-div", "操作提示", " 操作失败");
                    return false;
                }

            });
        },

        confirmDelBanner: function (bannerId) {
            var elementId = "show" + bannerId;
            showDialogModal("error-div", "操作提示", "确认是否删除？", 2, "ProjectBannerUtils.deleteBanner(" + bannerId + ")");
        },

        deleteBanner: function (bannerId) {
            ProjectBannerData.bannerNum--;
            $.ajax({
                type: "post",
                url: "${ctx}/system/projectBanner/delBanner/" + bannerId,
                dataType: 'json',
                success: function (data) {
                    if (data && data.CODE && data.CODE == "SUCCESS") {
                        showDialogModal("error-div", "操作提示", "删除成功");
                        $("#show" + bannerId).remove();
                        return true;
                    } else {
                        showDialogModal("error-div", "操作提示", " 操作失败");
                        return false;
                    }
                },
                error: function (req, error, errObj) {
                    showDialogModal("error-div", "操作提示", " 操作失败");
                    return false;
                }

            });
        },

        appendImage: function (path, bannerId) {
            var html = '<div class="smallImg" id="show' + bannerId + '" style="float:left;margin-right: 10px;margin-top: 10px;">';
            html += '<div class="image-outer-div">';
            html += '<div class="image-inner-div" style="left: 98px;" onclick="ProjectBannerUtils.confirmDelBanner(' + bannerId + ')"><span class="image-select">X</span></div></div>';
            html += '<img id="image_show" src="' + path + '" style="cursor: pointer" width="100" height="100"/></div>';

            $("#addImage").before(html);
        },

        //判断图片大小
        getPhotoSize: function (obj) {
            var photoExt = obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
            if (photoExt != '.jpg' && photoExt != '.png') {
                return "1";
            }
            var fileSize = 0;
            var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
            if (isIE && !obj.files) {
                var filePath = obj.value;
                var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
                var file = fileSystem.GetFile(filePath);
                fileSize = file.Size;
            } else {
                fileSize = obj.files[0].size;
            }
            fileSize = Math.round(fileSize / 1024 * 100) / 100; //结算完后这里的单位为KB
            if (fileSize >= (10 * 1024)) {//如果大于10MB则不允许上传
                return "2";
            }
        }
    };

    $(document).ready(function () {
        ProjectBannerUtils.init();
    });
</script>
</html>
