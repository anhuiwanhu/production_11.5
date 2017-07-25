<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String processInstanceId=request.getParameter("p_wf_processInstanceId");
	com.whir.service.api.ezflowservice.EzFlowLogService  logService=new com.whir.service.api.ezflowservice.EzFlowLogService();
	java.util.List logList=logService.getEzFlowLogList(processInstanceId);
	
	String local= session.getAttribute("org.apache.struts.action.LOCALE").toString();

	com.whir.org.bd.usermanager.UserBD ubd =new com.whir.org.bd.usermanager.UserBD();
%>
<script src="/defaultroot/scripts/main/whir.userInfo.card.js" language="javascript"></script>
<style type="text/css">
	.trigger1{color:blue}
	.trigger1:hover{color:red}
</style>
<div>&nbsp;</div>
<table width="100%" border="0" cellpadding="3" cellspacing="0">
	<TBODY>
	<%
    if(logList!=null&&logList.size()>0){
		String [] logObj = null;
		for(int i = 0; i < logList.size(); i ++){		
			logObj = (String[]) logList.get(i);
			String action=logObj[2];
		    String dealType=logObj[4];
			action=getLogResource(local,action,dealType);
			String dealUserId =logObj[6]==null?"":logObj[6].toString();
			String dealUserName=logObj[0]==null?"":logObj[0].toString();
			String dealReceiveUserId =logObj[7]==null?"":logObj[7].toString();
			String dealReceiveUserName =logObj[3]==null?"":logObj[3].toString();
			String rel1 = "/defaultroot/public/desktop/getUserCardInfo.jsp?id="+dealUserId+"&hasMsg=true";
			String dealUserNameHtml ="<a class=\"trigger1\" rel=\""+rel1+"\" href=\"javascript:void(0);\" >"+dealUserName+"</a>";
			
			String dealReceiveUserNameHtml ="";
			if(!dealReceiveUserName.equals("") && !dealReceiveUserId.equals("")){
				String[] dealReceiveUserNameObj =null;
				String[] dealReceiveUserIdObj =null;
				
				//System.out.println("dealReceiveUserName--0--->"+dealReceiveUserName);
				//System.out.println("dealReceiveUserId--0--->"+dealReceiveUserId);

				if(dealReceiveUserName.indexOf("|") >-1){
					//System.out.println("dealReceiveUserName--1--->"+dealReceiveUserName);
					//System.out.println("dealReceiveUserId--1--->"+dealReceiveUserId);

					dealReceiveUserName =dealReceiveUserName.replaceAll("\\|","");
					dealReceiveUserId =dealReceiveUserId.replaceAll("\\|","");

					//System.out.println("dealReceiveUserName--2--->"+dealReceiveUserName);
					//System.out.println("dealReceiveUserId--2--->"+dealReceiveUserId);

					if(dealReceiveUserName.endsWith(",")){
						dealReceiveUserName =dealReceiveUserName.substring(0,dealReceiveUserName.length()-1);
					}
					if(dealReceiveUserId.endsWith(",")){
						dealReceiveUserId =dealReceiveUserId.substring(0,dealReceiveUserId.length()-1);
					}

					dealReceiveUserNameObj =dealReceiveUserName.split(",");
					dealReceiveUserIdObj =dealReceiveUserId.split(",");

					for(int j=0;j<dealReceiveUserNameObj.length;j++){
						String drUserAccount =dealReceiveUserIdObj[j];
						String drUserName =dealReceiveUserNameObj[j];
						java.util.Map map =ubd.getUserInfoByAccount(drUserAccount);
						String drUserId =map.get("userId")==null?"":map.get("userId").toString();
						String rel2 = "/defaultroot/public/desktop/getUserCardInfo.jsp?id="+drUserId+"&hasMsg=true";
						dealReceiveUserNameHtml +="<a class=\"trigger1\" rel=\""+rel2+"\" href=\"javascript:void(0);\" >"+drUserName+"|</a>";
					}
				}else if(dealReceiveUserId.indexOf("$") >-1){
					//处理 邮件转发错误数据
					dealReceiveUserId=com.whir.ezflow.util.EzFlowUtil.dealStrForIn(dealReceiveUserId,'$',"");

					if(dealReceiveUserName.endsWith(",")){
						dealReceiveUserName =dealReceiveUserName.substring(0,dealReceiveUserName.length()-1);
					}
					if(dealReceiveUserId.endsWith(",")){
						dealReceiveUserId =dealReceiveUserId.substring(0,dealReceiveUserId.length()-1);
					}

					dealReceiveUserNameObj =dealReceiveUserName.split(",");
					dealReceiveUserIdObj =dealReceiveUserId.split(",");

					for(int j=0;j<dealReceiveUserNameObj.length;j++){
						String drUserId =dealReceiveUserIdObj[j];
						String drUserName =dealReceiveUserNameObj[j];
						 
						String rel2 = "/defaultroot/public/desktop/getUserCardInfo.jsp?id="+drUserId+"&hasMsg=true";
						dealReceiveUserNameHtml +="<a class=\"trigger1\" rel=\""+rel2+"\" href=\"javascript:void(0);\" >"+drUserName+"</a>&nbsp;";
					}
					
				}else{ 
					if(dealReceiveUserName.endsWith(",")){
						dealReceiveUserName =dealReceiveUserName.substring(0,dealReceiveUserName.length()-1);
					}
					if(dealReceiveUserId.endsWith(",")){
						dealReceiveUserId =dealReceiveUserId.substring(0,dealReceiveUserId.length()-1);
					}

					dealReceiveUserNameObj =dealReceiveUserName.split(",");
					dealReceiveUserIdObj =dealReceiveUserId.split(",");

					for(int j=0;j<dealReceiveUserNameObj.length;j++){
						String drUserAccount =dealReceiveUserIdObj[j];
						String drUserName =dealReceiveUserNameObj[j];
						java.util.Map map =ubd.getUserInfoByAccount(drUserAccount);
						String drUserId =map.get("userId")==null?"":map.get("userId").toString();
						String rel2 = "/defaultroot/public/desktop/getUserCardInfo.jsp?id="+drUserId+"&hasMsg=true";
						dealReceiveUserNameHtml +="<a class=\"trigger1\" rel=\""+rel2+"\" href=\"javascript:void(0);\" >"+drUserName+"</a>&nbsp;";
					}
				}
			}
	%>			   		   
	<TR>
		<TD width="2%"><span style="color:brown"><B>&nbsp;<%=""+(i+1)+"、"%></B></span></TD>
		<TD width="15%" style="white-space:nowrap;"><span style="color:blue;white-space:nowrap;" ><B>&nbsp;<%=""+dealUserNameHtml%></B></span></TD>
		<TD width="35%" style="white-space:nowrap;"><span style="color:purple"><B>&nbsp;<%=""+logObj[1]%></B></span></TD>
		<TD width="30%" style="white-space:nowrap;"><span style="color:green"><B>&nbsp;<%=""+action%></B></span></TD>
		<TD width="15%"><span style="color:mediumblue"><B>&nbsp;<%=""+dealReceiveUserNameHtml%></B></span></TD>
		<TD width="3%"><span style="color:blue"><B>&nbsp;&nbsp;</B></span></TD>
	</TR>
	<%}}%>
	<TR>
		<TD colSpan=7><FONT color=#0000ff></FONT></TD>
	</TR>
	</TBODY>
</TABLE>
<script language="javascript">
$(document).ready(function(){
	showUserCardInfo();
});
</script>
<%!
	/**
		临时处理国际化
	*/
	public String getLogResource(String local,String action ,String dealType) {
        if(dealType!=null){
		    if(dealType.equals("SEND")){
			    action=action.replaceFirst("发送" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("COMPLETE")){
			    action=action.replaceFirst("结束流程" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("VIEW")){
			    action=action.replaceFirst("签收" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("TRAN")){
			    action=action.replaceFirst("转办给" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("END")){
			    action=action.replaceFirst("办理完毕" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("BACK")){
			    action=action.replaceFirst("退回到" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("sendRead")){
			    action=action.replaceFirst("发阅件" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("ABANDON")){
			    action=action.replaceFirst("作废流程" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("ADD")){
			    action=action.replaceFirst("加签" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("CANCEL")){
			    action=action.replaceFirst("取消流程" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("DRAWBACK")){
			    action=action.replaceFirst("撤办到" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("READED")){
			    action=action.replaceFirst("阅件办理完毕" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("RECALL")){
			    action=action.replaceFirst("撤办到" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
			if(dealType.equals("autoDeal")){
			    action=action.replaceFirst("自动办理" ,com.whir.i18n.Resource.getValue(local,"workflow","workflow.log_"+dealType));
		    }
		}
	    return action;     
	} 
%>