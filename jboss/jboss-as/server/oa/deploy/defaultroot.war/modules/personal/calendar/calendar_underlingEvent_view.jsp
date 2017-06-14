<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><s:text name="personalwork.view" /><s:text name="schedule.subordinateSchedule" /><s:text name="calendar.aperiodic" /></title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <script src="<%=rootPath%>/modules/personal/calendar/calendar_underlingEvent_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/modules/personal/calendar/calendar_eventComment_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" type="text/javascript"></script>
</head>

<body class="Pupwin">
    <div class="BodyMargin_10">  
        <div class="docBoxNoPanel">
            <s:form name="dataForm" id="dataForm" action="${ctx}/EventUnderlingAction!viewUnderlingEvent.action" method="post" theme="simple" >
                <%@ include file="/public/include/form_detail.jsp"%>
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <s:hidden name="eventId" id="eventId" />
                    <s:hidden name="verifyCode" id="verifyCode" />
                    <!-- Main Part Start -->
                    <s:hidden name="event.onTimeMode" id="onTimeMode" value="0"/>
					
					<s:hidden id="formEventBeginTimeOld" value="%{formEventBeginTime}" />
					<s:hidden id="formEventEndTimeOld" value="%{formEventEndTime}" />
                    
                    <s:if test="eventId!=null">                        
                        <s:hidden id="formUnderlingEmpIdOld" value="%{formUnderlingEmpId}" />
                    </s:if>
                    <tr>  
                        <td class="td_lefttitle">  
                            <s:text name="myworklog.selectemp"/><span class="MustFillColor">*</span>：  
                        </td>  
                        <td colspan="6">
                            <s:hidden name="formUnderlingEmpName" id="formUnderlingEmpName" />
                            <select name="formUnderlingEmpId" id="formUnderlingEmpId" class="easyui-combobox" style="width:290px;" data-options="panelHeight:'auto',  selectOnFocus:true, onSelect: function(record){changeFormUnderlingEmpName(record);}">
                                <option value="">--<s:text name="innercontact.select"/>--</option>
                                <s:iterator var="obj" value="#request.underlingEmpList" >
                                    <option value="<s:property value='#obj[0]' />" ><s:property value='%{#obj[1]}' escape='false'/></option>
                                </s:iterator>
                            </select>
                        </td>  
                    </tr>  
                    <tr>  
                        <td class="td_lefttitle">  
                            <s:text name="calendar.title" /><span class="MustFillColor">*</span>：  
                        </td>  
                        <td colspan="6">
                            <s:textfield name="event.eventTitle" id="eventTitle" cssClass="inputText" cssStyle="width:98%;" disabled="true" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td class="td_lefttitle">  
                            <s:text name="calendar.place" />：  
                        </td>  
                        <td colspan="6">
                            <s:textfield name="event.eventAddress" id="eventAddress" cssClass="inputText" cssStyle="width:98%;" disabled="true" />  
                        </td>  
                    </tr>
                    <tr>  
                        <td class="td_lefttitle" width="11%">  
                            <s:text name="calendar.begin" />：
                        </td>  
                        <td width="15%"> 
                            <input type="text" class="Wdate whir_datebox" name="formEventBeginDate" id="formEventBeginDate" value='<s:property value="#request.formEventBeginDate" />' onfocus="WdatePicker({el:'formEventBeginDate',isShowWeek:true, isShowClear:false, readOnly:true, maxDate:'#F{$dp.$D(\'formEventEndDate\')||\'%y-%M-%d\'}'})" disabled="true" /> 
                        </td>  
                        <td id="td_beginTime" width="12%">
						<%
						    String formEventBeginTimeTotal = request.getAttribute("formEventBeginTime")==null?"28800":request.getAttribute("formEventBeginTime").toString();
							String formEventBeginTime="";
							String formEventBeginminutes ="";
							if(null!=formEventBeginTimeTotal && !formEventBeginTimeTotal.trim().equals("")){
							formEventBeginTime = (Integer.parseInt(formEventBeginTimeTotal)/3600)+"";
							
							formEventBeginminutes = ((Integer.parseInt(formEventBeginTimeTotal)%3600)/60)+"";
							}
                            
							
                        %>
                            <select name="formEventBeginHours" id="formEventBeginHours" class="selectlist" style="width:60px;" disabled="true" >
							<%
								for(int i=0; i<24; i++){
                                   
                                        int optValue = i*3600;
                                        String optText = (i<10?"0":"") + i ;
                                        String optSelected = "";
                                        if(formEventBeginTime.equals("" + i)){
                                            optSelected = "selected";
                                        }
							%>
										<option value="<%=optValue%>" <%=optSelected%> ><%=optText%></option>
							<%
									
								}
							%>
							</select>
							&nbsp;
							<span>时</span>
                        </td>
						<td id="td_beginTime2" width="8%">
                            <select name="formEventBeginMinutes" id="formEventBeginMinutes" class="selectlist" style="width:60px;" disabled="true">
                            <%
                                for(int i=0; i<60; i=i+5){
                                        int optValue = i*60;
                                        String optText = (i<10?"0":"") + i ;
                                        String optSelected = "";
                                        if(formEventBeginminutes.equals(""+i)){
                                            optSelected = "selected";
                                        }
                            %>
                                        <option value="<%=optValue%>" <%=optSelected%> ><%=optText%></option>
                            <%
                                    
                                }
                            %>
                            </select>
                        </td>
                        <td class="td_lefttitle" width="9%">  
                            <s:text name="calendar.dayevent" />：  
                        </td>  
                        <td> 
                            <s:radio name="event.eventFullDay" id="eventFullDay" list="%{#{'1':getText('rtx.Yes'),'0':getText('rtx.No')}}" theme="simple" disabled="true" ></s:radio>
                        </td>  
                    </tr>  
                    <tr>  
                        <td class="td_lefttitle">  
                            <s:text name="calendar.end" />：
                        </td>  
                        <td> 
                            <input type="text" class="Wdate whir_datebox" name="formEventEndDate" id="formEventEndDate" value='<s:property value="#request.formEventEndDate" />' onfocus="WdatePicker({el:'formEventEndDate',isShowWeek:true, isShowClear:false, readOnly:true, minDate:'#F{$dp.$D(\'formEventBeginDate\')}'})" disabled="true" />  
                        </td> 
                       <td id="td_endTime"  width="11%">
                        <%
                            String formEventEndTimeTotal = request.getAttribute("formEventEndTime")==null?"64800":request.getAttribute("formEventEndTime").toString();
							 String formEventEndTime ="";
							 String formEventEndTimeMinutes="";
							 if(null!=formEventEndTimeTotal && !formEventEndTimeTotal.trim().equals("")){
							formEventEndTime = (Integer.parseInt(formEventEndTimeTotal)/3600)+"";
							 
							formEventEndTimeMinutes = ((Integer.parseInt(formEventEndTimeTotal)%3600)/60)+"";
							 
							 }
							  
                        %>
                            <select name="formEventEndHours" id="formEventEndHours"  class="selectlist" style="width:60px;" disabled="true" >
							<%
								 for(int i=0; i<24; i++){
                                        int optValue = i*3600;
                                        String optText = (i<10?"0":"") + i ;
                                        String optSelected = "";
                                        if(formEventEndTime.equals("" + i)){
                                            optSelected = "selected";
                                        }
							%>
										<option value="<%=optValue%>" <%=optSelected%> ><%=optText%></option>
							<%
									
								}
							%>
							</select>
							&nbsp;
							<span>时</span>
                        </td> 
						<td id="td_endTime2">
                        
                            <select name="formEventEndMinutes" id="formEventEndMinutes" class="selectlist" style="width:60px;" disabled="true">
                            <%
                                for(int i=0; i<60; i=i+5){
                                    
                                        int optValue = i*60;
                                        String optText = (i<10?"0":"") + i ;
                                        String optSelected = "";
                                        if(formEventEndTimeMinutes.equals(""+i)){
                                            optSelected = "selected";
                                        }
                            %>
                                        <option value="<%=optValue%>" <%=optSelected%> ><%=optText%></option>
                            <%
                                    
                                }
                            %>
                            </select>
                        </td>
                        <td class="td_lefttitle">  
                            <s:text name="calendar.remind" />：  
                        </td>  
                        <td > 
                            <s:radio name="event.eventRemind" id="eventRemind" list="%{#{'1':getText('rtx.Yes'),'0':getText('rtx.No')}}" theme="simple" disabled="true" ></s:radio>
                        </td>  
                    </tr>  
                    <tr id="tr_eventRemind">  
                        <td id="td_perch" colspan="4">&nbsp;</td>
                        <td class="td_lefttitle">  
                            <s:text name="提醒项"/>：   
                        </td>  
                        <td >  
                        	<%
		                    com.whir.org.common.util.SysSetupReader sysRead = com.whir.org.common.util.SysSetupReader.getInstance();
		                    String mailRemind = sysRead.getOa_mailremind(session.getAttribute("domainId").toString());
		                    String modeType = "im|sms";
		                    if("1".equals(mailRemind)){
		                    	modeType = modeType+"|mail";
		                    }
		                    %>
                            <jsp:include page="/public/im/remind.jsp" flush="true">  
                                <jsp:param name="modeType" value="<%=modeType %>" />  
                                <jsp:param name="smsModelName" value="日程" />  
                                <jsp:param name="defaultSelected" value="" />  
                                <jsp:param name="disabled" value="im|sms|mail" />  
                            </jsp:include> 
                        </td>  
                    </tr>
                    <tr>  
                        <td class="td_lefttitle">  
                            <s:text name="calendar.participant" />：  
                        </td>  
                        <td colspan="6">  
                            <s:hidden name="event.attendId" id="attendId" />  
                            <s:textfield name="event.attend" id="attend" cssClass="inputText" cssStyle="width:98%;" readonly="true" disabled="true" />  
                        </td> 
                    </tr>  
                    <tr>  
                        <td class="td_lefttitle">  
                            <s:text name="calendar.content"/><span class="MustFillColor">*</span>：  
                        </td>  
                        <td colspan="6">  
                            <s:textarea name="event.eventContent" id="eventContent" rows="3" cssClass="inputTextarea" cssStyle="width:98%;" disabled="true" ></s:textarea>
                        </td>  
                    </tr>
                    <!-- 留言 [BEGIN] -->
                    <tr>
                        <td colspan="6"><strong><s:text name="personalwork.comment"/>：</strong></td>
                        <td align="right" style="padding-right:10px;">
                            <input type="button" class="btnButton4font" onclick="addComment();" value='<s:text name="personalwork.add"/><s:text name="personalwork.comment"/>' />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <table width="99%" border="0" cellspacing="0" cellpadding="0" class="docBoxNoPanel">
                                <tr>
                                    <td width="10%" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                        <s:text name="comment.person"/>
                                    </td>
                                    <td width="60%" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                        <s:text name="comment.content"/>
                                    </td>
                                    <td width="20%" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                        <s:text name="comment.time"/>
                                    </td>
                                    <td width="10%" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                        <s:text name="agent.operation"/>
                                    </td>
                                </tr>
                                <s:iterator var="obj" value="#request.commentList" >
                                    <tr>
                                        <td>
                                            <s:property value="%{#obj[1]}" />
                                        </td>
                                        <td style="word-break: break-all; word-wrap:break-word;">
                                            <s:property value="%{#obj[2]}" />
                                        </td>
                                        <td>
                                            <s:property value="%{#obj[3]}" />
                                        </td>
                                        <td>
                                            <s:if test="#obj[4]==1">
                                            <a href="javascript:void(0)" onclick="modiComment('<s:property value="%{#obj[0]}" />');"><img border="0" src="<%=rootPath%>/images/modi.gif" title='<s:text name="comm.modify"/>' ></a>
                                            <a href="javascript:void(0)" onclick="delComment('<s:property value="%{#obj[0]}" />');"><img border="0" src="<%=rootPath%>/images/del.gif" title='<s:text name="comm.delete"/>' ></a>
                                            </s:if>
                                        </td>
                                    </tr>
                                </s:iterator>
                            </table>
                        </td>
                    </tr>
                    <!-- 留言 [END] -->
                    <!-- Main Part End   -->
                    <tr class="Table_nobttomline">  
                        <td>&nbsp;</td>
                        <td colspan="5" >
                            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />
                        </td>  
                    </tr>  
                </table>
            </s:form>
        </div>
    </div>
</body>

<script type="text/javascript">
$(document).ready(function(){
    if(initViewForm()){
    }
});

function initViewForm(){
    if(initModiForm()){
        $('#formUnderlingEmpId').combobox('disable');
		
        //$('#formEventBeginTime').combobox('disable');
        //$('#formEventEndTime').combobox('disable');
		/*
        $('#formEventBeginHour').combobox('disable');
        $('#formEventBeginMinute').combobox('disable');
        $('#formEventEndHour').combobox('disable');
        $('#formEventEndMinute').combobox('disable');
		*/
        
    }
    return true;
}
</script>

</html>
