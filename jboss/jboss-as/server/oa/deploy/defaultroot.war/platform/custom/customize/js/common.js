
$(document).ready(function(){
    //-----表单字段控制
    $("#readrightbut").click(function(){  
        $("#readField").append($("#fountainField option:selected"));  
    });
	$("#readrightallbut").click(function(){  
		$("#readField").append($("#fountainField option"));  
    }); 
	$("#readleftbut").click(function(){  
        $("#fountainField").append($("#readField option:selected"));
    }); 
	$("#readleftallbut").click(function(){  
        $("#fountainField").append($("#readField option"));  
    });

	$("#writerightbut").click(function(){  
        $("#writeField").append($("#fountainField option:selected"));  
    });
	$("#writerightallbut").click(function(){  
		$("#writeField").append($("#fountainField option"));  
    }); 
	$("#writeleftbut").click(function(){  
        $("#fountainField").append($("#writeField option:selected"));
    }); 
	$("#writeleftallbut").click(function(){  
        $("#fountainField").append($("#writeField option"));  
    }); 
    
	$("#hiderightbut").click(function(){  
        $("#hiddenField").append($("#fountainField option:selected"));  
    });
	$("#hiderightallbut").click(function(){  
		$("#hiddenField").append($("#fountainField option"));  
    }); 
	$("#hideleftbut").click(function(){  
        $("#fountainField").append($("#hiddenField option:selected"));
    }); 
	$("#hideleftallbut").click(function(){  
        $("#fountainField").append($("#hiddenField option"));  
    });

	//----列表字段控制
     $("#modirightbut").click(function(){  
        $("#listWriteField").append($("#fountainField1 option:selected"));  
    });
	$("#modirightallbut").click(function(){  
		$("#listWriteField").append($("#fountainField1 option"));  
    }); 
	$("#modileftbut").click(function(){  
        $("#fountainField1").append($("#listWriteField option:selected"));
    }); 
	$("#modileftallbut").click(function(){  
        $("#fountainField1").append($("#listWriteField option"));  
    });


    $("#constrainA").click(function(){
      
	  var tmp = $("#menuWhereSql").val();
	  var mainTblField1 = $('#mainTblField1').val();
	  var mainoper1 = $("#mainoper1").val();
	  var mainval1 = $('#mainval1').val();
	  var mainuion = $("#mainuion").val();
	  var mainTblField2 = $('#mainTblField2').val();
	  var mainoper2 = $("#mainoper2").val();
	  var mainval2 = $('#mainval2').val();
	  
	  if(mainTblField1!=''&&mainTblField1!='-1'){
		  if(tmp != ""){
			tmp += " and ";
		  }
		  if(mainuion!="-1" && mainTblField2!='' &&mainTblField2!='-1'){
		     tmp += "("+mainTblField1+" "+mainoper1+" '"+mainval1+"' "+mainuion+" "+mainTblField2+" "+mainoper2+" '"+mainval2+"' )";
		  }else{
		     tmp += "("+mainTblField1+" "+mainoper1+" '"+mainval1+"')";
		  }
	  }
      $("#menuWhereSql").val(tmp); 
    });
	$("#constrainB").click(function(){  
         $("#menuWhereSql").val(''); 
		 $("#mainTblField1").get(0).selectedIndex=0;
		 $("#mainval1").get(0).selectedIndex=0;
         $("#mainuion").get(0).selectedIndex=0;
		 $("#mainoper1").get(0).selectedIndex=0;
		 $("#mainTblField2").get(0).selectedIndex=0;
		 $("#mainoper2").get(0).selectedIndex=0;
		 $("#mainval2").get(0).selectedIndex=0;
    });

	//排序
    $("#orderbutA").click(function(){  
      
	  var tmp = $("#orderStr").val();
	  var fieldName1 = $('#fieldName1').val();
	  var field1Desc1 = 'asc';
	  if($("#field1Desc1").attr("checked")){
			field1Desc1 = 'desc';
	   }
	  if(fieldName1!=''&&fieldName1!='-1'){
		  if(tmp == ''){
			tmp = " order by "+fieldName1+" "+field1Desc1;
		  }else{
		    tmp += ","+fieldName1+" "+field1Desc1;
		  }
	  }
      $("#orderStr").val(tmp); 
    });
	$("#orderbutB").click(function(){  
        $("#orderStr").val('');
		$("#fieldName1").get(0).selectedIndex=0;
    });


	var rowNum=1;
    //新增行
    $("#listtabbutadd").bind("click",function(){
		rowNum +=1;
		var rowHtml="";
		rowHtml +="<tr id='"+rowNum+"' align='center'>";
		rowHtml +="<td><input type=\"text\" id=\"actname"+rowNum+"\" name=\"actname\" class=\"inputText\" style=\"width:80px;\"/></td>";
		rowHtml +="<td><select id=\"acttype"+rowNum+"\" name=\"acttype\"><option value=\"0\">批量动作</option><option value=\"1\">单选动作</option></select></td>";
		rowHtml +="<td><input type=\"text\" id=\"linkurl"+rowNum+"\" name=\"linkurl\" class=\"inputText\" style=\"width:80px;\"/></td>";
		rowHtml +="<td>";
		rowHtml +="<input type=\"hidden\" id=\"viewscopes"+rowNum+"\" name=\"viewscopes\">";
		rowHtml +="<input type=\"text\" id=\"viewscopenames"+rowNum+"\" name=\"viewscopenames\" readonly=\"readonly\" class=\"inputText\"  style=\"width:80px;\">&nbsp;";
		
		rowHtml +="<a href=\"javascript:void(0);\" style=\"cursor:pointer\" onClick=\"openSelect({allowId:'viewscopes"+rowNum+"', allowName:'viewscopenames"+rowNum+"', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});\"><img src=\"images/select_arrow.gif\" align=\"absmiddle\" style=\"cursor:pointer\"/></a>";

        rowHtml +="</td>";
		rowHtml +="<td><input type=\"button\" class=\"btnButton4font\" value=\"移&nbsp除\" onclick=\"deleteRow('"+rowNum+"')\"/></td>";
		rowHtml +="</tr>";
		$("#actionTbl").append(rowHtml);
    });

	$("#actionTbutton1").click(function(){  
        if($("#actionTbutton1").val()=='打 开'){
		   $("#actionTbutton1").val('关 闭');
		   $('#actionTb1').show();
		}else{
		   $("#actionTbutton1").val('打 开');
		   $('#actionTb1').hide();
		}
    });
	$("#actionTbutton2").click(function(){  
        if($("#actionTbutton2").val()=='打 开'){
		   $("#actionTbutton2").val('关 闭');
		   $('#actionTb2').show();
		}else{
		   $("#actionTbutton2").val('打 开');
		   $('#actionTb2').hide();
		}
    });

	//查询方案设置
    $("#goSelBtn").click(function(){  
        $("#queryFieldSel").append($("#fieldQuerySel option:selected"));  
    });
	$("#goAllBtn").click(function(){  
		$("#queryFieldSel").append($("#fieldQuerySel option"));  
    }); 
	$("#backSelBtn").click(function(){  
        $("#fieldQuerySel").append($("#queryFieldSel option:selected"));
    }); 
	$("#backAllBtn").click(function(){  
        $("#fieldQuerySel").append($("#queryFieldSel option"));  
    });
	//列表标题设置
    $("#goSelBtn1").click(function(){  
        $("#listField").append($("#fieldL option:selected"));  
    });
	$("#goAllBtn1").click(function(){  
		$("#listField").append($("#fieldL option"));  
    }); 
	$("#backSelBtn1").click(function(){  
        $("#fieldL").append($("#listField option:selected"));
    }); 
	$("#backAllBtn1").click(function(){  
        $("#fieldL").append($("#listField option"));  
    });
	//导出字段设置
    $("#goSelBtn2").click(function(){  
        $("#listField2").append($("#fieldL2 option:selected"));  
    });
	$("#goAllBtn2").click(function(){  
		$("#listField2").append($("#fieldL2 option"));  
    }); 
	$("#backSelBtn2").click(function(){  
        $("#fieldL2").append($("#listField2 option:selected"));
    }); 
	$("#backAllBtn2").click(function(){  
        $("#fieldL2").append($("#listField2 option"));  
    });

	//查询方案
	//保存
    $("#saveQuery").click(function(){  
		var queryCaseName = $("#queryCaseName").val();
		if(queryCaseName=='' || $.trim(queryCaseName)==""){
		   whir_alert('请输入方案名称!',null);
		   return;
	    }
        if(queryCaseName!=''&&queryCaseName!=' '){
		   var tblId =  whirExtCombobox.getValue('menuListTableMapSel');
		   var qlFields = '';
		   $("#queryFieldSel option").each(function () {
             qlFields += $(this).val()+","; 
           });
		   if(qlFields==''){
		      whir_alert('请选择查询字段!',null);
	          return;
		   }
		   var newId =  $('#queryCasesSel').val();
		   var saveurl = "tblId="+tblId+"&qlFields="+qlFields+"&caseName="+queryCaseName+"&casetype=0";
		   if(newId!=''&&newId!='-1'&&newId!='new'){
		      saveurl+='&fieldId='+newId;
		   }
		   newId = ajaxForSync("custormermenu!saveQLCaseSet.action",saveurl);
		   //刷新
		   //var plansurl0='custormermenu!getPlansByTblId.action?tblId='+tblId+'&casetype=0&selectedId='+newId;
		   //whirSelect.clear('queryCasesSel');
		   $("#queryCasesSel").empty();
           var json1 = ajaxForSync("custormermenu!getPlansByTblId.action","tblId="+tblId+"&casetype=0&selectedId="+newId);
	       setSelectObj(json1,$('#queryCasesSel'));
		   whirSelect.setValue('queryCasesSel',newId);

           //$('#queryCasesSel').combobox('clear');
           //$('#queryCasesSel').combobox('reload', plansurl0);
		
		}
    });
	//删除
	$("#delQuery").click(function(){
       whir_confirm("您确定删除此方案吗？",function(){
		   var queryCasesSel = $('#queryCasesSel').val();
		   if(queryCasesSel!='-1' && queryCasesSel!='new'){
		      ajaxForSync("custormermenu!delQLCaseSet.action","caseId="+queryCasesSel);
			  var tblId =  whirExtCombobox.getValue('menuListTableMapSel');
		      //刷新
		      //var plansurl0='custormermenu!getPlansByTblId.action?tblId='+tblId+'&casetype=0';
              //$('#queryCasesSel').combobox('clear');
              //$('#queryCasesSel').combobox('reload', plansurl0);
              
			  $("#queryCasesSel").empty();
			  var json1 = ajaxForSync("custormermenu!getPlansByTblId.action","tblId="+tblId+"&casetype=0");
	          setSelectObj(json1,$('#queryCasesSel'));
			  $('#queryCaseName').val('');
			  $('#caseName').hide();

			  var json = ajaxForSync("custormermenu!getListFieldIdByTblId.action","tblId="+tblId);
			  if(json!='')
				 json = eval("("+json+")");
			  //查询方案
			  $("#fieldQuerySel").empty();
			  if(json.length>0){
				 for(var i = 1; i < json.length; i++) {
					var obj = json[i];
					$("#fieldQuerySel").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
				 }
			  }
			  $("#queryFieldSel").empty();
			  
		   }
		 });
		
    });
	//列表标题方案
    $("#saveList").click(function(){  
        var listCaseName = $("#listCaseName").val();
		if(listCaseName=='' || $.trim(listCaseName)==""){
		   whir_alert('请输入方案名称!',null);
		   return;
	    }
        if(listCaseName!=''&&listCaseName!=' '){
		   var tblId =  whirExtCombobox.getValue('menuListTableMapSel');
		   var qlFields = '';
		   $("#listField option").each(function () {
             qlFields += $(this).val()+","; 
           });
		   if(qlFields==''){
		      whir_alert('请选择标题字段!',null);
	          return;
		   }
		   var newId =  $('#listCasesSel').val(); 
		   var saveurl = "tblId="+tblId+"&qlFields="+qlFields+"&caseName="+listCaseName+"&casetype=1";
		   if(newId!=''&&newId!='-1'&&newId!='new'){
		      saveurl+='&fieldId='+newId;
		   }
		   newId = ajaxForSync("custormermenu!saveQLCaseSet.action",saveurl);
		   //刷新
		   //var plansurl0='custormermenu!getPlansByTblId.action?tblId='+tblId+'&casetype=1&selectedId='+newId;
           //$('#listCasesSel').combobox('clear');
           //$('#listCasesSel').combobox('reload', plansurl0);
           $("#listCasesSel").empty();
		   var json1 = ajaxForSync("custormermenu!getPlansByTblId.action","tblId="+tblId+"&casetype=1&selectedId="+newId);
	       setSelectObj(json1,$('#listCasesSel'));
		   whirSelect.setValue('listCasesSel',newId);
		
		}
    });
	$("#delList").click(function(){
         whir_confirm("您确定删除此方案吗？",function(){
           var listCasesSel = $('#listCasesSel').val();
		   if(listCasesSel!='-1' && listCasesSel!='new'){
			  ajaxForSync("custormermenu!delQLCaseSet.action","caseId="+listCasesSel);
			  var tblId =  whirExtCombobox.getValue('menuListTableMapSel');
			  //刷新
			   $("#listCasesSel").empty();
			  var json1 = ajaxForSync("custormermenu!getPlansByTblId.action","tblId="+tblId+"&casetype=1");
	          setSelectObj(json1,$('#listCasesSel'));

			  $('#listCaseName').val('');
			  $('#caseLName').hide();

			  var json = ajaxForSync("custormermenu!getListFieldIdByTblId.action","tblId="+tblId);
			  if(json!='')
				 json = eval("("+json+")");
			  //查询方案
			  $("#fieldL").empty();
			  if(json.length>0){
				 for(var i = 1; i < json.length; i++) {
					var obj = json[i];
					$("#fieldL").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
				 }
			  }
			  $("#listField").empty();
			  
		   }
		});
    });
	//导出字段方案
    $("#saveList2").click(function(){  
        var listCaseName2 = $("#listCaseName2").val();
		if(listCaseName2=='' || $.trim(listCaseName2)==""){
		   whir_alert('请输入方案名称!',null);
		   return;
	    }
        if(listCaseName2!=''&&listCaseName2!=' '){
		   var tblId =  whirExtCombobox.getValue('menuListTableMapSel');
		   var qlFields = '';
		   $("#listField2 option").each(function () {
             qlFields += $(this).val()+","; 
           });
		   if(qlFields==''){
		      whir_alert('请选择导出字段!',null);
	          return;
		   }
		   var newId =  $('#listCasesSel2').val();
		   var saveurl = "tblId="+tblId+"&qlFields="+qlFields+"&caseName="+listCaseName2+"&casetype=2";
		   if(newId!=''&&newId!='-1'&&newId!='new'){
		      saveurl+='&fieldId='+newId;
		   }
		   newId = ajaxForSync("custormermenu!saveQLCaseSet.action",saveurl);
		   //刷新
		   $("#listCasesSel2").empty();
		   var json1 = ajaxForSync("custormermenu!getPlansByTblId.action","tblId="+tblId+"&casetype=2&selectedId="+newId);
	       setSelectObj(json1,$('#listCasesSel2'));
		   whirSelect.setValue('listCasesSel2',newId);
		
		}
    });
	$("#delList2").click(function(){  
        whir_confirm("您确定删除此方案吗？",function(){
		   var listCasesSel2 = $('#listCasesSel2').val();
		   if(listCasesSel2!='-1' && listCasesSel2!='new'){
			  ajaxForSync("custormermenu!delQLCaseSet.action","caseId="+listCasesSel2);
			  var tblId =  whirExtCombobox.getValue('menuListTableMapSel');
			  //刷新
			  $("#listCasesSel2").empty();
			  var json1 = ajaxForSync("custormermenu!getPlansByTblId.action","tblId="+tblId+"&casetype=2");
	          setSelectObj(json1,$('#listCasesSel2'));

			  $('#listCaseName2').val('');
			  $('#caseLName2').hide();

			  var json = ajaxForSync("custormermenu!getListFieldIdByTblId.action","tblId="+tblId);
			  if(json!='')
				 json = eval("("+json+")");
			  //查询方案
			  $("#fieldL2").empty();
			  if(json.length>0){
				 for(var i = 1; i < json.length; i++) {
					var obj = json[i];
					$("#fieldL2").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
				 }
			  }
			  $("#listField2").empty();
			  
		   }
		});
    });
    

}); 


//设置下拉框选项
function setSelectObj(json,selectObj){

    if(json!='')
		 json = eval("("+json+")");
    selectObj.empty();
    if(json.length>0){
		 for(var i = 0; i < json.length; i++) {
			var obj = json[i];
			selectObj.append("<option value='"+obj.id+"'>"+obj.text+"</option>");
		 }
	 }

}
function changeSub(val) {

 if (val == -1){
	 $('#mainmenuorder').show();
	 $('#defHrefSpan').show();
	 //设置子栏目下拉框数据
	 var json1 = ajaxForSync("custormermenu!getSubMenusById.action","menuId=0");
	 setSelectObj(json1,$('#menuLocation'));

	 //设置地址链接为选中
	 $("input[name='readCK']").each(function(){
		if($(this).val()==1){
			$(this).attr("checked","checked");
		}
	 });
	 $('#linktitleTR1').show();
	 $('#linktitleTR2').hide();
	 $('#linktitleTR3').hide();
	 $('#linktitleTR4').hide();
	 $('#linkTR1').show();
	 $('#linkTR2').hide();
	 $('#linkTR3').hide();
	 $('#linkTR4').hide();	 
	 $('#mobileIsOpen').show();//移动端启用
	 //$('#mobileEnterpriseId').show();//企业号应用ID
	 
  }else{
	 $('#mainmenuorder').hide();
	 $('#defHrefSpan').hide();
	 //设置子栏目下拉框数据
	 var json1 = ajaxForSync("custormermenu!getSubMenusById.action","menuId="+val);
	 setSelectObj(json1,$('#menuLocation'));

	 $('#linktitleTR1').show();
	 $('#linktitleTR2').show();
	 $('#linktitleTR3').show();
	 $('#linktitleTR4').show();
	 $('#mobileIsOpen').hide();//移动端启用
	 //$('#mobileEnterpriseId').hide();//企业号应用ID

  }
}
function cleanData(flag) {

 if(flag==1){
	 
	 $("input[name='readCK']").each(function(){
		if($(this).val()==1){
			$(this).attr("checked","checked");
		}
	 });
	 $('#linkTR1').show();
	 $('#linkTR2').hide();
	 $('#linkTR3').hide();
	 $('#linkTR4').hide();
 }else if(flag==2){	 
	 $("input[name='readCK']").each(function(){
		if($(this).val()==2){
			$(this).attr("checked","checked");
		}
	 });
	 $('#readCK2').attr("checked",true); 
	 $('#linkTR1').hide();
	 $('#linkTR2').show();
	 $('#linkTR3').hide();
	 $('#linkTR4').hide();
		 	 
 }else if(flag==3){
	 $("input[name='readCK']").each(function(){
		if($(this).val()==3){
			$(this).attr("checked","checked");
		}
	 });
	 $('#linkTR1').hide();
	 $('#linkTR2').hide();
	 $('#linkTR3').show();
	 $('#linkTR4').hide();
 }else if(flag==4){
	 $("input[name='readCK']").each(function(){
		if($(this).val()==4){
			$(this).attr("checked","checked");
		}
	 });
	 $('#linkTR1').hide();
	 $('#linkTR2').hide();
	 $('#linkTR3').hide();
	 $('#linkTR4').show();
 }
}
function initListTalbes(val) {
 
	 /*var url='custormermenu!getTableListByModelId.action?modelId='+val;
	 $('#menuListTableMapSel').combobox('clear');
	 $('#menuListTableMapSel').combobox('reload', url);*/

	 whirExtCombobox.clear('menuListTableMapSel');

	var modelId = val;

	tableStore.load({params:{modelId:modelId}});
}

function selmenuListTab(val,menuSearchBound){
     
	 //获取表单数据
	 var json1 = ajaxForSync("custormermenu!getQueryMainFormByTblId.action","tblId="+val);
	 setSelectObj(json1,$('#menuSearchBound'));
	 if(menuSearchBound!=''){
	   whirSelect.setValue('menuSearchBound',menuSearchBound);
	 }

	 if(1==1){//重新选择数据表时候
		 var relationTrigSelect = $("select[name='relationTrig']");//字段联动下拉框
			if( relationTrigSelect.length > 0 ){
				var alloptions = relationTrigSelect[0].options;//清空
				for( j=alloptions.length-1;j>=1;j--){
					relationTrigSelect[0].remove(j);
				}
			}	
			$('#tr_relationTrig').hide();		 
	 }	 
	 //获取字段数据
	 var json2 = ajaxForSync("custormermenu!getListFieldByTblId.action","tblId="+val);
	 setSelectObj(json2,$('#mainTblField1'));
	 setSelectObj(json2,$('#mainTblField2'));
	 
	 //排序字段
	 setSelectObj(json2,$('#fieldName1'));
	 
	 var json = ajaxForSync("custormermenu!getListFieldIdByTblId.action","tblId="+val);
	 if(json!=''){
		 json = eval("("+json+")");
	 }
	 
	 if(json2!=''){
		 json2 = eval("("+json2+")");
	 }
	//查询方案、列表标题、导出字段  update by tianml 11.4版本新需求	
	 if(json.length>0){
		 var html="";
		 for(var i = 1; i < json.length; i++) {//从1开始，0是请选择
			var obj = json[i];
			var objlink = json2[i];
			 
			html+="<tr>";
			html+="<td>"+obj.text+"</td>";
			html+="<td><input type='checkbox' value='"+obj.id+"' name='listShow' id='listShow_"+i+"'/></td>";
			html+="<td><input type='checkbox' value='"+obj.id+"' name='selectCase' id='selectCase_"+i+"'/></td>";			
			html+="<td><input type='radio' value='"+objlink.id+"' name='menuMaintenanceSubTableName' id='linkField_"+i+"'/></td>";
			html+="<td><input type='checkbox' value='"+obj.id+"' name='exportField' id='exportField_"+i+"'/></td>"; 
			html+="<td><input type='checkbox' value='"+obj.id+"' name='mobile_listf' id='mobile_listf_"+i+"'/></td>";
			html+="<td><input type='checkbox' value='"+obj.id+"' name='mobile_searchf' id='mobile_searchf_"+i+"'/></td>";                                         
			html+="</tr>";						
			//$("#fountainField").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
		 }

		 $("#itemContainer_list").html(html);
	 }
	 
	 /*//查询方案
	 $("#fieldQuerySel").empty();
	 if(json.length>0){
		 for(var i = 1; i < json.length; i++) {
			var obj = json[i];
			$("#fieldQuerySel").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
		 }
	 }
	 $("#queryFieldSel").empty();

	 //列表标题
	 $("#fieldL").empty();
	 if(json.length>0){
		 for(var i = 1; i < json.length; i++) {
			var obj = json[i];
			$("#fieldL").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
		 }
	 }
	 $("#listField").empty();

	 //导出字段
	 $("#fieldL2").empty();
	 if(json.length>0){
		 for(var i = 1; i < json.length; i++) {
			var obj = json[i];
			$("#fieldL2").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
		 }
	 }
	 $("#listField2").empty();*/	 
	 
	 //链接字段
	 //setSelectObj(json1,$('#menuMaintenanceSubTableName'));


	 //获取表对应方案/查询方案
    /* var json2 = ajaxForSync("custormermenu!getPlansByTblId.action","tblId="+val+"&casetype=0");
	 setSelectObj(json2,$('#queryCasesSel'));*/

	 //获取表对应方案/列表标题
	 /*var json3 = ajaxForSync("custormermenu!getPlansByTblId.action","tblId="+val+"&casetype=1");
	 setSelectObj(json3,$('#listCasesSel'));*/

	 //获取表对应方案/导出字段
	 /*var json4 = ajaxForSync("custormermenu!getPlansByTblId.action","tblId="+val+"&casetype=2");
	 setSelectObj(json4,$('#listCasesSel2'));*/

	 //$('#caseName').hide();
	 //$('#caseLName').hide();
	 //$('#caseLName2').hide();
	 
	 
}
function selplan(casetype){

	 var menuListTableMapSel = whirExtCombobox.getValue('menuListTableMapSel');

	 if(menuListTableMapSel!='-1'&&menuListTableMapSel!=''){
			 //alert(menuListTableMapSel);

			 var json = ajaxForSync("custormermenu!getListFieldIdByTblId.action","tblId="+menuListTableMapSel);
			 if(json!='')
				 json = eval("("+json+")");

			 //获取表对应方案/查询方案
			 if(casetype==0){
				 var val = $('#queryCasesSel').val();
				 if(val=='-1'){
					 //查询方案
					 $("#fieldQuerySel").empty();
					 if(json.length>0){
						 for(var i = 1; i < json.length; i++) {
							var obj = json[i];
							$("#fieldQuerySel").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
						 }
					 }
					 $("#queryFieldSel").empty();
					 $("#caseName").hide();

				 }else if(val=='new'){
					 $("#queryCaseName").val('');
					 $("#caseName").show();
					 $("#fieldQuerySel").empty();
					 if(json.length>0){
						 for(var i = 1; i < json.length; i++) {
							var obj = json[i];
							$("#fieldQuerySel").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
						 }
					 }
					 $("#queryFieldSel").empty();


				 }else{
					 
					 var seljson = ajaxForSync("custormermenu!getQueryShowFieldsByCase.action","caseId="+val);
					 if(seljson!='')
						seljson = eval("("+seljson+")");
					 $("#queryFieldSel").empty();
					 var seljsons = '';
					 if(seljson.length>0){
						 for(var i = 0; i < seljson.length; i++) {
							var obj = seljson[i];
							$("#queryFieldSel").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
							seljsons += '$'+obj.id+'&';
						 }
					 }

					 $("#fieldQuerySel").empty();
					 if(json.length>0){
						 for(var i = 1; i < json.length; i++) {
							var obj = json[i];
							if(seljsons.indexOf(obj.id)==-1){
							   $("#fieldQuerySel").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
							}
						 }
					 }
					 $("#queryCaseName").val(whirSelect.getText("queryCasesSel"));
					 $("#caseName").show();
				 }
			 }else if(casetype==1){                    //获取表对应方案/列表标题
				 var val = $('#listCasesSel').val();
				 if(val=='-1'){
					 //列表标题
					 $("#fieldL").empty();
					 if(json.length>0){
						 for(var i = 1; i < json.length; i++) {
							var obj = json[i];
							$("#fieldL").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
						 }
					 }
					 $("#listField").empty();
					 $("#caseLName").hide();

				 }else if(val=='new'){
					 $("#listCaseName").val('');
					 $("#caseLName").show();

					 $("#fieldL").empty();
					 if(json.length>0){
						 for(var i = 1; i < json.length; i++) {
							var obj = json[i];
							$("#fieldL").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
						 }
					 }
					 $("#listField").empty();

				 }else{

					 var seljson = ajaxForSync("custormermenu!getQueryShowFieldsByCase.action","caseId="+val);
					 if(seljson!='')
						seljson = eval("("+seljson+")");
					 $("#listField").empty();
					 var seljsons = '';
					 if(seljson.length>0){
						 for(var i = 0; i < seljson.length; i++) {
							var obj = seljson[i];
							$("#listField").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
							seljsons += '$'+obj.id+'&';
						 }
					 }

					 $("#fieldL").empty();
					 if(json.length>0){
						 for(var i = 1; i < json.length; i++) {
							var obj = json[i];
							if(seljsons.indexOf(obj.id)==-1){
							   $("#fieldL").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
							}
						 }
					 }
					 $("#listCaseName").val(whirSelect.getText("listCasesSel"));
					 $("#caseLName").show();
				 }
			 }else if(casetype==2){                      //获取表对应方案/导出字段
				 var val = $('#listCasesSel2').val();
				 if(val=='-1'){
					 //导出字段
					 $("#fieldL2").empty();
					 if(json.length>0){
						 for(var i = 1; i < json.length; i++) {
							var obj = json[i];
							$("#fieldL2").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
						 }
					 }
					 $("#listField2").empty();
					 $("#caseLName2").hide();
				 }else if(val=='new'){

					 $("#listCaseName2").val('');
					 $("#caseLName2").show();

					 $("#fieldL2").empty();
					 if(json.length>0){
						 for(var i = 1; i < json.length; i++) {
							var obj = json[i];
							$("#fieldL2").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
						 }
					 }
					 $("#listField2").empty();

				 }else{
					 
					 var seljson = ajaxForSync("custormermenu!getQueryShowFieldsByCase.action","caseId="+val);
					 if(seljson!='')
						seljson = eval("("+seljson+")");
					 $("#listField2").empty();
					 var seljsons = '';
					 if(seljson.length>0){
						 for(var i = 0; i < seljson.length; i++) {
							var obj = seljson[i];
							$("#listField2").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
							seljsons += '$'+obj.id+'&';
						 }
					 }

					 $("#fieldL2").empty();
					 if(json.length>0){
						 for(var i = 1; i < json.length; i++) {
							var obj = json[i];
							if(seljsons.indexOf(obj.id)==-1){
							   $("#fieldL2").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
							}
						 }
					 }
					 $("#listCaseName2").val(whirSelect.getText("listCasesSel2"));
					 $("#caseLName2").show();
				 }
			 }
	 }
}

function setFields(val){

 $("#fountainField").empty();
 $("#readField").empty();
 $("#writeField").empty();
 $("#hiddenField").empty();
 $("#listWriteField").empty();
 
 //新表单
 if(val.indexOf("new$")!=-1){
     var _val = val.replace("new$","");
	 var json = ajaxForSync('custormermenu!getNewPageField.action?pageId='+_val);

	 if(json!='')
		 json = eval("("+json+")");

	 $("#fountainField").empty();
	 if(json.length>0){
		 for(var i = 0; i < json.length; i++) {
			var obj = json[i];
			$("#fountainField").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
		 }
	 }
	 $("#fountainField1").empty();
	 if(json.length>0){
		 for(var i = 0; i < json.length; i++) {
			var obj = json[i];
			$("#fountainField1").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
		 }
	 }
 }else{

    var json = ajaxForSync('custormermenu!getPageField.action?pageId='+val);

	 if(json!='')
		 json = eval("("+json+")");

	 $("#fountainField").empty();
	 if(json.length>0){
		 for(var i = 0; i < json.length; i++) {
			var obj = json[i];
			$("#fountainField").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
		 }
	 }
	 $("#fountainField1").empty();
	 if(json.length>0){
		 for(var i = 0; i < json.length; i++) {
			var obj = json[i];
			$("#fountainField1").append("<option value='"+obj.id+"'>"+obj.text+"</option>");
		 }
	 }
 }

}


function opensetField(obj) {
   if(obj.value=="打开"){
	 obj.value="关闭";
	 $('#actionTb3').show();
	 $('#formfieldFlag').val('1');
   }else{
	 obj.value="打开";
	 $('#actionTb3').hide();
	 $('#formfieldFlag').val('0');
	 $("#fountainField").append($("#readField option"));  
     $("#fountainField").append($("#writeField option"));  
     $("#fountainField").append($("#hiddenField option")); 
   }
   
}
 function opensetField1(obj) {
   if(obj.value=="打开"){
	 obj.value="关闭";
	 $('#actionTb4').show();
	 $('#listfieldFlag').val('1');
   }else{
	 obj.value="打开";
	 $('#actionTb4').hide();
	 $('#listfieldFlag').val('0');
	 $("#fountainField1").append($("#listWriteField option")); 
   }
   
 }
 function showQuery(show) {
    if (show == "1") {
    	$('#queryF').show();
    } else {
        $('#queryF').hide();
    }
}
 function showTitle(show) {
    if (show == "1") {
    	$("#titleF").show();
    } else {
        $("#titleF").hide();
    }
 }
 function showexp(exp) {

    if (exp == "1") {
    	$("#ExpFieldE").show();
    } else if(exp == "0"){
        $("#ExpFieldE").hide();
    } else {
    	$("#ExpFieldE").hide();
    }
 }
 function changeDef(val) {
    if(val=='-1'){
	   $('#taborder').hide();
	}else{
	   $('#taborder').show();
	}
 }

//删除行
function deleteRow(num){
    $("#actionTbl").children().find("#"+num).remove();
}

function isDigit(s) { 
	var patrn=/^[0-9]{1,20}$/; 
	if (!patrn.exec(s)) return false 
	return true 
}
function setSelectSave() {
	//默认选中读字段
	$("#readField").append($("#fountainField option"));  
    alert("setSelectSave");
	setSelectSel(document.getElementById("fountainField"));
	setSelectSel(document.getElementById("readField"));
	setSelectSel(document.getElementById("writeField"));
	setSelectSel(document.getElementById("hiddenField"));

	setSelectSel(document.getElementById("fountainField1"));
	setSelectSel(document.getElementById("listWriteField"));
}
function setSelectSel(obj) {
	for (var i=0;i<obj.length;i++){ 
		alert("setSelectSave");
       obj.options[i].selected = true;
	}
}
//设置移动端查询或者列表的选中值  add by tianml 2015/11/30
function changeMobileCheckbox(type){
	var s_type=document.getElementById(type);	 
	if(s_type.checked==true){
		s_type.value="1";
	}else{
    	s_type.value="0";
    }		
 }

