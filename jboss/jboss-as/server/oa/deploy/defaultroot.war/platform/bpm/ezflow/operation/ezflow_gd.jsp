<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<html>
<head>
	<title>ezflow_gd</title>
</head>
<body bgcolor="#ffffff">
<%
request.setCharacterEncoding("UTF-8");
//System.out.println("**************************************");
//System.out.println("enter gd page ");
//System.out.println("**************************************");

//System.out.println("**************************************");
//System.out.println("isGD: " + request.getParameter("isGD"));
//System.out.println("**************************************");

if(request.getParameter("gd") != null) {
    String pageContent = request.getParameter("pageContent");
	String p_submitPerson = request.getParameter("gd_startUserName")!=null?request.getParameter("gd_startUserName"):"";
	String p_submitTime = request.getParameter("gd_startTime")!=null?request.getParameter("gd_startTime"):"";
	p_submitTime = p_submitTime.indexOf(".")!=-1?p_submitTime.substring(0, p_submitTime.indexOf(".")):p_submitTime;
	
	String gd_type = request.getParameter("gd_type")!=null?request.getParameter("gd_type"):"";
	String gd_path = request.getParameter("gd_path")!=null?request.getParameter("gd_path"):"";

	if (pageContent != null && pageContent.length() > 0) {
		//int fp = pageContent.indexOf("<SCRIPT language=javascript>");
		//int ep = pageContent.indexOf("</SCRIPT>", fp);
		//pageContent = pageContent.substring(0, fp) + pageContent.substring(ep + 9);
		//pageContent = new String(pageContent.getBytes("ISO8859-1"), "GBK");
		if(pageContent.indexOf("gd();") >= 0){
			int tmp = pageContent.indexOf("gd();");
			pageContent = pageContent.substring(0, tmp) + pageContent.substring(tmp + 5);
		}
		pageContent = pageContent.replaceAll("gd();", "");
	}

	String title = request.getParameter("gd_title");
	if (title == null || title.length() <= 0)
		title = request.getAttribute("gd_title") + "";
	
    String workId = request.getParameter("gd_processInstanceId");
	if (workId == null || workId.length() <= 0)
		workId = request.getAttribute("gd_processInstanceId") + "";

    Calendar now = Calendar.getInstance();
    String tmp = "LC_" + workId + "_" + now.get(Calendar.YEAR) + (now.get(Calendar.MONTH) + 1) + now.get(Calendar.DATE) + ".htm";

	//String fileName = application.getRealPath(request.getRequestURI()).split("defaultroot")[0]+"defaultroot\\archivesfile\\" + tmp;
    String fileName = getServletConfig().getServletContext().getRealPath("/")+ "/archivesfile/" + tmp;

	//String returnValue = new com.whir.ezoffice.archives.bd.ArchivesBD().archivesPigeonholeSet("GZLC",(session.getAttribute("domainId")==null?"-1":session.getAttribute("domainId").toString()));

	String createEmp = request.getParameter("submitPersonId")==null?"-1":request.getParameter("submitPersonId");

	String gd_startUserCode= request.getParameter("gd_startUserCode")==null?"-1":request.getParameter("gd_startUserCode");

    // 发起人的组织id
	String createOrg = request.getParameter("gd_startOrgId")!=null?request.getParameter("gd_startOrgId").toString():"-1";
	
	String gd_remindTitle =request.getParameter("gd_remindTitle")!=null?request.getParameter("gd_remindTitle").toString():"-1";

	com.whir.ezoffice.customdb.common.util.DbOpt dbopt = null;
 
	try{
		dbopt = new com.whir.ezoffice.customdb.common.util.DbOpt();
		createEmp = dbopt.executeQueryToStr("select emp_id from org_employee where useraccounts='"+gd_startUserCode+"' and userisdeleted=0 and userisactive=1");
		dbopt.close();
	}catch(Exception e){
	
	}finally{
		try{dbopt.close();}catch(Exception ee){}
	}

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
    java.util.Date gdDate = new java.util.Date();
    //new com.whir.ezoffice.archives.action.ArchivesAction().addArchivesWaitPigeonhole(p_submitPerson + " " + p_submitTime + " 的" + title,tmp,Long.valueOf(workId),"GZLC",session.getAttribute("userName").toString(), new java.util.Date(), returnValue, request,createEmp,createOrg, "");
    com.whir.ezoffice.dossier.bd.DossierBD gdBD = new com.whir.ezoffice.dossier.bd.DossierBD();
    //gdBD.gdDossier(workId,"EZFLOW",p_submitPerson + " " + p_submitTime + " 的" + title,null,null,null,session.getAttribute("orgName")+"",now.get(Calendar.YEAR)+"",null,null,"",null,createEmp,createOrg,sdf.format(gdDate),session.getAttribute("domainId").toString(),"htm",tmp,null,null,null);

	if(gd_type.equals("1")){//设置了归档路径
		if(!gd_path.equals("")){
			com.whir.ezoffice.dossier.po.DossierCategoryPO dossierCategoryPo =null;
			dossierCategoryPo = gdBD.loadDossierCategory(Long.valueOf(gd_path));
			String lookUserId =dossierCategoryPo.getLookUserId()==null?"":dossierCategoryPo.getLookUserId();
    		String lookUser   =dossierCategoryPo.getLookUser()==null?"":dossierCategoryPo.getLookUser();
				
			gdBD.gdDossierEzFlow(workId,"EZFLOW",gd_remindTitle,null,null,null,session.getAttribute("orgName")+"",now.get(Calendar.YEAR)+"",null,null,"",null,createEmp,createOrg,sdf.format(gdDate),session.getAttribute("domainId").toString(),"htm",tmp,null,null,null,gd_path,lookUserId,lookUser);
		}else{
			gdBD.gdDossier(workId,"EZFLOW",gd_remindTitle,null,null,null,session.getAttribute("orgName")+"",now.get(Calendar.YEAR)+"",null,null,"",null,createEmp,createOrg,sdf.format(gdDate),session.getAttribute("domainId").toString(),"htm",tmp,null,null,null);
		}
	}else{
		gdBD.gdDossier(workId,"EZFLOW",gd_remindTitle,null,null,null,session.getAttribute("orgName")+"",now.get(Calendar.YEAR)+"",null,null,"",null,createEmp,createOrg,sdf.format(gdDate),session.getAttribute("domainId").toString(),"htm",tmp,null,null,null);
	}

	java.io.File file = new java.io.File(fileName);
	if(!file.exists()){
		file.createNewFile();
	}
    /*java.io.PrintWriter pw = new java.io.PrintWriter(new java.io.FileOutputStream(file));
    pw.println("<html><head><title>流程归档</title></head>");
    pw.println("<body leftmargin=0 topmargin=0 onload=\"init();\">");
    pw.println(pageContent);
    pw.println("</body></html>");
    pw.close();*/

	
	java.io.OutputStream out2= new java.io.FileOutputStream(file);
    java.io.BufferedWriter rd = new java.io.BufferedWriter(new java.io.OutputStreamWriter(out2,"utf-8"));
	rd.write("<html><head><title>"+title+"</title><meta http-equiv='Content-Type' content='text/html; charset=UTF-8' /><script src='/defaultroot/scripts/jquery-1.11.2.min.js' type='text/javascript'></script><script src='/defaultroot/scripts/i18n/zh_cn/CommonResource.js' type='text/javascript'></script><link   href='/defaultroot/themes/2012/blue/style.css' rel='stylesheet' type='text/css'/><style type=\"text/css\">.doc_content{ padding:20px; line-height:100%; height:100%; overflow:visible;}</style><SCRIPT LANGUAGE=\"JavaScript\">var whirRootPath = \""+com.whir.component.config.PropertiesUtil.getInstance().getRootPath()+"\"; function  readyFun(){}       function initFormFunc(){} </SCRIPT></head>");

	/*rd.write("<html><head><title>"+title+"</title><meta http-equiv='Content-Type' content='text/html; charset=UTF-8' /><script src='/defaultroot/scripts/jquery-1.11.2.min.js' type='text/javascript'></script><script src='/defaultroot/scripts/i18n/zh_cn/CommonResource.js' type='text/javascript'></script><link   href='/defaultroot/themes/common/common.css' rel='stylesheet' type='text/css'/><link   href='/defaultroot/themes/2012/blue/style.css' rel='stylesheet' type='text/css'/><style type=\"text/css\">.doc_content{ padding:20px; line-height:100%; height:100%; overflow:visible;}</style><SCRIPT LANGUAGE=\"JavaScript\">function  readyFun(){} </SCRIPT></head>");*/
    rd.write("<body leftmargin=0 topmargin=0>");
	rd.write("<input type=\"hidden\" name=\"workflow_thisIsInGDpage\"  id=\"workflow_thisIsInGDpage\"  value=\"1\">");
    rd.write(pageContent);
	rd.flush();
    rd.close();
    out2.close();
	
	//ftp上传
	com.whir.org.common.util.SysSetupReader sss = new com.whir.org.common.util.SysSetupReader();
	java.util.Map sysMap = sss.getSysSetupMap(request.getSession(true).getAttribute("domainId").toString());
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
	<script language="javascript">
	    /*if(parent.opener.search){
			  parent.opener.search();
		  }else{
			  parent.opener.window.location.reload();
		 }*/
		//parent.opener.window.location.reload();
        parent.window.close();
     </script>
<%
}else{%>
<iframe id="gd" src="<%=request.getAttribute("myhref") + "&gd=1"%>"></iframe>
<script language="JavaScript">
<!--
	//document.all.gd.src=encodeURI("<%=request.getAttribute("myhref") + "&gd=1"%>");
//-->
</script>
<%}%>
</body>
</html>