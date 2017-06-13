<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="/defaultroot/weixin/js/common.js"></script>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>选择查询项表单页</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.min.css" />
</head>

<body class="theme-green">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page">
		 <section id="sectionScroll" class="wh-section wh-section-bottomfixed">
		 <section class="wh-plan-head">
			  <p>选择查询项：</p>
		  </section>
          <section id="sectionScroll" class="wh-section wh-section-bottomfixed">
		   <input type="hidden"  name="menuId" value="${menuId}" id="menuId"/>
            <section class="wh-section wh-section-bottomfixed">
              <article class="wh-edit wh-edit-forum">
                <div>
                  <table class="wh-table-edit" id="contenttb">
                    
                  </table>
                  </div>
              </article>
            </section>
          </section>
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="wh-footer-btn row">
                  <a href="#" id="fbtn-cancel" class="fbtn-cancel col-100 fbtn-matter" onclick="searchclick();">查询</a> 
                </div>
              </div>
            </div>
          </footer>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/template.min.js"></script>
	<script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/plugin/zepto.js"></script>
    <script type="text/javascript">
      var myApp = new Framework7();
      var $$ = Dom7;
      // 清除搜索区域焦点bug
      $$(document).on('touchmove', function() {
        if ($$("#searchBug").is(":focus")) {
          $$("#searchBug").blur(); //主动清除焦点
          $$("#searchBug").val("");
        }
      });

      // 搜索焦点时
      $$('#searchBug').on('click', function() {
        if ($$('#list-con li').hasClass('hidden-by-searchbar')) {
          $$('.wh-load-md').hide();
          $$('.wh-load-tap').hide();
        }
      });

	  $(document).ready(function(){
		loadData()	 
      });
		
	  var searchfieldNames="";
      var searchfieldTypes="";
      var searchfieldShows="";
	  //加载数据
	  function loadData(){
	  var url = '/defaultroot/custmenu/getCustDataSearchList.controller';
	  var menuId =$("#menuId").val();
	  $$.ajax({
		  type: "post",
		  url: url,
		  dataType: "text",
		  data : {"menuid" : menuId},
		  success: function(data) {
			var obj = eval("("+data+")");
			if(obj.message.result=="1"&&
			        obj.data.searchFields){
                    var groups = obj.data.searchFields;
                    if(groups instanceof Array){
						var itemContent = "";
				        for(var i=0;i<groups.length;i++){
				            var fieldId=groups[i].fieldId;
				            var fieldDesName=groups[i].fieldDesName;
				            var fieldName=groups[i].fieldName;
				            var fieldWith=groups[i].fieldWith;
				            var fieldValue=groups[i].fieldValue;
				            var fieldType=groups[i].fieldType;
				            var fieldShow = groups[i].fieldShow;
							itemContent += '<tr><th><strong>'+fieldDesName+'</strong></th><td><div class="edit-ipt-a-arrow">';
				            if(fieldType=="1000000" || fieldType=="1000001"){
				               itemContent += '<input class="edit-ipt-r" type="number" id="' + fieldName + '_start" name="' + fieldName + '_start" value="" placeholder="请输入"/> ';
				               itemContent += '<input class="edit-ipt-r" type="number" id="' + fieldName + '_end" name="' + fieldName + '_end" value="" placeholder="请输入"/> ';
				            }else if(fieldShow == '101'){
				                //单行文本
				        		if(fieldType == '1000000'){
				        			itemContent += '<input class="edit-ipt-r" type="number" id="' + fieldName + '" value="" name="' + fieldName + '" maxlength="9" placeholder="请输入"/> ';
				        		}else if(fieldType == '1000001'){
				        			itemContent += '<input class="edit-ipt-r" type="number" id="' + fieldName + '" value="" name="' + fieldName + '" maxlength="18" placeholder="请输入"/> ';
				        		}else{
				        			itemContent += '<input class="edit-ipt-r" type="text" id="' + fieldName + '"  value="" name="' + fieldName + '" placeholder="请输入"/> ';
				        		}
				        		searchfieldNames += fieldName+",";
				            	searchfieldTypes += fieldType+",";
				            	searchfieldShows += fieldShow+",";
				            }else if(fieldShow == '103'){
				                //单选
				                if(groups[i].dataList){
				                   var c_groups = groups[i].dataList;
				                   itemContent += '<select id="' + fieldName + '" name="' + fieldName + '">'+
				        			'<option value="">请选择</option>';
				        			for(var j=0;j<c_groups.length;j++){
				        			    var showval = c_groups[j].showval;
				        			    var hiddenval = c_groups[j].hiddenval;
	                                    if(hiddenval){
	                                      itemContent += '<option value="'+hiddenval+'">'+showval+'</option>';
	                                    }
				        		    }
				        		    itemContent += '</select> ';
				                 }
				                 searchfieldNames += fieldName+",";
				            	 searchfieldTypes += fieldType+",";
				            	 searchfieldShows += fieldShow+",";
				            }else if(fieldShow == '104'){
				        		//多选
				        		 if(groups[i].dataList){
				                   var c_groups = groups[i].dataList;
				        			for(var j=0;j<c_groups.length;j++){
				        			    var showval = c_groups[j].showval;
				        			    var hiddenval = c_groups[j].hiddenval;
	                                    if(hiddenval){
	                                      itemContent += '<input type="checkbox" class="showcheck"  id="' + fieldName +j+'" name="' + fieldName + '" value="'+hiddenval+'">'+showval;
	                                    }
	                                    searchfieldNames += fieldName+j+",";
				            	 		searchfieldTypes += fieldType+",";
				            	 		searchfieldShows += fieldShow+",";
				        		    }
				                 }
		        	        }else if(fieldShow == '105'){
				        		//下拉框
				        		if(groups[i].dataList){
				                   var c_groups = groups[i].dataList;
				                   itemContent += '<select id="' + fieldName + '" name="' + fieldName + '">'+
				        			'<option value="">请选择</option>';
				        			for(var j=0;j<c_groups.length;j++){
				        			    var showval = c_groups[j].showval;
				        			    var hiddenval = c_groups[j].hiddenval;
	                                    if(hiddenval){
	                                      itemContent += '<option value="'+hiddenval+'">'+showval+'</option>';
	                                    }
				        		    }
				        		    itemContent += '</select> ';
				                }
				                searchfieldNames += fieldName+",";
				            	searchfieldTypes += fieldType+",";
				            	searchfieldShows += fieldShow+",";
		        	        }else if(fieldShow == '107'){
				        		//日期
				        		itemContent += '<input  class="edit-ipt-r" data-dateType="date" type="text" id="' + fieldName + '_start" name="' + fieldName + '_start" value="" placeholder="请输入"/> ';
				        		itemContent += '<input  class="edit-ipt-r" data-dateType="date" type="text" id="' + fieldName + '_end" name="' + fieldName + '_end" value="" placeholder="请输入"/> ';
		        	            searchfieldNames += fieldName+",";
				            	searchfieldTypes += fieldType+",";
				            	searchfieldShows += fieldShow+",";
		        	        }else if(fieldShow == '108'){
				        		//时间 
				        		itemContent += '<input  class="edit-ipt-r" data-dateType="time" type="text" id="' + fieldName + '_start" name="' + fieldName + '_start" value="" placeholder="请输入"/> ';
				        		itemContent += '<input  class="edit-ipt-r" data-dateType="time" type="text" id="' + fieldName + '_end" name="' + fieldName + '_end" value="" placeholder="请输入"/> ';
		        	            searchfieldNames += fieldName+",";
				            	searchfieldTypes += fieldType+",";
				            	searchfieldShows += fieldShow+",";
		        	        }else if(fieldShow == '109'){
				        		//日期 时间 
				        		itemContent += '<input  class="edit-ipt-r" data-dateType="datetime" type="text" id="' + fieldName + '_start" name="' + fieldName + '_start" value="" placeholder="请输入"/> ';
				        		itemContent += '<input  class="edit-ipt-r" data-dateType="datetime" type="text" id="' + fieldName + '_end" name="' + fieldName + '_end" value="" placeholder="请输入"/> ';
		        	            searchfieldNames += fieldName+",";
				            	searchfieldTypes += fieldType+",";
				            	searchfieldShows += fieldShow+",";
		        	        }else{
		        		        itemContent += '<input  class="edit-ipt-r" type="text" id="' + fieldName + '" name="' + fieldName + '" value="" placeholder="请输入"/> ';
		        		        searchfieldNames += fieldName+",";
				            	searchfieldTypes += fieldType+",";
				            	searchfieldShows += fieldShow+",";
				            }
							itemContent += '</div></td></tr>';
				        }
						
						$("#contenttb").append(itemContent);
				        
				    }else if(groups instanceof Object){				        
						var fieldId=groups.field.fieldId;
						var fieldDesName=groups.field.fieldDesName;
						var fieldName=groups.field.fieldName;
						var fieldWith=groups.field.fieldWith;
						var fieldValue=groups.field.fieldValue;
						var fieldType=groups.field.fieldType;
						var fieldShow = groups.field.fieldShow;

						var itemContent = '<tr><th><strong>'+fieldDesName+'</strong></th><td><div class="edit-ipt-a-arrow">';
						if(fieldType=="1000000" || fieldType=="1000001"){
						   itemContent += '<input class="edit-ipt-r" type="number" id="' + fieldName + '_start" name="' + fieldName + '_start" value="" placeholder="请输入"/> ';
						   itemContent += '<input class="edit-ipt-r" type="number" id="' + fieldName + '_end" name="' + fieldName + '_end" value="" placeholder="请输入"/> ';
						}else if(fieldShow == '101'){
							//单行文本
							if(fieldType == '1000000'){
								itemContent += '<input class="edit-ipt-r" type="number" id="' + fieldName + '" value="" name="' + fieldName + '" maxlength="9" placeholder="请输入"/> ';
							}else if(fieldType == '1000001'){
								itemContent += '<input class="edit-ipt-r" type="number" id="' + fieldName + '" value="" name="' + fieldName + '" maxlength="18" placeholder="请输入"/> ';
							}else{
								itemContent += '<input class="edit-ipt-r" type="text" id="' + fieldName + '"  value="" name="' + fieldName + '" placeholder="请输入"/> ';
							}
							searchfieldNames += fieldName+",";
							searchfieldTypes += fieldType+",";
							searchfieldShows += fieldShow+",";
						}else if(fieldShow == '103'){
							//单选
							if(groups[i].dataList){
							   var c_groups = groups[i].dataList;
							   itemContent += '<select id="' + fieldName + '" name="' + fieldName + '">'+
								'<option value="">请选择</option>';
								for(var j=0;j<c_groups.length;j++){
									var showval = c_groups[j].showval;
									var hiddenval = c_groups[j].hiddenval;
									if(hiddenval){
									  itemContent += '<option value="'+hiddenval+'">'+showval+'</option>';
									}
								}
								itemContent += '</select> ';
							 }
							 searchfieldNames += fieldName+",";
							 searchfieldTypes += fieldType+",";
							 searchfieldShows += fieldShow+",";
						}else if(fieldShow == '104'){
							//多选
							 if(groups[i].dataList){
							   var c_groups = groups[i].dataList;
								for(var j=0;j<c_groups.length;j++){
									var showval = c_groups[j].showval;
									var hiddenval = c_groups[j].hiddenval;
									if(hiddenval){
									  itemContent += '<input type="checkbox" class="showcheck"  id="' + fieldName +j+'" name="' + fieldName + '" value="'+hiddenval+'">'+showval;
									}
									searchfieldNames += fieldName+j+",";
									searchfieldTypes += fieldType+",";
									searchfieldShows += fieldShow+",";
								}
							 }
						}else if(fieldShow == '105'){
							//下拉框
							if(groups[i].dataList){
							   var c_groups = groups[i].dataList;
							   itemContent += '<select id="' + fieldName + '" name="' + fieldName + '">'+
								'<option value="">请选择</option>';
								for(var j=0;j<c_groups.length;j++){
									var showval = c_groups[j].showval;
									var hiddenval = c_groups[j].hiddenval;
									if(hiddenval){
									  itemContent += '<option value="'+hiddenval+'">'+showval+'</option>';
									}
								}
								itemContent += '</select> ';
							}
							searchfieldNames += fieldName+",";
							searchfieldTypes += fieldType+",";
							searchfieldShows += fieldShow+",";
						}else if(fieldShow == '107'){
							//日期
							itemContent += '<input  class="edit-ipt-r" data-dateType="date" type="text" id="' + fieldName + '_start" name="' + fieldName + '_start" value="" placeholder="请输入"/> ';
							itemContent += '<input  class="edit-ipt-r" data-dateType="date" type="text" id="' + fieldName + '_end" name="' + fieldName + '_end" value="" placeholder="请输入"/> ';
							searchfieldNames += fieldName+",";
							searchfieldTypes += fieldType+",";
							searchfieldShows += fieldShow+",";
						}else if(fieldShow == '108'){
							//时间 
							itemContent += '<input  class="edit-ipt-r" data-dateType="time" type="text" id="' + fieldName + '_start" name="' + fieldName + '_start" value="" placeholder="请输入"/> ';
							itemContent += '<input  class="edit-ipt-r" data-dateType="time" type="text" id="' + fieldName + '_end" name="' + fieldName + '_end" value="" placeholder="请输入"/> ';
							searchfieldNames += fieldName+",";
							searchfieldTypes += fieldType+",";
							searchfieldShows += fieldShow+",";
						}else if(fieldShow == '109'){
							//日期 时间 
							itemContent += '<input  class="edit-ipt-r" data-dateType="datetime" type="text" id="' + fieldName + '_start" name="' + fieldName + '_start" value="" placeholder="请输入"/> ';
							itemContent += '<input  class="edit-ipt-r" data-dateType="datetime" type="text" id="' + fieldName + '_end" name="' + fieldName + '_end" value="" placeholder="请输入"/> ';
							searchfieldNames += fieldName+",";
							searchfieldTypes += fieldType+",";
							searchfieldShows += fieldShow+",";
						}else{
							itemContent += '<input  class="edit-ipt-r" type="text" id="' + fieldName + '" name="' + fieldName + '" value="" placeholder="请输入"/> ';
							searchfieldNames += fieldName+",";
							searchfieldTypes += fieldType+",";
							searchfieldShows += fieldShow+",";
						}
						itemContent += ' </div></td></tr>';
						$("#contenttb").append(itemContent);
				}				
				
		  }},error: function(xhr, status) {
			alert('数据查询异常！');
		  }
	  });
  
	  }

	  //查询
		function searchclick(){
			var menuId =$("#menuId").val();
	        var searchfieldNamess = searchfieldNames.split(",");
	        var searchfieldTypess = searchfieldTypes.split(",");
	        var searchfieldShowss = searchfieldShows.split(",");
	        var cust_queryField = '';
	        var cust_queryText = '';
	        if(searchfieldNamess!='' && searchfieldNamess.length>0){
	           for(var i=0;i<searchfieldNamess.length-1;i++){
	             var fieldName = searchfieldNamess[i];
	             var fieldType = searchfieldTypess[i];
	             var fieldShow = searchfieldShowss[i];
	             if(fieldName!=''){
		              if(fieldType=="1000000" || fieldType=="1000001"){
		
			             if(document.getElementById(fieldName + '_start').value !=''){
			                cust_queryField += fieldName + '_start|';
			                cust_queryText += document.getElementById(fieldName + '_start').value+'|';
			             }
			             if(document.getElementById(fieldName + '_end').value!=''){
			                cust_queryField += fieldName + '_end|';
			                cust_queryText += document.getElementById(fieldName + '_end').value+'|';
			             }
			          }else if(fieldShow == '101' ||
			                   fieldShow == '103' ||
			                   fieldShow == '105'){
				              if(document.getElementById(fieldName).value!=''){
				                cust_queryField += fieldName + '|';
				                cust_queryText += document.getElementById(fieldName).value+'|';
				              }
	    	           }else if(fieldShow == '104'){
				              if(document.getElementById(fieldName).checked == true){
				                cust_queryField += fieldName + '|';
				                cust_queryText += document.getElementById(fieldName).value+'|';
				              }
	    	           }else if(fieldShow == '107' ||
	    	                  fieldShow == '108' ||
	    	                  fieldShow == '109'){
				      	     if(document.getElementById(fieldName + '_start').value!=''){
				                cust_queryField += fieldName + '_start|';
				                cust_queryText += document.getElementById(fieldName + '_start').value+'|';
				             }
				             if(document.getElementById(fieldName + '_end').value!=''){
				                cust_queryField += fieldName + '_end|';
				                cust_queryText += document.getElementById(fieldName + '_end').value+'|';
				             }
		    	        }else{
		    		        if(document.getElementById(fieldName).value!=''){
				                cust_queryField += fieldName + '|';
				                cust_queryText += document.getElementById(fieldName).value+'|';
				            }
			            }
		             }
	              }
	           }
	           window.location = "/defaultroot/custmenu/custData.controller?cust_queryField="+cust_queryField+"&cust_queryText="+cust_queryText+"&menuId="+menuId;
				
		}
    </script>
</body>

</html>
