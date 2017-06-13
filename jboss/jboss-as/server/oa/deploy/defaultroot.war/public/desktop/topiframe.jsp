<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.remind.RemindInfo"%>
<%@ page import="com.whir.ezoffice.workmanager.event.po.EventPO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String usedPortal = request.getParameter("usedPortal");

//-----判断该账号在其他机器上是否有登录，如果有登录，将本客户端踢出---2009-05-19----start
com.whir.org.bd.usermanager.UserBD userBD = new com.whir.org.bd.usermanager.UserBD();
String returnStr = userBD.kickoutUser(request);
//-----判断该账号在其他机器上是否有登录，如果有登录，将本客户端踢出---2009-05-19----end

if(returnStr.equals("yes")){//另一客户端用同一帐号登录了
%>
<script>
<%if("1".equals(usedPortal)){%>
    parent.parent.window.location.href="<%=rootPath%>/portal.jsp?errorType=kickout";
<%}else{%>    
    parent.parent.window.location.href="<%=rootPath%>/login.jsp?errorType=kickout";
<%}%>
</script>
<%
}
if(session==null || session.getAttribute("userId")==null){
%>
<script>
<%if("1".equals(usedPortal)){%>
    parent.parent.window.location.href="<%=rootPath%>/portal.jsp?errorType=overtime";
<%}else{%>
    parent.parent.window.location.href="<%=rootPath%>/login.jsp?errorType=overtime";
<%}%>
</script>
<%
}else{
String domainId = session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString();
String userId   = session.getAttribute("userId").toString(); 
RemindInfo remindInfo = RemindInfo.getInstance(domainId, userId);
Map map = remindInfo.getRemindInfo(userId);

//删除在security_onlineuser表中已经超过24小时的在线人员数据记录--2009-04-30--start
//com.whir.org.bd.usermanager.UserBD userBD = new com.whir.org.bd.usermanager.UserBD();
//int outHour = 24;//超过多少小时的在线用户数据记录删除
//String returnStr = userBD.delNoOnlineUser(request,outHour);
//删除在security_onlineuser表中已经超过24小时的在线人员数据记录--2009-04-30--end

int userNum = new com.whir.ezoffice.remind.bd.RemindBD().getOnlineUserNum(domainId).intValue();

int newMail=0;
int newTask=0;
int checkTask=0;
int waitTask=0;
int newReport=0;
int newEvent=0;
int waitFile=0;
int waitRead=0;
int matureFile=0;
int outMail=0;
int press=0;
int newMessage=0;
int newFeedBack=0;
int newInnerSendFile=0;
int mustReadInfoCount=0;
int meeting=0;
int remindContract=0;
int weekReport=0;
int monthReport=0;

List remindList = new ArrayList();
//会议
if(map.get("meetingCount")!=null) meeting=Integer.parseInt(map.get("meetingCount").toString());
if(meeting>0){
    remindList.add(new String[]{"meeting", meeting+"",rootPath+"/SubsidiaryMenuAction.do?menuId=37", rootPath+"/BoardRoomAction.do?action=meetingInformView&type=day", "common", "comm.meeting"});
}
//邮件
if(map.get("newMail")!=null) newMail=Integer.parseInt(map.get("newMail").toString());
if(newMail>0){
    remindList.add(new String[]{"mail", newMail+"",rootPath+"/InnerMailFolderAction.do?action=mail_menu", rootPath+"/innerMailAction.do?action=receiveView", "common", "comm.newmail"});
}
//外部邮件
if(map.get("outMail")!=null) outMail=Integer.parseInt(map.get("outMail").toString());
if(outMail>0){
    remindList.add(new String[]{"outmail", outMail+"","../../comm_mail/mail_menu.jsp", rootPath+"/LogonMailAction.do?action=responseToOutMail", "common", "comm.outmail"});
}
//任务
if(map.get("newTask")!=null) newTask=Integer.parseInt(map.get("newTask").toString());
if(newTask>0){
    remindList.add(new String[]{"newtask", newTask+"",rootPath+"/workLogAction.do?action=view_menu", rootPath+"/taskAction.do?action=selectPrincipalTask", "common", "comm.task"});
}

if(map.get("checkTask")!=null) checkTask=Integer.parseInt(map.get("checkTask").toString());
if(checkTask>0){
    remindList.add(new String[]{"checktask", checkTask+"",rootPath+"/workLogAction.do?action=view_menu", rootPath+"/taskAction.do?action=selectSettleCheckTask", "common", "comm.waittask"});
}
//合同
if(map.get("remindContract")!=null) remindContract=Integer.parseInt(map.get("remindContract").toString());
if(remindContract>0){
    remindList.add(new String[]{"remindContract", remindContract+"",rootPath+"/SubsidiaryMenuAction.do", rootPath+"/ContractAction.do?action=reminderList", "common", "comm.contractRemind"});
}

if(map.get("waitTask")!=null) waitTask=Integer.parseInt(map.get("waitTask").toString());
if(waitTask>0){
    remindList.add(new String[]{"waittask", waitTask+"",rootPath+"/workLogAction.do?action=view_menu", rootPath+"/taskAction.do?action=selectSettleCheckTask", "common", "comm.transtask"});
}
//工作汇报
if(map.get("newReport")!=null) newReport=Integer.parseInt(map.get("newReport").toString());
if(newReport>0){
    remindList.add(new String[]{"newreport", newReport+"",rootPath+"/workLogAction.do?action=view_menu&statusType=4", rootPath+"/WorkReportLeaderProductAction.do?action=list", "common", "comm.report"});
}
//事件
if(map.get("newEvent")!=null) newEvent=Integer.parseInt(map.get("newEvent").toString());
if(newEvent>0){
    remindList.add(new String[]{"newevent", newEvent+"",rootPath+"/workLogAction.do?action=view_menu&statusType=2", rootPath+"/eventAction.do?action=selectAllEvent", "common", "comm.event"});
}
//待办
if(map.get("waitFile")!=null) waitFile=Integer.parseInt(map.get("waitFile").toString());
if(waitFile>0){
    remindList.add(new String[]{"waitfile", waitFile+"",rootPath+"/mydesktop/filedealwith_menu.jsp", rootPath+"/FileDealWithAction.do?workStatus=0", "common", "comm.waitdofile"});
}
//待阅
if(map.get("waitRead")!=null) waitRead=Integer.parseInt(map.get("waitRead").toString());
if(waitRead>0){
    remindList.add(new String[]{"waitRead", waitRead+"",rootPath+"/mydesktop/filedealwith_menu.jsp?type=1", rootPath+"/FileDealWithAction.do?workStatus=2", "common", "comm.waitreadfile"});
}

if(map.get("matureFile")!=null) matureFile=Integer.parseInt(map.get("matureFile").toString());
if(matureFile>0){
    remindList.add(new String[]{"maturefile", matureFile+"",rootPath+"/mydesktop/filedealwith_menu.jsp", rootPath+"/FileDealWithAction.do?workStatus=0", "common", "comm.Pendingfileexpired"});
}

if(map.get("newPress")!=null) press=Integer.parseInt(map.get("newPress").toString());
if(press>0){
    remindList.add(new String[]{"press", press+"",rootPath+"/workLogAction.do?action=view_menu&statusType=9", rootPath+"/pressManageAction.do?action=receive_list", "common", "comm.press"});
}

if(map.get("newMessage")!=null) newMessage=Integer.parseInt(map.get("newMessage").toString());
if(newMessage>0){
    remindList.add(new String[]{"newMessage", newMessage+"",rootPath+"/message/message_menu.jsp", rootPath+"/MessageAction.do?action=receiveView", "common", "comm.NewSMS"});
}

if(map.get("newFeedBack")!=null) newFeedBack=Integer.parseInt(map.get("newFeedBack").toString());
if(newFeedBack>0){
    remindList.add(new String[]{"newFeedBack", newFeedBack+"",rootPath+"/workLogAction.do?action=view_menu&statusType=9", rootPath+"/pressManageAction.do?action=show_myallfeedback", "common", "comm.NewFeedback"});
}

if(map.get("ReceiveFileBoxCount")!=null) newInnerSendFile=Integer.parseInt(map.get("ReceiveFileBoxCount").toString());
if(newInnerSendFile>0){
    remindList.add(new String[]{"newinnersendfile", newInnerSendFile+"",rootPath+"/GovDocumentMenuAction.do", rootPath+"/GovReceiveFileBoxAction.do?action=list", "common", "comm.receivefile"});
}

if(map.get("mustReadInfoCount")!=null) mustReadInfoCount=Integer.parseInt(map.get("mustReadInfoCount").toString());
if(mustReadInfoCount>0){
    remindList.add(new String[]{"mustreadinfo", mustReadInfoCount+"",rootPath+"/information_manager/mustReadInfo.jsp", "", "common", "comm.mastread"});
}

//紫金矿业增加周、月汇报
if(map.get("weekReport")!=null) weekReport=Integer.parseInt(map.get("weekReport").toString());
if(weekReport>0){
    remindList.add(new String[]{"weekReport", weekReport+"",rootPath+"/workLogAction.do?action=view_menu&statusType=4", rootPath+"/WorkReportLeaderAction.do?action=list&reportType=1", "common", "comm.weekreport"});
}

if(map.get("monthReport")!=null) monthReport=Integer.parseInt(map.get("monthReport").toString());
if(monthReport>0){
    remindList.add(new String[]{"monthReport", monthReport+"",rootPath+"/workLogAction.do?action=view_menu&statusType=4", rootPath+"/WorkReportLeaderAction.do?action=list&reportType=3", "common", "comm.monthreport"});
}

String soundFile="";
String soundType="";
boolean sound=false;

/***********************取foxmail的新邮件数****************************/
//String mailURL="";
//String userAccount=session.getAttribute("userAccount").toString();
//String userPassword=session.getAttribute("userPassword").toString();
//com.whir.webmail.foxmail.FoxMailTools fmtools=new com.whir.webmail.foxmail.FoxMailTools();
//newMail=fmtools.getNewMailNum(userAccount,userPassword,"","");
//mailURL = fmtools.getMailURL();
/***********************取foxmail的新邮件数****************************/
%>
<html>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">
    <meta http-equiv="refresh" content="30">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <head>
        <script type="text/javascript">
			var whirRootPath = "<%=rootPath%>";
			var preUrl = "<%=preUrl%>"; 
		</script>
		<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
    </head>
    <body leftmargin="0" topmargin="0" onload="initRemindInfo();">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td height="26">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="280"  height="26">
							  <span id="remindInfo"><MARQUEE SCROLLAMOUNT="1" SCROLLDELAY="10" LOOP="-1" onmouseover="this.stop();" onmouseout="this.start();">
                              <%
                                if(remindList!=null&&remindList.size()>0){
                                    //取用户的提醒声音
                                    if(session.getAttribute("soundFile")==null || session.getAttribute("sounType") == null){
                                        List list=remindInfo.getRemindSound(userId);
                                        if(list.size()>0){
                                            session.setAttribute("soundFile",list.get(1));
                                            session.setAttribute("soundType",list.get(0));
                                        }else{
                                            session.setAttribute("soundFile","");
                                            session.setAttribute("soundType","");
                                        }
                                    }

                                    soundFile=session.getAttribute("soundFile").toString();
                                    soundType=session.getAttribute("soundType").toString();

                                    if("1".equals(soundType)){
                                        sound=true;
                                    }
                              %>

                                <img src="<%=rootPath%>/images/new_mail.gif" hspace="2" align="absmiddle">
                                    <label class="Maintext"><bean:message bundle="common" key="comm.youhave" /></label>
                                    <%
                                        for(int i0=0; i0<remindList.size(); i0++){
                                            String[] s = (String[])remindList.get(i0);                                            
                                    %>
                                    <a onclick="javascript:jumpnew('<%=s[2]%>','<%=s[3]%>');" style="cursor:hand"><label class="FontColorRed"><%=s[1]%></label><label class="Maintext"><bean:message bundle="<%=s[4]%>" key="<%=s[5]%>" /></label></a>
                                    <%}
                                }

                                if(sound || "2".equals(soundType)){
                                    String datePath = soundFile.substring(0,6);
                                    File newfile = new File(application.getRealPath("/") + "/upload/sound/"+datePath+ "/" + soundFile);
                                    File file = new File(application.getRealPath("/") + "/upload/sound/" + soundFile);
                                    if(newfile.exists()){
                                %>
                                <bgsound src="<%=rootPath%>/upload/sound/<%=datePath%>/<%=soundFile%>">
                                <%}else{%>
                                <bgsound src="<%=rootPath%>/upload/sound/<%=soundFile%>">
                                <%}}%>
								</MARQUEE>                                
							   </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
			<!--------------------------------增加一iframe 不断刷新邮件服务器保持session------------->
			<!-- <tr style="display:none">
			  <td>
			     <iframe src="<%//=mailURL%>/heart.asp"></iframe>
			  </td>
			</tr> -->
			<!--------------------------------增加一iframe 不断刷新邮件服务器保持session------------->
        </table>
    </body>
</html>

<SCRIPT LANGUAGE="JavaScript">
<!--
<%String userNumStr = userNum + "";%>

parent.document.getElementById("userPre").innerHTML="<bean:message bundle="common" key="comm.onlineuser" arg0="<%=userNumStr%>" />";

//setInterval('initRemindInfo()',30000);
function initRemindInfo(){
	var skin = '<%=whir_skin%>';
	var types = "newMail,waitFile,waitRead,";
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/SystemRemind!getRemindStr.action?types="+types+"&tmp=<%=new Date().getTime()%>",
        async: true,
		dataType: 'text',
		success: function(data) {
			data = data.replace(/\n|\r/igm,'');
			var resultArr = data.split("|");
			var resultStr = "";
			if(resultArr != null && resultArr.length > 0){
				for(var i=0;i<resultArr.length;i++){
					var name=resultArr[i].split(",")[0];
					var count=resultArr[i].split(",")[1];
					if(name=="newMail" && parseInt(count)>0){
						resultStr += '<img src="<%=rootPath%>/images/new_mail.gif" hspace="2" align="absmiddle"><label class="Maintext"><bean:message bundle="common" key="comm.youhave" /></label>';
						resultStr += '<a href="javascript:void(0);" onclick="javascript:jumpnew(\'<%=rootPath%>/innerMail!innermailMenu.action\',\'<%=rootPath%>/innerMail!receiveList.action\');" style="cursor:hand"><label class="FontColorRed">'+count+'</label><label class="Maintext"><bean:message bundle="common" key="comm.newmail" /></label></a>&nbsp;&nbsp;';
					}else if(name=="waitFile" && parseInt(count)>0){
						if(resultStr == ""){
							resultStr += '<img src="<%=rootPath%>/images/new_mail.gif" hspace="2" align="absmiddle"><label class="Maintext"><bean:message bundle="common" key="comm.youhave" /></label>';
						}
						resultStr += '<a href="javascript:void(0);" onclick="javascript:jumpnew(\'<%=rootPath%>/wfdealwith!menu.action\',\'<%=rootPath%>/wfdealwith!dealwithList.action?openType=waitingDeal\');" style="cursor:hand"><label class="FontColorRed">'+count+'</label><label class="Maintext"><bean:message bundle="common" key="comm.waitdofile" /></label></a>&nbsp;&nbsp;';
					}else if(name=="waitRead" && parseInt(count)>0){
						if(resultStr == ""){
							resultStr += '<img src="<%=rootPath%>/images/new_mail.gif" hspace="2" align="absmiddle"><label class="Maintext"><bean:message bundle="common" key="comm.youhave" /></label>';
						}
						resultStr += '<a href="javascript:void(0);" onclick="javascript:jumpnew(\'<%=rootPath%>/mydesktop/wfdealwith!menu.action?statusType=1\',\'<%=rootPath%>/wfdealwith!dealwithList.action?openType=waitingRead\');" style="cursor:hand"><label class="FontColorRed">'+count+'</label><label class="Maintext"><bean:message bundle="common" key="comm.waitreadfile" /></label></a>&nbsp;&nbsp;';
					}else if(name=="matureFile" && parseInt(count)>0){
						if(resultStr == ""){
							resultStr += '<img src="<%=rootPath%>/images/new_mail.gif" hspace="2" align="absmiddle"><label class="Maintext"><bean:message bundle="common" key="comm.youhave" /></label> />';
						}
						resultStr += '<a href="javascript:void(0);" onclick="javascript:jumpnew(\'<%=rootPath%>/mydesktop/filedealwith_menu.jsp\',\'<%=rootPath%>/FileDealWithAction.do?workStatus=0\');" style="cursor:hand"><label class="FontColorRed">'+count+'</label><label class="Maintext"><bean:message bundle="common" key="comm.Pendingfileexpired" /></label></a>&nbsp;&nbsp;';
					}
				}
			}
			parent.document.getElementById("remindInfo").innerHTML = resultStr;
		}
	});
}
//-->
</SCRIPT>
<%}%>