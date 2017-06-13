<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.whir.ezoffice.information.infomanager.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.PortletBD"%>
<%@ page import="com.whir.common.util.CommonUtils"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%
boolean _outter_ = "1".equals(request.getParameter("outter"));
String portletSettingId = request.getParameter("id");
//栏目ID
String channelId = request.getParameter("channelId");
//栏目名称
String userChannelName= request.getParameter("userChannelName");
//显示数目
int num = Integer.parseInt(request.getParameter("num"));

String windowHeight = request.getParameter("windowHeight");
int _windowHeight = 260;
try{
    _windowHeight = Integer.parseInt(windowHeight);
    _windowHeight -= 10;
}catch(Exception e){
}
PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
int limitNum = Integer.parseInt(confMap.get("limitNum")!=null&&!"".equals(confMap.get("limitNum")) ? confMap.get("limitNum") : "20");
String domainId = CommonUtils.getSessionDomainId(request).toString();
String userId = session.getAttribute("userId") == null ? "-1" : session.getAttribute("userId").toString();
String orgId = session.getAttribute("orgId")!=null?session.getAttribute("orgId").toString():"-1";
String orgIdString = session.getAttribute("orgIdString")!=null?session.getAttribute("orgIdString").toString():"$-1$";

String files = "";
String texts = "";
String links = "";

int smartInUse = 0;
if(sysMap != null && sysMap.get("附件上传") != null){
    smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());

List listInfo = pbd.listInformation(channelId, userId, orgId, orgIdString, domainId,limitNum);
String imageName = "-1"; //图片新闻图片名称,初始值为-1
String imageNewsTitle = "-1"; //图片新闻标题,初始值为-1
String imageNewsTitleLink = "-1"; //图片新闻标题链接,初始值为-1
int c = 0;
for (int i = 0; i < listInfo.size(); i++) {
	//设置图片显示数目
	if(c>=num){
		break;
	}

	Object[] obj = (Object[]) listInfo.get(i);
	int channelType = ((Integer) obj[7]).intValue();

	//图片新闻
	String informationId = obj[1].toString();
	InformationAccessoryBD accBD = new InformationAccessoryBD();
	List listAcc = accBD.getAccessory(informationId);
	for (int k = 0; k < listAcc.size(); k++,c++) {	
		Object[] objAcc = (Object[]) listAcc.get(k);
		if (((Integer) objAcc[4]).intValue() == 1) {
			//设置图片显示数目
			if(c>num){
				break;
			}

			imageName = objAcc[2].toString(); //标记已找到图片,标记为附件名称
			String datePath = imageName.substring(0,6);
			String subFolder = "";
			if(smartInUse==0){
				com.whir.common.util.UploadFile upFile = new com.whir.common.util.UploadFile();
				subFolder = upFile.getSubFolder(imageName);
				if(subFolder.length()>0){
					subFolder += "/";
				}
			}
			imageName=(smartInUse==1?rootPath+"/upload/information/"+datePath+"/"+imageName:fileServer+"/upload/information/"+subFolder+imageName);
			//
			imageNewsTitle = obj[2].toString(); //标题
			imageNewsTitleLink =
					rootPath+"/Information!view.action?" +
					"informationId=" + obj[1] +
					"&userDefine=" + obj[11] + "&informationType=" +
					obj[6] + "&channelId=" + channelId + 
					"&channelType=" + channelType +
					"&userChannelName=" +
					"信息管理";
            if(_outter_){
                imageNewsTitleLink = rootPath+"/PortalInformation!getInformation.action?title="+imageNewsTitle+"&id="+obj[1];
            }

			files = files + imageName+"|";
			texts = texts + imageNewsTitle+"|";
			links = links + imageNewsTitleLink+"|";
		}
	}
}
if(files.equals("")){
	files = rootPath+"/images/nophoto.gif";
	texts = "暂无图片";
	links = "";
}else if(files.endsWith("|")){
	files = files.substring(0,files.length()-1);
	texts = texts.substring(0,texts.length()-1);
	links = links.substring(0,links.length()-1);
	//links = links.replaceAll("&","%26");
}
%>
<HEAD>
<TITLE>图片页签显示</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>";
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=whir_agent%>"; 
</script>
<script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<!--script language="javascript" src="script/Picflash.js"></script-->
<script type="text/javascript" src="<%=rootPath%>/platform/portal/js/jquery.slideshow.lite-0.5.3.js"></script>
<style type="text/css" media="screen">
.slideshowlite {
	position: relative;
	border: 0px solid #111;
	overflow: hidden;
}
.slideshowlite a {
    position: absolute;
    z-index: 1;
    width: 100%;
    height: 100%;
    text-align: center;
}
.slideshowlite img {
    border: none;
}
/* pagination control */
.slideshowlite ul,
.slideshowlite ol {
	list-style: none;
	position: absolute;
	margin: 0;
	padding: 0;
	bottom: 5px;
	right: 5px;
	z-index: 3;
}
.slideshowlite ul li,
.slideshowlite ol li {
    float: left;
    margin: 0 3px;
    width: 16px;
}
.slideshowlite ul li a {
    position: relative;
    display: block;
    width: 100%;
    height: 14px;
    padding-top: 0px;
    padding-bottom: 4px;
    padding-left: 2px;
    padding-right: 2px;
    text-decoration: none;
    color: #666;
    background: #eee;
    border: 1px solid #666;
    text-align: center;
    font-size: 11px;
}
.slideshowlite ul li a.current {
    color: #111;
    font-weight: bold;
    border: 1px solid #438ccb;
    background: #fff799;
}
.slideshowlite ul li a:hover {
    color: #fff;
    background: #333;
}	
/* caption control */
.slideshowlite ol {
	top: 5px;
	position: relative;
	overflow: hidden;
	width: 100%;
	font-size: 14px;
	color: #fff;
	background: #000;
	padding: 3px 10px;
}
.slideshowlite ol li {
    width: 100%;
}
#slideshow ul { right: 5px; }
</style>
</HEAD>
<BODY onload="init();">
<table width="100%"  border="0" cellpadding="0" cellspacing="1" height="<%=_windowHeight%>" id='<%=portletSettingId%>'>
    <tr>
        <td valign="top" align="center" bgcolor="#FFFFFF">
			<div class="PicFlash">
				<div id="focus">
					<div id="slideshow" style="padding-right:10px">
					<%
					String[] fileArray = files.split("\\|");
					String[] textArray = texts.split("\\|");
					String[] linkArray = links.split("\\|");
					for(int i=0;i<fileArray.length;i++){
					%>
                            <!--div class="titlebg"></div>
                            <div class="titlefont"><%=textArray[i]%></div-->
                            <img name="image" style="cursor:pointer;" src="<%=fileArray[i]%>" onclick="openWin({url:'<%=linkArray[i]%>',winName:'info',isFull:true});" alt="<%=textArray[i]%>" height="<%=_windowHeight%>" width="100%"/>
                        
					<%}%>
					</div>
				</div>
			</div>
		</td>
    </tr>
</table>
</BODY>
</HTML>
<script language="JavaScript">
var divWidth = $("#slideshow").width();
var divHeight = $("#slideshow").height();
var e = new Image();
$("img[name='image']").each(function(){
    e.src = $(this).attr("src");
    if(e.width<divWidth){
        $(this).attr("width", e.width);
    }
    if(e.height>divHeight){
        $(this).attr("height", divHeight);
    }
});

var _bodyWidth = 0;
var _bodyHeight = 0;
function init() {
    _bodyWidth = document.body.clientWidth;
    if(parent) {
        if(parent.document.getElementById("ifm_<%=portletSettingId%>")) {
            parent.document.getElementById("ifm_<%=portletSettingId%>").height = <%=_windowHeight%>;//document.getElementById("<%=portletSettingId%>").clientHeight;
        }
    }

    $("#slideshow").slideshow({
        pauseSeconds: 3,
        width: '100%',
        height: <%=_windowHeight%>-10,
        caption: true
    });
}
</script>