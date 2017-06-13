<%@ taglib uri="/WEB-INF/tag-lib/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/tag-lib/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tag-lib/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tag-lib/struts-template.tld" prefix="template" %>
<%@ taglib uri="/WEB-INF/tag-lib/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tag-lib/struts-html.tld" prefix="html" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%
	 String  rootPath=com.whir.component.config.PropertiesUtil.getInstance().getRootPath();
	 if(!com.whir.common.util.CommonUtils.isForbiddenPad(request)){
	 	out.write("该页面不支持在PAD上显示，请于PC端查看。");
	 	return;
	 }
%>

<SCRIPT LANGUAGE="JavaScript">

var CommonJSResource = new Object();
CommonJSResource = {
	rootPath:"<%=rootPath%>"
}

</SCRIPT>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %><%!
  /**
   * 功能或作用：格式化日期时间
   * @param DateValue 输入日期或时间
   * @param DateType 格式化 EEEE是星期, yyyy是年, MM是月, dd是日, HH是小时, mm是分钟,  ss是秒
   * @return 输出字符串
   */
  public String FormatDate(String DateValue,String DateType)
  {
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;
  }
%>
<%
  ResultSet result=null;
  String mSubject=null;
  String mStatus=null;
  String mAuthor=null;
  String mFileDate=null;
  String mFileName ="测试文档";

  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="pdfserverservlet"; //"public/iWebPDF/PDFServer.jsp";

  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;//取得OfficeServer文件的完整URL
  String mHttpUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/";

  String mRecordID=request.getParameter("RecordID");
  String mUserName=request.getParameter("UserName");//new String(request.getParameter("UserName").getBytes("8859_1"));

  //取得编号
  if ( mRecordID==null)
  {
     mRecordID="";	//编号为空
  }
  //取得用户名
  if (mUserName==null)
  {
    mUserName="金格科技";
  }

  //打开数据库
  DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
  if (DbaObj.OpenConnection())
  {
    String mSql="Select * From pdfDocument Where RecordID='"+ mRecordID + "'";
    try
    {
      result=DbaObj.ExecuteQuery(mSql);
      if (result.next())
      {
        mRecordID=result.getString("RecordID");
        mSubject=result.getString("Subject");
        mAuthor=result.getString("Author");
        mFileDate=result.getString("FileDate");
        mStatus=result.getString("Status");
      }
      else
      {
	//取得唯一值(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
	//初始化值
        mRecordID=ld.toString();//保存的是文档的编号，通过该编号，可以在里找到所有属于这条纪录的文档
        mSubject="请输入主题";
        mAuthor=mUserName;
        mFileDate=DbaObj.GetDateTime();
        mStatus="DERF";
      }
      result.close();
    }
    catch(SQLException e)
    {
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }
%>

<html>
<head>
<title>金格iWebPDF示例程序</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel='stylesheet' type='text/css' href='test.css'>



<script src="/defaultroot/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
<!--
<script language="javascript" for=WebPDF event="OnOpen()">
  alert("打开成功");
</script>

<script language="javascript" for=WebPDF event="OnClose()">
  alert("关闭成功");
</script>
-->
<script language=javascript for=WebPDF event=OnToolsClick(vIndex,vCaption)>
if (vIndex==102){
	SaveDocument();////alert(1);
	webform.submit();
	  alert('保存成功！');
}
if (vIndex==103){
  try{
	if(!webform.WebPDF.WebSave()){
		
			if(confirm("是否保存对文档的修改？")){
			
				//icountCloseVal++;
				SaveDocument();
			
				//document.all.webform.IsOut.value="1";
				//document.all.webform.submit();
				//alert(1);
			//	$("*[name='IsOut']").val("1");
				
		  		$("*[name='webform']").submit();
		  		
			} else {
				//icountCloseVal++;
				
				window.close();
			}
		
			window.close();
	} else{
		    window.close();
	}
 }catch(e){
	
		if(confirm("是否保存对文档的修改？")){
			//icountCloseVal++;
		  SaveDocument();
		  $("*[name='webform']").submit();
		 // document.all.webform.submit();
		} else {
			//icountCloseVal++;
		  window.close();
		}

 }
}
</script>
<script language=javascript>
/*
form表单名称:webform
iWebPDF名称:WebPDF
*/

//作用：显示操作状态
function StatusMsg(mString){
  //webform.StatusBar.value=mString;
}

//作用：载入iWebPDF
function Load(){
  try{

    //以下属性必须设置，实始化iWebPDF
    webform.WebPDF.WebUrl="<%=mServerUrl%>";    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档 
    webform.WebPDF.RecordID="<%=mRecordID%>";   //RecordID:本文档记录编号
    webform.WebPDF.FileName="<%=mFileName%>";   //FileName:文档名称
    webform.WebPDF.UserName="<%=mUserName%>";   //UserName:操作用户名

    webform.WebPDF.ShowTools = 0;               //工具栏可见（1,可见；0,不可见）
    webform.WebPDF.SaveRight = 0;               //是否允许保存当前文档（1,允许；0,不允许）
    webform.WebPDF.PrintRight = 0;              //是否允许打印当前文档（1,允许；0,不允许）
    webform.WebPDF.AlterUser = false;           //是否允许由控件弹出提示框 true表示允许  false表示不允许

    webform.WebPDF.ShowBookMark = 0;			//是否显示书签树按钮（1,显示；0,不显示）
    webform.WebPDF.ShowSigns = 0;         	    //设置签章工具栏当前是否可见（1,可见；0,不可见）
    //alert(webform.WebPDF.SideWidth);          //显示侧边栏的宽度
    webform.WebPDF.SideWidth = 100;             //设置侧边栏的宽度

    webform.WebPDF.WebOpen();                   //打开该文档    交互OfficeServer的OPTION="LOADFILE"    <参考技术文档>
	//alert(webform.WebPDF.Status);
    StatusMsg(webform.WebPDF.Status);           //状态信息

    webform.WebPDF.Zoom = 100;                  //缩放比例
    webform.WebPDF.Rotate = 360;                //当显示页释放角度
    webform.WebPDF.CurPage = 1;                 //当前显示的页码

	webform.WebPDF.AppendTools("102",'保存',2);
	webform.WebPDF.AppendTools("103",'返回办公系统',7);
  }catch(e){
    alert(e.description);                       //显示出错误信息
  }
}

//作用：退出iWebPDF
function UnLoad(){
  try{
    if (!webform.WebPDF.WebClose()){
      StatusMsg(webform.WebPDF.Status);
    }else{
      StatusMsg("关闭文档...");
    }
  }catch(e){
    alert(e.description);
  }
}

//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  if (!webform.WebPDF.WebOpen()){               //打开该文档    交互OfficeServer的OPTION="LOADFILE"
    StatusMsg(webform.WebPDF.Status);
  }else{
    StatusMsg(webform.WebPDF.Status);
  }
}

//作用：保存文档
function SaveDocument(){
//	alert( webform.WebPDF.WebSave() );
  //webform.WebPDF.WebSetMsgByName("mydefine1","自定义变量值");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSave()时，一起提交到OfficeServer中
  if (!webform.WebPDF.WebSave()){               //交互OfficeServer的OPTION="SAVEFILE"
    StatusMsg(webform.WebPDF.Status);
    return false;
  }else{
	  webform.WebPDF.WebObject.Saved = true;
    StatusMsg(webform.WebPDF.Status);
    return true;
  }
}

//作用：关闭文档
function WebClose(){
  try{
    webform.WebPDF.WebClose();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：保存本地文档
function WebSaveLocal(){
  try{
    webform.WebPDF.WebSaveLocal();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：打开本地文档
function WebOpenLocal(){
  try{
    webform.WebPDF.WebOpenLocal();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：打印文档控制打印份数
function WebPrintCtrl(Ctrl){
  try{
	webform.WebPDF.WebPrint(Ctrl,"",1,webform.WebPDF.PageCount,true);
    StatusMsg(webform.WebPDF.Status);
  }
  catch(e){
    alert(e.description);
  }
}

//作用：翻至第一页
function WebGotoFirstPage(){
  try{
    webform.WebPDF.GotoFirstPage();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：翻至最后一页
function WebGotoLastPage(){
  try{
    webform.WebPDF.GotoLastPage();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：翻至前一页
function WebGotoPreviousPage(){
  try{
    webform.WebPDF.GotoPreviousPage();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：翻至后一页
function WebGotoNextPage(){
  try{
    webform.WebPDF.GotoNextPage();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：获取当前文档页数
function WebPageCount(){
  try{
    var mCount = webform.WebPDF.PageCount;
    alert("当前文档总页数为："+mCount)
  }catch(e){
    alert(e.description);
  }
}

//作用：当前显示模式（1 单页 2 双页 3 连续单页(默认) 4 连续双页）
function WebDisplayMode(mValue){
  try{
    webform.WebPDF.DisplayMode = mValue;
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用:禁用,启用全部功能按钮(参数ToolsName:按钮的名称;mValue:true启用 flase禁用)
function WebEnableTools(ToolNames,mValue){
  try{
    webform.WebPDF.EnableTools(ToolNames,mValue);
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description)
  }
}

//作用：通过Url打开文档
function WebOpenUrlFile(mUrl){
  try{
    webform.WebPDF.WebOpenUrlFile(mUrl);
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：下载指定文件
function WebDownLoadFile(mUrl,mFileName){
  try{
    webform.WebPDF.WebDownLoadFile(mUrl,mFileName);
    alert("下载保存成功，保存地址为C:\\123.pdf。");
  }catch(e){
    alert(e.description);
  }
}

//作用：客户端和服务器端信息交互
function WebSendInformation(){
  var info = window.prompt("请输入要传到服务器处理页面上的内容:","参数内容");
  if (info==null){return false}

  webform.WebPDF.WebSetMsgByName("COMMAND","SELFINFO");     //设置变量COMMAND="SELFINFO"，用来在服务器端做判断，以进入处理自定义参数传递的代码。
  webform.WebPDF.WebSetMsgByName("TESTINFO",info);          //自定义的一个参数"TESTINFO"，将info变量的信息设置到信息包中，以便传到后台。
  if (webform.WebPDF.WebSendMessage()){                     //向后台发信息包。交互OfficeServer的OPTION="SENDMESSAGE"。
    info = webform.WebPDF.WebGetMsgByName("RETURNINFO");    //如果交互成功，接受服务器端返回的信息。
    alert(info);
  }
  else{
    StatusMsg(webform.WebPDF.Status);
  }
}


//作用：在PDF文档中增加水印
function WebSetWateMark(mText){
  try{
    var mPageCount = webform.WebPDF.PageCount;                              //webform.WebPDF.PageCount获得当前总页数
    if (webform.WebPDF.EditStatus){                                         //获取当前PDF文档状态，可以允许更改的文档就可以执行水印写操作
      webform.WebPDF.WateMark(1,mPageCount,mText,25,125,45,true,-1,-1);     //设置水印。参数一：开始页；参数二：结束页；参数三：水印文本；参数四：透明度；参数五：字体大小；参数六：旋转角度（逆时针）；参数七：水印位置；参数八：水印X坐标；参数九：水印Y坐标。
      //alert("该PDF文档允许编辑，增加水印成功");
    }else{
      alert("该PDF文档不允许编辑，无法增加水印");
    }
  }catch(e){
    alert(e.description);                                       //显示出错误信息
  }
}

//=====================iSignature PDF电子签章相关接口========================================


//作用：调用签章窗体
function WebShowSignDlg(){
  if (!(webform.WebPDF.ShowSignDlg())){
    alert("调用签章窗体失败");  
  }
}

//作用：调用批量验证
function WebShowCheckDlg(){
  if (!(webform.WebPDF.ShowCheckDlg())){
    alert("调用批量验证失败");  
  }
}

//作用：调用参数设置窗体
function WebShowParamDlg(){
  if (!(webform.WebPDF.ShowParamDlg())){
    alert("调用参数设置窗体失败");  
  }
}

//作用：获取签章XML数量（UTF-8码）
function WebSignatureItem(){
  alert(webform.WebPDF.SignatureItem(-1));
}

//作用：获取文档中签章数据XML
function GetSignatureItemsXML(){
  var i;
  var LoadOk;
  var ErrorObj;
  var XmlObj = new ActiveXObject("Microsoft.XMLDOM");
  var XmlText;
  
  XmlObj.async = false;
  LoadOk=XmlObj.loadXML(webform.WebPDF.SignatureItem(-1));
  //alert(webform.WebPDF.SignatureItem());
  ErrorObj = XmlObj.parseError;
  if (ErrorObj.errorCode != 0){
    alert("返回信息错误..." + ErrorObj.reason);
  }
  else{
    var CurNodes=XmlObj.getElementsByTagName("Signature_PDF");
    if( 1 == CurNodes.length ){
      var SignNode=CurNodes.item(0);
      if( SignNode.hasChildNodes() ){
        var SignNodes = SignNode.childNodes;
        for (var iXml=0;iXml<SignNodes.length;iXml++){
          var signItem = SignNodes.item(iXml);
          XmlText = "签章是否保护文档：" + signItem.selectSingleNode("SignatureProtect").text + ";    True: 文档改动签章会变化；False: 文档改动签章不会变化\r\n";
          XmlText = XmlText + "文档是否完整：" + signItem.selectSingleNode("SignatureResult").text + ";    True: 文档完整；False: 文档不完整\r\n";
          XmlText = XmlText + "签章名称：" + signItem.selectSingleNode("SignatureName").text + ";\r\n";
          XmlText = XmlText + "签章应用程序：" + signItem.selectSingleNode("SignatureApp").text + ";\r\n";	
          XmlText = XmlText + "签章单位：" + signItem.selectSingleNode("SignatureUnit").text + ";\r\n";	
          XmlText = XmlText + "签章用户：" + signItem.selectSingleNode("SignatureUser").text + ";\r\n";
          XmlText = XmlText + "签章存在钥匙盘序列号：" + signItem.selectSingleNode("SignatureKeySN").text + ";\r\n";
          XmlText = XmlText + "签章序列号：" + signItem.selectSingleNode("SignatureSN").text + ";\r\n";
          XmlText = XmlText + "签章时间：" + signItem.selectSingleNode("SignatureDate").text + ";\r\n";
          XmlText = XmlText + "签章类型：" + signItem.selectSingleNode("SignatureType").text + ";    签章类型，0：没有进行签章，1：电子签章，2：手写签章，3：二维条码\r\n";
          XmlText = XmlText + "文档锁定：" + signItem.selectSingleNode("SignatureLocked").text + ";    True:如果文档处于锁定状态，是该签章执行的锁定功能; False:如果文档处于锁定状态，不是该签章执行的锁定功能\r\n";
          alert(XmlText);
        }
      }
    }
  }
  delete XmlObj;
}

//作用：将页面跳转至指定名称的书签位置(返回值为非零表示成功定位，零表示查找指定名称的书签失败)
function WebGotoBookMark(){
  try{
    var mBookMark = window.prompt("请输入要跳转到的书签名称","书签名称");
    if(mBookMark==null){return false;}
    webform.WebPDF.GotoBookMark(mBookMark);
  }catch(e){
    alert(e.description); 
  }
}

//作用:控制页面是否显示(参数Pages:页面范围;Enable:true显示 flase不显示;Text显示的文字)
function WebEnablePages(){
  try{
    alert("示例中将禁止显示第一页的内容");
    webform.WebPDF.EnablePages(1,false,"第一页已被禁止显示");//可以禁止显示多页，如："1-10,15,20"。
  }catch(e){
    alert(e.description)
  }
}

//作用：获取指定代码所代表的错误文本
function WebGetErrorString(){
   try{
     var mCode = window.prompt("请输入想要查询的错误代码，错误代码从“-1”到“32”总共34个。","14");
     if(mCode==null){return false;}
     var mError=webform.WebPDF.GetErrorString(mCode); //通过错误代码获得错误信息。错误代码从“-1”到“32”，总共34个。
     alert("代码对应的错误信息为："+mError);
  }catch(e){
    alert(e.description);
  }
}

//作用：获取指定页的长度、宽度及角度
function WebGetPageSize(){
  try{
    var mWidth = webform.WebPDF.GetPageSize(1,0); //设置页面宽、高、角度。 参数一：开始页；参数二：返回值类型，0：宽度 1：高度 2：旋转角度
    var mHeight = webform.WebPDF.GetPageSize(1,1);
    var meight = webform.WebPDF.GetPageSize(1,2);

    alert("本例中返回第一页的宽度："+mWidth+"；高度："+mHeight+"；旋转角度："+webform.WebPDF.GetPageSize(1,2));
  }catch(e){
    alert(e.description);
  }
}

//作用：判断文档是否打开
function FileisOpen(){
  try{
    var mOpen = webform.WebPDF.isOpen; //返回1为打开；0为没有打开
    if(mOpen==1){
      mOpen = "文档已经打开！";
    }else{
      mOpen = "没有文档被打开！";
    }
    alert(mOpen);
  }catch(e){
    alert(e.description);
  }
}

//作用：获取当前文档中的所有文字内容，该内容可以用来做全文检索
function GetContentText(){
  try{    
    alert(webform.WebPDF.ContentText);
  }catch(e){
    alert(e.description);
  }
}

</script>
</head>
<body bgcolor="#ffffff" onLoad="Load()" onUnload="UnLoad()">  <!--引导和退出iWebPDF-->
<iframe id="targetFrame" name="targetFrame" style="display:none"></iframe>
<form name="webform" method="post" action="DocumentSave.jsp" onSubmit="return SaveDocument();" target="targetFrame">  <!--保存iWebPDF后提交表单信息-->
<input type=hidden name=RecordID value="<%=mRecordID%>">
<input type=hidden name="content" value="<%=mRecordID%>">

<!--<table border=0 cellspacing='0' cellpadding='0' width=100% height=100% align=center class=TBStyle>
      <tr>
        <td height="24" align=center class="TDTitleStyle">主　题</td>
        <td class="TDStyle">&nbsp;<input type="text" name="Subject" value="<%=mSubject%>" class="IptStyle" style="WIDTH:75%">&nbsp;|←请输入主题</td>
        <td width="400" rowspan="4" class="TDTitleStyle" align="center"><input type="submit"  value="保存文档">&nbsp;<input type=button onClick="history.back()" value="返回列表"><br><br>注意：只有进行“保存文档”后，所做的操作才有效！</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">作　者</td>
        <td class="TDStyle">&nbsp;<input type=text name=Author value="<%=mAuthor%>" class="IptStyle"  style="WIDTH:75%">&nbsp;|←请输入作者</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">时　间</td>
        <td class="TDStyle">&nbsp;<input type=text name=FileDate value="<%=mFileDate%>" readonly class="IptStyleBlack" style="WIDTH:75%">&nbsp;|←编辑时间</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">状　态</td>
        <td class="TDStyle">&nbsp;<input type=text name=StatusBar readonly class="IptStyleBlack" style="WIDTH:75%">&nbsp;|←状态信息</td>
      </tr>
      <tr width="100" height="28">
        <td align="center" class="TDTitleMiddleStyle">
          <font color="#FF0000"><b>↓文档阅读功能↓</b></font>	    </td>
        <td height="100%" colspan="2" rowspan="7" align="right" valign="top" class="TDStyle" hegith="90%">
          <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
            <tr>
              <td bgcolor="menu" height="98%" valign="top">
                <!--调用iWebPicture，注意版本号，可用于升级-->
			    <script src="iWebPDF.js"></script>      <!--        </td>
            </tr>
          </table>        </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100" height="90%">
          <input type=button class=SideButton onClick="WebOpenLocal()" value="打开本地文档">
          <input type=button class=SideButton onClick="WebSaveLocal()" value="文档保存本地">
          <input type=button class=SideButton onClick="WebOpenUrlFile('http://www.goldgrid.com/iWebPDF/Demo.pdf')" value="打开Url文档">
          <input type=button class=SideButton onClick="WebClose()" value="关闭当前文档">
          <input type=button class=SideButton onClick="WebGotoFirstPage()" value="翻至最前页">
          <input type=button class=SideButton onClick="WebGotoPreviousPage()" value="向前翻一页">
          <input type=button class=SideButton onClick="WebGotoNextPage()" value="向后翻一页">
          <input type=button class=SideButton onClick="WebGotoLastPage()" value="翻至最后页">
          <input type=button class=SideButton onClick="WebDisplayMode(1)" value="独立单页显示">
          <input type=button class=SideButton onClick="WebDisplayMode(3)" value="连续单页显示">
          <input type=button class=SideButton onClick="WebDisplayMode(2)" value="独立双页显示">
          <input type=button class=SideButton onClick="WebDisplayMode(4)" value="连续双页显示">        </td>
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>↓文档控制功能↓</b></font>	    </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">
          <input type=button class=SideButton onClick="WebEnableTools('打印文档',false)" value="禁止打印按钮">
          <input type=button class=SideButton onClick="WebEnableTools('打开文档;保存文档;另存为;关闭文档;打印文档;实际大小;适应页面;适应高度;向左翻转;向右翻转;文档属性;电子签章;批量验证;文本选择;快照工具;签章参数;搜索文本;关于金格',0)" value="禁止全部按钮">
          <input type=button class=SideButton onClick="WebEnableTools('打开文档;保存文档;另存为;关闭文档;打印文档;实际大小;适应页面;适应高度;向左翻转;向右翻转;文档属性;电子签章;批量验证;文本选择;快照工具;签章参数;搜索文本;关于金格',1)" value="允许全部按钮">
          <input type=button class=SideButton onClick="WebPageCount()" value="获取总页数">
          <input type=button class=SideButton onClick="GetContentText()" value="获取文档内容">
          <input type=button class=SideButton onClick="WebGotoBookMark()" value="跳转指定位置">
          <input type=button class=SideButton onClick="WebEnablePages()" value="禁止显示某页">
          <input type=button class=SideButton onClick="WebGetErrorString()" value="获取错误文本">
          <input type=button class=SideButton onClick="WebGetPageSize()" value="显示页面参数">
          <input type=button class=SideButton onClick="FileisOpen()" value="文档是否打开">
          <input type=button class=SideButton onClick="WebPrintCtrl(3)" value="打印文档控制">
          <input type=button class=SideButton onClick="WebDownLoadFile('http://www.goldgrid.com/iWebPDF/Demo.pdf','C:\\123.pdf')" value="下载指定文件">
          <input type=button class=SideButton onClick="WebSendInformation()" value="无刷新信息交互">
          <input type=button class=SideButton onClick="WebSetWateMark('金格科技')" value="设置水印">        </td>
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>↓电子签章功能↓</b></font>	    </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">
          <input type=button class=SideButton onClick="WebShowSignDlg()" value="电子签章">
          <input type=button class=SideButton onClick="WebShowCheckDlg()" value="批量验证">
          <input type=button class=SideButton onClick="WebShowParamDlg()" value="参数设置">
          <input type=button class=SideButton onClick="WebSignatureItem()" value="电子签章XML">
          <input type=button class=SideButton onClick="GetSignatureItemsXML()" value="获取签章XML"></td>
      </tr>      
    </table>-->
</form>
</body>
</html>