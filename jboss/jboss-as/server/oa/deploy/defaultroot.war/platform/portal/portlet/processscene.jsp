<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>

<%
response.setContentType("text/html; charset=UTF-8");
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
String portletSettingId = request.getParameter("portletSettingId");
PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
//流程分类选择
String processType = confMap.get("processType");
processType = (processType!=null && !"".equals(processType) && !"null".equals(processType)) ? processType : "1";
//流程场景风格类型
String sceneType = confMap.get("sceneType");
sceneType = (sceneType!=null && !"".equals(sceneType) && !"null".equals(sceneType)) ? sceneType : "1";
//获取图片信息
String portletImgName = confMap.get("portletImgName");
String portletImgSaveName = confMap.get("portletImgSaveName");
String picName = "";
String picSrc = "";
if(portletImgSaveName!=null && !"".equals(portletImgSaveName) && !"null".equals(portletImgSaveName)){
	PortalLayoutBD bd = new PortalLayoutBD();
	List picList = bd.getPortalPortletFileList(portletSettingId);
	if(picList!=null && picList.size() > 0){
		for(int j=0; j<picList.size(); j++){
			PortalPortletFilePO fpo = (PortalPortletFilePO) picList.get(j);
			if(portletImgSaveName.equals(fpo.getSavename())){
				picName = fpo.getSavename();
				if(picName!=null && picName.length() > 6){
					picSrc = fileServer + "/upload/portal/" + picName.substring(0,6) + "/" + picName;
				}
				break;
			}
		}
	}
}

//获取场景名称
String sceneName = confMap.get("sceneName");
sceneName = (sceneName!=null && !"".equals(sceneName) && !"null".equals(sceneName)) ? sceneName : "流程";

Map itemMap = (Map) request.getAttribute("itemMap");
if(itemMap != null){
%>
<div class="wh-portal-i-content">
    <div id="proScene-<%=portletSettingId%>" class="process-list">
        <%if("2".equals(sceneType)){%>
		<div class="listbox">
            <ul class="clearfix">
                <%
				Iterator entries = itemMap.entrySet().iterator();
				while (entries.hasNext()) {
					Map.Entry entry = (Map.Entry) entries.next();
					String wfId = (String) entry.getKey();
					String wfName = (String) entry.getValue();
				%>
				<li><a href="javascript:void(0);" onclick="startProcess('<%=wfId%>');"><%=wfName%></a></li>
				<%}%>
            </ul>
        </div>
		<%}%>
		<div class="imgbox" id="sceneImg-<%=portletSettingId%>">
            <a href="javascript:void(0);">
                <img src="<%=picSrc%>" alt="<%=picName%>">
                <p><%=sceneName%></p>
            </a>
        </div>
        <%if("1".equals(sceneType)){%>
		<div class="listbox">
            <ul class="clearfix">
                <%
				Iterator entries = itemMap.entrySet().iterator();
				while (entries.hasNext()) {
					Map.Entry entry = (Map.Entry) entries.next();
					String wfId = (String) entry.getKey();
					String wfName = (String) entry.getValue();
				%>
				<li><a href="javascript:void(0);" onclick="startProcess('<%=wfId%>');"><%=wfName%></a></li>
				<%}%>
            </ul>
        </div>
		<%}%>
    </div>
</div>
<%}%>
<script language="JavaScript">
function startProcess(pool_processId){ 
    var url = whirRootPath+"/bpmstart!start.action?p_wf_pool_processId="+pool_processId;
	openWin({url:url,isFull:true});
}

/*$(document).bind('click',function(){
    $("#proScene-<%=portletSettingId%>").removeClass("open");
});
$('#sceneImg-<%=portletSettingId%>').bind('click',function(event){
	$("#proScene-<%=portletSettingId%>").addClass("open");
    stopPropagation(event);//调用停止冒泡方法,阻止document方法的执行
});*/

$(document).bind('click',function(e){
    var e = e || window.event; //浏览器兼容性
    var elem = e.target || e.srcElement;
    while (elem) { //循环判断至跟节点，防止点击的是dom子元素
      if (elem.id && elem.id=='sceneImg-<%=portletSettingId%>') {
        $("#proScene-<%=portletSettingId%>").addClass("open");
		return;
      }
      elem = elem.parentNode;
    }
    $("#proScene-<%=portletSettingId%>").removeClass("open"); //点击的不是dom或其子元素
});

function stopPropagation(e) {
	if(e.stopPropagation){
		e.stopPropagation();//停止冒泡  非ie
	}else{
		e.cancelBubble = true;//停止冒泡 ie
	}
}
</script>

