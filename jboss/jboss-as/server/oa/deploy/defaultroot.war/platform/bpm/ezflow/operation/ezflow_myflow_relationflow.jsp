<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.whir.i18n.Resource"%>
<%@page import="java.util.*"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String processInstanceId=request.getParameter("processInstanceId")==null?"":request.getParameter("processInstanceId").toString();
String  openType=request.getParameter("openType")==null?"":request.getParameter("openType").toString();
%>
<html>
<head>
	<title>标准列表页面结构</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body bgcolor="#ffffff">

<%
//父流程 子流程相关  不可删除
java.util.List listRelationWork = new java.util.ArrayList();

//相关流程  可删除
java.util.List listRelationProcess = new java.util.ArrayList();
if(processInstanceId!=null&&!processInstanceId.equals("null")&&!processInstanceId.equals("")){
    com.whir.service.api.ezflowservice.EzFlowRelationProcessService  relationService=new com.whir.service.api.ezflowservice.EzFlowRelationProcessService();
    listRelationProcess=relationService.findRelationProcess(processInstanceId);

}

int  relationSize=0;
%>
<div>&nbsp;</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="SubTable"  id="relationProcessTable" >
  <tr class="subTitle">
    <td><bean:message bundle="workflow" key="workflow.SubmitOrganization"/><!-- 报送单位 --></td>
    <td width="10%" nowrap><bean:message bundle="workflow" key="workflow.SubmitTime"/><!-- 报送时间 --></td>
    <td  width="35%" nowrap><bean:message bundle="workflow" key="workflow.Title"/><!-- 标题 --></td>
    <td><bean:message bundle="workflow" key="workflow.ProcessStatus"/><!-- 办理状态 --></td>
    <td><!-- 报送人 --><!--bean:message bundle="workflow" key="workflow.ProcessPerson"/--><bean:message bundle="filetransact" key="file.people"/></td>
	 <td><!-- 报送人 --><!--bean:message bundle="workflow" key="workflow.ProcessPerson"/--><bean:message bundle="common" key="comm.opr" /></td>
  </tr>
  <%
	  //父流程 子流程
	  if(listRelationWork!=null&&listRelationWork.size()>0){
		  for(int i=0;i<listRelationWork.size();i++){
		      String[] rWork=(String[])listRelationWork.get(i);
		      relationSize++;
		  %>
		  <tr >
			<td class="subTitleList"><%=rWork[0]%></td>
			<td class="subTitleList"><%=rWork[1]%></a></td>
			<td class="subTitleList"><a href="javascript:" onclick="javascript:window.open(encodeURI('<%=rWork[5]%>'),'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600');");"><%=rWork[2]%></td>
			<td class="subTitleList"><%=rWork[3]%></td>
			<td class="subTitleList"><%=rWork[4]%>&nbsp</td>
			<td class="subTitleList">&nbsp;</td>
		  </tr>
  <% 
	    }
	}
  %>

  <%
	   String startOrg="";
	   String startTime="";
	   String title="";
	   String nowActivitys="";
	   String pId="";
	   String nowStauts="";
	   String nowUsers="";
	   String strartUser="";
	   String busnessKey="";

	   String pr_pId="";
	   String pr_r_pId="";
	   Map  rMap=new HashMap();
	   com.whir.ezflow.util.EzFlowDateUtil ezFlowDateUtil=new com.whir.ezflow.util.EzFlowDateUtil();
	   com.whir.component.security.crypto.EncryptUtil encryptUtil =new com.whir.component.security.crypto.EncryptUtil(request);
	   String verifyCode="";
	   //相关流程
	   if(listRelationProcess!=null&&listRelationProcess.size()>0){
		   for(int i=0;i<listRelationProcess.size();i++){
			 rMap=(Map)listRelationProcess.get(i);
			 startOrg=rMap.get("WHIR_STARTORGNAME")==null?"&nbsp;":rMap.get("WHIR_STARTORGNAME").toString();
			 strartUser=rMap.get("WHIR_STARTUSERNAME")==null?"&nbsp;":rMap.get("WHIR_STARTUSERNAME").toString();
			 title=rMap.get("WHIR_REMINDTITLE")==null?"&nbsp;":rMap.get("WHIR_REMINDTITLE").toString();
			 nowActivitys=rMap.get("WHIR_DEALING_ACTIVITY")==null?"&nbsp;":rMap.get("WHIR_DEALING_ACTIVITY").toString();
			 nowUsers=rMap.get("WHIR_DEALING_USERS")==null?"&nbsp;":rMap.get("WHIR_DEALING_USERS").toString();
			 nowStauts=rMap.get("WHIR_STATUS")==null?"":rMap.get("WHIR_STATUS").toString();
			 pId=rMap.get("PROC_INST_ID_").toString();
			 startTime=ezFlowDateUtil.covertTimestampToStr(rMap.get("START_TIME_"));	 
			 busnessKey=rMap.get("BUSINESS_KEY_").toString();
             pr_pId=rMap.get("PR_PID").toString();
			 pr_r_pId=rMap.get("PR_R_PID").toString();		 
			 //办理完毕
			 if(nowStauts.equals("100")){
			     nowActivitys=Resource.getValue(local, "workflow", "workflow.Transacted");//"办理完毕";
                 nowUsers="&nbsp;"; 
			 }  
			 if(nowStauts.equals("-1")){
			    nowActivitys=Resource.getValue(local, "workflow", "workflow.Return");//"退回";
				nowUsers="&nbsp;"; 
			 }
			 if(nowStauts.equals("-2")){
				nowActivitys=Resource.getValue(local, "workflow", "workflow.Cancel");//"取消";
				nowUsers="&nbsp;"; 
			 }
			 if(nowStauts.equals("-3")){
				nowActivitys=Resource.getValue(local, "workflow", "workflow.newactivitybuttondelete");//"作废";
				nowUsers="&nbsp;"; 		 
			 }
			 if(nowStauts.equals("-4")){
			    nowActivitys=Resource.getValue(local, "workflow", "workflow.Return");//"退回";
				nowUsers="&nbsp;"; 
			 }
				
		    /*String[] rProcess=(String[])listRelationProcess.get(i);
		    if(rProcess[6].equals(request.getParameter("table")) && rProcess[7].equals(request.getParameter("record"))){
			  continue;
		    }*/

			verifyCode=encryptUtil.getSysEncoderKeyVlaue("p_wf_processIntanceId", pId, "WFDealWithAction");
		    relationSize++;
	  %>
		  <tr  id="TR_<%=pId%>">
			<td class="subTitleList"><%=startOrg%></td>
			<td class="subTitleList"><%=startTime%></td>
			<td class="subTitleList"><a href="javascript:openWorkFlow('','<%=pId%>','','<%=verifyCode%>')"> <%=title%></a></td>
			<td class="subTitleList"><%=nowActivitys%>&nbsp</td>
			<td class="subTitleList"><%=nowUsers%>&nbsp;</td>
			<td style="display:" class="subTitleList"><%if(openType!=null&&openType.equals("waitingDeal")){%><img src="<%=rootPath%>/images/del.gif" onclick="delRelationWork('<%=pId%>','<%=pr_pId%>','<%=pr_r_pId%>');" style="cursor:hand" title="<bean:message bundle="common" key="comm.sdel"/>"><%}%>&nbsp;<input type="hidden" name="pr_pId_r_pId" value="<%=pr_pId%>,<%=pr_r_pId%>"></td>
 
		  </tr>
  <%  }   
	}
  %>
</table> 
<input type="hidden" id="p_wf_relationallsize" name="p_wf_relationallsize" value="<%=relationSize%>">
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--

/*
//显示数量
 if(parent.document.all.Panle6){
	 <%if(relationSize>0){%>
     parent.document.all.Panle6.innerHTML="关联流程(<font color='red'><%=relationSize%></font>)" ;
	<%}%>
 }


 if(document.all.relationTitleSpan){
	 <%if(relationSize>0){%>
      document.all.relationTitleSpan.innerHTML="(<%=relationSize%>)" ;
	<%}%>
 }
 


  if(parent.document.all.RWorkTitle){
	<%if(relationSize>0){%>
     parent.document.all.RWorkTitle.innerHTML="关联流程(<font color='red'><%=relationSize%></font>)" ;
	<%}%>
 }*/
/* 




function  openProcess(processInstanceId,businesskey){
    var url='<%=rootPath%>/EzFlowOpenAction.do?action=updateOpen&processInstanceId='+processInstanceId+
		"&ezflowBusinessKey="+businesskey+'&openType=other';
    MM_openBrWindow(url,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=500,height=280');
} */



//打开流程
function  openWorkFlow(ezFlowTaskId,ezFlowProcessInstanceId, ezFlowTaskId_verifyCode,ezFlowProcessInstanceId_verifyCode){
    var openurl="<%=rootPath%>/ezflowopen!updateProcess.action?p_wf_processInstanceId="+ezFlowProcessInstanceId+"&verifyCode="+ezFlowProcessInstanceId_verifyCode+"&p_wf_openType=relation";	
	openWin({url:openurl,width:850,height:750,winName:'openWorkFlow'+ezFlowProcessInstanceId});
}


 //中间环节关联删除
function delRelationWork(pId,pr_pId,pr_r_pId){  
	var url="<%=rootPath%>/ezflowoperate!deleteRelation.action?pr_pId="+pr_pId+"&pr_r_pId="+pr_r_pId;

    var html = $.ajax({url: url,async: false}).responseText;  	
	whir_alert("<%=Resource.getValue(local,"workflow","workflow.deleteSuccess")%>",function(){});
	refreshRelation();
}

/**
新增流程删除相关附件
*/
function  delRelationProcess_add(obj){
	$(obj).parent().parent().remove();
}



//-->
</SCRIPT>
</html>
 