<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.ezoffice.customForm.ui2.*"%>
<%@ page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");
String pageId = EncryptUtil.htmlcode(request.getParameter("pageId"));

String processName = request.getAttribute("p_wf_processName")!=null?(String)request.getAttribute("p_wf_processName"):"";
String processId = request.getAttribute("p_wf_processId")!=null?(String)request.getAttribute("p_wf_processId"):"";
String activity = request.getAttribute("p_wf_cur_activityId")!=null?(String)request.getAttribute("p_wf_cur_activityId"):"";
String resubmit = request.getAttribute("p_wf_resubmit")!=null?(String)request.getAttribute("p_wf_resubmit"):"";
String action = request.getAttribute("p_wf_openType")!=null?(String)request.getAttribute("p_wf_openType"):"";

//用于自定义模块
String menuId = request.getParameter("menuId");
String moduleType = request.getParameter("moduleType");
String isprint = request.getParameter("isprint");

ParserHtml pHtml = new ParserHtml();
com.whir.ezoffice.customForm.bd.CustomFormBD cst = new com.whir.ezoffice.customForm.bd.CustomFormBD();
//Boolean isResubmit = Boolean.FALSE;
//if(request.getAttribute("resubmitWorkId") != null)isResubmit=Boolean.TRUE;
%>
<div id="showformDiv" style="width:100%;<%if("1".equals(isprint)){}else{%>height:100%;<%}%>padding:10px;">
<script language="javascript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/WorkflowResource.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=rootPath%>/platform/custom/custom_form/run/css/formstyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=rootPath%>/platform/custom/custom_form/run/css/formstyle_ext.css"/>
<script language="javascript" src="<%=rootPath%>/platform/custom/custom_form/run/js/form.js"></script>
<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/popselectdata.js"></script>
<script language="javascript" src="<%=rootPath%>/scripts/util/textareaAutoHeight2.js"></script>

<input type="hidden" id="Page_Id" name="Page_Id" value="<%=pageId%>"/>
<input type="hidden" id="work_Status" name="work_Status" value="<%=request.getAttribute("p_wf_workStatus")%>"/>
<input type="hidden" id="Modify_Field" name="Modify_Field" value="<%=request.getAttribute("p_wf_cur_ModifyField")%>"/>
<input type="hidden" id="Info_Id" name="Info_Id" value="<%=request.getAttribute("p_wf_recordId")%>"/>
<input type="hidden" id="infoId" name="infoId" value="<%=request.getAttribute("p_wf_recordId")%>"/>
<input type="hidden" id="isFormPrint" name="isFormPrint" value="<%=isprint%>"/>
<!-- 取此表单的唯一字段 -->
<input type="hidden" id="page_only_field" name="page_only_field" value="<%=cst.getOnlyField(pageId)%>"/>
<%@ include file="/platform/custom/custom_form/run/userinfo_include.jsp"%>
<%=cst.getComputeFieldHTML(pageId)%>
<jsp:include page="/platform/custom/custom_form/run/kq_include.jsp" flush="true">
    <jsp:param name="processName" value="<%=processName%>"/>
    <jsp:param name="action" value="<%=action%>"/>
</jsp:include>
<div id="formHTML">
<!-- 读取表单设计模板 -->
<%=pHtml.parseHtml(request, pageId)%>
</div>
<%
//子表的计算字段设置
out.print(new UIBD().getForeignComputeFieldHTML(pageId));
%>
<script language="javascript" src="<%=rootPath%>/platform/custom/custom_form/run/js/showform.js"></script>
<%@ include file="/platform/custom/custom_form/run/relate_include.jsp"%>
<jsp:include page="/platform/custom/custom_form/run/showform_include.jsp" flush="true">
    <jsp:param name="pageId" value="<%=pageId%>"/>
</jsp:include>
<jsp:include page="/platform/custom/custom_form/run/formext_include.jsp" flush="true">
    <jsp:param name="moduleType" value="<%=moduleType%>"/>
    <jsp:param name="processId" value="<%=processId%>"/>
    <jsp:param name="menuId" value="<%=menuId%>"/>
    <jsp:param name="activity" value="<%=activity%>"/>
    <jsp:param name="resubmit" value="<%=resubmit%>"/>
</jsp:include>
</div>
<div id="adddelrow_div" style="BORDER-RIGHT: #0a246a 1px solid; BORDER-TOP: #0a246a 1px solid; VISIBILITY: hidden; BORDER-LEFT: #0a246a 1px solid; WIDTH: 30px; BORDER-BOTTOM: #0a246a 1px solid; POSITION: absolute">
    <table height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  	<tbody>
  		<tr>
    		<td onmouseover="this.style.borderRiht='1px #0A246A solid';" onmouseout="this.style.borderRiht='';" align=middle><SPAN id="delrow_div" title='点击删除记录' style="cursor: pointer"><IMG height=12 src="<%=rootPath%>/platform/custom/custom_form/run/images/delarrow.gif" width=12 onclick='delRow()' align=absMiddle></SPAN>
			</td>
			<td>&nbsp;</td>
    		<td onmouseover="this.style.borderLeft='1px #0A246A solid';" onmouseout="this.style.borderLeft='';" align=middle><SPAN id="addrow_div" title='点击添加记录' style="cursor: pointer"><IMG height=12 src="<%=rootPath%>/platform/custom/custom_form/run/images/addarrow.gif" width=12 onclick='addRow()' align=absMiddle></SPAN>
  			</td>
		</tr>
	</tbody>
	</table>
</div>
<script src="<%=rootPath%>/modules/subsidiary/budget/js/wf_budget.js" language="javascript"></script>
<script src="<%=rootPath%>/modules/hrm/kq/js/kqWorkFlow.js" language="javascript"></script>
<script src="<%=rootPath%>/modules/subsidiary/projectmanager/ezForm/field_project_budget.js" language="javascript"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
$(document).ready(function(){
    initFormFunc();
});

//禁止页面查看源代码和F12键调试  开始
document.oncontextmenu=new Function("return false")
//document.onselectstart=new Function("return false") 

document.onkeydown=function (e){
    var currKey=0,evt=e||window.event;
    currKey=evt.keyCode||evt.which||evt.charCode;
    if (currKey == 123) {
		//火狐禁止不了F12，特殊处理  开始
		var userAgent = window.navigator.userAgent.toLowerCase();  
		if(userAgent.indexOf("firefox")!=-1){
			window.close();
		}
		//火狐禁止不了F12，特殊处理  结束
		window.event.keyCode=0;
        window.event.cancelBubble = true;
        window.event.returnValue = false;
    }
}
//禁止页面查看源代码和F12键调试  结束
//-->
</SCRIPT>