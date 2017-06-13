<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<%
String databaseType=com.whir.common.config.SystemCommon.getDatabaseType(); 
%>
<%
  String IsOut=request.getParameter("IsOut");
  System.out.println("databaseType::::::"+databaseType);  
  String mRecordID=request.getParameter("RecordID");
  if (mRecordID==null) mRecordID="";
  String mSubject="";//new String(request.getParameter("Subject").getBytes("8859_1"));
  String mAuthor="";//new String(request.getParameter("Author").getBytes("8859_1"));
  String mFileDate="";//new String(request.getParameter("FileDate").getBytes("8859_1"));
  String mFileType="pdf";
  String mStatus="READ";
int mDocumentId = 0;
DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mysql="SELECT RecordID from  pdfDocument Where RecordID='" + mRecordID + "'";
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mysql) ;
    if (result.next())
    {
      mysql="update pdfDocument set RecordID=?,Subject=?,Author=?,FileDate=?,FileType=?,Status=? where RecordID='"+mRecordID+"'";
    }
    else
    {
		if ("oracle".equals(databaseType)) {

		   //mysql="insert into Document (DocumentID,RecordID,Template,Subject,Author,FileDate,FileType,HtmlPath,Status) values (?,?,?,?,?,?,?,?,?)";
			 mysql="insert into pdfDocument (DOCUMENTID,RecordID,Subject,Author,FileDate,FileType,Status) values (?,?,?,?,?,?,?)";
		   
		    mDocumentId=DbaObj.GetMaxID("pdfDocument","DOCUMENTID");

	   }else if("mysql".equals(databaseType)){

			mysql="insert into Document (RecordID,Template,Subject,Author,FileDate,FileType,HtmlPath,Status) values (?,?,?,?,?,?,?,?)";

	   }else{
			mysql="insert into pdfDocument (RecordID,Subject,Author,FileDate,FileType,Status) values (?,?,?,?,?,?)";
			//mysql="insert into Document (RecordID,Template,Subject,Author,FileDate,FileType,HtmlPath,Status) values (?,?,?,?,?,?,?,?)";
	   }


			//  mysql="insert into pdfDocument (RecordID,Subject,Author,FileDate,FileType,Status) values (?,?,?,?,?,?)";
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

	     /*prestmt=DbaObj.Conn.prepareStatement(mysql);
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
         DbaObj.Conn.commit();*/

		  prestmt=DbaObj.Conn.prepareStatement(mysql);

		  prestmt.setInt(1,mDocumentId);
		  prestmt.setString(2,mRecordID);
		  prestmt.setString(3,mSubject);
		  prestmt.setString(4,mAuthor);
		  prestmt.setString(5,mFileDate);
		  prestmt.setString(6,mFileType);
		  prestmt.setString(7,"READ");
		  
		  DbaObj.Conn.setAutoCommit(false) ;
		  prestmt.executeUpdate();
		  DbaObj.Conn.commit();

	   }else if("mysql".equals(databaseType)){

	      prestmt=DbaObj.Conn.prepareStatement(mysql);
		  prestmt.setString(1,mRecordID);
		  prestmt.setString(2,mSubject);
		  prestmt.setString(3,mAuthor);
		  prestmt.setString(4,mFileDate);
		  prestmt.setString(5,mFileType);
		  prestmt.setString(6,"READ");
		  
		  DbaObj.Conn.setAutoCommit(false) ;
		  prestmt.executeUpdate();
		  DbaObj.Conn.commit();


	   }else{

	      prestmt=DbaObj.Conn.prepareStatement(mysql);
		  prestmt.setString(1,mRecordID);
		  prestmt.setString(2,mSubject);
		  prestmt.setString(3,mAuthor);
		  prestmt.setString(4,mFileDate);
		  prestmt.setString(5,mFileType);
		  prestmt.setString(6,"READ");
		  
		  DbaObj.Conn.setAutoCommit(false) ;
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
	<%if(request.getParameter("field")!=null && request.getParameter("field").trim().length()>0 && !request.getParameter("field").toUpperCase().equals("NULL")){%>
		//适用于自定义表单-子表
		<%if(request.getParameter("_rowIndex")!=null && request.getParameter("_rowIndex").trim().length()>0 && !request.getParameter("_rowIndex").toUpperCase().equals("NULL")){%>
		opener.document.getElementsByName('<%=request.getParameter("field")%>')[<%=request.getParameter("_rowIndex")%>].value = "<%=mRecordID%>";
		<%}else{%>
		opener.document.all.<%=request.getParameter("field")%>.value = "<%=mRecordID%>";
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
	<%if(request.getParameter("field")!=null && request.getParameter("field").trim().length()>0 && !request.getParameter("field").toUpperCase().equals("NULL")){%>
		//适用于自定义表单-子表
		<%if(request.getParameter("_rowIndex")!=null && request.getParameter("_rowIndex").trim().length()>0 && !request.getParameter("_rowIndex").toUpperCase().equals("NULL")){%>
		parent.opener.document.getElementsByName('<%=request.getParameter("field")%>')[<%=request.getParameter("_rowIndex")%>].value = "<%=mRecordID%>";
		<%}else{%>
		parent.opener.document.all.<%=request.getParameter("field")%>.value = "<%=mRecordID%>";
		<%}%>
	<%}else{%>
		//if(parent.opener.document.all.content)parent.opener.document.all.content.value = "<%=mRecordID%>";
		;
//alert("<%=mRecordID%>");
//alert("<%=mRecordID%>");
if ($.browser.msie ) { 
// && ($.browser.version == "6.0")//&& !$.support.style
//代码 
	if(parent.opener.document.all.content)parent.opener.document.all.content.value = "<%=mRecordID%>";
}else{ 


//alert(parent.opener.document.all.content.value);
//alert($("input[name='content']", parent.opener.document).val());
		//if($("*[name='content']", parent.opener.document) ) $("*[name='content']", parent.opener.document).val( "<%=mRecordID%>" );
		if( parent.opener.document.getElementsByName("content").length > 0){
			parent.opener.document.getElementsByName("content")[0].val("<%=mRecordID%>");
		}
}
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
