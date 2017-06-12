<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
    com.whir.ezoffice.boardroom.po.BoardRoomPO boardRoomPO=null;
    if(request.getAttribute("boardRoomPO")!=null){
	    boardRoomPO=(com.whir.ezoffice.boardroom.po.BoardRoomPO)request.getAttribute("boardRoomPO");
    }
    String boardroomId="";
    if(boardRoomPO !=null){
	    boardroomId=boardRoomPO.getBoardroomId().toString();
    }
     String defaultProcessId="";
    if(boardRoomPO !=null){
		if(boardRoomPO.getDefaultProcessId()!= null && !boardRoomPO.getDefaultProcessId().equals("null")){
			defaultProcessId=boardRoomPO.getDefaultProcessId().toString();
		}
    }
    String depict="";
    if(boardRoomPO !=null){
	    depict=boardRoomPO.getDepict();
    }
    if(depict==null){
        depict="";
    }
	if(depict != null && !depict.equals("") && !depict.equals("null")){
		depict=depict.replaceAll("\n","");
	}
	if(depict == null || depict.equals("null")){
		depict="";
	}
    String isVideo="";
    if(boardRoomPO !=null){
	    isVideo=boardRoomPO.getIsVideo().toString();
    } 
    
    String action="";
    if(request.getAttribute("action")!=null){
	    action=request.getAttribute("action").toString();
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:if test='#request.action == "add"'>新会议室</s:if><s:else>修改会议室</s:else> 
</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="Pupwin">
	<div class="BodyMargin_10" >  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="${ctx}/boardRoom!addBoardroom.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
        <s:hidden name="boardRoomPO.boardroomId" />
        <input type="hidden" name="type" value="<%=action%>">
        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr>  
                <td for="名称"  class="td_lefttitle">  
                    名称<span class="MustFillColor">*</span>：  
                </td>  
                <td colspan="3">  
                    <s:textfield name="boardRoomPO.name" id="name" cssClass="inputText" cssStyle="width:96.8%;" whir-options="vtype:['notempty',{'maxLength':30},'spechar3']"  maxlength="30"/>  
                </td>  
            </tr>  
            <tr>  
                <td for="描述" class="td_lefttitle">  
                    描述：  
                </td>  
                <td colspan="3">  
                   &nbsp;
                </td>  
            </tr>
            <tr>  
                <td colspan="4">  
                    <div style="display:none">
                        <s:textarea name="boardRoomPO.depict" id="depict"    cssClass="inputTextarea" cssStyle="width:80%;"/>
                    </div>
                    <div id="gnomeHtml">
                        <input type="hidden" name="content" id="content"/>
                        <iframe id="mailcontentHtml" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=content&style=coolblue&lang=<%=whir_locale%>" frameborder="0" scrolling="no" width="97%" height="350"></iframe>
                    </div>
                </td>  
            </tr>
            <tr>  
                <td for="位置" class="td_lefttitle" >  
                    位置<span class="MustFillColor">*</span>：  
                </td>  
                <td style="width:42%;">  
                    <s:textfield name="boardRoomPO.location" id="location" cssStyle="width:93%;" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':50}]"  maxlength="50"/>
                </td>  
                 <td for="容纳人数" class="td_lefttitle" >  
                    容纳人数：  
                </td>  
                <td style="width:42%;">  
                    <s:textfield name="boardRoomPO.capacitance" id="capacitance" cssStyle="width:93%;" cssClass="inputText" whir-options="vtype:['p_integer_e',{'maxLength':10}]"  maxlength="10"/>
                </td>  
            </tr>
             <tr>  
                <td for="办公地点" class="td_lefttitle">  
                    办公地点：  
                </td>  
                <td colspan="3">  
                    <s:textfield name="boardRoomPO.workaddress" id="workaddress" cssClass="inputText" whir-options="vtype:[{'maxLength':30}]"  maxlength="30" cssStyle="width:96.8%;"/>  
                </td>  
            </tr> 
            <tr>  
                <td for="类型" class="td_lefttitle" >  
                    类型：  
                </td>  
                <td>  
                     <s:if test='#request.action == "add"'>
                    <s:radio name="boardRoomPO.boardroomType" list="%{#{'0':'小型','1':'中型','2':'大型'}}" value="0" theme="simple"></s:radio>
                     </s:if>
                    <s:else>
                    <s:radio name="boardRoomPO.boardroomType" list="%{#{'0':'小型','1':'中型','2':'大型'}}" theme="simple"></s:radio>
                    </s:else>
                </td>  
                 <td for="管理部门" class="td_lefttitle" >  
                    管理部门：  
                </td>  
                <td>  
                    <s:textfield name="boardRoomPO.manageOrgName" id="manageOrgName" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]"  cssStyle="width:93%;" maxlength="100" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'manageOrg', allowName:'manageOrgName', select:'org', single:'yes', show:'org', range:'*0*'});"></a>
                    
                    <s:hidden name="boardRoomPO.manageOrg" id="manageOrg"/>
                </td>  
            </tr>
            <tr>  
                <td for="适用范围" class="td_lefttitle">  
                    适用范围：  
                </td>  
                <td colspan="3">  
                     <s:textarea name="principalName" id="principalName"    cssClass="inputTextarea" cssStyle="width:96.8%;"  readonly="true"/><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'principal', allowName:'principalName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"></a>
                     <div><label class="MustFillColor">“适用范围”为空时默认为所有用户。</label></div>
                    <s:hidden name="principal" id="principal"/> 
                </td>  
            </tr>
             <tr>  
                <td for="类型" class="td_lefttitle" >  
                    类型：  
                </td>  
                <td colspan="3">  
                     <s:if test='#request.action == "add"'>
                    <s:radio name="boardRoomPO.isVideo" list="%{#{'0':'普通会议室','2':'临时会议室','1':'视频会议室'}}" value="0" theme="simple"></s:radio>
                    <span id="maxNumberTr" style="display:none" nowrap>
                    最大点数： <s:textfield name="boardRoomPO.maxNumber" id="maxNumber" cssClass="inputText" whir-options="vtype:['p_integer_e',{'maxLength':6}]"  maxlength="6" value="0" cssStyle="width:8%;"/>

                    </span>
                     </s:if>
                    <s:else>
                    <s:radio name="boardRoomPO.isVideo" list="%{#{'0':'普通会议室','2':'临时会议室','1':'视频会议室'}}" theme="simple"></s:radio>
                     <span id="maxNumberTr" style="display:none" nowrap>
                    最大点数： <s:textfield name="boardRoomPO.maxNumber" id="maxNumber" cssClass="inputText" whir-options="vtype:['p_integer_e',{'maxLength':6}]"  maxlength="6"  cssStyle="width:8%;"/>
                     </span>
                    </s:else>
                </td>  
            </tr>
            <tr>  
                <td for="适用流程" class="td_lefttitle" >  
                    适用流程：  
                </td>  
                <td colspan="3">  
                     <select name="boardRoomPO.defaultProcessId" id="defaultProcessId"  class="easyui-combobox" style="width:150px"  data-options="panelHeight:'auto',forceSelection:true" >
                       <option value="-1"></option>
                        <%
                        java.util.List boradRoomApplyFlowlist=(java.util.List)request.getAttribute("boradRoomApplyFlowlist");
                        if(boradRoomApplyFlowlist !=null){
                            for(int	j =	0; j < boradRoomApplyFlowlist.size(); j++){
							Object[] obj = (Object[])boradRoomApplyFlowlist.get(j);
							String processId = obj[0] +	"" ;
							String processName = obj[1]	+ "";
							String processType = obj[2]	+ "";
                            String rs="";
                            if(defaultProcessId.equals(processId)){
                                rs="selected";
                            }
                        %>
                        <option value="<%=processId%>" <%=rs%>><%=processName%></option>
                        <%}
                        }%>
                    </select>
                </td>  
            </tr>
             <tr>  
                <td for="备注"  class="td_lefttitle">  
                    备注：  
                </td>  
                <td colspan="3">  
                     <s:textarea name="boardRoomPO.remark" id="remark"   cssClass="inputTextarea" cssStyle="width:96.8%;" whir-options="vtype:[{'maxLength':100}]"  maxlength="100"/>
                </td>  
            </tr>
            <tr>  
                <td for="会议设备" class="td_lefttitle">  
                    会议设备：  
                </td>  
                <td colspan="3">
                     <input type="button" class="btnButton4font" onClick="addBoardRoomEqu();" value='增&nbsp;&nbsp;加'/>  
                </td>  
            </tr>
            <tr>  
                <td colspan="4">  
                    <table width="96%" border="0" cellpadding="0" cellspacing="0"  id="detailTable" class="SubTable">
                        <tr class="subTitle">
                            <td align="center" width="30%" for="设备名称">设备名称</td>
                            <td align="center" width="62%" for="设备说明">设备说明</td>
                            <td align="center" width="8%" >操作</td>
                        </tr>
                        <%
                        Set equSet = (Set)request.getAttribute("bdRoomEqu");
                        if( equSet != null ){
                        Iterator iter = equSet.iterator();
                        com.whir.ezoffice.boardroom.po.BoardRoomEquipmentPO po = null;
                        while(iter.hasNext()){
                        po = (com.whir.ezoffice.boardroom.po.BoardRoomEquipmentPO) iter.next();
                        %>
                        <tr class="subTitle">
                            <td>
                                <input type="text" class="inputText" value="<%=po.getEquName()%>" maxlength="30" name="equname" whir-options="vtype:['notempty',{'maxLength':30}]" style="width:98%"> 
                            </td>
                            <td>
                                <input type="text" class="inputText" value="<%=po.getEquDescribe()==null?"":po.getEquDescribe()%>" maxlength="50" name="equDescribe" whir-options="vtype:[{'maxLength':50}]" style="width:98%">
                            </td>
                            <td>
                                <img src="<%=rootPath%>/images/del.gif" title="删除该设备" onClick='javascript:$(this).parent("td").parent("tr").remove();' style="cursor:hand">&nbsp;
                            </td>
                        </tr>
                        <% }
                        }%>
                    </table>
                </td>  
            </tr>
            <tr class="Table_nobttomline">  
                <td > </td> 
                <td nowrap style="padding-bottom:70px;"> 
                     <s:if test='#request.action=="add"'>
                    <input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/>' />  
                    <input type="button" class="btnButton4font" onClick="save(1,this);" value='<s:text name="comm.savecontinue"/>' />  
                    </s:if>
                    <s:else>
                    <input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/> ' />  
                    </s:else>
                    <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
                </td>  
            </tr>  
        </table>  
	</s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});


	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
    $(document).ready(function(){
        <%if(isVideo !=null && !isVideo.equals("") && isVideo.equals("1")){%>
            $("#maxNumberTr").show();
         <%}%>
        $(":radio[name='boardRoomPO.isVideo']").change(function(){
		if(this.value==1){
			$("#maxNumberTr").show();
		}else{
			$("#maxNumberTr").hide();
		}
	    });
        <s:if test='#request.action == "modi"'>
            if (mailcontentHtml.attachEvent) {
                mailcontentHtml.attachEvent("onload", function () {
                insertWebeditorHTML(mailcontentHtml, '<%=depict%>');
                });
            } else {
                mailcontentHtml.onload = function () {
                insertWebeditorHTML(mailcontentHtml, '<%=depict%>');
                };
            }
        </s:if>
        
    });
    function save(n,obj){ 
       var formId = $(obj).parents("form").attr("id");
       var validation = validateForm(formId);
       $(obj).parents("form").find("#saveType").val(n);
       if(validation){
           if(checkForm()){
               $('#'+formId).submit();
           }
       }
    }
    
function checkForm(){
    var name = $('#name').val();
    var depict = $('#depict').val();
    var location = $('#location').val();

    var val =getWebeditorHTML(mailcontentHtml);
    //mailcontentHtml.getHTML();
	$('#depict').val(val);
	depict = $('#depict').val();
    if (name !=""){
            if(name.substring(0,1) ==" "){
                whir_poshytip($('#name'),"名称不得为空格开头，请去空格。");
                return false;
                }
			if(name.indexOf(" ")>-1){
                whir_poshytip($('#name'),"名称中间不能有空格，请去空格。");
                return false;
                }
        }
    if (location !=""){
            if(location.substring(0,1) ==" "){
                whir_poshytip($('#location'),"位置不得为空格开头，请去空格。");
                return false;
                }
        }
   if(!checkQuery($('#name'),"名称")) {
        return false;
      }
   if(!checkQuery($('#location'),"位置")) {
     return false;

     }
      return true;
}
function checkQuery(obj,objName) {
    var regu = /["|']/g ;
    var re = new RegExp(regu);
    var val = obj.val();
    if (val.search(re) != -1){
        whir_poshytip(obj,objName+"不能包含半角符号！");
        return false;
    }
    return true;
}
    function addBoardRoomEqu(){
        var url = "<%=rootPath%>/modules/subsidiary/boardroom/addBoardRoomEqu.jsp"
        openWin({url:url,width:560,height:180,winName:'addBoardRoomEqu'});
    }



</script>

</html>

