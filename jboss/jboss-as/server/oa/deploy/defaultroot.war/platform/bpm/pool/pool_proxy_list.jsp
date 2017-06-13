<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=Resource.getValue(whir_locale, "personalwork", "personalwork.workagent")%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<s:form name="queryForm1" id="queryForm1" action="/bpmproxy!list.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <s:hidden  name="from" id="from" /> 
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar"  >  
        <tr>
            <td class="whir_td_searchtitle2"><%=Resource.getValue(local,"personalwork","agent.Agent")%>：</td>
            <td class="whir_td_searchinput">
			 <s:textfield id="proxyEmpName" name="proxyEmpName" size="16" cssClass="inputText" />
            </td>
			<td class="whir_td_searchtitle2"><%=Resource.getValue(local,"personalwork","agent.status")%>：</td>
            <td class="whir_td_searchinput">
			 
			  <s:select name="proxystate" id="proxystate" list="#{'':'--'+getText('commonuse.Pleaseselect')+'--','1':getText('agent.valid2'),'0':getText('agent.invalid2')}" listKey="key"  listValue="value"   cssClass="selectlist" cssStyle="width:200px;height:29px;"   /> 
            </td>
            <td  class="SearchBar_toolbar">
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm1');"  value='<s:text name="comm.searchnow"/>' />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />
            </td>
        </tr>
 
		
    </table>
	<!-- SEARCH PART END -->
   
   <!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			 <td align="right" width="55%">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right">
                <input type="button" class="btnButton4font" onclick="add1();" value='<bean:message bundle="common" key="comm.add"/>' />
                <input type="button" class="btnButton4font" onclick="ajaxBatchDelete_real(this);" value='<s:text name="comm.delselect"/>' />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'id',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState4J({checkbox_name:'id',state:this.checked,rangeId:'queryForm1'});" ></td>
			<td whir-options="field:'proxyEmpName',width:'7%'" nowrap><%=Resource.getValue(local,"personalwork","agent.Agent")%></td> 
			<td whir-options="field:'empName',width:'7%'" nowrap ><%=Resource.getValue(local,"personalwork","agent.Persontobeagent")%></td> 
			<td whir-options="field:'beginTime',width:'18%',renderer:common_DateFormatM"><bean:message bundle="personalwork" key="agent.begin"/></td> 
			<td whir-options="field:'endTime',width:'18%',renderer:common_DateFormatM"><bean:message bundle="personalwork" key="agent.end"/></td> 
			<td whir-options="field:'proxyState',width:'10%',renderer:showWFStatus"><bean:message bundle="personalwork" key="agent.status"/></td> 
			<td whir-options="field:'wfChannelReadName',width:'10%',renderer:showList1"><bean:message bundle="personalwork" key="agent.agentlist"/></td> 
			<td whir-options="field:'createEmpName',width:'8%'"><%=Resource.getValue(local,"personalwork","agent.Creator")%></td> 
			<td whir-options="field:'createTime',width:'12%',renderer:common_DateFormatM"><%=Resource.getValue(local,"personalwork","agent.CreateTime")%></td> 
			<td whir-options="field:'',width:'8%',renderer:myOperate1"> <bean:message bundle="common" key="comm.opr" /> </td> 
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
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	 $(document).ready(function(){	
		initListFormToAjax({formId:"queryForm1"});
	});

    //
	function  leftIframeInit(){
	    initListFormToAjax({formId:"queryForm1"});
	}


    //批量删除
	function  ajaxBatchDelete_real(obj){ 
		 ajaxBatchDelete('<%=rootPath%>/bpmproxy!delete.action?from='+$("#from").val(),'id','id',obj);
	}

 
	//自定义操作栏内容
	function myOperate1(po,i){
		var html =  '<a href="javascript:void(0)" onclick="modify1(\''+po.id+'\',\''+po.verifyCode+'\');"><img src="<%=rootPath%>/images/modi.gif" title=\'<s:text name="comm.supdate"/>\' style="cursor:hand"  ></a><a href="javascript:void(0)" onclick="ajaxDelete(\'${ctx}/bpmproxy!delete.action?id='+po.id+'&from='+$("#from").val()+'&verifyCode='+po.verifyCode+'\',this);"><img src="<%=rootPath%>/images/del.gif" title=\'<bean:message bundle="information" key="info.alldelete" />\' style="cursor:hand"  ></a>';
		return html;
	}
    
	//显示开始时间
	function  showWFStatus(po,i){
	    if(po.proxyState=="1"){
			return '<s:text name="agent.valid2"/>';
		}else{
			return '<s:text name="agent.invalid2"/>';
		}
	}
     
	function showList1(po,i){
		var html ='<a  href="javascript:void(0)" onclick="proxyList1(\''+po.empId+'\',\''+po.proxyEmpId+'\');"><bean:message bundle="personalwork" key="agent.agentlist"/></a>' ;
		return html;	
	}
    
	function  modify1(id,verifyCode){
	   var url="<%=rootPath%>/bpmproxy!modify.action?id="+id+"&verifyCode="+verifyCode+"&from="+$("#queryForm1  #from").val();
	   openWin({url:url,isFull:true,width:700,height:360,winName:'modifyWorkProxy'});
	   return null;
	}
    
	/**
	  empId:  被代理人
      proxyEmpId:代理人
	*/
	function proxyList1(empId,proxyEmpId){
	    var url="<%=rootPath%>/wfmyflow!mybeStand.action?wfCurEmployeeId="+proxyEmpId+"&proxyEmpId="+empId;
 
	    openWin({url:url,isFull:true,width:700,height:360,winName:'modifyWorkProxy'});
	    return null;
	}

	function  add1(){
		var url='<%=rootPath%>/bpmproxy!add.action?from='+$("#queryForm1  #from").val(); 
	    openWin({url:url,isFull:true,width:700,height:360,winName:'addproxy1'});
	}
     

	function common_DateFormatM(datestr){
		if(datestr.length > 16){
			return datestr.substring(0,16);
		}
		return datestr;
    }
 
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
   </script>
</html>

