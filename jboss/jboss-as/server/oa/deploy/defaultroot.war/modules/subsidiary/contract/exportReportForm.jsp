<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,java.io.*,jxl.*,jxl.write.*"%>
<%@ page import="com.whir.ezoffice.contract.bd.*"%>
<%@ page import="com.whir.ezoffice.projectmanager.bd.*"%>
<%@ page import="com.whir.ezoffice.contract.po.*"%>
<%@ page import="com.whir.ezoffice.projectmanager.po.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<%
	Date date = new Date();
  	SimpleDateFormat sdf = new SimpleDateFormat();
  	sdf.applyPattern("yyyyMMddhhmmss");
  	String strdate = sdf.format(date);
	
	OutputStream os = response.getOutputStream();
	response.reset();
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-disposition", "attachment;filename="+ strdate + ".xls");
	
	ContractBD cbd = new ContractBD();
	java.text.DecimalFormat df = new java.text.DecimalFormat("0.0");
	
	List reportList = (List) request.getAttribute("reportForm");
	String ContractClass = request.getAttribute("searchContractClass") ==null ?"":request.getAttribute("searchContractClass").toString();
	
	try {
		WritableWorkbook wwb = Workbook.createWorkbook(os);
		String[] exportFieldsName1 = new String[13];
		String[] exportFieldsName2 = new String[13];
		
		exportFieldsName1[0] ="";
		exportFieldsName1[1] ="";
		exportFieldsName1[2] ="基本信息";
		exportFieldsName1[3] ="";
		exportFieldsName1[4] ="";
		exportFieldsName1[5] ="合同约定情况";
		exportFieldsName1[6] ="";
		exportFieldsName1[7] ="";
		
		exportFieldsName2[0] ="合同号";
		exportFieldsName2[1] ="合同名称";
		exportFieldsName2[2] ="合同甲方";
		exportFieldsName2[3] ="合同乙方";
		exportFieldsName2[4] ="分期";
		exportFieldsName2[5] ="约定条款";
		
		if("1".equals(ContractClass)){
			exportFieldsName1[8] ="实际付款情况";
			
			exportFieldsName2[6] ="付款金额";
			exportFieldsName2[7] ="付款时间";
			exportFieldsName2[8] ="付款金额";
			exportFieldsName2[9] ="付款凭证号";
			exportFieldsName2[10] ="合同未付金额";
		}else{
			exportFieldsName1[8] ="实际收款情况";
			
			exportFieldsName2[6] ="收款金额";
			exportFieldsName2[7] ="收款时间";
			exportFieldsName2[8] ="收款金额";
			exportFieldsName2[9] ="收款凭证号";
			exportFieldsName2[10] ="合同未收金额";
		}
		exportFieldsName1[9] ="";
		exportFieldsName1[10] ="";
		exportFieldsName1[11] ="基本信息";
		exportFieldsName1[12] ="";
		
		exportFieldsName2[11] ="经办人";
		exportFieldsName2[12] ="备注";
		
		int cols = 0;
		if (exportFieldsName1 != null) {
			cols = exportFieldsName1.length;
		}
		Label label = null;
		WritableSheet sheet = null;
		int sheetnum = reportList.size() / 10000 + 1;
		sheet = wwb.createSheet("导出数据", 0);
		if (reportList.isEmpty()) {
			label = new Label(0, 1, "无数据");
			sheet.addCell(label);
		}
		
		for (int i = 0; i < sheetnum; i++) {
			sheet = wwb.createSheet("第" + (i + 1) + "页", i);
			// 表头1
			for (int j = 0; j < cols; j++) {
				label = new Label(j, 0, exportFieldsName1[j]);
				sheet.addCell(label);
				label = null;
			}
            // 表头2
			for (int j = 0; j < cols; j++) {
				label = new Label(j, 1, exportFieldsName2[j]);
				sheet.addCell(label);
				label = null;
			}
			
			int curRow = 2;
			
			double sumGRAmount1 = 0;
		  	double sumNoGRAmount1 = 0;
		  	BigDecimal bg=new BigDecimal("0");
		  	
			for (int k = 10000 * i; k < 10000 * (i + 1)	&& k < reportList.size(); k++) {
				Object[] obj = (Object[]) reportList.get(k);
				
				String Contractcode       = (obj[0]==null || "null".equals(obj[0].toString())) ?"":obj[0].toString();
				String ContractName1      = (obj[1]==null || "null".equals(obj[1].toString())) ?"":obj[1].toString();
				String ContractPersonA    = (obj[2]==null || "null".equals(obj[2].toString())) ?"":obj[2].toString();
				String ContractPersonB    = (obj[3]==null || "null".equals(obj[3].toString())) ?"":obj[3].toString();
				String ContractCountMoney = (obj[4]==null || "null".equals(obj[4].toString())) ?"0":obj[4].toString();
				String contractid         = (obj[5]==null || "null".equals(obj[5].toString())) ?"":obj[5].toString();
				String Remark             = (obj[6]==null || "null".equals(obj[6].toString())) ?"":obj[6].toString();
				String ContractActPer     = (obj[7]==null || "null".equals(obj[7].toString())) ?"":obj[7].toString();
				
				String sumTalkMoneyAdd    = cbd.sumTalkMoneyAdd(new Long(contractid))+"";
				
				//洽商后合同总金额
				String lastTalkmoneyadd = ContractCountMoney;
				if(ContractCountMoney != null && !"".equals(ContractCountMoney) && !"null".equals(ContractCountMoney) && 
				   sumTalkMoneyAdd != null && !"".equals(sumTalkMoneyAdd) && !"null".equals(sumTalkMoneyAdd)){
				     lastTalkmoneyadd = (Double.parseDouble(ContractCountMoney) + Double.parseDouble(sumTalkMoneyAdd))+"";
					 lastTalkmoneyadd = (new java.math.BigDecimal(lastTalkmoneyadd)).toString();
			    }
				ContractCountMoney = lastTalkmoneyadd;
				
				String sumGivedReceiveMoney = "0";
				if("1".equals(ContractClass)){    
                    sumGivedReceiveMoney = cbd.sumGivedMoney(new Long(contractid))+"";  //应付款合同
                }else if("2".equals(ContractClass)){   //应收款合同
                    sumGivedReceiveMoney = cbd.sumReceivedMoney(new Long(contractid))+"";
                }
				
				double NoGivedReceivedAmount = Double.parseDouble(ContractCountMoney) - Double.parseDouble(sumGivedReceiveMoney);
			    sumNoGRAmount1 = sumNoGRAmount1+NoGivedReceivedAmount;
				String NoGivedReceivedAmount_str = String.valueOf(NoGivedReceivedAmount);
				bg=new BigDecimal(NoGivedReceivedAmount_str);
				NoGivedReceivedAmount_str = bg.toString();
				bg=new BigDecimal(sumGivedReceiveMoney);
			    sumGivedReceiveMoney = bg.toString();
			    //处理显示科学计数法-----20130817-----开始
				ContractCountMoney =df.format(Double.valueOf(ContractCountMoney));
				sumGivedReceiveMoney =df.format(Double.valueOf(sumGivedReceiveMoney));
				NoGivedReceivedAmount_str =df.format(Double.valueOf(NoGivedReceivedAmount_str));
				//处理显示科学计数法-----20130817-----结束
				
				//合同号
				label = new Label(0, curRow, Contractcode);
				sheet.addCell(label);
				
				//合同名称
				label = new Label(1, curRow, ContractName1);
				sheet.addCell(label);
				
				//合同甲方
				label = new Label(2, curRow, ContractPersonA);
				sheet.addCell(label);
				
				//合同乙方
				label = new Label(3, curRow, ContractPersonB);
				sheet.addCell(label);
				
				//分期
				label = new Label(4, curRow, "");
				sheet.addCell(label);
				
				//约定条款
				label = new Label(5, curRow, "");
				sheet.addCell(label);
				
				//付款金额 or 收款金额
				label = new Label(6, curRow, ContractCountMoney);
				sheet.addCell(label);
				
				//付款时间 or 收款时间
				label = new Label(7, curRow, "");
				sheet.addCell(label);
				
				//付款金额 or 收款金额
				label = new Label(8, curRow, sumGivedReceiveMoney);
				sheet.addCell(label);
				
				//付款凭证号 or 收款凭证号
				label = new Label(9, curRow, "");
				sheet.addCell(label);
				
				//合同未付金额 or 合同未收金额
				label = new Label(10, curRow, NoGivedReceivedAmount_str);
				sheet.addCell(label);
				
				//经办人
				label = new Label(11, curRow, ContractActPer);
				sheet.addCell(label);
				
				//备注
				label = new Label(12, curRow, Remark);
				sheet.addCell(label);
				
				curRow++;
				
				//应付款合同
				if("1".equals(ContractClass)){
					List givedList = cbd.getGivedList(contractid);
					if(givedList != null){
						for(int j=0;j<givedList.size();j++){
							Object[] obj1 = (Object[])givedList.get(j);
							String Stage1           =  (String) obj1[0];
					        String ConventionTerms1 =  (String) obj1[1];
					        String GetMoney1        =  (String) obj1[2];
					        String GivedAmount1     =  (String) obj1[3];
					        String GivedDate1       =  (String) obj1[4];
					        String GivedCode1       =  (String) obj1[5];
							if((GivedCode1!=null)&&(",".equals(GivedCode1.trim()))){//11.5.0.0 去掉显示的时候显示的逗号
								 GivedCode1="";
							 }
					        String ActPer =  (String) obj1[6];
							if((ActPer!=null)&&(",".equals(ActPer.trim()))){//11.5.0.0 去掉显示的时候显示的逗号
								 ActPer="";
							 }
					        double NoGivedReceivedAmount1 = Double.parseDouble(GetMoney1) - Double.parseDouble(GivedAmount1);
					        sumGRAmount1 = sumGRAmount1 + Double.parseDouble(GivedAmount1);
						    bg=new BigDecimal(GetMoney1);
						    GetMoney1 = bg.toString();
						    bg=new BigDecimal(GivedAmount1);
						    GivedAmount1 = bg.toString();
						    String NoGivedReceivedAmount1_str = String.valueOf(NoGivedReceivedAmount1);
						    bg=new BigDecimal(NoGivedReceivedAmount1_str);
						    NoGivedReceivedAmount1_str = bg.toString();
						    //处理显示科学计数法-----20130817-----开始
							GetMoney1 =df.format(Double.valueOf(GetMoney1));
							GivedAmount1 =df.format(Double.valueOf(GivedAmount1));
							NoGivedReceivedAmount1_str =df.format(Double.valueOf(NoGivedReceivedAmount1_str));
							//处理显示科学计数法-----20130817-----结束
						    
						    //合同号
							label = new Label(0, curRow, "");
							sheet.addCell(label);
							
							//合同名称
							label = new Label(1, curRow, "");
							sheet.addCell(label);
							
							//合同甲方
							label = new Label(2, curRow, "");
							sheet.addCell(label);
							
							//合同乙方
							label = new Label(3, curRow, "");
							sheet.addCell(label);
							
							//分期
							label = new Label(4, curRow, Stage1);
							sheet.addCell(label);
							
							//约定条款
							label = new Label(5, curRow, ConventionTerms1);
							sheet.addCell(label);
							
							//付款金额 or 收款金额
							label = new Label(6, curRow, GetMoney1);
							sheet.addCell(label);
							
							//付款时间 or 收款时间
							label = new Label(7, curRow, GivedDate1);
							sheet.addCell(label);
							
							//付款金额 or 收款金额
							label = new Label(8, curRow, GivedAmount1);
							sheet.addCell(label);
							
							//付款凭证号 or 收款凭证号
							label = new Label(9, curRow, GivedCode1);
							sheet.addCell(label);
							
							//合同未付金额 or 合同未收金额
							label = new Label(10, curRow, NoGivedReceivedAmount1_str);
							sheet.addCell(label);
							
							//经办人
							label = new Label(11, curRow, ActPer);
							sheet.addCell(label);
							
							//备注
							label = new Label(12, curRow, "");
							sheet.addCell(label);
							
							curRow++;
						}
					}
				}else if("2".equals(ContractClass)){
					List ReceivedList = cbd.getReceivedList(contractid);
					if(ReceivedList != null){
						for(int j=0;j<ReceivedList.size();j++){
							Object[] obj1 = (Object[])ReceivedList.get(j);
							String Stage1           =  (String) obj1[0];
					       	String ConventionTerms1 =  (String) obj1[1];
					       	String GetMoney1        =  (String) obj1[2];
					       	String ReceivedAmount1  =  (String) obj1[3];
					       	String ReceivedDate1    =  (String) obj1[4];
					       	String ReceivedCode1    =  (String) obj1[5];
							if((ReceivedCode1!=null)&&(",".equals(ReceivedCode1.trim()))){//11.5.0.0 去掉显示的时候显示的逗号
								 ReceivedCode1="";
							 }
					       	String ActPer =  (String) obj1[6];
							if((ActPer!=null)&&(",".equals(ActPer.trim()))){//11.5.0.0 去掉显示的时候显示的逗号
								 ActPer="";
							 }
					       	double NoGivedReceivedAmount1 = Double.parseDouble(GetMoney1) - Double.parseDouble(ReceivedAmount1);
					       	sumGRAmount1 = sumGRAmount1 + Double.parseDouble(ReceivedAmount1);
						   	bg=new BigDecimal(GetMoney1);
						   	GetMoney1 = bg.toString();
						   	bg=new BigDecimal(ReceivedAmount1);
						   	ReceivedAmount1 = bg.toString();
						   	String NoGivedReceivedAmount1_str = String.valueOf(NoGivedReceivedAmount1);
						   	bg=new BigDecimal(NoGivedReceivedAmount1_str);
						   	NoGivedReceivedAmount1_str = bg.toString();
						   	//处理显示科学计数法-----20130817-----开始
							GetMoney1 =df.format(Double.valueOf(GetMoney1));
							ReceivedAmount1 =df.format(Double.valueOf(ReceivedAmount1));
							NoGivedReceivedAmount1_str =df.format(Double.valueOf(NoGivedReceivedAmount1_str));
							//处理显示科学计数法-----20130817-----结束
						   	
						   	//合同号
							label = new Label(0, curRow, "");
							sheet.addCell(label);
							
							//合同名称
							label = new Label(1, curRow, "");
							sheet.addCell(label);
							
							//合同甲方
							label = new Label(2, curRow, "");
							sheet.addCell(label);
							
							//合同乙方
							label = new Label(3, curRow, "");
							sheet.addCell(label);
							
							//分期
							label = new Label(4, curRow, Stage1);
							sheet.addCell(label);
							
							//约定条款
							label = new Label(5, curRow, ConventionTerms1);
							sheet.addCell(label);
							
							//付款金额 or 收款金额
							label = new Label(6, curRow, GetMoney1);
							sheet.addCell(label);
							
							//付款时间 or 收款时间
							label = new Label(7, curRow, ReceivedDate1);
							sheet.addCell(label);
							
							//付款金额 or 收款金额
							label = new Label(8, curRow, ReceivedAmount1);
							sheet.addCell(label);
							
							//付款凭证号 or 收款凭证号
							label = new Label(9, curRow, ReceivedCode1);
							sheet.addCell(label);
							
							//合同未付金额 or 合同未收金额
							label = new Label(10, curRow, NoGivedReceivedAmount1_str);
							sheet.addCell(label);
							
							//经办人
							label = new Label(11, curRow, ActPer);
							sheet.addCell(label);
							
							//备注
							label = new Label(12, curRow, "");
							sheet.addCell(label);
							
							curRow++;
						}
					}
				}
			}
			String sumGRAmount1_str = String.valueOf(sumGRAmount1);
			bg=new BigDecimal(sumGRAmount1_str);
			sumGRAmount1_str = bg.toString();
            
            String sumNoGRAmount1_str = String.valueOf(sumNoGRAmount1);
			bg=new BigDecimal(sumNoGRAmount1_str);
			sumNoGRAmount1_str = bg.toString();
			
			/*合计部分*/
			label = new Label(7, curRow, "项目合计");
			sheet.addCell(label);
			
			label = new Label(8, curRow, sumGRAmount1_str);
			sheet.addCell(label);
			
			label = new Label(10, curRow, sumNoGRAmount1_str);
			sheet.addCell(label);
		}
		wwb.write();
		wwb.close();
	}  catch (Exception e) {
		e.printStackTrace();
	}finally{  
            try {  
                os.flush();  
                os.close();  
            } catch (IOException e) {}  
              
    } 
 	
%>