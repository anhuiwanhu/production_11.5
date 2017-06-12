<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
	String userId = session.getAttribute("userId")==null?"":session.getAttribute("userId").toString();
	String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
	String orgIdString = session.getAttribute("orgIdString")==null?"":session.getAttribute("orgIdString").toString();
	String domainId = session.getAttribute("domainId").toString();
    com.whir.govezoffice.documentmanager.bd.SenddocumentBD bd = new com.whir.govezoffice.documentmanager.bd.SenddocumentBD();
   List list = bd.getTemplateList_Common(userId, orgId, orgIdString, "xxbs", domainId);
   com.whir.ezoffice.infosend.po.KwzlPO kwzlPO = null;

if(request.getAttribute("kwzlPO") != null ) {
      kwzlPO=(com.whir.ezoffice.infosend.po.KwzlPO)request.getAttribute("kwzlPO");
  }
  String kwmbid=kwzlPO==null?"":kwzlPO.getKwmbid();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:if test='#request.action == "add"'>新刊物种类设置</s:if><s:else>修改刊物种类设置</s:else> 
</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<%@ include file="/public/include/include_extjs.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->

</head>

<body class="Pupwin">
	<div class="BodyMargin_10" >  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="${ctx}/kwzl!save.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr>  
                <td for="刊物种类" style="width:130px;" class="td_lefttitle">  
                    刊物种类<span class="MustFillColor">*</span>：  
                </td>  
                <td>  
                    <s:textfield name="kwzlPO.kwkind" id="kwkind" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':50},'spechar3']" cssStyle="width:80%;" maxlength="50" onblur="validTitle();"/> 
					<div id="titleValidDiv" style="color: red"></div>
                    <s:hidden name="kwzlPO.id" id="id"/>
                    <s:hidden name="kwzlPO.kwcreate" id="kwcreate"/>
                    <s:hidden name="kwzlPO.kwcreateid" id="kwcreateid"/>
                    <s:hidden name="kwzlPO.kwcreateorg" id="kwcreateorg"/>
					<s:hidden name="kwzlPO.kwc" id="kwc"/>
                </td>  
            </tr>  
            <tr>  
                <td for="刊物模板" class="td_lefttitle">  
                    刊物模板<span class="MustFillColor">*</span>：  
                </td>  
                <td> 
					<select name="kwmbid" id="kwmbid"  style="width:90%;" class="selectlist" whir-options="vtype:['notempty',{'maxLength':50},'spechar3']">
						 <option value="">--请选择--</option>
					<%if(list!=null&&list.size()>0){
						for(int i=0; i<list.size(); i++){
							Object[] obj = (Object[])list.get(i);
							 boolean result = false;
							if(kwmbid.equals(obj[0].toString())){
								result=true;
							}
					%>
						<option value="<%=obj[0]%>" <%=result==true?"selected":""%>><%=obj[1]%></option>
					<%}}%>
					</select>
					<s:hidden name="kwzlPO.kwmb" id="kwmb"/>
                </td>  
            </tr>
            <tr>  
                <td for="可查看人" class="td_lefttitle" >  
                    可查看人：  
                </td>  
                <td>  
                     <s:textarea name="kwzlPO.kworder" id="kworder" cols="112" rows="3"   cssClass="inputTextarea" cssStyle="width:80%;" readonly="true"/><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'kworderid', allowName:'kworder', select:'user', single:'no', show:'orgusergroup', range:'*0*'});"></a>
					 <s:hidden name="kwzlPO.kworderid" id="kworderid"/>
					 <br/>
					 <span class="MustFillColor">"可查看人"为空时默认所有用户。</span>
                </td>  
            </tr>
            <tr class="Table_nobttomline">  
                <td > </td> 
                <td nowrap>  
                    <input type="button" class="btnButton4font" onClick="ok(0,this);" value='<s:text name="comm.saveclose"/>' />  
                   <s:if test='#request.action=="add"'>
                    <input type="button" class="btnButton4font" onClick="ok(1,this);" value='<s:text name="comm.savecontinue"/>' />  
                    </s:if>
                    <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
                </td>  
            </tr>  
        </table>  
	</s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});

	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
	Ext.onReady(function() {
		var modelCombo = Ext.create('Ext.form.field.ComboBox', {
			id: 'kwmbid',
			typeAhead: true,
			transform: 'kwmbid',
			hiddenName: 'kwzlPO.kwmbid',//传到后台的值
			width: 213,
			forceSelection: true,
			//emptyText: '--请选择--',
			listeners: {
				select: function(combo, record, index) {
				}
			},
			focus:{
			fn:function(){
				if(this.value==''){
					this.clearValue();
				}
			}
			},
			blur:{
				fn:function(){
					if(this.value==''){
						this.setValue('--请选择--');
						this.value='';
					}
				}
			}
		});
	});
	function ok(n,obj){ 
		var formId = $(obj).parents("form").attr("id");
		var validation = validateForm(formId);
		$(obj).parents("form").find("#saveType").val(n);
		if(validation){
			var val=whirExtCombobox.getValue("kwmbid");
			if(val == null || val =='' || val=='null'){
				//whir_alert("请选择正确模板类型！",null,null);
				 whir_poshytip($("#kwmbid"),"刊物模板不能为空！");
				 return false;
			}else{
				var text=whirExtCombobox.getText("kwmbid");
				$("#kwmb").val(text);
			}

			dataForm.action = "${ctx}/kwzl!save.action";
			$('#'+formId).submit();
		}			
	}
	//校验标题
	function validTitle(){
		var title = $('#kwkind').val();
		if(title==''){
			return;
		}
		var result = spechar(title,"\\\,/,?,#,&,\'");
		var id = $('#id').val();
		if(result != ''){
			return;
		}else{
			<s:if test='#request.action=="add"'>
				ajaxForAsync('kwzl!validTitle.action','validTarg=0&kwkind='+title,backValidTitle);
			</s:if>
			<s:else>
				ajaxForAsync('kwzl!validTitle.action','validTarg=1&kwkind='+title+'&id='+id,backValidTitle);
			</s:else>
		}
	}
	function backValidTitle(data){
		var json='';
		eval('json=' + data + ';');  
		//alert(json.result);
		$('#titleValidDiv').html(json.result);
	}
</script>
</html>

