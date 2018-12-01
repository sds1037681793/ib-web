/**
 * 
 */
var comm = null;
//卡检测id；
var intervalId;

var isCom = false;
function cardRead(cardType,cardCheckType){
	closeCard();
	if(!isCom){
		comm.OpenCard();
	}
	intervalId = setInterval("cardCheck('"+cardType+"','"+cardCheckType+"')",1400);
}
function initNetwork(ip,port){
	if(ip && ip.lengh != 0 && port && port.length != 0){
		var result = initTcpIp(ip,port);
		if(result == 0){
			isCom = false;
		}
		return result;
	}
	else{
		var result = initCom();
		if(result == 0){
			isCom = true;
		}
		return result;
	}
}

function initTcpIp(ip,port){
	var result = -1;
	if(comm && comm != null){
		result = comm.InitNetwork(ip, port);
	}
	return result;
}

function initCom(){
	var result = -1;
	if(comm && comm != null){
		result = comm.InitCom();
	}
	return result;
}

function sendSound(){
	if(isCom){
		var result = comm.sendSoundExt();
	}else{
		var result = comm.sendSound();
	}
}

function isExistcard(cardType){
	var result;
	if(cardType == 'IC'){
		if(isCom){
			result = comm.ReadICCardExt();
			//console.log("COM:" + result);
		}else{
			result = comm.ReadICCard();
			//console.log("TCP:" + result);
		}
		
	}else{
		if(isCom){
			result = comm.ReadIDCardExt();
		}else{
			result = comm.ReadIDCard();
		}
	}
	//console.log(result != '');
	if(result != ''){
		return true;
	}
	else{
		return false;
	}
}

function cardCheck(cardType,cardCheckType){
	var result;
	if(cardType == 'IC'){
		if(isCom){
			result = comm.ReadICCardExt();
			//console.log("COM:" + result);
		}else{
			result = comm.ReadICCard();
			//console.log("TCP:" + result);
		}
		
	}else{
		if(isCom){
			result = comm.ReadIDCardExt();
		}else{
			result = comm.ReadIDCard();
		}
	}
	if(result != ''){
		sendSound();
		var param = result.split("|");
		var info = {};
		//时租卡
		if(param[0] == "2c" || param[0] == "2d" || param[0] == "2e" || param[0] == "2f"){
			info.cardType = param[0];
			info.cardNo = param[1];
			info.strCarPosition = param[2];
			info.strEntranceTime = param[3];
			info.licensePlate = param[4];
			//门禁卡信息
			if(param[5] != "ff"){
				info.accessCardType = param[5];
				info.accessCardNo = param[6];
				info.accessValidDate = param[7];
				info.accessExpireDate = param[8];
				info.accessPassword = param[9];
			}
		}
		//月租卡
		if(param[0] == "24" || param[0] == "25" || param[0] == "26" || param[0] == "27"){
			info.cardType = param[0];
			info.cardNo = param[1];
			info.expireDate = param[2];
			info.licensePlate = param[3];
			info.strCarPosition = param[4];
			info.strEntranceTime = param[5];
			info.effectiveDate = param[6];
			//门禁卡信息
			if(param[7] != "ff"){
				info.accessCardType = param[7];
				info.accessCardNo = param[8];
				info.accessValidDate = param[9];
				info.accessExpireDate = param[10];
				info.accessPassword = param[11];
			}
		}
		//储值卡
		if(param[0] == "28" || param[0] == "29" || param[0] == "2a" || param[0] == "2b"){
			info.cardType = param[0];
			info.cardNo = param[1];
			info.licensePlate = param[2];
			info.strCarPosition = param[3];
			info.strEntranceTime = param[4];
			info.cardBalance = param[5];
			//门禁卡信息
			if(param[6] != "ff"){
				info.accessCardType = param[6];
				info.accessCardNo = param[7];
				info.accessValidDate = param[8];
				info.accessExpireDate = param[9];
				info.accessPassword = param[10];
			}
		}
		//贵宾卡
		if(param[0] == "22" || param[0] == "23"){
			info.cardType = param[0];
			info.cardNo = param[1];
			info.expireDate = param[2];
			info.licensePlate = param[3];
			info.strCarPosition = param[4];
			info.strEntranceTime = param[5];
			info.effectiveDate = param[6];
			//门禁卡信息
			if(param[7] != "ff"){
				info.accessCardType = param[7];
				info.accessCardNo = param[8];
				info.accessValidDate = param[9];
				info.accessExpireDate = param[10];
				info.accessPassword = param[11];
			}
		}
		//ID卡
		if(param[0] == "c"){
			info.cardNo = param[1];
			if(param[2] !="ff"){
				info.accessCardType = param[2];
				info.accessCardNo = param[3];
				info.accessValidDate = param[4];
				info.accessExpireDate = param[5];
				info.accessPassword = param[6];
			}
		}
		if(param[0] == "ff"){
			info.cardType = param[0];
			info.cardNo = param[1];
			//门禁卡
			if(param[2] !="ff"){
				info.accessCardType = param[2];
				info.accessCardNo = param[3];
				info.accessValidDate = param[4];
				info.accessExpireDate = param[5];
				info.accessPassword = param[6];
			} else if (param[2] =="ff") {
				info.accessCardType = param[2];
				info.accessCardNo = param[3];
			}
		}
		//门禁卡信息
		info.accessCardNo
		info.errorCode = 0;
		displayCardInfo(info,cardCheckType);
	}
}
function releaseNetwork(){
	if(isCom){
		if(comm && comm.CloseCom){
			comm.CloseCom()
		}
	}
	else{
		if(comm && comm.CloseCard){
			comm.CloseCard();
			comm.ReleaseNetWork();
		}
	}
}
function closeCard(){
	if(intervalId && intervalId != undefined && intervalId != null){
		clearInterval(intervalId);
	}
}
function writeICCard(data){
	var result = -1;
	if(isCom){
		result = comm.writeICCardExt(data);
		if(result == 0){
			comm.sendSoundExt();
		}
	}else{
		var ret = comm.OpenCard();
		result = comm.writeICCard(data);
		if(result == 0){
			comm.sendSound();
			comm.CloseCard();
		}
	}
	return result;
}
function writeAccessICCard(data){
	var result = -1;
	if(isCom){
		result = comm.WriteAccessICCardExt(data);
		if(result == 0){
			comm.sendSoundExt();
		}
	}else{
		var ret = comm.OpenCard();
		result = comm.WriteAccessICCard(data);
		if(result == 0){
			comm.sendSound();
			comm.CloseCard();
		}
	}
	return result;
}