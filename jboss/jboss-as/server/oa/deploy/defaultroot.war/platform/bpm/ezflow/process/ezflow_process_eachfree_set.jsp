<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String  haveUserTask= ""+request.getAttribute("haveUserTask");
if(haveUserTask.equals("1")){ 
	 String url=rootPath+"/platform/bpm/ezflow/graph/jsp/updateprocess.jsp?recordId=&subType=0&moduleId="+request.getParameter("moduleId")
		 +"&processDefId="+request.getParameter("processDefId");
     response.sendRedirect(url); 
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>标准列表页面结构</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox"> 
 <s:form name="dataForm" id="dataForm" action="ezflowprocess!SaveFreeProcessDef.action" method="post" theme="simple" >
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>  
	<!-- SEARCH PART END --> 
    <input type="hidden"  name="processDefId" id="processDefId" value="<%=request.getParameter("processDefId")+""%>">
	<input type="hidden"  name="p_wf_moduleId"  id="p_wf_moduleId"  value="<%=request.getParameter("moduleId")+""%>" >
	<input type="hidden"  name="haveUserTask"   id="haveUserTask"   value="<%=request.getAttribute("haveUserTask")+""%>" >
    <input type="hidden"  name="needToGraph"    id="needToGraph"   value="0">
   <!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			 <td align="right" width="55%">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right">
			  <input type="button" class="btnButton4font" onclick="saveOK(0);"  value='确　　定' />
                <input type="button" class="btnButton4font" onclick="saveOK(1);"  value='流程设计器' /> 
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead"> 
			<td whir-options="field:'buttonName',width:'25%'">活动名称</td> 
			<td whir-options="field:'buttonTipName',width:'25%'">办理方式</td> 
			<td whir-options="field:'buttonImageUrl',width:'25%'">缓急</td>  
			<td whir-options="field:'',width:'8%',renderer:myOperate">参与者</td>
            <td whir-options="field:'',width:'8%',renderer:myOperate">操作</td>  
        </tr>
		</thead>
		<tbody  id="itemContainer" >
		  <tr  class="listTableLine1"> 
				<td><input  type="text" name="userTaskname"   class="inputText" ></td> 
				<td>
				    <select  name="taskSequenceType">
					   <option value="monopolise"><%=Resource.getValue(local, "workflow", "workflow.monopolise")%></option>
					   <option value="sequential"><%=Resource.getValue(local, "workflow", "workflow.sequential")%></option>
					   <option value="parataxis"><%=Resource.getValue(local, "workflow", "workflow.parataxis")%></option>
					   <option value="monopolise_single"><%=Resource.getValue(local, "workflow", "workflow.single")%></option>
				    </select>
				</td> 
				<td>
				   <select  name="priority">
					   <option value="50"><%=Resource.getValue(local, "filetransact", "file.sort1") %></option>
					   <option value="40"><%=Resource.getValue(local, "filetransact", "file.sort2") %></option>
					   <option value="30"><%=Resource.getValue(local, "filetransact", "file.sort4") %></option>
					   <option value="20"><%=Resource.getValue(local, "filetransact", "file.sort3") %></option>
					   <option value="10"><%=Resource.getValue(local, "filetransact", "file.sort5") %></option>
				    </select>
				</td>  
				<td> 
				    <select  name="participantType" onChange="changerParticipantType(this);">
					   <option value="someUsers">从候选人员中指定</option>
					   <option value="prevTransactorLeader">上一活动办理人的上级领导</option>
					   <option value="allUser">从所有用户中选择</option>
					   <option value="initiator">流程启动人</option>
					   <!-- <option value="someGroups">从选定的群组中选择</option>  --> 
				    </select>
					<span><input type="text" style="width:50%;" class="inputText" name="passRound_candidate0" readonly="true"  id="passRound_candidate0"><a href="#" class="selectIco" onclick="chooseUser(this);return false;"><img src="/defaultroot/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><input type="hidden" name="passRound_candidateId0"  id="passRound_candidateId0" value=""></span>
				</td>
				<td >
				<a href="javascript:void(0)"  onclick="addEachTr(this)"><img src="/defaultroot/images/madd.gif" title="增加" border="0"></a>
				<a href="javascript:void(0)" onclick="delEachTr(this)"><img src="/defaultroot/images/del.gif" title="删除" border="0"></a>
				<a  href="javascript:void(0)"  onclick="nextTr(this)"><img src="/defaultroot/images/move_down.gif" title="下移" border="0"></a>
				<a href="javascript:void(0)"  onclick="lastTr(this)"><img src="/defaultroot/images/move_up.gif" title="上移" border="0"></a>
				<input type="hidden" name="eachIndex" value="0">
				</td>
          </tr>  
		</tbody>
    </table>
    
 </s:form>
</body>
 <script type="text/javascript"> 


   function  judgeHF(){ 
	    var result=true;
		var r_value="\\\,/,?,#,&,\',\"";
	    var speCharArr = r_value.split(",");


		$("input[name='userTaskname']").each(function(){
			var  uvalue=$(this).val();
			if(uvalue==""){
				result=false;
				whir_alert("活动名不能为空！");
			}else if(uvalue.length>30){
				whir_alert("活动名长度不能超过30！");
			}else { 
				for(var i=0;i<speCharArr.length;i++ ){
					if(speCharArr[i]!='' && uvalue.indexOf(speCharArr[i])>=0){
						result=false;
						whir_alert("活动名不能包含特殊字符！");
					}
				}
			}
		});

		if(!result){
		   return false;
		}

    
		$("select[name='participantType']").each(function(){
			  if($(this).val()=="someUsers"){
				  var  index=$(this).parent().parent().find("input[name='eachIndex']").val();  
                  if($("#passRound_candidateId"+index).val()==""){
					   result=false;
				       whir_alert("活动参与人不能为空！");
				  }
			  }
		});

	   return result;
   }
    $(document).ready(function(){		
		    $("#dataForm").ajaxForm({
			   beforeSubmit: function(formData, jqForm, optionss){
			   },
			   success: function(responseText){ 
				    var succ = jQuery(responseText).find("result").text();
					var  recordId = jQuery(responseText).find("processDefinitionId").text();  
			        if(succ==-10) { 
						$("#processDefId").val(recordId);
						if(window.opener){	
							opener.document.getElementById('p_wf_processId').value=recordId;  
						}   
						if($("#needToGraph").val()=="1"){
						   fff();
						}else{
						   window.close();
						}
					}
				},
			   error:   function (XMLHttpRequest, textStatus, errorThrown) { 
							
						}
			});			
	});


    var index=0;  
	function changerParticipantType(obj){ 
		if(obj.value=="someUsers"){
            $(obj).parent().find("span").show();
		}else{
            $(obj).parent().find("span").hide();
		} 
	}
    
	//
	function  chooseUser(obj){
		var  nowIndex=$(obj).parent().parent().parent().find('input[name="eachIndex"]').val(); 
		openSelect({allowId:'passRound_candidateId'+nowIndex, allowName:'passRound_candidate'+nowIndex, select:'user', single:'no', show:'usergroup', range:'*0*',key:'code'});
	}

   	 //字段联动 增加行
	function addEachTr(obj){
		index=index+1;
		var parentTr = $(obj).parent().parent(); 
		var  nowIndex=parentTr.find('input[name="eachIndex"]').val();  
	    var f_tableName_tr_html=parentTr.html();

		f_tableName_tr_html=f_tableName_tr_html.replace("passRound_candidateId"+nowIndex,"passRound_candidateId"+index);
		f_tableName_tr_html=f_tableName_tr_html.replace("passRound_candidateId"+nowIndex,"passRound_candidateId"+index);
		f_tableName_tr_html=f_tableName_tr_html.replace("passRound_candidate"+nowIndex,"passRound_candidate"+index);
		f_tableName_tr_html=f_tableName_tr_html.replace("passRound_candidate"+nowIndex,"passRound_candidate"+index); 

		parentTr.after($('<tr class="listTableLine1">'+f_tableName_tr_html+'</tr>'));  
		var nextTr = parentTr.next("tr").eq(0); 
		nextTr.find('input[name="eachIndex"]').val(index);  
        nextTr.find('input[name=passRound_candidateId'+index+']').val("");
		nextTr.find('input[name=passRound_candidate'+index+']').val("");   
		nextTr.find("span").show();

		/*var secondRow = $(currentTrigTable).find('#refTable tr:eq(1)');
		var _html = $(secondRow).html();
		var tr = $('<tr>'+_html+'</tr>');
		$(tr).find('select[name=_refTableName_'+g_component_no+']').val('');
		$(tr).find('input[name=_refTableAlias_'+g_component_no+']').val('');
		var parentTr = $(obj).parent().parent();
		$(parentTr).after(tr);*/
	}

	//字段联动 ，删去行
	function  delEachTr(obj){
	   var parentTr = $(obj).parent().parent(); 
	   var length= $("input[name='userTaskname']").length; 
	   if(length>1){
		   parentTr.remove();
	   }else{
		   whir_alert('请保留一行',function(){});
	   }
	}


    function  change(nextTr,parentTr){

		var nextTrhtml=nextTr.html();  
		//nextTr.find('select[name=_refTableName_'+g_component_no+']').val('');
		var n_userTaskname_v= nextTr.find("input[name='userTaskname']").val();
		var n_taskSequenceType_v= nextTr.find("select[name='taskSequenceType']").val();
		var n_priority_v= nextTr.find("select[name='priority']").val(); 
		
		var n_index_v=nextTr.find("input[name='eachIndex']").val();  
        var n_passRound_candidateId_v=nextTr.find("input[name=passRound_candidateId"+n_index_v+"]").val();
		var n_passRound_candidate_v=nextTr.find("input[name=passRound_candidate"+n_index_v+"]").val();
		var n_participantType_v= nextTr.find("select[name='participantType']").val();
	 

	    //alert(n_index_v);
		//alert(n_passRound_candidateId_v);
		//alert(n_passRound_candidate_v);





		var f_tableName_tr_html=parentTr.html();
		var userTaskname_v= parentTr.find("input[name='userTaskname']").val();
		var taskSequenceType_v= parentTr.find("select[name='taskSequenceType']").val();
		var priority_v= parentTr.find("select[name='priority']").val();  
	 

		var index_v=parentTr.find("input[name='eachIndex']").val();  
        var passRound_candidateId_v=parentTr.find("input[name=passRound_candidateId"+index_v+"]").val();
		var passRound_candidate_v=parentTr.find("input[name=passRound_candidate"+index_v+"]").val();
		var participantType_v= parentTr.find("select[name='participantType']").val();
	 

	    //alert("passRound_candidateId_v:"+passRound_candidateId_v);
		//alert("passRound_candidateId_v:"+passRound_candidateId_v);

		nextTr.html(f_tableName_tr_html);
		parentTr.html(nextTrhtml); 
		nextTr.find("input[name='userTaskname']").val(userTaskname_v);
		nextTr.find("select[name='taskSequenceType']").val(taskSequenceType_v);
		nextTr.find("select[name='priority']").val(priority_v); 
		nextTr.find("input[name='eachIndex']").val(index_v);

	
	    nextTr.find("input[name=passRound_candidateId"+index_v+"]").val(passRound_candidateId_v);
	    nextTr.find("input[name=passRound_candidate"+index_v+"]").val(passRound_candidate_v); 
		nextTr.find("select[name='participantType']").val(participantType_v);
 



		parentTr.find("input[name='userTaskname']").val(n_userTaskname_v);
		parentTr.find("select[name='taskSequenceType']").val(n_taskSequenceType_v);
		parentTr.find("select[name='priority']").val(n_priority_v); 
	    parentTr.find("input[name='eachIndex']").val(n_index_v);
	    parentTr.find("input[name=passRound_candidateId"+n_index_v+"]").val(n_passRound_candidateId_v);
	    parentTr.find("input[name=passRound_candidate"+n_index_v+"]").val(n_passRound_candidate_v); 
		parentTr.find("select[name='participantType']").val(n_participantType_v);
 


	}
	function  nextTr(obj){

		if($(obj).parent().parent().next("tr").length>0){
			var nextTr = $(obj).parent().parent().next("tr").eq(0); 
		    var parentTr = $(obj).parent().parent();  
			change(nextTr,parentTr);
		}
		 
	}  


	function  lastTr(obj){ 
		if($(obj).parent().parent().prev("tr").length>0){
			var nextTr = $(obj).parent().parent().prev("tr").eq(0); 
		    var parentTr = $(obj).parent().parent();  
			change(parentTr,nextTr);
		} 
	}  
	function saveOK(type){
		var  zhijiegraph=false;
		if(type=="1"){
			 var length= $("input[name='userTaskname']").length; 
	        if(length==1){
				if( $("input[name='userTaskname']").val()==""){
					zhijiegraph=true;
				}
			}

		}
		if(zhijiegraph){
			  fff(); 
		}else if(judgeHF()){
			$("#needToGraph").val(type);
			$("#dataForm").submit();
		}
	}

	function fff(){ 
		var src=whirRootPath+"/platform/bpm/ezflow/graph/jsp/updateprocess.jsp?recordId=&subType=0&moduleId="+$("#p_wf_moduleId").val();
	    src+="&processDefId="+$("#processDefId").val(); 
		location_href(src); 
	}
  
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
   </script>
</html>

