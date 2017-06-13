<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.bpm.bd.BPMFlowMessageBD"%>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
whir_custom_str="easyui,tagit";
if(request.getParameter("gd")!=null&&request.getParameter("gd").toString().equals("1")){
   // whir_custom_str+="notip";
}

String ezFlowProcessInstanceId= request.getAttribute("p_wf_processInstanceId")+"";
String userId =session.getAttribute("userId")==null?"":session.getAttribute("userId").toString();
BPMFlowMessageBD messageBD =new BPMFlowMessageBD();
int remindNum =messageBD.getRemindNumForFlowMessage(userId, ezFlowProcessInstanceId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=request.getAttribute("p_wf_processName")%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--工作流包含页 js文件-->
   	<%@ include file="/public/include/meta_base_ezflow.jsp"%>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	
	/**
	切换页面
	*/
	function  changePanle(flag){
		if(!judgePageIsShowAll()){
			whir_alert(workflowMessage_js.waitingload,function(){});
			return false;
		}
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
		//显示流程描述
		if(flag=="4"){
			showPrcosssDescription("docinfo4");
		}
		//显示留言
		if(flag=="5"){
			showWorkFlowMessage("docinfo5");
		}
		//显示流程跟踪单
		if(flag=="6"){
			showWorkFlowTrackingList("docinfo6");
		}
	}
	//-->
	</SCRIPT>
	<style type="text/css">
	.docBodyStyle{ 
		overflow:auto;
	} 
	.doc_Scroll{
		height:96%; width:100%; margin-top:33px;  overflow:visible;
	}
	</style>
</head>
<body class="docBodyStyle"  onload="initBody();viewPrint();commentWidth();"> 
    <!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>

	<!--style="position:relative;"-->
	<div class="doc_Scroll"  >
	<s:form name="dataForm" id="dataForm" action="ezflowoperate!showSend.action" method="post" theme="simple" >
	<%@ include file="/public/include/form_detail.jsp"%>
	<table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
		<tr valign="top">
			<td height="100%">
				<div class="docbox_noline">
					<div class="doc_Movetitle"  id="id_doc_movetitle">
						<div class="docRight" ><bean:message bundle="workflow" key="workflow.st"/><span class="redBold" id="viewPrintNum">0</span><bean:message bundle="workflow" key="workflow.printst"/></div>
						<ul>
							<li class="aon"  id="Panle0"><a href="#" onClick="changePanle(0);" ><bean:message bundle="workflow" key="workflow.newactivitybasicinfo"/></a></li>
							<li id="Panle1"><a href="#" onClick="changePanle(1);"><bean:message bundle="workflow" key="workflow.newworkflowchart"/></a></li> 
							<li id="Panle2" ><a href="#" onClick="changePanle(2);"><bean:message bundle="filetransact" key="file.workflowrecord"/></a></li>
							<li id="Panle6" ><a href="#" onClick="changePanle(6);">流程跟踪单</a></li>
							<li id="Panle4" ><a href="#" onClick="changePanle(4);"><bean:message bundle="workflow" key="workflow.ezFLOWDescription"/></a>
							<li id="Panle3" ><a href="#" onClick="changePanle(3);"><bean:message bundle="workflow" key="workflow.Relatedworkflow"/><span class="redBold" id="viewrelationnum"></span></a></li>
							<li id="Panle5" ><a href="#" onClick="changePanle(5);"><bean:message bundle="workflow" key="workflow.message"/><span class="redBold" id="viewmessagenum"><%if(remindNum>0){out.print("("+remindNum+")");}%></span></a></li>
						</ul>
						</div>  
						<div class="clearboth"></div>  
						<div id="docinfo0" class="doc_Content" >
							<!--表单包含页 -->
							<div>
							 	<%
							     String  p_wf_relationTrig=request.getAttribute("p_wf_relationTrig")==null?"":request.getAttribute("p_wf_relationTrig").toString();
							     String  p_wf_recordId=request.getAttribute("p_wf_recordId")==null?"":request.getAttribute("p_wf_recordId").toString();
							     String  p_wf_formKey_act=request.getAttribute("p_wf_formKey_act")==null?"":request.getAttribute("p_wf_formKey_act").toString();
								 String  parentFormId=request.getAttribute("parentFormId")==null?"":request.getAttribute("parentFormId").toString();
								 String  parentRecordId=request.getAttribute("parentRecordId")==null?"":request.getAttribute("parentRecordId").toString();
                                 
                                 /*System.out.println("formCode:"+p_wf_formKey_act);
								 System.out.println("infoId:"+p_wf_recordId);
								 System.out.println("settingId:"+p_wf_relationTrig);
								 System.out.println("processId:"+p_wf_formKey_act);
								 System.out.println("p_wf_relationTrig:"+p_wf_relationTrig);
								 System.out.println("p_wf_pareTableId:"+parentFormId);
								 System.out.println("p_wf_pareRecordId:"+parentRecordId); */
							    %>
							<div> 
								<jsp:include page="/platform/custom/ezform/run/showform.jsp" flush="true">
									<jsp:param name="formCode" value="<%=p_wf_formKey_act%>"/>
									<jsp:param name="infoId" value="<%=p_wf_recordId%>"/>
									<jsp:param name="settingId" value="<%=p_wf_relationTrig%>"/>
									<jsp:param name="processId" value=""/>
									<jsp:param name="p_wf_pareTableId" value="<%=parentFormId%>"/>
									<jsp:param name="p_wf_pareRecordId" value="<%=parentRecordId%>"/>
								</jsp:include>		
							</div>				  
						</div>	
						
						<!--工作流包含页-->
						<div>  
							<%@ include file="/platform/bpm/ezflow/operation/ezflow_include_form.jsp"%>
						</div>
						<!--批示意见包含页-->
						<div id="comment_outDiv" style="margin:0 auto;padding:0px 0px 0px 0px;">
							<%@ include file="/platform/bpm/ezflow/operation/ezflow_include_comment.jsp"%>  
						</div>
					</div>
					<div id="docinfo1" class="doc_Content"  style="display:none;text-align:center" ></div>
					<div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					<div id="docinfo3" class="doc_Content"  style="display:none;"></div>
					<div id="docinfo4" class="doc_Content"  style="display:none;"></div>
					<div id="docinfo5" class="doc_Content"  style="display:none;"></div>
					<div id="docinfo6" class="doc_Content"  style="display:none;"></div>
				</div>
			</td>
		</tr>
	</table>
	</s:form>
	</div>
    <div class="docbody_margin"></div>
	<%@ include file="/platform/bpm/ezflow/operation/ezflow_include_form_end.jsp"%> 
	          
	<!--归档时用的form -->  
	<form name="form4" action="<%=rootPath%>/platform/bpm/ezflow/operation/ezflow_gd.jsp?gd=1" method="POST">
		<input type="hidden" name="pageContent">
		<input type="hidden" name="gd_processInstanceId"  value='<%=request.getAttribute("p_wf_processInstanceId")+""%>' />
		<input type="hidden" name="gd_title"              value='<%=request.getAttribute("p_wf_processName")+""%>' />
		<input type="hidden" name="gd_startUserCode"   value='<%=request.getAttribute("p_wf_submitUserAccount")+""%>' />
		<input type="hidden" name="gd_startUserName"   value='<%=request.getAttribute("p_wf_submitPerson")+""%>' />
		<input type="hidden" name="gd_startTime"       value='<%=request.getAttribute("p_wf_submitTime")+""%>'  />
		<input type="hidden" name="gd_startOrgId"      value='<%=request.getAttribute("p_wf_startOrgId")+""%>'  />
		<input type="hidden" name="gd_remindTitle"     value='<%=request.getAttribute("p_wf_remindTitle")+""%>'  />
		<input type="hidden" name="gd_type"    value='<%=request.getAttribute("p_wf_processNeedDossierType")+""%>'  />
		<input type="hidden" name="gd_path"    value='<%=request.getAttribute("p_wf_processNeedDossierPath")+""%>'  />
	</form>
</body>
<script type="text/javascript">
/***
批示意见框的位置
*/
function commentWidth(){
   var  table=$("#formHTML").find("table").first();
   $("#comment_outDiv").width(table.width()+6); 

   /*if($("#trigger1_auto").length>0){
	    $("#trigger1_auto").powerFloat();  
   } 
   if($("#trigger1").length>0){
	    //$("#trigger1").powerFloat({offsets :{x:0, y:135} }); 
		$("#trigger1").powerFloat(); 
   } */

   <%if(request.getParameter("gd") != null){%>
     gd();
   <%}%>
}

//归档
function gd(){
	$("#id_doc_movetitle").remove(); 
	$("#popToolbar").remove();
	document.form4.pageContent.value = document.body.innerHTML;
	document.form4.submit();
}

/**
初始话信息
*/
function initBody(){
	//初始话信息
    ezFlowinit(); 
}
</script>
</html>