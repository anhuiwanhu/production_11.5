<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="com.whir.ezoffice.customdb.common.util.DbOpt"%>
<%
System.out.println("-----------------开始修改------------------");
String dataType = com.whir.common.config.SystemCommon.getDatabaseType();
DbOpt dbopt = new DbOpt();
Connection conn = null;
PreparedStatement ps = null;
PreparedStatement ps1 = null;
PreparedStatement ps2 = null;
try{
    conn = dbopt.getConnection();
	String sql = "select f1.field_name,t1.table_name from ttable t1,tfield f1 where t1.table_id = f1.field_table and f1.field_show in(202,215)";

    ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
	ResultSet rs1 = null;
    while(rs.next()){
		String fieldName = rs.getString(1);
		String tableName = rs.getString(2);
		//oracle
		String sql1 = "select "+fieldName+" from "+tableName+" where regexp_substr("+fieldName+",'[0-9]+') is not null";
		if (dataType.indexOf("mssqlserver") >= 0) {
			//sqlserver
			sql1 = "select "+fieldName+" from "+tableName+" where IsNumeric("+fieldName+") = 1";
		}
		ps1 = conn.prepareStatement(sql1);
		rs1 = ps1.executeQuery();
		while(rs1.next()){
			String fieldValue = rs1.getString(1);
			java.util.regex.Pattern pattern=java.util.regex.Pattern.compile("[0-9]*");
			java.util.regex.Matcher match=pattern.matcher(fieldValue);
			if(match.matches()){ 
				String sql2 = "update "+tableName+" set "+fieldName+" =(select empname from org_employee where emp_id="+fieldValue+") where "+fieldName+" ='"+fieldValue+"'";
				ps2 = conn.prepareStatement(sql2);
				ps2.executeUpdate();
				ps2.close();
				//conn.commit();
			}
		}
		ps1.close();
    }
    
    rs.close();
	rs1.close();
    ps.close();
}catch(Exception e){
    e.printStackTrace();
}finally{
    try{
        if(dbopt!=null)dbopt.close();
    }catch(Exception e){
        e.printStackTrace();
    }
	out.print("OK!");
}
System.out.println("-----------------修改成功------------------");
%>
