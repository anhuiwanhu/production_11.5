<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.whir.i18n.Resource"%>
<%@page import="com.whir.ezoffice.customForm.ui.UIBD"%>
<%@page import="java.util.*"%>
<%
String  localcom = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String  oldrecorId="";
String  public_comment_iWebVersion="6,3,0,178";
String  public_comment_iWebUrl="http://"+request.getServerName()+":"+request.getServerPort()+rootPath+"/iWebRevisionServlet";//取得OfficeServer文件的完整URL
java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
com.whir.ezoffice.workflow.newBD.WorkFlowCommonBD include_comment_wfcBD = new com.whir.ezoffice.workflow.newBD.WorkFlowCommonBD();
String include_p_wf_moduleId=request.getAttribute("p_wf_moduleId")+"";
//打印
String p_wf_isprint=request.getAttribute("p_wf_isprint")==null?"":request.getAttribute("p_wf_isprint").toString();
%>
<style type="text/css">
<!--
#noteDiv {
	position:absolute;
	width:400px;
	height:200px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
	background-color:#ffffff;
	top:17px !important;
	left:auto !important;
	right:0px !important;
}
#noteDiv1 {
	position:absolute;
	width:400px;
	height:200px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
}
.divOver{
    background-color:#003399;
	color:#FFFFFF;
	border-bottom:1px dashed #cccccc;
    width:96%;
	/**height:20px;*/
	line-height:20px;
	cursor:default;
	padding-left:5px;
	/**white-space:nowrap;*/
}
.divOut{
    background-color:#ffffff;
	color:#000000;
	border-bottom:1px dashed #cccccc;
    width:96%;
	/**height:20px;*/
	line-height:20px;
	cursor:default;
	padding-left:5px;
	/**white-space:nowrap;*/
}
-->
</style>
<script>
function setNote_w(obj){
	document.getElementById("flowNote").innerText+=obj.innerText;
}
</script>
<input type="hidden" name="addDivContent"  id="addDivContent" value=""> <!-- 在  常用语中用到-->
<%
int handSignInUse_w = 0;//是否使用了手写签名
int signatureInUse_w = 0;//是否使用了电子签章
java.util.Map include_sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
if(include_sysMap != null && include_sysMap.get("使用手写意见") != null && "1".equals(include_sysMap.get("使用手写意见").toString())){
    handSignInUse_w = 1;//手写签名
}
if(include_sysMap != null && include_sysMap.get("电子签章") != null && "1".equals(include_sysMap.get("电子签章").toString())){
	signatureInUse_w = 1;//电子签章
}


 String userAgent = request.getHeader("User-Agent");
 //
 if(userAgent != null && userAgent.indexOf("IE") >= 0){

 }else{
	 //非IE 不显示电子签章与 手写签名
     handSignInUse_w=0;
	 signatureInUse_w=0;
 }
 

//查找上传方式
int smartInUse_w = 0;
if(include_sysMap != null && include_sysMap.get("附件上传") != null){
	smartInUse_w = Integer.parseInt(include_sysMap.get("附件上传").toString());
}
String include_fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());//session.getAttribute("fileServer").toString();

 

//当前审批人和日期
String writeUser = session.getAttribute("userName").toString();
String writeUserId = session.getAttribute("userId").toString();
com.whir.org.bd.usermanager.UserBD ub = new com.whir.org.bd.usermanager.UserBD();
String writeUserSignature = ub.getSignature(writeUserId);
if(!"".equals(writeUserSignature)){
	writeUserSignature = "<IMG SRC='"+(smartInUse_w==1?rootPath:include_fileServer)+"/upload/peopleinfo/"+writeUserSignature+"'>";
}else{
	writeUserSignature = writeUser;
}

String workflow_accPath=(smartInUse_w==1?rootPath:include_fileServer)+"/upload/workflow_acc/";
 
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String nowTime = df.format(new java.util.Date());


//保护字段 
String protectField_w = request.getAttribute("protectField_w")+""; //	protectField_w += objP[1].toString()+"="+objP[2].toString()+";";
 
 
//电子签章div的位置
String inc_divId_w = java.util.Calendar.getInstance().getTimeInMillis() + "";

//常用语
java.util.List officelist_w = new com.whir.ezoffice.workflow.newBD.WorkFlowBD().getOffiDict(session.getAttribute("userId").toString(),session.getAttribute("domainId").toString());
 


//批示意见 内容列表
List commentList_w= (List)request.getAttribute("commentList_w");  

List tmpList= (List)request.getAttribute("commentTmpList");  
 
 

UIBD uibd = new UIBD();
//25、	“批示意见”字段编辑方式中，可设置“取值范围”，在下拉框中包括2“仅签名”、1“签名+日期”、0“签名+日期时间”。
com.whir.ezoffice.ezform.ui.UIBD   euibd=new  com.whir.ezoffice.ezform.ui.UIBD();

String[][] formCommentFields = null; 
if(include_p_wf_moduleId!=null&&(include_p_wf_moduleId.equals("2")||include_p_wf_moduleId.equals("3")||include_p_wf_moduleId.equals("34"))){  
	formCommentFields=euibd.getCommentFieldsByWfModuleId(include_p_wf_moduleId);
}else{
	formCommentFields = uibd.getCommentFieldsByPageId(request.getAttribute("p_wf_tableId")+"");
}
 

//当前表单名
String p_wf_tableName="";


String openType=request.getAttribute("p_wf_openType")==null?"":request.getAttribute("p_wf_openType").toString();

//当前的批示意见
String p_wf_curCommField=request.getAttribute("p_wf_curCommField")==null?"":request.getAttribute("p_wf_curCommField").toString();

String p_wf_commFieldType=request.getAttribute("p_wf_commFieldType")==null?"":request.getAttribute("p_wf_commFieldType").toString();

 

if(openType.equals("waitingDeal")){
	p_wf_curCommField=request.getAttribute("p_wf_curCommField")==null?"":request.getAttribute("p_wf_curCommField").toString();
}

if(openType.equals("waitingRead")){
	p_wf_curCommField=request.getAttribute("p_wf_curPassRoundCommField")==null?"":request.getAttribute("p_wf_curPassRoundCommField").toString();
}

if(p_wf_curCommField.endsWith(",")){
    p_wf_curCommField=p_wf_curCommField.substring(0,p_wf_curCommField.length()-1);
}
if(p_wf_curCommField.startsWith(",")){
   p_wf_curCommField=p_wf_curCommField.substring(1);
}

if(p_wf_commFieldType.equals("-1")){
    p_wf_curCommField="nullCommentField";
}

//  综合办公等其它模块  p_wf_commFieldType都为空 ,也要批示意见
if(!include_p_wf_moduleId.equals("2")&&!include_p_wf_moduleId.equals("3")&&!include_p_wf_moduleId.equals("34")){
	if(p_wf_commFieldType.equals("0")||p_wf_commFieldType.equals("")||p_wf_commFieldType.equals("null")){
	   p_wf_curCommField="autoCommentField";
	}
}

if(p_wf_curCommField.equals("")){
	p_wf_curCommField="nullCommentField";
}
 
if(formCommentFields!=null){
   //显示时间格式
   nowTime=uibd.getCommentDateFormatStr(p_wf_curCommField, nowTime, formCommentFields, "");
}
 

 //组织名
String nowdealOrgName=euibd.getCommentUserOrgNameWithCommentField(writeUserId, p_wf_curCommField, formCommentFields);

//当前办理人 当前任务的草稿批示意见
String    curDraftContent=request.getAttribute("draftCotent")==null?"":request.getAttribute("draftCotent").toString();
String    curDraftType=request.getAttribute("draftType")==null?"":request.getAttribute("draftType").toString();
String    curDraftAccName="";
String    curDraftAccSName="";

//只有 普通批示意见才显示
if(!curDraftType.equals("0")){
	curDraftContent="";
}
 
 
%>
 <div style="padding:10px;">
<s:if test="p_wf_processType==0">
 <table width="100%" border="0" cellpadding="5" align="center" cellspacing="0" style="border:1px dashed #C6CCD2;;<%if(commentList_w==null||commentList_w.size()<=0){out.println(";display:none;");}%>">
  <tr>
            <td width="12%" align="left" valign="middle">办理意见：</td>
            <td width="88%">
                <%//if(handSignInUse_w){%>
                    <table width="100%"  border="0">
                <%//}
                String[] comm = null;
                for(int j = 0; j < commentList_w.size(); j ++){
                   comm = (String[]) commentList_w.get(j);%>
                   <tr>
					 <td > 
					 <%
						boolean sx = false;
						try{
							 Long.parseLong(comm[1]);
							 sx = true;
						}catch(Exception e){}
						if(sx){
							//使用手写签名
							if(comm[1].endsWith("0000")){%>
								<!-- 电子签章 -->
								<div id="signPosi_<%=comm[1]%>" style='width:98%; height:98%;'></div> 
								<%} else{%> 
									<OBJECT name="incSig<%=j%>" id="incSig<%=j%>" classid="clsid:2294689C-9EDF-40BC-86AE-0438112CA439" codebase="<%=rootPath%>/public/iWebRevision.jsp/iWebRevision.cab#version=<%=public_comment_iWebVersion%>" width="100%" height="180">
										<param name="weburl" value="<%=public_comment_iWebUrl%>">
										<param name="recordid" value="<%=comm[1]%>">
										<param name="fieldname" value="SendOut<%=comm[1]%>">
										<param name="username" value="">
										<param name="Enabled" value="0">
										<param name="PenColor" value="00000000">
										<param name="BorderStyle" value="0">
									</OBJECT>
									<script language="javascript">								
									  function  incSig<%=j%>LoadSignature(){
										 try{   
											 $("#incSig<%=j%>")[0].LoadSignature();
											// eval("document.all.incSig<%=j%>.LoadSignature()");
										 }catch(e){
											 
										 }
									  }					 
									  incSig<%=j%>LoadSignature();
								  </script>
							
						<%
							}
						}else{%>
							<%if(comm[1] != null){%>
								<%=com.whir.common.util.CharacterTool.escapeHTMLTags(comm[1])%>
							<%}%>  
					   <% }%>
						 </td>
						</tr>
                        <tr>
						   <td style="text-align:right" >
							<%//文字
							if(sx){ %>
							  <span style="width:100%;text-align:right"><%=comm[0]%>&nbsp;&nbsp;(<%=comm[2].indexOf(".")>0?comm[2].substring(0,comm[2].indexOf(".")):comm[2]%>)</span>
							<%}else{%>
							    <span style="width:100%;text-align:right"><%=comm[0]%>&nbsp;&nbsp;(<%=comm[2].indexOf(".")>0?comm[2].substring(0,comm[2].indexOf(".")):comm[2]%>)</span>
							<%}%>
						   </td>
						 </tr>
					<%}
                //if(handSignInUse_w){%>
                    </table>
                <%//}%>
          </td>
        </tr>
    </table>
</s:if>
<s:else>
<!---------显示已经保存的批示意见内容---------->
<table width="100%" border="0"  cellspacing="0"  cellpadding="0" align="center" >
 <%
    String[] str2 = null, str3 = null;
	String commentContentType="1";
	String tmpStr4[]=null;

	String activityId=null;
	String activityName=null;
	boolean isgd=true;
	boolean inCommentRange=true;
    if(tmpList!=null&&tmpList.size()>0){
    for(int j = 0; j < tmpList.size(); j ++){  
    	str2=(String[])tmpList.get(j);
	    //判断是否显示意见，如果是无批示意见字段，则不显示
		String actiCommFieldType = str2[6];
		String passRoundCommFieldType = str2[7];
 
	    isgd=true;
	    inCommentRange=include_comment_wfcBD.inCommentRange(session.getAttribute("userId").toString(), session.getAttribute("orgIdString").toString(), str2[3]).booleanValue();
	    activityId=str2[0];
	    activityName=str2[1];

		//是否显示下面的自动追加的tr     当有一个批示意见内容是自动追加的时候 就应该显示自动批示意见tr 当前的table的tr td都是自动追加的批示意见
		boolean displayTr=false;
		for(int kk = 0; kk < commentList_w.size(); kk ++){
			  /**
			   * 活动id,活动名,办理人名,意见,办理时间,   0-4
			   * 步骤数，是否代理办理 ，范围，批示意见字段，批示意见类型， 5-9
			   * 阅件类型， commtype，办理人id，批示意见类型 （0：普通 1：手写签名  2： 电子签章），是否分支任务 10-14
			   * 分支任务数，分支id
			   * 
			   * */
               tmpStr4 = (String[]) commentList_w.get(kk); 
			   String temp_commtype = tmpStr4[11];
			   //1：批示意见对应字段  0：自动增加批示    -1：无批示意见
			   //tmpStr4[8]:whir$wanggl_f3733  tmpStr4[8]:-1
			    

			   /*if(tmpStr4[3]==null||tmpStr4[3].equals("")){
			       continue;
			    } */

			   if(!tmpStr4[0].equals(str2[0]) || ("2".equals(temp_commtype) && "-1".equals(passRoundCommFieldType)) || (!"2".equals(temp_commtype) && "-1".equals(actiCommFieldType))){
						continue;
			   }
			   if((str2[2]==null?"0":str2[2]).equals((tmpStr4[5]==null?"0":tmpStr4[5]))){
				   //当批示意见字段是 空  时  表明是自动追加的批示意见，  但是要排除公文流程
				   if(tmpStr4[8]==null||tmpStr4[8].toString().equals("-1")||tmpStr4[8].toString().equals("")||tmpStr4[8].toString().equals("null")){
					   //
			           //if(tmpStr4[8]!=null&&!tmpStr4[8].toString().equals("-1")&&!tmpStr4[8].toString().equals("")&&!tmpStr4[8].toString().equals("null")){
				       //并且要排除 公文流程
					   if(!include_p_wf_moduleId.equals("2")&&!include_p_wf_moduleId.equals("3")&&!include_p_wf_moduleId.equals("34")){
					       displayTr=true;
					       break;
					   }
				   }
			   }
  
		}
    %>
   <tr id="commTR" style="display:<%=displayTr?"":"none"%>">
      <td>
         <table border="0" width="100%" <%if(j==0 && tmpList.size()>1){out.print("style=\"border:1px dashed #C6CCD2;border-collapse:collapse;\"");}else if(j==tmpList.size()-1){out.print("style=\"border:1px dashed #C6CCD2;border-collapse:collapse;\"");}else{out.print("style=\"border:1px dashed #C6CCD2;border-collapse:collapse;\"");}%> >
		    <tr>
			 <!---此td显示活动名---->
             <td width="120" nowrap align="center"  style="border-bottom:<%=j==(tmpList.size()-1)?"1":"0"%>px dashed #C6CCD2; font-weight:bold; border-right:1px dashed #C6CCD2;"><%=activityName%>：</td>
             <td style="word-break:break-all; padding:0;" id="commTD"     align="left" valign="middle"   >
             <%  if(isgd&&inCommentRange){%>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"> 
                <%
                for(int k = 0; k < commentList_w.size(); k ++){
				    str3 = (String[]) commentList_w.get(k);
				    //判断是否显示意见，如果是无批示意见字段，则不显示
					String commtype = str3[11];

					/*if(str3[3]==null||str3[3].equals("")){
			           continue;
			        } */

					if(!str3[0].equals(str2[0]) || ("2".equals(commtype) && "-1".equals(passRoundCommFieldType)) || (!"2".equals(commtype) && "-1".equals(actiCommFieldType))){
						 continue;
					}
                    
					////步骤数不一致  跳出
					if((str2[2]==null?"0":str2[2]).equals((str3[5]==null?"0":str3[5]))){
					}else{
						 //步骤数不一致  跳出
					     continue;
					}

					//批示意见类型。  0： 普通，1：手写签名  2：电子签章
				    commentContentType=str3[13]==null?"":str3[13];
					String dealContent=str3[3];
					if(dealContent==null){
					   dealContent="";
					}
					String dealUserId=str3[12];
                    String dealUserName=str3[2];
				   // String daalTimeStr=simpleDateFormat.format(str3[4]);	
					String daalTimeStr=str3[4];	
					if(daalTimeStr!=null&&daalTimeStr.indexOf(".")>0){
						daalTimeStr=daalTimeStr.substring(0,daalTimeStr.indexOf("."));
					}

					 //组织名
					String dealOrgName="";


					String commentField=str3[8];
				    String standForUserName=str3[6];


					//显示时间格式
					//当为自定义表单的时候  处理是否显示时间及  时间格式 
					if(formCommentFields!=null){
                        daalTimeStr= uibd.getCommentDateFormatStr(commentField, daalTimeStr, formCommentFields, "");
						dealOrgName=euibd.getCommentUserOrgNameWithCommentField(dealUserId, commentField, formCommentFields);
					}

 
					//如果是自动追加批示意见
					//if("autoCommentField".equals(commentField)){
					//str3[8]: 批示意见字段  
					if(str3[8]==null || "-1".equals(str3[8]) || str3[8].trim().length()<1 || str3[8].trim().toUpperCase().equals("NULL")){	
						%>
					  <tr>
						<td  valign="middle" height="30" style="padding-left:10px; position:relative;">					
						<%if(commentContentType.equals("2")){%>
						 <!-- 电子签章 -->
						<div id="signPosi_<%=dealContent%>" style='width:98%; height:130px;'></div>
						
						<%}
						//手写批注
						if(commentContentType.equals("1")){%>
						<!-- 手写控件 -->
                                <OBJECT name="incSig<%=k%>"  id="incSig<%=k%>" classid="clsid:2294689C-9EDF-40BC-86AE-0438112CA439" codebase="<%=rootPath%>/public/iWebRevision.jsp/iWebRevision.cab#version=<%=public_comment_iWebVersion%>" width="100%" height="180">
                                        <param name="weburl" value="<%=public_comment_iWebUrl%>">
                                        <param name="recordid" value="<%=dealContent%>">
                                        <param name="fieldname" value="SendOut<%=dealContent%>">
                                        <param name="username" value="wanghr">
                                        <param name="Enabled" value="0">
                                        <param name="PenColor" value="00000000">
                                        <param name="BorderStyle" value="0">
										<param name="wmode" value="opaque">
                                  </OBJECT>
                                  <script language="javascript">
							           //加载手写签批的js函数
									   function  incSig<%=k%>LoadSignature(){
										     try{   
												 $("#incSig<%=k%>")[0].LoadSignature();
											    // eval("document.all.incSig<%=k%>.LoadSignature()");
											}catch(e){ 
											}
										}					 
									  incSig<%=k%>LoadSignature();
									  setTimeout("incSig<%=k%>LoadSignature()",500);
							         //document.all.incSig<%=k%>.LoadSignature();document.all.incSig<%=k%>.LoadSignature();
								   </script>                    		
						<%}
						    //文字
						    if(commentContentType.equals("0")){
							  //内容
							  out.println(com.whir.common.util.CharacterTool.escapeHTMLTags(dealContent));
							 
						    }

							 if(commentContentType.equals("4")){
							  //内容
							     String imgpath="";
							     if(dealContent!=null&&dealContent.length()>6){
								    imgpath=dealContent.substring(0,6)+"/";
							     } 
							     out.println("<IMG SRC='"+workflow_accPath+imgpath+dealContent+"'>");   
						     }
							 //文字  4：手机手写签批：5:语音审批
						     if(commentContentType.equals("5")){
								  //内容
								 String iframeHtml="<input type='hidden' name='wfCommentName_iframe"+k+"' id='wfCommentName_iframe"+k+"' value=\""+dealContent+"\" />"+ 
								  " <input type='hidden' name='wfCommentSaveName_iframe"+k+"' id='wfCommentSaveName_iframe"+k+"' value='"+dealContent+"'/>" +
								  " <iframe name='commentIframe"+k+"' id='commentIframe"+k+"' src='"+rootPath+"/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=commentIframe"+k+"&realFileNameInputId=wfCommentName_iframe"+k+"&saveFileNameInputId=wfCommentSaveName_iframe"+k+"&canModify=no&style=body{background-color:%23F6F6F6;}'  scrolling='no'  border='0' frameborder='0' width='100%' height='100%'></iframe>"; 
								  out.println(iframeHtml); 
							 } 
 
						%>
                       </td>
				     </tr>
					 <tr>
					   <td style="text-align:right;padding-bottom:0px;" valign="middle">
					    <%//文字
						if(commentContentType.equals("0")){ 
							String realdealUserName=ub.getSignature(dealUserId).equals("")?dealUserName:("<IMG SRC='"+(smartInUse_w==1?rootPath:include_fileServer)+"/upload/peopleinfo/"+ub.getSignature(dealUserId)+"'>");

							if(commtype!=null&&commtype.equals("3")){
								realdealUserName="转办人："+realdealUserName;
							%> 
							<%}
							%>
							<!--办理人 以及 转办 代办--->
						    <%=realdealUserName+"&nbsp;&nbsp;"+dealOrgName+"&nbsp;&nbsp;"+daalTimeStr+((standForUserName!=null&&!standForUserName.equals("")&&!standForUserName.equals(""))?"<font color=\"blue\">("+standForUserName+"代办)</font>":"")+"&nbsp;&nbsp;"%> 
						<%}else{%>
						   <%=dealUserName+"&nbsp;&nbsp;"+dealOrgName+"&nbsp;&nbsp;"+daalTimeStr+"&nbsp;&nbsp;"%>
						<%}%>
					   </td>
					 </tr>
			       <%}else{
					   //如果不是自动追加 就要用js赋值到表单 相应的div里
					   //js 赋值内容
					   String jsContent="";
					   if(commentContentType.equals("2")){
						  //电子签章
						  jsContent="<div style=\\\"height:130px\\\" ><div id=\\\"signPosi_"+dealContent+"\\\" style='position:absolute;'></div></div>";
						    			
						}
						//手写批注
						if(commentContentType.equals("1")){
                             jsContent+="<div style=\\\"width:100%;\\\">"+                             
                             "   <OBJECT name=\\\"incSig"+k+"\\\"   id=\\\"incSig"+k+"\\\" classid=\\\"clsid:2294689C-9EDF-40BC-86AE-0438112CA439\\\" codebase=\\\""+rootPath+"/public/iWebRevision.jsp/iWebRevision.cab#version="+public_comment_iWebVersion+"\\\" width=\\\"100%\\\" height=\\\"180\\\">"+
                                        "<param name=\\\"weburl\\\" value=\\\""+public_comment_iWebUrl+"\\\">"+
                                        "<param name=\\\"recordid\\\"     value=\\\""+dealContent+"\\\">"+
                                        "<param name=\\\"fieldname\\\"    value=\\\"SendOut"+dealContent+"\\\">"+
                                        "<param name=\\\"username\\\"     value=\\\"\\\">"+
                                        "<param name=\\\"Enabled\\\"      value=\\\"0\\\">"+
                                        "<param name=\\\"PenColor\\\"     value=\\\"00000000\\\">"+
                                        "<param name=\\\"BorderStyle\\\"  value=\\\"0\\\">"+
										"<param name=\\\"wmode\\\"        value=\\\"opaque\\\">"+
                              "   </OBJECT></div>";
							 //eval("document.all.incSig"+k+".LoadSignature()");
                        }
						//文字
						if(commentContentType.equals("0")){
							  //内容
							  jsContent+=com.whir.common.util.CharacterTool.escapeHTMLTags(dealContent);						 
						}
                        
						if(commentContentType.equals("4")){
							  //手机手写内容
							  String imgpath="";
							  if(dealContent!=null&&dealContent.length()>6){
								  imgpath=dealContent.substring(0,6)+"/";
							  } 
							  jsContent+="<IMG SRC='"+workflow_accPath+imgpath+dealContent+"'>";						 
						}


						if(commentContentType.equals("5")){
							  //内容
							   jsContent+="<div style=\\\"width:100%;\\\">"+
							  "<input type='hidden' name='wfCommentName_iframe"+k+"' id='wfCommentName_iframe"+k+"'  value=\\\""+dealContent+"\\\" />"+ 
							  " <input type='hidden' name='wfCommentSaveName_iframe"+k+"' id='wfCommentSaveName_iframe"+k+"' value='"+dealContent+"'/>" +
							  " <iframe name='commentIframe"+k+"' id='commentIframe"+k+"'   src='"+rootPath+"/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=commentIframe"+k+"&realFileNameInputId=wfCommentName_iframe"+k+"&saveFileNameInputId=wfCommentSaveName_iframe"+k+"&canModify=no&style=body{background-color:%23F6F6F6;}'  scrolling='no'  border='0' frameborder='0' width='100%' height='100%'></iframe></div>";						 
						}
 
						
						/*
						批示意见附件
						if(commentAccSaveName!=null&&!commentAccSaveName.equals("")&&!commentAccSaveName.equals("null")){
							jsContent+="<div style=\\\"width:100%;\\\">"+" <iframe id='viewUpload_"+k+"'  name='viewUpload_"+k+"'  height='60' width='100%'  frameborder=0 scrolling=auto  src='"+rootPath+"/ezflow/operation/ezFlow_iframe_viewUpload.jsp?accName="+commentAccDisName+"&accSName="+commentAccSaveName+"&index="+k+"'></iframe></div>";
						}*/

						//文字
						if(commentContentType.equals("0")){
							String realdealUserName=ub.getSignature(dealUserId).equals("")?dealUserName:("<IMG SRC='"+(smartInUse_w==1?rootPath:include_fileServer)+"/upload/peopleinfo/"+ub.getSignature(dealUserId)+"'>");
							if(commtype!=null&&commtype.equals("3")){
							    //jsContent+="转办人：";
								realdealUserName="转办人："+realdealUserName;
							}
						    //<!--办理人 以及 转办 代办--->
						    jsContent+="<div style=\\\"width:100%;text-align:right\\\">"+realdealUserName+"&nbsp;&nbsp;"+dealOrgName+"&nbsp;&nbsp;"+daalTimeStr+((standForUserName!=null&&!standForUserName.equals("")&&!standForUserName.equals(""))?"<font color=\\\"blue\\\">("+standForUserName+"代办)</font>":"")+""+"<br></div>";
						}else{
						    jsContent+="<div style=\\\"width:100%;text-align:right\\\">"+dealUserName+"&nbsp;&nbsp;"+dealOrgName+"&nbsp;&nbsp;"+daalTimeStr+""+"<br></div>";
							if(commentContentType.equals("2")){
                                  jsContent+="<div>&nbsp;&nbsp;&nbsp;&nbsp;</div>";
                                  jsContent+="<div style=\\\"height:45px\\\">&nbsp;&nbsp;&nbsp;&nbsp;</div>";
                            }
						}
						 	
						%>	
						<SCRIPT LANGUAGE="JavaScript">
				        <!--
                        //归档页面的  批示意见赋值不能赋两次
						if($("#workflow_thisIsInGDpage").length <=0){
							 <%
								 String  commentDivName=p_wf_tableName+"-"+commentField;	
								 //公文的批示意见
								 if(include_p_wf_moduleId.equals("2")||include_p_wf_moduleId.equals("3")||include_p_wf_moduleId.equals("34")){
										commentDivName=commentField;
								 }
							 %>
								/*document.getElementById("<%=commentDivName%>").innerHTML=document.getElementById("<%=commentDivName%>").innerHTML
									+"<%=jsContent%>";%*/
								
								 var commentField_js='<%=commentField%>_commentfield';
								 
								 if(commentField_js.indexOf('$')!=-1){
									 commentField_js = commentField_js.replace(/[$]/g, "\\\$"); 
								 }
								 //
								 
								 if($("div[id$='"+commentField_js+"']").length>0){
									$("div[id$='"+commentField_js+"']").eq(0).append("<%=jsContent%>");
								 }  
								<% 
								//手写批注
								if(commentContentType.equals("1")){%>
									 // eval("document.all.incSig"+<%=k%>+".LoadSignature()");
									 //setTimeout("document.all.incSig"+<%=k%>+".LoadSignature()",500);
									 function  incSig<%=k%>LoadSignature(){
										 try{   
											 $("#incSig<%=k%>")[0].LoadSignature();
											// eval("document.all.incSig<%=k%>.LoadSignature()");
										 }catch(e){
											 
										 }
									 }					 
									 incSig<%=k%>LoadSignature();
									 setTimeout("incSig<%=k%>LoadSignature()",500);
								<%}%>
						 }
				          //-->
				        </SCRIPT>
				   <%}%>	
               <%}%>
			   </table>
			 <%}%>
			 </td>
			</tr></table>
			<div style="height:5px;"></div>
            </td>
		 </tr>
		<%}}%>
	</table>
</s:else>
<!-- 退回意见 -->
<%
//不需要
if(false){
    String backCommentStr = new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD().getBackComment(request.getParameter("processId"),request.getParameter("table"),request.getParameter("record"));
	if(backCommentStr==null||backCommentStr.equals("null")){
		backCommentStr="";
	}
%><BR>
    <table id="backCommentTbl" width="100%" border="0" cellpadding="0" align="center" cellspacing="0">

      <tr style="display:'<%="".equals(backCommentStr)?"none":"none"%>'">
		<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"  style="border: 1px dashed #C6CCD2;" >
		  <tr>
            <td width="120" nowrap align="center" valign="middle" style="border-collapse:collapse;">退回意见：</td>
            <td style="word-break:break-all;">
                    <table width="100%" border="0">
					<%=backCommentStr%>
                    </table>
                &nbsp;
            </td>
			</tr></table></td>
        </tr>

    </table>
<BR>
<%}%>


<%

 //待办 待阅 才显示输入批示意见
 if((openType.equals("waitingDeal")||openType.equals("waitingRead"))&&!p_wf_isprint.equals("1")){

	 //如果当前是自动追加批示意见
	 if("autoCommentField".equals(p_wf_curCommField)){%>

	  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin:15px 0 0 0;border:1px dashed #C6CCD2;">
        <tr>
           <td align="left"  style="padding:10px 0 0 14px; font-weight:bold;  "><!-- 办理意见 --><%=Resource.getValue(localcom,"workflow","workflow.ProcessComment")%>：</td>
          
       </tr>
       <tr>
         <td colspan="2" valign="top" nowrap="nowrap">
         <%
		    String SignatureId = new java.util.Date().getTime() + "";
		 %>
			<!-- 填写意见框 -->
			<!-- 普通 -->
	         <table id="signTb1" width="100%" border="0">
				<tr>
				   <td>
				   <div style="position: relative;">
					 <div  style="text-align:right;  padding:0 10px 5px 0;"><a  id="trigger1" href="javascript:;"  rel="noteDiv" ><!-- 常用语 --><%=Resource.getValue(localcom,"workflow","workflow.Frequentusedwords")%></a></div>
						<div id="noteDiv"  value="comment" >
							<%
							  if(officelist_w!=null&&officelist_w.size()>0){
							   for(int i=0;i<officelist_w.size();i++){
								 String offContent=""+officelist_w.get(i);%>
								  <div class="divOut"  onmouseover="this.className='divOver'" onmouseout="this.className='divOut'" onclick="include_set_comment(this,'comment')"><%=offContent%></div>
							   <%}
							}
							%>
						    <div class="divOut"><a href="#"  onclick="addOffical();">>><!-- 添加 --><%=Resource.getValue(localcom,"workflow","workflow.newactivitydefineadd")%></a></div>
						</div>
						</div>
						<textarea  name="comment"  id="comment" cols="50" Class="inputTextarea" onblur="include_checkTextArea(this,'<%=Resource.getValue(localcom,"workflow","workflow.activitycomment")%>',1000);" style="height:100px;width:98%;border:1px solid #cccccc; margin:0 0 0 12px; height:expression((this.scrollHeight+2)<120?120:this.scrollHeight+2)"><%=curDraftContent%></textarea> </td>
					</tr>
	          </table>
			  <!-- 手写控件 -->
			  <%if(handSignInUse_w==1){%>
			  <table id="signTb2" width="100%" border="0"  style="display:none; ">
				  <tr>
				    <td align="right"><button class="btnButton4font" onclick="try{if(!SendOut.OpenSignature()){alert(SendOut.Status);};}catch(e){whir_alert('签章控件未成功安装，请安装后再使用！');}return false;"><!-- 签章 --><%=Resource.getValue(localcom,"workflow","workflow.Signature")%></button>
                      <input type="hidden" name="comment"  id="comment" value="<%=SignatureId%>">
					  <!-- <a href="javascript:" onclick="if (!SendOut.OpenSignature()){alert(SendOut.Status);}">打开签章</a> --></td>
			      </tr>
				  <tr>
				    <td height="120">
					  <OBJECT name="SendOut"  id="SendOut"  classid="clsid:2294689C-9EDF-40BC-86AE-0438112CA439" codebase="<%=rootPath%>/public/iWebRevision.jsp/iWebRevision.cab#version=<%=public_comment_iWebVersion%>" width="100%" height="180" style=" z-index:-1;">
							<param name="weburl" value="<%=public_comment_iWebUrl%>">
							<param name="recordid" value="<%=SignatureId%>">
							<param name="fieldname" value="SendOut<%=SignatureId%>">
							<param name="username" value="<%=session.getAttribute("userName")%>">
							<param name="Enabled" value="1">
							<param name="PenWidth" value="1">
							<param name="PenColor" value="00000000">
							<param name="BorderStyle" value="0">
							<param name="EditType" value="0">	
							<param name="wmode" value="transparent">
							<!-- <param name="wmode" value="opaque" /> -->

					  </OBJECT></td>
					</tr>
				</table>
			<%}%>
			<%if(signatureInUse_w==1){%>
			    <!-- 电子签章 -->
	  			<table id="signTb3" width="100%" border="0" style="display:none;">
				    <tr>
				      <td align="right">
						    <button class="btnButton4font" onclick="include_signature();return false;"><!-- 盖章  --><%=Resource.getValue(localcom,"workflow","workflow.Seal")%></button><button class="btnButton4font" onclick="include_signature2();return false;"><!-- 签字 --><%=Resource.getValue(localcom,"workflow","workflow.Sign")%></button>
					 </td>
        			</tr>
				    <tr>
					    <td  style="position:relative;height:150px">
						    <div id="signPosi_<%=inc_divId_w+"0000"%>" style="width:100%;height:98%;border:1px solid #cccccc;background-color:#ffffff;"></div>
							<input type="hidden" name="comment"  id="comment"  value="<%=inc_divId_w+"0000"%>">
						</td>
					</tr>
	 			 </table>
			<%}%>  
			<%
			//批示意见允许上传附件
			if(true){%>	 
			<!--       <iframe id="accessoryIframe"  name="accessoryIframe"  height="70" width="100%"  frameborder=0 scrolling=auto  src="<%=rootPath%>/work_flow/workflow_iframe_wfAccessory.jsp?accName=<%="curDraftAccName"%>&accSName=<%="curDraftAccSName"%>"></iframe> -->
			 <table   width="100%" border="0" cellpadding="0"  cellspacing="0" >
			   <tr>
				   <td align="left" style="padding-left:14px;">  
					  <input type="hidden" name="wfAccessoryName" id="wfAccessoryName"  />  
					  <input type="hidden" name="wfAccessorySaveName" id="wfAccessorySaveName" /> 
					  <iframe name="accessoryIframe" id="accessoryIframe" src="<%=rootPath%>/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=accessoryIframe&realFileNameInputId=wfAccessoryName&saveFileNameInputId=wfAccessorySaveName&canModify=yes&buttonText=上传附件"  scrolling=""  border="0" frameborder="0" width="520" height="100%"></iframe>
                     
				  </td>
        		 </tr>
		     </table>
		 
			 <%}%>
			 </td>
         </tr>
		 <tr>
		  <td colspan="2" align="right" >
			<div style="padding:0 10px 0px 0; text-align:right;"><input type="hidden" name="commentSignType"  id="commentSignType" value="0"><!-- 用户选择的批示类型 -->
			<input type="hidden" name="commentSignIndex" id="commentSignIndex" value="0"><!-- 用户选择的批示类型 -->
			<%if(handSignInUse_w==1 || signatureInUse_w==1){%>
   				<a href="javascript:;" onClick="changeSignType_w('0');"><!-- 普通 --><%=Resource.getValue(localcom,"workflow","workflow.Common")%></a>&nbsp;&nbsp;<%}%><%if(handSignInUse_w==1){%><a href="javascript:;" onClick="changeSignType_w('1');"><!-- 手写签名 --><%=Resource.getValue(localcom,"workflow","workflow.Handwrittensignature")%></a>&nbsp;&nbsp;<%}if(signatureInUse_w==1){%><a href="javascript:;" onClick="changeSignType_w('2');"><!-- 电子签章 --><%=Resource.getValue(localcom,"workflow","workflow.ElectronicSignature")%></a><%}%>
			<div align="right" ><%=writeUserSignature+" "+nowdealOrgName+" "+nowTime+" "%></div>
            
            </div>		 </td>
		</tr>
     </table>	 
	 <%}else{
	 }
 } 
%>

<!-----带 key 的电子签章------>
<%if(signatureInUse_w==1){%>
<OBJECT id="SignatureControl_w" classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E" codebase="<%=rootPath%>/public/iSignatureHTML.jsp/iSignatureHTML.cab#version=7,2,0,216" width="0" height="0" VIEWASTEXT>
<param name="ServiceUrl" value="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=rootPath%>/public/iSignatureHTML.jsp/Service.jsp"><!--读去数据库相关信息-->
<param name="WebAutoSign" value="0">             <!--是否自动数字签名(0:不启用，1:启用)-->
<!--param name="Weburl"  value="">        <签章服务器响应-->
</OBJECT>
<%}%>


<%
//隐藏
if(true){
  //重新发起之前的意见
  com.whir.ezoffice.workflow.newBD.WorkFlowCommonBD   combd=new com.whir.ezoffice.workflow.newBD.WorkFlowCommonBD();
  java.util.List   oldCommentList=combd.getOldComment(request.getAttribute("p_wf_recordId")+"",request.getAttribute("p_wf_tableId")+"");
  if(oldCommentList!=null&&oldCommentList.size()>0){
%>
<BR>
    <table width="100%" border="0" cellpadding="0" align="center" cellspacing="0">

      <tr>
		<td>
		<table width="100%" border="1" cellpadding="5" cellspacing="0" bordercolor="#bbbbbb" style="background-color:#F6F6F6;">
		    <tr>
            <td width="120" colspan="2" nowrap align="center" valign="middle" style="background-color:#F6F6F6;border-collapse:collapse;">重新发起前的意见： 
            </td>
			</tr>
			<%
		       Object [] bbbb=null;
	           String oldComment="";
			   String oldtime="";
			   String  contenttype="0";
	           for(int ii=0;ii<oldCommentList.size();ii++){
	               bbbb=(Object[])oldCommentList.get(ii);
				   oldrecorId=""+bbbb[9];//重新发起前的recordId
				   oldComment=(bbbb[0]==null||bbbb[0].toString().equals("null"))?"":bbbb[0].toString();
				   oldtime=""+bbbb[2];
                   
				   contenttype=""+bbbb[10];
				   if(oldtime.indexOf(".")>0){
					   oldtime=oldtime.substring(0,oldtime.indexOf("."));
					 }

					 if(oldComment.equals("")||oldComment.equals("null")){
					     continue;
					 }

				  %>
				    <tr>
            <td width="120" nowrap align="center" valign="middle" style="background-color:#F6F6F6;border-collapse:collapse;"><%=bbbb[5]%>：</td>
            <td style="word-break:break-all;">			 
                <table width="100%">
                <% 
					boolean sx = false;
                    try{
                         Long.parseLong(oldComment);
                         sx = true;
                    }catch(Exception e){}



                    if(!contenttype.equals("0")){
                        //使用手写签名
						if(contenttype.equals("2")){%>
							<!-- 电子签章 -->
							<tr>
								<td height="150"><div id="signPosi_<%=oldComment%>" style='position:absolute; width:100%; height:100%;'></div></td>
							</tr>
					   <%
					   } else if(contenttype.equals("1")){
					   %>
                        <tr>
                            <td width="100%" height="150">
                                <OBJECT name="oldincSig<%=ii%>" id="oldincSig<%=ii%>"  classid="clsid:2294689C-9EDF-40BC-86AE-0438112CA439" codebase="<%=rootPath%>/public/iWebRevision.jsp/iWebRevision.cab#version=<%=public_comment_iWebVersion%>" width="100%" height="180">
                                    <param name="weburl" value="<%=public_comment_iWebUrl%>">
                                    <param name="recordid" value="<%=bbbb[0]%>">
                                    <param name="fieldname" value="SendOut<%=bbbb[0]%>">
                                    <param name="username" value="wanghr">
                                    <param name="Enabled" value="0">
                                    <param name="PenColor" value="00000000">
                                    <param name="BorderStyle" value="0">
                                </OBJECT>
                                <script language="javascript"> $("#oldincSig<%=ii%>")[0].LoadSignature();</script>
                            </td>
                        </tr>
                    <%
					  }else if(contenttype.equals("4")){
						  //内容
						  String imgpath="";
						  if(oldComment!=null&&oldComment.length()>6){
							imgpath=oldComment.substring(0,6)+"/";
						  } 
						  out.println("<IMG SRC='"+workflow_accPath+imgpath+oldComment+"'>");  

					  }else if(contenttype.equals("5")){
						  //内容
						  String iframeHtml="<input type='hidden' name='wfCommentName_iframe"+ii+"' id='wfCommentName_iframe"+ii+"' value=\""+oldComment+"\" />"+ 
						  " <input type='hidden' name='wfCommentSaveName_iframe"+ii+"' id='wfCommentSaveName_iframe"+ii+"' value='"+oldComment+"'/>" +
						  " <iframe name='commentIframe"+ii+"' id='commentIframe"+ii+"' src='"+rootPath+"/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=commentIframe"+ii+"&realFileNameInputId=wfCommentName_iframe"+ii+"&saveFileNameInputId=wfCommentSaveName_iframe"+ii+"&canModify=no&style=body{background-color:%23F6F6F6;}'  scrolling='no'  border='0' frameborder='0' width='100%' height='100%'></iframe>"; 
						  out.println(iframeHtml); 
					  }
                     }else{
					%>
					   <span style="width:100%;text-align:left">
					    <%=oldComment+"<br>"%>
			            <%="　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　"+bbbb[1]+"   "+oldtime%></span>                
                     <%}%>
                 </table> 
            </td>
			</tr>             
	      <%} %>
			</table>
			</td>
        </tr>

    </table>
<BR>
<%}%>
<%}%> 
<%
//返工文件显示取消理由 
if("-2".equals(request.getAttribute("p_wf_workStatus")+"")){%>
<BR>
    <table id="backCommentTbl" width="100%" border="0" cellpadding="0" align="center" cellspacing="0">
	<tr>
	  <td height="22" width="70" nowrap><!-- 取消原因 --><bean:message bundle="workflow" key="workflow.CancelReason"/>：</td>
	  <td align="left"><%=new com.whir.ezoffice.workflow.newBD.WorkFlowBD().getCancelReason(""+request.getAttribute("p_wf_workId"))%></td>
	</tr>
	<tr>
	  <td height="22" colspan="2">&nbsp;</td>
	</tr>
	</table>
<BR>
<%}%> 
</div>

<script language="javascript">
<!--
//增加批示字段对应意见到指定位置 likun 20070129
//待办 或者待阅   当前不是自动追加批示意见   并且  不是无批示意见
<%if((openType.equals("waitingDeal")||openType.equals("waitingRead"))&&!p_wf_curCommField.equals("autoCommentField")&&!p_wf_curCommField.equals("nullCommentField")&&!p_wf_curCommField.equals("null")&&!p_wf_isprint.equals("1")){
 
	String SignatureId1 = new java.util.Date().getTime() + "";
    String  commentDivName=p_wf_tableName+"-"+p_wf_curCommField;
%>
  

 var  commentObj=document.getElementById("<%=commentDivName%>");
 var  commentinnerHTML="";



 var index="";
 var useDivArr = 0;
 //复合三种审批方式
 //普通
 commentinnerHTML+=
					"<div id='signTb1'  name='signTb1' style='display:'>"+
					"<div style=\"position: relative;\"><div align='right'    style=\"text-align:right;width:98%;\">&nbsp;&nbsp;&nbsp;<a href=\"javascript:;\"  id=\"trigger1\"   rel=\"noteDiv\"   ><!-- 常用语 --><%=Resource.getValue(localcom,"workflow","workflow.Frequentusedwords")%></a></div>"+
					"<div id=\"noteDiv\" value=\"<%=p_wf_curCommField%>\" >"+
					<%
					  if(officelist_w!=null&&officelist_w.size()>0){
					   for(int i=0;i<officelist_w.size();i++){
						 String offContent=""+officelist_w.get(i);%>
						  "<div class=\"divOut\" onmouseover=\"this.className='divOver'\" onmouseout=\"this.className='divOut'\" onclick=\"include_set_comment(this,'<%=p_wf_curCommField%>')\"><%=offContent%></div>"+

					   <%}
					}
					%>
					"<div class=\"divOut\"><a href=\"#\"  onclick=\"addOffical();\"  >>>添加</a></div></div></div>"+
					"<div><textarea name=\"<%=p_wf_curCommField%>\"  id=\"<%=p_wf_curCommField%>\"  Class=\"inputTextarea\" rows='8' style=\"width:98%;height:expression((this.scrollHeight+2)<120?120:this.scrollHeight+2)\" onblur=\"include_checkTextArea(this,'<%=Resource.getValue(localcom,"workflow","workflow.activitycomment")%>',1000);\"><%=(curDraftContent==null?"":curDraftContent.replaceAll("\"","'").replaceAll("\n","&#13;&#10;").replaceAll("\r",""))%></textarea>&nbsp;</div></div>";

 //手写
 <%if(handSignInUse_w==1){%>
    commentinnerHTML +=
					"<div id='signTb2' style='display:none'>"+
					"<div valign=bottom align=\"right\"><button class=btnButton4font onclick=\"try{if (!<%=p_wf_curCommField%>_SendOut.OpenSignature()){alert(<%=p_wf_curCommField%>_SendOut.Status);};}catch(e){whir_alert('签章控件未成功安装，请安装后再使用！');}return false;\"><!-- 签章 --><%=Resource.getValue(localcom,"workflow","workflow.Signature")%></button></div>"+				"<div>"+
					"<OBJECT name=\"<%=p_wf_curCommField%>_SendOut\"  id=\"<%=p_wf_curCommField%>_SendOut\" classid=\"clsid:2294689C-9EDF-40BC-86AE-0438112CA439\" codebase=\"<%=rootPath%>/public/iWebRevision.jsp/iWebRevision.cab#version=<%=public_comment_iWebVersion%>\" width=\"100%\" height=180>"
                			+"<param name=\"weburl\" value=\"<%=public_comment_iWebUrl%>\">"
            				+"<param name=\"recordid\" value=\"<%=SignatureId1%>"+index+"\">"
                			+"<param name=\"fieldname\" value=\"SendOut<%=SignatureId1%>"+index+"\">"
                			+"<param name=\"username\" value=\"<%=session.getAttribute("userName")%>\">"
                			+"<param name=\"Enabled\" value=\"1\">"
               	 			+"<param name=\"PenColor\" value=\"00000000\">"
                			+"<param name=\"BorderStyle\" value=\"0\">"
                			+"<param name=\"EditType\" value=\"0\"><param name=\"PenWidth\" value=\"1\">"
                                        +"<Param Name=\"ShowScale\" value=\"50\">"
            				+"</OBJECT>"
            				+"<input type=\"hidden\" name=\"<%=p_wf_curCommField%>\"  id=\"<%=p_wf_curCommField%>\" value=\"<%=SignatureId1%>"+index+"\"></div>"+
					"</div>";
 <%}%>

 <%if(signatureInUse_w==1){%>
 //电子签章
 commentinnerHTML+="<div id='signTb3' style='position:relative;width:100%;height:130px;display:none' >"+
						//"<div valign=bottom align=\"right\"></div>&nbsp;"+
						"<div id=signPosi_<%=inc_divId_w+"0000"%> style='position:absolute;width:100%;height:100%;'><div valign=bottom align=\"right\"><button class=btnButton4font onclick='include_signature();return false;'><!-- 盖章 --><%=Resource.getValue(localcom,"workflow","workflow.Seal")%></button><button class=btnButton4font onclick='include_signature2();return false;'><!-- 签字 --><%=Resource.getValue(localcom,"workflow","workflow.Sign")%></button></div><input type=\"hidden\" name=\"<%=p_wf_curCommField%>\"  id=\"<%=p_wf_curCommField%>\"  value=\"<%=inc_divId_w+"0000"%>\"></div>"+
					"</div>";
 <%}%>


<%
 //批示意见允许上传附件
 if(true){%>
    /*commentObj.innerHTML+='<div><iframe id="accessoryIframe"  name="accessoryIframe"  height="70" width="98%"  frameborder=0 scrolling=auto  src="<%=rootPath%>/work_flow/workflow_iframe_wfAccessory.jsp?accName=<%=curDraftAccName%>&accSName=<%=curDraftAccSName%>"></iframe></div>';*/
    var iframHtml='<div>'+
                  '<input type="hidden" name="wfAccessoryName" id="wfAccessoryName"  />'+
	              '<input type="hidden" name="wfAccessorySaveName" id="wfAccessorySaveName" />' +
	              '<iframe name="accessoryIframe" id="accessoryIframe" src="<%=rootPath%>/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=accessoryIframe&realFileNameInputId=wfAccessoryName&saveFileNameInputId=wfAccessorySaveName&canModify=yes&buttonText=上传附件"  scrolling="no"  border="0" frameborder="0" width="100%" height="100%"></iframe>';
	commentinnerHTML+=iframHtml;

<%}%>
 
 commentinnerHTML+=
					"<div align=\"right\"><input type=\"hidden\" name=\"commentSignType\"  id=\"commentSignType\" value=\"0\"><input type=\"hidden\" name=\"commentSignIndex\"  id=\"commentSignIndex\"   value=\"0\">"+
					"<%if(handSignInUse_w==1 || signatureInUse_w==1){%><a href=\"javascript:;\" onClick=\"changeSignTypeArr('0',"+useDivArr+");return false;\"><!-- 普通 --><%=Resource.getValue(localcom,"workflow","workflow.Common")%></a>&nbsp;&nbsp;<%}%><%if(handSignInUse_w==1){%><a href=\"javascript:;\""+ "onClick=\"changeSignTypeArr('1',"+useDivArr+");return false;\"><!-- 手写签名 --><%=Resource.getValue(localcom,"workflow","workflow.Handwrittensignature")%></a>&nbsp;&nbsp;<%}if(signatureInUse_w==1){%><a href=\"javascript:;\" onClick=\"changeSignTypeArr('2',"+useDivArr+");return false;\"><!-- 电子签章 --><%=Resource.getValue(localcom,"workflow","workflow.ElectronicSignature")%></a>&nbsp;&nbsp;<%}%></div>";
 commentinnerHTML += "<div align=\"right\"><%=writeUserSignature+" "+nowdealOrgName+" "+nowTime+""%></div>";
 

 var p_wf_curCommField_js='<%=p_wf_curCommField%>_commentfield';
 
 if(p_wf_curCommField_js.indexOf('$')!=-1){
	 p_wf_curCommField_js = p_wf_curCommField_js.replace(/[$]/g, "\\\$"); 
 }
 //
 
 if($("div[id$='"+p_wf_curCommField_js+"']").length>0){
    $("div[id$='"+p_wf_curCommField_js+"']").eq(0).append(commentinnerHTML);
 } 
			  
<%}%>
 

function changeSignTypeArr(type, i){
	var len =$("#commentSignType").length;
	if(len>1){
		if(type=='0'){
			if($("#signTb1").length >0){
                $("#signTb1")[i].show();
			}
			if($("#signTb2").length >0){
				$("#signTb2")[i].hide();
			}
			if($("#signTb3").length >0){
				$("#signTb3")[i].hide();
			}
		} else if(type=='1'){
			if($("#signTb1").length >0){
                $("#signTb1")[i].hide();
			}
			if($("#signTb2").length >0){
				$("#signTb2")[i].show();
			}
			if($("#signTb3").length >0){
				$("#signTb3")[i].hide();
			}
		} else if(type=='2'){
			if($("#signTb1").length >0){
                $("#signTb1")[i].hide();
			}
			if($("#signTb2").length >0){
				$("#signTb2")[i].hide();
			}
			if($("#signTb3").length >0){
				$("#signTb3")[i].show();
			}
		}

		$("#commentSignType")[i].value=type;
		$("#commentSignIndex")[i].value=type;
 
		
		//判断电子签章选项
		if($("#signTb2").length <=0&& type=='2'){
			$("#commentSignIndex")[i].value=1; 
		}
	} else{
		changeSignType_w(type);
	}
}

function changeSignType_w(type){
	if(type=='0'){
	    if($("#signTb1").length >0){
			$("#signTb1").show();
		}
		if($("#signTb2").length >0){
			$("#signTb2").hide();
		}
		if($("#signTb3").length >0){
			$("#signTb3").hide();
		} 
	} else if(type=='1'){
		if($("#signTb1").length >0){
			$("#signTb1").hide();
		}
		if($("#signTb2").length >0){
			$("#signTb2").show();
		}
		if($("#signTb3").length >0){
			$("#signTb3").hide();
		} 
	} else if(type=='2'){
		 if($("#signTb1").length >0){
			$("#signTb1").hide();
		}
		if($("#signTb2").length >0){
			$("#signTb2").hide();
		}
		if($("#signTb3").length >0){
			$("#signTb3").show();
		} 
	}
	$("#commentSignType").val(type);
	$("#commentSignIndex").val(type); 

	//判断电子签章选项
	if($("#signTb2").length<=0&& type=='2'){
		$("#commentSignIndex").val(1); 
	}
}

function changeSignature(name,type){
    var obj=document.getElementsByName(name);
	//alert(name);
	if(obj.EditType== 0){
		//手写变键盘
		obj.EditType=1;
		//eval("document.all."+name).EditType = 1;
		document.getElementsByName("signatureHref"+name).innerHTML="切换手写";
		//eval("document.all.signatureHref"+name).innerHTML = "切换手写";
	}else{
		//键盘变手写
		obj.EditType=0;
		document.getElementsByName("signatureHref"+name).innerHTML="切换键盘";
	}
}

/**
检测字符数
*/
function include_checkTextArea(obj, tmp, len){
	var text=obj.value;
    if(text.length > len){
	    whir_alert(tmp + "<%=Resource.getValue(localcom,"workflow","workflow.notexceedy")%>" + len + "！",function(){});
        obj.value=text.substring(0,len);
        obj.focus();
    }
}

function include_offiDict(userId, field){
       window.open('<%=rootPath%>/work_flow/workflow_offiDict.jsp?userId=' + userId + '&textAreaName=' + field,'','menubar=0,scrollbars=yes,locations=0,width=400,height=200,resizable=yes');
}


/**
设置批示意见框里的值
*/
function include_set_comment(obj,commentName){
	var val=$(obj).text();
    var  cobj=document.getElementById(commentName);
	if(cobj.length){
        cobj[0].value=cobj[0].value+val;
	} else{
		cobj.value=cobj.value+val;
	}
}

/**
新加常用语
*/
function  addOffical(){
	//
    var openurl='<%=rootPath%>/OfficalDictionAction!addOfficalDiction.action';
    openWin({url:openurl,width:600,height:300,winName:''});
}



function addDivContent(){
	var adddivcontent=$("#addDivContent").val();
	var comment=document.getElementById("noteDiv").getAttribute("value");
	document.getElementById("noteDiv").innerHTML= ""+"<div class='divOut' onmouseover='this.className=\"divOver\"' onmouseout='this.className=\"divOut\"' onclick=\"include_set_comment(this,\'"+comment+"\');\">"+adddivcontent+"<\/div>"+document.getElementById("noteDiv").innerHTML;
}

//电子签章
var wnd;
//作用：进行甲方签章
function include_signature() {
	if( wnd != undefined ){
		var results = wnd.split(";");
		$("#SignatureControl_w")[0].CharSetName = results[0];		//多语言集
		$("#SignatureControl_w")[0].WebAutoSign = results[1];		//自动数字签名
		$("#SignatureControl_w")[0].WebCancelOrder = results[2];    //撤消顺序
		$("#SignatureControl_w")[0].PassWord = results[3];			//签章密码
		var tmp = $("#SignatureControl_w")[0].WebSetFontOther((results[4]=="1"?true:false),results[5],results[6],results[7],results[8],results[9],(results[10]=="1"?true:false));				//设置签章附加文字格式
		$("#SignatureControl_w")[0].WebIsProtect=results[11];	//保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
    }else{
		$("#SignatureControl_w")[0].WebIsProtect=1;			    //保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
	}
	//$("#SignatureControl_w")[0].RemberFontOther=1;
	try{
		var mXml = "<?xml version='1.0' encoding='GB2312' standalone='yes'?>";
		mXml = mXml + "  <Signature>";
		mXml = mXml + "    <OtherParam>";
		mXml = mXml + "	    <RemberFontOther>1</RemberFontOther>"; 
		mXml = mXml + "    </OtherParam>"; 
		mXml = mXml + "	    <RememberPassword>true</RememberPassword>";//是否自动记忆密码  mXml = mXml + "    </OtherParam>";
		mXml = mXml + "  </Signature>";
		$("#SignatureControl_w")[0].XmlConfigParam = mXml;
		
		$("#SignatureControl_w")[0].FieldsList="<%=protectField_w%>";        //所保护字段
		$("#SignatureControl_w")[0].DivId="signPosi_<%=inc_divId_w+"0000"%>";//签章所在的层
		$("#SignatureControl_w")[0].Position(100,0);                         //签章位置
		$("#SignatureControl_w")[0].SaveHistory="False";                     //是否自动保存历史记录,true保存  false不保存  默认值false
		$("#SignatureControl_w")[0].UserName="lyj";                          //文件版签章用户
		$("#SignatureControl_w")[0].WebCancelOrder=1;			             //签章撤消原则设置, 0无顺序 1先进后出  2先进先出  默认值0
		$("#SignatureControl_w")[0].WebSetFontOther(false,"","1","宋体",11,"$000000","False");//设置签章样式
		$("#SignatureControl_w")[0].RunSignature();                         //执行签章操作
	}catch(e){
		whir_alert("签章控件未成功安装，请安装后再使用！");
		return false;
	}
}

//作用：进行手写签名
function include_signature2() {
	$("#SignatureControl_w")[0].FieldsList=""       //所保护字段
	if( wnd != undefined ){
		var results = wnd.split(";");
		$("#SignatureControl_w")[0].CharSetName = results[0];		//多语言集
		$("#SignatureControl_w")[0].WebAutoSign = results[1];		//自动数字签名
		$("#SignatureControl_w")[0].WebCancelOrder = results[2];	//撤消顺序
		$("#SignatureControl_w")[0].PassWord = results[3];			//签章密码
		$("#SignatureControl_w")[0].WebIsProtect=results[11];		//保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
	}else {
        $("#SignatureControl_w")[0].WebCancelOrder=0;			//签章撤消原则设置, 0无顺序 1先进后出  2先进先出  默认值0
		$("#SignatureControl_w")[0].WebIsProtect=1;			    //保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
	}

	try{
		var mXml = "<?xml version='1.0' encoding='GB2312' standalone='yes'?>";
		mXml = mXml + "  <Signature>";
		mXml = mXml + "    <OtherParam>";
		mXml = mXml + "	    <RemberFontOther>1</RemberFontOther>"; 
		mXml = mXml + "    </OtherParam>"; 
		mXml = mXml + "	    <RememberPassword>true</RememberPassword>";//是否自动记忆密码  mXml = mXml + "    </OtherParam>";
		mXml = mXml + "  </Signature>";
		$("#SignatureControl_w")[0].XmlConfigParam = mXml;

		$("#SignatureControl_w")[0].FieldsList="<%=protectField_w%>";        //所保护字段
		$("#SignatureControl_w")[0].DivId="signPosi_<%=inc_divId_w+"0000"%>";//签章所在的层
		$("#SignatureControl_w")[0].Position(0,0);                           //手写签名位置
		//$("#SignatureControl_w")[0].SaveHistory="false";                   //是否自动保存历史记录,true保存  false不保存  默认值false
		$("#SignatureControl_w")[0].RunHandWrite();                          //执行手写签名
	}catch(e){
		whir_alert("签章控件未成功安装，请安装后再使用！");
		return false;
	}
}

<%if(signatureInUse_w==1){%>
	try{
		$("#SignatureControl_w")[0].ShowSignature($("#p_wf_recordId").val());
		<%if(oldrecorId!=null&&!oldrecorId.equals("null")&&!oldrecorId.equals("")){%>
			//$("#SignatureControl_w")[0].ShowSignature('<%=oldrecorId%>');
		<%}%>
	}catch(e){
	}
<%}%>


//?????????????????????????????? 疑问
var tt_commTD = document.getElementsByName("commTD");
var tt_commTR = document.getElementsByName("commTR");
if(tt_commTD && tt_commTR) {
    for(var ii  = 0; ii < tt_commTD.length; ii ++) {
        var tmp = tt_commTD[ii].innerHTML;
        if(tmp.indexOf("<TBODY></TBODY>") == 31) {
           tt_commTR[ii].style.display = "none";
        }
    }
}


// 给 常用语添加 弹出层
//$("#trigger1").powerFloat({offsets :{x:0, y:-30} });
try{
    $("#trigger1").powerFloat();
}catch(e){
}
 
<%  
   // 手写签名 与 电子签章不支持在非IE下操作
   if(handSignInUse_w==1||signatureInUse_w==1){
%>
	$(document).ready(function(){
	   if($.browser.msie) { 
	   }else{
           whir_alert('本页面可能包含电子签章或手写签名,不支持在非IE下操作！',function(){});
	   }
	});
<%}%>

//-->
</script>