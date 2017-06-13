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
          <section class="wh-section wh-section-bottomfixed">
		  <input type="hidden"  name="menuId" value="${menuId}" id="menuId"/>
            <aside class="wh-category wh-category-forum">
              <div class="wh-container">
                <div class="wh-cate-lists list-block wh-cate-planlist" id="menuContent">
                  
                </div>
              </div>
            </aside>
          </section>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7();
  var $$ = Dom7;
  </script>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		loadCustMenu();
	});

    //加载菜单数据
	function loadCustMenu(){
		var menuId =$("#menuId").val();
		$.ajax({
			 type: 'post',
			 url: "/defaultroot/custmenu/custMenuData.controller",
			 dataType:'text',
			 data : {"menuId" : menuId},
			 success: function(data){ 
				if(!data){
        			 return;
        		}
        		var obj = eval("("+data+")");
        		if(!obj){
        			return;
        		}
             var content="";
			 if(obj.message.result=="1"){
				var groups = obj.data.menuList;
				for(var i=0;i<groups.length;i++){
				  var menuId = groups[i].menuId;
				  var menuName = groups[i].menuName;   
				  var hasacc1="";
				  if(groups[i].actionType =="1"){				   
					 hasacc1 = "downloadFile('"+groups[i].menuHtmlLink+"','"+groups[i].menuFileLink+"','"+groups[i].isftp+"');";
				   }else if(groups[i].actionType =="2"){
					 hasacc1 = "goStartFlow('"+groups[i].menuStartFlow.type+"','"+groups[i].menuStartFlow.formId+"','"+groups[i].menuStartFlow.processId+"','"+groups[i].menuStartFlow.processName+"');";
				   }else if(groups[i].actionType =="3"){
					 hasacc1 = "goDataList('"+groups[i].menuId+"','"+groups[i].menuName+"');";
				   }else if(groups[i].actionType =="4"){
					 hasacc1 = "goSSOLink('"+encodeURIComponent(groups[i].menuAction)+"');";
				   }
                 var con ="";//无下级菜单右边不显示展开
                 if(groups[i].child.length>0){
					 con='<a href="#" class="item-content item-link">';
				 }else{
					 con='<a href="#" class="item-content item-link notip">';
				 }	
				 content += '<ul>'
                    +'<li class="accordion-item">'
                     +'  <label class="label-checkbox">'
                      +'   <input type="checkbox" name="my-checkbox" value="实名">'
                      +'   <span class="edit-radio-l"></span>'
                      +' </label>'
                       +con
                       +'  <p>'
                         +'  <strong onclick="'+hasacc1+'">'+menuName+'</strong>'
                       +'  </p>'
                      +' </a>'
					  +createItem(groups[i].child)                  
                    +' </li>'
                  +' </ul>';

			 }
			 $("#menuContent").append(content);
             }   

			 },error: function(xhr, type){
				 alert('数据查询异常！');
			 }

		});
	}

	function createItem(groups){
		if(groups != null){
			var itemStr = '';
			for(var i =0;i<groups.length;i++){			
			  var menuId = groups[i].menuId;
			  var menuName = groups[i].menuName;
			  var hasacc1="";
              if(groups[i].actionType =="1"){				 
				   hasacc1 = "downloadFile('"+groups[i].menuHtmlLink+"','"+groups[i].menuFileLink+"','"+groups[i].isftp+"');";				 
			   }else if(groups[i].actionType =="2"){
				 hasacc1 = "goStartFlow('"+groups[i].menuStartFlow.type+"','"+groups[i].menuStartFlow.formId+"','"+groups[i].menuStartFlow.processId+"','"+groups[i].menuStartFlow.processName+"');";
			   }else if(groups[i].actionType =="3"){
				 hasacc1 = "goDataList('"+groups[i].menuId+"','"+groups[i].menuName+"');";
			   }else if(groups[i].actionType =="4"){
				 hasacc1 = "goSSOLink('"+encodeURIComponent(groups[i].menuAction)+"');";
			   }	   
			   var con ='';
			   if(groups[i].child.length>0){
				 con='<a href="#" class="item-content item-link">';
			   }else{
				 con='<a href="#" class="item-content item-link notip">';
			   }	
			   itemStr += '<div class="accordion-item-content">'
				 +'<div class="wh-cate-lists">'
				  +'<ul>'
					 +'<li class="accordion-item">'
					 +'<label class="label-checkbox">'
					 +'<input type="checkbox" name="my-checkbox" value="实名">'
					 +'<span class="edit-radio-l"></span>'
					  +'  </label>'
					   +con   
						 +'<p>'
						 +'  <strong onclick="'+hasacc1+'">'+menuName+'</strong> '
						 +'</p>'
					  +' </a>'
					 + createItem(groups[i].child)
					 +'</li>'
				   +'</ul>'
				 +'</div>'
			  +' </div>';
			}
			return itemStr;
		}
	}

    function downloadFile(menuHtmlLink,menuFileLink,isftp){
		//alert(menuHtmlLink+"  "+menuFileLink+"  "+isftp);
		clickSub("/defaultroot/evo/weixin/download/download.jsp?FileName="+menuHtmlLink+"&name="+menuFileLink+"&path=customize",this,menuHtmlLink,"customize",isftp);
	}
	
	function goStartFlow(type,pageId,processId,processName){
	  if(type=="cmdNewStartFlow"){
		window.location = '/defaultroot/workflow/newezform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName;
	  }else if(type=="cmdStartFlow"){
		window.location = '/defaultroot/workflow/newform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName;
	  }
	}
	function goDataList(menuId,menuName){
	   window.location = "/defaultroot/custmenu/custData.controller?menuId="+menuId+"&menuName="+menuName;
	}
	function goSSOLink(menuAction){
	  menuAction = decodeURIComponent(menuAction);
	  window.location.href=menuAction;
	}
		

</script>
</html>
