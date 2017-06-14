<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="com.whir.ezoffice.customdb.common.util.DbOpt"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
response.setContentType("application/json; charset=UTF-8");
String domainId = session.getAttribute("domainId").toString();

String sql = request.getParameter("sql");
//System.out.println("----------------------------sql1-----------------------:"+sql);
String dataSource = request.getParameter("dataSource");
String paramValue = request.getParameter("paramValue");
//System.out.println("----------------------------paramValue-----------------------:"+paramValue);
String paramNum = request.getParameter("paramNum");
int cols = Integer.parseInt(paramNum);
String[] param_field = paramValue.split(",");
com.whir.component.extds.DBTools dbt = new com.whir.component.extds.
            DBTools(dataSource);
Connection conn = null;
PreparedStatement ps = null;
String s = "{\"success\":true, \"data\":[";
try{
	conn = dbt.getConnection();
    ps = conn.prepareStatement(sql);
    //System.out.println("----------------------------sql-----------------------:"+sql);
    if(param_field!=null){
        for(int i=0; i<param_field.length; i++){
            int j=0;
            ps.setString(i+1, param_field[i]);
        }
    }
    ResultSet rs = ps.executeQuery();
    int j=0;
    while(rs.next()){
        if(j>0)s += ",";
        s += "[";
        for(int i=1, m=1; i<=cols; i++,m++){
            String val = rs.getString(m);
			String id="";
			//if(rs.getMetaData().getColumnCount()==2){
			//	id = rs.getString(++m);
			//}
            if(i>1)s += ",";
            s += "{\"id\":\""+id+"\",\"value\":\""+val+"\"}";
        }
        s += "]";
        j++;
    }
    if(j==0){
        s += "[";
        for(int i=1; i<=cols; i++){
            String val = "";
            if(i>1)s += ",";
            s += "{\"id\":\"\",\"value\":\""+val+"\"}";
        }
        s += "]";
    }
    rs.close();
    ps.close();
}catch(Exception e){
    e.printStackTrace();
}finally{
    try{
        if(dbt!=null)dbt.close();
    }catch(Exception e){
        e.printStackTrace();
    }
}
s += "]}";//System.out.print(s);
out.print(s);
%>