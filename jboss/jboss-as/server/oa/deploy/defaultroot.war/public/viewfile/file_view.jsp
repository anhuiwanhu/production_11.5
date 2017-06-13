<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%> 
<%@ include file="/public/include/init.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=rootPath%>/public/viewfile/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="<%=rootPath%>/public/viewfile/js/flexpaper.js"></script>
	<script type="text/javascript" src="<%=rootPath%>/public/viewfile/js/flexpaper_handlers.js"></script>
	<script type="text/javascript" src="<%=rootPath%>/public/viewfile/js/flexpaper_handlers_debug.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/util/cookie.js"></script>
	<style type="text/css" media="screen"> 
		html, body	{ height:100%; }
		body { margin:0; padding:0; overflow:auto; }   
		#flashContent { display:none; }
	</style> 
	<title>文档在线预览</title>
</head>
<%
String path = request.getParameter("path");
String fileName = request.getParameter("fileName");
String displayName = request.getParameter("displayName");
String convertType = request.getParameter("convertType");  
String isEncrypt = request.getParameter("isEncrypt");
String localpath = session.getServletContext().getRealPath("upload");
String realFile = preUrl + "/upload/" + path + "/" + fileName;
java.io.File file = new java.io.File (localpath+"\\"+path+"\\"+fileName);
if(!file.exists()){
	realFile = preUrl + "/upload/" + path + "/" + fileName.substring(0,6) + "/" + fileName;
}
realFile = realFile.substring(0,realFile.lastIndexOf("."))+".swf";

com.whir.component.security.crypto.EncryptUtil util = new com.whir.component.security.crypto.EncryptUtil();
String zhengwencode= util.getSysEncoderKeyVlaue("FileName",fileName,"dir"); 

String downloadUrl=preUrl+"/public/download/download.jsp?verifyCode="+zhengwencode+"&FileName="+fileName+"&path="+path+"&name="+displayName;


String  actionname="";

int splitIndex = fileName.lastIndexOf(".");
String extName = fileName.substring(splitIndex + 1);
if (extName != null) {
    extName = extName.toLowerCase();
}

String FILE_EXTS = "|txt|doc|docx|xls|xlsx|ppt|pptx|";
String  fileViewTypecookie=""; 
if (FILE_EXTS.indexOf("|" + extName + "|") != -1) {
  
   /*CookieParser cookieparser = new CookieParser();
   try{
        fileViewTypecookie=cookieparser.getStringCookie("fileViewType");
   }catch(Exception e){
   }*/


    Cookie[] cookies = request.getCookies();    
    // 遍历数组,获得具体的Cookie
    if(cookies == null) { 
    } else {
     for(int i=0; i<cookies.length; i++) {
        // 获得具体的Cookie
        Cookie cookie = cookies[i];
        // 获得Cookie的名称
        String name = cookie.getName();
        String value = cookie.getValue();
        if("fileViewType".equals(name)){
            fileViewTypecookie=value;
        } 
     }
    }  
   if(fileViewTypecookie==null||fileViewTypecookie.equals("")){
       fileViewTypecookie="wordToHtml";
   }

   if("wordToHtml".equals(fileViewTypecookie)){
       convertType="wordToHtml";  
       actionname="返回高清模式";
   }else{
       //pdfToSwf
       actionname="返回标清模式";
   }

   if("wordToHtml".equals(convertType)){
       realFile = realFile.substring(0,realFile.lastIndexOf("."))+".html";
   }
}
 

%>
<body style="overflow-y:hidden"> 
<style>
.zq_top1{line-height:30px;}
.zq_top1 .title{float:left; font-size:14px;}
.zq_top1 .title span{margin:0 15px 0 10px;color:#000;}
.zq_top1 .title a{color:#074977;font-size:12px;}
.zq_top1 .title a font{color:#999;}
.zq_top1 .xq_back{float:right;color:#000;font-size:14px;margin-right:15px;}
.zq_top1 .xq_back a{color:#074977;}
</style> 
    <div style="position:relative;background:#f6f9fc;width:100%; height:50px;color:#fff;z-index:9999;zoom:1;" class="zq_top1"><div class="title"><%if(!"information".equals(path)){%><span><strong><%=displayName%></strong></span><a href="<%=downloadUrl%>"  target="dwin"><font>[</font>下载<font>]</font></a><%}%></div><div class="xq_back"><a href="#"  onclick="changerType();"><%=actionname%></a></div></div> 
    <div style="display: block; height:90%;">
    <iframe src=""   width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" id="fileFrame" name="fileFrame" style="display:none;" ></iframe> 
	<div id="documentViewer" class="flexpaper_viewer" style="width:100%;height:100%;"></div>   
    </div>
    <iframe id="dwin" name="dwin" style="display:none"></iframe>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		type: 'POST',
		url: '<%=rootPath%>/UniAuth!viewFile.action',
        async: false,
		dataType: 'text',
		data: 'path=<%=path%>&convertType=<%=convertType%>&fileName=<%=fileName%>&isEncrypt=<%=isEncrypt%>',
		success: function(data){
			if(data!=null && data!=""){
				if(data == '-1'){
					whir_alert("预览文档失败！");
				}else{
                    <%
                        if("wordToHtml".equals(convertType)){%>
                             $("#fileFrame").show();
                             $("#documentViewer").hide();
                            $("#fileFrame").attr("src","<%=realFile%>");  
                      <%}else{

                    %>
                   
					var startDocument = "Paper";
					$('#documentViewer').FlexPaperViewer(
						{ config : {
							SWFFile : '<%=realFile%>',
							Scale : 1,
							ZoomTransition : 'easeOut',
							ZoomTime : 0.5,
							ZoomInterval : 0.2,
							FitPageOnLoad : false,
							FitWidthOnLoad : false,
							FullScreenAsMaxWindow : true,
							ProgressiveLoading : true,
							MinZoomSize : 0.2,
							MaxZoomSize : 5,
							SearchMatchAll : false,
							InitViewMode : 'Portrait',
							RenderingOrder : 'flash',
							StartAtPage : '',
							ViewModeToolsVisible : true,
							ZoomToolsVisible : true,
							NavToolsVisible : true,
							CursorToolsVisible : true,
							SearchToolsVisible : true,
							WMode : 'window',
							localeChain: 'zh_CN',
							jsDirectory: '<%=rootPath%>/public/viewfile/js/',
							cssDirectory: '<%=rootPath%>/public/viewfile/css/',
							localeDirectory: '<%=preUrl%>/upload/<%=path%>/'
						}}
					);
                    <%}%>
				}
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alert(XMLHttpRequest.status);
			alert(XMLHttpRequest.readyState);
			alert(textStatus);
		}
	});
});

function changerType(type){  
      <%
         if("wordToHtml".equals(convertType)){%>
           setCookie("fileViewType","pdfToSwf",expdate, "/", null, false);
         <%}else{%>
              setCookie("fileViewType","wordToHtml",expdate, "/", null, false);
        <% }   
      %>
      
      location.reload();
}
function location_href(url){
    if(document.all){
        if ($.browser.msie && ($.browser.version == "6.0") ) {
            document.write("<a href='javascript:void(0);' id='whir_alink_tttt' onclick='window.location.href=\""+url+"\";return false;'></a>");
            document.close();
            document.getElementById('whir_alink_tttt').click();
        }else{
            var gotoLink = document.createElement('a');
            gotoLink.href = url;
            document.body.appendChild(gotoLink);
            gotoLink.click();
        } 
    }else{
        window.location.href=url;
    }
}
</script>
</html>