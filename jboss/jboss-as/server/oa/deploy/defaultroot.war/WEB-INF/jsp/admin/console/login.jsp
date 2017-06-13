<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.i18n.Resource" %>
<%
String localeCode = "zh_CN";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ezOFFICE 管理控制台</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Bootstrap -->
    <link href="<%=rootPath%>/images/console/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="<%=rootPath%>/images/console/bootstrap/font-awesome.css" rel="stylesheet" />
    <link href="<%=rootPath%>/images/console/bootstrap/css.css?family=Abel|Open+Sans:400,600" rel="stylesheet" />

    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="<%=rootPath%>/scripts/plugins/bootstrap/3.1.1/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="<%=rootPath%>/scripts/plugins/bootstrap/3.1.1/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="<%=rootPath%>/scripts/plugins/bootstrap/3.1.1/respond.js/1.4.2/respond.min.js1"></script>
    <![endif]-->
</head>
<body>

    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3 panel panel-default">

                <h3 class="margin-base-vertical">ezOFFICE 管理控制台</h3>

                <form id="LogonForm" name="LogonForm" class="margin-base-vertical" action="Logon!logon.action" method="post" target="_self" onsubmit="return checkInput();">
                    <input type="hidden" name="reurl" value="Console!init.action"/>
                    <input type="hidden" name="domainAccount" value="whir"/>
                    <p class="input-group">
                        <span class="input-group-addon"><span class="icon-user">&nbsp;账号</span></span>
                        <input type="text" class="form-control input-lg" name="userAccount" placeholder="" maxlength="60" value="<%=request.getParameter("userAccount")!=null?request.getParameter("userAccount"):""%>"/>
                    </p>
                    <p class="input-group">
                        <span class="input-group-addon"><span class="icon-lock">&nbsp;密码</span></span>
                        <input type="password" class="form-control input-lg" name="userPassword" placeholder="" maxlength="60" value="<%=request.getParameter("userPassword")!=null?request.getParameter("userPassword"):""%>"/>
                    </p>
                    <p class="help-block text-center"></p>
                    <p class="text-center">
                        <button type="submit" class="btn btn-primary btn-lg btn-block logonfont">登录</button>
                    </p>
                    </span>
                </form>

                <div class="margin-base-vertical">
                    <small class="text-muted"></small>
                </div>

            </div><!-- //main content -->
        </div><!-- //row -->
    </div> <!-- //container -->

    <div id="footer">
        <p><!--Copyright &copy; 2014 万户网络 All Rights Reserved.--></p>
    </div>

    <script src="<%=rootPath%>/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/plugins/bootstrap/3.1.1/common.js"></script>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
$(function(){
    $(window).bind("load", function(){
        popTip("<%=request.getAttribute("errorType")!=null?(String)request.getAttribute("errorType"):""%>");
    });
});
//-->
</SCRIPT>