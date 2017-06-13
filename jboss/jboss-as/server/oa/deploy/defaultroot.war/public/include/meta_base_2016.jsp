<%--whir_custom_str_new="frame,portal,detail,lists"--%>

<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>"; 
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(whir_agent)%>"; 
	var whir_locale = "<%=whir_locale.toLowerCase()%>"; 
</script>

<%if(whir_custom_str_new.indexOf("frame")==-1 && whir_custom_str_new.indexOf("portal")==-1){%>
<link rel="stylesheet" href="<%=rootPath%>/template/css/template.bootstrap.min.css" /><%--除了门户、portel、知道等等 其他页面必用--%>
<%}%>

<link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.reset.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.fa.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.media.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.media.min.css" />

<%if(whir_custom_str_new.indexOf("detail")>-1){%>
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.detail.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.detail.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.detail.size.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.print.min.css" />
<%} else if(whir_custom_str_new.indexOf("frame")>-1){%>
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.style.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.style.size.min.css" />
<%} else if(whir_custom_str_new.indexOf("portal")>-1){%>
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.portal.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.portal.size.min.css" />
<%} else if(whir_custom_str_new.indexOf("lists")>-1){%>
<%}%>

<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>


<%if(whir_custom_str_new.indexOf("frame")==-1 && whir_custom_str_new.indexOf("portal")==-1){%>
<script type="text/javascript" src="<%=rootPath%>/scripts/static/template.min.js"></script>
<script type="text/javascript" src="<%=rootPath%>/scripts/static/template.extend.min.js"></script>
<script type="text/javascript" src="<%=rootPath%>/scripts/static/template.custom.min.js"></script>
<%}%>