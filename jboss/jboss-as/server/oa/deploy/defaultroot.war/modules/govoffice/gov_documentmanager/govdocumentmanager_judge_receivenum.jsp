<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
com.whir.common.util.DataSourceBase dsb = new com.whir.common.util.DataSourceBase();
java.sql.Connection conn = null;
java.sql.Statement stmt = null;

String numId=request.getParameter("numId");
String field2=request.getParameter("field2");
String seq=request.getParameter("zjkySeq");

String  recordId=request.getParameter("record")==null?"":request.getParameter("record").toString();
String newResubmit = request.getParameter("newResubmit")==null?"":request.getParameter("newResubmit").toString();

//int ny=new java.util.Date().getYear()+1900;

try{
         conn = dsb.getDataSource().getConnection();
         stmt = conn.createStatement();

        
         //int iskey=1;//0 不重排, 1 重排

         //String numStr="select  keyValue from gov_receivefileseq   where  id="+numId;//取此文号 是否要求重排


		 String  strSql="SELECT RECEIVEFILE_ID FROM EZOFFICE.GOV_RECEIVEFILE WHERE receivefile_isdraft!='1' and  seqid=" + numId+" and  zjkyseq like '"+ seq +"'";
          
       // System.out.println("////////////////////////////numStr"+numStr);
		  if(!recordId.equals("") && !recordId.equals("null")){
		    if(!newResubmit.equals("1")){
				strSql+= " and RECEIVEFILE_ID<> "+recordId;
			}
		  }

 
	     //java.sql.ResultSet rs = stmt.executeQuery(numStr);

          //if(rs.next()){
          // iskey=rs.getInt(1);
//
         // }
	  
          //if(iskey==1){// 重排
           
	       //strSql+=" and field2="+ny+"";
     
		 // }
	          //System.out.println("////////////////////////////strSql:"+strSql);
     java.sql.ResultSet rs = stmt.executeQuery(strSql);
    int channelsort = 0;
    if(rs.next()){
        out.print("0");
    }else{
        out.print("1");
    }
}catch(Exception e){
    System.out.println("-----------------------------------------------------");
    e.printStackTrace();
    System.out.println("-----------------------------------------------------");
}finally{
    if(stmt != null){
        stmt.close();
    }
    if(conn != null){
    	conn.close();
    }
}
%>
