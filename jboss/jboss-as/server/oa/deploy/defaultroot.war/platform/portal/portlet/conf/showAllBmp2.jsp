<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>选择流程分类</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body class="MainFrameBox">
<s:form name="queryForm" id="queryForm" action="PortletData!allBmpList2.action" method="post" theme="simple">
	<%@ include file="/public/include/form_list.jsp"%>
	<s:hidden id="type" name="type" />
	
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
        <tr>
            <td width="8%" nowrap>流程分类名称：</td>
            <td width="20%">
                <s:textfield id="packageName" name="packageName" size="20" cssClass="inputText" whir-options="vtype:[{'maxLength':20}]"/>
            </td>
			<td align="right" colspan="2">
                <input type="button" class="btnButton4font" onclick="refreshListForm('queryForm');"  value="<s:text name='comm.searchnow'/>" />
                <input type="button" class="btnButton4font" onclick="resetForm(this);" value="<s:text name='comm.clear'/>" />
            </td>
        </tr>
    </table>

	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			
			
			<td whir-options="field:'packageName'" ><s:text name="流程分类名称"/></td> 
			<td whir-options="field:'',width:'8%',renderer:myOperate"><s:text name="comm.opr"/></td>
			
        </tr>
		</thead>
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>

	
</s:form>
<div style="float:right;padding-top:3px;">
<input type="button" class="btnButton4font" onclick="window.close();" value="<s:text name='comm.exit'/>" />&nbsp;
</div>
<script language="javascript">
$(document).ready(function(){		
	initListFormToAjax({formId:"queryForm"});          
});

document.onkeydown=function(e){ 
	var theEvent = window.event || e; 
	var code = theEvent.keyCode || theEvent.which; 
	if (code == 13) { 
		refreshListForm('queryForm');
	} 
} 


function myOperate(po,i){
	var classIds = ",";
	var _classId = opener.document.getElementsByName("wfPackageId");
	for(var i=0; i<_classId.length; i++){
        var val = _classId[i].value;
        classIds += val+",";
    }
	var html = '';
	if(classIds.indexOf(","+po.wfPackageId+",")>-1){
		html = '<a href="javascript:void(0)" onclick="deleteOrg('+po.wfPackageId+',\''+po.packageName+'\',this);"> <img border="0" src="<%=rootPath%>/images/wrong.gif" title="取消选择" ></a>';
	}else{
		html = '<a href="javascript:void(0)" onclick="selectOrg('+po.wfPackageId+',\''+po.packageName+'\',this);"><img border="0" src="<%=rootPath%>/images/newDocument.png" title="选择" ></a>';
	}
	return html;
}

function selectOrg(id, name, obj){
    var _classId = opener.document.getElementsByName("wfPackageId");
	if(_classId.length >= 1){
		whir_alert('只能选择1个流程分类！');
		return;
	}
    for(var i=0; i<_classId.length; i++){
        var val = _classId[i].value;
        if(val==id){
            whir_alert('该流程已经选择，请重新选择。');
            return;
        }
    }

    var p = opener.document.getElementById("columnDiv1");
    if(p){
        p.innerHTML+='<div class="wh-choose-info-box" id="protype'+id+'"><input type="hidden" id="wfPackageId" name="wfPackageId" value="'+id+'"><input type="hidden" id="packageName" name="packageName" value="'+name+'"><i class="fa fa-times fa-color" onClick="javascript:$(this).parent().remove();"></i><span>'+name+'</span></div>';
    }
	$(obj).children().remove();
	$(obj).html('<img border="0" src="<%=rootPath%>/images/wrong.gif" title="取消选择" >');
	$(obj).attr("onclick","deleteOrg('"+id+"','"+name+"',this)");
}

function deleteOrg(id, name, obj){
	var p = opener.document.getElementById("columnDiv1");
	if(p){
        $(p).find("#protype"+id).remove();
		$(obj).html('<img border="0" src="<%=rootPath%>/images/newDocument.png" title="选择" >');
		$(obj).attr("onclick","selectOrg('"+id+"','"+name+"',this)");
    }
}
</script>
</body>