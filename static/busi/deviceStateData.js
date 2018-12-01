
// 子系统调用过来的编码，事先定义好； normalCount=正常数  ；abnormalCount=异常数
function deviceStateData(systemCode,normalCount,abnormalCount){
	if(times == 1){
		setTimeout("deviceStateData('" + systemCode + "','" + normalCount + "','" + abnormalCount + "')", 1000);
	}
	if(isNaN(normalCount)){
		normalCount = 0;
	}
	if(isNaN(abnormalCount)){
		abnormalCount = 0;
	}
	if(0>normalCount){
		normalCount = 0;
	}
	if(0>abnormalCount){
		abnormalCount = 0;
	}
	if(normalCount == undefined){
		normalCount = 0;
	}
	if(abnormalCount == undefined){
		abnormalCount = 0;
	}
	abnormalCount = parseInt(abnormalCount);
	normalCount = parseInt(normalCount);
	var time =getNowFormatDate();
	console.info("系统："+systemCode+"正常数："+normalCount+"异常数："+abnormalCount+"--------时间："+time);
	/**
	 * FIRE_FIGHTING 消防
	 * POWER_SUPPLY 供配电
	 * ELEVATOR 电梯
	 * PARKING 停车场
	 * ACCESS_CONTROL 人行出入
	 * HVAC 暖通
	 * SUPPLY_DRAIN 给排水
	 * VIDEO_MORNITORING 监控相机
	 */
	if(systemCode == "FIRE_FIGHTING"){
		hostFlag = true;
		// 正常
		normal = normal - hostNormal;
		normal = normal + normalCount;
		hostNormal = normalCount;
		// 异常
		abnormal = abnormal - hostAbnormal;
		abnormal = abnormal + abnormalCount;
		hostAbnormal = abnormalCount;
		// 判断所有的flag是不是
		if(hostFlag && electricFlag && elevatorFlag && peopleFlag && havcFlag && waterFlag && cameraFlag){
			deviceStateDatas(normal,abnormal);
		}
	}else if(systemCode == "POWER_SUPPLY"){
		electricFlag = true;
		// 正常
		normal = normal - electricNormal;
		normal = normal + normalCount;
		electricNormal = normalCount;
		// 异常
		abnormal = abnormal - electricAbnormal;
		abnormal = abnormal + abnormalCount;
		electricAbnormal = abnormalCount;
		// 判断所有的flag是不是
		if(hostFlag && electricFlag && elevatorFlag && peopleFlag && havcFlag && waterFlag && cameraFlag){
			deviceStateDatas(normal,abnormal);
		}
	}else if(systemCode == "ELEVATOR"){
		elevatorFlag = true;
		// 正常
		normal = normal - elevatorNormal;
		normal = normal + normalCount;
		elevatorNormal = normalCount;
		// 异常
		abnormal = abnormal - elevatorAbnormal;
		abnormal = abnormal + abnormalCount;
		elevatorAbnormal = abnormalCount;
		// 判断所有的flag是不是
		if(hostFlag && electricFlag && elevatorFlag && peopleFlag && havcFlag && waterFlag && cameraFlag){
			deviceStateDatas(normal,abnormal);
		}
	}else if(systemCode == "PARKING"){
		vehicleFlag = true;
		// 正常
		normal = normal - vehicleNormal;
		normal = normal + normalCount;
		vehicleNormal = normalCount;
		// 异常
		abnormal = abnormal - vehicleAbnormal;
		abnormal = abnormal + abnormalCount;
		vehicleAbnormal = abnormalCount;
		// 判断所有的flag是不是
		if(hostFlag && electricFlag && elevatorFlag && peopleFlag && havcFlag && waterFlag && cameraFlag){
			deviceStateDatas(normal,abnormal);
		}
	}else if(systemCode == "ACCESS_CONTROL"){
		peopleFlag = true;
		// 正常
		normal = normal - peopleNormal;
		normal = normal + normalCount;
		peopleNormal = normalCount;
		// 异常
		abnormal = abnormal - peopleAbnormal;
		abnormal = abnormal + abnormalCount;
		peopleAbnormal = abnormalCount;
		// 判断所有的flag是不是
		if(hostFlag && electricFlag && elevatorFlag && peopleFlag && havcFlag && waterFlag && cameraFlag){
			deviceStateDatas(normal,abnormal);
		}
	}else if(systemCode == "HVAC"){
		havcFlag = true;
		// 正常
		normal = normal - havcNormal;
		normal = normal + normalCount;
		havcNormal = normalCount;
		// 异常
		abnormal = abnormal - havcAbnormal;
		abnormal = abnormal + abnormalCount;
		havcAbnormal = abnormalCount;
		// 判断所有的flag是不是
		if(hostFlag && electricFlag && elevatorFlag && peopleFlag && havcFlag && waterFlag && cameraFlag){
			deviceStateDatas(normal,abnormal);
		}
	}else if(systemCode == "SUPPLY_DRAIN"){
		waterFlag = true;
		// 正常
		normal = normal - waterNormal;
		normal = normal + normalCount;
		waterNormal = normalCount;
		// 异常
		abnormal = abnormal - waterAbnormal;
		abnormal = abnormal + abnormalCount;
		waterAbnormal = abnormalCount;
		// 判断所有的flag是不是
		if(hostFlag && electricFlag && elevatorFlag && peopleFlag && havcFlag && waterFlag && cameraFlag){
			deviceStateDatas(normal,abnormal);
		}
	}else if(systemCode == "VIDEO_MORNITORING"){
		cameraFlag = true;
		// 正常
		normal = normal - cameraNormal;
		normal = normal + normalCount;
		cameraNormal = normalCount;
		// 异常
		abnormal = abnormal - cameraAbnormal;
		abnormal = abnormal + abnormalCount;
		cameraAbnormal = abnormalCount;
		// 判断所有的flag是不是
		if(hostFlag && electricFlag && elevatorFlag && peopleFlag && havcFlag && waterFlag && cameraFlag){
			deviceStateDatas(normal,abnormal);
		}
	}
	
}

function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    return currentdate;
}

function deviceStateDatas(normals,abnormals){
times = 1;
var obj = echarts.init(document.getElementById("deviceState"));
var	option = {
	  		title : {
	  	        text: '',
	  	        top:30,
	  	        right:'center',
	  	        x:'center'
	  	    },
	    tooltip: {
	        trigger: 'item',
	        formatter:function(obj){
	          	  return "正常:"+obj.percent.toFixed(1) + '%';
	            }
	    },
	    color:["#00BFA5", "#F4CC8A"], 
	    legend: {
	        orient: 'vertical',
	        x: "60%",
			y: "13%",
			itemGap:40,
	        itemWidth: 12,
			itemHeight: 12,
	        data:['正常','异常'],
	        textStyle: {
	            color: '#979797'
	          }
	    },
	    series: [
	        {
	            name:'设备异常正常比例',
	            type:'pie',
	            radius: ["72%", "99%"],
	 	        center : ["28%","50%"],
	            avoidLabelOverlap:false,
	            hoverAnimation : false,
	            label: {
	                normal: {
	                    show: false,
	                    position: 'center',
	                    textStyle: {
	 		              color: '#979797',
	 		              fontSize: 12
	 		            }    
	                },
	                emphasis: {
	                    show: false
	                }
	            },
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            itemStyle:{
	 		          normal:{ 
	                   label:{ 
	                     show: false, 
	                     formatter: "{d}%"  
	                    }
	               } 
	             },
	            data:[
	                {value:normals, name:'正常',label: {
	                    normal: {
	                        show: true,
	                        position: 'center',
	                        fontSize:20,
	                        fontWeight: 'bold',
	                        formatter:function(obj){
	                      	  return obj.percent.toFixed(1) + '%';
	                        }
	              },
	              emphasis: {
	                        show: true,
	                        textStyle: {
	                         fontSize: 20
	                        }
	              }
	              }},
	                {value:abnormals, name:'异常'}
	            ]
	        }
	    ]
	};
	var seriest = option.series.length;
	console.info("集合里饼图的数量====="+seriest);
	if(seriest > 1){
		console.info("饼图大于1则走这里,不继续执行下去====="+option);
		console.info(option);
		times = 0;
		return;
	}else{
		if(seriest > 1){
			console.info("饼图大于1则走这里,不继续执行下去====="+option);
			console.info(option);
			times = 0;
			return;
		}else{
			console.info(option);
			obj.setOption(option);
			console.info(obj);
			console.info(obj.id);
		}
	}
	times = 0;
}