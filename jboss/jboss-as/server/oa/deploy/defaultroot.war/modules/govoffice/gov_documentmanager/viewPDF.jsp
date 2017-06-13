<%@ include file="/public/include/init.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String url = request.getParameter("url")==null?"":request.getParameter("url").trim();
%>
<html>
<head>
<title></title>
<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
</head>
<body bgcolor="#ffffff">
	<div id="panelFrame" align="center">
	<%
    
    String userAgent = request.getHeader("User-Agent");
    
		if( userAgent != null && userAgent.indexOf("IE") >= 0){
		
	%>
		<object classid="clsid:CA8A9780-280D-11CF-A24D-444553540000" width="100%" height="100%" border="0" id="pdfObj">
			<param name="_Version" value="65539">
			<param name="_ExtentX" value="20108">
			<param name="_ExtentY" value="10866">
			<param name="_StockProps" value="0">
			<param name="SRC" value="<%=url%>">
		</object>
	<%}else if(userAgent != null && userAgent.indexOf("Chrome") >= 0) {%>
		<object width="100%" height="100%" type="application/pdf" data="<%=url%>"></object>
	
		
	<%}else{%>
		<embed width="100%" height="100%" src="<%=url%>" type="application/pdf"></embed>

		<!--<object data="<%=url%>" type="application/pdf"></object>-->
	<%}%>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	if(!($.browser.msie)){
		//$("#panelFrame").html('<embed width="100%" height="600px" src="<%=url%>"></embed>');
	}
});
</script>
</html>
