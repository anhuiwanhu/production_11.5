<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
  <%
  String noWriteField = "";
  //System.out.println("eeeeeeeeeeeeeeeee:"+	request.getAttribute("sendFileTitle") );
  //System.out.println("vvvvvvvvvvvvvvvvv:"+	com.opensymphony.xwork2.ActionContext.getContext().getValueStack().findString("sendFileTitle") );
  //org.apache.struts2.ServletActionContext.getContext().getValueStack().setValue("noWriteField", "11");
 // com.opensymphony.xwork2.ActionContext.getContext().getValueStack().getContext().put("noWriteField", "11");
   // com.opensymphony.xwork2.ActionContext.getContext().getValueStack().setValue("noWriteField", "11");
	//org.apache.struts2.ServletActionContext.getValueStack(request).setValue("noWriteField", "11");
//  request.setAttribute("noWriteField","11");
  
String curUserID = session.getAttribute("userId").toString();
//List  list = new NewEmployeeBD().selectSingle(new Long(curUserID));
//Object[] object = (Object[]) list.get(0);
//EmployeeVO vo = (EmployeeVO)object[0];
//String telephone = vo.getEmpBusinessPhone()==null?"":vo.getEmpBusinessPhone();

//附件
String  accessoryName=request.getAttribute("accessoryName")==null?"":request.getAttribute("accessoryName").toString();
String  accessorySaveName=request.getAttribute("accessorySaveName")==null?"":request.getAttribute("accessorySaveName").toString();


//参考附件
String  referenceAccessory=request.getAttribute("referenceAccessory")==null?"":request.getAttribute("referenceAccessory").toString();
String  referenceAccessorySaveName=request.getAttribute("referenceAccessorySaveName")==null?"":request.getAttribute("referenceAccessorySaveName").toString();





String  read_recordId=request.getParameter("sendFileId");


 String nowYearInt= (new java.util.Date().getYear()+1900)+"";

 String[] realFileArray = new String[0];
 String[] saveFileArray = new String[0];
java.util.Date sendFileDate = new java.util.Date() ;
java.util.Date sendFileSendDate = new java.util.Date();
java.util.Date documentCreateTime=new java.util.Date();
java.util.Date signsendTime=new java.util.Date();

if(request.getAttribute("sendFileDate")!=null)
    sendFileDate =  (java.util.Date)request.getAttribute("sendFileDate") ;
if(request.getAttribute("sendFileSendDate")!=null)
    sendFileSendDate =  (java.util.Date)request.getAttribute("sendFileSendDate") ;

if(request.getAttribute("documentCreateTime")!=null&&!request.getAttribute("documentCreateTime").toString().equals("")){
  documentCreateTime=(java.util.Date)request.getAttribute("documentCreateTime");
}
if(request.getAttribute("signsendTime")!=null&&!request.getAttribute("signsendTime").toString().equals("")){
  signsendTime=(java.util.Date) request.getAttribute("signsendTime");
}
 int createTimeYear= documentCreateTime.getYear()+1900;
int createTimeMonth= documentCreateTime.getMonth()+1;
int createTimeDate= documentCreateTime.getDate();
String createTimeStr=""+createTimeYear+"/"+createTimeMonth+"/"+createTimeDate;

if(accessoryName.equals("")||accessoryName.equals("null")){

  accessoryName=request.getParameter("accessoryName")==null?"":request.getParameter("accessoryName").toString();
}
if(accessorySaveName.equals("")||accessorySaveName.equals("null")){

  accessorySaveName=request.getParameter("accessorySaveName")==null?"":request.getParameter("accessorySaveName").toString();
}
String  contentAccName=request.getAttribute("contentAccName")==null?"":request.getAttribute("contentAccName").toString();
String contentAccSaveName=request.getAttribute("contentAccSaveName")==null?"":request.getAttribute("contentAccSaveName").toString();

  
  %>

<input type="hidden" name="htmlContent">
<input type="hidden" name="content" value="<%=request.getAttribute("content")%>">
<s:hidden property="sendFileLink"/>

<input type="hidden" name="oldTitle" >
<input type="hidden" name="oldToPerson1">
<input type="hidden" name="oldToPerson2">
<input type="hidden" name="oldToInnner">

<input type="hidden" name="sendSeqId">
<input type="hidden" name="sendSeqfig">
<input type="hidden" name="done">
<input type="hidden" name="editId" value="<%=read_recordId%>">
<s:hidden  property="sendFilePoNumId" />
<s:hidden  property="templateId" />
<s:hidden  property="zjkyWordId"  />

<s:hidden property="toPerson3"/>
<s:hidden property="toPerson4"/>
<s:hidden property="toPerson5"/>
<s:hidden property="toPerson6"/>

<s:hidden property="documentWordType"/>
<input type="hidden" name="candidateId">
<input type="hidden" name="candidate">
<input type="hidden" name="addDivContent" value="">
<input type="hidden" name="whichBatch" value="">
<input type="hidden" name="isInModify" value="">
<input type="hidden" name="contentAccName" value="<%=contentAccName%>">
<input type="hidden" name="contentAccSaveName" value="<%=contentAccSaveName%>">
<input type="hidden" name="sendToMyId" >
<input type="hidden" name="sendToMyName">
<input type="hidden" name="sendToType" value="0">
<input type="hidden" name="documentCreateTime" value="<%=createTimeStr%>">
<input type="hidden" name="sendFileNeedSendMsg2" value="0">
<input type="hidden" name="sendFileNeedRTX" value="0">
<input type="hidden" name="sendFileNeedMail" value="0">
<input type="hidden" name="isSendToMyOther" value="0">
<input type="hidden" name="isSyncToInfomation" value="<%=request.getAttribute("isSyncToInfomation")==null?"0":request.getAttribute("isSyncToInfomation").toString()%>"/>
<s:hidden property="sendFileText"/>
<s:hidden property="sendFileType"/>
<s:hidden property="sendFileRedHeadId"/>
<s:hidden property="documentSendFileHead" value="-1" />
<s:hidden  property="field1" />
<input type="hidden" name="field2" value="<%=!"1".equals(request.getParameter("newResubmit"))?(request.getAttribute("field2")==null?"":request.getAttribute("field2")):""%>"/>
<s:hidden   property="field6" />
<s:hidden property="toPerson1Id"/>	
<s:hidden property="toPerson2Id"/>
<s:hidden property="toPersonInnerId"/>
<s:hidden property="toPersonBaoId"/>
<s:hidden property="field5"/>

<input type="hidden" name="field3" value="<%=request.getAttribute("field3")==null?nowYearInt:request.getAttribute("field3").toString()%>">
<input type="hidden" name="handOutTime" value="<%=request.getAttribute("handOutTime")==null?"":request.getAttribute("handOutTime").toString()%>">
<input type="hidden" id="sendToMyRange" name="sendToMyRange" value="<%=request.getAttribute("sendToMyRange")==null?"":request.getAttribute("sendToMyRange").toString()%>">
<input type="hidden" name="createdEmp" value="<%=request.getAttribute("createdEmp")==null?"":request.getAttribute("createdEmp").toString()%>">
<input type="hidden" name="createdOrg" value="<%=request.getAttribute("createdOrg")==null?"":request.getAttribute("createdOrg").toString()%>">
 <input type="hidden" name="done"/>

<!--

<table width="100%" border="0" cellpadding="1" cellspacing="0" class="docBox" style="background-color:#ffffff;border:0px;">
  <tr>
    <td height="312" valign="top">
	
	  <div >
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
                      <td align="right" valign="middle"><div align="center">
                          <table width="80%" border="0" align="center" cellpadding="1" cellspacing="1">
                             
                     
							
							 
	                          <tr>
							  <td width="100%">--><table width="100%" border="0" cellpadding="0" cellspacing="0">					      
							     <tr>
							       <td colspan="6" align="center" style="border-bottom:#FF0000 solid 4px; font-weight:bold;font-size:30px;color:#FF0000"><s:property  value="#request.p_wf_processName" /></td>
						          </tr>
							     <tr>
							       <td width="10%" height="70" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><span class="STYLE1"><font color="#FF0000">签&nbsp;&nbsp;&nbsp; 发：</font></span></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><div id="documentSendFileSendFile_commentfield" style="text-align:left;<s:if test="p_wf_concealField.indexOf('$documentSendFileSendFile$') != -1 ">display:none</s:if>"></div>&nbsp;</td>
						           <td colspan="-1" align="left" class="STYLE1" style="border-bottom:#FF0000 solid 1px;border-left:#FF0000 solid 1px;"><font color="#FF0000">&nbsp;审核意见：</font></td>
						           <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><div id="documentSendFileCheckCommit_commentfield"  style="text-align:left;<s:if test="p_wf_concealField.indexOf('$documentSendFileCheckCommit$') != -1 ">display:none</s:if>"></div>&nbsp;</td>
					              </tr>
							     <tr>
							       <td height="70" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><span class="STYLE1"><font color="#FF0000">会&nbsp;&nbsp;&nbsp; 签：</font></span></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><div id="sendFileMassDraft_commentfield"  style="text-align:left;<s:if test="p_wf_concealField.indexOf('$sendFileMassDraft$') != -1 ">display:none</s:if>"></div>&nbsp;</td>
							       <td colspan="-1" align="left" class="STYLE1" style="border-bottom:#FF0000 solid 1px;border-left:#FF0000 solid 1px;"><font color="#FF0000">&nbsp;核&nbsp;&nbsp;&nbsp;稿：</font></td>
							       <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><div id="sendFileProveDraft_commentfield"  style="text-align:left;<s:if test="p_wf_concealField.indexOf('$sendFileProveDraft$') != -1 ">display:none</s:if>"></div>&nbsp;</td>
						         </tr>
							     <tr>
							       <td height="70" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><span class="STYLE1"><font color="#FF0000">审阅意见：</font></span></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><div id="sendFileReadComment_commentfield"  style="text-align:left;<s:if test="p_wf_concealField.indexOf('$sendFileReadComment$') != -1 ">display:none</s:if>"></div>&nbsp;</td>
							       <td colspan="-1" align="left" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;border-left:#FF0000 solid 1px;"><font color="#FF0000">&nbsp;承办单位意见：</font></td>
							       <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><div id="documentSendFileAssumeUnit_commentfield"  style="text-align:left;<s:if test="p_wf_concealField.indexOf('$documentSendFileAssumeUnit$') != -1 ">display:none</s:if>"></div>&nbsp;</td>
						         </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000" class="STYLE1">附&nbsp;&nbsp;&nbsp; 件：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                    
                                      




<table width="100%" border="0" cellpadding="0" cellspacing="1" id="govdocumenttable">
    <tr id="modiUploadtr" >
        <td height="25">
 
			

			
   <input type="hidden" name="accessoryName"  id="accessoryName"  value="<%=accessoryName%>">
  <input type="hidden" name="accessorySaveName"  id="accessorySaveName" value="<%=accessorySaveName%>">
  <s:if test="p_wf_concealField.indexOf('$accessoryName$')  < 0 ">
<jsp:include page="/public/upload/uploadify/upload_include.jsp" > 
   <jsp:param name="accessType"		 value="include" />
   <jsp:param name="makeYMdir"		 value="yes" />
   <jsp:param name="onInit"		     value="init" />
   <jsp:param name="onSelect"		 value="onSelect" />
   <jsp:param name="onUploadProgress"		 value="onUploadProgress" />
   <jsp:param name="onUploadSuccess"		 value="onUploadSuccess" />
   <jsp:param name="dir"		 value="govdocumentmanager" />
   <jsp:param name="uniqueId"    value="govdocumentmanager" />
   <jsp:param name="realFileNameInputId"    value="accessoryName" />
   <jsp:param name="saveFileNameInputId"    value="accessorySaveName" />
   <jsp:param name="canModify"       value="no"  />
   <jsp:param name="width"		 value="90" />
   <jsp:param name="height"		 value="20" />
   <jsp:param name="multi"		 value="true" />
   <jsp:param name="buttonClass" value="upload_btn" />
   <jsp:param name="buttonText"		 value="上传文件" />
   <jsp:param name="fileSizeLimit"		 value="0" />
   <jsp:param name="uploadLimit"		 value="0" />
</jsp:include>
	</s:if>

        </td>
    </tr>
    <tr id="govdocumenttable_tr">
        <td id="govdocumenttable_td">
        
        </td>
    </tr>
</table>
<input type="hidden" name="saveFileNameTemp_0_1" value="">

<table style="display:none">
   <tr>
       <td>
           <iframe id="delFile" name="delFile" src=""></iframe>
           <input type="hidden" name="deletedFileNames" id="deletedFileNames" value="">
		   <input type="hidden" name="allAttachSize" value="0">
        </td>
   </tr>
</table>

                                                                    </td>
						          </tr>
							     <tr>
							       <td width="10%" height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文&nbsp;&nbsp;&nbsp; 头：</font></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;" align="left">
										 

										<gov:field name="sendFileDepartWord" id="sendFileDepartWord" list="wordlist" field="sendFileDepartWord"/>
                                    </td>
						           <td width="10%" colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">字&nbsp;&nbsp;&nbsp; 号：</font></td>
						           <td width="10%" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
								   		<gov:field name="documentSendFileByteNumber" id="documentSendFileByteNumber"  field="documentSendFileByteNumber"  />
										 <s:hidden name="documentSendFileByteNumber"/>
								  </td>
						           <td width="10%" align="right" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">办理缓急：</font></td>
						           <td width="20%" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left"> 
                                     	<gov:field name="sendFileGrade" id="sendFileGrade" list="transactLevel"  field="sendFileGrade" />&nbsp; 
									
                                  </td>
							     </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文件标题：</font></td>
							       <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
								     <gov:field name="documentSendFileTitle" id="documentSendFileTitle"  field="sendFileTitle" /> 
									 <s:hidden name="documentSendFileTitle" />
								  </td>
								  <td width="10%" colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文件种类：</font></td>
						           	<td width="10%" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left"><gov:field name="documentFileType" id="documentFileType"  list="fileTypeArr"  field="documentFileType"/> 
									</td>
						          </tr>
							     <!--tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">主&nbsp;题&nbsp;词：</font></td>
							       <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
										<gov:field name="documentSendFileTopicWord" id="documentSendFileTopicWord"  styleClass="sw" style="width:80%"   field="documentSendFileTopicWord" /> 
                                    </td>
									</td>
									<td width="10%" colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文件种类：</font></td>
						           	<td width="10%" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left"><gov:field name="documentFileType" id="documentFileType"  list="fileTypeArr"  field="documentFileType"/> 
									</td>
						          </tr-->
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">主&nbsp;&nbsp;&nbsp; 送：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
                                     <gov:field name="toPerson1" id="toPerson1"   field="toPerson1" list="issueUnitList"/> 
                                     <!--<button class="btnButton2Font" onClick="openEndowSend('toPerson1');">选择</button>-->
                                   </td>
								 </tr>
							
                                   
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">抄&nbsp;&nbsp;&nbsp; 送：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
                                     <gov:field name="toPerson2" id="toPerson2" field="toPerson2" list="issueUnitList"/> 
                                      <!--<button class="btnButton2Font" onClick="openEndowSend('toPerson2');">选择</button>-->
                                   </td>
								 </tr>
								
                                   
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">拟稿单位：</font></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
								     <gov:field name="documentSendFileWriteOrg" id="documentSendFileWriteOrg"  styleClass="sw"  field="documentSendFileWriteOrg"/> 
                                    
                                   </td>
						           <td colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">会签单位：</font></td>
						           <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
									 <gov:field name="documentSendFileCounterSign" id="documentSendFileCounterSign"  styleClass="sw" field="documentSendFileCounterSign"/> 
                                   </td>
						           <td align="right" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">拟稿人：</font></td>
						           <td nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
									 <gov:field name="sendFileDraft" id="sendFileDraft"  styleClass="sw"  field="sendFileDraft"/> 
                                   </td>
							     </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">公开属性：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
									 <gov:field name="openProperty" id="openProperty" list="openPropertyArr"  field="openProperty"/> 
                                   </td>
					              </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">签发日期：</font></td>
							       <td width="80" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
											<gov:field name="signsendTime" id="signsendTime"   field="signsendTime"/> 
									</td>
						           <td colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">共&nbsp;&nbsp;&nbsp; 印：</font></td>
						           <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
                                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td>
                                           <gov:field name="documentSendFilePrintNumber" id="documentSendFilePrintNumber"  styleClass="sw"  field="documentSendFilePrintNumber"/> 
                                         </td>
                                        <td align="left"><font color="#FF0000">份</font></td>
                                      </tr>
                                    </table>                                   </td>
						           <td colspan="2" align="right" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                     <gov:field name="documentSendFileSendTime" id="documentSendFileSendTime"  field="documentSendFileSendTime"/> 
        							<font color="#FF0000">印发</font>
								  </td>
					              </tr>
							    </table>

<script>

/**
**/
function  judgeSpword(){

       if(document.all.documentSendFileTitle.value.indexOf("'") >= 0||document.all.documentSendFileTitle.value.indexOf("\"") >= 0||document.all.documentSendFileTitle.value.indexOf("/") >= 0||document.all.documentSendFileTitle.value.indexOf("\\") >= 0||document.all.documentSendFileTitle.value.indexOf("\|") >= 0||document.all.documentSendFileTitle.value.indexOf("<") >= 0||document.all.documentSendFileTitle.value.indexOf(">") >= 0){
	     	alert("标题中不能包含\ /,\\,:,\",?,*, <,>,\|,'");
			return  false;
		}
	 return true;
}

//检查页面参数有效性
function initPara() {
 
  if($("input[name='documentSendFileTitle']")[0].value==""){
    alert("标题不能为空！");
    return false;
  }

  if($("input[name='documentSendFileTitle']")[0].value.indexOf("#")>0){
     alert("标题不能含'#'");
     return false;
  }


 // if(!judgeSpword()){
	//return false;
  //}

 //if(!isPhone(document.all.field10)){
  // return false;
 // }
  
  if($("input[name='content']")[0].value==""){
      alert("您还没有起草正文！");
      return false;
  
  }
  return true;
	/*
   if (checkTextLengthOnly(GovSendFileActionForm.documentSendFileTopicWord,200,"主题词")&& checkTextLengthOnly(GovSendFileActionForm.field1,20,"文号")&&checkNumber(GovSendFileActionForm.field2,"发文序号",99999)&&checkText(GovSendFileActionForm.documentSendFileTitle,95,"发文标题")&& checkNumber(GovSendFileActionForm.documentSendFilePrintNumber,"份数",9999)&&checkTextLengthOnly(GovSendFileActionForm.sendFileAccessoryDesc,500,"附件描述")&&checkTextLengthOnly(GovSendFileActionForm.toPerson1,200,"主送")&&checkTextLengthOnly(GovSendFileActionForm.toPersonBao,200,"抄报")&&checkTextLengthOnly(GovSendFileActionForm.toPerson2,200,"抄送")&&checkTextLengthOnly(GovSendFileActionForm.toPersonInner,200,"内部发送")
    ){
	 
	setNewUpdate();
	trimrnTitle();//去掉 标题与 附件描述的 换行
	return true;

   }else{
   
    return false;
   }*/
}

/**
保存草稿
*/
function draftSave(){

	if(!initPara()) return;
	$('#dataForm').submit();
	//ok(0,$('#dataForm'));
}

//邮件转发
function transmit(){
	 var  toId=document.all.candidateId.value;
	 var  toName=document.all.candidate.value;
	 var  editId=document.all.editId.value;
	 
	  if(toName==""){
	   alert("请选择接收者");
	   return;
	  }
	  document.all.GovSendFileActionForm.action="< %=rootPath% >/GovSendFileAction.do?action=mailtransmit&toId="+toId+"&toName="+toName+"&editId="+editId+"&isEdit=1";
	  document.all.GovSendFileActionForm.submit();
}

//分发范围
function sendToMyRange_show(){
	//alert(1);
	window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	$("form[name='sendToMyForm']")[0].target="target";
	$("form[name='sendToMyForm'] input[name='sendFileId']")[0].value = $("input[name='editId']")[0].value;//.submit();
	$("form[name='sendToMyForm']")[0].submit();
	//document.sendToMyForm.target="target";
	//document.sendToMyForm.sendFileId.value = document.all.editId.value;
	//document.sendToMyForm.submit();
}


// 发文分发
function sendToMy(){
//< %=sendStatus% >

	var  toId=$("input[name='sendToMyId']")[0].value;
	//alert(1);
	var  toName=$("input[name='sendToMyName']")[0].value; //document.all.sendToMyName.value;
	//alert(2);
	var  editId=$("input[name='editId']")[0].value;//document.all.editId.value;

	if(toName==""){
	    alert("请选择接收者");
	    return;
	}
	//$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=&isSendToMyOther="+document.all.isSendToMyOther.value);
	
	$("form[name='GovSendFileActionForm']")[0].target="ifrm1";
	$("form[name='GovSendFileActionForm']")[0].submit();
	$("form[name='GovSendFileActionForm']")[0].target="";
	//document.all.GovSendFileActionForm.target="ifrm1";//发送不关闭
	//document.all.GovSendFileActionForm.submit();
	//document.all.GovSendFileActionForm.target="";
}

//补发
function cmdSendToMyOther(){
	window.open( "","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300" );
	$("form[name='sendToMyOtherForm']")[0].target="" ;
	$("form[name='sendToMyOtherForm']")[0].submit()  ;
	//document.sendToMyOtherForm.target="target";
	//document.sendToMyOtherForm.submit();
}


//下载文件
function cmdDowntext(){
		
	
}

//补发直接发送
function supplySend(){
    if(!initPara()) return;

	if($("input[name='sendToId2']")[0].value==""){
		window.alert("请选择要发送的人！");
		return;
	}

	$("form[name='GovSendFileActionForm']")[0].action="target";
	$("form[name='GovSendFileActionForm']")[0].submit();
    //GovSendFileActionForm.action = "< %=rootPath% >/GovSendFileAction.do?action=supplySend";
    //GovSendFileActionForm.submit();
}

</script>