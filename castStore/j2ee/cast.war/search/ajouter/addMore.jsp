<dsp:page>

  <dsp:importbean bean="/atg/commerce/search/refinement/CommerceFacetTrailDroplet"/>

  <dsp:getvalueof var="contextPath" bean="/OriginatingRequest.contextPath" />
  
  <dsp:getvalueof var="ajouterColumnWidth" bean="/com/castorama/search/SearchConfiguration.ajouterColumnWidth"/>
  <dsp:getvalueof var="facetRowAmount" bean="/com/castorama/search/SearchConfiguration.facetRowAmount"/>
  <dsp:getvalueof var="ajouterRowAmount" bean="/com/castorama/search/SearchConfiguration.ajouterRowAmount"/>
  <dsp:getvalueof var="ajouterSingleColumnWidth" bean="/com/castorama/search/SearchConfiguration.ajouterSingleColumnWidth"/>
  
  
  <dsp:getvalueof var="facetValuesResultListVar" param="facetValuesResultList"/>
  <dsp:getvalueof var="ajouterFacetId" param="ajouterFacetId"/>
  <dsp:getvalueof var="categoryIdVar" param="categoryId"/>
  <dsp:getvalueof var="sortByValue" param="sortByValue"/>
  <dsp:getvalueof var="productListingView" param="productListingView"/>
  <dsp:getvalueof var="question" param="question"/>
  <dsp:getvalueof var="searchType" param="searchType"/>
  <dsp:getvalueof var="produitsFST" param="produitsFST"/>
  <dsp:getvalueof var="facetedProperty" param="facetedProperty"/>
  <dsp:getvalueof var="queryResponse" param="queryResponse"/>
  <dsp:getvalueof var="containerVar" param="container"/>
  <dsp:getvalueof var="currentTab" param="currentTab"/>
  
  
  <c:if test="${fn:length(facetValuesResultListVar) > facetRowAmount}">
    <c:set var="addMorePopupList" value="${castCollection:subList(facetValuesResultListVar, facetRowAmount, fn:length(facetValuesResultListVar))}"/>
    <div class="autres">
      <a onclick="showAjouterPopup('#addMorePopup_${ajouterFacetId}')" class="autresLnk" href="javascript:void(0)"><fmt:message key="search_ajouterAddMore.addMore"/></a>
      
      <div id="addMorePopup_${ajouterFacetId}" class="autresPopup ajouterListContainer${ajouterFacetId}" style="display: none;">
        <div class="icoPpTop">
          <img src="${contextPath}/images/icoPpTop.gif" alt="" title=""/>
        </div>         
        <a href="javascript:void(0);" onclick="$('div#addMorePopup_${ajouterFacetId}').hide();"><img src="${contextPath}/images/icoClose.gif" style="float:right;" /></a>        
        <dsp:droplet name="/com/castorama/search/droplet/AjouterTableRenderer">
          <dsp:param name="arrayToRender" value="${addMorePopupList}"/>
          <dsp:param name="maxRowCount" value="${ajouterRowAmount}"/>
          <dsp:oparam name="outputTableStart">
            <table cellpadding="0" cellspacing="0" class="ajouterListTable">
            <dsp:getvalueof var="columnCountVar" param="columnCount"/>
            <c:choose>
              <c:when test="${columnCountVar == 1}">
              	<c:set var="width" value="${ajouterSingleColumnWidth}"/>
              </c:when>
              <c:otherwise>
              	<c:set var="width" value="${columnCountVar * ajouterColumnWidth}"/>
              </c:otherwise>
            </c:choose>
            <style type="text/css">
              .ajouterListContainer${ajouterFacetId} {
                width: ${width}px;
              }
            </style>
          </dsp:oparam>
          <dsp:oparam name="outputTableEnd">
            </table>
          </dsp:oparam>
          <dsp:oparam name="outputRowStart">
            <tr>
          </dsp:oparam>
          <dsp:oparam name="outputRowEnd">
            </tr>
          </dsp:oparam>
          <dsp:oparam name="outputColumnStart">
            <td>
          </dsp:oparam>
          <dsp:oparam name="outputColumnEnd">
            </td>
          </dsp:oparam>
          <dsp:oparam name="output">
            <dsp:getvalueof var="facetValueNode" param="element"/>
            <dsp:droplet name="CommerceFacetTrailDroplet">
              <dsp:param name="trail" param="produitsFST.facetTrail"/>
              <dsp:getvalueof var="trailString" param="produitsFST.facetTrail"/>
              <c:if test="${ empty trailString and ! empty queryResponse.question}">
                <dsp:setvalue param="addFacet" value="SRCH:${queryResponse.question}:${facetValueNode.facetValue}" />
              </c:if>
              <c:if test="${ ! empty trailString or empty queryResponse.question }">
                <dsp:setvalue param="addFacet" value="${facetValueNode.facetValue}" />
              </c:if>
              <dsp:param name="addFacet" param="addFacet"/>
              <dsp:param name="refineConfig" param="refineConfigObj"/>
              
              <dsp:oparam name="output">
                <dsp:getvalueof var="facetTrail" param="facetTrail" />
                <dsp:getvalueof var="trailVar" param="facetTrail.trailString" />
                
                <dsp:getvalueof var="startSep" value="?"/>
                <c:if test="${fn:contains(containerVar, '?') }">
                  <dsp:getvalueof var="startSep" value="&"/>
                </c:if>
                <c:if test="${not empty facetedProperty && not empty facetValueNode.facetValue.value}">
				  <dsp:getvalueof var="lastFilter" value="${facetedProperty}:${facetValueNode.facetValue.value }"/>
     			</c:if>
                <dsp:getvalueof var="osearchmode" param="osearchmode"/>
                <c:if test="${empty osearchmode and not empty searchType}">
                  	<dsp:getvalueof var="osearchmode" value="reg"/>
                </c:if>
                
                <dsp:getvalueof var="containerVarValid" value="${fn:replace(containerVar, '\\'', '&#92;&#39;')}"/>
                <dsp:getvalueof var="containerVarValid" value="${fn:replace(containerVarValid, '\"', '&#92;&#34;')}"/>
                <div class="iOpt" style="width: ${ajouterColumnWidth}px">
                  <input id="${facetValueNode.facetValue}" type="checkbox" defaultvalue="on" 
                         onClick="location.href='${containerVarValid }${startSep}trail=${castCollection:encode(trailVar)}&categoryId=${categoryIdVar}&sortByValue=${sortByValue}&productListingView=${productListingView}&question=${castCollection:encode(question)}&searchType=${searchType}&pageNum=1&currentTab=${currentTab}&lastFilter=${castCollection:encode(lastFilter)}&osearchmode=${osearchmode}'"/>
                 
                  <!-- <label for="${facetValueNode.facetValue}"> -->
                    <dsp:include page="/search/includes/facetValueFormatter.jsp">
                      <dsp:param name="facetedProperty" param="facetedProperty"/>
                      <dsp:param name="facetValue" value="${facetValueNode.facetValue}"/>
                      <dsp:param name="value" value="${facetValueNode.facetValue.value}"/>
                      <dsp:param name="facetId" value="${facetValueNode.facetValue.facet.id}"/>
                    </dsp:include>
                   <!-- </label> -->
                </div>
              </dsp:oparam>
              <dsp:oparam name="error">
              </dsp:oparam>
            </dsp:droplet>
          </dsp:oparam>
        </dsp:droplet> 
      </div>  
    </div>
  </c:if>
  
</dsp:page>