<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>选择栏目</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<%
String classId = request.getParameter("classId");
//20160531 -by jqq 安全性漏洞改造
if(classId!=null && !"".equals(classId))
	classId = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(classId);
%>
<body class="MainFrameBox">
<s:form name="queryForm" id="queryForm" action="PortletData!myChannelList.action" method="post" theme="simple">
	<%@ include file="/public/include/form_list.jsp"%>
	<s:hidden id="type" name="type" />
	<s:hidden id="iso" name="iso" />
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
        <tr>
            <td width="8%" nowrap>栏目：</td>
            <td width="20%">
                <s:textfield id="channelName" name="channelName" size="20" cssClass="inputText" whir-options="vtype:[{'maxLength':20}]"/>
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
			<td whir-options="field:'channelIdString',width:'90%'">栏目</td> 
			<td whir-options="field:'',width:'8%',renderer:myOperate"><s:text name="comm.opr"/></td>
        </tr>
		</thead>
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
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
	var _classId = opener.document.getElementsByName("classId");
	for(var i=0; i<_classId.length; i++){
        var val = _classId[i].value;
        classIds += val+",";
    }
	var html = '';
	if(classIds.indexOf(","+po.channelId+",")>-1){
		html = '<a href="javascript:void(0);" onclick="deleteColumn('+po.channelId+',\''+po.channelIdString+'\','+po.channelType+','+po.userDefine+',this);"><img border="0" src="<%=rootPath%>/images/wrong.gif" title="取消选择" ></a>';
	}else{
		html = '<a href="javascript:void(0);" onclick="selectColumn('+po.channelId+',\''+po.channelIdString+'\','+po.channelType+','+po.userDefine+',this);"><img border="0" src="<%=rootPath%>/images/newDocument.png" title="选择" ></a>';
	}
	return html;
}

function selectColumn(id, name, channelType, userDefine, obj){
    var _classId = opener.document.getElementsByName("classId");
	if(_classId.length >= 4){
		whir_alert('最多只能选择4个栏目！');
		return;
	}
    for(var i=0; i<_classId.length; i++){
        var val = _classId[i].value;
        if(val==id){
            whir_alert('该栏目已经选择，请重新选择。');
            return;
        }
    }

    var p = opener.document.getElementById("columnDiv");
    if(p){
        /*
		p.innerHTML+='<div class="column'+id+'"><input type="hidden" id="channelType" name="channelType" value="'+channelType+'"><input type="hidden" id="userDefine" name="userDefine" value="'+userDefine+'"><input type="hidden" id="classId" name="classId" value="'+id+'"><input type="text" id="className" name="className" value="'+name+'" style="width:85%;border:0;" readonly><img src="<%=request.getContextPath()%>/images/del.gif" alt="删除" onclick="javascript:$(this).parent().remove();" style="cursor:pointer"></div>';
		*/
		p.innerHTML+='<div class="wh-choose-info-box" id="column'+id+'"><input type="hidden" id="channelType" name="channelType" value="'+channelType+'"><input type="hidden" id="userDefine" name="userDefine" value="'+userDefine+'"><input type="hidden" id="classId" name="classId" value="'+id+'"><input type="hidden" id="className" name="className" value="'+name+'"><i class="fa fa-times fa-color" onClick="javascript:$(this).parent().remove();"></i><span>'+name+'</span></div>';
		
    }
	$(obj).children().remove();
	var td_parent = $(obj).parent();
	var td_html = "<a href=\"javascript:void(0);\" onclick=\"deleteColumn("+id+",'"+name+"',"+channelType+","+userDefine+",this);\"><img border=\"0\" src=\"<%=rootPath%>/images/wrong.gif\" title=\"取消选择\"></a>";
	td_parent.html(td_html);
	//$(obj).bind("onclick",function(){ deleteColumn(id,name,channelType,userDefine,this); });
	//$(obj).html('<img border="0" src="<%=rootPath%>/images/wrong.gif" title="取消选择" >');
	//$(obj).attr("onclick","deleteColumn('"+id+"','"+name+"','"+channelType+"','"+userDefine+"',this)");
}

function deleteColumn(id,name,channelType,userDefine,obj){
	var p = opener.document.getElementById("columnDiv");
	if(p){
    $(p).find("#column"+id).remove();
		var td_parent = $(obj).parent();
		var td_html = "<a href=\"javascript:void(0);\" onclick=\"selectColumn("+id+",'"+name+"',"+channelType+","+userDefine+",this);\"><img border=\"0\" src=\"<%=rootPath%>/images/newDocument.png\" title=\"选择\"></a>";
		td_parent.html(td_html);
		//$(obj).bind("onclick",function(){ selectColumn(id,name,channelType,userDefine,this); });
		//$(obj).html('<img border="0" src="<%=rootPath%>/images/newDocument.png" title="选择" >');
		//$(obj).attr("onclick","selectColumn('"+id+"','"+name+"','"+channelType+"','"+userDefine+"',this)");
    }
}
</script>
</body>