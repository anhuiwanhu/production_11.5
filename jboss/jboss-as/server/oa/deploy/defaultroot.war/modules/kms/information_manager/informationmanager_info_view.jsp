<!DOCTYPE html>
<%@ include file="/public/include/init.jsp"%>
<html lang="zh-cn" class="wh-gray-bg <%=whir_2016_skin_color%> <%=whir_2016_skin_styleColor%> <%=whir_pageFontSize_css%>">
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
	<script src="<%=rootPath%>/scripts/main/whir.application_2016.js" language="javascript"></script>
</head>
<%
	String iso = request.getParameter("iso")!=null?request.getParameter("iso"):"";
	String path = "information";
	//20160627 -by jqq 文档管理的历史版本查看改造
	String isoFlag = request.getAttribute("isoFlag")!=null?request.getAttribute("isoFlag").toString():"0";
	if( (iso!=null && iso.equals("1")) || "1".equals(isoFlag)){
		path = "isodoc";
	}
	//20160711 -by jqq 历史版本查看页面标识
	String hisFlag = request.getAttribute("hisFlag")!=null?request.getAttribute("hisFlag").toString():"";
	String userId = session.getAttribute("userId").toString();
	String userName = session.getAttribute("userName").toString();
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
	com.whir.common.util.UploadFile upFile = new com.whir.common.util.UploadFile();
	//20151116 -by jqq 取该信息点赞次数
	String praiseNum = request.getAttribute("praiseNum")!=null?request.getAttribute("praiseNum").toString():"0";
	String haspraise = request.getAttribute("haspraise")!=null?request.getAttribute("haspraise").toString():"0";
	//20151215 -by jqq 取该信息阅读统计总数
	String viewnum = request.getAttribute("viewnum")!=null?request.getAttribute("viewnum").toString():"0";
	if(Long.valueOf(viewnum) > new Long(999)){
		viewnum = "999+";
	}
	//20151217 -by jqq 取该用户对该信息是否有打印权限
	String canprint = request.getAttribute("canPrint")!=null?request.getAttribute("canPrint").toString():"0";
	//20160512 -by jqq 公共标签与个人标签
	List publicList = new ArrayList();
	publicList = (List) request.getAttribute("publicList");
	List personalList = new ArrayList();
	personalList = (List) request.getAttribute("personalList");
	List allPersonalList = new ArrayList();
	allPersonalList = (List) request.getAttribute("allPersonalList");
	String historyId = request.getParameter("historyId")==null?"":request.getParameter("historyId").toString();
	//20160513 -by jqq 评论使用头像
	String userphoto =  request.getAttribute("userphoto")==null?"/images/noliving.gif":request.getAttribute("userphoto").toString();
%>
<%
	//当前信息下标
	int index = 0;
	if(request.getParameter("index")!=null&&
	   !"null".equals(request.getParameter("index")+"")&&
	   !"".equals(request.getParameter("index")+"")){
	   index = Integer.parseInt(request.getParameter("index")+"");
	}
	//数据总条数
	int recordCount = 0;
	if(request.getParameter("recordCount")!=null&&
	   !"null".equals(request.getParameter("recordCount")+"")&&
	   !"".equals(request.getParameter("recordCount")+"")){
	   recordCount = Integer.parseInt(request.getParameter("recordCount")+"");
	}
	String checkdepart = request.getParameter("checkdepart")!=null ? request.getParameter("checkdepart") : "";
	checkdepart = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(checkdepart);
%> 
<body <s:if test="information.forbidCopy==1">onselectstart="return false"</s:if> >
	<div class="wh-wrapper">
    <div class="wh-view wh-detail wh-d-info">
      <div class="wh-dtl-top" id="info-top-div">
        <div class="container">
          <!-------------  信息所属栏目 ---------------->
		  <s:if test="information.informationOrISODoc!=1">
		  <div class="wh-dtl-bread">
            <a href="javascript:void(0);"><i class="fa fa-circle fa-color"></i></a>
			<a href="javascript:void(0);" class="dtl-fst" onclick="openChannel();" style="cursor:pointer"><span><s:property value="#request.channelNameString"/></span></a>
		</div>
		  </s:if>
          <!-------------  版本 附件 属性 关联 等下拉结构 start---------------->
		  <div class="wh-dtl-nav pull-right">
            <ul class="nav" role="tablist">
              <!-------------------------------------------版本 处理--------------------------------------------->
			  <li id="versionDropdown" role="presentation" class="dropdown">
				<a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><s:text name="info.detailversion"/><span class="arrow"><em></em></span></a>
                <div class="version dropdown-menu"> 
                  <div class="version-con">
                    <ol id="versionol">
                    </ol>
                  </div>
                </div>
              </li>
            <!-------------------------------------------附件 处理--------------------------------------------->
			<%
			String infoAppendName = request.getAttribute("infoAppendName")!=null?request.getAttribute("infoAppendName").toString():"";
			String infoAppendSaveName = request.getAttribute("infoAppendSaveName")!=null?request.getAttribute("infoAppendSaveName").toString():"";
			%>
			<s:if test="information.forbidCopy != 1">
				<s:if test="information.informationType == 4">
				<%
				infoAppendName += "|"+content+".doc";
				infoAppendSaveName += "|"+content+".doc";
				%>
				</s:if>
				<s:if test="information.informationType == 5">
				<%
				infoAppendName += "|"+content+".xls";
				infoAppendSaveName += "|"+content+".xls";
				%>
				</s:if>
				<s:if test="information.informationType == 6">
				<%
				infoAppendName += "|"+content+".ppt";
				infoAppendSaveName += "|"+content+".ppt";
				%>
				</s:if>
			</s:if>
			<%
				//2013-09-18-----处理附件问题
				if(infoAppendName.startsWith("|")){
					infoAppendName =infoAppendName.substring(1,infoAppendName.length());
				}
				if(infoAppendSaveName.startsWith("|")){
					infoAppendSaveName =infoAppendSaveName.substring(1,infoAppendSaveName.length());
				}
				//2013-09-18-----处理附件问题
				//20160607 -by jqq 统计附件数量
				int appendNum = 0;
				if(infoAppendSaveName !=null && !"".equals(infoAppendSaveName)){
					String[] appendArr = infoAppendSaveName.split("\\|");
					appendNum = appendArr.length;
				}
				
			%>
			<li role="presentation" class="dropdown">
                <a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><s:text name="info.viewattachment"/><%if(appendNum!=0){%><span class="badge"><%=appendNum%></span><%}%><span class="arrow"><em></em></span></a>
                <div class="doc dropdown-menu">
					<input type="hidden" name="infoAppendName" id="infoAppendName" value="<%=infoAppendName%>"/>
					<input type="hidden" name="infoAppendSaveName" id="infoAppendSaveName" value="<%=infoAppendSaveName%>"/>
					<jsp:include page="/public/upload_2016/uploadify/upload_include.jsp" flush="true">
					   <jsp:param name="dir" value="<%=path%>" />
					   <jsp:param name="uniqueId" value="uploadAppend" />
					   <jsp:param name="realFileNameInputId" value="infoAppendName" />
					   <jsp:param name="saveFileNameInputId" value="infoAppendSaveName" /> 
					   <jsp:param name="canModify" value="no" /> 
					   <jsp:param name="width" value="90" />
					   <jsp:param name="height" value="20" />
					   <jsp:param name="multi" value="true" />  
					   <jsp:param name="buttonClass" value="upload_btn" />
					   <jsp:param name="buttonText" value="上传附件" />
					   <jsp:param name="fileSizeLimit" value="0" /> 
					   <jsp:param name="fileTypeExts" value="" /> 
					   <jsp:param name="uploadLimit" value="0" /> 
					</jsp:include>
                </div>
			</li>
              <!---------------------------属性 处理（包含：作者，文章类型，摘要）------------------------------>
			  <li role="presentation" class="dropdown">
                <a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><s:text name="info.property"/>
                  <span class="arrow"><em></em></span></a>
                <div class="attr dropdown-menu">
                  <div class="attr-con">
                    <s:if test="information.informationOrISODoc!=1">
					<dl class="dl-horizontal">
                      <dt><s:text name="info.viewauthor"/>：</dt>
					  <dt></dt>
					  <dd id="info-author-name" title='<s:property value="%{information.informationAuthor}"/>'></dd>
                    </dl>
					</s:if>
                    <s:if test="information.informationOrISODoc!=1">
					<dl class="dl-horizontal">
                      <dt><s:text name="info.viewcontenttype"/>：</dt>
                      <dd><s:if test="information.documentType==0"><s:text name="info.authorstatcompose"/></s:if><s:if test="information.documentType==1"><s:text name="info.authorstatedit"/></s:if><s:if test="information.documentType==2"><s:text name="info.authorstatexcerpt"/></s:if></dd>
                    </dl>
					</s:if>
                    <dl>
                      <dt>
                        <s:text name="info.viewabstract"/>：
                      </dt>
                      <dd>
                        <p>
                          <s:property value="information.informationSummary"/>
                        </p>
                      </dd>
                    </dl>
                  </div>
                </div>
              </li>
			  <!-------------------------------------关联 相关性处理----------------------------------->
              <li role="presentation" class="dropdown">
                <a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><s:text name="info.relation"/><span class="badge" id="relationNumSpan"></span><span class="arrow"><em></em></span></a>
                <div class="relate dropdown-menu"> 
                  <div class="relate-con" id="relationDiv">
                    <s:if test="information.informationOrISODoc!=1">
					<script type="text/javascript">
					<!--
						<%
						String _informationId_=request.getAttribute("information.informationId")+""; 
						String  relationUrl=rootPath+"/relation!relationIncludeList.action?moduleType=information&infoId="
						+_informationId_+"&showAdd=0&tagName=relationObjectDIV&iframeName=relationIFrame&relationview=1&hasprintright="+canprint+"&newView=1";
						%>
						$("#relationDiv").load("<%=relationUrl%>&stime="+(new Date().getTime()) ,function(responseTxt,statusTxt,xhr){
							var   _relationTempNum=$("#relationTempNum").val();
							if(_relationTempNum!=null&&_relationTempNum!=""&&_relationTempNum!="0"){
								$("#relationNumSpan").html(_relationTempNum);
								$("#relationNumSpan").show();
							}else{
								$("#relationNumSpan").hide();
							}
							}); 
					//-->
					</script> 	
					</s:if>
					<s:else>
					<%
					List assoicateInfo = (List)request.getAttribute("assoicateInfo");
					if(assoicateInfo!=null && assoicateInfo.size()>0){
					%>
					<dl>
                      <dt><s:text name="info.viewrelatedcontent"/></dt>
                      <dd>
                        <ul>
						<%
						for(int i=0;i<assoicateInfo.size();i++){
							Object[] obj = (Object[])assoicateInfo.get(i);
						%>
							<li><a href="javascript:void(0);" onclick="viewInfo('<%=obj[1].toString()%>','<%=obj[6].toString()%>','<%=obj[7].toString()%>')"><i class="fa fa-circle"></i><p><%=obj[2].toString()%></p></a></li>
						<%}%>
                        </ul>
                      </dd>
                    </dl>
					<script type="text/javascript">
					<!--
						<%
						String relationNum = assoicateInfo.size() + ""; 
						%>
						$("#relationNumSpan").html("<%=relationNum%>");
						$("#relationNumSpan").show();
					//-->
					</script> 
					<%}else{%>
					<script type="text/javascript">
					<!--
						$("#relationNumSpan").hide();
					//-->
					</script>
					<%}%>
					</s:else>
                  </div>
                </div>
              </li>
            </ul>
          </div>
		  <!-------------  版本 附件 属性 关联 等下拉结构 end---------------->
        </div>
      </div>
      <div class="wh-dtl-con">
        <div class="container">
          <!---------------------页面标题 副标题------------------------->
		  <div class="wh-dtl-tit">
            <s:if test="information.displayTitle == 1">
			<h1><s:property value="information.informationTitle"/></h1>
			</s:if>
			<s:if test="information.informationSubTitle!=null && information.informationSubTitle!=''">
				<h2><s:property value="information.informationSubTitle"/></h2>
			</s:if>
          </div>
          <div class="wh-dtl-meta">
            <!---------------------发布时间  发布人------------------------->
			<div class="meta-l">
              <span class="meta-date"><s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/></span>
              <strong class="meta-author"><s:text name="info.searchareapublisher"/>：</strong>
              <span class="meta-aname"><s:property value="information.informationIssueOrg"/>.<s:property value="information.informationIssuer"/></span>
            </div>
		<%if(!"1".equals(hisFlag)){%>
			 <!---------------------  阅读情况 ------------------------->
            <div class="meta-more meta-r" id="info-moreinfo">
              <a href="javascript:void(0);" class="meta-m-view" onclick="browser();" title='<s:text name="info.ReadCircumstance"/>'><i class="fa fa-eye"></i><span><%=viewnum%></span></a>
              <!---------------------  评论 ------------------------->
			  <s:if test="information.informationOrISODoc!=1">
			  <s:if test='information.informationCanRemark!=0'>
			  <a id="comment-a" href="javascript:void(0);" class="meta-m-commit" tabindex="1"><i class="fa fa-pencil-square-o"></i><em id="comment-num"><s:property value="#request.commentNum"/></em><span><s:text name="info.detailcomment"/></span></a>
			  </s:if>
			  </s:if>
              <!---------------------  点赞 ------------------------->
			  <%if("0".equals(haspraise)){%>
				<a id="praise-<s:property value='information.informationId'/>" href="javascript:void(0);" class="meta-m-vote"><i class="fa fa-thumbs-o-up"></i><em id="praise-num-<s:property value='information.informationId'/>"><%=praiseNum%></em><span><s:text name="info.like"/></span></a>
			  <%}else{%>
				<a id="praise-<s:property value='information.informationId'/>" href="javascript:void(0);" class="meta-m-vote active"><i class="fa fa-thumbs-o-up"></i><em id="praise-num-<s:property value='information.informationId'/>"><%=praiseNum%></em><span><s:text name="info.like"/></span></a>
			  <%}%>
            </div>
		<%}%>
          </div>
          <hr/>
		  <!-------------------------信息标签：公共标签 & 个人标签 ------------------------------->
        <%if(!"1".equals(hisFlag)){%>
		  <s:if test="information.informationOrISODoc!=1">
		  <div id="tags-div" class="meta-tags clearfix">
			<a id="tags-a" href="javascript:void(0);" class="meta-cogs" tabindex="1" title="<s:text name='info.columnadd'/><s:text name='info.Tag'/>">+</a>
			<%
			if(publicList!=null && publicList.size()>0){
				for(int i=0; i<publicList.size(); i++){
					Object[] tagobj = (Object[])publicList.get(i);
			%>
			<a href="javascript:void(0);" class="meta-tag" onclick="searchTagInfo('<%=tagobj[0]%>','<%=tagobj[1]%>');"><span><%=tagobj[1]%></span></a>
			<%	}
			}%>
			<%
			if(personalList!=null && personalList.size()>0){
				for(int i=0; i<personalList.size(); i++){
					Object[] tagobj = (Object[])personalList.get(i);
			%>
			<a id="pertag-<%=tagobj[0]%>" href="javascript:void(0);" class="meta-close"><span onclick="searchTagInfo('<%=tagobj[0]%>','<%=tagobj[1]%>');"><%=tagobj[1]%></span><i class="fa fa-times-circle-o" onclick="deletePersonalTag(<%=tagobj[0]%>);" title="<s:text name='info.alldelete'/><s:text name='info.Tag'/>"></i></a>
			<%	}
			}%>
          </div>
		  <hr id="info-hr"/>
		  </s:if>
		<%}%>
          <!-----------------------------------------页面内容 start------------------------------------------->
		  <div class="wh-dtl-art clearfix">
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
							<div id="pdfDiv" align="center">
								<iframe name="dd" src="<%=rootPath%>/modules/kms/information_manager/newViewPDF.jsp?url=<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>" frameborder=0 style="width:900px;height:630px;" border=0></iframe>
							</div>
						</s:if>
						<!--------- 不禁止打印 ------------>
						<s:else>
							<div id="pdfDiv" align="center">
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
					<s:if test="information.forbidCopy != 1">
						<div class="news_fileLink">链接附件：<a href="<%=preUrl%>/public/download/download.jsp?FileName=<%=saveName%>&name=<%=fileName%>&path=<%=path%>&verifyCode=<%=dlcode%>"  target="_self"><%=fileName%></a></div>
					</s:if>
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
							//java.io.File smallfile = new java.io.File(smallSrcUrl);
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
						<p><img name="image" src="<%=smallSrcUrl%>" onerror="this.src='<%=realSrcUrl%>';this.onerror=null;" onclick="openRealPic('<%=realSrcUrl%>');" style="cursor:pointer"/></p>
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
						<p><img name="image" src="<%=smallSrcUrl2%>" onerror="this.src='<%=realSrcUrl2%>';this.onerror=null;" onclick="openRealPic('<%=realSrcUrl2%>');" style="cursor:pointer"/></p>
					</s:if>
					<%
						}//for 循环结束
					%>
					</div>
					<%
					}//!infoPicName2.equals("") 结束
					%>
					<div id="office-div">
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
					</div>
				</s:else><!--对应不是0/1类型信息，且不是文件链接的 结束（其实是office类型）-->
			</s:else><!---对应不是 request.fileLink == 'fileLink'文件链接 的情况 结束--->
		  </div>
		  <!-----------------------------------------页面内容 end------------------------------------------->
          <div class="wh-dtl-nav" id="info-next-div">
            <%if(index>0){%>
			<a id="beforeInfo" class="wh-dtl-btn wh-dtl-prev" href="#" onclick="goNextInfo('<%=index-1%>');"><s:text name="info.beforeinfo"/></a>
			<%}%>
            <s:if test='information.forbidCopy!=1 && #request.canPrint==1'>
			<a id="printpreview" class="wh-dtl-btn wh-dtl-print" href="javascript:void(0);" onclick="printView()"><s:text name="info.printpreview"/></a>
			</s:if>
			<%if((index<recordCount-1)){%>
			<a id="nextInfo" class="wh-dtl-btn wh-dtl-next" href="#" onclick="goNextInfo('<%=index+1%>');"><s:text name="info.nextinfo"/></a>
			<%}%>
          </div>
        </div>
      </div>
	</div>
	</div>		
	<!-----------------------------------------转发 收藏 笔记 返回顶部模块------------------------------------------->
	<div class="side-go-top" id="info-side-div">
	<%if(!"1".equals(hisFlag)){%>
		<s:if test="information.dossierStatus!=1 && #request.canVindicate && #request.dossierGD">
		<a id="gddiv" href="javascript:void(0);" onclick="gd();"><i class="fa fa-file-mana"></i><em><s:text name="info.viewarchive"/></em></a>
		</s:if>
		<s:if test="information.informationOrISODoc!=1">
		<%
		com.whir.org.common.util.SysSetupReader sysRed = com.whir.org.common.util.SysSetupReader.getInstance();
		String mailremind = sysRed.getOa_mailremind(session.getAttribute("domainId").toString());
		if(!"0".equals(mailremind)){
		%>
			<a href="javascript:void(0);" onclick="mailSend();"><i class="fa fa-pencil-square-o"></i><em><s:text name="info.transTo"/></em></a>
		<%}%>
		<a href="javascript:void(0);" onclick="collection();"><i class="fa fa-star-o"></i><em><s:text name="info.collection"/></em></a>
		<a href="javascript:void(0);" onclick="addNote();"><i class="fa fa-contract-mana"></i><em><s:text name="info.viewwritenotes"/></em></a>
		</s:if>
	<%}%>
		<a class="btn-go-top" href="javascript:void(0);"><i class="fa fa-angle-up"></i><em><s:text name="info.top"/></em></a>
	</div>
	<!--------------------------------------------------个人标签 modal----------------------------------------------------->
	<div id="add-personaltag" class="layer-modal add-meta-tips">
		<form class="clearfix">
			<div id="pertag-div" class="form-group meta-tips-formgroup">
				<select id="tags-select" class="form-control chzn-done" data-placeholder="<s:text name='info.mytag'/>" multiple="">
					<%
					if(allPersonalList!=null && allPersonalList.size()>0){
						for(int i=0; i<allPersonalList.size(); i++){
							Object[] tagobj = (Object[])allPersonalList.get(i);
					%>
					<option value="<%=tagobj[0]%>"><%=tagobj[1]%></option>
					<%	}
					}%>
				</select>
			</div>
			<div class="meta-tips-btn">
				<a class="btn btn-wh" href="javascript:void(0);" role="button" onclick="addPersonalTag();"><s:text name="info.setconfirm"/></a>
			</div>
		</form>
	</div>
	<!--------------------------------------------------评论 modal---------------------------------------------------------->
	<div id="comment-modal" class="layer-modal modal-comment-set" tabindex="1" role="dialog">
		<div class="comment-con">
		  <ul id="commentul">
		  </ul>
			<div class="comment-push form-group">
				<form id="setCommentForm" action="Information!setComment.action" method="post"> 
					<s:hidden id="informationId" name="information.informationId" />
					<s:hidden id="channelId" name="channelId" />
					<input type="hidden" id="updateCommentId" name="updateCommentId"/>
					<input type="hidden" id="tempContent" name="tempContent"/>
					<div class="comment-fl">
						<textarea id="commentContent" class="form-control" name="commentContent" rows="3" placeholder="<s:text name="info.detailcomment"/>"></textarea>
					</div>
				</form>
				<div class="comment-fr">
					<div class="user-icon">
						<img src="<%=userphoto%>" width="30" alt="">
						<span><%=userName%></span>
					</div>
					<button type="button" class="btn btn-default" onclick="saveComment();"><s:text name="info.saysubmit"/></button>
				</div>
			</div>
		</div>
	</div>
	<!------------------------------------------  查询历史版本form start---------------------------------------------->
	<s:form id="historyForm" name="historyForm" action="Information!historyList.action" method="post" >
		<s:hidden id="informationId" name="information.informationId" />
	</s:form>

	<s:form id="commentForm" name="commentForm" action="Information!commentList.action" method="post" >
		<s:hidden id="informationId" name="information.informationId" />
		<div class="news_Booklist" id="LM1" style="display:none;">
		</div>
	</s:form>
	<!------------------------------------------  查询历史版本form end------------------------------------------------>
	<!------------------------------------------  邮件转发/收藏/记笔记form start---------------------------------------------->
	<s:form id="gdform" name="gdform" action="Information!file.action" method="POST" target="dossier">
		<input type="hidden" id="pageContent" name="pageContent">
		<input type="hidden" id="pageStyle_common" name="pageStyle_common">
		<input type="hidden" id="pageStyle_style" name="pageStyle_style">
		<input type="hidden" id="gdType" name="gdType" value="<%=gdType%>">
		<s:hidden id="informationId" name="informationId"/>
		<s:hidden id="informationTitle" name="information.informationTitle"/>
	</s:form>
	<s:form id="mailForm" name="mailForm" action="innerMail!openAddMail.action" method="post" target="sendMail">
		<s:hidden type="hidden" id="pageURL" name="pageURL"/>
		<s:hidden type="hidden" id="informationIdForMail" name="informationIdForMail"/>
		<s:hidden type="hidden" id="channelIdForMail" name="channelIdForMail"/>
	</s:form>
		<s:form id="noteForm" name="noteForm" action="NoteBookAction!addNoteBook.action" method="post" target="note" >
		<s:hidden name="formNoteClassName" id="formNoteClassName" value="信息"/>
		<s:hidden name="formNoteTitle" id="formNoteTitle" value=""/>
		<s:hidden name="formNoteLink" id="formNoteLink" value=""/>
	</s:form>

	<s:form id="collectionForm" name="collectionForm" action="netdisk!infoFolderSelect.action" method="post" target="collection">
		<s:hidden type="hidden" id="httpUrl" name="httpUrl"/>
		<s:hidden type="hidden" id="infoId" name="infoId"/>
		<s:hidden type="hidden" id="channelIdForCollection" name="channelIdForCollection"/>
		<s:hidden type="hidden" id="title" name="title"/>
	</s:form>
	<!------------------------------------------  邮件转发/收藏/记笔记form end------------------------------------------------>
</body>
</html>
<script>
//信息作者长度特殊处理
function dealInfoAuthor(name){
	if(name!=null && name.length > 17){
		name = name.substring(0,17)+'...';
	}
	return name;
}

//打开栏目列表页面
function openChannel(){
	openWin({url:"InfoList!allList.action?channelId="+$('#channelId').val()+"&channelType="+$('#channelType').val()+"&userChannelName="+$('#userChannelName').val()+"&userDefine="+$('#userDefine').val(),isFull:true,winName:"channelList"});
}
//根据标签查询对应信息列表
function searchTagInfo(tagId,tagName){
	openWin({url:"InfoList!allList.action?channelType="+$('#channelType').val()+"&userChannelName="+$('#userChannelName').val()+"&userDefine="+$('#userDefine').val()+"&tagId="+tagId+"&tagName="+tagName,isFull:true,winName:"tagInfoList2"});
}
//点击版本下拉菜单，加载版本数据
$('#versionDropdown').on('show.bs.dropdown', function () {
  var html = "";
  //最新版本信息
  var informationId = '<s:property value="information.informationId"/>';
  var userId = "<%=userId%>";
  var canVindicate = '<%=canVindicate%>';
  var formId = "historyForm";
	//分页参数等html、公共js事件绑定
	initList(formId);
 	var jq_form = $('#'+formId);
	jq_form.ajaxForm({
		success:function(responseText){
			if(responseText!=null && responseText!=""){
				//解析服务器返回的json字符串
				var json = eval("("+responseText+")").data;
				var data = json.data;
				//如果只有当前第一个版本，则版本图标不带有箭头：<i>↑</i>
				if(data.length == 0){
					//如果不是历史版本的查看页面，则高亮选中的是最新版本：class="current"
					if('<%=historyId%>' == ''){
						html = '<li id="lastest-li" class="current"><a href="javascript:void(0);" class="clearfix"><em><s:property value="information.informationVersion"/></em><p><span><s:text name="info.viewmodifier"/>：<s:property value="information.informationIssuer"/></span><span><s:text name="info.viewpubtime"/>：<s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/></span></p></a></li>';
					}else{
						html = '<li id="lastest-li"><a href="javascript:void(0);" class="clearfix"><em><s:property value="information.informationVersion"/></em><p><span><s:text name="info.viewmodifier"/>：<s:property value="information.informationIssuer"/></span><span><s:text name="info.viewpubtime"/>：<s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/></span></p></a></li>';
					}
				}else{
					if('<%=historyId%>' == ''){
						html = '<li id="lastest-li" class="current"><a href="javascript:void(0);" class="clearfix"><em><s:property value="information.informationVersion"/></em><p><span><s:text name="info.viewmodifier"/>：<s:property value="information.informationIssuer"/></span><span><s:text name="info.viewpubtime"/>：<s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/></span></p></a><i class="arrowtip">&#8593;</i></li>';
					}else{
						html = '<li id="lastest-li"><a href="javascript:void(0);" class="clearfix"><em><s:property value="information.informationVersion"/></em><p><span><s:text name="info.viewmodifier"/>：<s:property value="information.informationIssuer"/></span><span><s:text name="info.viewpubtime"/>：<s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/></span></p></a><i class="arrowtip">&#8593;</i></li>';
					}
						
				}
				//循环数据信息
				for (var i=0; i<data.length; i++) {
					var po = data[i];
					var li = '';
					//查看历史页面，对应版本高亮显示
					if('<%=historyId%>' == po.historyId){
						li = '<li class="current"><a href="javascript:void(0);" class="clearfix" onclick="historyView(\''+po.historyId+'\',\''+po.historyVersion+'\')">';
					}else{
						li = '<li><a href="javascript:void(0);" class="clearfix" onclick="historyView(\''+po.historyId+'\',\''+po.historyVersion+'\')">';
					}
					//var li = '<li><a href="javascript:void(0);" class="clearfix" onclick="historyView(\''+po.historyId+'\',\''+po.historyVersion+'\')">';
					li += '<em>'+po.historyVersion+'</em>';
					li += '<p><span><s:text name="info.viewmodifier"/>：'+po.historyIssuerName+'</span><span><s:text name="info.viewpubtime"/>：'+po.historyTime+'</span></p>';
					//最后一个版本后面不加箭头
					if(i == data.length -1){
						li += '</a>';
						if(po.historyIssuerId == userId || canVindicate=='true'){
							li += '<i class="fa fa-minus-circle" onclick="deleteHistory('+po.historyId+');" title="<s:text name="info.alldelete"/>"></i>'
						}
						li += '</li>';
					}else{
						li += '</a><i class="arrowtip">&#8593;</i>';
						if(po.historyIssuerId == userId || canVindicate=='true'){
							li += '<i class="fa fa-minus-circle" onclick="deleteHistory('+po.historyId+');" title="<s:text name="info.alldelete"/>"></i>';
						}
						li += '</li>';
					}
					html += li;
				}
				
				$("#versionol").html(html);
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.dialog({id:"Tips"}).close();
			$.dialog.alert(comm.loadfailure,function(){});
		}
	}); 
	//初次提交表单获得数据
	$("#"+formId).submit();
  /*$.ajax({
		type: 'POST',
		url: whirRootPath+'/Information!historyList.action?informationId='+informationId,
		async: true,
		dataType: 'text',
		success: function(responseText){
			
		}
	});*/
});

//关闭下拉菜单时候
$('#versionDropdown').on('hide.bs.dropdown', function () {
	var html = "";
	$("#versionol").html(html);
});

//历史版本查看
function historyView(historyId,historyVersion){
	var html = "";
	var informationId = '<s:property value="information.informationId"/>';
	var informationType = '<s:property value="information.informationType"/>';
	var channelId = $("#channelId").val();
	var userChannelName = $("#userChannelName").val();
	var num = Math.random()*100;
	//html = '<a href="javascript:void(0);"
	openWin({url:'Information!historyView.action?historyId='+historyId+'&informationId='+informationId+'&informationType='+informationType+'&channelId='+channelId+'&userChannelName='+userChannelName,winName:'historyInfo'+parseInt(num),isFull:true});
	//return html;
}
//删除历史版本
function deleteHistory(historyId){
	layer.confirm('<s:text name="info.deleteversion"/>？', {icon: 3, title:'提示'}, function(index){
		$.ajax({
			type: 'POST',
			url: whirRootPath+'/Information!deleteHistory.action?historyId='+historyId,
			async: true,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!=""){
					whir_msg('<s:text name="info.delsuccess"/>',1);
				}
			}
		});
		//ajaxOperate({urlWithData:'Information!deleteHistory.action?historyId='+historyId,tip:'删除历史版本',isconfirm:false,formId:'historyForm'});
		//关闭提示窗口
		layer.close(index);
	});
}
//----------------------------------------------评论---------------------------------------------//
function initCommentListFormToAjax(){
	var userId = '<%=userId%>';
	var canVindicate = '<%=canVindicate%>';
	var delComment = '<%=delComment%>';
	var formId = "commentForm";
	var html = '';
	var userId = "<%=userId%>";
	var informationId = '<s:property value="information.informationId"/>';
	
 	var jq_form = $('#'+formId);
	jq_form.ajaxForm({
		success:function(responseText){
			//console.log(responseText);
			if(responseText!=null && responseText!=""){
				//$.dialog({id:"Tips"}).close();
				var json = eval("("+responseText+")").data;
				var data = json.data;
				//循环数据信息
				var informationId = '<s:property value="information.informationId"/>';			
				for (var i=0; i<data.length; i++) {
					var po = data[i];
					var li = '<li><div class="comment-title"><div class="comment-user">';
					li += '<a href="javascript:void(0);"><img src="'+po.empLivingPhoto+'" width="42" alt="'+po.commentIssuerName+'"></a>';
					li += '</div>';
					li += '<span>'+po.commentIssuerName+'</span>&nbsp;&nbsp;<i></i><span>'+po.commentIssuerOrg+'</span>';
					li += '<em>'+po.commentIssueTime+'</em>';
					//如果是本人的评论，可以修改与删除
					if(po.commentIssuerId == userId){
						li += '<div class="icon-opera">';
						li += '<i class="fa fa-pencil-square-o" onclick="modifyComment('+po.commentId+');" title="<s:text name="info.allmodify"/><s:text name="info.detailcomment"/>"></i>';
						li += '<i class="fa fa-minus-circle" onclick="deleteComment('+po.commentId+','+informationId+');" title="<s:text name="info.DelComment"/>"></i>';
						li += '</div>';
					}
					li += '</div><div class="comment-artical">';
					li += '<p>'+po.commentContent+'</p><input type="hidden" id="comment'+po.commentId+'" name="comment'+po.commentId+'" value="'+po.commentContent+'">';
					li += '</div></li>';
					/*if(po.commentIssuerId==userId || delComment=='1' || canVindicate=='true'){'
					}*/
					html += li;
				}
				$("#commentul").html(html);
				$("#commentul").scrollTop(0);
				
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.dialog({id:"Tips"}).close();
			$.dialog.alert(comm.loadfailure,function(){});
		}
	}); 
	//初次提交表单获得数据
	$("#"+formId).submit();
}

//评论触发打开页面
$('#comment-a').on('click',function(){
	layer.open({
		type: 1,
		shift: 2,
		shadeClose: false, //开启遮罩关闭
		area: ['608px', '450px'], //宽高
		title :'<s:text name="info.detailcomment"/>',
		content: $('#comment-modal'),
		cancel: function(){ 
			//右上角关闭回调
			//alert(123123);
		}
	});
	initCommentListFormToAjax();
});

//保存评论
function saveComment(){
	var commentcotents = $("#commentContent").val();
	if(commentcotents!=null){
		commentcotents = $.trim(commentcotents);
	}
	if(commentcotents==''){
		whir_msg('<s:text name="info.PleaseenterComment" />！',5);
		return;
	}else if(commentcotents.length>500){
		whir_msg('<s:text name="info.commenttoolong" />！',5);
		return;
	}else{
		$("#commentContent").val(trancComment($("#commentContent").val()));
		var jq_form = $('#setCommentForm');
		
		jq_form.ajaxForm({
			beforeSend:function(){
			},
			success:function(responseText){
				var result = eval("("+responseText+")").result;
				if(result == 'success'){
					//清空评论输入框
					$("#commentContent").val('');
					//清空修改评论的评论id
					$("#updateCommentId").val('');
					//initCommentListFormToAjax();
					commentCallBack();
				}
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				$.dialog({id:"Tips"}).close();
				$.dialog.alert(comm.loadfailure,function(){});
			}
		});
		//初次提交表单获得数据
		jq_form.submit();
	}
}
function trancComment(val){
	if(val.indexOf("<")>-1){
		val = val.replace(/\</g,'&lt;');
	}
	if(val.indexOf(">")>-1){
		val = val.replace(/\>/g,'&gt;');
	}
	if(val.indexOf("\"")>-1){
		val = val.replace(/\"/g,'&quot;');
	}
	return val;
}
//修改评论
function modifyComment(commentId){
	var content = $("#comment"+commentId).val();
	if(content.indexOf("<br/>")>-1){
		content = content.replace(/\<br\/\>/g,'\r');
	}
	$("#updateCommentId").val(commentId);
	$("#commentContent").val(content);
	$("#tempContent").val($("#commentContent").val());
}

//删除评论
function deleteComment(commentId,informationId){
	layer.confirm('<s:text name="info.deleteThisComment" />', {icon: 3, title:'提示'}, function(index){
		$.ajax({
			type: 'POST',
			url: whirRootPath+'/Information!deleteComment2.action?commentId='+commentId+'&informationId='+informationId,
			async: true,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!=""){
					commentCallBack();
				}
			}
		});
		//ajaxOperate({urlWithData:'Information!deleteComment2.action?commentId='+commentId+'&informationId='+informationId,tip:'<s:text name="info.DelComment" />',isconfirm:false,formId:'',callbackfunction:commentCallBack});
		//关闭提示窗口
		layer.close(index);
	});
}
//评论成功回调函数
function commentCallBack(){
	initCommentListFormToAjax({formId:"commentForm"}); 
	//$("#remark").hide();
	var informationId = '<s:property value="information.informationId"/>';
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Information!getCommentNum.action?informationId="+informationId,
		async: true,
		dataType: 'json',
		success: function(data){
			if(data!=null && data!=""){
				data = eval(data);
				if(data.num != null){
					$("#comment-num").html(data.num);
				}
			}
		}
	});
}

//阅读情况
function browser(){
	openWin({url:'realtimemessage!onlinelist.action?fromtype=information&id='+'<s:property value="information.informationId"/>',winName:'browser',isFull:true});
}
//点赞处理
$(function(){
	var informationId = '<s:property value="information.informationId"/>';
	$("#praise-"+informationId).astatus({delay:300},function(){
		$(this).toggleClass('active');
		if($(this).hasClass('active')){
			addPraise();
		}else{
			cancelPraise();
		}	
	});
});
//20151116 -by jqq  信息页面点赞处理
function addPraise(){
	var informationId = "<s:property value='information.informationId'/>";
	$.ajax({
		type:"POST",
		url:whirRootPath+'/Information!praiseInfo.action?praiseType=1&praiseInformationId='+informationId,
		async: false,
		dataType: 'text',
		success: function(data){
			if(data!=null && data!=""){
				var result = eval("("+data+")").result;
				//console.log(result);
				if(result == "success"){
					var praisenums =$("#praise-num-"+informationId).text();
					$("#praise-num-"+informationId).text(parseInt(praisenums)+1);
					//$("#praise-"+informationId).attr("onclick","cancelPraise()");
				}else if(result == "已赞同！"){
					//whir_alert("已赞同！");
					whir_msg('已赞同！',5);
				}else if(result == "点赞失败！"){
					//whir_alert("点赞失败！");
					whir_msg('点赞失败！',5);
				}
			}
		}
	});
}

//20160511 -by jqq 信息页面取消点赞处理
function cancelPraise(){
	var informationId = "<s:property value='information.informationId'/>";
	$.ajax({
		type:"POST",
		url:whirRootPath+'/Information!praiseInfo.action?praiseType=0&praiseInformationId='+informationId,
		async: false,
		dataType: 'text',
		success: function(data){
			if(data!=null && data!=""){
				var result = eval("("+data+")").result;
				if(result == "success"){
					var praisenums =$("#praise-num-"+informationId).text();
					$("#praise-num-"+informationId).text(parseInt(praisenums)-1);
					//$("#praise-"+informationId).attr("onclick","addPraise()");
				}else if(result == "已赞同！"){
					//whir_alert("已赞同！");
					whir_msg('已赞同！',5);
				}else if(result == "点赞失败！"){
					whir_msg('点赞失败！',5);
				}
			}
		}
	});
}
//归档
function gd(){
	$("#gd").val("-1");
	$("#pageStyle_common").val("<%=rootPath%>/themes/common/common.css");
	$("#pageStyle_style").val("<%=rootPath%>/<%=whir_skin%>/style.css");
	//20160719 -by jqq 归档时部分模块不记录
	$("#info-top-div").hide();
	$("#info-moreinfo").hide();
	$("#tags-div").hide();
	$("#info-hr").hide();
	$("#info-next-div").hide();
	$("#info-side-div").hide();
	if($("#office-div").length>0){
		$("#office-div").hide();
	}
	$("#pageContent").val(document.body.innerHTML);
	//openWin({url:'',winName:'dossier',width:10,height:10});
    $("#gdform").ajaxSubmit();
    try{
		$("#gddiv").hide();
    }catch(e){}
	whir_alert('<s:text name="info.archive" />！',function(){
    	$("#info-top-div").show();
		$("#info-moreinfo").show();
		$("#tags-div").show();
		$("#info-hr").show();
		$("#info-next-div").show();
		$("#info-side-div").show();
		if($("#office-div").length>0){
			$("#office-div").show();
		}
		<%if("checkdepart".equals(gdFromType)){%>
    		var url="/defaultroot/InfoList!allList.action?checkdepart=1&channelId=<%=departchannelId%>&channelType=<%=departchannelType%>&userChannelName=<%=departuserChannelName%>&userDefine=<%=departuserDefine%>&headColor=<%=departheadColor%>";
    		window.parent.location_href(url);
    	<%}else{%>
    		window.parent.refreshListForm('queryForm');
    	<%}%>
    });
}

//邮件转发
function mailSend(){
	var informationId = "<s:property value='information.informationId'/>";
	var channelId = '<s:property value="channelId"/>';
	var userChannelName = '<s:property value="#request.channelNameString"/>';
	var informationType = "<s:property value='information.informationType'/>";
	var informationTitle = "<s:property value='information.informationTitle'/>";
	var channelType = $("#channelType").val();
	var userDefine = $("#userDefine").val();
	$("#pageURL").val("<a onclick='openWin({url:\"Information!view.action?informationId="+informationId+"&informationType="+informationType+"&userChannelName="+userChannelName+"&channelId="+channelId+"&channelType="+channelType+"&userDefine="+userDefine+"\",isFull:true,winName:\"info\"});' href='javascript:void(0);'>"+informationTitle+"</a>");
	$("#informationIdForMail").val(informationId);
	$("#channelIdForMail").val(channelId);
	openWin({url:'innerMail!openAddMail.action',winName:'sendMail',isFull:true});
	//window.open("","sendMail","");
	$("#mailForm").submit();
}
//记笔记
function addNote(){
	var informationId = "<s:property value='information.informationId'/>";
	var channelId = '<s:property value="channelId"/>';
	var userChannelName = '<s:property value="#request.channelNameString"/>';
	var informationType = "<s:property value='information.informationType'/>";
	var informationTitle = "<s:property value='information.informationTitle'/>";
	var vUrl = whirRootPath + '/NoteBookAction!addNoteBook.action?noteType=information'
	vUrl += '&informationId=' + informationId;
	vUrl += "&informationType=" + informationType;
	vUrl += "&channelId=" + channelId;
	vUrl += "&informationTitle=" + informationTitle;
	vUrl += "&userChannelName=" + userChannelName;
	openWin({url:vUrl, width:620, height:350, winName:'addNoteBook'});
}

//收藏
function collection(){
	var informationId = "<s:property value='information.informationId'/>";
	var channelId = '<s:property value="channelId"/>';
	var userChannelName = '<s:property value="#request.channelNameString"/>';
	var informationType = "<s:property value='information.informationType'/>";
	var informationTitle = "<s:property value='information.informationTitle'/>";
	$("#httpUrl").val("Information!view.action?informationId="+informationId+"&informationType="+informationType+"&userChannelName="+userChannelName+"&channelId="+channelId);
	$("#title").val(informationTitle);
	$("#infoId").val(informationId);
	$("#channelIdForCollection").val(channelId);
	openWin({url:'netdisk!infoFolderSelect.action',winName:'collection',width:650,height:350});
	$("#collectionForm").submit();
}
//文档管理：相关信息点击查看页面
function viewInfo(infoId,intoType,channelId){
	openWin({url:'Information!view.action?informationId='+infoId+'&informationType='+intoType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+channelId+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&iso=1',isFull:true,winName:"isDoc"+infoId});
}
//点击缩略图打开原图
function openRealPic(src){
	openWin({url:src,isFull:true,winName:"Pic"});
}

//标签触发打开页面
$('#tags-a').on('click',function(){
	//初始打开允许标签input输入
	$('#pertag-div input').attr("disabled",false);
	layer.open({
		type: 1,
		shift: 2,
		shadeClose: false, //开启遮罩关闭
		area: ['420px', 'auto'], //宽高
		//btn: ['<s:text name="info.setconfirm"/>', '<s:text name="info.cancle"/>'],
		title :'<s:text name="info.newinfoadd"/><s:text name="info.mytag"/>',
		content: $('#add-personaltag'),
		yes: function(index, layero){
			//按钮【确定】的回调
			addPersonalTag();
		},
		cancel: function(){ 
			//右上角关闭回调
			canclePerTag();
		}
	});
});
//新增信息的个人标签
function addPersonalTag(){
	var informationId = "<s:property value='information.informationId'/>";
	var userId = '<%=userId%>';
	//选中的个人标签id
	var selectedTagId = $("#tags-select option:selected").val();
	var selectedTagName = $("#tags-select option:selected").text();
	if(selectedTagId==null || selectedTagId=="" || selectedTagName==null || selectedTagName==""){
		whir_msg("<s:text name='info.selecttag'/>！",1);
		return false;
	}else if(selectedTagId.indexOf("#new#") > -1){
		if(selectedTagName.length>6){
			whir_msg("<s:text name='info.tagtoolong'/>",5);
			return false;
		}
		if(legalCharacters(selectedTagName)){
			whir_msg("<s:text name='info.tagnospecial'/>："+"\\\"'`<>^/,|!@#%*()$&",5);
			return false;
		}
		//如果输入的是不存在的个人标签，先新增标签，再做信息-标签关联
		$.ajax({
			type:"POST",
			url:whirRootPath+'/InfoTagAction!saveNewTagRelation.action?tagName='+encodeURIComponent(selectedTagName)+'&infoId='+informationId+'&userId='+userId+'&type=1',
			async: false,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!=""){
					var result = eval("("+data+")").result;
					perTagCallBack(result,'1',selectedTagId,selectedTagName);
				}
			}
		});
	}else{
		//已经存在的标签，直接保存信息-标签关系
		$.ajax({
			type:"POST",
			url:whirRootPath+"/InfoTagAction!saveTagRelation.action?tagId="+selectedTagId+'&infoId='+informationId+'&type=1',
			async: false,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!=""){
					var result = eval("("+data+")").result;
					perTagCallBack(result,'0',selectedTagId,selectedTagName);
				}
			}
		});
	}
	
}
//添加个人标签后回调方法
function perTagCallBack(result,flag,selectedTagId,selectedTagName){
	if(result == "repeat"){
		whir_msg('添加标签重复！',5);
	}else if(result == "nosave"){
		whir_msg('<s:text name="info.addtagfail"/>',5);
	}else {
		//返回的是标签的Id
		if(flag == '1'){
			selectedTagId = result;
		}
		layer.closeAll();
		whir_msg('<s:text name="info.addtagsuccess"/>！',1);
		var html = '<a id="pertag-'+selectedTagId+'" href="javascript:void(0);" class="meta-close"><span onclick="searchTagInfo(\''+selectedTagId+'\',\''+selectedTagName+'\');">'+selectedTagName+'</span><i class="fa fa-times-circle-o" onclick="deletePersonalTag('+selectedTagId+');" title="<s:text name="info.alldelete"/><s:text name="info.Tag"/>"></i></a>';
		$("#tags-div").append(html);
		canclePerTag();
	} 
}
//删除信息的个人标签
function deletePersonalTag(tagId){
	var informationId = "<s:property value='information.informationId'/>";
	$.ajax({
		type:"POST",
		url:whirRootPath+"/InfoTagAction!delPerTagRelation.action?tagId="+tagId+'&infoId='+informationId,
		async: false,
		dataType: 'text',
		success: function(data){
			if(data!=null && data!=""){
				var result = eval("("+data+")").result;
				if(result == "success"){
					whir_msg('<s:text name="info.deletetagsuccess"/>！',1);
					$("#pertag-"+tagId).remove();
				}else if(result == "nodelete"){
					whir_msg('<s:text name="info.deletetagfail"/>！',5);
				}
			}
		}
	});
}
//取消个人标签的选择
function canclePerTag(){
	$("#tags-select option").prop('selected',false);
	$("#tags-select").trigger("liszt:updated");
	//$("#tag-warn-note").remove();
}

//选择多个人物
$('#tags-select').chosen({
	"width": "100%",
	"disable_search_threshold": 10,
	"allow_single_deselect": true,
	"max_selected_options": 1, //控制只允许选1个
	"search_contains":true, //模糊查询，默认的false是从头模糊查询str%
	"placeholder_text_multiple": "\u8bf7\u9009\u62e9\u6807\u7b7e",
	"placeholder_text_single": "\u8bf7\u9009\u62e9\u4e00\u9879",
	"no_results_text": "\u6ca1\u6709\u543b\u5408\u7684\u7ed3\u679c\uff0c\u8bf7\u56de\u8f66\u786e\u8ba4\u589e\u52a0\u65b0\u6807\u7b7e"
});
//个人标签的输入

//点击回车 输入无匹配结果的个人标签
$('#pertag-div input').keyup(function(event){
	//初始如果选中了标签，则不允许继续选择或输入
	if($('#pertag-div li.search-choice').length > 0){
		return false;
	}
	this.maxLength="6";
	var customTagPrefix = '#new#';
	if (this.value && this.value.length >= 1 && event.which === 13) {
		if(this.value.length > 6){
			whir_msg("<s:text name='info.tagtoolong'/>",5);
			return false;
		}
		var highlighted = $('.chzn-container').find('li.active-result.highlighted').first();
		if (event.which === 13 && highlighted.text() !== '') {
			var customOptionValue = customTagPrefix + highlighted.text();
			$('.chzn-done option').filter(function () { return $(this).val() == customOptionValue; }).remove();
			// Select the highlighted result
			var tagOption = $('.chzn-done option').filter(function () { return $(this).html() == highlighted.text(); });
			tagOption.attr('selected', 'selected');
		}else{
			var customTag = this.value;
			var tagOption = $('.chzn-done option').filter(function () { return $(this).html() == customTag; });
			if (tagOption.text() !== ''){
				tagOption.attr('selected', 'selected');
			}else{
				var option = $('<option>');
				option.text(this.value).val(customTagPrefix + this.value);
				option.attr('selected','selected');
				// Append the option an repopulate the chosen field
				$('.chzn-done').append(option);
			}
		}
		this.value = '';
        $('.chzn-done').trigger('liszt:updated');
		//选择之后，input控制不可输入（chosen选择模块实时仅1个input,选择后的变成span）
		$('#pertag-div input').attr("disabled",true);
		$('.search-choice-close').click(function(){
			//console.log($('.search-choice-close'));
			$('#pertag-div input').attr("disabled",false);
		});
        event.preventDefault();
	}
	
});
//过滤特殊字符
function legalCharacters(o) {
	//参数'o'是页面上的一个对象，如'document.forms[0].code'
	//var cnst ="!\"#$%&'()=`|~{+*}<>?_-^\\@[;:],./";
	//var cnst ="\\\"#$%&'()=`|~{+*}<>?_-^\\@[]\.,;:!/";
	var cnst ="\\\"'`<>^/,|!@#%*()$&";
    for (i=0;i<o.length;i++){
       	if (cnst.indexOf(o.charAt(i))>-1){
			return true;
        }
    }
    return false;
}

//打印预览
function printView(){
	var informationId = "<s:property value='information.informationId'/>";
	var channelId = '<s:property value="channelId"/>';
	var userDefine = '<s:property value="userDefine"/>';
	var userChannelName = '<s:property value="#request.channelNameString"/>';
	var informationType = "<s:property value='information.informationType'/>";
	openWin({url:'Information!view.action?informationId='+informationId+'&informationType='+informationType+'&userChannelName='+userChannelName+'&channelId='+channelId+'&channelType='+channelType+'&userDefine='+userDefine+'&printPreview=1&iso=<%=((iso!=null && iso.equals("1")) || "1".equals(isoFlag)) ? "1": ""%>',isFull:true,winName:"printPreview"});
}
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
						//20160615 -by jqq 无打印次数，不显示打印预览
						$("#printpreview").hide();
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

	if($('#gd').val()=='1'){gd();}
	//20160628 -by jqq 信息作者特殊处理
	var authorname = '<s:property value="%{information.informationAuthor}"/>';
	var lastName = dealInfoAuthor(authorname);
	$("#info-author-name").html(lastName);
});
//禁止页面右键（点击返回页面退回，可能导致审核信息不经审核就保存）
function stoprightbutton(){
	return false;
}
function isIe(){
	return ("ActiveXObject" in window);
}
function allscreen(){
	webform.WebOffice.FullSize();//全屏显示
}
<%if (!"1".equals(gd)) {%>
//页面加载office类型的信息处理
$(document).ready(function(){
    var isfordbidCopy = '<s:property value="information.forbidCopy"/>';
	//是否有打印权限
	var canprint = '<%=canprint%>';
	var forbidcopy = isfordbidCopy;
	
	if(isfordbidCopy == '1'){
		isfordbidCopy="-1,1,0,0,0,0,0,0";
	}else{
		isfordbidCopy="-1,2,0,0,0,0,1,0";
	}

	<s:if test="information.informationType==4">
		if(isSurface()){
			whir_alert("该页面不支持在PAD上显示，请于PC端查看!");
		}else{
			var content = '<%=content%>';
			webform.WebOffice.WebUrl="http://<%=request.getServerName()+":"+request.getServerPort()%><%=rootPath%>/officeserverservlet";
			webform.WebOffice.RecordID=content;
			webform.WebOffice.Template="";
			webform.WebOffice.FileName=content+".doc";
			webform.WebOffice.FileType=".doc";
			webform.WebOffice.EditType=isfordbidCopy;
			webform.WebOffice.UserName="<%=session.getAttribute("userName")%>";
			webform.WebOffice.showMenu = "0";
			webform.WebOffice.EnablePrint =isfordbidCopy;
			if(isfordbidCopy == "-1,2,0,0,0,0,1,0"){
				//20151217 -by jqq 添加权限控制
				if(canprint == '1'){
					webform.WebOffice.AppendTools("106","打印",5);
				}else{
					//3：自定义工具栏=true,	Office工具栏=false
					webform.WebOffice.ShowToolBar = 3;
			   }
			}else{
				webform.WebOffice.ShowToolBar = 3;
			}
			webform.WebOffice.WebOpen();
			webform.WebOffice.ShowType="1";
			
			webform.WebOffice.WebToolsVisible('Standard',false);  //标准
			webform.WebOffice.WebToolsVisible('Formatting',false);  //格式
			webform.WebOffice.WebToolsVisible('Tables and Borders',false);  //表格和边框
			webform.WebOffice.WebToolsVisible('Database',false);  // 数据库
			webform.WebOffice.WebToolsVisible('Drawing',false);  //绘图
			webform.WebOffice.WebToolsVisible('Forms',false);  //窗体
			webform.WebOffice.WebToolsVisible('Visual Basic',false);  //Visual Basic
			webform.WebOffice.WebToolsVisible('Mail Merge',false);  //邮件合并
			webform.WebOffice.WebToolsVisible('Extended Formatting',false);  //其它格式
			webform.WebOffice.WebToolsVisible('AutoText',false);  //自动图文集
			webform.WebOffice.WebToolsVisible('Web',false);  //Web
			webform.WebOffice.WebToolsVisible('Picture',false);  //图片
			webform.WebOffice.WebToolsVisible('Control Toolbox',false); //控件工具箱
			webform.WebOffice.WebToolsVisible('Web Tools',false);  //Web工具箱
			webform.WebOffice.WebToolsVisible('Frames',false);//  框架集
			webform.WebOffice.WebToolsVisible('WordArt',false);  //艺术字
			webform.WebOffice.WebToolsVisible('符号栏',false);  //符号栏
			webform.WebOffice.WebToolsVisible('Outlining',false); // 大纲
			webform.WebOffice.WebToolsVisible('E-mail',false); //电子邮件
			webform.WebOffice.WebToolsVisible('Word Count',false); //字数统计
			//隐藏按钮
			webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
			webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
			webform.WebOffice.VisibleTools("保存文件",false);
			webform.WebOffice.VisibleTools("文字批注",false);
			webform.WebOffice.VisibleTools("手写批注",false);
			webform.WebOffice.VisibleTools("文档清稿",false);
			webform.WebOffice.VisibleTools("重新批注",false);
			//ShowRevision(false);
			//document.all.panel3.style.display="";
			$("#panel3").show();
			//setTimeout("allscreen()", 2000);
		}
	</s:if>
	<s:if test="information.informationType==5">
		if(isSurface()){
			whir_alert("该页面不支持在PAD上显示，请于PC端查看!");
		}else{
			var content = '<%=content%>';
			webform.WebOffice.WebUrl="http://<%=request.getServerName()+":"+request.getServerPort()%><%=rootPath%>/officeserverservlet";
			webform.WebOffice.RecordID=content;
			webform.WebOffice.Template="";
			webform.WebOffice.FileName=content+".xls";
			webform.WebOffice.FileType=".xls";
			webform.WebOffice.EditType=isfordbidCopy;
			webform.WebOffice.UserName="<%=session.getAttribute("userName")%>";
			webform.WebOffice.showMenu = "0";
			webform.WebOffice.EnablePrint =isfordbidCopy;
			if(forbidcopy != "1"){
				//20151217 -by jqq 添加权限控制
				if(canprint == '1'){
					webform.WebOffice.AppendTools("106","打印",5);
				}else{
					//3：自定义工具栏=true,	Office工具栏=false
					webform.WebOffice.ShowToolBar = 3;
			   }
			}else{
				webform.WebOffice.ShowToolBar = 3;
			}
			webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
            webform.WebOffice.ShowType="1";
			webform.WebOffice.WebToolsVisible('Standard',false);  //标准
			webform.WebOffice.WebToolsVisible('Formatting',false);  //格式
			webform.WebOffice.WebToolsVisible('Tables and Borders',false);  //表格和边框
			webform.WebOffice.WebToolsVisible('Database',false);  // 数据库
			webform.WebOffice.WebToolsVisible('Drawing',false);  //绘图
			webform.WebOffice.WebToolsVisible('Forms',false);  //窗体
			webform.WebOffice.WebToolsVisible('Visual Basic',false);  //Visual Basic
			webform.WebOffice.WebToolsVisible('Mail Merge',false);  //邮件合并
			webform.WebOffice.WebToolsVisible('Extended Formatting',false);  //其它格式
			webform.WebOffice.WebToolsVisible('AutoText',false);  //自动图文集
			webform.WebOffice.WebToolsVisible('Web',false);  //Web
			webform.WebOffice.WebToolsVisible('Picture',false);  //图片
			webform.WebOffice.WebToolsVisible('Control Toolbox',false); //控件工具箱
			webform.WebOffice.WebToolsVisible('Web Tools',false);  //Web工具箱
			webform.WebOffice.WebToolsVisible('Frames',false);//  框架集
			webform.WebOffice.WebToolsVisible('WordArt',false);  //艺术字
			webform.WebOffice.WebToolsVisible('符号栏',false);  //符号栏
			webform.WebOffice.WebToolsVisible('Outlining',false); // 大纲
			webform.WebOffice.WebToolsVisible('E-mail',false); //电子邮件
			webform.WebOffice.WebToolsVisible('Word Count',false); //字数统计
			//隐藏按钮
			webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
			webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
			webform.WebOffice.VisibleTools("保存文件",false);
			webform.WebOffice.VisibleTools("文字批注",false);
			webform.WebOffice.VisibleTools("手写批注",false);
			webform.WebOffice.VisibleTools("文档清稿",false);
			webform.WebOffice.VisibleTools("重新批注",false);
			//ShowRevision(false);
			$("#panel3").show();
			//setTimeout("allscreen()", 2000);
		}
	</s:if>
	<s:if test="information.informationType==6">
		if(isSurface()){
			whir_alert("该页面不支持在PAD上显示，请于PC端查看!");
		}else{
			var content = '<%=content%>';
			webform.WebOffice.WebUrl="http://<%=request.getServerName()+":"+request.getServerPort()%><%=rootPath%>/officeserverservlet";
			webform.WebOffice.RecordID=content;
			webform.WebOffice.Template="";
			webform.WebOffice.FileName=content+".ppt";
			webform.WebOffice.FileType=".ppt";
			webform.WebOffice.EditType=isfordbidCopy;
			webform.WebOffice.UserName="<%=session.getAttribute("userName")%>";
			webform.WebOffice.showMenu = "0";
			webform.WebOffice.EnablePrint =isfordbidCopy;
			if(forbidcopy != "1"){
				if(canprint == '1'){
					webform.WebOffice.AppendTools("106","打印",5);
				}else{
					//3：自定义工具栏=true,	Office工具栏=false
					webform.WebOffice.ShowToolBar = 3;
			   }
			}else{
				webform.WebOffice.ShowToolBar = 3;
			}
			webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
			
			webform.WebOffice.WebToolsVisible('Standard',false);  //标准
			webform.WebOffice.WebToolsVisible('Formatting',false);  //格式
			webform.WebOffice.WebToolsVisible('Tables and Borders',false);  //表格和边框
			webform.WebOffice.WebToolsVisible('Database',false);  // 数据库
			webform.WebOffice.WebToolsVisible('Drawing',false);  //绘图
			webform.WebOffice.WebToolsVisible('Forms',false);  //窗体
			webform.WebOffice.WebToolsVisible('Visual Basic',false);  //Visual Basic
			webform.WebOffice.WebToolsVisible('Mail Merge',false);  //邮件合并
			webform.WebOffice.WebToolsVisible('Extended Formatting',false);  //其它格式
			webform.WebOffice.WebToolsVisible('AutoText',false);  //自动图文集
			webform.WebOffice.WebToolsVisible('Web',false);  //Web
			webform.WebOffice.WebToolsVisible('Picture',false);  //图片
			webform.WebOffice.WebToolsVisible('Control Toolbox',false); //控件工具箱
			webform.WebOffice.WebToolsVisible('Web Tools',false);  //Web工具箱
			webform.WebOffice.WebToolsVisible('Frames',false);//  框架集
			webform.WebOffice.WebToolsVisible('WordArt',false);  //艺术字
			webform.WebOffice.WebToolsVisible('符号栏',false);  //符号栏
			webform.WebOffice.WebToolsVisible('Outlining',false); // 大纲
			webform.WebOffice.WebToolsVisible('E-mail',false); //电子邮件
			webform.WebOffice.WebToolsVisible('Word Count',false); //字数统计
			//隐藏按钮
			webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
			webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
			webform.WebOffice.VisibleTools("保存文件",false);
			webform.WebOffice.VisibleTools("文字批注",false);
			webform.WebOffice.VisibleTools("手写批注",false);
			webform.WebOffice.VisibleTools("文档清稿",false);
			webform.WebOffice.VisibleTools("重新批注",false);
			$("#panel3").show();
			//setTimeout("allscreen()", 2000);
		}
	</s:if>
});
<%}%>
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
        offsetFixed:30, /*滚动条距离顶部50时触发 show-fixed*/
        offsetTop:30, /*滚动条距离顶部50时触发 show-top*/
        duration:300 /*回到顶部花费时间*/
});
//给点击事件增加一个状态，数值变化仅供参考

</script>
<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)">
   if (vIndex==1){  //打开本地文件
      WebOpenLocal();
   }
   if (vIndex==2){  //保存本地文件
      WebSaveLocal();
   }
   if (vIndex==4){  //保存并退出
     SaveDocument();    //保存正文
     webform.submit();  //提交表单
   }
   if (vIndex==6){  //打印文档
      WebOpenPrint();
   }
</script>
<script language="javascript" for=WebOffice event="OnToolsClick(vIndex,vCaption)">
   webform.WebOffice.showMenu = "0";       
   WebToolsVisible('Standard',false);  //标准
   WebToolsVisible('Formatting',false);  //格式
   WebToolsVisible('Tables and Borders',false);  //表格和边框
   WebToolsVisible('Database',false);  // 数据库
   WebToolsVisible('Drawing',false);  //绘图
   WebToolsVisible('Forms',false);  //窗体
   WebToolsVisible('Visual Basic',false);  //Visual Basic
   WebToolsVisible('Mail Merge',false);  //邮件合并
   WebToolsVisible('Extended Formatting',false);  //其它格式
   WebToolsVisible('AutoText',false);  //自动图文集
   WebToolsVisible('Web',false);  //Web
   WebToolsVisible('Picture',false);  //图片
   WebToolsVisible('Control Toolbox',false); //控件工具箱
   WebToolsVisible('Web Tools',false);  //Web工具箱
   WebToolsVisible('Frames',false);//  框架集
   WebToolsVisible('WordArt',false);  //艺术字
   WebToolsVisible('符号栏',false);  //符号栏
   WebToolsVisible('Outlining',false); // 大纲
   WebToolsVisible('E-mail',false); //电子邮件
   WebToolsVisible('Word Count',false); //字数统计
   
   if (vIndex==106){WebOpenPrint();}
   if (vIndex==-1&&vCaption=='全屏'){
	   document.all.panel3.style.display="";
   }
   if (vIndex==-1 && vCaption=='返回'){
  	   webform.WebOffice.WebObject.Saved = true;
       document.all.panel3.style.display="none";
   }
</script>
<script>
function goNextInfo(index){
	var recordCount = window.opener.document.getElementById("recordCount").value;
	var orderByFieldName="";
	if(window.opener.document.getElementById("orderByFieldName")){
	   orderByFieldName=window.opener.document.getElementById("orderByFieldName").value;
	}
	var orderByType="";
	if(window.opener.document.getElementById("orderByType")){
		orderByType=window.opener.document.getElementById("orderByType").value;
	}
	var ahref="type=nextinfo&index="+index+'&orderByFieldName='+orderByFieldName+'&orderByType='+orderByType;
	//栏目
	if(window.opener.document.getElementById("searchChannel")){
		 ahref += '&searchChannel='+window.opener.document.getElementById("searchChannel").value;
	}
	//部门
	if(window.opener.document.getElementById("searchOrgId")){
		 ahref += '&searchOrgId='+window.opener.document.getElementById("searchOrgId").value;
	}
	if(window.opener.document.getElementById("searchOrgName")){
		 ahref += '&searchOrgName='+window.opener.document.getElementById("searchOrgName").value;
	}
	//附件
	if(window.opener.document.getElementById("append")){
		 ahref += '&append='+window.opener.document.getElementById("append").value;
	}
	//标题
	if(window.opener.document.getElementById("title")){
		 ahref += '&title='+window.opener.document.getElementById("title").value;
	}
	//标签
	if(window.opener.document.getElementById("publicTagsId")){
		 ahref += '&publicTagsId='+window.opener.document.getElementById("publicTagsId").value;
	}
	if(window.opener.document.getElementById("personalTagsId")){
		 ahref += '&personalTagsId='+window.opener.document.getElementById("personalTagsId").value;
	}
	//发布人
	if(window.opener.document.getElementById("searchIssuerName")){
		 ahref += '&searchIssuerName='+window.opener.document.getElementById("searchIssuerName").value;
	}
	//发布时间
	if(window.opener.document.getElementById("startDate")){
		 ahref += '&startDate='+window.opener.document.getElementById("startDate").value;
	}
	if(window.opener.document.getElementById("endDate")){
		 ahref += '&endDate='+window.opener.document.getElementById("endDate").value;
	}
	//隐藏的字段
	if(window.opener.document.getElementById("channelType")){
		 ahref += '&channelType='+window.opener.document.getElementById("channelType").value;
	}
	if(window.opener.document.getElementById("userDefine")){
		 ahref += '&userDefine='+window.opener.document.getElementById("userDefine").value;
	}
	if(window.opener.document.getElementById("userChannelName")){
		 ahref += '&userChannelName='+window.opener.document.getElementById("userChannelName").value;
	}
	//其他方式进入到查看页面，可能带入的参数列举
	if(window.opener.document.getElementById("relation")){
		 ahref += '&relation='+window.opener.document.getElementById("relation").value;
	}
	if("<%=checkdepart%>" != ""){
		 ahref += '&checkdepart='+window.opener.document.getElementById("checkdepart").value;
	}
	if(window.opener.document.getElementById("picflag")){
		 ahref += '&picflag='+window.opener.document.getElementById("picflag").value;
	}
	if(window.opener.document.getElementById("channelId")){
		 ahref += '&channelId='+window.opener.document.getElementById("channelId").value;
	}
	//console.log(ahref);
	var json = ajaxForSync("<%=rootPath%>/InfoList!goNextInfo.action",ahref);

	json = eval("("+json+")");
	if(json!=""){
		//单位主页
		if(json.departFlag == "1"){
			whir_tips('',1,'',function(){
				location_href('Information!view.action?informationId='+json.informationId+'&informationType='+json.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+json.channelId+'&userDefine='+$("#userDefine").val()+'&channelType='+json.channelType+'&gdType=infomation&checkdepart=1'+'&index='+json.index+'&recordCount='+recordCount);
			});
		}else{
			whir_tips('',1,'',function(){
				location_href('Information!view.action?informationId='+json.informationId+'&informationType='+json.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+json.channelId+'&userDefine='+$("#userDefine").val()+'&channelType='+json.channelType+'&gdType=infomation&checkdepart=&index='+json.index+'&recordCount='+recordCount);
			});
		}
		
	}
}
</script>