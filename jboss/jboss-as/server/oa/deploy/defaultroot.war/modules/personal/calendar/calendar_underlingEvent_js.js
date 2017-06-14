/** 列表页 [BEGIN] */

/** 列表页 [END] */


/** 新增页 [BEGIN] */
// 
function changeEventType(option){
    var eventType = option.value;
    if(eventType == '0'){
        var vUrl = whirRootPath + '/EventUnderlingAction!addUnderlingEvent.action';
        vUrl += '?flagChangeEventType=1';
        location_href(vUrl);
    } else if(eventType == '1') {
        var vUrl = whirRootPath + '/EventUnderlingAction!addUnderlingEventEcho.action';
        vUrl += '?flagChangeEventType=1';
        location_href(vUrl);
    } else {
        //whir_tips("获取必须参数失败，请联系开发人员！", 3, "", null);
    }
}

// 初始化新增页面
/*
 * 注：这个方法源自 calender_myEvent_js.js 同名方法
 */
function initAddForm(){ 
    
    // 日程开始时间、结束时间的"时"、"分"部分
    //whirCombobox.setValue('formEventBeginTime', $("#formEventBeginTimeOld").val()==''?'28800':$("#formEventBeginTimeOld").val());
    //whirCombobox.setValue('formEventEndTime', $("#formEventEndTimeOld").val()==''?'64800':$("#formEventEndTimeOld").val());
    
    // 隐藏"提醒"部分
    $("#tr_eventRemind").hide();  
    
    // 注：Added for bug 21473 
    changeEventFullDay(0);
    
    return true;
}
/** 新增页 [END] */

/** 修改页 [BEGIN] */
// 初始化修改页面
/*
 * 注：这个方法源自 calender_myEvent_js.js 同名方法
 */
function initModiForm(){    
    
    // 下属员工
    whirCombobox.setValue('formUnderlingEmpId', $("#formUnderlingEmpIdOld").val());
    $('#formUnderlingEmpId').combobox('disable');
    
    // 日程开始时间、结束时间的"时"、"分"部分
    //whirCombobox.setValue('formEventBeginTime', $("#formEventBeginTimeOld").val()==''?'28800':$("#formEventBeginTimeOld").val());
    //whirCombobox.setValue('formEventEndTime', $("#formEventEndTimeOld").val()==''?'64800':$("#formEventEndTimeOld").val());
    
    // 根据“是否是全天事件”，显示/隐藏“时间选择部分”
    changeEventFullDay($('input[name="event.eventFullDay"]:checked').val());
    
    // 根据“是否提醒”，显示/隐藏“短信提醒”选择部分
    changeEventRemind($('input[name="event.eventRemind"]:checked').val());
    
    return true;
}
/** 修改页 [END] */


/** 新增/修改表单页 [BEGIN] */
// 提交表单前的验证
function checkForm(){
    
    // 检查下属员工
    // 检查不定期事件的开始时间、结束时间之间的大小
    if(checkUnderlingEmp() && checkEventDateTime()){
        return true;
    }
    return false;
}

// 改变“下属员工”下拉框时，对隐藏域“下属员工名称”赋值
function changeFormUnderlingEmpName(option){
    $('#formUnderlingEmpName').val($('#formUnderlingEmpId option[value='+option.value+']').text());
}

// 根据“是否是全天事件”，显示/隐藏“时间选择部分”
/*
 * 注：这个方法源自 calender_myEvent_js.js 同名方法
 */
function changeEventFullDay(flag){
    if(flag == 1){
        $("#td_beginTime").hide();
        $("#td_endTime").hide();
        $("#td_beginTime2").hide();
        $("#td_endTime2").hide();
        
        // 为了样式添加的
        $('#td_perch').attr("colspan", 2);
    }else{
        $("#td_beginTime").show();
        $("#td_endTime").show();
        $("#td_beginTime2").show();
        $("#td_endTime2").show();
        // 为了样式添加的
        $('#td_perch').attr("colspan", 4);
    }
}

// 根据“是否提醒”，显示/隐藏“短信提醒”选择部分
/*
 * 注：这个方法源自 calender_myEvent_js.js 同名方法
 */
function changeEventRemind(flag){
    //alert("flag=[" + flag + "]");
    //if($('#canSendMsg').val() == 'true'){
        if(flag == 1){
            $("#tr_eventRemind").show();
        }else{
            $("#tr_eventRemind").hide();
            $('input[name="event.noteRemindMode"][value="0"]').attr("checked", "checked");
            $('input[name="event.noteRemindMode"][value="0"]').click();
    		$("#remind_im").attr("checked",false);
    		$("#remind_sms").attr("checked",false);
    		$("#remind_mail").attr("checked",false);
        }
    //}
}
/** 新增/修改表单页 [END] */
