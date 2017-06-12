<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>收文</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<!--工具栏按钮 公用js-->
   <!--工作流包含页 js文件-->  
    <%@ include file="/public/include/meta_base_bpm.jsp"%>
 	<script src="<%=rootPath%>/modules/govoffice/gov_documentmanager/js/receive.js"   type="text/javascript"></script>
	<style type="text/css">
	<!--
	.sw {
		background:transparent;
		border-top-width: 0px;
		border-right-width: 0px;
		border-bottom-width: 1px;
		border-left-width: 0px;
		border-top-style: solid;
		border-right-style: solid;
		border-bottom-style: solid;
		border-left-style: solid;
		border-bottom-color: #CCCCCC;
	}

	#noteDiv_toPerson1 {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	#noteDiv_toPersonBao {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	#noteDiv_toPerson2 {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	.divOver{
		background-color:#003399;
		color:#FFFFFF;
		border-bottom:1px dashed #cccccc;
		width:100%;
		height:20px;
		line-height:20px;
		cursor:default;
		padding-left:5px;
	}
	.divOut{
		background-color:#ffffff;
		color:#000000;
		border-bottom:1px dashed #cccccc;
		width:100%;
		height:20px;
		line-height:20px;
		cursor:default;
		padding-left:5px;
	}
	.STYLE1,.STYLE1 font,.STYLE1 text,.STYLE1 textarea{font-size: 14px; font-family:"宋体"}
	
	-->
	</style>
	<style type="text/css">
        <%if( !"1".equals( request.getParameter("isPrint"))){ %> html,body{ height:100%; overflow:hidden; margin:0; padding:0;}<%}%>
    </style>

    <script type="text/javascript">
   <%if( !"1".equals( request.getParameter("isPrint"))){ %> $(function(){
     var bh = $("body").height();
     var dh = bh-47;
     $("#mainContent").height(dh);
    });
	<%}%>
    </script>

	<style>
	<!--
	@media print{


		.noprint{

		   display:none

		}

	}
	-->
	</style>

</head>
<body   onload="initBody();"  <%if( !"1".equals( request.getParameter("isPrint"))){ %>class="docBodyStyle" style="position:relative; height:100%;" <%}else{%>scroll=yes<%}%> > <!--scroll=yes   "-->
<%
	//System.out.println("[[[[[[[[[[[[[[[[[[[["+request.getAttribute("p_wf_modiButton"));;

String workStatus = request.getAttribute("p_wf_workStatus")==null?"1":(String)request.getAttribute("p_wf_workStatus");
String receiveStatus=request.getAttribute("receiveStatus")==null?"":request.getAttribute("receiveStatus").toString();

String modiButton = null ;//"none";

//if(request.getParameter("isEdit")!=null&&"1".equals(request.getParameter("isEdit").toString())){
if(1==2){
  if(receiveStatus.equals("1")){
 // System.out.println("_______________________________________________ISBACK2__"+request.getParameter("isBack"));
  	if("1".equals(request.getParameter("isBack"))){
 		modiButton=",Print,Tosend,Saveclose";
 	}else{
 		modiButton=",Back,Print,Tosend,Saveclose";
 	}
 }else{
 //System.out.println("_______________________________________________ISBACK__"+request.getParameter("isBack"));
 	if(!"1".equals(request.getParameter("isBack"))){
  		modiButton=",Wait,Back,Print,Tosend,Saveclose";
  	}else{
  		modiButton=",Wait,Print,Tosend,Saveclose";
  	}
 }
 
}else if( request.getParameter("viewOnly")!=null && "1".equals(request.getParameter("viewOnly") ) ){//else if(request.getParameter("viewOnly")!=null&&"1".equals(request.getParameter("viewOnly").toString())){
 modiButton="";

}

if(request.getAttribute("p_wf_processId")==null||request.getAttribute("p_wf_processId").toString().equals("")||request.getAttribute("p_wf_processId").toString().equals("null")){
 modiButton="";
}

if(workStatus.equals("-1")){
modiButton="";
}

if(workStatus.equals("2")){
modiButton="none";
//modiButton=",End,Viewtran";

}
//System.out.println("=================================================================================" + modiButton);
if(request.getParameter("fromdesktop")!=null && !"null".equals(request.getParameter("fromdesktop")) && "2".equals(request.getParameter("fromdesktop"))){
	modiButton="";
}
String commentNotNull = request.getAttribute("commentNotNull")==null?"0":request.getAttribute("commentNotNull").toString();//批示意见是否可以为空
//
if( "dealwith".equals(  request.getParameter("from") ) )
if( "1".equals( workStatus) ){
	modiButton=",Wait,Print,Cancel,EmailSend,AddNew,Tosend,Tocheck";
}else if("1011".equals( workStatus)){
	modiButton=",Print,EmailSend,AddNew";
}
if(modiButton == null){
	 modiButton = (String)request.getAttribute("p_wf_modiButton");
}//System.out.println("_______________________________________________modiButton__"+modiButton);
if(modiButton != null){
	request.setAttribute("p_wf_modiButton",modiButton.replaceAll(",Saveclose,",","));
}
	//System.out.println("[[[[[[[[[[[[[[[[[[[["+request.getAttribute("p_wf_modiButton"));;
	
	%>  <%if( !"1".equals( request.getParameter("isPrint"))){ %>
       <!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" ></jsp:include>
	   <%}%>
  <%if( !"1".equals( request.getParameter("isPrint"))){ %>	  <div class=""  id="mainContent"  style="overflow-y:auto; position:absolute; top:47px; width:100%; _width:99%; "><%}%>
<input type="hidden" name="from" value="<%=request.getParameter("from")%>">

	 <s:form name="dataForm" id="dataForm" action="wfoperate!showSend.action" method="post" theme="simple" >
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline"   >
					   <%if(! "1".equals( request.getParameter("isPrint"))){ %>
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> 
							  <li id="Panle2" ><a href="#" onClick="changePanle(2);">流程记录</a></li>
							  <li id="Panle3" ><a href="javascript:void(0);" onClick="changePanle(3);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
							  <%if( !"1".equals( request.getAttribute("p_wf_pool_processType") ) ){%>
							  <li id="Panle4" ><a href="#" onClick="changePanle(4);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
							  <%}%>
							 
						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <%}%>
					   <%if( "1".equals( request.getParameter("isPrint"))){ %><br><div align="right"><input type="button" class="btnButton4font noprint" value="打　印" onclick=";window.print();">
								<% if(com.whir.common.util.CommonUtils.isForbiddenPad(request)){%>
							    <input type="button" id="download" onclick="javascript:downloadHTML();" value="下载网页格式文件" class="btnButton4font noprint">
							
								<input type="button" id="exportWord111" onclick="javascript:exportWord();" value="下载WORD格式文件" class="btnButton6font noprint">
								<%}%>
							 </div><%}%>
					   <div id="docinfo0" class="doc_Content"  align="center">
							<!--表单包含页--><!--<input type="button" value="保存草稿" onclick="cmdSaveDraft()">
											 <input type="button" value="起草正0文" onclick="wordWindowFirst()">-->
							 
							<div  align="center"> 
							<%
							com.whir.govezoffice.documentmanager.bd.SendFileBD sendFileBD = new com.whir.govezoffice.documentmanager.bd.SendFileBD();
							String tableId_form =(String) request.getAttribute("p_wf_tableId" );
							List tableInfoList = sendFileBD.getWfTableInfoByTableId(tableId_form); // 根据tableId
							// 找table
							// 信息
							String tableName = "";
		

							if (tableInfoList != null && tableInfoList.size() > 0) {
								Object[] tableInfoObj = (Object[]) tableInfoList.get(0);
								tableName = "" + tableInfoObj[0];
							}
							//System.out.println(tableName + ":::::::::::" + tableId_form);
							if (tableName.equals("收文表") || "23".equals(tableId_form)) { //
								tableId_form = "standard";
							}
							
							
							String add = "/modules/govoffice/gov_documentmanager/forms/view_"+tableId_form+"_receiveform_include.jsp"; 
							 File file = new File(request.getRealPath("") +
                                        add);
								if (!file.exists()) {
									new com.whir.govezoffice.documentmanager.actionsupport.GovCustomAction().replayGovCustomPage(request,tableId_form,"1","1");
							 
								}
							%> 
							
								<jsp:include page="<%=add %>"></jsp:include>  

								
							</div>	
							<!--工作流包含页-->
							 <div>  
								   <%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
						    </div>
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
	<%@ include file="/platform/bpm/pool/pool_include_form_end.jsp"%>
</body>

<script type="text/javascript">

/**
 切换页面
 */
function  changePanle(flag){
	//if( flag == 3 ) flag= 2;
	for(var i=0;i<=4;i++){
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
	if(flag=="3" ){
	   showWorkFlowRelation("docinfo3");
	}

	 //显示
	if(flag=="4" ){
	   showWorkFlowAcc("docinfo4");
	}

	//显示流程记录
	if(flag=="2"){
	   showWorkFlowLog("docinfo2");
	}
}

/**
初始话信息
*/
function initBody(){
	p_wf_processName = $('#p_wf_processName').val();
	var windowWidth = window.screen.availWidth;
	var windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
	window.resizeTo(windowWidth,windowHeight);
	//初始话信息
	 <%if( !"1".equals( request.getParameter("isPrint"))){ %>
    ezFlowinit();
	 <%}%>

}
 <%if( "1".equals( request.getParameter("isPrint"))){ %>
function whir_alert(){
}
<%}%>



var tempHtml = "";
var processFlag = true;
 
var exportUrl = "PrintForm";
var p_wf_processName = "";
var dhtmlFlag = false;

function processContent(){
    var docinfo0 = document.getElementById('docinfo0').innerHTML;
    tempHtml = docinfo0;
    

    if($('#adddelrow_div').length>0)$('#adddelrow_div').remove();
	
    var _this_href = location.href;
    //_this_href = 'http://192.168.0.28:7001';
    _this_href = 'http://'+location.host;
    if(processFlag){
        $('#docinfo0 img').each(function(){
            var src = $(this).attr('src');
            if(src){
                if(src.indexOf("http:")==-1 || src.indexOf("https:")==-1){
                    $(this).attr('src', _this_href + src);
                }
            }
        });
        processFlag = false;
    }
	// $('#docinfo0 img').remove();
    $('#backCommentTbl').remove();
 
    $("tr[id=commTR]").each(function(i){
        var display = $(this).css('display');
        if(display=='none'){
            $(this).remove();
        }
    });
 
   // $("input[type=hidden]").remove();
     $("input[type!=button]").remove();
    processPrintHtml();
 
    docinfo0 = document.getElementById('docinfo0').innerHTML;
    
    var scriptregex = "<scr" + "ipt[^>.]*>[sS]*?</sc" + "ript>";
    var scripts = new RegExp(scriptregex, "gim");
    docinfo0 = docinfo0.replace(scripts, " ");
    docinfo0 = docinfo0.replace(/<script[\w\W]*?\<\/script>/igm, "");
 
    docinfo0 = docinfo0.replace(/<input type=hidden [\w\W]*?>/igm, "");
    docinfo0 = docinfo0.replace(/<object [\w\W]*?>/igm, "");
    docinfo0 = docinfo0.replace(/\<br\>/igm, "\n\r");
 
    docinfo0 = docinfo0.replace(/<link[\w\W]*?\>/igm, "");
 
    return docinfo0;
}
 

function downloadHTML(){
    dhtmlFlag = true;
    var docinfo0 = processContent();
    /*if($.browser.msie){
        document.getElementById('save').ExecWB(4,1);
    }else{*/
        _export2(exportUrl+'!export2html.action', docinfo0);
    //}

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
 


function exportWord(){
	//alert(1);
    var docinfo0 = processContent();
	//alert(docinfo0);
    if(false&&$.browser.msie){
        document.getElementById('docinfo0').innerHTML = "" + docinfo0;
 
        var oWD = new ActiveXObject("Word.Application");
        var oDC = oWD.Documents.Add("",0,1);
        var oRange =oDC.Range(0,1);
        var sel = document.body.createTextRange();
        sel.moveToElementText(document.getElementById('docinfo0'));
        try{
            sel.select();
        }catch(e){}
        sel.execCommand("Copy");
        oRange.Paste();
        oWD.Application.Visible = true;
        oWD.ActiveWindow.View.TableGridlines = false;
        document.execCommand("unselect");
        //设置文档为页面视图
        //oWD.ActiveWindow.ActivePane.View.Type = 3;
        try{
            oWD.ActiveWindow.ActivePane.View.Type = 9;
        }catch(e){
            oWD.ActiveWindow.ActivePane.View.Type = 3;
        }
        oWD.ActiveWindow.ActivePane.View.Zoom.Percentage = 100;
        //document.getElementById('exportHtml').innerHTML = "";
        //oDC.PrintPreview();
    }else{
        _export2(exportUrl+'!export2doc.action', docinfo0);
    }
 
    //endPrintHtml(tempHtml);
}
var dhtmlFlag = true;
function processPrintHtml(){
    $('#docinfo0 table').each(function(i){
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
 
    $('#commTD').each(function(i){
        $(this).prev().attr('style','');//css('border-bottom','1px solid #366AB3;');
    });
}
 
function endPrintHtml(tempHtml){
    document.getElementById('docinfo0').innerHTML = tempHtml;
}


</script>
 
</html>

