<!DOCTYPE html>
<%@ include file="/public/include/init.jsp"%>
<html lang="zh-cn">
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<%String whir_custom_str_new="detail";%>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><s:property value="information.informationTitle"/></title>
	
	<%@ include file="/public/include/meta_base_2016.jsp"%>
	<s:if test="information.forbidCopy==1">
		<script type="text/javascript"> 
		<!-- 
		document.oncontextmenu=function(e){return false;} 
		// -->
		</script> 
	</s:if>
</head>
<%
	String iso = request.getParameter("iso")!=null?request.getParameter("iso"):"";
	String path = "information";
	if(iso!=null && iso.equals("1")){
		path = "isodoc";
	}
	String userId = session.getAttribute("userId").toString();
	String canVindicate = request.getAttribute("canVindicate")!=null?request.getAttribute("canVindicate").toString():"false";//栏目维护权限
	String delComment = request.getAttribute("delComment")!=null?request.getAttribute("delComment").toString():"0";//评论修改删除权限
	String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
	List alist = new ArrayList();
	String content = request.getAttribute("content").toString();
	
	//2013-09-02-----修改开始
	String gd     =(request.getParameter("gd")==null || "null".equals(request.getParameter("gd")))?"":request.getParameter("gd");
	String gdType = EncryptUtil.htmlcode(request,"gdType");
	gdType = gdType.equals("")?"information":gdType;
	String gdFromType =(request.getParameter("gdFromType")==null || "null".equals(request.getParameter("gdFromType")))?"":request.getParameter("gdFromType");
	//2013-09-02-----修改结束
	
	//2013-09-11-----单位主页归档需要的参数-----start
  	String departchannelId =request.getParameter("departchannelId")==null?"":request.getParameter("departchannelId").toString();
  	String departchannelType =request.getParameter("departchannelType")==null?"":request.getParameter("departchannelType").toString();
  	String departuserChannelName =request.getParameter("departuserChannelName")==null?"":request.getParameter("departuserChannelName").toString();
  	String departuserDefine =request.getParameter("departuserDefine")==null?"":request.getParameter("departuserDefine").toString();
  	String departheadColor =request.getParameter("departheadColor")==null?"":request.getParameter("departheadColor").toString();
  	//2013-09-11-----单位主页归档需要的参数-----end
	
	//20151217 -by jqq 取该用户对该信息是否有打印权限
	String canprint = request.getAttribute("canPrint")!=null?request.getAttribute("canPrint").toString():"0";
%>
<body class="wh-print" <s:if test="information.forbidCopy==1">onselectstart="return false"</s:if> >
	<div class="container-fluid">
	<!--startprint-->
		<div class="print-ss">
		<div id="print-div" class="wh-p-container">
          <!---------------------页面标题 副标题------------------------->
		  <div class="wh-prt-tit">
            <s:if test="information.displayTitle == 1">
			<h1><s:property value="information.informationTitle"/></h1>
			</s:if>
			<s:if test="information.informationSubTitle!=null && information.informationSubTitle!=''">
				<h2><s:property value="information.informationSubTitle"/></h2>
			</s:if>
          </div>
          <div class="wh-prt-meta">
            <!---------------------发布时间  发布人------------------------->
			<div class="meta-l">
              <span id="issue-time" class="meta-date" style="display:none"><s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/></span>
              <span id="issue-user" style="display:none"><strong class="meta-author"><s:text name="info.searchareapublisher"/>：</strong>
              <span class="meta-aname"><s:property value="information.informationIssueOrg"/>.<s:property value="information.informationIssuer"/></span></span>
            </div>
          </div>
          <hr/>
		  <!-----------------------------------------页面内容 start------------------------------------------->
		  <div class="wh-prt-art clearfix">
            <input type="hidden" name="gd" value="<%=gd%>" id="gd"/>
			<s:hidden id="channelId" name="channelId"/>
			<s:hidden id="userChannelName" name="userChannelName"/>
			<s:hidden id="userDefine" name="userDefine"/>
			<s:hidden id="channelType" name="channelType"/>
			
            <s:if test="#request.fileLink == 'fileLink'">
			<%
			String fileName = request.getAttribute("fileName")==null?"":request.getAttribute("fileName").toString();
			String saveName = request.getAttribute("saveName")==null?"":request.getAttribute("saveName").toString();
			java.io.File file = new java.io.File(preUrl+"/upload/"+path+"/"+saveName);
			String subFolder = "";
			if(!file.exists()){
				subFolder = saveName.substring(0,6)+"/";
			}
			%>
				<s:if test="#request.fileName!='' && #request.saveName!=''">
					<!--------- 文件类型是pdf ------------>
					<s:if test="#request.fileType == 'PDF'">
						<!--------- 文件禁止打印 ------------>
						<s:if test="information.forbidCopy == 1">
							<div id="pdfDiv" class="wh-dtl-media">
								<iframe name="dd" src="<%=rootPath%>/modules/kms/information_manager/newViewPDF.jsp?url=<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>" frameborder=0 style="width:900px;height:630px;" border=0></iframe>
							</div>
						</s:if>
						<!--------- 不禁止打印 ------------>
						<s:else>
							<div id="pdfDiv" class="wh-dtl-media">
								<iframe name="dd" src="<%=rootPath%>/modules/govoffice/gov_documentmanager/viewPDF.jsp?url=<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>" frameborder=0 style="width:900px;height:630px;" border=0></iframe>
							</div>
						</s:else>
					</s:if>
					<!------------------------ 文件类型是jpg bmp gif 图片 ------------------------->
					<s:elseif test="#request.fileType == 'JPG' || #request.fileType == 'BMP' || #request.fileType == 'GIF'">
						<div class="wh-dtl-media"><img src="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>"/></div>
					</s:elseif>
					<!----------------------------- 文件类型是mpg mp3 avi wmv 等媒体 ------------------------------>
					<!--视频播放-----20130929-----start-->
					<s:elseif test="#request.fileType == 'MPG' || #request.fileType == 'MP3' || #request.fileType == 'WMV' || #request.fileType == 'ASF' || #request.fileType == 'AVI' || #request.fileType == 'MPEG'">
						<div class="wh-dtl-media">
							<object classid="clsid:22d6f312-b0f6-11d0-94ab-0080c74c7e95" >
								<param name="showstatusbar" value="1">
								<param name="filename" value="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>">
								<embed src="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>"></embed>
							</object>
						</div>
					</s:elseif>
					<!--------- 文件类型是rm rmvb 不能播放提供专门的播放器下载 ------------>
					<s:elseif test="#request.fileType == 'RM' || #request.fileType == 'RMVB'">
						<div class="wh-dtl-media">
							<object classid="clsid:cfcdaa03-8be4-11cf-b84b-0020afbbccfa" width="400" height="350" align="center">
								<param name="src" value="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>">
								<param name="console" value="clip1"><param name="controls" value="imagewindow">
								<param name="autostart" value="true">
							</object><br>
							<object classid="clsid:cfcdaa03-8be4-11cf-b84b-0020afbbccfa" height="32" width="400" align="center">
								<param name="src" value="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>">
								<param name="controls" value="controlpanel"><param name="console" value="clip1">
							</object><br>如果不能播放请<a href="<%=rootPath%>/modules/kms/information_manager/RealONEPlayerV6.0.11.868.exe">下载realone播放器</a>
						</div>
					</s:elseif>
					<s:elseif test="#request.fileType == 'SWF'">
						<div class="wh-dtl-media">
							<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="400" height="350" codebase="<%=rootPath%>/modules/kms/information_manager/SWFLASH.CAB">
								<param name="movie" value="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>">
								<param name="quality" value="high">
								<embed src="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>" type="application/x-shockwave-flash"></embed>
							</object>
						</div>
					</s:elseif>
					<s:elseif test="#request.fileType == 'IPX'">
						<div class="wh-dtl-media">
							<embed src="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>" width="364" height="359"></embed>&nbsp;如果不能播放请<a href="<%=rootPath%>/modules/kms/information_manager/axIpx32.exe">下载安装IPIX插件</a>
						</div>
					</s:elseif>
					<s:elseif test="#request.fileType == 'DWF'">
						<div class="wh-dtl-media">
							<object id='FNDWF70' classid='clsid:B2BE75F3-9197-11CF-ABF4-08000996E931' width='600' height='400' align='center'>
								<param name='Filename' value='<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>'>
								<param name='UserInterface' value='on'>
								<param name='BackColor' value='#FFFFFF'>
								<embed width='600' height='400' filename='<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>' userinterface='on' backcolor='#000000' align='center' name='FNDWF' pluginspage='http://www.autodesk.com/prods/whip' src='<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>'></embed>
							</object><br>如果不能浏览请<a href="<%=rootPath%>/modules/kms/information_manager/ExpressViewerSetup.exe">下载安装插件</a>
						</div>
					</s:elseif>
					<%
					EncryptUtil util = new EncryptUtil();
					String dlcode = util.getSysEncoderKeyVlaue("FileName",saveName,"dir");
					%>
					<!--视频播放-----20130929-----end-->
					<%-- <s:if test="information.forbidCopy != 1">
					<div class="news_fileLink">链接附件：<a href="<%=preUrl%>/public/download/download.jsp?FileName=<%=saveName%>&name=<%=fileName%>&path=<%=path%>&verifyCode=<%=dlcode%>"  target="_self"><%=fileName%></a></div>
					</s:if> --%>
				</s:if><!-----对应#request.fileName!='' && #request.saveName!=''---->
				<s:else>
					<div class="news_fileLink">链接附件：<span class="MustFillColor">链接文件不存在或已经被删除！</span></div>
				</s:else>
			</s:if><!-----对应request.fileLink == 'fileLink'---->
			<s:else>
				<s:if test="information.informationType == 0 || information.informationType == 1">
					<%
					String infoPicName = request.getAttribute("infoPicName")!=null?request.getAttribute("infoPicName").toString():"";
					String infoPicSaveName = request.getAttribute("infoPicSaveName")!=null?request.getAttribute("infoPicSaveName").toString():"";
					if(!infoPicName.equals("")){
						String[] imgs = infoPicSaveName.split("\\|");
					%>
					<div class="wh-dtl-media">
					<%
						for(int i=0;i<imgs.length;i++){
							String img = imgs[i];
							String realSrcUrl = preUrl+"/upload/"+path+"/"+img;
							String smallName = img.substring(0,img.lastIndexOf("."))+"_small"+img.substring(img.indexOf("."),img.length());
							String smallSrcUrl = preUrl+"/upload/"+path+"/"+smallName;
							java.io.File smallfile = new java.io.File(smallSrcUrl);
							//20160421 -by jqq未改造使用缩略图之前的上传图片，没有对应的_small文件，仍使用原文件地址
							/*if(!smallfile.exists()){
								smallSrcUrl = realSrcUrl;
							}*/
							java.io.File file = new java.io.File(realSrcUrl);
							
							if(!file.exists()){
								realSrcUrl = preUrl+"/upload/"+path+"/"+img.substring(0,6)+"/"+img;
								smallSrcUrl = preUrl+"/upload/"+path+"/"+img.substring(0,6)+"/"+smallName;
								/*java.io.File smallfiletmp = new java.io.File(smallSrcUrl);
								if(!smallfiletmp.exists()){
									smallSrcUrl = realSrcUrl;
								}*/
							}
					%>
					<s:if test="information.displayImage == 1">
						<p><img name="image" src="<%=smallSrcUrl%>" onerror="javascript:this.src='<%=realSrcUrl%>'"  style="cursor:pointer"/></p>
					</s:if>
					<%
						}//for 循环结束
					%>
					</div>
					<%
					}//!infoPicName.equals("") 结束
					%>
					<%=content%>
				</s:if><!----informationType == 0 || informationType == 1----->
				<s:else>
					<%
					String infoPicName2 = request.getAttribute("infoPicName2")!=null?request.getAttribute("infoPicName2").toString():"";
					String infoPicSaveName2 = request.getAttribute("infoPicSaveName2")!=null?request.getAttribute("infoPicSaveName2").toString():"";
					
					if(!infoPicName2.equals("")){
						String[] imgs2 = infoPicSaveName2.split("\\|");
					%>
					<div class="wh-dtl-media">
					<%
						for(int i=0;i<imgs2.length;i++){
							String img2 = imgs2[i];
							String realSrcUrl2 = preUrl+"/upload/"+path+"/"+img2;
							String smallName2 = img2.substring(0,img2.lastIndexOf("."))+"_small"+img2.substring(img2.indexOf("."),img2.length());
							String smallSrcUrl2 = preUrl+"/upload/"+path+"/"+smallName2;
							java.io.File file2 = new java.io.File(realSrcUrl2);
							if(!file2.exists()){
								realSrcUrl2 = preUrl+"/upload/"+path+"/"+img2.substring(0,6)+"/"+img2;
								smallSrcUrl2 = preUrl+"/upload/"+path+"/"+img2.substring(0,6)+"/"+smallSrcUrl2;
							}
					%>
					<s:if test="information.displayImage == 1">
						<p><img name="image" src="<%=smallSrcUrl2%>" onerror="javascript:this.src='<%=realSrcUrl2%>'"  style="cursor:pointer"/></p>
					</s:if>
					<%
						}//for 循环结束
					%>
					</div>
					<%
					}//!infoPicName2.equals("") 结束
					%>
					<%--<div>
						 <form name="webform" method="post">
							<table width="100%" id="showImage">
								<tr id="showImage">
									<td height="1" align="center">
										<div id="panel3" name="panel3">
											<%@ include file="/public/iWebOfficeSign/iWebOfficeVersion2.jsp"%>
										</div>
									</td>
									<input type="hidden" name="weboff">
								</tr>
							</table>
						</form>
					</div> --%>
				</s:else><!--对应不是0/1类型信息，且不是文件链接的 结束（其实是office类型）-->
			</s:else><!---对应不是 request.fileLink == 'fileLink'文件链接 的情况 结束--->
		  </div>
		  <!-----------------------------------------页面内容 end------------------------------------------->
         </div>
		</div>
		 <!--endprint-->
		<div id="check-div" class="wh-dtl-check">
			<label class="checkbox-inline">
				<input type="checkbox" id="userCheckbox" > <s:text name="info.printuser"/>
			</label>
			<label class="checkbox-inline">
				<input type="checkbox" id="timeCheckbox" > <s:text name="info.printtime"/>
			</label>
		</div>
		<div id="button-div" class="wh-prt-enter">
			<button class="btn btn-default" onclick="infoPrint();"><s:text name="info.confirmprint"/></button>
		</div>
	</div>
</body>
</html>
<script>
//阅读情况
function browser(){
	openWin({url:'realtimemessage!onlinelist.action?fromtype=information&id='+'<s:property value="information.informationId"/>',winName:'browser',isFull:true});
}
//信息打印：统计打印次数
function infoPrint(){
	var informationId = '<s:property value="information.informationId"/>';
	var channelId = '<s:property value="channelId"/>';
	//ajaxOperate({urlWithData:'Information!print.action?informationId='+informationId+'&channelId='+channelId,tip:'',isconfirm:false,formId:''});
	$.ajax({
		type: 'POST',
		url: whirRootPath+'/Information!print.action?informationId='+informationId+'&channelId='+channelId,
		async: true,
		dataType: 'text',
		success: function(data){
			if(data!=null && data!=""){
				if(data=="1"){
					
					var bdhtml=window.document.body.innerHTML;
					var sprnstr="<!--startprint-->";
					var eprnstr="<!--endprint-->";
					var prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17);
					prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
					window.document.body.innerHTML=prnhtml;
					window.print();
					window.opener=null; 
					window.open('','_self'); 
					window.close();
					//var oldPage = window.document.body.innerHTML;
					//window.document.body.innerHTML=bdhtml;
				}else{
					//禁止右键
					document.oncontextmenu = stoprightbutton;
					whir_alert("打印次数已达上限！");
				}
			}
		}
	});
}

$("#userCheckbox").click(function(){
	 if($(this).prop('checked')){
		$("#issue-user").show();
	 }else{
		$("#issue-user").hide();
	 }
});
$("#timeCheckbox").click(function(){
	 if($(this).prop('checked')){
		$("#issue-time").show();
	 }else{
		$("#issue-time").hide();
	 }
});
</script>

<script>
$(document).ready(function(){
	var isfordbidCopy = '<s:property value="information.forbidCopy"/>';
	var hasprintright = '<%=canprint%>';
	var informationId = '<s:property value="information.informationId"/>';
	var channelId = '<s:property value="channelId"/>';
	if(hasprintright != '1'){
		//禁止右键
		document.oncontextmenu = stoprightbutton;
	}else{
		//拥有权限，并且打印次数用完，不允许右键
		$.ajax({
			type: 'POST',
			url: whirRootPath+'/Information!judgePrintNum.action?informationId='+informationId+'&channelId='+channelId,
			async: true,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!=""){
					if(data!="1"){
						//禁止右键
						document.oncontextmenu = stoprightbutton;
					}
				}
			}
		});
	}
	document.onkeydown = function(event){
		var e = event || window.event;
		if((e.ctrlKey) && (e.keyCode==80)){
			if(isIe()){
				alert("禁止打印");
				//IE中阻止函数器默认动作的方式
				window.event.cancelBubble = true;
				window.event.returnValue = false;
			}else{
				e.preventDefault();
			}
			return false;
		}
	};

	$("body").unbind('keydown');
});
//禁止页面右键（点击返回页面退回，可能导致审核信息不经审核就保存）
function stoprightbutton(){
	return false;
}
function isIe(){
	return ("ActiveXObject" in window);
}

//处理页面图片，宽度大于800px时等比缩放处理
function FormatImagesSize(w){
    var e = new Image();
    $("img[name='image']").each(function(){
        e.src = $(this).attr("src");
        if(e.width>w){
		    $(this).attr("width", w);
			//宽度小于800px不变，大于800px等比缩放
			var Ratio = 800 / e.width;
			var h = e.height;
			$(this).attr("height", h * Ratio);
        }
    });
}

FormatImagesSize(800);
//返回顶部使用的脚本
$('.side-go-top').scrollTotop({
        offsetFixed:200, /*滚动条距离顶部300时触发 show-fixed*/
        offsetTop:100, /*滚动条距离顶部200时触发 show-top*/
        duration:300 /*回到顶部花费时间*/
});

</script>