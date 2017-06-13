<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.common.util.CommonUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
 EncryptUtil encryptUtil = new EncryptUtil();
  //String fromtype = request.getParameter("fromtype");
  //String fromtype = encryptUtil.htmlcode(request,"fromtype");
  String fromtype = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("fromtype"));
  //boolean online = com.whir.org.common.util.SysSetupReader.getInstance().hasRtxOnline(session.getAttribute("domainId").toString());
    String searchtype=request.getParameter("searchtype")==null?"":request.getParameter("searchtype").toString();
    searchtype =com.whir.component.security.crypto.EncryptUtil.htmlcode(searchtype);

    request.setAttribute("searchtypeTemp",searchtype);
    //邮件
  String mailId = request.getParameter("mailId");
  String readRatio = (String) request.getAttribute("readRatio");

  String method = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("method"));
  String id = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("id"));

  String titlename="";
  if("innermail".equals(fromtype)){
    titlename=Resource.getValue(whir_locale,"mail","mail.RTXTitle1");
  }else if("gov".equals(fromtype)){
    titlename=Resource.getValue(whir_locale,"mail","mail.RTXTitle2");
  }else if("question".equals(fromtype)){
    titlename=Resource.getValue(whir_locale,"mail","mail.RTXTitle3");
  }else if("information".equals(fromtype)){
    titlename=Resource.getValue(whir_locale,"mail","mail.RTXTitle4");
  }else if("boardroom".equals(fromtype)){
    titlename=Resource.getValue(whir_locale,"mail","mail.RTXTitle5");
  }else if("index".equals(fromtype)){
	titlename=Resource.getValue(whir_locale,"mail","mail.RTXTitle6");
  }else if("interquestion".equals(fromtype)){
    titlename=Resource.getValue(whir_locale,"mail","mail.RTXTitle7");
  }else if("knowledge".equals(fromtype)){
    titlename=Resource.getValue(whir_locale,"mail","mail.RTXTitle8");
  }
  
%>
<title><%=titlename%></title>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<%@ include file="/public/im/onlinejs.jsp"%>
	<title></title>
</head>

<body class="MainFrameBox" >
	<s:form name="queryForm" id="queryForm" action="/defaultroot/realtimemessage!getOnlineDataList.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
	 <br>
     <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
	    <input name="fromtype" type="hidden" value="<%=fromtype%>">
		<input name="mailId" type="hidden" value="<%=mailId%>">
		<input name="method" type="hidden" value="<%=method%>">
		<input name="id" type="hidden" value="<%=id%>">
        <tr>  
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"mail","mail.RTXHead1")%>：</td>  
            <td class="whir_td_searchinput">  
               <input type="text" id="searchOrg" name="searchOrg" class="inputText">  
            </td>  
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"mail","mail.RTXHead2")%>：</td>  
            <td class="whir_td_searchinput">  
                <input type="text" id="searchuserName" name="searchuserName" class="inputText">  
            </td>            			
            <td class="whir_td_searchinput">  
			    <%if(!"index".equals(fromtype)&&!"interquestion".equals(fromtype)){%>
					<%if("question".equals(fromtype)&&"viewbrowserOption".equals(method)){%>
					  
					<%}else{%>
                <select id="searchtype" name="searchtype" style="margin:0px;" class="selectlist">
							<OPTION VALUE="0" <c:if test="${requestScope.searchtypeTemp=='0'}"> selected="true" </c:if> ><%=Resource.getValue(whir_locale,"mail","mail.RTXHead3")%></OPTION>
							<%if("question".equals(fromtype)){%>
                            <OPTION VALUE="1" <c:if test="${requestScope.searchtypeTemp=='1'}"> selected="true" </c:if> ><%=Resource.getValue(whir_locale,"mail","mail.RTXHead8")%></OPTION>
							<OPTION VALUE="2" <c:if test="${requestScope.searchtypeTemp=='2'}"> selected="true" </c:if>><%=Resource.getValue(whir_locale,"mail","mail.RTXHead9")%></OPTION>
							<%}else{%>
							<OPTION VALUE="1"  <c:if test="${requestScope.searchtypeTemp=='1'}"> selected="true" </c:if>><%=Resource.getValue(whir_locale,"mail","mail.RTXHead4")%></OPTION>
							<OPTION VALUE="2" <c:if test="${requestScope.searchtypeTemp=='2'}"> selected="true" </c:if> ><%=Resource.getValue(whir_locale,"mail","mail.RTXHead5")%></OPTION>
							<%}%>
				 </select>
				 <%}%>
			 <%}%>	
            </td>         		
        </tr>  
        <tr>  
            
            <td colspan="5" class="SearchBar_toolbar" align="right">  
                <!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->  
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="<s:text name="comm.searchnow"/>" />  
                <!--resetForm(obj)为公共方法-->  
                <input type="button" class="btnButton4font" value="<s:text name="comm.clear"/>" onclick="resetForm(this);" />
				<%if("index".equals(fromtype)){%>
				<input type="button" class="btnButton4font" value="<bean:message bundle="common" key="comm.sendmail"/>" onclick="openSendMail();" />  
				<%}%>
            </td>  
        </tr>  
    </table>  
	<!-- MIDDLE  BUTTONS START -->  
	   	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">     
	        <tr>  
	            <td align="left">
				  &nbsp;
                 <%if("innermail".equals(fromtype)||
					  "boardroom".equals(fromtype)||
					  "information".equals(fromtype)||
					  "gov".equals(fromtype)||
					  "knowledge".equals(fromtype)){
					  if(readRatio==null) readRatio="";
				  %>
				  <%=readRatio%> <%=Resource.getValue(whir_locale,"mail","mail.RTXHead6")%>
				  <%}else if("index".equals(fromtype)){%>
				  <%=Resource.getValue(whir_locale,"mail","mail.RTXHead7")%><font style="color:#FF0000;font-weight: bold;" ><%=readRatio%></font>人
				  <%}%>
				</td>
				<%if( "information".equals(fromtype) ){%>
				<td id="view_detail" class="SearchBar_toolbar" align="right">
					<input type="button" class="btnButton4font" value="<s:text name="info.viewdetails"/>" onclick="getDetail();" />
				</td>
				<%}%>
	        </tr>  
	    </table>  
	    <!-- MIDDLE  BUTTONS END --> 
		 <%
			  if(realtimemessage_use){
				     if("rtx".equals(realtimemessage_type)){
						 if(online){
	     %>
            <div style="display:none">
			   <img align="absbottom" width="16" height="16" src="<%=rootPath%>/images/rtx/blank.gif" onload="online('');">
		    </div>
		<%}
			}
			 }%>

		
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer"  style="display:">
        <tr  id="original_tr" class="listTableHead">
			<td whir-options="field:'orgname',width:'30%'"><%=Resource.getValue(whir_locale,"mail","mail.RTXHead1")%></td> 
			<td whir-options="field:'userlist', width:'70%',renderer:showuserlist"><%=Resource.getValue(whir_locale,"mail","mail.RTXHead2")%></td>
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
	initListFormToAjax({formId:"queryForm"});
});
  
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//  

function showuserlist(po,i){
	var html = '';
    var userlist = po.userlist.split(",");
	for(var i=0;i<userlist.length-1;i++){
		var users = userlist[i].split("|");

		   var _empId = users[1];
		   var _empName = users[2];
		   var _empSex = users[3];
		   var _empAccounts = users[4];
		   var _gid = users[5];
		   var _notRead="";
		   if(users.length>=7){
			   _notRead = users[6];
		   }
		   var _titlevalue = "";
		   if(users.length>=8){
		     _titlevalue=users[7];
		     if(_titlevalue=="null")_titlevalue="";
		     if(_titlevalue!="") _titlevalue = _titlevalue.substring(0,16);
		   }

		   if(hasonline=="1"){

		   <%
			  if(realtimemessage_use){
				     if("rtx".equals(realtimemessage_type) || "rtx_http".equals(realtimemessage_type)){
	       %>

			              <%if(online){%>
							   html += '<img align="absbottom" width="16" height="16" src="<%=rootPath%>/images/rtx/blank.gif" onload="online(\''+_empAccounts+'\');">';
	
						  <%}else{%>
							  html +='<span onclick="userlist(\''+_empId+'\');" >';
								if(_empSex=="0"){
									html +='<img align="absbottom" width="16" height="16" border=0 src="<%=rootPath%>/images/forumMan.gif" >';
								}else if(_empSex=="1"){
									html += '<img align="absbottom" width="16" height="16" border=0 src="<%=rootPath%>/images/forumWoman.gif" >';
								}
							  html +='</span>';
						   <%}%>

			 <%      }else if("gk".equals(realtimemessage_type)){%>
                          html +='<a href="elava://chat?contact=<%=realtimemessage_zoneID%>.'+_gid+'"><img align="absbottom" width="16" height="16" border=0 src="http://<%=realtimemessage_serverDN%>:<%=realtimemessage_port%>/cgi-bin/chkonline/<%=realtimemessage_zoneID%>.'+_gid+':3"/></a>';

			 <%      }else if("eLink".equals(realtimemessage_type)){%>
                         
						var json = ajaxForSync("<%=rootPath%>/realtimemessage!isLoginInElink.action","empAccounts="+_empAccounts);
						if(eval(json) == 1){
							    html +='<span onclick="EimTest.OpenChatDial(\''+_empAccounts+'\')" >';
								if(_empSex=="0"){
									html +='<img align="absbottom" style="cursor:pointer" width="16" height="16" border=0 src="<%=rootPath%>/images/forumMan.gif" >';
								}else if(_empSex=="1"){
									html +='<img align="absbottom" style="cursor:pointer" width="16" height="16" border=0 src="<%=rootPath%>/images/forumWoman.gif" >';
								}
								html +='</span>';
						}else{
						        html +='<img align="absbottom" style="cursor:pointer" width="16" height="16" src="<%=rootPath%>/images/rtx/blank.gif" onclick="EimTest.OpenChatDial(\''+_empAccounts+'\')" >';
						}

	          <%   
	   			   }
			  
		         }
			  %>
			
             }

               var fontcolor='color:#000000';
			    <%if("index".equals(fromtype)){%>
					html +='<input type="checkbox" name="empChk" value="'+_empId+'|'+_empName+'">';
				<%}else if("information".equals(fromtype)||"gov".equals(fromtype)||"knowledge".equals(fromtype)){%>
                   if(_notRead=='0'){
					 fontcolor = "font-family: '宋体';font-size: 12px;font-weight: normal;color: #C6C6C6;text-decoration: none;";
				   }else{
					 fontcolor = "font-family: '宋体';font-size: 12px;color: #000000;text-decoration: none;font-weight: normal;";
				   }
				<%}else if("interquestion".equals(fromtype)){%>
				  //添加这个判断，设置网上调查模块的已投票为黑，未投票为灰 2016/07/11 
				 var mId='<%=mailId%>';
				 //var method_S='<%=method%>';
				     fontcolor = "font-family: '宋体';font-size: 12px;color: #000000;text-decoration: none;font-weight: normal;";	
				 if(mId=='0'){
				     fontcolor = "font-family: '宋体';font-size: 12px;font-weight: normal;color: #C6C6C6;text-decoration: none;";				 				   
				   } 			
				<%}else{%>
				   var method_S='<%=method%>';				   
                   if(_notRead=='1'){				   
					   
					   fontcolor = "font-family: '宋体';font-size: 12px;font-weight: normal;color: #C6C6C6;text-decoration: none;";	
				   }else{
				       fontcolor = "font-family: '宋体';font-size: 12px;font-weight: normal;color: #000000;text-decoration: none;";		 
				   }
				   if(method_S=="viewbrowserOption"){
				       fontcolor = "font-family: '宋体';font-size: 12px;font-weight: normal;color: #000000;text-decoration: none;";
				   }

				   var form_type= '<%=fromtype%>';
				   if(form_type=="boardroom"){
					   if(_notRead=='1'){
						   fontcolor = "font-family: '瀹嬩綋';font-size: 12px;color: #C6C6C6;text-decoration: none;font-weight: normal;";
					   }else{
						 fontcolor = "font-family: '瀹嬩綋';font-size: 12px;font-weight: normal;color: #000000;text-decoration: none;";
					   }
				   }
				<%}%>
			    html +='<a style="cursor:pointer;'+fontcolor+'" title="'+_titlevalue+'">'+_empName+'</a>&nbsp;&nbsp;';


	}
	

	return html;
}
function openSendMail() {

  var check = $("input:checked");  //得到所有被选中的checkbox
  var ids="";              //定义变量
  var names=""
  check.each(function(i){        //循环拼装被选中项的值
    var _r = $(this).val().split("|");
	
    ids += "$"+_r[0]+"$";
	names += _r[1]+",";
  });
   //alert(ids); alert(names);
   openWin({url:'innerMail!openAddMail.action?empId='+ids+'&empName='+names,isFull:'true',winName: 'openSendMail' });
}

function getDetail() {
	var informaitonid = "<%=id%>";
	var readRatio = "<%=readRatio%>";
	
	location_href("<%=rootPath%>/Information!infodetail.action?fromtype=information&id="+informaitonid+"&readRatio="+encodeURIComponent(readRatio));
}


</script>
</html>

