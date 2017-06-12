<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/weixin/common/taglibs.jsp"%>

<!DOCTYPE html>
<html>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1">
  <title>下属日志</title>
  <link rel="stylesheet" href="/defaultroot/framework/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/framework/template/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/framework/template/css/template.style.colors.min.css" />
</head>

<body class="theme-green">
  <div class="views">
    <div class="view view-content">
      <div class="pages">
        <div class="page">
          <section id="sectionScroll" class="wh-section wh-section-bottomfixed infinite-scroll">
            <header class="wh-search">
              <div class="wh-container">
                <form method="get">
                  <input type="search" placeholder="请输入员工姓名">
                  <i class="fa fa-search"></i>
                </form>
              </div>
            </header>
            <article class="wh-article wh-article-info wh-log-prolist">
              <div class="wh-container">
                <div class="wh-article-lists">
                  <ul class="list-container">
                    <li class="current">
                      <small>未读</small>
                      <span class="color-grey">【下属性名】</span>
                      <span>【填写日期】</span>
                      <span>【时间段】</span>
                      <span>【项目名称】</span>
                    </li>
                    <li>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>08:00-12:00</span>
                      <span>紫金矿业集团项目</span>
                    </li>
                    <li>
                      <small>未读</small>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>全天日志</span>
                    </li>
                    <li>
                      <small>未读</small>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>08:00-12:00</span>
                      <span>紫金矿业集团项目</span>
                    </li>
                    <li>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>08:00-12:00</span>
                      <span>紫金矿业集团项目</span>
                    </li>
                    <li>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>08:00-12:00</span>
                      <span>紫金矿业集团项目</span>
                    </li>
                    <li>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>08:00-12:00</span>
                      <span>紫金矿业集团项目</span>
                    </li>
                    <li>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>08:00-12:00</span>
                      <span>紫金矿业集团项目</span>
                    </li>
                    <li>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>08:00-12:00</span>
                      <span>紫金矿业集团项目</span>
                    </li>
                    <li>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>08:00-12:00</span>
                      <span>紫金矿业集团项目</span>
                    </li>
                    <li>
                      <span class="color-grey">李小琳</span>
                      <span>2016-04-11</span>
                      <span>08:00-12:00</span>
                      <span>紫金矿业集团项目</span>
                    </li>
                  </ul>
                  <!-- 下拉刷新动画 -->
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
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="/defaultroot/framework/template/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/framework/template/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="/defaultroot/framework/template/js/jquery-1.8.2.min.js"></script>
  <script type="text/javascript">
	  var myApp = new Framework7();
	  var $$ = Dom7;
	  
	  //滚动条至底部事触发事件
    $$(window).scroll(function(){
       var scrollTop = $(this).scrollTop();
       var scrollHeight = $(document).height();
       var windowHeight = $(this).height();
       if(scrollTop + windowHeight == scrollHeight){
      	 alert('111');
       }
    });
	  
	 /* var loading = false;
	  // 最多可加载的条目
	  var maxItems = 0;
	  // 每次加载添加多少条目
	  var itemsPerLoad = 10;
	  
	   $$(document).on('infinite', '#sectionScroll', function() {
	   		
	   		// 如果正在加载，则退出
		    if (loading) return;
		    loading = true;
		
		    lastIndex = $$('.list-container li').length;
		    alert(lastIndex);
	  });*/
  </script>
</body> 

</html>
