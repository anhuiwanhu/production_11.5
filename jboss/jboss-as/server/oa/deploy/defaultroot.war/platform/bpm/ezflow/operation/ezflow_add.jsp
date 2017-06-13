<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
whir_custom_str="easyui,tagit";
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
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
	<style type="text/css">
	   .docBodyStyle{ 
		 overflow:auto;
	   }

	  .doc_Scroll{    height:96%; width:100%; margin-top:33px;  overflow:visible;  }
	</style>

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
		for(var i=0;i<4;i++){
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
		   showWorkFlowRelation("docinfo2");
		}

		 //显示流程描述
		if(flag=="3"){
		   showPrcosssDescription("docinfo3");
		}
	}

	//-->
	</SCRIPT>
</head>
<body  class="docBodyStyle"   onload="initBody();">
    <!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
	 <div class="doc_Scroll">
	 <s:form name="dataForm" id="dataForm" action="ezflowoperate!showSend.action" method="post" theme="simple" >
	 <%@ include file="/public/include/form_detail.jsp"%>
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline">
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="#" onClick="changePanle(0);" ><bean:message bundle="workflow" key="workflow.newactivitybasicinfo"/></a></li>
							  <li id="Panle1"><a href="#" onClick="changePanle(1);"><bean:message bundle="workflow" key="workflow.newworkflowchart"/></a></li> 
							  <li id="Panle3" ><a href="#" onClick="changePanle(3);"><bean:message bundle="workflow" key="workflow.ezFLOWDescription"/></a>
							  <li id="Panle2" ><a href="#" onClick="changePanle(2);"><bean:message bundle="workflow" key="workflow.Relatedworkflow"/><span class="redBold" id="viewrelationnum"></span><span class="redBold" id="viewrelationnum"></span></a>
							  
							  </li>
						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <div id="docinfo0" class="doc_Content" >
							<!--表单包含页-->
							<div> 
							  <%
							     String  p_wf_relationTrig=request.getAttribute("p_wf_relationTrig")==null?"":request.getAttribute("p_wf_relationTrig").toString();

							     String  p_wf_recordId=request.getAttribute("p_wf_recordId")==null?"":request.getAttribute("p_wf_recordId").toString();

							     String  p_wf_formKey_act=request.getAttribute("p_wf_formKey_act")==null?"":request.getAttribute("p_wf_formKey_act").toString();

							     String  parentFormId=request.getParameter("parentFormId")==null?"":request.getParameter("parentFormId").toString();
								 String  parentRecordId=request.getParameter("parentRecordId")==null?"":request.getParameter("parentRecordId").toString();


							    %>
							    <jsp:include page="/platform/custom/ezform/run/showform.jsp" flush="true">
									<jsp:param name="formCode" value="<%=p_wf_formKey_act%>"/>
									<jsp:param name="infoId" value="<%=p_wf_recordId%>"/>
									<jsp:param name="settingId" value="<%=p_wf_relationTrig%>"/>
									<jsp:param name="processId" value=""/>
								   <jsp:param name="p_wf_pareTableId" value="<%=parentFormId%>"/>
									<jsp:param name="p_wf_pareRecordId" value="<%=parentRecordId%>"/>
								</jsp:include>	
							</div>	
							<!--工作流包含页-->
							 <div>  
								  <%@ include file="/platform/bpm/ezflow/operation/ezflow_include_form.jsp"%>
						    </div>
				      </div>
					 <div id="docinfo1" class="doc_Content"  style="display:none;" style="text-align:center"></div>
					 <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo3" class="doc_Content"  style="display:none;"></div> 
                 </div>
             </td>
         </tr>
     </table>
	 </s:form>
	</div>
    <div class="docbody_margin"></div>
	<%@ include file="/platform/bpm/ezflow/operation/ezflow_include_form_end.jsp"%>
</body>
<script type="text/javascript">

/**
初始话信息
*/
function initBody(){ 
     /*
	     $.get("/defaultroot/platform/bpm/ezflow/operation/xx.xml",function(xml){  
		 alert(xml);
	     alert($(xml).find("Item").length);   
         });*/

	//初始话信息
    ezFlowinit();


}
 
</script>
</html>