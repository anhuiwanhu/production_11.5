<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.math.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="com.whir.ezoffice.resource.po.SsDetailPO"%>
<%@ page import="com.whir.ezoffice.resource.bd.IntoOutStockBD"%>
<%
  String local    = session.getAttribute("org.apache.struts.action.LOCALE").toString();
  DateFormat df2  = DateFormat.getDateInstance(DateFormat.LONG, Locale.CHINESE);
  String stockId  = request.getAttribute("stockId")==null?"":""+request.getAttribute("stockId");
  String ssDeptId = request.getAttribute("ssDept")!=null?request.getAttribute("ssDept").toString():"";
  String mode     = request.getAttribute("mode")!=null?(((String)request.getAttribute("mode")).equals("2")?"outStock":"returnStock"):"outStock";
  String workTitle     = request.getAttribute("stockName")+"领用"+(mode.equals("outStock")?"出库":"退库")+"流程等待您的办理！";
  String curModiFields = request.getAttribute("p_wf_cur_ModifyField")!=null?request.getAttribute("p_wf_cur_ModifyField").toString():"";
  String p_wf_openType = request.getAttribute("p_wf_openType")!=null?request.getAttribute("p_wf_openType").toString():"";
  String checkFlag     = request.getAttribute("checkFlag")==null?"N":request.getAttribute("checkFlag").toString();
  String outFlag       = request.getParameter("outFlag");
  String canview       = request.getParameter("canview")==null?"1":request.getParameter("canview");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>领用<%=mode.equals("outStock")?"出库":"退库"%></title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base_head.jsp"%>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <%@ include file="/public/include/meta_base_workflow.jsp"%>
    <script type="text/javascript">
	    function cmdPrint(){
	    	$('.doc_Scroll').removeClass('doc_Scroll');
	    	window.print();
		}
    </script>
    <style>
		.TBStyle{
		    BACKGROUND-COLOR: #ffffff;
		    BORDER-BOTTOM: #000000 0px solid;
		    BORDER-LEFT: #000000 0px solid;
		    BORDER-RIGHT: #000000 1px solid;
		    BORDER-TOP: #000000 1px solid;
		    TEXT-DECORATION: none;
		    COLOR: #000000;
		}
		
		.TDStyle{}
		.TDStyle td{
		    BACKGROUND-COLOR: #ffffff;
		    BORDER-BOTTOM: #000000 1px solid;
		    BORDER-LEFT: #000000 1px solid;
		    BORDER-RIGHT: #000000 0px solid;
		    BORDER-TOP: #000000 0px solid;
		    TEXT-DECORATION: none;
		    COLOR: #000000;
		}
		
		.TDTitleStyle{}
		.TDTitleStyle td{
		    BACKGROUND-COLOR: menu;
		    BORDER-BOTTOM: #000000 1px solid;
		    BORDER-LEFT: #000000 1px solid;
		    BORDER-RIGHT: #000000 0px solid;
		    BORDER-TOP: #000000 0px solid;
		    TEXT-DECORATION: none;
		    COLOR: #000000;
		}
	</style>
</head>
<body class="docBodyStyle" scroll="no" onload="initBody();">
	<!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
	<div class="doc_Scroll">
	<s:form name="dataForm" id="dataForm" action="" method="post" theme="simple" >
		<%@ include file="/public/include/form_detail.jsp"%>
		<table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
		   <tr valign="top">
			  <td height="100%">
				 <div class="docbox_noline">
					<div class="doc_Movetitle">
					   <ul>
						  <li class="aon"  id="Panle0"><a href="#" onClick="changePanle(0);" >基本信息</a></li>
						  <li id="Panle1"><a href="#" onClick="changePanle(1);">流程图</a></li>
						  <li id="Panle2"><a href="#" onClick="changePanle(2);">流程记录</a></li>
						  <li id="Panle3"><a href="#" onClick="changePanle(3);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
						  <li id="Panle4"><a href="#" onClick="changePanle(4);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
					   </ul>
					</div>
					<div class="clearboth"></div>
					<div id="docinfo0" class="doc_Content" >
					   <!--表单包含页 -->
					   <div>
					   <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
						  <s:hidden name="ssMasterPO.id" />
						  <input type="hidden" name="checkAmount" id="checkAmount" value="" />
						  <input type="hidden" name="mode"      value="<%=mode%>" />
						  <input type="hidden" name="workTitle" value="<%=workTitle%>" />
						  <s:hidden name="ssMasterPO.ssStock" id="ssStock"/>
						  <s:hidden name="ssMasterPO.ssMoney" id="ssMoney"/>
						  <input type="hidden" name="stockId"   value="<%=request.getAttribute("stockId")%>" />
						  <input type="hidden" name="stockName" value="<%=request.getAttribute("stockName")%>" />
						  <s:hidden name="ssMasterPO.ssMan"   id="ssMan" /><!--出货人（又称：制单人）姓名-->
						  <s:hidden name="ssMasterPO.ssDept"  id="ssDept" /><!--出货人（又称：制单人）所在部门-->
						  <input type="hidden" name="flag"    id="flag" />
						  <tr>
							  <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"出库":"退库"%>单号：</td>
							  <td width="40%"><s:property value="ssMasterPO.serial"/></td>
							  <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"出库":"退库"%>仓库：</td>
							  <td width="40%"><s:property value="%{#request.stockName}"/></td>
						  </tr>
						  
						  <tr>
							  <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"出库":"退库"%>部门<span class="MustFillColor">*</span>：</td>
							  <td width="40%">
								  <s:hidden name="ssMasterPO.ssOrg" id="ssOrg" /><s:textfield name="ssMasterPO.ssOrgName" id="ssOrgName" cssClass="inputText" cssStyle="width:98%;" readonly="true" /><%if(curModiFields.indexOf("$ssDept$") >= 0 || "reStart".equals(p_wf_openType) || "startAgain".equals(p_wf_openType)){%><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'ssOrg', allowName:'ssOrgName', select:'org', single:'yes', show:'org', range:'*0*'});"></a><%}%>
							  </td>
							  <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"领用":"退库"%>人<span class="MustFillColor">*</span>：</td>
							  <td width="40%">
								  <s:hidden name="ssMasterPO.ssUseManID" id="ssUseManID" /><s:textfield name="ssMasterPO.ssUseMan" id="ssUseMan" cssClass="inputText" cssStyle="width:98%;" readonly="true" /><%if("reStart".equals(p_wf_openType) || "startAgain".equals(p_wf_openType)){%><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'ssUseManID', allowName:'ssUseMan', select:'user', single:'yes', show:'user', range:'*0*'});"></a><%}%>
							  </td>
						  </tr>
						  <%
							String ssTypeDefineSelected  = request.getAttribute("ssTypeDefineSelected")==null?"":request.getAttribute("ssTypeDefineSelected").toString();
						  %>
						  <tr>
							  <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"出库":"退库"%>日期：</td>
							  <td width="40%">
								  <%if(curModiFields.indexOf("$ssDate$") >= 0 || "reStart".equals(p_wf_openType) || "startAgain".equals(p_wf_openType)){%>
								  <s:textfield name="ssMasterPO.ssDate" id="ssDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({el:'ssDate',dateFmt:'yyyy-MM-dd',readOnly:true})" >
									  <s:param name="value"><s:date name="ssMasterPO.ssDate" format="yyyy-MM-dd"/></s:param>
								  </s:textfield>
								  <%}else{%>
								  <s:textfield name="ssMasterPO.ssDate" id="ssDate" cssClass="Wdate whir_datebox" readonly="true">
									  <s:param name="value"><s:date name="ssMasterPO.ssDate" format="yyyy-MM-dd"/></s:param>
								  </s:textfield>
								  <%}%>
							  </td>
							  <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"出库":"退库"%>类别：</td>
							  <td width="40%">
								  <%if(curModiFields.indexOf("$stock$") >= 0 || "reStart".equals(p_wf_openType) || "startAgain".equals(p_wf_openType)){%>
								  <select name="ssTypeDefine" id="ssTypeDefine" class="selectlist" style="width:98%;">
								  <%}else{%>
								  <input type="hidden" name="ssTypeDefineSelected" value="<%=ssTypeDefineSelected%>" />
								  <select name="ssTypeDefine" id="ssTypeDefine" class="easyui-combobox" data-options="width:202,panelHeight:'150'" editable="false" disabled="true">
								  <%}%>
								  <option value="-1"><s:text name='comm.select2'/></option>
								  <%
									List typeDefineList = (List)request.getAttribute("typeDefineList");
									if(typeDefineList !=null && typeDefineList.size() >0){
										for(int i = 0 ;i<typeDefineList.size();i++){
											Object []obj = (Object[])typeDefineList.get(i);
								  %>
								  <option value="<%=obj[0]%>" <%if(ssTypeDefineSelected.equals(String.valueOf(obj[0]))){%>selected<%}%>><%=obj[1]%></option>
								  <%}}%>
								  </select>
							  </td>
						  </tr>
						  
						  <%if(mode.equals("outStock")){%>
						  <tr>
							  <td width="9%" class="td_lefttitle" nowrap>领料部门：</td>
							  <td width="40%">
								  <select name="lyDept" id="lyDept" class="easyui-combobox" data-options="width:202,panelHeight:'150'" editable="false" <%if("modifyView".equals(p_wf_openType)){%>disabled="true"<%}%>>
								  <option value=""><s:text name='comm.select2'/></option>
								  <%
									String lyDept  = request.getAttribute("lyDept")==null?"":request.getAttribute("lyDept").toString();
									List deptList = (List)request.getAttribute("deptList");
									if(deptList !=null && deptList.size() >0){
										for(int i = 0;i<deptList.size();i++){
											Object []obj = (Object[])deptList.get(i);
								  %>
								  <option value="<%=obj[0]%>" <%if(lyDept.equals(String.valueOf(obj[0]))){%>selected<%}%>><%=obj[1]%></option>
								  <%}}%>
								  </select>
							  </td>
							  <td width="9%" class="td_lefttitle" nowrap>&nbsp;</td>
							  <td width="40%">&nbsp;</td>
						  </tr>
						  <%}%>
						  
						  <tr>
							  <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"用途":"退库原因"%><span class="MustFillColor">*</span>：</td>
							  <td width="89%" colspan="3">
								  <%if("modifyView".equals(p_wf_openType)){%>
								  <s:textarea name="ssMasterPO.uses" id="uses" cssClass="inputTextarea" cols="112" rows="3" cssStyle="width:99%;" readonly="true"></s:textarea>
								  <%}else{%>
								  <s:textarea name="ssMasterPO.uses" id="uses" cssClass="inputTextarea" cols="112" rows="3" maxLength="400" cssStyle="width:99%;"></s:textarea>
								  <%}%>
							  </td>
						  </tr>
						  
						  <tr>
							  <td width="9%" class="td_lefttitle" nowrap>备注：</td>
							  <td width="89%" colspan="3">
								  <%if("modifyView".equals(p_wf_openType)){%>
								  <s:textarea name="ssMasterPO.remark" id="remark" cssClass="inputTextarea" cols="112" rows="3" cssStyle="width:99%;" readonly="true"></s:textarea>
								  <%}else{%>
								  <s:textarea name="ssMasterPO.remark" id="remark" cssClass="inputTextarea" cols="112" rows="3" maxLength="100" cssStyle="width:99%;"></s:textarea>
								  <%}%>
							  </td>
						  </tr>
						  
						  <%if("reStart".equals(p_wf_openType) || "startAgain".equals(p_wf_openType)){%>
						  <tr>
							  <td class="td_lefttitle" colspan="4" nowrap>
								  <input type="button" class="btnButton4font" style="margin-bottom:5px;" onclick="addGoods('<%=mode%>','<%=request.getParameter("stockId")%>');" value="<s:text name="comm.add"/>" /><span class="MustFillColor">*</span>
							  </td>
						  </tr>
						  <%}%>
						  
						  <tr>
							  <td class="td_lefttitle" colspan="4" nowrap>
								  <table width="99.5%" border="0" cellpadding="0" cellspacing="0" id="detailTable" class="TBStyle">
									  <tr id="startTr" class="TDTitleStyle">
										  <td align="center" width="10%">存货编号</td>
										  <td align="center" width="22%">存货名称</td>
										  <td align="center" width="10%">规格型号</td>
										  <td align="center" width="10%">计量单位</td>
										  <td align="center" width="10%">数量</td>
										  <td align="center" width="10%">单价</td>
										  <td align="center" width="10%">金额</td>
										  <td align="center" width="10%"><%=mode.equals("outStock")?"使用":"退库"%>人</td>
										  <td align="center" width="8%">操作</td>
									  </tr>
									  <%
										//处理物品领用出库数量-----2013-07-20-----开始
										com.whir.ezoffice.resource.bd.IntoOutStockBD iobd =new com.whir.ezoffice.resource.bd.IntoOutStockBD();
										//处理物品领用出库数量-----2013-07-20-----结束
										Set ssDetail = (Set) request.getAttribute("ssDetail");
										String domainId = session.getAttribute("domainId") == null ? "0" : session.getAttribute("domainId").toString();
										BigDecimal aa= new BigDecimal(0);
										BigDecimal bb= new BigDecimal(0);
										if(ssDetail != null){
											Iterator iter = ssDetail.iterator();
											SsDetailPO ssDetailPO = null;
											while(iter.hasNext()){
												ssDetailPO = (SsDetailPO) iter.next();
												//处理物品领用出库数量-----2013-07-20-----开始
												String curKC   ="0";
												String goodsId =ssDetailPO.getGoodsId();
												if(mode.equals("outStock")){
													curKC =new IntoOutStockBD().getGoodsAmount(ssDetailPO.getGoodsId(),stockId);
												}else if(mode.equals("returnStock")){
													List list =new ArrayList();
													list =iobd.getOutStockNumber(stockId,goodsId);
													if(list !=null && list.size() >0){
														Object[] arr = (Object[])list.get(0);
														if(arr[1] !=null && !"".equals(String.valueOf(arr[1]))){
															curKC =String.valueOf(arr[1]);
														}
													}
												}
												//处理物品领用出库数量-----2013-07-20-----结束
												aa = aa.add(ssDetailPO.getAmount().abs());
												bb = bb.add(ssDetailPO.getGoodsMoney().abs());
									  %>
									  <tr class="TDStyle">
										  <td align="center">
											  <input type="hidden" name="goodsId" id="goodsId" value="<%=ssDetailPO.getGoodsId()%>"><%=ssDetailPO.getGoodsId().substring(domainId.length()+1,ssDetailPO.getGoodsId().length())%>
										  </td>
										  <td align="center">
											  <input type="hidden" name="goodsName" id="goodsName" value="<%=ssDetailPO.getGoodsName()%>"><%=ssDetailPO.getGoodsName()%>
										  </td>
										  <td align="center">
											  <input type="hidden" name="goodsSpecs" id="goodsSpecs" value="<%=ssDetailPO.getGoodsSpecs()==null?"":ssDetailPO.getGoodsSpecs()%>"><%=(ssDetailPO.getGoodsSpecs()==null||"null".equals(ssDetailPO.getGoodsSpecs())||"".equals(ssDetailPO.getGoodsSpecs()))?"&nbsp;":ssDetailPO.getGoodsSpecs()%>
										  </td>
										  <td align="center">
											  <input type="hidden" name="goodsUnit" id="goodsUnit" value="<%=ssDetailPO.getGoodsUnit()%>"><%=ssDetailPO.getGoodsUnit()%>
										  </td>
										  <td align="center">
											  <%if("modifyView".equals(p_wf_openType) && "1".equals(canview)){%>
											  <input type="text" class="inputText" value="<%=ssDetailPO.getAmount().abs().setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>" size="10" name="amount" id="amount" readonly="true" />
											  <%}else{%>
											  <input type="text" class="inputText" value="<%=ssDetailPO.getAmount().abs().setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>" size="10" name="amount" id="amount" onBlur="javascript:CheckAndCount(this);total_money();" />
											  <%}%>
										  </td>
										  <td align="center">
											  <input type="text" class="inputText" value="<%=ssDetailPO.getPrice().abs().setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>" size="10" name="price" id="price" maxlength="9" readonly="true" />
										  </td>
										  <td align="center">
											  <input type="text" class="inputText" value="<%=ssDetailPO.getGoodsMoney().abs().setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>" size="10" name="money" id="money" maxlength="9" readonly="true" />
										  </td>
										  <td align="center">
											  <input type="hidden" name="kc" id="kc" value="<%=curKC%>"><input type="text" name="useMan" id="useMan" value="<%=ssDetailPO.getUseMan()!=null?ssDetailPO.getUseMan():""%>" maxlength="50" class="inputText" size="10" readonly="true" />
										  </td>
										  <td align="center">
											  <%if("0".equals(canview)){%>
											  <img src="<%=rootPath%>/images/del.gif" alt="删除该物品" onclick="javascript:document.getElementById('detailTable').deleteRow(parentElement.parentElement.rowIndex);total_money();" style="cursor:hand" />
											  <%}else{%>&nbsp;<%}%>
										  </td>
									  </tr>
									  <%}}%>
									  
									  <tr id="endTr" class="TDStyle">
										  <td align="center" height="25">合计</td>
										  <td>&nbsp;</td>
										  <td>&nbsp;</td>
										  <td>&nbsp;</td>
										  <td><input type="text" name="sum_num" id="sum_num" value="<%=aa.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>" class="inputText" size="10" readonly="readonly"></td>
										  <td>&nbsp;</td>
										  <td><input type="text" name="sum_money" id="sum_money" value="<%=bb.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>" class="inputText" size="10" readonly="readonly"></td>
										  <td>&nbsp;</td>
										  <td>&nbsp;</td>
									  </tr>
								  </table>
							  </td>
						  </tr>
						  
						  <tr>
							  <td class="td_lefttitle" colspan="4" nowrap>
								  <table width="100%" border="0" cellpadding="1" cellspacing="1">
									 <tr>
										 <td width="10%" class="td_lefttitle" nowrap>制单人：</td>
										 <td width="20%"><s:property value="%{#request.makeManName}"/></td>
										 <td width="10%" class="td_lefttitle" nowrap>审核人：</td>
										 <td width="20%"><%=checkFlag.equals("Y")?request.getAttribute("checkManName"):"&nbsp;"%></td>
										 <td width="10%" class="td_lefttitle" nowrap>保管员：</td>
										 <td width="30%">
											 <%if(curModiFields.indexOf("$ssStoreMan$") >= 0 || "reStart".equals(p_wf_openType) || "startAgain".equals(p_wf_openType)){%>
											 <s:textfield name="ssMasterPO.ssStoreMan" id="ssStoreMan" maxLength="20" cssClass="inputText" cssStyle="width:96.5%;" />
											 <%}else{%>
											 <s:textfield name="ssMasterPO.ssStoreMan" id="ssStoreMan" maxLength="20" cssClass="inputText" cssStyle="width:96.5%;" readonly="true"/>
											 <%}%>
										 </td>
									 </tr>
									 <tr>
										 <td width="10%" class="td_lefttitle" nowrap>制单日期：</td>
										 <td width="20%"><%=df2.format((java.util.Date) request.getAttribute("makeDate"))%></td>
										 <td width="10%" class="td_lefttitle" nowrap>审核时间：</td>
										 <td width="20%"><%=request.getAttribute("checkDate")==null?"&nbsp;":df2.format((java.util.Date) request.getAttribute("checkDate"))%></td>
										 <td width="10%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"提料员":"经办人"%>：</td>
										 <td width="30%">
											 <%if(curModiFields.indexOf("$ssPicker$") >= 0 || "reStart".equals(p_wf_openType) || "startAgain".equals(p_wf_openType)){%>
											 <s:textfield name="ssMasterPO.ssPicker" id="ssPicker" maxLength="20" cssClass="inputText" cssStyle="width:96.5%;" />
											 <%}else{%>
											 <s:textfield name="ssMasterPO.ssPicker" id="ssPicker" maxLength="20" cssClass="inputText" cssStyle="width:96.5%;" readonly="true"/>
											 <%}%>
										 </td>
									 </tr>
									 <tr>
										 <td width="10%" class="td_lefttitle" nowrap>审核状态：</td>
										 <td width="20%"><%=checkFlag.equals("Y")?(outFlag!=null&&outFlag.equals("1")&&mode!=null?(mode.equals("outStock")?"已领用":"已退库"):"已审核"):(checkFlag.equals("B")?"退回":"待审核")%></td>
										 <td width="10%" class="td_lefttitle" nowrap>&nbsp;</td>
										 <td width="20%">&nbsp;</td>
										 <td width="10%" class="td_lefttitle" nowrap>&nbsp;</td>
										 <td width="30%">&nbsp;</td>
									 </tr>
								  </table>
							  </td>
						  </tr>
						  
					   </table>
					   </div>
					   <!--工作流包含页-->
					   <div><%@ include file="/platform/bpm/work_flow/operate/wf_include_form.jsp"%></div>
					   <!--批示意见包含页-->
					   <div><%@ include file="/platform/bpm/work_flow/operate/wf_include_comment.jsp"%></div>
					</div>
					<div id="docinfo1" class="doc_Content"  style="display:none;"></div>
					<div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					<div id="docinfo3" class="doc_Content"  style="display:none;"></div>
					<div id="docinfo4" class="doc_Content"  style="display:none;"></div>
					<div>
					   <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
						   <tr class="Table_nobttomline">
							   <td></td>
							   <td nowrap>
									<%if("outStock".equals(mode) && "true".equals(request.getParameter("isModify")) && checkFlag.equals("Y")){%>
									<input type="button" class="btnButton4font" onClick="saveAndExit('update');" value="<s:text name="comm.saveclose"/>" />
									<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
									<input type="button" class="btnButton4font" onClick="window.close();" value="<s:text name="comm.exit"/>" />
									<%}%>
							   </td>
						   </tr>
					   </table>
					<div>
				 </div>
			  </td>
		   </tr>
		</table>
	</s:form>
	</div>
    <div class="docbody_margin"></div>
    <%@ include file="/platform/bpm/work_flow/operate/wf_include_form_end.jsp"%>
</body>
<script type="text/javascript">
	//2013-08-06-----禁止Backspace-----start
	$(document).keydown(function(e){
        var doPrevent;
        var varkey =(e.keyCode) || (e.which) || (e.charCode);
        if(varkey ==8){
        	 var d = e.srcElement || e.target;
        	 if(d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA'){
        	 	doPrevent = d.readOnly || d.disabled;
        	 	if(d.type.toUpperCase() == 'SUBMIT' || d.type.toUpperCase() == 'RADIO' || d.type.toUpperCase() == 'CHECKBOX' || d.type.toUpperCase() == 'BUTTON'){
        	 		doPrevent = true;
        	 	}
        	 }else{
        	 	doPrevent = true;
        	 }
        }
        if(doPrevent){
        	e.preventDefault();
        }
    });
    //2013-08-06-----禁止Backspace-----end
	
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
    
	//检查页面参数有效性
	function initPara(){
		if($('#ssOrg').val() == ''){
			$.dialog.alert('请选择部门！', function(){});
    		return false;
		}
		
		var alertHtml ='退库人不能为空！';
		<%if(mode.equals("outStock")){%>
		    alertHtml ='领用人不能为空！';
		<%}%>
		if($('#ssUseManID').val() ==''){
			$.dialog.alert(alertHtml, function(){});
    		return false;
		}
		
		var alertHtml2 ='退库原因';
		<%if(mode.equals("outStock")){%>
		    alertHtml2 ='用途';
		<%}%>
		 
		if($.trim($('#uses').val()) == ''){
			$.dialog.alert("请填写"+alertHtml2+"!", function(){});
    		return false;
		}else if($('#uses').val() != '' && $('#uses').val().length > 400){
			$.dialog.alert(alertHtml2+'不能超过400个汉字！', function(){});
    		return false;
		}
		
		if($('#remark').val() != '' && $('#remark').val().length > 100){
			$.dialog.alert('备注不能超过100个汉字！', function(){});
    		return false;
		}
		
		if((document.getElementById('detailTable').rows.length - 2) == 0){
    		$.dialog.alert('您还没有增加物品信息，请增加物品信息！', function(){});
    		return false;
    	}
		
		$('#ssDept').val($('#ssOrg').val());
		
	    return true;
	}
	
	function saveAndExit(flag){
    	var alertHtml ='退库人不能为空！';
		<%if(mode.equals("outStock")){%>
		    alertHtml ='领用人不能为空！';
		<%}%>
		
		if($('#ssUseManID').val() ==''){
			$.dialog.alert(alertHtml, function(){});
    		return false;
		}
		
		if($('#remark').val() != '' && $('#remark').val().length > 100){
			$.dialog.alert('备注不能超过100个汉字！', function(){});
    		return false;
		}
		
		if((document.getElementById('detailTable').rows.length - 2) == 0){
    		$.dialog.alert('您还没有增加物品信息，请增加物品信息！', function(){});
    		return false;
    	}
    	
    	if($('#ssOrg').val() == ''){
			$.dialog.alert('请选择部门！', function(){});
    		return false;
		}
		
		if($.trim($('#uses').val()) == ''){
			$.dialog.alert('请填写用途！', function(){});
    		return false;
		}
		
		$('#ssDept').val($('#ssOrg').val());
    	$('#flag').val(flag);
    	
    	//流程页面的保存退出
		$("#dataForm").attr("action","<%=rootPath%>/outStockAction!modifyOutStock.action");
		setCallBackName("");
		$("#dataForm").submit();
    }
	
	function addGoods(mode,stockId){
	    if(mode == 'outStock'){
	       popup({id:'intoStockForm',content:'url:<%=rootPath%>/goodsAction!list.action?addGoods=1&stockIds='+stockId+'&addcolumn=8&chuku=1&mode=outStock',title:'选择物品信息',lock:false,width:950,height:450});
	    }else{
	       popup({id:'intoStockForm',content:'url:<%=rootPath%>/goodsAction!list.action?addGoods=2&stockIds='+stockId+'&addcolumn=8&mode=returnStock',title:'选择物品信息',lock:false,width:950,height:450});
	    }
	}
	
	function CheckAndCount(obj){
	    var mode ="<%=mode%>";
		//处理空格
	    $(obj).val($.trim($(obj).val()));

	    if($(obj).attr('name') == 'amount'){
	       if(isNaN($(obj).val()) || $(obj).val()<=0){
	       	   $.dialog.alert('请输入正确的数值！', function(){
	       	   	   $(obj).focus();
	       	   });
	       	   return false;
	       }else if($(obj).val() > 99999){
	       	   $.dialog.alert('数值不能大于99999！', function(){
	       	   	   $(obj).focus();
	       	   });
	       	   return false;
	       }
	    }
	    
	    if(isNaN($(obj).val()) || $(obj).val()<=0){
	        $.dialog.alert('请输入正确的数值！', function(){
	       	    $(obj).focus();
	        });
	        return false;
	    }else{
			//2014-05-27 处理小数点问题
			if($(obj).val().indexOf('.') != -1){
				var len =$(obj).val().substring($(obj).val().indexOf('.')+1,$(obj).val().length);
				if(len !=null && len !='' && len.length >2){
					$(obj).val(eval($(obj).val()).toFixed(2));
					if(isNaN($(obj).val()) || $(obj).val()<=0){
						$.dialog.alert('请输入正确的数值！', function(){
	       					$(obj).focus();
						});
						return false;
					}
				}
			}

	    	var amount = $(obj).parent().parent().find('#amount').val();
	    	var price  = $(obj).parent().parent().find('#price').val();
	    	var money  = $(obj).parent().parent().find('#money').val();
	    	var kc     = $(obj).parent().parent().find('#kc').val();
	        if($(obj).attr('name') == 'amount'){
	        	//if(mode=="outStock" && parseFloat($(obj).val()) > parseFloat(kc)){
	        	//	$.dialog.alert('出库数量不能大于库存:'+eval(kc).toFixed(2), function(){
	        	//		$(obj).focus();
	        	//	});
	        	//	return false;
	        	//}
	        	if(mode=="returnStock" && parseFloat($(obj).val()) > parseFloat(kc)){
	        		$.dialog.alert('退库数量不能大于已领用数量:'+eval(kc).toFixed(2), function(){
	        			$(obj).focus();
	        		});
	        		return false;
	            }else{
	        		var sumMoney =eval(amount*price).toFixed(2);
	        		$(obj).parent().parent().find('#money').val(sumMoney);
	        	}
	        }else{
	            var sumMoney =eval(amount*price).toFixed(2);
	            $(obj).parent().parent().find('#money').val(sumMoney);
	        }
	    }
	}
	
	function total_money(){
	    var goods_num=document.getElementById('detailTable').rows.length - 2;
	    var total_money = 0.00;
	    var cutNumber = Math.pow(10,2);
	    var total_amount = 0;
	    var total_mon = 0.00;
	    if(goods_num == 0){
	    	document.getElementById('ssMoney').value = 0;
	    }else if(goods_num==1){
	    	document.getElementById('ssMoney').value = document.getElementById('money').value;
	    	//total_amount += parseFloat(document.getElementById('amount').value);
			//total_mon    += eval(document.getElementById('money').value);
			var amoustr=document.getElementById('amount').value;
			if(amoustr!=null&&amoustr!=""){
			  total_amount += parseFloat(amoustr);
			}
			var monstr=document.getElementById('money').value;
			if(monstr!=null&&monstr!=""){
			  total_mon    += eval(monstr);
			}
	    }else{
	    	$('#detailTable').find('tr:not(#startTr,#endTr)').each(function(){
	    		//total_money   = total_money * 1 + $(this).find('input[name=money]').val() * 1;
	    		//total_amount += parseFloat($(this).find('input[name=amount]').val());
	    		//total_mon    += eval($(this).find('input[name=money]').val());
				var amoustr=$(this).find('input[name=amount]').val();
			   if(amoustr!=null&&amoustr!=""){
				  total_amount  += parseFloat(amoustr);
				}
				var monstr=$(this).find('input[name=money]').val();
				if(monstr!=null&&monstr!=""){
				  total_money   = total_money * 1 + monstr * 1;
				  total_mon+= eval(monstr);
				}else{
				  total_money   = total_money * 1 + 0 * 1;
				}
	        });
	        document.getElementById('ssMoney').value = Math.round(total_money * cutNumber)/cutNumber;
	    }
	    document.getElementById('sum_num').value  =total_amount.toFixed(2);
	    document.getElementById('sum_money').value=total_mon.toFixed(2);
	}
</script>
</html>