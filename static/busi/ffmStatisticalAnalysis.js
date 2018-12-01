var num = 0;
// 获取饼图echart
function getBingEchart(reportId, divId, startTime, endTime) {
	$.ajax({
		type : "post",
		url : ctx + "/report/" + reportId + "?projectCode=" + projectCode + "&startTime=" + startTime + "&endTime=" + endTime,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var obj = echarts.init(document.getElementById(divId));
			obj.setOption($.parseJSON(data));
		},
		error : function(req, error, errObj) {
		}
	});
}

//组装消防水系统事件统计图ECharts
function getWaterSystemEchart(divId, timeType) {
	if (timeType == undefined || timeType == "") {
		timeType = 1;
	}
	var zoomData = '';
	if (timeType == 1 || timeType == 3) {
		zoomData = [
			{
				type : 'inside',
				start : 50,
				end : 100,
				startValue : 0,
				endValue : 0
			}
		];
	} else {
		zoomData = '';
	}
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/getWaterSystemStatistics?timeType=" + timeType + "&projectCode=" + projectCode,
		async : true,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null && data.length > 0) {
				var date = new Date();
				var strDate = date.getDate();
				var timeArr = [];
				var waterPressureDataArr = [];
				var eleExpDataArr = [];
				var testOffLineDataArr = [];
				$(eval(data)).each(function() {
					timeArr[timeArr.length] = this.timeSpan;
					waterPressureDataArr[waterPressureDataArr.length] = this.waterPressure;
					eleExpDataArr[eleExpDataArr.length] = this.eleExp;
					testOffLineDataArr[testOffLineDataArr.length] = this.testOffLine;
				});

				var obj = echarts.init(document.getElementById(divId));
				obj.clear();
				var option = {
					tooltip : {
						trigger : 'axis',
						axisPointer : { // 坐标轴指示器，坐标轴触发有效
							type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
						}
					},
					legend : {
						data : [
								'水压异常            ', '电动阀异常            ', '测点离线'
						],
						icon : 'circle',
						textStyle : {
							color : '#666666'
						}
					},
					grid : {
						left : '3%',
						right : '6%',
						bottom : '3%',
						containLabel : true
					},
					xAxis : {
						type : 'category',
						name : '时间',
						nameTextStyle : {
							color : '#666666'
						},
						axisLabel : {
							show : true,
							interval : 0,
							textStyle : {
								color : '#666666'
							}
						},
						data : timeArr,
						axisLine : {
							lineStyle : {
								color : '#C2C9D1',
								width : 1,
								type : 'solid'
							}
						}
					},
					yAxis : {
						boundaryGap : [
								0, 0.1
						],
						minInterval : 1,
						type : 'value',
						name : '次数',
						nameTextStyle : {
							color : '#666666'
						},
						axisLabel : {
							show : true,
							interval : 0,
							textStyle : {
								color : '#666666'
							}
						},
						axisLine : {
							lineStyle : {
								color : '#C2C9D1',
								width : 1,
								type : 'solid'
							}
						}

					},
					dataZoom : zoomData,
					color : [
							'#4DA1FF', '#FFDC73', '#EF9393'
					],
					barWidth : 35,
					series : [
							{
								name : '水压异常            ',
								type : 'bar',
								stack : '总量',
								data : waterPressureDataArr
							}, {
								name : '电动阀异常            ',
								type : 'bar',
								stack : '总量',
								data : eleExpDataArr
							}, {
								name : '测点离线',
								type : 'bar',
								stack : '总量',
								data : testOffLineDataArr
							}
					]
				};
				obj.setOption(option);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

//组装消防火警系统事件统计图ECharts
function getAlarmSystemEchart(divId, timeType) {
	if (timeType == undefined || timeType == "") {
		timeType = 1;
	}
	var zoomData = '';
	if (timeType == 1 || timeType == 3) {
		zoomData = [
			{
				type : 'inside',
				start : 50,
				end : 100,
				startValue : 0,
				endValue : 0
			}
		];
	} else {
		zoomData = '';
	}
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireAlarmSystem/getAlarmSystemStatistics?timeType=" + timeType + "&projectCode=" + projectCode,
		async : true,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null && data.length > 0) {
				var date = new Date();
				var strDate = date.getDate();
				var width;
				// 当选择条件为本月(timeType=3)时适当修改条形宽度
				if (timeType == 3 && strDate <= 10) {
					width = 35;
				} else if (timeType == 3 && strDate <= 20) {
					width = 25;
				} else if (timeType == 3 && strDate > 20) {
					width = 15;
				}
				if (timeType != 3) {
					width = 35;
				}
				var timeArr = [];
				var fireStatusNumArr = [];
				var faultStatusNumArr = [];
				var linkageNumArr = [];
				$(eval(data)).each(function() {
					timeArr[timeArr.length] = this.timeSpan;
					fireStatusNumArr[fireStatusNumArr.length] = this.fireStatusNum;
					faultStatusNumArr[faultStatusNumArr.length] = this.faultStatusNum;
					linkageNumArr[linkageNumArr.length] = this.linkageNum;
					num = num+this.fireStatusNum+this.faultStatusNum+this.linkageNum;
				});
                if(num>0){
                	$("#alarm_system_form").show();
                	$("#alarm_system_form_no").hide();
                	num = 0;
                }else{
                	$("#alarm_system_form").hide();
                	$("#alarm_system_form_no").show();
                	num = 0;
                }
				var obj = echarts.init(document.getElementById(divId));
				obj.clear();
				var option = {
					tooltip : {
						trigger : 'axis',
						axisPointer : { // 坐标轴指示器，坐标轴触发有效
							type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
						}
					},
					
					legend : {
						data : [
								'火警             ', '故障             ', '回答'
						],
						icon : 'circle'
					},
					grid : {
						left : '3%',
						right : '6%',
						bottom : '13%',
						containLabel : true
					},
					dataZoom: zoomData,
				    calculable: true,
					xAxis : {
						name :'时间',
						nameTextStyle:{
		                    color:'#666666' 
		                  },
						type : 'category',
						axisLabel : {
		                      show : true,
		      				interval:0,
		                      textStyle : {
		                      color : '#666666'
		                      }
		                  },
						nameGap : 8,
						data : timeArr,
						axisLine: {
			                  lineStyle:{
			            color:'#C2C9D1',
						width:1,
			      		type:'solid'
			      	}
			              },
					
					},
				          yAxis: [
				                    {
				            						name :'次数',

				            						nameTextStyle:{
				                          color:'#666666'
				                        },
				            boundaryGap:[0, 0.1],

				            minInterval : 1, 
				                        type: "value",
				                        boundaryGap:[0, 0.1],
									    minInterval : 1, 
				            			axisLabel : {
				                            show : true,
				                            textStyle : {
				                            color : '#666666'
				                            }
				                        },
				            			axisLine: {
				                        lineStyle:{
				            		color:'#E7EBEF',
				            		width:2,
				            		type:'solid'
				            	}
				                    }
				                    }
				                ],
					color : [
							'#4DA1FF', '#FFDC73', '#EF9393'
					],
					barWidth : 35,
					series : [
							{
								name : '回答',
								type : 'bar',
								stack : '总量',
								data : linkageNumArr
							}, {
								name : '故障             ',
								type : 'bar',
								stack : '总量',
								data : faultStatusNumArr
							}, {
								name : '火警             ',
								type : 'bar',
								stack : '总量',
								data : fireStatusNumArr
							}
					]
				};
				obj.setOption(option);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}