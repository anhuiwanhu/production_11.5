<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%
String orgId = session.getAttribute("orgId").toString();
request.setAttribute("now",new java.util.Date());
String empLivingPhoto = request.getParameter("empLivingPhoto")==null?"":request.getParameter("empLivingPhoto");
%>
<!DOCTYPE html>
<html>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>表单页</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.min.css" />
</head>

<body class="theme-green">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page">
          <section class="wh-section wh-section-bottomfixed">
            <article class="wh-edit wh-edit-forum">
              <div>
			  <c:if test="${not empty docXml}">
            	<x:parse xml="${docXml}" var="doc"/>
                <table class="wh-table-edit">
                 <x:forEach select="$doc//fieldList/field" var="fd" >
					<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
					<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
					<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
					<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
						<tr>
							<th>
								<x:out select="$fd/name/text()"/>
								<c:choose>
									<c:when test="${showtype != '401' }">
										<c:if test="${mustfilled == '1' && readwrite == '1'}">
											<i class="fa fa-asterisk"></i>
											</c:if>：
									</c:when>
									<c:otherwise>
										<c:if test="${commentmustnonull == 'true' && readwrite == '1'}">
											<i class="fa fa-asterisk"></i>
										</c:if>：
									</c:otherwise>
								</c:choose>
							</th>
						<td>
						<c:choose>
							<%--单行文本 101--%>
							<c:when test="${showtype =='101' && readwrite =='1'}">
								<c:if test="${fieldtype == '1000000' }">
									<input placeholder="请输入" class="edit-ipt-r" type="number" maxlength="9" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
								</c:if>
								<c:if test="${fieldtype == '1000001' }">
									<input placeholder="请输入" class="edit-ipt-r" type="number" maxlength="18" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
								</c:if>
								<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
									<input placeholder="请输入" class="edit-ipt-r" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
								</c:if>
							</c:when>
							<%--密码输入 102--%>
							<c:when test="${showtype =='102' && readwrite =='1'}">
								<input placeholder="请输入" class="edit-ipt-r" type="password" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
							</c:when>
							<%--单选 103--%>
							<c:when test="${showtype =='103' && readwrite =='1'}">
								<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
								<div class="examine">
									<a class="edit-select edit-ipt-r">
										<div class="edit-sel-show">
											<span>请选择</span>
										</div>    
										<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_main_<x:out select="$fd/sysname/text()"/>' prompt='<x:out select="$fd/value/text()"/>'>
											<option value="">请选择</option>
											<x:forEach select="$fd//dataList/val" var="selectvalue" >
												<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
												<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
											</x:forEach>
										</select>
									</a>
								</div>
							</c:when>
							<%--多选 104--%>
							<c:when test="${showtype =='104' && readwrite =='1'}">
								<c:set var="selectedvalue">,<x:out select="$fd/hiddenval/text()"/></c:set>
								<x:forEach select="$fd//dataList/val" var="selectvalue" >
									<c:set var="curvalue">,<x:out select="$selectvalue/hiddenval/text()"/>,</c:set>
									<input type="checkbox" align="left" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$selectvalue/hiddenval/text()"/>,' <c:if test="${fn:indexOf(selectedvalue, curvalue) > -1}">checked="true"</c:if> style="width:10%;"><x:out select="$selectvalue/showval/text()"/>
								</x:forEach>
							</c:when>
							<%--下拉框 105--%>
							<c:when test="${showtype =='105' && readwrite =='1'}">
								<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
								<di
								v class="examine">
									<a class="edit-select edit-ipt-r">
										<div class="edit-sel-show">
											<span>请选择</span>
										</div>    
										<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_main_<x:out select="$fd/sysname/text()"/>' prompt='<x:out select="$fd/value/text()"/>'>
											<option value="">请选择</option>
											<x:forEach select="$fd//dataList/val" var="selectvalue" >
												<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
												<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
											</x:forEach>
										</select>
									</a>
								</div>
							</c:when>
							<%--日期 107--%>
							<c:when test="${showtype =='107' && readwrite =='1'}">
								<div class="edit-ipt-a-arrow">
									<input placeholder="选择日期" data-dateType="date" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									<label class="edit-ipt-label" for="scroller"></label>
								</div>
							</c:when>
							<%--时间 108--%>
							<c:when test="${showtype =='108' && readwrite =='1'}">
								<div class="edit-ipt-a-arrow">
									<input placeholder="选择时间 " data-dateType="time" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									<label class="edit-ipt-label" for="scroller"></label>
								</div>
							</c:when>
							<%--日期 时间 109--%>
							<c:when test="${showtype =='109' && readwrite =='1'}">
								<div class="edit-ipt-a-arrow">
									<input placeholder="选择日期 时间" data-dateType="datetime" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									<label class="edit-ipt-label" for="scroller"></label>
								</div>								
							</c:when>
							<%--多行文本 110--%>
							<c:when test="${showtype =='110' && readwrite =='1'}">
								<textarea name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" class="edit-txta edit-txta-l" maxlength="300"><x:out select="$fd/value/text()"/></textarea>
								<span class="edit-txta-num"><script>document.write(300-"<x:out select="$fd/value/text()"/>".length);</script></span>
							</c:when>
							<%--自动编号 111--%>
							<c:when test="${showtype =='111' && readwrite =='1'}">
								<x:out select="$fd/value/text()"/>
								<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
							</c:when>
							<%--html编辑 113--%>
							<c:when test="${showtype =='113' && readwrite =='1'}">
								<textarea name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" class="edit-txta edit-txta-l" maxlength="300"><x:out select="$fd/value/text()"/></textarea>
								<span class="edit-txta-num"><script>document.write(300-"<x:out select="$fd/value/text()"/>".length);</script></span>
							</c:when>
							<%--附件上传 115--%>
							<c:when test="${showtype =='115'}">
								<c:if test="${readwrite =='1'}">
									<ul class="edit-upload">
										<li class="edit-upload-in" onclick="addImg('<x:out select="$fd/sysname/text()"/>');"><span><i class="fa fa-plus"></i></span></li>
									</ul>
								</c:if>
								<c:set var="values"><x:out select="$fd/value/text()"/></c:set>
								<c:if test="${not empty values}">
									<%
									String realFileNames ="";
									String saveFileNames ="";
									String moduleName ="customform";
									String aValues =(String)pageContext.getAttribute("values");
									aValues=aValues.replace("&amp;","&");
									System.out.println("aValues----------------->"+aValues);
									String[] aval  = aValues.split(";");
									String[] aval0=new String[0];
									String[] aval1=new String[0];
									if(aval[0] != null && aval[0].endsWith(",")) {
										saveFileNames =aval[0].substring(0, aval[0].length() -1);
										saveFileNames =saveFileNames.replaceAll(",","|");
										System.out.println("saveFileNames----------------->"+saveFileNames);
									}
									if(aval[1] != null && aval[1].endsWith(",")) {
										realFileNames =aval[1].substring(0, aval[1].length() -1);
										realFileNames =realFileNames.replaceAll(",","|");
										System.out.println("realFileNames----------------->"+realFileNames);
									}
									%>
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
										<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
										<jsp:param name="moduleName" value="<%=moduleName%>" />
									</jsp:include>
									<input name="fileNames<x:out select="$fd/sysname/text()"/>" value="${values}" type="hidden"/>
								</c:if>
							</c:when>
							<%--Word编辑 116--%>
							<c:when test="${showtype =='116'}">
								<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
								<c:if test="${not empty filename}">
									<%
									String realFileNames ="";
									String saveFileNames ="";
									String moduleName ="information";
									realFileNames =(String)pageContext.getAttribute("filename")+".doc";
									saveFileNames =(String)pageContext.getAttribute("filename")+".doc";
									%>
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
										<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
										<jsp:param name="moduleName" value="<%=moduleName%>" />
									</jsp:include>
								</c:if>
								<c:if test="${empty filename && readwrite =='1'}">
									该字段暂不支持手机办理，请于电脑端操作。
								</c:if>
							</c:when>
							<%--Excel编辑 117--%>
							<c:when test="${showtype =='117'}">
								<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
								<c:if test="${not empty filename}">
									<%
									String realFileNames ="";
									String saveFileNames ="";
									String moduleName ="information";
									realFileNames =(String)pageContext.getAttribute("filename")+".xls";
									saveFileNames =(String)pageContext.getAttribute("filename")+".xls";
									%>
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
										<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
										<jsp:param name="moduleName" value="<%=moduleName%>" />
									</jsp:include>
								</c:if>
								<c:if test="${empty filename && readwrite =='1'}">
									该字段暂不支持手机办理，请于电脑端操作。
								</c:if>
							</c:when>
							<%--WPS编辑 118--%>
							<c:when test="${showtype =='118'}">
								<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
								<c:if test="${not empty filename}">
									<%
									String realFileNames ="";
									String saveFileNames ="";
									String moduleName ="information";
									realFileNames =(String)pageContext.getAttribute("filename")+".wps";
									saveFileNames =(String)pageContext.getAttribute("filename")+".wps";
									%>
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
										<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
										<jsp:param name="moduleName" value="<%=moduleName%>" />
									</jsp:include>
								</c:if>
								<c:if test="${empty filename && readwrite =='1'}">
									该字段暂不支持手机办理，请于电脑端操作。
								</c:if>
							</c:when>
							<%--登录人信息 --%>
							<c:when test="${( showtype =='213' || showtype =='215'|| showtype =='406'|| showtype =='601'|| showtype =='602'|| showtype =='603'|| showtype =='604'|| showtype =='605'|| showtype =='607'|| showtype =='701'|| showtype =='702'|| showtype =='201'|| showtype =='202' || showtype =='207'  ) && readwrite =='1'}">
								<x:out select="$fd/value/text()"/><input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
							</c:when>
							<%--单选人 全部 210--%>
							<c:when test="${showtype =='210' && readwrite =='1'}">
								<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
								<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user")' placeholder="请选择"/>
							</c:when>

							<%--多选人 全部 211--%>
							<c:when test="${showtype =='211' && readwrite =='1'}">
								<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
								<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user");' placeholder="请选择"/>
							</c:when>

							<%--单选组织 212--%>
							<c:when test="${showtype =='212' && readwrite =='1'}">
								<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
								<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/> 
							</c:when>

							<%--多选组织 214--%>
							<c:when test="${showtype =='214' && readwrite =='1'}">
								<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
								<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/>
							</c:when>
							<%--金额 301--%>
							<c:when test="${showtype =='301' && readwrite =='1'}">
								<c:if test="${fieldtype == '1000000' || fieldtype == '1000001'  }">
									<input class="edit-ipt-r" id='<x:out select="$fd/sysname/text()"/>' type="number" name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="changeMoney('<x:out select='$fd/sysname/text()'/>')" value='<x:out select="$fd/value/text()"/>' />
								</c:if>
								<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
									<input class="edit-ipt-r" id='<x:out select="$fd/sysname/text()"/>' type="text" name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="changeMoney('<x:out select='$fd/sysname/text()'/>')" value='<x:out select="$fd/value/text()"/>' />
								</c:if>
							</c:when>
							<%--批示意见 401--%>
							<c:when test="${showtype =='401' }">
								<x:forEach select="$fd//dataList/comment" var="ct" >
									<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)<br/>
									<c:set var="rfn">
									<x:forEach select="$ct/attachments/file" var="fe" >
										<x:out select="$fe//showName/text()"/>|
									</x:forEach>
									</c:set>
									<c:set var="sfn">
									<x:forEach select="$ct/attachments/file" var="ffe" >
										<x:out select="$ffe//saveName/text()"/>|
									</x:forEach>
										</c:set>
									<c:if test="${not empty sfn}">
										<%
											String realFileNames =(String)pageContext.getAttribute("rfn");
											String saveFileNames =(String)pageContext.getAttribute("sfn");
											String moduleName ="workflow_acc";
											
											realFileNames =realFileNames.substring(0,realFileNames.length() -1);
											saveFileNames =saveFileNames.substring(0,saveFileNames.length() -1);
											
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
												<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
									<c:if test="${not empty accDocXml}">
											<x:parse xml="${accDocXml}" var="accdoc"/>
											<x:forEach select="$accdoc//acc" var="ac" >
												<c:set var="showAc"><x:out select="$ac//accName/text()"/></c:set>
												<c:set var="saveAc"><x:out select="$ac//accSaveName/text()"/></c:set>
												<%
													String realFileNames1 =(String)pageContext.getAttribute("showAc");
													String saveFileNames1 =(String)pageContext.getAttribute("saveAc");
													String moduleName1 ="workflow_acc";
													realFileNames1 =realFileNames1.substring(0,realFileNames1.length());
													saveFileNames1 =saveFileNames1.substring(0,saveFileNames1.length());
													
												%>
												<jsp:include page="../common/include_download.jsp" flush="true">
														<jsp:param name="realFileNames"	value="<%=realFileNames1%>" />
														<jsp:param name="saveFileNames" value="<%=saveFileNames1%>" />
														<jsp:param name="moduleName" value="<%=moduleName1%>" />
												</jsp:include>
											</x:forEach>
									</c:if>
								</x:forEach>
								<c:if test="${readwrite =='1' }">
									<textarea class="edit-txta edit-txta-l" placeholder="请输入" name="comment_input" id="comment_input" maxlength="300"></textarea>
									<div class="examine" style="text-align:right;">
										<a class="edit-select edit-ipt-r">
											<div class="edit-sel-show">
												<span>常用审批语</span>
											</div>    
											<select class="btn-bottom-pop" onchange="selectComment(this);">
												<option value="0">常用审批语</option> 
												 <x:forEach select="$doc//officelist" var="selectvalue" >
													<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
												 </x:forEach>
											</select>
										</a>
									</div>		
									<c:if test="${isEzFlow !='1' || processCommentAcc == 'true' }">
										<ul class="edit-upload">
											<li class="edit-upload-in" onclick="addImg('commentacc');"><span><i class="fa fa-plus"></i></span></li>
										</ul>
									</c:if>
								</c:if>
							</c:when>
							<%--单选人 本组织 704--%>
							<c:when test="${showtype =='704' && readwrite =='1'}">
								<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
								<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
							</c:when>
							
							<%--多选人 本组织 705--%>
							<c:when test="${showtype =='705' && readwrite =='1'}">
								<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
								<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
							</c:when>
							<%--流程发起人 708--%>
							<c:when test="${showtype =='708' && readwrite =='1'}">
								<x:out select="$fd/value/text()"/><input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
							</c:when>
							<%--合计字段 606--%>            
								<c:when test="${showtype =='606'}">
									<c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
									<%
									String exp =(String)pageContext.getAttribute("expressionval");
									String[] newexpArr = exp.split("\\.");
									String  newxp = newexpArr[2];
									String nexp = (String)newxp.substring(0,newxp.length()-1);
									nexp = nexp.replace("$","");
									pageContext.setAttribute("expressionval",nexp);
									%>
									<c:if test="${readwrite == '1'}">
										<input class="edit-ipt-r" placeholder="请输入" id="${expressionval}" type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>'/>
									</c:if>
									<c:if test="${readwrite != '1'}">
										<input class="edit-ipt-r" placeholder="请输入" id="${expressionval}" type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' readonly="readonly"/>
									</c:if>
								</c:when>
							<%--大写字段 302--%>
							<c:when test="${showtype =='302'}">
								<c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
								<%
								String exp =(String)pageContext.getAttribute("expressionval");
								String nexp = exp.replace("$","");
								pageContext.setAttribute("expressionval",nexp);
								%>
								<c:if test="${readwrite == '1'}">
									<input class="edit-ipt-r" placeholder="请输入" id="${expressionval}" type="text" maxlength="18" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>'/>	
								</c:if>
								<c:if test="${readwrite != '1'}">
									<input class="edit-ipt-r" placeholder="请输入" id="${expressionval}" type="text" maxlength="18" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' readonly="readonly"/>	
								</c:if>
							</c:when>
							<%--日期时间计算 808--%>
							<c:when test="${showtype =='808' && readwrite =='1'}">
								该字段暂不支持手机办理，请于电脑端操作。
							</c:when>
							<c:otherwise>
								<x:out select="$fd/value/text()"/>
<%--									<input type="text" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>'  name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r"/>--%>
							</c:otherwise>
						</c:choose>
						</td>
						</tr>
					</x:forEach>
					<!--子表信息begin-->
					<x:forEach select="$doc//subTableList/subTable" var="st">
						<c:set var="subTable"></c:set>
						<x:forEach select="$st/subFieldList" var="ct" varStatus="xh">
							<c:set var="subTable" >${xh.index+1}</c:set>
						</x:forEach>
						<c:set var="subName" ><x:out select="$st/name/text()"/></c:set>
						<c:set var="subTableName" ><x:out select="$st/tableName/text()"/></c:set>
						<input name="subTableName" value="${subTableName}" type="hidden" />
						<input name="subName" value="${subName}" type="hidden" />
						<c:if test="${not empty subName}">
							<tr>
								<th>子表（${subName}）填写：</th>
								<td>
									<input id="subTableInput_${subTableName}" placeholder="添加子表" type="text" class="edit-ipt-r edit-ipt-arrow" 
									<c:if test="${not empty subTable}">value="${subTable}条子表数据"</c:if>
									 readonly="readonly" onclick="addSubTable('${subTableName}');"/>
								</td>
							</tr>
						</c:if>
					</x:forEach>
					<!--子表信息end-->
					<!--批示意见begin-->
					<c:set var="commentField" ><x:out select="$doc//workInfo/commentField/text()"/></c:set>
					<c:set var="actiCommFieldType" ><x:out select="$doc//workInfo/actiCommFieldType/text()"/></c:set>
					<c:if test="${actiCommFieldType != '-1' && (commentField == '-1' || commentField == 'nullCommentField' || commentField == 'autoCommentField' || commentField == 'null') }">
					<tr>
						<th>审批意见：
							<c:if test="${commentmustnonull eq true}">
								<i class="fa fa-asterisk"></i>
							</c:if>
						</th>
						<td>
							<textarea class="edit-txta edit-txta-l" placeholder="请输入文字" name="comment_input" id="comment_input" maxlength="300"></textarea>
							<%--<a href="#" class="edit-slt-r">常用语审批</a>--%>
							<div class="examine" style="text-align:right;">
								<a class="edit-select edit-ipt-r">
									<div class="edit-sel-show">
										<span>常用审批语</span>
									</div>    
									<select class="btn-bottom-pop" onchange="selectComment(this);">
										<option value="0">常用审批语</option> 
										<x:forEach select="$doc//officelist" var="selectvalue" >
											<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
										</x:forEach>
									</select>
								</a>
							</div>
							<c:if test="${isEzFlow !='1' || processCommentAcc == 'true' }">
								<ul class="edit-upload">
									<li class="edit-upload-in" onclick="addImg('commentacc');"><span><i class="fa fa-plus"></i></span></li>
								</ul>
							</c:if>
						</td>
					</tr>
					</c:if>
					<x:forEach select="$doc//commentList/comment" var="ct" >
						<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
						<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
						<tr>
							<th><x:out select="$ct//step/text()"/>：</th>
							<td><x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)<br/>
							<c:set var="rfn">
							<x:forEach select="$ct/attachments/file" var="fe" >
								<x:out select="$fe//showName/text()"/>|
							</x:forEach>
							</c:set>
							<c:set var="sfn">
							<x:forEach select="$ct/attachments/file" var="ffe" >
								<x:out select="$ffe//saveName/text()"/>|
							</x:forEach>
								</c:set>
							<c:if test="${not empty sfn}">
							<%
								String realFileNames =(String)pageContext.getAttribute("rfn");
								String saveFileNames =(String)pageContext.getAttribute("sfn");
								String moduleName ="workflow_acc";
								
								realFileNames =realFileNames.substring(0,realFileNames.length() -1);
								saveFileNames =saveFileNames.substring(0,saveFileNames.length() -1);
								
							%>
							<jsp:include page="../common/include_download.jsp" flush="true">
									<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
									<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
									<jsp:param name="moduleName" value="<%=moduleName%>" />
							</jsp:include>
							</c:if>
							<c:if test="${not empty accDocXml}">
									<x:parse xml="${accDocXml}" var="accdoc"/>
									<x:forEach select="$accdoc//acc" var="ac" >
										<c:set var="showAc"><x:out select="$ac//accName/text()"/></c:set>
										<c:set var="saveAc"><x:out select="$ac//accSaveName/text()"/></c:set>
										<%
											String realFileNames1 =(String)pageContext.getAttribute("showAc");
											String saveFileNames1 =(String)pageContext.getAttribute("saveAc");
											String moduleName1 ="workflow_acc";
											realFileNames1 =realFileNames1.substring(0,realFileNames1.length());
											saveFileNames1 =saveFileNames1.substring(0,saveFileNames1.length());
											
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames1%>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames1%>" />
												<jsp:param name="moduleName" value="<%=moduleName1%>" />
										</jsp:include>
									</x:forEach>
							</c:if>
							</td>
						</tr>
					</x:forEach>
                </table>
				</c:if>
              </div>
            </article>
          </section>
        </div>
      </div>
    </div>
  </div>
    <script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
</body>

</html>
