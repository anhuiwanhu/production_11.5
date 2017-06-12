<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*,java.text.*"%>
<%
String op = request.getParameter("op")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"op");
String searchTJFS = request.getParameter("searchTJFS")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"searchTJFS");
String searchN = request.getParameter("searchN")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"searchN");
String searchY = request.getParameter("searchY")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"searchY");
String searchJD = request.getParameter("searchJD")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"searchJD");
String searchQT1 = request.getParameter("searchQT1")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"searchQT1");
String searchQT2 = request.getParameter("searchQT2")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"searchQT2");


Date date = null ;
SimpleDateFormat sdf = new SimpleDateFormat();
sdf.applyPattern("yyyy/MM/dd");
  

if((null == searchQT1)||(1>searchQT1.length())){
	date = new Date();
    searchQT1 = sdf.format(date);
}
if((null == searchQT2)||(1>searchQT2.length())){
    date = new Date();
    searchQT2 = sdf.format(date);
}

String[] date1 = searchQT1.split("/");
String[] date2 = searchQT2.split("/");

String orderby = request.getParameter("orderby")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"orderby");
String sort = request.getParameter("sort")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"sort");
com.whir.org.manager.bd.ManagerBD mBD = new com.whir.org.manager.bd.ManagerBD();
boolean jfLook = mBD.hasRight(session.getAttribute("userId").toString(), "sft*01*05");
%>
<%if(jfLook){%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/public/include/meta_base.jsp"%>
<%@ include file="/public/include/meta_list.jsp"%>
<title>无标题文档</title>
</head>
<body class="MainFrameBox"  onLoad="init();">
<s:form name="queryForm" id="queryForm" action="${ctx}/xxcy!jftj.action" method="post" theme="simple">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
   <tr>
     <td class="whir_td_searchtitle">统计方式：</td>
     <td class="whir_td_searchinput" colspan=1 nowrap>
    <s:if test='#request.searchTJFS=="NF"'>
      <input type="radio" name="searchTJFS" value="NF" checked="checked" onClick="ck(this)">年份
     </s:if>
     <s:else>
		<input type="radio" name="searchTJFS" value="NF"  onClick="ck(this)">年份
     </s:else>
      <s:if test='#request.searchTJFS=="YF"'>
      <input type="radio" name="searchTJFS" value="YF" checked="checked" onClick="ck(this)">月度
     </s:if>
     <s:else>
		<input type="radio" name="searchTJFS" value="YF"  onClick="ck(this)">月度
     </s:else>
       <s:if test='#request.searchTJFS=="JD"'>
      <input type="radio" name="searchTJFS" value="JD" checked="checked" onClick="ck(this)">季度
     </s:if>
     <s:else>
		<input type="radio" name="searchTJFS" value="JD"  onClick="ck(this)">季度
      </s:else>
       <s:if test='#request.searchTJFS=="QT"'>
      <input type="radio" name="searchTJFS" value="QT" checked="checked" onClick="ck(this)">其它
       </s:if>
     <s:else>
		<input type="radio" name="searchTJFS" value="QT"  onClick="ck(this)">其它
      </s:else>
    </td>
	 <td class="whir_td_searchtitle">&nbsp;</td>
     <td class="whir_td_searchinput">&nbsp;</td>
     <td class="whir_td_searchtitle">&nbsp;</td>
     <td class="whir_td_searchinput">&nbsp;</td>
  </tr>
  <%java.util.Calendar now = java.util.Calendar.getInstance();%>
  <tr>
    <td class="whir_td_searchtitle">报送日期：</td>
    <td class="whir_td_searchinput"  colspan=4 nowrap>
      <span id="sp_NF" style="display:none;">
        <select name="searchN"  id="searchN" class="selectlist" style="width:15%">
          <%
            for(int i = now.get(java.util.Calendar.YEAR); i > 2010; i --){
		    if(searchN != null && !searchN.equals("") && searchN.equals(i+"")){
	     %>
		    <option value="<%=searchN%>" selected><%=i%></option>
		 <%
		    }else{
	     %>
	        <option value="<%=i%>"><%=i%></option>
         <%}}%>
        </select> 年
      </span>
      <span id="sp_YF" style="display:none;">
        <select name="searchY" id="searchY" class="selectlist" style="width:10%">
          <%
             for(int i = 0; i < 12; i ++){
			    if(searchY != null && !searchY.equals("")){
		            if(searchY.equals((i+1)+"")){
		  %>
		  <option value="<%=i + 1%>" selected><%=i + 1%></option>
		  <%}else{%>
          <option value="<%=i + 1%>"><%=i + 1%></option>
		  <%
		  }
		 }else{
	    %>
          <option value="<%=i + 1%>" <%=now.get(java.util.Calendar.MONTH)==i?"selected":""%>><%=i + 1%></option>
        <%}}%>
        </select> 月
      </span>
      <span id="sp_JD" style="display:none;">
        <select name="searchJD" id="searchJD" class="selectlist" style="width:10%">
          <option value="1" id="1" selected>1</option>
          <option value="2" id="2">2</option>
          <option value="3" id="3">3</option>
          <option value="4" id="4">4</option>
        </select> 季度
      </span>
      <span id="sp_QT" style="display:none;">
          <s:textfield id="searchQT1" name="searchQT1"  cssClass="Wdate whir_datebox" onfocus="WdatePicker({el:'searchQT1',isShowWeek:true,maxDate:'#F{$dp.$D(\\'searchQT2\\',{d:0});}'})"/> 至 <s:textfield id="searchQT2" name="searchQT2" cssClass="Wdate whir_datebox" onfocus="WdatePicker({el:'searchQT2',isShowWeek:true,minDate:'#F{$dp.$D(\\'searchQT1\\',{d:0});}'})"/>
      </span>
    </td>
    <td class="SearchBar_toolbar">
          <input type="button" class="btnButton4font"  onclick="sh();"  value='<s:text name="comm.searchnow"/>' />
          <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="cl();" />      
    </td>
  </tr>
    <s:hidden name="flag" value="jftj" id="flag"/>
    <s:hidden name="orderby"  id="orderby"/>
    <s:hidden name="sort"  id="sort"/>
</table>
<!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			 <td align="right" width="55%">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right">
				<%if(isForbiddenPad){%>
                <input type="button" class="btnButton4font" onclick="expY();" value="按年导出" />
                <input type="button" class="btnButton4font" onclick="exp();" value='<s:text name="comm.export"/>' />
				<%}%>
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
        <thead id="headerContainer">
            <tr class="listTableHead">
                <td class="listTableHead" nowrap="nowrap" width="4%" rowspan=2 valign=top>名次</td>
                <td class="listTableHead" rowspan=2 nowrap="nowrap" >报送单位</td>
                <td class="listTableHead" rowspan=2 nowrap="nowrap" >累计采用得分
                 <s:if test='#request.orderby!="ljjf"'>
                <img src="<%=rootPath%>/images/blanksort.gif" style="cursor:hand" onclick="order('ljjf', 'desc')" title="按总计得分排序">
                </s:if>
                <s:elseif test='#request.sort=="desc"'>
                <img src="<%=rootPath%>/images/arrow_down.gif" style="cursor:hand" onClick="order('ljjf','asc');" title="按总计得分排序">
                </s:elseif> 
                <s:else>
                <img src="<%=rootPath%>/images/arrow_up.gif" style="cursor:hand" onClick="order('ljjf','desc');" title="按总计得分排序">
                </s:else>
                </td>
                <%
                List kwList =null;
                int kwlength =0;
                String wangliIsAll=(String) request.getAttribute("isAll");
                if("All".equals(wangliIsAll)){
                String[] kwObj = null;
                kwList= (List) request.getAttribute("kwList");
                kwlength=kwList.size();
                }else{
                com.whir.ezoffice.infosend.po.JfbzPO kwObj = null;
                kwList= (List) request.getAttribute("kwList");
                kwlength=kwList.size();
                }
                %>
                <td colspan="<%=kwlength%>" class="listTableHead">条数</td>
                <td class="listTableHead" rowspan=2 nowrap="nowrap" >上报条数
                <s:if test='#request.orderby!="sbtj"'>
                <img src="<%=rootPath%>/images/blanksort.gif" style="cursor:hand" onclick="order('sbtj','desc')" title="按上报条数排序">
                </s:if>
                <s:elseif test='#request.sort=="desc"'>
                <img src="<%=rootPath%>/images/arrow_down.gif" style="cursor:hand" onClick="order('sbtj','asc');" title="按上报条数排序">
                </s:elseif> 
                <s:else>
                <img src="<%=rootPath%>/images/arrow_up.gif" style="cursor:hand" onClick="order('sbtj','desc');" title="按上报条数排序">
                </s:else>
                </td>
                <td class="listTableHead" rowspan=2 nowrap="nowrap" >当前得分
                <s:if test='#request.orderby!="dqjf"'>
                <img src="<%=rootPath%>/images/blanksort.gif" style="cursor:hand" onclick="order('dqjf','desc')" title="按当前得分排序">
                </s:if>
                <s:elseif test='#request.sort=="desc"'>
                <img src="<%=rootPath%>/images/arrow_down.gif" style="cursor:hand" onClick="order('dqjf','asc');" title="按当前得分排序">
                </s:elseif> 
                <s:else>
                <img src="<%=rootPath%>/images/arrow_up.gif" style="cursor:hand" onClick="order('dqjf','desc');" title="按当前得分排序">
                </s:else>
                </td>
            </tr>
            <tr class="listTableHead">
                <%
                if("All".equals(wangliIsAll)){
                String[] kwObj = null;
                kwList= (List) request.getAttribute("kwList");
                for(int i = 0; i < kwList.size(); i ++) {
                kwObj = (String[]) kwList.get(i);
                %>
                <td class="listTableHead" colspan="1"><%=kwObj[1]%></td>
                <%
                }
                }else{
                com.whir.ezoffice.infosend.po.JfbzPO kwObj = null;
                kwList= (List) request.getAttribute("kwList");
                for(int i = 0; i < kwList.size(); i ++) {
                kwObj = (com.whir.ezoffice.infosend.po.JfbzPO) kwList.get(i);
                %>
                <td colspan="1" class="listTableHead"><%=kwObj.getMc()%></td>
                <%
                }
                }
                %>
            </tr>
        </thead>
        <tbody  id="itemContainer">
                <%
                Map ljjf = (Map) request.getAttribute("ljjf");
                Map sbtj = (Map) request.getAttribute("sbtj");
                Map dqjf = (Map) request.getAttribute("dqjf");
                Map jftjMap = (Map) request.getAttribute("jftjMap");
                List dwList = (List) request.getAttribute("pageList");
                com.whir.ezoffice.infosend.po.DwPO resultObj = null;
                int index = 0;
                String listClass;
                %>
                <%
                for(int m1=0;m1<dwList.size();m1++){
                    resultObj = (com.whir.ezoffice.infosend.po.DwPO) dwList.get(m1);
                    int dwjb = resultObj.getDwjb().intValue();
                    index ++;
                    listClass = index%2!=0?"listTableLine2":"listTableLine1";
                %>
            <tr class="<%=listClass%>">
                <td  align="center"><%=index%></td>
                <td >
                <%
                if(dwjb > 1){
                for(int t=1;t<dwjb;t++){
                %>
                &nbsp;
                <%}}%>
                <%=resultObj.getMc()==null?"&nbsp;":resultObj.getMc()%>
                </td>
                <td  align="center">
                <%
                if(ljjf != null && ljjf.size() != 0){
                if(ljjf.get(resultObj.getDwid())== null || ljjf.get(resultObj.getDwid()).toString().equals("null")){
                %>
                0
                <%}else{%>
                <%=ljjf.get(resultObj.getDwid())%>
                <%
                }
                }else{
                %>
                0
                <%}%>
                </td>
                <%
                if(kwList != null && kwList.size() != 0){
                for(int j=0;j<kwList.size();j++){
                Map jfbzMap = new HashMap();
                jfbzMap = (HashMap)jftjMap.get("jfbzMap"+j);
                %>	
                <td  align="center" colspan="1">
                <%=jfbzMap.get(resultObj.getDwid())== null ?"0":jfbzMap.get(resultObj.getDwid())%>	
                </td>
                <%}}%>
                <td  align="center">
                <%
                if(sbtj != null && sbtj.size() != 0){%>
                <%=sbtj.get(resultObj.getDwid())== null ?"0":sbtj.get(resultObj.getDwid())%>
                <%
                }else{
                %>
                0
                <%}%>
                </td>
                <td align="center">
                <%
                if(dqjf != null && dqjf.size() != 0){%>
                <%=dqjf.get(resultObj.getDwid())== null ?"0":dqjf.get(resultObj.getDwid())%>
                <%
                }else{
                %>
                0
                <%}%>
                </td>
            </tr>
            <%}%>
    </tbody>
</table>
</s:form>
</body>
<iframe name="iframe1" style="display:none"></iframe>
</html>
<%}%>
<script language="javascript">
function cl() {
	<%
	 java.util.Calendar now = java.util.Calendar.getInstance();
	 int ii = now.get(java.util.Calendar.YEAR);
	%>
  var url = "${ctx}/xxcy!jftj.action?searchTJFS=NF&searchN=<%=ii%>";
    location_href(url);
}
function sh() {
    var val='';
    var t=$("#sp_QT").css("display");
    if(t == 'block'){
        var beginDate=$("#searchQT1").val();
        var endDate=$("#searchQT2").val();
        if(beginDate == '' || endDate == ''){
            val='1';
            whir_alert("请选择日期！",null,null);
            return;
        }
    }
   if(val ==''){
     queryForm.submit();
   }
}
$(document).ready(function(){
        init();		
 });
function init() {//sp_YF
 document.getElementById("sp_<%=searchTJFS%>").style.display = "";
 <%if(searchTJFS.equals("NF") || searchTJFS.equals("YF") || searchTJFS.equals("JD")){%>
document.getElementById("sp_NF").style.display = "";
	 <%}%>
 <%if(searchTJFS.equals("JD") && searchJD != null && !searchJD.equals("")){%>
	document.getElementById("<%=searchJD%>").selected = "selected";
	<%}%>
}
function ck(obj) {
  if(obj.value == "NF") {
    if(obj.checked) {
      $("#sp_NF").css("display","");
      $("#sp_YF").css("display","none");
      $("#sp_JD").css("display","none");
      $("#sp_QT").css("display","none");
    }
  } else if(obj.value == "YF") {
    if(obj.checked) {
      $("#sp_NF").css("display","");
      $("#sp_YF").css("display","");
      $("#sp_JD").css("display","none");
      $("#sp_QT").css("display","none");
    }
  } else if(obj.value == "JD") {
    if(obj.checked) {
       $("#sp_NF").css("display","");
      $("#sp_YF").css("display","none");
      $("#sp_JD").css("display","");
      $("#sp_QT").css("display","none");
    }
  } else if(obj.value == "QT") {
    if(obj.checked) {
      $("#sp_NF").css("display","none");
      $("#sp_YF").css("display","none");
      $("#sp_JD").css("display","none");
      $("#sp_QT").css("display","block");
    }
  }
}

function order(orderby, sort) {
  document.getElementById("orderby").value=orderby;
  document.getElementById("sort").value=sort;
  queryForm.target = "";
  queryForm.submit();
}
function exp() {
   document.getElementById("flag").value="exp";
    queryForm.action="${ctx}/xxcy!exp.action";
   queryForm.target = "_blank";
    queryForm.submit();
	queryForm.action="${ctx}/xxcy!jftj.action";
	queryForm.target = "";
}
function expY() {
 document.getElementById("flag").value="expY";
 queryForm.action="${ctx}/xxcy!expY.action";
 queryForm.target = "_blank";
 queryForm.searchTJFS.value="NF";
 //alert(queryForm.searchTJFS.value);//return;
 queryForm.submit();
 queryForm.action="${ctx}/xxcy!jftj.action";
 //document.getElementById("flag").value="jftj";
 queryForm.target = "";
}
</script>
