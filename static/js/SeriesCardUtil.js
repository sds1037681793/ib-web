/**
 * 
 */
var resultMark = 0;
var intervalId;
var strls = "";
var errorno = "";
var BLOCK0_EN = 0x01;//读第一块的(16个字节)
var BLOCK1_EN = 0x02;//读第二块的(16个字节)
var BLOCK2_EN = 0x04;//读第四块的(16个字节)
var NEEDSERIAL = 0x08;//仅读指定序列号的卡
var EXTERNKEY = 0x10;//用明码认证密码,产品开发完成后，建议把密码放到设备的只写区，然后用该区的密码后台认证，这样谁都不知道密码是多少，需要这方面支持请联系
var NEEDHALT = 0x20;//读/写完卡后立即休眠该卡，相当于这张卡不在感应区。要相重新操作该卡必要拿开卡再放上去
var myctrlword = 0;
var myareano = 0;
var authmode = 0;
var mypiccserial = "";

var mypicckey = ""; 
var piccdata0_2 = ""; 
//蜂鸣器发声音
function beep()
{
	
	IcCardReader.pcdbeep(100);//100表示响100毫秒
	 
}
//读卡
function SeriesReadcard()
{
	//指定控制字
	myctrlword=BLOCK0_EN + BLOCK1_EN + BLOCK2_EN + EXTERNKEY;
	//指定区号
	myareano = 8; //指定为第8区
	//批定密码模式
	authmode = 1; //大于0表示用A密码认证，推荐用A密码认证
	
	//指定序列号，未知卡序列号时可指定为8个0
	mypiccserial="00000000";

	//指定密码，以下密码为厂家出厂密码
	mypicckey = "ffffffffffff";
	
	var initCardNo = "";
	var info = {};
	strls=IcCardReader.piccreadex(myctrlword, mypiccserial,myareano,authmode,mypicckey);
	errorno = strls.substr(0,4);
	switch(errorno)
	{
		case "ER08":
			//alert("寻不到卡");
			resultMark = 2;
			info.errorCode = 1;
			break;	
		case "ER09":
			//alert("寻不到卡");
			resultMark = 2;
			info.errorCode = 1;
			break;	
		case "ER10":
			//alert("寻不到卡");
			resultMark = 2;
			info.errorCode = 1;
			break;	

		/*case "ER11":
			CardIDShower.value = "密码认证错误\r\n";
			CardIDShower.value = CardIDShower.value + strls + "\r\n";
			CardIDShower.value = CardIDShower.value + "其中错误号为：" + errorno + "\r\n";
			CardIDShower.value = CardIDShower.value + "卡十六进制序列号为：" + strls.substr(5,8) + "\r\n";
			resultMark = -1;
			info.errorCode = 2;
			break;	
		case "ER12":
			CardIDShower.value = "密码认证错误" + "\r\n";
			CardIDShower.value = CardIDShower.value + strls + "\r\n";
			CardIDShower.value = CardIDShower.value + "其中错误号为：" + errorno + "\r\n";
			CardIDShower.value = CardIDShower.value + "卡十六进制序列号为：" + strls.substr(5,8) + "\r\n";
			resultMark = -1;
			info.errorCode = 2;
			break;*/
		case "ER13":
			/*CardIDShower.value = "读卡错误" + "\r\n";
			CardIDShower.value = CardIDShower.value + strls + "\r\n";
			CardIDShower.value = CardIDShower.value + "其中错误号为：" + errorno + "\r\n";
			CardIDShower.value = CardIDShower.value + "卡十六进制序列号为：" + strls.substr(5,8) + "\r\n";*/
			resultMark = -1;
			info.errorCode = 3;
			break;	
			
		case "ER14":
			/*CardIDShower.value = "写卡错误" + "\r\n";
			CardIDShower.value = CardIDShower.value + strls + "\r\n";
			CardIDShower.value = CardIDShower.value + "其中错误号为：" + errorno + "\r\n";
			CardIDShower.value = CardIDShower.value + "卡十六进制序列号为：" + strls.substr(5,8) + "\r\n";*/
			resultMark = -1;
			info.errorCode = 4;
			break;
			
		case "ER21":
			resultMark = -1;
			info.errorCode = 5;
			break;
			
		case "ER22":
			resultMark = -1;
			info.errorCode = 5;
			//alert("动态库或驱动程序异常");
			break;	
		
		case "ER23":
			resultMark = -1;
			info.errorCode = 5;
			//alert("读卡器未插上或动态库或驱动程序异常");
			break;	
		case "ER24":
			resultMark = -1;
			info.errorCode = 5;
			//alert("操作超时，一般是动态库没有反应");
			break;	
		case "ER25":
			resultMark = -1;
			info.errorCode = 5;
			//alert("发送字数不够");	
			break;
		case "ER26":
			resultMark = -1;
			info.errorCode = 5;
			//alert("发送的CRC错");
			break;	
		case "ER27":
			resultMark = -1;
			info.errorCode = 5;
			//alert("接收的字数不够");
			break;	
		case "ER28":
			resultMark = -1;
			info.errorCode = 5;
			//alert("接收的CRC错");
			break;
		case "ER29":
			resultMark = -1;
			info.errorCode = 5;
			//alert("函数输入参数格式错误,请仔细查看"	);
			break;
		default :
			//读卡成功,其中ER00表示完全成功,ER01表示完全没读到卡数据，ER02表示仅读该卡的第一块成功,，ER02表示仅读该卡的第一二块成功，这是刷卡太快原因
			beep();
			resultMark = 1;
			info.errorCode = 0;
			initCardNo= strls.substr(5,8);
			info.cardNo = "00" + initCardNo.substr(6,2) + initCardNo.substr(4,2) + initCardNo.substr(2,2) + initCardNo.substr(0,2);
			break;
	}
	displaySeriesCardInfo(info,resultMark);
}
function SeriesCardCheck(){
	
	intervalId = setInterval("SeriesReadcard()",1400);
}
