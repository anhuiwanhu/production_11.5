/** 列表页 [BEGIN] */
/** 列表页 [END] */


/** 新增页 [BEGIN] */
/** 新增页 [END] */


/** 修改页 [BEGIN] */
/** 修改页 [END] */


/** 新增/修改页 [BEGIN] */
// 检查不定期事件的开始时间、结束时间之间的大小
function checkEventDateTime(){
    var isFullDay = $('input[name="event.eventFullDay"]:checked').val();
    //alert('isFullDay=[' + isFullDay + ']');
    var beginDate = $('#formEventBeginDate').val();
    var endDate = $('#formEventEndDate').val();
    if(beginDate=='' || beginDate==null){
			whir_alert('请选择有效期开始时间！');
			return false;
	}else if(endDate=='' || endDate==null){
			whir_alert('请选择有效期结束时间！');
			return false;
	}else if(beginDate>endDate){
				whir_alert('结束日期必须在开始日期之后');
				return false;
	}
    if(isFullDay == '0'){
        // 非全天事件
        
        // 调用公共方法比较两个日期
        var cDate = compareTwoDate($('#formEventBeginDate').val(), $('#formEventEndDate').val());
        //alert('cDate=[' + cDate + ']');
        if(cDate == '='){
            // 开始日期与结束日期相同
            var bTime0 = new Number($('#formEventBeginHours').val());
            var eTime0 = new Number($('#formEventEndHours').val());
		   
		    var bTime1 = new Number($('#formEventBeginMinutes').val());
            var eTime1 =new Number($('#formEventEndMinutes').val());
			var p = new Number("00");
            if(bTime0.valueOf() > eTime0.valueOf()){
                whir_poshytip($('#formEventBeginHours'), Personalwork.calendar_datecheck, 'center');
                return false;
            }
			if(bTime0.valueOf() == eTime0.valueOf() && bTime1.valueOf() >= eTime1.valueOf() && bTime1.valueOf() != p.valueOf()){
			  whir_poshytip($('#formEventBeginMinutes'), Personalwork.calendar_datecheck, 'center');
                return false;
			}
			if(bTime0.valueOf() == eTime0.valueOf() && bTime1.valueOf() >= eTime1.valueOf() && bTime1.valueOf() == p.valueOf()){
			  whir_poshytip($('#formEventBeginHours'), Personalwork.calendar_datecheck, 'center');
                return false;
			}
        }
    }
    return true;
}

// 检查定期事件的开始时间、结束时间之间的大小
function checkEchoEventDateTime(){
	var beginDate = $('#formEchoBeginDate').val();
    var endDate = $('#formEchoEndDate').val();
    var flag = "";
    $("input[name='event.echoMode']").each( function(){ 
    	if(this.checked){
    		flag = this.value;
    	}
    });
    if(beginDate=='' || beginDate==null){
		whir_alert('请选择有效期开始时间！');
		return false;
	}else if(endDate=='' || endDate==null){
		if(flag!=-1){
			whir_alert('请选择有效期结束时间！');
			return false;
		}
	}else if(flag!=-1 && beginDate>endDate){
		whir_alert('结束日期必须在开始日期之后');
		return false;
	}
	
    var bTime0 = new Number($('#formEventBeginHours').val());
	var eTime0 = new Number($('#formEventEndHours').val());
   
	var bTime1 = new Number($('#formEventBeginMinutes').val());
	var eTime1 =new Number($('#formEventEndMinutes').val());
	var p = new Number("00");
	         if(bTime0.valueOf() > eTime0.valueOf()){
                whir_poshytip($('#formEventBeginHours'), Personalwork.calendar_datecheck, 'center');
                return false;
            }
			if(bTime0.valueOf() == eTime0.valueOf() && bTime1.valueOf() >= eTime1.valueOf() && bTime1.valueOf() != p.valueOf()){
			  whir_poshytip($('#formEventBeginMinutes'), Personalwork.calendar_datecheck, 'center');
                return false;
			}
			if(bTime0.valueOf() == eTime0.valueOf() && bTime1.valueOf() >= eTime1.valueOf() && bTime1.valueOf() == p.valueOf()){
			  whir_poshytip($('#formEventBeginHours'), Personalwork.calendar_datecheck, 'center');
                return false;
			}
    return true;
}

// 检查下属员工
function checkUnderlingEmp(){
    if($('#formUnderlingEmpName').val() == ''){
        whir_poshytip($('#formUnderlingEmpId + span'), Personalwork.myworklog_selectemp);
        return false;
    }
    return true;
}
/** 新增/修改页 [END] */
