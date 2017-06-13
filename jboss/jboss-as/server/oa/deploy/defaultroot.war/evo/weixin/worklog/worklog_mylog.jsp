<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>

<!DOCTYPE html>
<html> 
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1">
  <title>我的日志</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.css" />
</head>

<body class="theme-green">
  <c:if test="${not empty docXml}">
  <x:parse xml="${docXml}" var="doc"/>
  <c:if test="${not empty dateDocXml}">
  	<x:parse xml="${dateDocXml}" var="dateDoc"/>
  	<c:set var="dateAttend">
	 <x:forEach select="$dateDoc//list" var="dt" ><x:out select="$dt/date/text()"/>,</x:forEach>
    </c:set>
   <input type="hidden" id="dtAttend" value="${dateAttend}"/>
  </c:if>
  <div class="views">
    <div class="view view-content">
      <div class="pages">
        <div class="page">
          <section id="sectionScroll" class="wh-section infinite-scroll wh-section-bottomfixed">
            <article class="wh-edit wh-edit-forum">
              <div>
                <div class="meeting-room-apply">
                  <div class="calendar hidden-print">
                    <header>
                      <h2 class="month"></h2> 
                      <i class="btn-prev fa fa-angle-left"></i>
                      <i class="btn-next fa fa-angle-right"></i>
                    </header>
                    <table>
                      <thead class="event-days">
                        <tr></tr>
                      </thead>
                      <tbody class="event-calendar">
                        <tr class="one"></tr>
                        <tr class="two"></tr>
                        <tr class="three"></tr>
                        <tr class="four"></tr>
                        <tr class="five "></tr>
                      </tbody>
                    </table>
                    <div class="list">
                      <div class="day-event" date-day="2" date-month="2" date-year="2016" data-number="1"></div>
                    </div>
                  </div>
                  <table class="wh-table-edit">
                  	<x:forEach select="$doc//list" var="lt" >
		          		<c:set var="id"><x:out select="$lt/id/text()"/></c:set>
		          		<c:set var="logDate"><x:out select="$lt/date/text()"/></c:set>
		          		<c:set var="logType"><x:out select="$lt/type/text()"/></c:set>
		          		<c:set var="sTime"><x:out select="$lt/sTime/text()"/></c:set>
		          		<c:set var="eTime"><x:out select="$lt/eTime/text()"/></c:set>
		          		<c:set var="logProName"><x:out select="$lt/logProName/text()"/></c:set>
	                    <tr>
	                      <td onclick="openWorkLog('${id}')">
	                        <p>
			                  <span>${logDate }</span>
			                  <c:choose>
			                  	<c:when test="${logType == '0' }">
			                  		<span>全天日志</span>
			                  	</c:when>
			                  	<c:otherwise>
			                  		<span>${sTime }-${eTime }</span>
			                  	</c:otherwise>
			                  </c:choose>
			                  <span>${logProName }</span>
			                </p>
	                      </td>
	                    </tr>
                    </x:forEach>
                    </tbody>
                  </table>
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
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="wh-footer-btn row">
                  <a href="javascript:newLog();" class="fbtn-matter col-100">写日志</a>
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
  </c:if> 
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/plugin/simplecalendar.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/template.min.js"></script>
  <script type="text/javascript"> 
    calendar.init('', '/defaultroot/evo/weixin/json/events.json');
    var myApp = new Framework7();
	var $$ = Dom7;
	//列表总记录
    var maxItems = '${recordCount}';
	// 每次加载添加多少条目
	var itemsPerLoad = 15;
    //当前页页数 全局变量
    var curPage = 1;
    var queryDate = '';
    var loading = false;
    window.onload=myfun;
    function myfun() {
    	var index = $$('.wh-table-edit tr').length;
    	if(index < 15){
    		 $$('.wh-load-md').hide();
    	}else{
    		 $$('.wh-load-md').show();
    	}
    	if(index == 0){
    		$$('.wh-table-edit').html('<tr><td>系统没有查询到相关记录</td></tr>');
    	}
    	var ids = $("#dtAttend").val();
		if(ids != "" && ids != undefined){
			ids = ids.substring(0,ids.length-1);
			var idArr = ids.split(",");
			for(var i=0;i<idArr.length;i++){
				$("#"+setLogDate(idArr[i])).addClass("event null");
			}
		}
	}
     
    //以填写日志的时间为灰色
    function grayDate(){
    	//已经预定的日期置灰
        var ids = $("#dtAttend").val();
		if(ids != "" && ids != undefined){
			ids = ids.substring(0,ids.length-1);
			var idArr = ids.split(",");
			for(var i=0;i<idArr.length;i++){
				$("#"+setLogDate(idArr[i])).addClass("event null");
			}
		}
	}
	
	//格式化时间
	function setLogDate(logDate) {
		var y = logDate.substring(0,4);
		var m = logDate.substring(5,7);
		var d = logDate.substring(8,10);
		if(m.substring(0,1)=='0'){
			m=m.replace("0","");
		}
		if(d.substring(0,1)=='0'){
			d=d.replace("0","");
		}
		var logDate = y+m+d;
		return logDate;
	}
	
    $$(document).on('infinite', '#sectionScroll', function() {
		    // 如果正在加载，则退出
		    if (loading) return;
		    loading = true;
		    lastIndex = $$('.wh-table-edit tr').length;
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
				        nextPage(curPage,'1',queryDate);
				        return;
				    }
		    }, 500);
	  });
	  
	  function nextPage(curPage,loadFlag,queryDate) {
	  	  var url = '/defaultroot/worklog/nextLogList.controller?curpage='+curPage+'&queryDate='+queryDate;
		  $$.ajax({
		      type: "post",
		      url: url,
		      dataType: "text",
		      success: function(data) {
		      	var jsonData = eval("("+data+")");
		      	var html ='';
		      	var hadread = '';
		      	var logType = '';
		      	var type = '';
		      	if(jsonData.data0.length < 15){
		      		$$('.wh-load-md').hide();
		      		// 加载完毕，则注销无限加载事件，以防不必要的加载
				     myApp.detachInfiniteScroll($$('#sectionScroll'));
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
	                    html +='<tr>'
	                    +'<td onclick="openWorkLog('+jsonData.data0[i].id+');">'
	                    +'<p>'
	                    +'<span>'+jsonData.data0[i].date+'</span>&nbsp;'
	                    + type+'&nbsp;'
	                    +'<span>'+jsonData.data0[i].logProName+'</span>'
	                    +'</p>'
	                    +'</td>'
	                    +'</tr>';
			      	}
			      	if(loadFlag == '1'){
	                 	$('.wh-table-edit tbody').append(html);
	                }else{
		                $('.wh-table-edit tbody').html(html);
	                }
		      	}else{
		      		$$('.wh-load-md').hide();
		      		$$('.wh-table-edit tbody').append('<tr><td><p>系统没有查询到相关记录</p></td></tr>');
		      	}
		      },error: function(xhr, status) {
		        $$('.wh-table-edit').append('<tr><td><p>没有更多记录</p></td></tr>');
		        $$('.wh-load-tap').hide();
		        $$('.wh-load-md').hide();
		      }
	      });
		}
		
	function selectdate(obj) {
		$$('.wh-load-md').show();
		var year = $(obj).attr("date-year");
		var month = $(obj).attr("date-month");
		var day = $(obj).attr("date-day");
		if(month<10){
			month='0'+month;
		}
		if(day<10){
			day='0'+day;
		}
		queryDate = year+'-'+month+'-'+day;
		$$('.wh-table-edit tbody').html('');
		curPage = 1;
		nextPage(curPage,'0',queryDate);
	}
    
    //打开日志详情
    function openWorkLog(id) {
		window.location = "/defaultroot/worklog/loadWorkLog.controller?workLogId="+id+"&logFlag=0";
	}
	
	//新建日志
    function newLog() {
		//window.location = "/defaultroot/worklog/writeLog.controller?loadFlag=1";
		window.location = "/defaultroot/worklog/writeLog.controller?loadFlag=1";
	}
  </script>
</body>

</html>

