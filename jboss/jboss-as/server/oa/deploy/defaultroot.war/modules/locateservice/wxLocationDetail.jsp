<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
 String id = request.getAttribute("id").toString();
 String date = (String)request.getAttribute("date");
 if(date.length()>10){
 	date = date.substring(0,10);
 }
%>
<head>
	<title>定位详细</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">

	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="${ctx}/WXLocationAction!wxLocationDetailListData.action" method="post" theme="simple">
	
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

	<input type="hidden" name="id" value="<%=id%>"/>
	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable" style="margin-top:10px;">
		<tr>
			<td width="12%">定位人员： </td>  
			<td width="38%">
				<span><%=request.getAttribute("username") %></span>
			</td>
			<td width="12%">定位日期：</td> 
			<td width="38%">
				<span><%=date %></span>
			</td>
		</tr>
		<tr>
			<td colspan="4">定位记录： </td>  
		</tr>
		<tr>
			<td colspan="4">
				<!-- LIST TITLE PART START -->	
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
					<!-- thead必须存在且id必须为headerContainer -->
					<thead id="headerContainer">
					<tr class="listTableHead">
						<td whir-options="field:'presentTime',renderer:updateDate,width:'15%'">时间</td> 
						<td whir-options="field:'presentAddress',width:'40%'">位置</td> 
						<td whir-options="field:'picture',renderer:viewPic,width:'15%'">图片</td> 
						<td whir-options="field:'remark',width:'30%'">备注</td>
					</tr>
					</thead>
					<!-- tbody必须存在且id必须为itemContainer -->
					<tbody  id="itemContainer" align="center">
					
					</tbody>
				</table>
			</td>
		</tr>
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
			date = date.substring(11,16);
		}
		return date;
	}

	function viewPic(po,i){
		var picName = po.picture;
		var html = "";
		if(picName!=null && picName!="" && picName!=undefined){
			var pic = picName.split(",");
			for(var i=0;i<pic.length;i++){
				var fold = pic[i].substring(0,6);
				html +=  '<a href="javascript:void(0)" onclick="javascript:openWin({url:\'/defaultroot/upload/phonekq/'+fold+'/'+pic[i]+'\',width:600,height:400,winName:\'图片详情\'});">'+(i+1)+'</a>';
				html += "，"
			}
			html = html.substring(0,html.length-1);
		}
		return html;
	}
   </script>
</html>
