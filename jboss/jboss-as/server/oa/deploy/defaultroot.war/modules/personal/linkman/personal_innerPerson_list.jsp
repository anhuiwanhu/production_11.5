<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!--<title>联系人-内部联系人-列表页面</title>-->
    <title><s:text name="personalwork.innercontact"/><s:text name="calendar.list" /></title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_list.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <%@ include file="/public/im/onlinejs.jsp"%>
    <script src="<%=rootPath%>/modules/personal/linkman/personal_innerPerson_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" type="text/javascript"></script>
    
     <!-- 人员浮动卡片 [BEGIN] -->
    <script src="<%=rootPath%>/scripts/main/whir.userInfo.card.js" language="javascript"></script>
    <style type="text/css">   
        .trigger1:hover{color:red}   
    </style>
    <!-- 人员浮动卡片 [END] -->
</head>

<body class="MainFrameBox">
    <s:form name="queryForm" id="queryForm" action="${ctx}/PersonInnerAction!list.action" method="post" theme="simple">
    <s:hidden name="queryOrgIdStr" id="queryOrgIdStr" value="%{#request.queryOrgIdStr}" />
    <!-- SEARCH PART START -->
    <%@ include file="/public/include/form_list.jsp"%>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar" style="display:none;">
        <tr>
            <td class="whir_td_searchtitle"><s:text name="innercontact.name"/>：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryPersonName" name="queryPersonName" size="16" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle"><s:text name="innercontact.ename"/>：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryPersonEName" name="queryPersonEName" size="16" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle"><s:text name="innercontact.department"/>：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryPersonDept" name="queryPersonDept" size="16" cssClass="inputText" />
            </td>
        </tr>
        <tr>
            <td class="whir_td_searchtitle"><s:text name="obj.selectobject.postdegree"/>：</td>
            <td class="whir_td_searchinput" nowrap>
                <select name="queryPersonDutyFlag" id="queryPersonDutyFlag" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto', selectOnFocus:true">
                    <option value="">--<s:text name="innercontact.Pleaseselect" />--</option>
                    <option value="0"><s:text name="obj.selectobject.equal"/>(＝)</option>
                    <option value="1"><s:text name="obj.selectobject.morethan"/>(＞)</option>
                    <option value="2"><s:text name="obj.selectobject.moreEqual"/>(＞＝)</option>
                    <option value="3"><s:text name="obj.selectobject.lessthan"/>(＜)</option>
                    <option value="4"><s:text name="obj.selectobject.lessEqual"/>(＜＝)</option>
                </select>
                <select name="queryPersonDuty" id="queryPersonDuty" class="easyui-combobox" style="width:180px;" data-options="selectOnFocus:true">
                    <option value="">--<s:text name="innercontact.Pleaseselect" />--</option>
                    <s:iterator var="obj" value="#request.personDutyList">
                        <option value='<s:property value="#obj[0]"/>_<s:property value="#obj[2]"/>'><s:property value="#obj[1]" /></option>
                    </s:iterator>
                </select>
            </td>
            <td class="whir_td_searchtitle"><s:text name="innercontact.offnumber" />：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryPersonBPhone" name="queryPersonBPhone" size="16" cssClass="inputText" whir-options="vtype:['p_integer_e']" maxLength="11" />
            </td>
            <td class="whir_td_searchtitle"><s:text name="innercontact.email" />：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryPersonEmail" name="queryPersonEmail" size="16" cssClass="inputText" />
            </td>
        </tr>
        <tr>
            <td class="whir_td_searchtitle"><s:text name="innercontact.add" />：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryPersonAddress" name="queryPersonAddress" size="16" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle"><s:text name="innercontact.mobile" />：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryPersonMPhone" name="queryPersonMPhone" size="16" cssClass="inputText" whir-options="vtype:['p_integer_e']" maxLength="11" />
            </td>
            <td class="whir_td_searchtitle"><s:text name="innercontact.sex" />：</td>
            <td class="whir_td_searchinput">
                <s:radio name="queryPersonSex" id="queryPersonSex" list="%{#{'0':getText('pubcontact.male'), '1':getText('pubcontact.female')}}" theme="simple"></s:radio>
                <!--
                <select name="queryPersonSex" id="queryPersonSex" class="easyui-combobox" style="width:286px;" data-options="panelHeight:'auto', selectOnFocus:true">
                    <option value="">--<s:text name="innercontact.Pleaseselect" />--</option>
                    <option value="0"><s:text name="pubcontact.male" /></option>
                    <option value="1"><s:text name="pubcontact.female" /></option>
                </select>
                -->
            </td>
        </tr>
        <tr>
            <td class="SearchBar_toolbar" colspan="6">
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
                <!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
    <!-- SEARCH PART END -->
    
    <!-- MIDDLE BUTTONS START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
            <td align="right">
            <!--
                <input type="button" class="btnButton4font" onclick="controlZTreeObject();" value='测试' />
            -->
                <s:if test='#request.hasExportRight=="true"'>
                <input type="button" class="btnButton4font" onclick="excelExport();" value='<s:text name="comm.export"/>' />
                </s:if>
                <input type="button" class="btnButton4font" id="openButton" onclick="controlQueryPart(1);" value='<s:text name="open.search"/>' style="display:;" />
                <input type="button" class="btnButton4font" id="closeButton" onclick="controlQueryPart(0);" value='<s:text name="close.search"/>' style="display:none;" />
            </td>
        </tr>
    </table>
    <!-- MIDDLE BUTTONS END -->
    <%
        if(realtimemessage_use){
            if("rtx".equals(realtimemessage_type)){
                if(online){
    %>
                    <div style="display:none">
                        <img align="absbottom" width="16" height="16" src="<%=rootPath%>/images/rtx/blank.gif" onload="online('');">
                    </div>
    <%
                }
            }
        }
    %>

    <!-- LIST PART START -->    
    <s:hidden id="scopeType" value="%{#request.scopeType}" />
    <s:hidden id="orgRange" value="%{#request.orgRange}" />
    <s:hidden id="userRange" value="%{#request.userRange}" />
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
        <thead id="headerContainer">
            <tr class="listTableHead">
                <td whir-options="field:'', width:'8%', renderer:showEmpName">
                    <s:text name="innercontact.name" />
                </td> 
                <td whir-options="field:'empSex', width:'5%', renderer:showEmpSex">
                    <s:text name="innercontact.sex" />
                </td> 
                <td whir-options="field:'orgNameString', width:'20%'">
                    <s:text name="innercontact.department" />
                </td> 
                <td whir-options="field:'empEmail', width:'20%'">
                    <s:text name="innercontact.email" />
                </td> 
                <td whir-options="field:'empAddress', width:'20%'">
                    <s:text name="innercontact.add" />
                </td> 
                <td whir-options="field:'empBusinessPhone', width:'10%'" nowrap>
                    <s:text name="innercontact.offnumber" />
                </td> 
                <td whir-options="field:'empMobilePhone', width:'10%'" nowrap>
                    <s:text name="innercontact.mobile" />
                </td> 
                <s:if test='#request.scopeType!=""'>
                    <s:if test='#request.scopeType=="0"'>
                        <td whir-options="field:'', width:'8%', renderer:myOperate0">
                            <s:text name="agent.operation" />
                        </td> 
                    </s:if>
                    <s:elseif test='#request.scopeType=="1"'>
                        <td whir-options="field:'', width:'8%', renderer:myOperate1">
                            <s:text name="agent.operation" />
                        </td> 
                    </s:elseif>
                    <s:elseif test='#request.scopeType=="2"'>
                        <td whir-options="field:'', width:'8%', renderer:myOperate2">
                            <s:text name="agent.operation" />
                        </td> 
                    </s:elseif>
                    <s:elseif test='#request.scopeType=="3"'>
                        <td whir-options="field:'', width:'8%', renderer:myOperate3">
                            <s:text name="agent.operation" />
                        </td> 
                    </s:elseif>
                    <s:elseif test='#request.scopeType=="4"'>
                        <td whir-options="field:'', width:'8%', renderer:myOperate4">
                            <s:text name="agent.operation" />
                        </td> 
                    </s:elseif>
                </s:if>
                <s:else>
                <td whir-options="field:'', width:'8%', renderer:myOperate">
                    <s:text name="agent.operation" />
                </td> 
                </s:else>
            </tr>
        </thead>
        <tbody  id="itemContainer" >
        
        </tbody>
    </table>
    <!-- LIST PART END -->

    <!-- PAGER PART START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER PART END -->
    </s:form>
</body>


<script type="text/javascript">

$(document).ready(function(){    
    //初始化列表页form表单,"queryForm"是表单id，可修改。
    initListFormToAjax({formId:"queryForm",onLoadSuccessAfter:showUserCardInfo});  
});

//自定义操作栏内容

function createOperateHtml(id){
    var html = '<a href="javascript:void(0)" onclick="modiInnerPerson('+id+');"><img border="0" src="<%=rootPath%>/images/modi.gif" title="<s:text name="comm.supdate"/>" ></a>';
    return html;
}

// 
function myOperate(po, i){
    var html = '';
    // 当且仅当 该 联系人 是 当前用户 时
    if('<s:property value="%{#session.userId}"/>' == po.empId){
        //html += '<a href="javascript:void(0)" onclick="modiInnerPerson('+po.empId+');"><img border="0" src="<%=rootPath%>/images/modi.gif" title="修改" ></a>';
        html += createOperateHtml(po.empId);
    }
    html = html==''?'&nbsp;':html;
    return html;
}

// 全部
function myOperate0(po, i){
    var html = createOperateHtml(po.empId);
    return html;
}

// 本人
function myOperate1(po, i){
    var html = '';
    // 当且仅当 该 联系人 是 当前用户 时
    if('<s:property value="%{#session.userId}"/>' == po.empId){
        html += createOperateHtml(po.empId);
    }
    html = html==''?'&nbsp;':html;
    return html;
}

// 本组织及下属组织
function myOperate2(po, i){
    var html = '';
    var orgRange = $('#orgRange').val();
    //alert('orgRange=[' + orgRange + ']');
    if('<s:property value="%{#session.userId}"/>' == po.empId || orgRange.indexOf(po.orgId) >= 0){
        html += createOperateHtml(po.empId);
    }
    html = html==''?'&nbsp;':html;
    return html;
}

// 本组织
function myOperate3(po, i){
    var html = '';
    // 当且仅当 该 联系人 与 当前用户 属于同一组织 时 
    if('<s:property value="%{#session.userId}"/>' == po.empId || '<s:property value="%{#session.orgId}"/>' == po.orgId){
        html += createOperateHtml(po.empId);
    }
    html = html==''?'&nbsp;':html;
    return html;
}

// 自定义
function myOperate4(po, i){
    var html = '';
    var orgRange = $('#orgRange').val();
    var userRange = $('#userRange').val();
    if('<s:property value="%{#session.userId}"/>' == po.empId || orgRange.indexOf(po.orgId) >= 0){
        html += createOperateHtml(po.empId);
    } else if(userRange != "" && userRange.indexOf("$" + po.empId + "$") > -1) {
		html += createOperateHtml(po.empId);
	}
    return html;
}

//自定义查看栏内容
function showEmpName(po, i){
    var html = '';
<%
if(realtimemessage_use){
%>
    var onLine = getOnlineHtml(whirRootPath, po.userAccounts, po.empId, po.empSex, po.orgId)
    html += onLine;
<%
}
%>
   // html += '<a href="javascript:void(0)" onclick="viewInnerPerson('+po.empId+');">'+po.empName+'</a>';
    var data = whirRootPath + '/public/desktop/getUserCardInfo.jsp?id=' + po.empId + '&hasMsg=true'; 
    html += '<a  class="trigger1"  rel=' + data + ' href="javascript:void(0);" onclick="viewInnerPerson('+po.empId+')">'+po.empName+'</a>';
   
 //   var html = '<a class="trigger1" rel=' + data + ' href="javascript:void(0);" onclick="viewUserInfo('+po.eventEmpId+')">' + po.eventEmpName + '</a>';
    
    
    return html;
}

function showEmpSex(po, i){
    if(po.empSex == '0'){
        return '' + Personalwork.pubcontact_male;
    } else if(po.empSex == '1') {
        return '' + Personalwork.pubcontact_female;
    } else {
        return '&nbsp;';
    }
}

function showEmpAddress(po, i) {
    var html = '';
    if(po.empCountry != ''){
        html += po.empCountry + '.';
    }
    if(po.empState != ''){
        html += po.empState + '.';
    }
    if(po.empCounty != ''){
        html += po.empCounty;
    } else {
        html = html.substring(0, html.length-1);
    }
    
    html = html==''?'&nbsp;':html;
    //html += po.empAddress;
    return html;
}

function controlZTreeObject(){
    //var parent = window.dialogArguments;
    //alert($(parent).find('addNode').val());
    //var x=parent.docuement.getElementById("age").value;

    //var obj = window.parent.document;
    //$(obj).find('#leftFrame').html()
    //alert($("#leftFrame", window.top.frames[0].document).attr("src"));
    //alert($('#addNode', window.parent.document).val());
    //$('#leftFrame', window.parent.document).find('addNode').eq(0).onclick();
}

</script>

</html>

