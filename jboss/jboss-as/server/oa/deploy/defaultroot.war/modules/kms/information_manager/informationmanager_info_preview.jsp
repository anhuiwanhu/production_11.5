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
	
	//2013-09-11-----单位主页归档需要的参数-----start
  	String departchannelId =request.getParameter("departchannelId")==null?"":request.getParameter("departchannelId").toString();
  	String departchannelType =request.getParameter("departchannelType")==null?"":request.getParameter("departchannelType").toString();
  	String departuserChannelName =request.getParameter("departuserChannelName")==null?"":request.getParameter("departuserChannelName").toString();
  	String departuserDefine =request.getParameter("departuserDefine")==null?"":request.getParameter("departuserDefine").toString();
  	String departheadColor =request.getParameter("departheadColor")==null?"":request.getParameter("departheadColor").toString();
  	//2013-09-11-----单位主页归档需要的参数-----end
	String canprint = "0";
	//页面预览需要的参数
	String userDefine = request.getAttribute("userDefine").toString();
	String userChannelName = request.getAttribute("userChannelName").toString();
	String content = request.getAttribute("content").toString();
%>
<body onselectstart="return false">
	<div class="wh-wrapper">
    <div class="wh-view wh-detail wh-d-info">
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
              <span id="issue-time" class="meta-date"><s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/></span>
              <span id="issue-user"><strong class="meta-author"><s:text name="info.searchareapublisher"/>：</strong>
              <span class="meta-aname"><s:property value="information.informationIssueOrg"/>.<s:property value="information.informationIssuer"/></span></span>
            </div>
          </div>
          <hr/>
		  <!-----------------------------------------页面内容 start------------------------------------------->
		  <div class="wh-dtl-art clearfix">
            <s:hidden id="channelId" name="channelId"/>
			<s:hidden id="userChannelName" name="userChannelName"/>
			<s:hidden id="userDefine" name="userDefine"/>
			<s:hidden id="channelType" name="channelType"/>
			
            <%
			String infoPicName = request.getAttribute("infoPicName")!=null?request.getAttribute("infoPicName").toString():"";
			String infoPicSaveName = request.getAttribute("infoPicSaveName")!=null?request.getAttribute("infoPicSaveName").toString():"";
			if(!infoPicName.equals("")){
				String[] imgs = infoPicSaveName.split("\\|");
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
			<%-- <s:if test="information.displayImage == 1"> --%>
				<div class="wh-dtl-media">
					<img name="image" src="<%=smallSrcUrl%>" onclick="openRealPic('<%=realSrcUrl%>');" style="cursor:pointer"/>
				</div>
			<%-- </s:if> --%>
			<%
				}//for 循环结束
			}//!infoPicName.equals("") 结束
			%>
			<%--<div class="news_content"> --%>
				<%=content%>
			<%--</div> --%>
		  </div>
		  <!-----------------------------------------页面内容 end------------------------------------------->
         </div>
	</div>
	</div>
	</div>
</body>
</html>
<script>
$(document).ready(function(){
	var isfordbidCopy = '<s:property value="information.forbidCopy"/>';
	var hasprintright = '<%=canprint%>';
	var informationId = '<s:property value="information.informationId"/>';
	var channelId = '<s:property value="channelId"/>';
	//禁止右键
	document.oncontextmenu = stoprightbutton;
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