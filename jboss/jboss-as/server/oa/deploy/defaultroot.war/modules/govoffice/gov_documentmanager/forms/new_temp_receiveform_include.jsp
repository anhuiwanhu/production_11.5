<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
com.whir.ezoffice.ezform.util.ModuleParser parser = new com.whir.ezoffice.ezform.util.ModuleParser();
String formId="";
String read_recordId =  request.getParameter("p_wf_recordId")==null?"": request.getParameter("p_wf_recordId")+"";
String read_tableId=request.getAttribute("p_wf_tableId").toString();
		if ("1".equals(request.getParameter("extendMainTable"))) {
			read_recordId = request.getParameter("p_wf_pareRecordId");
		} 
%>
				<input type="hidden" name="noNeedFlush" value="1" /> <!--不刷新页面-->
                <input type="hidden" name="isChangeSeq" value="0">
				<s:hidden name="seq" property="seq" />
				<s:hidden name="seqId" property="seqId"/>
				<input type="hidden" name="seqyear" value="-1">
				<s:hidden name="tableNameOrId" property="p_wf_tableId" />
				<!-- <input type="hidden" name="receiveAccType" value="1"> 标明在 收文
				 <s:hidden name="sendFileId" property="p_wf_recordId" />
				 <s:hidden name="sendFileLink" property="sendFileLink" />
				 <s:hidden name="sendFileTitle" property="sendFileTitle1" />
				 <s:hidden name="fromFileSendCheckLink" property="fromFileSendCheckLink" />
				 <s:hidden name="fromFileSendCheckId" property="fromFileSendCheckId" />-->
				 <s:hidden name="done" />
				 <input type="hidden" name="createdDate1">
				<!--<s:hidden name="isMyReceiveDoc" property="isMyReceiveDoc" />
				 <input type="hidden" name="fromSendFileType" value="${param.fromSendFileType}">
				 <input type="hidden" name="winHref" value="GovReceiveFileAction.do?action=see&processId=${param.processId}&processName=${param.processName}&processType=${param.processType}&tableId=${param.tableId}&remindField=">
				<s:if test="%#{param.exchangeFileLink != null}">
					<input type="hidden" name="exchangeFileId" value="${param.id}">
					<input type="hidden" name="exchangeFileLink" value="${param.exchangeFileLink}">
					<input type="hidden" name="exchangeFileTitle" value="${param.title}">
				</s:if>-->
                <govContent></govContent>
				
                       