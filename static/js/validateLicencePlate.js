function validateLicencePlate(licencePlate) {
	licencePlate = $.trim(licencePlate.toUpperCase());
	 var re=/^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{4}[A-Z_0-9_\u4e00-\u9fa5]$|^[A-Z]{2}[a-zA-Z_0-9_\u4e00-\u9fa5]{7}$/; 
 
	 if (licencePlate.length == 7) {
	      var one=licencePlate.slice(0,1);
	      if(/^[\u4e00-\u9fa5]+$/.test(one)){
	    	  var str = licencePlate.slice(1,2);
		      if(/^[A-Z]+$/.test(str)){
		    	  if(licencePlate.search(re)==-1)
			         {
						showAlert('warning', '输入的车牌号应为7位或9位！', "licensePlate", 'top');
						$("#licensePlate").focus();
						return false;
			         }
		      }else{
				     if(licencePlate.search(re)==-1)
			         {
						showAlert('warning', '车牌第二位应为大写字母！', "licensePlate", 'top');
						$("#licensePlate").focus();
						return false;
			         } 
		         }
		 }else{
		     if(licencePlate.search(re)==-1)
	         {
				showAlert('warning', '车牌的第一位为直辖市编号汉字！', "licensePlate", 'top');
				$("#licensePlate").focus();
				return false;
	         }  
		 }
	      
	 }else if(licencePlate.length == 9){
		 var two = licencePlate.slice(0,2);
		 if(two!="WJ"){
				showAlert('warning', '武警车牌以WJ开头！', "licensePlate", 'top');
				$("#licensePlate").focus();
				return false;
		 }else{
			 if(licencePlate.search(re)==-1)
	         {
				showAlert('warning', '输入的车牌号格式不正确！', "licensePlate", 'top');
				$("#licensePlate").focus();
				return false;
	         }  
		 }
	 }
	 
	  
     if(licencePlate.search(re)==-1)
         {
			showAlert('warning', '输入的车牌号应为7位或9位！', "licensePlate", 'top');
			$("#licensePlate").focus();
			return false;
         }  
	 }   


function validateLicencePlates(vehicleLisencePlate) {

		 var re=/^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{4}[A-Z_0-9_\u4e00-\u9fa5]$|^[A-Z]{2}[A-Z_0-9_\u4e00-\u9fa5]{7}$/; 
	 
		 if (vehicleLisencePlate.length == 7) {
		      var one=vehicleLisencePlate.slice(0,1);
		      if(/^[\u4e00-\u9fa5]+$/.test(one)){
		    	  var str = vehicleLisencePlate.slice(1,2);
			      if(/^[A-Z]+$/.test(str)){
			    	  if(vehicleLisencePlate.search(re)==-1)
				         {
							showAlert('warning', '输入的车牌号应为7位或9位！', "vehicleLisencePlate", 'top');
							$("#vehicleLisencePlate").focus();
							return false;
				         }
			      }else{
					     if(vehicleLisencePlate.search(re)==-1)
				         {
							showAlert('warning', '车牌第二位应为大写字母！', "vehicleLisencePlate", 'top');
							$("#vehicleLisencePlate").focus();
							return false;
				         } 
			         }
			 }else{
			     if(vehicleLisencePlate.search(re)==-1)
		         {
					showAlert('warning', '车牌的第一位为直辖市编号汉字！', "vehicleLisencePlate", 'top');
					$("#vehicleLisencePlate").focus();
					return false;
		         }  
			 }
		      
		 }else if(vehicleLisencePlate.length == 9){
			 var two = vehicleLisencePlate.slice(0,2);
			 if(two!="WJ"){
					showAlert('warning', '武警车牌以WJ开头！', "vehicleLisencePlate", 'top');
					$("#vehicleLisencePlate").focus();
					return false;
			 }else{
				 if(vehicleLisencePlate.search(re)==-1)
		         {
					showAlert('warning', '输入的车牌号格式不正确！', "vehicleLisencePlate", 'top');
					$("#vehicleLisencePlate").focus();
					return false;
		         }  
			 }
		 }
		 
		  
	     if(vehicleLisencePlate.search(re)==-1)
	         {
				showAlert('warning', '输入的车牌号应为7位或9位！', "vehicleLisencePlate", 'top');
				$("#vehicleLisencePlate").focus();
				return false;
	         }  
		 }   



function validateLicencePlat(lAuthorizeCertNo) {
	 var re=/^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{4}[A-Z_0-9_\u4e00-\u9fa5]$|^[A-Z]{2}[A-Z_0-9_\u4e00-\u9fa5]{7}$/; 

	 if (lAuthorizeCertNo.length == 7) {
	      var one=lAuthorizeCertNo.slice(0,1);
	      if(/^[\u4e00-\u9fa5]+$/.test(one)){
	    	  var str = lAuthorizeCertNo.slice(1,2);
		      if(/^[A-Z]+$/.test(str)){
		    	  if(lAuthorizeCertNo.search(re)==-1)
			         {
						showAlert('warning', '输入的车牌号应为7位或9位！', "lAuthorizeCertNo", 'top');
						$("#lAuthorizeCertNo").focus();
						return false;
			         }
		      }else{
				     if(lAuthorizeCertNo.search(re)==-1)
			         {
						showAlert('warning', '车牌第二位应为大写字母！', "lAuthorizeCertNo", 'top');
						$("#lAuthorizeCertNo").focus();
						return false;
			         } 
		         }
		 }else{
		     if(lAuthorizeCertNo.search(re)==-1)
	         {
				showAlert('warning', '车牌的第一位为直辖市编号汉字！', "lAuthorizeCertNo", 'top');
				$("#lAuthorizeCertNo").focus();
				return false;
	         }  
		 }
	      
	 }else if(lAuthorizeCertNo.length == 9){
		 var two = lAuthorizeCertNo.slice(0,2);
		 if(two!="WJ"){
				showAlert('warning', '武警车牌以WJ开头！', "lAuthorizeCertNo", 'top');
				$("#lAuthorizeCertNo").focus();
				return false;
		 }else{
			 if(lAuthorizeCertNo.search(re)==-1)
	         {
				showAlert('warning', '输入的车牌号格式不正确！', "lAuthorizeCertNo", 'top');
				$("#lAuthorizeCertNo").focus();
				return false;
	         }  
		 }
	 }
	 
	  
    if(lAuthorizeCertNo.search(re)==-1)
        {
			showAlert('warning', '输入的车牌号应为7位或9位！', "lAuthorizeCertNo", 'top');
			$("#lAuthorizeCertNo").focus();
			return false;
        }  
	 } 