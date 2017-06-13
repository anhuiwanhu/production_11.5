<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>

<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>我要打卡</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body class="theme-green">
<c:if test="${not empty docXml}">
 <x:parse xml="${docXml}" var="doc"/>
 <c:set var="presentTime"><x:out select="$doc//presentTime/text()"/></c:set>
 <c:set var="userName"><x:out select="$doc//userName/text()"/></c:set>
 <c:set var="record"><x:out select="$doc//record/text()"/></c:set>
 <c:set var="photo"><x:out select="$doc//photo/text()"/></c:set>
 <form id="sendForm" method="post" action="/defaultroot/worklog/saveWorkLog.controller" onsubmit="return false">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page">
          <section class="wh-section wh-section-topstaic">
            <header class="wh-clock-header">
              <section class="wh-container">
                <strong class="document-icon">
                <c:if test="${photo eq '' || photo eq null}"><img src="/defaultroot/evo/weixin/images/head.png"></c:if>
                <c:if test="${photo != ''}"><img src="/defaultroot/upload/peopleinfo/${photo}"></c:if>
                </strong>
                <div class="wh-clock-info">
                  <span id="toDay"></span>
                  <span id="week"></span>
                  <p><strong>${userName }，</strong>欢迎使用微信考勤</p>
                </div>
                <a href="##">本日已签<br>${record }次</a>
              </section>
            </header>
            <div class="wh-clock-times">
              <div class="row no-gutter">
                <div class="col-50" onclick="openMap()">查看地图</div>
                <div class="col-50" onclick="resetLocation()">重新定位</div>
              </div>
            </div>
            <article class="wh-edit wh-edit-forum">
              <div>
                <div class="wh-clock-map">
                  <aside class="wh-load-clock" style="display:block">
                    <div class="wh-load-circlemax"></div>
                    <div class="wh-load-circlemin"></div>
                    <i class="fa fa-check-circle" style="display: none"></i>
                  </aside>
                  <!--<p></p>-->
                  <p id = "addressId">获取当前位置中...</p>
                  <p id = "currentDate"></p>
                </div>
                <table class="wh-table-edit">
                  <tbody>
                  	<tr>
                    <th>上传图片：</th>
                    <td>
                      <ul class="edit-upload">
                        <li class="edit-upload-in" onclick="addImg();"><span><i class="fa fa-plus"></i></span></li>
                      </ul>
                    </td>
                    </tr>
                    <tr>
                      <th>签到备注：</th>
                      <td>
                      	<input type="hidden" name="longitude" id="longitude"/>	
						 <input type="hidden" name="latitude" id="latitude"/>	
						 <input type="hidden" name="presentAddress" id="presentAddress"/>
                          <input class="edit-ipt-r" type="text" placeholder="请填写" name="remark" id="remark" />
                      	 <!--<textarea class="edit-txta edit-txta-l" placeholder="请填写" name="remark" id="remark"></textarea> -->
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </article>
            <div class="wh-get-clock">
              <div>
                <a href="javascript:;"><img src="/defaultroot/evo/weixin/frameworktemplate/images/get-clock.png" class="getclock"></a>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>
  </div>
  </form>
  </c:if>
  <script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/frameworktemplate//js/plugin/zepto.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/js/uploadPreview.min.js"></script>
  <script type="text/javascript" src="/defaultroot/modules/comm/microblog/script/ajaxfileupload.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
  <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
  <script type="text/javascript">
  var modal;

  var comflag = 1;
  $('.getclock').on('click', function(e) {
  	if(comflag == 0){
   		return;
   	}
   	comflag = 0;
    var presentAddress = $("#presentAddress").val();
  	if(presentAddress == ''){
  		var myApp = new Framework7();
  		myApp.alert('没有地址信息请重新定位');
  		comflag = 1;
  		return;
  	}
  	$.ajax({
	    type: "post",
	    url: "/defaultroot/attendance/saveWxLocation.controller",
	    data:$('#sendForm').serialize(),
	    success: function(data) {
	    	var jsonData = eval("("+data+")");
	    	var commentFlag = jsonData.data0;
	    	if(commentFlag=='1'){
	    		var myApp = new Framework7();
	    		//myApp.alert('保存成功！');
	    		e.stopPropagation();
				    modal = myApp.modal({
				      title: ' ',
				      text: ' ',
				      afterText: '<div class="clock-modal"><img src="/defaultroot/evo/weixin/frameworktemplate/images/meeting-user.png"/><p><strong>本日已成功签到！</strong></p><p>签到数据已传回OA系统，请坚持哦</p><p id="point"><span class="point1"></span><span class="point2"></span><span class="point3"></span></p></div>',
				      buttons: []
				    })
				    myApp.swiper($(modal).find('.swiper-container'), {
				      pagination: '.swiper-pagination'
				    });
				
				    var point = $("#point");
				    var start = setInterval(function(){
				      var p3= point.children(".point3"); 
				    },1000);
				
				    setTimeout(function() {
				      myApp.hidePreloader();
				      window.location = '/defaultroot/attendance/myAttendance.controller';
				    }, 2000);
	    	}else{
	    		comflag = 1;
	    		myApp.alert('保存失败！');
	    	}
	    }
	});

  });
  $(function(){
     var weekNum = new Date().getDay();
     var date = new Date();
	 var toDay = date.getFullYear()+'年'+(date.getMonth()+1)+'月'+date.getDate()+'日';
     var week = '';
     if(weekNum == '1'){
     	week = '星期一';
     }else if(weekNum == '2'){
     	week = '星期二';
     }else if(weekNum == '3'){
     	week = '星期三';
     }else if(weekNum == '4'){
     	week = '星期四';
     }else if(weekNum == '5'){
     	week = '星期五';
     }else if(weekNum == '6'){
     	week = '星期六';
     }else{
     	week = '星期日';
     }
     $('#week').html(week);
     $('#toDay').html("今天是"+toDay);
     getCurrentDate();
  });
  
  //获取当前位置经纬度
  wx.ready(function(){
  	getMyLocation();
  });
  
 function getMyLocation() {
	wx.getLocation({
	    type: 'gcj02', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	    success: function (res) {
	        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	        var longitude = res.longitude ; // 经度，浮点数，范围为180 ~ -180。
	        //var speed = res.speed; // 速度，以米/每秒计
	        //var accuracy = res.accuracy; // 位置精度
	        myLocation(latitude,longitude);
	    }
	});
 }
  //当前时间动态显示
  function getCurrentDate(){
    var obj = new Date();
    var y = obj.getFullYear();
    var m = obj.getMonth()+1;
    var d = obj.getDate();
    var h = obj.getHours();
    var i = obj.getMinutes();
    var s = obj.getSeconds();
    if(m < 10) m = "0" + m;
    if(d < 10) d = "0" + d;
    if(h < 10) h = "0" + h;
    if(i < 10) i = "0" + i;
    if(s < 10) s = "0" + s;
    var time = y+'-'+m+'-'+d+' '+h+':'+i+':'+s;
    $("#currentDate").html("当前时间："+time);
    setTimeout(getCurrentDate,1000);
}
  function myLocation(latitude,longitude) {
		var geocoder = null;
		geocoder = new qq.maps.Geocoder({
		    complete:function(result){
		        $('.wh-load-circlemax').hide();
		        $('.wh-load-circlemin').hide();
		        $('.fa-check-circle').show();
		        $('#latitude').val(latitude);
		        $('#longitude').val(longitude);
		        var myAddress = result.detail.address.replace("中国", "");
		        $('#presentAddress').val(myAddress);
		        $('#addressId').html('当前位置：'+myAddress);
		    }
		});
		var coord=new qq.maps.LatLng(latitude,longitude);
		geocoder.getAddress(coord);
 }
  
  var index = 0;
  function addImg(){
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="imgName"/>'+
		       '<input type="hidden" id="img_save_name_'+index+'" name="imgSaveName" data-filesize="0"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
    }
    
    //回调函数上传图片
	function callBackFun(upImgId,imgliId){
		//var myApp = new Framework7();
		//myApp.showPreloader('正在上传...');
		var loadingDialog = openTipsDialog('正在上传...');
		$("#img_name_"+(index-1)).val($("#"+upImgId).val());
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=phonekq', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				//alert(1);
				$("#img_save_name_"+(index-1)).val(msg.data);
				$("#img_save_name_"+(index-1)).data("filesize",msg.fileSize);
				$("#img_name_"+(index-1)).val(fileShowName);
				$("#"+imgliId).show();
				loadingDialog.close();
				//myApp.hidePreloader();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				var myApp = new Framework7();
				myApp.alert("文件上传失败！");
			}
		});
	}
	 //删除缩略图
    function removeImg(index){
	   $("#imgli_"+index).remove();
	   $("#up_img_"+index).remove();
	   $("#img_save_name_"+(index-1)).val('');
    }
	//重新定位
	function resetLocation() {
		$('#addressId').html('获取当前位置中...');
		$('.wh-load-circlemax').show();
        $('.wh-load-circlemin').show();
        $('.fa-check-circle').hide();
        getMyLocation();
	}
	
	function openMap(){
		var longitude = $('#longitude').val();
		var latitude = $('#latitude').val();
		var presentAddress = $('#presentAddress').val();
		wx.openLocation({
		    latitude: parseFloat(latitude), // 纬度，浮点数，范围为90 ~ -90
		    longitude: parseFloat(longitude), // 经度，浮点数，范围为180 ~ -180。
		    name: presentAddress, // 位置名
		    address: presentAddress, // 地址详情说明
		    scale: 28, // 地图缩放级别,整形值,范围从1~28。默认为最大
		    infoUrl: presentAddress // 在查看位置界面底部显示的超链接,可点击跳转
		});
	}
  </script>
</body>
</html>