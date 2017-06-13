<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>"; 
    var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=whir_agent%>"; 
    var whir_locale = "<%=whir_locale.toLowerCase()%>"; 
</script>

<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<link   href="<%=rootPath%>/themes/common/common.css" rel="stylesheet" type="text/css"/>
<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>

<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>

<script src="<%=rootPath%>/scripts/plugins/My97DatePicker/WdatePicker.js"></script>

<script src="<%=rootPath%>/scripts/plugins/powerFloat/jquery-powerFloat.js" type="text/javascript"></script>
<link   href="<%=rootPath%>/scripts/plugins/powerFloat/powerFloat.css" rel="stylesheet" type="text/css"/>

<link   href="<%=rootPath%>/scripts/plugins/easyui/1.3.2/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
<link   href="<%=rootPath%>/scripts/plugins/easyui/1.3.2/themes/icon.css" rel="stylesheet" type="text/css"/>
<script src="<%=rootPath%>/scripts/plugins/easyui/1.3.2/jquery.easyui.min.js" type="text/javascript"></script>

<!--[if IE 6]>
<script type="text/javascript" src="<%=rootPath%>/scripts/desktop/iepng.js"></script>
<script type="text/javascript"> 
EvPNG.fix('img,.scrollArrowLeft,.scrollArrowLeftDisabled,.scrollArrowRight,.scrollArrowRightDisabled,.face_box,.top_boxbg,.bg_01,.bg_02,.topread_box,.skin_btn,.f_person,.hint_area,.facebg,.logo_img,.bg_png,.main_box,.bg_png');
</script>
<![endif]-->

<script type="text/javascript">
	/********公共初始化操作**********************/
	$(document).ready(function(){			
		setInputStyle();
		digitCheck();
		$("input[type='hidden'],select").each(function(){
			$(this).attr("defaultValue",$(this).val());
		});

		 
	});
</script>