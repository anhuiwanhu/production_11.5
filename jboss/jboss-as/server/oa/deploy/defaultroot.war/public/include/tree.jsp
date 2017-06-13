    <script type="text/javascript">
		var whirRootPath = "<%=rootPath%>";
		var preUrl = "<%=preUrl%>"; 
		var whir_browser = "<%=whir_browser%>"; 
	    var whir_agent = "<%=whir_agent%>"; 
	</script>
    <script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
    <link   href="<%=rootPath%>/themes/common/common.css" rel="stylesheet" type="text/css"/>
    <link   href="<%=rootPath%>/<%=whir_skin%>/style.css" rel="stylesheet" type="text/css"/>
    <link   href="<%=rootPath%>/scripts/plugins/zTree/css/<%=whir_skin.indexOf("2007")!=-1||whir_skin.indexOf("2009")!=-1||whir_skin.indexOf("2011")!=-1?"default":"2012"%>/zTreeStyle.css" rel="stylesheet" type="text/css"/>
    <!--link   href="<%=rootPath%>/scripts/plugins/zTree/css/2012/iconSkin.css" rel="stylesheet" type="text/css"/-->
    <script src="<%=rootPath%>/scripts/plugins/zTree/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/plugins/zTree/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/main/whir.menu.js" type="text/javascript"></script>
    <%if(isPad){%>
    <link   href="<%=rootPath%>/scripts/plugins/jscroll/jquery.jscrollpane.css"  type="text/css" rel="stylesheet" media="all" />    
    <script  src="<%=rootPath%>/scripts/plugins/jscroll/jquery.mousewheel.js" type="text/javascript"></script>
    <script  src="<%=rootPath%>/scripts/plugins/jscroll/jquery.jscrollpane.min.js" type="text/javascript"></script>
    <%}%>

    <SCRIPT LANGUAGE="JavaScript">
    <!--
    var whir_treeSetting = {  
        view: {  
            showLine: <%=whir_skin.indexOf("2012")!=-1||whir_skin.indexOf("metro")!=-1||whir_skin.indexOf("2013")!=-1?"false":"true"%>  
        },  
        data: {  
            simpleData: {  
                enable: true  
            }  
        }  
    };
    //-->
    </SCRIPT>
    <%if(!isSurface && (whir_agent.indexOf("msie")!=-1 && whir_agent.indexOf("touch")!=-1)){%>
    <script src="<%=rootPath%>/scripts/util/tree.js" type="text/javascript"></script>
    <%}%>