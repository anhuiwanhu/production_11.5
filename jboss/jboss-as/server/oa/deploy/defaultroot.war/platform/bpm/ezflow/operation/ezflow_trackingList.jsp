<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.whir.i18n.Resource"%>
<%@page import="java.util.*"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String processInstanceId=request.getParameter("p_wf_processInstanceId")==null?"":request.getParameter("p_wf_processInstanceId").toString();
String isPrint=request.getParameter("isPrint")==null?"":request.getParameter("isPrint").toString();
com.whir.service.api.ezflowservice.EzFLOWForWorkFlow bd =new com.whir.service.api.ezflowservice.EzFLOWForWorkFlow();
Map map =new HashMap();
map =bd.getWorkFlowTrackingList(processInstanceId);
%>
<html>
<head>
	<title>流程跟踪单</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<style type="text/css">
		.trackTable{width: 100%}
		.trackTable td{border:1px solid #ccc;}
		.trackTable td{padding: 5px;}
		.bold{font-weight: bold;}
	</style>
</head>
<body bgcolor="#ffffff">
<div>&nbsp;</div>
<table cellspacing="0" cellpadding="0"  style="border-collapse: collapse;" class="trackTable">
  	<%if(isPrint.equals("")){%>
  	<tr>
		<td colspan="5" style="text-align: right;">
			<input type="button" onClick="myprint();" value="打　印" class="btnButton4font"/>
		</td>
	</tr>
	<%}%>
  	<tr>
		<td colspan="5" class="bold">当前节点信息</td>
	</tr>
	<%
	List procinstList =(List) map.get("real_procinstList");
	if(procinstList !=null && procinstList.size() >0){
		for(int i=0;i<procinstList.size();i++){
			Object[] obj =(Object[])procinstList.get(0);
	%>
  	<tr>
		<td width="15%">当前所处节点：</td>
		<td width="35%" colspan="2"><%=obj[0]==null?"":obj[0].toString()%></td>
		<td width="15%">当前处理人：</td>
		<td width="35%"><%=obj[1]==null?"":obj[1].toString()%></td>
	</tr>
	<%
		}
	}
	%>

	<tr>
		<td colspan="5" class="bold">办理过程记录</td>
	</tr>

	<tr style="text-align:center;font-weight: bold;">
		<td width="15%">活动名称</td>
		<td width="15%">处理人</td>
		<td width="20%">操作时间</td>
		<td width="15%">操作</td>
		<td width="35%">批示意见</td>
	</tr>
   	<%
   	List dealList =(List) map.get("dealList");
   	if(dealList !=null && dealList.size() >0){
		for(int j=0;j<dealList.size();j++){
			Object[] obj =(Object[])dealList.get(j);
			String dealusername =obj[0]==null?"":obj[0].toString();
			String dealtime =obj[1]==null?"":obj[1].toString();
			if(!"".equals(dealtime) && dealtime.length() >19){
				dealtime =dealtime.substring(0,19);
			}
			String dealtype =obj[2]==null?"":obj[2].toString();
			String curactivityname =obj[3]==null?"":obj[3].toString();
			String dealcontent =obj[4]==null?"":obj[4].toString();
			String operateName ="";
			if("END".equals(dealtype)){
				operateName ="办理完毕";
			}else if("COMPLETE".equals(dealtype)){
				operateName ="结束流程";
			}else if("BACK".equals(dealtype)){
				operateName ="退回";
			}else if("TRAN".equals(dealtype)){
				operateName ="转办";
			}else if("RECALL".equals(dealtype)){
				operateName ="撤办";
			}else if("ADD".equals(dealtype)){
				operateName ="加签";
			}else if("MAILSEND".equals(dealtype)){
				operateName ="邮件转发";
			}else{
				operateName ="发送";
			}
   	%>
	<tr>
		<td width="15%"><%=curactivityname%></td>
		<td width="15%"><%=dealusername%></td>
		<td width="20%"><%=dealtime%></td>
		<td width="15%"><%=operateName%></td>
		<td width="35%"><%=dealcontent%></td>
	</tr>
	<%
		}
	}
	%>
</table>
</body>
<script type="text/javascript">
	function myprint(){
		var url="/defaultroot/platform/bpm/ezflow/operation/ezflow_trackingList.jsp?p_wf_processInstanceId=<%=processInstanceId%>&isPrint=true";
		//alert(url);
	    openWin({url:url,isFull:true,winName:'打印流程跟踪单'});
	}

	<%if("true".equals(isPrint)){%>
	    window.print();
	    setTimeout(function(){window.close();},2000);
	<%}%>
</script>
</html>