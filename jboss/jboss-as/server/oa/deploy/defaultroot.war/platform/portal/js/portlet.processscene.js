/*-------------------------------------------------------*/
//文件办理
/*-------------------------------------------------------*/
/*--------------------portlet---------start--------------*/
var processscene = {
	portletAdd: function(opts){
		var portletSettingId = opts.portletSettingId;
		var isNew = opts.isNew?opts.isNew:false;
		if(!isNew){
			var result = ajaxResponseXML(portletSettingId);
			if($('portletSettings', result).length > 0){
				var ps = $('portletSettings', result).eq(0);
				opts = Portlet.getCommonOpts(ps, opts);

				var sceneType = $(ps).find('sceneType:first').text();

				opts = $.extend(opts, {sceneType:sceneType});
			}
		}

		var p = Portlet.addPortlet(opts);

		return p;
	},
	refresh: function(target, opts){		

		//if(opts.fileDealType){
			Portlet.updating(target);

			var sceneType = opts.sceneType;

			var htmlContent = '';
			$.ajax({
				url: whirRootPath+"/PortalServlet?portletSettingId="+opts.portletSettingId+"&portletType="+opts.type+"&rnd="+Math.random(),
				cache: PORTAL_CACHE,
				async: true,
				success: function(response) {
					htmlContent = response;
					target.html(htmlContent);

					var more = '';

					var moreLink = "<a href='"+more+"' style='color:"+opts.titleColor+"' class='rssA'>"+opts.title+"</a>";

					if(_def_isDesignPage_){
						moreLink = opts.title;
					}

					Portlet.setPortletTitle(target,moreLink);
				}
			});
		//}

		//Portlet.setPortletTitle(target,opts.title);
	},
	getSettingsXml: function(target, opts){
		var result = "";

		var limitNum = $('input[name=limitNum]').val();
		var limitChar = $('input[name=limitChar]').val();
		result += '<limitNum>'+limitNum+'</limitNum>';
		result += '<limitChar>'+limitChar+'</limitChar>';
		//上传图片
		var portletImgName = $('input[name=portletImgName]').val();
		result += '<portletImgName>'+portletImgName+'</portletImgName>';
		var portletImgSaveName = $('input[name=portletImgSaveName]').val();
		result += '<portletImgSaveName>'+portletImgSaveName+'</portletImgSaveName>';
		//名称
		var sceneName = $('input[name=sceneName]').val();
		result += '<sceneName>'+sceneName+'</sceneName>';
		//流程分类
		var processType = $('input[name=processType]:checked').val();
		result += '<processType>'+(processType?processType:'')+'</processType>';
		//场景风格
		var sceneType = $('input[name=sceneType]:checked').val();
		result += '<sceneType>'+(sceneType?sceneType:'')+'</sceneType>';
		//选择流程分类
		var wfPackageId= '';
		$('input[name=wfPackageId]').each(function(){
			var val = $(this).val();
			wfPackageId += val + ',';
		});
		result += '<wfPackageId>'+wfPackageId+'</wfPackageId>';

		var packageName = '';
		$('input[name=packageName]').each(function(){
			var val = $(this).val();
			packageName += val + ',';
		});
		result += '<packageName>'+packageName+'</packageName>';
		//
		var wfPackageId2= '';
		$('input[name=wfPackageId2]').each(function(){
			var val = $(this).val();
			wfPackageId2 += val + ',';
		});
		result += '<wfPackageId2>'+wfPackageId2+'</wfPackageId2>';

		var packageName2 = '';
		$('input[name=packageName2]').each(function(){
			var val = $(this).val();
			packageName2 += val + ',';
		});
		result += '<packageName2>'+packageName2+'</packageName2>';

		opts = $.extend(opts, {limitNum:limitNum, limitChar:limitChar, portletImgName:portletImgName, portletImgSaveName:portletImgSaveName, processType:processType, sceneType:sceneType, wfPackageId:wfPackageId, packageName:packageName, wfPackageId2:wfPackageId2, packageName2:packageName2,sceneName:sceneName});

		return result;
	}
};
/*--------------------portlet---------end--------------*/