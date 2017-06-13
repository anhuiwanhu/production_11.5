<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>";
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=whir_agent%>";
    var whir_skin = "<%=whir_skin%>";
</script>

<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<link   href="<%=rootPath%>/themes/common/desktop.css" rel="stylesheet" type="text/css"/>
<link   href="<%=rootPath%>/<%=whir_skin%>/style.css" rel="stylesheet" type="text/css"/>
<%if(whir_custom_str.indexOf("lhgdialog")<0){%>
<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>
<%}%>
<link   href="<%=rootPath%>/<%=whir_skin%>/portal/main.css" rel="stylesheet" type="text/css"/>
<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>
<%if(whir_agent.indexOf("MSIE 7")>=0 || whir_agent.indexOf("MSIE 10")>=0 ){%>
	<style >
		body{position:relative;}
	</style>
<%} %>