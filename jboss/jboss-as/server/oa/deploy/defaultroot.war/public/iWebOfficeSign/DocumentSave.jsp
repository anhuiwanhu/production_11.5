<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%
String databaseType=com.whir.common.config.SystemCommon.getDatabaseType();
%>
<%
  String mRecordID=com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("RecordID"));
  if(null!= mRecordID && !"".equals(mRecordID) && !"null".equals(mRecordID)){
		if(!StringUtils.isNumeric(mRecordID)){
			mRecordID = "";
	   }
  }

  String field=com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("field"));

  String _rowIndex=com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("_rowIndex"));


  if (mRecordID==null) mRecordID="";
  String mTemplate= com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("Template"));


  String mSubject=request.getParameter("Subject");
  String mAuthor=request.getParameter("Author");
  String mFileDate=request.getParameter("FileDate");
  String mFileType= com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("FileType"));


  String mHTMLPath= com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("HTMLPath"));


  String mStatus="READ";
  String IsOut= com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("IsOut"));


  int mDocumentId=0;

DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mysql="SELECT DocumentID,RecordID from  Document Where RecordID='" + mRecordID + "'";
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mysql) ;
    if (result.next())
    {
		if ("oracle".equals(databaseType)) {

	    mysql="update Document set DocumentID=?,RecordID=?,Template=?,Subject=?,Author=?,FileDate=?,FileType=?,HtmlPath=?,Status=? where RecordID='"+mRecordID+"'";
        mDocumentId=result.getInt("DocumentID");

	   }else if("mysql".equals(databaseType)){
	     mysql="update Document set RecordID=?,Template=?,Subject=?,Author=?,FileDate=?,FileType=?,HtmlPath=?,Status=? where RecordID='"+mRecordID+"'";
	   }else{
	     mysql="update Document set RecordID=?,Template=?,Subject=?,Author=?,FileDate=?,FileType=?,HtmlPath=?,Status=? where RecordID='"+mRecordID+"'";
	   }
    }
    else
    {
		if ("oracle".equals(databaseType)) {

	   mysql="insert into Document (DocumentID,RecordID,Template,Subject,Author,FileDate,FileType,HtmlPath,Status) values (?,?,?,?,?,?,?,?,?)";
       mDocumentId=DbaObj.GetMaxID("Document","DocumentID");

	   }else if("mysql".equals(databaseType)){

	    mysql="insert into Document (RecordID,Template,Subject,Author,FileDate,FileType,HtmlPath,Status) values (?,?,?,?,?,?,?,?)";

	   }else{

	    mysql="insert into Document (RecordID,Template,Subject,Author,FileDate,FileType,HtmlPath,Status) values (?,?,?,?,?,?,?,?)";
	   }
    }
    result.close();
  }
  catch(Exception e)
  {
      System.out.println(e.toString());
  }
  java.sql.PreparedStatement prestmt=null;
  try
  {
     if ("oracle".equals(databaseType)) {

	     prestmt=DbaObj.Conn.prepareStatement(mysql);
         prestmt.setInt(1,mDocumentId);
         prestmt.setString(2,mRecordID);
         prestmt.setString(3,mTemplate);
         prestmt.setString(4,mSubject);
         prestmt.setString(5,mAuthor);
         prestmt.setDate(6,DbaObj.GetDate());
         prestmt.setString(7,mFileType);
         prestmt.setString(8,mHTMLPath);
         prestmt.setString(9,"READ");

         DbaObj.Conn.setAutoCommit(true) ;
         prestmt.executeUpdate();
         DbaObj.Conn.commit();

	   }else if("mysql".equals(databaseType)){

	     prestmt=DbaObj.Conn.prepareStatement(mysql);
         prestmt.setString(1,mRecordID);
         prestmt.setString(2,mTemplate);
         prestmt.setString(3,mSubject);
         prestmt.setString(4,mAuthor);
         prestmt.setString(5,mFileDate);
         prestmt.setString(6,mFileType);
         prestmt.setString(7,mHTMLPath);
         prestmt.setString(8,"READ");
        // DbaObj.Conn.setAutoCommit(true) ;
         prestmt.executeUpdate();
        // DbaObj.Conn.commit();

	   }else{

	     prestmt=DbaObj.Conn.prepareStatement(mysql);
         prestmt.setString(1,mRecordID);
         prestmt.setString(2,mTemplate);
         prestmt.setString(3,mSubject);
         prestmt.setString(4,mAuthor);
         prestmt.setString(5,mFileDate);
         prestmt.setString(6,mFileType);
         prestmt.setString(7,mHTMLPath);
         prestmt.setString(8,"READ");
         DbaObj.Conn.setAutoCommit(true) ;
         prestmt.executeUpdate();
         DbaObj.Conn.commit();
	   }
  }
  catch(Exception e)
  {
      System.out.println(e.toString());
  }
  finally
  {
      prestmt.close();
  }
  DbaObj.CloseConnection() ;
}
else
{
  out.println("OpenDatabase Error") ;
}
//response.sendRedirect("DocumentList.jsp");
%>
<script src="/defaultroot/scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
<script language="javascript">
if(opener){
	<%if(field!=null && field.trim().length()>0 && !field.toUpperCase().equals("NULL")){%>
		//适用于自定义表单-子表
		<%if(_rowIndex!=null && _rowIndex.trim().length()>0 && !_rowIndex.toUpperCase().equals("NULL")){%>
		opener.document.getElementsByName('<%=field%>')[<%=_rowIndex%>].value = "<%=mRecordID%>";
		<%}else{%>
		opener.document.all.<%=field%>.value = "<%=mRecordID%>";
		<%}%>
	<%}else{%>
		opener.document.all.content.value = "<%=mRecordID%>";		
	<%}%>		
		try{
			var pFunc = opener.WritetextModiEvent;
			if(pFunc){
				opener.WritetextModiEvent();
			}
		}catch(e){}
    window.parent.close();
}else{
	<%if(field!=null && field.trim().length()>0 && !field.toUpperCase().equals("NULL")){%>
		//适用于自定义表单-子表
		<%if(_rowIndex!=null && _rowIndex.trim().length()>0 && !_rowIndex.toUpperCase().equals("NULL")){%>
		parent.opener.document.getElementsByName('<%=field%>')[<%=_rowIndex%>].value = "<%=mRecordID%>";
		<%}else{%>
		parent.opener.document.all.<%=field%>.value = "<%=mRecordID%>";
		<%}%>
	<%}else{%>
		//if(parent.opener.document.all.content)parent.opener.document.all.content.value = "<%=mRecordID%>";
		//alert("<%=mRecordID%>");

		if($("*[name='content']", parent.opener.document) ) $("*[name='content']", parent.opener.document).val( "<%=mRecordID%>" );
		//alert($("*[name='content']", parent.opener.document).val());
	<%}%>
		try{
			var pFunc = parent.opener.WritetextModiEvent;
			if(pFunc){
				parent.opener.WritetextModiEvent();
			}
		}catch(e){}
		
	<%if("1".equals(IsOut)){%>
	parent.window.close();
	<%}%>
    //window.history.back();
}

//   window.parent.location = "DocumentList.jsp";
</script>
