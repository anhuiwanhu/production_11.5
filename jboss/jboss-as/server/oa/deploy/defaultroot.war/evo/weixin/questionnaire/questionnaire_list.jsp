<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1">
  <title>调查问卷</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.min.css" />
</head>
<body class="theme-green">
  <div class="views">
    <div class="view view-content">
      <div class="pages">
        <div class="page">
          <section id="sectionScroll" class="wh-section infinite-scroll">
            <article class="wh-edit wh-edit-forum">
              <div class="wh-container">
                <div class="wh-article-lists">
                  <div class="meeting-notice">
                    <ul>
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
              </div>
            </article>
          </section>
        </div>
      </div>
    </div>
  </div>
</body>
<script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/template.min.js"></script>
 <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/plugin/zepto.js"></script>
<script type="text/javascript">
	var myApp = new Framework7();
	var $$ = Dom7;
	function openNaireDetail(questionnaireId,state) {
		window.location = "/defaultroot/naire/questionnaireAnswer.controller?questionnaireId="+questionnaireId+"&state="+state;
	}
	var curpage = 1;
	var itemsPerLoad = 15;
	$(function () {
		 addItems(curpage,1);
	});
	var dataList; 
	var maxItems = 0;
	var loading = false;
	$$(document).on('infinite', '#sectionScroll', function() {
   		// 如果正在加载，则退出
	    if (loading) return;
	    loading = true;
	    lastIndex = $$('.list-container li').length;
	     setTimeout(function() {
		      loading = false;
		      if (itemsPerLoad >= maxItems) {
			        // 加载完毕，则注销无限加载事件，以防不必要的加载
			        myApp.detachInfiniteScroll($$('#sectionScroll'));
			        // 删除加载提示符
			        $$('.wh-load-md').hide();
			        return;
			    }
			    if (maxItems - itemsPerLoad > 0) {
			    	curpage = curpage+1;
			        addItems(curpage,0);
			        return;
			    }
	    }, 500);
	  });
	
	function addItems(curpage,flag) {
  	  var url = '/defaultroot/naire/getList.controller?curpage='+curpage;
	  $$.ajax({
	      type: "post",
	      url: url,
	      dataType: "text",
	      success: function(data) {
	      	dataList = data;
	      	var jsonData = eval("("+data+")");
	      	var html ='';
	      	var state ='';
	      	maxItems = jsonData.data1;
	      	if(jsonData.data0.length < 15){
	      		$$('.wh-load-md').hide();
			    myApp.detachInfiniteScroll($$('#sectionScroll'));
	      	}else{
	      		$$('.wh-load-md').show();
	      	}
	      	if(jsonData.data0.length>0){
		      	for(var i = 0; i < jsonData.data0.length; i++){
		      		if(jsonData.data0[i].isSubmitAnswered == '0'){
		      			state = '<strong class="forum-avatar m-tag-ny">待参与</strong>';
		      		}else{
		      			state = '<strong class="forum-avatar m-tag-had">已参与</strong>';
		      		}
		      		 html +='<li>'
	                    + state
	                    +'<p>'
	                    + '<a href="javascript:openNaireDetail('+jsonData.data0[i].questionnaireId+','+jsonData.data0[i].isSubmitAnswered+');">'+jsonData.data0[i].title+'等待您的参与！</a>'
	                    +'<span>['+jsonData.data0[i].startDate.substring(0,10)+']</span>'
	                    +'</p>'
	                    +'</li>';
		      	}
		     	if(flag == 1){
		     		$$('.meeting-notice ul').html(html);
		     	}else{
		     		$$('.meeting-notice ul').append(html);
		     	}
	      	}else{
	      		$$('.wh-load-md').hide();
	      		$$('.meeting-notice ul').html('<li>系统没有查询到相关记录！</li>');
	      	}
	      },error: function(xhr, status) {
	      		$$('.meeting-notice ul').html('<li>系统没有查询到相关记录！</li>');
		        $$('.wh-load-tap').hide();
		        $$('.wh-load-md').hide();
	      }
      });
	}
	
</script>
</html>