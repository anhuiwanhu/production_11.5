<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>查看发文</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<!--工具栏按钮 公用js-->
   <!--工作流包含页 js文件-->  
   <%@ include file="/public/include/meta_base_bpm.jsp"%>

	<script src="<%=rootPath%>/modules/govoffice/gov_documentmanager/js/send_v.js"   type="text/javascript"></script>

	<style type="text/css">
	<!--
	.sw {
		background:transparent;
		border-top-width: 0px;
		border-right-width: 0px;
		border-bottom-width: 1px;
		border-left-width: 0px;
		border-top-style: solid;
		border-right-style: solid;
		border-bottom-style: solid;
		border-left-style: solid;
		border-bottom-color: #CCCCCC;
	}

	#noteDiv_toPerson1 {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	#noteDiv_toPersonBao {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	#noteDiv_toPerson2 {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	.divOver{
		background-color:#003399;
		color:#FFFFFF;
		border-bottom:1px dashed #cccccc;
		width:100%;
		height:20px;
		line-height:20px;
		cursor:default;
		padding-left:5px;
	}
	.divOut{
		background-color:#ffffff;
		color:#000000;
		border-bottom:1px dashed #cccccc;
		width:100%;
		height:20px;
		line-height:20px;
		cursor:default;
		padding-left:5px;
	}
	.STYLE1,.STYLE1 font,.STYLE1 text,.STYLE1 textarea{font-size: 14px; font-family:"宋体"}
	
	-->
	</style>
	<style>
	<!--
	@media print{


		.noprint{

		   display:none

		}

	}
	-->
	</style>
	<style type="text/css">
        <%if( !"1".equals( request.getParameter("isPrint"))){ %> html,body{ height:100%; overflow:hidden; margin:0; padding:0;}<%}%>
    </style>

    <script type="text/javascript">
   <%if( !"1".equals( request.getParameter("isPrint"))){ %> $(function(){
     var bh = $("body").height();
     var dh = bh-47;
     $("#mainContent").height(dh);
    });
	<%}%>
    </script>
</head>
<body    onload="initBody();" <%if( !"1".equals( request.getParameter("isPrint"))){ %>class="docBodyStyle" style="position:relative; height:100%;" <%}else{%>scroll=yes<%}%> ><!--scroll=yes   -->
<%request.removeAttribute("p_wf_cur_ModifyField");  
/// 控制按纽出现 
//String workStatus = request.getAttribute("p_wf_workStatus")==null?"":(String)request.getAttribute("p_wf_workStatus").toString();
   String sendStatus=request.getAttribute("sendStatus")==null?"0":request.getAttribute("sendStatus").toString();
   String modiButton = ",Toreceive,DepartSend,Hasread,Noread,SendToMyRange,GovRead";

   String workStatus=request.getParameter("workStatus")==null?"-3":request.getParameter("workStatus").toString();

      if(request.getParameter("myFile")!=null&&request.getParameter("myFile").toString().equals("1")){
		
		String queryNumber=request.getParameter("queryNumber")==null?"":request.getParameter("queryNumber").toString();
		String queryTitle=request.getParameter("queryTitle")==null?"":request.getParameter("queryTitle").toString();
		String queryOrg=request.getParameter("queryOrg")==null?"":request.getParameter("queryOrg").toString();

		String _page_off=request.getParameter("pager.offset")==null?"0":request.getParameter("pager.offset").toString();
		String tag=request.getParameter("tag")==null?"0":request.getParameter("tag").toString();
		
		String queryItem = request.getParameter("queryItem")==null?"":request.getParameter("queryItem");
		String queryBeginDate = request.getParameter("queryBeginDate")==null?"":request.getParameter("queryBeginDate");
		String queryEndDate = request.getParameter("queryEndDate")==null?"":request.getParameter("queryEndDate");

		String toMe = request.getParameter("toMe")==null?"":request.getParameter("toMe");
		%>
     <script>
		//	var myUrl = "GovReceiveFileBoxAction.do?action=list&queryNumber=<%=queryNumber%>&queryTitle=<%=queryTitle%>&queryOrg=<%=queryOrg%>&pager.offset=<%=_page_off%>&tag=<%=tag%>";
			<%if(!"".equals(queryItem)){%>
			//	myUrl += '&queryItem=<%=queryItem%>&queryBeginDate=<%=queryBeginDate%>&queryEndDate=<%=queryEndDate%>';
			<%}%>
				<%if(!"1".equals(toMe)){%>			
		//window.opener.location.href=encodeURI(myUrl);
		<%}%>
	    // UTFWindowOpener.location.reload();
	 </script>
	<%}else{
		modiButton = ",Toreceive,DepartSend,Hasread,Noread,SendToMyRange,GovRead";//增加阅读情况
	}

	if(workStatus.equals("2")){
		 modiButton = ",End,DepartSend,Toreceive,Hasread,Noread,TranRead,SendToMyRange";
	}
	if("handlingFileList".equals(request.getParameter("fromlist"))){//经办文件查阅
		//关闭、查看正文、查看历史痕迹、下载文件、打印、阅读情况
		modiButton = ",SeeWord,ReadHistorytext,Downtext,GovRead,Print,Close";//Viewtext
	}
	if("notsend".equals(request.getParameter("fromex")) ){
		//关闭、打印、催办、查看正文、邮件转发、新建流程、转收文、转文件送审签、公文交换、查看历史痕迹
		//modiButton=",Viewtext,Wait,EmailSend,AddNew,Print,ReadHistorytext,Toreceive,Tocheck";
		modiButton = ",Viewtext,Print,AddNew,ReadHistorytext,Toreceive,Tocheck";
	}
	if("hassend".equals(request.getParameter("fromex")) ){
		//关闭、打印、催办、查看正文、邮件转发、新建流程、转收文、转文件送审签、公文交换、查看历史痕迹
		//modiButton=",Viewtext,Wait,EmailSend,AddNew,Print,ReadHistorytext,Toreceive,Tocheck,GovExchange";
		modiButton = ",Viewtext,Print,AddNew,ReadHistorytext,Toreceive,Tocheck,GovExchange";
	}
	if("mycancel".equals(request.getParameter("fromex")) ){
		//关闭、打印、催办、查看正文、邮件转发、新建流程、转收文、转文件送审签、公文交换、查看历史痕迹
		modiButton=",Viewtext,Wait,EmailSend,AddNew,Print,ReadHistorytext,Toreceive,Tocheck,GovExchange";
	}
	request.setAttribute("p_wf_modiButton",modiButton);
/*
   if(workStatus.equals("102")){
   modiButton = ",Viewacc,Toselfdept,Toreceive,Viewread";
   
   }
   if(workStatus.equals("-3")){
    modiButton = ",Viewacc";
   
   }*/
%>
  <%if( !"1".equals( request.getParameter("isPrint"))){ %>


    <!--包含头部--->
	 <div style="height:47px; position:absolute; top:0; width:100%;z-index:1000;" >
		<jsp:include page="/public/toolbar/toolbar_include.jsp" ></jsp:include>
	 </div>
  <%}%>	
  <%if( !"1".equals( request.getParameter("isPrint"))){ %>	  <div class=""  id="mainContent"  style="overflow-y:auto; position:absolute; top:47px; width:100%; _width:99%; "><%}%>
<form name="sendToMyForm" id="sendToMyForm" action="<%=rootPath%>/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy_range.jsp" method="post" >

<input type="hidden" id="sendToMyRange3" name="sendToMyRange3" value="<%=request.getAttribute("sendToMyRange")==null?"":request.getAttribute("sendToMyRange").toString()%>"/>
<input type="hidden" name="p_wf_recordId" value="<%=request.getAttribute("p_wf_recordId")==null?"":request.getAttribute("p_wf_recordId")%>"/>

<input type="hidden" id="sendToIdNew" name="sendToIdNew" value="<%=request.getAttribute("sendToId")==null?"":request.getAttribute("sendToId").toString()%>"/>
<input type="hidden" name="sendToNameNew" id="sendToNameNew" value="<%=request.getAttribute("sendToName")==null?"":request.getAttribute("sendToName").toString()%>"/>


</form>
<input type="hidden" name="from" value="<%=request.getParameter("from")%>">
<form name="form1" action="public/iWebOfficeSign/DocumentEdit.jsp" method="post">
<input type="hidden" name="RecordID">
<input type="hidden" name="EditType" value="5">
<input type="hidden" name="UserName" value="<%=session.getAttribute("userName")%>">
<input type="hidden" id="sys_userName" value="<%=session.getAttribute("userName")%>">
<input type="hidden" name="ShowSign" value="0">
<input type="hidden" name="CanSave" value="1">
<input type="hidden" name="sendfileNUM"> 
<input type="hidden" name="documentSendFileWriteOrg_1"> 
<input type="hidden" name="documentSendFileTopicWord_1"> 
<input type="hidden" name="toPerson1_1" > 
<input type="hidden" name="toPerson2_1" > 
<input type="hidden" name="documentSendFilePrintNumber_1">
<input type="hidden" name="documentSendFileSendTime_1">
<input type="hidden" name="sendFileRedHeadId_1" > 
<input type="hidden" name="moduleType"  value="govdocument">
<input type="hidden" name="saveDocFile"  value="1">
<input type="hidden" name="Template">
<input type="hidden" name="sendFileDepartWord_1">
<input type="hidden" name="hasSeal">
<input type="hidden" name="senddocumentTitle">
<input type="hidden" name="underwriteTime">
<input type="hidden" name="sendFileAccessoryDesc_1">
<input type="hidden" name="showTempSign" value="0">
<input type="hidden" name="showTempHead" value="1">
<input type="hidden" name="showSignButton" value="1">
<input type="hidden" name="showEditButton" value="1">
<input type="hidden" name="sendFileGrade_1"><!--办理缓急 （等级）-->
<input type="hidden" name="underwritePerson"><!--签发人-->
<input type="hidden" name="securityGrade_1"><!-- 密级-->
<input type="hidden" name="loadTemp" value="1">
<input type="hidden" name="textContent" value="-1"> <!--  1 套用 content   0  不套用 content-->
<input type="hidden" name="FileType" value=".doc">
<input type="hidden" name="isWordWindowFirst" value="1"><!--是起草正文页面,只有发起页面才会判断正文内容及修改情况-->
</form>

	 <s:form name="dataForm" id="dataForm" action="GovDocSend!saveDraft.action" method="post" theme="simple" >
	  <input type="hidden" name="fileVerifyCode" value="<%=request.getAttribute("fileVerifyCode")%>">
	  <%@ include file="/public/include/form_detail.jsp"%>
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline">
					   <%if( !"1".equals( request.getParameter("isPrint"))){ %>
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> 
							  <li id="Panle2" ><a href="#" onClick="changePanle(2);">流程记录</a></li>
							  <li id="Panle3" ><a href="#" onClick="changePanle(3);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
							  <%if( !"1".equals( request.getAttribute("p_wf_pool_processType") ) ){%>
							  <li id="Panle4" ><a href="#" onClick="changePanle(4);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
							  <%}%>
							  <li id="Panle5" ><a href="#" onClick="changePanle(5);">修改记录</a></li>
							  <li id="Panle6" ><a href="#" onClick="changePanle(6);">相关收文</a></li>

						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
					   <%}%>
					   <%if( "1".equals( request.getParameter("isPrint"))){ %>
							<br>
							<div align="right">
								<input type="button" class="btnButton4font noprint" value="打　印" onclick="window.print();">
								<% if(com.whir.common.util.CommonUtils.isForbiddenPad(request)){%>
								<input type="button" id="download" onclick="javascript:downloadHTML();" value="下载网页格式文件" class="btnButton4font noprint">
							
								<input type="button" id="exportWord111" onclick="javascript:exportWord();" value="下载WORD格式文件" class="btnButton6font noprint">
								<%}%>
							</div>
					   <%}%>
                       <div id="docinfo0" class="doc_Content"  align="center">
					
							<!--表单包含页-->
							<div  align="center"> 
							 
							

							<%
								
								com.whir.govezoffice.documentmanager.bd.SendFileBD sendFileBD = new com.whir.govezoffice.documentmanager.bd.SendFileBD();
								String tableId_form = (String)request.getAttribute("p_wf_tableId");
								List tableInfoList = sendFileBD.getWfTableInfoByTableId(tableId_form); // 根据tableId
								// 找table
								// 信息
								String tableName = "";
			

								if (tableInfoList != null && tableInfoList.size() > 0) {
									Object[] tableInfoObj = (Object[]) tableInfoList.get(0);
									tableName = "" + tableInfoObj[0];
								}
								if (tableName.equals("发文表")) { //
									tableId_form = "standard";
								}
								String add = "/modules/govoffice/gov_documentmanager/forms/view_"+tableId_form+"_sendform_include.jsp"; 
								File file = new File(request.getRealPath("") +
                                        add);
								if (!file.exists()) {
									new com.whir.govezoffice.documentmanager.actionsupport.GovCustomAction().replayGovCustomPage(request,tableId_form,"0","1");
							 
								}
								
								%> 
								<jsp:include page="<%=add %>"></jsp:include>  
							</div>	
							<!--工作流包含页-->
							 <div>  
								  <%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
						    </div>
							 <div>  
								  <%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>
						    </div>
							 
				      </div>
					 <div id="docinfo1" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo3" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo4" class="doc_Content"  style="display:none;"></div>
					
					 <div id="docinfo5" class="doc_Content" style="display:none">
 <%
  java.util.List updatelist=new java.util.ArrayList();
  java.util.List titlelist=new java.util.ArrayList();
  java.util.List mainlist=new java.util.ArrayList();
  java.util.List copylist=new java.util.ArrayList();
  java.util.List innerlist=new java.util.ArrayList();
  String [] titleArr=null;
  String [] mainArr=null;
  String [] copyArr=null;
  String [] innerArr=null;
  //com.whir.govezoffice.documentmanager.bd.SendFileBD  sendFileBD=new com.whir.govezoffice.documentmanager.bd.SendFileBD();
   if(request.getAttribute("p_wf_recordId")!=null&&!request.getAttribute("p_wf_recordId").equals(""))
    updatelist=sendFileBD.getAllSendDocumentUpdatePO((String)request.getAttribute("p_wf_recordId"));

	if(updatelist!=null&&updatelist.size()>0){
	   for(int i=0;i<updatelist.size();i++){
		Object [] updateObj=(Object[])updatelist.get(i);
        String empId=""+updateObj[7];
	
	    if(empId.equals("")){
       if(updateObj[4].toString().equals("1")){           
	   titleArr=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};
		}
		 if(updateObj[4].toString().equals("2")){
		mainArr=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};

		}

		if(updateObj[4].toString().equals("3")){
		copyArr=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};

		}

		if(updateObj[4].toString().equals("4")){
		innerArr=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};

		}
			
		}else{
       
	       if(updateObj[4].toString().equals("1")){           
	         String titleObj []=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};
		titlelist.add(titleObj);
		}

		 if(updateObj[4].toString().equals("2")){
		String mainObj[]=new String[]{(updateObj[3]==null?"":updateObj[3].toString()),""+updateObj[1],""+updateObj[6]};
			mainlist.add(mainObj);
		}

		if(updateObj[4].toString().equals("3")){
		String copyObj[]=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};
		copylist.add(copyObj);
		}

		if(updateObj[4].toString().equals("4")){
		String  innerObj[]=new String[]{(updateObj[3]==null?"":updateObj[3].toString()),(updateObj[1]==null?"":updateObj[1].toString()),(updateObj[6]==null?"":updateObj[6].toString())};
		innerlist.add(innerObj);
		}
		
		
		}
	   }
	
	}


 %>
      <TABLE width="100%" 
     class="listTable">
  
        <TR class="listTableHead">
          <TD width="60%" class="td_lefttitle">修改内容</TD>
          <TD width="15%">修改人</TD>
          <TD width="25%">修改时间</TD></TR>
 
        <TR cellpadding="0" class="listTableLine2">
          <TD colSpan=3 class="td_lefttitle"><B>标题</B></TD></TR>

		  <%if(titleArr!=null&&titleArr.length>0){%>
		     
		  <TD width="50%"><%=titleArr[0]%></TD>
          <TD width="20%"><%=titleArr[1]%></TD>
          <TD width="30%"><%=titleArr[2]%></TD></TR>
		  
		  <%}%>

         <%if(titlelist!=null&&titlelist.size()>0){
		   for(int i=0;i<titlelist.size();i++){
			 Object []titleObj=(Object[])titlelist.get(i); %>  


		  <TR class="listTableLine1">
          <TD width="50%"><%=titleObj[0]%></TD>
          <TD width="20%"><%=titleObj[1]%></TD>
          <TD width="30%"><%=titleObj[2]%></TD></TR>
			   
		  <% }
		 
		 
		 }%> 
        

        <TR cellpadding="0" class="listTableLine2">
          <TD colSpan=3 class="td_lefttitle"><B>主送</B></TD></TR>
		   <%if(mainArr!=null&&mainArr.length>0){%>
		     
		  <TD width="50%"><%=mainArr[0]%></TD>
          <TD width="20%"><%=mainArr[1]%></TD>
          <TD width="30%"><%=mainArr[2]%></TD></TR>
		  
		  <%}%>
           
		   <%
		    if(mainlist!=null&&mainlist.size()>0){
			  for(int i=0;i<mainlist.size();i++){
			   Object mainObj[]=(Object[])mainlist.get(i);
				if( !(mainObj[0]==null||"0".equals(mainObj[0])) ){    
		   %>
			   
		  <TR class="listTableLine1">
          <TD width="60%"><%=(mainObj[0]==null||"0".equals(mainObj[0]))?"&nbsp;":mainObj[0]%></TD>
          <TD width="15%"><%=mainObj[1]%></TD>
          <TD width="25%"><%=mainObj[2]%></TD></TR>
			  
			 <% }
			  }
			}
		   %>

        <TR cellpadding="0" class="listTableLine2">
          <TD colSpan=3 class="td_lefttitle"><B>抄送</B></TD></TR>
		  <%if(copyArr!=null&&copyArr.length>0){%>
		     
		  <TD width="50%"><%=copyArr[0]%></TD>
          <TD width="20%"><%=copyArr[1]%></TD>
          <TD width="30%"><%=copyArr[2]%></TD></TR>
		  
		  <%}%>

		  <%
		   if(copylist!=null&&copylist.size()>0){
		      for(int i=0;i<copylist.size();i++){
			   Object [] copyObj=(Object[])copylist.get(i);
			   
				if( ! (copyObj[0]==null||"0".equals(copyObj[0])) ){
		   %>
             
			  <TR class="listTableLine1">
          <TD width="60%"><%=(copyObj[0]==null||"0".equals(copyObj[0]))?"&nbsp;":copyObj[0] %></TD>
          <TD width="15%"><%=copyObj[1]%></TD>
          <TD width="25%"><%=copyObj[2]%></TD></TR>  
			  
			 <%}
		     }
		   }
		  %>		  
		    <TR cellpadding="0" class="listTableLine2">
          <TD colSpan=3 class="td_lefttitle"><B>内部发送</B></TD></TR>
		   <%if(innerArr!=null&&innerArr.length>0){%>
		     
		  <TD width="50%"><%=innerArr[0]==null?"":innerArr[0]%></TD>
          <TD width="20%"><%=innerArr[1]==null?"":innerArr[1]%></TD>
          <TD width="30%"><%=innerArr[2]==null?"":innerArr[2]%></TD></TR>
		  
		  <%}%>
           
		   <%
		    if(innerlist!=null&&innerlist.size()>0){
			  for(int i=0;i<innerlist.size();i++){
			   Object innerObj[]=(Object[])innerlist.get(i);
			    	if( ! (innerObj[0]==null||"0".equals(innerObj[0])) ){   
		 	%>
		  <!--   
		  <TR>
          <TD width="60%"><%=(innerObj[0]==null||"0".equals(innerObj[0])) ?"&nbsp;":innerObj[0]%></TD>
          <TD width="15%"><%=innerObj[1]==null?"":innerObj[1]%></TD>
          <TD width="25%"><%=innerObj[2]==null?"":innerObj[2]%></TD></TR>	
          -->	  
		 <% }}} %>

 </TABLE>
 

					 
					 </div>
					 <div id="docinfo6" class="doc_Content"  style="display:none;"></div>
                 </div>
				

             </td>
         </tr>
     </table>
	 </s:form>
	  <%if( !"1".equals( request.getParameter("isPrint"))){ %></div><%}%>
    <div class="docbody_margin"></div>
	<%@ include file="/platform/bpm/pool/pool_include_form_end.jsp"%>
</body>
<script type="text/javascript">

/**
 切换页面
 */

function  changePanle(flag){
//if( flag == 3 ) flag= 2;
	for(var i=0;i<7;i++){
		$("#Panle"+i).removeClass("aon");
	}
	$("#Panle"+flag).addClass("aon");
	$("div[id^='docinfo']").hide();
	$("#docinfo"+flag).show();
    
	//显示流程图
	if(flag=="1"){
		//传流程图的div的id
       showWorkFLowGraph("docinfo1");
	}
	 //显示关联流程
	if(flag=="2"){
	   showWorkFlowLog("docinfo2");
	}
	//显示关联流程
	if(flag=="3"){
	   showWorkFlowRelation("docinfo3");
	}
 
	//显示相关附件
	if(flag=="4"){
	   showWorkFlowAcc("docinfo4");
	}
	if(flag=="6"){
	    var url="/defaultroot/GovDocSend!sendAssociate.action?sendFileId="+$("#p_wf_recordId").val();

		var html = $.ajax({url: url,async: false,cache:false}).responseText;

		$("#docinfo"+flag).html(html);
	}
	//http://localhost:7001/defaultroot/GovDocSend!sendAssociate.action
}


 
</script>
<script type="text/javascript">



/**
初始话信息
*/
function initBody(){
	var windowWidth = window.screen.availWidth;
	var windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
	window.resizeTo(windowWidth,windowHeight);
	//初始话信息
     <%if( !"1".equals( request.getParameter("isPrint"))){ %> 
    ezFlowinit();
	 <%}%>
	  p_wf_processName = $('#p_wf_processName').val();
}
 


 

//选择主送 ，抄送
function openEndowSend(type){

	if(type=="toPerson1"){   

		openSelect({allowId:'toPerson1Id', allowName:'toPerson1', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});
		//openEndow('toPerson1Id','toPerson1',document.all.toPerson1Id.value,document.all.toPerson1.value,'userorggroup','no','userorggroup','*0*');
	}
	if(type=="toPerson2"){   
		openSelect({allowId:'toPerson2Id', allowName:'toPerson2', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});
		//openEndow('toPerson2Id','toPerson2',document.all.toPerson2Id.value,document.all.toPerson2.value,'userorggroup','no','userorggroup','*0*');
	}

	if(type=="toPersonBao"){   
		openSelect({allowId:'toPersonBaoId', allowName:'toPersonBao', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});
		//openEndow('toPersonBaoId','toPersonBao',document.all.toPersonBaoId.value,document.all.toPersonBao.value,'userorggroup','no','userorggroup','*0*');
	}

	if(type=="toPersonInner"){   
		openSelect({allowId:'toPersonInnerId', allowName:'toPersonInner', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});
		//openEndow('toPersonInnerId','toPersonInner',document.all.toPersonInnerId.value,document.all.toPersonInner.value,'org','no','org','*0*');
	}

}

var noteTimer=null;
function getNote(index){
	
 var sTop=document.getElementById("docinfo0").scrollTop;
 var noteDiv="noteDiv_"+index;
// alert(noteDiv);
 if(document.getElementById(noteDiv)){
	  var d=document.getElementById(noteDiv);
	  d.style.left=event.x-200;
	  d.style.top=event.y+sTop-30;
	  d.style.display="inline";
  }
}
function hiddenNote(dd){
	var dealFunct="closeNote('"+dd+"')";
    noteTimer=window.setTimeout(dealFunct,500);
}
function closeNote(dd){
	var noteDiv="noteDiv_"+dd;
	if(document.getElementById(noteDiv)){
	   var d=document.getElementById(noteDiv);
	   d.style.display="none";
	}
}
function lockedNote(){
  window.clearTimeout(noteTimer);
}
function setNote(obj,dd){
	if(document.getElementById(dd)){
	document.getElementById(dd).value+=obj.innerText;
	}
}
function setNoteExt(obj,dd,ddId,issueUnitName,issueUnitID){
	issueUnitID = '~' + issueUnitID + '~';
	if(document.getElementById(dd) && document.getElementById(ddId)){
		var nameValue = document.getElementById(dd).value;
		var idValue = document.getElementById(ddId).value;
		if(obj.checked){
			nameValue +=issueUnitName + ',';
			idValue += issueUnitID + '';
		}else{
			var idIndex =idValue.indexOf(issueUnitID);
			var idLen = issueUnitID.length;
			var idPre = idValue.substring(0,idIndex);
			var idSuf = idValue.substring((idIndex + idLen)+1);

			idValue = idPre + idSuf;

			var nameIndex = nameValue.indexOf(issueUnitName);
			var nameLen = issueUnitName.length;
			var namePre = nameValue.substring(0,nameIndex);
			var nameSub = nameValue.substring((nameIndex+nameLen)+1);
			
			nameValue = namePre + nameSub;
		}
		document.getElementById(dd).value = nameValue;
		document.getElementById(ddId).value = idValue;
	}
	//document.getElementById(dd).value+=obj.innerText;
}

function selecttw() {
	var hhref = "/defaultroot/GovDocSend!chooseSendTopical.action" ;
	openWin({url:hhref,width:650,height:450,winName:'modifyUser'});
	//postWindowOpen(hhref,'','TOP=0,LEFT=0,scrollbars=yes,resizable=no,width=600,height=300') ;
}



 //起草正文
function wordWindowFirst(){	
	var underwriteTime="";
	var hasSeal="";
	var departWord="";
	var  wordValue=$("select[name='sendFileDepartWord']")[0].value;   
	if(wordValue!=""){		 
		mystr=wordValue.split(";");      
		departWord=mystr[1];               
	}
	
	$("input[name='RecordID']")[0].value = $("input[name='content']")[0].value; // document.all.content.value;
	$("input[name='Template']")[0].value = "";
	$("input[name='showSignButton']")[0].value="0";
	$("input[name='ShowSign']")[0].value="-1";
	$("input[name='textContent']")[0].value="";
	$("input[name='loadTemp']")[0].value="0"
    // 选择 编辑 类型
   /* if(confirm(" 是否默认word起草正文？ \n 点‘确认’则默认word起草，点‘取消’则wps起草！")){
    document.all.documentWordType.value=".doc";
	document.all.FileType.value=".doc";	
	}else{
    document.all.documentWordType.value=".wps";
	document.all.FileType.value=".wps";
	}*/
	var  myDatestr=""+new Date().getTime(); 
	window.open("", "ec"+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
	form1.target="ec"+myDatestr;
	form1.submit();

}
<%if( "1".equals( request.getParameter("isPrint"))){ %>
function whir_alert(){
}
<%}%>

/*
	var windowWidth = window.screen.availWidth;
	var windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
	window.resizeTo(windowWidth,windowHeight);
*/

var tempHtml = "";
var processFlag = true;
 
var exportUrl = "PrintForm";
var p_wf_processName = "";
var dhtmlFlag = false;

function processContent(){
	 

    var docinfo0 = document.getElementById('docinfo0').innerHTML;
    tempHtml = docinfo0;
 
    if($('#adddelrow_div').length>0)$('#adddelrow_div').remove();
 
    var _this_href = location.href;
    _this_href = 'http://'+location.host;
 
    if(processFlag){
        $('#docinfo0 img').each(function(){
            var src = $(this).attr('src');
            if(src){
                if(src.indexOf("http:")==-1 || src.indexOf("https:")==-1){
                    $(this).attr('src', _this_href + src);
                }
            }
        });
        processFlag = false;
    }
 
    $('#backCommentTbl').remove();
 
    $("tr[id=commTR]").each(function(i){
        var display = $(this).css('display');
        if(display=='none'){
            $(this).remove();
        }
    });
 
   // $("input[type=hidden]").remove();
   $("input[type!=button]").remove();
    processPrintHtml();
 
    docinfo0 = document.getElementById('docinfo0').innerHTML;
    
    var scriptregex = "<scr" + "ipt[^>.]*>[sS]*?</sc" + "ript>";
    var scripts = new RegExp(scriptregex, "gim");
    docinfo0 = docinfo0.replace(scripts, " ");
    docinfo0 = docinfo0.replace(/<script[\w\W]*?\<\/script>/igm, "");
 
    docinfo0 = docinfo0.replace(/<input type=hidden [\w\W]*?>/igm, "");
    docinfo0 = docinfo0.replace(/<object [\w\W]*?>/igm, "");
    docinfo0 = docinfo0.replace(/\<br\>/igm, "\n\r");
 
    docinfo0 = docinfo0.replace(/<link[\w\W]*?\>/igm, "");
 
    return docinfo0;
}
 

function downloadHTML(){
    dhtmlFlag = true;
    var docinfo0 = processContent();
    /*if($.browser.msie){
        document.getElementById('save').ExecWB(4,1);
    }else{*/
        _export2(exportUrl+'!export2html.action', docinfo0);
    //}

}
 
 
function _export2(url, content){
    var $form = createDynamicForm({id:'_postForm_',target:'_self', action:url, method:'post', params:[{name:'title', value:p_wf_processName}]});
    var textareaObj = $('<textarea name=content style="display:none"/>');
    textareaObj.val(content);
    textareaObj.appendTo($form);
 
    if($form) {
        $form.submit();
    }
}
 


function exportWord(){
	//alert(1);
    var docinfo0 = processContent();
	//alert(docinfo0);
    if(false&&$.browser.msie){
        document.getElementById('docinfo0').innerHTML = "" + docinfo0;
 
        var oWD = new ActiveXObject("Word.Application");
        var oDC = oWD.Documents.Add("",0,1);
        var oRange =oDC.Range(0,1);
        var sel = document.body.createTextRange();
        sel.moveToElementText(document.getElementById('docinfo0'));
        try{
            sel.select();
        }catch(e){}
        sel.execCommand("Copy");
        oRange.Paste();
        oWD.Application.Visible = true;
        oWD.ActiveWindow.View.TableGridlines = false;
        document.execCommand("unselect");
        //设置文档为页面视图
        //oWD.ActiveWindow.ActivePane.View.Type = 3;
        try{
            oWD.ActiveWindow.ActivePane.View.Type = 9;
        }catch(e){
            oWD.ActiveWindow.ActivePane.View.Type = 3;
        }
        oWD.ActiveWindow.ActivePane.View.Zoom.Percentage = 100;
        //document.getElementById('exportHtml').innerHTML = "";
        //oDC.PrintPreview();
    }else{
        _export2(exportUrl+'!export2doc.action', docinfo0);
    }
 
    //endPrintHtml(tempHtml);
}
var dhtmlFlag = true;
function processPrintHtml(){
    $('#docinfo0 table').each(function(i){
        var $this = $(this);
        var width = $this.css('width');
        if(width.indexOf('px')!=-1){
            width = width.substr(0, width.length -2);
        }
 
        if(width > 550){
            if(dhtmlFlag){
                $this.attr('width', '100%');
                dhtmlFlag = false;
            }
        }
    });
 
    $('#commTD').each(function(i){
        $(this).prev().attr('style','');//css('border-bottom','1px solid #366AB3;');
    });
}
 
function endPrintHtml(tempHtml){
    document.getElementById('docinfo0').innerHTML = tempHtml;
}


</script>
</html>

