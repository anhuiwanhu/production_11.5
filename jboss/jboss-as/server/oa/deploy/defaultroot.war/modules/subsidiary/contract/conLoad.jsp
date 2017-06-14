<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.contract.po.*"%>
<%
  String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String recordIdPrint =request.getParameter("p_wf_recordId");
	String isPrint =request.getParameter("isPrint");
	String curModifyField = request.getAttribute("p_wf_cur_ModifyField")==null?"":request.getAttribute("p_wf_cur_ModifyField").toString();//当前活动可写字段
	String p_wf_openType  = request.getAttribute("p_wf_openType")!=null?request.getAttribute("p_wf_openType").toString():"";
	if (p_wf_openType.equals("reStart") || p_wf_openType.equals("startAgain")||p_wf_openType.equals("modifyView")) {
         curModifyField = "";
	}
%>
<head>
    <title>合同申请</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base_head.jsp"%>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <%@ include file="/public/include/meta_base_bpm.jsp"%>
    <script type="text/javascript">
	    function cmdPrint(){
	         window.print();
			 setTimeout(function(){window.close();},2000);
	    	//var draftParm ='?p_wf_recordId=<%=recordIdPrint%>&p_wf_moduleId=92&p_wf_openType=modifyView&isPrint=print';
	    	//openWin({url:'contract!conLoad.action'+draftParm,isFull:true,winName:'合同审批流程打印'});
		}
    </script>
</head>
<body class="docBodyStyle" scroll="no" onload="initBody();">
	<!--包含头部--->
	<%if(!"print".equals(isPrint)){%>
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
	<%}%>
	<div class="doc_Scroll">
		<%@ include file="/public/include/form_detail.jsp"%>
		<s:form name="dataForm" id="dataForm" action="" method="post" theme="simple" >
			<table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
			   <tr valign="top">
				  <td height="100%">
					 <div class="docbox_noline">
						
						<div class="doc_Movetitle" id="id_doc_movetitle">
						   <ul>
							  <li class="aon"  id="Panle0"><a href="#" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="#" onClick="changePanle(1);">流程图</a></li>
							  <li id="Panle2"><a href="#" onClick="changePanle(2);">流程记录</a></li>
							  <li id="Panle3"><a href="#" onClick="changePanle(3);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
							  <%if(!"1".equals(p_wf_pool_processType)){%>
							  <li id="Panle4"><a href="#" onClick="changePanle(4);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
							  <%}%>
						   </ul>
						</div>
						
						<div class="clearboth"></div>
						<div id="docinfo0" class="doc_Content" >
						   <!--表单包含页 -->
						   <div>
						   <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
							  <tr>
								 <td for="合同号" width="9%" class="td_lefttitle">合同号<span class="MustFillColor">*</span>：</td>
								 <td>
									 <%if(curModifyField.indexOf("$Contractcode$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										 <s:textfield name="Contractcode" id="Contractcode" cssClass="inputText" value="%{#request.Contractcode}" cssStyle="width:98%;" readonly="true"/>
									 <%}else{%>
										 <s:textfield name="Contractcode" id="Contractcode" cssClass="inputText" value="%{#request.Contractcode}" cssStyle="width:98%;" whir-options="vtype:['notempty',{'maxLength':50},'spechar3']"/>
									 <%}%>
								 </td>
								 <td for="合同所属项目" width="9%" class="td_lefttitle">合同所属项目：</td>
								 <td>
									 <%if(curModifyField.indexOf("$searchProjectName$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										 <s:textfield name="searchProjectName" id="searchProjectName" cssClass="inputText" value="%{#request.projctName}" cssStyle="width:98%;" readonly="true"/>
										 <s:hidden id="searchProjectId" name="searchProjectId" value="%{#request.ProjectId}"/>
									 <%}else{%>
										 <s:textfield name="searchProjectName" id="searchProjectName" cssClass="inputText" value="%{#request.projctName}" cssStyle="width:98%;" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick='popup({content:"url:<%=rootPath%>/contract!selectProjectList.action",title:"选择项目列表",lock:true,width:800,height:500});'></a>
										 <s:hidden id="searchProjectId" name="searchProjectId" value="%{#request.ProjectId}"/>
									 <%}%>
								 </td>
							  </tr>
							  
							  <tr>
								  <td for="合同名称" width="9%" class="td_lefttitle">合同名称<span class="MustFillColor">*</span>：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractName$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="ContractName" id="ContractName" cssClass="inputText" value="%{#request.ContractName}" cssStyle="width:98%;" readonly="true"/>
									  <%}else{%>
										  <s:textfield name="ContractName" id="ContractName" cssClass="inputText" value="%{#request.ContractName}" cssStyle="width:98%;" whir-options="vtype:['notempty',{'maxLength':50},'spechar3']"/>
									  <%}%>
								  </td>
								  <td for="合同类别" width="9%" class="td_lefttitle">合同类别：</td>
								  <td>
									  <%if(curModifyField.indexOf("$searchContractType$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="searchContractTypeName" id="searchContractTypeName" cssClass="inputText" value="%{#request.typeName}" cssStyle="width:98%;" readonly="true"/>
										  <s:hidden id="searchContractType" name="searchContractType" value="%{#request.ContractTypeId}"/>
									  <%}else{%>
										  <s:textfield name="searchContractTypeName" id="searchContractTypeName" cssClass="inputText" value="%{#request.typeName}" cssStyle="width:98%;" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick='popup({content:"url:<%=rootPath%>/contract!selectConTypeList.action",title:"选择合同类别",lock:true,width:800,height:500});'></a>
										  <s:hidden id="searchContractType" name="searchContractType" value="%{#request.ContractTypeId}"/>
									  <%}%>
								  </td>
							  </tr>
							  
							  <tr>
								  <td for="合同甲方" width="9%" class="td_lefttitle">合同甲方：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractPersonA$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="ContractPersonA" id="ContractPersonA" cssClass="inputText" value="%{#request.ContractPersonA}" cssStyle="width:98%;" readonly="true"/>
									  <%}else{%>
										  <s:textfield name="ContractPersonA" id="ContractPersonA" cssClass="inputText" value="%{#request.ContractPersonA}" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':50},'spechar3']"/>
									  <%}%>
								  </td>
								  <td for="合同乙方" width="9%" class="td_lefttitle">合同乙方：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractPersonB$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="ContractPersonB" id="ContractPersonB" cssClass="inputText" value="%{#request.ContractPersonB}" cssStyle="width:98%;" readonly="true"/>
									  <%}else{%>
										  <s:textfield name="ContractPersonB" id="ContractPersonB" cssClass="inputText" value="%{#request.ContractPersonB}" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':50},'spechar3']"/>
									  <%}%>
								  </td>
							  </tr>
							  
							  <tr>
								  <td for="合同丙方" width="9%" class="td_lefttitle">合同丙方：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractPersonC$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="ContractPersonC" id="ContractPersonC" cssClass="inputText" value="%{#request.ContractPersonC}" cssStyle="width:98%;" readonly="true"/>
									  <%}else{%>
										  <s:textfield name="ContractPersonC" id="ContractPersonC" cssClass="inputText" value="%{#request.ContractPersonC}" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':50},'spechar3']"/>
									  <%}%>
								  </td>
								  <td for="合同丁方" width="9%" class="td_lefttitle">合同丁方：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractPersonD$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="ContractPersonD" id="ContractPersonD" cssClass="inputText" value="%{#request.ContractPersonD}" cssStyle="width:98%;" readonly="true"/>
									  <%}else{%>
										  <s:textfield name="ContractPersonD" id="ContractPersonD" cssClass="inputText" value="%{#request.ContractPersonD}" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':50},'spechar3']"/>
									  <%}%>
								  </td>
							  </tr>
							  
							  <tr>
								  <td for="合同办理人" width="9%" class="td_lefttitle">合同办理人：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractActPer$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="ContractActPer" id="ContractActPer" cssClass="inputText" value="%{#request.ContractActPer}" cssStyle="width:98%;" readonly="true"/>
									  <%}else{%>
										  <s:textfield name="ContractActPer" id="ContractActPer" cssClass="inputText" value="%{#request.ContractActPer}" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':50},'spechar3']"/>
									  <%}%>
								  </td>
								  <td for="合同责任部门" width="9%" class="td_lefttitle">合同责任部门：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractActDepName$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:hidden id="ContractActDep" name="ContractActDep" value="%{#request.ContractActDep}"/><s:textfield name="ContractActDepName" id="ContractActDepName" cssClass="inputText" value="%{#request.ContractActDepName}" cssStyle="width:98%;" readonly="true"/>
									  <%}else{%>
										  <s:hidden id="ContractActDep" name="ContractActDep" value="%{#request.ContractActDep}"/><s:textfield name="ContractActDepName" id="ContractActDepName" cssClass="inputText" value="%{#request.ContractActDepName}" cssStyle="width:98%;" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'ContractActDep', allowName:'ContractActDepName', select:'userorg', single:'no', show:'userorg', range:'*0*'});"></a>
									  <%}%>
								  </td>
							  </tr>
							  
							  <tr>
								  <td for="合同性质" width="9%" class="td_lefttitle">合同性质：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractClass$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:select name="ContractClass" id="ContractClass" list="#{1:'应付款合同',2:'应收款合同',3:'其他合同'}" listKey="key"  listValue="value" value="%{#request.ContractClass}" cssClass="selectlist" cssStyle="width:98%" disabled="true"/>
									  <%}else{%>
										  <s:select name="ContractClass" id="ContractClass" list="#{1:'应付款合同',2:'应收款合同',3:'其他合同'}" listKey="key"  listValue="value" value="%{#request.ContractClass}" cssClass="selectlist" cssStyle="width:98%"/>
									  <%}%>
								  </td>
								  <td for="合同总金额" width="9%" class="td_lefttitle">合同总金额：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractCountMoney$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="ContractCountMoney" id="ContractCountMoney" cssClass="inputText" value="%{#request.ContractCountMoney}" cssStyle="width:98%;" readonly="true"/>
									  <%}else{%>
										  <s:textfield name="ContractCountMoney" id="ContractCountMoney" cssClass="inputText" value="%{#request.ContractCountMoney}" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':10},'p_decimal_e']"/>
									  <%}%>
								  </td>
							  </tr>
							  <%
								String sDate = request.getAttribute("ContractBeginDate")!=null?request.getAttribute("ContractBeginDate").toString():null;
								String eDate = request.getAttribute("ContractEndDate")!=null?request.getAttribute("ContractEndDate").toString():null;
							  %>
							  <tr>
								  <td for="开始日期" width="9%" class="td_lefttitle">开始日期：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractBeginDate$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="ContractBeginDate" id="ContractBeginDate" cssClass="inputText" value="%{#request.ContractBeginDate}" cssStyle="width:98%;" readonly="true"/>
									  <%}else{%>
										  <input name="ContractBeginDate" id="ContractBeginDate" class="Wdate" value="<%=sDate%>" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowToday:true,readOnly:true})"/>
									  <%}%>
								  </td>
								  <td for="结束日期" width="9%" class="td_lefttitle">结束日期：</td>
								  <td>
									  <%if(curModifyField.indexOf("$ContractEndDate$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textfield name="ContractEndDate" id="ContractEndDate" cssClass="inputText" value="%{#request.ContractEndDate}" cssStyle="width:98%;" readonly="true" />
									  <%}else{%>
										  <input name="ContractEndDate" id="ContractEndDate" class="Wdate" value="<%=eDate%>" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowToday:true,readOnly:true})"/>
									  <%}%>
								  </td>
							  </tr>
							  
							  <tr>
								  <td for="服务内容" width="9%" class="td_lefttitle">服务内容：</td>
								  <td colspan="3">
									  <%if(curModifyField.indexOf("$ContractSerContent$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textarea name="ContractSerContent"  id="ContractSerContent" cols="112" rows="3" cssClass="inputTextarea" value="%{#request.ContractSerContent}" cssStyle="width:99%;" readonly="true"></s:textarea>
									  <%}else{%>
										  <s:textarea name="ContractSerContent"  id="ContractSerContent" cols="112" rows="3" cssClass="inputTextarea" value="%{#request.ContractSerContent}" cssStyle="width:99%;" whir-options="vtype:[{'maxLength':500},'spechar3']"></s:textarea>
									  <%}%>
								  </td>
							  </tr>
							  
							  <tr>
								  <td for="合同正文" width="9%" class="td_lefttitle">合同正文：</td>
								  <td colspan="3">
									  <s:hidden name="ContractContent"  id="ContractContent" value="%{#request.ContractContent}"/>
									  <%if(curModifyField.indexOf("$ContractContent$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										 <input type="button" class="btnButton4font" onClick="viewJG();" value="查&nbsp;&nbsp;&nbsp;&nbsp;看" />
									  <%}else{%>
										 <input type="button" class="btnButton4font" onClick="writeJG();" value="编&nbsp;&nbsp;&nbsp;&nbsp;辑" />
									  <%}%>
								  </td>
							  </tr>
							  
							  <%
								ContractPO contractPO = (ContractPO)request.getAttribute("conPO");
								String realFileArray="";
								String saveFileArray="";
								Set Accessorys = contractPO.getContractAccessoryPO();
								if(Accessorys!=null && Accessorys.size()>0){
									Iterator itor = Accessorys.iterator();
									while(itor.hasNext()){
										ContractAccessoryPO Accessoryo = (ContractAccessoryPO)itor.next();
										if(Accessoryo !=null && Accessoryo.getSave() !=null && Accessoryo.getSaveName() !=null){
											realFileArray +=(String)Accessoryo.getSave() + "|";
											saveFileArray +=(String)Accessoryo.getSaveName() + "|";
										}
									}
								}
								if(!"".equals(realFileArray)){
								   realFileArray =realFileArray.substring(0,realFileArray.lastIndexOf("|"));
								   saveFileArray =saveFileArray.substring(0,saveFileArray.lastIndexOf("|"));
								}
								String canModify ="no";
								if(curModifyField.indexOf("$realFileName$") !=-1 || "reStart".equals(p_wf_openType) || "startAgain".equals(p_wf_openType)){
									canModify ="yes";
								}
							  %>
							  <tr>
								  <td for="附件" width="9%" class="td_lefttitle">附件：</td>
								  <td colspan="3">
									  <input type="hidden" name="realFileName" id="realFileName" style="width:800px;" value="<%=realFileArray%>"/>
									  <input type="hidden" name="saveFileName" id="saveFileName" style="width:800px;" value="<%=saveFileArray%>"/>
									  <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
										   <jsp:param name="accessType"  value="include" />
										   <jsp:param name="makeYMdir"   value="yes" />
										   <jsp:param name="onInit"      value="init" />
										   <jsp:param name="onSelect"    value="onSelect" />
										   <jsp:param name="onUploadProgress"  value="onUploadProgress" />
										   <jsp:param name="onUploadSuccess"   value="onUploadSuccess" />
										   <jsp:param name="isShowBatchDownButton"  value="no" />
										   <jsp:param name="dir"  value="contract" />
										   <jsp:param name="uniqueId"  value="contract" />
										   <jsp:param name="realFileNameInputId"  value="realFileName" />
										   <jsp:param name="saveFileNameInputId"  value="saveFileName" />
										   <jsp:param name="canModify"  value="<%=canModify%>" />
										   <jsp:param name="fileSizeLimit" value="0" />
										   <jsp:param name="fileTypeExts"  value="*.jpg;*.jpeg;*.gif;*.png;*.zip;*.doc;*.docx;*.xls;*.xlsm;*.ppt;*.pptx" />
										   <jsp:param name="uploadLimit"   value="0" />
									  </jsp:include>
								  </td>
							  </tr>
							  
							  <tr>
								  <td for="备注" width="9%" class="td_lefttitle">备注：</td>
								  <td colspan="3">
									  <%if(curModifyField.indexOf("$Remark$") <0 && !"reStart".equals(p_wf_openType) && !"startAgain".equals(p_wf_openType)){%>
										  <s:textarea name="Remark"  id="Remark" cols="112" rows="3" cssClass="inputTextarea" value="%{#request.Remark}" cssStyle="width:99%;" readonly="true"></s:textarea>
									  <%}else{%>
										  <s:textarea name="Remark"  id="Remark" cols="112" rows="3" cssClass="inputTextarea" value="%{#request.Remark}" cssStyle="width:99%;" whir-options="vtype:[{'maxLength':500},'spechar3']"></s:textarea>
									  <%}%>
								  </td>
							  </tr>
						   </table>
						   </div>
						   <%if("1".equals(p_wf_pool_processType)){%>
						   </br>
						   <%}%>
						   <!--工作流包含页-->
						   <div><%@ include file="/platform/bpm/pool/pool_include_form.jsp"%></div>
						   <!--批示意见包含页-->
						   <div><%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%></div>
						</div>
						<div id="docinfo1" class="doc_Content"  style="display:none;"></div>
						<div id="docinfo2" class="doc_Content"  style="display:none;"></div>
						<div id="docinfo3" class="doc_Content"  style="display:none;"></div>
						<div id="docinfo4" class="doc_Content"  style="display:none;"></div>
					 </div>
				  </td>
			   </tr>
			</table>
		</s:form>
	</div>
    <div class="docbody_margin"></div>
    <%@ include file="/platform/bpm/pool/pool_include_form_end.jsp"%>
	
	<!--归档时用的form luosong 2017-3-1-->  
	<form name="form4" action="<%=rootPath%>/modules/subsidiary/contract/contract_gd.jsp?gd=1" method="POST">
		<input type="hidden" name="pageContent">
		<input type="hidden" name="gd_processInstanceId"  value='<%=request.getAttribute("p_wf_processInstanceId")+""%>' />
		<input type="hidden" name="gd_title"           value='<%=request.getAttribute("p_wf_processName")+""%>' />
		<input type="hidden" name="gd_startUserCode"   value='<%=request.getAttribute("p_wf_submitUserAccount")+""%>' />
		<input type="hidden" name="gd_startUserName"   value='<%=request.getAttribute("p_wf_submitPerson")+""%>' />
		<input type="hidden" name="gd_startTime"       value='<%=request.getAttribute("p_wf_submitTime")+""%>'  />
		<input type="hidden" name="gd_startOrgId"      value='<%=request.getAttribute("p_wf_startOrgId")+""%>'  />
		<input type="hidden" name="gd_remindTitle"    id="gd_remindTitle1"  value='<%=request.getAttribute("p_wf_remindTitle")+""%>'  />
		<input type="hidden" name="gd_type"    value='<%=request.getAttribute("p_wf_processNeedDossierType")+""%>'  />
		<input type="hidden" name="gd_path"    value='<%=request.getAttribute("p_wf_processNeedDossierPath")+""%>'  />
	</form>
</body>
<script type="text/javascript">
    /**切换页面*/
    function  changePanle(flag){
        for(var i=0;i<5;i++){
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
    }
    
    /**初始话信息*/
    function initBody(){
        //初始话信息
        ezFlowinit();
    }
    
    function viewJG(){
		openWin({url:'<%=rootPath%>/public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+document.getElementById("ContractContent").value+'&EditType=0&CanSave=1&saveDocFile=0&moduleType=contract&field=ContractContent&showEditButton=0',isFull:true,winName:'查看合同正文'});
	}
	
	function writeJG(){
		openWin({url:'<%=rootPath%>/public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+document.getElementById("ContractContent").value+'&EditType=1&CanSave=1&saveDocFile=1&moduleType=contract&field=ContractContent&showEditButton=1',isFull:true,winName:'编辑合同正文'});
	}
	
	//检查页面参数有效性
	function initPara(){
	    var flag = validateForm("dataForm");
	    if(flag){
			return true;
		}
	}
	
	var isPrint ='<%=isPrint%>';
	if(isPrint =='print'){
		$(document).ready(function(){
			window.print();
			setTimeout(function(){window.close();},2000);
		});
	}
	
	//2017-2-24 luosong
   <%if(request.getParameter("gd") != null){%>
     gd();
   <%}%>
   
   //归档
	function gd(){
		var ContractName = $("#ContractName").val();
		$("#gd_remindTitle1").val(ContractName);
		$("#id_doc_movetitle").remove(); 
		$("#popToolbar").remove();
		document.form4.pageContent.value = document.body.innerHTML;
		document.form4.submit();
	}
</script>
</html>