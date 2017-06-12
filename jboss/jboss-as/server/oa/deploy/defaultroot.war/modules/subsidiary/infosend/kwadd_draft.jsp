<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Calendar now = java.util.Calendar.getInstance();
String noWriteField = new com.whir.ezoffice.workflow.newBD.WorkFlowCommonBD().getNoWriteField(request.getParameter("processId"));
boolean readonly = false;
String  draftParm=request.getParameter("selProcess")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"selProcess");
String userId = session.getAttribute("userId")==null?"":session.getAttribute("userId").toString();
String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
String orgIdString = session.getAttribute("orgIdString")==null?"":session.getAttribute("orgIdString").toString();
String domainId = session.getAttribute("domainId").toString();
com.whir.govezoffice.documentmanager.bd.SenddocumentBD bd = new com.whir.govezoffice.documentmanager.bd.SenddocumentBD();
List list1 = bd.getTemplateList_Common(userId, orgId, orgIdString, "xxbs", domainId);
List list =null;
list= (List) request.getAttribute("templateList");
com.whir.ezoffice.infosend.po.KwPO kwPO = null;

if(request.getAttribute("kwPO") != null ) {
	kwPO=(com.whir.ezoffice.infosend.po.KwPO)request.getAttribute("kwPO");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>刊物审核</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base_head.jsp"%>
    <%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<%@ include file="/public/include/meta_base_bpm.jsp"%>
    <SCRIPT LANGUAGE="JavaScript">
    <!--
       
         function cmdSaveDraft(){
            //设置表单为异步提交
	        initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存草稿'});
            var validation = validateForm("dataForm");
            $("#dataForm").find("#saveType").val(0);
            if(validation){
                 if(initPara()){
                    dataForm.action = "${ctx}/kw!draft.action";
                    $('#dataForm').submit();
                 }
            }		
        }
    //-->
    </SCRIPT>
    <style TYPE="text/css">
<!--
#receiveForm{
  background-color:#000000;
}
.receiveForm td{
  font-size:12px;
  background-color:#ffffff;
}
.doc_Content{ padding:20px 0px;}
.doc_Content td{ padding:5px;}
//-->
</style>
</head>
<body  onload="initBody();" scroll=no class="docBodyStyle">
    <!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
     <div class="doc_Scroll">
    <s:form name="dataForm" id="dataForm" action="${ctx}/kw!save.action" method="post" theme="simple" >
     <s:hidden name="kwPO.kwid" id="kwid"/>
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline">
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> 
							   <li id="Panle2" ><a href="javascript:void(0);" onClick="changePanle(2);">相关流程</a></li> 
						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <div id="docinfo0" class="doc_Content">
							<!--表单包含页-->
                                <table width="100%" cellpadding="10" CELLSPACING="1" ID="receiveForm" class="receiveForm" align="center" class="Table_bottomline">
                                    <tr>
                                        <td for="刊物种类" width="10%" height="30" nowrap="nowrap" align="center" class="td_lefttitle">刊物种类：</td>
                                        <td width="55%" >
                                            <select name="_kwzl" id="_kwzl" class="easyui-combobox" style="width:150px"  data-options="panelHeight:200,forceSelection:true,onSelect: function(record){chKWZL(record);}">
                                            <%
											String kwkindid=kwPO.getKwkindid()+"";
											if(list!=null&&list.size()>0){
												for(int i=0; i<list.size(); i++){
												Object[] obj = (Object[])list.get(i);
												boolean fl=(kwkindid.equals(obj[0].toString()));
                                            %>
                                            <option value="<%=obj[0]+"_"+obj[2]+"_"+obj[3]%>" <%=fl?"selected":""%>><%=obj[1]%></option>
                                            <%}}%>
                                            </select>
											<s:hidden name="kwPO.kwzl" id="kwzl"/>
											<s:hidden name="kwPO.kwkindid" id="kwkindid"/>
											<s:hidden name="kwPO.kwkind" id="kwkind"/>
                                            <s:hidden name="kwPO.kwzlmc" id="kwzlmc"/>
                                             <s:hidden name="kwPO.processParameter" id="processParameter"/>
                                           <!--  <input type="hidden" name="kwPO.processParameter" id="processParameter" value="<%=draftParm%>"/> -->
                                        </td>
                                        <td for="刊物期数"width="10%" nowrap="nowrap" align="center" class="td_lefttitle">刊物期数：</td>
                                        <td width="25%">
                                            <%
                                            readonly = true;
                                            String defaultKWQS = request.getAttribute("defaultKWQS")==null?"1":""+request.getAttribute("defaultKWQS")+"";
                                            if(noWriteField.indexOf("$KWQS$") >= 0) readonly=true;%>
                                            
                                            第<s:textfield name="kwPO.kwqs" id="kwqs" cssClass="inputText" whir-options="vtype:[{'maxLength':10},'spechar3']" cssStyle="width:20%" maxlength="10"/>期
                                            <input type="hidden" name="defaultKWQS" id="defaultKWQS" value="<%=request.getAttribute("defaultKWQS")==null?"1":request.getAttribute("defaultKWQS").toString()%>">

                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="刊物密级" height="30" nowrap="nowrap" align="center" class="td_lefttitle">刊物密级：</td>
                                        <td>
                                            <%
                                            readonly = false;
                                            if(noWriteField.indexOf("$KWMJ$") >= 0) readonly=true;
                                            if(readonly){
                                            %>
                                            <s:textfield name="kwPO.kwmj" id="kwmj" cssClass="inputText" whir-options="vtype:[{'maxLength':15},'spechar3']" readonly="true" cssStyle="width:90%" maxlength="15"/>
                                            <%}else{%>
                                              <s:textfield name="kwPO.kwmj" id="kwmj" cssClass="inputText" whir-options="vtype:[{'maxLength':15},'spechar3']" cssStyle="width:90%" maxlength="15"/>
                                            <%}%>
                                        </td>
                                        <td  for="总期数"nowrap="nowrap" align="center" class="td_lefttitle">总期数：</td>
                                        <td>
                                            <%
                                                readonly = false;
                                            if(noWriteField.indexOf("$ZQS$") >= 0) readonly=true;
                                             if(readonly){
                                            %>
                                            <s:textfield name="kwPO.zqs" id="zqs" cssClass="inputText" whir-options="vtype:[{'maxLength':25},'spechar3']" readonly="true" cssStyle="width:90%" maxlength="25"/>
                                             <%}else{%>
                                                 <s:textfield name="kwPO.zqs" id="zqs" cssClass="inputText" whir-options="vtype:[{'maxLength':25},'spechar3']" cssStyle="width:90%" maxlength="25"/>
                                             <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="副标题"height="30" nowrap="nowrap" align="center" class="td_lefttitle">副标题 <span class="MustFillColor">*</span>：</td>
                                        <td colspan="3">
                                            <%
                                                readonly = false;
                                            if(noWriteField.indexOf("$FBT$") >= 0) readonly=true;
                                             if(readonly){
                                            %>
                                            <s:textfield name="kwPO.fbt" id="fbt" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':65},'spechar3']" readonly="true" cssStyle="width:97%" maxlength="65"/>
                                            <%}else{%>
                                                 <s:textfield name="kwPO.fbt" id="fbt" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':65},'spechar3']" cssStyle="width:97%" maxlength="65"/>
                                             <%}%>
                                             
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="发布单位"height="30" nowrap="nowrap" align="center" class="td_lefttitle">发布单位：</td>
                                        <td>
                                            <%
                                                readonly = false;
                                            if(noWriteField.indexOf("$FBDW$") >= 0) readonly=true;
                                            if(readonly){
                                            %>
                                            <s:textfield name="kwPO.fbdw" id="fbdw" cssClass="inputText" whir-options="vtype:[{'maxLength':50},'spechar3']" readonly="true" cssStyle="width:90%" maxlength="50"/>
                                            <%}else{%>
                                                  <s:textfield name="kwPO.fbdw" id="fbdw" cssClass="inputText" whir-options="vtype:[{'maxLength':50},'spechar3']"  cssStyle="width:90%" maxlength="50"/>
                                             <%}%>
                                        </td>
                                        </td>
                                        <td for="发布日期" nowrap="nowrap" align="center" class="td_lefttitle">发布日期：</td>
                                        <td>
                                            <s:textfield id="fbrq" name="kwPO.fbrq"  cssClass="Wdate whir_datebox" onfocus="WdatePicker({el:'fbrq',isShowWeek:true})" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="报"height="30" nowrap="nowrap" align="center" class="td_lefttitle">报：</td>
                                        <td colspan="3">
                                            <%
                                                readonly = false;
                                            if(noWriteField.indexOf("$KWB$") >= 0) readonly=true;
                                            if(readonly){
                                            %>
                                            <s:textfield name="kwPO.kwb" id="kwb" cssClass="inputText" whir-options="vtype:[{'maxLength':65},'spechar3']" readonly="true" cssStyle="width:97%" maxlength="65"/>
                                            <%}else{%>
                                                   <s:textfield name="kwPO.kwb" id="kwb" cssClass="inputText" whir-options="vtype:[{'maxLength':65},'spechar3']"  cssStyle="width:97%" maxlength="65"/>
                                             <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="送"height="30" nowrap="nowrap" align="center" class="td_lefttitle">送：</td>
                                        <td colspan="3">
                                            <%
                                                readonly = false;
                                            if(noWriteField.indexOf("$KWS$") >= 0) readonly=true;
                                            if(readonly){
                                            %>
                                            <s:textfield name="kwPO.kws" id="kws" cssClass="inputText" whir-options="vtype:[{'maxLength':65},'spechar3']" readonly="true" cssStyle="width:97%" maxlength="65"/>
                                            <%}else{%>
                                                 <s:textfield name="kwPO.kws" id="kws" cssClass="inputText" whir-options="vtype:[{'maxLength':65},'spechar3']" cssStyle="width:97%" maxlength="65"/>
                                             <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="发/抄"height="30" nowrap="nowrap" align="center" class="td_lefttitle">发/抄：</td>
                                        <td colspan="3">
                                            <%
                                                readonly = false;
                                            if(noWriteField.indexOf("$KWFC$") >= 0) readonly=true;
                                            if(readonly){
                                            %>
                                            <s:textfield name="kwPO.kwfc" id="kwfc" cssClass="inputText" whir-options="vtype:[{'maxLength':65},'spechar3']" readonly="true" cssStyle="width:97%" maxlength="65"/>
                                            <%}else{%>
                                                 <s:textfield name="kwPO.kwfc" id="kwfc" cssClass="inputText" whir-options="vtype:[{'maxLength':65},'spechar3']" cssStyle="width:97%" maxlength="65"/>
                                             <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="印发份数"height="30" nowrap="nowrap" align="center" class="td_lefttitle">印发份数：</td>
                                        <td colspan="3">
                                            <%
                                                readonly = false;
                                            if(noWriteField.indexOf("$YFFS$") >= 0) readonly=true;
                                            if(readonly){
                                            %>
                                            <s:textfield name="kwPO.yffs" id="yffs" cssClass="inputText" whir-options="vtype:[{'maxLength':6},'spechar3']" readonly="true" cssStyle="width:97%" maxlength="6"/>
                                            <%}else{%>
                                                 <s:textfield name="kwPO.yffs" id="yffs" cssClass="inputText" whir-options="vtype:[{'maxLength':6},'spechar3']"  cssStyle="width:97%"
                                                 maxlength="6"/>
                                             <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="30" nowrap="nowrap" align="center">初选信息：</td>
                                        <td colspan="3">
                                            <%readonly = false;
                                            if(noWriteField.indexOf("$CXXX$") >= 0) readonly=true;
                                            if(!readonly) {
                                            %>
                                            <%}%>
                                            <table width="100%" id="xxtab">
                                                <tr>
                                                    <td>
                                                    <input type="button" class="btnButton4font" value="添加" onclick="addxx();" />
                                                    </td>
                                                </tr>
                                                <%
                                                if(request.getAttribute("xxList") != null) {
                                                  List xxList = (List) request.getAttribute("xxList");
                                                  Object[] obj;
                                                  for(int i = 0; i < xxList.size(); i ++) {
                                                    obj = (Object[]) xxList.get(i);
                                                    %>
                                                    <tr>
                                                      <td>
                                                        <input type="hidden" name="xxid" value="<%=obj[0]%>">
                                                        <a href="javascript:" onClick="openWin({url:'<%=rootPath%>/syxx!load.action?xxid=<%=obj[0]%>&readonly=1&verifyCode=SyxxAction',width:850,height:750,winName:'viewSyxx'});"><%=obj[1]%></a>&nbsp;<img src="<%=rootPath%>/images/del.gif" style="cursor:hand" onclick="delxx(this)">
                                                      </td>
                                                    </tr>
                                                    <%
                                                  }
                                                }
                                                %>
                                            </table>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="30" nowrap="nowrap" align="center">刊物正文：</td>
                                        <td colspan="3">
                                            <%readonly = false;
                                            if(noWriteField.indexOf("$KWZW$") >= 0) readonly=true;
                                            if(!readonly) {
                                            %>
                                            <input type="button" class="btnButton4font" value="编辑正文" onclick="bjzw();" />
                                            <%}%>
                                            <s:hidden name="kwPO.kwzw" id="kwzw" />
                                        </td>
                                    </tr>
                                    
                                </table>
								  
								
							<!--工作流包含页-->
							 <div>  
								  <%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
						    </div>
				      </div>
					 <div id="docinfo1" class="doc_Content"  style="display:none;">111</div>
					 <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
                 </div>
             </td>
         </tr>
     </table>
      <!-- <input type="button" class="btnButton4font" onClick="ok2(0,this);" value="保存退出" /> -->
     </s:form>
	</div>
    <div class="docbody_margin"></div>
	<%@ include file="/platform/bpm/work_flow/operate/wf_include_form_end.jsp"%>
<form name="form1" id="form1" method="POST" action="<%=rootPath%>/public/iWebOfficeSign/DocumentEdit.jsp">
  <input type="hidden" name="RecordID" id="RecordID">
  <input type="hidden" name="EditType"  id="EditType"value="1">
  <input type="hidden" name="UserName" id="UserName" value="<%=session.getAttribute("userName")%>">
  <input type="hidden" name="CanSave" id="CanSave" value="1">
  <input type="hidden" name="showTempSign" id="showTempSign" value="1">
  <input type="hidden" name="showTempHead" id="showTempHead" value="1">
  <input type="hidden" name="ShowSign" id="ShowSign" value="0">
  <input type="hidden" name="showSignButton" id="showSignButton" value="1">
  <input type="hidden" name="showEditButton" id="showEditButton" value="1">
  <input type="hidden" name="saveDocFile" id="saveDocFile" value="1">
  <input type="hidden" name="moduleType"  id="moduleType"value="infosend">
  <input type="hidden" name="Template" id="Template">
  <input type="hidden" name="FileType" id="FileType" value=".doc">
  <input type="hidden" name="loadTemp"  id="loadTemp"value="1">
  <input type="hidden" name="textContent" id="textContent" value="-1">
  <input type="hidden" name="content" id="content">
  <%//标签%>
  <input type="hidden" name="$KWQS" id="$KWQS" value="-1">
  <input type="hidden" name="$FBDW" id="$FBDW" value="-1">
  <input type="hidden" name="$FBRQ"  id="$FBRQ"value="-1">
  <input type="hidden" name="$KWS" id="$KWS"value="-1">
  <input type="hidden" name="$KWB" id="$KWB" value="-1">
  <input type="hidden" name="$KWFC" id="$KWFC"  value="-1">
  <input type="hidden" name="$KWMJ" id="$KWMJ" value="-1">
  <input type="hidden" name="$ZQS"   id="$ZQS"value="-1">
  <input type="hidden" name="$FBT"   id="$FBT" value="-1">
  <input type="hidden" name="$YFFS"   id="$YFFS"value="-1">
  <input type="hidden" name="$ZWNR" id="$ZWNR" value="-1">

</form>
</body>
<iframe name="iframe1"id="iframe1" style="display:none"></iframe>
<iframe name="iframe2" id="iframe2" style="display:none"></iframe>
<script type="text/javascript">
var screenwidth;//分辨率宽度
var screenheight;//分辨率高度
    screenwidth = screen.availWidth-5;
    screenheight = screen.availHeight-18;

/**
 切换页面
 */
function  changePanle(flag){
	for(var i=0;i<3;i++){
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
	   showWorkFlowRelation("docinfo2");
	}
}

/**
初始话信息
*/
function initBody(){
	//初始话信息
    ezFlowinit();
    windowWidth = window.screen.availWidth;
	windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
	window.resizeTo(windowWidth,windowHeight);
    $("#fbrq").val('<%=sf.format(now.getTime())%>');
	var val = whirCombobox.getValue("_kwzl");
	val=val.split("_")[1];
    //document.getElementById("content").value=val;
    //getCXXX(val);
    //getBH(val);
}
function chKWZL() {
	var val = whirCombobox.getValue("_kwzl");
	val=val.split("_")[1];
	getCXXX(val);
	getBH(val);
}
function getCXXX(templateId) {
	document.getElementById("iframe1").src = "<%=rootPath%>/modules/subsidiary/infosend/getcxxx.jsp?templateid=" + templateId;
}
function getBH(templateId) {
	document.getElementById("iframe2").src = "<%=rootPath%>/modules/subsidiary/infosend/getbh.jsp?templateid=" + templateId;
}

function bjzw() {
	var val = whirCombobox.getValue("_kwzl");
	val=val.split("_")[1];
	document.getElementById("Template").value = val;
	document.getElementById("$KWQS").value = "[刊物期数]" + document.getElementById("kwqs").value;
	document.getElementById("$FBDW").value = "[发布单位]" + document.getElementById("fbdw").value;
	var fbrq = document.getElementById("fbrq").value.split("-");
	document.getElementById("$FBRQ").value = "[发布日期]" + fbrq[0] + "年" + fbrq[1] + "月" + fbrq[2] + "日";
	document.getElementById("$KWS").value = "[送]" + document.getElementById("kws").value;
	document.getElementById("$KWB").value = "[报]" + document.getElementById("kwb").value;
	document.getElementById("$KWFC").value = "[发抄]" + document.getElementById("kwfc").value;
	document.getElementById("$KWMJ").value = "[刊物密级]" + document.getElementById("kwmj").value;
	document.getElementById("$ZQS").value = "[总期数]" + document.getElementById("zqs").value;
	document.getElementById("$FBT").value = "[副标题]" + document.getElementById("fbt").value;
	document.getElementById("$YFFS").value = "[印发份数]" + document.getElementById("yffs").value;
	
	form1.RecordID.value = document.getElementById("content").value;
	var xxid = document.getElementsByName("xxid");
	var tmp = "";
	for(var i = 0; i < xxid.length; i ++) {
		tmp += xxid[i].value + ",";
	}
	document.getElementById("iframe1").src = "<%=rootPath%>/modules/subsidiary/infosend/bjzw.jsp?xxid=" + tmp;
}
function delxx(obj) {
	$(obj).parent("td").parent("tr").remove();
}

function addxx() {
	var val='<%=rootPath%>/syxx!list.action?op=select';
	openWin({url:val,width:780,height:590,winName:'selectxx'});
}
function ok2(n,obj){ 
	var formId = $(obj).parents("form").attr("id");
	var validation = validateForm(formId);
	if(validation){
		if(beforeSubmit()){
			$('#'+formId).submit();
		}
	}
}
function initPara() {
    var validation = validateForm("dataForm");
	if($('#kwzw').val() !=null && $('#kwzw').val() !='null'){
		document.getElementById("content").value =$('#kwzw').val();
	}
    if(validation){
        var content = document.getElementById("content").value;
        if(content==''){
            whir_alert("您还没有编辑正文！",null,null);
            return false;
        }
       
        var val = whirCombobox.getValue("_kwzl");
		if(val != null && val !='' && val !='null'){
			$("#kwzl").val(val.split("_")[1]);
			$("#kwkindid").val(val.split("_")[0]);
			$("#kwzlmc").val(val.split("_")[2]);
			var kwkind=whirCombobox.getText("_kwzl");
			$("#kwkind").val(kwkind);
			$("#kwzw").val( $("#content").val());
			return true;
		}else{
			whir_alert("刊物种类为空，不可发送！",null,null);
			return false;
		}
    }
	return false;
}
</script>
</html>