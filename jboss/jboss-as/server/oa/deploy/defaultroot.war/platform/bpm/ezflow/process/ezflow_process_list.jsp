<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
  whir_custom_str="easyui ";
  String moduleId=com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"moduleId");
  String iswhirchoosed=com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"iswhirchoosed");
  String iswhirchoosedIsSinger=com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"iswhirchoosedIsSinger");
  String whirchoosedIdPara=com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"whirchoosedIdPara"); 
  String whirchoosedNamePara=com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"whirchoosedNamePara");
  if(iswhirchoosed!=null&&iswhirchoosed.equals("1")){
	  if(whirchoosedIdPara==null||whirchoosedIdPara.equals("")||whirchoosedIdPara.equals("null")){
		  whirchoosedIdPara="subactivityIds";
		  whirchoosedNamePara="subactivityNames";
	  }
  }
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>标准列表页面结构</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>

	<%
	String color = request.getParameter("headColor")!=null?request.getParameter("headColor"):"";
	if(!"".equals(color)){
	%>
	<link href="<%=rootPath%>/themes/department/style.css" rel="stylesheet" type="text/css"/>
	<%
	}
	%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<style type="text/css">
	<!--
	#noteDiv {
		position:absolute;
		width:210px;
		height:200px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
		background-color:#ffffff;
		top:29px !important;
		left:0px !important;
		*left:5px !important;

	}
	-->
   </style>
</head>
<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="${ctx}/ezflowprocess!list.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
	<input type="hidden" name="batchIds" id="batchIds" />
	<input type="hidden" name="choosed_processPackage" id="choosed_processPackage" />
	<s:hidden name="subType" id="subType" />
	<s:hidden name="moduleId" id="moduleId" />
	<input type="hidden"  name="iswhirchoosed" id="iswhirchoosed" value="<%=iswhirchoosed%>">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar"  >  
        <tr>
            <td class="whir_td_searchtitle2" ><bean:message bundle="workflow" key="workflow.Category"/>：</td>
            <td class="whir_td_searchinput" >
				<s:textfield id="packageName" name="packageName" size="16" cssClass="inputText" />
            </td>
			<td class="whir_td_searchtitle2" ><bean:message bundle="workflow" key="workflow.workflowname"/>：</td>
            <td class="whir_td_searchinput" >
				<s:textfield id="processName" name="processName" size="16" cssClass="inputText" />
            </td>
            <td class="SearchBar_toolbar" nowrap>
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);setStyle();" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END --> 
    <%if(iswhirchoosed.equals("1")){%>
	
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr>
			<td align="right" width="35%"> 
            </td>
            <td align="right" style="text-valign:center;valign:center" nowrap> 
			<input type="button" class="btnButton4font" onclick="window.close();" value='确  定' />
			<input type="button" class="btnButton4font" onclick="clearchoose();" value='清除选择' />
            </td>
        </tr> 
    </table> 
	<%}else{ %> 
   
   <!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			 <td align="right" width="35%">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right" style="text-valign:center;valign:center" nowrap>
				<s:if test="subType==0">
					<div class="ezflow_list_import_div">
						<input type="button" class="btnButton4font" onclick="importProcess();" value='<s:text name="comm.import"/>' />
						<input type="button" class="btnButton4font" onclick="exportProcess();" value='<s:text name="comm.export"/>' />
					</div>
					
					<div class="ezflow_list_package_div">
						<input type="text" class="inputText" style="width:210px" readonly="true" id="choosed_processPackageName" id="choosed_processPackageName"  rel="noteDiv" whir-options="'promptText':'<s:text name="workflow.pleasechoosepackage"/>'"/>
						<div id="noteDiv" align="left"  style="display:none; position: absolute;top:29px !important; left:0px !important;">
							<ul>
							<%
							List processPackageList=new ArrayList();
							if(request.getAttribute("processPackageList")!=null){
								processPackageList=(List)request.getAttribute("processPackageList");
							}
							Object packageObj[]=null;
							for(int i=0;i<processPackageList.size();i++){
								packageObj=(Object [])processPackageList.get(i);
							%>
								<li><input type="checkbox" name="processPackage_checbox"  displaytext="<%=packageObj[1]%>"  value="<%=packageObj[0]%>"  onchange="setPackageInfo()"><%=packageObj[1]%></li> 
							<% 
							  }
							%>
							</ul>
						</div>
					</div>
				</s:if>
				<div  class="ezlow_list_operator_div">
					<input type="button" class="btnButton4font" onclick="add();" value='<bean:message bundle="common" key="comm.add"/>' />
					<input type="button" class="btnButton4font" onclick="batchDelete();" value='<bean:message bundle="common" key="comm.delselect"/>' /> 
					<s:if test="subType==0">
					<input type="button" class="btnButton4font" onclick="copeProcess();" value='<bean:message bundle="workflow" key="workflow.Copyworkflow"/>' />
					</s:if>
				</div>
            </td>
        </tr>
    </table>
	<%}%>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable"  id="processTableId">
		<thead id="headerContainer">
        <tr class="listTableHead">
		    <td whir-options="field:'id',width:'2%',checkbox:true,renderer:showBatchDeal" ><%if(!iswhirchoosedIsSinger.equals("1")){%><input type="checkbox" name="items" id="items" onclick="selectAllCB(this.checked);setCheckBoxState('id',this.checked);" ><%}%></td> 
			<td whir-options="field:'packageName',width:'15%'"><bean:message bundle="workflow" key="workflow.setupcategory"/></td> 
			<td whir-options="field:'processName',width:'28%',renderer:showProcessName,allowSort:true"><bean:message bundle="workflow" key="workflow.workflowname"/></td> 
		    <s:if test="subType==0">
			<td whir-options="field:'processScopeNames',width:'32%'"><bean:message bundle="workflow" key="workflow.setupusers"/></td> 
			</s:if>
			<!-- <td whir-options="field:'processType',width:'15%',renderer:showtype"><bean:message bundle="workflow" key="workflow.setuptype"/></td>  -->
			<td whir-options="field:'createUserName',width:'7%'"><bean:message bundle="workflow" key="workflow.setupcreator"/></td> 
			<td whir-options="field:'sort',width:'6%'"><bean:message bundle="information" key="info.sort" /></td>
			<%if(!iswhirchoosed.equals("1")){%>
			<td whir-options="field:'',width:'10%',renderer:myOperate"><bean:message bundle="common" key="comm.opr" /></td> 
			<%}%>
        </tr>
		</thead>
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->
	</s:form>
</body>
<script type="text/javascript">
	 
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){			
		initListFormToAjax({formId:"queryForm",onLoadSuccessAfter:mergeCellsPackgeName});	
	    // 弹出层
	    $("#choosed_processPackageName").powerFloat();
	});
 
	/**
	*合并流程的分类
	*/   
	function  mergeCellsPackgeName(){		
	    mergeCells("processTableId",1,1, 1);
		if(window.parent.loadIframe){
            window.parent.loadIframe();
        }
	}

	/**
	*显示流程名
	*/
	function  showProcessName(po,i){ 
		if(po.isdeployed=="1"){
			return  po.processName;
		}else{
			return  "<font color='red' >"+po.processName+"</font>";
		} 
	}

    /**
	checkbox 显示
	*/
	function  showBatchDeal(po,i){
		var html =' id="'+po.id+'"  processId="'+po.processId+'"  verifyCode="'+  po.verifyCode+ 
			'"   onclick="checkOk(this,  \''+po.processName+'\', \''+po.id+'\',\''+po.processId+'\');" ';
	   <%if(!iswhirchoosedIsSinger.equals("1")){%>
		if(opener){
			var openerValue=$("#<%=whirchoosedIdPara%>",window.opener.document).val();
			if(openerValue!=null&&openerValue.indexOf(po.processId) >=0){ 
				html=" checked "+html;
			}
		} 
		<%}%>
		return html;
	}	


	//判断选择
	function checkOk(obj,processName,id,processId){  
		if(opener){
			 <%if(iswhirchoosedIsSinger.equals("1")){%>

				 	$("input[type='checkbox'][name!=\"items\"][name!=\"processPackage_checbox\"]").each(function(){
						//alert(1);
						 if(this!=obj){
						    this.checked=false;
						 }
					});

				 if(obj.checked){	
					$("#<%=whirchoosedNamePara%>",window.opener.document).val(processName);
					$("#<%=whirchoosedIdPara%>",window.opener.document).val(processId);
				 }else{
					//$("#<%=whirchoosedNamePara%>",window.opener.document).val($("#<%=whirchoosedNamePara%>",window.opener.document).val().replace(processName+";",""));
					//$("#<%=whirchoosedIdPara%>",window.opener.document).val($("#<%=whirchoosedIdPara%>",window.opener.document).val().replace(processId+";","")); 
				 }
			 <%}else{%>
				 if(obj.checked){	
					$("#<%=whirchoosedNamePara%>",window.opener.document).val($("#<%=whirchoosedNamePara%>",window.opener.document).val()+processName+";");
					$("#<%=whirchoosedIdPara%>",window.opener.document).val($("#<%=whirchoosedIdPara%>",window.opener.document).val()+processId+";");
				 }else{
					$("#<%=whirchoosedNamePara%>",window.opener.document).val($("#<%=whirchoosedNamePara%>",window.opener.document).val().replace(processName+";",""));
					$("#<%=whirchoosedIdPara%>",window.opener.document).val($("#<%=whirchoosedIdPara%>",window.opener.document).val().replace(processId+";","")); 
				 }
			 <%}%>
		 } 
	}	
	
	//清除选择
	function clearchoose(){
			$("#<%=whirchoosedNamePara%>",window.opener.document).val("");
			$("#<%=whirchoosedIdPara%>",window.opener.document).val("");

			$("input[type='checkbox'][name!=\"items\"][name!=\"processPackage_checbox\"]").each(function(){
			//alert(1);
			 this.checked=false;
		});
	}


	function selectAllCB(v1){
		$("input[type='checkbox'][name!=\"items\"][name!=\"processPackage_checbox\"]").each(function(){
			//alert(1);
			if(this.checked != v1){
				this.checked = ! v1;
				this.click();
			}
		});
		
	}

	function  batchDelete_real(){ 
		ajaxBatchOperate({url:'<%=rootPath%>/ezflowprocess!deleteProcess.action',checkbox_name:'id',attr_name:'id,processId',tip:'<s:text name="comm.sdel"/>',isconfirm:false,formId:'queryForm',callbackfunction:null});
	}

	function  batchDelete(){
		var deleteIds= getCheckBoxData("id","id"); 
		if(deleteIds==""){
			whir_alert('<s:text name="workflow.pleasechoosedata"/>',function(){});
		}else{
			whir_confirm('<s:text name="workflow.batchdeleteprocessTips"/>',function(){batchDelete_real();});
		}
	}

	function  deleteProcess(id,processId){
		var moduleId ='<%=moduleId%>';
		if(moduleId == '4'){//信息流程
			var ajaxCallUrl = whirRootPath + "/Channel!judgeProcessDelete.action?processKey="+processId;
			var result = $.ajax({
				  url: ajaxCallUrl,
				  async: false
			}).responseText;
			if(result =='1'){
				whir_alert('此流程已绑定栏目，栏目下有信息，不能删除!',function(){});
				return false;
			}
		}

		if($("#subType").val()=="1"){
			var url="<%=rootPath%>/platform/bpm/ezflow/process/ezflow_process_judgemainprocess.jsp?id="+id+"&processId="+processId;
            var result = $.ajax({
				  url: url,
				  async: false
			}).responseText;
			
			if(result!="0"){
			    whir_alert('此子流程已被关联，不能删除!',function(){});
				return ;
			}
		}
		whir_confirm('<s:text name="workflow.deleteprocessTips"/>',function(){ajaxOperate({urlWithData:'<%=rootPath%>/ezflowprocess!deleteProcess.action?id='+id+'&processId='+processId,tip:'<s:text name="comm.sdel"/>',isconfirm:false,formId:'queryForm',callbackfunction:null});});
	}
	
	//自定义操作栏内容
	function myOperate(po,i){
		var html =  '<a href="javascript:void(0)" onclick="deleteProcess(\''+po.id+'\',\''+po.processId+'\');"><img border="0" src="<%=rootPath%>/images/del.gif" title="<s:text name="comm.sdel"/>" ></a>';
	    html+='<a href="javascript:void(0)" onclick="designerMap(\''+po.id+'\');"><img border="0" src="<%=rootPath%>/images/designerWorkflow.gif" title="<s:text name="workflow.createGraph"/>" ></a>';
	    html+='<a href="javascript:void(0)" onclick="deploy(\'redeploy\',\''+po.id+'\',\''+po.processId+'\');;"><img border="0" src="<%=rootPath%>/images/deploy.gif" title="<s:text name="workflow.deploy"/>" ></a>';
        html+='<a href="javascript:void(0)" onclick="setOrder(\''+po.id+'\',\''+po.processId+'\',\''+po.sort+'\');;"><img border="0" src="<%=rootPath%>/images/px.gif" title="<bean:message bundle="information" key="info.sort" />" ></a>';
 		if($("#subType").val()!="1"){//子流程不显示流程版本
			html+='<a href="javascript:void(0)" onclick="getFlowVersion(\''+po.id+'\',\''+po.processId+'\',\''+po.processName+'\');"><img border="0" src="<%=rootPath%>/images/version.gif" title="<s:text name="workflow.processVersion"/>" ></a>';
		}
		return html;
	}

	function getFlowVersion(id, processId, processName){
		//alert("id:"+id+"|processId:"+processId);
		var src="<%=rootPath%>/ezflowprocess!ezFlowProcessVersion.action?id="+id+"&processId="+processId+"&processName="+processName;
		//alert(src);
		openWin({url:src,width:1000,height:600,winName:''});
	}
	
	//设计流程图
	function  designerMap(recordId){
		//通过action加载到相应的流程
		var src="<%=rootPath%>/platform/bpm/ezflow/graph/jsp/updateprocess.jsp?recordId="+recordId+"&subType="+$("#subType").val()+"&moduleId="+$("#moduleId").val();
		//src+="&processDefId=zhiyouprocess:1:98259200";
		//window.open(src,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=920,height=800');
		openWin({url:src,width:1185,height:780,scrollbars:'yes',resizable:'yes',winName:''});
	}
	
	//自定义查看栏内容
	function show(po,i){
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/wfprocess!viewButton.action?buttonId='+po.buttonId+'&moduleId='+$("#moduleId").val()+'\',width:620,height:310,winName:\'showUser\'});">'+po.packageName+'</a>';
		return html;
	}
	
	function showtype(po,i){
		var html ;
		if(po.processType==1){
			html = '<bean:message bundle="workflow" key="workflow.newworkflowfix"/>';
		}else{
			html = '<bean:message bundle="workflow" key="workflow.newworkflowrandom"/>';
		}
		return html;
	}

	function add(){
        var src="<%=rootPath%>/platform/bpm/ezflow/graph/jsp/updateprocess.jsp?subType="+$("#subType").val()+"&moduleId="+$("#moduleId").val();
		//window.open(src,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=770,height=500');
		openWin({url:src,width:1185,height:780,winName:''});
	}

	String.prototype.trim=function(){
		return this.replace(/(^\s*)|(\s*$)/g, "");
	}
	String.prototype.ltrim=function(){
　　    return this.replace(/(^\s*)/g,"");
	}
	String.prototype.rtrim=function(){
　　    return this.replace(/(\s*$)/g,"");
	}
	
    /***
	设置排序码
	*/
	function setOrder(id,processId,sort){
		$.dialog.whir_prompt(
			'<s:text name="workflow.pleaseinputsort"/>', 
			 function(val){ 
			      var url="<%=rootPath%>/ezflowprocess!setOrder.action?id="+id+"&sort="+val;
				  
				  if(val==""){
					 $.dialog.alert('<s:text name="workflow.pleaseinputnum"/>');
				     return false;
				  }
				  if(val.trim()==""){
					   $.dialog.alert('<s:text name="workflow.pleaseinputnum"/>');
				     return false;
				  }
				  if(isNaN(val)){
					 $.dialog.alert('<s:text name="workflow.pleaseinputnum"/>');
		             return false; 
	              } 
				  if(val.indexOf(".") >= 0){
					  $.dialog.alert('<s:text name="workflow.pleaseinputnum"/>');
		              return false;
				  }
				  if(val.indexOf("-") >= 0){
					  $.dialog.alert('<s:text name="workflow.pleaseinputnum"/>');
		              return false;
				  }
				  if(val.length>9){
				      $.dialog.alert('<s:text name="workflow.sortistolong"/>');
					  return false;
				  }
				  var result = $.ajax({
				  url: url,
				  async: false
				  }).responseText;
				  refreshListForm('queryForm');
			 }, 
			 sort,
			 '<s:text name="workflow.setsort"/>'
		);
	}
   
    /**
	部署
	*/
	function  deploy(type,id,processId){
		whir_confirm(
			 '<s:text name="workflow.suredeploy"/>',
			 function (){
			   deployResult(type,id,processId);
			 }
		);    
	}

	function   deployResult(type,id,processId){
	    //alert("<%=rootPath%>/ezflowprocess!deploy.action?id=" + id + "&processId=" + encodeURIComponent(processId));
		
	    var result = $.ajax({
		   url: "<%=rootPath%>/ezflowprocess!deploy.action?id=" + id + "&processId=" + encodeURIComponent(processId)+"&subType="+$("#subType").val()+"&moduleId="+$("#moduleId").val(),
		   async: false
	    }).responseText;
	    if(result=="-1"){
		    whir_alert('<s:text name="workflow.deployfailed"/>',function(){});
	    }else if(result=="-2"){
		    whir_alert('<s:text name="workflow.deployfailed"/>',function(){});
	    }else if(result=="-3"){
		    whir_alert('流程设置中有子流程不存在，请检查！',function(){});
	    }else{
		    whir_alert('<s:text name="workflow.deploysuccess"/>',function(){});
	    }				  
	    refreshListForm_('queryForm');
	}
    
	/**
	刷新 
	*/
	function  refreshListForm_setName(name){
	   $("#processName").val(name);
	   refreshListForm('queryForm');
	}


    /**
	刷新 
	*/
	function  refreshListForm_default(){
	   refreshListForm_('queryForm');
	}
    
	/**
	导入
	*/
	function importProcess(){ 
       var url="<%=rootPath%>/ezflowprocess!importProcess.action?moduleId="+$("#moduleId").val();
	   if($("#choosed_processPackage").val()!=""){
		   url+="%26choosed_processPackage="+encodeURIComponent(encodeURIComponent($("#choosed_processPackage").val()))+"%26choosed_processPackageName="+encodeURIComponent(encodeURIComponent($("#choosed_processPackageName").val()));
	   } 
	   excelImport( {  importer:url ,    title: '文件导入' ,filetype:'*.xml' } );
	}
    
	/**
	
	*/
	function  copeProcess(){
	    ajaxBatchOperate({url:"<%=rootPath%>/ezflowprocess!copyProcess.action",checkbox_name:"id",attr_name:"id",tip:"",isconfirm:true,formId:"queryForm",callbackfunction:null});
	}

	/**
	导出
	*/
	function exportProcess(){
		var ids= getCheckBoxData("id","processId");
		if(ids==""){
		  whir_alert('<s:text name="workflow.pleasechoosedata"/>',function(){});
		  return false;
		}
		$("#batchIds").val(ids);
		document.queryForm.action="<%=rootPath%>/ezflowprocess!export.action";
		//queryForm.target="_blank";
        document.queryForm.submit();

		document.queryForm.action="<%=rootPath%>/ezflowprocess!list.action";
	}

	 /**
	  选中的分类事件
	 */
	 function  setPackageInfo(){
		  var _processPackage1="";
		  var _processPackageName1="";
		  $('input:checkbox[name="processPackage_checbox"]:checked').each(function(){					 
			   if($(this).attr("checked")=="checked"){
				   _processPackage1+=$(this).val()+",";
				   _processPackageName1+=$(this).attr("displaytext")+",";
			   }			 
		  }); 
		  if(_processPackage1!==""&&_processPackage1.substring(_processPackage1.length-1)==","){
			  _processPackageName1=_processPackageName1.substring(0,_processPackageName1.length-1);
			  _processPackage1=_processPackage1.substring(0,_processPackage1.length-1);
		 } 
		 $("#processPackageDisName").html(_processPackageName1);
		 $("#choosed_processPackage").val(_processPackage1);
		 $("#choosed_processPackageName").val(_processPackageName1);		
	 } 
   </script>
</html>