<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String voitureId="";
    if(request.getParameter("voitureId")!=null)
    voitureId=request.getParameter("voitureId").toString();

    com.whir.ezoffice.voiture.bd.VoitureManagerSecondBD bd = new com.whir.ezoffice.voiture.bd.VoitureManagerSecondBD();
    Double lastJygls = bd.getLastJygls(new Long(voitureId));
     Date maintainTime = new Date();
      com.whir.ezoffice.voiture.po.VoitureFeePO voitureFeePO=null;
    if(request.getAttribute("voitureFeePO") !=null){
        voitureFeePO=(com.whir.ezoffice.voiture.po.VoitureFeePO)request.getAttribute("voitureFeePO");
    }
    Set ss=null;
     if(voitureFeePO != null){
         if(voitureFeePO.getMaintainTime() != null){
        maintainTime=voitureFeePO.getMaintainTime();
        }
         if(voitureFeePO.getVoitureReplacementPO() != null){
            ss = (Set)voitureFeePO.getVoitureReplacementPO();
        }
     }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:if test='#request.action == "add"'>新车辆费用</s:if><s:else>车辆费用修改</s:else> 
</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="Pupwin">
	<div class="BodyMargin_10" >  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="${ctx}/voitureFee!add.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
        <s:hidden name="voitureId" id="voitureId"/>
        <s:hidden name="voitureFeePO.id" id="id"/>
        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr>  
                <td for="发生日期"  class="td_lefttitle" nowrap="nowrap">  
                    发生日期：  
                </td>  
                <td width="42%">  
                    <input type="text" name="voitureFeePO.maintainTime" id="maintainTime" class="Wdate whir_datebox" onfocus="WdatePicker({el:'maintainTime',isShowWeek:true})"  value="<%=formatter.format(maintainTime)%>"/> 
                </td> 
                <td> 
                    &nbsp;
                </td> 
                <td width="42%">
                    &nbsp;
                </td>  
            </tr>
            <tr>  
                <td colspan="4">  
                    <b>油费</b>  
                </td>  
            </tr>  
            <tr>  
                <td for="经办人" class="td_lefttitle" nowrap="nowrap">  
                    经办人：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.jbr" id="jbr" cssClass="inputText" whir-options="vtype:[{'maxLength':25},'spechar3']"  maxlength="25" cssStyle="width:85%"/>
                </td>
                 <td for="加油卡卡号" class="td_lefttitle" nowrap="nowrap">  
                    加油卡卡号：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.jykkh" id="jykkh" cssClass="inputText" whir-options="vtype:[{'maxLength':25},'spechar3']"  maxlength="25" cssStyle="width:85%"/>
                </td>
            </tr>
            <tr>  
                <td for="上次加油公里数" class="td_lefttitle" nowrap="nowrap">  
                    上次加油公里数：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.scjysgls" id="scjysgls" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" readonly="true"/>
                </td>
                <td for="油单价" class="td_lefttitle" nowrap="nowrap">  
                    油单价：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.ydj" id="ydj" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%"/>
                </td>
            </tr>
            <tr> 
                  <td for="卡原余额" class="td_lefttitle"nowrap="nowrap">  
                    卡原余额：  
                </td>  
                <td>
                   <s:textfield name="voitureFeePO.kyye" id="kyye" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onchange="chg_1();" onpropertychange="chg_1();"/> 元
                </td>
                <td for="本次加油公里数" class="td_lefttitle" nowrap="nowrap">  
                    本次加油公里数：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.bcjysgls" id="bcjysgls" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_2();" onchange="chg_2();"/>
                </td>
            </tr>
            <tr>  
                  <td for="剩余金额" class="td_lefttitle">  
                    剩余金额：  
                </td>        
                <td>
                    <s:textfield name="voitureFeePO.syje" id="syje" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" readonly="true"/> 元
                </td>
                 <td for="油量（升）" class="td_lefttitle"nowrap="nowrap">  
                    油量（升）：  
                </td>  
                <td>
                   <s:textfield name="voitureFeePO.yl" id="yl" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onchange="chg_2();" onpropertychange="chg_2();"/>
                </td>
            </tr>
            <tr>  
                 <td for="油耗" class="td_lefttitle">  
                    油耗：  
                </td>        
                <td>
                    <s:textfield name="voitureFeePO.oilCost" id="oilCost" cssClass="inputText" whir-options="vtype:[{'range':'0-99999999.9'},{'maxLength':10}]"   maxlength="10" cssStyle="width:85%" readonly="true"/> 
                </td>
                 <td for="加油金额" class="td_lefttitle">  
                    加油金额：  
                </td>        
                <td colspan="3">
                    <s:textfield name="voitureFeePO.jyje" id="jyje" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onchange="chg_1();chg_3();" onpropertychange="chg_1();chg_3();"/> 元
                </td>
            </tr>
             <tr>  
                <td  colspan="4" class="td_lefttitle">  
                    说明：油耗=本次油量*100/（本次加油时公里数-上次加油时公里数）,前提是每次都加满油箱。  
                </td>        
                
            </tr>
             <tr>  
                <td colspan="4">  
                    <b>维修/保养费用</b>  
                </td>  
            </tr>  
            <tr>  
                <td for="保养类型" class="td_lefttitle">  
                    保养类型：  
                </td>        
                <td>
                    <s:radio name="voitureFeePO.isMaintain" list="%{#{'1':'保养','0':'维修'}}"  theme="simple" onclick="chg(this);"></s:radio>
                </td>
                <td for="维修方式" class="td_lefttitle">  
                    维修方式：  
                </td>        
                <td>
                    <s:radio name="voitureFeePO.wxfs" list="%{#{'1':'自主维修','0':'委外维修'}}"  theme="simple" onclick="chg2(this);"></s:radio>
                </td>
            </tr>
            
             <tr>  
                <td for="主修师傅" class="td_lefttitle" nowrap="nowrap">  
                    主修师傅：  
                </td> 
                <td>
                  <s:textfield name="voitureFeePO.zxsf" id="zxsf" cssClass="inputText" whir-options="vtype:[{'maxLength':25}]"  maxlength="25" cssStyle="width:85%" /> 
                </td>
                <td for="合作单位" class="td_lefttitle" nowrap="nowrap">  
                    合作单位：  
                </td>  
                <td>  
                     <s:textfield name="voitureFeePO.hzdw" id="hzdw" cssClass="inputText" whir-options="vtype:[{'maxLength':25}]"  maxlength="25" cssStyle="width:85%" /> 
                </td>
            </tr>
            <tr> 
                <td for="经办人" class="td_lefttitle" nowrap="nowrap">  
                    经办人：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.jbr2" id="jbr2" cssClass="inputText" whir-options="vtype:[{'maxLength':25},'spechar3']"  maxlength="25" cssStyle="width:85%" /> 
                </td> 
                <td colspan="2">  
                   
                </td>
            </tr>
            <tr> 
                <td for="维修/保养简述" class="td_lefttitle" nowrap="nowrap">  
                    维修/保养简述：
                </td>  
               <td colspan="3">
                    <s:textarea name="voitureFeePO.wxbyjs" id="wxbyjs" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:94.2%;" whir-options="vtype:[{'maxLength':250}]" maxlength="250"/>
                </td>
            </tr>
            <tr> 
                <td for="维修/保养公里数" class="td_lefttitle" nowrap="nowrap">  
                    维修/保养公里数：
                </td>  
                <td >  
                   <s:textfield name="voitureFeePO.wxbysgls" id="wxbysgls" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%"/> 
                </td> 
                <td for="下次维修/保养公里数" class="td_lefttitle" nowrap="nowrap">  
                    下次维修/保养公里数：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.xcwxbygls" id="xcwxbygls" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%"/> 
                </td>
            </tr>
            <tr> 
                <td for="票据号码" class="td_lefttitle" nowrap="nowrap">  
                    票据号码：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.pjhh2" id="pjhh2" cssClass="inputText" whir-options="vtype:[{'maxLength':25}]"  maxlength="25" cssStyle="width:85%"/> 
                </td> 
                <td for="票据日期" class="td_lefttitle" nowrap="nowrap">  
                    票据日期：
                </td>  
                <td>  
                     <s:textfield name="voitureFeePO.pjrq2" id="pjrq2"  cssClass="Wdate whir_datebox" onfocus="WdatePicker({el:'pjrq2',isShowWeek:true,dateFmt:'yyyy-MM-dd'})"> 
                      <s:param name="value"><s:date name="voitureFeePO.pjrq2" format="yyyy-MM-dd"/></s:param>
                    </s:textfield>
                </td>
            </tr>
            	<tr>
				<td colspan="4">
					<table id="tbl_1" width="86%" border="1" cellpadding="0" cellspacing="0" style="border:solid 1px #000000;border-color:black; ">
						<tr style="background-color:#D3D3D3;border-bottom:solid 1px #000000;border-color:black">
							<td width="40%" align="center" style="border-color:black" for="更换配件名称">更换配件名称</td>
							<td width="20%" align="center" style="border-color:black" for="数量">数量</td>
							<td width="20%" align="center" style="border-color:black" for="单价（保留6位小数）">单价（保留6位小数）</td>
							<td width="20%" align="center" style="border-color:black" for="配件费">配件费</td>
						</tr>
                        <s:if test='#request.action == "add"'>
                        <tr style="display:none" onmouseover="setAbsolute(this,'visible',0);">
                            <td  align="center" class="remark_td1">
                                <input type="text" name="a_name" class="inputText" style="width:99%"  id="name_0"value="" maxlength="50" whir-options="vtype:[{'maxLength':50},'spechar3']"/>
                            </td>
                            <td  align="center" class="remark_td1">
                                <input type="text" name="a_amount" id="amount_0"
                                class="inputText" style="width:98%;text-align:right" value="" maxlength="10" style="ime-mode:disabled;" whir-options="vtype:['p_decimal_e',{'maxLength':10}]" onpropertychange="chg_5();" onchange="chg_5();"/>
                            </td>
                            <td  align="center" class="remark_td1">
                                <input type="text" name="a_price" class="inputText"  id="price_0"style="width:98%;text-align:right" value="" maxlength="10" style="ime-mode:disabled;"   whir-options="vtype:[{'maxLength':10},{'point':6}]"onpropertychange="chg_5();" onchange="chg_5();"/>
                            </td>
                            <td  align="center" class="remark_td2">
                                <input type="text" name="a_cost" class="inputText"  id="cost_0"style="width:98%;text-align:right" value="" maxlength="10" style="ime-mode:disabled;"  whir-options="vtype:['p_decimal_e',{'maxLength':10}]" onpropertychange="chg_5();" onchange="chg_5();" />
                            </td>
                        </tr>
                         </s:if>
                        <s:else>
                        <%
							String pjhj = "0.0";
							if(ss ==null || ss.size()<=0){
                         %>
                         <tr style="display:none" onmouseover="setAbsolute(this,'visible',0);">
                            <td  align="center" class="remark_td1">
                                <input type="text" name="a_name" class="inputText" style="width:99%"  id="name_0"value="" maxlength="50" whir-options="vtype:[{'maxLength':50},'spechar3']"/>
                            </td>
                            <td  align="center" class="remark_td1">
                                <input type="text" name="a_amount" id="amount_0"
                                class="inputText" style="width:98%;text-align:right" value="" maxlength="10" style="ime-mode:disabled;" whir-options="vtype:['p_decimal_e',{'maxLength':10}]" onpropertychange="chg_5();"onchange="chg_5();" />
                            </td>
                            <td  align="center" class="remark_td1">
                                <input type="text" name="a_price" class="inputText"  id="price_0"style="width:98%;text-align:right" value="" maxlength="10" style="ime-mode:disabled;"   whir-options="vtype:[{'maxLength':10},{'point':6}]"onpropertychange="chg_5();" onchange="chg_5();" />
                            </td>
                            <td  align="center" class="remark_td2">
                                <input type="text" name="a_cost" class="inputText"  id="cost_0"style="width:98%;text-align:right" value="" maxlength="10" style="ime-mode:disabled;"  whir-options="vtype:['p_decimal_e',{'maxLength':10}]" onpropertychange="chg_5();" onchange="chg_5();"/>
                            </td>
                        </tr>
                        <%
                        }else{
                            Iterator itor = ss.iterator();
                             int i=0;
								while(itor.hasNext()){
                                    com.whir.ezoffice.voiture.po.VoitureReplacementPO vv = (com.whir.ezoffice.voiture.po.VoitureReplacementPO)itor.next();
                                    if(vv.getCost()!=null){
                                        java.math.BigDecimal b1=new java.math.BigDecimal(pjhj+"");
                                        java.math.BigDecimal b2=new java.math.BigDecimal(vv.getCost()+"");
                                        pjhj=b1.add(b2)+"";
                                    }else{
                                        java.math.BigDecimal b1=new java.math.BigDecimal(pjhj+"");
                                        java.math.BigDecimal b2=new java.math.BigDecimal("0.0");
                                        pjhj = b1.add(b2)+"";
                                    }
                        %>
                        <tr onmouseover="setAbsolute(this,'visible',0)" align="center">
							<td class="remark_td1">
                                <input type="text" name="a_name" id="name_<%=i%>"class="inputText" style="width:99%" value="<%=vv.getName()!=null?vv.getName():""%>"whir-options="vtype:[{'maxLength':50},'spechar3']" maxlength="50"/>
                            </td>
							<td class="remark_td1">
                                <input type="text" name="a_amount" id="amount_<%=i%>"class="inputText" style="width:98%;text-align:right" value="<%=vv.getAmount()!=null?(new java.math.BigDecimal(vv.getAmount()+"")+""):""%>" maxlength="10"  whir-options="vtype:['p_decimal_e',{'maxLength':10}]"style="ime-mode:disabled;" onpropertychange="chg_5();" onchange="chg_5();"/>
                            </td>
							<td class="remark_td1">
                                <input type="text" name="a_price"id="price_<%=i%>" class="inputText" style="width:98%;text-align:right" value="<%=vv.getPrice()!=null?(new java.math.BigDecimal(vv.getPrice()+"")+""):""%>" maxlength="10"  whir-options="vtype:['p_decimal_e',{'maxLength':10}]" style="ime-mode:disabled;" onpropertychange="chg_5();" onchange="chg_5();"/>
                            </td>
							<td class="remark_td2">
                                <input type="text" name="a_cost"id="cost_<%=i%>" class="inputText" style="width:98%;text-align:right" value="<%=vv.getCost()!=null?(new java.math.BigDecimal(vv.getCost()+"")+""):""%>" maxlength="10" whir-options="vtype:['p_decimal_e',{'maxLength':10}]" style="ime-mode:disabled;" onpropertychange="chg_5();" onchange="chg_5();" />
                            </td>
						</tr>
                        <%
                            i++;
                            }
                        }%>
                        </s:else> 
						<tr>
							<td colspan="3" align="right" class="remark_td1">合计 配件费：</td>
							<td class="remark_td2" align="center">
                                 <s:textfield name="hjpjf" id="hjpjf" whir-options="vtype:[{'maxLength':13}]" maxlength="13" cssClass="inputText" readonly="true" cssStyle="width:98%;text-align:right" />
                            </td>
						</tr>
					</table>
				</td>

				</tr>
            <tr> 
                <td for="工时费" class="td_lefttitle" nowrap="nowrap">  
                    工时费：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.gsf" id="gsf" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_6();" onchange="chg_6();"/> 元
                </td> 
                <td for="合计费用" class="td_lefttitle" nowrap="nowrap">  
                   合计费用：
                </td>  
                <td>  
                    <s:textfield name="whbyhjfy" id="whbyhjfy" cssClass="inputText" readonly="true" cssStyle="width:85%" onpropertychange="chg_3();" onchange="chg_3();"/> 元
                </td>
            </tr>
             <tr>  
                <td colspan="4">  
                    <b>其他费用</b>  
                </td>  
            </tr>  
            <tr> 
                <td for="经办人" class="td_lefttitle" nowrap="nowrap">  
                    经办人：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.jbr3" id="jbr3" cssClass="inputText" whir-options="vtype:[{'maxLength':25},'spechar3']"  maxlength="25" cssStyle="width:85%"/> 
                </td> 
               <td colspan="2">  
                   
                </td>
            </tr>
             <tr> 
                <td for="票据号码" class="td_lefttitle" nowrap="nowrap">  
                    票据号码：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.pjhh3" id="pjhh3" cssClass="inputText" whir-options="vtype:[{'maxLength':25},'spechar3']"  maxlength="25" cssStyle="width:85%"/> 
                </td> 
                <td for="票据日期" class="td_lefttitle" nowrap="nowrap">  
                    票据日期：
                </td>  
                <td>  
                     <s:textfield name="voitureFeePO.pjrq3" id="pjrq3"  cssClass="Wdate whir_datebox" onfocus="WdatePicker({el:'pjrq3',dateFmt:'yyyy-MM-dd',isShowWeek:true})"> 
                        <s:param name="value"><s:date name="voitureFeePO.pjrq3" format="yyyy-MM-dd"/></s:param>
                    </s:textfield>
                </td>
            </tr>
            <tr> 
                <td for="洗车费" class="td_lefttitle" nowrap="nowrap">  
                    洗车费：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.washFee" id="washFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td> 
                <td for="税费" class="td_lefttitle" nowrap="nowrap">  
                    税费：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.taxFee" id="taxFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td>
            </tr>
            <tr> 
                <td for="保险费" class="td_lefttitle" nowrap="nowrap">  
                    保险费：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.insureFee" id="insureFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td> 
                <td for="养路费" class="td_lefttitle" nowrap="nowrap">  
                    养路费：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.roadFee" id="roadFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td>
            </tr>
            <tr> 
                <td for="年票费" class="td_lefttitle" nowrap="nowrap">  
                    年票费：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.yearTicketFee" id="yearTicketFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td> 
                <td for="车辆年审费" class="td_lefttitle" nowrap="nowrap">  
                    车辆年审费：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.yearSensorFee" id="yearSensorFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td>
            </tr>
            <tr> 
                <td for="驾驶证年检费" class="td_lefttitle" nowrap="nowrap">  
                    驾驶证年检费：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.jsznjf" id="jsznjf" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td> 
                <td for="卡车营运证年审费" class="td_lefttitle" nowrap="nowrap">  
                    卡车营运证年审费：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.kcyyznsf" id="kcyyznsf" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td>
            </tr>
            <tr> 
                <td for="车船使用税" class="td_lefttitle" nowrap="nowrap">  
                    车船使用税：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.ccsyf" id="ccsyf" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td> 
                <td for="定损事故处理费" class="td_lefttitle" nowrap="nowrap">  
                    定损事故处理费：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.accidentFee" id="accidentFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td>
            </tr>
             <tr> 
                <td for="购置税" class="td_lefttitle" nowrap="nowrap">  
                    购置税：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.purchaseTax" id="purchaseTax" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td> 
                <td for="上牌费" class="td_lefttitle" nowrap="nowrap">  
                    上牌费：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.brandFee" id="brandFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td>
            </tr>
            <tr> 
                <td for="月保费" class="td_lefttitle" nowrap="nowrap">  
                    月保费：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.monthFee" id="monthFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td> 
                <td for="其他费用" class="td_lefttitle" nowrap="nowrap">  
                    其他费用：
                </td>  
                <td>  
                    <s:textfield name="voitureFeePO.otherFee" id="otherFee" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9'},{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td>
            </tr>
            <tr> 
                <td for="二级维护费" class="td_lefttitle" nowrap="nowrap">  
                    二级维护费：
                </td>  
                <td>  
                   <s:textfield name="voitureFeePO.ejwhf" id="ejwhf" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_4();" onchange="chg_4();"/> 元
                </td> 
                <td for="合计费用" class="td_lefttitle" nowrap="nowrap">  
                    合计费用：
                </td>  
                <td>  
                    <s:textfield name="qthjfy" id="qthjfy" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]"  maxlength="10" cssStyle="width:85%" onpropertychange="chg_3();" onchange="chg_3();" readonly="true"/> 元
                </td>
            </tr>
             <tr> 
                <td for="备注" class="td_lefttitle" nowrap="nowrap">  
                    备注：
                </td>  
               <td colspan="3">
                    <s:textarea name="voitureFeePO.remark" id="remark" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:94.2%;" whir-options="vtype:[{'maxLength':250}]" maxlength="250"/>
                </td>
            </tr>
            <tr> 
                <td for="本次录入费用总计" class="td_lefttitle" nowrap="nowrap">  
                    <b>本次费用总计：</b>
                </td>  
                <td>  
                   <s:textfield name="zjfy" id="zjfy" cssClass="inputText" whir-options="vtype:[{'maxLength':13}]"  maxlength="13" cssStyle="width:85%" readonly="true"/> 元
                </td> 
                <td colspan="2">  
                 
                </td>
            </tr>
            <tr class="Table_nobttomline">  
                <td > </td> 
                <td nowrap colspan=3> 
                    <s:if test='#request.action=="add"'>
                    <input type="button" class="btnButton4font" onClick="ok(0,this);" value='<s:text name="comm.saveclose"/>' />  
                    <input type="button" class="btnButton4font" onClick="ok(1,this);" value='<s:text name="comm.savecontinue"/>' />  
                    </s:if>
                    <s:else>
                    <input type="button" class="btnButton4font" onClick="update(0,this);" value='<s:text name="comm.saveclose"/>' />  
                    </s:else>
                    <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' /> 
                   
                </td>  
            </tr>  
        </table> 
        <DIV id=adddelrow_div
	style="BORDER-RIGHT: #0a246a 1px solid; BORDER-TOP: #0a246a 1px solid; VISIBILITY: hidden; BORDER-LEFT: #0a246a 1px solid; WIDTH: 30px; BORDER-BOTTOM: #0a246a 1px solid; POSITION: absolute">
	<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  	<TBODY>
  		<TR>
    		<TD onmouseover="this.style.borderRiht='1px #0A246A solid'"
    			onmouseout="this.style.borderRiht=''" align=middle><SPAN id=delrow_div
      			title=点击删除记录 style="CURSOR: hand"><IMG height=12
      			src="<%=rootPath%>/images/delarrow.gif" width=12 onclick='delROW()' align=absMiddle></SPAN>
			</TD>
			<td>&nbsp;</td>
    		<TD onmouseover="this.style.borderLeft='1px #0A246A solid'"
    			onmouseout="this.style.borderLeft=''" align=middle><SPAN id=addrow_div
      			title=点击添加记录 style="CURSOR: hand"><IMG height=12
      			src="<%=rootPath%>/images/addarrow.gif" width=12 onclick='addROW()' align=absMiddle></SPAN>
  			</TD>
		</TR>
	</TBODY>
	</TABLE>
</DIV>
	</s:form>
		</div>
	</div>
</body>
<script type="text/javascript">

	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});

	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
    var delRows='';
    $(document).ready(function(){
          $(window).bind('resize', function(){
               ww();
           });
    });
     function ww() {
        setAbsolute1('visible');
    }
    function setAbsolute1(visible){
        var div = document.getElementById("adddelrow_div");
        div.style.visibility = visible;
         var tbl_w = $("#tbl_1").width();
        var tbl_l = $("#tbl_1").position().left;

        var position = $("#tbl_1").find("tr").eq(delRows).position();
        div.style.left= (tbl_w + tbl_l + 5) + 'px';//
        div.style.top = position.top + 'px';
    }

/**
 * 新增或修改页面点击保存退出或保存继续按钮触发的事件.
 * @param n   0:保存退出；1:保存继续.
 * @param obj 保存按钮的dom对象.
 */
    function update(n,obj) {
        var formId = $(obj).parents("form").attr("id");
        var validation = validateForm(formId);
        $(obj).parents("form").find("#saveType").val(n);
        if(validation){
                //dataForm.action = "<%=rootPath%>/voitureFee!update.action";
				$("#dataForm").attr("action","<%=rootPath%>/voitureFee!update.action");
                $('#'+formId).submit();
        }	    
    }
    
function chg(obj){
     var radioObj = $('input[name="voitureFeePO.wxfs"]');
	if(obj.value=='1'){
        for(var k=0;k<radioObj.length;k++){
                radioObj[k].checked = false ;
            }
            
	}else{
		radioObj[0].checked = true ;
	}
    //$("input:radio").uniform();
}

function chg2(obj){
    var radioObj = $('input[name="voitureFeePO.isMaintain"]');
    radioObj[0].checked = false ;
    radioObj[1].checked = true ;
    //$("input:radio").uniform();
}

function chg_1(){
	var kyye = $("#kyye").val();
	var jyje = $("#jyje").val();
	if(kyye==''||isNaN(kyye))kyye=0.0;
	if(jyje==''||isNaN(jyje))jyje=0.0;
	$("#syje").val((parseFloat(kyye)-parseFloat(jyje)).toFixed(4));
}

function chg_2(){
	var scjysgls = $("#scjysgls").val();
	var bcjysgls = $("#bcjysgls").val();
	var yl = $("#yl").val();
	if(scjysgls==''||isNaN(scjysgls))scjysgls=0.0;
	if(bcjysgls==''||isNaN(bcjysgls))bcjysgls=0.0;
	if(yl==''||isNaN(yl))yl=0.0;

	if(parseFloat(bcjysgls)-parseFloat(scjysgls) != 0)
		$("#oilCost").val(((parseFloat(yl)*100)/((parseFloat(bcjysgls)-parseFloat(scjysgls)))).toFixed(4));
	else
	    $("#oilCost").val(0.0);
}

function chg_3(){
	var jyje = $("#jyje").val();
	var whbyhjfy = $("#whbyhjfy").val();
	var qthjfy = $("#qthjfy").val();
	if(jyje==''||isNaN(jyje))jyje=0.0;
	if(whbyhjfy==''||isNaN(whbyhjfy))whbyhjfy=0.0;
	if(qthjfy==''||isNaN(qthjfy))qthjfy=0.0;
	$("#zjfy").val((parseFloat(jyje)+parseFloat(whbyhjfy)+parseFloat(qthjfy)).toFixed(4));
}

function chg_4(){
	var washFee = $("#washFee").val();
	var taxFee = $("#taxFee").val();
	var insureFee = $("#insureFee").val();

	var roadFee = $("#roadFee").val();
	var yearTicketFee = $("#yearTicketFee").val();
	var yearSensorFee = $("#yearSensorFee").val();
	var jsznjf = $("#jsznjf").val();
	var kcyyznsf = $("#kcyyznsf").val();
	var ccsyf = $("#ccsyf").val();
	var accidentFee = $("#accidentFee").val();
	var purchaseTax =$("#purchaseTax").val();
	var brandFee = $("#brandFee").val();
	var monthFee = $("#monthFee").val();
	var otherFee = $("#otherFee").val();
	var ejwhf = $("#ejwhf").val();

	if(washFee==''||isNaN(washFee))washFee=0.0;
	if(taxFee==''||isNaN(taxFee))taxFee=0.0;
	if(insureFee==''||isNaN(insureFee))insureFee=0.0;

	if(roadFee==''||isNaN(roadFee))roadFee=0.0;
	if(yearTicketFee==''||isNaN(yearTicketFee))yearTicketFee=0.0;
	if(yearSensorFee==''||isNaN(yearSensorFee))yearSensorFee=0.0;
	if(jsznjf==''||isNaN(jsznjf))jsznjf=0.0;
	if(kcyyznsf==''||isNaN(kcyyznsf))kcyyznsf=0.0;
	if(ccsyf==''||isNaN(ccsyf))ccsyf=0.0;
	if(accidentFee==''||isNaN(accidentFee))accidentFee=0.0;
	if(purchaseTax==''||isNaN(purchaseTax))purchaseTax=0.0;
	if(brandFee==''||isNaN(brandFee))brandFee=0.0;
	if(monthFee==''||isNaN(monthFee))monthFee=0.0;
	if(otherFee==''||isNaN(otherFee))otherFee=0.0;
	if(ejwhf==''||isNaN(ejwhf))ejwhf=0.0;

	$("#qthjfy").val((parseFloat(washFee)+parseFloat(taxFee)+parseFloat(insureFee)+parseFloat(roadFee)+parseFloat(yearTicketFee)+parseFloat(yearSensorFee)+parseFloat(jsznjf)+parseFloat(kcyyznsf)+parseFloat(ccsyf)+parseFloat(accidentFee)+parseFloat(purchaseTax)+parseFloat(brandFee)+parseFloat(monthFee)+parseFloat(otherFee)+parseFloat(ejwhf)).toFixed(4));
    chg_3();
}

function chg_5(){
	var a_cost =  $('input[name="a_cost"]');
	var sum_cost = 0.0;
	for(var i=0; i<a_cost.length; i++){
       var display =a_cost[i].display;
       if(display == 'none'){
           continue;
       }
		var cost = a_cost[i].value;
		if(cost==''||isNaN(cost))cost=0.0;
		sum_cost += parseFloat(cost);
	}
	$("#hjpjf").val(parseFloat(sum_cost).toFixed(4));
    chg_6();
    chg_3();
}

function chg_6(){
	var hjpjf = $("#hjpjf").val();
	var gsf = $("#gsf").val();
	if(hjpjf==''||isNaN(hjpjf))hjpjf=0.0;
	if(gsf==''||isNaN(gsf))gsf=0.0;
	$("#whbyhjfy").val((parseFloat(hjpjf)+parseFloat(gsf)).toFixed(4));
}
function addROW() {
    commonAddTr({tableId:'tbl_1',trIndex:1,operate:'auto',position:'end',isKeep:false,obj:null,callbackfunction:mycall});
}
function mycall(newTr){
   $(newTr).prev().clone(true).insertAfter(newTr);
   $(newTr).prev().remove();
   $(newTr).bind("mouseover",function(){
        setAbsolute(this,'visible',0);
   });
    //解决小数输入问题
    $(newTr).find("input[name='a_price']").unbind('keyup blur');	
    $(newTr).find("input[name='a_price']").unbind('blur');

    //解决小数输入问题
    $(newTr).find("input[name='a_price']").bind('keyup blur',function(){checkNumberWithPoint(this,6);});	
    $(newTr).find("input[name='a_price']").bind('blur',function(){clearPoint(this);});
   
}

function setAbsolute(obj,visible,tt){
	delRows=obj.rowIndex;
	var div = document.getElementById("adddelrow_div");
	div.style.visibility = visible;
    var position = $(obj).position();
	var tbl_w = $("#tbl_1").width();
    var tbl_l = $("#tbl_1").position().left;

	var _scrollTop = 0;
	if(isSurface()){    
	var _position = $('body').css('position');
	if(_position=='relative'){
	_scrollTop = $('.Pupwin').scrollTop();
	}
	}
    div.style.left= (tbl_w + tbl_l + 5) + 'px';//$("#tbl_2").width()+65+ 'px';
	div.style.top = ( position.top+_scrollTop)+ 'px';
}

function delROW(){
    var len=document.getElementById('tbl_1').rows.length;
	if(delRows!=''&&len>2 && delRows != len-1){
        $.dialog.confirm("确定要删除这一行吗？", function(){removeROW(delRows,len)});
	}
}
function removeROW(delRows1,len){
    if(delRows1 == 1){
         clearData($("#tbl_1").find("tr").eq(delRows1));
         $("#tbl_1").find("tr").eq(delRows1).hide();
         delRows='';
         if(len>3){
             setAbsolute($("#tbl_1").find("tr").get(2),'visible',0);
         }else{
            setAbsolute($("#tbl_1").find("tr").get(0),'visible',0);
         }
    }else{
        $("#tbl_1").find("tr").eq(delRows1).remove();
        delRows='';
        setAbsolute($("#tbl_1").find("tr").get(delRows1-1),'visible',0);
    } 
	chg_5();
}
//$(document).ready(function(){
   setAbsolute(document.getElementById('tbl_1').rows[0],'visible',0);
//});

</script>

</html>

