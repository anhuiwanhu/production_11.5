
//适用于请假流程和出差流程 计算天数和时间数
function computeDT(json){
    var startT = json.startField;
    var endT   = json.endField;
    var days   = json.daysField;
    var hours  = json.hoursField;
    var workday= json.isWorkDays;//1-只计算工作日 0-都计算
    
    //alert(startT+"|"+endT+"|"+days+"|"+hours+"|"+workday);
    
    var s_date =document.getElementById(startT).value;
    var e_date =document.getElementById(endT).value;
    var result =compareTwoDate(s_date,e_date);
	if(result ==">"){
		$.dialog.alert("开始时间不能大于结束时间！",function(){});
		return false;
	}

	//区分考勤流程开始
	if(startT.indexOf("whir$t_")==-1){
		if(s_date.length<=10 && e_date.length<=10){
			s_date = s_date.replace(/-/g,"/"); 
			e_date = e_date.replace(/-/g,"/"); 
			var date1 = new Date(s_date);
			var date2 = new Date(e_date);

			var date3=(date2.getTime()-date1.getTime())/1000+60*60*24;   //相差秒数  
			
			var days_ = date3/(60*60*24);
			var hours_ = date3/(60*60);
			if(document.getElementById(days)){
				document.getElementById(days).value =days_.toFixed(2);
			}
			if(document.getElementById(hours)){
				document.getElementById(hours).value=hours_.toFixed(2);
			}
			return;
		}else{
			var s_day = s_date.split(" ")[0];
			var s_time = s_date.split(" ")[1];
			var e_day = e_date.split(" ")[0];
			var e_time = e_date.split(" ")[1];
			s_day = s_day.replace(/-/g,"/"); 
			e_day = e_day.replace(/-/g,"/"); 
			var date1 = new Date(s_day);
			var date2 = new Date(e_day);
			var date3=(date2.getTime()-date1.getTime())/1000;   //日期相差秒数  

			var date4 = s_time.split(":")[0]*60*60+s_time.split(":")[1]*60;
			var date5 = e_time.split(":")[0]*60*60+e_time.split(":")[1]*60;
			var date6; //时间相差秒数  

			var a_s_time = 30600;//8:30
			var a_e_time = 43200;//12:00
			var p_s_time = 48600;//13:30
			var p_e_time = 64800;//18:00

			if(date4<a_s_time){
				if(date5<a_s_time){
					date6 = 0;
				}else if(date5<a_e_time){
					date6 = date5-a_s_time;
				}else if(date5<p_s_time){
					date6 = 12600;
				}else if(date5<p_e_time){
					date6 = date5-p_s_time+12600;
				}else{
					date6 = 28800;
				}
			}else if(date4<a_e_time){
				if(date5<a_e_time){
					date6 = date5-date4;
				}else if(date5<p_s_time){
					date6 = a_e_time-date4;
				}else if(date5<p_e_time){
					date6 = date5-date4-5400;
				}else{
					date6 = p_e_time-date4-5400;
				}
			}else if(date4<p_s_time){
				if(date5<p_s_time){
					date6 = 0;
				}else if(date5<p_e_time){
					date6 = date5-p_s_time;
				}else{
					date6 = 16200;
				}
			}else if(date4<p_e_time){
				if(date5<p_e_time){
					date6 = date5-date4;
				}else{
					date6 = p_e_time-date4;
				}
			}else{
				date6 = 0;
			}

			//var date6=(date5-date4);   //时间相差秒数  
			var days_ = (date3)/(60*60*24)+date6/(60*60*8);
			var hours_ = (date3+date6)/(60*60);
			if(document.getElementById(days)){
				document.getElementById(days).value =days_.toFixed(2);
			}
			if(document.getElementById(hours)){
				document.getElementById(hours).value=hours_.toFixed(2);
			}
			return;
		}
	}
	//区分考勤流程结束

	if(s_date.length<=10){
		s_date = s_date+" 23:59";
	}
	if(e_date.length<=10){
		e_date = e_date+" 23:59";
	}
	
	//else if(result =="="){
	//	$.dialog.alert("开始时间不能等于结束时间！",function(){});
	//	return false;
	//}
    
    var address = whirRootPath + "/kqworkflow!computeDT.action?s_date="+s_date+"&e_date="+e_date+"&workday="+workday;
	//alert(address);
    $.ajax({
	 	type: 'POST',
	 	url: address,
	 	async: true,
	 	dataType: 'json',
	 	success: function(json){
			//alert(json.hours);
			if(json.noKqTime =='noKqTime'){
				$.dialog.alert("您没有假期，请联系管理员！",function(){});
				return false;
			}else{
				if(document.getElementById(days)){
					document.getElementById(days).value =json.days;
				}
				if(document.getElementById(hours)){
					document.getElementById(hours).value=json.hours;
				}
			}
	 	},
	 	error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
	});
}

//适用于调休流程 计算实际加班小时数和可冲销加班小时数
function getPaidleaveInfo(){
	var address = whirRootPath + "/kqworkflow!getPaidleaveInfo.action";
    $.ajax({
	 	type: 'POST',
	 	url: address,
	 	async: true,
	 	dataType: 'json',
	 	success: function(json){
	 		if(document.getElementById("whir$_paidleave_overtime")){
	 	 		document.getElementById("whir$_paidleave_overtime").value =json.all_realtime;
	 	 	}
	 	 	if(document.getElementById("whir$_paidleave_offtime")){
	 	 		document.getElementById("whir$_paidleave_offtime").value=json.realtime;
	 	 	}
	 	},
	 	error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
	});
}

//适用于调休流程 判断调休小时数是否大于可冲销加班小时数
function isSendPaidleave(){
	var hours =document.getElementById("whir$_paidleave_hours").value; //调休小时数
	var realtime =document.getElementById("whir$_paidleave_offtime").value; //可冲销加班小时数
	if(parseFloat(hours) > parseFloat(realtime)){
		whir_alert("您的可冲销加班小时数不足，请重新填写调休时间！",function(){
			return false;
		});
		return false;
	}
	return true;
}