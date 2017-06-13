<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>

<!DOCTYPE html>
<html>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1">
  <title>下属日志</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.min.css" />
</head>

<body class="theme-green noback">
	<c:if test="${not empty docXml}">
  	 <x:parse xml="${docXml}" var="doc"/>
  	 <x:forEach select="$doc//list" var="lt" >
     	<c:set var="empId"><x:out select="$lt/empId/text()"/></c:set>
     	<input type="hidden" name="empId" id="empId" value="${empId }"/>
	 </x:forEach>
  <div class="views">
    <div class="view view-content">
      <div class="pages">
        <div class="page">
          <section id="sectionScroll" class="wh-section wh-section-bottomfixed infinite-scroll">
            <header >
              <div class="list-block">
                <ul>
                  <li>
                    <a href="#" data-open-in="popup" class="item-link smart-select" data-back-on-select="true" data-popup-close-text="返回">
                      <select name="fruits" onchange="sel(this);">
                        <option value="apple" selected>请选择</option>
                        <x:forEach select="$doc//list" var="lt" >
					     	<option value="<x:out select="$lt/empId/text()"/>"><x:out select="$lt/empName/text()"/></option>
						 </x:forEach>
                      </select>
                      <div class="item-content">
                        <div class="item-inner">
                          <div class="item-title">下属员工</div>
                        </div>
                      </div>
                    </a>
                  </li>
                </ul>
              </div>
            </header>
            <article class="wh-article wh-article-info wh-log-prolist">
              <div class="wh-container">
                <div class="wh-article-lists">
                  <ul class="list-container">
                  </ul>
                  <!-- 下拉刷新动画 -->
		           <aside class="wh-load-box infinite-scroll-top" style="display: block">
		             <div class="wh-load-tap" style="display:none">上滑加载更多</div>
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
        </div>
      </div>
    </div>
  </div>
  </c:if>
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/plugin/zepto.js"></script>
  <script type="text/javascript">
	  var myApp = new Framework7();
	  var $$ = Dom7;
	  
	  var loading = false;
      //当前页页数 全局变量
      var curPage = 1;
	  //var url = "/defaultroot/worklog/getUnderlingWorkLogList.controller";
	  // 最多可加载的条目
	  var maxItems = 0;
	  // 每次加载添加多少条目
	  var itemsPerLoad = 15;
	  var empIds = '';
	   $(function () {
	   		var arr = $$("input[name=empId]");
		 	//var empIds = '';
		 	if(arr.length>0){
		 		for(var i=0;i<arr.length;i++){
			 		empIds += '$'+arr[i].value+'$';
		 		}
		 		//url = url+"?queryEmpIds="+empIds;
		 		addItems(empIds,curPage,'0');
		 	}else{
		 		$$('.wh-load-md').hide();
		 		$$('.list-container').html('<p class="warning-no-data">系统没有查询到相关记录！</p>');
		 	}
       });
	   $$(document).on('infinite', '#sectionScroll', function() {
	   		// 如果正在加载，则退出
		    if (loading) return;
		    loading = true;
		    lastIndex = $$('.list-container li').length;
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
				        curPage = curPage+1;
				        addItems(empIds,curPage,'1');
				        return;
				    }
		    }, 500);
	  });
	  
	  function addItems(empId,curPage,loadFlag) {
		  	if(loadFlag == '0'){
		  		myApp.showPreloader('列表加载中...');
		  	}
	  	  var url = '/defaultroot/worklog/getUnderlingWorkLogList.controller?queryEmpIds='+empId+'&curpage='+curPage;
		  $$.ajax({
		      type: "post",
		      url: url,
		      dataType: "text",
		      success: function(data) {
		      	var jsonData = eval("("+data+")");
		      	var html ='';
		      	var hadread = '';
		      	var readFlag = '';
		      	var logType = '';
		      	var type = '';
		      	maxItems = jsonData.data1;
		      	if(maxItems<15){
		      		$$('.wh-load-md').hide();
		      	}//如果查询总记录数大于15，则加载无线滚动事件
		    	if(maxItems > 15){
		    		$$('.wh-load-md').show();
		    		myApp.attachInfiniteScroll($$('#sectionScroll'));
		    	}
		      	if(jsonData.data0.length>0){
			      	for(var i = 0; i < jsonData.data0.length; i++){
			      		hadread = jsonData.data0[i].hadread;
			      		logType = jsonData.data0[i].type;
			      		if(hadread == '0'){
			      			readFlag = '<small>未读</small>';
			      		}else{
			      			readFlag = '';
			      		}
			      		if(logType == '0'){
			      			type = '<span>全天日志</span>';
			      		}else{
			      			type = '<span>'+jsonData.data0[i].sTime+'-'+jsonData.data0[i].eTime+'</span>';
			      		}
	                    html +='<li onclick="openWorkLog('+jsonData.data0[i].id+');">'
	                    + readFlag
	                    +'<span class="color-grey">'+jsonData.data0[i].empName+'</span>'
	                    +'<span>'+jsonData.data0[i].date+'</span>'
	                    + type
	                    +'<span>'+jsonData.data0[i].logProName+'</span>'
	                    +'</li>';
			      	}
			      	myApp.hidePreloader();
			      	if(loadFlag == '1'){
	                 	$$('.list-container').append(html);
	                }else{
		                $$('.list-container').html(html);
	                }
		      	}else{
		      		myApp.hidePreloader();
		      		$$('.list-container').html('<p class="warning-no-data">系统没有查询到相关记录！</p>');
		      	}
		      },error: function(xhr, status) {
		      	myApp.hidePreloader();
		        $$('.list-container').html('<p class="warning-no-data">系统没有查询到相关记录！</p>');
		        $$('.wh-load-tap').hide();
		        $$('.wh-load-md').hide();
		      }
	      });
		}
	
	//打开日志详情
    function openWorkLog(id) {
		window.location = "/defaultroot/worklog/loadWorkLog.controller?workLogId="+id+"&logFlag=1";
	}
	
	function sel(obj) {
		if($(obj).val() == 'apple'){
			var arr = $$("input[name=empId]");
			var selEmpId = '';
		 	if(arr.length>0){
		 		for(var i=0;i<arr.length;i++){
			 		selEmpId += '$'+arr[i].value+'$';
		 		}
		 	}
		 	empIds = selEmpId;
		}else{
			empIds = "$"+$(obj).val()+"$";
		}
    	addItems(empIds,1,'0');
	}
  </script>
</body> 

</html>
