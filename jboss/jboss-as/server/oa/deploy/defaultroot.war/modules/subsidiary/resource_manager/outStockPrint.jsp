<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.Calendar,java.text.DecimalFormat"%>
<%@ page import="java.math.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="com.whir.ezoffice.resource.po.SsDetailPO"%>
<%@ page import="com.whir.ezoffice.resource.bd.IntoOutStockBD"%>
<%@ page import="com.whir.ezoffice.resource.bd.TypeDefineBD"%>
<html>
<%
	int perPageCount = Integer.parseInt(request.getParameter("perPageCount"));
	
	int pagecount = 0 ;
	int record  = 0 ;
	if(request.getAttribute("recordCount")!=null){
		record = Integer.parseInt(request.getAttribute("recordCount").toString());
	}
	
	if(record % perPageCount == 0 ){
 		pagecount = record / perPageCount;
	}else{
 		pagecount = record / perPageCount + 1;
	}
	
	Calendar now = Calendar.getInstance();
	String mode  = request.getParameter("mode");
	BigDecimal amount = new BigDecimal(0);
	BigDecimal money  = new BigDecimal(0);
%>
<head>
<title>打印<%=mode.equals("outStock")?"出库":"退库"%>单</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
	<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
	<script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
	<script src="<%=rootPath%>/scripts/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
	<style>
	  	td{
	    	font-size:12px;
	  	}
	  	.bottomLine{
	    	border-bottom:1px solid #000000;
	  	}
	</style>
</head>
<body>
<% 
	for(int i  = 1 ; i <=pagecount ; i++ ) {
 		amount = new BigDecimal(0);
 		money  = new BigDecimal(0);
 		String pageStyle= "page-break-after:always";
 		if(i<pagecount){
  			pageStyle= "page-break-after:always";
  		}else{
  			pageStyle= "page-break-after:auto";
  		}
%>
<p align="center" style="<%=pageStyle%>">
<table width="90%" border="0" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  	<tr>
	  		<td colspan="10" align="center" style="font-size:18px;" ><strong>材料<%=mode.equals("outStock")?"出库":"退库"%>单</strong></td>
	  	</tr>
      	<tr>
        	<td width="4%"  height="26">&nbsp;</td>
        	<td width="8%"  valign="bottom" align="center"><%=mode.equals("outStock")?"出库":"退库"%>单号</td>
        	<td width="20%" valign="bottom" class="bottomLine"><s:property value="ssMasterPO.serial"/></td>
        	<td width="4%"  valign="bottom">&nbsp;</td>
        	<td width="8%"  valign="bottom" align="center"><%=mode.equals("outStock")?"出库":"退库"%>日期</td>
        	<td width="20%" valign="bottom" class="bottomLine">
                <%now.setTime((java.util.Date) request.getAttribute("ssDate"));%>
	  		    <%=now.get(Calendar.YEAR)+"年"+(now.get(Calendar.MONTH) + 1)+"月"+now.get(Calendar.DATE)+"日"%>
	        </td>
        	<td width="4%"  valign="bottom">&nbsp;</td>
        	<td width="8%"  valign="bottom" align="center">仓&nbsp;&nbsp;&nbsp;&nbsp;库</td>
        	<td width="20%" valign="bottom" class="bottomLine"> <%=request.getAttribute("stockName")%></td>
        	<td width="4%">&nbsp;</td>
      	</tr>
      	<tr>
        	<td height="26">&nbsp;</td>
        	<td valign="bottom" align="center"><%=mode.equals("outStock")?"出库":"退库"%>类别</td>
        	<td valign="bottom" class="bottomLine"><%
        	if(request.getAttribute("ssTypeDefineSelected")!=null && !"0".equals(request.getAttribute("ssTypeDefineSelected").toString())){
			    try{
					out.println(new com.whir.ezoffice.resource.bd.TypeDefineBD().load(new Long(request.getAttribute("ssTypeDefineSelected").toString())).getTypeDefineName());
			    }catch(Exception e){}
		    }
	  		%>&nbsp;</td>
        	<td valign="bottom">&nbsp;</td>
        	<td valign="bottom" align="center">部&nbsp;&nbsp;&nbsp;门</td>
        	<td valign="bottom" class="bottomLine"><s:property value="ssMasterPO.ssOrgName"/></td>
        	<td valign="bottom">&nbsp;</td>
        	<td valign="bottom" align="center">备&nbsp;&nbsp;&nbsp;&nbsp;注</td>
        	<td valign="bottom" class="bottomLine"><s:property value="ssMasterPO.remark"/>&nbsp;</td>
        	<td>&nbsp;</td>
      	</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <table width="100%" style="border-collapse: collapse" borderColor="#000000" cellPadding="1" align="center" border="1">
      	<tr>
        	<td width="8%"  align="center" height="22">序号</td>
        	<td width="15%" align="center">材料编码</td>
        	<td width="22%" align="center">材料名称</td>
        	<td width="15%" align="center">规格型号</td>
        	<td width="10%" align="center">计量单位</td>
        	<td width="10%" align="center">数量</td>
        	<td width="10%" align="center">单价</td>
        	<td width="10%" align="center">金额</td>
      	</tr>
	  	<%
		    List list = (List)request.getAttribute("outStockList");
		    for( int j = 0 ;  j < list.size(); j++){
		    	if(j >= (i-1)*perPageCount && j < i*perPageCount){
				String domainId = session.getAttribute("domainId") == null ? "0" :session.getAttribute("domainId").toString();
				SsDetailPO  ssDetailPO = (SsDetailPO)list.get(j);
				amount = amount.add(ssDetailPO.getAmount().abs());
		        money  = money.add(ssDetailPO.getGoodsMoney().abs());
		%>
      	<tr>
        	<td height="22" align="center"><%=j+1%></td>
        	<td><%=ssDetailPO.getGoodsId().substring(domainId.length()+1,ssDetailPO.getGoodsId().length())%></td>
        	<td><%=ssDetailPO.getGoodsName()%></td>
        	<td><%=ssDetailPO.getGoodsSpecs()==null||"null".equals(ssDetailPO.getGoodsSpecs())?"":ssDetailPO.getGoodsSpecs()%></td>
        	<td align="center"><%=ssDetailPO.getGoodsUnit()%></td>
        	<td align="right"><%=ssDetailPO.getAmount().abs().setScale(2, BigDecimal.ROUND_HALF_UP)%></td>
        	<td align="right"><%=ssDetailPO.getPrice().setScale(6, BigDecimal.ROUND_HALF_UP)%></td>
        	<td align="right"><%=ssDetailPO.getGoodsMoney().abs().setScale(2, BigDecimal.ROUND_HALF_UP)%></td>
      	</tr>
	  	<%}}%>
      	<tr>
        	<td height="22" align="center">小计</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td align="center">&nbsp;</td>
        	<td align="right"><%=amount.setScale(2, BigDecimal.ROUND_HALF_UP)%></td>
        	<td align="right">&nbsp;</td>
        	<td align="right"><%=money.setScale(2, BigDecimal.ROUND_HALF_UP)%></td>
      	</tr>
	  	<% if(i == pagecount) { %>
      	<tr>
        	<td height="22" align="center">&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td align="center">&nbsp;</td>
        	<td align="right">&nbsp;</td>
        	<td align="right">总计:</td>
        	<td align="right"><s:property value="ssMasterPO.ssMoney"/></td>
      	</tr>
	  	<%}%>
      </table>
    </td>
  </tr>
  <tr>
    <td>
	  <%String checkFlag = request.getAttribute("checkFlag")==null?"N":request.getAttribute("checkFlag").toString();%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      	<tr>
        	<td width="8%"  valign="bottom" height="24" align="center">制单人</td>
        	<td width="15%" valign="bottom" class="bottomLine"><%=request.getAttribute("makeManName")%></td>
        	<td width="3%"  valign="bottom">&nbsp;</td>
        	<td width="8%"  valign="bottom" align="center">审核人</td>
        	<td width="15%" valign="bottom" class="bottomLine"><%=checkFlag.equals("Y")?(request.getAttribute("checkManName")==null?"&nbsp;":request.getAttribute("checkManName")):"&nbsp;"%></td>
        	<td width="2%"  valign="bottom">&nbsp;</td>
        	<td width="8%"  valign="bottom" align="center">保管员</td>
        	<td width="15%" valign="bottom" class="bottomLine"><s:property value="ssMasterPO.ssStoreMan"/>&nbsp;</td>
        	<td width="3%">&nbsp;</td>
        	<td width="8%"  valign="bottom" align="center"><%=mode.equals("outStock")?"提料员":"经办人"%></td>
        	<td width="15%" class="bottomLine"><s:property value="ssMasterPO.ssPicker"/>&nbsp;</td>
      	</tr>
      </table>
	  <br>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" >
 		<tr><td align="right">第<%=i%>页，共<%=pagecount%>页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
	  </table>
    </td>
  </tr>
</table>
<%}%>
</body>
<script type="text/javascript">
	$(document).ready(function(){
	      window.print();
	      setTimeout(function(){window.close();},2000);
	});
</script>
</html>