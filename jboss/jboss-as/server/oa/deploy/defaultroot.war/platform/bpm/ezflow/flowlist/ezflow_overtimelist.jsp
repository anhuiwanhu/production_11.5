<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.whir.component.page.Page"%>
<%@ page import="com.whir.component.page.PageFactory"%> 
<%
String localeCode=request.getParameter("localeCode");
if(localeCode==null){
   localeCode="zh_cn";
   Cookie[] cookies = request.getCookies();
   if(cookies!=null){
      for (int i = 0; i < cookies.length; i++){
          Cookie c = cookies[i];

          if(c.getName().equalsIgnoreCase("LocLan")){
              localeCode= c.getValue();
          }
       }
   }
}
String localpath = session.getServletContext().getRealPath("upload");
String skin = request.getParameter("skin")!=null?request.getParameter("skin"):"";
String domainId = "0"; 
	 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  lang="zh-cn" class="wh-gray-bg <%=whir_2016_skin_color%> <%=whir_2016_skin_styleColor%> <%=whir_pageFontSize_css%>">
<head>
	<title>标准列表页面结构</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
 <%@ include file="/public/include/portal_base113.jsp"%>

    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js"></script> 
    <script type="text/javascript" src="<%=rootPath%>/platform/portal/js/scriptloader.js"></script>
 
    <script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.validation.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.application.js"></script>
 
 
<link   href="<%=rootPath%>/themes/common/desktop.css" rel="stylesheet" type="text/css"/>
 
<%if(whir_agent.indexOf("MSIE 7")>=0 || whir_agent.indexOf("MSIE 10")>=0 ){%>
<style >
    body{position:relative;}
</style>
<%}%>
 

 
</head>

<body class="MainFrameBox">
<%
        String viewSql=    "aaa.workFileType, aaa.workCurStep, aaa.workTitle, aaa.workDeadLine, aaa.workSubmitPerson, "
		+ // 0---4
		"aaa.workSubmitTime, aaa.workType, aaa.workActivity, aaa.workTableId, aaa.workRecordId, "
		+ // 5---9
		"aaa.wfWorkId, aaa.workSubmitPerson, aaa.wfSubmitEmployeeId, aaa.workAllowCancel, "
		+ // 10--13
		"aaa.workProcessId, aaa.workStepCount,aaa.workMainLinkFile, aaa.workSubmitTime, "
		+ // 14--17
		"aaa.workCurStep, aaa.creatorCancelLink, aaa.isStandForWork, aaa.standForUserId, "
		+ // 18--21
		"aaa.standForUserName,aaa.workCreateDate,aaa.submitOrg,aaa.workDoneWithDate,aaa.emergence,"
		+ // 22--26
		"aaa.initActivity,aaa.initActivityName,aaa.tranType, aaa.tranFromPersonId, aaa.processDeadlineDate,"
		+ // 27--31
		"aaa.wfCurEmployeeId,aaa.workDeadlineDate,aaa.fromUserId,aaa.fromUserName,aaa.submitOrg,"
		+ // 32---36
		"aaa.isForkTask,aaa.forkStepCount,aaa.forkId,aaa.fromforkActivityId ,aaa.workStatus "; // 37---41
		// viewSql+=",0,'0','0' ";
		 viewSql += ",aaa.isezFlow,aaa.ezFlowTaskId,aaa.ezFlowProcessInstanceId,aaa.noTreatment,aaa.attention,aaa.moduleId ";// 42-----44
		
		String  fromSql = " com.whir.ezoffice.workflow.po.WFWorkPO aaa  ";   
	    Map  varMap=new HashMap();   
		String whereSql = " where  aaa.workStatus =:var_workStauts and aaa.wfCurEmployeeId =:var_wf_CurEmployeeId "
		+ " and aaa.workDeadLine=1  and  aaa.workDeadlineDate  is not null   "+
		"and aaa.workListControl = 1 and aaa.workDelete = 0   and  aaa.isezFlow=1 order by aaa.workDeadlineDate  "; 
		varMap.put("var_workStauts", new Long("0"));
		String  wfCurEmployeeId=""+session.getAttribute("userId");
		varMap.put("var_wf_CurEmployeeId", new Long(wfCurEmployeeId)); 
		Page hqlpage = PageFactory.getHibernatePage(viewSql, fromSql, whereSql, "");
		hqlpage.setPageSize(6);
		hqlpage.setCurrentPage(1);
		/*
		 * hqlpage.setVarMap(varMap);若没有查询条件，可略去此行
		 */
		hqlpage.setVarMap(varMap);
		/*
		 * list，数据结果
		 */
		List list = hqlpage.getResultList();
        
 
	    // 当前时间格式
		java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("MM-dd HH:mm");
		com.whir.component.security.crypto.EncryptUtil util = new com.whir.component.security.crypto.EncryptUtil();

		%>



	 
            <div class="wh-portal-info-content">
		<%

        Date now=new Date(); 
        if(list!=null&&list.size()>0){
			Object  obj[]=null;
			
			for(int i=0;i<list.size();i++){
				obj=(Object [])list.get(i);  
				Date date=(Date)obj[33];
				long l=date.getTime()-now.getTime();
                String redStr="";
				String str="剩";
				if(l<0){
					l=-l;
					str="超";
					redStr="color: red;";
				}
 
				long day=l/(24*60*60*1000);
				long hour=(l/(60*60*1000)-day*24);
				long min=((l/(60*1000))-day*24*60-hour*60);
				long s=(l/1000-day*24*60*60-hour*60*60-min*60);  
				 
				if(day>0){
				  str+=""+day+"天";
				}
				if(hour>0){
				   str+=hour+"小时";
				}
				if(str.length()==1){
					if(min>0){
				        str+=min+"分";
				    }else{
						str+="1分";
					}
				}

                   String zhengwencode= util.getSysEncoderKeyVlaue("ezFlowTaskId",""+obj[43],"WFDealWithAction"); 

				%> 
				  <div class="wh-portal-i-item clearfix">
                    <a href=""  onclick="openWorkFlow('<%=obj[16]%>','<%=obj[10]%>', '<%=obj[9]%>','<%=obj[43]%>','<%=zhengwencode%>');return false;">
                        <span style="width: 70px;padding-right: 10px;display: inline-block;<%=redStr%>"><%=str%></span>
                        <span><%=obj[1]%>&nbsp;<%=obj[2]%></span>
                        <em class="wh-pending-em">[<%=simpleDateFormat.format((Date)obj[17])%>]</em> 
                    </a>
                </div>  


				<%
			}
		}%>
		</div>  
 

 
 
</body>
 <script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
 
	
	//自定义操作栏内容  
	//打开流程
	function  openWorkFlow(url,workId, recordId,ezFlowTaskId,ezFlowTaskId_verifyCode){
	    var openType="waitingDeal";
 
        
		var isezFlow="1";
	    //新工作流
		if(isezFlow=="1"){
			if(url==null||url==""||url=="null"){
				url="<%=rootPath%>/ezflowopen!updateProcess.action";
			}
			if(!url.startWith("<%=rootPath%>")){
				url="<%=rootPath%>"+url;
			}
			if(recordId=="-1"){
			   recordId="";
			}
 
			if(url.indexOf("?")>=0){ 
				 openurl=url+"&ezFlowTaskId="+ezFlowTaskId+"&verifyCode="+ezFlowTaskId_verifyCode+"&p_wf_openType="+openType+"&p_wf_pool_processType=1&p_wf_recordId="+recordId;
			}else{
				openurl=url+"?ezFlowTaskId="+ezFlowTaskId+"&verifyCode="+ezFlowTaskId_verifyCode+"&p_wf_openType="+openType+"&p_wf_pool_processType=1&p_wf_recordId="+recordId;
			}    
			 
		} 


		openurl+="&portletSettingId"+
		//openurl =openurl+"&from=workflow";
		//openurl =openurl+"&from="+from;

		//alert("openurl:"+openurl); 
		openWin({url:openurl,isFull:true,width:850,height:750,winName:'openWorkFlow'+workId});
		 
	}


	function refreshListForm_(){ 
		location_href("/defaultroot/platform/bpm/ezflow/flowlist/ezflow_overtimelist.jsp");  
	}

	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
   </script>
</html>

