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
<%if(!isForbiddenPad&&!isSurface){%>
<style>.ui_content.ui_state_full{ display:block;width:100%;height:100%;margin:0;padding:0!important; -webkit-overflow-scrolling: touch !important;overflow: scroll !important; }</style><%}%>
<script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>
<%if(whir_custom_str.indexOf("My97DatePicker")<0){%>	
<script src="<%=rootPath%>/scripts/plugins/My97DatePicker/WdatePicker.js"></script>
<%}%>
<%if(whir_custom_str.indexOf("powerFloat")<0){%>	
<script src="<%=rootPath%>/scripts/plugins/powerFloat/jquery-powerFloat.js" type="text/javascript"></script>
<link   href="<%=rootPath%>/scripts/plugins/powerFloat/powerFloat.css" rel="stylesheet" type="text/css"/>
<%}%>
<%if(whir_custom_str.indexOf("easyui")<0){%>	
<link   href="<%=rootPath%>/scripts/plugins/easyui/1.3.2/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
<link   href="<%=rootPath%>/scripts/plugins/easyui/1.3.2/themes/icon.css" rel="stylesheet" type="text/css"/>
<script src="<%=rootPath%>/scripts/plugins/easyui/1.3.2/jquery.easyui.min.js" type="text/javascript"></script>
<%}%>
<%if(whir_custom_str.indexOf("tagit")!=-1){%>
<link href="<%=rootPath%>/scripts/plugins/tagit/css/jquery-ui-simple.css" rel="stylesheet" type="text/css">
<link href="<%=rootPath%>/scripts/plugins/tagit/css/tagit-simple-grey.css" rel="stylesheet" type="text/css">
<script src="<%=rootPath%>/scripts/plugins/jquery_ui/jquery-ui.min.js"></script>
<script src="<%=rootPath%>/scripts/plugins/tagit/tagit.js"></script>
<script src="<%=rootPath%>/scripts/plugins/tagit/tagit.utils.js"></script>
<%}%>
<script type="text/javascript">
/********公共初始化操作**********************/
$(document).ready(function(){	
    setInputStyle();
    digitCheck();
    $("input[type='hidden'],select").each(function(){
        $(this).attr("defaultValue",$(this).val());
    });
    try{$(document.body).focus();}catch(e){}
});
</script>
<%if(whir_agent.indexOf("MSIE 7")>=0 || whir_agent.indexOf("MSIE 10")>=0 ){%>
	<style >
		body{position:relative;}
	</style>
<%}%>