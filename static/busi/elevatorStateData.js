
//集团首页饼图所需电梯正常异常数据
function elevatorStateDatas(){
	var typeCode="ELEVATOR";
	var projectId=0;
	$.ajax({
		type : "post",
		url : ctx + "/elevator/elevatorProjectPage/queryElevatorState?typeCode=" +typeCode + "&projectId=" + projectId,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				var returnVal = data.RETURN_PARAM;
					normals = returnVal.normalElevators;
					abnormals = returnVal.abnormalElevators;
					deviceStateData(typeCode,normals,abnormals);
					flushElevator = setTimeout("elevatorStateDatas()",60000);

			}else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
			var normals=normals;
			var abnormals=abnormals;
		}
	});
var obj = echarts.init(document.getElementById("elevator_group"));
var	option = {
	  		title : {
	  	        text: '',
	  	        top:30,
	  	        right:'center',
	  	        x:'center'
	  	    },
	    tooltip: {
	        trigger: 'item',
	        formatter: "{a} <br/>{b}:{c}({d}%)"
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
                    	  return obj.percent.toFixed(1)+ '%';
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
	obj.setOption(option);
}