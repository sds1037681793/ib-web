// 全局保存当前选中窗口
var g_iWndIndex = 0; //可以不用设置这个变量，有窗口参数的接口中，不用传值，开发包会默认使用当前选择窗口
var screenMap = {};//0不在播放1在播放
$(function () {
    // 检查插件是否已经安装过
    var iRet = WebVideoCtrl.I_CheckPluginInstall();
    if (-2 == iRet) {
        alert("您的Chrome浏览器版本过高，不支持NPAPI插件（安装时请将浏览器关闭）！");
        return;
    } else if (-1 == iRet) {
        var szInfo = "您还未安装过插件，请下载WebComponentsKit.exe安装！";

        showDialogModal("error-div", "操作提示", szInfo, 2, "downloadexe()");
        return;
    }

    // 初始化插件参数及插入插件
    WebVideoCtrl.I_InitPlugin(1300, 700, {
        bWndFull: true,//是否支持单窗口双击全屏，默认支持 true:支持 false:不支持
        iWndowType: 3,
        cbSelWnd: function (xmlDoc) {
            g_iWndIndex = $(xmlDoc).find("SelectWnd").eq(0).text();

            $("#catchP").attr("src",ctx+'/static/hkImage/catchP.svg');
            $("#startVideoTape").attr("src",ctx+'/static/hkImage/startVideoTape.svg');
            $("#stopVideoTape").attr("src",ctx+'/static/hkImage/stopVideoTape.svg');
            $("#stopVideo").attr("src",ctx+'/static/hkImage/stopVideo.svg');

            if(screenMap[g_iWndIndex] == 1){
                $("#catchP").attr("src",ctx+'/static/hkImage/catchPL.svg');
                $("#startVideoTape").attr("src",ctx+'/static/hkImage/startVideoTapeL.svg');
                $("#stopVideoTape").attr("src",ctx+'/static/hkImage/stopVideoTapeL.svg');
                $("#stopVideo").attr("src",ctx+'/static/hkImage/stopVideoL.svg');
            }
        }
    });
    WebVideoCtrl.I_InsertOBJECTPlugin("divPlugin");

    // 检查插件是否最新
    /*if (-1 == WebVideoCtrl.I_CheckPluginVersion()) {
        alert("检测到新的插件版本，双击开发包目录里的WebComponentsKit.exe升级！");
        return;
    }*/

    // 窗口事件绑定
    $(window).bind({
        resize: function () {
            var $Restart = $("#restartDiv");
            if ($Restart.length > 0) {
                var oSize = getWindowSize();
                $Restart.css({
                    width: oSize.width + "px",
                    height: oSize.height + "px"
                });
            }
        }
    });
});

// 获取窗口尺寸
function getWindowSize() {
    var nWidth = $(this).width() + $(this).scrollLeft(),
        nHeight = $(this).height() + $(this).scrollTop();

    return {width: nWidth, height: nHeight};
}


// 窗口分割数
function changeWndNum(iType) {
    $("#screen1").attr("src",ctx+'/static/hkImage/1screen.svg');
    $("#screen4").attr("src",ctx+'/static/hkImage/4screen.svg');
    $("#screen9").attr("src",ctx+'/static/hkImage/9screen.svg');
    $("#screen16").attr("src",ctx+'/static/hkImage/16screen.svg');

    if(iType == 1){
        $("#screen1").attr("src",ctx+'/static/hkImage/1screenL.svg');
    }else if(iType == 2){
        $("#screen4").attr("src",ctx+'/static/hkImage/4screenL.svg');
    }else if(iType == 3){
        $("#screen9").attr("src",ctx+'/static/hkImage/9screenL.svg');
    }else if(iType == 4){
        $("#screen16").attr("src",ctx+'/static/hkImage/16screenL.svg');
    }

    iType = parseInt(iType, 10);
    WebVideoCtrl.I_ChangeWndNum(iType);
}

var szIP = "";
var szPort, szUsername, szPassword;

// 登录
function clickLogin(newNode) {
    szIP = newNode.ip;
    szPort = newNode.port;
    szUsername = newNode.userName;
    szPassword = newNode.password;
    if ("" == szIP || "" == szPort) {
        return;
    }

    var iRet = WebVideoCtrl.I_Login(szIP, 1, szPort, szUsername, szPassword, {
        success: function (xmlDoc) {
        },
        error: function () {
            alert(szIP + " 登录失败！");
        }
    });

    if (-1 == iRet) {
        alert(szIP + " 已登录过！");
    }
}

// 退出
function clickLogout(newNode) {
    var szInfo = "";

    szIP = newNode.ip;
    if (szIP == "") {
        return;
    }

    var iRet = WebVideoCtrl.I_Logout(szIP);
    if (0 == iRet) {
    } else {
        szInfo = "退出失败！";
        // alert(szIP + " " + szInfo);
    }
}

// 开始预览
function clickStartRealPlay(iChannelID) {
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex),
        iStreamType = 1,
        bZeroChannel = false,
        szInfo = "";

    if ("" == szIP) {
        return;
    }

    if (oWndInfo != null) {// 已经在播放了，先停止
        WebVideoCtrl.I_Stop();
    }

    var iRet = WebVideoCtrl.I_StartRealPlay(szIP, {
        iStreamType: iStreamType,
        iChannelID: iChannelID,
        bZeroChannel: bZeroChannel
    });

    if (0 == iRet) {
        screenMap[g_iWndIndex] = 1;

        $("#catchP").attr("src",ctx+'/static/hkImage/catchPL.svg');
        $("#startVideoTape").attr("src",ctx+'/static/hkImage/startVideoTapeL.svg');
        $("#stopVideoTape").attr("src",ctx+'/static/hkImage/stopVideoTapeL.svg');
        $("#stopVideo").attr("src",ctx+'/static/hkImage/stopVideoL.svg');
    } else {
        szInfo = "开始预览失败！";
        alert(szIP + " " + szInfo);
    }
    jQuery("#error-div-modal").css("z-index", 2000);
}

// 停止预览
function clickStopRealPlay() {
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex),
        szInfo = "";

    if (oWndInfo != null) {
        var iRet = WebVideoCtrl.I_Stop();
        if (0 == iRet) {
            screenMap[g_iWndIndex] = 0;

            $("#catchP").attr("src",ctx+'/static/hkImage/catchP.svg');
            $("#startVideoTape").attr("src",ctx+'/static/hkImage/startVideoTape.svg');
            $("#stopVideoTape").attr("src",ctx+'/static/hkImage/stopVideoTape.svg');
            $("#stopVideo").attr("src",ctx+'/static/hkImage/stopVideo.svg');
        } else {
            szInfo = "停止预览失败！";
            alert(oWndInfo.szIP + " " + szInfo);
        }
    }
}

/**
 * 下载插件
 */
function downloadexe() {
    window.open("static/plugin/WebComponentsKit(has rem cfg).exe", "_self");
}

//PTZ控制  9为自动，1,2,3,4,5,6,7,8为方向PTZ
var g_bPTZAuto = false;
function PTZControl(iPTZIndex){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex),
        // bZeroChannel = $("#channels option").eq($("#channels").get(0).selectedIndex).attr("bZero") == "true" ? true : false,
        iPTZSpeed = 1;//云台速度，默认为1

    // if (bZeroChannel) {// 零通道不支持云台
    //     return;
    // }

    if (oWndInfo != null) {
        if (9 == iPTZIndex && g_bPTZAuto) {
            iPTZSpeed = 0;// 自动开启后，速度置为0可以关闭自动
        } else {
            g_bPTZAuto = false;// 点击其他方向，自动肯定会被关闭
        }

        WebVideoCtrl.I_PTZControl(iPTZIndex, false, {
            iPTZSpeed: iPTZSpeed,
            success: function (xmlDoc) {
                if (9 == iPTZIndex) {
                    g_bPTZAuto = !g_bPTZAuto;
                }
                // alert(oWndInfo.szIP+"开启云台成功！");
            },
            error: function () {
                alert(oWndInfo.szIP+"开启云台失败！");
            }
        });
    }
};

//变倍-
function PTZZoomout(){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

    if (oWndInfo != null) {
        WebVideoCtrl.I_PTZControl(11, false, {
            iWndIndex: g_iWndIndex,
            success: function (xmlDoc) {
                // alert(oWndInfo.szIP+"变倍-成功！");
            },
            error: function () {
                alert(oWndInfo.szIP + "变倍-失败！");
            }
        });
    }
};

//变倍+
function PTZZoomIn(){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

    if (oWndInfo != null) {
        WebVideoCtrl.I_PTZControl(10, false, {
            iWndIndex: g_iWndIndex,
            success: function (xmlDoc) {
                // alert(oWndInfo.szIP + "变倍+成功！");
            },
            error: function () {
                alert(oWndInfo.szIP + "变倍+失败！");
            }
        });
    }
};

//变焦-
function PTZFoucusOut(){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

    if (oWndInfo != null) {
        WebVideoCtrl.I_PTZControl(13, false, {
            iWndIndex: g_iWndIndex,
            success: function (xmlDoc) {
                // alert(oWndInfo.szIP + "变焦-成功！");
            },
            error: function () {
                alert(oWndInfo.szIP + "变焦-失败！");
            }
        });
    }
};

//变焦+
function PTZFocusIn(){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

    if (oWndInfo != null) {
        WebVideoCtrl.I_PTZControl(12, false, {
            iWndIndex: g_iWndIndex,
            success: function (xmlDoc) {
                // alert(oWndInfo.szIP + "变焦+成功！");
            },
            error: function () {
                alert(oWndInfo.szIP + "变焦+失败！");
            }
        });
    }
};

//光圈+
function PTZIrisOut(){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

    if (oWndInfo != null) {
        WebVideoCtrl.I_PTZControl(15, false, {
            iWndIndex: g_iWndIndex,
            success: function (xmlDoc) {
                // alert(oWndInfo.szIP + "光圈-成功！");
            },
            error: function () {
                alert(oWndInfo.szIP + "光圈-失败！");
            }
        });
    }
};

//光圈-
function PTZIrisIn(){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

    if (oWndInfo != null) {
        WebVideoCtrl.I_PTZControl(14, false, {
            iWndIndex: g_iWndIndex,
            success: function (xmlDoc) {
                // alert(oWndInfo.szIP + "光圈+成功！");
            },
            error: function () {
                alert(oWndInfo.szIP + "光圈+失败！");
            }
        });
    }
};

//抓图
function clickCapturePic(){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex),
        szInfo = "";

    if (oWndInfo != null) {
        var szPicName = oWndInfo.szIP + "_" + g_iWndIndex + "_" + new Date().getTime(),
            iRet = WebVideoCtrl.I_CapturePic(szPicName);
        if (0 == iRet) {
            szInfo = "抓图成功！";
        } else {
            szInfo = "抓图失败！";
        }
        alert(oWndInfo.szIP + " " + szInfo);
    }
};

//开始录像
function clickStartRecord(){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex),
        szInfo = "";

    if (oWndInfo != null) {
        var szFileName = oWndInfo.szIP + "_" + g_iWndIndex + "_" + new Date().getTime(),
            iRet = WebVideoCtrl.I_StartRecord(szFileName);
        if (0 == iRet) {
            szInfo = "开始录像成功！";
        } else {
            szInfo = "开始录像失败！";
        }
        alert(oWndInfo.szIP + " " + szInfo);
    }
};

//停止录像
function clickStopRecord(){
    var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex),
        szInfo = "";

    if (oWndInfo != null) {
        var iRet = WebVideoCtrl.I_StopRecord();
        if (0 == iRet) {
            szInfo = "停止录像成功！";
        } else {
            szInfo = "停止录像失败！";
        }
        alert(oWndInfo.szIP + " " + szInfo);
    }
};