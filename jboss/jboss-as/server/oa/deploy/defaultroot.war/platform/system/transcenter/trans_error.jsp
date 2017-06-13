<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  isErrorPage="true"%>
<%@ page import="java.util.*"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

String  rootPath=com.whir.component.config.PropertiesUtil.getInstance().getRootPath();
Random r=new Random();
int num=r.nextInt(100);//随机产生一个1到100的数；

String error_code = request.getParameter("error_code");
String error_info = "当前页面无法找到";
if(error_code.equals("noright")){
	error_info = "您无权限查看本模块信息！";
}else if(error_code.equals("nouser")){
	error_info = "您无权限查看本模块信息！";
}
if(application.getAttribute("errorNum") == null){
    application.setAttribute("errorNum", new Integer(1));
}else{
    application.setAttribute("errorNum", new Integer(2));
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>error</title>
<style type="text/css">
body{ background-color:#fff; font-size:12px; margin:0px; padding:0px;}
a{ color:#b0afaf; text-decoration:none; text-decoration:none;}
img{ border:0px;}
.box_550{ width:550px; margin:0px auto; padding-top:50px;}
.box_300{ width:300px; margin:0px auto; background:url(<%=rootPath%>/images/error_p1.gif) right top no-repeat; padding:74px 0px 0px 0px;} 
h1.title_01{ font-size:18px; margin:0px;  padding:0px 0px 5px 0px;}
.box300_cont {   min-height:50px;  height:auto !important; height:50px; }
.box300_cont .left{ float:left; padding-right:5px; font-size:12px; font-weight:bold; color:#333; line-height:20px;}
.box300_cont .right{ float:left;    font-size:12px; color:#ff9000; line-height:20px;}
.gray_box{ padding:6px 0px 6px 20px; line-height:24px; border:1px solid #e3e3e3; clear:both; color:#b0afaf;}
.clear_box{ clear:both; padding:5px 0px; margin:0px;}
.box_250{ background:url(<%=rootPath%>/images/err_p3.gif1) right top no-repeat; padding:96px 0px 0px 0px; width:250px; margin:0px auto;}
</style>

<script src="<%=rootPath%>/scripts/jquery-1.11.1.min.js" language="javascript"></script>
</head>

<body >
<div class="box_550">
	<div class="box_250">
		<h1 class="title_01"><%//=error_info%></h1>
	</div>

</div>

<script>
function setDisplay(obj,i){
	if(i==0){
		$(obj).hide();
		$(obj).next().show();
		$("#error_info").show();
	}else{
		$(obj).hide();
		$(obj).prev().show();
		$("#error_info").hide();
	}
}
</script>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
//<%=session.getId()%>-<%=session.getAttribute("errorNum")%>
<%
if(application.getAttribute("errorNum") != null){
    int errorNum = ((Integer)application.getAttribute("errorNum")).intValue();
    if(errorNum > 1){
        application.removeAttribute("errorNum");
%>
    alert('<%=error_info%>');
<%}}%>
//-->
</SCRIPT>