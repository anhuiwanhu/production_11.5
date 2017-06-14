<script src="<%=rootPath%>/platform/bpm/i18n/js_workflowMessage.jsp"   type="text/javascript"></script>
<script src="<%=rootPath%>/public/toolbar/WhirToolbar.js"   type="text/javascript"></script>
<!--工具栏工作流按钮事件公用js-->
<script src="<%=rootPath%>/platform/bpm/ezflow/js/workflow.js"   type="text/javascript"></script>
<!--工具栏工作流js-->
<script src="<%=rootPath%>/platform/bpm/ezflow/js/wf.js"   type="text/javascript"></script>

<link   href="<%=rootPath%>/scripts/plugins/zTree/css/2012/zTreeStyle.css" rel="stylesheet" type="text/css"/>
<!--link   href="<%=rootPath%>/scripts/plugins/zTree/css/2012/iconSkin.css" rel="stylesheet" type="text/css"/-->
<script src="<%=rootPath%>/scripts/plugins/zTree/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/plugins/zTree/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
<%if(isForbiddenPad){%>
<script src="<%=rootPath%>/public/treeselect/script.js"   type="text/javascript"></script>
<%}else{%>
<script src="<%=rootPath%>/public/treeselect/script_ipad.js"   type="text/javascript"></script>
<%}%>
<script src="<%=rootPath%>/platform/bpm/ezflow/graph/whirflow/src/name/xio/util/Map.js" type="text/javascript"></script> 
<script src="<%=rootPath%>/platform/bpm/ezflow/graph/whirflow/src/name/xio/util/List.js" type="text/javascript"></script> 
<script type="text/javascript">
<!--  
 
     var tableListProcessSet = new List(); 

	 function setTableListProcessSet(list){
		 tableListProcessSet=list;
	 }

	 function clearTableListProcess(){
	 	  tableListProcessSet = new List(); 
	 }
 
	 function addTableListProcess(str){ 
		 var varmap=new Map(); 
		 varmap.put("eachIndex",str[0]);
		 varmap.put("participantType",str[1]);
		 varmap.put("eachIndex",str[2]);
		 varmap.put("passRound_candidateId",str[3]); 
		 varmap.put("passRound_candidate",str[4]);
		 varmap.put("taskSequenceType",str[5]);
		 varmap.put("priority",str[6]);
		 varmap.put("userTaskname",str[7]);
		 tableListProcessSet.add(varmap);   
	 }

	 function getTableListProcessSet(){ 
		 return tableListProcessSet;
	 }
 

 
//-->
</script>