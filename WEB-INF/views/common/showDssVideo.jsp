<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="height" value="${param.height==null?432:param.height}" />
<c:set var="width" value="${param.width==null?768:param.width}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%-- <script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js"
			type="text/javascript"></script> --%>
	<script type="text/javascript"
		src="${ctx}/static/video-player/js/dss-player.js"></script>
</head>
	<div id="divDss" style="width: 100%;height: 100%">
	</div>
<script>
	var type = "${param.type}";
	var deviceNo = "${param.deviceNo}";
	var playbackTime = decodeURI("${param.playbackTime}");
	var url = "${param.url}";
	var dssProjectCode = "";
	if(typeof(projectCode) != 'undefined'){
		dssProjectCode = projectCode;
	}
	var playbackStartTime = null;
	var playbackEndTime = null;
	if(playbackTime != ""){
		var playbackDate = new Date(playbackTime.replace(/-/g,'/'));
		playbackStartTime = formatDateTime(playbackDate.getTime()-10*1000);
		playbackEndTime = formatDateTime(playbackDate.getTime()+10*1000);
	}
	$(".modal-dialog").css("transform","none");
	var dssPlayerObj = null;
	var dssParam = null;
	var beShown = false;
	$(document).ready(function(){
       	initDSS();
		$("#show-video-dss-modal").on('shown.bs.modal', function () {
			console.log("shown.bs.modal");
			if(!beShown){
				if(dssParam != null){
					dssPlayerObj = $("#divDss").dssPlayer({
						ipAddr : dssParam.ipAddr,
						port : dssParam.port,
						username : dssParam.userName,
						password : dssParam.password,
						width : "100%",
						height : "100%"
					});
					dssPlayerObj.play(dssParam.channel,playbackStartTime,playbackEndTime);
				}
				beShown = true;
			}
        });
		/* $("#show-video-modal .close").on("click",function(){
			dssPlayerObj.stop();
        	$('#show-video-modal').modal('hide');
	    }); */
		$("#show-video-dss-modal").on('hide.bs.modal', function () {
			if(dssPlayerObj != null){
				dssPlayerObj.stop();
			}
        });
	});
	function initDSS(){
		if(url != "" && url != "undefined"){
			//视频宽高比例与显示宽高要一致  否则会有黑边  720*1280
			var videoHtml = '<video src="'+ url +'" height="${height}" width="${width}" controls autoplay="autoplay">'
				+ '您的浏览器不支持 video 标签。'
				 + '</video>';
			$("#divDss").append(videoHtml);
			openModal("#show-video-dss-modal", false, false);
		}else{
			$.ajax({
				type : "get",
				url : "${ctx}/device/deviceInfo/dssParam?deviceNo=" + deviceNo + "&type=" + type + "&projectCode=" + dssProjectCode,
				dataType : "json",
				async: false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						dssParam = data.RETURN_PARAM;
						openModal("#show-video-dss-modal", false, false);
					} else {
						showDialogModal("error-div", "操作错误", data.MESSAGE);
						$('#show-video-dss-modal').modal('hide');
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
		}
	}
	function formatDateTime(inputTime) {
		var date = new Date(inputTime);
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		m = m < 10 ? ('0' + m) : m;
		var d = date.getDate();
		d = d < 10 ? ('0' + d) : d;
		var h = date.getHours();
		h = h < 10 ? ('0' + h) : h;
		var minute = date.getMinutes();
		var second = date.getSeconds();
		minute = minute < 10 ? ('0' + minute) : minute;
		second = second < 10 ? ('0' + second) : second;
		return y + '-' + m + '-' + d + ' ' + h + ':' + minute + ':' + second;
	};
	
	function showDModal(msg){
		showDialogModal("error-div", "操作错误", msg);
		$("#error-div-modal-content").append('<iframe id="iframe-dss" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:400px; height:186px;z-index:-1; filter:alpha(opacity=0);"></iframe>');
	}
</script>
