<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="../common/taglibs.jsp" %>
<c:if test="${not empty docXml3}">
	<x:parse xml="${docXml3}" var="doc3"/>  
	<c:set var="notFlow" ><x:out select="$doc3//notFlow/text()"/></c:set>
</c:if>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>查看帖子</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.swiper.css" />
</head>
<body>

<section class="wh-section wh-section-bottomfixed">
    <article class="wh-article wh-article-forum">
        <div class="wh-container" id="content" data-loadflag="0">
            <h1>${topicForumTitle}</h1>
            <hr />
            <c:choose>
				<c:when test="${not empty docXml}">
	           	 	<x:parse xml="${docXml}" var="doc"/>
					<x:forEach select="$doc//list" var="n"  varStatus="status">
						<c:set var="forumType" ><x:out select="$n/forumType/text()"/></c:set>
						<c:set var="id" ><x:out select="$n/id/text()"/></c:set>
						<c:set var="anonymous" ><x:out select="$n/anonymous/text()"/></c:set>
						<c:set var="curName">匿名</c:set>
						<c:if test="${anonymous == '0'}">
							<c:set var="curName" ><x:out select="$n/empName/text()"/></c:set>
						</c:if>       
						<c:if test="${anonymous == '2'}">
							<c:set var="curName" ><x:out select="$n/nickName/text()"/></c:set> 
						</c:if>
						<c:set var="authorPhoto"><c:out value="${authorPhotoArr[status.index]}"/></c:set>
						<%  String pic=(String)pageContext.getAttribute("authorPhoto");
							String photoPath = "";
							if(null != pic && !pic.equals("") && !"null".equals(pic)){
								photoPath = "/defaultroot/upload/peopleinfo/"+pic;
							}else{
								photoPath = "/defaultroot/evo/weixin/images/head.png";
							}
							if("1".equals((String)pageContext.getAttribute("anonymous"))) {
								photoPath = "/defaultroot/evo/weixin/images/head.png";
							} %>
						<c:set var="floor" >${(status.index+1)+(offset-1)*15}</c:set>
						<c:set var="floorName" >${floor}楼</c:set>
						<c:if test="${floor == 1}">
							<c:set var="floorName" >楼主</c:set>
						</c:if>
						<c:set var="time" ><x:out select="$n/forumIssueTime/text()"/></c:set>
						<c:if test="${fn:indexOf(time,'.') > 0}">
							<c:set var="time">${fn:substringBefore(time,".")}</c:set>
						</c:if> 
						<c:set var="forumAuthorOrg" ><x:out select="$n/forumAuthorOrg/text()"/></c:set>
						<c:if test="${anonymous == '1'}">
							<c:set var="forumAuthorOrg" ></c:set>
						</c:if>       
						<c:set var="content" ><x:out select="$n/forumContent/text()"/></c:set>
						<%
							String aContent = (String) pageContext.getAttribute("content");
							aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
							aContent = com.whir.component.util.StringUtils.resizeImgSize(aContent, "200", "");
							aContent = aContent.replaceAll("amp;","");
						%>     
						<c:set var="newContent" value="<%=aContent%>" />
						<!-- 区分楼主与其他用户的区别 -->
						<c:choose>
							<c:when test="${floor == 1}">
					            <div class="wh-article-floor wh-floor-lord">
							</c:when>
							<c:otherwise>
					            <div class="wh-article-floor wh-floor-reply">
							</c:otherwise>
						</c:choose>
			                <div class="wh-article-desc">
			                    <strong class="forum-avatar"><img src="<%=photoPath%>" onerror="this.src='/defaultroot/evo/weixin/images/head.png'" /></strong>
			                    <div class="desc-info">
			                        <p>
			                            <strong class="desc-author">${curName}</strong>
			                            <%
			                            String forumAuthorOrg = (String)pageContext.getAttribute("forumAuthorOrg");
			                            String authorOrg = "";
			                            if(!"".equals(forumAuthorOrg) && forumAuthorOrg != null){
				                            authorOrg = forumAuthorOrg.substring(forumAuthorOrg.lastIndexOf(".")+1, forumAuthorOrg.length());
			                            }
			                            %>
			                            <span class="desc-post">
			                            	<%=authorOrg%>
			                            </span>
			                        </p>
			                        <p>
			                            <span class="desc-date">${fn:substring(time,0,16)}</span>
			                            <span class="desc-part">${floorName}</span>
			                        </p>
			                    </div>
			                    <c:if test="${floor != 1 && notFlow != '1' && forumType != '2'}">
			                   		<a class="desc-quote" href="javascript:toReply('toReplyForm_${id}');">引用</a>
			                    </c:if>
	 		                </div>
			                <div class="wh-article-fulltext">
			                    <p>${newContent}</p>
			                </div>
			                <x:if select="$n/forumAttachName">
								<c:set var="names" ><x:out select="$n/forumAttachName/text()"/></c:set>
								<c:set var="savenames" ><x:out select="$n/forumAttachSave/text()"/></c:set>
								<c:if test="${not empty names }">
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="${names}" />
										<jsp:param name="saveFileNames" value="${savenames}" />
										<jsp:param name="moduleName" value="forum" />
									</jsp:include>
								</c:if>
							</x:if>
			            </div>
			            <c:if test="${floor == 1}">
			            	<hr />
			            </c:if>
						<form action="/defaultroot/post/reply.controller" id="toReplyForm_${id}" method="get">
							<input type="hidden" value="${postId}" name="postId"/>
							<input type="hidden" value="${content}" name="content"/>
							<input type="hidden" value="${floor}" name="forumFloor"/>
							<input type="hidden" value="${curName}" name="forumUserName"/>
							<input type="hidden" value="${time}" name="forumIssueTime"/>
							<input type="hidden" value="${id}" name="forumId"/>
						</form>
					</x:forEach>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
        </div>
    </article>
    <!-- <div class="wh-article-pagenav">
        <a href="javascript:void(0);" class="prev">上一篇</a>
        <a href="javascript:void(0);" class="next">下一篇</a>
    </div> -->
    <aside class="wh-load-box" style="display: none">
        <div class="wh-load-tap">上滑加载更多</div>
        <div class="wh-load-md" style="display: none">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
        </div>
    </aside>
</section>
<footer class="wh-footer wh-footer-text">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <c:choose>
                	<c:when test="${notFlow != '1' && topicForumType != '2'}">
		                <a href="/defaultroot/post/list.controller?classId=${param.curClassId}&className=${forumClassName}" class="fbtn-link col-xs-6"><i class="fa fa-list"></i>${forumClassName}</a>
		                <a href="javascript:goReply('${postId}','1');" class="fbtn-matter col-xs-6"><i class="fa fa-reply-all"></i>回复</a>
                	</c:when>
                	<c:otherwise>
		                <a href="/defaultroot/post/list.controller?classId=${param.curClassId}&className=${forumClassName}" class="fbtn-link col-xs-6 fbtn-single"><i class="fa fa-list"></i>${forumClassName}</a>
                	</c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</footer>
</body>
<input id="offset" value="${offset}" type="hidden"/>
<input id="nomore" value="${nomore}" type="hidden"/>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
<script type="text/javascript">
	var nomore = "";
	var offset = "";
	$(function(){
		nomore = $("#nomore").val();
		offset = $("#offset").val();
		if(nomore){
			$(".wh-load-box").css("display","block");
		}else{
			$(".wh-load-box").css("display","none");
		}
	});
	
	//滚动条至底部事触发事件
    $(window).scroll(function(){
       var scrollTop = $(this).scrollTop();
       var scrollHeight = $(document).height();
       var windowHeight = $(this).height();
       if(scrollTop + windowHeight == scrollHeight){
      	 loadNextPage();
      }
    });
	
	//加载下一页内容
	function loadNextPage(){
		var $content = $('#content');
		if($content.data('loadflag') == '1'){
			return;
		}
		$content.data('loadflag','1');
		if(nomore){
			offset = parseInt(offset) + 1 + "";
			var nextPageUrl = "/defaultroot/post/pageInfo.controller?pageSize="+offset+"&postId=${postId}";
			$(".wh-load-md").css("display","block");
			$(".wh-load-tap").html("正在加载...");
			$.ajax({
				url : nextPageUrl,
				type : "post",
				success : function(data){
					nomore = $($(data)[25]).val();
					offset = $($(data)[23]).val();
					if(nomore){
						$(".wh-load-tap").html("上滑加载更多");
						$(".wh-load-box").css("display","block");
						$(".wh-load-md").css("display","none");
					}else{
						$(".wh-load-box").css("display","none");
					}
					$("#content").append($("article div",data).html().replace('<h1></h1>','').replace('<hr>',''));
					$content.data('loadflag','0');
				},
				error:function(data){
					$(".wh-load-box").html("加载失败！");
				}
			});
		}
	}
	
	//回复页面跳转
	function goReply(postId,forumFloor){
		window.location = "/defaultroot/post/reply.controller?forumFloor="+forumFloor+"&postId=${postId}";
	}
	
	function toReply(id){
		$("#"+id).submit();
	}
	    
    wx.ready(function(){
	    wx.getNetworkType({
		    success: function (res) {
		        var networkType = res.networkType; // 返回网络类型2g，3g，4g，wifi
		    }
		});
    });
</script>