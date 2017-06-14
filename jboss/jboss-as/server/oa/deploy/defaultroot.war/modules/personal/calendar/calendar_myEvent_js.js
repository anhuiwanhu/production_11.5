

/** 列表页 [BEGIN] */

/** 列表页 [END] */


/** 新增页 [BEGIN] */
// 
function changeEventType(option,startTime,endTime,date){
    var eventType = option.value;
    if(eventType == '0'){
        var vUrl = whirRootPath + '/EventAction!addMyEvent.action';
        vUrl += '?flagChangeEventType=1&formEventBeginDate='+date+'&formEventBeginTime='+startTime+'&formEventEndTime='+endTime;
        location_href(vUrl);
    } else if(eventType == '1') {
        var vUrl = whirRootPath + '/EventAction!addMyEventEcho.action';
        vUrl += '?flagChangeEventType=1&formEventBeginDate='+date+'&formEventBeginTime='+startTime+'&formEventEndTime='+endTime;
        location_href(vUrl);
    }  else {
        //whir_tips("获取必须参数失败，请联系开发人员！", 3, "", null);
    }
}

// 初始化新增页面
function initAddForm(){ 
    // 日程开始时间、结束时间的"时"、"分"部分
    //whirCombobox.setValue('formEventBeginTime', $("#formEventBeginTimeOld").val()==''?'28800':$("#formEventBeginTimeOld").val());
    //whirCombobox.setValue('formEventEndTime', $("#formEventEndTimeOld").val()==''?'64800':$("#formEventEndTimeOld").val());
	
    // 注：Added for bug 21473 
    changeEventFullDay(0);
    
    return true;
}

/** 新增页 [END] */


/** 修改页 [BEGIN] */
// 初始化修改页面
function initModiForm(){
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

/** 修改页/查看页 [BEGIN] */
/*
 * 注意：这里的两个方法，来自于calendar_common_js.js 
 */
// 在查看页中，删除事件记录
function deleteEventInForm(){
    var eventId = $('#eventId').val();
    if(eventId != '' && eventId != undefined ) {
        var vUrl = whirRootPath + '/EventAction!deleteEvent.action';
        vUrl += '?eventId=' + eventId;
        vUrl += '&verifyCode=' + $('#verifyCode').val();
        //alert('vUrl=[' + vUrl + ']');
        ajaxOperate({urlWithData:vUrl, tip:comm.whir_delete, isconfirm:true, formId:'', callbackfunction:deleteEventSuccess});
    } else {
        //whir_tips("获取必须参数失败，请联系开发人员！", 3, "", null);
    }
}

// 删除事件成功
function deleteEventSuccess(json){
    // 刷新父页面
    window.opener.refreshListForm('queryForm');
    
    // 关闭当前页面
    closeWindow(null);
}

// [暂未使用] 重新加载"日程" 修改页面
function refreshEventModi(){
    var eventId = $('#eventId').val();
    if(eventId != '' && eventId != undefined){
        var url = whirRootPath + '/EventAction!modiMyEvent.action';
        url += '?eventId=' + eventId;
        location_href(url);
        //alert(location_href);
    }else{
        //whir_tips("获取必须参数失败，请联系开发人员！", 3, "", null);
    }
    //$("#dataForm").submit();
}
/** 修改页/查看页 [END] */


/** 新增/修改表单页 [BEGIN] */
// 提交表单前的验证
function checkForm(){
    // 检查不定期事件的开始时间、结束时间之间的大小
    if(checkEventDateTime()){
        return true;
    }
    return false;
}

// 根据“是否是全天事件”，显示/隐藏“时间选择部分”
function changeEventFullDay(flag){
    //alert("flag=[" + flag + "]");
    if(flag == 1){
        $("#td_beginTime").hide();
        $("#td_endTime").hide();
        $("#td_beginTime2").hide();
        $("#td_endTime2").hide();
        
        // 为了样式添加的
        $('#td_perch').attr("colspan", 2);
        //$('#tr_eventRemind >td').eq(0).remove();
    } else {
        $("#td_beginTime").show();
        $("#td_endTime").show();
		$("#td_beginTime2").show();
        $("#td_endTime2").show();
        
        // 为了样式添加的
        $('#td_perch').attr("colspan", 4);
        //$('#tr_eventRemind').prepend('<td>&nbsp;</td>');
    }
}

// 根据“是否提醒”，显示/隐藏“短信提醒”选择部分
function changeEventRemind(flag){
    //alert("flag=[" + flag + "]");
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
}
/** 新增/修改表单页 [END] */
