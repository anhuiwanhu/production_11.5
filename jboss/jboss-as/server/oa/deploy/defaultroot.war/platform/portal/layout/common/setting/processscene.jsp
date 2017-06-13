<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%
ConfMap confMap = (ConfMap)request.getAttribute("confMap");
String portletSettingId = request.getParameter("portletSettingId");
//流程分类选择
String processType = confMap.get("processType");
processType = (processType!=null && !"".equals(processType) && !"null".equals(processType)) ? processType : "1";
//流程场景风格类型
String sceneType = confMap.get("sceneType");
sceneType = (sceneType!=null && !"".equals(sceneType) && !"null".equals(sceneType)) ? sceneType : "1";
String portletImgName = confMap.get("portletImgName");
String portletImgSaveName = confMap.get("portletImgSaveName");
%>
<tr>
    <td style="margin-top:50px"><em></em></td>
    <td style="margin-top:50px">
		<div class="wh-choose-info-title"><input type="radio" name="processType" value="1" <%="1".equals(processType)?"checked":""%>>选择流程分类<input type="radio" name="processType" value="2" <%="2".equals(processType)?"checked":""%>>选择流程</div>
	</td>
	<td style="margin-top:50px">
        <div id="select-process1" class="wh-choose-info-column clearfix">
          <a href="javascript:void(0)" class="wh-choose-info-btn" onclick='javascript:openWin({url:"<%=request.getContextPath()%>/PortletData!allBmp2.action",winName:"allMyColumn",width:850,height:650});' >选择流程分类</a>
        </div>
    </td>
	<td style="margin-top:50px">
        <div id="select-process2" class="wh-choose-info-column clearfix">
          <a href="javascript:void(0)" class="wh-choose-info-btn" onclick='javascript:openWin({url:"<%=request.getContextPath()%>/PortletData!allProcess.action?moduleId=1&iswhirchoosed=1&sceneFlag=1",winName:"allMyColumn",width:850,height:650});' >选择流程</a>
        </div>
    </td>
	
</tr>
<tr>
	<td>
	</td>
	<td colspan="3">
		<div id="columnDiv1">
			<%
			String packageName = confMap.get("packageName");
			String wfPackageId = confMap.get("wfPackageId");
			if(wfPackageId!=null&&!"".equals(wfPackageId)&&!"null".equals(wfPackageId)){
				String[] wfPackageIdArr = wfPackageId.split(",");
				String[] packageNameArr = packageName.split(",");
				for(int i0=0; i0<wfPackageIdArr.length; i0++){
			%>
				<div class="wh-choose-info-box" id="protype<%=wfPackageIdArr[i0]%>">
					<input type="hidden" id="wfPackageId" name="wfPackageId" value="<%=wfPackageIdArr[i0]%>">
					<input type="hidden" id="packageName" name="packageName" value="<%=packageNameArr[i0]%>">
					<i class="fa fa-times fa-color" onClick="javascript:$(this).parent().remove();"></i><span><%=packageNameArr[i0]%></span>
				</div>
			<%}}%>
		</div>
		<div id="columnDiv2">
			<%
			String packageName2 = confMap.get("packageName2");
			String wfPackageId2 = confMap.get("wfPackageId2");
			if(wfPackageId2!=null&&!"".equals(wfPackageId2)&&!"null".equals(wfPackageId2)){
				String[] wfPackageIdArr2 = wfPackageId2.split(",");
				String[] packageNameArr2 = packageName2.split(",");
				for(int i0=0; i0<wfPackageIdArr2.length; i0++){
			%>
				<div class="wh-choose-info-box" id="workflow-<%=wfPackageIdArr2[i0]%>">
					<input type="hidden" id="wfPackageId2" name="wfPackageId2" value="<%=wfPackageIdArr2[i0]%>">
					<input type="hidden" id="packageName2" name="packageName2" value="<%=packageNameArr2[i0]%>">
					<i class="fa fa-times fa-color" onClick="javascript:$(this).parent().remove();"></i><span><%=packageNameArr2[i0]%></span>
				</div>
			<%}}%>
		</div>
	</td>
</tr>
<tr>
    <th><em>显示布局：</em></th>
    <td colspan="3">
        <div class="wh-choose-info-type">
            <ul class="clearfix">
                <li class="wh-choose-info21">
                    <div class="wh-choose-info-title"><input type="radio" name="sceneType" value="1" <%="1".equals(sceneType)?"checked":""%>>风格1</div>
                </li>
                <li class="wh-choose-info22">
                    <div class="wh-choose-info-title"><input type="radio" name="sceneType" value="2" <%="2".equals(sceneType)?"checked":""%>>风格2</div>
                </li>
            </ul>
        </div>
    </td>
</tr>
<tr>
    <th><em>场景名称：</em></th>
    <td colspan="3">
		<div class="wh-choose-input">
		<input type="text" id="sceneName" class="wh-choose-input-wid" name="sceneName" value='<%=confMap.get("sceneName")!=null ?confMap.get("sceneName")+"":""%>'></input>
		</div>
	</td>
</tr>
<tr>
	<th><em>上传图片：</em></th>
    <td colspan="2">
        <input type="hidden" name="portletImgName" value="<%=portletImgName%>" id="portletImgName"/>
        <input type="hidden" name="portletImgSaveName" value="<%=portletImgSaveName%>" id="portletImgSaveName"/>
        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
            <jsp:param name="isShowBatchDownButton" value="no" />
            <jsp:param name="accessType" value="include" />
            <jsp:param name="makeYMdir" value="yes" />
            <jsp:param name="dir" value="portal" />
            <jsp:param name="uniqueId" value="uniqueId_portlet" />
            <jsp:param name="realFileNameInputId" value="portletImgName" />
            <jsp:param name="saveFileNameInputId" value="portletImgSaveName" />
            <jsp:param name="canModify" value="yes" />
            <jsp:param name="width" value="90" />
            <jsp:param name="height" value="20" />
            <jsp:param name="multi" value="false" />
            <jsp:param name="buttonClass" value="upload_btn" />
            <jsp:param name="buttonText" value="上传图片" />
            <jsp:param name="fileSizeLimit" value="5MB" />
            <jsp:param name="fileTypeExts" value="*.jpg;*.jpeg;*.gif;*.png;" />
            <jsp:param name="uploadLimit" value="1" />
            <jsp:param name="portletSettingId" value="<%=portletSettingId%>" />
            <jsp:param name="buttonDesc" value="支持图片格式：.jpg,.jpeg,.gif,.png" />
        </jsp:include>
    </td>
</tr>
<script>
$(function() {
    var type_value = $("input[name=processType]:checked").val(); 
	if(type_value == '1'){
		$('#select-process1').show();
		$('#select-process2').hide();
	}else{
		$('#select-process1').hide();
		$('#select-process2').show();
	}
});
$(document).ready(function() { 
	$("input[name=processType]").change(function() { 
		var type_value = $("input[name=processType]:checked").val(); 
		if(type_value == '1'){
			$('#select-process1').show();
			$('#select-process2').hide();
		}else{
			$('#select-process1').hide();
			$('#select-process2').show();
		}
		$('#columnDiv1').html('');
		$('#columnDiv2').html('');
	});
});
</script>