<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="java.util.*"%><%
    String taskId=request.getParameter("taskId")==null?"":request.getParameter("taskId");

	com.whir.service.api.ezflowservice.EzFlowTransactorService  tranService=new com.whir.service.api.ezflowservice.EzFlowTransactorService();
	String operId=tranService.judgeSubActivityStatus(taskId);  
	out.print(operId);%>