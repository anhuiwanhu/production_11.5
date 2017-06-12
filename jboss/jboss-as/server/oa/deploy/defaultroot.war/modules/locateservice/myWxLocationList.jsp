<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>我的定位</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">

	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="${ctx}/WXLocationAction!myWxLocationListData.action" method="post" theme="simple">
	
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
		<tr>
			<td class="whir_td_searchtitle">定位时间：</td>
			<td  class="whir_td_searchinput" style="width:10%">
				<input type="text" name="searchStartDate" id="searchStartDate" class="Wdate whir_datebox" onfocus="WdatePicker({el:'searchStartDate',isShowWeek:true})" />
			</td>
			<td class="whir_td_searchtitle">定位地点：</td>
			<td  class="whir_td_searchinput">
				<input type="text" Class="inputText" id="location" name="location" maxlength="20" />
			</td>
			<td class="whir_td_searchtitle">来源：</td>
			<td class="whir_td_searchinput">
				<select id="source" name="source" style="width:50%;">
					<option value=""></option>
				<s:iterator value="#request.modelList" status="status" id="model">
					<option value="<s:property value="#request.modelList[#status.index][0]"/>"><s:property value="#request.modelList[#status.index][1]"/></option>
				</s:iterator>
				</select>
			</td>
		</tr>
		<tr>
			<td class="SearchBar_toolbar" colspan="6">
				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="查　询" />
			</td>
		</tr>
		
		
    </table>
	<!-- SEARCH PART END -->
    
	<!-- 操作按纽栏	-->
	<!--<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">
	    <tr>
	        <td align="right">
	          	<input class="btnButton4font" onclick="excelExport();" value="导出全部" type="button">
				<input class="btnButton4font" onclick="ajaxBatchDelete('/defaultroot/WXLocationAction!batchDelete.action','id','id',this);" value="删除" type="button">
	        </td>
	    </tr>
	</table>-->
	<s:hidden name="numPo.oldYear"/>
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'userName',width:'15%'">姓名</td> 
			<td whir-options="field:'presentTime',renderer:updateDate,width:'15%'">定位时间</td> 
			<td whir-options="field:'presentAddress',width:'30%'">定位地点</td> 
			<td whir-options="field:'attendanceSource',width:'15%',renderer:sourceFrom">来源</td> 
			<td whir-options="field:'record',width:'15%'">签到次数</td> 
			<td whir-options="width:'10%',renderer:myOperate">详细</td>
        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
		<tbody  id="itemContainer" align="center">
		
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
	
	<form id="exportForm" name="exportForm" action="" method="post">
       
    </form>
</body>


	<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){	
		initListFormToAjax({formId:'queryForm'});		
	});

	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
	//自定义操作栏内容
	function myOperate(po,i){
		var html =  '<a href="javascript:void(0)" onclick="javascript:openWin({url:\'/defaultroot/WXLocationAction!wxLocationDetail.action?id='+po.id+'&date='+po.presentTime+'&username='+po.userName+'&orgname='+po.orgName+'\',width:900,height:600,winName:\'详细信息\'});">查看</a>';
		return html;
	}	
	
	function updateDate(po,i){
		var date = po.presentTime;
		if(date.length>10){
			date = date.substring(0,10);
		}
		return date;
	}
	/*
	function excelExport(){
		var username =$('#username').val();
		var orgname =$('#orgname').val();
		var attlocation =$('#location').val();
		var source =$('#source').val();
		var searchStartDate =$('#searchStartDate').val();
		var param = 'username='+username+'&orgname='+orgname+'&searchStartDate='+searchStartDate+'&location='+attlocation+'&source='+source;
	    $('#exportForm').attr('action','WXLocationAction!export.action?'+param);
	    $('#exportForm').submit();
	}*/

	function sourceFrom(po,i){
		var html = '';
		if(po.attendanceSource==1){
			html = "evo客户端";
		}else if(po.attendanceSource==2){
			html = "微信企业号";
		}
		return html;
	}
   </script>

</html>



