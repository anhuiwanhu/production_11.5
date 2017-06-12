<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%

String userId = session.getAttribute("userId").toString();
boolean hasMsg = com.whir.org.common.util.SysSetupReader.getInstance().hasMsg(session.getAttribute("domainId").toString());
String range = "*AAAA*";
if(session.getAttribute("rang")!=null && !"".equals(session.getAttribute("rang"))){
	range = (String)session.getAttribute("rang");
}
String receive = "";
if(request.getAttribute("receive")!=null && !"".equals(request.getAttribute("receive"))){
	receive = (String)request.getAttribute("receive");
}
%>
<head>  
	<title><bean:message bundle="personalwork" key="personalwork.tasksearch"/></title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_list.jsp"%>  
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
</head> 
<body class="MainFrameBox"> 
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="${ctx}/taskCenter!selectSearchTaskData.action" method="post" theme="simple">
	<input type="hidden" id="range" name="range" value="<%=range%>">
	<input type="hidden" id="receive" name="receive" value="<%=receive%>">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar" id="searchTable" style="display:none">  
        <tr>
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"personalwork","project.TaskName")%>：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="taskTitle" name="taskTitle" cssClass="inputText"/>
            </td>
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.finishedrate")%>：</td>
            <td class="whir_td_searchinput">
                <select name="taskFinishRate" class="selectlist" style="margin:0px;">
                	<%String taskFinishRate=request.getParameter("taskFinishRate")==null?"":request.getParameter("taskFinishRate");%>
                	<option value="-1">--<s:text name='commonuse.Pleaseselect'/>--</option>
				  <%for (int i=0;i<=95;i=i+5){%>
				    <option value="<%=i%>" <%=taskFinishRate.equals(i+"")?"selected":""%>><%=i%>%</option>
				  <%}%>
                </select>
            </td>
            
            <td class="whir_td_searchtitle">
			  <bean:message bundle="personalwork" key="taskcenter.task"/><%if(request.getParameter("receive")!=null && request.getParameter("receive").equals("receive")){%><bean:message bundle="personalwork" key="taskcenter.accept"/><%}else{%><bean:message bundle="personalwork" key="taskcenter.create"/><%}%><bean:message bundle="personalwork" key="taskcenter.person"/>：
			</td>
            <td class="whir_td_searchinput">
			  <%String typeR=request.getParameter("typeR")==null?"":request.getParameter("typeR");%>
			  <input type="radio" name="typeR" value="org" <%=typeR.equals("org")||typeR.equals("")?"checked":""%> onclick="changeReceiveType();"/>
			  <bean:message bundle="personalwork" key="taskcenter.bydept"/>
			  &nbsp;<input  type="radio" name="typeR" value="user" <%=typeR.equals("user")?"checked":""%> onclick="changeReceiveType();"/>
			  <bean:message bundle="personalwork" key="taskcenter.byemp"/> 
			</td>

       </tr>
       <tr>
       		<td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.tasktype")%>：</td>
            <td class="whir_td_searchinput" nowrap="nowrap">
				<%String taskType=request.getParameter("taskType")==null?"":request.getParameter("taskType");%>
				<select id="taskType" class="selectlist" style="margin:0px;" name="taskType" >
                	<option value="-1" <%=taskType.equals("-1")?"selected":""%>>--<s:text name='commonuse.Pleaseselect'/>--</option>
                	<option value="其它" <%="其它".equals(taskType)?"selected":""%>><%=Resource.getValue(whir_locale,"personalwork","workstatus.other")%></option>
				  	<s:iterator  value="allTaskClassList" status="st" id="taskClassVO"> 
					  	<s:if test="top==<%=taskType%>">
						  	<option value="<s:property value='className' />" selected="selected">
						  		<s:property value="className" /> 
							</option>
					  	</s:if>
					  	<s:else>
						  	<option value="<s:property value='className' />">
						  		<s:property value="className" /> 
							</option>
					  	</s:else>
					 </s:iterator>
                </select>
            </td>
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.priority")%>：</td>
            <td class="whir_td_searchinput" >
                <s:select name="taskPriority" cssStyle="margin:0px;" list="#{'0':getText('taskcenter.normal'),'1':getText('taskcenter.quick'),'2':getText('taskcenter.immediately')}" listKey="key"  listValue="value" headerKey="" headerValue="--%{getText('commonuse.Pleaseselect')}--"  cssClass="selectlist" />
            </td>

            <td class="whir_td_searchtitle">
			 <span id="departmentSpan"><bean:message bundle="personalwork" key="taskcenter.department"/></span><span id="employeeSpan" style="display:none;"><bean:message bundle="personalwork" key="taskcenter.employee"/></span>：
			</td>
			<%
			  String taskJoinOrgName=request.getParameter("taskJoinOrgName")==null?"":request.getParameter("taskJoinOrgName");
			  String taskJoinOrgId=request.getParameter("taskJoinOrgId")==null?"":request.getParameter("taskJoinOrgId");
			  String taskJoinedEmpName=request.getParameter("taskJoinedEmpName")==null?"":request.getParameter("taskJoinedEmpName");
			  String taskJoinedEmpId=request.getParameter("taskJoinedEmpId")==null?"":request.getParameter("taskJoinedEmpId");
			%>
            <td id="orgTR" <%=typeR.equals("user")?"style=\"display:none\"":""%> nowrap="nowrap">
			  <input type="hidden" id="taskJoinOrgId" name="taskJoinOrgId" value="<%=taskJoinOrgId%>">	
			  <input type="text" id="taskJoinOrgName" name="taskJoinOrgName" value="<%=taskJoinOrgName%>" readonly="readonly" class="inputText"><a href="#" class="selectIco" onclick="openSelect({allowId:'taskJoinOrgId', allowName:'taskJoinOrgName', select:'org', single:'no', show:'org', range:'<%=range%>'});"></a>
			</td>
			<td id="userTR" <%=typeR.equals("org") || typeR.equals("")?"style=\"display:none\"":""%> nowrap="nowrap">
			  <input type="hidden" id="taskJoinedEmpId" name="taskJoinedEmpId" value="<%=taskJoinedEmpId%>">			  
			  <input type="text" id="taskJoinedEmpName" name="taskJoinedEmpName" value="<%=taskJoinedEmpName%>" class="inputText" readonly="readonly"><a href="#" class="selectIco" onclick="openSelect({allowId:'taskJoinedEmpId', allowName:'taskJoinedEmpName', select:'usergroup', single:'no', show:'usergroup', range:'<%=range%>'});"></a>
			</td>
       </tr>
       <tr>
       		<td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.status")%>：</td>
            <td class="whir_td_searchinput" nowrap="nowrap">
                <s:select name="taskStatus" cssStyle="margin:0px;" list="#{'0':getText('taskcenter.notstart'),'1':getText('taskcenter.ongoing'),'2':getText('taskcenter.delay'),'3':getText('taskcenter.finished'),'4':getText('taskcenter.checking'),'5':getText('taskcenter.canceled')}" listKey="key"  listValue="value" headerKey="" headerValue="--%{getText('commonuse.Pleaseselect')}--"  cssClass="selectlist" />
            </td>
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"personalwork","diary.begin")%>：</td>
            <td class="whir_td_searchinput" nowrap="nowrap">
				<input name="startTaskBeginTime"  id="startTaskBeginTime"   class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'endTaskBeginTime\',{d:0});}'})" />
				&nbsp;<%=Resource.getValue(whir_locale,"personalwork","taskcenter.to")%>&nbsp;
				<input name="endTaskBeginTime" id="endTaskBeginTime"  class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'startTaskBeginTime\',{d:1});}'})" />
            </td>
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.enddate")%>：</td>
            <td class="whir_td_searchinput" nowrap="nowrap">
				<input name="startTaskEndTime"  id="startTaskEndTime"   class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'endTaskEndTime\',{d:0});}'})" />
				&nbsp;<%=Resource.getValue(whir_locale,"personalwork","taskcenter.to")%>&nbsp;
				<input name="endTaskEndTime" id="endTaskEndTime"  class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'startTaskEndTime\',{d:1});}'})" />
            </td>
       </tr>
       <tr>
            <td class="whir_td_searchtitle">&nbsp;</td>
            <td class="whir_td_searchinput">&nbsp;</td>
            <td class="whir_td_searchtitle">&nbsp;</td>
			<td class="whir_td_searchinput">&nbsp;</td>
            <td class="SearchBar_toolbar"  nowrap="nowrap" colspan="2">
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="<s:text name='comm.searchnow'/>" />
				<!--resetForm(obj)为公共方法-->
				<%--
                <input type="button" class="btnButton4font" value="<s:text name='comm.clear'/>" onclick="resetForm(this);" />
                 --%>
                <input type="button" class="btnButton4font" value="<s:text name='comm.clear'/>" onclick="newResetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
	
	<!-- MIDDLE  BUTTONS START -->  
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
        <tr>  
            <td align="right">  
               <input name="" type="button" value="<s:text name='comm.export'/>" class="btnButton4font" onclick="exportExcel();" />   
               <input name="" type="button" value="<%=Resource.getValue(whir_locale,"personalwork","open.search")%>" class="btnButton4font" onclick="chSearch(this);" />   
            </td>  
        </tr>  
    </table>  
    <!-- MIDDLE  BUTTONS END --> 
	
	<!-- LIST TITLE PART START -->
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
		    <td whir-options="field:'taskPriority',width:'5%',renderer:showPriority"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.priority")%></td> 
			<td whir-options="field:'taskType',width:'10%',allowSort:true"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.tasktype")%></td> 
			<td whir-options="field:'taskTitle',width:'46%',renderer:show,allowSort:true"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.taskname")%></td>
			<td whir-options="field:'taskBeginTime',width:'10%',renderer:common_DateFormatFull"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.startdate")%></td>
			<td whir-options="field:'taskEndTime',width:'10%',renderer:common_DateFormatFull,allowSort:true"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.enddate")%></td> 
			<td whir-options="field:'taskPrincipalNames',width:'8%',allowSort:true"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.principal")%></td> 
			<td whir-options="field:'taskFinishRate',width:'5%',renderer:showFinishRate,allowSort:true"><%=Resource.getValue(whir_locale,"personalwork","taskcenter.finishedrate")%></td> 
			<td whir-options="field:'taskStatus',width:'6%',renderer:showisCheck,allowSort:true"><%=Resource.getValue(whir_locale,"personalwork","status.status")%></td> 
        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->

	</s:form>


</body>


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm',onLoadSuccessAfter:showInfo});
		
	});
	//优先级
	function showPriority(po,i){
		var html ;
		if(po.taskPriority==0){
			html = '<font color="#0000FF">一般</font>';
		}else if(po.taskPriority==1){
			html = '<font color="#000000">快办</font>';
		}else{
			html = "即办";
		}
		return html;
	}
	
	//任务类型
	function showType(po,i){
		var html ;
		if(po.taskType=='其它'){
			html = "其它";
		}else{
			html = po.taskType;
		}
		return html;
	}
	//完成率
	function showFinishRate(po,i){
		
		return po.taskFinishRate+"%";
	}
	
	//显示安排人
	function showInfo(){
		$(".trigger1").powerFloat({
		    targetMode: "ajax"
		});
	}

	//任务名称
	function show(po,i){
		var html = '<a href="javascript:void(0)" onclick="openWin({url:\'taskCenter!selectSingleTask.action?modi=1&cansees=1&taskId='+po.taskId+'&fromMod==taskCheckList'+'\',isFull:true,width:800,height:600,winName:\'showTask\'});">'+po.taskTitle+'</a>';
		return html;
	}

	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
	//优先级
	function showPriority(po,i){
		var html ;
		if(po.taskPriority==0){
			html = '<font color="#0000FF">一般</font>';
		}else if(po.taskPriority==1){
			html = '<font color="#000000">快办</font>';
		}else{
			html = "即办";
		}
		return html;
	}
	//考核状态
	function showisCheck(po,i){
		var html ;
		if(po.taskStatus=='0'){
			html = "未开始";
		}else if(po.taskStatus=='1'&&po.taskFinishRate!='100'){
			html = "进行中";
		}else if(po.taskStatus=='3'){
			html = "已推迟";
		}else if((po.taskStatus=='2'||po.taskStatus=='4')&&po.taskFinishRate=='100'){
			html = "已完成";
		}else if(po.taskStatus=='1'&&po.taskFinishRate=='100'){
			html = "待考核";
		}else if(po.taskStatus=='4'&&po.taskFinishRate!='100'){
			html = "已取消";
		}
		return html;
	}
	function showCreatedEmp(po,i){
		var html = "";
		var target = "";
		if('<%=userId%>'==po.createdEmp){
			target = "true";
		}
		var data = "/defaultroot/modules/personal/task/getInfo.jsp?id="+po.createdEmp+"&hasMsg="+target;
		html +="<a class=\"trigger1\" href=\"javascript:void(0);view("+po.createdEmp+","+target+");\" rel=\""+data+"\" >"+po.createdEmpName+"</a>";
		
		return html;
	}
	
	function common_DateFormatFull(datestr){
		if(datestr.length > 10){
			return datestr.substring(0,10);
		}
		return datestr;
	}
	
	function chSearch(obj){
		if(obj.value == "<%=Resource.getValue(whir_locale,"personalwork","open.search")%>"){
			obj.value = "<%=Resource.getValue(whir_locale,"personalwork","close.search")%>";
			$('#searchTable').css('display','');
		}else{
			obj.value = "<%=Resource.getValue(whir_locale,"personalwork","open.search")%>";
			$('#searchTable').css('display','none');
		}
	}
	//自定义操作栏内容
	function myOperate(po,i){
		var html =  '';
		if(po.isCheck=="false" && po.taskFinishRate=="100" &&po.taskStatus=="1"){
			html += '<a href="javascript:void(0)" onclick="openWin({url:\'taskCenter!tasksettleCheckAdd.action?taskId='+po.taskId+'&taskTitle='+po.taskTitle+'\',width:800,height:600,winName:\'tasksettleCheckAdd'+i+'\'});"><img border="0" src="<%=rootPath%>/images/py.gif" title="<%=Resource.getValue(whir_locale,"personalwork","taskcenter.evaluationword")%>" ></a>';
		}else{
			html =  '&nbsp;';
		}
		return html;
	}
	function changeReceiveType(){
	    if ($("input[name='typeR'][value='org']").attr("checked")=='checked'){
	    	$('#userTR').css('display','none');
	    	$('#orgTR').css('display','');
	    	$('#departmentSpan').css('display','');
	    	$('#employeeSpan').css('display','none');
	    }else if($("input[name='typeR'][value='user']").attr("checked")=='checked'){
	        $('#userTR').css('display','');
	    	$('#orgTR').css('display','none');
	    	$('#departmentSpan').css('display','none');
	    	$('#employeeSpan').css('display','');
	    }
	}
	//导出
	function exportExcel() {
		var itemContainer = $("#recordCount").val();
		if(itemContainer == "0") {
			whir_alert("没有可导出的内容！", null);
			return;
		}
		var receive = $('#receive').val();
		queryForm.action = 'taskCenter!selectSearchTaskExport.action?receive='+receive;
		queryForm.target = "_blank";
		queryForm.submit();
		queryForm.action = 'taskCenter!selectSearchTaskData.action';
	}
	function newResetForm(obj) {
		resetForm(obj);
		changeReceiveType();
	}
   </script>

</html>
