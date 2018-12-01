<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<html>

<head>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/css/fontColor.css" rel="stylesheet" type="text/css" />
    <title>视频列表</title>
</head>
<body>
<div style="width:1640px;">
<div style="margin-top: 10px;margin-left: 10px;margin-right: 10px;" class="content-default">
    <form id=query>
        <table id="area-form-table">
            <tr>
                <td align="right" width="100">设备名称：</td>
                <td><input id="query-deviceName" name="query-deviceName" placeholder="名称" class="form-control required"
                           type="text" style="width: 150px;"/></td>
                <td align="right" width="100">选择品牌：</td>
                <td>
                    <div id="cameraBrand-dropdownlist"></div>
                </td>
              <td align="right" width="150">选择状态：</td>
                <td>
                    <div id="status-dropdownlist"></div>
                </td>
                <td>
                    <button id="btn-query-device" type="button" class="btn btn-default btn-common btnicons"
                            style="margin-left: 50px;"><p class="btniconimg"><span>查询</span></p>
                    </button>
                </td>
            </tr>
        </table>
    </form>
</div>
<div style="margin-top: 20px;margin-left: 10px;margin-right: 10px;">

    <table id="tb_videos" class="tb_videos" style="border: 1px solid; height:200px;width:99%;margin:0 auto;">
        <tr>
            <th rowspan="" colspan=""></th>
        </tr>
    </table>
    <div id="video-pg" style="text-align: right;"></div>
</div>
<div id="show-video"></div>
<div id="show-picture"></div>
<div id="show-video-dss"></div>
<div id="error-div"></div>
</div>
<script type="text/javascript">
	var orgId = "${param.projectId}";
	if (orgId == "") {
	    orgId = $("#login-org").data("orgId");
	}
    var videoListManageData = {
        dropDownListCameraBrand: new HashMap(),
        cameraBrandList: new Array(),
        dropDownListStatus: new HashMap(),
        statusList: new Array(),
        row: null,
        deviceId: null,
        deviceNumber: null,
        tbDevices: null,
        pg: null,
        NVRType: null,
        loginNVRRest: null,
        ipAdd: null,
        pictureData: new Array
    };
    videoListManageData.statusList[0]= {itemText: "请选择",itemData: ""};
    videoListManageData.statusList[1]= {itemText: "在线",itemData: "1"};
    videoListManageData.statusList[2]= {itemText: "离线",itemData: "0"};
    var videoListManageUtil = {
        init: function () {
            videoListManageUtil.bindEvent();
            videoListManageUtil.loadCameraBrandDropDownList();
            videoListManageUtil.loadStatusDropDownList();
            videoListManageUtil.loadVideoList();
        },
        bindEvent: function () {
            $('#btn-query-device').on('click', function () {
                videoListManageData.pg.load({"page": 1});
                videoListManageData.tbDevices.load();
            });
            $("#show-picture").on('shown.bs.modal', function () {
                loadPic();
            });
        },
        loadVideoList: function () {
            var cols = [
                    {title: '设备Id', name: 'deviceId', width: 200, sortable: false, align: 'left', hidden: true},
                    {title: '设备名称', name: 'deviceName', width: 200, sortable: false, align: 'left'},
                    {title: '归属NVR', name: 'nvrName', width: 200, sortable: false, align: 'left'},
                    {title: '地图名称', name: 'mapName', width: 200, sortable: false, align: 'left'},
                    {title: 'IP地址', name: 'ip', width: 260, sortable: false, align: 'left'},
                    {
                        title: '品牌',
                        name: 'brand',
                        width: 237,
                        sortable: false,
                        align: 'left',
                        renderer: function (val, item, rowIndex) {
                            if (item.brand == '1') {
                                return '海康';
                            } else if (item.brand == '2') {
                                return '大华';
                            }
                        }
                    },
                    {title: '型号', name: 'deviceType', width: 150, sortable: false, align: 'left'},
                   {
                        title: '设备状态',
                        name: 'status',
                        width: 150,
                        sortable: true,
                        align: 'left',
                        renderer: function (val, item, rowIndex) {
                            if (item.status == '1') {
                                return '在线';
                            } else if (item.status == '0') {
                                return '离线';
                            }
                        }
                    }, 
                    {
                        title: '操作', name: 'operate', width: 220, sortable: false, align: 'left',
                        renderer: function (val, item, rowIndex) {
                            var monitoringObj = '<a class="calss-monitoring" href="#" title="实时监控" style="font-size: 12px; padding-right: 10px;">实时监控</a>';
                            var recordObj = '<a class="class-record" href="#" title="抓拍记录" style="font-size: 12px;  padding-right: 10px;">抓拍记录</a>';
                            return monitoringObj + recordObj;
                        }
                    }
                ]
            ;
            videoListManageData.pg = $('#video-pg').mmPaginator({"limitList": [10]});
            videoListManageData.tbDevices = $('#tb_videos').mmGrid({
                height: 570,
                cols: cols,
                url: '${ctx}/device/manage/loadVideoList?CHECK_AUTHENTICATION=false&projectCode='+projectCode,
                method: 'post',
                remoteSort: false,
                sortName: 'id',
                sortStatus: 'desc',
                multiSelect: false,
                nowrap: true,
                checkCol: false,
                fullWidthRows: false,
                autoLoad: false,
                showBackboard: false,
                params: function () {
                    var deviceName = $.trim($("#query-deviceName").val());
                    var brand = $("#brandValue").val();
                    var status = $("#statusValue").val();
                    data = {"deviceName": deviceName, "brand": brand, "status": status};
                    return data;
                },
                plugins: [videoListManageData.pg]
            });

            videoListManageData.tbDevices.on('cellSelect', function (e, item, rowIndex, colIndex) {
                e.stopPropagation();
                if ($(e.target).is('.calss-monitoring')) {
                    videoListManageData.row = videoListManageData.tbDevices.row(rowIndex);
                    videoListManageData.deviceId = videoListManageData.row.deviceId;
                    videoListManageData.deviceNumber = videoListManageData.row.deviceNumber;
                    /* var options = {
                        modalDivId: "show-video",
                        width: 820,
                        height: 560,
                        title: "查看视频",
                        url: "videomonitoring/showVideo1?CHECK_AUTHENTICATION=false",
                        footerType: "user-defined",
                        oriMarginTop: 180,
                        footerButtons: []
                    };
                    createModalWithLoadOptions(options);
                    openModal("#show-video-modal", false, false); */
                    playBack(rowIndex);

                } else if ($(e.target).is('.class-record')) {
                    videoListManageData.row = videoListManageData.tbDevices.row(rowIndex);
                    videoListManageData.deviceId = videoListManageData.row.deviceId;
                    videoListManageData.deviceNumber = videoListManageData.row.deviceNumber;
                    createModalWithLoad("show-picture", 800, 650, "场景抓拍历史记录", "videomonitoring/showPicture?CHECK_AUTHENTICATION=false", "", "", "");
                }
            }).on('loadSuccess', function (e, data) {
            }).on('loadError', function (req, error, errObj) {
                showDialogModal("error-div", "操作错误", "初始化菜单数据失败：" + errObj);
            }).load();
        },
        loadStatusDropDownList: function () {
            $.ajax({
                type: "post",
                url: "${ctx}/staticData/query?CHECK_AUTHENTICATION=false&typeCode=CAMERA_STATUS&dataCode=",
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                async: false,
                success: function (data) {
                    if (data != null && data.length > 0) {
                        $(eval(data)).each(function () {
                            videoListManageData.dropDownListStatus.put(this.value, this.name);
                            videoListManageData.statusList[videoListManageData.statusList.length] = {
                                itemText: this.name,
                                itemData: this.value
                            };
                        });
                    }
                },
                error: function (req, error, errObj) {
                    showDialogModal("error-div", "操作错误", errObj);
                    return;
                }
            });

            var statusDropdownlist = $('#status-dropdownlist').dropDownList({
                inputName: "statusName",
                inputValName: "statusValue",
                buttonText: "",
                width: "115px",
                readOnly: false,
                required: true,
                maxHeight: 200,
                onSelect: function (i, data, icon) {
                },
                items: videoListManageData.statusList
            });

            statusDropdownlist.setData("请选择", "", "");
        },
        loadCameraBrandDropDownList: function () {
            $.ajax({
                type: "post",
                url: "${ctx}/device/bsStaticData/getValidStaticDatasByTypeCode?CHECK_AUTHENTICATION=false&typeCode=CAMERA_BRAND&dataCode=",
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                async: false,
                success: function (data) {
                    videoListManageData.cameraBrandList[videoListManageData.cameraBrandList.length] = {
                        itemText: "请选择",
                        itemData: ""
                    };
                    if (data != null && data.length > 0) {
                        $(eval(data)).each(function () {
                            videoListManageData.dropDownListCameraBrand.put(this.value, this.name);
                            videoListManageData.cameraBrandList[videoListManageData.cameraBrandList.length] = {
                                itemText: this.name,
                                itemData: this.value
                            };
                        });
                    }
                },
                error: function (req, error, errObj) {
                    showDialogModal("error-div", "操作错误", errObj);
                    return;
                }
            });

            var cameraBrandDropdownlist = $('#cameraBrand-dropdownlist').dropDownList({
                inputName: "brandName",
                inputValName: "brandValue",
                buttonText: "",
                width: "115px",
                readOnly: false,
                required: true,
                maxHeight: 200,
                onSelect: function (i, data, icon) {
                },
                items: videoListManageData.cameraBrandList
            });

            cameraBrandDropdownlist.setData("请选择", "", "");
        }
    };
    $(document).ready(function () {
        videoListManageUtil.init();
    });
    
    function playBack(rowIndex){
    	var row = videoListManageData.tbDevices.row(rowIndex);
    	if(row.deviceId){
        	createModalWithLoad("show-video-dss", 820, 560, "查看视频",
        			"videomonitoring/showDssVideo?type=1&deviceNo="+ row.deviceId, "", "", "","");
    	}
    }
</script>
</body>
</html>