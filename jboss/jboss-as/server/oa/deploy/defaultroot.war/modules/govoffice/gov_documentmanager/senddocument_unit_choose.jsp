<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

int index = 0  ;
int countRecordCount = 0  ;
if(request.getParameter("pager.offset")!=null)
    index=Integer.parseInt(request.getParameter("pager.offset"));
int offset1 = index ;
int pageSize = com.whir.common.util.CommonUtils.getUserPageSize(request);
String orderBy = request.getParameter("orderBy");
String sortType = request.getParameter("sortType");

String field=request.getParameter("field");
String fieldId=request.getParameter("fieldId");

	Object []  unitTypeObj=null;
	if(request.getAttribute("unitType")!=null){
     unitTypeObj=(Object []) request.getAttribute("unitType");
    }

 String unitType=request.getParameter("unitType")==null?"":request.getParameter("unitType").toString();
    String unitName=request.getAttribute("unitName")==null?"":request.getAttribute("unitName").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>单位选择</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body  class="MainFrameBox"  onKeyDown="if(event.keyCode==13) searcher();">
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1"  class="SearchBar">
    <tr>
	  <td width="16" rowspan="5" valign="top"></td>
	  <td>单位分类：&nbsp;
	   <select name="unitType" >
                 <option value="">请选择</option>
		  <%if(unitTypeObj!=null&&unitTypeObj.length>0){
		     for(int i=0;i<unitTypeObj.length;i++){%>
			 <%

			  if(unitTypeObj[i].toString().equals(unitType)){
				 
				 %>
			     
			  	 <option value="<%=unitTypeObj[i].toString()%>" selected><%=unitTypeObj[i].toString()%></option>			 
			 <%}else{	 
			 %>
			 <option value="<%=unitTypeObj[i].toString()%>"><%=unitTypeObj[i].toString()%></option>
			 <%}%>
			<% }
		  }%>
	  </select> </td>
        <td>
            单位名称：&nbsp;
            <input name="unitName" id="unitName" type="text" value="<%=unitName%>" />
        </td>
	  <td align="right">  
	 <input type=button  onClick="searcher();" class="btnButton4font" value="立即查找"/>
     <input type=button  onClick="unsearcher();" class="btnButton4font" value="清　除"/></td>	
	 <td width="16" rowspan="5" valign="top"></td>
	</tr>
</table>

<br>

<table class="SearchBar"><tr><td>

  <form action="GovDocReceiveProcess!chooseUnit.action"  method="post">
   <input type="hidden"  name="field" value="<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(field)%>">
   <input type="hidden"  name="fieldId" value="<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(fieldId)%>">
<table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left">
    	<input type="radio" name="isAllName" value="1" onclick="chooseType('0')" checked/>选用全称  
        <input type="radio" name="isAllName" value="2" onclick="chooseType('1')"/>选用简称
	</td>
  </tr>
</table>

<%
		java.util.List list = (java.util.List)request.getAttribute("mylist");
		java.util.Map map = new java.util.HashMap();
		for(int k=0;k<list.size();k++){
			Object[] obj = (Object[])list.get(k);
			Object[] data = new Object[3];
			data[0] = obj[0];
			data[1] = obj[2];
			data[2] = obj[3];
			java.util.List mylist = new java.util.ArrayList();
			if(map.get(obj[1].toString())!=null){
				java.util.List hasList = (java.util.List)map.get(obj[1].toString());
				mylist.addAll(hasList);
			}
			mylist.add(data);
			map.put(obj[1].toString(),mylist);
		}
	 %>
	 <%
	java.util.Iterator it = map.entrySet().iterator();
	int keyIndex = 0;
	while(it.hasNext()){
		keyIndex++;
		java.util.Map.Entry entry = (java.util.Map.Entry)it.next();
		String key = entry.getKey().toString();
		java.util.List data = (java.util.List)entry.getValue();
	 %>
	   <table WIDTH="95%" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="1" >
	 <tr>
		<td HEIGHT="20" COLSPAN="2"><b>
<%--
            <input type="checkbox" style="cursor:'hand'" name="<%="key" + keyIndex%>" onclick="chooseAll('<%="key" + keyIndex%>')"/>
--%>
            <%=key%></b></td>
	 </tr>
		<%
		int kk=0; 
		for(int k=0;k<data.size();k++){
			Object[] myData =(Object[])data.get(k);
			if(kk%3==0){
				out.println("<tr>");
			}	
		%>
			 <td VALIGN="top" width="33%">
			 <!--全称-->
			 <div STYLE="padding-left:15px;float:left;word-break:keep-all;position:static" class="chkAll">
				<input type="checkbox" onclick="getValueArr(this);" style="cursor:'hand'" id="<%="key" + keyIndex + "_" + myData[0]%>" name="<%="key" + keyIndex + "_" + myData[0]%>" value="<%=myData[0] + ";" + myData[1]%>" /><%=myData[1]%>
			 </div>
			 <!--简称-->
			 <div STYLE="padding-left:15px;float:left;word-break:keep-all;position:static;display:none" class="chkJS">
				<input type="checkbox" onclick="getValueArr(this);" style="cursor:'hand'"  id="<%="key" + keyIndex + "_" + myData[0]%>" name="<%="key" + keyIndex + "_" + myData[0]%>" value="<%=myData[0] + ";" + myData[2]%>" /><%=myData[2]%>
			 </div>
			  </td>
		<%
		if(kk%3==2){out.println("</tr>");}
		kk++;	
		%>
		<%}
		if((kk-1)%3<2){out.println("<td  width='33%'>&nbsp;</td></tr>");}
		%>
		 </table>
		 <div><hr style="border:1px solid #cccccc;height:1px;width:95%;"></div>
	 <%}%>
</form>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;&nbsp;
		  <%String pagerURL = "SenddocumentBaseAction.do";%>
		
	</td>
  </tr>
</table>


	</td>
  </tr>

  <tr>
    <td align="left" class="Table_nobttomline">

<%--
	    <input type="button" class="btnButton4font" onClick="closeOK();" value="确　定"/>
--%>
		<input type="button" class="btnButton4font" onClick="tuichu();" value="退　出"/>

	</td>
  </tr>
</table>





</body>
</html>
<script language="javascript">


function tuichu(){
 window.close();
}
//增加
function adder() {
    var hhref = "SenddocumentBaseAction.do?action=unitAdd" ;
    postWindowOpen(hhref,'','TOP=0,LEFT=0,scrollbars=yes,resizable=no,width=600,height=300') ;
}

//修改 editType =1  编辑 eidtType = 0 浏览
function moder(editId,editType) {
    var hhref = "SenddocumentBaseAction.do?action=unitload" ;
    hhref += "&editId=" + editId ;
    hhref += "&editType=" +editType;
    hhref += "&pager.offset=<%=offset1%>" ;
    postWindowOpen(hhref,'','TOP=0,LEFT=0,scrollbars=yes,resizable=no,width=700,height=400') ;
}
//taodp==================start
//按类别选择
function chooseAll(key){	
	var keyArray = $('input[name^=' + key +'_]');
	for(var k=0;k<keyArray.length;k++){
		keyArray[k].checked=$('input[name=' + key +']').attr('checked');
	}
		//$("input:checkbox, input:radio").uniform();
}
function chooseType(flag){
	if(flag=='0'){//全称	
		$('.chkAll').css('display','block');
		$('.chkJS').css('display','none');
	}else{//简称
		$('.chkAll').css('display','none');
		$('.chkJS').css('display','block');
	}
}
function closeOK(){
//alert(window.opener.document.all.<%=field%>.value);

if ($.browser.msie ){//&& ($.browser.version == "6.0") && !$.support.style) { 
//代码 
if(eval("opener.window.document.all."+"<%=field%>") && eval("opener.window.document.all."+"<%=fieldId%>")){

		var _parentNameObj =  eval("opener.window.document.all."+"<%=field%>");
		var _parentidObj = eval("opener.window.document.all."+"<%=fieldId%>");

		var namesValue = _parentNameObj.value;

		var idsValue = _parentidObj.value;
		if(namesValue !=''){
			namesValue +=',';
			idsValue +=',';
			//设置为空
			namesValue ='';
			idsValue ='';
		}
		
		var flag = $('input[name=isAllName]:eq(0)').attr('checked');
		
		if(flag){//全称	
			//alert(2);
			//var allChkObj = $('.chkAll').children('input:checkbox');
			var allChkObj = $('.chkAll input[type=checkbox]:checked')
			//alert(allChkObj.length);
			for(var k=0;k<allChkObj.length;k++){
				if(allChkObj[k].checked){
				
					var allChkValues = allChkObj[k].value.split(';');
					var idVal = allChkValues[0];
					var nameVal = allChkValues[1];
					
					if(idsValue.indexOf(idVal) ==-1){
						namesValue += nameVal + ',';
						idsValue += idVal + ',';
					}

				}
			}
		}else{//简称		
		
		//	var allChkObj = $('.chkJS').children('input:checkbox');
			var allChkObj = $('.chkJS input[type=checkbox]:checked')
			for(var k=0;k<allChkObj.length;k++){
				if(allChkObj[k].checked){
					var allChkValues = allChkObj[k].value.split(';');
					var idVal = allChkValues[0];
					var nameVal = allChkValues[1];
					
					if(idsValue.indexOf(idVal) ==-1){
						namesValue += nameVal + ',';
						idsValue += idVal + ',';
					}

				}
			}
		}

		if(namesValue !=''){
			namesValue = namesValue.substring(0,namesValue.length-1);
		}
		if(idsValue !=''){
			idsValue = idsValue.substring(0,idsValue.length-1);
		}
		
		//赋值
		_parentNameObj.value = namesValue;
		_parentidObj.value = idsValue;
	}
	window.close();
} else{



	//alert("$(\"*[name='<%=field%>']\",window.opener.document)"+$("*[name='<%=field%>']",window.opener.document).length + ":" +  $("*[name='<%=fieldId%>']",window.opener.document).length);
	if( $("*[name='<%=field%>']",window.opener.document).length > 0 &&  $("*[name='<%=fieldId%>']",window.opener.document).length > 0 ){

	//if(eval("window.opener.document.all."+"<%=field%>") && eval("window.opener.document.all."+"<%=fieldId%>")){
		var _parentNameObj =   $("*[name='<%=field%>']",window.opener.document)[0];//eval("window.opener.document.all."+"<%=field%>");
		var _parentidObj =  $("*[name='<%=fieldId%>']",window.opener.document)[0];//eval("window.opener.document.all."+"<%=fieldId%>");

		var namesValue = _parentNameObj.value;
		var idsValue = _parentidObj.value;
		if(namesValue !=''){
			namesValue +=',';
			idsValue +=',';
			//设置为空
			namesValue ='';

			idsValue ='';
		}
	
		
		var flag = $('input[name=isAllName]:eq(0)').attr('checked');
		if(flag){//全称	
			var allChkObj =$('.chkAll input[type=checkbox]:checked');// $('.chkAll').children('input:checkbox');
			//alert($('.chkAll input[type=checkbox]').length);
			//alert(allChkObj.length);
			for(var k=0;k<allChkObj.length;k++){
				if(allChkObj[k].checked){
					var allChkValues = allChkObj[k].value.split(';');
					var idVal = allChkValues[0];
					var nameVal = allChkValues[1];
					
					if(idsValue.indexOf(idVal) ==-1){
						namesValue += nameVal + ',';
						idsValue += idVal + ',';
					}

				}
			}
		}else{//简称		
			var allChkObj = $('.chkJS input[type=checkbox]:checked'); //$('.chkJS').children('input:checkbox');
			//alert($('.chkJS').length);
			//alert(allChkObj.length);
			for(var k=0;k<allChkObj.length;k++){
				if(allChkObj[k].checked){
					var allChkValues = allChkObj[k].value.split(';');
					var idVal = allChkValues[0];
					var nameVal = allChkValues[1];
					
					if(idsValue.indexOf(idVal) ==-1){
						namesValue += nameVal + ',';
						idsValue += idVal + ',';
					}

				}
			}
		}
		if(namesValue !=''){
			namesValue = namesValue.substring(0,namesValue.length-1);
		}
		if(idsValue !=''){
			idsValue = idsValue.substring(0,idsValue.length-1);
		}

		//赋值
		_parentNameObj.value = namesValue;
		_parentidObj.value = idsValue;
	}
	window.close();
}
}
//初始化已选中的
$(function(){
	if ($.browser.msie ){
		if(eval("opener.window.document.all."+"<%=field%>") && eval("opener.window.document.all."+"<%=fieldId%>")){
			var _parentNameObj =  eval("opener.window.document.all."+"<%=field%>");
			var _parentidObj = eval("opener.window.document.all."+"<%=fieldId%>");

			var namesValue = _parentNameObj.value;
			var idsValue = _parentidObj.value;

			var allchkboxs = $('input:checkbox');
			for(var k=0;k<allchkboxs.length;k++){
				var allChkValues = allchkboxs[k].value.split(';');
				if(idsValue.indexOf(allChkValues[0]) !=-1){
					allchkboxs[k].checked=true;
				}
			}
		}
	}else{
		//if(eval("window.opener.document.all."+"<%=field%>") && eval("window.opener.document.all."+"<%=fieldId%>")){
		if( $("*[name='<%=field%>']",window.opener.document).length > 0 &&  $("*[name='<%=fieldId%>']",window.opener.document).length > 0 ){
			//var _parentNameObj =  eval("window.opener.document.all."+"<%=field%>");
			//var _parentidObj = eval("window.opener.document.all."+"<%=fieldId%>");
			var _parentNameObj =   $("*[name='<%=field%>']",window.opener.document)[0];//eval("window.opener.document.all."+"<%=field%>");
			var _parentidObj   =   $("*[name='<%=fieldId%>']",window.opener.document)[0];//eval("window.opener.document.all."+"<%=fieldId%>");

			var namesValue = _parentNameObj.value;
			var idsValue = _parentidObj.value;

			var allchkboxs = $('input:checkbox');
			for(var k=0;k<allchkboxs.length;k++){
				var allChkValues = allchkboxs[k].value.split(';');
				if(idsValue.indexOf(allChkValues[0]) !=-1){
					allchkboxs[k].checked=true;
				}
			}
		}
	}
		//$("input:checkbox, input:radio").uniform();
});
//taodp======================end
//批量删除
function delBatch() {
    var ids = getCheckBoxID();
    if(ids == "") {
        alert("没有选择记录！") ;
    }else {
		 ids=ids.substring(0,ids.length-1);
         if(confirm("确实要删除吗？")){
            var countRecordCount = "<%=countRecordCount%>" ;
            var offset1 = parseInt("<%=offset1%>") ;
			var pageSize = parseInt("<%=pageSize%>") ;
            var idsArr = ids.split(",")  ;
            var moveoffset = idsArr.length-1 ;
            moveoffset = countRecordCount == moveoffset ? offset1 -pageSize :offset1 ; //得到符合条件的offset,来处理临界的情况
            moveoffset = moveoffset < 0 ? 0 :moveoffset ;
            var hhref  = "SenddocumentBaseAction.do?action=unitdelete" ;
            hhref +="&ids="+ids ;
            hhref +="&pager.offset="+moveoffset ;
            //window.location.href = hhref ;
			location_href( hhref );
         }
    }
 }

 //单个删除
function del(id) {
     if(confirm("确实要删除吗？")){
        var hhref  = "SenddocumentBaseAction.do?action=unitdelete" ;
            hhref +="&ids="+id  ;

        //window.location.href = hhref ;
		location_href( hhref );
    }
 }
 //全选|全除
function selectAll(obj) {
    if(obj.checked) {
    	for(var i = 0 ; i < SenddocumentBaseActionForm.length ; i++ ) {
        	var chkObj = SenddocumentBaseActionForm[i] ;
        	 if(chkObj.type == "checkbox"){
			if(chkObj!=obj&&!chkObj.disabled) {
                              chkObj.checked = true ;
			}
        	 }
   	 }
    }else {
            for(var i = 0 ; i < SenddocumentBaseActionForm.length ; i++ ) {
                var chkObj = SenddocumentBaseActionForm[i] ;
                 if(chkObj.type == "checkbox"){
                        if(chkObj!=obj) {
                              chkObj.checked = false ;
                        }
                 }
   	 }
    }
		//$("input:checkbox, input:radio").uniform();
}
function closeOK_bak() {

    var allName=document.getElementsByName("isAllName"); 
	var allNameValue;
   for(i=0;i<allName.length;i++)  
   {  
   if(allName[i].checked) allNameValue=allName[i].value;  
    }

    var retText="" ;
	var retvalue="";
    for(var i = 0 ; i < SenddocumentBaseActionForm.length ; i++ ) {
        var obj = SenddocumentBaseActionForm[i] ;
         if(obj.type == "checkbox"&&obj!=SenddocumentBaseActionForm.chkSelect){
		if(obj.checked) {
			
			  var objvalue=obj.value;

			  var objArr=objvalue.split(";");
			 retvalue+=objArr[0]+",";

			  if(allNameValue=="1"){			
			   retText+=objArr[1]+",";
			  }else{
			   retText+=objArr[2]+',';	  
			  }
			
			  
                	/*retvalue +=objvalue.substring(0,objvalue.indexOf(";")) ;
				
                        retvalue += "," ;

						retText+=objvalue.substring(objvalue.indexOf(";")+1);
                        retText+=",";*/

		}
         }
    }


   if(retText.length>1){
		 retText=retText.substring(0,retText.length-1);
	
	}
	if(retvalue.length>1){
		 retvalue=retvalue.substring(0,retvalue.length-1);
	}
 
     if(eval("window.opener.document.all."+"<%=field%>").value==""){
	eval("window.opener.document.all."+"<%=field%>").value=eval("window.opener.document.all."+"<%=field%>").value+retText;
	eval("window.opener.document.all."+"<%=fieldId%>").value=eval("window.opener.document.all."+"<%=fieldId%>").value+retvalue;
	}else{
	eval("window.opener.document.all."+"<%=field%>").value=eval("window.opener.document.all."+"<%=field%>").value+","+retText;
	eval("window.opener.document.all."+"<%=fieldId%>").value=eval("window.opener.document.all."+"<%=fieldId%>").value+","+retvalue;
	}
	window.close();

}



function orderBy(type,sortType){

	 var myhref ="GovDocReceiveProcess!chooseUnit.action?orderBy=" + type + "&sortType=" + sortType+"&field=<%=field%>&fieldId=<%=fieldId%>";
	 // window.location.href = myhref;
	  location_href( myhref );

}

function unsearcher(){

 var myhref ="GovDocReceiveProcess!chooseUnit.action?field=<%=field%>&fieldId=<%=fieldId%>";
// window.location.href = myhref;
location_href( myhref );
}

function searcher() {
     if($("*[name='unitType']").val().indexOf("'") >= 0){
    	alert("搜索条件不能包含单引号！");
        return ;
    }
   var myhref ="GovDocReceiveProcess!chooseUnit.action?unitName="+encodeURIComponent(encodeURIComponent($("#unitName").val()))+"&unitType="+encodeURIComponent($("*[name='unitType']").val())+"&field=<%=field%>&fieldId=<%=fieldId%>";
	 location_href( myhref );
}
function getValueArr(obj){
    var tempParentwin;
    var tempValueArr=$(obj).val().split(';')
    var tempNameValue=tempValueArr[1];
    var tempIdValue=tempValueArr[0];
    if ($.browser.msie ){
        tempParentwin=opener.window;
    }else{
        tempParentwin=window.opener;
    }
    if($(obj).attr("checked")){
        tempParentwin.updateReceiveUnitValue(tempNameValue,tempIdValue,'1');
    }else{
        tempParentwin.updateReceiveUnitValue(tempNameValue,tempIdValue,'2');
    }
}

</script>
