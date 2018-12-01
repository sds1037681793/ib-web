<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style="width: 600px;margin-left: 20px;margin-top: 10px;">
    <div style="float: left;margin-top: 5px;height: 260px">
        <div style="margin-top: 20px">新闻标题：</div>
        <div style="margin-top: 160px">新闻内容：</div>
    </div>
    <div style="float: left;margin-top: 5px;">
        <textarea id="newsTitle" name="newsTitle" class="form-control required"
                  type="text" style="width: 480px;height: 100px;resize:none;background-color: #FFC;line-height: 1.3;"
                  required="required"></textarea>
        <textarea id="newsContent" name="newsContent" class="form-control required"
                  type="text" style="width: 480px;height: 230px;resize:none;background-color: #FFC;line-height: 1.3;margin-top: 20px;"
                  required="required"></textarea>
    </div>
</div>
</body>
<script>
    var ProjectNewsData = {
        id: null,
        newsTitle: null,
        newsContent: null
    }
    var ProjectNewsUtil = {
        init: function () {
            $.ajax({
                type: "post",
                url: "${ctx}/system/secProjectNews/getProjectNews/" + ProjectNewsData.id,
                success: function (data) {
                    if (data) {
                        data = JSON.parse(data);
                        $("#newsTitle").val(data.newsTitle);
                        $("#newsContent").val(data.newsContent);
                    }
                },
                error: function (req, error, errObj) {
                    showDialogModal("error-div", "操作错误", errObj);
                    return;
                }
            })
        },

        saveProjectNews: function () {
            var newsTitle = $("#newsTitle").val().trim();
            var newsContent = $("#newsContent").val().trim();
            if (!newsTitle) {
                showDialogModal("error-div", "操作提示", " 请填写新闻标题");
                return false;
            }
            if (!newsContent) {
                showDialogModal("error-div", "操作提示", " 请填写新闻内容");
                return false;
            }
            $.ajax({
                type: "post",
                url: "${ctx}/system/secProjectNews/saveNews",
                data: {
                    projectId: ProjectNewsListData.projectId,
                    projectCode: ProjectNewsListData.projectCode,
                    newsTitle: newsTitle,
                    newsContent: newsContent,
                    newsId: ProjectNewsData.id
                },
                dataType: 'json',
                success: function (data) {
                    if (data && data.CODE && data.CODE == "SUCCESS") {
                        $("#edit-data-modal").modal('hide');//内容操作框
                        showDialogModal("error-div", "操作提示", "保存成功");
                        pjNewsData.load();
//                        $("#ext-operation-div-modal").modal('hide');//列表框
                        return true;
                    } else {
                        $("#edit-data-modal").modal('hide');
                        showDialogModal("error-div", "操作失败", data.MESSAGE);
                        return false;
                    }
                },
                error: function (req, error, errObj) {
                    showDialogModal("error-div", "操作错误", errObj);
                    return false;
                }

            });
        }
    };
    $(document).ready(function () {
        if ('${param.rowIndex}' != -1) {
            var row = pjNewsData.row('${param.rowIndex}');
            ProjectNewsData.id = row.id;
            ProjectNewsData.newsTitle = row.newsTitle;
            ProjectNewsData.newsContent = row.newsContent;

            $("#newsTitle").val(ProjectNewsData.newsTitle);
            $("#newsContent").val(ProjectNewsData.newsContent);
        }
        ProjectNewsUtil.init();
    });
</script>
</html>
