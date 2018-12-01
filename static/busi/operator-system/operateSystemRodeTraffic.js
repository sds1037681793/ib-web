//马路流量
function getRodeTraffic() {
	$.ajax({
		type : "post",
		url : ctx + "/rode/rodeTraffic",
		async:false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				var returnVal = data.RETURN_PARAM;
			if (returnVal.rodeTrafficType=="2,3") { // 7:00-9:00早高峰
                $("#rodeTrafficShow").addClass("rodeTrafficShowYellow");+
                $("#rodeTrafficShowTwo").addClass("rodeTrafficShowTwo");
                $("#rodeTraffic1").removeClass("rodeTraffic1");
                $("#rodeTraffic1").addClass("rodeTraffic1Yellow");
                $("#rodeTraffic3").removeClass("rodeTraffic3");
                $("#rodeTraffic3").addClass("rodeTraffic3Red");
                $("#rodeTraffic4").removeClass("rodeTraffic4");
                $("#rodeTraffic4").addClass("rodeTraffic4Yellow");
                $("#rodeTraffic5").removeClass("rodeTraffic5");
                $("#rodeTraffic5").addClass("rodeTraffic5Red");
                $("#rodeTraffic6").removeClass("rodeTraffic6");
                $("#rodeTraffic6").addClass("rodeTraffic6Yellow");
                $("#rodeTraffic7").removeClass("rodeTraffic7");
                $("#rodeTraffic7").addClass("rodeTraffic7Yellow");
                $("#rodeTraffic8").removeClass("rodeTraffic8");
                $("#rodeTraffic8").addClass("rodeTraffic8Red");
                $("#rodeTraffic10").removeClass("rodeTraffic10");
                $("#rodeTraffic10").addClass("rodeTraffic10Yellow");
                } else if (returnVal.rodeTrafficType=="3,2") {// 16:30-18:30晚高峰
                      $("#rodeTrafficShow").addClass("rodeTrafficShow");
                      $("#rodeTrafficShowTwo").addClass("rodeTrafficShowTwo");
                      $("#rodeTraffic2").removeClass("rodeTraffic2");
                      $("#rodeTraffic2").addClass("rodeTraffic2Yellow");
                      $("#rodeTraffic4").removeClass("rodeTraffic4");
                      $("#rodeTraffic4").addClass("rodeTraffic4Red");
                      $("#rodeTraffic5").removeClass("rodeTraffic5");
                      $("#rodeTraffic5").addClass("rodeTraffic5Red");
                      $("#rodeTraffic6").removeClass("rodeTraffic6");
                      $("#rodeTraffic6").addClass("rodeTraffic6Yellow");
                      $("#rodeTraffic7").removeClass("rodeTraffic7");
                      $("#rodeTraffic7").addClass("rodeTraffic7Yellow");
                      $("#rodeTraffic8").removeClass("rodeTraffic8");
                      $("#rodeTraffic8").addClass("rodeTraffic8Yellow");
                      $("#rodeTraffic9").removeClass("rodeTraffic9");
                      $("#rodeTraffic9").addClass("rodeTraffic9Red");
                      $("#rodeTraffic11").removeClass("rodeTraffic11");
                      $("#rodeTraffic11").addClass("rodeTraffic11Yellow");
                }
			}else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});

}
