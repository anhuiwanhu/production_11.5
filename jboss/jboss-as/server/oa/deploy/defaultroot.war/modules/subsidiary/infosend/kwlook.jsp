<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>

<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String curModifyField=request.getAttribute("p_wf_cur_ModifyField")==null?"":request.getAttribute("p_wf_cur_ModifyField").toString();
//String curModifyField="";
List list =(List)request.getAttribute("templateList");
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
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline">
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> 
                              <li id="Panle2" ><a href="javascript:void(0);" onClick="changePanle(2);">流程记录</a></li>
							  <li id="Panle3" ><a href="javascript:void(0);" onClick="changePanle(3);">相关流程<span class="redBold" id="viewrelationnum"></span></a></li>
                              <li id="Panle4" ><a href="javascript:void(0);" onClick="changePanle(4);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <div id="docinfo0" class="doc_Content">
							<!--表单包含页-->
                                <table width="100%" cellpadding="10" CELLSPACING="1" ID="receiveForm" class="receiveForm" align="center" class="Table_bottomline">
                                    <tr>
                                        <td for="刊物种类" width="10%" height="30" nowrap="nowrap" align="center" class="td_lefttitle">刊物种类：</td>
                                        <td width="55%" >
                                            <%if(curModifyField.indexOf("$KWZL$") >= 0){%>
                                            <select name="_kwzl" id="_kwzl"class="easyui-combobox" style="width:150px"  data-options="panelHeight:'auto',onSelect: function(record){chKWZL(record);}">
                                            <%
                                            if(list!=null&&list.size()>0){
                                            for(int i=0; i<list.size(); i++){
                                            Object[] obj = (Object[])list.get(i);
                                            %>
                                            <option value="<%=obj[0]+"_"+obj[2]+"_"+obj[3]%>"><%=obj[1]%></option>
                                            <%}}%>
                                            </select>
                                            <%} else {%>
                                                <s:property value="kwPO.kwkind" escape="false"/>
           
                                            <%}%>
                                            <s:hidden name="kwPO.kwzlmc" id="kwzlmc"/>
											<s:hidden name="kwPO.kwzl" id="kwzl"/>
											<s:hidden name="kwPO.kwkindid" id="kwkindid"/>
											<s:hidden name="kwPO.kwkind" id="kwkind"/>
                                        </td>
                                        <td for="刊物期数"width="10%" nowrap="nowrap" align="center" class="td_lefttitle">刊物期数：</td>
                                        <td width="25%">第
                                            <%if(curModifyField.indexOf("$kwPO.kwqs$") >= 0){%>
                                            <s:textfield name="kwPO.kwqs" id="kwqs" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]" cssStyle="width:20%" maxlength="10"/>
                                            <%} else {%>
                                            <s:property value="kwPO.kwqs" escape="false"/>
                                            <s:hidden name="kwPO.kwqs" id="kwqs"/>
                                            <%}%>期
                                            <s:hidden name="kwPO.kwid" id="kwid"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="刊物密级" height="30" nowrap="nowrap" align="center" class="td_lefttitle">刊物密级：</td>
                                        <td>
                                               <%if(curModifyField.indexOf("$kwPO.kwmj$") >= 0){%>
                                              <s:textfield name="kwPO.kwmj" id="kwmj" cssClass="inputText" whir-options="vtype:[{'maxLength':15}]" cssStyle="width:90%" maxlength="15"/>
                                               <%} else {%>
                                               <s:property value="kwPO.kwmj" escape="false"/>
                                               <s:hidden name="kwPO.kwmj" id="kwmj"/>
                                               <%}%>
                                        </td>
                                        <td  for="总期数"nowrap="nowrap" align="center" class="td_lefttitle">总期数：</td>
                                        <td>
                                            <%if(curModifyField.indexOf("$kwPO.zqs$") >= 0){%>
                                             <s:textfield name="kwPO.zqs" id="zqs" cssClass="inputText" whir-options="vtype:[{'maxLength':25}]" cssStyle="width:90%" maxlength="25"/>
                                            <%} else {%>
                                               <s:property value="kwPO.zqs" escape="false"/>
                                               <s:hidden name="kwPO.zqs" id="zqs"/>
                                              <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="副标题"height="30" nowrap="nowrap" align="center" class="td_lefttitle">副标题 <span class="MustFillColor">*</span>：</td>
                                        <td colspan="3">
                                            <%if(curModifyField.indexOf("$kwPO.fbt$") >= 0){%>
                                                 <s:textfield name="kwPO.fbt" id="fbt" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':65}],'promptText':'请输入标题'" cssStyle="width:97%" maxlength="65"/>
                                              <%} else {%>
                                              <s:property value="kwPO.fbt" escape="false"/>
                                               <s:hidden name="kwPO.fbt" id="fbt"/>
                                              <%}%>
                                             
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="发布单位"height="30" nowrap="nowrap" align="center" class="td_lefttitle">发布单位：</td>
                                        <td>
                                             <%if(curModifyField.indexOf("$kwPO.fbdw$") >= 0){%>
                                                  <s:textfield name="kwPO.fbdw" id="fbdw" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]"  cssStyle="width:90%" maxlength="50"/>
                                             <%} else {%>
                                              <s:property value="kwPO.fbdw" escape="false"/>
                                               <s:hidden name="kwPO.fbdw" id="fbdw"/>
                                              <%}%>
                                        </td>
                                        </td>
                                        <td for="发布日期" nowrap="nowrap" align="center" class="td_lefttitle">发布日期：</td>
                                        <td>
                                            <%if(curModifyField.indexOf("$kwPO.fbrq$") >= 0){%>
                                            <s:textfield id="fbrq" name="kwPO.fbrq"  cssClass="Wdate whir_datebox" onfocus="WdatePicker({el:'fbrq',isShowWeek:true})" >
                                              <s:param name="value"><s:date name="kwPO.fbrq" format="yyyy-MM-dd"/></s:param>
                                            </s:textfield>
                                            <%} else {%>
                                              <s:date name="kwPO.fbrq" format="yyyy-MM-dd"/>
                                                <input type="hidden" name="kwPO.fbrq" id="fbrq" value='<s:date name="kwPO.fbrq" format="yyyy-MM-dd"/>'>
                                               <input type="hidden" name="kwPO.processParameter" id="processParameter" value='<s:property value="kwPO.processParameter" escape="false"/>'>
                                              <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="报"height="30" nowrap="nowrap" align="center" class="td_lefttitle">报：</td>
                                        <td colspan="3">
                                           <%if(curModifyField.indexOf("$kwPO.kwb$") >= 0){%>
                                                <s:textfield name="kwPO.kwb" id="kwb" cssClass="inputText" whir-options="vtype:[{'maxLength':65}]"  cssStyle="width:97%" maxlength="65"/>
                                              <%} else {%>
                                              <s:property value="kwPO.kwb" escape="false"/>
                                               <s:hidden name="kwPO.kwb" id="kwb"/>
                                              <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="送"height="30" nowrap="nowrap" align="center" class="td_lefttitle">送：</td>
                                        <td colspan="3">
                                           <%if(curModifyField.indexOf("$kwPO.kws$") >= 0){%>
                                                 <s:textfield name="kwPO.kws" id="kws" cssClass="inputText" whir-options="vtype:[{'maxLength':65}]" cssStyle="width:97%" maxlength="65"/>
                                             <%} else {%>
                                              <s:property value="kwPO.kws" escape="false"/>
                                               <s:hidden name="kwPO.kws" id="kws"/>
                                              <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="发/抄"height="30" nowrap="nowrap" align="center" class="td_lefttitle">发/抄：</td>
                                        <td colspan="3">
                                           <%if(curModifyField.indexOf("$kwPO.kwfc$") >= 0){%>
                                                 <s:textfield name="kwPO.kwfc" id="kwfc" cssClass="inputText" whir-options="vtype:[{'maxLength':65}]" cssStyle="width:97%" maxlength="65"/>
                                             <%} else {%>
                                              <s:property value="kwPO.kwfc" escape="false"/>
                                               <s:hidden name="kwPO.kwfc" id="kwfc"/>
                                              <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="印发份数"height="30" nowrap="nowrap" align="center" class="td_lefttitle">印发份数：</td>
                                        <td colspan="3">
                                           <%if(curModifyField.indexOf("$kwPO.yffs$") >= 0){%>
                                                 <s:textfield name="kwPO.yffs" id="yffs" cssClass="inputText" whir-options="vtype:[{'maxLength':6}]"  cssStyle="width:97%" maxlength="6"/>
                                             <%} else {%>
                                              <s:property value="kwPO.yffs" escape="false"/>
                                               <s:hidden name="kwPO.yffs" id="yffs"/>
                                              <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="30" nowrap="nowrap" align="center">初选信息：</td>
                                        <td colspan="3">
                                            <table width="100%" id="xxtab">
                                                <%if(curModifyField.indexOf("$kwPO.kwzw$") >= 0){%>
                                                <tr>
                                                    <td>
                                                    <input type="button" class="btnButton4font" value="添加" onclick="addxx();" />
                                                    </td>
                                                </tr>
                                                <%}%>
                                                
                                                 <%
                                                if(request.getAttribute("xxList") != null) {
                                                  List xxList = (List) request.getAttribute("xxList");
                                                  Object[] obj;
                                                  for(int i = 0; i < xxList.size(); i ++) {
                                                    obj = (Object[]) xxList.get(i);
                                                    %>
                                                    <tr>
                                                      <td>
                                                        <input type="checkbox" name="xxid" value="<%=obj[0]%>" disabled="disabled">
                                                        <a href="javascript:" onClick="openWin({url:'<%=rootPath%>/syxx!load.action?xxid=<%=obj[0]%>&readonly=1&verifyCode=SyxxAction',width:850,height:750,winName:'viewSyxx'});"><%=obj[1]%></a>
                                                        <input type="hidden" name="xxid" value="<%=obj[0]%>">
                                                        <%if(curModifyField.indexOf("$kwPO.kwzw$") >= 0){%>
                                                        <img src="<%=rootPath%>/images/del.gif" style="cursor:hand" onClick="delxx(this);">
                                                        <%}%>
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
                                            <input type="button" class="btnButton4font" value="查看正文" onclick="bjzw('look');" />
                                            <s:hidden name="kwPO.kwzw" id="kwzw"/>
                                        </td>
                                    </tr>
                                    
                                </table>
                                 <%if(request.getParameter("ttt") != null) {%>
                                <table width="100%">
                                    <tr>
                                        <td>
                                        <input type="button" class="btnButton4font" value="退出" onclick="window.close();" />
                                        </td>
                                    </tr>
                                </table>
								<%}%>
							<!--工作流包含页-->
							 <div>  
								  <%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
						    </div>
							 <!--批示意见包含页-->
							<div>
								  <%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>
							</div>
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
  <input type="hidden" name="loadTemp"  id="loadTemp"value="0">
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
<script type="text/javascript">
    var screenwidth;//分辨率宽度
    var screenheight;//分辨率高度
    screenwidth = screen.availWidth-5;
    screenheight = screen.availHeight-18;

/**
 切换页面
 */
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
     $("#content").val($("#kwzw").val());
}
function bjzw(type) {
	var kwid=$("#kwid").val();
    form1.RecordID.value = $("#content").val();
    if(type == "edit") {
        $("#showEditButton").val("1");
        $("#CanSave").val("1");
    } else {
        $("#showEditButton").val("0");
        $("#CanSave").val("0");
    }
    document.getElementById("iframe1").src = "<%=rootPath%>/modules/subsidiary/infosend/ckzw.jsp?kwid=" + kwid;
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
    if(validation){
        var obj = document.getElementById("_kwzl");
        if(obj.tagName == "SELECT") {
            var val=$("#_kwzl").val();
			$("#kwzl").val(val.split("_")[1]);
			$("#kwkindid").val(val.split("_")[0]);
			$("#kwzlmc").val(val.split("_")[2]);
            var kwkind=$('#kwzl option[value='+val+']').text();
            $("#kwkind").val(kwkind);
            return true;
        }
    }
	return false;
}

</script>
</html>

