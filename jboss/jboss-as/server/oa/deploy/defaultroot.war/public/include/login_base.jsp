<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>"; 
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(whir_agent)%>"; 
	var whir_locale = "<%=whir_locale.toLowerCase()%>"; 
</script>

<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<link   href="<%=rootPath%>/themes/common/common.css" rel="stylesheet" type="text/css"/>
<link   href="<%=rootPath%>/<%=whir_skin%>/style.css" rel="stylesheet" type="text/css"/>

<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>

<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>
<!--[if IE 6]>
<script src="<%=rootPath%>/scripts/desktop/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
EvPNG.fix('img,.scrollArrowLeft,.scrollArrowLeftDisabled,.scrollArrowRight,.scrollArrowRightDisabled,.face_box,.top_boxbg,.bg_01,.bg_02,.topread_box,.skin_btn,.f_person,.hint_area,.facebg,.logo_img,.bg_png,.main_box,.bg_png');
</script>
<![endif]-->
<script type="text/javascript">
/********公共初始化操作**********************/
</script>

<%if(whir_agent.indexOf("MSIE 7")>=0 || whir_agent.indexOf("MSIE 10")>=0 ){%>
	<style >
		body{position:relative;}
	</style>
<%}%>