<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String remoteAddr = null;
if(application.getAttribute("remoteAddr") == null) {
  com.whir.ezoffice.infosend.actionsupport.RemoteAddr r = new com.whir.ezoffice.infosend.actionsupport.RemoteAddr();
  remoteAddr = r.getRemoteAddr();
  application.setAttribute("remoteAddr", remoteAddr);
} else {
  remoteAddr = application.getAttribute("remoteAddr")==null?"":application.getAttribute("remoteAddr").toString();
}
 com.whir.ezoffice.infosend.po.DwPO dwPO = null;
java.util.List bsdwList = (java.util.List) request.getAttribute("bsdwList");
String zf = request.getParameter("zf")==null?"":request.getParameter("zf").toString();
com.whir.ezoffice.infosend.po.SyxxPO syxxPO = null;

if(request.getAttribute("syxxPO") != null ) {
      syxxPO=(com.whir.ezoffice.infosend.po.SyxxPO)request.getAttribute("syxxPO");
  }
  String xxfl="文章";
  if(syxxPO != null){
        if(syxxPO.getXxfl() != null && !syxxPO.getXxfl().equals("")&& !syxxPO.getXxfl().equals("null")){
            xxfl=syxxPO.getXxfl();
        }
  }
   String shr="";
  if(syxxPO != null){
        if(syxxPO.getShr() != null && !syxxPO.getShr().equals("")&& !syxxPO.getShr().equals("null")){
            shr=syxxPO.getShr();
        }
  }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>修改信息
</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->

</head>

<body class="Pupwin">
	<div class="BodyMargin_10" >  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="${ctx}/syxx!save.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr>  
                <td for="报送单位"  class="td_lefttitle">  
                    报送单位：  
                </td>  
                <td width="42%"> 
                    <s:textfield name="syxxPO.bsdw" id="bsdw" cssClass="inputText" readonly="true"/> 
                    <s:hidden name="syxxPO.bsdwid" id="bsdwid"/>
                </td>
                 <td for="报送日期"  class="td_lefttitle">  
                    报送日期：  
                </td>  
                <td width="42%">  
                    <s:textfield name="syxxPO.fbrq" id="fbrq" cssClass="inputText" readonly="true"> 
                        <s:param name="value"><s:date name="syxxPO.fbrq" format="yyyy-MM-dd HH:mm"/></s:param>
                   </s:textfield>
					<input type="hidden" name="fbrq" value='<s:date name="syxxPO.fbrq" format="yyyy-MM-dd HH:mm:ss"/>' />
                </td>  
            </tr>
            <tr>  
                <td for="报送人"  class="td_lefttitle">  
                    报送人：  
                </td>  
                <td>  
                   <s:textfield name="syxxPO.bsrxm" id="bsrxm" cssClass="inputText" readonly="true"/> 
                </td>
                 <td for="联系电话"  class="td_lefttitle">  
                    联系电话：  
                </td>  
                <td>  
                    <s:textfield name="syxxPO.lxdh" id="lxdh" cssClass="inputText" whir-options="vtype:[{'maxLength':15}]" maxlength="15"/>  
                </td>  
            </tr>  
            <tr>  
                <td for="审核人"  class="td_lefttitle">  
                    审核人：  
                </td>  
                <td>  
                       <input type="text" name="syxxPO.shr" maxlength="30" value="<%=shr%>" id="shr" class="inputText" whir-options="vtype:[{'maxLength':30}]"/>
                </td>
                 <td for="信息分类" width="9%" class="td_lefttitle">  
                    信息分类：  
                </td>  
                <td>  
                    <select name="syxxPO.xxfl" id="xxfl" style="width:40%" class="selectlist" >
                        <option value="文章" <%=xxfl.equals("文章")?"selected":""%>>文章</option>
                        <option value="信息" <%=xxfl.equals("信息")?"selected":""%>>信息</option>
                        <option value="案例" <%=xxfl.equals("案例")?"selected":""%>>案例</option>
                        <option value="其它" <%=xxfl.equals("其它")?"selected":""%>>其它</option>
                    </select>  
                </td>  
            </tr>  
            <tr>  
                <td for="信息标题" class="td_lefttitle">  
                    信息标题<span class="MustFillColor">*</span>：  
                </td>  
                <td colspan="3">  
                    <s:textfield name="syxxPO.bt" id="bt" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':65},'spechar3']" style="width:98.8%"  maxlength="65"/> 
                </td>  
            </tr>
             <tr>  
                <td for="正文" class="td_lefttitle">  
                    正文：  
                </td>  
                <td colspan="3">  
                     <s:textarea name="syxxPO.zw" id="zw" cols="70" rows="20"   cssClass="inputTextarea" cssStyle="width:98.8%;height:400px;font-family:仿宋_GB2312;font-size:18px;"/> 
                </td>  
            </tr>
            <tr style="display:none">  
                <td for="报送至单位" class="td_lefttitle" >  
                    报送至<span class="MustFillColor">*</span>：  
                </td>  
                <td colspan="3">  
                      <s:textfield name="syxxPO.bszdwmc" id="bszdwmc" cssClass="inputText" whir-options="vtype:['notempty']"  readonly="true" style="width:89.6%"/><a href="javascript:void(0);" class="selectIco" onclick="ckbsz();"></a>
                     <input type="button" class="btnButton4font" onClick="resetOrg();" value='<s:text name="comm.clear"/>' /> 
                       <s:hidden name="syxxPO.bszdwid" id="bszdwid"/>
                       <s:hidden name="syxxPO.bszdwserver" id="bszdwserver"/>
                       
                       <input type="hidden" name="mcstr" id="mcstr" value="<s:property value='#request.mcstr'/>">
                </td>  
            </tr>
            <tr>  
                <td for="附件" class="td_lefttitle">  
                    附件：  
                </td>  
                <td colspan="3"> 
                    <s:hidden name="syxxPO.fjname" id="fjname"/>
                    <s:hidden name="syxxPO.fjsavename" id="fjsavename"/>

                    <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                        <jsp:param name="dir"		 value="infosend" />
                        <jsp:param name="uniqueId"    value="uniqueId" />
                        <jsp:param name="realFileNameInputId"    value="fjname" />
                        <jsp:param name="saveFileNameInputId"    value="fjsavename" />
                        <jsp:param name="canModify"       value="yes" />
                        <jsp:param name="width"		 value="90" />
                        <jsp:param name="height"		 value="20" />
                        <jsp:param name="multi"		 value="true" />
                        <jsp:param name="buttonClass" value="upload_btn" />
                        <jsp:param name="fileSizeLimit"		 value="0" />
                        <jsp:param name="fileTypeExts"		 value="*.jpg;*.jpeg;*.gif;*.png;*.zip;*.doc;*.docx;*.xls;*.xlsm;*.ppt;*.pptx;*.txt" />
                    </jsp:include>
                </td>  
            </tr>
            <%
		   com.whir.org.manager.bd.ManagerBD mBD = new com.whir.org.manager.bd.ManagerBD();
			  boolean jfLook = mBD.hasRight(session.getAttribute("userId").toString(), "sft*01*05");
			  if(request.getParameter("readonly") !=null && request.getParameter("readonly").equals("1")){%>
          <%} else {%>
            <tr class="Table_nobttomline">  
                <td > </td> 
                <td nowrap colspan="3">  
                    <input type="button" class="btnButton4font" onClick="ok(0,this);" value='<s:text name="comm.saveclose"/>' />
                    <s:if test='#request.action=="add"'>
                    <input type="button" class="btnButton4font" onClick="ok(1,this);" value='<s:text name="comm.savecontinue"/>' />
                    </s:if>
                    <s:else>
                    <input type="button" class="btnButton4font" onClick="cxxx();" value="初选信息" />
                    <input type="button" class="btnButton4font" onClick="zf();" value="转&nbsp;&nbsp;&nbsp;&nbsp;发" />
                    </s:else>
                    <%if(jfLook){%>
                     <input type="button" class="btnButton4font" onClick="xxcy();" value="信息采用" />
			        <%}%>
                    <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
                </td>  
            </tr>
            <%}%>
        </table>
        <s:hidden name="syxxPO.xxid" />
        <s:hidden name="syxxPO.bsrid" />

        <s:hidden name="syxxPO.xxshzt" />
        <s:hidden name="syxxPO.bsdwserver" />
       
	 
		</div>
	</div>
     <input type="hidden" name="BSZDWID1" id="BSZDWID1" value="<s:property value='syxxPO.bszdwid'/>"/>
     <input type="hidden" name="BSZDWMC1" id="BSZDWMC1" value="<s:property value='syxxPO.bszdwmc'/>"/>
     <input type="hidden" name="BSZDWSERVER1" id="BSZDWSERVER1" value="<s:property value='syxxPO.bszdwserver'/>"/>
     </s:form>
</body>
<iframe name="iframe1" style="display:none"></iframe>
<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});


	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
    function zf(){
        var url="${ctx}/wdxx!add.action?xxid=<%=request.getParameter("xxid")%>&zf=zf";
        location_href(url);
    }

function cxxx(){
      var url='<%=rootPath%>/modules/subsidiary/infosend/cxxx.jsp?xxid=<%=request.getParameter("xxid")%>';
    // popup({id:'cxxx',content: 'url:'+url,title:'初选信息',width: '500px',height: '400px',lock: true,resize: false}); 
    openWin({url:url,width:800,height:530,winName:'cxxx'});

}
function xxcy() {

    var url='${ctx}/jfbz!list.action?xxid=<%=request.getParameter("xxid")%>&op=select';
     popup({id:'selcyqk1',content: 'url:'+url,title:'积分标准',width: '500px',height: '400px',lock: true,resize: false}); 
    //openWin({url:val,width:600,height:480,winName:'xxcy'});
  
}
    function choseBsdw(){
        var bsdw =  $("#choseBsdw").val();
        var arr=bsdw.split("_");
        $("#bsdwid").val(arr[0]);
        $("#bsdw").val(arr[1]);
    }
    function resetOrg(){
         $("#bszdwid").val('');
         $("#bszdwmc").val('');
         $("#bszdwserver").val('');
         document.cookie = "BSZDWMC=";

         $("#BSZDWMC1").val('');
         $("#BSZDWID1").val('');
         $("#BSZDWSERVER1").val('');
    }
    function ckbsz() {
	var resimName=$("#bsrxm").val();//抱送人姓名
    var ids=$("#BSZDWID1").val();//已经选择的单位的id
    var val='<%=rootPath%>/modules/subsidiary/infosend/seldw.jsp?resimName='+resimName+'&dwjb=<%=request.getAttribute("dwjb")==null?"":request.getAttribute("dwjb").toString()%>&ids='+ids;
    openWin({url:val,width:300,height:550,winName:'seldw'});
}
/**
 * 新增或修改页面点击保存退出或保存继续按钮触发的事件.
 * @param n   0:保存退出；1:保存继续.
 * @param obj 保存按钮的dom对象.
 */
function ok22(n,obj){ 
   // alert("1");
    choseBsdw();
	var formId = $(obj).parents("form").attr("id");
	var validation = validateForm(formId);
	$(obj).parents("form").find("#saveType").val(n);
	if(validation){
		$('#'+formId).submit();
	}			
}
	
</script>

</html>

