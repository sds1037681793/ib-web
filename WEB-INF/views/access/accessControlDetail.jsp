<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style>
/* #tb_accessControlDetailDiv{ overflow:auto} */
</style>
<link href="${ctx}/static/css/pagination.css" rel="stylesheet"
	type="text/css" />
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script type="text/javascript"
	src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<script src="${ctx}/static/js/jquery.pagination.js"
	type="text/javascript"></script>
<style type="text/css">

.header-default {
	background-color: #fff;
	border: 1px solid #e1e1e1;
	padding: 17px;
	margin-bottom: 20px;
	margin-left: 10px;
	width: 99%;
	background: #FFFFFF;
	border: 1px solid #B2B2B2;
	border-radius: 4px;
}

.form-control {
	margin-left: 10px;
	border: 1px solid #CCCCCC;
	border-radius: 2px;
}

#quPassageName, #ddl-btn-quPassageName, #ddl-btn-custmTypeName,
	#custmTypeName {
	/* 	border: 1px solid #CCCCCC; */
	/* 	border-radius: 2px; */
	
}

.pagination .current.prev, .pagination .next {
	border-color: #FFFFFF;
	background: #ffffff;
	font-size: 12px;
	color: #129D7C;
}

.pagination .prev {
	border-color: #FFFFFF;
	background: #ffffff;
	font-size: 12px;
	color: #0B78CC;
}

.pagination .current {
	border: 0px solid #E3EBED;
	background-color: #129D7C;
	font-size: 14px;
	padding-top: 4px;
}

.pagination a {
	text-decoration: none;
	background: #FFFFFF;
	border: 1px solid #E3EBED;
	font-family: PingFangSC-Regular;
	font-size: 12px;
	color: #129D7C;
}

.btn-common {
	margin-right: 0px !important;
}
</style>
</head>
<body>
	<div class="content-default" style="">
		<form id="select-form" style="margin-top: -3px;">
			<table style="">
				<tr>
					<td align="right" style="width: 6rem;">通道：</td>
					<td><div id="passage-dropdownlist"></div></td>
					<td align="right" style="width: 6rem;">类型：</td>
					<td>
						<div id="custmType-dropdownlist"></div>
					</td>
					<td align="right" style="text-align: right; width: 6rem;">用户姓名：</td>
					<td><input id="personnelName" name="personnelName"
						placeholder="用户姓名" class="form-control required" type="text"
						style="width: 150px;" /></td>
				</tr>
				<tr>
					<td align="right">开始时间：</td>
					<td><input id="accStartDate" name="accStartDate"
						placeholder="开始时间" class="form-control required" type="text"
						style="width: 150px;" /></td>
					<td align="right">结束时间：</td>
					<td><input id="accEndDate" name="accEndDate"
						placeholder="结束时间" class="form-control required" type="text"
						style="width: 150px;" /></td>
					<td></td>
					<td align="right" style="width: 150px;">
						<button id="btn-query" type="button"
							class="btn btn-default btn-common btn-common-green" style="">查询</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- tag -->
	<div id="tb_accessControlDetailDiv" class="content-default"
		style="height: 99%; width: 100%; padding-top: 0px; padding-bottom: 35px; padding-left: 30px; background: #fff; border: 1px solid #ccc;">
		<table id="tb_accessControlDetail"
			style="border: 0px solid; height: 99%; width: 99%;">
			<!-- <ul id="lxf-box">
    </ul> -->
			<tr id="picTr1"></tr>
			<tr id="picTr2"></tr>
		</table>
	</div>
	<div class="pagination" style="position: relative; float: right;"></div>
	<div id="access-img"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>
	<script type="text/javascript">
		var returnData;
		var loadx = 1;
		var oneCount = 10;
		var margin = 10;//这里设置间距
		var li_W = 356;//图片宽
		if ($(window).width() <= 1024) {
			li_W = 22 * 12;
		} else if ($(window).width() <= 1366) {
			li_W = 22 * 14;
		} else {
			li_W = 22 * 16;
		}

		var scrollTimer = null;
		var sentIt = true;
		var orgId = $("#login-org").data("orgId");
		//var userType;
		//var userId;
		var ddlAllPassage;
		var countRecord;
		var ddlAllPassageItems = new Array();
		ddlAllPassageItems[ddlAllPassageItems.length] = {
			itemText : "请选择",
			itemData : 0
		};
		var custmTypeItems = new Array();
		custmTypeItems[0] = {
				itemText : "请选择",
				itemData : ""
			};
		custmTypeItems[1] = {
			itemText : "用户",
			itemData : 1
		};
		custmTypeItems[2] = {
			itemText : "访客",
			itemData : 2
		};
		$(document)
				.ready(
						function() {
							oneCount = calculateColumns() * 2;
							dropdownlist1 = $('#custmType-dropdownlist')
									.dropDownList({
										inputName : "custmTypeName",
										inputValName : "custmTypeId",
										buttonText : "",
										width : "117px",
										readOnly : false,
										required : true,
										MultiSelect : true,
										maxHeight : 200,
										onSelect : function(i, data, icon) {
										},
										items : custmTypeItems
									});
							dropdownlist1.setData("请选择", "", "");

							initPage();
							$('#btn-query').on('click', function() {
								initPage();
							});

							// 获取静态数据类型
							$.ajax({type : "post",
								url : "${ctx}/access-control/accessStatistics/queryAllPassage?CHECK_AUTHENTICATION=false&projectCode=" + projectCode,
										async : false,
										dataType : "json",
										contentType : "application/json;charset=utf-8",
										success : function(data) {
											if (data.data != null && data.data.length > 0) {
												$(eval(data.data))
														.each(
																function() {
																	ddlAllPassageItems[ddlAllPassageItems.length] = {
																		itemText : this.itemText,
																		itemData : this.itemData
																	};
																});
												// 设置用户类型下拉列表
												ddlAllPassage = $(
														"#passage-dropdownlist")
														.dropDownList(
																{
																	inputName : 'quPassageName',
																	inputValName : 'quPassageId',
																	buttonText : "",
																	width : "117px",
																	readOnly : false,
																	required : true,
																	maxHeight : 200,
																	items : ddlAllPassageItems
																});
												ddlAllPassage.setData("请选择",
														"0", "");
											}
										},
										error : function(req, error, errObj) {
										}
									});
							$("#accStartDate").datetimepicker({
								id : 'datetimepicker-accStartDate',
								containerId : 'datetimepicker-div',
								lang : 'ch',
								timepicker : true,
								hours12 : false,
								allowBlank : true,
								format : 'Y-m-d H:i:s',
								formatDate : 'YYYY-mm-dd hh:mm:ss'
							});
							$("#accEndDate").datetimepicker({
								id : 'datetimepicker-accEndDate',
								containerId : 'datetimepicker-div',
								lang : 'ch',
								timepicker : true,
								hours12 : false,
								allowBlank : true,
								format : 'Y-m-d H:i:s',
								formatDate : 'YYYY-mm-dd hh:mm:ss'

							});
						});
		function initPage() {//初始页
			var limit = oneCount;
			var personnelName = $("#personnelName").val();
			var passageId = $("#quPassageId").val();
			var startDate = $("#accStartDate").val();
			var endDate = $("#accEndDate").val();
			var data = {
				"projectCode" : projectCode
			};
			var custmTypeId = $("#custmTypeId").val();
			if (personnelName != "") {
				$(data).attr({
					"personnelName" : personnelName
				});
			}
			if (passageId != "") {
				$(data).attr({
					"passageId" : passageId
				});
			}
			if (startDate != "") {
				$(data).attr({
					"startDate" : startDate
				});
			}
			if (endDate != "") {
				$(data).attr({
					"endDate" : endDate
				});
			}
			if (custmTypeId != "") {
				$(data).attr({
					"custmTypeId" : custmTypeId
				});
			}
			$.ajax({
				type : "post",
				url : "${ctx}/access-control/accessStatistics/getList?page=1&limit=" + limit
						+ "&sortName=id&sortType=desc",
				data : JSON.stringify(data),
				dataType : "json",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					returnData = data;
					$(".pagination").pagination(data.totalCount, {
						callback : pageselectCallback,
						prev_text : '上一页',
						next_text : '下一页',
						items_per_page : oneCount,
						num_display_entries : 5,
						num_edge_entries : 2
					});
				},
				error : function(req, error, errObj) {
				}
			});
		}

		function pageselectCallback(page_index, jq) {
			InitData(page_index);
		}
		function InitData(page_id) {
			getData(page_id + 1);
		}
		function createAccModal(id) {
			
			var imgs = $("#"+id+"").attr("imgs");
			var faceImgUrl = $("#"+id+"").attr("faceImgUrl");
			createModalWithLoad("access-img", 730, 500,  "门禁监控",
					"accessControl/accessFindSnapshotImage?imgs=" + imgs+"&faceImgUrl="+faceImgUrl, "", "", "");
			openModal("#access-img-modal", true, false);
			$('#access-img-modal').on('shown.bs.modal', function() {
				loadPic();
			})
		}

		function waterFlowImg() {//定义成函数便于调用
			var lastTop = 0;
			var li = $("#lxf-box").find("li");//这里是区块名称
			var h = [];//记录区块高度的数组
			var n = calculateColumns();
			for (var i = 0; i < li.length; i++) {//有多少个li就循环多少次
				li_H = li[i].offsetHeight;//获取每个li的高度
				if (i < n) {//n是一行最多的li，所以小于n就是第一行了
					h[i] = li_H;//把每个li放到数组里面
					li.eq(i).css("top", 0);
					li.eq(i).css("left", i * li_W);
					lastTop = li_H + margin;
				} else {
					min_H = Math.min.apply(null, h);//取得数组中的最小值，区块中高度值最小的那个
					minKey = getArrayKey(h, min_H);//最小的值对应的指针
					h[minKey] += li_H + margin;//加上新高度后更新高度值
					li.eq(i).css("top", min_H + margin);//先得到高度最小的Li，然后把接下来的li放到它的下面
					li.eq(i).css("left", minKey * li_W);//第i个li的左坐标就是i*li的宽度
					lastTop = min_H + li_H + margin;
				}
			}
			$(".pagination").css("top", lastTop + 10);
		}

		function getArrayKey(s, v) {
			for (k in s) {
				if (s[k] == v) {
					return k;
				}
			}
		}

		function calculateColumns() {//计算需要的列数
			var all_W = $("#tb_accessControlDetail").width();
			var num = all_W / (li_W + margin) | 0;
			if (num < 1) {
				num = 1;
			} //保证至少有一列
			return num;
		}

		function firstPageInit() {
			var data = returnData;
			$("#tb_accessControlDetail").find("td").remove();
			var html = '';
			var dataLength = data.items.length;
			countRecord = dataLength;

			for (var i = 0; i < dataLength; i++) {
				var imgurl = extNetImageMapping(data.items[i].imgUrl);
				var custName = "未知";
				if (data.items[i].custName) {
					custName = data.items[i].custName;
				}
				var authType = "未知";
				if (data.items[i].authType) {
					authType = data.items[i].authType;
				}
				var authNo = "未知";
				if (data.items[i].authNo) {
					authNo = data.items[i].authNo;
				}
				var personnelTypeName = "未知";
				if (data.items[i].personnelTypeName) {
					personnelTypeName = data.items[i].personnelTypeName;
				}
				var passageName = "未知";
				if (data.items[i].passageName) {
					passageName = data.items[i].passageName;
				}
				var openDate = "未知";
				if (data.items[i].openDate) {
					openDate = data.items[i].openDate.substring(5)
				}
				var faceImgUrl = extNetImageMapping(data.items[i].faceImgUrl);
				var cell = "cell" + i;
				var cType = data.items[i].cType;
				var cTypeName = '用户姓名：';
				if (2 == cType || 4 == cType) {
					cTypeName = '访客姓名：';
				}
				if (imgurl == "" || typeof (imgurl) == "undefined") {
					imgurl = "${ctx}/static/img/m2.png";
				}
				var imgurls = extNetImageMapping(data.items[i].imgUrls);
				if (imgurls == "" || typeof (imgurls) == "undefined") {
					imgurls = "${ctx}/static/img/m2.png";
					icErrorImg = "${ctx}/static/img/IcErrorImg.svg";
					if(faceImgUrl == "" || typeof (faceImgUrl) == "undefined"){
						faceImgUrl =icErrorImg;
					}
					html += '<td id ="'+cell+'" imgs="'+imgurls+'" faceImgUrl="'+faceImgUrl+'" style="width:25rem;padding-top: 3rem;">'
							+ '<img style="width:22rem;height:200px;" src="'+faceImgUrl+'"/><table style="width:25rem;margin-top:20px;margin-left:2px;"><tr><td>'
							+ cTypeName
							+ ''
							+ custName
							+ '</td><td>出入通道：'
							+ passageName
							+ '</td></tr><tr><td>出入方式：'
							+ authType
							+ '</td><td >出入时间：'
							+ openDate
							+ '</h></td></tr></table>' + '</td>';
				} else {
					var defaultImg = "${ctx}/static/img/m2.png";
					html += '<td  id ="'+cell+'" imgs="'+imgurls+'"  faceImgUrl="'+faceImgUrl+'"  style="width:25rem;padding-top: 3rem;position:relative">'
							+ '<img style="width:22rem;height:200px;cursor: pointer;" src="'
							+ faceImgUrl
							+ '" onerror="src='
							+ defaultImg
							+ '" onclick="createAccModal(\''
							+ cell
							+ '\')"/><table style="width:25rem;margin-top:20px;margin-left:2px;">';
					if (typeof (faceImgUrl) != "undefined") {
						var faceImgUrl = extNetImageMapping(faceImgUrl);
						html += '<img  src = '+ faceImgUrl +' class="pic" style="position:absolute; left:16.5rem; width:5.5rem;height: 5.5rem;" ></img>'
					}
					html += '<tr><td>' + cTypeName + '' + custName
							+ '</td><td>出入通道：' + passageName
							+ '</td></tr><tr><td>出入方式：' + authType
							+ '</td><td >出入时间：' + openDate
							+ '</h></td></tr></table>' + '</td>';
				}

				if (i == Math.ceil(countRecord / 2) - 1) {
					$("#picTr1").append(html);
					html = '';
				}
			}
			if (dataLength < Math.ceil(countRecord / 2)) {
				for (var i = 0; i < Math.ceil(countRecord / 2) - dataLength; i++) {
					html += '<td style="width:25rem;"><input type="hidden"/><td>';
				}
			}
			$("#picTr2").append(html);
		}

		function getData(load_index) {
			//第一遍查询不需要再进行查询一次
			if (load_index == 1) {
				firstPageInit();
			} else {
				var limit = oneCount;
				var personnelName = $("#personnelName").val();
				var passageId = $("#quPassageId").val();
				var startDate = $("#accStartDate").val();
				var endDate = $("#accEndDate").val();
				var data = {
					"projectCode" : projectCode
				};
				var custmTypeId = $("#custmTypeId").val();
				if (personnelName != "") {
					$(data).attr({
						"personnelName" : personnelName
					});
				}
				if (passageId != "") {
					$(data).attr({
						"passageId" : passageId
					});
				}
				if (startDate != "") {
					$(data).attr({
						"startDate" : startDate
					});
				}
				if (endDate != "") {
					$(data).attr({
						"endDate" : endDate
					});
				}
				if (custmTypeId != "") {
					$(data).attr({
						"custmTypeId" : custmTypeId
					});
				}

				$.ajax({
							type : "post",
							url : "${ctx}/access-control/accessStatistics/getList?page="
									+ load_index + "&limit=" + limit
									+ "&sortName=id&sortType=desc",
							data : JSON.stringify(data),
							dataType : "json",
							async : false,
							contentType : "application/json;charset=utf-8",
							success : function(data) {
								$("#tb_accessControlDetail").find("td")
										.remove();
								var html = '';
								var dataLength = data.items.length;
								if (load_index == 1) {
									countRecord = dataLength;
								}
								for (var i = 0; i < dataLength; i++) {
									var imgurl = extNetImageMapping(data.items[i].imgUrl);
									var custName = "未知";
									if (data.items[i].custName) {
										custName = data.items[i].custName;
									}
									var authType = "未知";
									if (data.items[i].authType) {
										authType = data.items[i].authType;
									}
									var authNo = "未知";
									if (data.items[i].authNo) {
										authNo = data.items[i].authNo;
									}
									var personnelTypeName = "未知";
									if (data.items[i].personnelTypeName) {
										personnelTypeName = data.items[i].personnelTypeName;
									}
									var passageName = "未知";
									if (data.items[i].passageName) {
										passageName = data.items[i].passageName;
									}
									var openDate = "未知";
									if (data.items[i].openDate) {
										openDate = data.items[i].openDate
												.substring(5)
									}
									var faceImgUrl = data.items[i].faceImgUrl;
									var cell = "cell" + i;
									var cType = data.items[i].cType;
									var cTypeName = '用户姓名：';
									if (2 == cType || 4 == cType) {
										cTypeName = '访客姓名：';
									}
									if (imgurl == ""
											|| typeof (imgurl) == "undefined") {
										imgurl = "${ctx}/static/img/m2.png";
									}
									var imgurls = extNetImageMapping(data.items[i].imgUrls);

									if (imgurls == ""
											|| typeof (imgurls) == "undefined") {
										imgurls = "${ctx}/static/img/m2.png";
										icErrorImg = "${ctx}/static/img/IcErrorImg.svg";
										if(faceImgUrl == "" || typeof (faceImgUrl) == "undefined"){
											faceImgUrl =icErrorImg;
										}
										html += '<td id ="'+cell+'" imgs="'+imgurls+'" faceImgUrl="'+faceImgUrl+'"   style="width:25rem;padding-top: 3rem;">'
												+ '<img style="width:22rem;height:200px;" src="'+faceImgUrl+'"/><table style="width:25rem;margin-top:20px;margin-left:2px;"><tr><td>'
												+ cTypeName
												+ ''
												+ custName
												+ '</td><td>出入通道：'
												+ passageName
												+ '</td></tr><tr><td>出入方式：'
												+ authType
												+ '</td><td >出入时间：'
												+ openDate
												+ '</h></td></tr></table>'
												+ '</td>';
									} else {
										var defaultImg = "${ctx}/static/img/m2.png";
										html += '<td  id ="'+cell+'" imgs="'+imgurls+'"  faceImgUrl="'+faceImgUrl+'" style="width:25rem;padding-top: 3rem;position:relative">'
												+ '<img style="width:22rem;height:200px;cursor: pointer;" src="'
												+ faceImgUrl
												+ '" onerror="src='
												+ defaultImg
												+ '" onclick="createAccModal(\''
												+ cell
												+ '\')"/><table style="width:25rem;margin-top:20px;margin-left:2px;">';
										if (typeof (faceImgUrl) != "undefined") {
											var faceImgUrl = extNetImageMapping(faceImgUrl);
											html += '<img  src = '+ faceImgUrl +' class="pic" style="position:absolute; left:16.5rem; width:5.5rem;height: 5.5rem;" ></img>'
										}
										html += '<tr><td>' + cTypeName + ''
												+ custName + '</td><td>出入通道：'
												+ passageName
												+ '</td></tr><tr><td>出入方式：'
												+ authType + '</td><td >出入时间：'
												+ openDate
												+ '</h></td></tr></table>'
												+ '</td>';
									}

									if (i == Math.ceil(countRecord / 2) - 1) {
										$("#picTr1").append(html);
										html = '';
									}
								}
								if (dataLength < Math.ceil(countRecord / 2)) {
									for (var i = 0; i < Math
											.ceil(countRecord / 2)
											- dataLength; i++) {
										html += '<td style="width:25rem;"><input type="hidden"/><td>';
									}
								}
								$("#picTr2").append(html);
							},
							error : function(req, error, errObj) {
							}
						});
			}
		}

	</script>
</body>
</html>