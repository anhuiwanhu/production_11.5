<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>${menuName}</title> 
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.min.css" />
</head>

<body class="theme-green">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page">
          <section id="sectionScroll" class="wh-section infinite-scroll wh-section-bottomfixed">
		    <input type="hidden"  name="menuId" value="${menuId}" id="menuId"/>
			<input type="hidden"  name="menuName" value="${menuName}" id="menuName"/>
			<input type="hidden"  name="cust_queryField" value="${cust_queryField}" id="cust_queryField"/>
			<input type="hidden"  name="cust_queryText" value="${cust_queryText}" id="cust_queryText"/>
            <header id="searchBar" class="wh-search">
              <div class="wh-container">
                <div class="wh-search-input" id="serchDiv">
                  <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init searchbar-active">
                    <label class="fa fa-search" for="search"></label>
                    <input id="searchBug" type="search"  placeholder="搜索信息标题" onfocus="searchList()">
                    <a href="#" class="searchbar-cancel">取消</a>
                  </form>
                </div>
              </div>
            </header>
			<section class="" id="searchType">
			  
		    </section>
            <article class="wh-article wh-article-document wh-article-plan">
              <div class="wh-container">
                <div class="wh-article-lists">
                  <ul id="listul">
                   
                  </ul>
				  <aside class="wh-load-box infinite-scroll-top" style="display: block">
		             <div class="wh-load-tap" style="display:none">没有更多数据了</div>
		             <div class="wh-load-md">
		               <span></span>
		               <span></span>
		               <span></span>
		               <span></span>
		               <span></span>
		             </div>
		          </aside>
                </div>
              </div>
            </article>
          </section>
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="wh-footer-btn row" id="but_cmdAdd">
                  <a href="#" class="fbtn-matter col-100 " id="cmdAdd">新增</a>
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
	  $("#searchDiv").hide();
	  $("#but_cmdAdd").hide();
	  loadDataList(1);
  
  });
  var maxItems ="";
  var loading = false;
  //当前页页数 全局变量
  var curPage = 1;

  //获取页面数据
  function loadDataList(curPage){
	  var url = '/defaultroot/custmenu/getCustDataList.controller?curpage='+curPage;
	  var menuId =$("#menuId").val();
      var cust_queryField = document.getElementById("cust_queryField").value;
	  var cust_queryText = document.getElementById("cust_queryText").value;
	  if(cust_queryText != '' &&　curPage == '1'){
	  var htmlcon ='';
	  var arr = cust_queryText.substring(0,cust_queryText.length-1).split('|');
	  for(var a=0;a<arr.length;a++){
		htmlcon+='<span>'+arr[a]+'</span>';
	  }
	 
	  htmlcon+='<p>查询结果如下：</p>';
      $("#searchType").attr("class","wh-plan-head");
	  $("#searchType").append(htmlcon);
	  }
	  $$.ajax({
		  type: "post",
		  url: url,
		  dataType: "text",
		  data : {"menuid" : menuId,"cust_queryField" : cust_queryField,"cust_queryText" : cust_queryText},
		  success: function(data) {
			var obj = eval("("+data+")");
			 if(obj.message.result=="1"){
				 maxItems = obj.data.recordCount;
                 if(obj.data.middlButton.button){
			       var type = obj.data.middlButton.button.type;
			       var formId = obj.data.middlButton.button.formId;
			       if(type=='cmdAdd'){
			       		$('#cmdAdd').click(function(){ 
							go_CmdAdd('0',formId);
						});
			            $('#but_cmdAdd').show();
			       }else if(type=='cmdNewAdd'){
			            var formCode = obj.data.middlButton.button.formCode;
                        $('#cmdAdd').click(function(){ 
							go_newCmdAdd('new',formId,formCode);
					    });
			            $('#but_cmdAdd').show();

			       }else if(type=='cmdStartFlow'){
			         var processId = obj.data.middlButton.button.processId;
			         var processName = obj.data.middlButton.button.processName;
					 $('#cmdAdd').click(function(){ 
						go_CmdFlow(formId,processId,processName);
					 });
			         $('#but_cmdAdd').hide();
			       }else if(type=='cmdNewStartFlow'){
			         var processId = obj.data.middlButton.button.processId;
			         var processName = obj.data.middlButton.button.processName;
					 $('#cmdAdd').click(function(){ 
						go_CmdNewFlow(formId,processId,processName);
					 });
			         $('#but_cmdAdd').show();
			       }
			       
			     }
			     if(obj.data.searchFields&&
			        obj.data.searchFields!=""&&
			        obj.data.searchFields!=" "&&
			        obj.data.searchFields!="[]"&&
			        obj.message.result=="1"&&
			        obj.data.datalist){
                    $("#searchDiv").show();
			     }
				 var htmlContent ="";
				 if(obj.message.result=="1"&&
			        obj.data.datalist != null){
			        var formId = obj.data.viewButton.formId;
			        var pageCount = obj.data.pageCount;
                    var groups = obj.data.datalist;
                    if(groups instanceof Array){
	                    for(var i=0;i<groups.length;i++){
				            var infoId=groups[i][0];
				            var title="";
				            for(var j=1;j<groups[i].length;j++){
				               title +=groups[i][j]+"  ";
				            }
				            title = title.replace(/\&/g,'&amp;');
				            title = title.replace(/\</g,'&lt;');
				            htmlContent +=  '<li onclick="go_viewForm(\''+formId+'\',\''+infoId+'\');">'
										+  '<strong class="document-icon">'+title+'</strong>'
										+  '</li>';
				        }
						$("#listul").append(htmlContent);
                    }else if(groups instanceof Object){
						var infoId=groups.list[0];
						var title="";
						for(var j=1;j<groups.list.length;j++){
						   title +=groups.list[j]+"  ";
						}
						title = title.replace(/\&/g,'&amp;');
						title = title.replace(/\</g,'&lt;');
						htmlContent +=  '<li onclick="go_viewForm(\''+formId+'\',\''+infoId+'\');">'
									+  '<strong class="document-icon">'+title+'</strong>'
									+  '</li>'; 
						$("#listul").append(htmlContent);

                    }
					$$('.wh-load-md').hide();
			     }else{
					htmlContent = '<p>没有更多记录</p>';
					$("#listul").append(htmlContent);
					$$('.wh-load-md').hide();
			     }

			 }			
		  },error: function(xhr, status) {
			alert('数据查询异常！');
		  }
	  });
  
  }

  $$(document).on('infinite', '#sectionScroll', function() {
		   // 如果正在加载，则退出
		    if (loading) return;
		    loading = true;
		    lastIndex = $$('#listul li').length;
		     setTimeout(function() {
			      loading = false;
			      if (lastIndex >= maxItems) {
				        // 加载完毕，则注销无限加载事件，以防不必要的加载
				        myApp.detachInfiniteScroll($$('#sectionScroll'));
				        // 删除加载提示符
				        $$('.wh-load-md').hide();
				        return;
				    }
				    if (maxItems - lastIndex > 0) {
				    	//alert(curPage);
				        curPage = curPage+1;
				        loadDataList(curPage);
				        return;
				    }
		    }, 500);
	 });

	 function go_viewForm(formId,infoId) {
		window.location = "/defaultroot/custmenu/getCusDataView.controller?formId="+formId+"&infoId="+infoId;
	 }

	 function searchList(){
        var menuId =$("#menuId").val();
		window.location = "/defaultroot/custmenu/custDataSearchList.controller?menuId="+menuId;
	 }
     //新增表单
     function go_CmdAdd(formtype,formId){
		var menuId =$("#menuId").val();
		var menuName =$("#menuName").val();
		window.location = "/defaultroot/custmenu/custDataAdd.controller?pageId="+formId+"&cust_formType="+formtype+"&menuId="+menuId+"&menuName="+menuName+"&processId=''";
	 }
    
	//新表单新增
	function go_newCmdAdd(formtype,formId,formCode) {	
	   var menuId =$("#menuId").val();
	   var menuName =$("#menuName").val();
	   window.location = "/defaultroot/custmenu/custDataAdd.controller?pageId="+formId+"&cust_formType="+formtype+"&menuId="+menuId+"&menuName="+menuName+"&cust_formCode="+formCode+"&processId=''";
	}
	 //老流程
	function go_CmdFlow(pageId,processId,processName) {
	   window.location = '/defaultroot/workflow/newezform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName;
	}
	//新流程
	function go_CmdNewFlow(pageId,processId,processName) {
	   window.location = '/defaultroot/workflow/newezform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName;
	}
  </script>
</body>

</html>
