<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
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
String p_wf_tableId=request.getParameter("p_wf_tableId")==null?"":request.getParameter("p_wf_tableId").toString(); 
String p_wf_processType=request.getParameter("p_wf_processType")==null?"":request.getParameter("p_wf_processType").toString(); 
String p_wf_recordId=request.getParameter("p_wf_recordId")==null?"":request.getParameter("p_wf_recordId").toString(); 


 
 String selectSql= "select worktype  from  wf_work  where  worktable_id=:worktable_id   and  workrecord_id=:workrecord_id ";	
 Map varMap=new HashMap();
 varMap.put("worktable_id", p_wf_tableId);
 varMap.put("workrecord_id",p_wf_recordId); 
 Object [] pObj=null; 
 com.whir.common.db.Dbutil dbutil=new com.whir.common.db.Dbutil();
 try { 
	pObj=dbutil.getFirstDataBySQL(selectSql,varMap); 
	p_wf_processType=""+pObj[0];
 } catch (Exception e) { 
	e.printStackTrace();
 }
 if(p_wf_tableId!=null&&!p_wf_tableId.equals("")&&!p_wf_tableId.equals("null")&&
    p_wf_processType!=null&&!p_wf_processType.equals("")&&!p_wf_processType.equals("null")){
/**
 * 活动id,活动名,办理人名,意见,办理时间,   0-4
 * 步骤数，是否代理办理 ，范围，批示意见字段，批示意见类型， 5-9
 * 阅件类型， commtype，办理人id，批示意见类型 （0：普通 1：手写签名  2： 电子签章），是否分支任务 10-14
 * 分支任务数，分支id
 * 
 * */
 List commentList_w = new com.whir.ezoffice.workflow.newBD.WorkFlowBD()
		.getDealWithCommentNotBack(p_wf_tableId, p_wf_recordId,p_wf_processType);

 List tmpList = new java.util.ArrayList();
 
 //业务流程才处理
 if(p_wf_processType.equals("1")){		
	
	 String disActivityId = "";
	 String disCurStepCount = "";
	 String deal_isForkTask="";
	 String deal_forkStepCount="";
	 String deal_forkId="";
	 if(commentList_w!=null&&commentList_w.size()>0){              
		 for(int j = 0; j < commentList_w.size(); j ++){
			 String[] str2 = (String[]) commentList_w.get(j);
			 deal_isForkTask=str2[14];
			 if(deal_isForkTask.equals("0")){
				 //
				 if(!disActivityId.equals(str2[0]) || !disCurStepCount.equals(str2[5])){
					 disActivityId = str2[0];
					 disCurStepCount = str2[5];				
					 deal_forkStepCount=str2[15];
					 deal_forkId=str2[16];
					 //活动id,活动名,str2,范围,批示意见字段,commtype,批示意见类型,阅件类型,批示意见类型 （0：普通 1：手写签名  2： 电子签章）
					 String[] str3 = {str2[0],str2[1],str2[5],str2[7],str2[8],str2[11],str2[9],str2[10],str2[13]};
					 tmpList.add(str3);
				 }
			 }else{
				 if(!disActivityId.equals(str2[0])||!(deal_forkStepCount.equals(str2[15])&&deal_forkId.equals(str2[16]))){
					disActivityId = str2[0];
					disCurStepCount = str2[5];
					deal_forkStepCount=str2[15];
					deal_forkId=str2[16];
					//活动id,活动名,str2,范围,批示意见字段,commtype,批示意见类型,阅件类型,批示意见类型 （0：普通 1：手写签名  2： 电子签章）
					String[] str3 = {str2[0],str2[1],str2[5],str2[7],str2[8],str2[11],str2[9],str2[10],str2[13]};
					tmpList.add(str3);
				}
			 }
		 }
	 }	 
 }

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
     //handSignInUse_w=0;
	 //signatureInUse_w=0;
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


java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String nowTime = df.format(new java.util.Date());


//保护字段 
String protectField_w = request.getAttribute("protectField_w")+""; //	protectField_w += objP[1].toString()+"="+objP[2].toString()+";";
 
 
//电子签章div的位置
String inc_divId_w = java.util.Calendar.getInstance().getTimeInMillis() + "";
 
com.whir.ezoffice.ezform.ui.UIBD   euibd=new  com.whir.ezoffice.ezform.ui.UIBD();
UIBD uibd = new UIBD();
//25、	“批示意见”字段编辑方式中，可设置“取值范围”，在下拉框中包括2“仅签名”、1“签名+日期”、0“签名+日期时间”。
String[][] formCommentFields = null; 
if(include_p_wf_moduleId!=null&&(include_p_wf_moduleId.equals("2")||include_p_wf_moduleId.equals("3")||include_p_wf_moduleId.equals("34"))){  
	formCommentFields=euibd.getCommentFieldsByWfModuleId(include_p_wf_moduleId);
}else{
	formCommentFields = uibd.getCommentFieldsByPageId(p_wf_tableId+"");
}

//当前表单名
String p_wf_tableName="";  

//当前的批示意见
String p_wf_curCommField=request.getAttribute("p_wf_curCommField")==null?"":request.getAttribute("p_wf_curCommField").toString();

String p_wf_commFieldType=request.getAttribute("p_wf_commFieldType")==null?"":request.getAttribute("p_wf_commFieldType").toString();

 
if(formCommentFields!=null){
   //显示时间格式
   nowTime=uibd.getCommentDateFormatStr(p_wf_curCommField, nowTime, formCommentFields, "");
}


 
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
<%
  if(p_wf_processType.equals("0")){
%>
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
<%}else{%> 
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
             <td width="120" nowrap align="center"  style="border-bottom:<%=j==(tmpList.size()-1)?"1":"0"%>px; font-weight:bold; border-right:1px dashed #C6CCD2;"><%=activityName%>：</td>
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
					String commentField=str3[8];
				    String standForUserName=str3[6];
                    String dealOrgName="";

					//显示时间格式
					//当为自定义表单的时候  处理是否显示时间及  时间格式 
					if(formCommentFields!=null){
                        daalTimeStr= uibd.getCommentDateFormatStr(commentField, daalTimeStr, formCommentFields, "");
						 //组织名
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
						<div id="signPosi_<%=dealContent%>" style='width:98%; height:130px'></div>
						
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
							%>
						<%}
 
						%>
                       </td>
				     </tr>
					 <tr>
					   <td style="text-align:right;padding-bottom:10px;" valign="middle" >
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
						   jsContent+="<div style=\\\"width:100%;text-align:right\\\">"+realdealUserName+"&nbsp;&nbsp;"+dealOrgName+"&nbsp;&nbsp;"+daalTimeStr+((standForUserName!=null&&!standForUserName.equals("")&&!standForUserName.equals(""))?"<font color=\\\"blue\\\">("+standForUserName+"代办)</font>":"")+""+"<br><br></div>";
						}else{
						      jsContent+="<div style=\\\"width:100%;text-align:right\\\">"+dealUserName+"&nbsp;&nbsp;"+dealOrgName+"&nbsp;&nbsp;"+daalTimeStr+""+"<br><br></div>";
						}
						 	
						%>	
						<SCRIPT LANGUAGE="JavaScript">
				        <!--
						 <%
							 String  commentDivName=p_wf_tableName+"-"+commentField;	
						     //公文的批示意见
						     if(include_p_wf_moduleId.equals("2")||include_p_wf_moduleId.equals("3")||include_p_wf_moduleId.equals("34")){
                                    commentDivName=commentField;
							 }
						 %>
					        /*document.getElementById("<%=commentDivName%>").innerHTML=document.getElementById("<%=commentDivName%>").innerHTML
								+"<%=jsContent%>";%*/
							
							 var commentField_js='<%=commentField%>';
							 
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
<%}%>
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
//返工文件显示取消理由 
if("-2".equals(request.getAttribute("p_wf_workStatus")+"")){%>
<BR>
    <table id="backCommentTbl" width="100%" border="0" cellpadding="0" align="center" cellspacing="0">
	<tr>
	  <td height="22" width="70" nowrap><!-- 取消原因 --><bean:message bundle="workflow" key="workflow.CancelReason"/>：</td>
	  <td align="left"><%=new com.whir.ezoffice.workflow.newBD.WorkFlowBD().getCancelReason(request.getParameter("work"))%></td>
	</tr>
	<tr>
	  <td height="22" colspan="2">&nbsp;</td>
	</tr>
	</table>
<BR>
<%}%>  
<%if(signatureInUse_w==1){%>
<OBJECT id="SignatureControl_w" classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E" codebase="<%=rootPath%>/public/iSignatureHTML.jsp/iSignatureHTML.cab#version=7,2,0,216" width="0" height="0" VIEWASTEXT>
<param name="ServiceUrl" value="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=rootPath%>/public/iSignatureHTML.jsp/Service.jsp"> 
<param name="WebAutoSign" value="0">  
</OBJECT>
<%}%> 
</div>

<script language="javascript">
 
  
  
//电子签章
var wnd;
//作用：进行甲方签章
function include_signature() {
	if( wnd != undefined ){
		var results = wnd.split(";");
		$("#SignatureControl_w")[0].CharSetName = results[0];		//多语言集
		$("#SignatureControl_w")[0].WebAutoSign = results[1];		//自动数字签名
		$("#SignatureControl_w")[0].WebCancelOrder = results[2];		//撤消顺序
		$("#SignatureControl_w")[0].PassWord = results[3];			//签章密码
		var tmp = $("#SignatureControl_w")[0].WebSetFontOther((results[4]=="1"?true:false),results[5],results[6],results[7],results[8],results[9],(results[10]=="1"?true:false));				//设置签章附加文字格式
		$("#SignatureControl_w")[0].WebIsProtect=results[11];		//保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
    }else{
		$("#SignatureControl_w")[0].WebIsProtect=1;			    //保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
	}
	$("#SignatureControl_w")[0].FieldsList="<%=protectField_w%>";       //所保护字段
	$("#SignatureControl_w")[0].DivId="signPosi_<%=inc_divId_w+"0000"%>";                     //签章所在的层
	$("#SignatureControl_w")[0].Position(100,0);                     //签章位置
	$("#SignatureControl_w")[0].SaveHistory="False";                    //是否自动保存历史记录,true保存  false不保存  默认值false
	$("#SignatureControl_w")[0].UserName="lyj";                         //文件版签章用户
	$("#SignatureControl_w")[0].WebCancelOrder=1;			    //签章撤消原则设置, 0无顺序 1先进后出  2先进先出  默认值0
	$("#SignatureControl_w")[0].WebSetFontOther(false,"","1","宋体",11,"$000000","False");//设置签章样式
	$("#SignatureControl_w")[0].RunSignature();                          //执行签章操作
}

//作用：进行手写签名
function include_signature2() {
	$("#SignatureControl_w")[0].FieldsList=""       //所保护字段
	if( wnd != undefined ){
		var results = wnd.split(";");
		$("#SignatureControl_w")[0].CharSetName = results[0];		//多语言集
		$("#SignatureControl_w")[0].WebAutoSign = results[1];		//自动数字签名
		$("#SignatureControl_w")[0].WebCancelOrder = results[2];		//撤消顺序
		$("#SignatureControl_w")[0].PassWord = results[3];			//签章密码
		$("#SignatureControl_w")[0].WebIsProtect=results[11];		//保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
	}else {
        $("#SignatureControl_w")[0].WebCancelOrder=0;			            //签章撤消原则设置, 0无顺序 1先进后出  2先进先出  默认值0
		$("#SignatureControl_w")[0].WebIsProtect=1;			    //保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
	}
	$("#SignatureControl_w")[0].FieldsList="<%=protectField_w%>";      //所保护字段
	$("#SignatureControl_w")[0].DivId="signPosi_<%=inc_divId_w+"0000"%>";                   //签章所在的层
	$("#SignatureControl_w")[0].Position(0,0);                       //手写签名位置
	//$("#SignatureControl_w")[0].SaveHistory="false";                   //是否自动保存历史记录,true保存  false不保存  默认值false
	$("#SignatureControl_w")[0].RunHandWrite();                          //执行手写签名
}

<%if(signatureInUse_w==1){%>
	try{
     $("#SignatureControl_w")[0].ShowSignature(<%=p_wf_recordId%>);
     <%if(oldrecorId!=null&&!oldrecorId.equals("null")&&!oldrecorId.equals("")){%>
	     //$("#SignatureControl_w")[0].ShowSignature('<%=oldrecorId%>');
	<%}%>
	}catch(e){
	}
<%}%> 
//-->
</script>
<%}%>