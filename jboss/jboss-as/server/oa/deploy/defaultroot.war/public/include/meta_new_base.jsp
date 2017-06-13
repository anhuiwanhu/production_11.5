<link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.reset.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.fa.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.portal.min.css" />
 
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.portal.size.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.before.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.after.min.css" />
<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.ztree.css" type="text/css"> 
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/zTree_v3/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/zTree_v3/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/zTree_v3/jquery.ztree.exedit-3.5.js"></script> 
<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>"; 
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(whir_agent)%>"; 
	var whir_locale = "<%=whir_locale.toLowerCase()%>"; 
</script> 
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>  
<SCRIPT LANGUAGE="JavaScript" src="<%=rootPath%>/scripts/main/cookie.js"></SCRIPT> 
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/superslide/jquery.SuperSlide.2.1.1.js" ></script>   
<script type="text/javascript">
<!--
	var g_whir_skin = "<%=whir_skin%>";
//-->
</script>
<%if(isPad){%>
<link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.ios.css" />
<%}%>
<!--[if lt IE 9]>
<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.portal.ie8.css" />
<![endif]-->