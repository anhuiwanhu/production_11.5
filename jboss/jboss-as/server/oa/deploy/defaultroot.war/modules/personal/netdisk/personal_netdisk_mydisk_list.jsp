<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.ezoffice.netdisk.bd.*"%>
<%@ page import="com.whir.ezoffice.netdisk.common.configreader.exchangeData"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
java.lang.StringBuffer gifString=new java.lang.StringBuffer("");//得到filetype文件夹下的所有gif文件名称
String path = System.getProperty("file.separator")!=null?System.getProperty("file.separator"):"";
String ap = application.getRealPath("/");
if(!ap.endsWith(path)){
	ap = ap +path;
}
java.io.File filetype= new java.io.File(ap+"modules/personal/netdisk"+path+"filetype");
File[] array= filetype.listFiles()!=null?filetype.listFiles():new File[0];
for(int i=0;i<array.length;i++){
 if(array[i].getName().endsWith(".gif"))
      gifString.append(array[i].getName()+"#");
}

String domainId=session.getAttribute("domainId")+"";
//java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(domainId);
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
String userId = session.getAttribute("userId").toString();

//--------判断是ftp还是http方式上传图片-----2009-06-30 start----
int smartInUse = 0;
//if(sysMap != null && sysMap.get("附件上传") != null){
	//smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
//}
String downPath=smartInUse==1?"/defaultroot":fileServer;
//-------判断是ftp还是http方式上传图片-----2009-06-30 end----
		   
NetdiskBD netdiskBD=new NetdiskBD();
exchangeData exchange=new exchangeData();
String userAccount=session.getAttribute("userAccount").toString();

String currentid="0";

if(!"".equals(request.getParameter("currentid"))&&request.getParameter("currentid")!=null){
  currentid=request.getParameter("currentid");
}

String copynoly="0";
if(!"".equals(request.getParameter("copynoly"))){
  copynoly=request.getParameter("copynoly");
}

String test="0";
if(request.getAttribute("currentid")!=null){
  test=request.getAttribute("currentid").toString();
  currentid=request.getAttribute("currentid").toString();
}
%>

<%

	double usedFileSize=netdiskBD.getAllFileSizeByUser(userId);//得到当前用户我的文档总容量
	double fileMaxSize = new com.whir.org.bd.usermanager.UserBD().getNetDiskSize(userId);//分配的容量
	double copyPraseFileSize=0;
	if(session.getAttribute("copyitem")!=null&&"0".equals(session.getAttribute("copyorcut").toString())){
	
	   copyPraseFileSize=netdiskBD.getPraseFileSize(session.getAttribute("copyitem").toString());//得到拷贝并且要黏贴的文档大小
	}
	double useWidth = usedFileSize/(fileMaxSize*1024*1024)*100;
	//System.out.println("=====@netdisk_mydisk.jsp--[useWidth]=[" + useWidth + "]");
	double useLineWidth = usedFileSize/(fileMaxSize*1024*1024)*150; //useWidth;
	if(useLineWidth > 150){
		useLineWidth = 150;
	}
	DecimalFormat df = new DecimalFormat("0.00");
	DecimalFormat df1 = new DecimalFormat("0");
	long leaveSize = (long)(fileMaxSize*1024*1024-usedFileSize);//剩余容量
	System.out.println("leaveSize:"+leaveSize+";usedFileSize:"+usedFileSize+";fileMaxSize:"+fileMaxSize);
	String leaveSize_tr = leaveSize/1024+"KB";
	
	/*Map map = (Map) com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(), domainId);
	String fileSizeLimitAll="110240000";
	
	if(map != null && map.get("FileSizeLimitAll") != null){
	    fileSizeLimitAll = map.get("FileSizeLimitAll").toString();
	    if(fileSizeLimitAll.startsWith("1")){
	        int fileSize=Integer.parseInt(fileSizeLimitAll.substring(1));
	       
	        if(leaveSize==0 || leaveSize > fileSize){
	        	leaveSize_tr = (fileSize/(1024*1024))+"MB";
	        }
	    }
	}*/
	
	String uploadFileI18N = Resource.getValue(whir_locale,"personalwork","webdisk.upload");
%>
<head>  
	<title>无标题文档</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_list.jsp"%>  
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
	<script type="text/JavaScript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" ></script>
	<script type="text/JavaScript" src="<%=rootPath%>/modules/personal/netdisk/netdisk_mine_list_js.js" ></script>
	<script>
		function myonSWFReady(){
			if($.browser.mozilla){
				$("#div_uniqueId .swfupload").css("margin-left","-8px");
			}
		}
		$(document).ready(function(){
			$("#imgdis  .uploadify-button").css({"border":"0px"});
			$("#textdis .uploadify-button").css({"border":"0px","background-color":"#f6f6f6","color":"#0657ab","padding-top":"3px"});
		});
	</script>
</head> 
<body class="MainFrameBox">
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="${ctx}/netdisk!listData.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
	<input type="hidden" name="delFlag" id="delFlag" value="" />
	<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="searchTable" style="background-color:#f6f6f6;border:1px solid #ccc;">  
        <tr style="h">
			<td width="9%">
				<div align="center"><img <%if(currentid==null || "null".equals(currentid) || "0".equals(currentid) || "0".equals(test)){%>src="images/upstop.gif"<%}else{%>src="images/up.gif" onclick="uplist();"<%}%> style="cursor:pointer" title="<%=Resource.getValue(whir_locale,"personalwork","webdisk.previous")%>" style="border-width:0px;"></div>
			</td>
			<td width="9%">
				<div align="center"><img <%if(currentid==null || "null".equals(currentid) || "0".equals(currentid)){%>src="images/homestop.gif"<%}else{%>src="images/home.gif" onclick="homes();"<%}%> style="cursor:pointer" title="<%=Resource.getValue(whir_locale,"personalwork","webdisk.root")%>"></div>
			</td>
			<td width="9%">
				<div align="center"><img src="images/fs_refresh.gif" onclick="refresh();" style="cursor:pointer" title="<%=Resource.getValue(whir_locale,"personalwork","webdisk.refresh")%>" style="border-width:0px;"></div>
			</td>
            <td width="9%">
				<div align="center"><img src="images/newDocument.png" onclick="newDoc();" style="cursor:pointer" title="<%=Resource.getValue(whir_locale, "personalwork", "webdisk.NewDocument")%>" style="border-width:0px;"></div>
			</td>
			<td width="9%">
			<%
				if (isPad) {
                    // Added by Qian Min for ezOFFICE 11.0.0.11 at 2013-10-13 
			%>
					<div align="center">
						<img src="images/upload.gif" onclick="uploadFile_iPad();" style="cursor:pointer" title="<%=uploadFileI18N%>" >
					</div>
			<%
				} else {
			%>		
					<input type="text" name="realFileName" id="realFileName" style="width:800px;display:none;" value=""/>
					<input type="text" name="saveFileName" id="saveFileName" style="width:800px;display:none;" value=""/>
					<div style="margin-top:8px;margin-left:30px;" id="imgdis">
					<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
						<jsp:param name="accessType" value="include" />
						<jsp:param name="makeYMdir" value="yes" />
						<jsp:param name="onInit" value="" /> 
						<jsp:param name="onSelect" value="" />
						<jsp:param name="onUploadProgress" value="" />  
						<jsp:param name="onUploadSuccess" value="_onUploadSuccess" />
						<jsp:param name="onSWFReady" value="myonSWFReady" />
						<jsp:param name="dir" value="netdisk" />
						<jsp:param name="uniqueId" value="uniqueId" />
						<jsp:param name="realFileNameInputId" value="realFileName" />
						<jsp:param name="saveFileNameInputId" value="saveFileName" /> 
						<jsp:param name="canModify" value="yes" />
					  
						<jsp:param name="style" value="#uniqueId{margin-left:8px;margin-bottom:15px;}" />
					  
						<jsp:param name="width" value="16" /> 
						<jsp:param name="height" value="10" />  
						<jsp:param name="multi" value="false" />
						<jsp:param name="buttonImage" value="/defaultroot/images/upload.gif" />
						<jsp:param name="buttonText" value="<%=uploadFileI18N%>" />
						<jsp:param name="fileSizeLimit" value="<%=leaveSize_tr%>" /> 
						<jsp:param name="uploadLimit" value="0" />
					</jsp:include>
					</div>
			<%
				}
			%>
            </td>
			<td id="tddel" width="9%">
				<div align="center"><img src="images/new_folder.gif" style="cursor:pointer" onclick="addfolder();" title="<%=Resource.getValue(whir_locale,"personalwork","webdisk.newfilefolder")%>"></div>
			</td>
			<td id="tdcut" width="9%">
				<div align="center">
					<!-- a href="workLogAction.do?action=view_menu&statusType=7" target="leftFrame" onclick="deleteall();" -->
					<a href="javascript:void(0)" onclick="delBatch('<%=rootPath%>/netdisk!deleteall.action',this);">
						<img src="images/delete_big.gif" style="cursor:pointer;border:none;" title="<%=Resource.getValue(whir_locale,"personalwork","webdisk.deleteselect")%>">
					</a>
				</div>
			</td>
			<td id="tdcopy" width="9%">
				<div align="center"><img src="images/cut.gif" style="cursor:pointer" onclick="cuts();" title="<%=Resource.getValue(whir_locale,"personalwork","webdisk.cut")%>"></div>
			</td>
			<td id="tdpas" width="9%">
				<div align="center"><img src="images/copys.gif" style="cursor:pointer" onclick="copys();" title="<%=Resource.getValue(whir_locale,"personalwork","webdisk.copy")%>"></div>
			</td>
			<td id="tdzip" width="9%">
			    <div align="center">
				<!-- a href="workLogAction.do?action=view_menu&statusType=7" target="leftFrame" onclick="parse();" -->
				<a href="javascript:void(0)" onclick="parse();">
				<img src="images/pas.gif" style="cursor:pointer;border:none;"  title="<%=Resource.getValue(whir_locale,"personalwork","webdisk.paste")%>">
				</a>
				</div>
			</td>

			<td id="tdunzip" width="9%">
				<div align="center">
					<a href="javascript:void(0);" onclick="search123();">
					<img src="images/ab_search.gif" style="cursor:pointer;border:none;" title="<%=Resource.getValue(whir_locale,"personalwork","webdisk.search")%>">
					</a>
				</div>
			</td>
		</tr>
		<tr>
			<td >
				<div align="center"><%if(currentid==null || "null".equals(currentid) || "0".equals(currentid) || "0".equals(test)){%><%=Resource.getValue(whir_locale,"personalwork","webdisk.previous")%><%}else{%><a href="#" onclick="uplist();"><%=Resource.getValue(whir_locale,"personalwork","webdisk.previous")%></a><%}%></div>
			</td>
			<td>
				<div align="center"><%if(currentid==null || "null".equals(currentid) || "0".equals(currentid)){%><%=Resource.getValue(whir_locale,"personalwork","webdisk.root")%><%}else{%><a href="#" onclick="homes();"><%=Resource.getValue(whir_locale,"personalwork","webdisk.root")%></a><%}%></div>
			</td>
			<td>
				<div align="center"><a href="#" onclick="refresh();"><%=Resource.getValue(whir_locale,"personalwork","webdisk.refresh")%></a></div>
			</td>
                                      <td>
				<div align="center"><a href="#" onclick="newDoc();"><%=Resource.getValue(whir_locale, "personalwork", "webdisk.NewDocument")%></a></div>
			</td>
			<td>
			<%
				if (isPad) {
                    // Added by Qian Min for ezOFFICE 11.0.0.11 at 2013-10-13 
			%>
					<div align="center"><%=uploadFileI18N%></div>
			<%
				} else {
			%>
					<input type="text" name="_realFileName" id="_realFileName" style="width:800px;display:none;" value=""/>
					<input type="text" name="_saveFileName" id="_saveFileName" style="width:800px;display:none;" value=""/>
					<div style="margin-top:0px;margin-left:7px;" id="textdis">
					<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
						<jsp:param name="accessType" value="include" />
						<jsp:param name="makeYMdir" value="yes" />
						<jsp:param name="onInit" value="" /> 
						<jsp:param name="onSelect" value="" />
						<jsp:param name="onUploadProgress" value="" />  
						<jsp:param name="onUploadSuccess" value="_onUploadSuccess" />
						<jsp:param name="dir" value="netdisk" />
						<jsp:param name="uniqueId" value="uniqueId1" />
						<jsp:param name="realFileNameInputId" value="_realFileName" />
						<jsp:param name="saveFileNameInputId" value="_saveFileName" /> 
						<jsp:param name="canModify" value="yes" />

						<jsp:param name="style" value="#uniqueId1,#div_uniqueId1{border:0;color:#0657AB;background-color:#f6f6f6;}#uniqueId1{margin-left:14px;margin-top:-5px;margin-bottom:12px;}" />

						<jsp:param name="width" value="50" /> 
						<jsp:param name="height" value="10" />  
						<jsp:param name="multi" value="false" />
						<jsp:param name="buttonClass" value="upload_btn" />

						<jsp:param name="buttonText" value="<%=uploadFileI18N%>" />
						<jsp:param name="fileSizeLimit" value="<%=leaveSize_tr%>" /> 
						<jsp:param name="uploadLimit" value="0" />
					</jsp:include>
					</div>
			<%
				}
			%>
            </td>
			
			
			<td id="tdnewfolder1">
				<div align="center"><a href="#" onclick="addfolder();"><%=Resource.getValue(whir_locale,"personalwork","webdisk.newfilefolder")%></a></div>
			</td>
			<td id="tddel1">
				<div align="center">
					<!-- a onclick="deleteall();" href="workLogAction.do?action=view_menu&statusType=7"  target="leftFrame" -->
					<a href="javascript:void(0)" onclick="delBatch('<%=rootPath%>/netdisk!deleteall.action',this);">
						<%=Resource.getValue(whir_locale,"personalwork","webdisk.deleteselect")%>
					</a>
				</div>
			</td>
			<td id="tdcut1">
				<div align="center"><a href="#" onclick="cuts();"><%=Resource.getValue(whir_locale,"personalwork","webdisk.cut")%></a></div>
			</td>
			<td id="tdcopy1">
				<div align="center"><a href="#" onclick="copys();"><%=Resource.getValue(whir_locale,"personalwork","webdisk.copy")%></a></div>
			</td>
			<td id="tdpas1">
				<div align="center">
				<!-- a href="workLogAction.do?action=view_menu&statusType=7" target="leftFrame" onclick="parse();" -->
				<a href="javascript:void(0)" onclick="parse();">
				<%=Resource.getValue(whir_locale,"personalwork","webdisk.paste")%>
				</a></div>
			</td>
			<td id="tdzip1">
                <div align="center"><a href="#" onclick="search123();"><%=Resource.getValue(whir_locale,"personalwork","webdisk.search")%></a></div>
			</td>

		</tr>
    </table>
    <%
	  String fileidstring="";
	  if(request.getAttribute("fileidstring")!=null && !"".equals(request.getAttribute("fileidstring"))){
	    fileidstring=request.getAttribute("fileidstring").toString();
	  }
	
	%><br/>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar" style='display:none' id="searchtable1">
	    <tr>
			<td class="whir_td_searchtitle"><bean:message bundle="personalwork" key="webdisk.filename" />：</td>
			<td class="whir_td_searchinput">
				<s:textfield id="fileSaveName" name="fileSaveName" size="18" cssClass="inputText" maxlength="200" /> 
			</td>
			<td class="whir_td_searchtitle"><bean:message bundle="personalwork" key="webdisk.filesize" />：</td>
			<td class="whir_td_searchinput" nowrap="nowrap">
				<s:textfield id="filesizeBegin" name="filesizeBegin" size="18" cssClass="inputText" maxlength="10" whir-options="vtype:['p_integer']" cssStyle="width:100px;" />
				<bean:message bundle="personalwork" key="webdisk.byte" />&nbsp;&nbsp;<bean:message bundle="personalwork" key="webdisk.to" />&nbsp;
				<s:textfield id="filesizeEnd" name="filesizeEnd" size="18" cssClass="inputText" maxlength="10" whir-options="vtype:['p_integer']" cssStyle="width:100px;" />
				<bean:message bundle="personalwork" key="webdisk.byte" />
				<input style="display:none;" type="checkbox" value="1" name="choicesize" <%if("1".equals(request.getParameter("choicesize"))){%>checked<%}%>>
			</td>
			<td class="whir_td_searchtitle">&nbsp;</td>
			<td class="whir_td_searchinput">&nbsp;</td>
	    </tr>
		
		<tr>
			<td class="whir_td_searchtitle"><bean:message bundle="personalwork" key="webdisk.filetype" />：</td>
			<td class="whir_td_searchinput">
				<s:textfield id="fileType" name="fileType" size="18" cssClass="inputText" maxlength="200" />
			</td>
			<td class="whir_td_searchtitle"><bean:message bundle="personalwork" key="webdisk.modidate" />：</td>
			<td class="whir_td_searchinput" nowrap="nowrap">
                <s:textfield name="startTaskBeginTime" id="startTaskBeginTime" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'endTaskBeginTime\\',{d:0});}'})">
   					<s:param name="value"><s:date name="startTaskBeginTime" format="yyyy-MM-dd" /></s:param> 
   				</s:textfield> <s:text name="webdisk.to"/> <s:textfield name="endTaskBeginTime" id="endTaskBeginTime" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'startTaskBeginTime\\',{d:0});}'})">
   					<s:param name="value"><s:date name="endTaskBeginTime" format="yyyy-MM-dd" /></s:param> 
   				</s:textfield><input type="checkbox" value="1" name="choicetime" style="cursor:pointer;display:none;">
            </td>
			<td colspan="2" class="SearchBar_toolbar" >
				<input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="<s:text name='comm.searchnow'/>" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="<s:text name='comm.clear'/>" onclick="resetForm(this);" />
			</td>
		</tr>
	</table>
    
	<!-- SEARCH PART END -->
	
	<table width="100%">
		<tr>
			<td align="right" id="td_info">
			<s:text name="webdisk.totalspace"/><%=fileMaxSize%>MB： <s:text name="webdisk.surplus"/><%=df.format(leaveSize/(1024*1024))%>MB， <s:text name="webdisk.used"/><%=df.format(usedFileSize/(1024*1024))%>MB
			</td>
			<td width="150px" id="td_css">
				  <div id="spacePanel" style="width:150px;border:1px solid #aaaaaa;height:18px;">
					  <div style="position:relative;background-color:#FF0000;border-right:1px solid #eeeeee;width:<%=useLineWidth%>px;height:18px;"></div>
					  <div style="position:relative;width:150px;height:18px;margin-top:-18px;" align="center"><%=df.format(useWidth)%>%</div>
				  </div>
			</td>
		</tr>
	</table>
	
  <input type="hidden" name="useracc" value="<%=userAccount%>">
  <input type="hidden" id="currenid" name="currenid" value="<%=currentid%>">
  <input type="hidden" id="currentid" name="currentid" value="<%=currentid%>">
  <%
  String up_currentid="0";//非'0'二级文档 列表
  if(!"".equals(request.getAttribute("up_currentid"))&&request.getAttribute("up_currentid")!=null){
	  up_currentid=request.getAttribute("up_currentid")+"";
  }
  String upevent="0";//'0'下级文档 列表，‘1’上级文档列表
  if(!"".equals(request.getAttribute("upevent"))&&request.getAttribute("upevent")!=null){
	  upevent=request.getAttribute("upevent")+"";
  }
  %>
  <input type="hidden" id="up_currentid" name="up_currentid" value="<%=com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(up_currentid)%>">
  <input type="hidden" name="upevent" value="<%=com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(upevent)%>">

  <input type="hidden" id="copyitem" name="copyitem" value="<%=request.getAttribute("copyitem")==null?"":com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getAttribute("copyitem").toString())%>">
  <input type="hidden" id="copyorcut" name="copyorcut"  value="<%=request.getAttribute("copyorcut")==null?"":com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getAttribute("copyorcut").toString())%>">
  <input type="hidden" name="upuse" value="<%=request.getAttribute("currentid")==null?"":request.getAttribute("currentid")==null?"":com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getAttribute("currentid").toString())%>">
  <input type="hidden" name="allAttachSize" value="0">
  <input type="hidden" name="fileidstring" value="<%=com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(fileidstring)%>">
	
	<!-- LIST TITLE PART START -->
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable" style="border-top:1px solid #ccc;" >
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
        	<td whir-options="field:'fileId',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('fileId',this.checked);" ></td>
			<td whir-options="field:'fileType',width:'10%',renderer:showFileType,allowSort:true"><s:text name="webdisk.filetype"/></td> 
			<td whir-options="field:'fileSaveName',width:'25%',renderer:showFileSaveName,allowSort:true"><s:text name="webdisk.filename"/></td> 
			<td whir-options="field:'fileSize',width:'10%',renderer:showFileSize,allowSort:true"><s:text name="webdisk.size"/></td>
			<td whir-options="field:'fileCreatedTime',width:'11%',renderer:common_DateFormatFull,allowSort:true"><s:text name="webdisk.modidate"/></td> 
			<td whir-options="field:'fileShareToName',renderer:showShare"><s:text name="webdisk.shareto"/></td> 
			<td whir-options="width:'8%',renderer:myOperate"><s:text name="webdisk.operate"/></td> 
        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->

<!--copyPraseFileSize剩余容量是否存的下拷贝的文件--->
<input type="hidden" id="copyPraseFileSize" name="copyPraseFileSize" value="<%=(leaveSize>copyPraseFileSize)%>">
	</s:form>
<div style="display:none">
			<iframe id="downloadFile" name="downloadFile" width="0" height="0"></iframe>
	</div>
</body>


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){	
		/*$('input[name="fileSizeLimit"]').each(function(){
			alert($(this).val());
		});	*/
		initListFormToAjax({formId:'queryForm',onLoadSuccessAfter:showInfo});
		
	});
	
	//显示图片
	function showInfo(){//delFlag=1-->新建文件夹，删除文件夹刷新左边菜单标识
		if($('#delFlag').val()=='1'){//处理‘非删除操作’左边菜单刷新问题
			//$("#leftFrame",window.parent.document).attr("src","<%=rootPath%>/modules/personal/personal_menu.jsp?statusType=1");
			$('#delFlag').val('');
		}
		$(".trigger1").powerFloat({
		    targetMode: "ajax"
		});
		var url = "netdisk!getFileInfo.action";
	  	jQuery.ajax({
		  type : "POST",
		  url  : url,
		  success: function(msg){
		  	var msg_json = eval("("+msg+")");
		  	$('#td_info').text(msg_json.TDStr);
		  	//$('#spacePanel').find("div:first-child").attr('width',msg_json.useLineWidth+'px;')
		  	$('#spacePanel').find("div:eq(0)").attr('style','position:relative;background-color:#FF0000;border-right:1px solid #eeeeee;width:'+msg_json.useLineWidth+'px;height:18px;');
		  	$('#spacePanel').find("div:eq(1)").text(msg_json.useWidth+'%');
		  },
		  error: function(XMLHttpRequest, textStatus, errorThrown){
			
		  }
	  	});
		
	}
	
	//上传保存附件信息到数据库	
	function _onUploadSuccess(msg){
		var file_type = msg.file_type;
		var save_name = msg.save_name;
		var file_name = msg.file_name;
		var relative_path = msg.relative_path;
		var file_size = msg.file_size;
		var currenid = $("input[name='currenid']").val();
		var fileidstring = $("input[name='fileidstring']").val();
		var url = "netdisk!addFileInfo.action?file_type="+ file_type +"&save_name="+ save_name +"&file_name="+ file_name +"&file_size="+ file_size+"&currenid="+ currenid +"&fileidstring="+ fileidstring;
	  	jQuery.ajax({
		  type : "POST",
		  url  : encodeURI(url),
		  success: function(msg){
		  	//initListFormToAjax({formId:'queryForm',onLoadSuccessAfter:showInfo});
			location.reload();
		  },
		  error: function(XMLHttpRequest, textStatus, errorThrown){
			
		  }
	  	});
		  
	}
	
	//类型
	function showFileType(po,i){
		var html = "";
		var sign=po.fileExtName.toLowerCase();
		var isShowImg = "yes";
        var showType = sign;
        if(po.fileType=="2"){//html编辑
            isShowImg = "no";
            showType = "HTML";
        }else if(po.fileType=="3"){//普通编辑
            isShowImg = "no";
            showType = "TXT";
        }else if(po.fileType=="4"){//word编辑
            isShowImg = "no";
            showType = "WORD";
        }else if(po.fileType=="5"){//excel编辑
            isShowImg = "no";
            showType = "EXCEL";
        }else if(po.fileType=="6"){//信息模块收藏来的超级链接地址
            isShowImg = "no";
            showType ="http";
        }
		if(sign=="dir"){
		    sign="folder";
		}
		if(po.fileIsShare!="0" && po.fileExtName.toLowerCase()=="dir"){
		    sign="shared";
		}
		var gifString = '<%=gifString%>';
		//alert(gifString);
		if(isShowImg=="yes"&&gifString.indexOf(sign+".gif#")>0){
			html ="<img src='/defaultroot/modules/personal/netdisk/filetype/"+sign+".gif' />";
		}else{
			html = showType;
		}
		
		return html;
	}
	//文件名
	function showFileSaveName(po,i){
		var userId = '<%=userId%>';
		var html = '<a class="trigger1" href="javascript:void(0)" ';
		var isShowImg = "yes";
        if(po.fileType=="2"){//html编辑
            isShowImg = "no";
        }else if(po.fileType=="3"){//普通编辑
            isShowImg = "no";
        }else if(po.fileType=="4"){//word编辑
            isShowImg = "no";
        }else if(po.fileType=="5"){//excel编辑
            isShowImg = "no";
        }else if(po.fileType=="6"){//信息模块收藏来的超级链接地址
            isShowImg = "no";
        }
       
        //alert("isShowImg:"+isShowImg+"-po.fileType:"+po.fileType+"-po.fileExtName.toLowerCase():"+po.fileExtName.toLowerCase());
		if(isShowImg=="no" && po.fileType=="6"){
			html += "onclick=javascript:viewHttp('"+po.fileName+"');";
		}else if(isShowImg=="no" && po.fileType!="6"){
			html += 'onclick="openWin({url:\'netdisk!getNetdiskById.action?currenUserId='+userId+'&id='+po.fileId+'\',isFull:true,width:800,height:600,winName:\'getNetdiskById_view\'});"';
		}else{
			var fileServer = '<%=fileServer%>';
			if(po.fileExtName.toLowerCase()=='jpg' || po.fileExtName.toLowerCase()=='gif' || po.fileExtName.toLowerCase()=='png' || po.fileExtName.toLowerCase()=='bmp'){
				//html += 'onMouseOver=show("'+po.fileSaveName+'",1,"'+po.fileName+po.fileExtName+'"); onMouseOut=show("'+po.fileSaveName+'",0,"'+po.fileName+po.fileExtName+'");';
				var path = po.fileName.substring(0,6)+'/'+po.fileName+'.'+po.fileExtName.toLowerCase();
				html += ' rel="' + fileServer + '/upload/netdisk/'+path+'" ';
			}
			if(po.fileExtName.toLowerCase()=='dir'){
				html += 'onclick="getchildfolder('+po.fileId+');" ';
			}else{
				html += 'onclick=\'downNetdiskFile("'+po.fileDownloadCode+'","'+po.fileSaveName+'","'+po.fileName+'","'+po.fileExtName+'","'+fileServer+'");\' ';
			}
		}
		html += '>'+po.fileSaveName+'</a>';
		return html;
	}
	
	//打开文件夹
	function getchildfolder(currentid){
		var copyitem = $("input[name='copyitem']").val();
		var copyorcut = $("input[name='copyorcut']").val();
		window.location.href="netdisk!list.action?upevent=0&currentid="+currentid+"&copyitem="+ copyitem +"&copyorcut="+ copyorcut +"";
	}
	//打开新建文档(http编辑、普通编辑、word编辑、excel编辑)
	function view(id){
		openWin({url:'netdisk!getNetdiskById.action?currenUserId=&id='+id,width:800,height:600,winName:'getNetdiskById_view'});
	}
	//打开超链接
	function viewHttp(link){
	    openWin({url:link,isFull:true});
	}
	//下载文件downloadFile
	function downNetdiskFile(dlCode, fileSaveName, fileName, fileExtName, fileServer){
        var downloadUrl = fileServer + "/public/download/download.jsp?";
        if(isPad()){
            downloadUrl = fileServer + "/DownloadServlet?cd=inline&isPad=true&";
        }
        downloadUrl += 'verifyCode='+dlCode+'&FileName='+fileName+'.'+fileExtName+'&path=netdisk';
		commonSubmitDynamicForm({"action":downloadUrl,"target":"downloadFile", params:[{'name':'name', 'value':fileSaveName}]});
	}
	
	function showShare(po,i){
		var html = "";
		if(po.fileIsShare!='0'){
			if(po.fileShareToName!=null&&po.fileShareToName!=''&&po.fileShareToName!='0'){
				html += po.fileShareToName;
			}else{
				html += "&nbsp;";
			}
		}else{
			html += "&nbsp;";
		}
		return html;
	}
	//大小
	function showFileSize(po,i){
		
		return po._fileSize;
	}
	
	//自定义操作栏内容
	function myOperate(po,i){
		//var html =  '<img src="images/modi.gif" title="修改" style="cursor:pointer" onclick="modify(\''+po[0]+'\')" ><img src="images/del.gif" title="删除" style="cursor:pointer" onclick="delSingle(\''+po[0]+'\')" >';
		var html = '';
		var showImg = "";
		var userId = '<%=userId%>';
		var currenid = $("input[name='currenid']").val();
		var sign=po.fileExtName.toLowerCase();
		var isShowImg = "yes";
		var showType = sign;
        if(po.fileType=="2"){//html编辑
            isShowImg = "no";
        	showType = "HTML";
        }else if(po.fileType=="3"){//普通编辑
            isShowImg = "no";
        	showType = "TXT";
        }else if(po.fileType=="4"){//word编辑
            isShowImg = "no";
        	showType = "WORD";
        }else if(po.fileType=="5"){//excel编辑
            isShowImg = "no";
        	showType = "EXCEL";
        }else if(po.fileType=="6"){//信息模块收藏来的超级链接地址
            isShowImg = "no";
        	showType ="http";
        }
        if(sign=="dir"){
		    sign="folder";
		}
		if(po.fileIsShare!="0" && po.fileExtName.toLowerCase()=="dir"){
		    sign="shared";
		}
		var gifString = '<%=gifString%>';
		//alert(gifString);
		if(isShowImg=="yes" && gifString.indexOf(sign+".gif#")>0){
			showImg =sign;
		}else{
			showImg = showType;
		}
		
        if(isShowImg=="no" && po.fileType!="6"){
        	//如果是新建文档，类型为html编辑、普通、word编辑、excel编辑 则有修改页面
        	html += '<img src="images/modi.gif" style="cursor:pointer;border:none;" onclick="openWin({url:\'netdisk!getNetdiskById.action?type=modify&id='+po.fileId+'&currenid='+currenid+'&currenUserId='+userId+'\',isFull:true,winName:\'getNetdiskById\'});" title="' + comm.modify + '"/>';
        }
        //html += '<a href="workLogAction.do?action=view_menu&statusType=7" target="leftFrame" title="删除"><img src="images/del.gif" style="cursor:pointer;border:none;" onclick="deletefile('+po.fileId+');"></a>';
        html += '<a href="javascript:void(0);"><img src="images/del.gif" style="cursor:pointer" onclick="del(\'netdisk!deletefile.action?fileId='+po.fileId+'&currenid='+currenid+'&verifyCode='+po.verifyCode+'\',this,\''+showImg+'\');" title="' + comm.delete_ + '" /></a>';
        po.fileSaveName = replaceAll(po.fileSaveName,"&#39;","\\'");
        //alert(po.fileSaveName);
        html += '<a href="javascript:void(0);"><img src="images/rename.gif" style="cursor:pointer;border:none;" onclick="openWin({url:\'netdisk!renameNetdisk.action?netdiskid='+po.fileId+'&oldname='+po.fileSaveName+'&type='+po.fileExtName.toLowerCase()+'&currenUserId='+userId+'\',width:500,height:170,winName:\'renameNetdisk\'});" title="' + Personalwork.webdisk_rename + '"/></a>';
		if(po.fileIsShare=="0" && po.fileExtName.toLowerCase()=="dir"){
			html += '<img  style="cursor:pointer" border="0" src="images/sharing.gif" onclick="openWin({url:\'netdisk!openshared.action?copyitem='+po.fileId+'&currenid='+currenid+'&currenUserId='+userId+'\',width:800,height:630,winName:\'openshared\'});" title="' + Personalwork.webdisk_share + '"/>';
		}
		if(po.fileIsShare!="0" && po.fileExtName.toLowerCase()=="dir"){
			html += '<img style="cursor:pointer" border="0" src="images/sharing.gif" title="' + Personalwork.webdisk_modifyshare + '" onclick="openWin({url:\'netdisk!modishared.action?id='+po.fileId+'\',width:920,height:630,winName:\'modishared\'});"/>';
			html += '<img  style="cursor:pointer" border="0" src="images/qx.gif" title="' + Personalwork.webdisk_cancelshare + '" onclick="unshared('+po.fileId+','+<%=currentid%>+');"/>';
		}
		//alert(html);
		return html;
	}
	
	//单个删除--删除文件夹时刷新左边菜单
	function del(url,obj,showImg){
	    if(showImg=='folder'||showImg=='shared'){//判断是不是文件夹
			$('#delFlag').val('1');
	    }
		ajaxDelete(url,obj);
	}
	
	//批量删除--删除文件夹时刷新左边菜单
	function delBatch(url,obj){
		var typeName = ""; 
		var imgFile = 0;
		$("input[name=fileId]").each(function(){
			if($(this).attr("checked")=='checked' ){
				var imgSrc = $(this).parent().parent().parent().next("td").children().attr("src");
				/* Modified by Qian Min for ezOFFICE 11.0.0.7 [BEGIN] */
				if(imgSrc != undefined){
					if(imgSrc.indexOf('shared.gif')!=-1||imgSrc.indexOf('folder.gif')!=-1){
						imgFile++;
					}
				}
				/* Modified by Qian Min for ezOFFICE 11.0.0.7 [END] */
			}
		});
		if(imgFile>0){
			$('#delFlag').val('1');
		}
		ajaxBatchDelete(url,'fileId','fileId',obj);
	}
	
	//如果是新建文档，类型为html编辑、普通、word编辑、excel编辑 则有修改页面
	function modifyfile(id){
	    //var currenid=document.all.currenid.value;
	    var currenid = $("input[name='currenid']").val();
	    var userId = '<%=userId%>';
	    openWin({url:'netdisk!getNetdiskById.action?type=modify&id='+id+'&currenid='+currenid+'&currenUserId='+userId,width:800,height:600,winName:'getNetdiskById'});
	}
	//重命名
	function rename(netdiskid,oldname,type){
		//alert(type);
		var userId = '<%=userId%>';
		openWin({url:'netdisk!renameNetdisk.action?netdiskid='+ netdiskid +'&oldname='+ oldname +'&type='+ type +'&currenUserId='+userId,width:420,height:240,winName:'renameNetdisk'});
	}
	
	function unshared(id,crrunid){
	  $.dialog.confirm(Personalwork.webdisk_cancelshareremind, function(){
		  var url = "netdisk!unshared.action?currenid="+ crrunid +"&id="+ id;
		  jQuery.ajax({
			  type : "POST",
			  url  : url,
			  success: function(msg){
			  	initListFormToAjax({formId:'queryForm'});
			  },
			  error: function(XMLHttpRequest, textStatus, errorThrown){
				
			  }
		  });
	  });
	}
	
	function common_DateFormatFull(datestr){
		if(datestr!=null){
			if(datestr.length > 16){
				return datestr.substring(2,16);
			}
			return datestr;
		}
		return "";
	}
	
	//返回上一级
	function uplist(){
	  var copyitem = $("input[name='copyitem']").val();
	  var copyorcut = $("input[name='copyorcut']").val();
	  var up_currentid = $("#up_currentid").val();
	  if(up_currentid==""){
	    up_currentid="0";
	  }
	  window.location.href="netdisk!list.action?currentid="+up_currentid+"&upevent=1&copyitem="+copyitem+"&copyorcut="+copyorcut;
	}
	//根目录
	function homes(){
	   var copyitem = $("input[name='copyitem']").val();
	   var copyorcut = $("input[name='copyorcut']").val();
	   window.location.href="netdisk!list.action?currentid=0&copyitem="+copyitem+"&copyorcut="+copyorcut;
	}
	
	//刷新本页
	function refresh(){
	    //以下两行是新增的，由于在进入下子目录后在返回到父目录后刷新则显示是子目录的内容，不合理----2008-11-12
	    var locationURL = window.location.href;
	    locationURL = locationURL.replace("#","");//---当打开文档内容后，locationURL后会多一个#，则要去掉#---2009-07-13
	    window.location.href=locationURL;
	    //下面2行是原来的
	  //var currenid=document.all.currenid.value;
	  //window.location.href="NetdiskAction.do?action=list&currentid="+ currenid +"";
	}
	
	
	//新建文档
	function newDoc(){
		var userId = '<%=userId%>';
		var currenid = $("input[name='currenid']").val();
		var fileidstring = $("input[name='fileidstring']").val();
		openWin({url:'netdisk!openNewDocument.action?currenid='+currenid+'&fileidstring='+ fileidstring +'&currenUserId='+userId,isFull:true,winName:'openNewDoc'});
	}
	
	//上传文件 
	function uploadfile(){
		
	}
	
	//新文件夹
	function addfolder(){
	   var currenid = $("input[name='currenid']").val();
	   var fileidstring = $("input[name='fileidstring']").val();
	   var userId = '<%=userId%>';
	   openWin({url:'netdisk!openfolder.action?currenid='+currenid+'&fileidstring='+ fileidstring +'&currenUserId='+userId,width:660,height:200,winName:'addfolder'});
	}
	//复制
	function copys(){
		 var currenid = $("input[name='currenid']").val();
		 var copyitem = getCheckBoxData("fileId","fileId");
		 var ishared = $("#ishared").val();
		
		if(copyitem==""){
		  $.dialog.alert(Personalwork.webdisk_copyselremind);
		  return false;
		}
		if((copyitem.charAt(copyitem.length-1)==",")==false){
			copyitem += ",";
		}
		$('#copyitem').val(copyitem);
		$('#copyorcut').val('0');
		
		ajaxForSync("<%=rootPath%>/modules/personal/netdisk/ajax_copyshare.jsp?currenid="+ currenid +"&copyitem="+ copyitem +"&copyorcut=0&ishared="+ ishared,'');
		$.dialog.alert(Personalwork.webdisk_copysuccess);
	 }
	//剪切
	function cuts(){
		 var currenid = $("input[name='currenid']").val();
		 var copyitem = getCheckBoxData("fileId","fileId");
		 var ishared = $("#ishared").val();
		  
	    if(copyitem==""){
		  $.dialog.alert(Personalwork.webdisk_cutremind);
		  return false;
		}
	    if((copyitem.charAt(copyitem.length-1)==",")==false){
			copyitem += ",";
		}
	    $('#copyitem').val(copyitem);
		$('#copyorcut').val('1');
		ajaxForSync("<%=rootPath%>/modules/personal/netdisk/ajax_copyshare.jsp?currenid="+ currenid +"&copyitem="+ copyitem +"&copyorcut=1&ishared="+ ishared,'');
		$.dialog.alert(Personalwork.webdisk_cutsuccess);
  	}
	
	/**
	 * 数组是否包含另一个元素
	 * @param {} arr
	 * @param {} value
	 * @return {Boolean}
	 */
	function isContainEle(arr,value){
		if(arr){
			for(var i in arr){
				if(arr[i]==value)
				return true;
			}
			return false;
		}
	}
	
	/**
	 * 过滤某个元素
	 * @param {} arr
	 * @param {} ele
	 */
	function filterElement(arr,ele){
		var arrTemp="";
		var len=arr.length;
		if(arr){
			for(var i=0;i<len;i++){
				if(arr[i]!=ele){
				 arrTemp+=arr[i];
				 arrTemp+=",";
				}
			}
			return arrTemp;
		}
		return "";
	}
	
	 //粘贴
	function parse(){
		 var currenid = $("input[name='currenid']").val();
		 var copyitem = $("input[name='copyitem']").val();
		 var copyorcut = $("input[name='copyorcut']").val();
		 var _fileOwnId = '<%=userId%>';
		 
		 if(copyitem==null || copyitem=='null' || copyitem==''){
		 	var json = ajaxForSync("<%=rootPath%>/modules/personal/netdisk/ajax_copyshare.jsp",'');
		 	    json = eval('('+json+')');
		 	copyitem = json.copyitem;
		 	copyorcut = json.copyorcut;
		 	//currenid = json.currenid;
		 	//alert("dd:"+copyitem);
		 }
		 
		 //alert(currenid);
		 
		 //return ;
		 
		 if(copyitem==null || copyitem=='null' ||copyitem==''){
			 $.dialog.alert(Personalwork.webdisk_copyselremind);
			 return;
		 }
		 var url = "netdisk!getFileAllSize.action?copyitem="+ copyitem+"&fileOwnId="+_fileOwnId;
	  	 jQuery.ajax({//取复制文件大小
			  async: false,
			  type : "POST",
			  url  : url,
			  success: function(msg){
			  	var msg_json = eval("("+msg+")");
			  	$("#copyPraseFileSize").val(msg_json.result);
			  	
			  },
			  error: function(XMLHttpRequest, textStatus, errorThrown){
				
			  }
	  	 });
	  	 
	  	 var copyPraseFileSize = $("#copyPraseFileSize").val();
		 var root = '<%=rootPath%>';
		 if(copyPraseFileSize=="false"){
	       $.dialog.alert(Personalwork.webdisk_documentoverflowtips);
		   return false;
		 }
		 
		 var copyitemSubs="";
		 if(copyitem.indexOf(",")>0){
			var indexs=copyitem.indexOf(",");
			var arr=new Array();
			    arr=copyitem.split(",");
			    if(!isContainEle(arr,currenid)){
			    	var url = root+"/netdisk!parse.action?currenid="+ currenid +"&copyitem="+ copyitem +"&copyorcut="+copyorcut;
		 			ajaxOperate({url:url,tip:"",isconfirm:false,formId:"queryForm",callbackfunction:null});
				}
		 }else{
		   if(copyitem!=currenid)return;
		   		var url = root+"/netdisk!parse.action?currenid="+ currenid +"&copyitem="+ copyitem +"&copyorcut="+copyorcut;
		 		ajaxOperate({url:url,tip:"",isconfirm:false,formId:"queryForm",callbackfunction:null});
		 }
		 $('#copyitem').val('');
		 $('#copyorcut').val('');
		 //$.dialog.alert("保存成功!");
	 }
	
	function search123(){
	  	var tag=$('#searchtable1').css('display');
	  	if(tag=="none"){
		  	$('#searchtable1').css('display','');
	  	}else{
	    	$('#searchtable1').css('display','none');
	  	}
	  
	}
	
   </script>

</html>
