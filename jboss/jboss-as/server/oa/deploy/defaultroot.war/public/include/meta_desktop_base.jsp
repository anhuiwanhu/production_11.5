<link rel="stylesheet" href="<%=rootPath%>/template/css/template.bootstrap.min.css" /> 
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.reset.min.css" /> 
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.fa.min.css" />
<!--ztree 样式放在 media里了-->
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.media.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.style.min.css" />


<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.lists.css" />   
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.before.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.after.min.css" />  

<%
/*
 默认皮肤 不要  template.theme.pure.min.css 
 线性：  template.theme.line.min.css
 纯色：  template.theme.pure.min.css

 原来 template.keyframe. =whir_new_skin .css 动画颜色  template.color. =whir_new_skin .css  皮肤颜色。

*/
%>
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.<%=whir_2016_skin_style%>.min.css" />
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2016/template.theme.media.min.css" /> 
<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.style.size.min.css" />  
<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>  
<script type="text/javascript" src="<%=rootPath%>/scripts/static/template.custom.min.js"></script>
<script type="text/javascript" src="<%=rootPath%>/scripts/static/template.extend.min.js"></script>
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/zTree_v3/jquery.ztree.core-3.5.js"></script>
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
<script LANGUAGE="JavaScript" src="<%=rootPath%>/scripts/main/cookie.js"></script>
<script LANGUAGE="JavaScript" src="<%=rootPath%>/scripts/desktop/desktop_2016.js"></script> 
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/superslide/jquery.SuperSlide.2.1.1.js" ></script>   
<script type="text/javascript">  
  var setting = {
		view: {
			selectedMulti: false,
			dblClickExpand: false
		},
		check: {
			enable: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		edit: {
			enable: false
		},
		callback: {
		  onClick: onClick
		} 
	}; 
	function onClick(e,treeId, treeNode) {
		 var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		 zTree.expandNode(treeNode);
    };  
</script>
<script type="text/javascript">
<!--
	var g_whir_skin = "<%=whir_skin%>";
//-->
</script>
 