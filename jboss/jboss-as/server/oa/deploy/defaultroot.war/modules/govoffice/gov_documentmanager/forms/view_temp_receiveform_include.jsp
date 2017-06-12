<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
com.whir.ezoffice.ezform.util.ModuleParser parser = new com.whir.ezoffice.ezform.util.ModuleParser();
String  read_recordId=(String)request.getAttribute("p_wf_recordId");
String formId=read_recordId;
String read_tableId=request.getAttribute("p_wf_tableId").toString();
%>
<%
String noWriteField = "";
String curUserID = session.getAttribute("userId").toString();
//附件
String  accessoryName=request.getAttribute("accessoryName")==null?"":request.getAttribute("accessoryName").toString();
String  accessorySaveName=request.getAttribute("accessorySaveName")==null?"":request.getAttribute("accessorySaveName").toString();
//参考附件
String  referenceAccessory=request.getAttribute("referenceAccessory")==null?"":request.getAttribute("referenceAccessory").toString();
String  referenceAccessorySaveName=request.getAttribute("referenceAccessorySaveName")==null?"":request.getAttribute("referenceAccessorySaveName").toString();
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



<govContent></govContent>
					
		

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

  if($("input[name='content']")[0].value==""){
      alert("您还没有起草正文！");
      return false;
  
  }
  return true;
}
</script>