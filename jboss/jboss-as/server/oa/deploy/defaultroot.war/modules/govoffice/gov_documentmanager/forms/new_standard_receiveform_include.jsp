<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
java.util.Date serverDate = new java.util.Date() ;
String serverY = serverDate.getYear() + 1900 +"";
String serverM = serverDate.getMonth() + 1 +"";
String serverD = serverDate.getDate() +"";
String field3_value=""+serverDate.getTime();
String now = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new  java.util.Date());
request.setAttribute("now",now);
%>
<!--
<table width="100%" border="0" cellpadding="1" cellspacing="0" class="">
  <tr>
    <td height="312" valign="top">
         <div id="docinfo0">-->
            <table width="80%" border="0" align="center" cellpadding="1" cellspacing="1">

				<input type="hidden" name="noNeedFlush" value="1" /> <!--不刷新页面-->
                <input type="hidden" name="isChangeSeq" value="0">
				<s:hidden name="seq" property="seq" />
				<s:hidden name="tableNameOrId" property="p_wf_tableId" />
					<tr>
                      <td width="100%" align="center"  nowrap="nowrap" class=big0 style="font-size:35px"><font color="#000000" size="35"  style="font-size:35px"><b  style="font-size:35px"><s:property  value="#request.p_wf_processName" /></b></font></td>
                    </tr>
                    
                    <tr>
                      <td align="right"  valign="top"><div align="left">
                          <table width="100%" border="0" align="center" cellpadding="0">


				<!-- <input type="hidden" name="receiveAccType" value="1"> 标明在 收文
				 <s:hidden name="sendFileId" property="p_wf_recordId" />
				 <s:hidden name="sendFileLink" property="sendFileLink" />
				 <s:hidden name="sendFileTitle" property="sendFileTitle1" />
				 <s:hidden name="fromFileSendCheckLink" property="fromFileSendCheckLink" />
				 <s:hidden name="fromFileSendCheckId" property="fromFileSendCheckId" />-->
				 <s:hidden name="done" />

				
				 <input type="hidden" name="createdDate1">
				 <input type="hidden" name="createdDate" value="<%=now%>">
				<!-- <s:hidden name="isMyReceiveDoc" property="isMyReceiveDoc" />
				 <input type="hidden" name="fromSendFileType" value="${param.fromSendFileType}">
				 <input type="hidden" name="winHref" value="GovReceiveFileAction.do?action=see&processId=${param.processId}&processName=${param.processName}&processType=${param.processType}&tableId=${param.tableId}&remindField=">-->
				<!--<s:if test="%#{param.exchangeFileLink != null}">
					<input type="hidden" name="exchangeFileId" value="${param.id}">
					<input type="hidden" name="exchangeFileLink" value="${param.exchangeFileLink}">
					<input type="hidden" name="exchangeFileTitle" value="${param.title}">
				</s:if>-->
     			<tr>
                <tr>
                    <td width="100%" height="35" colspan="2" align="right">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#000000">
								<input type="hidden" name="field1" value="-1">
									<input type="hidden" name="field2" value="<%=serverY%>">
								<input type="hidden" name="field3" value=""><!--当前时间long型****-->
								<s:hidden name="receiveFileFileNoCount" property="receiveFileFileNoCount"/>
								<s:hidden name="seqId" property="seqId"/>
								<input type="hidden" name="seqyear" value="-1">
                                <tr bgcolor="#FFFFFF">
                                    <td height="40" style="border-bottom:#000000 solid 4px; padding-left:10px;" nowrap><span class="STYLE1">编&nbsp;&nbsp;&nbsp; 号：</span></td>
                                    <td height="35" style="border-bottom:#000000 solid 4px;" align="left">
							
					<s:if test="p_wf_concealField.indexOf('$zjkySeq$') != -1 "><s:hidden  name="zjkySeqId" property="zjkySeqId"/><s:textfield   maxlength="95" cssClass="sw"  name="zjkySeq" property="zjkySeq"  style="display:none" readonly="true"/></s:if><s:elseif test="p_wf_cur_ModifyField.indexOf('$zjkySeq$') != -1 || p_wf_cur_ModifyField.indexOf('$receiveFileFileNo$') != -1"><s:hidden  name="zjkySeqId" property="zjkySeqId"/><s:textfield   maxlength="95" cssClass="sw"  name="zjkySeq" property="zjkySeq"  readonly="true"/><img src="images/select.gif" onClick="changeSeqNum();" title="选择" style="cursor:hand"/></s:elseif><s:else><s:hidden  name="zjkySeqId" property="zjkySeqId"/><s:textfield   maxlength="95" cssClass="sw" cssStyle="display:none"  name="zjkySeq" property="zjkySeq"  readonly="true"/><s:property  value="#request.zjkySeq" /></s:else>

								
									</td>
                                    <td height="35" align="center" class="STYLE1" style="border-bottom:#000000 solid 4px;padding-left:10px;">收文日期：</td>
                                    <td height="35" style="border-bottom:#000000 solid 4px;" align="left"> 
									<span align="right">
                                        <s:if test="p_wf_concealField.indexOf('$receiveFileReceiveDate$') != -1 ">
                                            <s:textfield   maxlength="95" cssClass="sw" cssStyle="display:none"  name="receiveFileReceiveDate" property="receiveFileReceiveDate"  value=""   readonly="true"/>
                                        </s:if>
                                        <s:elseif test="p_wf_cur_ModifyField.indexOf('$receiveFileReceiveDate$') != -1">
                                            <span align="right">
                                                <input type="text" class="Wdate whir_datebox" id="d122" name="receiveFileReceiveDate" value="<s:date name="receiveFileReceiveDate" format="yyyy-MM-dd"/>" onfocus="WdatePicker({el:'d122'})"/>
                                            </span>
                                        </s:elseif>
                                        <s:else>
                                            <s:textfield   maxlength="95" cssClass="sw" cssStyle="display:none"  name="receiveFileReceiveDate" property="receiveFileReceiveDate"  value=""   readonly="true"/>
                                        </s:else>
                                    </span>
                                    </td>
                                 </tr>
                                  <tr bgcolor="#FFFFFF">
                                    <td width="10%" height="40" nowrap class="STYLE1" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;padding-left:10px;" for="来文单位">来文单位 <font color="red">*</font> ：</td>
                                    <td id="lwdwList"  class="whir_td_searchinput" width="40%" height="35" align="left" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;">
										 <s:if test="p_wf_concealField.indexOf('$receiveFileSendFileUnit$') != -1 ">
                                             <s:hidden  name="receiveFileSendFileUnitId" property="receiveFileSendFileUnitId"/>
                                             <s:textfield style="display:none"   maxlength="95" cssClass="sw"  name="receiveFileSendFileUnit" property="receiveFileSendFileUnit"  />
                                         </s:if>
                                        <s:elseif test="p_wf_cur_ModifyField.indexOf('$receiveFileSendFileUnit$') != -1">

                                            <s:hidden  name="receiveFileSendFileUnitId" property="receiveFileSendFileUnitId"/>
                                            <s:textfield style="width:80%"   maxlength="95" cssClass="sw"  name="receiveFileSendFileUnit" property="receiveFileSendFileUnit"  />
                                            <img src="images/select.gif" onClick="javascript:choosePerson('mainToPerson','receiveFileSendFileUnit','receiveFileSendFileUnitId','选择单位');" title="选择" style="cursor:hand"/>
                                            <%--<s:hidden  name="receiveFileSendFileUnitId" property="receiveFileSendFileUnitId"/>
                                            <s:select   id="receiveFileSendFileUnitTemp" name="receiveFileSendFileUnitTemp" list="#request.mylist" listKey="unitWholeName" listValue="unitWholeName" cssClass="easyui-combobox" cssStyle="width:290px;height:29px;" ></s:select>--%>
<%--
                                            <img src="images/select.gif" onClick="javascript:choosePerson('mainToPerson','receiveFileSendFileUnit','receiveFileSendFileUnitId','选择单位');" title="选择" style="cursor:hand"/>
--%>

                                        </s:elseif>
                                        <s:else>
                                            <s:hidden  name="receiveFileSendFileUnitId" property="receiveFileSendFileUnitId"/>
                                            <s:textfield style="display:none"   maxlength="95" cssClass="sw"  name="receiveFileSendFileUnit" property="receiveFileSendFileUnit"  />
                                            <s:property  value="#request.receiveFileSendFileUnit" />
                                        </s:else>


                                   </td>
                                    <td width="10%" height="35" align="center" class="STYLE1" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;padding-left:10px;">原 文 号：</td>
                                  <td width="40%" height="35" style="border-bottom:#000000 solid 1px;" align="left"><s:if test="p_wf_concealField.indexOf('$receiveFileFileNumber$') != -1 "><s:textfield   maxlength="95" cssClass="sw" cssStyle='display:none'  name="receiveFileFileNumber" property="receiveFileFileNumber"  readonly="true"/></s:if><s:elseif test="p_wf_cur_ModifyField.indexOf('$receiveFileFileNumber$') != -1"><s:textfield   maxlength="95" cssClass="sw"  name="receiveFileFileNumber" cssStyle="width:80%"   property="receiveFileFileNumber"  /></s:elseif><s:else><s:textfield   maxlength="95" cssClass="sw" cssStyle='display:none'  name="receiveFileFileNumber" property="receiveFileFileNumber"  readonly="true"/><s:property  value="#request.receiveFileFileNumber" /></s:else></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF" >
                                    <td height="40" class="STYLE1" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;padding-left:10px;">秘密级别：</td>
                                    <td height="35" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;" align="left">
											<s:if test="p_wf_concealField.indexOf('$receiveFileSafetyGrade$') != -1 "><s:hidden  name="receiveFileSafetyGrade" property="receiveFileSafetyGrade"  /></s:if><s:elseif test="p_wf_cur_ModifyField.indexOf('$receiveFileSafetyGrade$') != -1"> <s:select name="receiveFileSafetyGrade" property="receiveFileSafetyGrade"  list="#request.receiveSecretLevelList" >
                                    </s:select>       </s:elseif><s:else><s:hidden  name="receiveFileSafetyGrade" property="receiveFileSafetyGrade"  /><s:property  value="#request.receiveFileSafetyGrade" /></s:else>
                                                                
									</td>
                                    <td height="35" align="center" class="STYLE1" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;padding-left:10px;">紧急程度：</td>
                                    <td height="35" style="border-bottom:#000000 solid 1px;" align="left">
									
									 <s:if test="p_wf_concealField.indexOf('$field4$') != -1 "><s:textfield   maxlength="95" cssClass="sw" style='display:none'  name="field4" property="field4"  readonly="true"/></s:if><s:elseif test="p_wf_cur_ModifyField.indexOf('$field4$') != -1"> <s:select name="field4" property="field4" disabled="false" list="#request.field4List"></s:select></s:elseif><s:else><s:textfield   maxlength="95" cssClass="sw" style='display:none'  name="field4" property="field4"  readonly="true"/><s:property  value="#request.field4" /></s:else>
									
									</td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF" >
                                    <td height="40" class="STYLE1" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;padding-left:10px;" for="标题">标&nbsp;&nbsp;题 <font color="red">*</font>：</td>
                                    <td height="35" style="border-bottom:#000000 solid 1px;" colspan="3" align="left">									
 									 
									  <s:if test="p_wf_concealField.indexOf('$receiveFileTitle$') != -1 ">
                                          <s:textfield   maxlength="95" cssClass="sw"  cssStyle="display:none"  name="receiveFileTitle" property="receiveFileTitle"  style="width:90%"   readonly="true"/>
                                      </s:if>
                                        <s:elseif test="p_wf_cur_ModifyField.indexOf('$receiveFileTitle$') != -1">
                                            <s:textfield style="width:90%"  maxlength="95" cssClass="sw"  name="receiveFileTitle" property="receiveFileTitle"  />
                                        </s:elseif>
                                        <s:else>
                                            <s:textfield   maxlength="95" cssClass="sw"   name="receiveFileTitle" property="receiveFileTitle"  style="width:90%"   readonly="true"/>
                                        </s:else>
                                   </td>
                                  </tr><!-- $accessoryNameFile$$accessoryName$  accessoryName1 accessoryName2 -->
                                  <tr bgcolor="#FFFFFF" >
                                    <td height="40" class="STYLE1" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;padding-left:10px;">正文内容：</td>
                                    <td height="35" style="border-bottom:#000000 solid 1px;" colspan="3" align="left">
                                    <%String modi_accessoryName1 = ((request.getAttribute("p_wf_cur_ModifyField")+"").indexOf("$accessoryName$") >= 0)?"yes":"no";%><table width="100%" border="0" cellpadding="0" cellspacing="1" id="govdocumenttable"><tr id="govTableName_accessoryName1_tr" ><td height="25"><input type="hidden" name="accessoryName1"  id="accessoryName1"  value="<%=request.getAttribute("accessoryName1")==null?"":request.getAttribute("accessoryName1").toString()%>"><input type="hidden" name="accessorySaveName1"  id="accessorySaveName1" value="<%=request.getAttribute("accessorySaveName1")==null?"":request.getAttribute("accessorySaveName1").toString()%>"><jsp:include page="/public/upload/uploadify/upload_include.jsp" ><jsp:param name="accessType"		 value="include" /><jsp:param name="makeYMdir"		 value="yes" /><jsp:param name="onInit"		     value="init" /><jsp:param name="onSelect"		 value="onSelect" /><jsp:param name="onUploadProgress"		 value="onUploadProgress" /><jsp:param name="onUploadSuccess"		 value="onUploadSuccess" /><jsp:param name="dir"		 value="govdocumentmanager" /><jsp:param name="uniqueId"    value="govdocumentmanager" /><jsp:param name="realFileNameInputId"    value="accessoryName1" /><jsp:param name="saveFileNameInputId"    value="accessorySaveName1" /><jsp:param name="canModify"       value="<%=modi_accessoryName1%>" /> <jsp:param name="width"		 value="90" /><jsp:param name="height"		 value="20" /><jsp:param name="multi"		 value="true" /><jsp:param name="buttonClass" value="upload_btn" /><jsp:param name="buttonText"		 value="上传文件" /><jsp:param name="fileSizeLimit"		 value="0" /><jsp:param name="uploadLimit"		 value="0" /></jsp:include>
                                    </td></tr><tr id="govTableName_accessoryName1"><td id="govTableName_accessoryName1_td"></td></tr></table></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF" >
                                    <td height="40" class="STYLE1" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;padding-left:10px;">附&nbsp;&nbsp;&nbsp; 件：</td>
                                    <td height="35" style="border-bottom:#000000 solid 1px;" colspan="3" align="left">
									 <%String modi_accessoryName2 = ((request.getAttribute("p_wf_cur_ModifyField")+"").indexOf("$accessoryNameFile$") >= 0)?"yes":"no";%><table width="100%" border="0" cellpadding="0" cellspacing="1" id="govdocumenttable"><tr id="govTableName_accessoryName2_tr" ><td height="25"><input type="hidden" name="accessoryName2"  id="accessoryName2"  value="<%=request.getAttribute("accessoryName2")==null?"":request.getAttribute("accessoryName2").toString()%>"><input type="hidden" name="accessorySaveName2"  id="accessorySaveName2" value="<%=request.getAttribute("accessorySaveName2")==null?"":request.getAttribute("accessorySaveName2").toString()%>">
                                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" >
                                            <jsp:param name="accessType"		 value="include" />
                                            <jsp:param name="makeYMdir"		 value="yes" />
                                            <jsp:param name="onInit"		     value="init" />
                                            <jsp:param name="onSelect"		 value="onSelect" />
                                            <jsp:param name="onUploadProgress"		 value="onUploadProgress" />
                                            <jsp:param name="onUploadSuccess"		 value="onUploadSuccess" />
                                            <jsp:param name="dir"		 value="govdocumentmanager" />
                                            <jsp:param name="uniqueId"    value="govdocumentmanager2" />
                                            <jsp:param name="realFileNameInputId"    value="accessoryName2" />
                                            <jsp:param name="saveFileNameInputId"    value="accessorySaveName2" />
                                            <jsp:param name="canModify"       value="<%=modi_accessoryName2%>" />
                                            <jsp:param name="width"		 value="90" />
                                            <jsp:param name="height"		 value="20" />
                                            <jsp:param name="multi"		 value="true" />
                                            <jsp:param name="buttonClass" value="upload_btn" />
                                            <jsp:param name="buttonText"		 value="上传文件" />
                                            <jsp:param name="fileSizeLimit"		 value="0" />
                                        <jsp:param name="uploadLimit"		 value="0" /></jsp:include>
                                    </td></tr><tr id="govTableName_accessoryName2"><td id="govTableName_accessoryName2_td"></td></tr></table>
                                    </td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF" >
                                    <td height="70" class="STYLE1" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;padding-left:10px;">拟办意见：</td>
                                    <td height="35" style="border-bottom:#000000 solid 1px;" colspan="3"><div id="receiveFileLeaderComment">&nbsp;</div></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF" >
                                    <td height="70" class="STYLE1" style="border-bottom:#000000 solid 1px;border-right:#000000 solid 1px;padding-left:10px;">领导批示：</td>
                                    <td height="35" style="border-bottom:#000000 solid 1px;" colspan="3"><div id="receiveFileLeaderComment">&nbsp;</td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF" >
                                    <td height="70" class="STYLE1" style="border-bottom:#000000 solid 4px;border-right:#000000 solid 1px;padding-left:10px;">办理结果：</td>
                                    <td height="35" style="border-bottom:#000000 solid 4px;" colspan="3"><div id="receiveFileTransAuditComment">&nbsp;</td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF" >
                                    <td height="35" style="border-bottom:#000000 solid 1px;display:none" colspan="6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td >类型：</td>
                                        <td>                                        </td>
										<s:hidden  name="zbstatus" value="0"/>
                                      </tr>
                                      
                                      <tr>
                                        <td>份数：</td>
                                        <td>
										 <s:textfield style="width:98%"  styleClass="sw" maxlength="5" class="sw"  size="8" name="receiveFileQuantity" property="sendFilePrintNum" />
										</td>
                                      </tr>
                                      <tr>
                                        <td>文件归类：</td>
                                        <td><s:select property="receiveFileType" disabled="false" list="#request.decumentKindList"></s:select></td>
                                      </tr>
                                      <tr>
                                        <td>文种：</td>
                                        <td><s:select property="zjkyType" disabled="false" list="#request.receiveFileTypeList"></s:select></td>
                                      </tr>
                                      <tr>
                                        <td>保管期限：</td>
                                        <td><s:select property="zjkykeepTerm" disabled="false" list="#request.keepTermList"></s:select></td>
                                      </tr>
                                      <tr>
                                        <td>批示内容：</td>
                                        <td><s:hidden  property="receiveFileDoComment" value="0"/>
										<s:hidden property="receiveFileDoComment"/>
										<s:textarea cols="102" styleClass="css0" rows="8" name="receiveFileDoComment" property="receiveFileDoComment"></s:textarea>
										</td>
                                      </tr>
                                      <tr>
                                        <td>field5</td>
                                        <td><s:textfield  size="35" styleClass="css0" property="field5" maxlength="20"  name="field5"/></td>
                                      </tr>
                                      <tr>
                                        <td>field6</td>
                                        <td><s:textfield  size="35" styleClass="css0" property="field6" maxlength="20"  name="field6"/></td>
                                      </tr>
                                      <tr>
                                        <td>field7</td>
                                        <td><s:textfield  size="35" styleClass="css0" property="field7" maxlength="20"  name="field7"/></td>
                                      </tr>
                                      <tr>
                                        <td>field8</td>
                                        <td><s:textfield  size="35" styleClass="css0" property="field8" maxlength="20"  name="field8"/></td>
                                      </tr>
                                      <tr>
                                        <td>field9</td>
                                        <td><s:textfield  size="35" styleClass="css0" property="field9" maxlength="20"  name="field9"/></td>
                                      </tr>
                                      <tr>
                                        <td>field10</td>
                                        <td><s:textfield  size="35" styleClass="css0" property="field10" maxlength="20"  name="field10"/></td>
                                      </tr>
                                      
                                    </table></td>
                                  </tr>
                             </table></td>
                            </tr>
                            <tr><td width="6%" height="35">&nbsp;</td></tr>
                           
                            <tr>
                              <td height="22" colspan="6" nowrap>
							 				 </td>
                            </tr>
                          </table>
                        </div></td>
						<!-- 要求发送继续后可以自动增加流水号START-->
							
					    <!-- 要求发送继续后可以自动增加流水号 END-->
                    </tr>
                  </table>