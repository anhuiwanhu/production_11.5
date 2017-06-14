
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>                
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <s:hidden name="event.eventId" id="eventId" />
                    <s:hidden name="event.eventFullDay" id="eventFullDay" value="0" />
                    
                    <s:hidden id="formEventBeginTimeOld" value="%{formEventBeginTime}" />
                    <s:hidden id="formEventEndTimeOld" value="%{formEventEndTime}" />
                    
                    <s:if test="eventId==null">
                        <s:hidden name="event.onTimeContent" id="onTimeContent" value="0"/>
                    </s:if>
                    <s:else>
                        <s:hidden name="event.onTimeContent" id="onTimeContent" />
                        
                        <s:hidden name="verifyCode" id="verifyCode" />
                    </s:else>
                    <!-- Main Part Start -->
                    <s:if test="eventId==null && #request.flagChangeEventType==1">
                     <%
						String formEventBeginTime1 = EncryptUtil.htmlcode(request.getAttribute("formEventBeginTime")==null?"28800":request.getAttribute("formEventBeginTime").toString());
                        String formEventEndTime1 = EncryptUtil.htmlcode(request.getAttribute("formEventEndTime")==null?"64800":request.getAttribute("formEventEndTime").toString()) ;
                        String date = EncryptUtil.htmlcode(request.getAttribute("formEventBeginDate")==null?"":request.getAttribute("formEventBeginDate").toString());
					 %>
                    <tr>
                        <td><s:text name="calendar.eventtype"/>：</td>
                        <td>
                            <select id="changeEventType" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto', selectOnFocus:true, onSelect: function(record){changeEventType(record,'<%=formEventBeginTime1%>','<%=formEventEndTime1%>','<%=date%>');}, editable:false">
                                <option value="0" ><s:text name="calendar.aperiodic"/></option>
                                <option value="1" selected="selected" ><s:text name="calendar.periodic"/></option>
                            </select>
                        </td>
                    </tr>
                    </s:if>
                    <tr>  
                        <td for='<s:text name="calendar.title"/>' width="11%" class="td_lefttitle">  
                            <s:text name="calendar.title"/><span class="MustFillColor">*</span>：  
                        </td>  
                        <td width="89%">
                            <s:textfield name="event.eventTitle" id="eventTitle" cssClass="inputText" whir-options="vtype:['notempty', {'maxLength':50}, 'spechar3']" maxLength="50" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="calendar.place"/>' class="td_lefttitle">  
                            <s:text name="calendar.place"/>：  
                        </td>  
                        <td>
                            <s:textfield name="event.eventAddress" id="eventAddress" cssClass="inputText" whir-options="vtype:[{'maxLength':50}, 'spechar3']" maxLength="50" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="calendar.time"/>' class="td_lefttitle">  
                            <s:text name="calendar.time"/>：  
                        </td>  
                        <td>
                       <%
						    String formEventBeginTimeTotal = request.getAttribute("formEventBeginTime")==null?"28800":request.getAttribute("formEventBeginTime").toString();
                            String formEventBeginTime = (Integer.parseInt(formEventBeginTimeTotal)/3600)+"";
							
							String formEventBeginminutes = ((Integer.parseInt(formEventBeginTimeTotal)%3600)/60)+"";
							
                        %>
                             <select name="formEventBeginHours" id="formEventBeginHours"  class="selectlist" style="width:9%;" >
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
							 <select name="formEventBeginMinutes" id="formEventBeginMinutes" class="selectlist" style="width:60px;" >
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
                            &nbsp;<s:text name="calendar.to"/>&nbsp;
                       <%
                            String formEventEndTimeTotal = request.getAttribute("formEventEndTime")==null?"64800":request.getAttribute("formEventEndTime").toString();
							
							  String formEventEndTime = (Integer.parseInt(formEventEndTimeTotal)/3600)+"";
							 
							String formEventEndTimeMinutes = ((Integer.parseInt(formEventEndTimeTotal)%3600)/60)+"";
                        %>
                            <select name="formEventEndHours" id="formEventEndHours" class="selectlist" style="width:9%;" >
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
							<select name="formEventEndMinutes" id="formEventEndMinutes" class="selectlist" style="width:60px;" >
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
                    </tr>  
                    <tr>  
                        <td for='<s:text name="calendar.permode"/>' class="td_lefttitle">  
                            <s:text name="calendar.permode"/>：  
                        </td>  
                        <td>
                            <s:if test="eventId==null">
                                <s:radio name="event.onTimeMode" id="onTimeMode" list="%{#{'1':getText('calendar.sortday'),'2':getText('calendar.sortweek'),'3':getText('calendar.sortmonth'),'4':getText('calendar.sortyear')}}" value="1" theme="simple" onclick="changeOnTimeMode(this.value);"></s:radio>
                            </s:if>
                            <s:else>
                                <s:radio name="event.onTimeMode" id="onTimeMode" list="%{#{'1':getText('calendar.sortday'),'2':getText('calendar.sortweek'),'3':getText('calendar.sortmonth'),'4':getText('calendar.sortyear')}}" theme="simple" onclick="changeOnTimeMode(this.value);"></s:radio>
                            </s:else>
                        </td>  
                    </tr>  
                    <tr id="tr_onTimeMode_day">  
                        <td>&nbsp;</td>  
                        <td>
                            <s:if test="eventId==null||(#request.event.onTimeContent!='0'&&#request.event.onTimeContent!='1')">
                                <s:radio name="onTimeMode_day" id="onTimeMode_day" list="%{#{'0':getText('calendar.everyday'), '1':getText('calendar.everyworkday')}}" value="0" theme="simple" ></s:radio>
                            </s:if>
                            <s:else>
                                <s:radio name="onTimeMode_day" id="onTimeMode_day" list="%{#{'0':getText('calendar.everyday'), '1':getText('calendar.everyworkday')}}" theme="simple" ></s:radio>
                            </s:else>
                        </td>  
                    </tr>  
                    <tr id="tr_onTimeMode_week">  
                        <td>&nbsp;</td>  
                        <td>
                            <input type="checkbox" id="onTimeMode_week1" value="0" /><s:text name="calendar.monday" />&nbsp;
                            <input type="checkbox" id="onTimeMode_week2" value="0" /><s:text name="calendar.tuesday" />&nbsp;
                            <input type="checkbox" id="onTimeMode_week3" value="0" /><s:text name="calendar.wednesday" />&nbsp;
                            <input type="checkbox" id="onTimeMode_week4" value="0" /><s:text name="calendar.thursday" />&nbsp;
                            <input type="checkbox" id="onTimeMode_week5" value="0" /><s:text name="calendar.friday" />&nbsp;
                            <input type="checkbox" id="onTimeMode_week6" value="0" /><s:text name="calendar.saturday" />&nbsp;
                            <input type="checkbox" id="onTimeMode_week0" value="0" /><s:text name="calendar.sunday" />&nbsp;
                        </td>  
                    </tr>  
                    <tr id="tr_onTimeMode_month">  
                        <td>&nbsp;</td>  
                        <td>
                            <s:text name="calendar.dayeverymonth" />
                            <select id="onTimeMode_month" class="selectlist" style="width:8%;" >
                            <%
                                for(int i=1; i<32; i++){
                                    String optValue = (i<10?"0":"") + i;
                                    String optText = (i<10?"0":"") + i;
                            %>
                                    <option value="<%=optValue%>" ><%=optText%></option>
                            <%
                                }
                            %>
                            </select><s:text name="calendar.day" />
                        </td>  
                    </tr> 
                    <tr id="tr_onTimeMode_year">  
                        <td>&nbsp;</td>  
                        <td>
                            <s:text name="calendar.dayeveryear" />
                            <select id="onTimeMode_year_month" class="selectlist" style="width:8%;" >
                            <%
                                for(int i=1; i<13; i++){
                                    String optValue = (i<10?"0":"") + i;
                                    String optText = (i<10?"0":"") + i;
                            %>
                                    <option value="<%=optValue%>" ><%=optText%></option>
                            <%
                                }
                            %>
                            </select><s:text name="calendar.monthof" />
                            <select id="onTimeMode_year_day" class="selectlist" style="width:8%;" >
                            <%
                                for(int i=1; i<32; i++){
                                    String optValue = (i<10?"0":"") + i;
                                    String optText = (i<10?"0":"") + i;
                            %>
                                    <option value="<%=optValue%>" ><%=optText%></option>
                            <%
                                }
                            %>
                            </select><s:text name="calendar.day" />
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="calendar.repeat" />' class="td_lefttitle">  
                            <s:text name="calendar.repeat" />：  
                        </td>  
                        <td>
                            <input type="text" class="Wdate whir_datebox" name="formEchoBeginDate" id="formEchoBeginDate" value='<s:property value="#request.formEchoBeginDate" />' onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})"/>
                            <span id="span_formEchoEndDate">
                            &nbsp;<s:text name="calendar.to"/>&nbsp;
                            <input type="text" class="Wdate whir_datebox" name="formEchoEndDate" id="formEchoEndDate" value='<s:property value="#request.formEchoEndDate" />' onfocus="WdatePicker({el:'formEchoEndDate',isShowWeek:true, isShowClear:false, readOnly:true, minDate:'#F{$dp.$D(\'formEchoBeginDate\')}'})"/>  
                            </span>
                            <s:if test="eventId==null">
                                <s:radio name="event.echoMode" id="echoMode" list="%{#{'-1':getText('calendar.noend'), '0':getText('calendar.hasEndDate')}}" value="0" theme="simple" onclick="changeEchoMode(this.value);" ></s:radio>
                            </s:if>
                            <s:else>
                                <s:radio name="event.echoMode" id="echoMode" list="%{#{'-1':getText('calendar.noend'), '0':getText('calendar.hasEndDate')}}" theme="simple" onclick="changeEchoMode(this.value);" ></s:radio>
                            </s:else>
                        </td>  
                    </tr>
                    <tr>  
                        <td for='<s:text name="calendar.participant"/>' class="td_lefttitle">  
                            <s:text name="calendar.participant"/>：  
                        </td>  
                        <td>  
                            <s:hidden name="event.attendId" id="attendId" />  
                            <s:textfield name="event.attend" id="attend" cssClass="inputText" readonly="true" /><a href="JavaScript:void(0);" class="selectIco" onclick="openSelect({allowId:'attendId', allowName:'attend', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
                        </td>
                    </tr>  
                    <s:hidden id="canSendMsg" value="%{#request.canSendMsg}" />
                    <tr>  
                            <td for='<s:text name="calendar.remind"/>' class="td_lefttitle">  
                                <s:text name="calendar.remind"/>：  
                            </td>  
                            <td >  
                                <s:if test="eventId==null || #request.event.eventRemind==null" >
                                    <s:radio name="event.eventRemind" id="eventRemind" list="%{#{'1':getText('rtx.Yes'),'0':getText('rtx.No')}}" value="0" theme="simple" onclick="changeEventRemind(this.value);"></s:radio>
                                </s:if>
                                <s:else>
                                    <s:radio name="event.eventRemind" id="eventRemind" list="%{#{'1':getText('rtx.Yes'),'0':getText('rtx.No')}}" theme="simple" onclick="changeEventRemind(this.value);"></s:radio>
                                </s:else>
                                
                                <span id="span_eventRemind">
                                    <s:text name="提醒项"/>： 
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
                                        <jsp:param name="disabled" value="" />  
                                    </jsp:include>  
                                </span>
                            </td> 
                    </tr>  
                    <tr>  
                        <td for='<s:text name="calendar.content"/>' class="td_lefttitle">  
                            <s:text name="calendar.content"/><span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:textarea name="event.eventContent"  id="eventContent" rows="3" cssClass="inputTextarea" cssStyle="width:98%" whir-options="vtype:['notempty', {'maxLength':200}, 'spechar3']" maxLength="200" ></s:textarea>
                        </td>  
                    </tr>
                    <!-- 留言 [BEGIN] -->
                    <s:if test="eventId!=null">
                    <tr>
                        <td><strong><s:text name="personalwork.comment"/>：</strong></td>
                        <td align="right" style="padding-right:10px;">
                            <input type="button" class="btnButton4font" onclick="addComment();" value='<s:text name="personalwork.add"/><s:text name="personalwork.comment"/>' />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
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
                                            <a href="javascript:void(0)" onclick="modiComment('<s:property value="%{#obj[0]}" />');"><img border="0" src="<%=rootPath%>/images/modi.gif" title='<s:text name="comm.supdate"/>' ></a>
                                            <a href="javascript:void(0)" onclick="delComment('<s:property value="%{#obj[0]}" />');"><img border="0" src="<%=rootPath%>/images/del.gif" title='<s:text name="comm.sdel"/>' ></a>
                                            </s:if>
                                        </td>
                                    </tr>
                                </s:iterator>
                            </table>
                        </td>
                    </tr>
                    </s:if>
                    <!-- 留言 [END] -->
                    <!-- Main Part End   -->
                    <tr class="Table_nobttomline">  
                        <td>&nbsp;</td>
                        <td nowrap>
                            <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(0,this);}" value='<s:text name="comm.saveclose"/>' />
                            <s:if test="eventId==null" >
                                <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(1,this);}" value='<s:text name="comm.savecontinue"/>' />
                            </s:if>
                            <s:else>
                                <input type="button" class="btnButton4font" onClick="deleteEventInForm();" value='<s:text name="comm.delete"/>' />
                            </s:else>
                            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
                            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />
                        </td>  
                    </tr>
                </table>  