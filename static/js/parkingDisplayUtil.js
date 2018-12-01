/**
 * 所有对显示频处理方法
 */
var elementId;


function setting()
{
   var deviceName = "ParkingDisplay";
   var baurate = 4800;
   var bytesize = 8;
   var parity = 0;
   var stopbits = 0;
   var comm = document.getElementById(elementId);
   var commName = document.getElementById("comName").value;
   var result = comm.SetComName(deviceName, commName, baurate, bytesize, parity, stopbits);
   alert(result);
}

//设置com组建元素id，在做任何处理前先设置
function setComm(srcId){
	elementId = srcId;
}

//初始化
function init(){
	var comm = 	document.getElementById(elementId);
	var result = comm.InitCom();
	return result;
}

//关闭
function close(){
	var comm = 	document.getElementById(elementId);
	var result = comm.CloseCom();
	return result;
}

//读取机号
function readDeviceNoExt(){
	var comm = document.getElementById(elementId);
	var result = comm.readDeviceNoExt();
	return result;
}

//设置机号
function setDeviceNoExt(oldNo,newNo){
	var comm = document.getElementById(elementId);
	var data = oldNo + "|" + newNo;
	var result = comm.setDeviceNoExt(data);
	return result;
}

function loadTime(machineNo,date){
	var comm = document.getElementById(elementId);
	var data = machineNo + "|" + date;
	var result = comm.LoadTime(data);
	return result;
}

//读取时间  响应数据的格式:日期|星期
function readTimeExt(machineNo){
	var comm = document.getElementById(elementId);
	var result = comm.ReadTimeExt(machineNo);
	return result;
}

//初始化显示频
function initDisplayExt(machineNo){
	var comm = document.getElementById(elementId);
	var result = comm.InitDisplayExt(machineNo);
	return result;
}

//加载剩余车位数
function loadRemainParkingSpaces(machineNo,remainParkingSpaces){
	var comm = document.getElementById(elementId);
	var data = machineNo + "|" + remainParkingSpaces;
	var result = comm.loadRemainParkingSpacesExt(data);
	return result;
}

//设置显示屏显示样式
/************************************************************************/
/* 
说明：显示字段1个字节有8位组成，其中只能1位为‘1’，为‘1’的那位对应字段被选中，每位对应格式如下：（D7  D6  D5  D4  D3  D2  D1  D0） 
D7：显示“剩余车位XXXX个”80
D6：显示“总剩余车位XXXX个”40
D5：显示“本区剩余车位XXXX个”20
D4：显示“现时12：00   剩余车位XXXX个” ，其中12：00为时间（时：分） 10
D3：显示“显示12：00   总剩余车位XXXX个” 08
D2：显示“显示12：00   本区剩余车位XXXX个”04
D1：显示“加载信息（64 byte）+ XXXX个” 02
D0：显示其它信息，选择此选项时，显示屏将不显示剩余车位，而显示加载的公共信息 01
D0->01  D1->02  D2->04  D3->08  D4->10  D5->20  D6->40  D7->80                                                                 */
/************************************************************************/
function loadRemainParkingSpaceDisplayField(machineNo,displayField){
	var comm = document.getElementById(elementId);
	var data = machineNo + "|" + displayField;
	var result = comm.loadRemainParkingSpaceDisplayFieldExt(data);
	return result;
}

//读取显示屏显示样式
function readSelectDisplayField(machineNo){
	var comm = document.getElementById(elementId);
	var result = comm.readSelectDisplayFieldExt(machineNo);
	return result;
}

//设置显示屏移动速度，只有0和1的选择
function loadDisplayMoveSpeed(machineNo,speed){
	var comm = document.getElementById(elementId);
	var data = machineNo + "|" + speed;
	var result = comm.loadDisplayMoveSpeedExt(data);
	return result;
}

function loadDisplayMode(machineNo,displayMode){
	var comm = document.getElementById(elementId);
	var data = machineNo + "|" + displayMode;
	var result = comm.loadDisplayModeExt(data);
	return result;
}

function loadDisplayContent(machineNo,content){
	var comm = document.getElementById(elementId);
	var data = machineNo + "|" + content;
	var result = comm.loadDisplayContentExt(data);
	return result;
}

function loadOtherContent(machineNo,otherContent){
	var comm = document.getElementById(elementId);
	var data = machineNo + "|" + otherContent;
	var result = comm.loadOtherContentExt(data);
	return result;
}

function displayComeInParkingSapces(machineNo,comeInParkingSapces){
	var comm = document.getElementById(elementId);
	var data = machineNo + "|" + comeInParkingSapces;
	var result = comm.displayComeInParkingSapcesExt(data);
	return result;
}

function displayGetOutParkingSapces(machineNo,getOutParkingSapces){
	var comm = document.getElementById(elementId);
	var data = machineNo + "|" + getOutParkingSapces;
	var result = comm.displayGetOutParkingSapcesExt(data);
	return result;
}

function displayHint(machineNo){
	var comm = document.getElementById(elementId);
	var result = comm.displayHintExt(machineNo);
	return result;
}