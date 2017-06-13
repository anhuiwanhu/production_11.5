<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%
/*response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);*/
String localeCode=request.getParameter("localeCode");
if(localeCode==null){
   localeCode="zh_cn";
   Cookie[] cookies = request.getCookies();
   if(cookies!=null){
      for (int i = 0; i < cookies.length; i++){
          Cookie c = cookies[i];

          if(c.getName().equalsIgnoreCase("LocLan")){
              localeCode= c.getValue();
          }
       }
   }
}

//以下语句防止日文系统ja或者zh_CN
localeCode = com.whir.component.util.LocaleUtils.getLocale(localeCode);

String skin = request.getParameter("skin")!=null?request.getParameter("skin"):"";
String domainId = "0";//session.getAttribute("domainId").toString()

PortalLayoutBD bd = new PortalLayoutBD();
String[][] layoutPO = null;

String title = "";//标题
if("1".equals(request.getAttribute("preview"))){//预览用
    layoutPO = bd.loadLayout(request.getParameter("layoutId"));
    //title = "预览-";
}else{//登录前用
    layoutPO = bd.getEnabledPortalLayout(domainId);
}

if(layoutPO==null||layoutPO.length<1){//登录页
    response.sendRedirect(rootPath+"/portal.jsp");
}else{
    title += layoutPO[0][1];
    String layoutId = layoutPO[0][0];
    String templateId = layoutPO[0][4];
	String themeId = layoutPO[0][9]!=null&&!layoutPO[0][9].equals("")?layoutPO[0][9]:"0";
	String headerId = layoutPO[0][2];
    String footerId = layoutPO[0][3];

	PortalBD portalBD = new PortalBD();
	if(!skin.equals("")){//切换主题时
		themeId = portalBD.getThemeIdBySkin(skin);
	}
	
	if(themeId!=null && !"0".equals(themeId)){
		String hfId = portalBD.getHeaderFooterByThemeId(themeId);
		headerId = hfId.substring(0,hfId.indexOf(","));
		footerId = hfId.substring(hfId.indexOf(",")+1);
	}
	//20160428 -by jqq 安全性漏洞改造
	headerId = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(headerId);
	footerId = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(footerId);

    PortalTemplatePO templatePO = new PortalTemplateBD().load(new Long(templateId));

    String solutionId = layoutPO[0][7]!=null?layoutPO[0][7]:"";

    String screenWidth = layoutPO[0][5];
    String w1 = "";
    String w2 = "";
    if(screenWidth!=null){
        if(!"-1".equals(screenWidth)){
            try{
                w1 = screenWidth + "px";
                w2 = (Integer.parseInt(screenWidth) - 8) + "px";//23
            }catch(Exception e){
                w1 = "";
                w2 = "";
            }
        }
    }
	if(skin.equals("")){//默认主题
		PortalThemePO theme = portalBD.loadPortalThemePO(Long.valueOf(themeId));
		if(theme!=null){
			skin = "themes/login/"+theme.getSkinDir();
		}else{
			skin = "themes/login/blue";
		}
	}else{
		skin = "themes/login/"+skin;
	}

	String allSkinDir = portalBD.getAllThemeSkin();
%>
<html>
<head>
<title><%=title%></title>
<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>";
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=whir_agent%>"; 
	var g_whir_skin = "<%=whir_skin%>";
</script>

<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<link   href="<%=rootPath%>/themes/common/desktop.css" rel="stylesheet" type="text/css"/>
<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>

<link   href="<%=rootPath%>/<%=skin%>/portal/main.css" rel="stylesheet" type="text/css"/>
<link   href="<%=rootPath%>/scripts/plugins/uniform/themes/default/css/uniform.default.css" rel="stylesheet" type="text/css"/>
<script src="<%=rootPath%>/scripts/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.openselect.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.tab.js" type="text/javascript"></script>
<%if(whir_agent.indexOf("MSIE 7")>=0 || whir_agent.indexOf("MSIE 10")>=0 ){%>
	<style >
		body{position:relative;}
	</style>
<%} %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=rootPath%>/themes/login/style.css" rel="stylesheet" type="text/css" />

<SCRIPT LANGUAGE="JavaScript" src="<%=rootPath%>/scripts/desktop/desktop.js"></SCRIPT>

<script language="JavaScript">
<!--
var _def_isDesignPage_ = false;
var _def_isPortalPage_ = true;
//-->
</script>

<script language="JavaScript">
<!--
function reSetIframe() {
    var iframe = document.getElementById("MainDesktop");
    try {
        gg();
        var bHeight = iframe.contentWindow.document.body.scrollHeight;
        var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
        var height = Math.max(bHeight, dHeight);
        iframe.height = height;
    } catch (ex) { }
}

function gg() {
    var iframe = document.getElementById("MainDesktop");//注意这里的ID为menu_products_new，跟iframe的ID要对应
    iframe.height =600;//100;
 
}
//-->
</script>
</head>
<body class="MainFrameBox">
<div align="center">
    <div style="width:<%=w1%>;height:100%;">
        <div style="width:<%=w2%>;" align="left">
            <jsp:include page="top.jsp" flush="true">
                <jsp:param name="id" value="<%=headerId%>"/>
				<jsp:param name="skins" value="<%=allSkinDir%>"/>
				<jsp:param name="skin" value="<%=skin%>"/>
            </jsp:include>
        </div>
        
        <div style="background:;width:<%=w2%>;padding:0px 0 3px 0;" align="left">
            <jsp:include page="menu.jsp" flush="true">
                <jsp:param name="preview" value="1"/>
                <jsp:param name="layoutId" value="<%=layoutId%>"/>
                <jsp:param name="solutionId" value="<%=solutionId%>"/>
                <jsp:param name="skin" value="<%=skin%>"/>
            </jsp:include>
        </div>
        
        <div id="mainLayout" style="width:<%=w2%>;">
            <%
                String _self = request.getParameter("_self");
                String id = EncryptUtil.htmlcode(request.getParameter("id"));
                if("true".equals(_self)){//当前窗口
                    PortalMenuPO mpo = new PortalBD().loadMenu(new Long(id));
                    String _href = "javascript:void(0);";
                    String mid = mpo.getId()+"";
                    String linkUrl = mpo.getLinkUrl();
                    String menuType = mpo.getMenuType();
                    String menuId = mpo.getMenuId()+"";
                    String firstUrl = "about:blank";
                    if(linkUrl!=null){
                        if(!linkUrl.trim().startsWith("http://")){
                            _href = "http://" + linkUrl.trim();
                        }else{
                            _href = linkUrl.trim();
                        }
                    }

                    if("3".equals(menuType)){
                        _href = rootPath + "/PortalInformation!informationList.action?channelId="+menuId+"&mid="+mid;
                    }else if("4".equals(menuType)){
                        _href = rootPath + "/PortletForumAction!forumTopicList.action?forumClassId="+menuId+"&mid="+mid;
                    }

                    if(firstUrl.equals("about:blank")&&!_href.equals("javascript:void(0);"))firstUrl=_href;
                    
            %>
            <iframe id="MainDesktop" name="MainDesktop" src="<%=firstUrl%>" frameborder="0" border="0" width="100%" height="100%" scrolling="no" onload="reSetIframe()"></iframe>
            <%}else{%>
            <iframe id="MainDesktop" name="MainDesktop" src="<%=rootPath%>/Portal!main_pageleft.action?id=<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(id)%>&skin=<%=skin%>" frameborder="0" border="0" width="100%" height="100%" scrolling="no" onload="reSetIframe()"></iframe>
            <%}%>
        </div>

        <div style="width:<%=w2%>;" align="left">
            <jsp:include page="bottom.jsp" flush="true">
                <jsp:param name="id" value="<%=footerId%>"/>
            </jsp:include>
        </div>
    </div>
</div>
</body>
</html>
<script language="JavaScript">
function changeTheme(skin){
	location_href('<%=rootPath%>/portal.jsp?skin='+skin);
}
</script>
<%}%>