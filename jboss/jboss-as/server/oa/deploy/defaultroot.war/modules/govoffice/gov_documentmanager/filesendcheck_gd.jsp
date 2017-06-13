<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.io.*"%>
<html>
<head>
<title>
正在归档中,请稍后...
</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body bgcolor="#ffffff">
<%
request.setCharacterEncoding("UTF-8");
if(request.getParameter("gd") != null){
    String pageContent = request.getParameter("pageContent");
    //int fp = pageContent.indexOf("<SCRIPT language=javascript>");
    //int ep = pageContent.indexOf("</SCRIPT>", fp);
    //pageContent = pageContent.substring(0, fp) + pageContent.substring(ep + 9);
    //pageContent = new String(pageContent.getBytes("ISO8859-1"), "GBK");
    if(pageContent.indexOf("gd();") >= 0){
        int tmp = pageContent.indexOf("gd();");
        pageContent = pageContent.substring(0, tmp) + pageContent.substring(tmp + 5);
    }
    pageContent = pageContent.replaceAll("gd();", "");
    Calendar now = Calendar.getInstance();
    String tmp = "GW_" + request.getParameter("recordId") + "_" + now.get(Calendar.YEAR) + (now.get(Calendar.MONTH) + 1) + now.get(Calendar.DATE) + ".htm";
	
    String fileName = getServletConfig().getServletContext().getRealPath("/") + "/archivesfile/" + tmp;
    //String returnValue = new com.whir.ezoffice.archives.bd.ArchivesBD().archivesPigeonholeSet("GWGL",session.getAttribute("domainId")==null?"-1":session.getAttribute("domainId").toString());

    String createdEmp = request.getParameter("createdEmp");
    java.util.HashMap hmap = new com.whir.govezoffice.documentmanager.bd.SendFileBD().getUserOrg(createdEmp);
    String createdOrg = hmap==null?"":hmap.get("orgId").toString();
    //new com.whir.ezoffice.archives.action.ArchivesAction().addArchivesWaitPigeonhole(request.getParameter("fileTitle"),tmp,Long.valueOf(request.getParameter("recordId")),"GWGL",session.getAttribute("userName").toString(), new java.util.Date(), returnValue, request, createdEmp, createdOrg,"WJSS");
   

    	 java.io.File file = new java.io.File(fileName);
         OutputStreamWriter os = null;
         try {
	
              os = new OutputStreamWriter(new FileOutputStream(file), "UTF-8");
			 // os.write("<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><title>文件送审签归档</title><script  src=\"" + rootPath + "/js/utfTooljs.js\"  language=\"javascript\" ></script><script  src=\"" + rootPath + "/js/util/tool.js\"  language=\"javascript\" ></script></head>\n"+"<body onload=\"init();\" leftmargin=0 topmargin=0>\n"+pageContent+"</body></html>");
			    os.write(" <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head>	<title>发文</title>	<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/>	<meta http-equiv=\"X-UA-Compatible\" content=\"IE=EmulateIE8\" />	<script type=\"text/javascript\"> 	var whirRootPath = \"/defaultroot\";	var preUrl = \"/defaultroot\"; 	var whir_browser = \"msie\"; 	var whir_agent = \"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET4.0C; .NET4.0E)\"; </script> <script src=\"/defaultroot/scripts/jquery-1.11.2.min.js\" type=\"text/javascript\"></script><script src=\"/defaultroot/scripts/i18n/zh_CN/CommonResource.js\" type=\"text/javascript\"></script><link   href=\"/defaultroot/themes/common/common.css\" rel=\"stylesheet\" type=\"text/css\"/><link   href=\"/defaultroot/themes/2011/green/style.css\" rel=\"stylesheet\" type=\"text/css\"/> <script src=\"/defaultroot/scripts/plugins/My97DatePicker/WdatePicker.js\"></script> <script src=\"/defaultroot/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog\" type=\"text/javascript\"></script> <script src=\"/defaultroot/scripts/plugins/powerFloat/jquery-powerFloat.js\" type=\"text/javascript\"></script><link   href=\"/defaultroot/scripts/plugins/powerFloat/powerFloat.css\" rel=\"stylesheet\" type=\"text/css\"/> <script src=\"/defaultroot/scripts/plugins/form/jquery.form.js\" type=\"text/javascript\"></script><link   href=\"/defaultroot/scripts/plugins/form/form.css\" rel=\"stylesheet\" type=\"text/css\"/> <link   href=\"/defaultroot/scripts/plugins/easyui/1.3.2/themes/default/easyui.css\" rel=\"stylesheet\" type=\"text/css\"/><link   href=\"/defaultroot/scripts/plugins/easyui/1.3.2/themes/icon.css\" rel=\"stylesheet\" type=\"text/css\"/><script src=\"/defaultroot/scripts/plugins/easyui/1.3.2/jquery.easyui.min.js\" type=\"text/javascript\"></script> <link   href=\"/defaultroot/scripts/plugins/uniform/themes/default/css/uniform.default.css\" rel=\"stylesheet\" type=\"text/css\"/><script src=\"/defaultroot/scripts/plugins/uniform/jquery.uniform.min.js\" type=\"text/javascript\"></script> <script src=\"/defaultroot/scripts/main/whir.validation.js\" type=\"text/javascript\"></script><script src=\"/defaultroot/scripts/main/whir.application.js\" type=\"text/javascript\"></script><script src=\"/defaultroot/scripts/main/whir.openselect.js\" type=\"text/javascript\"></script><script src=\"/defaultroot/scripts/main/whir.tab.js\" type=\"text/javascript\"></script><script src=\"/defaultroot/scripts/main/whir.combobox.js\" type=\"text/javascript\"></script><script src=\"/defaultroot/scripts/util/whir.base64.js\" type=\"text/javascript\"></script><!--[if IE 6]><script src=\"/defaultroot/scripts/desktop/iepng.js\" type=\"text/javascript\"></script><script type=\"text/javascript\">EvPNG.fix('img,.scrollArrowLeft,.scrollArrowLeftDisabled,.scrollArrowRight,.scrollArrowRightDisabled,.face_box,.top_boxbg,.bg_01,.bg_02,.topread_box,.skin_btn,.f_person,.hint_area,.facebg,.logo_img,.bg_png,.main_box,.bg_png');</script><![endif]--><script type=\"text/javascript\"> /********公共初始化操作**********************/$(document).ready(function(){			    setInputStyle();    digitCheck();    $(\"input[type='hidden'],select\").each(function(){        $(this).attr(\"defaultValue\",$(this).val());    });               });</script>    	<script src=\"/defaultroot/scripts/plugins/poshytip/jquery.poshytip.js\" type=\"text/javascript\"></script><link   href=\"/defaultroot/scripts/plugins/poshytip/tip-yellowsimple/tip-yellowsimple.css\" rel=\"stylesheet\" type=\"text/css\"/>	<!--这里可以追加导入模块内私有的js文件或css文件-->    <!--工作流包含页 js文件-->      <script src=\"/defaultroot/public/toolbar/WhirToolbar.js\"   type=\"text/javascript\"></script><!--工具栏工作流按钮事件公用js--><script src=\"/defaultroot/platform/bpm/work_flow/js/workflow.js\"   type=\"text/javascript\"></script><!--工具栏工作流js--><script src=\"/defaultroot/platform/bpm/work_flow/js/wf.js\"   type=\"text/javascript\"></script> <link   href=\"/defaultroot/scripts/plugins/zTree/css/2012/zTreeStyle.css\" rel=\"stylesheet\" type=\"text/css\"/><!--link   href=\"/defaultroot/scripts/plugins/zTree/css/2012/iconSkin.css\" rel=\"stylesheet\" type=\"text/css\"/--><script src=\"/defaultroot/scripts/plugins/zTree/js/jquery.ztree.core-3.5.min.js\" type=\"text/javascript\"></script><script src=\"/defaultroot/scripts/plugins/zTree/js/jquery.ztree.excheck-3.5.min.js\" type=\"text/javascript\"></script><script src=\"/defaultroot/public/treeselect/script.js\"   type=\"text/javascript\"></script>   	<script src=\"/defaultroot/modules/govoffice/gov_documentmanager/js/send.js\"   type=\"text/javascript\"></script>	<style type=\"text/css\">	<!--	.sw {		background:transparent;		border-top-width: 0px;		border-right-width: 0px;		border-bottom-width: 1px;		border-left-width: 0px;		border-top-style: solid;		border-right-style: solid;		border-bottom-style: solid;		border-left-style: solid;		border-bottom-color: #CCCCCC;	}	.inputTextsw{		background:transparent;		border-top-width: 0px;		border-right-width: 0px;		border-bottom-width: 1px;		border-left-width: 0px;		border-top-style: solid;		border-right-style: solid;		border-bottom-style: solid;		border-left-style: solid;		border-bottom-color: #CCCCCC;	}	#noteDiv_toPerson1 {		position:absolute;		width:220px;		height:126px;		z-index:1;		overflow:auto;		border:1px solid #829FBB;		display:none;	}	#noteDiv_toPersonBao {		position:absolute;		width:220px;		height:126px;		z-index:1;		overflow:auto;		border:1px solid #829FBB;		display:none;	}	#noteDiv_toPerson2 {		position:absolute;		width:220px;		height:126px;		z-index:1;		overflow:auto;		border:1px solid #829FBB;		display:none;	}	.divOver{		background-color:#003399;		color:#FFFFFF;		border-bottom:1px dashed #cccccc;		width:100%;		height:20px;		line-height:20px;		cursor:default;		padding-left:5px;		white-space:nowrap	}	.divOut{		background-color:#ffffff;		color:#000000;		border-bottom:1px dashed #cccccc;		width:100%;		height:20px;		line-height:20px;		cursor:default;		padding-left:5px;				white-space:nowrap	}	.STYLE1,.STYLE1 font,.STYLE1 text,.STYLE1 textarea{font-size: 14px; font-family:\"宋体\"}		-->	</style>	<style type=\"text/css\">        html,body{ height:100%; overflow:hidden; margin:0; padding:0;}    </style>     <script type=\"text/javascript\">    $(function(){     var bh = $(\"body\").height();     var dh = bh-47;     $(\"#mainContent\").height(dh);    });    </script> </head> "+"<body style=\"overflow:scroll\"  leftmargin=0 topmargin=0>\n"+pageContent+"</body><script>document.getElementById('popToolbar').parentNode.removeChild(document.getElementById('popToolbar'));</script></html>");
			
         } catch (Exception e) {
             e.printStackTrace();
         }finally{
              try{
				  os.flush();
                  os.close();
              }catch(Exception e1){
                e1.printStackTrace();
              }

         }
		 		 //ftp上传
		 com.whir.org.common.util.SysSetupReader sss = new com.whir.org.common.util.SysSetupReader();
		  //java.util.Map sysMap = sss.getSysSetupMap(request.getSession(true).getAttribute("domainId").toString());
		   if (sysMap != null && sysMap.get("附件上传") != null && sysMap.get("附件上传").toString().equals("0")){
			   java.util.Map ftpMap = com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(), request.getSession(true).getAttribute("domainId").toString());
			   String server = ftpMap.get("server").toString();
			   String port = ftpMap.get("port").toString();
			   String user = ftpMap.get("user").toString();
			   String oriPass = ftpMap.get("oriPass") + "whir?!";
				com.whir.govezoffice.documentmanager.common.util.NewFtpClient ftpClient = new com.whir.govezoffice.documentmanager.common.util.NewFtpClient(server, port,user,oriPass,fileName,tmp, "archivesfile");
				ftpClient.upload2();
		   }
%>
<%    
	 Date date=new Date();
     String dateString1=""+(date.getYear()+1900);//+"/"+(date.getMonth()+1)+"/"+date.getDate();
	 String dateString2=""+(date.getYear()+1900)+"/"+(date.getMonth()+1)+"/"+date.getDate();
	 com.whir.ezoffice.dossier.bd.DossierBD dossierBD=new com.whir.ezoffice.dossier.bd.DossierBD();
		 Boolean b=dossierBD.gdDossier(request.getParameter("fileId"),"SSQGL",request.getParameter("fileTitle"),null,null,null,null,dateString1,null,null,request.getParameter("org"),null,createdEmp,createdOrg,dateString2,session.getAttribute("domainId").toString(),"htm",tmp,null,null,request.getParameter("zwurl"));
%>
	<script language="javascript">
        parent.window.close();
		parent.opener.location.reload();
    </script>
<%
}else{%>
<iframe id="gd" src=""></iframe>
<SCRIPT LANGUAGE="JavaScript">
<!--
<%
//解锁在线编辑
java.util.Map myParaTmp = new java.util.HashMap();
myParaTmp.put("recordId",request.getParameter("recordId"));
myParaTmp.put("tableId",request.getParameter("tableId"));
myParaTmp.put("processId",request.getParameter("processId"));
myParaTmp.put("workId",request.getParameter("workId"));
com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD myUfbdTemp = new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD();
myUfbdTemp.delWFOnlineUser(myParaTmp);
%>
	var  url='<%=request.getAttribute("myhref") + "&gd=1"%>';   
   // url=encodeURI(url);
	document.all.gd.src=url;

//-->
</SCRIPT>
<%}%>
</body>
</html>
