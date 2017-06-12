<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>冲销时限</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body class="Pupwin">
	<div class="BodyMargin_10">
		<div class="docBoxNoPanel">
	       <s:form name="dataForm" id="dataForm" action="/kqrecordimp!savepaidleave.action" method="post" theme="simple" >
	            <%@ include file="/public/include/form_detail.jsp"%>
	            <s:hidden type="hidden" name="kqSetPo.setId" id="setId"  />
				<s:hidden type="hidden" name="kqSetPo.domainId" id="domainId"  />
				<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
				   	<tr>
						<td width="2">&nbsp;</td>
						<td colspan="2"><span>设置加班小时数作废的时间点，可定义一个时间点之后的加班小时数允许调休，这个时间点之前的加班小时数全部作废。</span></td>
					</tr>
				   	<tr>
						<td width="1%">&nbsp;</td>
						<td width="7%">冲销时限:</td>
						<td width="92%">
							<s:textfield name="kqSetPo.setValue" id="beginDate" cssClass="Wdate whir_datebox" whir-options="vtype:['notempty']" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" ></s:textfield>
						</td>
					</tr>
				   	<tr class="Table_nobttomline">
				      	<td>&nbsp;</td>
				      	<td nowrap><input type="button" class="btnButton4font" onClick="saveAndContinue(this);" value="<s:text name="comm.save"/>" /></td>
				   	</tr>
				</table>
	       </s:form>
		</div>
	</div>
</body>

<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	
	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存',"reset":'no'});
	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
    function saveAndContinue(obj){
       ok(1,obj);
    }
    
</script>
</html>