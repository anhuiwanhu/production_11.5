<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%> 
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.i18n.Resource" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String local       = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String styleColor=whir_session_skin.substring(whir_session_skin.indexOf("/")+1);

String style=styleColor.substring(0,styleColor.indexOf("-"));
String color=styleColor.substring(styleColor.indexOf("-")+1);

String  style_default="";
String  style_line="";
String  style_pure="";
 
if(style.equals("default")){
	style_default="active";
}
if(style.equals("line")){
	style_line="active";
}
if(style.equals("pure")){
	style_pure="active";
}
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title></title> 
  <link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.reset.min.css" />
  <link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.fa.min.css" />
  <link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.media.min.css" />
  <%//主样式库 %>
  <!-- <link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.style.min.css" /> -->
  <link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/themes/2015/template.theme.min.css" />
  <%//大小  %>
  <!-- <link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.style.size.min.css" /> -->
</head>

<body>
 <s:form name="dataFormSkin" id="dataFormSkin"  action="/defaultroot/MyInfoAction!updateMySkin.action" method="post" theme="simple" > 
  <s:hidden value="%{#request.mySkin}" id="mySkinOld" />
  <s:hidden name="mySkin" id="mySkin"  value="%{#request.mySkin}" /> 
  <!--换肤专用-->
  <input type="hidden"  name="test" id="test" >
  <div class="skin-dialog" data-value="<%=styleColor%>">
    <div class="skin-model clearfix">
      <div id="whSkinImg" class="skin-model-img skin-default" data-value="<%=styleColor%>">
        <span class="<%=styleColor%>"></span>
      </div>
      <div class="skin-section" data-value="<%=style%>">
        <a class="default <%=style_default%>" data-themetype="default" href="javascript:void(0)">
          <i class="fa fa-check-circle"></i>
          <em><s:text name="personalwork.styleSimple"/></em>
          <span></span>
        </a>
        <a class="line <%=style_line%>" data-themetype="line" href="javascript:void(0)">            
          <i class="fa fa-check-circle"></i>
          <em><s:text name="personalwork.styleArtwork"/></em>
          <span></span>
        </a>
        <a class="pure <%=style_pure%>" data-themetype="pure" href="javascript:void(0)">
          <i class="fa fa-check-circle"></i>
          <em><s:text name="personalwork.styleSolid"/></em>
          <span></span>
        </a>
      </div>
    </div>     
    <div class="skin-color clearfix" data-value="<%=color%>">
      <a class="red" data-themecolor="red" href="javascript:void(0)" title="红色"></a>
      <a class="pink" data-themecolor="pink" href="javascript:void(0)"></a>
      <a class="darkred" data-themecolor="darkred" href="javascript:void(0)"></a>
      <a class="orange" data-themecolor="orange" href="javascript:void(0)"></a>
      <a class="lightgreen" data-themecolor="lightgreen" href="javascript:void(0)"></a>
      <a class="green" data-themecolor="green" href="javascript:void(0)"></a>
      <a class="cyan" data-themecolor="cyan" href="javascript:void(0)"></a>
      <a class="seablue" data-themecolor="seablue" href="javascript:void(0)"></a>
      <a class="skyblue" data-themecolor="skyblue" href="javascript:void(0)"></a>
      <a class="blue" data-themecolor="blue" href="javascript:void(0)"></a>
      <a class="violet" data-themecolor="violet" href="javascript:void(0)"></a>
      <a class="purple" data-themecolor="purple" href="javascript:void(0)"></a>
      <a class="indigo" data-themecolor="indigo" href="javascript:void(0)"></a>
      <a class="darkblue" data-themecolor="darkblue" href="javascript:void(0)"></a>
      <a class="maroon" data-themecolor="maroon" href="javascript:void(0)"></a>
      <a class="brown" data-themecolor="brown" href="javascript:void(0)"></a>
      <a class="gray" data-themecolor="gray" href="javascript:void(0)"></a>
      <a class="black" data-themecolor="black" href="javascript:void(0)"></a>
    </div>
    <div class="skin-ok-button clearfix"><span><s:text name="comm.save"/></span></div>
  </div> 
  </s:form>
  <script type="text/javascript">
		var whirRootPath = "<%=rootPath%>";
		var preUrl = "<%=preUrl%>"; 
		var whir_browser = "<%=whir_browser%>"; 
		var whir_agent = "<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(whir_agent)%>"; 
		var whir_locale = "<%=whir_locale.toLowerCase()%>"; 
  </script>
  <script type="text/javascript" src="<%=rootPath%>/scripts/jquery-1.8.0.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>  
	<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>
	<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>  


  <script> 
  function skinThumb(ele,tAll,tName,tColor){
    var tAll,tName,tColor  
    tAll=tName+"-"+tColor;
    $(ele).children('span').removeClass().addClass(tAll);  
    $("#mySkin").val("2015/"+tAll); 
  }

  $(function() {

    $("a[data-themecolor='<%=color%>']").addClass('active'); 
	var themeName= $('.skin-section').data('value');
	var themeColor= $('.skin-color').data('value');
	var theme = $('.skin-dialog').data('value'); 

	$('.skin-section a').on('click',function(){
		$('.skin-section a').removeClass('active');
		$(this).addClass('active');
		themeName = $(this).data('themetype');
		skinThumb('.skin-model-img',theme,themeName,themeColor);
	});

	$('.skin-color a').on('click',function(){
		$('.skin-color a').removeClass('active');
		$(this).addClass('active');
		themeColor = $(this).data('themecolor');
		skinThumb('.skin-model-img',theme,themeName,themeColor);
	});

	$('.skin-ok-button').on('click',function(){
		skinThumb('.skin-model-img',theme,themeName,themeColor); 
		ok(0,this);
	});


	if(initModiForm()){ 
		//设置表单为异步提交
		initDataFormToAjax({"dataForm":'dataFormSkin', "tip":'<s:text name="personalwork.save" />', "callbackfunction":updateMySkinSuccess});
		}
  });


  function  initModiForm(){
	  return true;
  }
 
  var api = frameElement==undefined?null:frameElement.api, W = api==null?null:api.opener; 
  function updateMySkinSuccess(){
		if(api == undefined) {
		} else {
			// W.refreshDisplayList();
			var url = whirRootPath + "/desktop.jsp" +'?date='+Math.random();
			//alert(url);
			api.hide();
			W.top.location_href(url);
			//window.top.location.reload();
			
			// 关闭当前弹出层
			//api.close();
		}
	}

	function closePopup(){
		if(api == undefined) {
		} else {
			// 关闭当前弹出层
			api.close();
		}
	}
  </script>
</body> 
</html> 