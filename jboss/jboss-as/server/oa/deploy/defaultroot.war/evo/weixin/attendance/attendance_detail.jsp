<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>${param.presentTime }</title>
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
            <article class="wh-article wh-article-document wh-article-clockinfo ">
              <div class="wh-container">
                <div class="wh-article-lists">
                  <ul>
                  	<x:forEach select="$doc//list/detailList" var="dl" >
                  		<c:set var="picture"><x:out select="$dl/picture/text()"/></c:set>
                  		<c:set var="folderVal">${fn:substring(picture,0,6)}</c:set>
	                    <li>
	                      <span><x:out select="$dl/presentTime/text()"/></span>
	                      <i class="fa fa-map-marker"></i>
	                      <p>
	                        <a href="###"><x:out select="$dl/address/text()"/></a>
	                        <c:if test="${picture !='' }">
	                        <%
				            	String pictures = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("picture"));
				            	String[] arr = pictures.split(",");
				            	for (int i = 0; i < arr.length; i++) {
				             %>	
	                        <img onclick="imgDetail('<%=arr[i] %>','${folderVal }')" src='/defaultroot/upload/phonekq/${folderVal}/<%=arr[i] %>'/>
	                        <%
	                        	}
	                         %>
	                         </c:if>
	                        <strong><x:out select="$dl/remark/text()"/></strong>
	                      </p>
	                    </li>
                    </x:forEach>
                  </ul>
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
                </div>
              </div>
            </article>
          </section>
        </div>
      </div>
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
					        $$('.wh-load-box').hide();
					        $$('.wh-load-md').hide();
					        return;
					    }
					    if (maxItems - lastIndex > 0) {
					    	//alert(curPage);
					        curPage = curPage+1;
					        nextPage(curPage,'1');
					        return;
					    }
			    }, 500);
		  });
		
		function nextPage(curPage,loadFlag) {
	  	  var url = '/defaultroot/attendance/nextMyAttendanceDetail.controller?curpage='+curPage+'&id=${param.id}';
		  $$.ajax({
		      type: "post",
		      url: url,
		      dataType: "text",
		      success: function(data) {
		      	var jsonData = eval("("+data+")");
		      	var html ='';
		      	if(jsonData.data0.length<15){
		      		 myApp.detachInfiniteScroll($$('#sectionScroll'));
		      		 // 删除加载提示符
			         $$('.wh-load-box').hide();
			         $$('.wh-load-md').hide();
		      	}
		      	if(jsonData.data0.length>0){
			      	for(var i = 0; i < jsonData.data0.length; i++){
			      		var pictures = jsonData.data0[i].picture;
			      		var arr = pictures.split(",");
			      		var folderVal = pictures.substring(0,6);
		            	html += '<li>'
		            	+'<span>'+jsonData.data0[i].presentTime+'</span>'
		            	+'<i class="fa fa-map-marker"></i>'
		            	+'<p>'
		            	+'<a href="###">'+jsonData.data0[i].address+'</a>';
		            	for (var j = 0; j < arr.length; j++) {
		            		html +='<img onclick="imgDetail('+arr[i]+','+folderVal+')" src="/defaultroot/upload/phonekq/'+folderVal+'/'+arr[i]+'"/>';
		            	}
		            	html +='<strong>'+jsonData.data0[i].remark+'</strong>'
		            	+'</p>'
		            	+'</li>';
			      	}
			      	if(loadFlag == '1'){
	                 	$('.wh-article-lists ul').append(html);
	                }else{
		                $('.wh-article-lists ul').html(html);
	                }
		      	}
		      },error: function(xhr, status) {
		        $$('.wh-article-lists ul').append('<li>没有更多记录</li>');
		        $$('.wh-load-tap').hide();
		        $$('.wh-load-md').hide();
		      }
	      });
		}
	  
	  function imgDetail(fileName,path) {
		  window.location = '${oaIp}/defaultroot/upload/phonekq/'+path+'/'+fileName;
	  }
  </script>
  </body>
