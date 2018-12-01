/*<object id="POSOCX" classid="clsid:805EAF5C-AD0D-4013-B225-F37B4544FA4F"  width="0" height="0" align="center" hspace="0">
</object>*/
/*print("POSOCX","COM6",19200,"123456");*/
var POS_SUCCESS = 1001;
var POS_FAIL = 1002;//状态：失败
var POSOCX = null;
var comm = null; //通讯句柄
var nRet = null;
/*function print(POSOCXID,com,baudrate,content){
	
	POSOCX = document.getElementById(POSOCXID);
	//打开端口 com:端口，baudrate:波特率：如9600
	comm = posOpen(com,baudrate,POSOCX);
	//打印二维码
	if(comm == -1){
		return -1;
	}else{
		var nRet ;
		var strData = content;
		var dataLength = content.length;
		//打印位置
		nRet = POSOCX.POSSetMotionUnit(comm,0,203, 203);//默认是：g_hComm,nPortType,203, 203
		//Set character right space.
		nRet = POSOCX.POSSetRightSpacing(comm,0,8);//默认0
		//Set character line space.
		nRet = POSOCX.POSSetLineSpacing(comm,0,50);//默认24
		//Set Print Mode
		nRet = POSOCX.POSSetMode(comm,0,0);
		if(nRet != POS_SUCCESS)
		{
			form.statusResultName.value = "Set Print Mode unsuccessfully!";
			return;
		}
		nRet = POSOCX.POSSTextOut(comm,0,"测试停车场", 100, 2, 2, 1,0);
	  	nRet = POSOCX.POSFeedLine(comm,0);
		nRet = POSOCX.POSSBarcodeQR(comm,0,strData,130,10, 2, 0, dataLength); 
		if(nRet != POS_SUCCESS)
		{
			form.statusResultName.value = "Print QR unsuccessfully!";
			return;
		}
		POSOCX.POSFeedLine(comm,0);
		//打印位置
		//nRet = POSOCX.POSSetMotionUnit(comm,0,20, 20);
		//Set character right space.
		nRet = POSOCX.POSSetRightSpacing(comm,0,5);
		//Set character line space.
		nRet = POSOCX.POSSetLineSpacing(comm,0,24);
		nRet = POSOCX.POSSTextOut(comm,0,"商户名称：联华", 5, 2, 2, 1,0);
		nRet = POSOCX.POSFeedLine(comm,0	);
		nRet = POSOCX.POSSTextOut(comm,0,"优惠信息：2小时", 5, 1, 1, 1,0);
		nRet = POSOCX.POSFeedLine(comm,0);
		nRet = POSOCX.POSSTextOut(comm,0,"失效时间：2016-01-31 23:59:59", 5, 1, 1, 1,0);
		POSOCX.POSStartDuplexPrint(comm,0);
		// Cut paper
		nRet = POSOCX.POSCutPaper(comm,0,0,0);
		nRet = POSOCX.POSCutPaper(g_hComm,nPortType,POS_CUT_MODE_PARTIAL, 0);
		POSOCX.POSClose(comm,0);
	}
}*/
function print1(POSOCXID,comm,baudrate,content){
	var nRet ;
	POSOCX = document.getElementById(POSOCXID);
	comm = posOpen(comm,baudrate,POSOCX);
	if(comm == -1){
		return ;
		
	}
	
	
	var strData = content.get("QRCODE");
	var QrTitle = content.get("QrTitle");
	//var dataLength = content.length;
	//打印位置
	//nRet = POSOCX.POSSetMotionUnit(comm,0,203, 203);//默认是：g_hComm,nPortType,203, 203
	//Set character right space.
	nRet = POSOCX.POSSetRightSpacing(comm,0,8);//默认0
	//Set character line space.
	nRet = POSOCX.POSSetLineSpacing(comm,0,50);//默认24
	//Set Print Mode
	nRet = POSOCX.POSSetMode(comm,0,0);
	if(nRet != POS_SUCCESS)
	{
		//提示报错
		//form.statusResultName.value = "Set Print Mode unsuccessfully!";
		POSOCX.POSClose(comm,0);
		return nRet;
	}
	nRet = POSOCX.POSSTextOut(comm,0,QrTitle, 100, 2, 2, 1,0);
  	nRet = POSOCX.POSFeedLine(comm,0);
  	//打印二维码
  	printCode(comm,strData);
  	nRet = POSOCX.POSSetRightSpacing(comm,0,5);
  	nRet = POSOCX.POSFeedLine(comm,0);
  	nRet = POSOCX.POSSTextOut(comm,0,"商户名称："+content.get("merchantName"), 5, 1, 1, 1,0);
  	nRet = POSOCX.POSFeedLine(comm,0);
  	nRet = POSOCX.POSSTextOut(comm,0,"优惠信息:"+content.get("discountName"), 5, 1, 1, 1,0);
	nRet = POSOCX.POSFeedLine(comm,0);
	nRet = POSOCX.POSSTextOut(comm,0,"失效时间:"+content.get("expireDate"), 5, 1, 1, 1,0);
	nRet = POSOCX.POSFeedLine(comm,0);
	nRet = POSOCX.POSCutPaper(comm,0,0x42,0);
	nRet =POSOCX.POSClose(comm,0);
	return nRet;
}

//}
/******************************
Parameter:NULL
Description:
*******************************/
function posOpen(com,baudrate,POSOCX){
	if(null != POSOCX){
		return  POSOCX.POSOpen(com,baudrate,8,1,0,0);
		
	}else{
		//提示报错
		return POSOCX.POSClose(comm,0);
		
	}
}

function printCode(comm,strData,content) {
	var dataLength = strData.length;
	nRet = POSOCX.POSSBarcodeQR(comm,0,strData,130,10, 2, 0, dataLength); 
	if(nRet != POS_SUCCESS)
	{
		//提示报错
		POSOCX.POSClose(comm,0);
		return;
	}
	
	
} 
//写cookies

function setCookie(name,value,time){
	var oDate = new Date();
	oDate.setDate(oDate.getDate()+time);
	document.cookie = name+"="+value+";expires="+oDate;
	}


	function getCookie(name){
	var arr = document.cookie.split("; ");
	for(var i=0; i<arr.length; i++){
	var arr2 = arr[i].split("=");
	if(arr2[0] == name){
	return arr2[1];
	}
	}
	return "";
	}


	function removeCookie(name){
	setCookie(name,"",0)
	} 
	function getLodop(oOBJECT,oEMBED){
		/**************************
		  本函数根据浏览器类型决定采用哪个页面元素作为Lodop对象：
		  IE系列、IE内核系列的浏览器采用oOBJECT，
		  其它浏览器(Firefox系列、Chrome系列、Opera系列、Safari系列等)采用oEMBED,
		  如果页面没有相关对象元素，则新建一个或使用上次那个,避免重复生成。
		  64位浏览器指向64位的安装程序install_lodop64.exe。
		**************************/
		        var strHtmInstall="<br><font color='#FF00FF'>打印控件未安装!点击这里<a href='scripts/LODOP/install_lodop32.exe' target='_self'>执行安装</a>,安装后请刷新页面或重新进入。</font>";
		        var strHtmUpdate="<br><font color='#FF00FF'>打印控件需要升级!点击这里<a href='scripts/LODOP/install_lodop32.exe' target='_self'>执行升级</a>,升级后请重新进入。</font>";
		        var strHtm64_Install="<br><font color='#FF00FF'>打印控件未安装!点击这里<a href='scripts/LODOP/install_lodop64.exe' target='_self'>执行安装</a>,安装后请刷新页面或重新进入。</font>";
		        var strHtm64_Update="<br><font color='#FF00FF'>打印控件需要升级!点击这里<a href='scripts/LODOP/install_lodop64.exe' target='_self'>执行升级</a>,升级后请重新进入。</font>";
		        var strHtmFireFox="<br><br><font color='#FF00FF'>（注意：如曾安装过Lodop旧版附件npActiveXPLugin,请在【工具】->【附加组件】->【扩展】中先卸它）</font>";
		        var strHtmChrome="<br><br><font color='#FF00FF'>(如果此前正常，仅因浏览器升级或重安装而出问题，需重新执行以上安装）</font>";
		        var LODOP;		
			try{	
			     //=====判断浏览器类型:===============
			     var isIE	 = (navigator.userAgent.indexOf('MSIE')>=0) || (navigator.userAgent.indexOf('Trident')>=0);
			     var is64IE  = isIE && (navigator.userAgent.indexOf('x64')>=0);
			     //=====如果页面有Lodop就直接使用，没有则新建:==========
			     if (oOBJECT!=undefined || oEMBED!=undefined) { 
		               	 if (isIE) 
			             LODOP=oOBJECT; 
			         else 
			             LODOP=oEMBED;
			     } else { 
				 if (CreatedOKLodop7766==null){
		          	     LODOP=document.createElement("object"); 
				     LODOP.setAttribute("width",0); 
		                     LODOP.setAttribute("height",0); 
				     LODOP.setAttribute("style","position:absolute;left:0px;top:-100px;width:0px;height:0px;");  		     
		                     if (isIE) LODOP.setAttribute("classid","clsid:2105C259-1E0C-4534-8141-A753534CB4CA"); 
				     else LODOP.setAttribute("type","application/x-print-lodop");
				     document.documentElement.appendChild(LODOP); 
			             CreatedOKLodop7766=LODOP;		     
		 	         } else 
		                     LODOP=CreatedOKLodop7766;
			     };
			     //=====判断Lodop插件是否安装过，没有安装或版本过低就提示下载安装:==========
			     if ((LODOP==null)||(typeof(LODOP.VERSION)=="undefined")) {
			             if (navigator.userAgent.indexOf('Chrome')>=0)
			                 _alert(strHtmChrome);
			             if (navigator.userAgent.indexOf('Firefox')>=0)
			                 _alert(strHtmFireFox);
			             if (is64IE) _alert(strHtm64_Install); else
			             if (isIE)   _alert(strHtmInstall);    else
			                 _alert(strHtmInstall);
			             return LODOP;
			     } else 
			     if (LODOP.VERSION<"6.1.7.4") {
			             if (is64IE) _alert(strHtm64_Update); else
			             if (isIE) _alert(strHtmUpdate); else
			             _alert(strHtmUpdate);
			    	     return LODOP;
			     };
			     //=====如下空白位置适合调用统一功能(如注册码、语言选择等):====	     
			     LODOP.SET_LICENSES("浙江爱特电子技术有限公司","853537363857383919278901905623","","");
			     //============================================================	     
			     return LODOP; 
			} catch(err) {
			     if (is64IE)
//			     document.documentElement.innerHTML= strHtm64_Install+document.documentElement.innerHTML;
			        oss.core.common.showWarnMsg('安装提示', strHtm64_Install);
		            else
//		            document.documentElement.innerHTML= strHtmInstall+document.documentElement.innerHTML;
		            oss.core.common.showWarnMsg('安装提示', strHtmInstall);
			     return LODOP; 
				
//			     document.documentElement.innerHTML="Error:"+strHtml1+document.documentElement.innerHTML;
//			     return LODOP; 
			
			};
		}
