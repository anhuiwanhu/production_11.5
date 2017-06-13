<style type="text/css">
.imgPhoto{
    margin-top:-25px;padding-top:3px;float:right;height:19px;width:94px;background:#fff;border:1px solid #808080;text-align:center;cursor:pointer;
}
.sync{
    margin: 5px 5px 5px 0;
}
</style>
<!--[if IE 6]>
<style type="text/css">
.imgPhoto{margin-top:-20px;}
</style>
<![endif]-->
<%
String logoFileName="",logoSaveFileName="";
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
int smartInUse = 0;
if(sysMap != null && sysMap.get("附件上传") != null){
	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}
String path = smartInUse == 1 ? rootPath : fileServer;
String src = path + "/upload/desktop/";

logoFileName="desktop.png";
logoSaveFileName="desktop.png";

String logoSaveFileName_ = request.getAttribute("logoSaveFileName")!=null?request.getAttribute("logoSaveFileName")+"":"";
if(!"".equals(logoSaveFileName_) && !"null".equals(logoSaveFileName_)){
    src += logoSaveFileName_;
}else{
    src = path + "/images/blank.gif";
}
%>
<s:hidden name="org.orgId" id="orgId"/>
<s:hidden name="hasChanged" id="hasChanged"/>
<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
    <tr>
        <td for="组织名称" width="100" class="td_lefttitle">组织名称<span class="MustFillColor">*</span>：</td>
        <td><s:textfield name="org.orgName" id="orgName" cssClass="inputText" whir-options="vtype:['notempty','spechar3']" cssStyle="width:96%;" maxlength="40"/>
        </td>
    </tr>
    <tr>
        <td for="组织简称" class="td_lefttitle">组织简称<span class="MustFillColor">*</span>：</td>
        <td><s:textfield name="org.orgSimpleName" id="orgSimpleName" cssClass="inputText" whir-options="vtype:['notempty','spechar3']" cssStyle="width:96%;" maxlength="16"/>
        </td>
    </tr>
    <tr>
        <td for="组织英文名" class="td_lefttitle">组织英文名：</td>
        <td><s:textfield name="org.orgEnglishName" id="orgEnglishName" cssClass="inputText" whir-options="vtype:['spechar3']" cssStyle="width:96%;" maxlength="100"/>
        </td>
    </tr>
    <tr>
        <td for="组织编码" class="td_lefttitle">组织编码<span class="MustFillColor">*</span>：</td>
        <td><s:textfield name="org.orgSerial" id="orgSerial" cssClass="inputText" whir-options="vtype:['notempty','spechar3']" cssStyle="width:96%;" maxlength="100"/>
        </td>
    </tr>

    <tr>
        <td for="单位标识" class="td_lefttitle">单位标识：</td>
        <td>
            <s:radio id="orgType" name="org.orgType" list="#{'0':'是','1':'否'}"></s:radio>
        </td>
    </tr>

    <tr>
        <td for="分管领导" class="td_lefttitle">分管领导：</td>
        <td>
            <s:hidden name="org.chargeLeaderIds" id="chargeLeaderIds"/>
            <s:textfield name="org.chargeLeaderNames" id="chargeLeaderNames" cssClass="inputText" cssStyle="width:96%;" readonly="true" maxlength="50"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'chargeLeaderIds', allowName:'chargeLeaderNames', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
            <s:if test="org.orgId!=null">
            <div class="sync"><input type="checkbox" name="isSyncChargeLeader" id="isSyncChargeLeader" value="1"/><label for="isSyncChargeLeader" style="cursor:pointer;">同步用户分管领导</label></div>
            </s:if>
        </td>
    </tr>
    <tr>
        <td for="部门领导" class="td_lefttitle">部门领导：</td>
        <td>
            <s:hidden name="org.orgManagerEmpId" id="orgManagerEmpId"/>
            <s:textfield name="org.orgManagerEmpName" id="orgManagerEmpName" cssClass="inputText" cssStyle="width:96%;" readonly="true" maxlength="50"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'orgManagerEmpId', allowName:'orgManagerEmpName', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
            <s:if test="org.orgId!=null">
            <div class="sync"><input type="checkbox" name="isSyncOrgManagerEmp" id="isSyncOrgManagerEmp" value="1"/><label for="isSyncOrgManagerEmp" style="cursor:pointer;">同步用户部门领导</label></div>
            </s:if>
        </td>
    </tr>
    <!--tr style="display:none">
        <td for="组织类型" class="td_lefttitle">组织类型：</td>
        <td>
            <s:select name="org.orgType" id="orgType" list="#{'0':'单位','1':'其它'}" listKey="key" listValue="value"/>
        </td>
    </tr-->
    <s:if test="addType == 1 || orgId != 0">
    <tr>
        <td for="所属组织" class="td_lefttitle">所属组织<span class="MustFillColor">*</span>：</td>
        <td>
            <s:hidden name="org.orgParentOrgId" id="orgParentOrgId"/>
            <s:textfield name="orgParentOrgName" id="orgParentOrgName" cssClass="inputText" cssStyle="width:96%;" whir-options="vtype:['notempty']" readonly="true"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'orgParentOrgId', allowName:'orgParentOrgName', select:'org', single:'yes', show:'org', range:'<s:property value="range"/>', limited:'1', callbackOK:'changeBrother'});"></a>
        </td>
    </tr>
    </s:if>
    <tr>
        <td for="存放位置" class="td_lefttitle">存放位置：</td>
        <td>
            <select id="currentOrderCode" name="currentOrderCode" class="easyui-combobox" data-options="width:430,valueField:'id',textField:'text',onSelect:function(record){changeOrder();}">
            <s:if test="org.orgId==null">
                <s:iterator value="#request.listBrother" status="status" id="borther">
                <option value="<s:property value="#request.listBrother[#status.index][0]"/>" <s:if test="#request.listBrother[#status.index][0] == #request.listBrother[#request.listBrother.size()-1][0]">selected</s:if>><s:property value="#request.listBrother[#status.index][1]"/></option>
                </s:iterator>
            </s:if>
            <s:else>
                <s:iterator value="#request.listBrother" status="status" id="borther">
                <option value="<s:property value="#request.listBrother[#status.index][0]"/>" <s:if test="#request.listBrother[#status.index][0] == brotherOrgId">selected</s:if>><s:property value="#request.listBrother[#status.index][1]"/></option>
                </s:iterator>
            </s:else>
            </select>            
            <s:radio id="orgSort" name="orgSort" list="#{'0':'前','1':'后'}" onclick="changeOrder();"></s:radio>
        </td>
    </tr>
    <tr>
        <td for="单位主页" class="td_lefttitle">单位主页：</td>
        <td>
            <s:select name="org.orgHasChannel" id="orgHasChannel" list="#{'0':'无','1':'有'}" listKey="key" listValue="value" cssClass="easyui-combobox" data-options="width:50,editable:false,panelHeight:'auto',onSelect: function(record){setChannelStyle();}"/>
            <span id="orgChannelTypeSpan" <s:if test="org.orgHasChannel == 0">style="display:none"</s:if>>
            <s:radio id="orgChannelType" name="org.orgChannelType" list="#{'0':'系统自带','1':'外部主页'}" onclick="setChannelType(this);"/>
            <label for="外部主页" style="display:none">外部主页</label>
            <span id="orgChannelUrlSpan" <s:if test="org.orgChannelType == 0">style="display:none"</s:if>>
            <span class="MustFillColor">*</span>
            <s:if test="org.orgChannelType == 0">
            <s:textfield name="org.orgChannelUrl" id="orgChannelUrl" cssClass="inputText" cssStyle="width:58%;" maxlength="200" whir-options=""/>
            </s:if>
            <s:else>
            <s:textfield name="org.orgChannelUrl" id="orgChannelUrl" cssClass="inputText" cssStyle="width:58%;" maxlength="200" whir-options="vtype:['notempty',{'spechar':'\\''}]"/>
            </s:else>
            </span>
            </span>
        </td>
    </tr>

    <tr>
        <td for="可查看人" class="td_lefttitle" valign="top">可查看人：</td>
        <td colspan=3>
            <s:hidden name="scopeIds" id="scopeIds"/>
            <s:textarea name="scopeNames" id="scopeNames" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:96%;" readonly="true"></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'scopeIds', allowName:'scopeNames', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"></a>
            <div><span class="MustFillColor MustFillExt">“可查看人”为空时默认所有用户。</span></div>
        </td>
    </tr>

    <tr style="<s:if test="useTrans != 1 || tansType != 'server'">display:none</s:if>">
        <td for="接口地址" class="td_lefttitle">接口地址：</td>
        <td><s:textfield name="org.webserviceUrl" id="webserviceUrl" cssClass="inputText" cssStyle="width:96%;" maxlength="150"/>
        </td>
    </tr>
    <tr>
        <td for="描述" class="td_lefttitle">描述：</td>
        <td>
            <s:textarea name="org.orgDescripte" id="orgDescripte" cols="112" rows="5" cssClass="inputTextarea" cssStyle="width:96%;" whir-options="vtype:[{'maxLength':150}]"></s:textarea>
        </td>
    </tr>

	<tr>
        <td class="td_lefttitle"><strong>审批权限</strong></td>
        <td align="left">
            <hr style="width:96%;float:left;border-color:#fff;"/>
        </td>
    </tr>

    <tr>
        <td for="一级审批人" class="td_lefttitle">一级审批人：</td>
        <td><s:hidden name="org.oneLevelUserId" id="oneLevelUserId"/>
            <s:textfield name="org.oneLevelUserName" id="oneLevelUserName" cssClass="inputText" cssStyle="width:96%;" readonly="true" maxlength="100"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'oneLevelUserId', allowName:'oneLevelUserName', select:'user', single:'no', show:'user', range:'*0*', limited:'1'});"></a>
        </td>
    </tr>

    <tr>
        <td for="二级审批人：" class="td_lefttitle">二级审批人：</td>
        <td><s:hidden name="org.twoLevelUserId" id="twoLevelUserId"/>
            <s:textfield name="org.twoLevelUserName" id="twoLevelUserName" cssClass="inputText" cssStyle="width:96%;" readonly="true" maxlength="100"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'twoLevelUserId', allowName:'twoLevelUserName', select:'user', single:'no', show:'user', range:'*0*', limited:'1'});"></a>
        </td>
    </tr>

    <tr>
        <td for="三级审批人" class="td_lefttitle">三级审批人：</td>
        <td><s:hidden name="org.threeLevelUserId" id="threeLevelUserId"/>
            <s:textfield name="org.threeLevelUserName" id="threeLevelUserName" cssClass="inputText" cssStyle="width:96%;" readonly="true" maxlength="100"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'threeLevelUserId', allowName:'threeLevelUserName', select:'user', single:'no', show:'user', range:'*0*', limited:'1'});"></a>
        </td>
    </tr>

    <tr>
        <td for="四级审批人" class="td_lefttitle">四级审批人：</td>
        <td><s:hidden name="org.fourLevelUserId" id="fourLevelUserId"/>
            <s:textfield name="org.fourLevelUserName" id="fourLevelUserName" cssClass="inputText" cssStyle="width:96%;" readonly="true" maxlength="100"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'fourLevelUserId', allowName:'fourLevelUserName', select:'user', single:'no', show:'user', range:'*0*', limited:'1'});"></a>
        </td>
    </tr>

    <tr>
        <td for="五级审批人" class="td_lefttitle">五级审批人：</td>
        <td><s:hidden name="org.fiveLevelUserId" id="fiveLevelUserId"/>
            <s:textfield name="org.fiveLevelUserName" id="fiveLevelUserName" cssClass="inputText" cssStyle="width:96%;" readonly="true" maxlength="100"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'fiveLevelUserId', allowName:'fiveLevelUserName', select:'user', single:'no', show:'user', range:'*0*', limited:'1'});"></a>
        </td>
    </tr>

    <tr>
        <td for="六级审批人" class="td_lefttitle">六级审批人：</td>
        <td><s:hidden name="org.sixLevelUserId" id="sixLevelUserId"/>
            <s:textfield name="org.sixLevelUserName" id="sixLevelUserName" cssClass="inputText" cssStyle="width:96%;" readonly="true" maxlength="100"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'sixLevelUserId', allowName:'sixLevelUserName', select:'user', single:'no', show:'user', range:'*0*', limited:'1'});"></a>
        </td>
    </tr>

    <tr>
        <td class="td_lefttitle"><strong>显示设置</strong></td>
        <td align="left">
            <hr style="width:96%;float:left;border-color:#fff;"/>
        </td>
    </tr>

    <tr>
        <td for="窗口标题" class="td_lefttitle">窗口标题：</td>
        <td>
            <s:textfield name="org.winTitle" id="winTitle" cssClass="inputText" whir-options="vtype:['spechar3']" cssStyle="width:96%;" maxlength="40"/>
        </td>
    </tr>
    <tr>
        <td for="组织LOGO" class="td_lefttitle">组织LOGO：</td>
        <td>
            <s:textfield id="logoFileName" name="org.logoFileName" cssClass="inputText" size="40" readonly="true" style="width:96%"/>
            <s:hidden id="logoSaveFileName" name="org.logoSaveFileName"/>
            <div><span class="MustFillColor" style="padding-left:0;">建议：LOGO尺寸高度请勿超出50px，格式为png。</span></div>
            <div style="width:214px;">
                <div style="float:left;width:120px;padding-top:5px;">
                <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                    <jsp:param name="onInit" value="" />
                    <jsp:param name="onSelect" value="" />

                    <jsp:param name="onUploadSuccess" value="showIMG" />
                    <jsp:param name="isShowBatchDownButton" value="no" />

                    <jsp:param name="accessType" value="include" />
                    <jsp:param name="makeYMdir" value="no" />
                    <jsp:param name="dir" value="desktop" />
                    <jsp:param name="uniqueId" value="uniqueId_logoFileName" />
                    <jsp:param name="realFileNameInputId" value="logoFileName" />
                    <jsp:param name="saveFileNameInputId" value="logoSaveFileName" />
                    <jsp:param name="canModify" value="yes" />
                    <jsp:param name="width" value="90" />
                    <jsp:param name="height" value="20" />
                    <jsp:param name="multi" value="false" />
                    <jsp:param name="buttonClass" value="upload_btn" />
                    <jsp:param name="buttonText" value="上传图片" />
                    <jsp:param name="fileSizeLimit" value="5MB" />
                    <jsp:param name="fileTypeExts" value="*.png;" />
                    <jsp:param name="uploadLimit" value="1" />
                </jsp:include>
                </div>
                <div class="imgPhoto" onclick="whir_confirm('确认删除?',function delepic(){$('#ImgShow').attr('src','<%=rootPath%>/images/blank.gif');$('#logoFileName').val('');$('#logoSaveFileName').val('');},function(){})">删除图片</div>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <div style="margin-top:5px;"><img id="ImgShow" src="<%=src%>"></div>
        </td>
    </tr>

    <tr class="Table_nobttomline">
        <td></td>
        <td nowrap>
            <input type="button" class="btnButton4font" onClick="saveorganization(this);" value="<s:text name="comm.saveclose"/>" />
            <s:if test="org.orgId==null">
                <input type="button" class="btnButton4font" onClick="ok(1,this);" value="<s:text name="comm.savecontinue"/>" />
            </s:if>
            <input type="button" id="resetBtn" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<s:text name="comm.exit"/>" />
        </td>
    </tr>
</table>
<SCRIPT LANGUAGE="JavaScript">

function saveorganization(obj){
	var logoFileName = $('#logoFileName').val();
	if(logoFileName.length>40){
		whir_alert("图片名称长度超出40，请重新上传！");
	}else{
		ok(0,obj);
	}
}

function showIMG(json){
	$('#ImgShow').attr("src", "<%=path%>/upload/desktop/"+json.save_name+json.file_type);
    $('#logoFileName').val(json.file_name+json.file_type);
    $('#logoSaveFileName').val(json.save_name+json.file_type);
}

var old_orgHasChannel = "";
function resetTheForm(obj){
    resetDataForm(obj);

    resetOther(obj);    
}

function resetOther(obj){
    $('#orgHasChannel').combobox('setValue', old_orgHasChannel);

    setChannelStyle();

    var orgChannelType = $("input:radio[name='org.orgChannelType']:checked")[0];
    setChannelType(orgChannelType);

    if($('#orgParentOrgId').length>0){
        $('#orgParentOrgId').val('<s:property value="org.orgParentOrgId"/>');
        changeBrother();
    }
}

//是否有 单位主页
function setChannelStyle(){
    var orgHasChannel = $('#orgHasChannel').combobox('getValue');
    if(orgHasChannel == '0'){
        $('#orgChannelTypeSpan').hide();
        $('#orgChannelUrl').val('');
        $('#orgChannelUrl').attr('whir-options', "");
    }else if(orgHasChannel == '1'){
        $('#orgChannelTypeSpan').show();
    }
}

// 系统自带 ， 外部单位主页
function setChannelType(obj){
    var orgChannelType = $(obj).val();
    if(orgChannelType == '0'){
        $('#orgChannelUrlSpan').hide();
        $('#orgChannelUrl').attr('whir-options', "");
    }else{
        $('#orgChannelUrlSpan').show();
        $('#orgChannelUrl').attr('whir-options', "vtype:['notempty',{'spechar':'\\\''}]");
    }
}

function changeOrder(){
    $('#hasChanged').val('1');
}

function changeBrother(){
    var orgParentOrgId = $('#orgParentOrgId').val();
    if(orgParentOrgId==''){
        orgParentOrgId="0";
        $('#orgParentOrgId').val("0");
        $('#orgParentOrgName').val("一级组织");
    }
    var orgId = $('#orgId').val();
    var params = '&orgParentOrgId='+orgParentOrgId+'&orgId='+orgId;//alert(params);
    $('#currentOrderCode').combobox('clear');
    $('#currentOrderCode').combobox('reload', '<%=rootPath%>/Organization!getBrotherOrg.action?range=<s:property value="#request.range"/>'+params);
}

//检查网址格式
function checkURL(val, mode) {
    if ((mode == 0) && (val.value == "")) {
        return true;
    }

    var s = "外部主页地址错误！";
    var val2 = val.value;
    if (val2.indexOf('://') > 0) {
        var isNot = " !@$^*()'`~|]}[{;>,<";
        if (val2.indexOf('\"') > 0 || val2.indexOf('\\') > 0) {
            alert(s);
            val.focus();
            val.select();
            return false;
        } else {
            for (var i = 0; i < val2.length; i++) {
                for (var x = 1; x < isNot.length; x++) {
                    if (val2.charAt(i) == isNot.charAt(x)) {
                        alert(s);
                        val.focus();
                        val.select();
                        return false;
                    }
                }
            }
        }
    } else {
        alert(s);
        val.focus();
        val.select();
        return false;
    }

    return true;
}

$(document).ready(function(){         
    old_orgHasChannel = $('#orgHasChannel').combobox('getValue');
});

</SCRIPT>