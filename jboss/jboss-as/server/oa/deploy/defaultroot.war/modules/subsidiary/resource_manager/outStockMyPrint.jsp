<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.math.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="com.whir.ezoffice.resource.po.SsDetailPO"%>
<%@ page import="com.whir.ezoffice.resource.bd.IntoOutStockBD"%>
<%@ page import="com.whir.ezoffice.resource.bd.TypeDefineBD"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String ssMasterId = request.getParameter("ssMasterId")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("ssMasterId"));
    if(null!= ssMasterId && !"".equals(ssMasterId) && !"null".equals(ssMasterId)){
	   ssMasterId = ssMasterId.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)","");
	}
	String stockId    = request.getAttribute("stockId")==null?"":request.getAttribute("stockId").toString();
	Calendar now  = Calendar.getInstance();
	String mode   = request.getParameter("mode")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("mode"));
    if(null!= mode && !"".equals(mode) && !"null".equals(mode)){
	   mode = mode.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)","");
	}
%>
<head>
	<title>打印<%=mode.equals("outStock")?"出库":"退库"%>单</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<script type="text/javascript">
	    var whirRootPath = "<%=rootPath%>";
		var preUrl       = "<%=preUrl%>";
		var whir_browser = "<%=whir_browser%>";
        var whir_agent   = "<%=whir_agent%>"; 
	</script>
	<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
	<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
	<script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
	<script src="<%=rootPath%>/scripts/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js" type="text/javascript"></script>
	<script src="<%=rootPath%>/scripts/plugins/jPages/js/jPages.js" type="text/javascript"></script>
    <link  href="<%=rootPath%>/scripts/plugins/jPages/css/jPages.css" rel="stylesheet" type="text/css"/>
	<style>
  		td{
    		font-size:12px;
  		}
  		.bottomLine{
    		border-bottom:1px solid #000000;
  		}
  		.btnButton4font{
		    cursor: pointer;
		    background: url(defaultroot/themes/common/images/inbtnbg.jpg) repeat-x left bottom #f2f2f2;
		    color: #333;
		    font-size: 12px;
		    border: 1px solid #afafaf;
		    height: 24px;
		    padding: 0px 10px 0px 10px;
			*+padding: 0px 3px 0px 3px;
		}
	</style>
</head>
<body>
<s:form name="queryForm" id="queryForm" action="/outStockAction!getSsDetail.action" method="post" theme="simple">
<%@ include file="/public/include/form_list.jsp"%>
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
        	<td width="20%" valign="bottom" class="bottomLine"><%=request.getAttribute("stockName")%></td>
        	<td width="4%">&nbsp;</td>
      	</tr>
      	<tr>
        	<td height="26">&nbsp;</td>
       	 	<td valign="bottom" align="center" ><%=mode.equals("outStock")?"出库":"退库"%>类别</td>
        	<td valign="bottom" class="bottomLine"><%
        	if(request.getAttribute("ssTypeDefineSelected")!=null && !"0".equals(request.getAttribute("ssTypeDefineSelected").toString())){
			    try{
					out.println(new com.whir.ezoffice.resource.bd.TypeDefineBD().load(new Long(request.getAttribute("ssTypeDefineSelected").toString())).getTypeDefineName());
			    }catch(Exception e){}
		    }
			%></td>
        	<td valign="bottom">&nbsp;</td>
        	<td valign="bottom" align="center">部&nbsp;&nbsp;&nbsp;门</td>
        	<td valign="bottom" class="bottomLine"><s:property value="ssMasterPO.ssOrgName"/>&nbsp;</td>
        	<td valign="bottom">&nbsp;</td>
        	<td valign="bottom" align="center">备&nbsp;&nbsp;&nbsp;&nbsp;注</td>
        	<td valign="bottom" class="bottomLine"><s:property value="ssMasterPO.remark"/>&nbsp;</td>
        	<td>&nbsp;</td>
      	</tr>
      </table>
    </td>
  </tr>
  
  <input type="hidden" name="ssMasterId" value="<%=ssMasterId%>">
  <s:hidden name="ssMasterPO.ssMoney" id="ssMoney"/>
  <tr>
    <td>
      <table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#999999" class="listTable">
      	<thead id="headerContainer">
	    	<tr class="listTableHead">
        		<td align="center" bgcolor="#dddddd" whir-options="field:'index',width:'8%'">序号</td>
        		<td align="center" bgcolor="#dddddd" whir-options="field:'chbm',width:'15%'">材料编码</td>
        		<td align="center" bgcolor="#dddddd" whir-options="field:'goodsName',width:'22%'">材料名称</td>
        		<td align="center" bgcolor="#dddddd" whir-options="field:'goodsSpecs',width:'15%'">规格型号</td>
        		<td align="center" bgcolor="#dddddd" whir-options="field:'goodsUnit',width:'10%'">计量单位</td>
        		<td align="center" bgcolor="#dddddd" whir-options="field:'amount',width:'10%'">数量</td>
        		<td align="center" bgcolor="#dddddd" whir-options="field:'price',width:'10%'">单价</td>
        		<td align="center" bgcolor="#dddddd" whir-options="field:'goodsMoney',width:'10%'">金额</td>
      		</tr>
	    </thead>
        
	    <tbody  id="itemContainer">
	    
      	</tbody>
	  	
      </table>
    </td>
  </tr>
  <tr>
    <td>
	 <%String checkFlag = request.getAttribute("checkFlag")==null?"N":request.getAttribute("checkFlag").toString();%>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
      	<tr>
        	<td width="8%"  valign="bottom" height="24" align="center">制单人</td>
        	<td width="15%" valign="bottom" class="bottomLine"><%=request.getAttribute("makeManName")==null?"&nbsp;":request.getAttribute("makeManName").toString()%></td>
        	<td width="3%"  valign="bottom">&nbsp;</td>
        	<td width="8%"  valign="bottom" align="center">审核人</td>
        	<td width="15%" valign="bottom" class="bottomLine"><%=checkFlag.equals("Y")?(request.getAttribute("checkManName")==null?"&nbsp;":request.getAttribute("checkManName").toString()):"&nbsp;"%></td>
        	<td width="2%"  valign="bottom">&nbsp;</td>
        	<td width="8%"  valign="bottom" align="center">保管员</td>
        	<td width="15%" valign="bottom" class="bottomLine"><s:property value="ssMasterPO.ssStoreMan"/>&nbsp;</td>
       		<td width="3%">&nbsp;</td>
        	<td width="8%"  valign="bottom" align="center"><%=mode.equals("outStock")?"提料员":"经办人"%></td>
        	<td width="15%" class="bottomLine"><s:property value="ssMasterPO.ssPicker"/>&nbsp;</td>
      	</tr>
   	 </table>
 	 <br>
 	 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
     </table>
     <br>
	 <table width="100%" border="0" cellpadding="0" cellspacing="0" >
  	 	<tr>
     		<td>每页&nbsp;<input type="text" name="pageNum" id="pageNum" onkeyup="checkNUM(this);" size="3" maxlength="2">&nbsp;条&nbsp;<input type="button" class="btnButton4font" onClick="change();" value="<s:text name="comm.confirm"/>" class="btnButton4font"/>&nbsp;<input type="button" class="btnButton4font" onClick="myprint();" value="<s:text name="comm.print"/>" class="btnButton4font"/></td>
        </tr>
     </table>
    </td>
  </tr>
</table>
</s:form>
</body>
<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){
		initListFormToAjax({formId:"queryForm",onLoadSuccessAfter:backAjaxRun});
		
		//处理GO显示不全问题-----2013-07-19-----开始
		$('.Pagebar').find('input[type=button]').attr('style','height:23px;width:50px;margin-top:5px;');
		//处理GO显示不全问题-----2013-07-19-----结束
	});
	
	function backAjaxRun(){
	    $('#itemContainer').find('tr').each(function(){
	    	$(this).find('td').attr('align','center');
	    	$(this).find('td').attr('height','22');
	    	$(this).find('td:eq(0)').css('background-color','#dddddd');
	    	$(this).find('td').not($(this).find('td:eq(0)')).css('background-color','#FFFFFF');
	    });
	    
	    $('#itemContainer tr').show();
	}
	
	function checkNUM(obj){
		var value = $(obj).val();
	    if((/^(\+|-)?\d+$/.test( value )) && value >0){
	        return true;
	    }else{
	        $(obj).val('1');
	    }
	}
	
	function change(){
	    var pageNum =$('#pageNum').val();
	    if(pageNum ==''){
	    	$.dialog.alert('不能为空！', function(){
	    		$('#pageNum').focus();
	    	});
	    	return false;
	    }
	    $('#start_page').val('1');
	    refreshListForm('queryForm');
	}
	
	function myprint(){
	    var para =$('#page_size').val();
	    var pageNum =$('#pageNum').val();
	    if(pageNum !=''){
	        para =pageNum;
	    }
	    openWin({url:'<%=rootPath%>/outStockAction!print.action?ssMasterId=<%=ssMasterId%>&mode=<%=mode%>&stockId=<%=stockId%>&perPageCount='+para+'',isFull:true,winName:'打印信息'});
	}
</script>
</html>