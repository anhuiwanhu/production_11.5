<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>  
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1">
  <title>查看结果</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/frameworktemplate/css/template.style.colors.min.css" />
</head>
<body class="theme-green">
<c:if test="${not empty docXml}">
<x:parse xml="${docXml}" var="doc"/>
<c:set var="questionnaireId"><x:out select="$doc//questionnaire/questionnaireId/text()"/></c:set>
<c:set var="questionnaireTitle"><x:out select="$doc//questionnaire/questionnaireTitle/text()"/></c:set>
<c:set var="allCanAnswerSum"><x:out select="$doc//questionnaire/allCanAnswerSum/text()"/></c:set>
<c:set var="answerSheetSum"><x:out select="$doc//questionnaire/answerSheetSum/text()"/></c:set>
<c:set var="answerRatio"><fmt:formatNumber value="${answerSheetSum / allCanAnswerSum *100}" pattern="##.##" minFractionDigits="0" ></fmt:formatNumber>%</c:set>
<c:set var="answerSheetSum"><x:out select="$doc//questionnaire/answerSheetSum/text()"/></c:set>
<c:set var="grade"><x:out select="$doc//questionnaire/grade/text()"/></c:set>
  <div class="views">
    <div class="view view-content">
      <div class="pages">
        <div class="page">
          <section class="wh-section wh-section-bottomfixed">
            <article class="wh-edit wh-result wh-questionnaire-forum">
              <div class="result-section1">
                <div class="wh-container">
                  <div class="statistics-bar">
                    <p>调查人数${allCanAnswerSum } ，已交问卷人数${answerSheetSum }</p>
                    <div class="statistics-bar-a">
                      <span style="width:${answerRatio }" class="color"></span>
                      <span class="color color-no">${answerRatio }</span>
                    </div>
                  </div>
                  <c:if test="${grade == '1' }">
                  	  <c:set var="questionnaireAllScore"><x:out select="$doc//questionnaireAllScore/text()"/></c:set>
                  	  <c:set var="voteUserScore"><x:out select="$doc//voteUserScore/text()"/></c:set>
                  	  <c:set var="scoreRatio"><fmt:formatNumber value="${voteUserScore / questionnaireAllScore *100}" pattern="##.##" minFractionDigits="0" ></fmt:formatNumber>%</c:set>
	                  <div class="statistics-bar">
	                    <p>您的得分:${voteUserScore } 总分数：${questionnaireAllScore }</p>
	                    <div class="statistics-bar-a">
	                      <span style="width:${scoreRatio}" class="color"></span>
	                      <span class="color color-no">${scoreRatio }</span>
	                    </div>
	                  </div>
                  </c:if>
                </div>
              </div>
              <div class="result-section2">
                <div class="wh-section-title">${questionnaireTitle }</div>
                <div class="wh-container">
                  <div class="result_list">
                  	<!-- 单选 -->
                <c:set var="liNum" value="0" />
                <x:forEach select="$doc//questhemeRadioList" var="qr" >
                	<c:set var="liNum">${liNum+1 }</c:set>
               		<c:set var="questhemeId"><x:out select="$qr/questhemeId/text()"/></c:set>
               		<c:set var="questionnaireTitle"><x:out select="$qr/questhemeTitle/text()"/></c:set>
               		<c:set var="isOtherAnswer"><x:out select="$qr/isOtherAnswer/text()"/></c:set>
               		<c:set var="imgFlag" value=""/>
               		<x:forEach select="$qr//themeOptionList" var="tolPhoto" >
               			<c:set var="imgFlag"><x:out select="$tolPhoto/opImgSaveName/text()"/></c:set>
               		</x:forEach>
                    <li>
                      <div class="title clearfix">
                        <span class="code">${liNum }.</span>
                        <span class="text">${questionnaireTitle }</span>
                      </div>
                      <c:if test="${imgFlag !='' }">
                      		<div class="wh-questionnaire-img-list clearfix">
				            <ul>
                      </c:if>
                      <x:forEach select="$qr//themeOptionList" var="tolR" >
	                  		<c:set var="themeOptionId"><x:out select="$tolR/themeOptionId/text()"/></c:set>
	                  		<c:set var="themeOptionTitle"><x:out select="$tolR/themeOptionTitle/text()"/></c:set>
	                  		<c:set var="eachOptSum"><x:out select="$tolR/eachOptSum/text()"/></c:set>
	                  		<c:set var="isMySelected"><x:out select="$tolR/isMySelected/text()"/></c:set>
	                  		<c:set var="answerRatio1"><fmt:formatNumber value="${eachOptSum / allCanAnswerSum *100}" pattern="##.##" minFractionDigits="0" ></fmt:formatNumber>%</c:set>
	                  		<c:set var="opImgSaveName"><x:out select="$tolR/opImgSaveName/text()"/></c:set>
	                  		<c:choose>
	                  			<c:when test="${opImgSaveName !='' }">
	                  				<c:set var="folderVal">${fn:substring(opImgSaveName,0,6)}</c:set>
			                          <li class="current">
			                            <em><img src='/defaultroot/upload/quesCustAnswer/${folderVal}/<x:out select="$tolR/opImgSaveName/text()"/>'/></em>
			                            <p>
			                              <label class="label-radio item-content">
			                                <input disabled type="radio" name="questhemeRadioList_${liNum }" <c:if test="${isMySelected =='1' }">checked="checked"</c:if> value="${themeOptionId }">
			                                <span class="edit-radio-l">${themeOptionTitle }</span>
			                              </label>
			                            </p>
			                            <div class="statistics-bar-a">
			                            	<c:if test="${answerRatio1 != '0%'}">
			                            		<span style="width:${answerRatio1}" class="color"></span>
			                            		<span class="color color-no">${answerRatio1 }</span>
			                            	</c:if>
				                        </div>
			                          </li>
	                  			</c:when>
	                  			<c:otherwise>
	                  				<div class="box">  
				                        <p>
				                          <label class="label-radio item-content">
				                            <input disabled type="radio" name="questhemeRadioList_${liNum }" <c:if test="${isMySelected =='1' }">checked="checked"</c:if> value="${themeOptionId }">
				                            <span class="edit-radio-l">${themeOptionTitle }</span>
				                          </label>
				                        </p>
				                        <div class="statistics-bar-a">
				                        	<c:if test="${answerRatio1 != '0%'}">
			                            		<span style="width:${answerRatio1}" class="color"></span>
			                            		<span class="color color-no">${answerRatio1 }</span>
		                            		</c:if>
				                        </div>
				                      </div>
	                  			</c:otherwise>
	                  		</c:choose>
	                  </x:forEach>
	                  <c:if test="${imgFlag !='' }">
	                  			</ul>
                      		</div>
                      </c:if>
                      <c:if test="${isOtherAnswer == '1' }">
                      	  <c:set var="isMyOtherAnswer"><x:out select="$qr/isMyOtherAnswer/text()"/></c:set>
                      	  <c:set var="myOtherAnswerContent"><x:out select="$qr/myOtherAnswerContent/text()"/></c:set>
                      	  <c:set var="otherAnswerNum"><x:out select="$qr/otherAnswerNum/text()"/></c:set>
                      	  <c:set var="answerRatio1ot"><fmt:formatNumber value="${otherAnswerNum / allCanAnswerSum *100}" pattern="##.##" minFractionDigits="0" ></fmt:formatNumber>%</c:set>
	                      <div class="box">  
	                        <p>
	                          <label class="label-radio item-content">
	                            <input disabled type="radio" name="questhemeRadioList_${liNum }" <c:if test="${isMyOtherAnswer =='1' }">checked="checked"</c:if> value="${themeOptionId }">
	                            <span class="edit-radio-l">其他意见</span>
	                          </label>
	                        </p>
	                        <div class="statistics-bar-a">
	                        	<c:if test="${answerRatio1ot != '0%'}">
	                           		<span style="width:${answerRatio1ot}" class="color"></span>
	                           		<span class="color color-no">${answerRatio1ot }</span>
	                          	</c:if>
	                        </div>
	                        <div class="wj">
	                        <textarea readonly="readonly" class="textarea_a">${myOtherAnswerContent }</textarea>
	                      </div>
	                      </div>
                      </c:if>
                      <li>
                    </x:forEach>
                    <!-- 复选 -->
	                <x:forEach select="$doc//questhemeCheckList" var="qc" >
	                	<c:set var="liNum">${liNum+1 }</c:set>
	               		<c:set var="questhemeId"><x:out select="$qc/questhemeId/text()"/></c:set>
	               		<c:set var="questionnaireTitle"><x:out select="$qc/questhemeTitle/text()"/></c:set>
	               		<c:set var="isOtherAnswer"><x:out select="$qc/isOtherAnswer/text()"/></c:set>
	               		<c:set var="imgFlag" value=""/>
	               		<x:forEach select="$qc//themeOptionList" var="tolPhotoC" >
	               			<c:set var="imgFlag"><x:out select="$tolPhotoC/opImgSaveName/text()"/></c:set>
	               		</x:forEach>
	                    <li>
	                      <div class="title clearfix">
	                        <span class="code">${liNum }.</span>
	                        <span class="text">${questionnaireTitle }</span>
	                      </div>
	                      <c:if test="${imgFlag !='' }">
                      		<div class="wh-questionnaire-img-list clearfix">
				            <ul>
                     	 </c:if>
	                      <x:forEach select="$qc//themeOptionList" var="tolC" >
		                  		<c:set var="themeOptionId"><x:out select="$tolC/themeOptionId/text()"/></c:set>
		                  		<c:set var="themeOptionTitle"><x:out select="$tolC/themeOptionTitle/text()"/></c:set>
		                  		<c:set var="eachOptSum"><x:out select="$tolC/eachOptSum/text()"/></c:set>
		                  		<c:set var="isMySelected"><x:out select="$tolC/isMySelected/text()"/></c:set>
		                  		<c:set var="answerRatio1"><fmt:formatNumber value="${eachOptSum / allCanAnswerSum *100}" pattern="##.##" minFractionDigits="0" ></fmt:formatNumber>%</c:set>
		                  		<c:set var="opImgSaveName"><x:out select="$tolC/opImgSaveName/text()"/></c:set>
		                  		<c:choose>
		                  			<c:when test="${opImgSaveName !='' }">
		                  				<c:set var="folderVal">${fn:substring(opImgSaveName,0,6)}</c:set>
				                          <li class="current">
				                            <em><img src='/defaultroot/upload/quesCustAnswer/${folderVal}/<x:out select="$tolC/opImgSaveName/text()"/>'/></em>
				                            <p>
				                              <label class="label-radio item-content">
				                                <input disabled type="checkbox" name="questhemeRadioList_${liNum }" <c:if test="${isMySelected =='1' }">checked="checked"</c:if> value="${themeOptionId }">
							                         <span class="edit-radio-l">${themeOptionTitle }</span>
				                              </label>
				                            </p>
				                            <div class="statistics-bar-a">
					                          <c:if test="${answerRatio1 != '0%'}">
			                            		<span style="width:${answerRatio1}" class="color"></span>
			                            		<span class="color color-no">${answerRatio1 }</span>
		                            		</c:if>
					                        </div>
				                          </li>
		                  			</c:when>
		                  			<c:otherwise>
		                  				<div class="box">  
					                        <p>
					                          <label class="label-checkbox item-content">
					                          	<input disabled type="checkbox" name="questhemeCheckList_${liNum }" <c:if test="${isMySelected =='1' }">checked="checked"</c:if> value="${themeOptionId }">
					                          	<span class="edit-radio-l">${themeOptionTitle }</span>
					                          </label>
					                        </p>
					                        <div class="statistics-bar-a">
					                          <c:if test="${answerRatio1 != '0%'}">
			                            		<span style="width:${answerRatio1}" class="color"></span>
			                            		<span class="color color-no">${answerRatio1 }</span>
		                            		</c:if>
					                        </div>
					                      </div>
		                  			</c:otherwise>
		                  		</c:choose>
		                  </x:forEach>
		                  <c:if test="${imgFlag !='' }">
		                  		</ul>
	                      		</div>
	                      </c:if>
	                       <c:if test="${isOtherAnswer == '1' }">
	                      	  <c:set var="isMyOtherAnswer"><x:out select="$qc/isMyOtherAnswer/text()"/></c:set>
	                      	  <c:set var="myOtherAnswerContent"><x:out select="$qc/myOtherAnswerContent/text()"/></c:set>
	                      	  <c:set var="otherAnswerNum"><x:out select="$qc/otherAnswerNum/text()"/></c:set>
	                      	  <c:set var="answerRatio1ot"><fmt:formatNumber value="${otherAnswerNum / allCanAnswerSum *100}" pattern="##.##" minFractionDigits="0" ></fmt:formatNumber>%</c:set>
		                      <div class="box">  
		                        <p>
		                          <label class="label-radio item-content">
		                            <input disabled type="checkbox" name="questhemeRadioList_${liNum }" <c:if test="${isMyOtherAnswer =='1' }">checked="checked"</c:if> value="${themeOptionId }">
		                            <span class="edit-radio-l">其他意见</span>
		                          </label>
		                        </p>
		                        <div class="statistics-bar-a">
		                        	<c:if test="${answerRatio1ot != '0%'}">
		                           		<span style="width:${answerRatio1ot}" class="color"></span>
		                           		<span class="color color-no">${answerRatio1ot }</span>
		                          	</c:if>
		                        </div>
		                        <div class="wj">
		                        <textarea readonly="readonly" class="textarea_a">${myOtherAnswerContent }</textarea>
		                      </div>
		                      </div>
	                      </c:if>
	                      <li>
	                 </x:forEach>
	                 <!-- 问答-->
	                 <x:forEach select="$doc//questhemeEssayList" var="qe" >
	                	<c:set var="liNum">${liNum+1 }</c:set>
	               		<c:set var="questhemeId"><x:out select="$qe/questhemeId/text()"/></c:set>
	               		<c:set var="questionnaireTitle"><x:out select="$qe/questhemeTitle/text()"/></c:set>
	               		<c:set var="answerContent"><x:out select="$qe/answerContent/text()"/></c:set>
	                    <li>
	                      <div class="title clearfix">
	                        <span class="code">${liNum }.</span>
	                        <span class="text">${questionnaireTitle }</span>
	                      </div>
	                      <div class="wj">
	                        <textarea readonly="readonly" class="textarea_a">${answerContent }</textarea>
	                      </div>
	                    </li>
	                 </x:forEach>
                  </div>
                </div>
              </div>
            </article>
          </section>
        </div>
      </div>
    </div>
  </div>
  </c:if>
</body>
</html>

