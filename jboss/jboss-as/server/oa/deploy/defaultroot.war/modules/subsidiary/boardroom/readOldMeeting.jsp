<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardRoomApplyPO"%>
<%
String userId = session.getAttribute("userId").toString();
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
whir_custom_str="easyui";
if(request.getParameter("gd")!=null&&request.getParameter("gd").toString().equals("1")){
    whir_custom_str+="notip";
}
String boardroomApplyId = request.getParameter("p_wf_recordId")!=null ? request.getParameter("p_wf_recordId") :"";
String motif = request.getParameter("title")!=null ? request.getParameter("title") :"";
motif=java.net.URLDecoder.decode(motif,"UTF-8");

String org_ = session.getAttribute("orgId").toString();

BoardRoomApplyPO po = (BoardRoomApplyPO)request.getAttribute("boardRoomApplyPO");
String formCode = po.getFormCode();
if(motif.equals("")){
	motif = po.getMotif();
}

SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm");
String currentdate = format.format( new Date());

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=motif%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--工作流包含页 js文件-->
   	<%@ include file="/public/include/meta_base_ezflow.jsp"%>
	<%@ include file="/platform/report/graphreport/highcharts/meta_base_highcharts.jsp"%>
	<link   href="/defaultroot/scripts/plugins/easyui/1.3.2/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
	<link   href="/defaultroot/scripts/plugins/easyui/1.3.2/themes/icon.css" rel="stylesheet" type="text/css"/>
	<link   href="/defaultroot/template/css/template_default/template.media.min.css" rel="stylesheet" type="text/css"/>
	<script src="/defaultroot/scripts/plugins/easyui/1.3.2/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="/defaultroot/scripts/static/template.extend.js" type="text/javascript"></script>
	<style type="text/css">
	   .docBodyStyle{ 
		 overflow:auto;
	  } 
	  .doc_Scroll{    height:96%; width:100%; margin-top:33px;  overflow:visible;  }
	  
	  .iframe-cover{display:none;}
	</style>
</head>
<body class="docBodyStyle"  onload="initBody();"> 
	<!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
	<!--style="position:relative;"-->
	<div class="doc_Scroll"  >
	 <%@ include file="/public/include/form_detail.jsp"%>
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline">
					   <div class="doc_Movetitle"  id="id_doc_movetitle">
					     <div class="docRight" ><bean:message bundle="workflow" key="workflow.st"/><span class="redBold" id="viewPrintNum">0</span><bean:message bundle="workflow" key="workflow.printst"/></div>
						 <ul>
							  <li class="aon"  id="Panle0"><a href="#" onClick="" ><bean:message bundle="workflow" key="workflow.newactivitybasicinfo"/></a></li>
						 </ul>
					   </div>  
                       <div class="clearboth"></div> 
                       <div id="docinfo0" class="doc_Content" >
							<!--表单包含页 -->
							<div>
								<div> 
									 <jsp:include page="/platform/custom/ezform/run/showform.jsp" flush="true">
										<jsp:param name="formCode" value="<%=formCode%>"/>
										<jsp:param name="infoId" value="<%=boardroomApplyId%>"/>
									</jsp:include>
								</div>
							</div>	 
							<!--工作流包含页-->
							<div>  
								<%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
								
						    </div>
							
				      </div>
					  <div id="docinfo1" class="doc_Content"  style="display:none;text-align:center" ></div>
					  <div id="docinfo5" class="doc_Content"  style="display:none;"></div>
					  <div id="docinfo6" class="doc_Content"  style="display:none;"></div>
                 </div>
             </td>
         </tr>
     </table>
    
	</div>
</body>
<script type="text/javascript">

//addButton();

/*function addButton(){
	if(doc!=""){
		whirToolbar.addjsonButtonStr("{id:'ViewNotice',name:'会议通知查看',tips:'会议通知查看',img:'/defaultroot/images/toolbar/viewtext.gif',width:'10'}");
		whirToolbar.showToolbar();
	}
	whirToolbar.addjsonButtonStr("{id:'ZfToSend',name:'转发',tips:'转发',img:'/defaultroot/images/toolbar/transend.gif',width:'10'}");
	whirToolbar.showToolbar();
	whirToolbar.addjsonButtonStr("{id:'ZfToCancel',name:'撤办',tips:'撤办',img:'/defaultroot/images/toolbar/transend.gif',width:'10'}");
	whirToolbar.showToolbar();
	whirToolbar.addjsonButtonStr("{id:'SendToMyDayProcess',name:'同步到我的日程',tips:'同步到我的日程',img:'/defaultroot/images/toolbar/feedback.png',width:'10'}");
	whirToolbar.showToolbar();
	var sonDiv = $("#MEETINGNOTICE_SONDIV").attr("style");
	if(sonDiv){
		whirToolbar.addjsonButtonStr("{id:'FJSave',name:'附件保存',tips:'附件保存',img:'/defaultroot/images/toolbar/saveclose.png',width:'10'}");
		whirToolbar.showToolbar();
	}

	if(sendSw=="true"){
		whirToolbar.addjsonButtonStr("{id:'SendToReceive',name:'转收文',tips:'转收文',img:'/defaultroot/images/toolbar/sendtoreceive.png',width:'10'}");
		whirToolbar.showToolbar();
	}

	//whirToolbar.addjsonButtonStr("{id:'Print',name:'打印',tips:'打印',img:'/defaultroot/images/toolbar/print.png',width:'10'}");
	//whirToolbar.showToolbar();
	whirToolbar.addjsonButtonStr("{id:'SendToEnd',name:'送结束',tips:'送结束',img:'/defaultroot/images/toolbar/sendtoreceive.png',width:'10'}");
	whirToolbar.showToolbar();
}*/

/**
 切换页面
 */
function  changePanle(flag){
	if(flag==0){
		$("#docinfo6").html("");
	}
	
	for(var i=0;i<7;i++){
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

	//显示流程描述
	if(flag=="4"){
	   showPrcosssDescription("docinfo4");
	}

	//显示流程跟踪
	if(flag=="5"){
	   showZFLog("docinfo5");
	}

	//显示回执信息
	if(flag=="6"){
	    seeDetail("docinfo6");
	}
}

/**
初始话信息
*/
function initBody(){
	//初始话信息
    ezFlowinit(); 
}
 
</script>
</html>

