<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.i18n.Resource" %>
<%
request.setCharacterEncoding("UTF-8");
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();

com.whir.ezoffice.workflow.newBD.ProcessBD pbd = new com.whir.ezoffice.workflow.newBD.ProcessBD();
com.whir.ezoffice.workflow.newBD.WorkFlowBD wbd = new com.whir.ezoffice.workflow.newBD.WorkFlowBD();

String initActivity = request.getParameter("activity");
String tableId = request.getParameter("table");
String recordId = request.getParameter("record");
String workType = request.getParameter("workType");
String processId = request.getParameter("processId");
String submitPersonId = request.getParameter("submitPersonId");

String concealFieldString = "";
/*
if(workType.equals("1")){
     //表示是业务流程                            //activity
     java.util.List list = wbd.getHideList(initActivity, tableId, recordId, "1");
     String[] str = null;
     for(int i = 0; i < list.size(); i ++){
          str = (String[]) list.get(i);
          if(str[0].equals("3")){
            //隐藏字段
            concealFieldString = concealFieldString + "$" + str[1] + "$";
         }
     }
}

//发起人  适用  “对发起人隐藏字段”
if(submitPersonId!=null&&submitPersonId.equals(session.getAttribute("userId").toString())){
    java.util.List list = pbd.getHiddenFieldList(processId);
    String str = null;
    for(int i = 0; i < list.size(); i ++){
       str = ""+list.get(i);
       //隐藏字段
       concealFieldString = concealFieldString + "$" + str+ "$";

    }
}*/
request.setAttribute("concealField", concealFieldString);
%>
<%
//发起人
String submitPerson="";
//发起时间
String submitDate="";
//流程名称
String processName="";

String pageId = "";
com.whir.ezoffice.customdb.common.util.DbOpt dbopt = new com.whir.ezoffice.customdb.common.util.DbOpt();
try{
    pageId = dbopt.executeQueryToStr("select PRINT_PAGE_ID from TPAGE where PAGE_ID="+request.getParameter("p_wf_tableId"));

    String[][] results = dbopt.executeQueryToStrArr2("select WORKSUBMITPERSON, WORKCREATEDATE from WF_WORK where WF_WORK_ID = "+request.getParameter("p_wf_workId"),2);
    submitPerson = results[0][0];
    if("en_us".equals(local)){
        submitDate = results[0][1].substring(0, results[0][1].indexOf(" "));
    }else{
        submitDate = results[0][1].substring(0, results[0][1].indexOf(" "));//.replace('-','年').replace('-','月')+"日";
        String y = submitDate.substring(0, 4);
        String m = submitDate.substring(5, 7);
        String d = submitDate.substring(8, 10);
        submitDate = y + "年" + m + "月" + d + "日";
    }

    String[][] results2 = dbopt.executeQueryToStrArr2("select workflowprocessname from wf_workflowprocess where wf_workflowprocess_id = "+request.getParameter("p_wf_processId"),1);
    processName = results2[0][0];

    if(pageId==null || pageId.trim().length()<1){
        pageId = request.getParameter("p_wf_tableId");
    }else{
        String pageRef = dbopt.executeQueryToStr("select PAGE_REF from TPAGE where PAGE_ID="+pageId);
        if(pageRef==null || pageRef.trim().length()<8){
            pageId = request.getParameter("p_wf_tableId");
        }    
    }
}catch(Exception e){
    pageId = request.getParameter("p_wf_tableId");
} finally{
    try{dbopt.close();}catch(Exception e2){}
}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=submitPerson%> <%=submitDate%> <%=processName%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%
    whir_custom_str="easyui";
    %>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <%@ include file="/public/include/meta_base_workflow.jsp"%>
    <style type="text/css">
    td,div,p,font,span,option,label,li{
        font-size:13px;
        /*color:#000000;*/
        line-height:150%;
    }
    </style>
    <style media="print">
    .toolbarPrint{
        display:none;
    }
    .printNumTbl{
        display:none;
    }
    </style>
    <style type="text/css">
    /*带标题模板*/
    .templateBox{ clear:both; width:98%;}
    .templateBox .templateBoxline{ border:1px solid #dcdcdc; padding:0 20px; margin:0; min-height: 100px;  height: auto !important;  height: 100px;}
    .templateBox .templateTitle{ height:28px; line-height:28px; font-weight:bold; color:#000; font-size:12px; margin:0; padding:0 15px;}
    .templateBox .templateContent{
        width:100%;
        border-collapse: collapse;
        clear: both;
        display: table;
        border-spacing: 0;
        table-layout: auto;
    }

    .relationObjDiv{
        width:98%;
        float:left;
        margin:5px;
        /*display:inline;*/
        display: table-cell;
        vertical-align: top;
    }

    .templateBox .templateContent .relationObjDiv_outter{
        width:49%;
        float:left;
    }

    .dataDiv{
    }

    </style>
</head>
<body scroll="yes" style="overflow:auto;">
<div class="toolbarPrint" align=left>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" id="print" style="display:none" onclick="javascript:printDoc(this);" value="打　印" class="btnButton4font">
<%if(isForbiddenPad){%><input type="button" id="download" style="display:none" onclick="javascript:downloadHTML();" value="下载网页格式文件" class="btnButton4font">
<input type="button" id="exportWord" style="display:none" onclick="javascript:exportWord();" value="下载WORD格式文件" class="btnButton6font"><%}%>
<OBJECT CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" ID="save" HEIGHT=0 WIDTH=0></OBJECT>
</div>
<!-- body start-->

<div style="padding:20px;">
    <table width="100%" border="0" class="printNumTbl">
        <tr>
            <td align="right" style="padding-right:20px;">
                <script language="javascript">
                    try{
                        var obj = opener.document.getElementById("viewPrintNum");
                        document.write("第 "+obj.innerHTML+" 次打印");
                    }catch(e){}
                </script>
            </td>
        </tr>
    </table>
    <div id="__contentDIV__">
		<style>
		.subtablediv table{
			width:100%;
		}
		</style>
        <input type=hidden name=tableId value="<%=pageId%>">
        <%
            String flag="none";
            out.print("<input type=hidden name=recordId value="+request.getParameter("p_wf_recordId")+">");
            request.setAttribute("infoId",request.getParameter("p_wf_recordId"));
        %>
		<div style="padding:10px;margin-bottom:10px">
        <jsp:include page="/platform/custom/custom_form/run/showform.jsp" flush="true">
            <jsp:param name="pageId"  value="<%=pageId%>"/>
            <jsp:param name="flag" value="1"/>
            <jsp:param name="isprint" value="1"/>
        </jsp:include>
		</div>
        <div>  
            <%@ include file="/platform/bpm/work_flow/operate/wf_include_form.jsp"%>
        </div>
        <!--------批示意见----------->
        <div id="includeCommentDiv" align=center style="margin:0 auto;padding:0px 0px 0px 0px;">
            <%@ include file="/platform/bpm/work_flow/operate/wf_include_comment.jsp"%>
        </div>
    </div>

</div>

<div id="exportHtml" style="display:none"></div>
<!-- body end-->
</body>
</html>
<script language="JavaScript">
<!--
var exportUrl = "PrintForm";
var p_wf_processName = "";
var dhtmlFlag = false;
$(function () {
    p_wf_processName = $('#p_wf_processName').val();
    init()
});

function init(){
    var loc = window.location+'';
	var s = loc.substr(0,5);
	if(s.indexOf('http')!=-1||
	   s.indexOf('https')!=-1||
	   s.indexOf('ftp')!=-1){
	    document.getElementById('print').style.display="";
		document.getElementById('download').style.display="";
        document.getElementById('exportWord').style.display="";
	}else{
		document.getElementById('print').style.display="none";
		document.getElementById('download').style.display="none";
        document.getElementById('exportWord').style.display="none";
	}

    if($('#isEzForm').length > 0){
        exportUrl = "PrintEzForm";
    }

    resetCommentWidth();
    $(window).resize(function(){resetCommentWidth();});
}

function resetCommentWidth(){
    //$('#includeCommentDiv').css('width', '100%');
    //$('#includeCommentDiv').css('width', ($('#formHTML table').width() + 12) + 'px');

    commentWidth();
}

/***
批示意见框的位置
*/
function commentWidth(){
   var  table=$("#formHTML").find("table").first();
   $("#includeCommentDiv").width(table.width()+18);
}

function printDoc(obj){
    //window.print();
    //window.close();

    var basePath = 'http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=rootPath%>';
    var printHtml = '';
    printHtml += '<!DOCTYPE html>';
    printHtml += '<html style="height:0;">';
    printHtml += '<head>';
    printHtml += '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>';
    printHtml += '<title>打印表单</title>';
    printHtml += '<script language="javascript" src="'+basePath+'/scripts/jquery-1.11.2.min.js"></sc'+'ript>';
    printHtml += '<link rel="stylesheet" type="text/css" href="'+basePath+'/themes/common/common.css"/>';
    printHtml += '<link rel="stylesheet" type="text/css" href="'+basePath+'/<%=whir_skin%>/style.css"/>';
    printHtml += '<script>';
    printHtml += 'window.onerror = function(){return true;};';
    printHtml += '</sc'+'ript>';
    printHtml += '</head>';
    printHtml += '<body style="background:#fff;margin:0;padding:10px;" onload="window.print();window.close();">';

    var __contentDIV__ = document.getElementById('__contentDIV__').innerHTML;

    var scriptregex = "<scr" + "ipt[^>.]*>[sS]*?</sc" + "ript>";
    var scripts = new RegExp(scriptregex, "gim");
    __contentDIV__ = __contentDIV__.replace(scripts, " ");
    __contentDIV__ = __contentDIV__.replace(/<script[\w\W]*?\<\/script>/igm, "");

    printHtml += __contentDIV__;

    printHtml += '<script>';
    printHtml += 'try{document.getElementById("showformDiv").style.height="auto";}catch(e){}';
    //printHtml += 'try{document.getElementById("includeCommentDiv").style.width="100%";}catch(e){}';
    printHtml += '</sc'+'ript>';

    printHtml += '</body>';
    printHtml += '</html>';

    printWin = window.open("", "newwin", "");
    printWin.document.write(printHtml);
    printWin.document.close();
}

function _export2(url, content){
    var $form = createDynamicForm({id:'_postForm_',target:'_self', action:url, method:'post', params:[{name:'title', value:p_wf_processName}]});
    var textareaObj = $('<textarea name=content style="display:none"/>');
    textareaObj.val(content);
    textareaObj.appendTo($form);

    if($form) {
        $form.submit();
    }
}

var tempHtml = "";
var processFlag = true;
function processContent(){
    if(tempHtml != ''){
        document.getElementById('__contentDIV__').innerHTML = tempHtml;
    }else{
        tempHtml = document.getElementById('__contentDIV__').innerHTML;
    }
    var __contentDIV__ = document.getElementById('__contentDIV__').innerHTML;

    if($('#adddelrow_div').length>0)$('#adddelrow_div').remove();

    var _this_href = location.href;
    _this_href = '<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()%>';

    if(processFlag){
        $('#__contentDIV__ img').each(function(){
            var src = $(this).attr('src');
            if(src){
                if(src.indexOf("http:")==-1 && src.indexOf("https:")==-1){
                    $(this).attr('src', _this_href + src);
                }
            }
        });
        //processFlag = false;
    }

    $('#backCommentTbl').remove();

    $("tr[id=commTR]").each(function(i){
        var display = $(this).css('display');
        if(display=='none'){
            $(this).remove();
        }
    });

    $("input[type=hidden]").remove();

    processPrintHtml();

    __contentDIV__ = document.getElementById('__contentDIV__').innerHTML;
    
    var scriptregex = "<scr" + "ipt[^>.]*>[sS]*?</sc" + "ript>";
    var scripts = new RegExp(scriptregex, "gim");
    __contentDIV__ = __contentDIV__.replace(scripts, " ");
    __contentDIV__ = __contentDIV__.replace(/<script[\w\W]*?\<\/script>/igm, "");

    __contentDIV__ = __contentDIV__.replace(/<input type=hidden [\w\W]*?>/igm, "");
    __contentDIV__ = __contentDIV__.replace(/<object [\w\W]*?>/igm, "");
    __contentDIV__ = __contentDIV__.replace(/\<br\>/igm, "\n\r");

    __contentDIV__ = __contentDIV__.replace(/<link[\w\W]*?\>/igm, "");

    return __contentDIV__;
}

function downloadHTML(){
    dhtmlFlag = false;
    var __contentDIV__ = processContent();
    _export2(exportUrl+'!export2html.action', __contentDIV__);
}

function exportWord(){
    dhtmlFlag = true;
    var __contentDIV__ = processContent();
    _export2(exportUrl+'!export2doc.action', __contentDIV__);
    endPrintHtml(tempHtml);
}

function processPrintHtml(){
    $('#__contentDIV__ table').each(function(i){
        var $this = $(this);
        var width = $this.css('width');
        if(width.indexOf('px')!=-1){
            width = width.substr(0, width.length -2);
        }

        if(width > 550){
            if(dhtmlFlag){
                $this.attr('width', '100%');
                dhtmlFlag = false;
            }
        }
    });

	//打印自动添加用户任务样式出错
    //$('#commTD').each(function(i){
    //    $(this).prev().attr('style','');//css('border-bottom','1px solid #366AB3;');
    //});
}

function endPrintHtml(tempHtml){
    document.getElementById('__contentDIV__').innerHTML = tempHtml;
}
//-->
</script>