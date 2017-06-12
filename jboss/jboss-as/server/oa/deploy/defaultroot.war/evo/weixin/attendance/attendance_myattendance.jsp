<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>

<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>我的考勤</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.min.css" />
</head>

<body class="theme-green">
<c:if test="${not empty docXml}">
<x:parse xml="${docXml}" var="doc"/>
  <div class="views">
    <div class="view"> 
      <div class="pages">
        <div class="page">
          <section id="sectionScroll" class="wh-section infinite-scroll">
            <article class="wh-article wh-article-document wh-article-clock">
              <div class="wh-container">
                <div class="wh-article-lists">
                  <ul>
                  	<x:forEach select="$doc//list/attendanceList" var="alt" >
                  		<c:set var="id"><x:out select="$alt/id/text()"/></c:set>
	                    <c:set var="presentTime"><x:out select="$alt/presentTime/text()"/></c:set>
	                    <li class="swipeout" onclick="openDetail('${id}','${presentTime }');">
	                      <strong class="document-icon">
	                      	<c:if test="${photo eq '' || photo eq null}"><img src="/defaultroot/evo/weixin/images/head.png"></c:if>
               				<c:if test="${photo != ''}"><img src="/defaultroot/upload/peopleinfo/${photo}"></c:if>
	                      </strong>
	                      <p><a href=""><x:out select="$alt/presentTime/text()"/></a></p>
	                      <span>打卡<i><x:out select="$alt/record/text()"/></i>次</span> 
	                    </li>
                    </x:forEach>
                  </ul>
                </div>
              </div>
            </article>
            <!-- 下拉刷新动画 -->
           <aside class="wh-load-box infinite-scroll-top" style="display: none">
             <div class="wh-load-tap" style="display:none">没有更多数据了</div>
             <div class="wh-load-md">
               <span></span>
               <span></span>
               <span></span>
               <span></span>
               <span></span>
             </div>
           </aside>
          </section>
        </div>
      </div>
    </div>
  </div>
  </c:if> 
  <script src="/defaultroot/evo/weixin/frameworktemplate/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/plugin/zepto.js"></script>
  <script type="text/javascript">

    var $$ = Dom7;

    //初始化应用
    var myapp = new Framework7();

    //初始化view
    var mainView = myapp.addView('.view',{
      dynamicNavbar: true, 
      swipeBackPageThreshold: 3,
      swipeBackPage: true,
      pushState: true, 
    }); 

	$(function(){
    	var trLength = $$('.wh-article-lists li').length;
    	if(trLength == 0){
    		$$('.wh-article-lists ul').html('系统没有查询到相关记录');
    	}
     });

    $$(document).on('navbarInit', function (e) {
      var navbar = e.detail.navbar;
      var page = e.detail.page;
      console.log(page.name);

    }); 

    //swipe
    $$(".swipeout").on('open',function(){
        myApp.alert('Item removed'); 
    })
	
	//列表总记录
    var maxItems = '${recordCount}';
    if(maxItems>15){
    	 $$('.wh-load-box').show();
    }
	// 每次加载添加多少条目
	var itemsPerLoad = 15;
    //当前页页数 全局变量
    var curPage = 1;
    var loading = false;
	
	$$(document).on('infinite', '#sectionScroll', function() {
		   // 如果正在加载，则退出
		    if (loading) return;
		    loading = true;
		    lastIndex = $$('.wh-article-lists li').length;
		     setTimeout(function() {
			      loading = false;
			      if (lastIndex >= maxItems) {
				        // 加载完毕，则注销无限加载事件，以防不必要的加载
				        myApp.detachInfiniteScroll($$('#sectionScroll'));
				        // 删除加载提示符
				        $$('.wh-load-md').hide();
				        $$('.wh-load-box').hide();
				        return;
				    }
				    if (maxItems - lastIndex > 0) {
				    	//alert(curPage);
				    	 $$('.wh-load-box').hide();
				    	 $$('.wh-load-md').hide();
				        curPage = curPage+1;
				        nextPage(curPage);
				        return;
				    }
		    }, 500);
	  });
	
	function nextPage(curPage) {
  	  var url = '/defaultroot/attendance/nextMyAttendance.controller?curpage='+curPage;
	  $$.ajax({
	      type: "post",
	      url: url,
	      dataType: "text",
	      success: function(data) {
	      	var jsonData = eval("("+data+")");
	      	var html ='';
	      	if(jsonData.data0.length>0){
		      	for(var i = 0; i < jsonData.data0.length; i++){
	            	html += '<li class="swipeout">'
	            	+'<strong class="document-icon"><img src="/defaultroot/upload/peopleinfo/${photo }"></strong>'
	            	+'<p>'
	            	+'<a href="javascript:openDetail('+jsonData.data0[i].id+');">'+jsonData.data0[i].presentTime+'</a>'
	            	+'</p>'
	            	+'<span>打卡<i>'+jsonData.data0[i].record+'</i>次</span>'
	            	+'</li>';
		      	}
                $('.wh-article-lists ul').append(html);
	      	}
	      },error: function(xhr, status) {
	        $$('.wh-article-lists ul').append('<li>没有更多记录</li>');
	        $$('.wh-load-tap').hide();
	        $$('.wh-load-md').hide();
	      }
      });
	}
	function openDetail(id,presentTime) {
		//alert(id);
		window.location = "/defaultroot/attendance/myAttendanceDetail.controller?id="+id+"&presentTime="+presentTime;
	}
  </script>
</body>

</html>