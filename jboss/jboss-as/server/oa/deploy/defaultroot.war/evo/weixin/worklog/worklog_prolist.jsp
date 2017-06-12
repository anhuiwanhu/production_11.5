<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<header id="searchBar" class="wh-search">
	<div class="wh-container">
		<div class="wh-search-input">
			<form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init searchbar-active">
				<label class="fa fa-search" for="search"></label>
				<input id="searchBug" type="search" placeholder="搜索项目标题" class="" name="qText">
				<a href="#" class="searchbar-cancel" >取消</a>
			</form>
		</div>
	</div>
</header>
<article class="wh-article wh-article-info wh-log-prolist">
	<div class="wh-container">
		<div class="wh-article-lists">
			<c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc" />
				<ul id="proListUl">
					<x:forEach select="$doc//list" var="lt">
						<li onclick="addClassLi(<x:out select="$lt/id/text()"/>)" id="proLi_<x:out select="$lt/id/text()"/>">
							<strong class="forum-avatar"><i class="fa fa-check-circle"></i></strong>
							<div>
								<a href="#">项目编号</a>
								<input type="hidden" name="id" value="<x:out select="$lt/id/text()"/>" /> 
								<span><x:out select="$lt/code/text()" /></span>
								<p><x:out select="$lt/name/text()" /></p>
							</div>
						</li>
					</x:forEach>
				</ul>
			</c:if>
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
<script src="/defaultroot/evo/weixin/frameworktemplate/js/plugin/zepto.js"></script>
<script type="text/javascript">
	var myApp = new Framework7();
	var $$ = Dom7;

	// 清除搜索区域焦点bug

	function removeSearch(schElmID) {
		$$(schElmID).blur().val(""); //主动清除焦点
		$$(schElmID).next('.searchbar-cancel').hide();
	}

	// 搜索焦点时
	$$('#fbtn-save').on('click', function() {
		$$(this).next('.searchbar-cancel').show();
	})

	var selProId = '';
	var selProName = '';
	var selProCode = '';
	
	function addClassLi(id) {
		$('#proLi_'+id).addClass("current").siblings().removeClass("current");
		selProId = id;
		selProName = $$(".wh-article-lists .current p").html();
		selProCode = $$(".wh-article-lists .current span").html();
	}

	//列表总记录
	var maxItems = '${recordCount}';
	// 每次加载添加多少条目
	var itemsPerLoad = 15;
	//当前页页数 全局变量
	var curPage = 1;
	var loading = false;
	var qText = '';
	$$(document).on('infinite', '#sectionScroll1', function() {
		// 如果正在加载，则退出
		if (loading)
			return;
		loading = true;
		lastIndex = $$('#proListUl li').length;
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
				curPage = curPage + 1;
				nextPage(curPage);
				return;
			}
		}, 500);
	});

	function nextPage(curPage) {
		var url = '/defaultroot/worklog/nextProList.controller?curpage='+ curPage;
		$$.ajax({
				type : "post",
				url : url,
				dataType : "text",
				success : function(data) {
					var jsonData = eval("(" + data + ")");
					if(jsonData.data0.length < 15){
						myApp.detachInfiniteScroll($$('#sectionScroll'));
						// 删除加载提示符
						$$('.wh-load-md').hide();
					}
					var html = '';
					for ( var i = 0; i < jsonData.data0.length; i++) {
						html += '<li onclick="addClassLi('+jsonData.data0[i].id+')" id="proLi_'+jsonData.data0[i].id+'">'
						+ '<strong class="forum-avatar">'
						+ '<i class="fa fa-check-circle"></i>'
						+ '</strong>'
						+ '<div>'
						+ '<a href="#">项目编号</a>'
						+ '<input type="hidden" name="id" value="'+jsonData.data0[i].id+'" />'
						+ '<span>' + jsonData.data0[i].code
						+ '</span>' + '<p>'
						+ jsonData.data0[i].name + '</p>'
						+'</div>' 
						+ '</li>';
					}
					$$('.wh-article-lists ul').append(html);
				},
				error : function(xhr, status) {
					$$('.wh-article-lists').append('<tr><td><p>没有更多记录</p></td></tr>');
					$$('.wh-load-tap').hide();
					$$('.wh-load-md').hide();
				}
		});
	}

	function yesSel() {
		$$('#projectId').val(selProId);
		$$('#projectCode').val(selProCode);
		$$('#projectName').val(selProName);
		$$('#protd').html(selProName);
		hiddenContent(1);
	}
	
	//绑定查询框回车事件
    $('#searchBug').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if(/[@#\$%\^&\*]+/g.test($('#searchBug').val())){
				myApp.alert('请正确填写搜索项目名称！');
				return false;
			}
			qText = $('#searchBug').val();
			//if(qText!=''){
				selProList(1,qText);
			//}
		} 
	});
	
	function selProList(curPage,qText) {
		$$('.wh-article-lists ul').html('');
		$$('.wh-load-md').show();
		var url = '/defaultroot/worklog/selProList.controller?curpage='+ curPage +'&qText='+ qText;
		$$.ajax({
				type : "post",
				url : url,
				dataType : "text",
				success : function(data) {
					var jsonData = eval("(" + data + ")");
					maxItems = jsonData.data1;
					if(maxItems < 15){
						myApp.detachInfiniteScroll($$('#sectionScroll'));
						// 删除加载提示符
						$$('.wh-load-md').hide();
					}
					var selhtml = '';
					for ( var i = 0; i < jsonData.data0.length; i++) {
						selhtml += '<li onclick="addClassLi('+jsonData.data0[i].id+')" id="proLi_'+jsonData.data0[i].id+'">'
						+ '<strong class="forum-avatar">'
						+ '<i class="fa fa-check-circle"></i>'
						+ '</strong>'
						+ '<div>'
						+ '<a href="#">项目编号</a>'
						+ '<input type="hidden" name="id" value="'+jsonData.data0[i].id+'" />'
						+ '<span>' + jsonData.data0[i].code
						+ '</span>' + '<p>'
						+ jsonData.data0[i].name + '</p>'
						+'</div>' 
						+ '</li>';
					}
					if(selhtml !=''){
						$$('.wh-article-lists ul').html(selhtml);
					}else{
						$$('.wh-article-lists ul').html('<li>没有查询到记录</p></li>');
						$$('.wh-load-tap').hide();
						$$('.wh-load-md').hide();
					}
				},
				error : function(xhr, status) {
					$$('.wh-article-lists ul').html('<li>没有查询到记录</p></li>');
					$$('.wh-load-tap').hide();
					$$('.wh-load-md').hide();
				}
		});
	}
</script>
