<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.whir.ezoffice.information.infomanager.bd.*"%>
<%@ page import="com.whir.common.util.UploadFile"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

String categoryName = request.getParameter("categoryName");
String title = request.getParameter("title")==null?"":request.getParameter("title").toString();
Object[] obj = request.getAttribute("po")==null?null:(Object[])request.getAttribute("po");
java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy年MM月dd日 HH:mm");
String informationId = obj[0].toString();
String informationType = (String)obj[5];
String content = obj[2]!=null?obj[2].toString():"";
String displayImage = obj[6]!=null?obj[6].toString():"";
InformationAccessoryBD accBD = new InformationAccessoryBD();
List listAcc = null;
if(!"0".equals(displayImage)){
    listAcc = accBD.getAccessory(informationId);
}
title = obj[1].toString();
title = title.replaceAll("<","&lt;").replaceAll(">","&gt;");
int smartInUse = 0;
//java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap("0");
if(sysMap != null && sysMap.get("附件上传") != null){
    smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=title%></title>
<link href="<%=rootPath%>/themes/portal/default/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=rootPath%>/scripts/jquery-1.11.1.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /> 
</head>
<%
if(informationType.equals("2")){
%>
<body>
<script type="text/javascript">
location.href = '<%=content%>';
</script>
</body>
</html>
<%}else{%>
<body onload="Load();">
<!--头部开始-->
<!--头部结束-->

<div class="mainbox">
<div class="main_nr"  style="padding:0px; background-image:none;">
<div  style="height:30px; line-height:30px; text-align:right"><a href="#" style="color:#BA022D;"></a></div>
    <div class="title02"><%if(categoryName!=null&&!"".equals(categoryName)&&!"null".equals(categoryName)){%><%=categoryName%>&nbsp;>&nbsp;<%}%><%=title%></div>
      <div class="content_box"> 
      <div class="content">
        <div class="content_t"><%=title%></div>
        <div class="content_time"><%=sf.format(obj[4])%>&nbsp;&nbsp;<span><%=obj[3].toString()%></span></div>
        <%if(!"0".equals(displayImage)){%>
		<div align="center">
		<%
			String imageName = "";
			for(int i=0;i<listAcc.size();i++){
				Object[] objAcc = (Object[]) listAcc.get(i);
				if (((Integer) objAcc[4]).intValue() == 1) {
					imageName = objAcc[2].toString(); //标记已找到图片,标记为附件名称
					String datePath = imageName.substring(0,6);
					String subFolder = "";
					if(smartInUse==0){
						com.whir.common.util.UploadFile upFile = new com.whir.common.util.UploadFile();
						subFolder = upFile.getSubFolder(imageName);
						if(subFolder.length()>0){
							subFolder += "/";
						}
					}
					imageName=(smartInUse==1?rootPath+"/upload/information/"+datePath+"/"+imageName:fileServer+"/upload/information/"+subFolder+imageName);
		%>
			<img src="<%=imageName%>" />
		<%
				}
			}
		%>
		</div>
        <%}%>
        <%if("4".equals(informationType)||"5".equals(informationType)||"6".equals(informationType)){%>
        <div class="content_font">
            <form name="webform" method="post">
            <div id="panel3" name="panel3" style="display:none;" align=center>
                <%@ include file="/public/iWebOfficeSign/iWebOfficeVersion2.jsp"%>
            </div>
            </form>
        </div>
        <%}else if("0".equals(informationType)){%>
        <div class="content_font">
        <%
            char[] tmp = content.toCharArray();
            for(int i = 0; i < tmp.length; i ++){
                if(tmp[i] == '\n'){
                    out.print("<br>");
                }else if(tmp[i] == (char) 32){
                    out.print("&nbsp;");
                }else{
                    out.print(tmp[i]);
                }
            }
        %>
        </div>
        <%}else if("3".equals(informationType)){
			UploadFile upFile = new UploadFile();
			String fileType = obj[2]!=null && obj[2].toString().endsWith(".pdf") ? "pdf" :"";
			if(fileType.equals("pdf")){
				String saveName = obj[2].toString().split(":")[1];
				String subFolder = saveName.substring(0,6);
				String encrypt = upFile.getFileEncrypt(saveName);
				if("1".equals(encrypt)){
					String localPath = session.getServletContext().getRealPath("upload");
					String decode = localPath+"\\information\\"+subFolder+"\\"+"decode-"+saveName;
					String file = localPath+"\\information\\"+subFolder+"\\"+saveName;
					File decodeFile = new File(decode);
					if(!decodeFile.exists()){
						BufferedInputStream input = new BufferedInputStream(new FileInputStream(file));
						BufferedOutputStream output = new BufferedOutputStream(new FileOutputStream(decodeFile));
						byte[] buf = new byte[8192];
						int n = -1;
						while( -1 != (n = input.read(buf, 0, buf.length))) {
							for(int i0 = 0; i0 < n; i0++) {
								buf[i0] = (byte)(buf[i0] + 1);
							}
							output.write(buf, 0, n);
						}
						output.flush();
					}
					saveName = "decode-"+saveName;
				}
		%>
		<div align="center">
			<iframe name="dd" src="<%=rootPath%>/modules/govoffice/gov_documentmanager/viewPDF.jsp?url=<%=preUrl%>/upload/information/<%=subFolder+"/"+saveName%>" frameborder=0 style="width:900px;height:630px;" border=0></iframe>
		</div>
		<%	}else{%>
        <div class="content_font"><%=obj[2]!=null?(obj[2].toString().indexOf(":")!=-1?obj[2].toString().split(":")[0]:obj[2].toString()):"&nbsp;"%></div>
        <%}}else{%>
        <div class="content_font"><%=obj[2]!=null?obj[2].toString():"&nbsp;"%></div>
        <%}%>
		<div align="center" style="padding-top:20px;"><input name="" type="button" value="关闭"  onclick="javascript:window.close();"  class="but_04"/></div>
        </div> 
      </div>  
  <div class="clear_1"></div>

</div>
</div>

<!--底部结束-->
<!--底部开始-->
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
function FormatImagesSize(w){
  var e=new Image();
  for(i=0;i<document.images.length;i++){
    if (document.images[i]){
	  if(document.images[i].resize!=0){
        e.src=document.images[i].src;
        if (e.width>w) {
		  var pic=document.images[i];
		  pic.width=w;
		  pic.style.width="";
		  pic.style.height="";
          //pic.title="";
          //pic.style.cursor="hand";
          //pic.onclick=function(){}
		}
	  }
    }
  }
}
FormatImagesSize(800);

function Load(){
	<%if("4".equals(informationType)){%>
    webform.WebOffice.WebUrl="http://<%=request.getServerName()+":"+request.getServerPort()%><%=rootPath%>/officeserverservlet";
    webform.WebOffice.RecordID="<%=content%>";
    webform.WebOffice.Template="";
    webform.WebOffice.FileName="<%=content%>.doc";
    webform.WebOffice.FileType=".doc";
    webform.WebOffice.EditType="-1,2,0,0,0,0,0,0";
    webform.WebOffice.UserName="ezoffice";
    webform.WebOffice.showMenu = "0";
    webform.WebOffice.EnablePrint ="-1,2,0,0,0,0,0,0";
    webform.WebOffice.WebOpen();
    webform.WebOffice.ShowType="1";

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

    //隐藏按钮
    webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
    webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
    webform.WebOffice.VisibleTools("保存文件",false);
    webform.WebOffice.VisibleTools("文字批注",false);
    webform.WebOffice.VisibleTools("手写批注",false);
    webform.WebOffice.VisibleTools("文档清稿",false);
    webform.WebOffice.VisibleTools("重新批注",false);

    ShowRevision(false);

    document.all.panel3.style.display="";

    <%}else if("5".equals(informationType)){%>
    webform.WebOffice.WebUrl="http://<%=request.getServerName()+":"+request.getServerPort()%><%=rootPath%>/officeserverservlet";
    webform.WebOffice.RecordID="<%=content%>";
    webform.WebOffice.Template="";
    webform.WebOffice.FileName="<%=content%>.xls";
    webform.WebOffice.FileType=".xls";
    webform.WebOffice.EditType="-1,2,0,0,0,0,0,0";
    webform.WebOffice.UserName="ezoffice";
    webform.WebOffice.showMenu = "0";
    webform.WebOffice.EnablePrint ="-1,2,0,0,0,0,0,0";

    webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
    webform.WebOffice.ShowType="1";
    //StatusMsg(webform.WebOffice.Status);
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

    //隐藏按钮
    webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
    webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
    webform.WebOffice.VisibleTools("保存文件",false);
    webform.WebOffice.VisibleTools("文字批注",false);
    webform.WebOffice.VisibleTools("手写批注",false);
    webform.WebOffice.VisibleTools("文档清稿",false);
    webform.WebOffice.VisibleTools("重新批注",false);


    ShowRevision(false);
    document.all.panel3.style.display="";

    <%}else if("6".equals(informationType)){%>
    webform.WebOffice.WebUrl="http://<%=request.getServerName()+":"+request.getServerPort()%><%=rootPath%>/officeserverservlet";
    webform.WebOffice.RecordID="<%=content%>";
    webform.WebOffice.Template="";
    webform.WebOffice.FileName="<%=content%>.ppt";
    webform.WebOffice.FileType=".ppt";
    webform.WebOffice.EditType="-1,2,0,0,0,0,0,0";
    webform.WebOffice.UserName="ezoffice";
    webform.WebOffice.showMenu = "0";
    webform.WebOffice.EnablePrint ="-1,2,0,0,0,0,0,0";

    webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
    //StatusMsg(webform.WebOffice.Status);
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

    //隐藏按钮
    webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
    webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
    webform.WebOffice.VisibleTools("保存文件",false);
    webform.WebOffice.VisibleTools("文字批注",false);
    webform.WebOffice.VisibleTools("手写批注",false);
    webform.WebOffice.VisibleTools("文档清稿",false);
    webform.WebOffice.VisibleTools("重新批注",false);

    //ShowRevision(false);
    document.all.panel3.style.display="";
    // webform.WebOffice.WebSlideShow();
    <%}%>
}

function WebToolsVisible(ToolName,Visible){
    try{
    webform.WebOffice.WebToolsVisible(ToolName,Visible);
    StatusMsg(webform.WebOffice.Status);
    }catch(e){}
}

//作用：显示操作状态
function StatusMsg(mString){
    StatusBar.innerText=mString;
}

function ShowRevision(mValue){
}
//-->
</SCRIPT>
<%}%>