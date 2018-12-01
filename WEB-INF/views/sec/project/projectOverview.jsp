<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style="width: 600px;margin-left: 30px;">
    <div style="float: left;margin-top: 111px;">
        项目概况：
    </div>
    <div style="float: left">
        <textarea id="overview" name="ovewview" class="form-control required"
                  type="text" style="width: 500px;height: 240px;resize:none;background-color: #FFC;line-height: 1.3;"
                  required="required"></textarea>
    </div>
</div>
</body>
<script>
    var ProjectOverviewData = {
        overviewId: null,
        projectCode: null,
        projectId: null
    };
    var ProjectOverviewUtil = {
        init: function () {
            ProjectOverviewData.projectCode = tbOrgs.row("${param.rowIndex}").organizeCode;
            ProjectOverviewData.projectId = tbOrgs.row("${param.rowIndex}").id;
            $.ajax({
                type: "post",
                url: "${ctx}/system/secProjectOverview/getProjectOverview/" + ProjectOverviewData.projectCode,
                success: function (data) {
                    if (data) {
                        data = JSON.parse(data);
                        $("#overview").val(data.overview);
                    }
                },
                error: function (req, error, errObj) {
                    showDialogModal("error-div", "操作错误", errObj);
                    return;
                }
            })
        },

        saveProjectOverview: function () {
            var overview = $("#overview").val().trim();
            if (!overview) {
                showDialogModal("error-div", "操作提示", " 请填写项目概况");
                return false;
            }
            $.ajax({
                type: "post",
                url: "${ctx}/system/secProjectOverview/saveOverview",
                data: {
                    projectId: ProjectOverviewData.projectId,
                    projectCode: ProjectOverviewData.projectCode,
                    overview: overview
                },
                dataType: 'json',
                success: function (data) {
                    if (data && data.CODE && data.CODE == "SUCCESS") {
                        $("#ext-operation-div-modal").modal('hide');
                        tbOrgs.load();
                        showDialogModal("error-div", "操作提示", "保存成功");
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
        }
    };
    $(document).ready(function () {
        ProjectOverviewUtil.init();
    });
</script>
</html>
