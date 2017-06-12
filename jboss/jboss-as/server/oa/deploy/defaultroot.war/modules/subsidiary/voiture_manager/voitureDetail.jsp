<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
    java.util.List voitureTypeList = (java.util.List) request.getAttribute("voitureTypeList");
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String delDate1 = request.getParameter("delDate")!=null?request.getParameter("delDate"):"";
    Calendar now = Calendar.getInstance();
    if(delDate1 !=null && !delDate1.equals("") && !delDate1.equals("null")){
            now.setTime(formatter.parse(delDate1));
    }else{
        now.setTime(new Date());
    }				
    Date delDate = now.getTime();
    String  voitureTypeId = request.getAttribute("voitureTypeId")==null?"":request.getAttribute("voitureTypeId").toString();
    com.whir.ezoffice.voiture.po.VoiturePO voiturePO=null;
    if(request.getAttribute("voiturePO") !=null){
        voiturePO=(com.whir.ezoffice.voiture.po.VoiturePO)request.getAttribute("voiturePO");
    }
    String status="";
    if(voiturePO != null){
        status=voiturePO.getStatus()+"";
    }
    String view = request.getParameter("view")!=null?request.getParameter("view"):"";
    String className="BodyMargin_10_";
    if(view.equals("true")){
        className="BodyMargin_10";
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>车辆信息查看
</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
    <script language="javascript">
function parentIframeHeight() {
        if(top.location != self.location) {
		    window.parent.document.getElementById("detail").height =( document.documentElement.scrollHeight+50)+"px";
            //alert("111:"+document.documentElement.scrollHeight);
		}
}
$(document).ready(function(){
    <%if(!view.equals("true")){%>
    iframeResizeHeight("detail","div1",50);
    <%}%>
   });
</script>
</head>

<body class="Pupwin" width="100%">
	<div class="<%=className%>" id="div1">  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="${ctx}/voiture!save.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
        <s:hidden name="voiturePO.id" />
        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr>  
                <td for="型号"  class="td_lefttitle" nowrap="nowrap">  
                    型号<span class="MustFillColor">*</span>：  
                </td>  
                <td width="42%">  
                    <s:textfield name="voiturePO.model" id="model" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':15}]"  maxlength="15" cssStyle="width:92%" readonly="true"/>  
                </td> 
                <td for="车牌号" class="td_lefttitle" nowrap="nowrap">  
                    车牌号<span class="MustFillColor">*</span>：  
                </td>  
                <td width="42%">  
                    <s:textfield name="voiturePO.num" id="num" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':10}]"  maxlength="10" cssStyle="width:92%" readonly="true"/>  
                </td>  
            </tr>  
            <tr>  
                <td for="车辆名称" class="td_lefttitle" nowrap="nowrap">  
                    车辆名称<span class="MustFillColor">*</span>：
                </td>  
                <td>  
                    <s:textfield name="voiturePO.name" id="name" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':25}]"  maxlength="25"  cssStyle="width:92%"  readonly="true"/>  
                </td>
                <td for="司机" class="td_lefttitle">  
                    司机<span class="MustFillColor">*</span>：
                </td>  
                <td>  
                    <s:textfield name="voiturePO.motorMan" id="motorMan" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':30}]"  maxlength="30"  cssStyle="width:92%"  readonly="true"/>  
                </td>  
            </tr>
            <tr>  
                <td for="类别" class="td_lefttitle" >  
                    类别<span class="MustFillColor">*</span>：  
                </td>  
                <td>  
                    <select name="voitureTypeId" id="voitureTypeId"  class="easyui-combobox" style="width:150px"  whir-options="vtype:['notempty']" data-options="panelHeight:'auto'" disabled="true" >
                        <option value="">请选择</option>
                        <%
                        if(voitureTypeList != null && voitureTypeList.size()>0){
                            for(int i=0;i<voitureTypeList.size();i++){
                                Object[] obj = (Object[]) voitureTypeList.get(i);
                         %>
                        <option value="<%=obj[0]%>" <%if(voitureTypeId.equals(obj[0].toString())){%>selected<%}%>><%=obj[1]%></option>
                        <%}}%>
                    </select>
                </td>
                <td for="车辆识别码" class="td_lefttitle" nowrap="nowrap">  
                    车辆识别码：
                </td>  
                <td>  
                    <s:textfield name="voiturePO.voitureCode" id="voitureCode" cssClass="inputText" whir-options="vtype:[{'maxLength':30}]"  maxlength="30" cssStyle="width:92%" readonly="true"/>  
                </td>  
            </tr>
            <tr>  
                <td for="固定成本" class="td_lefttitle">  
                    固定成本：  
                </td>        
                <td>
                    <s:textfield name="voiturePO.fixedCost" id="fixedCost" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9999'},{'maxLength':30}]"  maxlength="30" cssStyle="width:92%" readonly="true"/>元
                </td>
                <td for="油耗成本" class="td_lefttitle">  
                    油耗成本：  
                </td>        
                <td>
                    <s:textfield name="voiturePO.oilCost" id="oilCost" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999.9999'},{'maxLength':30}]"  maxlength="30" cssStyle="width:92%" readonly="true"/>元
                </td>  
            </tr>
            <tr>  
                <td for="保养周期" class="td_lefttitle">  
                    保养周期：  
                </td>        
                <td>
                    <s:textfield name="voiturePO.maintainCyc" id="maintainCyc" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999'},{'maxLength':15}]"  maxlength="15" cssStyle="width:92%"  readonly="true"/>月
                </td>
                <td for="保养里程数" class="td_lefttitle">  
                    保养里程数：  
                </td>        
                <td nowrap="nowrap">
                    <s:textfield name="voiturePO.maintainOdograph" id="maintainOdograph" cssClass="inputText" whir-options="vtype:['p_decimal_e',{'range':'0-99999999'},{'maxLength':15}]"  maxlength="15"  cssStyle="width:92%" readonly="true"/>公里
                </td>  
            </tr>
             <tr>  
                <td for="所属单位" class="td_lefttitle">  
                    所属单位<span class="MustFillColor">*</span>：  
                </td>  
                <td>
                    <s:textfield name="voiturePO.orgName" id="orgName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':100}]"  maxlength="100" cssStyle="width:92%" readonly="true"/><s:hidden name="voiturePO.orgId" id="orgId"/> 
                </td>
                <td for="车辆状态" class="td_lefttitle" nowrap="nowrap">  
                    车辆状态<span class="MustFillColor">*</span>：  
                </td>  
                <td>  
                    <select name="voiturePO.status" id="status" class="selectlist" whir-options="vtype:['notempty']" style="width:20%" onchange="chgstat();" disabled="true">
                        <option value="1" <%if(status.equals("1")){%>selected<%}%>>在用</option>
                        <option value="0" <%if(status.equals("0")){%>selected<%}%>>报废</option>
						<option value="2" <%if(status.equals("2")){%>selected<%}%>>停用</option>
                    </select>
                    <span style="display:none" id="pandelDate">
                         <input type="text" name="voiturePO.delDate" id="delDate" class="Wdate whir_datebox" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" value="<%=formatter.format(delDate)%>"/>
                    </span>
                </td>
            </tr>
            <tr>  
                <td for="备注" class="td_lefttitle">  
                    备注：
                </td>  
                <td colspan=3>
                    <s:textarea name="voiturePO.remark" id="remark" cols="112" rows="3"   cssClass="inputTextarea" cssStyle="width:97%;" whir-options="vtype:[{'maxLength':200}]"  maxlength="200" readonly="true"/>
                </td>  
            </tr>
             <tr>  
                <td for="适用范围" class="td_lefttitle">  
                    适用范围<span class="MustFillColor">*</span>：
                </td>  
                <td colspan=3>
                    <s:textarea name="voiturePO.useRangeName" id="useRangeName" cols="112" rows="3"   cssClass="inputTextarea" cssStyle="width:97%;" whir-options="vtype:['notempty']"  readonly="true"/><s:hidden name="voiturePO.useRangeId" id="useRangeId"/> 
                </td>  
            </tr>
            <% if(!("1".equals(request.getParameter("ifram")+""))){ %>
            <tr class="Table_nobttomline">  
                <td > </td> 
                <td nowrap colspan=3>                     
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
                </td>  
            </tr>
            <% }%>  
        </table>  
	</s:form>
	
		</div>
	</div>
</body>
</html>

