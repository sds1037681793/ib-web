function chart(id, data) {

	$("#" + id).empty();
	var content = '<table>';
	var width = $("#" + id).width();

	$
			.each(
					data,
					function(i, item) {
						var color = "#FFFFFF";
						switch (i + 1) {
						case 1:
							color = "#2383F3";
							break;
						case 2:
							color = "#A2CE6A";
							break;
						case 3:
							color = "#E44881";
							break;
						case 4:
							color = "#4BC7DB";
							break;
						case 5:
							color = "#FFF487";
							break;
						default:
							break;
						}
						var theWidth = item.cent * width;
						content += '<tr><td><span style=width:'
								+ width
								+ 'px;line-height:7rem;height:7rem;font-size:30px;color:#FFFFFF; letter-spacing: -0.2px;">'
								+ item.passageName + '&nbsp;&nbsp;&nbsp;&nbsp;'
								+ item.counts + '</span></td></tr>';
						content += '<tr><td><div style="opacity: 0.8;background: #464861;width:'
								+ width
								+ 'px;height:4.2rem;"></div>'
								+ '<div style="    position: relative;z-index: 99;margin-top: -4.2rem;height:4.2rem;width:'
								+ theWidth
								+ 'px;background:'
								+ color
								+ ';"></div></td></tr>'
					})
	content += '</table>'
	$("#" + id).append(content);
}

/* 男女比例 */
function sexRatioEchartInit() {
	var obj = echarts.init(document.getElementById("sex_ratio"));
	var option = {
		legend : {
			orient : 'horizontal',
			x : 'right',
			y : 'center',
			left : '60%',
			width : '1.7rem',
			height : '1.7rem',
			itemGap : 38,
			formatter : function(name) {
				if (name == '男') {
					return name + '  ' + male + '人';
				} else if (name == '女') {
					return name + '  ' + female + '人';
				}

			},
			data : [ {
				icon : 'circle',
				name : '男',
				textStyle : {
					color : '#FFFFFF'
				}

			}, {
				icon : 'circle',
				name : '女',
				textStyle : {
					color : '#FFFFFF'
				}
			} ]
		},
		color : [ '#00EDFF', '#FF6F6F' ],
		series : [ {
			name : '男女比例',
			type : 'pie',
			radius : [ '60%', '90%' ],
			center : [ '40%', '50%' ],
			hoverAnimation : false,
			itemStyle : {
				normal : {
					label : {
						show : false
					},
					labelLine : {
						show : false
					}
				},
				emphasis : {
					label : {
						show : false,
						position : 'left',
						textStyle : {
							fontSize : '30',
							fontWeight : 'bold',
							color : '#FFFFFF'
						}
					}
				}
			},
			data : [ {
				value : male,
				name : '男'
			}, {
				value : female,
				name : '女'
			} ]
		} ]
	}
	obj.setOption(option);
}

/* 登记人员比例 */
function signRatioEchartInit() {
	var obj = echarts.init(document.getElementById("sign_ratio"));
	var option = {
		legend : {
			orient : 'horizontal',
			x : 'right',
			y : 'center',
			left : '32%',
			width : '1.7rem',
			height : '1.7rem',
			itemGap : 38,
			formatter : function(name) {
				if (name == '已登记人员') {
					return name + '  ' + signPeople + '人';
				} else if (name == '未登记人员') {
					return name + '  ' + stranger + '人';
				}

			},
			data : [ {
				icon : 'circle',
				name : '已登记人员',
				textStyle : {
					color : '#FFFFFF'
				}

			}, {
				icon : 'circle',
				name : '未登记人员',
				textStyle : {
					color : '#FFFFFF'
				}
			} ]
		},
		color : [ '#5775FF', '#70D7FF' ],
		series : [ {
			name : '登记人员比例',
			type : 'pie',
			radius : [ '60%', '90%' ],
			center : [ '12%', '50%' ],
			hoverAnimation : false,
			itemStyle : {
				normal : {
					label : {
						show : false
					},
					labelLine : {
						show : false
					}
				},
				emphasis : {
					label : {
						show : false,
						position : 'left',
						textStyle : {
							fontSize : '30',
							fontWeight : 'bold',
							color : '#FFFFFF'
						}
					}
				}
			},
			data : [ {
				value : signPeople,
				name : '已登记人员'
			}, {
				value : stranger,
				name : '未登记人员'
			} ]
		} ]
	}
	obj.setOption(option);
}

function oldNewRatioEchartInit() {
	var obj = echarts.init(document.getElementById("oldNew_ratio"));
	var option = {
		legend : {
			orient : 'horizontal',
			x : 'right',
			y : 'center',
			left : '70%',
			width : '1.7rem',
			height : '1.7rem',
			itemGap : 38,
			formatter : function(name) {
				if (name == '新客') {
					return name + '  ' + newCust + '人';
				} else if (name == '老客') {
					return name + '  ' + oldCust + '人';
				}

			},
			data : [ {
				icon : 'circle',
				name : '新客',
				textStyle : {
					color : '#FFFFFF'
				}

			}, {
				icon : 'circle',
				name : '老客',
				textStyle : {
					color : '#FFFFFF'
				}
			} ]
		},
		color : [ '#FDF29C', '#75BC73' ],
		series : [ {
			name : '新老客户比例',
			type : 'pie',
			radius : [ '60%', '90%' ],
			center : [ '50%', '50%' ],
			hoverAnimation : false,
			itemStyle : {
				normal : {
					label : {
						show : false
					},
					labelLine : {
						show : false
					}
				},
				emphasis : {
					label : {
						show : false,
						position : 'left',
						textStyle : {
							fontSize : '30',
							fontWeight : 'bold',
							color : '#FFFFFF'
						}
					}
				}
			},
			data : [ {
				value : newCust,
				name : '新客'
			}, {
				value : oldCust,
				name : '老客'
			} ]
		} ]
	}
	obj.setOption(option);
}

//option.series[i].label.normal.show="true";

function alarmRed(flag,projectCode,data,qList,maxCode,option){
	if(flag == 1){
		for (var i = 0; i < data.length; i++) {
			for(var s = 0;s<projectCode.length;s++){
				if(data[i].value == projectCode[s]){
					option.series[i].itemStyle.normal.color="red";
				}
				if(data[i].value == maxCode){
					// 把地图点变大
					option.series[i].symbolSize="30";
					option.series[i].label.normal.show="true";
				}
			}
		}
	}else if(flag == 2){
		for (var i = 0; i < data.length; i++) {
			if(data[i].value == projectCode){
				var color = option.series[i].itemStyle.normal.color;
				if(color == "red"){
					
				}else{
					option.series[i].itemStyle.normal.color="#00BFA5";
				}
			}
			if(maxCode != ""){
				if(data[i].value == maxCode){
					// 把地图点变大
					option.series[i].symbolSize="30";
					option.series[i].label.normal.show="true";
				}
			}
		}
	}
	if(qList != "" && qList != undefined){
		for (var i = 0; i < data.length; i++) {
			for(var s = 0;s<qList.length;s++){
				if(data[i].value == qList[s]){
					option.series[i].itemStyle.normal.color="red";
				}
			}
		}
	}
	if(flag == 3){
		for (var i = 0; i < data.length; i++) {
			if(data[i].value == projectCode){
				// 把地图点变大
				option.series[i].symbolSize="30";
				option.series[i].label.normal.show="true";
			}
		}
	}
	if(flag == 4 && qList != "" && qList != undefined){
		for (var i = 0; i < data.length; i++) {
			for(var s = 0;s<qList.length;s++){
				if(data[i].value == qList[s]){
					option.series[i].itemStyle.normal.color="red";
				}
			}
			if(data[i].value == projectCode){
				// 把地图点变大
				option.series[i].symbolSize="30";
				option.series[i].label.normal.show="true";
			}
		}
	}
}


function initGroupMap(flag,projectCode,qList,maxCode) {
	chartsJsObj = echarts.init(document.getElementById("groupMap"));
	var option = {
	  		backgroundColor : '#404a59',
	  		tooltip : {
	  			backgroundColor: '#1B212A',
	  			position: function (point, params, dom, rect, size) {
	  			      // 固定在顶部
	  			      return [point[0]-35,point[1]-50];
	  			 },
	  			backgroundColor: 'rgba(0,0,0,0.2)',
	  			trigger : 'item',
	  		    textStyle : {
	  	            color: '#D6D6D6',
	  	            decoration: 'none',
	  	            fontSize: 15,
	  	            fontWeight: 'bold'
	  	        },
	  		    formatter: function (params, ticket, callback) {
                     console.log(params)
                     var relVal = params.name+"<br/>";
                     return relVal;
                 }
	  		},
	  		geo : {
	  			map : 'china',
	  			label : {
	  				emphasis : {
	  					show : false
	  				}
	  			},
	  			scaleLimit :{
	  				min:0.8
	  			},
	  			roam : true,
	  			itemStyle : {
	  				normal : {
	  					areaColor : '#323c48',
	  					borderColor : '#111'
	  				},
	  				emphasis : {
	  					areaColor : '#2a333d'
	  				}
	  			}
	  		},
	  		series : []
	  	};
	
	
	var geoCoordMap = {};
	// 获取项目和编码
	var datas = new Array();
	
	var convertData = function(datas) {
		var res = [];
			var geoCoord = geoCoordMap[datas.name];
			if (geoCoord) {
				res.push({
					name : datas.name,
					value : geoCoord.concat(datas.value)
				});
			}

		return res;
	};
	
	$.ajax({
		type: "get",
		url: ctx + "/system/homePageOrganize/getProjectData?keyword="+"",
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null && data.length > 0) {
				var i=0;
				var x =118;
				var y =105258;
				var xx = 28;
				var yy =275812;
				$(eval(data)).each(function(){
					var color = '#00BFA5';
					x=x+1;
					y=y+1;
					xx=xx+1;
					yy=yy+1;
					var xy = x+"."+y;
					var xxyy = xx+"."+yy;
					if(datas != ""){
						i=i+1;
					}
					var objs = new Object(); 
					var objgeo = new Object(); 
					var projectName = this.projectName;
					var projectCode = this.projectCode;
					objs.name = projectName;
					objs.value = projectCode;
					datas.push(objs);
					if(this.longitude != undefined && this.longitude != null){
						$(geoCoordMap).attr(projectName,[ this.longitude, this.latitude ]);
					}else{
						$(geoCoordMap).attr(projectName,[ xy, xxyy ]);
					}
					if(this.isAbnormal == 1){
						color = "red";
					}
					var seriestList ={
								name : projectName,
								type : 'effectScatter',
								coordinateSystem : 'geo',
								data : convertData(datas[i]),
								symbolSize : function(val) {
									return 10;
								},
								showEffectOn : 'render',
								rippleEffect : {
									brushType : 'stroke'
								},
								hoverAnimation : true,
								label : {
									normal : {
										formatter : '{b}',
										position : 'right',
										show : false
									}
								},
								itemStyle : {
									normal : {
										color : color,
										shadowBlur : 10,
										shadowColor : '#333'
									}
								},
								zlevel : 1
							};
					option.series.push(seriestList);
				});
			}
		},
		error: function(req, error, errObj) {
		}
	});
	alarmRed(flag,projectCode,datas,qList,maxCode,option);
	chartsJsObj.setOption(option);
}

function groupChartsClickEnventInit(){
chartsJsObj.on('click', function (params) {
			if(params.data){
				var data = params.data.value;
				// 获取到项目编码
				var projectCode = data[2];
				if(loginName == "xzgj03" && this.projectCode != "XIZIGUOJI")
				{
					return true;
				}
				
					$.ajax({
						type: "get",
						url: ctx + "/projectPage/toProjectPage?projectCode="+projectCode,
						contentType: "application/json;charset=utf-8",
						success: function(data) {
							if(data && data.code == 0) {
								var projectId = data.data.projectId;
								disconnect();
								window.open(ctx + "/main?projectCode="+projectCode+"&projectId="+projectId);
							} else {
								console.log("设置登录信息发生错误!");
							}
						},
						error: function(req, error, errObj) {
							console.log("设置登录信息发生错误!");
						}
					});
				}
		});
}


// 投屏页面地图点位
function initGroupMapDisplay(flag,projectCode,qList,maxCode) {
	chartsJsObj = echarts.init(document.getElementById("groupMapDisplay"));
	var option = {
			backgroundColor:'linear-gradient(-180deg,  rgba(30,48,95,0.9), rgba(28,54,111,0.9))',
	  		tooltip : {
	  			backgroundColor: '#1B212A',
	  			position: function (point, params, dom, rect, size) {
	  			      // 固定在顶部
	  			      return [point[0]-35,point[1]-50];
	  			 },
	  			backgroundColor: 'rgba(0,0,0,0.2)',
	  			trigger : 'item',
	  		    textStyle : {
	  	            color: '#D6D6D6',
	  	            decoration: 'none',
	  	            fontSize: 15,
	  	            fontWeight: 'bold'
	  	        },
	  		    formatter: function (params, ticket, callback) {
                     console.log(params)
                     var relVal = params.name+"<br/>";
                     return relVal;
                 }
	  		},
	  		geo : {
	  			map : 'china',
	  			label : {
	  				emphasis : {
	  					show : false
	  				}
	  			},
	  			scaleLimit :{
	  				min:0.8
	  			},
	  			roam : true,
	  			itemStyle : {
	  				normal : {
	  					areaColor : 'rgba(30,45,85,0.9)',
	  					borderColor : '#111'
	  				},
	  				emphasis : {
	  					areaColor : 'rgba(15,28,65,0.86)'
	  				}
	  			}
	  		},
	  		series : []
	  	};
	
	
	var geoCoordMap = {};
	// 获取项目和编码
	var datas = new Array();
	
	var convertData = function(datas) {
		var res = [];
			var geoCoord = geoCoordMap[datas.name];
			if (geoCoord) {
				res.push({
					name : datas.name,
					value : geoCoord.concat(datas.value)
				});
			}

		return res;
	};
	
	$.ajax({
		type: "get",
		url: ctx + "/system/homePageOrganize/getProjectDataScreen?keyword="+"",
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null && data.length > 0) {
				var i=0;
				var x =118;
				var y =105258;
				var xx = 28;
				var yy =275812;
				$(eval(data)).each(function(){
					projectTotal = projectTotal+1;
					var color = '#00BFA5';
					var isOpen = this.isProjectOpen;
					x=x+1;
					y=y+1;
					xx=xx+1;
					yy=yy+1;
					var xy = x+"."+y;
					var xxyy = xx+"."+yy;
					if(datas != ""){
						i=i+1;
					}
					var objs = new Object(); 
					var objgeo = new Object(); 
					var projectName = this.projectName;
					var projectCode = this.projectCode;
					objs.name = projectName;
					objs.value = projectCode;
					datas.push(objs);
					if(this.longitude != undefined && this.longitude != null){
						$(geoCoordMap).attr(projectName,[ this.longitude, this.latitude ]);
					}else{
						$(geoCoordMap).attr(projectName,[ xy, xxyy ]);
					}
					if(this.isAbnormal == 1){
						color = "red";
					}
					if(isOpen == "0"){
						var seriestList ={
								name : projectName,
								type : 'scatter',
								coordinateSystem : 'geo',
								data : convertData(datas[i]),
								symbolSize : function(val) {
									return 7;
								},
								showEffectOn : 'render',
								rippleEffect : {
									brushType : 'stroke'
								},
								hoverAnimation : true,
								label : {
									normal : {
										formatter : '{b}',
										position : 'right',
										show : false
									}
								},
								itemStyle : {
									normal : {
										color : color,
										shadowBlur : 10,
										shadowColor : '#333'
									}
								},
								zlevel : 1
							};
					}else{
						projectOpenNum = projectOpenNum+1;
						var seriestList ={
								name : projectName,
								type : 'effectScatter',
								coordinateSystem : 'geo',
								data : convertData(datas[i]),
								symbolSize : function(val) {
									return 10;
								},
								showEffectOn : 'render',
								rippleEffect : {
									brushType : 'stroke'
								},
								hoverAnimation : true,
								label : {
									normal : {
										formatter : '{b}',
										position : 'right',
										show : false
									}
								},
								itemStyle : {
									normal : {
										color : color,
										shadowBlur : 10,
										shadowColor : '#333'
									}
								},
								zlevel : 1
							};
					}
					option.series.push(seriestList);
				});
			}
		},
		error: function(req, error, errObj) {
		}
	});
	alarmRed(flag,projectCode,datas,qList,maxCode,option);
	chartsJsObj.setOption(option);
	var o = document.getElementById("project_item");
	o.style.width = ((projectOpenNum/projectTotal)*314)+ 'px';
	$("project_item").innerHTML = o.style.width;
	var toNum = (projectOpenNum/projectTotal)*100;
	if(toNum<1){
		toNum = 1;
	}else{
		toNum = Math.round(toNum);
	}
	$("#project_proportion").html("已接入"+toNum+"%项目");
}



